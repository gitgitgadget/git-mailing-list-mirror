Return-Path: <SRS0=1y/A=EO=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3A9EC388F2
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 08:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 870D5206E3
	for <git@archiver.kernel.org>; Sun,  8 Nov 2020 08:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j41MmKVG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgKHIlz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 8 Nov 2020 03:41:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726115AbgKHIlz (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 8 Nov 2020 03:41:55 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8BB1C0613CF
        for <git@vger.kernel.org>; Sun,  8 Nov 2020 00:41:53 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h2so5296587wmm.0
        for <git@vger.kernel.org>; Sun, 08 Nov 2020 00:41:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=TO1QjRyL3lcEx/wDG4s02hHu3pm+fqcGL6SHb3klo9U=;
        b=j41MmKVG9TM6Yg5nLD5H26XqCYvwVw3QFLKtN542u3ZJtfzjVnYJSM2ehCIy+HCn0f
         UhmaNb1C9c7e7sgQtyNhv3xMfM8qxZuH23i+8PjezDSpYoR+vUFvRa1/gN1ZgFiyyc8o
         JUM1oErCG+rTeVszO1CHl7enDH8fW4+ll1Fa68uwDejLZAnoJJq5XSnmD+QT4N5+GhPf
         q7wF+eXNPZ3aPG/rVpG+1tiBHnG73TTHjoGSRKMG/Y+U7AOQYx3XrzKmKnyWnIZhJQ4N
         CmBz7qVuj+c8OPTZ5WhETxC6UZidwhW2P9NR6SVwHNJrOnaK+iDJ/lD9TQJHY7RMDG3d
         /3jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=TO1QjRyL3lcEx/wDG4s02hHu3pm+fqcGL6SHb3klo9U=;
        b=J5c5QOF7UIK3BLR+cXV5Z7EOnCY7wSx28G7dY20C+l1OAKlFkm5U9buigQEMHVVrAk
         FS2wAb/Yq0cAM3j+FJ6a23LKBATOWnwRAQZUJkrS9KjgDVcce7Aa4y5LdZjywnI3bfqk
         l9GvnppkB8szNLCBUJSui2+9f/qL2SsFrEM43A489+s6+FTlzBr52hUz1NelVx3So+va
         srjKAE8d1x4KJGWs2nxknG2IjZ3gk0KcJs+GrzLVtewEPnjABXBX6eyiFqGXUDl3LOMN
         W8SCXBHJOujRsEQwiO9DfDXtDvNJf1VBVTx8Puvksdw7VEUR67+A5MDOruuTifdU7DWd
         sxBQ==
X-Gm-Message-State: AOAM530raTzgItt+IWkkegBq99pThDR8l9T81RMvXLOOtXoNS8gYY1V1
        2Lb0e8k4O/sbkzshXlMbRFfCMNeH8zw=
X-Google-Smtp-Source: ABdhPJzzMmgPJo6eTHFTJawGYKjgq6PkyEO6g+Ei5zd2C8RsM+6ee/h2FhFJ8w32aw4/Blc/XKSRJQ==
X-Received: by 2002:a05:600c:2048:: with SMTP id p8mr8722580wmg.165.1604824912553;
        Sun, 08 Nov 2020 00:41:52 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m22sm9685252wrb.97.2020.11.08.00.41.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Nov 2020 00:41:52 -0800 (PST)
Message-Id: <pull.782.git.1604824911359.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Sun, 08 Nov 2020 08:41:51 +0000
Subject: [PATCH] p4: respect init.defaultBranch
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Diamand <luke@diamand.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In `git p4 clone`, we hard-code the branch name `master` instead of
looking what the _actual_ initial branch name is. Let's fix that.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
    p4: respect init.defaultBranch
    
    Just something I noticed while working on the big master -> main rename
    in the test suite.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-782%2Fdscho%2Fgit-p4-and-init.defaultBranch-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-782/dscho/git-p4-and-init.defaultBranch-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/782

 git-p4.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index 4433ca53de..52ddb1d7b2 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -4186,7 +4186,7 @@ def run(self, args):
 
         # create a master branch and check out a work tree
         if gitBranchExists(self.branch):
-            system([ "git", "branch", "master", self.branch ])
+            system([ "git", "branch", currentGitBranch(), self.branch ])
             if not self.cloneBare:
                 system([ "git", "checkout", "-f" ])
         else:

base-commit: 7f7ebe054af6d831b999d6c2241b9227c4e4e08d
-- 
gitgitgadget
