From: Elijah Newren <newren@gmail.com>
Subject: [PATCHv3 02/16] t4017 (diff-retval): replace manual exit code check with test_expect_code
Date: Sat, 25 Sep 2010 13:06:53 -0600
Message-ID: <1285441627-28233-3-git-send-email-newren@gmail.com>
References: <1285441627-28233-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 21:05:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oza40-00051f-86
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 21:05:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756508Ab0IYTFb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 25 Sep 2010 15:05:31 -0400
Received: from mail-pv0-f174.google.com ([74.125.83.174]:41285 "EHLO
	mail-pv0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752968Ab0IYTFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Sep 2010 15:05:30 -0400
Received: by mail-pv0-f174.google.com with SMTP id 2so931665pvg.19
        for <git@vger.kernel.org>; Sat, 25 Sep 2010 12:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BIINvUj07vwzUVkuz42kD9/tZsNxtk4VDRbrswRwg1w=;
        b=YxzmoLXRxmcRhXmLEJmChPBB7SVQUJp+XaN/isOqPekTXvqEKX54WJx2po3Edfe8tv
         8fcmU37tMAXkMMdljpe+M69HnO6Gv/MsYnsciFFITn5t+lK7w+D9ZVc2nQ84D8fP+b/J
         MEMcc9cR0piIhwPseYPiN038Zpxns+XlJrC7M=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=Peg7Ld/gn4aEk3BdpqKV1bRbuYLWOM/hxx4UXW2VElLO/ovZOKogdHeLi1JZaLAXP9
         KODIXIMNgcJqrkpKrdSof8DNPSzNnXuSlT0bP2v1/wVofTp5NHQvNkU8gRTU1TvjWZAW
         AGb+EwvlHnAVlXfOhu2e58a336jPBLNelLf6w=
Received: by 10.114.137.15 with SMTP id k15mr5525418wad.225.1285441530078;
        Sat, 25 Sep 2010 12:05:30 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id o17sm6338669wal.21.2010.09.25.12.05.27
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 25 Sep 2010 12:05:29 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285441627-28233-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157174>


Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t4017-diff-retval.sh |   30 ++++++++++--------------------
 1 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/t/t4017-diff-retval.sh b/t/t4017-diff-retval.sh
index 6158985..6605e12 100755
--- a/t/t4017-diff-retval.sh
+++ b/t/t4017-diff-retval.sh
@@ -28,37 +28,29 @@ test_expect_success 'git diff --quiet -w  HEAD^ HEAD' '
 	test_must_fail git diff --quiet -w HEAD^ HEAD
 '
 
-test_expect_success 'git diff-tree HEAD^ HEAD' '
+test_expect_code 1 'git diff-tree HEAD^ HEAD' '
 	git diff-tree --exit-code HEAD^ HEAD
-	test $? = 1
 '
-test_expect_success 'git diff-tree HEAD^ HEAD -- a' '
+test_expect_code 0 'git diff-tree HEAD^ HEAD -- a' '
 	git diff-tree --exit-code HEAD^ HEAD -- a
-	test $? = 0
 '
-test_expect_success 'git diff-tree HEAD^ HEAD -- b' '
+test_expect_code 1 'git diff-tree HEAD^ HEAD -- b' '
 	git diff-tree --exit-code HEAD^ HEAD -- b
-	test $? = 1
 '
-test_expect_success 'echo HEAD | git diff-tree --stdin' '
+test_expect_code 1 'echo HEAD | git diff-tree --stdin' '
 	echo $(git rev-parse HEAD) | git diff-tree --exit-code --stdin
-	test $? = 1
 '
-test_expect_success 'git diff-tree HEAD HEAD' '
+test_expect_code 0 'git diff-tree HEAD HEAD' '
 	git diff-tree --exit-code HEAD HEAD
-	test $? = 0
 '
-test_expect_success 'git diff-files' '
+test_expect_code 0 'git diff-files' '
 	git diff-files --exit-code
-	test $? = 0
 '
-test_expect_success 'git diff-index --cached HEAD' '
+test_expect_code 0 'git diff-index --cached HEAD' '
 	git diff-index --exit-code --cached HEAD
-	test $? = 0
 '
-test_expect_success 'git diff-index --cached HEAD^' '
+test_expect_code 1 'git diff-index --cached HEAD^' '
 	git diff-index --exit-code --cached HEAD^
-	test $? = 1
 '
 test_expect_success 'git diff-index --cached HEAD^' '
 	echo text >>b &&
@@ -74,9 +66,8 @@ test_expect_success 'git diff-tree -Stext HEAD^ HEAD -- b' '
 		test $? = 1
 	}
 '
-test_expect_success 'git diff-tree -Snot-found HEAD^ HEAD -- b' '
+test_expect_code 0 'git diff-tree -Snot-found HEAD^ HEAD -- b' '
 	git diff-tree -p --exit-code -Snot-found HEAD^ HEAD -- b
-	test $? = 0
 '
 test_expect_success 'git diff-files' '
 	echo 3 >>c && {
@@ -113,10 +104,9 @@ test_expect_success '--check --exit-code returns 3 for a dirty difference' '
 
 '
 
-test_expect_success '--check with --no-pager returns 2 for dirty difference' '
+test_expect_code 2 '--check with --no-pager returns 2 for dirty difference' '
 
 	git --no-pager diff --check
-	test $? = 2
 
 '
 
-- 
1.7.3.95.g14291
