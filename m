From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v3 03/23] t5800: use skip_all instead of prereq
Date: Sat, 16 Jul 2011 15:03:23 +0200
Message-ID: <1310821424-4750-4-git-send-email-srabbelier@gmail.com>
References: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sat Jul 16 15:04:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qi4Xu-00056J-NJ
	for gcvg-git-2@lo.gmane.org; Sat, 16 Jul 2011 15:04:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754708Ab1GPNEb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Jul 2011 09:04:31 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:57335 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754701Ab1GPNE1 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Jul 2011 09:04:27 -0400
Received: by mail-ew0-f46.google.com with SMTP id 4so996062ewy.19
        for <git@vger.kernel.org>; Sat, 16 Jul 2011 06:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=S4q73MPY+s1ZclgPhuxu4FbYfV6vLDXkLkaZ/HUb/dI=;
        b=EjtZZ/HPgoLZNWD3SlR8BXk94VfGFZofBEE37ASwkss2IPCrHeQCmfrl0JpliJzgDq
         UMVaTsSSnXdR2k/C4AZ/tifNBQFzeEwSY9dLQqgeWkVICg8kIQI8WMpU3yheLV+QG1xq
         NTYNPxJsTh8BQSuJAU/KLNvfdto984qRdFwNE=
Received: by 10.213.29.80 with SMTP id p16mr581688ebc.44.1310821466663;
        Sat, 16 Jul 2011 06:04:26 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id q16sm1212533eef.7.2011.07.16.06.04.24
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Jul 2011 06:04:25 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1310821424-4750-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177257>

All tests require python 2.4 or higher.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  Unchanged

 t/t5800-remote-helpers.sh |   34 +++++++++++++++++++---------------
 1 files changed, 19 insertions(+), 15 deletions(-)

diff --git a/t/t5800-remote-helpers.sh b/t/t5800-remote-helpers.sh
index 3a37ad0..f6796e3 100755
--- a/t/t5800-remote-helpers.sh
+++ b/t/t5800-remote-helpers.sh
@@ -7,15 +7,19 @@ test_description='Test remote-helper import and export commands'
 
 . ./test-lib.sh
 
-if test_have_prereq PYTHON && "$PYTHON_PATH" -c '
+if ! test_have_prereq PYTHON ; then
+	skip_all='skipping git-remote-hg tests, python not available'
+	test_done
+fi
+
+"$PYTHON_PATH" -c '
 import sys
 if sys.hexversion < 0x02040000:
     sys.exit(1)
-'
-then
-    # Requires Python 2.4 or newer
-	test_set_prereq PYTHON_24
-fi
+' || {
+	skip_all='skipping git-remote-hg tests, python version < 2.4'
+	test_done
+}
 
 compare_refs() {
 	git --git-dir="$1/.git" rev-parse --verify $2 >expect &&
@@ -23,7 +27,7 @@ compare_refs() {
 	test_cmp expect actual
 }
 
-test_expect_success PYTHON_24 'setup repository' '
+test_expect_success 'setup repository' '
 	git init --bare server/.git &&
 	git clone server public &&
 	(cd public &&
@@ -33,34 +37,34 @@ test_expect_success PYTHON_24 'setup repository' '
 	 git push origin master)
 '
 
-test_expect_success PYTHON_24 'cloning from local repo' '
+test_expect_success 'cloning from local repo' '
 	git clone "testgit::${PWD}/server" localclone &&
 	test_cmp public/file localclone/file
 '
 
-test_expect_success PYTHON_24 'cloning from remote repo' '
+test_expect_success 'cloning from remote repo' '
 	git clone "testgit::file://${PWD}/server" clone &&
 	test_cmp public/file clone/file
 '
 
-test_expect_success PYTHON_24 'create new commit on remote' '
+test_expect_success 'create new commit on remote' '
 	(cd public &&
 	 echo content >>file &&
 	 git commit -a -m two &&
 	 git push)
 '
 
-test_expect_success PYTHON_24 'pulling from local repo' '
+test_expect_success 'pulling from local repo' '
 	(cd localclone && git pull) &&
 	test_cmp public/file localclone/file
 '
 
-test_expect_success PYTHON_24 'pulling from remote remote' '
+test_expect_success 'pulling from remote remote' '
 	(cd clone && git pull) &&
 	test_cmp public/file clone/file
 '
 
-test_expect_success PYTHON_24 'pushing to local repo' '
+test_expect_success 'pushing to local repo' '
 	(cd localclone &&
 	echo content >>file &&
 	git commit -a -m three &&
@@ -68,12 +72,12 @@ test_expect_success PYTHON_24 'pushing to local repo' '
 	compare_refs localclone HEAD server HEAD
 '
 
-test_expect_success PYTHON_24 'synch with changes from localclone' '
+test_expect_success 'synch with changes from localclone' '
 	(cd clone &&
 	 git pull)
 '
 
-test_expect_success PYTHON_24 'pushing remote local repo' '
+test_expect_success 'pushing remote local repo' '
 	(cd clone &&
 	echo content >>file &&
 	git commit -a -m four &&
-- 
1.7.5.1.292.g728120
