From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: [PATCH v2 03/20] t5800: use skip_all instead of prereq
Date: Sun, 19 Jun 2011 17:18:28 +0200
Message-ID: <1308496725-22329-4-git-send-email-srabbelier@gmail.com>
References: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Cc: Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>,
	Ramkumar
X-From: git-owner@vger.kernel.org Sun Jun 19 17:19:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QYJn2-0003jn-13
	for gcvg-git-2@lo.gmane.org; Sun, 19 Jun 2011 17:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754345Ab1FSPTl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 19 Jun 2011 11:19:41 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:44389 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754318Ab1FSPTf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 19 Jun 2011 11:19:35 -0400
Received: by ewy4 with SMTP id 4so981213ewy.19
        for <git@vger.kernel.org>; Sun, 19 Jun 2011 08:19:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=dDZ1AXrhPmrSMdN+ZnxZYefx1Uoux9Lp89VD7i5Va+M=;
        b=PKLz6p/oojKvOUw0YyLBIFlyxpowcuqVONewGeawO6K7JfTaCKZPKTqVTSMfc+rh6+
         Nou+lXc0RAZHSSSY/N20oYpBHpsUG71phFS6yJoYrLXROtRtqDYk0FStUVQ3/rhTjgCm
         GtdbRBCicjkASoTCOu8avopTH2Lp/nQ19/UDU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=ukenjHudsDSqScO4DoMx9B8VZRyqkJjFkmz8Crcn47BnMJ54DTBlI3XeXxeKedOjYw
         xcmwtG1KbyYPv+7soR9MTVhqcWl1timP1i38cNDaZWvGFODfycasPzhXWMlS9Mf+AX1x
         cs9OclHkkHtJgYKknnXCI8uWf7+R9u0UwYYDA=
Received: by 10.14.96.78 with SMTP id q54mr1582940eef.157.1308496774190;
        Sun, 19 Jun 2011 08:19:34 -0700 (PDT)
Received: from localhost.localdomain ([188.142.63.148])
        by mx.google.com with ESMTPS id y6sm3824429eem.18.2011.06.19.08.19.32
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 19 Jun 2011 08:19:33 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.1.292.g728120
In-Reply-To: <1308496725-22329-1-git-send-email-srabbelier@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176006>

All tests require python 2.4 or higher.

Signed-off-by: Sverre Rabbelier <srabbelier@gmail.com>
---

  New in this series.

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
