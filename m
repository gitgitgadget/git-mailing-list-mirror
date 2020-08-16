Return-Path: <SRS0=m/NF=B2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BBD8C433E3
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 06:59:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3564F2065C
	for <git@archiver.kernel.org>; Sun, 16 Aug 2020 06:59:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5MBHfVH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729481AbgHPG7S (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 16 Aug 2020 02:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728364AbgHPG7Q (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 16 Aug 2020 02:59:16 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2E18C061786
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 23:59:15 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id r15so1925964wrp.13
        for <git@vger.kernel.org>; Sat, 15 Aug 2020 23:59:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=IxJdTKCZwVzThoMxWIXx9IZir8S1e+YUZRU8upg7dvs=;
        b=R5MBHfVH8r/W8H9IsQRVbYqyV5JAHeenvzBEKf/UcvP+OQIi2lWCQEnRteI3zwoThf
         77UWa41aGWvnpgPKNJ7ffkIPUVq1IBWNRG3uaClses1Aa4gSvmsxbpCQPgQE7MOHG0O+
         2xFVuTrN7N+wSIw2No8l8sDlb1aOFNuNEpQp+jHj2LV2xOv0cRvfI+eXmUIYas8Klgkh
         TvYqs/c48k3LEfu6pgKqQGk4TbJu2g2W4tGjgECYRlRuYjgCqMwW9n3vUAC4sd60HqSt
         bAnrUVRB6fqu1PzWmMWltz3KiXk4s3dVqUZoDNtSJdcVVZXqBXqmQITit9gzU7OS/onY
         ydYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=IxJdTKCZwVzThoMxWIXx9IZir8S1e+YUZRU8upg7dvs=;
        b=WRicutfRx5MQHR7b3rnBV3bkSPFT/qQCxodIzDlsEdkluebZUQRZ7SQyBQ4q2UrPci
         nii0upSN8FfMQB0YBfOxIEakpy9O60tr2ejKIv9jRUCl+t81VG+2oyhV++NhpGBKbBQ5
         Lc3fLAVCxOMFgp5nx25W8vX1Rq1X5ho85VNsV6k8+UhK0ZzAbGhGbHmQ20StE2Byyd5u
         Bg5+IgQLLuIVpWBq9iweDBTJ7Y9fxYyWSCL3Sf0yHwrC/V0wVBq+jVyJ+bb7zK26VprE
         ANNavIdyKjV1+VMDxjNr83zmvdWAFrFAMS5/sdku+W7q+z2Fckcu1dqkUC7Zy3KGTx9O
         VDQA==
X-Gm-Message-State: AOAM530ysE2HZsbLSNX7cz23jUp5Io1onkyoAJL+Mii5CDbv8f4Iky5N
        kYiecKZ1H7P0iDaV9JXkGtf/h9BDVWY=
X-Google-Smtp-Source: ABdhPJynbVtU0R9605q6V3RD7AqlrxdaWfF8+Y26RMCElSPG7IX2Cmg+EwddYPFFWXoYTvH7RbO+TQ==
X-Received: by 2002:a5d:5710:: with SMTP id a16mr10208267wrv.217.1597561154574;
        Sat, 15 Aug 2020 23:59:14 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm23979542wmc.28.2020.08.15.23.59.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Aug 2020 23:59:14 -0700 (PDT)
Message-Id: <068e097e22fa42b79e70b0346cc7460f1a3cbcff.1597561152.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 16 Aug 2020 06:59:10 +0000
Subject: [PATCH 2/3] dir: make clear_directory() free all relevant memory
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

The calling convention for the dir API is supposed to end with a call to
clear_directory() to free up no longer needed memory.  However,
clear_directory() didn't free dir->entries or dir->ignored.  I believe
this was oversight, but a number of callers noticed memory leaks and
started free'ing these, but often somewhat haphazardly (sometimes
freeing the entries in the arrays, and sometimes only free'ing the
arrays themselves).  This suggests the callers weren't trying to make
sure any possible memory used might be free'd, but just the memory they
noticed their usecase definitely had allocated.  This also caused the
extra memory deallocations to be duplicated in many places.

Fix this mess by moving all the duplicated free'ing logic into
clear_directory().

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c |  6 +-----
 builtin/stash.c |  3 ---
 dir.c           | 12 ++++++++----
 dir.h           |  2 +-
 wt-status.c     |  4 ----
 5 files changed, 10 insertions(+), 17 deletions(-)

diff --git a/builtin/clean.c b/builtin/clean.c
index 5a9c29a558..4ffe00dd7f 100644
--- a/builtin/clean.c
+++ b/builtin/clean.c
@@ -1021,11 +1021,7 @@ int cmd_clean(int argc, const char **argv, const char *prefix)
 		string_list_append(&del_list, rel);
 	}
 
