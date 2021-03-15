Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CA8C433E6
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FE7A64F60
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232677AbhCOXoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbhCOXoG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:44:06 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA298C06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:05 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id o16so6544000wrn.0
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IR/z7EPzNg2DTosS0lyrv6vDKrPO0p/omRoYJ2ykXPQ=;
        b=TF98G202q1H9XQRWsJTwcpgSJIAMTgoWl+lTT37hf76ufQTC8IksbM8YSPSVH6dShx
         kCmT9zyNtnYzy+y3tUXPOPJ2QfqTVgyO1rXmI5f4Rr2mjpMh1Em33vURz3hqN8gQwmSj
         tUGRoUuQoH643PrUXVPG8JAlHMoOFOGnPRtIOcPUFdlDSzAo5Ra3YelCby6yz2DorsIo
         v5sjv3QzvpKeYzTmDHZp13p1aF5wGyvMW//RVbpKjQuz42UfCm0q27UtYtHjohPn+j6Z
         AJXNY73KYdu1BRckFFe1iVGCDnIh+QEDh9+FF7eLSIhkuWWFp4I5L5joF3P6MdcWC0CQ
         jQ7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IR/z7EPzNg2DTosS0lyrv6vDKrPO0p/omRoYJ2ykXPQ=;
        b=seN6AOAnDK3Rh3PZwzp86zrihvPA5YWnM/SqDw0IOiy4X2GXItiJ2sd62poROEdD9T
         AstO3HQS5C3x1/0QOM6kUITRKyoY0PYKjSGeLTw9mAwtKxQwUBt02WAXA6151SfwK1OQ
         4jLXWALQoOFkdpM2tABzp6MfeZBGNsc/9b8+raDhe7NjR0jAnAO2WYe3MDR/50Gwen6B
         aoKEiGzvIa99FpabwsieNUEDq2nd7T2/sbQKJwV16i6GfQN8TevfhZQYbHPqjSg0MbB3
         Lvaut5K1Eztd98U1zq+tldt7nV9O2k6f0S9//2y9prPDufjdTD+kmi8zzqdlwCpLz7su
         CD6g==
X-Gm-Message-State: AOAM5323OggciV2XbYdmlU0PEtqxn5t+jZAHXg3lfIafRjiq1gfrvvo5
        1TijiSQwLgiLfaPV8GvYMxuYUzdTVbUMfg==
X-Google-Smtp-Source: ABdhPJxg2xzfuvYeMMVyVGI4xFZBoQ4j+rejlmgzNxRosekyVCTwdEpFYJNmIePLM4DavIHbJ/y46Q==
X-Received: by 2002:a5d:6807:: with SMTP id w7mr1856983wru.103.1615851844315;
        Mon, 15 Mar 2021 16:44:04 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm20417268wrt.70.2021.03.15.16.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:44:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 5/9] tree.h API: remove support for starting at prefix != ""
Date:   Tue, 16 Mar 2021 00:43:40 +0100
Message-Id: <20210315234344.28427-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Every caller of the read_tree_recursive() function hardcoded a
starting point of "" in the tree. So let's simply remove that
parameter.

The last function to call read_tree_recursive() with a non-"" path was
read_tree_recursive() itself, but that was changed in
ffd31f661d5 (Reimplement read_tree_recursive() using
tree_entry_interesting(), 2011-03-25).

As it turns out (Murphy's law and all) we're just about to gain a new
in-tree user that would need this parameter[1]. Let's remove it anyway
as the common case is going to be to not supply it, A later commit
will bring back this functionality in different form.

1. https://lore.kernel.org/git/xmqqft106sok.fsf@gitster.g/

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
index db53e2c8e6d..cd432ac03cd 100644
--- a/builtin/ls-files.c
+++ b/builtin/ls-files.c
@@ -523,7 +523,7 @@ void overlay_tree_on_index(struct index_state *istate,
 
 	if (!fn)
 		fn = read_one_entry_quick;
-	err = read_tree_recursive(the_repository, tree, "", 0, 1, &pathspec, fn, istate);
+	err = read_tree_recursive(the_repository, tree, 1, &pathspec, fn, istate);
 	if (err)
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
index a6c12f2745a..04eb11aed31 100644
--- a/tree.c
+++ b/tree.c
@@ -83,14 +83,12 @@ static int read_tree_1(struct repository *r,
 
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
index 6b0b1dc211a..5252b5139dd 100644
--- a/tree.h
+++ b/tree.h
@@ -35,7 +35,6 @@ typedef int (*read_tree_fn_t)(const struct object_id *, struct strbuf *, const c
 
 int read_tree_recursive(struct repository *r,
 			struct tree *tree,
-			const char *base, int baselen,
 			int stage, const struct pathspec *pathspec,
 			read_tree_fn_t fn, void *context);
 #endif /* TREE_H */
-- 
2.31.0.rc2.211.g1d0b8788b3

