Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D0DCC433FE
	for <git@archiver.kernel.org>; Fri,  1 Apr 2022 15:54:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235249AbiDAP4b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Apr 2022 11:56:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343771AbiDAPRs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Apr 2022 11:17:48 -0400
Received: from b-painless.mh.aa.net.uk (b-painless.mh.aa.net.uk [IPv6:2001:8b0:0:30::52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C146C4EF6C
        for <git@vger.kernel.org>; Fri,  1 Apr 2022 08:01:16 -0700 (PDT)
Received: from [195.110.77.193] (helo=red.nvidia.com)
        by painless-b.tch.aa.net.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <jholdsworth@nvidia.com>)
        id 1naIDw-009TW3-D7; Fri, 01 Apr 2022 15:25:59 +0100
From:   Joel Holdsworth <jholdsworth@nvidia.com>
To:     git@vger.kernel.org, Luke Diamand <luke@diamand.org>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Cc:     Tzadik Vanderhoof <tzadik.vanderhoof@gmail.com>,
        Dorgon Chang <dorgonman@hotmail.com>,
        Joachim Kuebart <joachim.kuebart@gmail.com>,
        Daniel Levin <dendy.ua@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Ben Keene <seraphire@gmail.com>,
        Andrew Oakley <andrew@adoakley.name>,
        Joel Holdsworth <jholdsworth@nvidia.com>
Subject: [PATCH v5 06/22] git-p4: remove commented code
Date:   Fri,  1 Apr 2022 15:24:48 +0100
Message-Id: <20220401142504.58995-7-jholdsworth@nvidia.com>
X-Mailer: git-send-email 2.35.GIT
In-Reply-To: <20220401142504.58995-1-jholdsworth@nvidia.com>
References: <20220401142504.58995-1-jholdsworth@nvidia.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Previously, the script contained commented code including Python 2 print
statements. Presumably, these were used as a developer aid at some point
in history. However, the commented code is generally undesirable, and
this commented code serves no useful purpose. Therefore this patch
removes it.

Signed-off-by: Joel Holdsworth <jholdsworth@nvidia.com>
---
 git-p4.py | 7 -------
 1 file changed, 7 deletions(-)

diff --git a/git-p4.py b/git-p4.py
index 892b964eec..53e99f81b7 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3583,23 +3583,18 @@ def importNewBranch(self, branch, maxChange):
         self.gitStream.flush()
         branchPrefix = self.depotPaths[0] + branch + "/"
         range = "@1,%s" % maxChange
-        #print "prefix" + branchPrefix
         changes = p4ChangesForPaths([branchPrefix], range, self.changes_block_size)
         if len(changes) <= 0:
             return False
         firstChange = changes[0]
-        #print "first change in branch: %s" % firstChange
         sourceBranch = self.knownBranches[branch]
         sourceDepotPath = self.depotPaths[0] + sourceBranch
         sourceRef = self.gitRefForBranch(sourceBranch)
-        #print "source " + sourceBranch
 
         branchParentChange = int(p4Cmd(["changes", "-m", "1", "%s...@1,%s" % (sourceDepotPath, firstChange)])["change"])
-        #print "branch parent: %s" % branchParentChange
         gitParent = self.gitCommitByP4Change(sourceRef, branchParentChange)
         if len(gitParent) > 0:
             self.initialParents[self.gitRefForBranch(branch)] = gitParent
-            #print "parent git commit: %s" % gitParent
 
         self.importChanges(changes)
         return True
@@ -3742,8 +3737,6 @@ def importHeadRevision(self, revision):
                 newestRevision = change
 
             if info["action"] in self.delete_actions:
-                # don't increase the file cnt, otherwise details["depotFile123"] will have gaps!
-                #fileCnt = fileCnt + 1
                 continue
 
             for prop in ["depotFile", "rev", "action", "type" ]:
-- 
2.35.GIT

