From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 2/5] t0050: use the CASE_INSENSITIVE_FS test prereq
Date: Thu, 26 Jul 2012 15:39:54 +0200
Message-ID: <d404f849524e47602f72de88b4487863d23a60d1.1343309173.git.git@drmicha.warpmail.net>
References: <5001B82B.1060201@web.de>
Cc: tboegi@web.de
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 26 15:40:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SuOIq-0004YT-1a
	for gcvg-git-2@plane.gmane.org; Thu, 26 Jul 2012 15:40:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab2GZNkE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jul 2012 09:40:04 -0400
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:59050 "EHLO
	out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751773Ab2GZNkD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Jul 2012 09:40:03 -0400
Received: from compute1.internal (compute1.nyi.mail.srv.osa [10.202.2.41])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id BBE4020B93;
	Thu, 26 Jul 2012 09:40:02 -0400 (EDT)
Received: from frontend1.nyi.mail.srv.osa ([10.202.2.160])
  by compute1.internal (MEProxy); Thu, 26 Jul 2012 09:40:02 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=Qw
	OjSBiaFPI3i4q8HAUVd67YNug=; b=Ft9fYnHyJfwti/ECgLNmDhDhrl/fCoBKdC
	vRV10Iy8qCAiRWpoKRjYJjAVQ4O0HpRHFBa8J5K4NPIyZMrCK/78g5Zf/HAScafg
	DUiLXQn3twAgkoUs8uWFh8pgbGqDJHF/Y1DfSzxeqeAfGLAgBT4DW1crDaqjGICy
	e9cOiZdAY=
X-Sasl-enc: rrpG0QfSSFZxKOMsURcg6Zoxyi1fRlJBYC8oXmNOm9d9 1343310002
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 6203D8E011D;
	Thu, 26 Jul 2012 09:40:02 -0400 (EDT)
X-Mailer: git-send-email 1.7.12.rc0.198.gd66b616
In-Reply-To: <5001B82B.1060201@web.de>
In-Reply-To: <cover.1343309173.git.git@drmicha.warpmail.net>
References: <cover.1343309173.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202268>


Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t0050-filesystem.sh | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/t/t0050-filesystem.sh b/t/t0050-filesystem.sh
index 1542cf6..df9498b 100755
--- a/t/t0050-filesystem.sh
+++ b/t/t0050-filesystem.sh
@@ -7,23 +7,12 @@ test_description='Various filesystem issues'
 auml=$(printf '\303\244')
 aumlcdiar=$(printf '\141\314\210')
 
-case_insensitive=
 unibad=
 no_symlinks=
 test_expect_success 'see what we expect' '
 
-	test_case=test_expect_success &&
 	test_unicode=test_expect_success &&
 	mkdir junk &&
-	echo good >junk/CamelCase &&
-	echo bad >junk/camelcase &&
-	if test "$(cat junk/CamelCase)" != good
-	then
-		test_case=test_expect_failure &&
-		case_insensitive=t
-	fi &&
-	rm -fr junk &&
-	mkdir junk &&
 	>junk/"$auml" &&
 	case "$(cd junk && echo *)" in
 	"$aumlcdiar")
@@ -41,14 +30,20 @@ test_expect_success 'see what we expect' '
 	}
 '
 
-test "$case_insensitive" &&
+if test_have_prereq CASE_INSENSITIVE_FS
+then
 	say "will test on a case insensitive filesystem"
+	test_case=test_expect_failure
+else
+	test_case=test_expect_success
+fi
+
 test "$unibad" &&
 	say "will test on a unicode corrupting filesystem"
 test "$no_symlinks" &&
 	say "will test on a filesystem lacking symbolic links"
 
-if test "$case_insensitive"
+if test_have_prereq CASE_INSENSITIVE_FS
 then
 test_expect_success "detection of case insensitive filesystem during repo init" '
 
-- 
1.7.12.rc0.198.gd66b616
