Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69BA3C433B4
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 20:07:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17E496143D
	for <git@archiver.kernel.org>; Wed, 28 Apr 2021 20:07:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240673AbhD1UIA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Apr 2021 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237174AbhD1UHw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Apr 2021 16:07:52 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E032C06138B
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 13:06:59 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n3-20020a05600c4f83b02901425630b2c2so3167645wmq.1
        for <git@vger.kernel.org>; Wed, 28 Apr 2021 13:06:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=BNazD4+oKkL2Dqo+Hjzuk7tO0JefqeDu/pdAXP5g5sI=;
        b=tpPOCdixYe14vIUvQJS3fz1EZSPEWTkAWb1ypLGGWuCESL5/FyVtJHYSaVQegQKv8M
         +Qce+kIWjCjclZSZ0K4Bwm9lIq4KLrvE5SwQcpPA5JYoQTT36V3NOnz1RjwEuvIheobI
         wKdraRLcTg0FzCrF+4EyIxFbBbzNnMdzwKHcMVH8AKCuvb59V/m9L69IoycZRJ7cNYQV
         3/ZE5D8/qisbI3RB0iVrHBNaQi3DANYlU9TRNkjSIVfqMfIL9WxvDWo4xrno1H4PEvGp
         19LAyrR/eCy8TXlifNb2FlG5TIU5PL293yw5MRe15M6dL8Ou5qBBmVPcXtS3dtM4RhRk
         Y10w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=BNazD4+oKkL2Dqo+Hjzuk7tO0JefqeDu/pdAXP5g5sI=;
        b=G/gX2W6qgIawnl5r+UIFT0sjItTeeb2lspXoLBh4JGWDZ5Z/Wrc6xWPXoVvlsxFCjp
         +MF+8sd/s0revsqX/ZtcSwfzuRXdZSCJOoChv+oz89YdVW8wiuz1IBbES42e4zsuFYv1
         lje8mxGaY2nLwSrs49YaDJGAhTa8LRwF9D2Xvi8fVMThQMPgEFK4zpK0T5nOfYx/dfsy
         BxdVz5sXaHjhbiwAOUDVWU8bV2Il1i0kKlT8I8i9qCALU/QnKV8ab08yWCjWypt3y1QN
         c1WhE8SGOhceiKWeAZM5NQta5LEyRN/boOgX+R0KRzIU3LsMxDCjqhbG1ynAyC9zPANo
         1e5w==
X-Gm-Message-State: AOAM533+gCKALV0LsyDkfaDesMhoOGK/U4tdETOgrAm8DbSgZvYYTnc2
        egSsvSWOIF0ejnI2fbCbEcB0DZQH5l8=
X-Google-Smtp-Source: ABdhPJyzzwbKHHibptZYk7eWX7enodHy9/mmSBXcoOaJFCuGCvkpNWQMwtXz29XSojjQuaceo1AVQw==
X-Received: by 2002:a7b:cdf0:: with SMTP id p16mr2910576wmj.100.1619640418017;
        Wed, 28 Apr 2021 13:06:58 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v20sm906377wmj.15.2021.04.28.13.06.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Apr 2021 13:06:57 -0700 (PDT)
Message-Id: <pull.1013.git.git.1619640416533.gitgitgadget@gmail.com>
From:   "Joachim Kuebart via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 28 Apr 2021 20:06:56 +0000
Subject: [PATCH] git-p4: speed up search for branch parent
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Joachim Kuebart <joachim.kuebart@gmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Joachim Kuebart <joachim.kuebart@gmail.com>

Previously, the code iterated through the parent branch commits and
compared each one to the target tree using diff-tree.

This patch outputs the revision's tree hash along with the commit hash,
thereby saving the diff-tree invocation. This results in a considerable
speed-up, at least on Windows.

Signed-off-by: Joachim Kuebart <joachim.kuebart@gmail.com>
---
    git-p4: speed up search for branch parent
    
    Previously, the code iterated through the parent branch commits and
    compared each one to the target tree using diff-tree.
    
    This patch outputs the revision's tree hash along with the commit hash,
    thereby saving the diff-tree invocation. This results in a considerable
    speed-up, at least on Windows.
    
    Signed-off-by: Joachim Kuebart joachim.kuebart@gmail.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1013%2Fjkuebart%2Fp4-faster-parent-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1013/jkuebart/p4-faster-parent-v1
Pull-Request: https://github.com/git/git/pull/1013

 git-p4.py | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 09c9e93ac401..dbe94e6fb83b 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3600,19 +3600,19 @@ def importNewBranch(self, branch, maxChange):
         return True
 
     def searchParent(self, parent, branch, target):
-        parentFound = False
-        for blob in read_pipe_lines(["git", "rev-list", "--reverse",
+        for tree in read_pipe_lines(["git", "rev-parse",
+                                     "{}^{{tree}}".format(target)]):
+            targetTree = tree.strip()
+        for blob in read_pipe_lines(["git", "rev-list", "--format=%H %T",
                                      "--no-merges", parent]):
-            blob = blob.strip()
-            if len(read_pipe(["git", "diff-tree", blob, target])) == 0:
-                parentFound = True
+            if blob[:7] == "commit ":
+                continue
+            blob = blob.strip().split(" ")
+            if blob[1] == targetTree:
                 if self.verbose:
-                    print("Found parent of %s in commit %s" % (branch, blob))
-                break
-        if parentFound:
-            return blob
-        else:
-            return None
+                    print("Found parent of %s in commit %s" % (branch, blob[0]))
+                return blob[0]
+        return None
 
     def importChanges(self, changes, origin_revision=0):
         cnt = 1

base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
-- 
gitgitgadget
