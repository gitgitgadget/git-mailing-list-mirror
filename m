Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E05EC4167B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:47:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0B9823BC6
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 19:47:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387900AbgLITnG (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 14:43:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387859AbgLITm4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 14:42:56 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CE55C0617A7
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 11:41:36 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id a12so3024990wrv.8
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 11:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=koxMBDcb1fAdRxwvk1liqoKIKXbP2FQzrjy1Xyv+aiA=;
        b=WElcu2yqQg5/F0FFpZAAIRXNUlluEIAxGJGw9fEO81fPLWOAQv1ysIUrIV0fDuSitp
         ynUzyKVHZfudw2WBbFqYUw+PCYdSIhaNfBcGqrtqMntq5si1WRsTGjXOd4rJu9eD4Hmg
         gFps9Sc2YFHh7WBXPqqPE13b/QH8ScpFR6yFoV0UvLRlxvC+DL90YhVrmgWhDbef8WU0
         eW+9U9z6YJe7rNj+1d5CwZ3mz1uc7mlCwvfDLHKnc7fYfpLFJEBrwvAjtWrevh+5CkXO
         smM0zOxBfS02/aaoYeWZHtMKXa1abaHNlPRI+7G4QXaU1X3a5ctPV35IcHt8Ug4QKXXD
         0xOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=koxMBDcb1fAdRxwvk1liqoKIKXbP2FQzrjy1Xyv+aiA=;
        b=ZFOm3EXyNbKNGnGW7pzfqr1gwnZ1l7m5SAD0k59jGt7NbOhnLLzJ3YYJenloxBFATT
         /AcnMcpyvyA1N9VOTHXH/cC1nF11kmv2L/Fhm7gnURaU96RGyCUCSlkumFV+WLNj4Z57
         fU+it2gQ8PDjYljak/NksCykGv8POj+VWOrHaTnGDslpnOi5JzzXFlkS0HtwUArG0NE1
         zg+Mnqh4zcWWfuRaHHvesAMo4VH9Af4mEYaDuiVlJCWX2G4qpAVPUZmoNvTrPNuhnvqA
         nzAOXDRGKwDLOy/u06l2vhekceydJYUCoRwv+pqWuMr7u5Ev9CuqoQibpDcYI6zW9Mwn
         +0/A==
X-Gm-Message-State: AOAM532b5oHdv16/kKj7B+lwXx3AS7gsII3T2B37kIhX9Dx8Xj83Mhyt
        FLtTfNXsnYsPQJnLc343iB+X+IKOCNA=
X-Google-Smtp-Source: ABdhPJyS8wk5HvbKXgxJqGgdK3A4QRrDsnwkhpZj6DKz3qQJtDWRJMk415Q/RtzUU+9fMbSBwCTW0Q==
X-Received: by 2002:a5d:6351:: with SMTP id b17mr4367693wrw.80.1607542894896;
        Wed, 09 Dec 2020 11:41:34 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z22sm4649495wml.1.2020.12.09.11.41.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 11:41:34 -0800 (PST)
Message-Id: <9c79b9f4a096afeef620ff4fc1f85525923e3d02.1607542887.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.812.git.1607542887.gitgitgadget@gmail.com>
References: <pull.812.git.1607542887.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 19:41:22 +0000
Subject: [PATCH 06/11] merge-ort: add implementation of both sides renaming
 identically
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>, Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Implement rename/rename(1to1) handling, i.e. both sides of history
renaming a file but renaming the same way.  This code replaces the
following from merge-recurisve.c:

  * all the 1to1 code in process_renames()
  * the RENAME_ONE_FILE_TO_ONE case of process_entry()

Also, there is some shared code from merge-recursive.c for multiple
different rename cases which we will no longer need for this case (or
other rename cases):

  * handle_rename_normal()
  * setup_rename_conflict_info()

The consolidation of four separate codepaths into one is made possible
by a change in design: process_renames() tweaks the conflict_info
entries within opt->priv->paths such that process_entry() can then
handle all the non-rename conflict types (directory/file, modify/delete,
etc.) orthogonally.  This means we're much less likely to miss special
implementation of some kind of combination of conflict types (see
commits brought in by 66c62eaec6 ("Merge branch 'en/merge-tests'",
2020-11-18), especially commit ef52778708 ("merge tests: expect improved
directory/file conflict handling in ort", 2020-10-26) for more details).
That, together with letting worktree/index updating be handled
orthogonally in the merge_switch_to_result() function, dramatically
simplifies the code for various special rename cases.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 merge-ort.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index faec29db955..085e81196a5 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -647,14 +647,31 @@ static int process_renames(struct merge_options *opt,
 		    !strcmp(oldpath, renames->queue[i+1]->one->path)) {
 			/* Handle rename/rename(1to2) or rename/rename(1to1) */
 			const char *pathnames[3];
+			struct version_info merged;
+			struct conflict_info *base, *side1, *side2;
+			unsigned was_binary_blob = 0;
 
 			pathnames[0] = oldpath;
 			pathnames[1] = newpath;
 			pathnames[2] = renames->queue[i+1]->two->path;
 
+			base = strmap_get(&opt->priv->paths, pathnames[0]);
+			side1 = strmap_get(&opt->priv->paths, pathnames[1]);
+			side2 = strmap_get(&opt->priv->paths, pathnames[2]);
+
+			VERIFY_CI(base);
+			VERIFY_CI(side1);
+			VERIFY_CI(side2);
+
 			if (!strcmp(pathnames[1], pathnames[2])) {
-				/* Both sides renamed the same way. */
-				die("Not yet implemented");
+				/* Both sides renamed the same way */
+				assert(side1 == side2);
+				memcpy(&side1->stages[0], &base->stages[0],
+				       sizeof(merged));
+				side1->filemask |= (1 << 0);
+				/* Mark base as resolved by removal */
+				base->merged.is_null = 1;
+				base->merged.clean = 1;
 
 				/* We handled both renames, i.e. i+1 handled */
 				i++;
-- 
gitgitgadget

