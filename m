Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E9FC433EF
	for <git@archiver.kernel.org>; Thu, 30 Dec 2021 22:09:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242209AbhL3WI7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Dec 2021 17:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhL3WI7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Dec 2021 17:08:59 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8633C061574
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 14:08:58 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id v11so52860389wrw.10
        for <git@vger.kernel.org>; Thu, 30 Dec 2021 14:08:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=ib2oDLmy/tWH6d4TfXbrm38auELFSlWe22SqBRr5XKQ=;
        b=LytoWafk1NJVNr0/zqyQtheMcDkXQu2ziqTsZf2fj5eDUEbbzKWp5/ITMoiHbCZHMn
         ARlq1DOoJ5Kk8vN4EniSL8ihi1tzsdGlypAuMt3HUUtclvloq1M8FKCwgBOPtdcyvGQx
         9FIOLWpZwnk79r/HsWAgxqWF4TWEBf+EjsK2a8UmAbxjWAWlzZYcqCUT8A0sb6Q+kyuJ
         K8wMV3g6ntsCjIytq4Euzvh2nc/VDLrzr8GUmv9MG6y/spF47GlgUm+KCSUiWruPSx8L
         L3Z1CLq5s83uZv8aUE1wuTYI+OuihXVVRKVtNfGjLIISBVyfX+deheRgjUooNJR87w2o
         8iIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=ib2oDLmy/tWH6d4TfXbrm38auELFSlWe22SqBRr5XKQ=;
        b=Lge0HGYHcoCcswnlTlr4affpjw56WMMfSQ6ecLUTPJbtZbkACub7QbWYTWYB2oVPJL
         z5ZbodfeJL81B/zjsNX5Rd5bTpq8ZtkhybbzCp94/9CTjtS7K4YnyvCJLLiohLYVoqks
         ZuI36jw/imauqtbYv/g+HNQ+KorkFSNOnb2VMUJ65rlM91v7fxAfO+F6L0XpJcVUyd68
         QHEMvu0E/VkXsrkDiZswi3F6w+dfJa1aE1vqQP9iocdKe1d9fsWa8e/Jna6gRYJuhRvC
         tlgbw7M3D/V0gzNFWG/7RQMaQX6I//JYbvaaC9hlDE7b+O54/m7o7sSerlVDoniPW+27
         EoZw==
X-Gm-Message-State: AOAM533trdiL9g+AuE7k/fDVCGltPjIGjwo4UbjH7JWX/Q199xvA70gk
        nYp9pEkNHWdClBBZsJ+nZlqPIcTOOPA=
X-Google-Smtp-Source: ABdhPJz89Cm3Dsf9gFTGXCapeiSw3GQMnQZHyhQgN9HBqfudXuGjFR4scGhl7SL+hI0hhWKYauhpcg==
X-Received: by 2002:a5d:59a6:: with SMTP id p6mr26034180wrr.559.1640902136911;
        Thu, 30 Dec 2021 14:08:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 9sm31642816wrz.90.2021.12.30.14.08.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Dec 2021 14:08:56 -0800 (PST)
