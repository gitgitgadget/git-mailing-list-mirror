From: mhagger@alum.mit.edu
Subject: [PATCH v4 5/7] clear_ref_cache(): extract two new functions
Date: Mon, 17 Oct 2011 04:38:09 +0200
Message-ID: <1318819091-7066-6-git-send-email-mhagger@alum.mit.edu>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:39:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFd6V-00026B-Om
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:39:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754341Ab1JQCiu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:38:50 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45416 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab1JQCit (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:38:49 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BECB73.dip.t-dialin.net [84.190.203.115])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9H2cN3X013403;
	Mon, 17 Oct 2011 04:38:34 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183755>

From: Michael Haggerty <mhagger@alum.mit.edu>

Extract two new functions from clear_cached_refs():
clear_loose_ref_cache() and clear_packed_ref_cache().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 623d673..2a21dc3 100644
--- a/refs.c
+++ b/refs.c
@@ -158,13 +158,24 @@ static void free_ref_array(struct ref_array *array)
 	array->refs = NULL;
 }
 
-static void clear_ref_cache(struct ref_cache *refs)
+static void clear_packed_ref_cache(struct ref_cache *refs)
 {
-	if (refs->did_loose)
-		free_ref_array(&refs->loose);
 	if (refs->did_packed)
 		free_ref_array(&refs->packed);
-	refs->did_loose = refs->did_packed = 0;
+	refs->did_packed = 0;
+}
+
+static void clear_loose_ref_cache(struct ref_cache *refs)
+{
+	if (refs->did_loose)
+		free_ref_array(&refs->loose);
+	refs->did_loose = 0;
+}
+
+static void clear_ref_cache(struct ref_cache *refs)
+{
+	clear_packed_ref_cache(refs);
+	clear_loose_ref_cache(refs);
 }
 
 static struct ref_cache *create_ref_cache(const char *submodule)
-- 
1.7.7.rc2
