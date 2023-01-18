Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD1FCC004D4
	for <git@archiver.kernel.org>; Wed, 18 Jan 2023 06:29:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229759AbjARG3V (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Jan 2023 01:29:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjARG00 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Jan 2023 01:26:26 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622E4392AB
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 22:16:00 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id k18so11856102pll.5
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 22:16:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+HdPOl7eU1wJNV+4i49VYYYT2F3MlCPIs8e5mCVYsDY=;
        b=e8jxI1y2iYSWoUz3ih1IyjnD68sViCS7o6Q627eX17uFisiPG7ga26yS0aWFrhuhg0
         3Lq4dZxYczlWmV1lyGEb4hPIvCMNbBKCjdoh2su0cCifek1EhJj8TAoiIwy7bxVcm+3M
         6cgH3UXDkOU4E2AqSSA5aTO+xfl81nq42YC/4BL/1vqL7aFAe13oYBOhQHBOpbPiZ10c
         ufk/EAysGPynJcUJoaI6MtAPGoTCo/jabb6N9IFGDobVeP1LH8GC9kSNG2rXk6ez570A
         drBi1Ssswzqwr57imYcOvbGGpdQ4DfPYaY/LXbmcQAUfEQC/UlsZvC2Zjy0lBq6G2fOH
         AcIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+HdPOl7eU1wJNV+4i49VYYYT2F3MlCPIs8e5mCVYsDY=;
        b=i9xkp5DeM8l5udlAM7ND8MeM7+xBgj75g+LOjHOkpt2deLh9ok+fdk/NK1I8ttKyKS
         I3lu09iyYIGYf6qA+PWWg8oLcNSCXxdVH4s92JCyJLjX2EkWgtrVDnWvxG1mw2Fc0EWL
         kPQU+0n2PmBocT5nMKz4UcSO6ZppmJLFoitHhaGejJnpPWuT9fnY8cBRZbcqJqmxGXMZ
         s2WJrKNpyc/N3GR/+AFRam4WaKMkwyYIDmrW/zoF7ys+YkNGy3bqYHwP188ONJt+DI8Z
         k0rHQAr0iRakgBWNvqT//4wL5xV5kk3XuF4Xvz/4uJxTtqzyP9Nqkw8mV8kvyuAoMDeq
         70Qg==
X-Gm-Message-State: AFqh2ko2rayDTfSHD1c9rP70dbNm9j4Bf7Teaes6BB7DNscZ+raAhiWO
        KzgEoompL8UlEXaw6Z8UZAT5MU5xp1U=
X-Google-Smtp-Source: AMrXdXuxpNAJtO2XLywo5tEMU5WTtsmI1G0+eo2rmcx/YR0r/3/3NUaGH5+cekWXEP5BqhZiXl/VIA==
X-Received: by 2002:a17:902:6e17:b0:193:39c4:cf55 with SMTP id u23-20020a1709026e1700b0019339c4cf55mr4819244plk.17.1674022559527;
        Tue, 17 Jan 2023 22:15:59 -0800 (PST)
Received: from localhost.localdomain (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id d17-20020a170902ced100b00168dadc7354sm22208487plg.78.2023.01.17.22.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 22:15:58 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     pclouds@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Jinwook Jeong <vustthat@gmail.com>,
        =?UTF-8?q?Rub=C3=A9n=20Justo?= <rjusto@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH v2] checkout/switch: disallow checking out same branch in multiple worktrees
Date:   Tue, 17 Jan 2023 22:15:27 -0800
Message-Id: <20230118061527.76218-1-carenas@gmail.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230116172824.93218-1-carenas@gmail.com>
References: <20230116172824.93218-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Commands `git switch -C` and `git checkout -B` neglect to check whether
the provided branch is already checked out in some other worktree, as
shown by the following example:

  $ git worktree list
  .../foo    beefb00f [main]
  $ git worktree add ../other
  Preparing worktree (new branch 'other')
  HEAD is now at beefb00f first
  $ cd ../other
  $ git switch -C main
  Switched to and reset branch 'main'
  $ git worktree list
  .../foo    beefb00f [main]
  .../other  beefb00f [main]

Fix this problem by teaching `git switch -C` and `git checkout -B` to
check whether the branch in question is already checked out elsewhere
by expanding on the existing checks that are being used by their non
force variants.

As reflected on the tests, this will change the behaviour of those
commands when they are invoked in a worktree that has that requested
branch checked out, as that matches the logic used by branch, is safer
(assuming both commands are user facing) and can be overriden with an
existing flag.

Reported-by: Jinwook Jeong <vustthat@gmail.com>
Helped-by: Rubén Justo <rjusto@gmail.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
Changes since v1
* A much better commit message
* Changes to the tests as suggested by Eric
* Changes to the logic as suggested by Rubén

 builtin/checkout.c      | 24 +++++++++++++++++-------
 t/t2400-worktree-add.sh | 18 ++++++++++++++++--
 2 files changed, 33 insertions(+), 9 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3fa29a08ee..58a956392b 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -1474,7 +1474,8 @@ static void die_if_some_operation_in_progress(void)
 }
 
 static int checkout_branch(struct checkout_opts *opts,
-			   struct branch_info *new_branch_info)
+			   struct branch_info *new_branch_info,
+			   struct branch_info *check_branch_info)
 {
 	if (opts->pathspec.nr)
 		die(_("paths cannot be used with switching branches"));
@@ -1533,13 +1534,12 @@ static int checkout_branch(struct checkout_opts *opts,
 	if (!opts->can_switch_when_in_progress)
 		die_if_some_operation_in_progress();
 
-	if (new_branch_info->path && !opts->force_detach && !opts->new_branch &&
-	    !opts->ignore_other_worktrees) {
+	if (check_branch_info->path && !opts->force_detach && !opts->ignore_other_worktrees) {
 		int flag;
 		char *head_ref = resolve_refdup("HEAD", 0, NULL, &flag);
-		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
-			die_if_checked_out(new_branch_info->path, 1);
+		if (opts->new_branch_force || (head_ref &&
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, check_branch_info->path))))
+			die_if_checked_out(check_branch_info->path, 1);
 		free(head_ref);
 	}
 
@@ -1628,6 +1628,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			 struct branch_info *new_branch_info)
 {
 	int parseopt_flags = 0;
+	struct branch_info check_branch_info = { 0 };
 
 	opts->overwrite_ignore = 1;
 	opts->prefix = prefix;
@@ -1739,6 +1740,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 			!opts->new_branch;
 		int n = parse_branchname_arg(argc, argv, dwim_ok,
 					     new_branch_info, opts, &rev);
+		check_branch_info = *new_branch_info;
 		argv += n;
 		argc -= n;
 	} else if (!opts->accept_ref && opts->from_treeish) {
@@ -1751,8 +1753,16 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 						      opts, &rev,
 						      opts->from_treeish);
 
