Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AF3ECAAD8
	for <git@archiver.kernel.org>; Mon, 29 Aug 2022 20:54:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiH2UyX (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Aug 2022 16:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbiH2UyV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2022 16:54:21 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7070182845
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:20 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id m16so11631287wru.9
        for <git@vger.kernel.org>; Mon, 29 Aug 2022 13:54:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc;
        bh=7B+IpJe/zaczEsI7evqyq9ZQLpHLVvfFYSDHDH0tswQ=;
        b=XBvH3XJN6jApb/LBUUeENySKzjHAUriHj7rr8JzigKTjybQ9dtehV3IDWR0hrW21XZ
         iVcoCjm7pigLfEiC0ngXNnLcC5UdgJVx0XRNitV8DxGyR1qgjDwOi/LLFM+/3Ut/WqTM
         7Ke4rgwr7Hb7PCBYttEQuzxeyziSCcEgYA29VnA7nu4THpHdnIihSNmhzhCiOIG0l7li
         knO+2B2weMAVHV/4IYIPkIsfvwPSrYdIfK62IlxRuOFCbaDtzNZ2CZSYn4FpJJzxkUPB
         3iamEjaRsgcGPx23gv+3fiuJR3dQ+pCvJ85ScvBT8HA44Ry/mNYd520/WEzRZMuvNI8i
         faIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc;
        bh=7B+IpJe/zaczEsI7evqyq9ZQLpHLVvfFYSDHDH0tswQ=;
        b=lP3HUYslfZzUU29ZW5evDT3ctMbJZx1NOdNbvcAipo5KHj+cVvtYKiB9SAThy+t+xN
         w5Ro8hUZyDthqcmcwciYZBgKdSMCGLXjWVIlyHCIb47tqKSCdZecXodyYid7eSk3GoEM
         4qJX1Gox9iOLsvBgwBzi2oEUEii9n/SOC/IAdS5DbAbTj4tX7v+G3/IIkGLIyfc2LZjA
         0wjZKYIroV42mCWLLSz2+lXkDt8oDssi8y4FucjJ9GXY28OwanfTwt22EZ+bPxZccomt
         BfEuhZyh5IjD1EiPvp2RJQSIO47UEHvgxmo5KBPxGv7XY81YbWaCRiWVim0t29ei4lvv
         CJ5Q==
X-Gm-Message-State: ACgBeo01+SUfE/1Mqrbp40nGEWUkk0aOCHtqXn1UBKDdQT/nH/oI5OHH
        R+0gKJrpgm2a/oyZKbQTlFaLT5jZFIU=
X-Google-Smtp-Source: AA6agR4goBKoBnbMfDbAJXIFkCRhJrOPFMwrZkWu4uBybLXxIi7vWWSfQnZOd7UJPmNSjbqXN6Q9ow==
X-Received: by 2002:adf:e502:0:b0:225:8785:eee7 with SMTP id j2-20020adfe502000000b002258785eee7mr7202796wrm.304.1661806458813;
        Mon, 29 Aug 2022 13:54:18 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id bq25-20020a5d5a19000000b0021e519eba9bsm3144797wrb.42.2022.08.29.13.54.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 13:54:18 -0700 (PDT)
Message-Id: <936e237c716bddf3a5889829e0c907e881736336.1661806456.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
References: <pull.1321.git.git.1661806456.gitgitgadget@gmail.com>
From:   "Glen Choo via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Aug 2022 20:54:11 +0000
Subject: [PATCH 1/6] clone: teach --detach option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Philippe Blain <levraiphilippeblain@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Glen Choo <chooglen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Glen Choo <chooglen@google.com>

Teach "git clone" the "--detach" option, which leaves the cloned repo in
detached HEAD (like "git checkout --detach"). If the clone is not bare,
the remote's HEAD branch is also not created (bare clones always copy
all remote branches directly to local branches, so the branch is still
created in the bare case).

This is especially useful in the "submodule.propagateBranches" workflow,
where the submodule branch names match the superproject's branch names,
so it makes no sense to name the branches after the submodule's remote's
branches.

Signed-off-by: Glen Choo <chooglen@google.com>
---
 Documentation/git-clone.txt |  7 ++++++-
 builtin/clone.c             | 12 +++++++++---
 t/t5601-clone.sh            | 22 ++++++++++++++++++++++
 3 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-clone.txt b/Documentation/git-clone.txt
