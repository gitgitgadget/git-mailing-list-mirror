Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 355051F597
	for <e@80x24.org>; Sun, 22 Jul 2018 09:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbeGVKyO (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 06:54:14 -0400
Received: from mail-io0-f194.google.com ([209.85.223.194]:37278 "EHLO
        mail-io0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728533AbeGVKyN (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 06:54:13 -0400
Received: by mail-io0-f194.google.com with SMTP id z19-v6so13246224ioh.4
        for <git@vger.kernel.org>; Sun, 22 Jul 2018 02:58:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=l1NTa51VfN5u1oQ3kLs+ABkdHQaQAP1GJtNdg4zENfE=;
        b=PXRlmULQ5WQm6vLk2Vu43EhdbfW1XyA/OPeYn6Ga59UVaS+CIIEavM3crLK8SXI7ul
         YRmNJcSP/4AfqC4l1jtUPqipzX64kn7VkJIYqCOsYyshJ/wA3UBVqB817g9YlX7rfbav
         H6dBWsQrzq7n56B9JIAM0MrV9DgKh+Jz7gi10HH1hP8fSFcCtlp0Mw0WLlH//qofKvX/
         TwNubISxQTZu0hOvmb+AdMt+4JOCFFdJV2jomm8voBV92WTr3RVzHqzUY0DbQO4xD7AU
         ZZ/FjqPQ0hhELeuRDRqtdC599kEY2vo5kIsL39KhzU4cRqROavYynbhSs8pTlTiZjyc5
         yJ9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=l1NTa51VfN5u1oQ3kLs+ABkdHQaQAP1GJtNdg4zENfE=;
        b=uAnMcTr87Mc7uZBrIzzz9tba4mV27olwPdtLUGskcbDrbZhAxWLY9/u7Zj5lgr2tx2
         IBkyOVoQBQoxV8xGp5kvWM9jS7CeuNrVWFOnKP5j0ykdnw8Y120WcNrBLXQkdKuI1DoJ
         SUj5eN2BlAobgOuqtTBjR9zYCgT4hFck76bmUhuk7CiE32fxCHm/GS7PfGLUEEOprsfL
         gNIcZI9jDbaFd+uZRglXfmlo5DaZoikRnAZynDvq2j7Q/4FCDSotwqp8Gb/LWV1Fv/oG
         e77ipa/IdjehrTEwpR5xYHFpTYx2ZfAY1M6IK5wkoGt4e85drPhKNV/Wefy9FTshTS9S
         Kmhg==
X-Gm-Message-State: AOUpUlFpR1DNrlZspyieBzR1lA0Jax2sFkIHbBEhbBvI2k4j0F7NhIgB
        bTfA9Y/SgKZ6eDZ54LFfjTQXkhiW
X-Google-Smtp-Source: AAOMgpc0kXUuFtw6wksn5j5+wEaTzQ+D4BN5uBQZU3uH9o7Hca99ZGmx+Msi+2pEAa7tw3eUXsQkiw==
X-Received: by 2002:a6b:144c:: with SMTP id 73-v6mr6580538iou.218.1532253484142;
        Sun, 22 Jul 2018 02:58:04 -0700 (PDT)
Received: from localhost.localdomain (user-12l2cs3.cable.mindspring.com. [69.81.51.131])
        by smtp.gmail.com with ESMTPSA id w13-v6sm3681298itb.29.2018.07.22.02.58.03
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 22 Jul 2018 02:58:03 -0700 (PDT)
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Duy Nguyen <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Stefan Beller <sbeller@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 09/14] range-diff: relieve callers of low-level configuration burden
Date:   Sun, 22 Jul 2018 05:57:12 -0400
Message-Id: <20180722095717.17912-10-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.18.0.345.g5c9ce644c3
In-Reply-To: <20180722095717.17912-1-sunshine@sunshineco.com>
References: <20180722095717.17912-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

There are a number of very low-level configuration details which need to
be managed precisely to generate a proper range-diff. In particular,
'diff_options' output format, header suppression, indentation, and
dual-color mode must all be set appropriately to ensure proper behavior.

Handle these details locally in the libified range-diff back-end rather
than forcing each caller to have specialized knowledge of these
implementation details, and to avoid duplication as new callers are
added.

While at it, localize these tweaks to be active only while generating
the range-diff, so they don't clobber the caller-provided
'diff_options', which might be used beyond range-diff generation.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 builtin/range-diff.c | 23 ++++-------------------
 range-diff.c         | 24 ++++++++++++++++++++++--
 range-diff.h         |  3 ++-
 3 files changed, 28 insertions(+), 22 deletions(-)

diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index bbe6b05ae9..91463a1df6 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -11,11 +11,6 @@ N_("git range-diff [<options>] <base> <old-tip> <new-tip>"),
 NULL
 };
 
-static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
-{
-	return data;
-}
-
 int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
 	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
@@ -29,17 +24,11 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_END()
 	};
 	int i, j, res = 0;
