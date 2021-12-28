Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 788BEC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 00:20:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbhL1AUt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 19:20:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234131AbhL1AUt (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 19:20:49 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDAAAC06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 16:20:48 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id s1so35148963wrg.1
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 16:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=JIvHQg2GD6zPDjBBNCc36pkZZnTWa9s+1IJczCQVw70=;
        b=QC27Ox1sHMzpQmOjzCIUjeelxpl3nq9COvWPcF1C5/ygDmvC66ybWLwzFHDjH1KaYp
         5Idj6KhQEbMHgW8kSmm3HpYgyNngBFpbjpIpZkCT1QQI386NtiyOmcjGhSlI4JLGA6mC
         VnRyUc4zKk6uuQTPw+tAVIxoSi5JoKLc53kr4DNAyzP3uNA2hSsZvDdR2ZpKxDDSiIll
         V5JzYYwDAv91QJ9mDs6Kc2KYEYYfxPgPe0paVdnbhRrdkvY4RxZSDEYRTS22M9eCeMRz
         QG89TWi7J5RmOkAl0N/es5Mb3a++s4+6Knw/K1DwhBZbMwqC0Q+3CIX174jok+4Fmebm
         IH5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=JIvHQg2GD6zPDjBBNCc36pkZZnTWa9s+1IJczCQVw70=;
        b=wR3COnnnYXR4up13EXqGxOojxEH98YlkapA4mUUApu1jBY3J537go9mt++Lufs1KNK
         3DUG79A2EzOHpA7cKegnQr8qhSnk20eT6AEmxz+8CLmWM1ddd+MY4J1NLGqdYaoXevQ0
         X2iwHJnfHLZ5fGjLT1XXeA0ROpcPE+pDRapokEiTVDV7VJVi4ldEczwzZUdjeJ7Usn1Z
         Q9691yV0L3xqnH9Xo937YJlVAJL9qz3tWE9Z9RwHmFMoYy41ljoC67GmdDJeKPQbS8bc
         cLLqeGw7UG4Cm9t8F0sHDdaAqxJzQ48gTOHV/6pAzfm2U7YMaB2AUyyPmmMVBtlX5CuN
         VWcQ==
X-Gm-Message-State: AOAM533t8iAQO7TUHMYIhEXNPSQcfEEm1h33oeCoorh8MWbuBoETpTou
        e4YMLoHraafKbfiIg7fM5jZ/2+4T82o=
X-Google-Smtp-Source: ABdhPJzla1Ue/P46KhnQuII209O2nLgF1E/qae23cRrsO0dJE+7f8L97nLmLKwzgcZ9Kf+dD8BUYHg==
X-Received: by 2002:adf:97c2:: with SMTP id t2mr14397836wrb.577.1640650847438;
        Mon, 27 Dec 2021 16:20:47 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm16342152wme.39.2021.12.27.16.20.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 16:20:47 -0800 (PST)
Message-Id: <pull.1174.git.git.1640650846612.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 28 Dec 2021 00:20:46 +0000
Subject: [PATCH] merge-ort: fix bug with renormalization and rename/delete
 conflicts
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
Signed-off-by: Elijah Newren <newren@gmail.com>
---
    merge-ort: fix bug with renormalization and rename/delete conflicts
    
    Original report:
    https://lore.kernel.org/git/CAN0XMOK8iHZnbtYw7CPAQGJcmuVSDxQoFNFEwiaa41V89F1rzA@mail.gmail.com/
    
    Built in v2.34.1, but rebases onto and/or merges cleanly with newer
    versions.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1174%2Fnewren%2Fmerge-ort-rename-delete-renormalization-bug-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1174/newren/merge-ort-rename-delete-renormalization-bug-v1
Pull-Request: https://github.com/git/git/pull/1174

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
