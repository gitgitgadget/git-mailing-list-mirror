From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v2 7/7] clear_cached_refs(): inline function
Date: Mon, 10 Oct 2011 10:24:24 +0200
Message-ID: <1318235064-25915-8-git-send-email-mhagger@alum.mit.edu>
References: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
 <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 10:25:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RDBAY-0004ta-MY
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 10:25:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752729Ab1JJIYw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 04:24:52 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:57890 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751353Ab1JJIYv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 04:24:51 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RDB4o-0004Bi-Iu; Mon, 10 Oct 2011 10:19:10 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318235064-25915-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183237>

clear_cached_refs() was only called from one place, so inline it
there.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index 01a5958..bf53189 100644
--- a/refs.c
+++ b/refs.c
@@ -191,12 +191,6 @@ static void clear_cached_loose_refs(struct cached_refs *refs)
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
@@ -237,7 +231,9 @@ static struct cached_refs *get_cached_refs(const char *submodule)
 
 void invalidate_ref_cache(const char *submodule)
 {
-	clear_cached_refs(get_cached_refs(submodule));
+	struct cached_refs *refs = get_cached_refs(submodule);
+	clear_cached_packed_refs(refs);
+	clear_cached_loose_refs(refs);
 }
 
 static struct ref_list *read_packed_refs(FILE *f)
-- 
1.7.7.rc2
