From: mhagger@alum.mit.edu
Subject: [PATCH 07/15] names_conflict(): simplify implementation
Date: Tue, 10 Apr 2012 07:30:19 +0200
Message-ID: <1334035827-20331-8-git-send-email-mhagger@alum.mit.edu>
References: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Apr 10 07:31:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SHTgG-0002ab-Sy
	for gcvg-git-2@plane.gmane.org; Tue, 10 Apr 2012 07:31:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753185Ab2DJFbA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Apr 2012 01:31:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:59218 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752638Ab2DJFa6 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2012 01:30:58 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0B8CA.dip.t-dialin.net [79.192.184.202])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3A5UXe0000870;
	Tue, 10 Apr 2012 07:30:51 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1334035827-20331-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195073>

From: Michael Haggerty <mhagger@alum.mit.edu>

Save a bunch of lines of code and a couple of strlen() calls.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/refs.c b/refs.c
index cdb66d9..d4f58b8 100644
--- a/refs.c
+++ b/refs.c
@@ -342,19 +342,10 @@ static int do_for_each_ref_in_arrays(struct ref_array *array1,
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
1.7.10
