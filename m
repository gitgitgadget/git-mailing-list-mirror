From: Elijah Newren <newren@gmail.com>
Subject: [RFC PATCHv2 02/16] t4017 (diff-retval): replace manual exit code check with test_expect_code
Date: Fri, 24 Sep 2010 16:22:42 -0600
Message-ID: <1285366976-22216-3-git-send-email-newren@gmail.com>
References: <1285366976-22216-1-git-send-email-newren@gmail.com>
Cc: Elijah Newren <newren@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 25 00:21:33 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OzGe0-0000U4-4c
	for gcvg-git-2@lo.gmane.org; Sat, 25 Sep 2010 00:21:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758250Ab0IXWVV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 24 Sep 2010 18:21:21 -0400
Received: from mail-qy0-f174.google.com ([209.85.216.174]:48207 "EHLO
	mail-qy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753683Ab0IXWVU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Sep 2010 18:21:20 -0400
Received: by qyk36 with SMTP id 36so1937273qyk.19
        for <git@vger.kernel.org>; Fri, 24 Sep 2010 15:21:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=BIINvUj07vwzUVkuz42kD9/tZsNxtk4VDRbrswRwg1w=;
        b=EBTSSVjY+3BTrsMDPlGhPLKCie/wZ/oSrLB36giaXbuh31PHc0bmVmgLd1RhvhtEYo
         Xo4kvcSRlYteCmeo4daMwxF2KQ9ujXinIf5gevS6HpBOJHXLCyfhGwpBvsZIeV1/UO4E
         BaI7CErSS0oOTWGMbtMTExhZtuiKSYvX8EBtE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=a4dodQZQPl6gFKQLaVD5qyp5FTtmWjzUmf5WUO6d++R0pIsTgH4KXgjmma6Z2lL7XJ
         2GnoV+puSeklHlUmRfyenwPiGSuSyYbTuE0FhBKOAVEMoiZkllm/MAN9uXx4mV1hhesX
         x2Adl/4dWpdr7ytD/DqL2v7LaoItK701Q06aM=
Received: by 10.220.126.220 with SMTP id d28mr1336039vcs.146.1285366879462;
        Fri, 24 Sep 2010 15:21:19 -0700 (PDT)
Received: from Miney.hsd1.nm.comcast.net. (c-76-113-57-218.hsd1.nm.comcast.net [76.113.57.218])
        by mx.google.com with ESMTPS id r35sm1865945vbw.17.2010.09.24.15.21.17
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 24 Sep 2010 15:21:18 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.95.g14291
In-Reply-To: <1285366976-22216-1-git-send-email-newren@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/157075>


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
