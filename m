Return-Path: <SRS0=7dzq=DU=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8BBAC433E7
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:31:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 684B820E65
	for <git@archiver.kernel.org>; Tue, 13 Oct 2020 05:31:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f9qJALFu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732418AbgJMF3Q (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Oct 2020 01:29:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732408AbgJMF3Q (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Oct 2020 01:29:16 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F2AFC0613D0
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 22:29:16 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id n13so19605580ybk.9
        for <git@vger.kernel.org>; Mon, 12 Oct 2020 22:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=xrhFOfNqB5CyV3Y2posNuFdp9qLwQlvO3omko1hpkGY=;
        b=f9qJALFuNpoYlzxOC3ltT4sYbwx08mMMf3f7+tv69iaEnU94IhciSNnAXZqaO6liMc
         eT9N1h/GvmSZ2HTPkhwMvFRlrDZofp9B+0lz4oKbrpoVmSf2INYRHeh7ArEYCk/Bv5LN
         ilzmPy9qFZ3uTlqDzHIXRs8AtvuvfdJt8RppDJiRtqWdM17SVM8a8PFYZcczuydgOyVv
         WUE+eyfe/ld+4tCc90IXeq1AdqDEme64XtPZb8VwUx3CuTqcdR3W8ajSe0One55Xj+to
         9KQoQ1XlL/OZirQOJgnJl+yETqzqC5Kwsl+bfd6KMb8hjXEtHawtN+jsncoO4pV234Ts
         wfOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=xrhFOfNqB5CyV3Y2posNuFdp9qLwQlvO3omko1hpkGY=;
        b=TWt6Wu5KaRBMKJELk/4ihA2zW+XerTs/aHv1KcFJNYMc8vXkiUg60l71YZ7+FaWfOC
         /K9l3eGqnt+PF/G8kDICEEDHN8FIhTe3lYmNb3fOhJeEimreOCbZ+a7dlZ+6QIt/6Vu7
         AyzcziF2P88ypPRZTKxM8Z5euQjXbqCjAKJBCtUPdr7nLW8LYoY2ePl4SyvBtqhv96gw
         BWgmWADgwbk1zfjxdP4I4WPXzZ5WH0MLr+OE/bkGDmsEkIn+UiFjRWuQpioou4RW1UNw
         X9lh1f54YBj0QAb3pkGmt2+9CJqpx6cDOOCYfbKC+VEYUq3Cn+IAQfeW608w92hexVER
         Tyzw==
X-Gm-Message-State: AOAM530gsWWrFlGiJWFF8PWZMEIdHcuZ0AU6wefT8JoUw9ESzqOba6H7
        9QpdFPNm6C/Ml90uNMlSfJIRQEU7Oufaajd02X5uHXNFOLJgV//qQB+r9S/AIc0tMH+Hp2aejan
        DGwDe9X2qodRkFad5gaKZAA+KrymLh3xLnKd64JxcbRzyiqicZ3SqyljNBn9x
X-Google-Smtp-Source: ABdhPJy2cnehuoj/7PDUn2ZVKKZpq/wbKcri0cAb/Xxz7QeU8luKVmLNn8oDdCbuVli86/0M7uFDf3sW2iel
Sender: "shengfa via sendgmr" <shengfa@lins.c.googlers.com>
X-Received: from lins.c.googlers.com ([fda3:e722:ac3:10:2b:ff92:c0a8:cb])
 (user=shengfa job=sendgmr) by 2002:a25:a85:: with SMTP id 127mr36947464ybk.396.1602566955561;
 Mon, 12 Oct 2020 22:29:15 -0700 (PDT)
Date:   Tue, 13 Oct 2020 05:28:50 +0000
In-Reply-To: <20201013052851.373029-1-shengfa@google.com>
Message-Id: <20201013052851.373029-2-shengfa@google.com>
Mime-Version: 1.0
References: <CAEOYnAQYMrNAe9s1V-0DVLdL-B_KpHMDP5e=yRnbCkMWdrvFHQ@mail.gmail.com>
 <20201013052851.373029-1-shengfa@google.com>
X-Mailer: git-send-email 2.28.0.1011.ga647a8990f-goog
Subject: [WIP v2 1/2] Adding a record-time-zone command option for commit
From:   Shengfa Lin <shengfa@google.com>
To:     git@vger.kernel.org
Cc:     sandals@crustytoothpaste.net, gitster@pobox.com,
        jrnieder@gmail.com, nathaniel@google.com, rsbecker@nexbridge.com,
        santiago@nyu.edu, shengfa@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Many places in Git record the timezone of actor when a
timestamp is recorded, including the commiter and author
timestamps in a commit object and the tagger timestamp in a tag
object. Some people however prefer not to share where they
actually are.

They _could_ just say "export TZ=UTC" and be done with it,
but the method would not easily allow them to pretend to be
in the UTC timezone only with Git, while revealing their true
timezone to other activities (e.g. sending e-emails?).

Introduce --[no-]record-time-zone for commit command, which can be
specified to disallow Git to record time zone. Timezone will be
recorded by default.

Note that this is a WIP and the test is failing.

Signed-off-by: Shengfa Lin <shengfa@google.com>
---
 builtin/am.c            |  2 +-
 builtin/blame.c         |  4 +-
 builtin/commit.c        |  3 +-
 builtin/fast-import.c   |  2 +-
 builtin/show-branch.c   |  2 +-
 builtin/tag.c           |  2 +-
 cache.h                 | 10 +++--
 date.c                  | 96 ++++++++++++++++++++++++++++-------------
 http-backend.c          |  2 +-
 pretty.c                |  6 ++-
 ref-filter.c            |  2 +-
 reflog-walk.c           |  2 +-
 refs.c                  |  6 ++-
 sha1-name.c             |  2 +-
 t/helper/test-date.c    |  8 ++--
 t/t7514-commit-patch.sh |  9 ++++
 16 files changed, 107 insertions(+), 51 deletions(-)

diff --git a/builtin/am.c b/builtin/am.c
index 2c7673f74e..059cc5fce7 100644
--- a/builtin/am.c
+++ b/builtin/am.c
@@ -884,7 +884,7 @@ static int hg_patch_to_mail(FILE *out, FILE *in, int keep_cr)
 			if (tz > 0)
 				tz2 = -tz2;
 
-			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, DATE_MODE(RFC2822)));
+			fprintf(out, "Date: %s\n", show_date(timestamp, tz2, NULL, DATE_MODE(RFC2822)));
 		} else if (starts_with(sb.buf, "# ")) {
 			continue;
 		} else {
diff --git a/builtin/blame.c b/builtin/blame.c
index bb0f29300e..8205f01868 100644
--- a/builtin/blame.c
+++ b/builtin/blame.c
@@ -306,7 +306,7 @@ static const char *format_time(timestamp_t time, const char *tz_str,
 		size_t time_width;
 		int tz;
 		tz = atoi(tz_str);
-		time_str = show_date(time, tz, &blame_date_mode);
+		time_str = show_date(time, tz, NULL, &blame_date_mode);
 		strbuf_addstr(&time_buf, time_str);
 		/*
 		 * Add space paddings to time_buf to display a fixed width
@@ -1002,7 +1002,7 @@ int cmd_blame(int argc, const char **argv, const char *prefix)
 		blame_date_width = sizeof("Thu Oct 19 16:00:04 2006 -0700");
 		break;
 	case DATE_STRFTIME:
-		blame_date_width = strlen(show_date(0, 0, &blame_date_mode)) + 1; /* add the null */
+		blame_date_width = strlen(show_date(0, 0, NULL, &blame_date_mode)) + 1; /* add the null */
 		break;
 	}
 	blame_date_width -= 1; /* strip the null */
diff --git a/builtin/commit.c b/builtin/commit.c
index 1dfd799ec5..ee3ca2c7ac 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -1547,7 +1547,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 				N_("ok to record an empty change")),
 		OPT_HIDDEN_BOOL(0, "allow-empty-message", &allow_empty_message,
 				N_("ok to record a change with an empty message")),
