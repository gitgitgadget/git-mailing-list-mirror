Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26051C433EF
	for <git@archiver.kernel.org>; Wed,  1 Dec 2021 06:41:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346999AbhLAGof (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Dec 2021 01:44:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347005AbhLAGo1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Dec 2021 01:44:27 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6AC5C06175A
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:05 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id q3so26939508wru.5
        for <git@vger.kernel.org>; Tue, 30 Nov 2021 22:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=o4h+3a7yRw+c3FD46JIvqGnMPi7Qm5sDmzrze/V2zW8=;
        b=pbc6bSIIDp40wi+2F9vSpjjyHtTzIHLGgzIunEMfV3KB/UgzNwgp26YprzyIzWh82+
         3wKkhIpMbeLrRkmAXK3nhxQrsq8tT94pPdQPhLVIAfTbE8g375DgM3DjLqgoFReDVLYa
         eVKIu6AzFBLiVHqDNn/Mvz8ZbkJmXu23wiQjuONkee8bVH1IY6N1vl5NWny4LMBYlZ4R
         x/XkeUbAVHHuIBjp+rEO8GHxDBkAQ7l1HfIFV65PK1Tg2ENcabEZY4J3oNg1slbkAREm
         ggF8XLcJ/8LJuvXgfAB6jVRLq2xLiizgoZiriMUY1/MQLTZ2ch2I2DtkZL23fxfVmmgP
         Eh1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=o4h+3a7yRw+c3FD46JIvqGnMPi7Qm5sDmzrze/V2zW8=;
        b=j1250uXtn/zyCfmf6qx1BPClFlsnnxQj/vEpsH+ZRX8CO+qJmQLbD4E1dZTNByWBuA
         iCo3/iGjXBBd6PDI1AgMWdmrMkKE2JXtQwmk/uelqZGG/YwmGV35xg0gufQhH5PW7YAa
         od6gs4ish0j2uK5BBjaAHKG02noyd3/8E7mF4NxMO2Ys+vamMfIrjW5V1MCxw5CBQjiu
         tKujrinPy1lDC0RrPPs05YEvDKpg0HNJ+e7xtzzg5fsLei8iE0vJLFvkokiCu/QHplGR
         +88ZbphFyCAc1ZmbjyfuSSTR4Ako0K9rbnaz3KK4p3oamaLvfFL1h6Rt79s2zwHZUoOC
         4fVw==
X-Gm-Message-State: AOAM533yPJYCQTUwDHy5Pa7Jv/wdjZndGXmEQ1sQqsry+2q1LJs7/SpQ
        +f7hBb7hpxKBTQeu1oo9ThDXuyjNexU=
X-Google-Smtp-Source: ABdhPJwM9S3WZmPuDyTwTGiQpbbqKOOuTjaECAlVRIzjFc7wT3VgDZ3vrEv7nZ5366JKRR9Wdo/tUA==
X-Received: by 2002:adf:ce8b:: with SMTP id r11mr4482213wrn.294.1638340864435;
        Tue, 30 Nov 2021 22:41:04 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 4sm24107555wrz.90.2021.11.30.22.41.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Nov 2021 22:41:04 -0800 (PST)
Message-Id: <fe47c0f0c174a7571a76149e144c036d99a46b98.1638340854.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
References: <pull.1140.v4.git.git.1638225434.gitgitgadget@gmail.com>
        <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Dec 2021 06:40:53 +0000
Subject: [PATCH v5 10/11] dir: new flag to remove_dir_recurse() to spare the
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
        Eric Sunshine <sunshine@sunshineco.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
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
index ce2efb9d30a..bc92230f2f2 100755
--- a/t/t2501-cwd-empty.sh
+++ b/t/t2501-cwd-empty.sh
@@ -291,11 +291,6 @@ test_submodule_removal () {
 	test_status=
 	test "$path_status" = dir && test_status=test_must_fail
 
-	# Actually, while path_status=dir && test_status=test_must_fail
-	# reflect our desired behavior, current behavior is:
-	path_status=missing
-	test_status=
-
 	test_when_finished "git reset --hard HEAD~1" &&
 	test_when_finished "rm -rf .git/modules/my_submodule" &&
 
-- 
gitgitgadget

