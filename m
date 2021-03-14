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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A436C43381
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 08:11:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3350E64EC0
	for <git@archiver.kernel.org>; Sun, 14 Mar 2021 08:11:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234355AbhCNILO (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Mar 2021 04:11:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229539AbhCNIKl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Mar 2021 04:10:41 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DECC061574
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 00:10:41 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id 124-20020a1c00820000b029010b871409cfso18300033wma.4
        for <git@vger.kernel.org>; Sun, 14 Mar 2021 00:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=QQtdGhGhqroQU3GYqgPtRHzpBzTMmMVvEyGMaRwQvq0=;
        b=MyC7CHN5nYoI1gGiZ+8C6vuM3Yjh1E8mSS/7DuvE1ClqVf4uNAvEvB0aqcHU/N0WE8
         jkT5vtVkIGu8uT+JhamVas4zaZKz7lgs9a34SMWQ7KbYHTbY0umCCt8p6hhzcSUPf+t5
         YTLz+Zxl3wcII2GdT9ZBpEZ7/NzEkmHSL3qxEV4ooMCf0CjyK7Pzhs8twKaeRnu3GSvF
         +iRUaLmvCIpd0A7Skuqls8RY83IRFhvzMlmPVyghq4OetpO92mrTn6AucNgQIXHfaQfD
         O8F9JYG7ckAMjPwMLaaHkHNMSQBmNkZELydZiD/Rb7wJZvUz+A0LvbtSn/Vh4kM1Lzk5
         gZOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=QQtdGhGhqroQU3GYqgPtRHzpBzTMmMVvEyGMaRwQvq0=;
        b=crvGBmuxOMUU4JcKo5COepNSha+pdPuWjauXra0sENoZXjDels67HqXY1PKeJpnJlT
         PLG6PNBnqfm7NDuujNPkkFnFkdsX6u9suZqMF+Jaw72Apg0oeZLWoiyWpAPkupqUlN4+
         hY5/aroH/HV3cHEU/rIsLiR+B25QxoSdq1mOw2qdqj4ZFU1QQsnAIQH1/zijItcy4c4w
         43S1AQp1eqzZl23UGDAk47j/KnuJABpiXy7FHeOKa60N6BQcd32ygqv6r6uCsIRpCDUN
         sdL7Ty+STec6wvECRApUspDx05Rct9kZs4Cm2UOfSAZaex/goGzy+VeyRihC69inbjcK
         q61A==
X-Gm-Message-State: AOAM533oeMbMswrVUkH2rmPP5vKAliJg7d4SwajuplhYWjVVRHk4rssU
        JQYCax2YchUT5G77HEvxlcpBwKOt+Ho=
X-Google-Smtp-Source: ABdhPJz0HvG1iR9C1f3wm3YBIWNSTasX/zHsmZrSHnJE1EsH+2UTeepedAbjHfrJuxSc6xCm4OC4ow==
X-Received: by 2002:a1c:7ec4:: with SMTP id z187mr20929655wmc.3.1615709440138;
        Sun, 14 Mar 2021 00:10:40 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h25sm9967809wml.32.2021.03.14.00.10.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Mar 2021 00:10:39 -0800 (PST)
Message-Id: <pull.898.v4.git.1615709438971.gitgitgadget@gmail.com>
In-Reply-To: <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com>
References: <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 14 Mar 2021 08:10:38 +0000
Subject: [PATCH v4] [GSOC] format-patch: pass --left-only to range-diff
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

When two different iterative versions t1 and t2 are base upstream
commit b1 and b2, b2 inherits from b1. If the user base on b1 to
generate cover-letter, but `git format-patch --range-diff=b1..t1
b1..t2 --cover-letter` may mistakenly place upstream commit in the
range-diff output in cover-letter.

Teaching `format-patch` pass `--left-only` to `range-diff`, it will
suppress the output on the upstream commits.At the same time, it has
a disadvantage: the iterative version on the right side will be ignored
too. So using `--left-only` is just a lazy way to avoid upstream output.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC][RFC] format-patch: pass --left-only to range-diff
    
    With the help of Taylor Blau and Junio, I understand why the upstream
    commit appeared in the range-diff, and completed the writing of the
    test.
    
    But I notice that in https://github.com/gitgitgadget/git/issues/876 and
    https://lore.kernel.org/git/xmqqpn0456lr.fsf@gitster.g/ Both Junio and
    Johannes Schindelin have questions about the practicality of this
    --left-only, and I am also starting to have confusion now, and
    format-patch --range-diff is more suitable for two commit ranges to
    compare the differences. It is not suitable for T1...T2, which further
    proves that the practicability of this patch may not be as good as
    previously imagined. Should I close it?

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-898%2Fadlternative%2Fformat-patch-range-diff-right-only-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-898/adlternative/format-patch-range-diff-right-only-v4
Pull-Request: https://github.com/gitgitgadget/git/pull/898

