From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 3/5] t0050: use the SYMLINKS test prereq
Date: Thu, 26 Jul 2012 15:39:55 +0200
Message-ID: <8a35a99e9694af4cccda19199c7543d748d41d73.1343309173.git.git@drmicha.warpmail.net>
References: <5001B82B.1060201@web.de>
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 15:40:21 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuOIf-0004LP-9z
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 15:40:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752048Ab2GZNkH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 09:40:07 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:50162 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751773Ab2GZNkE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 09:40:04 -0400
Received: from compute6.internal (compute6.nyi.mail.srv.osa [10.202.2.46])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id 5EFF220AA5;
	Thu, 26 Jul 2012 09:40:04 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute6.internal (MEProxy); Thu, 26 Jul 2012 09:40:04 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=xS
	yfaoCUTcz+gvLhEtH9Hfqt2JM=; b=M9W6OhNScKYDQ8vYfVqKsmTZNhcME2hgF5
	NseE87R3AzlwfF1wdqlcSmzMPXE+42c6a5oPTEjPXpfl/mQnTGiAxShtlWiDacIs
	oLduUSjbNXMU7JTjp3pVqr2iGmwOCRqtzmqDYmi8ni5eZLz3hhrynoq26tnLr4FC
	DMm0DaivE=
X-Sasl-enc: ltSLCbSuRN+tIp44EJ9+vYIlo70KbhDtbzDdZ2618m8G 1343310003
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id E7259483525;
	Thu, 26 Jul 2012 09:40:03 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc0.198.gd66b616
In-Reply-To: <5001B82B.1060201@web.de>
In-Reply-To: <cover.1343309173.git.git@drmicha.warpmail.net>
References: <cover.1343309173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202264>


Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t0050-filesystem.sh | 21 +++++++--------------
 1 file changed, 7 insertions(+), 14 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index df9498b..b46ae72 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -8,7 +8,6 @@ auml=$(printf '\303\244')
 aumlcdiar=$(printf '\141\314\210')
 
 unibad=
-no_symlinks=
 test_expect_success 'see what we expect' '
 
 	test_unicode=test_expect_success &&
@@ -21,13 +20,7 @@ test_expect_success 'see what we expect' '
 		;;
 	*)	;;
 	esac &&
-	rm -fr junk &&
-	{
-		ln -s x y 2> /dev/null &&
-		test -h y 2> /dev/null ||
-		no_symlinks=1 &&
-		rm -f y
-	}
+	rm -fr junk
 '
 
 if test_have_prereq CASE_INSENSITIVE_FS
@@ -40,7 +33,7 @@ fi
 
 test "$unibad" &&
 	say "will test on a unicode corrupting filesystem"
-test "$no_symlinks" &&
+test_have_prereq SYMLINKS ||
 	say "will test on a filesystem lacking symbolic links"
 
 if test_have_prereq CASE_INSENSITIVE_FS
@@ -57,18 +50,18 @@ test_expect_success "detection of case insensitive filesystem during repo init"
 '
 fi
 
-if test "$no_symlinks"
+if test_have_prereq SYMLINKS
 then
 test_expect_success "detection of filesystem w/o symlink support during repo init" '
 
-	v=$(git config --bool core.symlinks) &&
-	test "$v" = false
+	test_must_fail git config --bool core.symlinks ||
+	test "$(git config --bool core.symlinks)" = true
 '
 else
 test_expect_success "detection of filesystem w/o symlink support during repo init" '
 
-	test_must_fail git config --bool core.symlinks ||
-	test "$(git config --bool core.symlinks)" = true
+	v=$(git config --bool core.symlinks) &&
+	test "$v" = false
 '
 fi
 
-- 
1.7.12.rc0.198.gd66b616
