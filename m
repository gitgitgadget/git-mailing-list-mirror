Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 54E0F2023D
	for <e@80x24.org>; Tue, 23 May 2017 02:41:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S936034AbdEWCl1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 22 May 2017 22:41:27 -0400
Received: from mail-pf0-f181.google.com ([209.85.192.181]:34671 "EHLO
        mail-pf0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965573AbdEWClQ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 May 2017 22:41:16 -0400
Received: by mail-pf0-f181.google.com with SMTP id 9so99553609pfj.1
        for <git@vger.kernel.org>; Mon, 22 May 2017 19:41:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=U0cRJYVjlmuG/vFB88b28Gx/oLQ+DY+O/Q4+nVRmrcQ=;
        b=OPQhqirw9/poOhGlBTS1/F9fzJmV4AOcKsjaVS/VQLcSysVkyJPrsYvI/jeK0usNm+
         xEFvxKXv0z8lYFl+7LBLd0zRdZ6XBEB2BUreWcGXxvZ5guZ2QJatHg9BkbukxMBg7Dwn
         U7Igji6MH+4zOgq4+TemJmoTlk5E4N/DXxv/EbPWzm7YCXGfhHMxBxJxrCt+Jg9Ab1ur
         +FFzBUu/429F8dd4I5bxVWffxqq9NOeos2y/jKKLfzFG5NLIROhl1ms7ajMnrbVaxjkX
         tmqFUv4EmrrAw52YqpQGB5evIdYMzbS2+Jfi6UaGUGjALbf1IVORcFjqi46SByXLT+Rz
         3Wfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=U0cRJYVjlmuG/vFB88b28Gx/oLQ+DY+O/Q4+nVRmrcQ=;
        b=YWxvNcIE2QuBnNfEFZ285fmJTHJ/H/59fONYR3Tc8egmUuwM8MqH6iJ9SnuVLj0q7V
         ByQfxLB59Vztcr07hwpdCds5l3vGTSq0XR1lWFoK1nzBzouwiWXk5IgE9zx+cjPLHjLg
         nAxF+dkWyDBJRm6RdlcKkH4bh1mR7qCVl6I4VYQKbdrHUbakPadLiHvV3lI6uGgPCyyr
         48rHJG7Ca3zvAys60EtSpg/nlyCBwqWsLB0TsfeSH3fgACUsyyvHKXC1YuaAWFDAzspM
         22ag+d3fp0LkTXwErXlIcn5lTGkDbHp2qIYnVmLgJLFm99vZq+ImufHqTYYLYwNiGoum
         0BlA==
X-Gm-Message-State: AODbwcC9+Wez5vC/wVAUDJO3MjR5ZroD/LvfGZEMqP4+GgaY0nB3IKMR
        3reRK9Fe6BuiNXHB
X-Received: by 10.84.222.129 with SMTP id x1mr32655194pls.144.1495507275107;
        Mon, 22 May 2017 19:41:15 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:6dc1:8d70:6f8f:1c2a])
        by smtp.gmail.com with ESMTPSA id o20sm31117850pfa.96.2017.05.22.19.41.14
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 22 May 2017 19:41:14 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, bmwill@google.com, jrnieder@gmail.com,
        jonathantanmy@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv4 11/17] diff.c: convert show_stats to use emit_line_*
Date:   Mon, 22 May 2017 19:40:42 -0700
Message-Id: <20170523024048.16879-12-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170523024048.16879-1-sbeller@google.com>
References: <20170518193746.486-1-sbeller@google.com>
 <20170523024048.16879-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a later patch, I want to propose an option to detect&color
moved lines in a diff, which cannot be done in a one-pass over
the diff. Instead we need to go over the whole diff twice,
because we cannot detect the first line of the two corresponding
lines (+ and -) that got moved.

So to prepare the diff machinery for two pass algorithms
(i.e. buffer it all up and then operate on the result),
move all emissions to places, such that the only emitting
function is emit_line_0.

We call print_stat_summary from builtin/apply, so we still
need the version with a file pointer, so introduce
print_stat_summary_0 that uses emit_line_* machinery and
keep print_stat_summary with the same arguments around.

The responsibility to print the line prefix moves from the callers
of print_stat_summary_0 into the function itself.

Signed-off-by: Stefan Beller <sbeller@google.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 diff.c | 89 ++++++++++++++++++++++++++++++++++++++----------------------------
 diff.h |  4 +--
 2 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/diff.c b/diff.c
index b5a5261a4e..a76abf5f69 100644
--- a/diff.c
+++ b/diff.c
@@ -1540,20 +1540,19 @@ static int scale_linear(int it, int width, int max_change)
 	return 1 + (it * (width - 1) / max_change);
 }
 
