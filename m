Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC5BEC433E0
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 08:34:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A89C76527C
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 08:34:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbhCIIeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 03:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbhCIIdx (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 03:33:53 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E56BAC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 00:33:52 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id b18so14242544wrn.6
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 00:33:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=PyiSvrZXIWIlMQbHr2KwgPUVXNMrT0i6gv/dtgZSoNg=;
        b=Gy5zJgbLRIYif3OtxcjGX/+6yH2JC+9F3jQ9mEAkug76Xdn5yGRU4aF0OXb2ETx2Wk
         aV7OzU7gKefhb8YL3SHtrpUnKTl+xFOVPgXgCAqYsxaHDC2tqUKwFrrswWSSD7RGbFPH
         F8StxgPIebL+F6p8M+3OSv/09/jQBw5HklfH8wWoJWkjf+TJ9l6l14SkX8uzhclHXKMu
         RTbb2sN8KdFZSogekkAWDlRxBO530+yUr29mhIgPy9u328AoqsBZ0IclP7WobnRiC9t6
         6bi/4HRCXlupvEIKVehJpqjvUb7gflpHqFEDIuh6aowDIQYAA9wqUFw+cXmM1Xfnl7eE
         Ma5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=PyiSvrZXIWIlMQbHr2KwgPUVXNMrT0i6gv/dtgZSoNg=;
        b=sejpzi8ALkcmc4/Lq3OaxTOHMh2RO1Q4kfpH13qlFXMBY+kqbEOA5DZSD9xynjr2Xp
         7xzA7BbDnoxUQ4vsuLPIob0njIk1RYfLLp9uYhfUfhEyr0c7nGMFdd/6417fY8fBwFUP
         GBMNLQmFYkLp6Z6tchmP8/Ps6OM7CbTLJY2lWx2LcvdM6BzApHzXKxLfte7CNNJmT3Yp
         AWRHSXXjGph2aMA1TCZXAXKJxxJ8hKmYuLRON/P5d19AG+N9l1qZgEg74ELr9/jGysVm
         fX0u8ueMq+N1tVla8QI/FhLC0GCiTiyBeFoW0HhwFaz33Sf0LGYReCybCQLepLRBnoXJ
         DPtg==
X-Gm-Message-State: AOAM531zo0buz6sze+dkjpuIWFtkDRNVOHawi4Yx3ltAUokJj2VYjORt
        gVzX7ArpA+QEFumo0/aolV6No2JM3tc=
X-Google-Smtp-Source: ABdhPJyAKhGopMce9WFgJeMn3X0DUQS8jpuLTyCVtZdeT1PwL1OZlo3CBRct/139MWozR9VaBnHTzQ==
X-Received: by 2002:a5d:6412:: with SMTP id z18mr27144520wru.214.1615278831654;
        Tue, 09 Mar 2021 00:33:51 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m6sm23015605wrv.73.2021.03.09.00.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 00:33:51 -0800 (PST)
Message-Id: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
In-Reply-To: <pull.898.git.1615100240295.gitgitgadget@gmail.com>
References: <pull.898.git.1615100240295.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 08:33:50 +0000
Subject: [PATCH v2] [GSOC][RFC] format-patch: pass --left-only to range-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
Taylor Blau proposing `git format-patch --cover-letter
--range-diff` may mistakenly place upstream commit in the
range-diff output. Teach `format-patch` pass `--left-only`
to range-diff,can avoid this kind of mistake.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC][RFC] format-patch: pass --left-only to range-diff
    
    With the help of Taylor Blau, I understood why the upstream commit
    appeared in the range-diff, and completed the writing of the test.
    
    this want to fix #876 Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-898%2Fadlternative%2Fformat-patch-range-diff-right-only-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-898/adlternative/format-patch-range-diff-right-only-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/898