-	for (i = 0; i < dir.nr; i++)
-		free(dir.entries[i]);
-
-	for (i = 0; i < dir.ignored_nr; i++)
-		free(dir.ignored[i]);
+	clear_directory(&dir);
 
 	if (interactive && del_list.nr > 0)
 		interactive_main_loop();
diff --git a/builtin/stash.c b/builtin/stash.c
index 10d87630cd..da48533d49 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -875,11 +875,8 @@ static int get_untracked_files(const struct pathspec *ps, int include_untracked,
 		strbuf_addstr(untracked_files, ent->name);
 		/* NUL-terminate: will be fed to update-index -z */
 		strbuf_addch(untracked_files, '\0');
-		free(ent);
 	}
 
-	free(dir.entries);
-	free(dir.ignored);
 	clear_directory(&dir);
 	return found;
 }
diff --git a/dir.c b/dir.c
index 08df469bf7..b136c037d9 100644
--- a/dir.c
+++ b/dir.c
@@ -3012,10 +3012,7 @@ int remove_path(const char *name)
 	return 0;
 }
 
-/*
- * Frees memory within dir which was allocated for exclude lists and
- * the exclude_stack.  Does not free dir itself.
- */
+/* Frees memory within dir which was allocated.  Does not free dir itself. */
 void clear_directory(struct dir_struct *dir)
 {
 	int i, j;
@@ -3034,6 +3031,13 @@ void clear_directory(struct dir_struct *dir)
 		free(group->pl);
 	}
 
+	for (i = 0; i < dir->ignored_nr; i++)
+		free(dir->ignored[i]);
+	for (i = 0; i < dir->nr; i++)
+		free(dir->entries[i]);
+	free(dir->ignored);
+	free(dir->entries);
+
 	stk = dir->exclude_stack;
 	while (stk) {
 		struct exclude_stack *prev = stk->prev;
diff --git a/dir.h b/dir.h
index 5855c065a6..7d76d0644f 100644
--- a/dir.h
+++ b/dir.h
@@ -36,7 +36,7 @@
  *
  * - Use `dir.entries[]`.
  *
- * - Call `clear_directory()` when none of the contained elements are no longer in use.
+ * - Call `clear_directory()` when the contained elements are no longer in use.
  *
  */
 
diff --git a/wt-status.c b/wt-status.c
index d75399085d..c00ea3e06a 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -724,18 +724,14 @@ static void wt_status_collect_untracked(struct wt_status *s)
 		struct dir_entry *ent = dir.entries[i];
 		if (index_name_is_other(istate, ent->name, ent->len))
 			string_list_insert(&s->untracked, ent->name);
-		free(ent);
 	}
 
 	for (i = 0; i < dir.ignored_nr; i++) {
 		struct dir_entry *ent = dir.ignored[i];
 		if (index_name_is_other(istate, ent->name, ent->len))
 			string_list_insert(&s->ignored, ent->name);
-		free(ent);
 	}
 
-	free(dir.entries);
-	free(dir.ignored);
 	clear_directory(&dir);
 
 	if (advice_status_u_option)
-- 
gitgitgadget

