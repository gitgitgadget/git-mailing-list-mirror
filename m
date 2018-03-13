Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 186BB1F404
	for <e@80x24.org>; Tue, 13 Mar 2018 20:20:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752652AbeCMUUs (ORCPT <rfc822;e@80x24.org>);
        Tue, 13 Mar 2018 16:20:48 -0400
Received: from mail-pg0-f66.google.com ([74.125.83.66]:42746 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752149AbeCMUUp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Mar 2018 16:20:45 -0400
Received: by mail-pg0-f66.google.com with SMTP id x2so361231pgo.9
        for <git@vger.kernel.org>; Tue, 13 Mar 2018 13:20:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=FYUAQCRz/A1VfX5vngLgUCk1hG/oogSeYRowSp1VUDY=;
        b=NvyTENzcYOl3hRb1r7vRs9kbJDPFIS3Jqc+p+bGZrq8+c3bTAJYKrewbTqIyVRhTVP
         x3i4Xa7NpUmALHPsY61ub/gRZIubKdngtOt165k/CWmWc8xIngq1oL8YGlNt8ZT3kLtr
         6ZOJKNqwedpwxr7e12hha3fpU/XJJyDGmcd9oGn+uKLztVH3wZTz3zHSNm/+m6rzWaTO
         NUEBixqiQi6KA/73nJOK/R47DA4w5/4CsJ0KB4FI6hg9GUFG6eQV25dkYa667HZeSasj
         1GthFgxAV1KERyASOjV9FEGHh257169OmBaCKWxWFojiCFGC6ntDsli10g8vRaClw2bT
         Yl1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=FYUAQCRz/A1VfX5vngLgUCk1hG/oogSeYRowSp1VUDY=;
        b=ppw4m1xl8lUDiPwiLmCFpv5aRwRMxN5HStsfui0E3Nxdik9dJFgqg/5QjlTPp7zayQ
         CRXyHMeAi8pD9lj/JgMQ/l3Vikd66qwL5u5tjknDb23A+Ib6wy02fdiRpBhDe+pTbdYD
         KCc1CJ2NqQZ6kUGau1thl67XmBgLtTbCvY/KlfXWUkYcmkU9JU0p6AFSMPpo2jmkhWQs
         MdHb8pKbUFJhvu2go0b+knyl58OqSaVsMonk9Ffrkg6r6hCrJEYped4yGqD0a5F9bMvc
         jVEYIe1u/ZBjqDDuWtZbbxGIdMrc9aY+hMW+70emzIRBqQM7mxf5ziA4dynD7f0lE5lb
         4GIQ==
X-Gm-Message-State: AElRT7EJr5w5gFFoQBrenT2PNdtHXSRjU3qA7XOHDSeFOc6s2wkJZVL6
        G/BRMP2mJmLHnr6vol1Pdw8mkg==
X-Google-Smtp-Source: AG47ELuUDf6scDShE+d43UISgbycTkaiAX7BHjlUbd5/uI0Uvn9fTqvDSat2HVHrbdxAvMh0de/krg==
X-Received: by 10.98.62.14 with SMTP id l14mr1811144pfa.206.1520972444641;
        Tue, 13 Mar 2018 13:20:44 -0700 (PDT)
Received: from localhost.localdomain ([27.34.104.85])
        by smtp.gmail.com with ESMTPSA id 68sm1498114pgi.14.2018.03.13.13.20.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 13 Mar 2018 13:20:43 -0700 (PDT)
From:   Pratik Karki <predatoramigo@gmail.com>
To:     git@vger.kernel.org
Cc:     Pratik Karki <predatoramigo@gmail.com>
Subject: [GSoC] [PATCH] test: avoid pipes in git related commands for test suite
Date:   Wed, 14 Mar 2018 02:04:45 +0545
Message-Id: <20180313201945.8409-1-predatoramigo@gmail.com>
X-Mailer: git-send-email 2.16.2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch removes the necessity of pipes in git related commands for test suite.

Exit code of the upstream in a pipe is ignored so, it's use should be avoided. The fix for this is to write the output of the git command to a file and test the exit codes of both the commands being linked by pipe.

Signed-off-by: Pratik Karki <predatoramigo@gmail.com>
---
 t/t7001-mv.sh                        | 24 ++++++++++++------------
 t/t9104-git-svn-follow-parent.sh     |  4 ++--
 t/t9110-git-svn-use-svm-props.sh     | 36 ++++++++++++++++++------------------
 t/t9111-git-svn-use-svnsync-props.sh | 36 ++++++++++++++++++------------------
 t/t9114-git-svn-dcommit-merge.sh     |  8 ++++----
 t/t9130-git-svn-authors-file.sh      | 16 ++++++++--------
 t/t9138-git-svn-authors-prog.sh      | 28 ++++++++++++++--------------
 t/t9153-git-svn-rewrite-uuid.sh      |  8 ++++----
 8 files changed, 80 insertions(+), 80 deletions(-)

diff --git a/t/t7001-mv.sh b/t/t7001-mv.sh
index 6e5031f56..0dcf1fa3e 100755
--- a/t/t7001-mv.sh
+++ b/t/t7001-mv.sh
@@ -21,8 +21,8 @@ test_expect_success \
 
 test_expect_success \
     'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
-    grep "^R100..*path0/COPYING..*path1/COPYING"'
+    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+    grep "^R100..*path0/COPYING..*path1/COPYING" actual'
 
 test_expect_success \
     'moving the file back into subdirectory' \
@@ -35,8 +35,8 @@ test_expect_success \
 
 test_expect_success \
     'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
-    grep "^R100..*path1/COPYING..*path0/COPYING"'
+    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+    grep "^R100..*path1/COPYING..*path0/COPYING" actual'
 
 test_expect_success \
     'checking -k on non-existing file' \
@@ -116,10 +116,10 @@ test_expect_success \
 
 test_expect_success \
     'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
-     grep "^R100..*path0/COPYING..*path2/COPYING" &&
-     git diff-tree -r -M --name-status  HEAD^ HEAD | \
-     grep "^R100..*path0/README..*path2/README"'
+    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+     grep "^R100..*path0/COPYING..*path2/COPYING" actual &&
+     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+     grep "^R100..*path0/README..*path2/README" actual'
 
 test_expect_success \
     'succeed when source is a prefix of destination' \
@@ -135,10 +135,10 @@ test_expect_success \
 
 test_expect_success \
     'checking the commit' \
-    'git diff-tree -r -M --name-status  HEAD^ HEAD | \
-     grep "^R100..*path2/COPYING..*path1/path2/COPYING" &&
-     git diff-tree -r -M --name-status  HEAD^ HEAD | \
-     grep "^R100..*path2/README..*path1/path2/README"'
+    'git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+     grep "^R100..*path2/COPYING..*path1/path2/COPYING" actual &&
+     git diff-tree -r -M --name-status  HEAD^ HEAD >actual &&
+     grep "^R100..*path2/README..*path1/path2/README" actual'
 
 test_expect_success \
     'do not move directory over existing directory' \
diff --git a/t/t9104-git-svn-follow-parent.sh b/t/t9104-git-svn-follow-parent.sh
index cd480edf1..284d1224e 100755
--- a/t/t9104-git-svn-follow-parent.sh
+++ b/t/t9104-git-svn-follow-parent.sh
@@ -204,8 +204,8 @@ test_expect_success "follow-parent is atomic" '
 test_expect_success "track multi-parent paths" '
 	svn_cmd cp -m "resurrect /glob" "$svnrepo"/r9270 "$svnrepo"/glob &&
 	git svn multi-fetch &&
-	test $(git cat-file commit refs/remotes/glob | \
-	       grep "^parent " | wc -l) -eq 2
+	test $(git cat-file commit refs/remotes/glob >actual &&
+	       grep "^parent " actual | wc -l) -eq 2
 	'
 
 test_expect_success "multi-fetch continues to work" "
diff --git a/t/t9110-git-svn-use-svm-props.sh b/t/t9110-git-svn-use-svm-props.sh
index dde0a3c22..a1a00c298 100755
--- a/t/t9110-git-svn-use-svm-props.sh
+++ b/t/t9110-git-svn-use-svm-props.sh
@@ -21,32 +21,32 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
 
 bar_url=http://mayonaise/svnrepo/bar
 test_expect_success 'verify metadata for /bar' "
-	git cat-file commit refs/remotes/bar | \
-	   grep '^git-svn-id: $bar_url@12 $uuid$' &&
-	git cat-file commit refs/remotes/bar~1 | \
-	   grep '^git-svn-id: $bar_url@11 $uuid$' &&
-	git cat-file commit refs/remotes/bar~2 | \
-	   grep '^git-svn-id: $bar_url@10 $uuid$' &&
-	git cat-file commit refs/remotes/bar~3 | \
-	   grep '^git-svn-id: $bar_url@9 $uuid$' &&
-	git cat-file commit refs/remotes/bar~4 | \
-	   grep '^git-svn-id: $bar_url@6 $uuid$' &&
-	git cat-file commit refs/remotes/bar~5 | \
-	   grep '^git-svn-id: $bar_url@1 $uuid$'
+	git cat-file commit refs/remotes/bar >actual &&
+	   grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~1 >actual &&
+	   grep '^git-svn-id: $bar_url@11 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~2 >actual &&
+	   grep '^git-svn-id: $bar_url@10 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~3 >actual &&
+	   grep '^git-svn-id: $bar_url@9 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~4 >actual &&
+	   grep '^git-svn-id: $bar_url@6 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~5 >actual &&
+	   grep '^git-svn-id: $bar_url@1 $uuid$' actual
 	"
 
 e_url=http://mayonaise/svnrepo/dir/a/b/c/d/e
 test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
-	git cat-file commit refs/remotes/e | \
-	   grep '^git-svn-id: $e_url@1 $uuid$'
+	git cat-file commit refs/remotes/e >actual &&
+	   grep '^git-svn-id: $e_url@1 $uuid$' actual
 	"
 
 dir_url=http://mayonaise/svnrepo/dir
 test_expect_success 'verify metadata for /dir' "
-	git cat-file commit refs/remotes/dir | \
-	   grep '^git-svn-id: $dir_url@2 $uuid$' &&
-	git cat-file commit refs/remotes/dir~1 | \
-	   grep '^git-svn-id: $dir_url@1 $uuid$'
+	git cat-file commit refs/remotes/dir >actual &&
+	   grep '^git-svn-id: $dir_url@2 $uuid$' actual &&
+	git cat-file commit refs/remotes/dir~1 >actual &&
+	   grep '^git-svn-id: $dir_url@1 $uuid$' actual
 	"
 
 test_expect_success 'find commit based on SVN revision number' "
diff --git a/t/t9111-git-svn-use-svnsync-props.sh b/t/t9111-git-svn-use-svnsync-props.sh
index 22b6e5ee7..5306a87f3 100755
--- a/t/t9111-git-svn-use-svnsync-props.sh
+++ b/t/t9111-git-svn-use-svnsync-props.sh
@@ -20,32 +20,32 @@ uuid=161ce429-a9dd-4828-af4a-52023f968c89
 
 bar_url=http://mayonaise/svnrepo/bar
 test_expect_success 'verify metadata for /bar' "
-	git cat-file commit refs/remotes/bar | \
-	   grep '^git-svn-id: $bar_url@12 $uuid$' &&
-	git cat-file commit refs/remotes/bar~1 | \
-	   grep '^git-svn-id: $bar_url@11 $uuid$' &&
-	git cat-file commit refs/remotes/bar~2 | \
-	   grep '^git-svn-id: $bar_url@10 $uuid$' &&
-	git cat-file commit refs/remotes/bar~3 | \
-	   grep '^git-svn-id: $bar_url@9 $uuid$' &&
-	git cat-file commit refs/remotes/bar~4 | \
-	   grep '^git-svn-id: $bar_url@6 $uuid$' &&
-	git cat-file commit refs/remotes/bar~5 | \
-	   grep '^git-svn-id: $bar_url@1 $uuid$'
+	git cat-file commit refs/remotes/bar >actual &&
+	   grep '^git-svn-id: $bar_url@12 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~1 >actual &&
+	   grep '^git-svn-id: $bar_url@11 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~2 >actual &&
+	   grep '^git-svn-id: $bar_url@10 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~3 >actual &&
+	   grep '^git-svn-id: $bar_url@9 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~4 >actual &&
+	   grep '^git-svn-id: $bar_url@6 $uuid$' actual &&
+	git cat-file commit refs/remotes/bar~5 >actual &&
+	   grep '^git-svn-id: $bar_url@1 $uuid$' actual
 	"
 
 e_url=http://mayonaise/svnrepo/dir/a/b/c/d/e
 test_expect_success 'verify metadata for /dir/a/b/c/d/e' "
-	git cat-file commit refs/remotes/e | \
-	   grep '^git-svn-id: $e_url@1 $uuid$'
+	git cat-file commit refs/remotes/e >actual &&
+	   grep '^git-svn-id: $e_url@1 $uuid$' actual
 	"
 
 dir_url=http://mayonaise/svnrepo/dir
 test_expect_success 'verify metadata for /dir' "
-	git cat-file commit refs/remotes/dir | \
-	   grep '^git-svn-id: $dir_url@2 $uuid$' &&
-	git cat-file commit refs/remotes/dir~1 | \
-	   grep '^git-svn-id: $dir_url@1 $uuid$'
+	git cat-file commit refs/remotes/dir >actual &&
+	   grep '^git-svn-id: $dir_url@2 $uuid$' actual &&
+	git cat-file commit refs/remotes/dir~1 >actual &&
+	   grep '^git-svn-id: $dir_url@1 $uuid$' actual
 	"
 
 test_done
diff --git a/t/t9114-git-svn-dcommit-merge.sh b/t/t9114-git-svn-dcommit-merge.sh
index 50bca62de..c945c3758 100755
--- a/t/t9114-git-svn-dcommit-merge.sh
+++ b/t/t9114-git-svn-dcommit-merge.sh
@@ -68,7 +68,7 @@ test_debug 'gitk --all & sleep 1'
 test_expect_success 'verify pre-merge ancestry' "
 	test x\$(git rev-parse --verify refs/heads/svn^2) = \
 	     x\$(git rev-parse --verify refs/heads/merge) &&
-	git cat-file commit refs/heads/svn^ | grep '^friend$'
+	git cat-file commit refs/heads/svn^ >actual && grep '^friend$' actual
 	"
 
 test_expect_success 'git svn dcommit merges' "
@@ -82,12 +82,12 @@ test_expect_success 'verify post-merge ancestry' "
 	     x\$(git rev-parse --verify refs/remotes/origin/trunk) &&
 	test x\$(git rev-parse --verify refs/heads/svn^2) = \
 	     x\$(git rev-parse --verify refs/heads/merge) &&
-	git cat-file commit refs/heads/svn^ | grep '^friend$'
+	git cat-file commit refs/heads/svn^ >actual && grep '^friend$' actual
 	"
 
 test_expect_success 'verify merge commit message' "
-	git rev-list --pretty=raw -1 refs/heads/svn | \
-	  grep \"    Merge branch 'merge' into svn\"
+	git rev-list --pretty=raw -1 refs/heads/svn >actual &&
+	  grep \"    Merge branch 'merge' into svn\" actual
 	"
 
 test_done
diff --git a/t/t9130-git-svn-authors-file.sh b/t/t9130-git-svn-authors-file.sh
index 41264818c..e12f8cf3b 100755
--- a/t/t9130-git-svn-authors-file.sh
+++ b/t/t9130-git-svn-authors-file.sh
@@ -27,10 +27,10 @@ test_expect_success 'imported 2 revisions successfully' '
 	(
 		cd x
 		test "$(git rev-list refs/remotes/git-svn | wc -l)" -eq 2 &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
-		  grep "^author BBBBBBB BBBBBBB <bb@example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
-		  grep "^author AAAAAAA AAAAAAA <aa@example\.com> "
+		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
+		  grep "^author BBBBBBB BBBBBBB <bb@example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
+		  grep "^author AAAAAAA AAAAAAA <aa@example\.com> " actual
 	)
 	'
 
@@ -44,10 +44,10 @@ test_expect_success 'continues to import once authors have been added' '
 		cd x
 		git svn fetch --authors-file=../svn-authors &&
 		test "$(git rev-list refs/remotes/git-svn | wc -l)" -eq 4 &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
-		  grep "^author DDDDDDD DDDDDDD <dd@example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
-		  grep "^author CCCCCCC CCCCCCC <cc@example\.com> "
+		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
+		  grep "^author DDDDDDD DDDDDDD <dd@example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
+		  grep "^author CCCCCCC CCCCCCC <cc@example\.com> " actual
 	)
 	'
 
