Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64765C433EF
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:06:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4353561175
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 02:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237421AbhKICJP (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Nov 2021 21:09:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbhKICJO (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Nov 2021 21:09:14 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F163C061570
        for <git@vger.kernel.org>; Mon,  8 Nov 2021 18:06:29 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d5so30238689wrc.1
        for <git@vger.kernel.org>; Mon, 08 Nov 2021 18:06:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=xdjj+qmXXr/T0ysERiC+N3LNh1Szj9dfU9JPj1qpYts=;
        b=NIjuZePlAWBbt50IEeI7jly/DhVjLn5V2fIlXttqYuVXZGlrQXGnXpR0kn4bIeHKFa
         CoXq532P9eu5w/6H1orLQAvRT628Z2QcKyysjtsGH58hWiFrVbsrOZJa/P3Eg7HMJsMY
         SHq8wKLCr0rKwZLNus7M3Yt7kRgHMrqM/CpVEHsH8GmJQDqxDTG1AKlatYipMHp6ip7S
         5JGDHBoRgIRLEdIJmnq4fws3oWUibDoz9i1UfdGe3brxMGvlsaOvn9rMLcikMNX+QLSr
         srhNbPL7BIiODFNuB3/JCQSVhCum/P7juVFAxRRUfAg3vxVrfTkFcpWAqeCBXMIjhMui
         CoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=xdjj+qmXXr/T0ysERiC+N3LNh1Szj9dfU9JPj1qpYts=;
        b=mY77osITLxSX8q/HQ0HYuxBjAt+Kc9DiGFBixPfdOOYkIqRDB2pdp8Vk1daTxZvUBE
         PBGPIZMDu70lZMGkRbQkfCu32UaxBDJ8n/Vq4552uJHBRfp54dxVelbRWHd54nI02YLq
         sczOsGMQ2qmDDFVbj1D0/uFXle93thmOSOExKRDITRkbtUgq2hQcy8bZzFWLAuZPX7OY
         ZSbG6RDJ6W/qWpYjXo/h9oaIOQTdy/Fv+tCrde6z5S0MvLp8MpWMicMBveBZRKGCq4mr
         tha1CO0xnKpHilT1KTztAfX6ajD+atak9dEVQ7YgNmF83MWg+33IjGz7v2IybveYwo+n
         TkCg==
X-Gm-Message-State: AOAM530KS1i3BppT5tnRSI0/kz4xbZ0NqJVzEckTLO+uvoHO+Ekb3OKP
        4LXHLi+x2U4KCPP7d0+trEpVIdhrHCg=
X-Google-Smtp-Source: ABdhPJzehnc/uLePAr9eUF299wPYZ2FmcQ00U3j/7xnRJTk2TTLrul9aOKrXrLZP/4FJM9kwOmTGEw==
X-Received: by 2002:a5d:6e8c:: with SMTP id k12mr4630007wrz.401.1636423587630;
        Mon, 08 Nov 2021 18:06:27 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o5sm4164564wrx.83.2021.11.08.18.06.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Nov 2021 18:06:27 -0800 (PST)
Message-Id: <pull.1127.git.git.1636423586620.gitgitgadget@gmail.com>
From:   "Samuel Yvon via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 09 Nov 2021 02:06:26 +0000
Subject: [PATCH] builtin-commit: re-read file index before launching editor
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Samuel Yvon <samuelyvon9@gmail.com>,
        Samuel Yvon <samuelyvon9@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Samuel Yvon <samuelyvon9@gmail.com>

Changes made within a pre-commit hook are not reflected within
the editor (for instance, with `git commit --verbose`) because
the index is re-read after the editor has been used.

This has the consequence of not displaying the actual changes made
by the pre-commit hook, but committing them anyways.

While it is often argued that the hook's purpose is not to automatically
write content to the repository, it is acknowledged that using the
pre-commit to apply mechanical fixes on top of the existing changes
is a supported use case, along with verifying the content.

I think not seeing these mechanical fixes before commiting is incorrect.
A developer might expect the commit to look a certain way but if the
pre-commit goes wrong the invalid changes will go unnoticed until
committed.

Signed-off-by: Samuel Yvon <samuelyvon9@gmail.com>
---
    builtin-commit: Re-read file index before launching editor
    
    Changes made within a pre-commit hook are not reflected within the
    editor (for instance, with git commit --verbose) because the index is
    re-read after the editor has been used.
    
    This has the consequence of not displaying the actual changes made by
    the pre-commit hook, but committing them anyways.
    
    While it is often argued that the hook's purpose is not to automatically
    write content to the repository, it is acknowledged that using the
    pre-commit to apply mechanical fixes on top of the existing changes is a
    supported use case, along with verifying the content.
    
    I think not seeing these mechanical fixes before commiting is incorrect.
    A developer might expect the commit to look a certain way but if the
    pre-commit goes wrong the invalid changes will go unnoticed until
    committed.
    
    I had a small exchange in the Google Group before submitting this Pr.
    Here is a link for cross-referencing:
    https://groups.google.com/g/git-mentoring/c/FsP83I9mN6c
    
    As a side note, I do not know who manages the Github Repo but the
    following description threw me off a little bit:
    
    Git Source Code Mirror - This is a publish-only repository and all pull requests are ignored. 
    
    
    since after looking deeper it seems the PRs are not ignored.
    
    Signed-off-by: Samuel Yvon samuelyvon9@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1127%2FSamuelYvon%2Fmaint-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1127/SamuelYvon/maint-v1
Pull-Request: https://github.com/git/git/pull/1127

 builtin/commit.c | 21 +++++++++++----------
 1 file changed, 11 insertions(+), 10 deletions(-)

diff --git a/builtin/commit.c b/builtin/commit.c
index 7c9b1e7be3a..e75b11d1c60 100644
--- a/builtin/commit.c
+++ b/builtin/commit.c
@@ -728,8 +728,17 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 	/* This checks and barfs if author is badly specified */
 	determine_author_info(author_ident);
 
-	if (!no_verify && run_commit_hook(use_editor, index_file, "pre-commit", NULL))
-		return 0;
+	if (!no_verify && find_hook("pre-commit")) {
+		if(run_commit_hook(use_editor, index_file, "pre-commit", NULL))
+			return 0;
+
+		/*
+		 * Re-read the index as pre-commit hook could have updated it,
+		 * and write it out as a tree.
+		 */
+		discard_cache();
+		read_cache_from(index_file);
+	}
 
 	if (squash_message) {
 		/*
@@ -1051,14 +1060,6 @@ static int prepare_to_commit(const char *index_file, const char *prefix,
 		return 0;
 	}
 
-	if (!no_verify && find_hook("pre-commit")) {
-		/*
-		 * Re-read the index as pre-commit hook could have updated it,
-		 * and write it out as a tree.  We must do this before we invoke
-		 * the editor and after we invoke run_status above.
-		 */
-		discard_cache();
-	}
 	read_cache_from(index_file);
 
 	if (update_main_cache_tree(0)) {

base-commit: 5fbd2fc5997dfa4d4593a862fe729b1e7a89bcf8
-- 
gitgitgadget