Message-Id: <pull.1174.v2.git.git.1640902135926.gitgitgadget@gmail.com>
In-Reply-To: <pull.1174.git.git.1640650846612.gitgitgadget@gmail.com>
References: <pull.1174.git.git.1640650846612.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 30 Dec 2021 22:08:55 +0000
Subject: [PATCH v2] merge-ort: fix bug with renormalization and rename/delete
 conflicts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Derrick Stolee <stolee@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Ever since commit a492d5331c ("merge-ort: ensure we consult df_conflict
and path_conflicts", 2021-06-30), when renormalization is active AND a
file is involved in a rename/delete conflict BUT the file is unmodified
(either before or after renormalization), merge-ort was running into an
assertion failure.  Prior to that commit (or if assertions were compiled
out), merge-ort would mis-merge instead, ignoring the rename/delete
conflict and just deleting the file.

Remove the assertions, fix the code appropriately, leave some good
comments in the code, and add a testcase for this situation.

Reported-by: Ralf Thielow <ralf.thielow@gmail.com>
Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: fix bug with renormalization and rename/delete conflicts
    
    Original report:
    https://lore.kernel.org/git/CAN0XMOK8iHZnbtYw7CPAQGJcmuVSDxQoFNFEwiaa41V89F1rzA@mail.gmail.com/
    
    Built in v2.34.1, but rebases onto and/or merges cleanly with newer
    versions.
    
    Changes since v1:
    
     * Added Stolee's Reviewed-by

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1174%2Fnewren%2Fmerge-ort-rename-delete-renormalization-bug-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1174/newren/merge-ort-rename-delete-renormalization-bug-v2
Pull-Request: https://github.com/git/git/pull/1174

Range-diff vs v1:

 1:  5841f3d901d ! 1:  72876b9c106 merge-ort: fix bug with renormalization and rename/delete conflicts
     @@ Commit message
          comments in the code, and add a testcase for this situation.
      
          Reported-by: Ralf Thielow <ralf.thielow@gmail.com>
     +    Reviewed-by: Derrick Stolee <dstolee@microsoft.com>
          Signed-off-by: Elijah Newren <newren@gmail.com>
      
       ## merge-ort.c ##


 merge-ort.c                | 19 ++++++++++++++++---
 t/t6418-merge-text-auto.sh | 26 ++++++++++++++++++++++++++
 2 files changed, 42 insertions(+), 3 deletions(-)

diff --git a/merge-ort.c b/merge-ort.c
index 0342f104836..c3197970219 100644
--- a/merge-ort.c
+++ b/merge-ort.c
@@ -3841,9 +3841,22 @@ static void process_entry(struct merge_options *opt,
 		if (opt->renormalize &&
 		    blob_unchanged(opt, &ci->stages[0], &ci->stages[side],
 				   path)) {
-			ci->merged.is_null = 1;
-			ci->merged.clean = 1;
-			assert(!ci->df_conflict && !ci->path_conflict);
+			if (!ci->path_conflict) {
+				/*
+				 * Blob unchanged after renormalization, so
+				 * there's no modify/delete conflict after all;
+				 * we can just remove the file.
+				 */
+				ci->merged.is_null = 1;
+				ci->merged.clean = 1;
+				 /*
+				  * file goes away => even if there was a
+				  * directory/file conflict there isn't one now.
+				  */
+				ci->df_conflict = 0;
+			} else {
+				/* rename/delete, so conflict remains */
+			}
 		} else if (ci->path_conflict &&
 			   oideq(&ci->stages[0].oid, &ci->stages[side].oid)) {
 			/*
diff --git a/t/t6418-merge-text-auto.sh b/t/t6418-merge-text-auto.sh
index 1e0296dd172..41288a60ceb 100755
--- a/t/t6418-merge-text-auto.sh
+++ b/t/t6418-merge-text-auto.sh
@@ -204,4 +204,30 @@ test_expect_success 'Test delete/normalize conflict' '
 	test_path_is_missing file
 '
 
+test_expect_success 'rename/delete vs. renormalization' '
+	git init subrepo &&
+	(
+		cd subrepo &&
+		echo foo >oldfile &&
+		git add oldfile &&
+		git commit -m original &&
+
+		git branch rename &&
+		git branch nuke &&
+
+		git checkout rename &&
+		git mv oldfile newfile &&
+		git commit -m renamed &&
+
+		git checkout nuke &&
+		git rm oldfile &&
+		git commit -m deleted &&
+
+		git checkout rename^0 &&
+		test_must_fail git -c merge.renormalize=true merge nuke >out &&
+
+		grep "rename/delete" out
+	)
+'
+
 test_done

base-commit: e9d7761bb94f20acc98824275e317fa82436c25d
-- 
gitgitgadget
