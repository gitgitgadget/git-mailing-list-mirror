Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F3B9C636CC
	for <git@archiver.kernel.org>; Sun,  5 Feb 2023 03:46:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjBEDq1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Feb 2023 22:46:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjBEDq0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Feb 2023 22:46:26 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289EB1C5A5
        for <git@vger.kernel.org>; Sat,  4 Feb 2023 19:46:25 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id o18so7714374wrj.3
        for <git@vger.kernel.org>; Sat, 04 Feb 2023 19:46:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjnipgRy3r/tiLab8yFZsZlkSBGIpNzSs/aai2VJvy0=;
        b=cucyWDAeuExvzIzwvUhdpkTtpVNFCs6GjxkjloSSSzPQGvEuXc3njRb44N5Jx8JlvB
         sR9F+97SeoUoy2QuE74tN3n+x1/JAOa3QoFqWwOiWn0cevZU3Wu5xdAkBlghlnKGKILu
         S2KtH8ZMIRcPc9efuFypyOwDbAlWlaVQW57bNZcxiBbKCgu3++BrlRtADJqxnc9WBd+n
         b/wKrL5lCOla/Oo1l6KUgg9wRtxPLkvjNPT8BkpbrApvUOUa/rCP4dE1r2HCrgpNHiOx
         I8HKnOAvr9u49cCYEeI1vqDeh+UCSX2nwd0DKBCctElYbEr9Jnt6sl59DAyuiKwyosne
         zj6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjnipgRy3r/tiLab8yFZsZlkSBGIpNzSs/aai2VJvy0=;
        b=KLprVr6UVIubCLC8UW1SI21wWOWkxWz9UBh27DhFlPDcIgnD8tuuSctsMWD4/M+uaY
         4+cUGFSShIgCyXHJmM6FgX5qvb5OuOVsn8YbAi7uW8J+NYHYu+30ZBeyX440AhnDprBX
         G10o4SDx/7UzQ3v/QCjWPlhL6AQLI2LFN8HJV+Na+rz9ArkSg/Sk3L6DXqMqD0VF800B
         aKopYL4Vv0FTG5WsOedVBkcHXRd0ZzimFhpbHCQcU1JUiwS8e1BvT5tsG5WzR7VNN4QQ
         4nHayMvyaqlCeyELnWHy0qpf86zO5E23bh+Hc7WJEP49C2vzi+0xG5ONB3x6CeXxwgHQ
         cWWA==
X-Gm-Message-State: AO0yUKWXjCgHhx57aDYD9Gm0x/bfbDyIrI2XlaG0KuUJUQZRQ905p6mR
        j7G3tz8rtDgvSdx97QTjFL7HA5uIEQk=
X-Google-Smtp-Source: AK7set8aOBwhM/9CrD0e4XUfxSX+5EjUuyCKM+Yn8HfliP/2RhJ7ZG1HJkt7Xi9+uqHiORK3LBOxiw==
X-Received: by 2002:a05:6000:10c3:b0:2bf:b113:8ae2 with SMTP id b3-20020a05600010c300b002bfb1138ae2mr15457033wrx.15.1675568783512;
        Sat, 04 Feb 2023 19:46:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i6-20020a0560001ac600b00241fde8fe04sm6063029wry.7.2023.02.04.19.46.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 19:46:23 -0800 (PST)
Message-Id: <f56bd38ac3f80fb3a7e8c92cadaa57d2b0754b9f.1675568781.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
References: <pull.1452.git.git.1675568781.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 05 Feb 2023 03:46:20 +0000
Subject: [PATCH 1/2] diff: consolidate diff algorithm option parsing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>, John Cai <jcai@gitlab.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <jcai@gitlab.com>

The diff option parsing for --minimal, --patience, --histgoram can all
be consolidated into one function. This is a preparatory step for the
subsequent commit which teaches diff to keep track of whether or not a
diff algorithm has been set via the command line.

While we're at it, the logic that sets the diff algorithm in
diff_opt_diff_algorithm() can be refactored into a helper that will
allow multiple callsites to set the diff algorithm.

Signed-off-by: John Cai <johncai86@gmail.com>
---
 diff.c | 87 ++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 54 insertions(+), 33 deletions(-)

diff --git a/diff.c b/diff.c
index 329eebf16a0..a8a31c81fe7 100644
--- a/diff.c
+++ b/diff.c
@@ -3437,6 +3437,22 @@ static int diff_filepair_is_phoney(struct diff_filespec *one,
 	return !DIFF_FILE_VALID(one) && !DIFF_FILE_VALID(two);
 }
 
