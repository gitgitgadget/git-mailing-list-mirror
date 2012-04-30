From: mhagger@alum.mit.edu
Subject: [RFC 2/7] check_refname_component(): fix check with REFNAME_DOT_COMPONENT
Date: Tue,  1 May 2012 01:02:50 +0200
Message-ID: <1335826975-3093-3-git-send-email-mhagger@alum.mit.edu>
References: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 01:03:37 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzd3-0000YN-Be
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 01:03:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757412Ab2D3XD3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Apr 2012 19:03:29 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:41741 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757027Ab2D3XDI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 19:03:08 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p4FC0D9D4.dip.t-dialin.net [79.192.217.212])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id q3UN2xbB028766;
	Tue, 1 May 2012 01:03:02 +0200
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1335826975-3093-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196634>

From: Michael Haggerty <mhagger@alum.mit.edu>

When REFNAME_DOT_COMPONENT is set, we want to allow refname components
that start with '.' but not equal to ".".  The old code would have
allowed refname components equal to "." if they were not the last
component of the refname.  Fix the test.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/refs.c b/refs.c
index 927d36c..c293fd2 100644
--- a/refs.c
+++ b/refs.c
@@ -59,7 +59,7 @@ static int check_refname_component(const char *refname, int flags)
 		 * Even if leading dots are allowed, don't allow "."
 		 * as a component (".." is prevented by a rule above).
 		 */
-		if (len == 1)
+		if (i == 1)
 			return -1; /* Component equals ".". */
 	}
 	if (i >= 5 && !memcmp(&refname[i - 5], ".lock", 5))
-- 
1.7.10
