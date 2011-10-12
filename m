From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 7/7] clear_cached_refs(): inline function
Date: Wed, 12 Oct 2011 20:44:27 +0200
Message-ID: <1318445067-19279-8-git-send-email-mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Wed Oct 12 20:50:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3sW-0006Yt-9m
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754023Ab1JLSty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:49:54 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:58253 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753978Ab1JLStw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:49:52 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RE3mf-0008JO-5w; Wed, 12 Oct 2011 20:44:05 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183396>

clear_cached_refs() was only called from one place, so inline it
there.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 9e9edf7..409314d 100644
--- a/refs.c
+++ b/refs.c
@@ -172,12 +172,6 @@ static void clear_cached_loose_refs(struct cached_refs *refs)
 	refs->did_loose = 0;
 }
 
-static void clear_cached_refs(struct cached_refs *refs)
-{
-	clear_cached_packed_refs(refs);
-	clear_cached_loose_refs(refs);
-}
-
 static struct cached_refs *create_cached_refs(const char *submodule)
 {
 	int len;
@@ -215,7 +209,9 @@ static struct cached_refs *get_cached_refs(const char *submodule)
 
 void invalidate_ref_cache(const char *submodule)
 {
-	clear_cached_refs(get_cached_refs(submodule));
+	struct cached_refs *refs = get_cached_refs(submodule);
+	clear_cached_packed_refs(refs);
+	clear_cached_loose_refs(refs);
 }
 
 static void read_packed_refs(FILE *f, struct ref_array *array)
-- 
1.7.7.rc2
