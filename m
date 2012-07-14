From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH] t3910: give reason for skipping the test
Date: Sat, 14 Jul 2012 19:52:25 +0200
Message-ID: <71c43b6e469c916f6c41026ad6ed25c1094018be.1342287902.git.git@drmicha.warpmail.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 14 19:52:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq6WC-0007ld-JD
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 19:52:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751375Ab2GNRwc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 13:52:32 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:48825 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751191Ab2GNRwa (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 14 Jul 2012 13:52:30 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 48C3B20C60
	for <git@vger.kernel.org>; Sat, 14 Jul 2012 13:52:30 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Sat, 14 Jul 2012 13:52:30 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:subject:date:message-id; s=
	smtpout; bh=+wk+8E+6ID9uwjXMLEk+Cm+1cfo=; b=gl32cBcvzHJ0lLxVla+C
	/jSAHBLnGGWNrzNO8dOB2XZ8gy9fZhoZ7uAzbmW3r2i+35GDVHMpICJeIn3EnHd4
	O/9gsQFHy9n5N74Q6mzoBz6ZHgDxSh6BMyOO6wotjfPpDMy5EazkrC+0/sW5lXHY
	A2l7zlCSnF7+e8D3uJAgGqY=
X-Sasl-enc: KFqGnt5NoLpA6VTWNpwxVeTkY9z5kgCugH1M+6Di83w7 1342288349
Received: from localhost (unknown [79.199.72.217])
	by mail.messagingengine.com (Postfix) with ESMTPA id 95A5F4837EA;
	Sat, 14 Jul 2012 13:52:29 -0400 (EDT)
X-Mailer: git-send-email 1.7.11.2.381.gb6e9843
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201446>

t3910 is skipped for most users because it requires a filesystem which
does automatic conversion between different utf-8 types. Currently, this
results in a skipped test with "no reason given".

Use the skip_all mechanism from our test suite so that a reason for
skipping the test is given to the user.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
Alternatively, we could set a prerequisite and mark all tests with that.  Since
it's either or for the whole test skip_all seems more appropriate.  In that
case, we can also flatten the else branch, of course. The current patch is
minimally invasive, though.

 t/t3910-mac-os-precompose.sh | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/t/t3910-mac-os-precompose.sh b/t/t3910-mac-os-precompose.sh
index 88b7a20..fb7c7ff 100755
--- a/t/t3910-mac-os-precompose.sh
+++ b/t/t3910-mac-os-precompose.sh
@@ -22,8 +22,11 @@ esac
 rm -rf junk
 
 
-if test "$test_nfd"
+if ! test "$test_nfd"
 then
+	skip_all="filesystem does not convert utf-8 nfd to nfc"
+	test_done
+else
 	# create more utf-8 variables
 	Odiarnfc=`printf '\303\226'`
 	Odiarnfd=`printf 'O\314\210'`
@@ -157,8 +160,6 @@ then
 		precomposeunicode=`git config core.precomposeunicode` &&
 		test "$precomposeunicode" = "true"
 	'
-else
-	 say "Skipping nfc/nfd tests"
 fi
 
 test_done
-- 
1.7.11.2.381.gb6e9843
