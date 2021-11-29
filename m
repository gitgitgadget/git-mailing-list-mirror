Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4469BC433F5
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 23:10:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237480AbhK2XNR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 18:13:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237376AbhK2XMy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 18:12:54 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7BBC041F6A
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:24 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id o13so39953788wrs.12
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 14:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GQ30DFUaFvo+Yk5HfJoAEmTlphSEdk+kZ7EVCDlfifI=;
        b=a+BRP55NivAw+mhaZMsyUisFnDkdpSm3ZIm31HpD4tz89hoSvBHUoN/FQvwwihqohz
         7tbyPTz7sm/ETjfQtKy/NUbgKHQYk/KKK2Avxo/imPGkzurpaUSL11+7Uq+t0X2QaPFt
         G/3LGrvUIS7YAXWnLrRX9nzcZiSu0mcZ5hhWpxNY0Hn+spS4LpG9DFlxLGUfmeCy1vOp
         94ZOFJ7cgI+RbSf/kKQ72EPAAVzgu+kLWaHVpFnpWTaShVTTgubECqFupmYBy26JSg0d
         oNhqr71JtqV4j++TLYV/pBELi21lWNfyxoh7mEhnkxsfFOKHuk51iYvhUBm1fjD7V3HM
         pxVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GQ30DFUaFvo+Yk5HfJoAEmTlphSEdk+kZ7EVCDlfifI=;
        b=A0fG9S7+y+HP4jbLEY5m2SW4V/drkYH7G+wEqbO2bWXFvtSOHnH7coz7xAVv8BtJHz
         Sk4nmCmBxgB9cG0vIc1qZ2UiIpTZ+hDFqn8Cu6P6VzoH14EesnxR7WjQahMkf3aNE+Hm
         6Uo+atOFCx+bWgksC8Y/OPFGnGJElDuB9Dpj1CQSoPPR+ag4ml0ko2CCd2fnywR1IJhC
         1rR42lqVJAgbltG7Ziaasocgny5oQaiFD6U1PkrUcOfh9VP0TzP56mwhfpQ78ySEUGwA
         yWuR23MghuzsUDxX/nJlcBajEAuvbLFE8yzY1Nih97ByjqqitedBGHzRJmRqbo90Rbtm
         JjyA==
X-Gm-Message-State: AOAM532HYMB3nXOjH280L7/waFlZ4e/raKqm3oLfZEoWhQLRX4AMZOjA
        naXbsapzzA8afNdWZ6jI5J/+llnr6lg=
X-Google-Smtp-Source: ABdhPJwNP4gFLz59Z/DVXVIKgw63A7ANoloqi/42uW1ruXlYROXXi+5NsHNloLp1RXjKxUWAclOIwQ==
X-Received: by 2002:a05:6000:1048:: with SMTP id c8mr36243515wrx.352.1638225443179;
        Mon, 29 Nov 2021 14:37:23 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j17sm798613wmq.41.2021.11.29.14.37.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 14:37:22 -0800 (PST)
Message-Id: <d5750fcb6d561f0190ae69ac0065a6971c437c81.1638225434.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
References: <pull.1140.v3.git.git.1637966463.gitgitgadget@gmail.com>
        <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Nov 2021 22:37:13 +0000
Subject: [PATCH v4 10/11] dir: new flag to remove_dir_recurse() to spare the
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
        Derrick Stolee <stolee@gmail.com>,
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
 t/t2501-cwd-empty.sh |  5 -----
 4 files changed, 14 insertions(+), 9 deletions(-)

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
index 30b8ffaa11b..6d8f68c08dd 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -291,11 +291,6 @@ test_submodule_removal () {
 	test_status=
 	test "$path_status" = dir && test_status=test_must_fail
 
-	# Actually, while path_status == dir && test_status=test_must_fail
-	# reflect our desired behavior, current behavior is:
-	path_status=missing
-	test_status=
-
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf .git/modules/my_submodule" &&
 
-- 
gitgitgadget

