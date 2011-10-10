From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 5/7] clear_cached_refs(): extract two new functions
Date: Mon, 10 Oct 2011 10:24:22 +0200
Message-ID: <1318235064-25915-6-git-send-email-mhagger@alum.mit.edu>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
 <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 10:25:09 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDBAX-0004ta-Kw
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 10:25:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752543Ab1JJIYr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 04:24:47 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57861 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1JJIYp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 04:24:45 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RDB4j-0004Bi-5U; Mon, 10 Oct 2011 10:19:05 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183235>

Extract two new functions from clear_cached_refs():
clear_loose_ref_cache() and clear_packed_ref_cache().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   22 +++++++++++++++++-----
 1 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index 9f004ce..6e480ad 100644
--- a/refs.c
+++ b/refs.c
@@ -175,14 +175,26 @@ static void free_ref_list(struct ref_list *list)
 	}
 }
 
-static void clear_cached_refs(struct cached_refs *refs)
+static void clear_cached_packed_refs(struct cached_refs *refs)
 {
-	if (refs->did_loose && refs->loose)
-		free_ref_list(refs->loose);
 	if (refs->did_packed && refs->packed)
 		free_ref_list(refs->packed);
-	refs->loose = refs->packed = NULL;
-	refs->did_loose = refs->did_packed = 0;
+	refs->packed = NULL;
+	refs->did_packed = 0;
+}
+
+static void clear_cached_loose_refs(struct cached_refs *refs)
+{
+	if (refs->did_loose && refs->loose)
+		free_ref_list(refs->loose);
+	refs->loose = NULL;
+	refs->did_loose = 0;
+}
+
+static void clear_cached_refs(struct cached_refs *refs)
+{
+	clear_cached_packed_refs(refs);
+	clear_cached_loose_refs(refs);
 }
 
 static struct cached_refs *create_cached_refs(const char *submodule)
-- 
1.7.7.rc2
