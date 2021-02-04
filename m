Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27342C433DB
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:23:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B340164E0A
	for <git@archiver.kernel.org>; Thu,  4 Feb 2021 20:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240067AbhBDUWk (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Feb 2021 15:22:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240058AbhBDUWh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Feb 2021 15:22:37 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16C63C061794
        for <git@vger.kernel.org>; Thu,  4 Feb 2021 12:08:03 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so5106548wrz.0
        for <git@vger.kernel.org>; Thu, 04 Feb 2021 12:08:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=YtdXnObg3kniJj+YeqqTbm2VP7wZXt7FTIB0shXGuYI=;
        b=gMf+EpwtIAAyNSDDCTEgwqf/BBkqOMD8fY1cG5A4zQajO/HNgwliVNAipybtJNmuHQ
         dZXPsjd5CGse3mNf5ycA/1aiVPl5FduvHspYS5aZLHLinTiIER+55U1RWcTSk5CwO4Fx
         naQCW/vcoq3av34SVP8EKRlE1vVt6jBcyfcreUmO0WuMi0qCbd3TanezG71BHUNXjcvh
         CVwfXXEXmMrX3N0Dcz9VHHq2zxsTuxCQb7pdCGzvDzcN9ZobtJaxcB97/6i7Qcaw/b0G
         Gjh4DYO671OffDI5HxrXayu/SgKVsmOstFysOwNIjLWYYnmG8r2T2JfH4FJ9rqI9eXT8
         kdTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=YtdXnObg3kniJj+YeqqTbm2VP7wZXt7FTIB0shXGuYI=;
        b=mraMXqk5zFwxusTL3MIo3kYIJh5Fi4W3WTvZDAbDc0qDWdelvDeYDwCIfkZpDyX7rj
         G+WmcJIE7wvyv7vtIKa8GfyTBHUBf0LiyHms9WK333CWJwE9p0fVmi6E6i4WkkIdIw6r
         9mxU+VVag8EVBpHDXfKTVENsS7SCOlHsXd6A8GSGl0mkyj1nsfGvmsZGkBe6jvaPJW4x
         3na0kKZhAoLPrvUeq0srx17kXhcsYrOnMnDPlpFaJ1Y39QjcBsqI8eMQFj21ipdM0o5h
         f0LcUPvMfIckERlG6S8uf6v9D2Adxt1hauRPqW/JaX7iuyKP2sF7ORXA4e0ddw+RhWbD
         Zt2g==
X-Gm-Message-State: AOAM531PuwJL5SJH46UqaZx6hPgsS5n9ThpQfPE6k1VNJ+gBUewu3XL5
        8myMrK+GgPOhgV7blOvpVDjrZ44ClRE=
X-Google-Smtp-Source: ABdhPJzzMQrG2uYEl1iLdWDqM5CrHDM0PBUx+mqiN0cRzWvIHVPvIygcl4HpOI6G8BVpmgu4PlrtXg==
X-Received: by 2002:a5d:68c4:: with SMTP id p4mr1203531wrw.62.1612469281591;
        Thu, 04 Feb 2021 12:08:01 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o124sm7360162wmb.5.2021.02.04.12.08.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 12:08:01 -0800 (PST)
Message-Id: <1c599abdbb6fd304dd340ecbf903082306cf9138.1612469275.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.869.git.1612469275.gitgitgadget@gmail.com>
References: <pull.869.git.1612469275.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Feb 2021 20:07:54 +0000
Subject: [PATCH 6/6] range-diff: offer --left-only/--right-only options
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

When comparing commit ranges, one is frequently interested only in one
side, such as asking the question "Has this patch that I submitted to
the Git mailing list been applied?": one would only care about the part
of the output that corresponds to the commits in a local branch.

To make that possible, imitate the `git rev-list` options `--left-only`
and `--right-only`.

This addresses https://github.com/gitgitgadget/git/issues/206

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/git-range-diff.txt |  9 +++++++++
 builtin/range-diff.c             |  8 +++++++-
 range-diff.c                     | 11 ++++++++---
 range-diff.h                     |  1 +
 t/t3206-range-diff.sh            | 15 +++++++++++++++
 5 files changed, 40 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-range-diff.txt b/Documentation/git-range-diff.txt
index 14bffb272a06..e3bd93515819 100644
--- a/Documentation/git-range-diff.txt
+++ b/Documentation/git-range-diff.txt
@@ -10,6 +10,7 @@ SYNOPSIS
 [verse]
 'git range-diff' [--color=[<when>]] [--no-color] [<diff-options>]
 	[--no-dual-color] [--creation-factor=<factor>]
+	[--left-only | --right-only]
 	( <range1> <range2> | <rev1>...<rev2> | <base> <rev1> <rev2> )
 
 DESCRIPTION
@@ -69,6 +70,14 @@ to revert to color all lines according to the outer diff markers
 	See the ``Algorithm`` section below for an explanation why this is
 	needed.
 
+--left-only::
+	Suppress commits that are missing from the first specified range
+	(or the "left range" when using the `<rev1>...<rev2>` format).
+
+--right-only::
+	Suppress commits that are missing from the second specified range
+	(or the "right range" when using the `<rev1>...<rev2>` format).
+
 --[no-]notes[=<ref>]::
 	This flag is passed to the `git log` program
 	(see linkgit:git-log[1]) that generates the patches.
diff --git a/builtin/range-diff.c b/builtin/range-diff.c
index 80fcdc6ad42d..78bc9fa77062 100644
--- a/builtin/range-diff.c
+++ b/builtin/range-diff.c
@@ -21,7 +21,7 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		.diffopt = &diffopt,
 		.other_arg = &other_arg
 	};
