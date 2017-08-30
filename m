Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3895A208E0
	for <e@80x24.org>; Wed, 30 Aug 2017 17:51:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752291AbdH3Ruv (ORCPT <rfc822;e@80x24.org>);
        Wed, 30 Aug 2017 13:50:51 -0400
Received: from mout.web.de ([217.72.192.78]:52357 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752003AbdH3RuI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Aug 2017 13:50:08 -0400
Received: from debian.fritz.box ([91.20.59.6]) by smtp.web.de (mrweb102
 [213.165.67.124]) with ESMTPSA (Nemesis) id 0LiCsx-1d93E40W4x-00nMmY for
 <git@vger.kernel.org>; Wed, 30 Aug 2017 19:50:07 +0200
From:   Rene Scharfe <l.s.r@web.de>
To:     git@vger.kernel.org
Subject: [PATCH 12/34] diff: release strbuf after use in show_stats()
Date:   Wed, 30 Aug 2017 19:49:43 +0200
Message-Id: <20170830175005.20756-13-l.s.r@web.de>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170830175005.20756-1-l.s.r@web.de>
References: <20170830175005.20756-1-l.s.r@web.de>
X-Provags-ID: V03:K0:T4aq8ZWVqvYncqESkwCNL9fo/zgpPEyBIZnr/r0W5SJQkgIAU+I
 SqM0OiRfBgPFQ5ChBZAL2t4yg5r+yTTZL7BT9PnkDH2qmvMEvtw5BHjeEBdbx2Jrwdcl/Hk
 QYMg8hSQi5HnWIo4pbFvROIVrdngyYtzOc2ukGeMTxea6g0PVL5g/Q4WPHyhGVXG7bnHQi9
 SdRouY0MAE5hqm4RLlQsw==
X-UI-Out-Filterresults: notjunk:1;V01:K0:Hjebg7sZXsg=:grIYh96ZmaMmJcUC1Coeao
 4M5rUH7IUBggk+pSYNgohC5d9lEIfKrCFH3RiZhMF83iEg/FTYDIXqfHS+ZeDLyhPb5LPgJx/
 LRDMOAzGBn7D8xPHPUTTIhmN0qk3+J1/BmXs24V7NZDzts3aBy8KKtAGrfAaj5yLOMHL1Tiwp
 Pg3Qb75+BJjAhJj/UtF7xDkVjFBh37SwD/1UnC5x5/RG/TRu1ruXaDYwFGCKPSYacHB1lq7lq
 j5RRnl5MB6VW2ubgG1CLyiceWZ+pTj1yZzZZF6dywpQlekPc80r2EBFFWE/7qnYYTyHLKj4Ck
 PP6nFf70L6qmgjvrg5P/DPn+3C/2nPO2SEjjGCE5AuUmJJqClttv+aXWBJ8ZzpRqCdPAYwqfR
 cADDSZiQ6ZisdomLu+gwpaiOtJG2duA8t+pb10PR3j8h0u6kjDNJvhhgxxWAksrR/YdbDeQ3v
 RWX5pZj2LrVUYfLEn4Z1Wz6d20FrEA66fIxbg2kYMHxDLlXX334xJyeJZIwEPMt8FprVnQXT+
 X2XbvyzIenISSHjpi13lBwpFPUWvv/gwg0XDWjsT6iRl7pEfMMALdJJ34DjOzUIQuNiKqVe+C
 x3CRV0wDYeLThtqZt1tjbcgVKQnBDRgaYQqAs6VvSY0Tqns7pc0g8Ce7ZXVQy6ppazNWfWldU
 mUMT7s3hKst95TYGfG5WCmSaXQ/8J4eUCYha0cFcTYn24JrEltiDkw/n1QdbJjgGS+aInyXKO
 OR3YxaKoC7dNcLLijMeBwIZaf8DeQ7gQB5j5fnubiuAO3PZFXYi6/7+/HrdDKHDl564Jwzb9X
 WKHk2VtmGnUS6ssp3lFD6k7YWeafA==
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

