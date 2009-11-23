From: Brian Gernhardt <brian@gernhardtsoftware.com>
Subject: [PATCH] t/gitweb-lib: Split HTTP response with non-GNU sed
Date: Mon, 23 Nov 2009 12:33:42 -0500
Message-ID: <1258997622-62403-1-git-send-email-brian@gernhardtsoftware.com>
Cc: Junio C Hamano <gitster@pobox.com>
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Nov 23 18:33:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCcnP-0007vS-Nm
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 18:33:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753110AbZKWRdj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 12:33:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752922AbZKWRdj
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 12:33:39 -0500
Received: from vs072.rosehosting.com ([216.114.78.72]:38484 "EHLO
	silverinsanity.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752761AbZKWRdi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 12:33:38 -0500
Received: by silverinsanity.com (Postfix, from userid 5001)
	id BB5E11FFC087; Mon, 23 Nov 2009 17:33:40 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on silverinsanity.com
X-Spam-Level: 
X-Spam-Status: No, score=-4.5 required=4.0 tests=ALL_TRUSTED,AWL,BAYES_00,
	URIBL_RED autolearn=ham version=3.2.5
Received: from localhost.localdomain (cpe-67-240-172-169.rochester.res.rr.com [67.240.172.169])
	by silverinsanity.com (Postfix) with ESMTPA id E5DED1FFC06B;
	Mon, 23 Nov 2009 17:33:38 +0000 (UTC)
X-Mailer: git-send-email 1.6.5.3.433.g11067
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133512>

Recognizing \r in a regex is something GNU sed will do, but other sed
implementation's won't.  (Found with BSD sed on OS X.) So use a
literal carriage return instead.

Signed-off-by: Brian Gernhardt <brian@gernhardtsoftware.com>
---
 t/gitweb-lib.sh |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 32b841d..35dda58 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -52,8 +52,8 @@ gitweb_run () {
 	rm -f gitweb.log &&
 	perl -- "$SCRIPT_NAME" \
 		>gitweb.output 2>gitweb.log &&
-	sed -e   '/^\r$/q' <gitweb.output >gitweb.headers &&
-	sed -e '1,/^\r$/d' <gitweb.output >gitweb.body    &&
+	sed -e   '/^
$/q' <gitweb.output >gitweb.headers &&
+	sed -e '1,/^
$/d' <gitweb.output >gitweb.body    &&
 	if grep '^[[]' gitweb.log >/dev/null 2>&1; then false; else true; fi
 
 	# gitweb.log is left for debugging
-- 
1.6.5.3.433.g11067