index 632bd1348ea..a3af90824b6 100644
--- a/Documentation/git-clone.txt
+++ b/Documentation/git-clone.txt
@@ -16,7 +16,7 @@ SYNOPSIS
 	  [--depth <depth>] [--[no-]single-branch] [--no-tags]
 	  [--recurse-submodules[=<pathspec>]] [--[no-]shallow-submodules]
 	  [--[no-]remote-submodules] [--jobs <n>] [--sparse] [--[no-]reject-shallow]
-	  [--filter=<filter> [--also-filter-submodules]] [--] <repository>
+	  [--filter=<filter> [--also-filter-submodules] [--detach]] [--] <repository>
 	  [<directory>]
 
 DESCRIPTION
@@ -210,6 +210,11 @@ objects from the source repository into a pack in the cloned repository.
 	`--branch` can also take tags and detaches the HEAD at that commit
 	in the resulting repository.
 
+--detach::
+	If the cloned repository's HEAD points to a branch, point the newly
+	created HEAD to the branch's commit instead of the branch itself. In a
+	non-bare repository, the branch will not be created.
+
 -u <upload-pack>::
 --upload-pack <upload-pack>::
 	When given, and the repository to clone from is accessed
diff --git a/builtin/clone.c b/builtin/clone.c
index c4ff4643ecd..1bc1807360e 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -77,6 +77,7 @@ static int option_filter_submodules = -1;    /* unspecified */
 static int config_filter_submodules = -1;    /* unspecified */
 static struct string_list server_options = STRING_LIST_INIT_NODUP;
 static int option_remote_submodules;
+static int option_detach;
 
 static int recurse_submodules_cb(const struct option *opt,
 				 const char *arg, int unset)
@@ -160,6 +161,8 @@ static struct option builtin_clone_options[] = {
 		    N_("any cloned submodules will use their remote-tracking branch")),
 	OPT_BOOL(0, "sparse", &option_sparse_checkout,
 		    N_("initialize sparse-checkout file to include only files at root")),
+	OPT_BOOL(0, "detach", &option_detach,
+		 N_("detach HEAD and don't create branch")),
 	OPT_END()
 };
 
@@ -607,10 +610,12 @@ static void update_remote_refs(const struct ref *refs,
 }
 
 static void update_head(const struct ref *our, const struct ref *remote,
-			const char *unborn, const char *msg)
+			const char *unborn, int should_detach,
+			const char *msg)
 {
 	const char *head;
-	if (our && skip_prefix(our->name, "refs/heads/", &head)) {
+	if (our && !should_detach &&
+	    skip_prefix(our->name, "refs/heads/", &head)) {
 		/* Local default branch link */
 		if (create_symref("HEAD", our->name, NULL) < 0)
 			die(_("unable to update HEAD"));
@@ -1339,7 +1344,8 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 			   branch_top.buf, reflog_msg.buf, transport,
 			   !is_local);
 
-	update_head(our_head_points_at, remote_head, unborn_head, reflog_msg.buf);
+	update_head(our_head_points_at, remote_head, unborn_head,
+		    option_detach, reflog_msg.buf);
 
 	/*
 	 * We want to show progress for recursive submodule clones iff
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index cf3be0584f4..1e7e5143a76 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -333,6 +333,28 @@ test_expect_success 'clone checking out a tag' '
 	test_cmp fetch.expected fetch.actual
 '
 
+test_expect_success '--detach detaches and does not create branch' '
+	test_when_finished "rm -fr dst" &&
+	git clone --detach src dst &&
+	(
+		cd dst &&
+		test_must_fail git rev-parse main &&
+		test_must_fail git symbolic-ref HEAD &&
+		test_cmp_rev HEAD refs/remotes/origin/HEAD
+	)
+'
+
+test_expect_success '--detach with --bare detaches but creates branch' '
+	test_when_finished "rm -fr dst" &&
+	git clone --bare --detach src dst &&
+	(
+		cd dst &&
+		git rev-parse main &&
+		test_must_fail git symbolic-ref HEAD &&
+		test_cmp_rev HEAD refs/heads/main
+	)
+'
+
 test_expect_success 'set up ssh wrapper' '
 	cp "$GIT_BUILD_DIR/t/helper/test-fake-ssh$X" \
 		"$TRASH_DIRECTORY/ssh$X" &&
-- 
gitgitgadget