diff --git a/t/t9138-git-svn-authors-prog.sh b/t/t9138-git-svn-authors-prog.sh
index 7d7e9d46b..5b04c2b40 100755
--- a/t/t9138-git-svn-authors-prog.sh
+++ b/t/t9138-git-svn-authors-prog.sh
@@ -44,24 +44,24 @@ test_expect_success 'imported 6 revisions successfully' '
 test_expect_success 'authors-prog ran correctly' '
 	(
 		cd x
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 | \
-		  grep "^author ee-foo <ee-foo@example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~2 | \
-		  grep "^author dd <dd@sub\.example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~3 | \
-		  grep "^author cc <cc@sub\.example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~4 | \
-		  grep "^author bb <bb@example\.com> " &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn~5 | \
-		  grep "^author aa <aa@example\.com> "
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~1 >actual &&
+		  grep "^author ee-foo <ee-foo@example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~2 >actual &&
+		  grep "^author dd <dd@sub\.example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~3 >actual &&
+		  grep "^author cc <cc@sub\.example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~4 >actual &&
+		  grep "^author bb <bb@example\.com> " actual &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn~5 >actual &&
+		  grep "^author aa <aa@example\.com> " actual
 	)
 '
 
 test_expect_success 'authors-file overrode authors-prog' '
 	(
 		cd x
-		git rev-list -1 --pretty=raw refs/remotes/git-svn | \
-		  grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> "
+		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
+		  grep "^author FFFFFFF FFFFFFF <fFf@other\.example\.com> " actual
 	)
 '
 
