Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A56CBC433EF
	for <git@archiver.kernel.org>; Thu, 25 Nov 2021 08:42:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353830AbhKYIpY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Nov 2021 03:45:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349985AbhKYInU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Nov 2021 03:43:20 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A987C0613F3
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id u1so9836544wru.13
        for <git@vger.kernel.org>; Thu, 25 Nov 2021 00:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=qJm6PilFjX46tbJSQL7+uesjaprEBsYLqIkvPEue6kM=;
        b=QSQz5i9Up76p4TgeUSiGkdlaN7HOOWyGvJzGIfcCmYfJ4yQs5WLcNF3VLhJ/1chkxe
         53/Y938PDggPHIOaRPTVSzz3MB9Y3N30JY3J+KnVfkCrvXMHYRe+pGr1pGBo23sR9WJw
         6vs6M4FYu26OCkHglnmh55S6pDGkrR3o475taB924xyxgjpEt86kJax5TfDnwaYZyL6z
         OCh30Rp4imiJKf4tj6P10Sq7wRWUm2SQMnJEKfCTR12fkxnFr6rBiyZlW+cVVNA/Uatg
         YWkRWDyLkB6s4/6K2auuR/QhEMSgzd94li6HRqguvfehnnI6/X0Rzi7s3t5mIriKxa4r
         okxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=qJm6PilFjX46tbJSQL7+uesjaprEBsYLqIkvPEue6kM=;
        b=pyT83zDa53wUEdg2gM85mUMBUy43aIM6vuMik1zXl95gSHnnxKnn0gyjYlOg3BfC1u
         ad7IMsXVGYRkBHYH68l2aUBWne47LG8vBBVx3/CEWgjVMdEgmaf3mDUOb5Dgy9am9/pu
         p2Srxi2a7W17SAU8fBJx5gZ1B7xG8Gc0qGeaVlY6FNvC6WjLRGr5KYAL0LTQ8PJrr3Ok
         GNm5SM2o4q2SnxkgdUkyUMUumaqHSgMrskoDw+B6T4pEp5BgyiPkXhEwvB7DBJ5lt2w7
         wvUKkletXD8UaCNIV5ZONNZ4qk7WilQOw38PHW1lPpYPvMmd6NvYlBXiET4kei81iUiC
         RQWA==
X-Gm-Message-State: AOAM531jeCNp5HJIfTTLiU4J8THOMNNMnKFpBun1eXzNFQbviwGpBKJ+
        bIHfzPDmBlq+t+OmV4WbLJBKgmT5MGs=
X-Google-Smtp-Source: ABdhPJzvvYiMVs9nh6Jc2kn5yE5QLaopTdooL+si6MOiQB4Ro1H/JA1ZzClwYTH+5sioC+dfpCzygw==
X-Received: by 2002:adf:f20f:: with SMTP id p15mr4423614wro.187.1637829567676;
        Thu, 25 Nov 2021 00:39:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y15sm2621342wry.72.2021.11.25.00.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Nov 2021 00:39:27 -0800 (PST)
Message-Id: <adaad7aeaac20357f1b83d21085257b8b8fe4591.1637829556.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
References: <pull.1140.git.git.1637455620.gitgitgadget@gmail.com>
        <pull.1140.v2.git.git.1637829556.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 25 Nov 2021 08:39:16 +0000
Subject: [PATCH v2 9/9] dir: new flag to remove_dir_recurse() to spare the
 original_cwd
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Elijah Newren <newren@gmail.com>,
        Glen Choo <chooglen@google.com>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

