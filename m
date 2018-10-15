Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A83BA1F453
	for <e@80x24.org>; Mon, 15 Oct 2018 11:14:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726534AbeJOS7P (ORCPT <rfc822;e@80x24.org>);
        Mon, 15 Oct 2018 14:59:15 -0400
Received: from mail-pg1-f180.google.com ([209.85.215.180]:46655 "EHLO
        mail-pg1-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbeJOS7P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Oct 2018 14:59:15 -0400
Received: by mail-pg1-f180.google.com with SMTP id a5-v6so8996005pgv.13
        for <git@vger.kernel.org>; Mon, 15 Oct 2018 04:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=diamand.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=n9DLn3N8MxdlWF/xOd4AOanOLPC39tDsYeob6yjt69I=;
        b=FGyDmmbRlRsLugGko4ed35nGsOjZFBdWouDM95hVtKXQA/Ut6IKdplGAR9hJN0b47U
         W+w+NanghevMi394xaAYlt/7GhsimjJ3+nYF9itNY35zN3LJGAYeoLEh/H9sqHZvAF/Q
         nw7YvBsnp+XgZ18akYHi+ccsgJiZctLoUrNPE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=n9DLn3N8MxdlWF/xOd4AOanOLPC39tDsYeob6yjt69I=;
        b=ElwMNLzOb1roAv17pY/QcpSCv4MGFE/EG2lE2U+a2m86lyJS+kDRVzxnTf363/ob1Z
         v/8ddZNXEL24OUVpcRuJbfYbzeOfC5NKOPPR8+UQlNJeqCQvk9oMby1kqIqpMZEW9GLX
         KFE78ezNQwN4exa/ZyMTx/UVq8zzsW0LOalJTcKXkrwQLnGcYuJwdNksMon4KE34mejO
         ThknlgMq344OM4WF4iVCeOcbi8gUqbYaJqnq8+PBtPiAjFkaHLmDkmznwVEbESCpxg8m
         4vXX/gudjN0wMsgr6oQEHdWP0KtpnXqadCb12cdZkIpn9IV//7maUGNGZgXrx13GOOZG
         bu1A==
X-Gm-Message-State: ABuFfohxMadAyaD3IRsQWSxLz2kwemJmh8ziwcKkGADw0HHCEYbKIF/g
        gk9aRn8r4yLRMcOiXiNo2IakVS9OU5f8Nkjf
X-Google-Smtp-Source: ACcGV605HoGXUzZTx4qnC+YJC75xMBZMrh2Icy+IGCc6c2FlEoYWrJEeH/OQOK/+y7MvkJ5S/wydxQ==
X-Received: by 2002:a62:7a81:: with SMTP id v123-v6mr17487906pfc.240.1539602066902;
        Mon, 15 Oct 2018 04:14:26 -0700 (PDT)
Received: from lgd-kipper.hsd1.ca.comcast.net ([2601:646:8581:1fcf:8286:f2ff:fe24:931b])
        by smtp.gmail.com with ESMTPSA id e22-v6sm11352461pfi.61.2018.10.15.04.14.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Oct 2018 04:14:26 -0700 (PDT)
From:   Luke Diamand <luke@diamand.org>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Chen Bin <chenbin.sh@gmail.com>,
        Miguel Torroja <miguel.torroja@gmail.com>,
        George Vanburgh <gvanburgh@bloomberg.net>,
        Merland Romain <merlorom@yahoo.fr>,
        Vinicius Kursancew <viniciusalexandre@gmail.com>,
        larsxschneider@gmail.com, Lex Spoon <lex@lexspoon.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Luke Diamand <luke@diamand.org>
Subject: [PATCHv2 2/3] git-p4: unshelve into refs/remotes/p4-unshelved, not refs/remotes/p4/unshelved
Date:   Mon, 15 Oct 2018 12:14:07 +0100
Message-Id: <20181015111408.17618-3-luke@diamand.org>
X-Mailer: git-send-email 2.19.1.331.gae0ed827e6
In-Reply-To: <20181015111408.17618-1-luke@diamand.org>
References: <20181015111408.17618-1-luke@diamand.org>
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
index 41780a5aa9..6c0017e36e 100644
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
+$ git show p4-unshelved/12345
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
2.19.1.331.gae0ed827e6

