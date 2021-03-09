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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CADFC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 10:29:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A5986525F
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 10:29:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbhCIK3D (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 05:29:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230446AbhCIK2u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 05:28:50 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897EBC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 02:28:50 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id 7so14650526wrz.0
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 02:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9WbECwlG7C2z/5FhkWynv96Ow77/WkDwTPwLbnkBaJc=;
        b=rIkZl8J3GfiEaCGiS67tlUSTRDE70XlEgJptUH7IK59reMv+po6V+6CG6Ymtzklmm6
         49vpLsBta1G/9/8+aXZ6HgXxuknbF/zzg2QDq9ImA3VIfqamhHNNHrlJe52quqJBF+Mm
         aRkCVrmSyNtPqeidTqU2NCsh3w98DnJam8RZQ7nWjLwIV7hrBBr5wtK0PEeK/rBviQHa
         vr6hyIuIKHlecsiXb3hrhluIxVwhtrmMHirf0l4c/LxPKPKMPAvrmolns2pO6Ozh/3YH
         Cr9pjpDDtwBI4Amz6xck2QbUdy8dEeI7znl5O3ZmE+3uV+j3nioKf1MHJ2mKZqk6o7jS
         ft9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9WbECwlG7C2z/5FhkWynv96Ow77/WkDwTPwLbnkBaJc=;
        b=Lca8TwEeF5nDv+UqTudoLqKQR8C3uYxtdMQtKULPBCnwfNjyPB9Bw4Gmx85+UEe1I1
         oIMC84kovS3ktfQu8WLflYu/MD2afiU+wubfpbFM7zZ9rm65MWXFpvHtPuK4hsySgSl1
         Gsryr6sQ64/HmQHAM0zvtbcLnsUkgH7h9a19BweFd66V/dvzRdK8QA/inwyVQ4CnRlKL
         vc169xFgJ8MJf70hKLUg02PvfaWsStIycinOZo1JBjXECvIdzOpil3R8C41DsGFMQC1I
         VhRJL+IwG11TvRwjMCRpLsSA0x4CME/39IhKveD+yZKDLlL8gh+IL/+xWjlT2zoEPCsy
         MliA==
X-Gm-Message-State: AOAM530PTY7uckVnTNPBG88rJx2frZdVZxyVTMZIJIWonZ5bCWFBWYZC
        j5VadApeL5wVo0eB0tZyvVWsjUollTg=
X-Google-Smtp-Source: ABdhPJwvKgKxgVBPi+0xjLWThqQ5KzwM7Yx99yYCXRKyWD1YnB7p1RUlCtM7V3B9LgaJiPt5wrJq7A==
X-Received: by 2002:adf:f9d0:: with SMTP id w16mr3808524wrr.336.1615285727987;
        Tue, 09 Mar 2021 02:28:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j6sm3208243wmq.16.2021.03.09.02.28.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Mar 2021 02:28:47 -0800 (PST)
Message-Id: <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com>
In-Reply-To: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
References: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Mar 2021 10:28:46 +0000
Subject: [PATCH v3] [GSOC][RFC] format-patch: pass --left-only to range-diff
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
        Eric Sunshine <sunshine@sunshineco.com>,
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

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-898%2Fadlternative%2Fformat-patch-range-diff-right-only-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-898/adlternative/format-patch-range-diff-right-only-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/898

Range-diff vs v2:

 1:  8daffd4f7546 ! 1:  5c58eb186d41 [GSOC][RFC] format-patch: pass --left-only to range-diff
     @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *pre
       			    N_("percentage by which creation is weighted")),
       		OPT_END()
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
     + 					     _("Interdiff against v%d:"));
     + 	}
       
     - 	if (creation_factor < 0)
     - 		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
     --	else if (!rdiff_prev)
     --		die(_("--creation-factor requires --range-diff"));
     --
     -+	else if (!rdiff_prev) {
     ++	if (!rdiff_prev) {
      +		if (creation_factor >= 0)
      +			die(_("--creation-factor requires --range-diff"));
      +		if (left_only)
      +			die(_("--left-only requires --range-diff"));
      +	}
     ++
     + 	if (creation_factor < 0)
     + 		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
     +-	else if (!rdiff_prev)
     +-		die(_("--creation-factor requires --range-diff"));
     + 
       	if (rdiff_prev) {
       		if (!cover_letter && total != 1)
     - 			die(_("--range-diff requires --cover-letter or single patch"));
      @@ builtin/log.c: int cmd_format_patch(int argc, const char **argv, const char *prefix)
       		if (thread)
       			gen_message_id(&rev, "cover");
       		make_cover_letter(&rev, !!output_directory,
      -				  origin, nr, list, branch_name, quiet);
      +				  origin, nr, list, branch_name, quiet,
     -+					left_only);
     ++				  left_only);
       		print_bases(&bases, rev.diffopt.file);
       		print_signature(rev.diffopt.file);
       		total++;
     @@ t/t3206-range-diff.sh: test_expect_success '--left-only/--right-only' '
      +	git rebase $base --onto main &&
      +	tip="$(git rev-parse my-feature)" &&
      +	git format-patch --range-diff $base $old $tip --cover-letter  &&
     -+	grep  "> 1: .* feature$"  0000-cover-letter.patch &&
     ++	grep "> 1: .* feature$" 0000-cover-letter.patch &&
      +	git format-patch --range-diff $base $old $tip --left-only --cover-letter &&
     -+	! grep  "> 1: .* feature$"  0000-cover-letter.patch
     ++	! grep "> 1: .* feature$" 0000-cover-letter.patch
      +'
     -+
      +
       test_done


 Documentation/git-format-patch.txt |  5 ++++-
 builtin/log.c                      | 20 +++++++++++++++-----
 t/t3206-range-diff.sh              | 27 +++++++++++++++++++++++++++
 3 files changed, 46 insertions(+), 6 deletions(-)

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
index f67b67d80ed1..21fed9db82d6 100644
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
@@ -2083,10 +2087,15 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 					     _("Interdiff against v%d:"));
 	}
 
+	if (!rdiff_prev) {
+		if (creation_factor >= 0)
+			die(_("--creation-factor requires --range-diff"));
+		if (left_only)
+			die(_("--left-only requires --range-diff"));
+	}
+
 	if (creation_factor < 0)
 		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
-	else if (!rdiff_prev)
-		die(_("--creation-factor requires --range-diff"));
 
 	if (rdiff_prev) {
 		if (!cover_letter && total != 1)
@@ -2134,7 +2143,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, branch_name, quiet,
+				  left_only);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;
diff --git a/t/t3206-range-diff.sh b/t/t3206-range-diff.sh
index 1b26c4c2ef91..6178a12dd4b1 100755
--- a/t/t3206-range-diff.sh
+++ b/t/t3206-range-diff.sh
@@ -748,4 +748,31 @@ test_expect_success '--left-only/--right-only' '
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
+	grep "> 1: .* feature$" 0000-cover-letter.patch &&
+	git format-patch --range-diff $base $old $tip --left-only --cover-letter &&
+	! grep "> 1: .* feature$" 0000-cover-letter.patch
+'
+
 test_done

base-commit: be7935ed8bff19f481b033d0d242c5d5f239ed50
-- 
gitgitgadget
