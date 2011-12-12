From: mhagger@alum.mit.edu
Subject: [PATCH v2 22/51] names_conflict(): simplify implementation
Date: Mon, 12 Dec 2011 06:38:29 +0100
Message-ID: <1323668338-1764-23-git-send-email-mhagger@alum.mit.edu>
References: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 12 06:42:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RZyeI-00015m-6C
	for gcvg-git-2@lo.gmane.org; Mon, 12 Dec 2011 06:42:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753193Ab1LLFl4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Dec 2011 00:41:56 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:34710 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752448Ab1LLFkJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Dec 2011 00:40:09 -0500
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BEB2AB.dip.t-dialin.net [84.190.178.171])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id pBC5d8aZ015577;
	Mon, 12 Dec 2011 06:40:00 +0100
X-Mailer: git-send-email 1.7.8
In-Reply-To: <1323668338-1764-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186873>

From: Michael Haggerty <mhagger@alum.mit.edu>

Save a bunch of lines of code and a couple of strlen() calls.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   17 ++++-------------
 1 files changed, 4 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index c33e94a..12a70c1 100644
--- a/refs.c
+++ b/refs.c
@@ -1094,19 +1094,10 @@ static int remove_empty_directories(const char *file)
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
1.7.8