-
+                OPT_BOOL(0, "record-time-zone", &record_time_zone, N_("record user timezone")),
 		OPT_END()
 	};
 
@@ -1580,6 +1580,7 @@ int cmd_commit(int argc, const char **argv, const char *prefix)
 	argc = parse_and_validate_options(argc, argv, builtin_commit_options,
 					  builtin_commit_usage,
 					  prefix, current_head, &s);
+
 	if (verbose == -1)
 		verbose = (config_commit_verbose < 0) ? 0 : config_commit_verbose;
 
diff --git a/builtin/fast-import.c b/builtin/fast-import.c
index 1bf50a73dc..5aebe70670 100644
--- a/builtin/fast-import.c
+++ b/builtin/fast-import.c
@@ -327,7 +327,7 @@ static void write_crash_report(const char *err)
 	fprintf(rpt, "fast-import crash report:\n");
 	fprintf(rpt, "    fast-import process: %"PRIuMAX"\n", (uintmax_t) getpid());
 	fprintf(rpt, "    parent process     : %"PRIuMAX"\n", (uintmax_t) getppid());
-	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, DATE_MODE(ISO8601)));
+	fprintf(rpt, "    at %s\n", show_date(time(NULL), 0, NULL, DATE_MODE(ISO8601)));
 	fputc('\n', rpt);
 
 	fputs("fatal: ", rpt);
diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index d6d2dabeca..e4210c06ab 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -777,7 +777,7 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 			else
 				msg++;
 			reflog_msg[i] = xstrfmt("(%s) %s",
-						show_date(timestamp, tz,
+						show_date(timestamp, tz, NULL,
 							  DATE_MODE(RELATIVE)),
 						msg);
 			free(logmsg);
diff --git a/builtin/tag.c b/builtin/tag.c
index ecf011776d..6ee3c7109e 100644
--- a/builtin/tag.c
+++ b/builtin/tag.c
@@ -332,7 +332,7 @@ static void create_reflog_msg(const struct object_id *oid, struct strbuf *sb)
 		free(buf);
 
 		if ((c = lookup_commit_reference(the_repository, oid)) != NULL)
-			strbuf_addf(sb, ", %s", show_date(c->date, 0, DATE_MODE(SHORT)));
+			strbuf_addf(sb, ", %s", show_date(c->date, 0, NULL, DATE_MODE(SHORT)));
 		break;
 	case OBJ_TREE:
 		strbuf_addstr(sb, "tree object");
diff --git a/cache.h b/cache.h
index c0072d43b1..84f9e88649 100644
--- a/cache.h
+++ b/cache.h
@@ -1625,17 +1625,18 @@ struct date_mode {
 /*
  * Convenience helper for passing a constant type, like:
  *
- *   show_date(t, tz, DATE_MODE(NORMAL));
+ *   show_date(t, tz, NULL, DATE_MODE(NORMAL));
  */
 #define DATE_MODE(t) date_mode_from_type(DATE_##t)
 struct date_mode *date_mode_from_type(enum date_mode_type type);
 
-const char *show_date(timestamp_t time, int timezone, const struct date_mode *mode);
+const char *show_date(timestamp_t time, int timezone, int *sign, const struct date_mode *mode);
 void show_date_relative(timestamp_t time, struct strbuf *timebuf);
 void show_date_human(timestamp_t time, int tz, const struct timeval *now,
 			struct strbuf *timebuf);
 int parse_date(const char *date, struct strbuf *out);
-int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset);
+int parse_date_basic(const char *date, timestamp_t *timestamp,
+                     int *offset, int *zero_offset_negative_sign);
 int parse_expiry_date(const char *date, timestamp_t *timestamp);
 void datestamp(struct strbuf *out);
 #define approxidate(s) approxidate_careful((s), NULL)
@@ -1979,4 +1980,7 @@ int print_sha1_ellipsis(void);
 /* Return 1 if the file is empty or does not exists, 0 otherwise. */
 int is_empty_or_missing_file(const char *filename);
 
+/* date.c */
+extern int record_time_zone;
+
 #endif /* CACHE_H */
diff --git a/date.c b/date.c
index f9ea807b3a..f32ab51f2b 100644
--- a/date.c
+++ b/date.c
@@ -6,6 +6,8 @@
 
 #include "cache.h"
 
+int record_time_zone = 1;
+
 /*
  * This is like mktime, but without normalization of tm_wday and tm_yday.
  */
@@ -213,7 +215,21 @@ struct date_mode *date_mode_from_type(enum date_mode_type type)
 	return &mode;
 }
 
