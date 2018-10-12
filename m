Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A3E4F1F97E
	for <e@80x24.org>; Fri, 12 Oct 2018 05:28:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727429AbeJLM70 (ORCPT <rfc822;e@80x24.org>);
        Fri, 12 Oct 2018 08:59:26 -0400
Received: from mail-pl1-f193.google.com ([209.85.214.193]:36005 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727227AbeJLM7Z (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Oct 2018 08:59:25 -0400
Received: by mail-pl1-f193.google.com with SMTP id y11-v6so5335516plt.3
        for <git@vger.kernel.org>; Thu, 11 Oct 2018 22:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lxJpCT9ycjowXjXQqKT326lXmRXjAOxFpv1eZjNJbzE=;
        b=Qv7FgekugZwr56rylBi8YR2CAZigzzg7CCinvbJl9v3puziuHX4WqI3q5NCSedqZWW
         i3P2o+YLtMunMRZoXo06iN1jjnYbVM5Zna2Z++hncjI6+w/swfBMeiupeyfphZYTu4Oy
         4dp6VNB4ByLFw8Ih5O4wVKXudrCiKgH9V+ZDg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lxJpCT9ycjowXjXQqKT326lXmRXjAOxFpv1eZjNJbzE=;
        b=jclfu8JL4WbGRAWX8w1Wv9d39C1lPAa8xMf6mX3yprvifSbwojLOg7SaJ7EcQgeB7V
         ehSWMyHyNVf6snigBtiGZE0soghas8cl1YTEcZm9l9i08LxHGJ5u29R+E/0FoF+PP44x
         M7HtVznK2okDMF9KSSBKbK0zNezmdfwPFvEzfvXSn2jldMN6X1zqnjUEQJmizIzWw38t
         f/IhLmxzvpCTmt8cEJcaENanMNMMY6fFdYoQwXu6u4vUPW8DILQyI5XitO3LWXlaYXYg
         NxQagsHvqUZYZkf6yY9612BjN5coGrNCc3FlNmLdlwopc69k3E0JxnvbRe6DqVmC+jKB
         v0hg==
X-Gm-Message-State: ABuFfojgUzENLCxsnnpw+oaqHExUYY2Vw9jy7p10A9w/jgxVgk7wvhxd
        F+ovmltv3lqCkyYX0aEIRhEPjNKvNe23ftlm
X-Google-Smtp-Source: ACcGV63CKbifQ/0FQhGyGZooB5S+MGMDJhmMZif60kOqNeRlv9fPebmvXWDpOfMScYT/OcWUed49iA==
X-Received: by 2002:a17:902:2de4:: with SMTP id p91-v6mr4404207plb.148.1539322123232;
        Thu, 11 Oct 2018 22:28:43 -0700 (PDT)
Received: from lgd-kipper.hsd1.ca.comcast.net ([2601:646:8581:1fcf:8286:f2ff:fe24:931b])
        by smtp.gmail.com with ESMTPSA id t26-v6sm209110pfa.158.2018.10.11.22.28.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 11 Oct 2018 22:28:42 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Lex Spoon <lex@lexspoon.org>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv1 2/3] git-p4: unshelve into refs/remotes/p4-unshelved, not refs/remotes/p4/unshelved
Date:   Fri, 12 Oct 2018 06:28:32 +0100
Message-Id: <20181012052833.6945-3-luke@diamand.org>
X-Mailer: git-send-email 2.19.1.272.gf84b9b09d4
In-Reply-To: <20181012052833.6945-1-luke@diamand.org>
References: <20181012052833.6945-1-luke@diamand.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The branch detection code looks for branches under refs/remotes/p4/...
and can end up getting confused if there are unshelved changes in
there as well. This happens in the function p4BranchesInGit().

Instead, put the unshelved changes into refs/remotes/p4-unshelved/<N>.

Signed-off-by: Luke Diamand <luke@diamand.org>
---
 Documentation/git-p4.txt | 6 +++---
 git-p4.py                | 3 ++-
 t/t9832-unshelve.sh      | 6 +++---
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-p4.txt b/Documentation/git-p4.txt
index 41780a5aa9..c7705ae6e7 100644
--- a/Documentation/git-p4.txt
+++ b/Documentation/git-p4.txt
@@ -174,7 +174,7 @@ $ git p4 submit --update-shelve 1234 --update-shelve 2345
 Unshelve
 ~~~~~~~~
 Unshelving will take a shelved P4 changelist, and produce the equivalent git commit
-in the branch refs/remotes/p4/unshelved/<changelist>.
+in the branch refs/remotes/p4-unshelved/<changelist>.
 
 The git commit is created relative to the current origin revision (HEAD by default).
 If the shelved changelist's parent revisions differ, git-p4 will refuse to unshelve;
@@ -182,13 +182,13 @@ you need to be unshelving onto an equivalent tree.
 
 The origin revision can be changed with the "--origin" option.
 
-If the target branch in refs/remotes/p4/unshelved already exists, the old one will
+If the target branch in refs/remotes/p4-unshelved already exists, the old one will
 be renamed.
 
 ----
 $ git p4 sync
 $ git p4 unshelve 12345
-$ git show refs/remotes/p4/unshelved/12345
+$ git show p4/unshelved/12345
 <submit more changes via p4 to the same files>
 $ git p4 unshelve 12345
 <refuses to unshelve until git is in sync with p4 again>
diff --git a/git-p4.py b/git-p4.py
index 5701bad06a..76c18a22e9 100755
--- a/git-p4.py
+++ b/git-p4.py
@@ -3956,7 +3956,8 @@ def __init__(self):
         ]
         self.verbose = False
         self.noCommit = False
-        self.destbranch = "refs/remotes/p4/unshelved"
+        self.destbranch = "refs/remotes/p4-unshelved"
+        self.origin = "p4/master"
 
     def renameBranch(self, branch_name):
         """ Rename the existing branch to branch_name.N
diff --git a/t/t9832-unshelve.sh b/t/t9832-unshelve.sh
index 48ec7679b8..c3d15ceea8 100755
--- a/t/t9832-unshelve.sh
+++ b/t/t9832-unshelve.sh
@@ -54,8 +54,8 @@ EOF
 		cd "$git" &&
 		change=$(last_shelved_change) &&
 		git p4 unshelve $change &&
-		git show refs/remotes/p4/unshelved/$change | grep -q "Further description" &&
-		git cherry-pick refs/remotes/p4/unshelved/$change &&
+		git show refs/remotes/p4-unshelved/$change | grep -q "Further description" &&
+		git cherry-pick refs/remotes/p4-unshelved/$change &&
 		test_path_is_file file2 &&
 		test_cmp file1 "$cli"/file1 &&
 		test_cmp file2 "$cli"/file2 &&
@@ -88,7 +88,7 @@ EOF
 		cd "$git" &&
 		change=$(last_shelved_change) &&
 		git p4 unshelve $change &&
-		git diff refs/remotes/p4/unshelved/$change.0 refs/remotes/p4/unshelved/$change | grep -q file3
+		git diff refs/remotes/p4-unshelved/$change.0 refs/remotes/p4-unshelved/$change | grep -q file3
 	)
 '
 
-- 
2.19.1.272.gf84b9b09d4