Range-diff vs v1:

 1:  590bd06ee5ee ! 1:  8daffd4f7546 [GSOC][RFC] format-patch: pass --right-only to range-diff
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC][RFC] format-patch: pass --right-only to range-diff
     +    [GSOC][RFC] format-patch: pass --left-only to range-diff
      
          In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
     -    Taylor Blau proposing 'git format-patch --cover-letter
     -    --range-diff' may mistakenly place upstream commit in the
     -    range-diff output. Teach `format-patch` pass `--right-only`
     -    to range-diff, maybe can avoid this kind of mistake.
     -
     -    Because `git rebase --apply` will internally call `git
     -    format-patch -k --stdout --full-index --cherry-pick --right-only
     -    --src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter
     -    --pretty=mboxrd --topo-order --no-base`, In order to avoid the
     -    ambiguity of `--right-only`, users can call `format-patch
     -    --range-diff --only-right` instead of `--right-only` to only emit
     -    output related to the second range.
     +    Taylor Blau proposing `git format-patch --cover-letter
     +    --range-diff` may mistakenly place upstream commit in the
     +    range-diff output. Teach `format-patch` pass `--left-only`
     +    to range-diff,can avoid this kind of mistake.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-format-patch.txt: SYNOPSIS
       		   [--no-notes | --notes[=<ref>]]
       		   [--interdiff=<previous>]
      -		   [--range-diff=<previous> [--creation-factor=<percent>]]
     -+		   [--range-diff=<previous> [--creation-factor=<percent>] [--right-only]]
     ++		   [--range-diff=<previous> [--creation-factor=<percent>] [--left-only]]
       		   [--filename-max-length=<n>]
       		   [--progress]
       		   [<common diff options>]
     @@ Documentation/git-format-patch.txt: material (this may change in the future).
       	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
       	for details.
       
     -+--only-right:
     -+	Used with `--range-diff`, only emit output related to the second range.
     ++--left-only:
     ++	Used with `--range-diff`, only emit output related to the first range.
      +
       --notes[=<ref>]::
       --no-notes::
     @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_separ
       			      int nr, struct commit **list,
       			      const char *branch_name,
      -			      int quiet)
     -+			      int quiet, int right_only)
     ++			      int quiet, int left_only)
       {
       	const char *committer;
       	struct shortlog log;
     @@ builtin/log.c: static void make_cover_letter(struct rev_info *rev, int use_separ
       			.diffopt = &opts,
      -			.other_arg = &other_arg
      +			.other_arg = &other_arg,
     -+			.right_only = right_only
     ++			.left_only = left_only
       		};
       
       		diff_setup(&opts);
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       	struct strbuf rdiff2 = STRBUF_INIT;
       	struct strbuf rdiff_title = STRBUF_INIT;
       	int creation_factor = -1;
     --
     -+	int right_only = 0;
     ++	int left_only = 0;
     + 
       	const struct option builtin_format_patch_options[] = {
       		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
     - 			    N_("use [PATCH n/m] even with a single patch"),
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
       			     parse_opt_object_name),
       		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
       			   N_("show changes against <refspec> in cover letter or single patch")),
     -+		OPT_BOOL(0, "only-right", &right_only,
     -+			 N_("only emit output related to the second range")),
     ++		OPT_BOOL(0, "left-only", &left_only,
     ++			 N_("only emit output related to the first range")),
       		OPT_INTEGER(0, "creation-factor", &creation_factor,
       			    N_("percentage by which creation is weighted")),
       		OPT_END()
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     + 
     + 	if (creation_factor < 0)
       		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
     - 	else if (!rdiff_prev)
     - 		die(_("--creation-factor requires --range-diff"));
     +-	else if (!rdiff_prev)
     +-		die(_("--creation-factor requires --range-diff"));
      -
     -+	if (right_only && !rdiff_prev)
     -+		die(_("--right_only requires --range-diff"));
     ++	else if (!rdiff_prev) {
     ++		if (creation_factor >= 0)
     ++			die(_("--creation-factor requires --range-diff"));
     ++		if (left_only)
     ++			die(_("--left-only requires --range-diff"));
     ++	}
       	if (rdiff_prev) {
       		if (!cover_letter && total != 1)
       			die(_("--range-diff requires --cover-letter or single patch"));
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       		make_cover_letter(&rev, !!output_directory,
      -				  origin, nr, list, branch_name, quiet);
      +				  origin, nr, list, branch_name, quiet,
     -+					right_only);
     ++					left_only);
       		print_bases(&bases, rev.diffopt.file);
       		print_signature(rev.diffopt.file);
       		total++;
     +
     + ## t/t3206-range-diff.sh ##
     +@@ t/t3206-range-diff.sh: test_expect_success '--left-only/--right-only' '
     + 	test_cmp expect actual
     + '
     + 
     ++test_expect_success 'format-patch --range-diff --left-only' '
     ++	rm -fr repo &&
     ++	git init repo &&
     ++	cd repo &&
     ++	git branch -M main &&
     ++	echo "base" >base &&
     ++	git add base &&
     ++	git commit -m "base" &&
     ++	git checkout -b my-feature &&
     ++	echo "feature" >feature &&
     ++	git add feature &&
     ++	git commit -m "feature" &&
     ++	base="$(git rev-parse main)" &&
     ++	old="$(git rev-parse my-feature)" &&
     ++	git checkout main &&
     ++	echo "other" >>base &&
     ++	git add base &&
     ++	git commit -m "new" &&
     ++	git checkout my-feature &&
     ++	git rebase $base --onto main &&
     ++	tip="$(git rev-parse my-feature)" &&
     ++	git format-patch --range-diff $base $old $tip --cover-letter  &&
     ++	grep  "> 1: .* feature$"  0000-cover-letter.patch &&
     ++	git format-patch --range-diff $base $old $tip --left-only --cover-letter &&
     ++	! grep  "> 1: .* feature$"  0000-cover-letter.patch
     ++'
     ++
     ++
     + test_done


 Documentation/git-format-patch.txt |  5 ++++-
 builtin/log.c                      | 20 ++++++++++++++------
 t/t3206-range-diff.sh              | 28 ++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf221087..8c5eca0ba1e3 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -27,7 +27,7 @@ SYNOPSIS
 		   [--[no-]encode-email-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
-		   [--range-diff=<previous> [--creation-factor=<percent>]]
+		   [--range-diff=<previous> [--creation-factor=<percent>] [--left-only]]
 		   [--filename-max-length=<n>]
 		   [--progress]
 		   [<common diff options>]
@@ -301,6 +301,9 @@ material (this may change in the future).
 	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
 	for details.
 
+--left-only:
+	Used with `--range-diff`, only emit output related to the first range.
+
 --notes[=<ref>]::
 --no-notes::
 	Append the notes (see linkgit:git-notes[1]) for the commit
diff --git a/builtin/log.c b/builtin/log.c
index f67b67d80ed1..5620dfafb37e 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1153,7 +1153,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
-			      int quiet)
+			      int quiet, int left_only)
 {
 	const char *committer;
 	struct shortlog log;
@@ -1228,7 +1228,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			.creation_factor = rev->creation_factor,
 			.dual_color = 1,
 			.diffopt = &opts,
-			.other_arg = &other_arg
+			.other_arg = &other_arg,
+			.left_only = left_only
 		};
 
 		diff_setup(&opts);