-	int simple_color = -1;
+	int simple_color = -1, left_only = 0, right_only = 0;
 	struct option range_diff_options[] = {
 		OPT_INTEGER(0, "creation-factor",
 			    &range_diff_opts.creation_factor,
@@ -31,6 +31,10 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 		OPT_PASSTHRU_ARGV(0, "notes", &other_arg,
 				  N_("notes"), N_("passed to 'git log'"),
 				  PARSE_OPT_OPTARG),
+		OPT_BOOL(0, "left-only", &left_only,
+			 N_("only emit output related to the first range")),
+		OPT_BOOL(0, "right-only", &right_only,
+			 N_("only emit output related to the second range")),
 		OPT_END()
 	};
 	struct option *options;
@@ -88,6 +92,8 @@ int cmd_range_diff(int argc, const char **argv, const char *prefix)
 	FREE_AND_NULL(options);
 
 	range_diff_opts.dual_color = simple_color < 1;
+	range_diff_opts.left_only = left_only;
+	range_diff_opts.right_only = right_only;
 	res = show_range_diff(range1.buf, range2.buf, &range_diff_opts);
 
 	strvec_clear(&other_arg);
diff --git a/range-diff.c b/range-diff.c
index 5455cbb9521b..6f52dce0f6b6 100644
--- a/range-diff.c
+++ b/range-diff.c
@@ -513,7 +513,8 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched LHS commit whose predecessors were shown. */
 		if (i < a->nr && a_util->matching < 0) {
-			output_pair_header(&opts, patch_no_width,
+			if (!range_diff_opts->right_only)
+				output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, a_util, NULL);
 			i++;
 			continue;
@@ -521,7 +522,8 @@ static void output(struct string_list *a, struct string_list *b,
 
 		/* Show unmatched RHS commits. */
 		while (j < b->nr && b_util->matching < 0) {
-			output_pair_header(&opts, patch_no_width,
+			if (!range_diff_opts->left_only)
+				output_pair_header(&opts, patch_no_width,
 					   &buf, &dashes, NULL, b_util);
 			b_util = ++j < b->nr ? b->items[j].util : NULL;
 		}
@@ -551,7 +553,10 @@ int show_range_diff(const char *range1, const char *range2,
 	struct string_list branch1 = STRING_LIST_INIT_DUP;
 	struct string_list branch2 = STRING_LIST_INIT_DUP;
 
-	if (read_patches(range1, &branch1, range_diff_opts->other_arg))
+	if (range_diff_opts->left_only && range_diff_opts->right_only)
+		res = error(_("--left-only and --right-only are mutually exclusive"));
+
+	if (!res && read_patches(range1, &branch1, range_diff_opts->other_arg))
 		res = error(_("could not parse log for '%s'"), range1);
 	if (!res && read_patches(range2, &branch2, range_diff_opts->other_arg))
 		res = error(_("could not parse log for '%s'"), range2);
diff --git a/range-diff.h b/range-diff.h
index 8fb2ff05865d..66aacd47d149 100644
--- a/range-diff.h
+++ b/range-diff.h
@@ -9,6 +9,7 @@
 struct range_diff_options {
 	int creation_factor;
 	unsigned dual_color:1;
+	unsigned left_only:1, right_only:1;
 	const struct diff_options *diffopt;
 	const struct strvec *other_arg;
 };
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index e217cecac9ed..41cc1077a18f 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -725,4 +725,19 @@ test_expect_success 'format-patch --range-diff with multiple notes' '
 	test_cmp expect actual
 '
 
+test_expect_success '--left-only/--right-only' '
+	git switch --orphan left-right &&
+	test_commit first &&
+	test_commit unmatched &&
+	test_commit common &&
+	git switch -C left-right first &&
+	git cherry-pick common &&
+
+	git range-diff -s --left-only ...common >actual &&
+	head_oid=$(git rev-parse --short HEAD) &&
+	common_oid=$(git rev-parse --short common) &&
+	echo "1:  $head_oid = 2:  $common_oid common" >expect &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