remove_dir_recurse(), and its non-static wrapper called
remove_dir_recursively(), both take flags for modifying its behavior.
As with the previous commits, we would generally like to protect
the original_cwd, but we want to forced user commands (e.g. 'git rm -rf
...') or other special cases to remove it.  Add a flag for this purpose.
After reading through every caller of remove_dir_recursively() in the
current codebase, there was only one that should be adjusted and that
one only in a very unusual circumstance.  Add a pair of new testcases to
highlight that very specific case involving submodules && --git-dir &&
--work-tree.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/rm.c         |  3 ++-
 dir.c                | 12 +++++++++---
 dir.h                |  3 +++
 t/t2501-cwd-empty.sh | 42 ++++++++++++++++++++++++++++++++++++++++++
 4 files changed, 56 insertions(+), 4 deletions(-)

diff --git a/builtin/rm.c b/builtin/rm.c
index 3d0967cdc11..b4132e5d8ee 100644
--- a/builtin/rm.c
+++ b/builtin/rm.c
@@ -399,12 +399,13 @@ int cmd_rm(int argc, const char **argv, const char *prefix)
 	if (!index_only) {
 		int removed = 0, gitmodules_modified = 0;
 		struct strbuf buf = STRBUF_INIT;
+		int flag = force ? REMOVE_DIR_PURGE_ORIGINAL_CWD : 0;
 		for (i = 0; i < list.nr; i++) {
 			const char *path = list.entry[i].name;
 			if (list.entry[i].is_submodule) {
 				strbuf_reset(&buf);
 				strbuf_addstr(&buf, path);
-				if (remove_dir_recursively(&buf, 0))
+				if (remove_dir_recursively(&buf, flag))
 					die(_("could not remove '%s'"), path);
 
 				removed = 1;
diff --git a/dir.c b/dir.c
index 97d6b71c872..52064345a6b 100644
--- a/dir.c
+++ b/dir.c
@@ -3204,6 +3204,7 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	int ret = 0, original_len = path->len, len, kept_down = 0;
 	int only_empty = (flag & REMOVE_DIR_EMPTY_ONLY);
 	int keep_toplevel = (flag & REMOVE_DIR_KEEP_TOPLEVEL);
+	int purge_original_cwd = (flag & REMOVE_DIR_PURGE_ORIGINAL_CWD);
 	struct object_id submodule_head;
 
 	if ((flag & REMOVE_DIR_KEEP_NESTED_GIT) &&
@@ -3259,9 +3260,14 @@ static int remove_dir_recurse(struct strbuf *path, int flag, int *kept_up)
 	closedir(dir);
 
 	strbuf_setlen(path, original_len);
-	if (!ret && !keep_toplevel && !kept_down)
-		ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
-	else if (kept_up)
+	if (!ret && !keep_toplevel && !kept_down) {
+		if (!purge_original_cwd &&
+		    startup_info->original_cwd &&
+		    !strcmp(startup_info->original_cwd, path->buf))
+			ret = -1; /* Do not remove current working directory */
+		else
+			ret = (!rmdir(path->buf) || errno == ENOENT) ? 0 : -1;
+	} else if (kept_up)
 		/*
 		 * report the uplevel that it is not an error that we
 		 * did not rmdir() our directory.
diff --git a/dir.h b/dir.h
index d6a5d03bec2..8e02dfb505d 100644
--- a/dir.h
+++ b/dir.h
@@ -495,6 +495,9 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
 /* Remove the contents of path, but leave path itself. */
 #define REMOVE_DIR_KEEP_TOPLEVEL 04
 
+/* Remove the_original_cwd too */
+#define REMOVE_DIR_PURGE_ORIGINAL_CWD 0x08
+
 /*
  * Remove path and its contents, recursively. flags is a combination
  * of the above REMOVE_DIR_* constants. Return 0 on success.
diff --git a/t/t2501-cwd-empty.sh b/t/t2501-cwd-empty.sh
index 4362e7b15e5..8da3fb1f5d3 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -252,4 +252,46 @@ test_expect_success 'stash does not remove cwd incidentally' '
 	test_path_is_dir untracked
 '
 
+test_expect_success 'rm -r leaves submodule if cwd inside' '
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf .git/modules/my_submodule" &&
+
+	git checkout foo/bar/baz &&
+
+	git init my_submodule &&
+	touch my_submodule/file &&
+	git -C my_submodule add file &&
+	git -C my_submodule commit -m "initial commit" &&
+	git submodule add ./my_submodule &&
+	git commit -m "Add the submodule" &&
+
+	(
+		cd my_submodule &&
+		test_must_fail git --git-dir=../.git --work-tree=.. rm -r ../my_submodule/
+	) &&
+
+	test_path_is_dir my_submodule
+'
+
+test_expect_success 'rm -rf removes submodule even if cwd inside' '
+	test_when_finished "git reset --hard HEAD~1" &&
+	test_when_finished "rm -rf .git/modules/my_submodule" &&
+
+	git checkout foo/bar/baz &&
+
+	git init my_submodule &&
+	touch my_submodule/file &&
+	git -C my_submodule add file &&
+	git -C my_submodule commit -m "initial commit" &&
+	git submodule add ./my_submodule &&
+	git commit -m "Add the submodule" &&
+
+	(
+		cd my_submodule &&
+		git --git-dir=../.git --work-tree=.. rm -rf ../my_submodule/
+	) &&
+
+	test_path_is_missing my_submodule
+'
+
 test_done
-- 
gitgitgadget
