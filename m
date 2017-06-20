Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id CC2611FA7B
	for <e@80x24.org>; Tue, 20 Jun 2017 02:48:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751806AbdFTCsy (ORCPT <rfc822;e@80x24.org>);
        Mon, 19 Jun 2017 22:48:54 -0400
Received: from mail-pf0-f175.google.com ([209.85.192.175]:33846 "EHLO
        mail-pf0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751789AbdFTCsv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Jun 2017 22:48:51 -0400
Received: by mail-pf0-f175.google.com with SMTP id s66so62712022pfs.1
        for <git@vger.kernel.org>; Mon, 19 Jun 2017 19:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AIlReFFKSWdamIO6+d6ugrlJc1M1Wrg0U6Wq7Gy7ZYM=;
        b=VEhAiCaTEQAtqkK9u7aR5OxKpeVPSfGWkQdZPkEbIf2r4oY6KvT2BHoveRC9qP6/IH
         bZsme7w1VjKUhwVxvqfxpCnLPgAaVjJeMARxh6iLI56NpujEqVhns5QGiWym7piR6D2W
         mS4TfssfmXUpMBsa6JSZaAtNqi8sV6XtOtI405/wOWn13mnLQkBEnjwmmPHzjTC1Gj8Z
         eL66jwxZFDGDKupZYdu9lAuEc7enn8rSuDanpYn2AWt53qOEBlytvdNpxNr89YUtrdz7
         UM5H8+/Yp4I/di5Bn82H11PCkIMpeieVYDxRdDM1LnDTjWsz0euwelWNTP5UZTZZDCV9
         DvbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AIlReFFKSWdamIO6+d6ugrlJc1M1Wrg0U6Wq7Gy7ZYM=;
        b=mE1SIcPw+29kIuNK8kK7sTLAl/gSgymfxSOWc+z8w5M46Nc/FwvQyoi0ZWdvNc06I4
         CmaiOuCWeIzO/AwKk6o0Now+O4YymgG11tPWHP5kUxe9s+XzuZenJAf2Zp91e6+TNA+1
         qwo3pydu8DIwIjZbkr/0yanSPo1goesKyzfs/Nsq0HhR1SfNship+atVe57qndh8js5b
         oymMzMXqDXUlysAq+dl2JghQ+eRvEBqfsU+N6zKoUoG12yVsGzGxBNrHW0qTm80eeRsX
         PXNkLR+i8at1TMJJqA6Wz4eSOX1raaSjrNkPe72tFOE/5JbqlJ70P4kBZD1d8sd8p83h
         Rf+w==
X-Gm-Message-State: AKS2vOylvW5kyEU1N4XAN2+2yFi6soB3bjUUXi+yO9kJq3s9hw92hf0G
        /8H+K64rjU/+JJy+tUxN8Q==
X-Received: by 10.101.91.65 with SMTP id y1mr29281126pgr.92.1497926925429;
        Mon, 19 Jun 2017 19:48:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:bc0c:b118:3a9a:5fd4])
        by smtp.gmail.com with ESMTPSA id y28sm24205508pfd.32.2017.06.19.19.48.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 19 Jun 2017 19:48:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     sbeller@google.com
Cc:     bmwill@google.com, git@vger.kernel.org, gitster@pobox.com,
        jonathantanmy@google.com, jrnieder@gmail.com, mhagger@alum.mit.edu,
        peff@peff.net, philipoakley@iee.org
Subject: [PATCH 17/26] diff.c: convert show_stats to use emit_diff_symbol
Date:   Mon, 19 Jun 2017 19:48:07 -0700
Message-Id: <20170620024816.20021-18-sbeller@google.com>
X-Mailer: git-send-email 2.12.2.575.gb14f27f917
In-Reply-To: <20170620024816.20021-1-sbeller@google.com>
References: <CAGZ79kaqjQYmkt77kk5m=fdBfbZAvwd0YhhT7=O5b-FkQmDfHg@mail.gmail.com>
 <20170620024816.20021-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We call print_stat_summary from builtin/apply, so we still
need the version with a file pointer, so introduce
print_stat_summary_0 that uses emit_string machinery and
keep print_stat_summary with the same arguments around.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 diff.c | 118 +++++++++++++++++++++++++++++++++++++++++------------------------
 diff.h |   4 +--
 2 files changed, 77 insertions(+), 45 deletions(-)

