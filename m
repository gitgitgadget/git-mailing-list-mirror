Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 10BAD202A7
	for <e@80x24.org>; Fri, 30 Jun 2017 00:08:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752434AbdF3AId (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 20:08:33 -0400
Received: from mail-pf0-f174.google.com ([209.85.192.174]:34619 "EHLO
        mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752538AbdF3AHq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 20:07:46 -0400
Received: by mail-pf0-f174.google.com with SMTP id s66so58007354pfs.1
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 17:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=V90fxrm5MZsJUEltPH1vQnCAGYjJNylvTBjQDkr7Jek=;
        b=qlag+yspvCJ4I9w5satWz1Wx56+HkQLGe14pSL6oQ0e+XqIc/IkyrFO73h1Zo2+KOO
         chLRAqt42UVz6DG3GRbugCRRfjS3yp3jSnr79E156aV7zuBrD6WxMuFficO9ALDOEGdF
         OMsWjvOqLVZ/OwubJd4qFea8Tzw1+0OkHnoiFzPZrZwNWVXlO5FtZSpAQfYMQI6NRRUc
         xm2T9vw+XWUQ1EdQLFrOk54kLJg29WQOurGbIPgDmhZTkNOaz5VWLYkLe4ww8j3FSngQ
         8YGGVt4k6zeNCYKVPhU1QSqgj7WSAim9AOrmWZmk3k7fB11tSfvlRmX5gyr+zcsQlEOp
         QEzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=V90fxrm5MZsJUEltPH1vQnCAGYjJNylvTBjQDkr7Jek=;
        b=l8SVc8utrjzrR4fe+g+U6yTBr/VP7UzEqjMFKh7Vr6nBvs4PUqk71q4XE83rGe9k7g
         sE4ekDmiXDP8jetRJDiQJ/6ZdkSQNojIZfU7qtPh1zsst7IHfFz+mU3I0rrcgxhhdBlU
         OxQO7ABePzMe3Rs35o0SmFlCLoKq5AbkV3483cgDdwWOPGU/Sud+k7nj+z0v5KTvOA+b
         jF60HO5GlnHn/uDBQ+O+ixcxLAE+UF2B9DRKqALya5SW5S7+vC+nd3q+1pnF1Jk5J8q+
         qUSvUkyA9I3T4QjnEAAr5pcBZkkYqY5T098Ku6yPXn4JGpqikRJgrGuguw6ud0/19tz9
         PcPQ==
X-Gm-Message-State: AKS2vOzPkFN859RFyiIg34fWjMxJMxMK++EhHJmk3+UAWT8Ug27/iOud
        44chRrqu5X488ujZeSvzwg==
X-Received: by 10.84.217.150 with SMTP id p22mr21002672pli.270.1498781265170;
        Thu, 29 Jun 2017 17:07:45 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:c3c:7a18:f5d8:50e0])
        by smtp.gmail.com with ESMTPSA id y185sm11285746pgb.9.2017.06.29.17.07.44
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 29 Jun 2017 17:07:44 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com, git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [PATCH 17/25] diff.c: convert show_stats to use emit_diff_symbol
Date:   Thu, 29 Jun 2017 17:07:02 -0700
Message-Id: <20170630000710.10601-18-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.31.g9b732c453e
In-Reply-To: <20170630000710.10601-1-sbeller@google.com>
References: <20170630000710.10601-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

We call print_stat_summary from builtin/apply, so we still
need the version with a file pointer, so introduce
print_stat_summary_0 that uses emit_string machinery and
keep print_stat_summary with the same arguments around.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 114 +++++++++++++++++++++++++++++++++++++++++------------------------
 diff.h |   4 +--
 2 files changed, 74 insertions(+), 44 deletions(-)