Range-diff vs v3:

 1:  5c58eb186d41 ! 1:  3738a00129b5 [GSOC][RFC] format-patch: pass --left-only to range-diff
     @@ Metadata
      Author: ZheNing Hu <adlternative@gmail.com>
      
       ## Commit message ##
     -    [GSOC][RFC] format-patch: pass --left-only to range-diff
     +    [GSOC] format-patch: pass --left-only to range-diff
      
     -    In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
     -    Taylor Blau proposing `git format-patch --cover-letter
     -    --range-diff` may mistakenly place upstream commit in the
     -    range-diff output. Teach `format-patch` pass `--left-only`
     -    to range-diff,can avoid this kind of mistake.
     +    When two different iterative versions t1 and t2 are base upstream
     +    commit b1 and b2, b2 inherits from b1. If the user base on b1 to
     +    generate cover-letter, but `git format-patch --range-diff=b1..t1
     +    b1..t2 --cover-letter` may mistakenly place upstream commit in the
     +    range-diff output in cover-letter.
     +
     +    Teaching `format-patch` pass `--left-only` to `range-diff`, it will
     +    suppress the output on the upstream commits.At the same time, it has
     +    a disadvantage: the iterative version on the right side will be ignored
     +    too. So using `--left-only` is just a lazy way to avoid upstream output.
      
          Signed-off-by: ZheNing Hu <adlternative@gmail.com>
      
     @@ Documentation/git-format-patch.txt: material (this may change in the future).
       
      +--left-only:
      +	Used with `--range-diff`, only emit output related to the first range.
     ++	This option only can be used in this situation: The first iteration `t1`
     ++	based on the upstream commit `b1`, the second iteration `t2` based on the
     ++	upstream commit `b2`, `b2` inherited from the `b1`, then If the user want
     ++	output the range-diff between this two iterations (t1 and t2) in cover-letter,
     ++	and just use `b1` as the same base for `--range-diff`, but they don't want the
     ++	upstream range `b1..b2` included on the right side of the range-diff output.
     ++	By using `git format-patch --range-diff=b1..t1 b1..t2 --cover-letter --left-only`,
     ++	all content on the right side will be removed, leaving only the range
     ++	`b1..t1` on the left side.
     +++
     ++Note that this `--left-only` is just a lazy way to let user use same base
     ++and avoid outputting upstream commits in cover-letter, and the side effect
     ++is that `b2..t2` on the right side will not be outputted.
     ++
      +
       --notes[=<ref>]::
       --no-notes::
     @@ t/t3206-range-diff.sh: test_expect_success '--left-only/--right-only' '
      +	git checkout my-feature &&
      +	git rebase $base --onto main &&
      +	tip="$(git rev-parse my-feature)" &&
     -+	git format-patch --range-diff $base $old $tip --cover-letter  &&
     -+	grep "> 1: .* feature$" 0000-cover-letter.patch &&
     -+	git format-patch --range-diff $base $old $tip --left-only --cover-letter &&
     ++	git format-patch --range-diff $base..$old $base..$tip --cover-letter  &&
     ++	grep "> 1: .* new$" 0000-cover-letter.patch &&
     ++	git format-patch --range-diff $base..$old $base..$tip --left-only --cover-letter &&
      +	! grep "> 1: .* feature$" 0000-cover-letter.patch
      +'
      +


 Documentation/git-format-patch.txt | 19 ++++++++++++++++++-
 builtin/log.c                      | 20 +++++++++++++++-----
 t/t3206-range-diff.sh              | 27 +++++++++++++++++++++++++++
 3 files changed, 60 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf221087..99a2d87a859f 100644
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
@@ -301,6 +301,23 @@ material (this may change in the future).
 	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
 	for details.
 
+--left-only:
+	Used with `--range-diff`, only emit output related to the first range.
+	This option only can be used in this situation: The first iteration `t1`
+	based on the upstream commit `b1`, the second iteration `t2` based on the
+	upstream commit `b2`, `b2` inherited from the `b1`, then If the user want
+	output the range-diff between this two iterations (t1 and t2) in cover-letter,
+	and just use `b1` as the same base for `--range-diff`, but they don't want the
+	upstream range `b1..b2` included on the right side of the range-diff output.
+	By using `git format-patch --range-diff=b1..t1 b1..t2 --cover-letter --left-only`,
+	all content on the right side will be removed, leaving only the range
+	`b1..t1` on the left side.
++
+Note that this `--left-only` is just a lazy way to let user use same base
+and avoid outputting upstream commits in cover-letter, and the side effect
+is that `b2..t2` on the right side will not be outputted.
+
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
index 1b26c4c2ef91..8e537793947b 100755
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
+	git format-patch --range-diff $base..$old $base..$tip --cover-letter  &&
+	grep "> 1: .* new$" 0000-cover-letter.patch &&
+	git format-patch --range-diff $base..$old $base..$tip --left-only --cover-letter &&
+	! grep "> 1: .* feature$" 0000-cover-letter.patch
+'
+
 test_done

base-commit: be7935ed8bff19f481b033d0d242c5d5f239ed50
-- 
gitgitgadget
