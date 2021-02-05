Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30FBBC433E0
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:29:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B70A64FEE
	for <git@archiver.kernel.org>; Fri,  5 Feb 2021 22:29:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhBEW3C (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Feb 2021 17:29:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbhBEOWu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Feb 2021 09:22:50 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8208C061A29
        for <git@vger.kernel.org>; Fri,  5 Feb 2021 07:50:07 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id f16so6384254wmq.5
        for <git@vger.kernel.org>; Fri, 05 Feb 2021 07:50:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=SetI9u2aCQMvY5R8rvY72StXJrn3+wWQEZIDz7SL8gM=;
        b=UkRMHIiFukj9ufYe4OLPvn8Whz+589ErDCC2HhSQtvRa5KRm1NNBboKfa+vFaDF6qn
         7bsifyevqiLTj7JSiTlEyOUK9i7MsZ8yzbfHf6zvPb0yreeermF4hkuyAjUAzAO9U2Z1
         3J1Zr2cqE9bXTMVQuoXSSWoFn50tRIrfGi0MsRTYhSfsebXVEtfFgUTIwzzJwCuwG8Fs
         HOfVxknWwNKPBGIjnNuQLh7p4QJSv+ZGsrcWEiDdlPDU1cIJ9SKXaiCPW3j7GMKwV/59
         60Fk/Dcs+Gpg31FLIQS2iFE8Fbdy2KxgosEUC/QUSKnC++KQHNTdxLcozFb7j+0peF6E
         om8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=SetI9u2aCQMvY5R8rvY72StXJrn3+wWQEZIDz7SL8gM=;
        b=qYh/0zi7RFVzxGjSa99j/gos2etzcA61w8L4DMIgPGlnKBOrlPnHTt2IrLPT+Jfkmm
         cnZ7D76m47bwOYzVKN+7m1vHwgJYkhb1T3M3UpsTF5CeqKyljKkU52UJlVE6yE5NTI1r
         wcD+stIZp83XqwFVVlsrL/GhVDFtSNkuEGy2bfd8U9pdMrBGXBYCuINCn6EtrmZU5M+N
         OizrmsQa+a5P+yfTFH46YNWY/H+ekiVUxo99KqRMvYpapJWZ7P7Xswwc9DodVe6ENTw/
         1y7qjTAOij4CaSQP4ejnoOMJt2ExxFJ8GArh/liC46Tw6mMopqQWSfI9jgb2uuff0SFA
         373w==
X-Gm-Message-State: AOAM532rMnKon5DuCqRoIqk2OsZKpxfpUgSLKPHiFlyue0JoSD61LJm2
        iqZL/LF6TZpe3iMel382vIuk+/XU8kI=
X-Google-Smtp-Source: ABdhPJw6j53QwE7nY5JqIALdRoDImijE/3ahm+bIPQ6IHs7e59cXdJPQdH5R+ocRv+XY2JofsaGmKg==
X-Received: by 2002:a1c:7f93:: with SMTP id a141mr3921945wmd.105.1612536378394;
        Fri, 05 Feb 2021 06:46:18 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm11613060wre.78.2021.02.05.06.46.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Feb 2021 06:46:17 -0800 (PST)
Message-Id: <7367eadfe2430fbcd60e7b7abf7cb432488b9c39.1612536373.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
        <pull.869.v2.git.1612536373.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Feb 2021 14:46:11 +0000
Subject: [PATCH v2 4/6] range-diff: combine all options in a single data
 structure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

This will make it easier to implement the `--left-only` and
`--right-only` options.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 builtin/log.c        | 10 ++++++++--
 builtin/range-diff.c | 13 +++++++++----
 log-tree.c           |  8 ++++++--
 range-diff.c         | 18 +++++++++---------
 range-diff.h         | 16 ++++++++++------
 5 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 91466c059c79..a06e5385689b 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1231,14 +1231,20 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 		 */
 		struct diff_options opts;
 		struct strvec other_arg = STRVEC_INIT;
+		struct range_diff_options range_diff_opts = {
+			.creation_factor = rev->creation_factor,
+			.dual_color = 1,
+			.diffopt = &opts,
+			.other_arg = &other_arg
+		};
+
 		diff_setup(&opts);
 		opts.file = rev->diffopt.file;
 		opts.use_color = rev->diffopt.use_color;
 		diff_setup_done(&opts);
 		fprintf_ln(rev->diffopt.file, "%s", rev->rdiff_title);
 		get_notes_args(&other_arg, rev);
-		show_range_diff(rev->rdiff1, rev->rdiff2,
-				rev->creation_factor, 1, &opts, &other_arg);
+		show_range_diff(rev->rdiff1, rev->rdiff2, &range_diff_opts);
 		strvec_clear(&other_arg);
 	}
 }
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 5b1f6326322f..80fcdc6ad42d 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -14,12 +14,17 @@ NULL
 
 int cmd_range_diff(int argc, const char **argv, const char *prefix)
 {
-	int creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	struct diff_options diffopt = { NULL };
 	struct strvec other_arg = STRVEC_INIT;
+	struct range_diff_options range_diff_opts = {
+		.creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT,
+		.diffopt = &diffopt,
+		.other_arg = &other_arg
+	};
 	int simple_color = -1;
 	struct option range_diff_options[] = {
-		OPT_INTEGER(0, "creation-factor", &creation_factor,
+		OPT_INTEGER(0, "creation-factor",
+			    &range_diff_opts.creation_factor,
 			    N_("Percentage by which creation is weighted")),
 		OPT_BOOL(0, "no-dual-color", &simple_color,
 			    N_("use simple diff colors")),
@@ -82,8 +87,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	}
 	FREE_AND_NULL(options);
 
-	res = show_range_diff(range1.buf, range2.buf, creation_factor,
-			      simple_color < 1, &diffopt, &other_arg);
+	range_diff_opts.dual_color = simple_color < 1;
+	res = show_range_diff(range1.buf, range2.buf, &range_diff_opts);
 
 	strvec_clear(&other_arg);
 	strbuf_release(&range1);
diff --git a/log-tree.c b/log-tree.c
index fd0dde97ec32..eeacba15dc94 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -808,6 +808,11 @@ void show_log(struct rev_info *opt)
 	if (cmit_fmt_is_mail(ctx.fmt) && opt->rdiff1) {
 		struct diff_queue_struct dq;
 		struct diff_options opts;
+		struct range_diff_options range_diff_opts = {
+			.creation_factor = opt->creation_factor,
+			.dual_color = 1,
+			.diffopt = &opts
+		};
 
 		memcpy(&dq, &diff_queued_diff, sizeof(diff_queued_diff));
 		DIFF_QUEUE_CLEAR(&diff_queued_diff);
@@ -822,8 +827,7 @@ void show_log(struct rev_info *opt)
 		opts.file = opt->diffopt.file;
 		opts.use_color = opt->diffopt.use_color;
 		diff_setup_done(&opts);
-		show_range_diff(opt->rdiff1, opt->rdiff2,
-				opt->creation_factor, 1, &opts, NULL);
+		show_range_diff(opt->rdiff1, opt->rdiff2, &range_diff_opts);
 
 		memcpy(&diff_queued_diff, &dq, sizeof(diff_queued_diff));
 	}
diff --git a/range-diff.c b/range-diff.c
index d0d941a25add..25d4c244799c 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -526,33 +526,32 @@ static struct strbuf *output_prefix_cb(struct diff_options *opt, void *data)
 }
 
 int show_range_diff(const char *range1, const char *range2,
-		    int creation_factor, int dual_color,
-		    const struct diff_options *diffopt,
-		    const struct strvec *other_arg)
+		    struct range_diff_options *range_diff_opts)
 {
 	int res = 0;
 
 	struct string_list branch1 = STRING_LIST_INIT_DUP;
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
-	if (read_patches(range1, &branch1, other_arg))
+	if (read_patches(range1, &branch1, range_diff_opts->other_arg))
 		res = error(_("could not parse log for '%s'"), range1);
-	if (!res && read_patches(range2, &branch2, other_arg))
+	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg))
 		res = error(_("could not parse log for '%s'"), range2);
 
 	if (!res) {
 		struct diff_options opts;
 		struct strbuf indent = STRBUF_INIT;
 
-		if (diffopt)
-			memcpy(&opts, diffopt, sizeof(opts));
+		if (range_diff_opts->diffopt)
+			memcpy(&opts, range_diff_opts->diffopt, sizeof(opts));
 		else
 			diff_setup(&opts);
 
 		if (!opts.output_format)
 			opts.output_format = DIFF_FORMAT_PATCH;
 		opts.flags.suppress_diff_headers = 1;
-		opts.flags.dual_color_diffed_diffs = dual_color;
+		opts.flags.dual_color_diffed_diffs =
+			range_diff_opts->dual_color;
 		opts.flags.suppress_hunk_header_line_count = 1;
 		opts.output_prefix = output_prefix_cb;
 		strbuf_addstr(&indent, "    ");
@@ -560,7 +559,8 @@ int show_range_diff(const char *range1, const char *range2,
 		diff_setup_done(&opts);
 
 		find_exact_matches(&branch1, &branch2);
-		get_correspondences(&branch1, &branch2, creation_factor);
+		get_correspondences(&branch1, &branch2,
+				    range_diff_opts->creation_factor);
 		output(&branch1, &branch2, &opts);
 
 		strbuf_release(&indent);
diff --git a/range-diff.h b/range-diff.h
index 4abd70c40fed..a595f4e8db2d 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -6,15 +6,19 @@
 
 #define RANGE_DIFF_CREATION_FACTOR_DEFAULT 60
 
+struct range_diff_options {
+	int creation_factor;
+	unsigned dual_color:1;
+	const struct diff_options *diffopt; /* may be NULL */
+	const struct strvec *other_arg; /* may be NULL */
+};
+
 /*
- * Compare series of commits in RANGE1 and RANGE2, and emit to the
- * standard output.  NULL can be passed to DIFFOPT to use the built-in
- * default.
+ * Compare series of commits in `range1` and `range2`, and emit to the
+ * standard output.
  */
 int show_range_diff(const char *range1, const char *range2,
-		    int creation_factor, int dual_color,
-		    const struct diff_options *diffopt,
-		    const struct strvec *other_arg);
+		    struct range_diff_options *opts);
 
 /*
  * Determine whether the given argument is usable as a range argument of `git
-- 
gitgitgadget

