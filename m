From: mhagger@alum.mit.edu
Subject: [PATCH v2 11/12] names_conflict(): simplify implementation
Date: Fri, 28 Oct 2011 13:28:03 +0200
Message-ID: <1319801284-15625-12-git-send-email-mhagger@alum.mit.edu>
References: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 28 13:30:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJkdu-0003Lo-Sw
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 13:30:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439Ab1J1Laa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 07:30:30 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:55033 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751913Ab1J1La3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 07:30:29 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RJkVI-0007Cx-N0; Fri, 28 Oct 2011 13:21:40 +0200
X-Mailer: git-send-email 1.7.7
In-Reply-To: <1319801284-15625-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184371>

From: Michael Haggerty <mhagger@alum.mit.edu>


Save a bunch of lines of code and a couple of strlen() calls.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index 62e5fd3..2a5d8b2 100644
--- a/refs.c
+++ b/refs.c
@@ -1100,19 +1100,10 @@ static int remove_empty_directories(const char *file)
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
