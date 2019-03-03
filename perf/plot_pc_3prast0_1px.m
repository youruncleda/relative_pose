part = 'rot';
part = 'transl';

errs_pc3prast0 = eval(sprintf('%s_errs_pc3prast0', part));
errs_pc5p = eval(sprintf('%s_errs_pc5p', part));

fig = figure;
set(fig, 'position', [100,100,200,200]);

level = numel(nstd_ray);

ref_errs = mean(errs_pc5p(:, level, 1, 1), 1);
ref_errs = reshape(ref_errs, [1 ,1]);
errs = mean(errs_pc3prast0(:, level, :, :), 1);
errs = reshape(errs, [K2, K3]);
%     mesh(errs), hold on

contour(errs, 'showtext', 'on',...
    'LineColor', 'b');

hold on

% https://undocumentedmatlab.com/blog/customizing-contour-plots
drawnow();


xticklabels(arrayfun(@(x) sprintf('%.2f', x), rad2deg(nstd_angle), 'uniformoutput', false));
xlabel('transl turb (deg)')
yticklabels(arrayfun(@(x) sprintf('%.1f', x), nstd_transl * 100, 'uniformoutput', false))
ylabel([part, ' turb (%)'])

set(fig,'Units','Inches');
pos = get(fig,'Position');
set(fig,'PaperPositionMode','Auto','PaperUnits','Inches','PaperSize',[pos(3), pos(4)])
print(fig, ['./pc_3prast0_1px_', part], '-dpdf', '-r0');
