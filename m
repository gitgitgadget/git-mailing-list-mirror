From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 04/33] refs: document how current_ref is used
Date: Sun, 14 Apr 2013 14:54:19 +0200
Message-ID: <1365944088-10588-5-git-send-email-mhagger@alum.mit.edu>
References: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Sun Apr 14 14:56:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URMUI-0005c4-A9
	for gcvg-git-2@plane.gmane.org; Sun, 14 Apr 2013 14:56:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751880Ab3DNMzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 14 Apr 2013 08:55:33 -0400
Received: from ALUM-MAILSEC-SCANNER-4.MIT.EDU ([18.7.68.15]:54958 "EHLO
	alum-mailsec-scanner-4.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751849Ab3DNMzW (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 14 Apr 2013 08:55:22 -0400
X-AuditID: 1207440f-b7f0e6d000000957-f6-516aa73a8e65
Received: from outgoing-alum.mit.edu (OUTGOING-ALUM.MIT.EDU [18.7.68.33])
	by alum-mailsec-scanner-4.mit.edu (Symantec Messaging Gateway) with SMTP id 89.7A.02391.A37AA615; Sun, 14 Apr 2013 08:55:22 -0400 (EDT)
Received: from michael.fritz.box (p57A24996.dip.t-dialin.net [87.162.73.150])
	(authenticated bits=0)
        (User authenticated as mhagger@ALUM.MIT.EDU)
	by outgoing-alum.mit.edu (8.13.8/8.12.4) with ESMTP id r3ECtAk1007029
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 14 Apr 2013 08:55:20 -0400
X-Mailer: git-send-email 1.8.2.1
In-Reply-To: <1365944088-10588-1-git-send-email-mhagger@alum.mit.edu>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFjrCIsWRmVeSWpSXmKPExsUixO6iqGu1PCvQ4HcDv0XXlW4mi4beK8wW
	Kx/fZba4vWI+s8WPlh5mB1aPv+8/MHm0v3/H7PGsdw+jx8VLyh6fN8kFsEZx2yQllpQFZ6bn
	6dslcGd8WjmfteAQe8Xk904NjN1sXYwcHBICJhLf+2q6GDmBTDGJC/fWA4W5OIQELjNK3Ft2
	mAXCOcsk8ePaDiaQKjYBXYlFPc1MIM0iAtkSu9fKg4SZBRwkNn9uZASxhQVsJbp3vwArZxFQ
	lfi4eQuYzSvgIrF82m1WiGUKEse3bwOr5xRwlZj+/Bg7iC0EVDNr82zWCYy8CxgZVjHKJeaU
	5urmJmbmFKcm6xYnJ+blpRbpmujlZpbopaaUbmKEhBP/Dsau9TKHGAU4GJV4eB1YsgKFWBPL
	iitzDzFKcjApifIuXAoU4kvKT6nMSCzOiC8qzUktPsQowcGsJMLr2AqU401JrKxKLcqHSUlz
	sCiJ86ovUfcTEkhPLEnNTk0tSC2CycpwcChJ8L4GGSpYlJqeWpGWmVOCkGbi4AQRXCAbeIA2
	vAUp5C0uSMwtzkyHKDrFqCglzvsRJCEAksgozYMbAIv8V4ziQP8I8z4FqeIBJg247ldAg5mA
	BvvsTQcZXJKIkJJqYMz2iJG0iSjfLrpz2vdHL9L/SFglmkWs3tIe3cFzQX1Cx8dn59UPXJOb
	6K3sUvb14u763Bk2i9bfv3UxJc7ZSMKsyGHPi8MH0r8Wi/MsL5yy8dam53+yWLewfjD5c7py
	K2vJi36+r1m72rl1ckUzhZu7415N0lgx6e/D9u6veX1rr5n84G94t0uJpTgj0VCL 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221127>


Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/refs.c b/refs.c
index f503ec4..88ff153 100644
--- a/refs.c
+++ b/refs.c
@@ -528,6 +528,15 @@ static void sort_ref_dir(struct ref_dir *dir)
 /* Include broken references in a do_for_each_ref*() iteration: */
 #define DO_FOR_EACH_INCLUDE_BROKEN 0x01
 
+/*
+ * current_ref is a performance hack: when iterating over references
+ * using the for_each_ref*() functions, current_ref is set to the
+ * current reference's entry before calling the callback function.  If
+ * the callback function calls peel_ref(), then peel_ref() first
+ * checks whether the reference to be peeled is the current reference
+ * (it usually is) and if so, returns that reference's peeled version
+ * if it is available.  This avoids a refname lookup in a common case.
+ */
 static struct ref_entry *current_ref;
 
 /*
-- 
1.8.2.1
