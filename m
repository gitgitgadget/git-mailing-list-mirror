Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A6ACC2023D
	for <e@80x24.org>; Wed, 17 May 2017 02:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752901AbdEQC71 (ORCPT <rfc822;e@80x24.org>);
        Tue, 16 May 2017 22:59:27 -0400
Received: from mail-pg0-f47.google.com ([74.125.83.47]:35310 "EHLO
        mail-pg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752836AbdEQC7V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 May 2017 22:59:21 -0400
Received: by mail-pg0-f47.google.com with SMTP id q125so66048705pgq.2
        for <git@vger.kernel.org>; Tue, 16 May 2017 19:59:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DoknSrhGBfYqCr0vrYBQhrPmU1mvcY5fMdc3huSS/kk=;
        b=cAo4xqLlJc6BuzAEr1xPF06WJVSDQm678UGWjlZ0YlCD0rOl9yTUmsySuf46AlBTb2
         zLVBzTMF5lU7Gn5ljQ80ZBIjKQ+U4GsNPElHns/m6N97eMDzUh9VYws5GPC9EJIq90Ho
         E5bndxtcP/dJQOJM3fOBeDTThmgJFqFdwd8g/VXKsxA4InVJYmS+1LcE3HGTnZPbIPct
         swUeWh52ZoHchlA6fJ0syX7D0AJCnITcdSg89q9A4dey/OyyyqJyfIwkIL2t/sY4V6YN
         tCz8ttodaRrqGWfIGbdEZOA4zglXE6LjkB4780REe/GmTYzJv3TKQMMJEzhDzcJkI6XT
         rYKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DoknSrhGBfYqCr0vrYBQhrPmU1mvcY5fMdc3huSS/kk=;
        b=SmdZpAoMInFy9dt4jyZG6HJMflKA7Zw6VBu605c7bynagw6BBdZCd+tO0nPJgzUtqR
         W6rhtL/2L9Cp835Zs/pwf/CdaShXVgXXNNoNwhJ20EU9zrZ5HsfkIbd8ExeHZ8JKA3dR
         g/1G6RHL5kkr8ccp4VBXb4MBXimEHUtEIZZAulnpZQx1u/FwExarLPy0AJ3PzbbGK2Z0
         yw/z/6wUfgOsQsITA4FEJsfwxjKL1FPUeCSuaTj+btyM4BYGsdLSM4ajMpvhYD1iaQ2H
         bpjcq6KGohd7Fjrkw8BNMeq+zcRH29Qkm0ZCOxsHk1kfFPujY4WNHnbmqE2ZSo1V2nXN
         gW7A==
X-Gm-Message-State: AODbwcD96SnB/CcAV7I4HnIDEIMXwJOfUJiSjN7s4yWlJWUsJX/usH/X
        QVTiigPObNyN1AN2
X-Received: by 10.99.96.3 with SMTP id u3mr1287787pgb.69.1494989960966;
        Tue, 16 May 2017 19:59:20 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:b4bc:dafd:125e:c48a])
        by smtp.gmail.com with ESMTPSA id m89sm643855pfg.22.2017.05.16.19.59.20
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Tue, 16 May 2017 19:59:20 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     jrnieder@gmail.com, gitster@pobox.com, jonathantanmy@google.com,
        bmwill@google.com, peff@peff.net, mhagger@alum.mit.edu,
        Stefan Beller <sbeller@google.com>
Subject: [PATCHv2 14/20] diff.c: convert show_stats to use emit_line_*
Date:   Tue, 16 May 2017 19:58:51 -0700
Message-Id: <20170517025857.32320-15-sbeller@google.com>
X-Mailer: git-send-email 2.13.0.18.g7d86cc8ba0
In-Reply-To: <20170517025857.32320-1-sbeller@google.com>
References: <20170514040117.25865-1-sbeller@google.com>
 <20170517025857.32320-1-sbeller@google.com>
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
---
 diff.c | 89 ++++++++++++++++++++++++++++++++++++++----------------------------
 diff.h |  4 +--
 2 files changed, 53 insertions(+), 40 deletions(-)

diff --git a/diff.c b/diff.c
index 2dd10fa16a..ccd28953d7 100644
--- a/diff.c
+++ b/diff.c
@@ -1536,20 +1536,19 @@ static int scale_linear(int it, int width, int max_change)
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
@@ -1573,14 +1572,16 @@ static void fill_print_name(struct diffstat_file *file)
 	file->print_name = pname;
 }
 
-int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
+void print_stat_summary_0(struct diff_options *options, int files,
+			  int insertions, int deletions)
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
@@ -1607,9 +1608,17 @@ int print_stat_summary(FILE *fp, int files, int insertions, int deletions)
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
@@ -1619,13 +1628,13 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -1779,26 +1788,29 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
 
@@ -1821,14 +1833,15 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -1849,11 +1862,12 @@ static void show_stats(struct diffstat_t *data, struct diff_options *options)
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
@@ -1865,7 +1879,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 
 	for (i = 0; i < data->nr; i++) {
 		int added = data->files[i]->added;
-		int deleted= data->files[i]->deleted;
+		int deleted = data->files[i]->deleted;
 
 		if (data->files[i]->is_unmerged ||
 		    (!data->files[i]->is_interesting && (added + deleted == 0))) {
@@ -1875,8 +1889,7 @@ static void show_shortstats(struct diffstat_t *data, struct diff_options *option
 			dels += deleted;
 		}
 	}
-	fprintf(options->file, "%s", diff_line_prefix(options));
-	print_stat_summary(options->file, total_files, adds, dels);
+	print_stat_summary_0(options, total_files, adds, dels);
 }
 
 static void show_numstat(struct diffstat_t *data, struct diff_options *options)
diff --git a/diff.h b/diff.h
index 6e14100102..b75b0d7283 100644
--- a/diff.h
+++ b/diff.h
@@ -394,8 +394,8 @@ extern int parse_rename_score(const char **cp_p);
 
 extern long parse_algorithm_value(const char *value);
 
-extern int print_stat_summary(FILE *fp, int files,
-			      int insertions, int deletions);
+extern void print_stat_summary(FILE *fp, int files,
+			       int insertions, int deletions);
 extern void setup_diff_pager(struct diff_options *);
 
 #endif /* DIFF_H */
-- 
2.13.0.18.g7d86cc8ba0