diff --git a/diff.c b/diff.c
index f5a14359ae..76d4b8ebf9 100644
--- a/diff.c
+++ b/diff.c
@@ -566,6 +566,10 @@ enum diff_symbol {
 	DIFF_SYMBOL_BINARY_DIFF_HEADER_LITERAL,
 	DIFF_SYMBOL_BINARY_DIFF_BODY,
 	DIFF_SYMBOL_BINARY_DIFF_FOOTER,
+	DIFF_SYMBOL_STATS_SUMMARY_NO_FILES,
+	DIFF_SYMBOL_STATS_SUMMARY_ABBREV,
+	DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES,
+	DIFF_SYMBOL_STATS_LINE,
 	DIFF_SYMBOL_SUBMODULE_ADD,
 	DIFF_SYMBOL_SUBMODULE_DEL,
 	DIFF_SYMBOL_SUBMODULE_UNTRACKED,
@@ -629,6 +633,7 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 {
 	static const char *nneof = " No newline at end of file\n";
 	const char *context, *reset, *set, *meta, *fraginfo;
+	struct strbuf sb = STRBUF_INIT;
 	switch (s) {
 	case DIFF_SYMBOL_NO_LF_EOF:
 		context = diff_get_color_opt(o, DIFF_CONTEXT);
@@ -640,6 +645,8 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 	case DIFF_SYMBOL_SUBMODULE_HEADER:
 	case DIFF_SYMBOL_SUBMODULE_ERROR:
 	case DIFF_SYMBOL_SUBMODULE_PIPETHROUGH:
+	case DIFF_SYMBOL_STATS_SUMMARY_INSERTS_DELETES:
+	case DIFF_SYMBOL_STATS_LINE:
 	case DIFF_SYMBOL_BINARY_DIFF_BODY:
 	case DIFF_SYMBOL_CONTEXT_FRAGINFO:
 		emit_line(o, "", "", line, len);
@@ -748,9 +755,17 @@ static void emit_diff_symbol(struct diff_options *o, enum diff_symbol s,
 		fprintf(o->file, "%sSubmodule %s contains modified content\n",
 			diff_line_prefix(o), line);
 		break;
+	case DIFF_SYMBOL_STATS_SUMMARY_NO_FILES:
+		emit_line(o, "", "", " 0 files changed\n",
+			  strlen(" 0 files changed\n"));
+		break;
+	case DIFF_SYMBOL_STATS_SUMMARY_ABBREV:
+		emit_line(o, "", "", " ...\n", strlen(" ...\n"));
+		break;
 	default:
 		die("BUG: unknown diff symbol");
 	}
+	strbuf_release(&sb);
 }
 
 void diff_emit_submodule_del(struct diff_options *o, const char *line)
@@ -1705,20 +1720,14 @@ static int scale_linear(int it, int width, int max_change)
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
@@ -1742,14 +1751,16 @@ static void fill_print_name(struct diffstat_file *file)
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
@@ -1776,9 +1787,19 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
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
@@ -1788,13 +1809,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -1948,26 +1969,32 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
 
@@ -1990,14 +2017,16 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -2018,11 +2047,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -2034,7 +2065,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 
 	for (i = 0; i < data->nr; i++) {
 		int added = data->files[i]->added;
-		int deleted= data->files[i]->deleted;
+		int deleted = data->files[i]->deleted;
 
 		if (data->files[i]->is_unmerged ||
 		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
@@ -2044,8 +2075,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			dels += deleted;
 		}
 	}
-	fprintf(options->file, "%s", diff_line_prefix(options));
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary_inserts_deletes(options, total_files, adds, dels);
 }
 
 static void show_numstat(struct diffstat_t *data, struct diff_options *options)
diff --git a/diff.h b/diff.h
index ae40bac7a9..d6094a1eed 100644
--- a/diff.h
+++ b/diff.h
@@ -405,8 +405,8 @@ extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
 
-extern int print_stat_summary(FILE *fp, int files,
-			      int insertions, int deletions);
+extern void print_stat_summary(FILE *fp, int files,
+			       int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
 #endif /* DIFF_H */
-- 
2.13.0.31.g9b732c453e