@@ -1732,6 +1733,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
 	int creation_factor = -1;
+	int left_only = 0;
 
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
@@ -1814,6 +1816,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     parse_opt_object_name),
 		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
 			   N_("show changes against <refspec> in cover letter or single patch")),
+		OPT_BOOL(0, "left-only", &left_only,
+			 N_("only emit output related to the first range")),
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("percentage by which creation is weighted")),
 		OPT_END()
@@ -2085,9 +2089,12 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 
 	if (creation_factor < 0)
 		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
-	else if (!rdiff_prev)
-		die(_("--creation-factor requires --range-diff"));
-
+	else if (!rdiff_prev) {
+		if (creation_factor >= 0)
+			die(_("--creation-factor requires --range-diff"));
+		if (left_only)
+			die(_("--left-only requires --range-diff"));
+	}
 	if (rdiff_prev) {
 		if (!cover_letter && total != 1)
 			die(_("--range-diff requires --cover-letter or single patch"));
@@ -2134,7 +2141,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, branch_name, quiet,
+					left_only);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 1b26c4c2ef91..abb0cf7fb465 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -748,4 +748,32 @@ test_expect_success '--left-only/--right-only' '
 	test_cmp expect actual
 '
 
+test_expect_success 'format-patch --range-diff --left-only' '
+	rm -fr repo &&
+	git init repo &&
+	cd repo &&
+	git branch -M main &&
+	echo "base" >base &&
+	git add base &&
+	git commit -m "base" &&
+	git checkout -b my-feature &&
+	echo "feature" >feature &&
+	git add feature &&
+	git commit -m "feature" &&
+	base="$(git rev-parse main)" &&
+	old="$(git rev-parse my-feature)" &&
+	git checkout main &&
+	echo "other" >>base &&
+	git add base &&
+	git commit -m "new" &&
+	git checkout my-feature &&
+	git rebase $base --onto main &&
+	tip="$(git rev-parse my-feature)" &&
+	git format-patch --range-diff $base $old $tip --cover-letter  &&
+	grep  "> 1: .* feature$"  0000-cover-letter.patch &&
+	git format-patch --range-diff $base $old $tip --left-only --cover-letter &&
+	! grep  "> 1: .* feature$"  0000-cover-letter.patch
+'
+
+
 test_done

base-commit: be7935ed8bff19f481b033d0d242c5d5f239ed50
-- 
gitgitgadget
