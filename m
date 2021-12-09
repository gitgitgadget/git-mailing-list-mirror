Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D367CC433EF
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbhLIFMc (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:12:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230297AbhLIFMU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:12:20 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE0AC0617A2
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:08:47 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id m25-20020a7bcb99000000b0033aa12cdd33so4502017wmi.1
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:08:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=9XEHnnsmJWMBO+mNisk01KWXBk6Ata42T9bb1T8ml7k=;
        b=LliyUTr+ukZSIkCADy/VQrBxrADlFWjNzNUDfV9eYekPZQwOnp9h3YRyk8h/fPkJXT
         l8FHS2CA2tag70ZR+KSRVg1y0Bnuoh70Cf6cx8Wfh2nrw106t4oaiqgdWOkLHecIBYKt
         7y588oGP/fjXzcE2Fy9gW0XAO4Bwh7+YHna1kPdIoH8ZX5DSFZjXhXM/LmxKIsLyfgIH
         mCTyK4MrCCRAQfs1uVnoZ9A1kButDagCn2Q15jTT1c1k+Qj3ltqrmDuCBS6cUu1fzPdJ
         /Uwo1q3YxrLGIkNKVNtsJHRcW7xvDBWrDb1XQFBlwHSehBkvdm2fvtEcx8k9337njdav
         278A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=9XEHnnsmJWMBO+mNisk01KWXBk6Ata42T9bb1T8ml7k=;
        b=zLvqu3hU2E+7x3pdQnjMuH8RkfRZLY+J2QcezHq5JyeP5FLE8Kx0ImWxomSn/pE5Ri
         0TNd0p3ykBhWczFC3UCcIWwc54u/7jpEWzxEv0qZAebEK91NTTFdc4TXgy93W4BCdEqa
         hsOPHgdzDxwL1J4JRD915UqaxbAYaMF0ROClvTyFWfJRo3vOwO4pP9KcREz1WxvG26/d
         DRxCII50V24MMTWZacWV1FCYrowLeLQXPilcM1BRfH/4GJ9haatLSeuOeWoUQtM3makI
         JZbFyMVPPGNNlxw1BFybd/KkKc4CJ1O01o7as14jrcXMYAUj5mzraJ4EY9Ooqe74tCa+
         rHgA==
X-Gm-Message-State: AOAM530yc/anueh2cz+XkzV5pVV6O0/FaojXdGbn2zKkW3cNsvCsMfmM
        oHkRmSbXyv622EqK1umSI5XbdFcbcNc=
X-Google-Smtp-Source: ABdhPJxM7ZrDMykgoDxEbw6k3YrxMnXA/kQx7r7MWAvAIzUhP2EYu/TYyl0+C6Jlux3XiwixCHCETQ==
X-Received: by 2002:a1c:3546:: with SMTP id c67mr4064996wma.43.1639026525811;
        Wed, 08 Dec 2021 21:08:45 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l2sm8079915wmq.42.2021.12.08.21.08.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:08:45 -0800 (PST)
Message-Id: <4a18efd51ef65ee6e4d06ac9dfed5b1645609549.1639026515.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
References: <pull.1140.v5.git.git.1638340854.gitgitgadget@gmail.com>
        <pull.1140.v6.git.git.1639026515.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 09 Dec 2021 05:08:34 +0000
Subject: [PATCH v6 10/11] dir: new flag to remove_dir_recurse() to spare the
 original_cwd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
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

Acked-by: Derrick Stolee <stolee@gmail.com>
Acked-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
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