+static int set_diff_algorithm(struct diff_options *opts,
+			      const char *alg)
+{
+	long value = parse_algorithm_value(alg);
+
+	if (value < 0)
+		return 1;
+
+	/* clear out previous settings */
+	DIFF_XDL_CLR(opts, NEED_MINIMAL);
+	opts->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
+	opts->xdl_opts |= value;
+
+	return 0;
+}
+
 static void builtin_diff(const char *name_a,
 			 const char *name_b,
 			 struct diff_filespec *one,
@@ -5107,17 +5123,40 @@ static int diff_opt_diff_algorithm(const struct option *opt,
 				   const char *arg, int unset)
 {
 	struct diff_options *options = opt->value;
-	long value = parse_algorithm_value(arg);
 
 	BUG_ON_OPT_NEG(unset);
-	if (value < 0)
+
+	if (set_diff_algorithm(options, arg))
 		return error(_("option diff-algorithm accepts \"myers\", "
 			       "\"minimal\", \"patience\" and \"histogram\""));
 
-	/* clear out previous settings */
-	DIFF_XDL_CLR(options, NEED_MINIMAL);
-	options->xdl_opts &= ~XDF_DIFF_ALGORITHM_MASK;
-	options->xdl_opts |= value;
+	return 0;
+}
+
+static int diff_opt_diff_algorithm_no_arg(const struct option *opt,
+				   const char *arg, int unset)
+{
+	struct diff_options *options = opt->value;
+
+	BUG_ON_OPT_NEG(unset);
+	BUG_ON_OPT_ARG(arg);
+
+	if (!strcmp(opt->long_name, "patience")) {
+		int i;
+		/*
+		 * Both --patience and --anchored use PATIENCE_DIFF
+		 * internally, so remove any anchors previously
+		 * specified.
+		 */
+		for (i = 0; i < options->anchors_nr; i++)
+			free(options->anchors[i]);
+		options->anchors_nr = 0;
+	}
+
+	if (set_diff_algorithm(options, opt->long_name))
+		return error(_("available diff algorithms include \"myers\", "
+			       "\"minimal\", \"patience\" and \"histogram\""));
+
 	return 0;
 }
 
@@ -5242,26 +5281,6 @@ static enum parse_opt_result diff_opt_output(struct parse_opt_ctx_t *ctx,
 	return 0;
 }
 
-static int diff_opt_patience(const struct option *opt,
-			     const char *arg, int unset)
-{
-	struct diff_options *options = opt->value;
-	int i;
-
-	BUG_ON_OPT_NEG(unset);
-	BUG_ON_OPT_ARG(arg);
-	options->xdl_opts = DIFF_WITH_ALG(options, PATIENCE_DIFF);
-	/*
-	 * Both --patience and --anchored use PATIENCE_DIFF
-	 * internally, so remove any anchors previously
-	 * specified.
-	 */
-	for (i = 0; i < options->anchors_nr; i++)
-		free(options->anchors[i]);
-	options->anchors_nr = 0;
-	return 0;
-}
-
 static int diff_opt_ignore_regex(const struct option *opt,
 				 const char *arg, int unset)
 {
@@ -5562,9 +5581,10 @@ struct option *add_diff_options(const struct option *opts,
 			    N_("prevent rename/copy detection if the number of rename/copy targets exceeds given limit")),
 
 		OPT_GROUP(N_("Diff algorithm options")),
-		OPT_BIT(0, "minimal", &options->xdl_opts,
-			N_("produce the smallest possible diff"),
-			XDF_NEED_MINIMAL),
+		OPT_CALLBACK_F(0, "minimal", options, NULL,
+			       N_("produce the smallest possible diff"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_diff_algorithm_no_arg),
 		OPT_BIT_F('w', "ignore-all-space", &options->xdl_opts,
 			  N_("ignore whitespace when comparing lines"),
 			  XDF_IGNORE_WHITESPACE, PARSE_OPT_NONEG),
@@ -5589,10 +5609,11 @@ struct option *add_diff_options(const struct option *opts,
 		OPT_CALLBACK_F(0, "patience", options, NULL,
 			       N_("generate diff using the \"patience diff\" algorithm"),
 			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
-			       diff_opt_patience),
-		OPT_BITOP(0, "histogram", &options->xdl_opts,
-			  N_("generate diff using the \"histogram diff\" algorithm"),
-			  XDF_HISTOGRAM_DIFF, XDF_DIFF_ALGORITHM_MASK),
+			       diff_opt_diff_algorithm_no_arg),
+		OPT_CALLBACK_F(0, "histogram", options, NULL,
+			       N_("generate diff using the \"histogram diff\" algorithm"),
+			       PARSE_OPT_NONEG | PARSE_OPT_NOARG,
+			       diff_opt_diff_algorithm_no_arg),
 		OPT_CALLBACK_F(0, "diff-algorithm", options, N_("<algorithm>"),
 			       N_("choose a diff algorithm"),
 			       PARSE_OPT_NONEG, diff_opt_diff_algorithm),
-- 
gitgitgadget