diff --git a/diff.c b/diff.c
index e6ade5fde0..0a5ff2500f 100644
--- a/diff.c
+++ b/diff.c
@@ -586,7 +586,10 @@ enum diff_symbol {
 	DIFF_SYMBOL_SUBMODULE_HEADER,
 	DIFF_SYMBOL_SUBMODULE_ERROR,
 	DIFF_SYMBOL_SUBMODULE_PIPETHROUGH,
-
+	DIFF_SYMBOL_STATS_SUMMARY_NO_FILES,
+	DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
+	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
+	DIFF_SYMBOL_STATS_LINE,
 };
 /*
  * Flags for content lines:
@@ -628,6 +631,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 {
 	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset, *set, *meta, *fraginfo;
+	struct strbuf sb = STRBUF_INIT;
 	switch (s) {
 	case DIFF_SYMBOL_SEPARATOR:
 		fprintf(o->file, "%s%c",
@@ -756,9 +760,22 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
 		emit_line(o, "", "", line, len);
 		break;
+	case DIFF_SYMBOL_STATS_SUMMARY_NO_FILES:
+		fprintf(o->file, " 0 files changed\n");
+		break;
+	case DIFF_SYMBOL_STATS_SUMMARY_ABBREV:
+		emit_line(o, "", "", " ...\n", strlen(" ...\n"));
+		break;
+	case DIFF_SYMBOL_STATS_LINE:
+		emit_line(o, "", "", line, len);
+		break;
+	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
+		emit_line(o, "", "", line, len);
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
+	strbuf_release(&sb);
 }
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line)
@@ -1712,20 +1729,14 @@ static int scale_linear(int it, int width, int max_change)
 	return 1 + (it * (width - 1) / max_change);
 }
 
-static void show_name(FILE *file,
-		      const char *prefix, const char *name, int len)
-{
-	fprintf(file, " %s%-*s |", prefix, len, name);
-}
-
-static void show_graph(FILE *file, char ch, int cnt, const char *set, const char *reset)
+static void show_graph(struct strbuf *out, char ch, int cnt,
+		       const char *set, const char *reset)
 {
 	if (cnt <= 0)
 		return;
-	fprintf(file, "%s", set);
-	while (cnt--)
-		putc(ch, file);
-	fprintf(file, "%s", reset);
+	strbuf_addstr(out, set);
+	strbuf_addchars(out, ch, cnt);
+	strbuf_addstr(out, reset);
 }
 
 static void fill_print_name(struct diffstat_file *file)
@@ -1749,14 +1760,16 @@ static void fill_print_name(struct diffstat_file *file)
 	file->print_name = pname;
 }
 
-int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
+static void print_stat_summary_inserts_deletes(struct diff_options *options,
+		int files, int insertions, int deletions)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
 
 	if (!files) {
 		assert(insertions == 0 && deletions == 0);
-		return fprintf(fp, "%s\n", " 0 files changed");
+		emit_diff_symbol(options, DIFF_SYMBOL_STATS_SUMMARY_NO_FILES,
+				 NULL, 0, 0);
+		return;
 	}
 
 	strbuf_addf(&sb,
@@ -1783,9 +1796,19 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
-	ret = fputs(sb.buf, fp);
+	emit_diff_symbol(options, DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
+			 sb.buf, sb.len, 0);
 	strbuf_release(&sb);
-	return ret;
+}
+
+void print_stat_summary(FILE *fp, int files,
+			int insertions, int deletions)
+{
+	struct diff_options o;
+	memset(&o, 0, sizeof(o));
+	o.file = fp;
+
+	print_stat_summary_inserts_deletes(&o, files, insertions, deletions);
 }
 
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
@@ -1795,13 +1818,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 	int total_files = data->nr, count;
 	int width, name_width, graph_width, number_width = 0, bin_width = 0;
 	const char *reset, *add_c, *del_c;
-	const char *line_prefix = "";
 	int extra_shown = 0;
+	const char *line_prefix = diff_line_prefix(options);
+	struct strbuf out = STRBUF_INIT;
 
 	if (data->nr == 0)
 		return;
 
-	line_prefix = diff_line_prefix(options);
 	count = options->stat_count ? options->stat_count : data->nr;
 
 	reset = diff_get_color_opt(options, DIFF_RESET);
@@ -1955,26 +1978,32 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		}
 
 		if (file->is_binary) {
-			fprintf(options->file, "%s", line_prefix);
-			show_name(options->file, prefix, name, len);
-			fprintf(options->file, " %*s", number_width, "Bin");
+			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
+			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
-				putc('\n', options->file);
+				strbuf_addch(&out, '\n');
+				emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
+						 out.buf, out.len, 0);
+				strbuf_reset(&out);
 				continue;
 			}
-			fprintf(options->file, " %s%"PRIuMAX"%s",
+			strbuf_addf(&out, " %s%"PRIuMAX"%s",
 				del_c, deleted, reset);
-			fprintf(options->file, " -> ");
-			fprintf(options->file, "%s%"PRIuMAX"%s",
+			strbuf_addstr(&out, " -> ");
+			strbuf_addf(&out, "%s%"PRIuMAX"%s",
 				add_c, added, reset);
-			fprintf(options->file, " bytes");
-			fprintf(options->file, "\n");
+			strbuf_addstr(&out, " bytes\n");
+			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
+					 out.buf, out.len, 0);
+			strbuf_reset(&out);
 			continue;
 		}
 		else if (file->is_unmerged) {
-			fprintf(options->file, "%s", line_prefix);
-			show_name(options->file, prefix, name, len);
-			fprintf(options->file, " Unmerged\n");
+			strbuf_addf(&out, " %s%-*s |", prefix, len, name);
+			strbuf_addstr(&out, " Unmerged\n");
+			emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
+					 out.buf, out.len, 0);
+			strbuf_reset(&out);
 			continue;
 		}
 
@@ -1997,14 +2026,16 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 				add = total - del;
 			}
 		}
-		fprintf(options->file, "%s", line_prefix);
-		show_name(options->file, prefix, name, len);
-		fprintf(options->file, " %*"PRIuMAX"%s",
+		strbuf_addf(&out, " %s%-*s |", prefix, len, name);
+		strbuf_addf(&out, " %*"PRIuMAX"%s",
 			number_width, added + deleted,
 			added + deleted ? " " : "");
-		show_graph(options->file, '+', add, add_c, reset);
-		show_graph(options->file, '-', del, del_c, reset);
-		fprintf(options->file, "\n");
+		show_graph(&out, '+', add, add_c, reset);
+		show_graph(&out, '-', del, del_c, reset);
+		strbuf_addch(&out, '\n');
+		emit_diff_symbol(options, DIFF_SYMBOL_STATS_LINE,
+				 out.buf, out.len, 0);
+		strbuf_reset(&out);
 	}
 
 	for (i = 0; i < data->nr; i++) {
@@ -2025,11 +2056,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (i < count)
 			continue;
 		if (!extra_shown)
-			fprintf(options->file, "%s ...\n", line_prefix);
+			emit_diff_symbol(options,
+					 DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
+					 NULL, 0, 0);
 		extra_shown = 1;
 	}
-	fprintf(options->file, "%s", line_prefix);
-	print_stat_summary(options->file, total_files, adds, dels);
+
+	print_stat_summary_inserts_deletes(options, total_files, adds, dels);
 }
 
 static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
@@ -2041,7 +2074,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 
 	for (i = 0; i < data->nr; i++) {
 		int added = data->files[i]->added;
-		int deleted= data->files[i]->deleted;
+		int deleted = data->files[i]->deleted;
 
 		if (data->files[i]->is_unmerged ||
 		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
@@ -2051,8 +2084,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			dels += deleted;
 		}
 	}
-	fprintf(options->file, "%s", diff_line_prefix(options));
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary_inserts_deletes(options, total_files, adds, dels);
 }
 
 static void show_numstat(struct diffstat_t *data, struct diff_options *options)
diff --git a/diff.h b/diff.h
index 2ee0ef3908..b73f7a1e75 100644
--- a/diff.h
+++ b/diff.h
@@ -398,8 +398,8 @@ extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
 
-extern int print_stat_summary(FILE *fp, int files,
-			      int insertions, int deletions);
+extern void print_stat_summary(FILE *fp, int files,
+			       int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
 #endif /* DIFF_H */
-- 
2.12.2.575.gb14f27f917

