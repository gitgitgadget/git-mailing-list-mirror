From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 25/28] rebase: use 'cherrypick' mode instead of 'am'
Date: Fri, 30 Aug 2013 00:56:19 -0500
Message-ID: <1377842182-18724-26-git-send-email-felipe.contreras@gmail.com>
References: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 30 08:02:16 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFHmf-0007iQ-2P
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 08:02:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755965Ab3H3GCH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 02:02:07 -0400
Received: from mail-oa0-f51.google.com ([209.85.219.51]:48950 "EHLO
	mail-oa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755841Ab3H3GCE (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 02:02:04 -0400
Received: by mail-oa0-f51.google.com with SMTP id h1so1758133oag.24
        for <git@vger.kernel.org>; Thu, 29 Aug 2013 23:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=92Gn4m/lvUFLfW36Y8o2zHR/ktJh1FJQ58+8khTNDOM=;
        b=PdBZMJODQYC+lpcMFslpnxq1BRAVMJnH+LtT1quTGwaVmyZAyiPCoClm0xVJeo1XDh
         WvospvhIEQFygeU4kaXk7x/w7BAoA4FsHwQkbQudqEyy861j6culzM8atx0/UpPAPea8
         aDnslRL19Q8WJHvREi1Psmri++Q49uQWjJt5eiBcuD72NfTpS6GTz8ns9ibno92LNYxv
         QhWDmY9IoyDjSPQjrx3TQYOQWd0z/+rRna2JZdQLIgzmPnTKWztok22vZT8r82MppKkj
         H77Uten+jyKZjFZ82rRTeV7rgCsMuJgcvT5ZIL9o8kkPyOu0HXblYz3pxt/yc2q0xNlM
         3jJg==
X-Received: by 10.60.80.8 with SMTP id n8mr5510604oex.33.1377842524326;
        Thu, 29 Aug 2013 23:02:04 -0700 (PDT)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id rl1sm36955456oeb.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 29 Aug 2013 23:02:03 -0700 (PDT)
X-Mailer: git-send-email 1.8.4-fc
In-Reply-To: <1377842182-18724-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233418>

Unless any specific 'git am' options are used.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 git-rebase.sh                          | 8 ++++----
 t/t3407-rebase-abort.sh                | 2 +-
 t/t3420-rebase-autostash.sh            | 2 +-
 t/t3425-rebase-topology-merges.sh      | 6 +++---
 t/t5520-pull.sh                        | 2 +-
 t/t9106-git-svn-commit-diff-clobber.sh | 2 +-
 6 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/git-rebase.sh b/git-rebase.sh
index ebe87a3..f0291df 100755
--- a/git-rebase.sh
+++ b/git-rebase.sh
@@ -415,13 +415,13 @@ elif test -n "$do_merge"
 then
 	type=merge
 	state_dir="$merge_dir"
-elif test -n "$keep_empty"
+elif test -n "$git_am_opt"
 then
-	type=cherrypick
-	state_dir="$merge_dir"
-else
 	type=am
 	state_dir="$apply_dir"
+else
+	type=cherrypick
+	state_dir="$merge_dir"
 fi
 
 if test -z "$rebase_root"
diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index a6a6c40..2699b08 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -96,7 +96,7 @@ testrebase() {
 	'
 }
 
-testrebase "" .git/rebase-apply
+testrebase "" .git/rebase-merge
 testrebase " --merge" .git/rebase-merge
 
 test_done
diff --git a/t/t3420-rebase-autostash.sh b/t/t3420-rebase-autostash.sh
index c179262..58bf705 100755
--- a/t/t3420-rebase-autostash.sh
+++ b/t/t3420-rebase-autostash.sh
@@ -162,7 +162,7 @@ test_expect_success "rebase: noop rebase" '
 	)
 '
 
-testrebase "" .git/rebase-apply
+testrebase "" .git/rebase-merge
 testrebase " --merge" .git/rebase-merge
 testrebase " --interactive" .git/rebase-merge
 
diff --git a/t/t3425-rebase-topology-merges.sh b/t/t3425-rebase-topology-merges.sh
index 1d195fb..99b4535 100755
--- a/t/t3425-rebase-topology-merges.sh
+++ b/t/t3425-rebase-topology-merges.sh
@@ -71,7 +71,7 @@ test_run_rebase () {
 	"
 }
 #TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'e n o' ''
+test_run_rebase success 'n o e' ''
 test_run_rebase success 'e n o' -m
 test_run_rebase success 'n o e' -i
 
@@ -88,7 +88,7 @@ test_run_rebase () {
 	"
 }
 #TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'd e n o' ''
+test_run_rebase success 'd n o e' ''
 test_run_rebase success 'd e n o' -m
 test_run_rebase success 'd n o e' -i
 
@@ -105,7 +105,7 @@ test_run_rebase () {
 	"
 }
 #TODO: make order consistent across all flavors of rebase
-test_run_rebase success 'd e n o' ''
+test_run_rebase success 'd n o e' ''
 test_run_rebase success 'd e n o' -m
 test_run_rebase success 'd n o e' -i
 
diff --git a/t/t5520-pull.sh b/t/t5520-pull.sh
index ed4d9c8..751b50d 100755
--- a/t/t5520-pull.sh
+++ b/t/t5520-pull.sh
@@ -273,7 +273,7 @@ test_expect_success 'setup for avoiding reapplying old patches' '
 test_expect_success 'git pull --rebase does not reapply old patches' '
 	(cd dst &&
 	 test_must_fail git pull --rebase &&
-	 test 1 = $(find .git/rebase-apply -name "000*" | wc -l)
+	 test 1 = $(cat .git/sequencer/todo | wc -l)
 	)
 '
 
diff --git a/t/t9106-git-svn-commit-diff-clobber.sh b/t/t9106-git-svn-commit-diff-clobber.sh
index f6d7ac7..b9cec33 100755
--- a/t/t9106-git-svn-commit-diff-clobber.sh
+++ b/t/t9106-git-svn-commit-diff-clobber.sh
@@ -92,7 +92,7 @@ test_expect_success 'multiple dcommit from git svn will not clobber svn' "
 
 
 test_expect_success 'check that rebase really failed' '
-	test -d .git/rebase-apply
+	test -d .git/rebase-merge
 '
 
 test_expect_success 'resolve, continue the rebase and dcommit' "
-- 
1.8.4-fc
