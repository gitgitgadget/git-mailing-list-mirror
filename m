Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2430C433EF
	for <git@archiver.kernel.org>; Mon, 21 Mar 2022 12:43:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347517AbiCUMow (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Mar 2022 08:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347079AbiCUMov (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Mar 2022 08:44:51 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FC1B35A8C
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 05:43:26 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id j13-20020a05600c1c0d00b0038c8f94aac2so4048958wms.3
        for <git@vger.kernel.org>; Mon, 21 Mar 2022 05:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=P2SifhrRalog8bs8g+5skoONXFDknrUnOXTDEk/b+Fc=;
        b=FRx/AsGzmp9BwRsYaOIDHCSylqNhBSi0dVKeJSAR0QJwjxer3qQTHhcgh9JBRjMNhh
         ZRunutAiyWGYrNW2CabP0dnSwtDrWON9Uq51TAXvzUmBl0R+8ri21/eKtAZk2NraDTNE
         tTxsTyNBcY+T+MWXRYfIrrr74Dvl5ijWr7QZYzww67wLzLwbrWC8r8JIJzRyLG5uKVxO
         4w4SkTSrqg+6irBvwSyREmH760HrW8StllU+DpY+81xO3L+7loiBIyW31WlLdqhga/F4
         NSO1hFb0X7BVshfaKDsWOyppJCqQGUNCx4hjur9iqZTNbee3qSjPmQaHZ1w+w776TrmT
         MZew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=P2SifhrRalog8bs8g+5skoONXFDknrUnOXTDEk/b+Fc=;
        b=bMeArOhntWX1+IH0b95X3HeMH9TzytTWThIrZs07r9uBEOsHDiOby3hH+n/QmAQ0as
         0jhsclkOPYcBcURBUrbCDNuwaCR5NUJQxLAf/XdWqS7iQgRTKNL2sPfqR02amLnbDaS6
         Z5qjDKbeReArvnuq2gTwDOIc6t+efmGI1daxD8hmcQJmPMa0yOuKLNmVZHAJwslxdZdn
         FBL4W+VRkz7hFaXRUsScauScR0++dpihsUq/awyF3Y71Dz/HSe+GNF8QS/70k9oyXmS7
         JNBFk1Rtj80rqiMnYHKkdkkydQ1nfrZ0JeoMl0D7Qw+vp6bhPwshBwzEuEO9sl7e7UuD
         DPlQ==
X-Gm-Message-State: AOAM533DqyIq2aUFK+N+Oav8ThomKWmh68vW0roApxfYAfUB8xCiX7XR
        0f200kBiiiyUc4Jf0o7sCuNti7AwBOU=
X-Google-Smtp-Source: ABdhPJyMHv4oFq4V6GGs7mlN3Uu5F7DZbIS8RxIFYVQrRKvdOdSMeq2x48287JFJOe+tF5Dz81TbDQ==
X-Received: by 2002:a05:600c:1c0e:b0:38c:ae37:c1d2 with SMTP id j14-20020a05600c1c0e00b0038cae37c1d2mr2154462wms.205.1647866604410;
        Mon, 21 Mar 2022 05:43:24 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y7-20020a5d4ac7000000b00203e4c8bdf1sm11732751wrs.93.2022.03.21.05.43.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Mar 2022 05:43:23 -0700 (PDT)
Message-Id: <pull.1180.git.1647866603032.gitgitgadget@gmail.com>
From:   "Kirill Frolov via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 21 Mar 2022 12:43:22 +0000
Subject: [PATCH] git-p4: fix issue with multiple perforce remotes
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Joel Holdsworth <jholdsworth@nvidia.com>,
        Ben Keene <seraphire@gmail.com>,
        Luke Diamand <luke@diamand.org>,
        Yang Zhao <yang.zhao@skyboxlabs.com>,
        Kirill Frolov <k.frolov@samsung.com>,
        Kirill Frolov <k.frolov@samsung.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Kirill Frolov <k.frolov@samsung.com>

Single perforce branch might be sync'ed multiple times with different
revision numbers, so it will be seen to Git as complete different
commits. This can be done by the following command:

  git p4 sync --branch=NAME //perforce/path...

It is assumed, that this command applied multiple times and
peforce repository changes between command invocations.

In such situation, git p4 will see multiple perforce branches with
same name and different revision numbers. The problem is that to make
a shelve, git-p4 script will try to find "origin" branch, if not
specified in command line explicitly. And previously script selected
any branch with same name and don't mention particular revision number.
Later this may cause failure of the command "git diff-tree -r $rev^ $rev",
so shelve can't be created (due to wrong origin branch/commit).

This commit fixes the heuristic by which git p4 selects origin branch:
first it tries to select branch with same perforce path and perforce
revision, and if it fails, then selects branch with only same perforce
path (ignoring perforce revision number).

Signed-off-by: Kirill Frolov <k.frolov@samsung.com>
---
    git-p4: fix issue with perforce branch synchronized multiple times.
    
    Perforce branch might be sync'ed multiple times with different revision
    numbers (by the command "git p4 sync --branch=NAME //perforce/path...")
    
    In such situation, git p4 will see multiple perforce branches with same
    name and different revision numbers. The problem is that to make a
    shelve, git-p4 script will try to find "origin" branch, if not specified
    in command line explicitly. And previously script selected any branch
    with same name and don't mention particular revision number. Later this
    may cause failure of the command "git diff-tree -r $rev^ $rev", so
    shelve can't be created (due to wrong origin branch/commit).
    
    This commit fixes the heuristic by which git p4 selects origin branch:
    first it tries to select branch with same perforce path and perforce
    revision, and if it fails, then selects branch with only same perforce
    path (ignoring perforce revision number).
    
    Signed-off-by: Kirill Frolov k.frolov@samsung.com

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1180%2Fkfrolov%2Fperforce_multi_fix-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1180/kfrolov/perforce_multi_fix-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1180

 git-p4.py | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/git-p4.py b/git-p4.py
index a9b1f904410..4903e86351d 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -946,8 +946,12 @@ def findUpstreamBranchPoint(head = "HEAD"):
         log = extractLogMessageFromGitCommit(tip)
         settings = extractSettingsGitLog(log)
         if "depot-paths" in settings:
+            git_branch = "remotes/p4/" + branch
             paths = ",".join(settings["depot-paths"])
-            branchByDepotPath[paths] = "remotes/p4/" + branch
+            branchByDepotPath[paths] = git_branch
+            if "change" in settings:
+                paths = paths + ";" + settings["change"]
+                branchByDepotPath[paths] = git_branch
 
     settings = None
     parent = 0
@@ -957,6 +961,10 @@ def findUpstreamBranchPoint(head = "HEAD"):
         settings = extractSettingsGitLog(log)
         if "depot-paths" in settings:
             paths = ",".join(settings["depot-paths"])
+            if "change" in settings:
+                expaths = paths + ";" + settings["change"]
+                if expaths in branchByDepotPath:
+                    return [branchByDepotPath[expaths], settings]
             if paths in branchByDepotPath:
                 return [branchByDepotPath[paths], settings]
 

base-commit: 74cc1aa55f30ed76424a0e7226ab519aa6265061
-- 
gitgitgadget
