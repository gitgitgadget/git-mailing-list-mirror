From: mhagger@alum.mit.edu
Subject: [PATCH 11/12] names_conflict(): simplify implementation
Date: Wed, 19 Oct 2011 23:44:51 +0200
Message-ID: <1319060692-27216-12-git-send-email-mhagger@alum.mit.edu>
References: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 19 23:50:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RGe1f-0002A1-FY
	for gcvg-git-2@lo.gmane.org; Wed, 19 Oct 2011 23:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754743Ab1JSVuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Oct 2011 17:50:08 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:33231 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753787Ab1JSVuH (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Oct 2011 17:50:07 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RGdqr-0004K1-ML; Wed, 19 Oct 2011 23:39:05 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319060692-27216-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183982>

From: Michael Haggerty <mhagger@alum.mit.edu>


Save a bunch of lines of code and a couple of strlen() calls.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index ada691b..4bc6041 100644
--- a/refs.c
+++ b/refs.c
@@ -1096,19 +1096,10 @@ static int remove_empty_directories(const char *file)
  */
 static int names_conflict(const char *refname1, const char *refname2)
 {
-	int len1 = strlen(refname1);
-	int len2 = strlen(refname2);
-	int cmplen;
-	const char *lead;
-
-	if (len1 < len2) {
-		cmplen = len1;
-		lead = refname2;
-	} else {
-		cmplen = len2;
-		lead = refname1;
-	}
-	return !strncmp(refname1, refname2, cmplen) && lead[cmplen] == '/';
+	for (; *refname1 && *refname1 == *refname2; refname1++, refname2++)
+		;
+	return (*refname1 == '\0' && *refname2 == '/')
+		|| (*refname1 == '/' && *refname2 == '\0');
 }
 
 /*
-- 
1.7.7