-static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm, int tz, struct tm *human_tm, int human_tz, int local)
+static int negative_zero(int tz, int *sign)
+{
+        return !tz && sign && (*sign) == '-';
+}
+
+static const char *tz_fmt(int tz, int *sign)
+{
+        if (!negative_zero(tz, sign))
+                return " %+05d";
+        else
+                return " -%04d";
+}
+
+
+static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm, int tz, int *sign, struct tm *human_tm, int human_tz, int local)
 {
 	struct {
 		unsigned int	year:1,
@@ -277,10 +293,10 @@ static void show_date_normal(struct strbuf *buf, timestamp_t time, struct tm *tm
 		strbuf_addf(buf, " %d", tm->tm_year + 1900);
 
 	if (!hide.tz)
-		strbuf_addf(buf, " %+05d", tz);
+                strbuf_addf(buf, tz_fmt(tz, sign), tz);
 }
 
-const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
+const char *show_date(timestamp_t time, int tz, int *signp, const struct date_mode *mode)
 {
 	struct tm *tm;
 	struct tm tmbuf = { 0 };
@@ -331,15 +347,18 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 	if (mode->type == DATE_SHORT)
 		strbuf_addf(&timebuf, "%04d-%02d-%02d", tm->tm_year + 1900,
 				tm->tm_mon + 1, tm->tm_mday);
-	else if (mode->type == DATE_ISO8601)
-		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d %+05d",
+	else if (mode->type == DATE_ISO8601) {
+		strbuf_addf(&timebuf, "%04d-%02d-%02d %02d:%02d:%02d",
 				tm->tm_year + 1900,
 				tm->tm_mon + 1,
 				tm->tm_mday,
-				tm->tm_hour, tm->tm_min, tm->tm_sec,
-				tz);
+				tm->tm_hour, tm->tm_min, tm->tm_sec);
+		strbuf_addf(&timebuf, tz_fmt(tz, signp), tz);
+        }
 	else if (mode->type == DATE_ISO8601_STRICT) {
 		char sign = (tz >= 0) ? '+' : '-';
+                if (negative_zero(tz, signp))
+                        sign = '-';
 		tz = abs(tz);
 		strbuf_addf(&timebuf, "%04d-%02d-%02dT%02d:%02d:%02d%c%02d:%02d",
 				tm->tm_year + 1900,
@@ -347,16 +366,18 @@ const char *show_date(timestamp_t time, int tz, const struct date_mode *mode)
 				tm->tm_mday,
 				tm->tm_hour, tm->tm_min, tm->tm_sec,
 				sign, tz / 100, tz % 100);
-	} else if (mode->type == DATE_RFC2822)
-		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d %+05d",
+	} else if (mode->type == DATE_RFC2822) {
+		strbuf_addf(&timebuf, "%.3s, %d %.3s %d %02d:%02d:%02d",
 			weekday_names[tm->tm_wday], tm->tm_mday,
 			month_names[tm->tm_mon], tm->tm_year + 1900,
-			tm->tm_hour, tm->tm_min, tm->tm_sec, tz);
+			tm->tm_hour, tm->tm_min, tm->tm_sec);
+		strbuf_addf(&timebuf, tz_fmt(tz, signp), tz);
+        }
 	else if (mode->type == DATE_STRFTIME)
 		strbuf_addftime(&timebuf, mode->strftime_fmt, tm, tz,
 				!mode->local);
 	else
-		show_date_normal(&timebuf, time, tm, tz, &human_tm, human_tz, mode->local);
+		show_date_normal(&timebuf, time, tm, tz, signp, &human_tm, human_tz, mode->local);
 	return timebuf.buf;
 }
 
@@ -786,14 +807,16 @@ static int match_tz(const char *date, int *offp)
 	return end - date;
 }
 