-	struct strbuf four_spaces = STRBUF_INIT;
 	struct strbuf range1 = STRBUF_INIT, range2 = STRBUF_INIT;
 
 	git_config(git_diff_ui_config, NULL);
 
 	diff_setup(&diffopt);
-	diffopt.output_format = DIFF_FORMAT_PATCH;
-	diffopt.flags.suppress_diff_headers = 1;
-	diffopt.output_prefix = output_prefix_cb;
-	strbuf_addstr(&four_spaces, "    ");
-	diffopt.output_prefix_data = &four_spaces;
 
 	argc = parse_options(argc, argv, NULL, options,
 			     builtin_range_diff_usage, PARSE_OPT_KEEP_UNKNOWN);
@@ -55,12 +44,9 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	argc = j;
 	diff_setup_done(&diffopt);
 
-	if (simple_color < 1) {
-		if (!simple_color)
-			/* force color when --dual-color was used */
-			diffopt.use_color = 1;
-		diffopt.flags.dual_color_diffed_diffs = 1;
-	}
+	/* force color when --dual-color was used */
+	if (!simple_color)
+		diffopt.use_color = 1;
 
 	if (argc == 2) {
 		if (!strstr(argv[0], ".."))
@@ -96,11 +82,10 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	}
 
 	res = show_range_diff(range1.buf, range2.buf, creation_factor,
-			      &diffopt);
+			      simple_color < 1, &diffopt);
 
 	strbuf_release(&range1);
 	strbuf_release(&range2);
-	strbuf_release(&four_spaces);
 
 	return res;
 }
diff --git a/range-diff.c b/range-diff.c
index 76e053c2b2..091fc344cd 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -414,8 +414,14 @@ static void output(struct string_list *a, struct string_list *b,
 	strbuf_release(&dashes);
 }
 
+static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
+{
+	return data;
+}
+
 int show_range_diff(const char *range1, const char *range2,
-		    int creation_factor, struct diff_options *diffopt)
+		    int creation_factor, int dual_color,
+		    struct diff_options *diffopt)
 {
 	int res = 0;
 
@@ -428,9 +434,23 @@ int show_range_diff(const char *range1, const char *range2,
 		res = error(_("could not parse log for '%s'"), range2);
 
 	if (!res) {
+		struct diff_options opts;
+		struct strbuf indent = STRBUF_INIT;
+
+		memcpy(&opts, diffopt, sizeof(opts));
+		opts.output_format = DIFF_FORMAT_PATCH;
+		opts.flags.suppress_diff_headers = 1;
+		opts.flags.dual_color_diffed_diffs = dual_color;
+		opts.output_prefix = output_prefix_cb;
+		strbuf_addstr(&indent, "    ");
+		opts.output_prefix_data = &indent;
+		diff_setup_done(&opts);
+
 		find_exact_matches(&branch1, &branch2);
 		get_correspondences(&branch1, &branch2, creation_factor);
-		output(&branch1, &branch2, diffopt);
+		output(&branch1, &branch2, &opts);
+
+		strbuf_release(&indent);
 	}
 
 	string_list_clear(&branch1, 1);
diff --git a/range-diff.h b/range-diff.h
index 73d6e232fe..bf265594f3 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -6,6 +6,7 @@
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
 
 int show_range_diff(const char *range1, const char *range2,
-		    int creation_factor, struct diff_options *diffopt);
+		    int creation_factor, int dual_color,
+		    struct diff_options *diffopt);
 
 #endif
-- 
2.18.0.345.g5c9ce644c3

