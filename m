From: mhagger@alum.mit.edu
Subject: [PATCH v4 7/7] clear_ref_cache(): inline function
Date: Mon, 17 Oct 2011 04:38:11 +0200
Message-ID: <1318819091-7066-8-git-send-email-mhagger@alum.mit.edu>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:39:06 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFd6X-00026B-S1
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:39:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754445Ab1JQCjB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:39:01 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45422 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754378Ab1JQCiy (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:38:54 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BECB73.dip.t-dialin.net [84.190.203.115])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9H2cN3Z013403;
	Mon, 17 Oct 2011 04:38:38 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183760>

From: Michael Haggerty <mhagger@alum.mit.edu>

clear_ref_cache() was only called from one place, so inline it
there.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |   10 +++-------
 1 files changed, 3 insertions(+), 7 deletions(-)

diff --git a/refs.c b/refs.c
index a888cea..d8a4fa3 100644
--- a/refs.c
+++ b/refs.c
@@ -172,12 +172,6 @@ static void clear_loose_ref_cache(struct ref_cache *refs)
 	refs->did_loose = 0;
 }
 
-static void clear_ref_cache(struct ref_cache *refs)
-{
-	clear_packed_ref_cache(refs);
-	clear_loose_ref_cache(refs);
-}
-
 static struct ref_cache *create_ref_cache(const char *submodule)
 {
 	int len;
@@ -215,7 +209,9 @@ static struct ref_cache *get_ref_cache(const char *submodule)
 
 void invalidate_ref_cache(const char *submodule)
 {
-	clear_ref_cache(get_ref_cache(submodule));
+	struct ref_cache *refs = get_ref_cache(submodule);
+	clear_packed_ref_cache(refs);
+	clear_loose_ref_cache(refs);
 }
 
 static void read_packed_refs(FILE *f, struct ref_array *array)
-- 
1.7.7.rc2
