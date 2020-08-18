Return-Path: <SRS0=LSsm=B4=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A08C433DF
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:58:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 570292065D
	for <git@archiver.kernel.org>; Tue, 18 Aug 2020 22:58:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R0lZW55w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbgHRW6f (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Aug 2020 18:58:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHRW6a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Aug 2020 18:58:30 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C5CAC061342
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 15:58:30 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id f18so432840wmc.0
        for <git@vger.kernel.org>; Tue, 18 Aug 2020 15:58:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yam7r2zNN8rKKazJNOk1/yqK6+Pz4KqBqKsFUVxsnBk=;
        b=R0lZW55wcz2ST94QPf2N98iWzsbFGjlU35D6UYyOmXqSYZ+ZSqkYRYxy3Fh1bI3ArS
         LCBgSi/kSpQyDuYFvAW7XdhYR1BQ1UKZkmUiOGT+DwoO8a65zPWg/Ylm087JvaPZFj8Q
         NEMmArB4ihy1Pi/jSOrZJv723ACEsyfsZPTWJHAd7PB8TjyubXFl9ulw8OiVrO56fQeL
         wRIW9sAdxZWjzO7EHJH8WZxcauHMBQH91ceJ5Pfjcc+67Yzt0lkixDpOqU93z8r2UvOK
         5NG5t4jUyDQrw1ZSTZJ9kxFH/AI3LuDokzcWOQSCF0WtMbL6JbL68JdqydtSr7mIGA3M
         8aoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yam7r2zNN8rKKazJNOk1/yqK6+Pz4KqBqKsFUVxsnBk=;
        b=cB0o5ms71QfjRnoS891IdwfK37yNVWw9SaJhCrLWT9bB048UEG50TLtB4/niq2uhwr
         gDUnaZkrN4SE4SsOwpMsH5ClfUfVFF+WsIUgIk6akuwZnxpoF0fUKW83Rn3yVa431URh
         LlOxmWb1ZCrpNrub85/gr4HcwVj3hXoX0K1yQEl+Io0VnmmLwsaUFbqy3OngLbmJfnr8
         u7A7sC7VNTPihzu+5nXD2agDmQngNhOULWczWj19qMRaA2fP6DL/rQG8QGC5vCkPqi+t
         5/1I6e4DuvhVqdrtmzwWipf3FHiIq7QzR0QjO5osij+QOgd+nILV37l/ihmUhtVzC3r+
         NQlg==
X-Gm-Message-State: AOAM530iHy5pRPKBRkE8/8vO88hCnbp4z2Cu/SCWpEVW6ik/Rnb9VjeO
        hFc4EhbHdpvSf5Mv9nyeo0Oc59Nrk8M=
X-Google-Smtp-Source: ABdhPJxAYqWw1SuEdu70gK4CTuVhwHuY0hTkU5zavodahftFEmQ9es+mSvz+iyIeO6yMGDe6P+Xd6Q==
X-Received: by 2002:a7b:cf29:: with SMTP id m9mr1964240wmg.88.1597791508671;
        Tue, 18 Aug 2020 15:58:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id p17sm41795513wra.81.2020.08.18.15.58.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2020 15:58:28 -0700 (PDT)
Message-Id: <f890ac027936350df8e2818552485268afd83aa6.1597791506.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.831.v2.git.git.1597791506.gitgitgadget@gmail.com>
References: <pull.831.git.git.1597561152.gitgitgadget@gmail.com>
        <pull.831.v2.git.git.1597791506.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 18 Aug 2020 22:58:25 +0000
Subject: [PATCH v2 1/2] dir: make clear_directory() free all relevant memory
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
this was an oversight, but a number of callers noticed memory leaks and
started free'ing these.  Unfortunately, they did so somewhat haphazardly
(sometimes freeing the entries in the arrays, and sometimes only
free'ing the arrays themselves).  This suggests the callers weren't
trying to make sure any possible memory used might be free'd, but just
the memory they noticed their usecase definitely had allocated.

Fix this mess by moving all the duplicated free'ing logic into
clear_directory().  End by resetting dir to a pristine state so it could
be reused if desired.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 builtin/clean.c |  6 +-----
 builtin/stash.c |  3 ---
 dir.c           | 13 +++++++++++--
 dir.h           |  2 +-
 wt-status.c     |  4 ----
 5 files changed, 13 insertions(+), 15 deletions(-)

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
index fe64be30ed..aa96030031 100644
--- a/dir.c
+++ b/dir.c
@@ -3009,8 +3009,8 @@ int remove_path(const char *name)
 }
 
 /*
- * Frees memory within dir which was allocated for exclude lists and
- * the exclude_stack.  Does not free dir itself.
+ * Frees memory within dir which was allocated, and resets fields for further
+ * use.  Does not free dir itself.
  */
 void clear_directory(struct dir_struct *dir)
 {
@@ -3030,6 +3030,13 @@ void clear_directory(struct dir_struct *dir)
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
@@ -3037,6 +3044,8 @@ void clear_directory(struct dir_struct *dir)
 		stk = prev;
 	}
 	strbuf_release(&dir->basebuf);
+
+	memset(&dir, 0, sizeof(*dir));
 }
 
 struct ondisk_untracked_cache {
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

