Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC25020285
	for <e@80x24.org>; Wed, 30 Aug 2017 17:58:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751822AbdH3R6d (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:58:33 -0400
Received: from mout.web.de ([212.227.17.11]:63422 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751667AbdH3R61 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:58:27 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb101
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiUC0-1dErq21Rk4-00ch0G for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:58:26 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 12/34] diff: release strbuf after use in show_stats()
Date:   Wed, 30 Aug 2017 19:58:11 +0200
Message-Id: <20170830175825.20905-7-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175825.20905-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
 <20170830175825.20905-1-l.s.r@web.de>
X-Provags-ID: V03:K0:vKkkfkgjahgFWRc6lA3tt97iS6XvaTP0QwF9WBC6yZp8/vIQt/d
 ogyyNRL4OnTgV3LZgojiNV+fdqCdv+gVcq8XMkA+fMekCe+Ea7wqjaGPPt/lGKriiSF677c
 jRBgTbfVIatAafHmO81PZvEfq8zsWqxwOz9I3tUve1nQfVIZiJe36gGE9sZijjro9IlchqG
 dfeb3DkZ+kERmffSOgxBQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:c5wlfheZ9Dc=:pNuvEcge/5mOcKZbIYdcUf
 PzVUfQPIh9mVhQ7INPD+4NJQKATXDB0AVFSIwok+pxfRnyNLrAvRAaQCcGwK+4ozpkIfCKJB4
 QZNhyq9KL3Uz8JHQs8UfWDg66dWTABwppqVMC5CJ2KGbEHGpOtSUCrSGlGZU2B3Ghi72M36bZ
 TFD50mpkLJYKNSp1D8Ufcf8fQB5yuwPusGvyvpwv+6tm0O8+xEeCywHCy7+++3OBs6jxo4nv8
 mW6NiwnMhI0UdAUSpW2tUL9Be3saUjl4d+D/LuWpZ64SSfhJ709WZdWbu03s3RC7hYZgNBBUl
 iL9jRvXnzxarhz3n0eZuteoDDf5MMFJxmKT3dyUAoBS6wJGRed4FvVuqV9uKIYZOLzUauHZIg
 kQ+soMWDm/OAwICuI7+qtZukVoqlQE0Cwbgu3w4EPwvrE3V71+mIhia3zBtl2oblvTR3AUnbv
 ZIRB7UiTLsJ3skOespwVT2VxMuR9PVTYuuJsPopT6zEBT/+1qt1+/BA9iueO7dsKfgwfskiDZ
 MMZ+xfZ4H+f5Xy/8ngDDrcdo5iDsMj+As+PF+Ps/ofEE7dTaPFAK3CunE6NRKIY56CDqzAJlS
 4MueXQpAFUjcqJAoGPR/mz4nRncDKjx9xzBWgXDL7O1EGHRWsqp/AcGssxtpmVMGIypEZFv+n
 qWEpdANlVGu3NWHM1nZAWToFlVr7w63GIOo0tk+gk8E50GDgWrUdF0BCVWGpo8xaabhiCoZ5W
 NCt7zU5cEUk98GnOiBfsfh7VjawNmnJnHoWTYrHhqryhWxjlJgzEXRz+OwlfyyvcU1/jRT4XS
 93I9V5SHKz3nQbn3D3UfZIJdGh4ig==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Rene Scharfe <l.s.r@web.de>
---
 diff.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/diff.c b/diff.c
index 33c65f492d..64cdcf2331 100644
--- a/diff.c
+++ b/diff.c
@@ -2334,255 +2334,256 @@ void print_stat_summary(FILE *fp, int files,
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
 {
 	int i, len, add, del, adds = 0, dels = 0;
 	uintmax_t max_change = 0, max_len = 0;
 	int total_files = data->nr, count;
 	int width, name_width, graph_width, number_width = 0, bin_width = 0;
 	const char *reset, *add_c, *del_c;
 	int extra_shown = 0;
 	const char *line_prefix = diff_line_prefix(options);
 	struct strbuf out = STRBUF_INIT;
 
 	if (data->nr == 0)
 		return;
 
 	count = options->stat_count ? options->stat_count : data->nr;
 
 	reset = diff_get_color_opt(options, DIFF_RESET);
 	add_c = diff_get_color_opt(options, DIFF_FILE_NEW);
 	del_c = diff_get_color_opt(options, DIFF_FILE_OLD);
 
 	/*
 	 * Find the longest filename and max number of changes
 	 */
 	for (i = 0; (i < count) && (i < data->nr); i++) {
 		struct diffstat_file *file = data->files[i];
 		uintmax_t change = file->added + file->deleted;
 
 		if (!file->is_interesting && (change == 0)) {
 			count++; /* not shown == room for one more */
 			continue;
 		}
 		fill_print_name(file);
 		len = strlen(file->print_name);
 		if (max_len < len)
 			max_len = len;
 
 		if (file->is_unmerged) {
 			/* "Unmerged" is 8 characters */
 			bin_width = bin_width < 8 ? 8 : bin_width;
 			continue;
 		}
 		if (file->is_binary) {
 			/* "Bin XXX -> YYY bytes" */
 			int w = 14 + decimal_width(file->added)
 				+ decimal_width(file->deleted);
 			bin_width = bin_width < w ? w : bin_width;
 			/* Display change counts aligned with "Bin" */
 			number_width = 3;
 			continue;
 		}
 
 		if (max_change < change)
 			max_change = change;
 	}
 	count = i; /* where we can stop scanning in data->files[] */
 
 	/*
 	 * We have width = stat_width or term_columns() columns total.
 	 * We want a maximum of min(max_len, stat_name_width) for the name part.
 	 * We want a maximum of min(max_change, stat_graph_width) for the +- part.
 	 * We also need 1 for " " and 4 + decimal_width(max_change)
 	 * for " | NNNN " and one the empty column at the end, altogether
 	 * 6 + decimal_width(max_change).
 	 *
 	 * If there's not enough space, we will use the smaller of
 	 * stat_name_width (if set) and 5/8*width for the filename,
 	 * and the rest for constant elements + graph part, but no more
 	 * than stat_graph_width for the graph part.
 	 * (5/8 gives 50 for filename and 30 for the constant parts + graph
 	 * for the standard terminal size).
 	 *
 	 * In other words: stat_width limits the maximum width, and
 	 * stat_name_width fixes the maximum width of the filename,
 	 * and is also used to divide available columns if there
 	 * aren't enough.
 	 *
 	 * Binary files are displayed with "Bin XXX -> YYY bytes"
 	 * instead of the change count and graph. This part is treated
 	 * similarly to the graph part, except that it is not
 	 * "scaled". If total width is too small to accommodate the
 	 * guaranteed minimum width of the filename part and the
 	 * separators and this message, this message will "overflow"
 	 * making the line longer than the maximum width.
 	 */
 
 	if (options->stat_width == -1)
 		width = term_columns() - strlen(line_prefix);
 	else
 		width = options->stat_width ? options->stat_width : 80;
 	number_width = decimal_width(max_change) > number_width ?
 		decimal_width(max_change) : number_width;
 
 	if (options->stat_graph_width == -1)
 		options->stat_graph_width = diff_stat_graph_width;
 
 	/*
 	 * Guarantee 3/8*16==6 for the graph part
 	 * and 5/8*16==10 for the filename part
 	 */
 	if (width < 16 + 6 + number_width)
 		width = 16 + 6 + number_width;
 
 	/*
 	 * First assign sizes that are wanted, ignoring available width.
 	 * strlen("Bin XXX -> YYY bytes") == bin_width, and the part
 	 * starting from "XXX" should fit in graph_width.
 	 */
 	graph_width = max_change + 4 > bin_width ? max_change : bin_width - 4;
 	if (options->stat_graph_width &&
 	    options->stat_graph_width < graph_width)
 		graph_width = options->stat_graph_width;
 
 	name_width = (options->stat_name_width > 0 &&
 		      options->stat_name_width < max_len) ?
 		options->stat_name_width : max_len;
 
 	/*
 	 * Adjust adjustable widths not to exceed maximum width
 	 */
 	if (name_width + number_width + 6 + graph_width > width) {
 		if (graph_width > width * 3/8 - number_width - 6) {
 			graph_width = width * 3/8 - number_width - 6;
 			if (graph_width < 6)
 				graph_width = 6;
 		}
 
 		if (options->stat_graph_width &&
 		    graph_width > options->stat_graph_width)
 			graph_width = options->stat_graph_width;
 		if (name_width > width - number_width - 6 - graph_width)
 			name_width = width - number_width - 6 - graph_width;
 		else
 			graph_width = width - number_width - 6 - name_width;
 	}
 
 	/*
 	 * From here name_width is the width of the name area,
 	 * and graph_width is the width of the graph area.
 	 * max_change is used to scale graph properly.
 	 */
 	for (i = 0; i < count; i++) {
 		const char *prefix = "";
 		struct diffstat_file *file = data->files[i];
 		char *name = file->print_name;
 		uintmax_t added = file->added;
 		uintmax_t deleted = file->deleted;
 		int name_len;
 
 		if (!file->is_interesting && (added + deleted == 0))
 			continue;
 
 		/*
 		 * "scale" the filename
 		 */
 		len = name_width;
 		name_len = strlen(name);
 		if (name_width < name_len) {
 			char *slash;
 			prefix = "...";
 			len -= 3;
 			name += name_len - len;
 			slash = strchr(name, '/');
 			if (slash)
 				name = slash;
 		}
 
 		if (file->is_binary) {
 			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
 			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
 				strbuf_addch(&out, '\n');
 				emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
 						 out.buf, out.len, 0);
 				strbuf_reset(&out);
 				continue;
 			}
 			strbuf_addf(&out, " %s%"PRIuMAX"%s",
 				del_c, deleted, reset);
 			strbuf_addstr(&out, " -> ");
 			strbuf_addf(&out, "%s%"PRIuMAX"%s",
 				add_c, added, reset);
 			strbuf_addstr(&out, " bytes\n");
 			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
 					 out.buf, out.len, 0);
 			strbuf_reset(&out);
 			continue;
 		}
 		else if (file->is_unmerged) {
 			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
 			strbuf_addstr(&out, " Unmerged\n");
 			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
 					 out.buf, out.len, 0);
 			strbuf_reset(&out);
 			continue;
 		}
 
 		/*
 		 * scale the add/delete
 		 */
 		add = added;
 		del = deleted;
 
 		if (graph_width <= max_change) {
 			int total = scale_linear(add + del, graph_width, max_change);
 			if (total < 2 && add && del)
 				/* width >= 2 due to the sanity check */
 				total = 2;
 			if (add < del) {
 				add = scale_linear(add, graph_width, max_change);
 				del = total - add;
 			} else {
 				del = scale_linear(del, graph_width, max_change);
 				add = total - del;
 			}
 		}
 		strbuf_addf(&out, " %s%-*s |", prefix, len, name);
 		strbuf_addf(&out, " %*"PRIuMAX"%s",
 			number_width, added + deleted,
 			added + deleted ? " " : "");
 		show_graph(&out, '+', add, add_c, reset);
 		show_graph(&out, '-', del, del_c, reset);
 		strbuf_addch(&out, '\n');
 		emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
 				 out.buf, out.len, 0);
 		strbuf_reset(&out);
 	}
 
 	for (i = 0; i < data->nr; i++) {
 		struct diffstat_file *file = data->files[i];
 		uintmax_t added = file->added;
 		uintmax_t deleted = file->deleted;
 
 		if (file->is_unmerged ||
 		    (!file->is_interesting && (added + deleted == 0))) {
 			total_files--;
 			continue;
 		}
 
 		if (!file->is_binary) {
 			adds += added;
 			dels += deleted;
 		}
 		if (i < count)
 			continue;
 		if (!extra_shown)
 			emit_diff_symbol(options,
 					 DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
 					 NULL, 0, 0);
 		extra_shown = 1;
 	}
 
 	print_stat_summary_inserts_deletes(options, total_files, adds, dels);
+	strbuf_release(&out);
 }
 
 static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
-- 
2.14.1