+		check_branch_info = *new_branch_info;
 		if (!opts->source_tree)
 			die(_("reference is not a tree: %s"), opts->from_treeish);
+	} else if (opts->new_branch) {
+		struct object_id rev;
+
+		if (!get_oid_mb(opts->new_branch, &rev))
+			setup_new_branch_info_and_source_tree(&check_branch_info,
+							opts, &rev,
+							opts->new_branch);
 	}
 
 	if (argc) {
@@ -1819,7 +1829,7 @@ static int checkout_main(int argc, const char **argv, const char *prefix,
 	if (opts->patch_mode || opts->pathspec.nr)
 		return checkout_paths(opts, new_branch_info);
 	else
-		return checkout_branch(opts, new_branch_info);
+		return checkout_branch(opts, new_branch_info, &check_branch_info);
 }
 
 int cmd_checkout(int argc, const char **argv, const char *prefix)
diff --git a/t/t2400-worktree-add.sh b/t/t2400-worktree-add.sh
index d587e0b20d..a66f9bb30c 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -121,7 +121,10 @@ test_expect_success '"add" worktree creating new branch' '
 test_expect_success 'die the same branch is already checked out' '
 	(
 		cd here &&
-		test_must_fail git checkout newmain
+		test_must_fail git checkout newmain &&
+		test_must_fail git checkout -B newmain &&
+		test_must_fail git switch newmain &&
+		test_must_fail git switch -C newmain
 	)
 '
 
@@ -143,7 +146,18 @@ test_expect_success 'not die the same branch is already checked out' '
 test_expect_success 'not die on re-checking out current branch' '
 	(
 		cd there &&
-		git checkout newmain
+		git checkout newmain &&
+		git switch newmain
+	)
+'
+
+test_expect_success 'but die if using force without --ignore-other-worktrees' '
+	(
+		cd there &&
+		test_must_fail git checkout -B newmain &&
+		test_must_fail git switch -C newmain &&
+		git checkout --ignore-other-worktrees -B newmain &&
+		git switch --ignore-other-worktrees -C newmain
 	)
 '
 
-- 
2.37.1 (Apple Git-137.1)