-static void show_name(FILE *file,
+static void show_name(struct strbuf *out,
 		      const char *prefix, const char *name, int len)
 {
-	fprintf(file, " %s%-*s |", prefix, len, name);
+	strbuf_addf(out, " %s%-*s |", prefix, len, name);
 }
 
-static void show_graph(FILE *file, char ch, int cnt, const char *set, const char *reset)
+static void show_graph(struct strbuf *out, char ch, int cnt, const char *set, const char *reset)
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
@@ -1577,14 +1576,16 @@ static void fill_print_name(struct diffstat_file *file)
 	file->print_name = pname;
 }
 
-int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
+static void print_stat_summary_0(struct diff_options *options, int files,
+				 int insertions, int deletions)
 {
 	struct strbuf sb = STRBUF_INIT;
-	int ret;
 
 	if (!files) {
 		assert(insertions == 0 && deletions == 0);
-		return fprintf(fp, "%s\n", " 0 files changed");
+		strbuf_addstr(&sb, " 0 files changed");
+		emit_line(options, NULL, NULL, 1, 0, sb.buf, sb.len);
+		return;
 	}
 
 	strbuf_addf(&sb,
@@ -1611,9 +1612,17 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
 			    deletions);
 	}
 	strbuf_addch(&sb, '\n');
-	ret = fputs(sb.buf, fp);
+	emit_line(options, NULL, NULL, 1, 0, sb.buf, sb.len);
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
+	print_stat_summary_0(&o, files, insertions, deletions);
 }
 
 static void show_stats(struct diffstat_t *data, struct diff_options *options)
@@ -1623,13 +1632,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -1783,26 +1792,29 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		}
 
 		if (file->is_binary) {
-			fprintf(options->file, "%s", line_prefix);
-			show_name(options->file, prefix, name, len);
-			fprintf(options->file, " %*s", number_width, "Bin");
+			show_name(&out, prefix, name, len);
+			strbuf_addf(&out, " %*s", number_width, "Bin");
 			if (!added && !deleted) {
-				putc('\n', options->file);
+				strbuf_addch(&out, '\n');
+				emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
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
+			emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+			strbuf_reset(&out);
 			continue;
 		}
 		else if (file->is_unmerged) {
-			fprintf(options->file, "%s", line_prefix);
-			show_name(options->file, prefix, name, len);
-			fprintf(options->file, " Unmerged\n");
+			show_name(&out, prefix, name, len);
+			strbuf_addstr(&out, " Unmerged\n");
+			emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+			strbuf_reset(&out);
 			continue;
 		}
 
@@ -1825,14 +1837,15 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 				add = total - del;
 			}
 		}
-		fprintf(options->file, "%s", line_prefix);
-		show_name(options->file, prefix, name, len);
-		fprintf(options->file, " %*"PRIuMAX"%s",
+		show_name(&out, prefix, name, len);
+		strbuf_addf(&out, " %*"PRIuMAX"%s",
 			number_width, added + deleted,
 			added + deleted ? " " : "");
-		show_graph(options->file, '+', add, add_c, reset);
-		show_graph(options->file, '-', del, del_c, reset);
-		fprintf(options->file, "\n");
+		show_graph(&out, '+', add, add_c, reset);
+		show_graph(&out, '-', del, del_c, reset);
+		strbuf_addch(&out, '\n');
+		emit_line(options, NULL, NULL, 1, 0, out.buf, out.len);
+		strbuf_reset(&out);
 	}
 
 	for (i = 0; i < data->nr; i++) {
@@ -1853,11 +1866,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
 		if (i < count)
 			continue;
 		if (!extra_shown)
-			fprintf(options->file, "%s ...\n", line_prefix);
+			emit_line(options, NULL, NULL, 1, 0,
+				  " ...\n", strlen(" ...\n"));
 		extra_shown = 1;
 	}
-	fprintf(options->file, "%s", line_prefix);
-	print_stat_summary(options->file, total_files, adds, dels);
+
+	print_stat_summary_0(options, total_files, adds, dels);
 }
 
 static void show_shortstats(struct diffstat_t *data, struct diff_options *options)
@@ -1869,7 +1883,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 
 	for (i = 0; i < data->nr; i++) {
 		int added = data->files[i]->added;
-		int deleted= data->files[i]->deleted;
+		int deleted = data->files[i]->deleted;
 
 		if (data->files[i]->is_unmerged ||
 		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
@@ -1879,8 +1893,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			dels += deleted;
 		}
 	}
-	fprintf(options->file, "%s", diff_line_prefix(options));
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary_0(options, total_files, adds, dels);
 }
 
 static void show_numstat(struct diffstat_t *data, struct diff_options *options)
diff --git a/diff.h b/diff.h
index 9ad546361a..56d8dd036e 100644
--- a/diff.h
+++ b/diff.h
@@ -392,8 +392,8 @@ extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
 
-extern int print_stat_summary(FILE *fp, int files,
-			      int insertions, int deletions);
+extern void print_stat_summary(FILE *fp, int files,
+			       int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
 #endif /* DIFF_H */
-- 
2.13.0.18.g7d86cc8ba0

