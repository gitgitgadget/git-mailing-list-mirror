Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9DC5320984
	for <e@80x24.org>; Sun, 11 Sep 2016 05:42:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755539AbcIKFmt (ORCPT <rfc822;e@80x24.org>);
        Sun, 11 Sep 2016 01:42:49 -0400
Received: from mail-pa0-f68.google.com ([209.85.220.68]:33538 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752735AbcIKFmq (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Sep 2016 01:42:46 -0400
Received: by mail-pa0-f68.google.com with SMTP id h5so6030778pao.0
        for <git@vger.kernel.org>; Sat, 10 Sep 2016 22:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QkYvZg7WOrima8W0dfprrUUfU2ymOXnLmOAehq6NpgM=;
        b=qpntit3CFPY4JxP0zVD+Rt5jnbWUTwVkQtjikrZ7mmpv8Gpih9Qsd2E8Cs9Gj7Yv/H
         zH4Dkp8xpBejKVHen3nYKaCvCtzu1y5v8uuRUs71T0DfOAhgHjpFua5lEA24IcnIJyXL
         4BCz2DAjHqSzii8/tdnuobpW1msS+pLSnZoxh77dBV+lHZNrZUhKLTOyaoNbJ3WX0vER
         uaJWZWGmjXspNxmaVUs2SCFfVoHAR6ZE/BWpmVtYW7mvnKU13tlq4Vw/qN8VWIRK1W2L
         p1p7sCz5iKH6//kG1a0ZX3CP5O7kguldDq0CZYumJShZGsrq3lVWOui0504zUt4GgO6e
         ODgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QkYvZg7WOrima8W0dfprrUUfU2ymOXnLmOAehq6NpgM=;
        b=TV0pKQuZWfT0I5PKPPaYc48rxBakbOm/rqhot1hoY5OSO32e76yHJSSgv0f4INgXLm
         GmDvEc7vd4ruxC882MrnVJ+1JCHfb1qHwowzMKD41dO8lzKYn1IDIgFq5/xK6UC/e34H
         lOJIlNQZ23QQQ1iNhIN7MBVcLSbe6xFD3tCUlf1DkfhNM77lxV5JY5eANrOY+gepLJjf
         xV2MKB+J7VznEUvgQ5f4dy/tzb2QI2FYk6vloleQGDpE0mLeb2jlBLTGdeo53zmhbx2H
         ee3avVK2NxLdeSjp4cbXw5vw/xskhvlAvNjbq5lrw+/gwq4GfTOXt74VPjAo3uUJ/i1n
         S/hw==
X-Gm-Message-State: AE9vXwNgOmy0Ofar4q8QpoPtpG1Gx4m109UYWpLsJxTqM9xyHEbNcD6JM8qkTS4L06g0Kw==
X-Received: by 10.66.229.9 with SMTP id sm9mr21506003pac.138.1473572565121;
        Sat, 10 Sep 2016 22:42:45 -0700 (PDT)
Received: from localhost (c-67-188-214-183.hsd1.ca.comcast.net. [67.188.214.183])
        by smtp.gmail.com with ESMTPSA id m5sm15493716paw.40.2016.09.10.22.42.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 10 Sep 2016 22:42:44 -0700 (PDT)
From:   Stefan Beller <stefanbeller@gmail.com>
To:     gitster@pobox.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 10/10] submodule.c: convert show_submodule_summary to use emit_line_fmt
Date:   Sat, 10 Sep 2016 22:42:10 -0700
Message-Id: <1473572530-25764-11-git-send-email-stefanbeller@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
References: <1473572530-25764-1-git-send-email-stefanbeller@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Stefan Beller <sbeller@google.com>

---
 diff.c      |  5 ++---
 diff.h      |  3 +++
 submodule.c | 42 +++++++++++++++++-------------------------
 submodule.h |  3 +--
 4 files changed, 23 insertions(+), 30 deletions(-)

diff --git a/diff.c b/diff.c
index 255fbf3..c00306b 100644
--- a/diff.c
+++ b/diff.c
@@ -493,7 +493,7 @@ static void emit_line(struct diff_options *o, const char *set, const char *reset
 	emit_line_0(o, set, reset, line[0], line+1, len-1);
 }
 
-static void emit_line_fmt(struct diff_options *o,
+void emit_line_fmt(struct diff_options *o,
 			  const char *set, const char *reset,
 			  const char *fmt, ...)
 {
@@ -2310,8 +2310,7 @@ static void builtin_diff(const char *name_a,
 			(!two->mode || S_ISGITLINK(two->mode))) {
 		const char *del = diff_get_color_opt(o, DIFF_FILE_OLD);
 		const char *add = diff_get_color_opt(o, DIFF_FILE_NEW);
-		show_submodule_summary(o->file, one->path ? one->path : two->path,
-				line_prefix,
+		show_submodule_summary(o, one->path ? one->path : two->path,
 				one->oid.hash, two->oid.hash,
 				two->dirty_submodule,
 				meta, del, add, reset);
diff --git a/diff.h b/diff.h
index 7883729..1699d9c 100644
--- a/diff.h
+++ b/diff.h
@@ -180,6 +180,9 @@ struct diff_options {
 	int diff_path_counter;
 };
 
+void emit_line_fmt(struct diff_options *o, const char *set, const char *reset,
+		   const char *fmt, ...);
+
 enum color_diff {
 	DIFF_RESET = 0,
 	DIFF_CONTEXT = 1,
diff --git a/submodule.c b/submodule.c
index 1b5cdfb..c817b46 100644
--- a/submodule.c
+++ b/submodule.c
@@ -304,8 +304,8 @@ static int prepare_submodule_summary(struct rev_info *rev, const char *path,
 	return prepare_revision_walk(rev);
 }
 
-static void print_submodule_summary(struct rev_info *rev, FILE *f,
-		const char *line_prefix,
+static void print_submodule_summary(struct rev_info *rev,
+		struct diff_options *o,
 		const char *del, const char *add, const char *reset)
 {
 	static const char format[] = "  %m %s";
@@ -317,24 +317,16 @@ static void print_submodule_summary(struct rev_info *rev, FILE *f,
 		ctx.date_mode = rev->date_mode;
 		ctx.output_encoding = get_log_output_encoding();
 		strbuf_setlen(&sb, 0);
-		strbuf_addstr(&sb, line_prefix);
-		if (commit->object.flags & SYMMETRIC_LEFT) {
-			if (del)
-				strbuf_addstr(&sb, del);
-		}
-		else if (add)
-			strbuf_addstr(&sb, add);
 		format_commit_message(commit, format, &sb, &ctx);
-		if (reset)
-			strbuf_addstr(&sb, reset);
-		strbuf_addch(&sb, '\n');
-		fprintf(f, "%s", sb.buf);
+		if (commit->object.flags & SYMMETRIC_LEFT)
+			emit_line_fmt(o, del, reset, "%s\n", sb.buf);
+		else if (add)
+			emit_line_fmt(o, add, reset, "%s\n", sb.buf);
 	}
 	strbuf_release(&sb);
 }
 
-void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_summary(struct diff_options *o, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset)
@@ -359,30 +351,30 @@ void show_submodule_summary(FILE *f, const char *path,
 		message = "(revision walker failed)";
 
 	if (dirty_submodule & DIRTY_SUBMODULE_UNTRACKED)
-		fprintf(f, "%sSubmodule %s contains untracked content\n",
-			line_prefix, path);
+		emit_line_fmt(o, 0, 0,
+			      "Submodule %s contains untracked content\n", path);
 	if (dirty_submodule & DIRTY_SUBMODULE_MODIFIED)
-		fprintf(f, "%sSubmodule %s contains modified content\n",
-			line_prefix, path);
+		emit_line_fmt(o, 0, 0,
+			      "Submodule %s contains modified content\n", path);
 
 	if (!hashcmp(one, two)) {
 		strbuf_release(&sb);
 		return;
 	}
 
-	strbuf_addf(&sb, "%s%sSubmodule %s %s..", line_prefix, meta, path,
-			find_unique_abbrev(one, DEFAULT_ABBREV));
+	strbuf_addf(&sb, "Submodule %s %s..", path,
+		    find_unique_abbrev(one, DEFAULT_ABBREV));
 	if (!fast_backward && !fast_forward)
 		strbuf_addch(&sb, '.');
 	strbuf_addf(&sb, "%s", find_unique_abbrev(two, DEFAULT_ABBREV));
 	if (message)
-		strbuf_addf(&sb, " %s%s\n", message, reset);
+		strbuf_addf(&sb, " %s\n", message);
 	else
-		strbuf_addf(&sb, "%s:%s\n", fast_backward ? " (rewind)" : "", reset);
-	fwrite(sb.buf, sb.len, 1, f);
+		strbuf_addf(&sb, "%s:\n", fast_backward ? " (rewind)" : "");
+	emit_line_fmt(o, meta, reset, "%s", sb.buf);
 
 	if (!message) /* only NULL if we succeeded in setting up the walk */
-		print_submodule_summary(&rev, f, line_prefix, del, add, reset);
+		print_submodule_summary(&rev, o, del, add, reset);
 	if (left)
 		clear_commit_marks(left, ~0);
 	if (right)
diff --git a/submodule.h b/submodule.h
index 2af9390..fefc0ab 100644
--- a/submodule.h
+++ b/submodule.h
@@ -41,8 +41,7 @@ int parse_submodule_update_strategy(const char *value,
 		struct submodule_update_strategy *dst);
 const char *submodule_strategy_to_string(const struct submodule_update_strategy *s);
 void handle_ignore_submodules_arg(struct diff_options *diffopt, const char *);
-void show_submodule_summary(FILE *f, const char *path,
-		const char *line_prefix,
+void show_submodule_summary(struct diff_options *o, const char *path,
 		unsigned char one[20], unsigned char two[20],
 		unsigned dirty_submodule, const char *meta,
 		const char *del, const char *add, const char *reset);
-- 
2.7.4

