From: =?ISO-8859-1?Q?Ren=E9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
Subject: [PATCH 2/4] t0024, t5000: use test_lazy_prereq for UNZIP
Date: Sun, 06 Jan 2013 18:49:00 +0100
Message-ID: <50E9B90C.2060200@lsrfire.ath.cx>
References: <7vwqw7mb09.fsf@alter.siamese.dyndns.org> <50E9B82D.50005@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>
To: git discussion list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Jan 06 18:49:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TruLb-0002iW-VR
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 18:49:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756086Ab3AFRtE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jan 2013 12:49:04 -0500
Received: from india601.server4you.de ([85.25.151.105]:37105 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753067Ab3AFRtE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jan 2013 12:49:04 -0500
Received: from [192.168.2.105] (p579BE5C2.dip.t-dialin.net [87.155.229.194])
	by india601.server4you.de (Postfix) with ESMTPSA id B640D193;
	Sun,  6 Jan 2013 18:49:01 +0100 (CET)
User-Agent: Mozilla/5.0 (Windows NT 6.2; WOW64; rv:17.0) Gecko/17.0 Thunderbird/17.0
In-Reply-To: <50E9B82D.50005@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212828>

This change makes the code smaller and we can put it at the top of
the script, its rightful place as setup code.

Signed-off-by: Rene Scharfe <rene.scharfe@lsrfire.ath.cx>
---
 t/t0024-crlf-archive.sh | 12 +++++-------
 t/t5000-tar-tree.sh     | 12 +++++-------
 2 files changed, 10 insertions(+), 14 deletions(-)

diff --git a/t/t0024-crlf-archive.sh b/t/t0024-crlf-archive.sh
index 080fe5c..ba397bb 100755
--- a/t/t0024-crlf-archive.sh
+++ b/t/t0024-crlf-archive.sh
@@ -5,6 +5,11 @@ test_description='respect crlf in git archive'
 . ./test-lib.sh
 GIT_UNZIP=${GIT_UNZIP:-unzip}
 
+test_lazy_prereq UNZIP '
+	"$GIT_UNZIP" -v >/dev/null 2>&1
+	test $? -ne 127
+'
+
 test_expect_success setup '
 
 	git config core.autocrlf true &&
@@ -26,13 +31,6 @@ test_expect_success 'tar archive' '
 
 '
 
-"$GIT_UNZIP" -v >/dev/null 2>&1
-if [ $? -eq 127 ]; then
-	say "Skipping ZIP test, because unzip was not found"
-else
-	test_set_prereq UNZIP
-fi
-
 test_expect_success UNZIP 'zip archive' '
 
 	git archive --format=zip HEAD >test.zip &&
diff --git a/t/t5000-tar-tree.sh b/t/t5000-tar-tree.sh
index 1f7593d..6702157 100755
--- a/t/t5000-tar-tree.sh
+++ b/t/t5000-tar-tree.sh
@@ -31,6 +31,11 @@ GUNZIP=${GUNZIP:-gzip -d}
 
 SUBSTFORMAT=%H%n
 
+test_lazy_prereq UNZIP '
+	"$GIT_UNZIP" -v >/dev/null 2>&1
+	test $? -ne 127
+'
+
 check_zip() {
 	zipfile=$1.zip
 	listfile=$1.lst
@@ -201,13 +206,6 @@ test_expect_success \
       test_cmp a/substfile2 g/prefix/a/substfile2
 '
 
-"$GIT_UNZIP" -v >/dev/null 2>&1
-if [ $? -eq 127 ]; then
-	say "Skipping ZIP tests, because unzip was not found"
-else
-	test_set_prereq UNZIP
-fi
-
 test_expect_success \
     'git archive --format=zip' \
     'git archive --format=zip HEAD >d.zip'
-- 
1.7.12
