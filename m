Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AEDC0C54EBE
	for <git@archiver.kernel.org>; Mon, 16 Jan 2023 17:50:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235063AbjAPRt4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 16 Jan 2023 12:49:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235055AbjAPRta (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 16 Jan 2023 12:49:30 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657A139CC2
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:30:33 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id v23so26072225plo.1
        for <git@vger.kernel.org>; Mon, 16 Jan 2023 09:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uVyltB8jN25Nkiu+lSWv8AJ/etuFZePrJBexWQLHY9w=;
        b=G3euKzQ/MxxMVjAK/dgPVsiQb1T1LSQGW0B8AkBfZ7OxYxUVVVe04YZ+1Px9DsU1VE
         Qzirz/kSW9PNEz/BBGRBGGtXuhj8PM1vJdBH8fh8Oqhs4Ve893R3b3k2vIsigNOIRlt1
         VvDwxvoFNXww2QdhAiCR7gLjWXYrYEnCJ/DJgyfgAvruK1t9Kr4t20FROBGEKWjCSTxt
         AbSgmEHPQt+v/hI8I2GzBuiPF7HoTXw4BgpMq0FyZDCwkVKI4NUPe/KDJVv/hsiD3t1R
         2KhTHbVE+pw4gKSiBqYR79MsXgGcrXlTssbbTMV16Pc4ajK3QwG7OeQVue9rpZS0qm9F
         AIrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uVyltB8jN25Nkiu+lSWv8AJ/etuFZePrJBexWQLHY9w=;
        b=iMLlPbxClVowIx2XbzOgt30GlNoQiaZqU5PeJlC6+OarhlfrgKydIRa28as4CM6O0/
         VH3D3jvWsDkf/s+jotzmTA7kMaWCDon77qitYOE8e4fEgaDfBJjfkueWnoBabfkcdc10
         6lydaLkkMG7ZtzqvAKpYQaajffy4lAh9BYkR7RjlsmXSnxJOWK0llTF6Ww33oB7RJRqu
         HHerLkSyOjWKgjpMZs2Gxnq57GZVPDVXfxsCKxBGt9t9vuNgThuXu1MecygNg/cu4FxA
         xs6RPOg6PSEcINNXFJJ8Te8+oTjl4tCTmwNkV4eAh1tp8za/vcrVR+x2Hd4B63djbhLX
         XmSw==
X-Gm-Message-State: AFqh2kpsuAJNaqJmbKMjJQmISGXZgk4uLmi9Veras9ZL6jIHmuwilYEX
        MEnPmq/KT2ogz1Kb+J3GWwzxNmTMxxY=
X-Google-Smtp-Source: AMrXdXtXLTZSsSim5ZyS8dW0dDDi1JlA8Tuf4bVdqWJPvNAlwD/w1o1+gHNjPgxE/i8KYS3WpMCL9A==
X-Received: by 2002:a05:6a20:6d02:b0:b6:9f9f:4b90 with SMTP id fv2-20020a056a206d0200b000b69f9f4b90mr15304683pzb.24.1673890232512;
        Mon, 16 Jan 2023 09:30:32 -0800 (PST)
Received: from localhost.localdomain (192-184-217-7.fiber.dynamic.sonic.net. [192.184.217.7])
        by smtp.gmail.com with ESMTPSA id f7-20020a623807000000b00589500f19d0sm14228083pfa.142.2023.01.16.09.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Jan 2023 09:30:32 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     vustthat@gmail.com, sunshine@sunshineco.com, pclouds@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH] builtin/checkout: check the branch used in -B with worktrees
Date:   Mon, 16 Jan 2023 09:28:24 -0800
Message-Id: <20230116172824.93218-1-carenas@gmail.com>
X-Mailer: git-send-email 2.39.0.1.g119e9c6876.dirty
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When multiple worktrees are being used, checkout/switch check
that the target branch is not already checked out with code that
evolved from 8d9fdd7087 (worktree.c: check whether branch is rebased
in another worktree, 2016-04-22), but that logic wasn't valid for
-B/-C

Avoid reusing the same `branch_info` structure for the checks and
assumming that it will be rejected later if is a new branch that
already exists as that doesn't apply to -B/-C.

Reported-by: Jinwook Jeong <vustthat@gmail.com>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/checkout.c      | 22 ++++++++++++++++------
 t/t2400-worktree-add.sh | 14 ++++++++++++++
 2 files changed, 30 insertions(+), 6 deletions(-)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index 3fa29a08ee..94dcd617ef 100644
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
 		if (head_ref &&
-		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, new_branch_info->path)))
-			die_if_checked_out(new_branch_info->path, 1);
+		    (!(flag & REF_ISSYMREF) || strcmp(head_ref, check_branch_info->path)))
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
index d587e0b20d..283ba7607e 100755
--- a/t/t2400-worktree-add.sh
+++ b/t/t2400-worktree-add.sh
@@ -125,6 +125,13 @@ test_expect_success 'die the same branch is already checked out' '
 	)
 '
 
+test_expect_success 'die the same branch is already checked out (checkout -B)' '
+	(
+		cd here &&
+		test_must_fail git checkout -B newmain
+	)
+'
+
 test_expect_success SYMLINKS 'die the same branch is already checked out (symlink)' '
 	head=$(git -C there rev-parse --git-path HEAD) &&
 	ref=$(git -C there symbolic-ref HEAD) &&
@@ -147,6 +154,13 @@ test_expect_success 'not die on re-checking out current branch' '
 	)
 '
 
+test_expect_success 'not die on re-checking out current branch (checkout -B)' '
+	(
+		cd there &&
+		git checkout -B newmain
+	)
+'
+
 test_expect_success '"add" from a bare repo' '
 	(
 		git clone --bare . bare &&
-- 
2.39.0.1.g119e9c6876.dirty

