Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9436DC4332B
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F481650BC
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 19:35:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbhCFTfc (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 14:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbhCFTfT (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 14:35:19 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EFA4C06174A
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 11:35:19 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e10so6550192wro.12
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 11:35:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mrcRlHe995DTbDvHo1KsHYJ867Bi456GltRcqJtXoME=;
        b=NvhnJbaFUTf0lFxnawzWW+lppIx5zhnmGZm+vZONujtrtGaGz8B4Zu3zQjcrpNSlvF
         O3JNh6UqtUwPlhPAnG4J62OYxlaJzWW58T4stSDhOfCWTjqomHr3/3IKy2QDZN/Rzf5w
         SpdS7OR3+fXxIAB8k8Sgq1ffgKNLU959IpoSfmVI74Sd16Qf2e00rcGmZsFJiR2rEAZy
         Y+Tlf5fggPKq6nIALosRz+eau6dWKve7jEVa3jfhlgL7nLbFRlI/xAZPVFFzzVm/AiHE
         Q31bD1c/7uuPc+ZPOZzbFwIIkdLGt7LY8diaSUrmmP9ZYErS8xC3+6IpcLFCwUGbHUbh
         6QmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mrcRlHe995DTbDvHo1KsHYJ867Bi456GltRcqJtXoME=;
        b=OlRx7BitcKcC1+TT+cThndInJbnkjAsR5vdK3vhcsSz36fZHpufzWE5U5nXYjQJ92y
         QOs9uaVm0eRygJDhCrCXVhLoU8pQMeg1adhCVzkEQDRZGc7hNbHHFVpaQ3hE0ySfAl5f
         us4XwoItc73qt/6n0lqdNClER6tIinqPL2eXjZCRsHUDvLwZBtN1AWCjDqnXGBqDbofF
         N0zhEhMnwAOBRkQGB1ciGP2FL7XguFiLvUYy0JdJMaBD+zHRLboiHZb36OEolIkC5M0X
         SpqsaAZhnMTciIBQdccrvWWrq9GfXmFpMTak54DB2lRZr6baaq+/rJ1CimH1UKRYsviu
         NHTQ==
X-Gm-Message-State: AOAM5327HjLPaWIfagSt3bjdE80QmIlf2bY69oFiWYPSFveowhv5qfSl
        SAxS/v8mN8QzXGausC1/TJtT3JKj2XqvPA==
X-Google-Smtp-Source: ABdhPJzRvfa2RrMQ4lNhd9AmU03Z5fWNLJ+NZOWlkCKWxImQbprgxp/BSkEUg1yNNdkMQHC6WLo+Xw==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr15510015wrt.192.1615059317660;
        Sat, 06 Mar 2021 11:35:17 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a5sm9951578wrs.35.2021.03.06.11.35.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 11:35:17 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/7] tree.h API: remove support for starting at prefix != ""
Date:   Sat,  6 Mar 2021 20:34:57 +0100
Message-Id: <20210306193458.20633-7-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
References: <1240014568-3675-1-git-send-email-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every caller or the read_tree_recursive() function hardcoded a
starting point of "" in the tree. So let's simply remove that
parameter.

It might be useful in the future to get this functionality back,
there's no reason we won't have a read_tree_recursive() use-case that
would want to start in a subdirectory.

But if and when that happens we can just add something like a
read_tree_recursive_subdir() and have both read_tree_recursive() and
that function be a thin wrapper for read_tree_1().

In the meantime there's no reason to keep around what amounts to dead
code just in case we need it in the future.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 archive.c          | 8 ++++----
 builtin/checkout.c | 2 +-
 builtin/log.c      | 4 ++--
 builtin/ls-files.c | 2 +-
 builtin/ls-tree.c  | 2 +-
 merge-recursive.c  | 2 +-
 tree.c             | 2 --
 tree.h             | 1 -
 8 files changed, 10 insertions(+), 13 deletions(-)

diff --git a/archive.c b/archive.c
index 5919d9e5050..9394f170f7f 100644
--- a/archive.c
+++ b/archive.c
@@ -316,8 +316,8 @@ int write_archive_entries(struct archiver_args *args,
 		git_attr_set_direction(GIT_ATTR_INDEX);
 	}
 
-	err = read_tree_recursive(args->repo, args->tree, "",
-				  0, 0, &args->pathspec,
+	err = read_tree_recursive(args->repo, args->tree,
+				  0, &args->pathspec,
 				  queue_or_write_archive_entry,
 				  &context);
 	if (err == READ_TREE_RECURSIVE)
@@ -405,8 +405,8 @@ static int path_exists(struct archiver_args *args, const char *path)
 	ctx.args = args;
 	parse_pathspec(&ctx.pathspec, 0, 0, "", paths);
 	ctx.pathspec.recursive = 1;
-	ret = read_tree_recursive(args->repo, args->tree, "",
-				  0, 0, &ctx.pathspec,
+	ret = read_tree_recursive(args->repo, args->tree,
+				  0, &ctx.pathspec,
 				  reject_entry, &ctx);
 	clear_pathspec(&ctx.pathspec);
 	return ret != 0;
diff --git a/builtin/checkout.c b/builtin/checkout.c
index 2d6550bc3c8..21b742c0f07 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -155,7 +155,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 
 static int read_tree_some(struct tree *tree, const struct pathspec *pathspec)
 {
-	read_tree_recursive(the_repository, tree, "", 0, 0,
+	read_tree_recursive(the_repository, tree, 0,
 			    pathspec, update_some, NULL);
 
 	/* update the index with the given tree's info
diff --git a/builtin/log.c b/builtin/log.c
index f67b67d80ed..ffa3fb8c286 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -681,8 +681,8 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 					diff_get_color_opt(&rev.diffopt, DIFF_COMMIT),
 					name,
 					diff_get_color_opt(&rev.diffopt, DIFF_RESET));
-			read_tree_recursive(the_repository, (struct tree *)o, "",
-					    0, 0, &match_all, show_tree_object,
+			read_tree_recursive(the_repository, (struct tree *)o,
+					    0, &match_all, show_tree_object,
 					    rev.diffopt.file);
 			rev.shown_one = 1;
 			break;
diff --git a/builtin/ls-files.c b/builtin/ls-files.c
index c0349a7b206..2c609428eea 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -483,7 +483,7 @@ void overlay_tree_on_index(struct index_state *istate,
 			       PATHSPEC_PREFER_CWD, prefix, matchbuf);
 	} else
 		memset(&pathspec, 0, sizeof(pathspec));
-	if (read_tree_recursive(the_repository, tree, "", 0, 1,
+	if (read_tree_recursive(the_repository, tree, 1,
 				&pathspec, read_one_entry_quick, istate))
 		die("unable to read tree entries %s", tree_name);
 
diff --git a/builtin/ls-tree.c b/builtin/ls-tree.c
index 7cad3f24ebd..7d3fb2e6d0f 100644
--- a/builtin/ls-tree.c
+++ b/builtin/ls-tree.c
@@ -185,6 +185,6 @@ int cmd_ls_tree(int argc, const char **argv, const char *prefix)
 	tree = parse_tree_indirect(&oid);
 	if (!tree)
 		die("not a tree object");
-	return !!read_tree_recursive(the_repository, tree, "", 0, 0,
+	return !!read_tree_recursive(the_repository, tree, 0,
 				     &pathspec, show_tree, NULL);
 }
diff --git a/merge-recursive.c b/merge-recursive.c
index b052974f191..fa7602ff0f2 100644
--- a/merge-recursive.c
+++ b/merge-recursive.c
@@ -473,7 +473,7 @@ static void get_files_dirs(struct merge_options *opt, struct tree *tree)
 {
 	struct pathspec match_all;
 	memset(&match_all, 0, sizeof(match_all));
-	read_tree_recursive(opt->repo, tree, "", 0, 0,
+	read_tree_recursive(opt->repo, tree, 0,
 			    &match_all, save_files_dirs, opt);
 }
 
diff --git a/tree.c b/tree.c
index c1bde9314d0..285633892c2 100644
--- a/tree.c
+++ b/tree.c
@@ -82,14 +82,12 @@ static int read_tree_1(struct repository *r,
 
 int read_tree_recursive(struct repository *r,
 			struct tree *tree,
-			const char *base, int baselen,
 			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int ret;
 
-	strbuf_add(&sb, base, baselen);
 	ret = read_tree_1(r, tree, &sb, stage, pathspec, fn, context);
 	strbuf_release(&sb);
 	return ret;
diff --git a/tree.h b/tree.h
index 34549c86c9f..9a0fd3221e3 100644
--- a/tree.h
+++ b/tree.h
@@ -33,7 +33,6 @@ typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const c
 
 int read_tree_recursive(struct repository *r,
 			struct tree *tree,
-			const char *base, int baselen,
 			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context);
 
-- 
2.31.0.rc0.126.g04f22c5b82

