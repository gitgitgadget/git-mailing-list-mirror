Return-Path: <SRS0=HVLo=IF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 160C9C433E6
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 07:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E38A265126
	for <git@archiver.kernel.org>; Sun,  7 Mar 2021 07:05:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbhCGG5s (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Mar 2021 01:57:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbhCGG5X (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Mar 2021 01:57:23 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94844C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 22:57:22 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id b18so7823472wrn.6
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 22:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=2294BqTK/8y8GCBzBgxJzvPXJ/yi+642tcElO6vMl3s=;
        b=GZHiPogpRND6wA8kmdftzo7G5mravdC4E8DSZdtT55/1N11EXYtALePnWO3HX/lFI9
         YIPXfqUvfr+akOyH8EZErdayXZRUDAj1JzgZ1s/+OldbkEmsgzXRILPbQ82pm7b6VK7p
         SBIsurVutNQCNeLYzp6NTsYB07P6EVASrmtEpZCLyHXM1NmE8QTwjC3joLxlDc2jh8/F
         ONuWmjGSnvtkkHTGs5nCypR+yV1ZDW2YI4q4zva7W2JemIznUKZhwFVQSO9iSUNx6jIy
         f+OXuhDg6WwZmjqozAfTms2td6jxzkbIb4Rn2IemGwxgLr0PBJiSoE00VFDoX/TVuJpp
         vaxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=2294BqTK/8y8GCBzBgxJzvPXJ/yi+642tcElO6vMl3s=;
        b=g1X/CipMDLc0Dgkz2nYwPJVZHGHaOu0r1cPrTdKP4eAq6fXLxs5VqH5BmCTOIMMA3u
         QZlsJIAjLfRAnXea5hOlljJIqwxTz9Ku5nnD3VG4qdftBtoQLLfdALHEEMrQDELYwRE8
         KhJ0As0r0tMiUZ11U0y9TsU8gEcKmyyi3nK4jce1btEWlDFGeLBgbUudJYjd+fI6XACw
         6bhiZ1RP55F261rWEDa4DmyNxNSp2W+ppBXJ8/I8RSed8flBV0SxO2uFLuR0Ah62abje
         Nmb9OjDyt0Bd8cpJPacYd5BcibFV0VQnQzY/WE7E/VKI3ZpUPr32fddZ9sUqBKFVW0i5
         cLMA==
X-Gm-Message-State: AOAM531h+vNyk2MquGeqAkK6QZ8jOBr9TazFt9dD8CurbCIbTWiLs9Lc
        h8PdwJLhFmIejtIof1vqNuqq/77AxaU=
X-Google-Smtp-Source: ABdhPJwCJq1U2AMHFfWMrYdWNtcl8JOI6UvM2P/1KUZg0EKGb8qUZ5td98YNjDDtCzqZVfqz0C2aNA==
X-Received: by 2002:adf:f4c1:: with SMTP id h1mr17225454wrp.71.1615100241234;
        Sat, 06 Mar 2021 22:57:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j30sm13974033wrj.62.2021.03.06.22.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 22:57:20 -0800 (PST)
Message-Id: <pull.898.git.1615100240295.gitgitgadget@gmail.com>
From:   "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 07 Mar 2021 06:57:19 +0000
Subject: [PATCH] [GSOC][RFC] format-patch: pass --right-only to range-diff
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Taylor Blau <me@ttaylorr.com>,
        ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: ZheNing Hu <adlternative@gmail.com>

In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
Taylor Blau proposing 'git format-patch --cover-letter
--range-diff' may mistakenly place upstream commit in the
range-diff output. Teach `format-patch` pass `--right-only`
to range-diff, maybe can avoid this kind of mistake.

Because `git rebase --apply` will internally call `git
format-patch -k --stdout --full-index --cherry-pick --right-only
--src-prefix=a/ --dst-prefix=b/ --no-renames --no-cover-letter
--pretty=mboxrd --topo-order --no-base`, In order to avoid the
ambiguity of `--right-only`, users can call `format-patch
--range-diff --only-right` instead of `--right-only` to only emit
output related to the second range.

Signed-off-by: ZheNing Hu <adlternative@gmail.com>
---
    [GSOC][RFC] format-patch: pass --right-only to range-diff
    
    Transfer parameters are relatively simple. But because I can' t
    reproduce the situation, There's no big difference between adding
    ---only-right and not adding ---only-right. So I haven't written the
    test files for the time being.
    
    I may need to ask reviewers opinion first.
    
    this want to fix #876 Thanks.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-898%2Fadlternative%2Fformat-patch-range-diff-right-only-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-898/adlternative/format-patch-range-diff-right-only-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/898

 Documentation/git-format-patch.txt |  5 ++++-
 builtin/log.c                      | 15 ++++++++++-----
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/Documentation/git-format-patch.txt b/Documentation/git-format-patch.txt
index 3e49bf221087..5dae34c3090b 100644
--- a/Documentation/git-format-patch.txt
+++ b/Documentation/git-format-patch.txt
@@ -27,7 +27,7 @@ SYNOPSIS
 		   [--[no-]encode-email-headers]
 		   [--no-notes | --notes[=<ref>]]
 		   [--interdiff=<previous>]
-		   [--range-diff=<previous> [--creation-factor=<percent>]]
+		   [--range-diff=<previous> [--creation-factor=<percent>] [--right-only]]
 		   [--filename-max-length=<n>]
 		   [--progress]
 		   [<common diff options>]
@@ -301,6 +301,9 @@ material (this may change in the future).
 	creation/deletion cost fudge factor. See linkgit:git-range-diff[1])
 	for details.
 
+--only-right:
+	Used with `--range-diff`, only emit output related to the second range.
+
 --notes[=<ref>]::
 --no-notes::
 	Append the notes (see linkgit:git-notes[1]) for the commit
diff --git a/builtin/log.c b/builtin/log.c
index f67b67d80ed1..5d2f39fd19a7 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1153,7 +1153,7 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			      struct commit *origin,
 			      int nr, struct commit **list,
 			      const char *branch_name,
-			      int quiet)
+			      int quiet, int right_only)
 {
 	const char *committer;
 	struct shortlog log;
@@ -1228,7 +1228,8 @@ static void make_cover_letter(struct rev_info *rev, int use_separate_file,
 			.creation_factor = rev->creation_factor,
 			.dual_color = 1,
 			.diffopt = &opts,
-			.other_arg = &other_arg
+			.other_arg = &other_arg,
+			.right_only = right_only
 		};
 
 		diff_setup(&opts);
@@ -1732,7 +1733,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	struct strbuf rdiff2 = STRBUF_INIT;
 	struct strbuf rdiff_title = STRBUF_INIT;
 	int creation_factor = -1;
-
+	int right_only = 0;
 	const struct option builtin_format_patch_options[] = {
 		OPT_CALLBACK_F('n', "numbered", &numbered, NULL,
 			    N_("use [PATCH n/m] even with a single patch"),
@@ -1814,6 +1815,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 			     parse_opt_object_name),
 		OPT_STRING(0, "range-diff", &rdiff_prev, N_("refspec"),
 			   N_("show changes against <refspec> in cover letter or single patch")),
+		OPT_BOOL(0, "only-right", &right_only,
+			 N_("only emit output related to the second range")),
 		OPT_INTEGER(0, "creation-factor", &creation_factor,
 			    N_("percentage by which creation is weighted")),
 		OPT_END()
@@ -2087,7 +2090,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		creation_factor = RANGE_DIFF_CREATION_FACTOR_DEFAULT;
 	else if (!rdiff_prev)
 		die(_("--creation-factor requires --range-diff"));
-
+	if (right_only && !rdiff_prev)
+		die(_("--right_only requires --range-diff"));
 	if (rdiff_prev) {
 		if (!cover_letter && total != 1)
 			die(_("--range-diff requires --cover-letter or single patch"));
@@ -2134,7 +2138,8 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (thread)
 			gen_message_id(&rev, "cover");
 		make_cover_letter(&rev, !!output_directory,
-				  origin, nr, list, branch_name, quiet);
+				  origin, nr, list, branch_name, quiet,
+					right_only);
 		print_bases(&bases, rev.diffopt.file);
 		print_signature(rev.diffopt.file);
 		total++;

base-commit: be7935ed8bff19f481b033d0d242c5d5f239ed50
-- 
gitgitgadget
