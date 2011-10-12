From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 5/7] clear_cached_refs(): extract two new functions
Date: Wed, 12 Oct 2011 20:44:25 +0200
Message-ID: <1318445067-19279-6-git-send-email-mhagger@alum.mit.edu>
References: <7vty7ggzum.fsf@alter.siamese.dyndns.org>
 <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 12 20:50:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3sV-0006Yt-7l
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:50:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754013Ab1JLSts (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:49:48 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:58222 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab1JLStq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:49:46 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RE3mZ-0008JO-4B; Wed, 12 Oct 2011 20:43:59 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183395>

Extract two new functions from clear_cached_refs():
clear_loose_ref_cache() and clear_packed_ref_cache().

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 79e3576..9d962bd 100644
--- a/refs.c
+++ b/refs.c
@@ -158,13 +158,24 @@ static void free_ref_array(struct ref_array *array)
 	array->refs = NULL;
 }
 
-static void clear_cached_refs(struct cached_refs *refs)
+static void clear_cached_packed_refs(struct cached_refs *refs)
 {
-	if (refs->did_loose)
-		free_ref_array(&refs->loose);
 	if (refs->did_packed)
 		free_ref_array(&refs->packed);
-	refs->did_loose = refs->did_packed = 0;
+	refs->did_packed = 0;
+}
+
+static void clear_cached_loose_refs(struct cached_refs *refs)
+{
+	if (refs->did_loose)
+		free_ref_array(&refs->loose);
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