@@ -73,8 +73,8 @@ test_expect_success 'authors-prog handled special characters in username' '
 	(
 		cd x &&
 		git svn --authors-prog=../svn-authors-prog fetch &&
-		git rev-list -1 --pretty=raw refs/remotes/git-svn |
-		grep "^author xyz; touch evil <xyz; touch evil@example\.com> " &&
+		git rev-list -1 --pretty=raw refs/remotes/git-svn >actual &&
+		grep "^author xyz; touch evil <xyz; touch evil@example\.com> " actual &&
 		! test -f evil
 	)
 '
diff --git a/t/t9153-git-svn-rewrite-uuid.sh b/t/t9153-git-svn-rewrite-uuid.sh
index 372ef1568..3b00a9135 100755
--- a/t/t9153-git-svn-rewrite-uuid.sh
+++ b/t/t9153-git-svn-rewrite-uuid.sh
@@ -16,10 +16,10 @@ test_expect_success 'load svn repo' "
 	"
 
 test_expect_success 'verify uuid' "
-	git cat-file commit refs/remotes/git-svn~0 | \
-	   grep '^git-svn-id: .*@2 $uuid$' &&
-	git cat-file commit refs/remotes/git-svn~1 | \
-	   grep '^git-svn-id: .*@1 $uuid$'
+	git cat-file commit refs/remotes/git-svn~0 >actual &&
+	   grep '^git-svn-id: .*@2 $uuid$' actual &&
+	git cat-file commit refs/remotes/git-svn~1 >actual &&
+	   grep '^git-svn-id: .*@1 $uuid$' actual
 	"
 
 test_done
-- 
2.16.2

