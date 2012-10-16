From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: [PATCH 1/4] t3419-rebase-patch-id: heed USR_BIN_TIME prereq
Date: Tue, 16 Oct 2012 13:39:44 +0200
Message-ID: <b04898886f0c7ed9d943aef0ce6e047f10c97d76.1350387132.git.git@drmicha.warpmail.net>
References: <k5gq60$q8c$1@ger.gmane.org>
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Oct 16 13:40:12 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TO5VD-0003yi-7v
	for gcvg-git-2@plane.gmane.org; Tue, 16 Oct 2012 13:40:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754552Ab2JPLjw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Oct 2012 07:39:52 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:54628 "EHLO
	out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754515Ab2JPLjv (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 16 Oct 2012 07:39:51 -0400
Received: from compute2.internal (compute2.nyi.mail.srv.osa [10.202.2.42])
	by gateway1.nyi.mail.srv.osa (Postfix) with ESMTP id CC41920918;
	Tue, 16 Oct 2012 07:39:50 -0400 (EDT)
Received: from frontend2.nyi.mail.srv.osa ([10.202.2.161])
  by compute2.internal (MEProxy); Tue, 16 Oct 2012 07:39:50 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=from:to:cc:subject:date:message-id
	:in-reply-to:references:in-reply-to:references; s=smtpout; bh=xa
	AgTBjVt7dIcn+gkvTfrff73K8=; b=e6mPNtx2XoSmDvXAkTRc/6S/QqLU6yjjNa
	jVEXTjMFIHcojP0phTyAIIXgqRDtUbJECpuQSECw9Zm9H3/N0TpRk/qEYlhKtD5i
	s/k2uQjF0lPKOHIOedZ/310CYf5m1AheCnFSTAuPYsGNDfsMsaeX+xbbv9inzrKo
	deewx2PuQ=
X-Sasl-enc: zM+cn5ZQbMsU0lXymTaY8uuOghBlZ8NFPUSAka5UoBW4 1350387590
Received: from localhost (unknown [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 7525D4825E5;
	Tue, 16 Oct 2012 07:39:50 -0400 (EDT)
X-Mailer: git-send-email 1.8.0.rc2.304.g9f3ac5c
In-Reply-To: <k5gq60$q8c$1@ger.gmane.org>
In-Reply-To: <cover.1350387132.git.git@drmicha.warpmail.net>
References: <cover.1350387132.git.git@drmicha.warpmail.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207817>

t3419 sets the t3419-rebase-patch-id.sh prereq based on the availability
of /usr/bin/time but calls the binary unconditionally (in debug mode).

Make it run the timing only when the prereq is matched.

Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
---
 t/t3419-rebase-patch-id.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t3419-rebase-patch-id.sh b/t/t3419-rebase-patch-id.sh
index e70ac10..52af547 100755
--- a/t/t3419-rebase-patch-id.sh
+++ b/t/t3419-rebase-patch-id.sh
@@ -69,7 +69,7 @@ do_tests()
 		git cherry-pick master >/dev/null 2>&1
 	"
 
-	test_debug "
+	test_have_prereq USR_BIN_TIME && test_debug "
 		run git diff master^\!
 	"
 
@@ -77,7 +77,7 @@ do_tests()
 		echo 'file binary' >.gitattributes
 	"
 
-	test_debug "
+	test_have_prereq USR_BIN_TIME && test_debug "
 		run git format-patch --stdout master &&
 		run git format-patch --stdout --ignore-if-in-upstream master
 	"
-- 
1.8.0.rc2.304.g9f3ac5c