-static void date_string(timestamp_t date, int offset, struct strbuf *buf)
+static void date_string(timestamp_t date, int offset,
+                        int zero_offset_negative_sign, struct strbuf *buf)
 {
 	int sign = '+';
+        if (offset < 0) {
+                offset = -offset;
+                sign = '-';
+        } else if (!offset && zero_offset_negative_sign)
+                sign = '-';
 
-	if (offset < 0) {
-		offset = -offset;
-		sign = '-';
-	}
 	strbuf_addf(buf, "%"PRItime" %c%02d%02d", date, sign, offset / 60, offset % 60);
 }
 
@@ -826,17 +849,21 @@ static int match_object_header_date(const char *date, timestamp_t *timestamp, in
 
 /* Gr. strptime is crap for this; it doesn't have a way to require RFC2822
    (i.e. English) day/month names, and it doesn't work correctly with %z. */
-int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
+int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset, int *zero_offset_negative_sign)
 {
 	struct tm tm;
 	int tm_gmt;
 	timestamp_t dummy_timestamp;
 	int dummy_offset;
+        int dummy_zero_offset_negative_sign;
+        int negative_sign;
 
 	if (!timestamp)
 		timestamp = &dummy_timestamp;
 	if (!offset)
 		offset = &dummy_offset;
+        if (!zero_offset_negative_sign)
+                zero_offset_negative_sign = &dummy_zero_offset_negative_sign;
 
 	memset(&tm, 0, sizeof(tm));
 	tm.tm_year = -1;
@@ -848,6 +875,7 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 	tm.tm_sec = -1;
 	*offset = -1;
 	tm_gmt = 0;
+        negative_sign = 0;
 
 	if (*date == '@' &&
 	    !match_object_header_date(date + 1, timestamp, offset))
@@ -864,9 +892,11 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 			match = match_alpha(date, &tm, offset);
 		else if (isdigit(c))
 			match = match_digit(date, &tm, offset, &tm_gmt);
-		else if ((c == '-' || c == '+') && isdigit(date[1]))
+		else if ((c == '-' || c == '+') && isdigit(date[1])) {
 			match = match_tz(date, offset);
-
+                        if (c == '-')
+                                negative_sign = 1;
+                }
 		if (!match) {
 			/* BAD CRAP */
 			match = 1;
@@ -895,6 +925,9 @@ int parse_date_basic(const char *date, timestamp_t *timestamp, int *offset)
 
 	if (!tm_gmt)
 		*timestamp -= *offset * 60;
+
+        *zero_offset_negative_sign = (!(*offset) && negative_sign);
+
 	return 0; /* success */
 }
 
@@ -924,9 +957,10 @@ int parse_date(const char *date, struct strbuf *result)
 {
 	timestamp_t timestamp;
 	int offset;
-	if (parse_date_basic(date, &timestamp, &offset))
+        int zero_offset_negative_sign;
+	if (parse_date_basic(date, &timestamp, &offset, &zero_offset_negative_sign))
 		return -1;
-	date_string(timestamp, offset, result);
+	date_string(timestamp, offset, zero_offset_negative_sign, result);
 	return 0;
 }
 
@@ -996,15 +1030,16 @@ void parse_date_format(const char *format, struct date_mode *mode)
 void datestamp(struct strbuf *out)
 {
 	time_t now;
-	int offset;
-	struct tm tm = { 0 };
+	int offset = 0;
 
-	time(&now);
+        time(&now);
+        if (record_time_zone) {
+          struct tm tm = { 0 };
+          offset = tm_to_time_t(localtime_r(&now, &tm)) - now;
+          offset /= 60;
+        }
 
-	offset = tm_to_time_t(localtime_r(&now, &tm)) - now;
-	offset /= 60;
-
-	date_string(now, offset, out);
+	date_string(now, offset, !record_time_zone, out);
 }
 
 /*
@@ -1330,7 +1365,7 @@ timestamp_t approxidate_relative(const char *date)
 	int offset;
 	int errors = 0;
 
-	if (!parse_date_basic(date, &timestamp, &offset))
+	if (!parse_date_basic(date, &timestamp, &offset, NULL))
 		return timestamp;
 
 	get_time(&tv);
@@ -1346,7 +1381,7 @@ timestamp_t approxidate_careful(const char *date, int *error_ret)
 	if (!error_ret)
 		error_ret = &dummy;
 
-	if (!parse_date_basic(date, &timestamp, &offset)) {
+	if (!parse_date_basic(date, &timestamp, &offset, NULL)) {
 		*error_ret = 0;
 		return timestamp;
 	}
@@ -1371,3 +1406,4 @@ int date_overflows(timestamp_t t)
 	sys = t;
 	return t != sys || (t < 1) != (sys < 1);
 }
+
diff --git a/http-backend.c b/http-backend.c
index a03b4bae22..644c4c7af6 100644
--- a/http-backend.c
+++ b/http-backend.c
@@ -97,7 +97,7 @@ static void hdr_int(struct strbuf *hdr, const char *name, uintmax_t value)
 
 static void hdr_date(struct strbuf *hdr, const char *name, timestamp_t when)
 {
-	const char *value = show_date(when, 0, DATE_MODE(RFC2822));
+	const char *value = show_date(when, 0, NULL, DATE_MODE(RFC2822));
 	hdr_str(hdr, name, value);
 }
 
diff --git a/pretty.c b/pretty.c
index 7a7708a0ea..9b86e4ec12 100644
--- a/pretty.c
+++ b/pretty.c
@@ -416,6 +416,7 @@ const char *show_ident_date(const struct ident_split *ident,
 {
 	timestamp_t date = 0;
 	long tz = 0;
+        int sign = '+';
 
 	if (ident->date_begin && ident->date_end)
 		date = parse_timestamp(ident->date_begin, NULL, 10);
@@ -426,8 +427,11 @@ const char *show_ident_date(const struct ident_split *ident,
 			tz = strtol(ident->tz_begin, NULL, 10);
 		if (tz >= INT_MAX || tz <= INT_MIN)
 			tz = 0;
+                else if (!tz && ident->tz_begin &&
+                         (*ident->tz_begin) == '-')
+                        sign = '-';
 	}
-	return show_date(date, tz, mode);
+	return show_date(date, tz, &sign, mode);
 }
 
 void pp_user_info(struct pretty_print_context *pp,
diff --git a/ref-filter.c b/ref-filter.c
index c62f6b4822..85bf338c99 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -1136,7 +1136,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 	tz = strtol(zone, NULL, 10);
 	if ((tz == LONG_MIN || tz == LONG_MAX) && errno == ERANGE)
 		goto bad;
-	v->s = xstrdup(show_date(timestamp, tz, &date_mode));
+	v->s = xstrdup(show_date(timestamp, tz, NULL, &date_mode));
 	v->value = timestamp;
 	return;
  bad:
diff --git a/reflog-walk.c b/reflog-walk.c
index 3a25b27d8f..2a9c7cadad 100644
--- a/reflog-walk.c
+++ b/reflog-walk.c
@@ -224,7 +224,7 @@ void get_reflog_selector(struct strbuf *sb,
 	if (commit_reflog->selector == SELECTOR_DATE ||
 	    (commit_reflog->selector == SELECTOR_NONE && force_date)) {
 		info = &commit_reflog->reflogs->items[commit_reflog->recno+1];
-		strbuf_addstr(sb, show_date(info->timestamp, info->tz, dmode));
+		strbuf_addstr(sb, show_date(info->timestamp, info->tz, NULL, dmode));
 	} else {
 		strbuf_addf(sb, "%d", commit_reflog->reflogs->nr
 			    - 2 - commit_reflog->recno);
diff --git a/refs.c b/refs.c
index fa01153151..6cb056a2d1 100644
--- a/refs.c
+++ b/refs.c
@@ -890,13 +890,15 @@ static int read_ref_at_ent(struct object_id *ooid, struct object_id *noid,
 			oidcpy(cb->oid, noid);
 			if (!oideq(&cb->ooid, noid))
 				warning(_("log for ref %s has gap after %s"),
-					cb->refname, show_date(cb->date, cb->tz, DATE_MODE(RFC2822)));
+					cb->refname, 
+                                        show_date(cb->date, cb->tz,
+                                                  NULL, DATE_MODE(RFC2822)));
 		}
 		else if (cb->date == cb->at_time)
 			oidcpy(cb->oid, noid);
 		else if (!oideq(noid, cb->oid))
 			warning(_("log for ref %s unexpectedly ended on %s"),
-				cb->refname, show_date(cb->date, cb->tz,
+				cb->refname, show_date(cb->date, cb->tz, NULL,
 						       DATE_MODE(RFC2822)));
 		oidcpy(&cb->ooid, ooid);
 		oidcpy(&cb->noid, noid);
diff --git a/sha1-name.c b/sha1-name.c
index 0b23b86ceb..9362c20803 100644
--- a/sha1-name.c
+++ b/sha1-name.c
@@ -915,7 +915,7 @@ static int get_oid_basic(struct repository *r, const char *str, int len,
 				if (!(flags & GET_OID_QUIETLY)) {
 					warning(_("log for '%.*s' only goes back to %s"),
 						len, str,
-						show_date(co_time, co_tz, DATE_MODE(RFC2822)));
+						show_date(co_time, co_tz, NULL, DATE_MODE(RFC2822)));
 				}
 			} else {
 				if (flags & GET_OID_QUIETLY) {
diff --git a/t/helper/test-date.c b/t/helper/test-date.c
index 099eff4f0f..cf8d4574b7 100644
--- a/t/helper/test-date.c
+++ b/t/helper/test-date.c
@@ -28,7 +28,7 @@ static void show_human_dates(const char **argv)
 {
 	for (; *argv; argv++) {
 		time_t t = atoi(*argv);
-		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(HUMAN)));
+		printf("%s -> %s\n", *argv, show_date(t, 0, NULL, DATE_MODE(HUMAN)));
 	}
 }
 
@@ -51,7 +51,7 @@ static void show_dates(const char **argv, const char *format)
 			arg++;
 		tz = atoi(arg);
 
-		printf("%s -> %s\n", *argv, show_date(t, tz, &mode));
+		printf("%s -> %s\n", *argv, show_date(t, tz, NULL, &mode));
 	}
 }
 
@@ -67,7 +67,7 @@ static void parse_dates(const char **argv)
 		parse_date(*argv, &result);
 		if (sscanf(result.buf, "%"PRItime" %d", &t, &tz) == 2)
 			printf("%s -> %s\n",
-			       *argv, show_date(t, tz, DATE_MODE(ISO8601)));
+			       *argv, show_date(t, tz, NULL, DATE_MODE(ISO8601)));
 		else
 			printf("%s -> bad\n", *argv);
 	}
@@ -79,7 +79,7 @@ static void parse_approxidate(const char **argv)
 	for (; *argv; argv++) {
 		timestamp_t t;
 		t = approxidate_relative(*argv);
-		printf("%s -> %s\n", *argv, show_date(t, 0, DATE_MODE(ISO8601)));
+		printf("%s -> %s\n", *argv, show_date(t, 0, NULL, DATE_MODE(ISO8601)));
 	}
 }
 
diff --git a/t/t7514-commit-patch.sh b/t/t7514-commit-patch.sh
index 998a2103c7..3ba1ff4f81 100755
--- a/t/t7514-commit-patch.sh
+++ b/t/t7514-commit-patch.sh
@@ -31,4 +31,13 @@ test_expect_success 'edit hunk "commit --dry-run -p -m message"' '
 	test -r editor_was_started
 '
 
+test_expect_success 'commit date shows timezone offset -0000 when no-record-time-zone is specified' '
+        echo test >>file &&
+        git add file &&
+        TZ=UTC-09 git commit --date=@1600000000 -m "test" --no-record-time-zone &&
+        git show -s --format='%aI' >output &&
+        echo 2020-09-13T12:26:40-00:00 >expect &&
+        test_cmp output expect
+'
+
 test_done
-- 
2.28.0.1011.ga647a8990f-goog

