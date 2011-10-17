From: mhagger@alum.mit.edu
Subject: [PATCH v4 3/7] invalidate_ref_cache(): expose this function in the refs API
Date: Mon, 17 Oct 2011 04:38:07 +0200
Message-ID: <1318819091-7066-4-git-send-email-mhagger@alum.mit.edu>
References: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Julian Phillips <julian@quantumfyre.co.uk>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 17 04:38:51 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RFd6I-0001z5-NV
	for gcvg-git-2@lo.gmane.org; Mon, 17 Oct 2011 04:38:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754307Ab1JQCis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 16 Oct 2011 22:38:48 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:45408 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754134Ab1JQCip (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 16 Oct 2011 22:38:45 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from michael.fritz.box (p54BECB73.dip.t-dialin.net [84.190.203.115])
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p9H2cN3V013403;
	Mon, 17 Oct 2011 04:38:31 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318819091-7066-1-git-send-email-mhagger@alum.mit.edu>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183754>

From: Michael Haggerty <mhagger@alum.mit.edu>

Make invalidate_ref_cache() an official part of the refs API.  It is
currently a fact of life that code outside of refs.c mucks about with
references.  This change gives such code a way of informing the refs
module that it should no longer trust its cache.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    2 +-
 refs.h |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 68b73aa..ddd799e 100644
--- a/refs.c
+++ b/refs.c
@@ -202,7 +202,7 @@ static struct ref_cache *get_ref_cache(const char *submodule)
 	return refs;
 }
 
-static void invalidate_ref_cache(const char *submodule)
+void invalidate_ref_cache(const char *submodule)
 {
 	clear_ref_cache(get_ref_cache(submodule));
 }
diff --git a/refs.h b/refs.h
index 0229c57..f439c54 100644
--- a/refs.h
+++ b/refs.h
@@ -80,6 +80,14 @@ extern void unlock_ref(struct ref_lock *lock);
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
+/*
+ * Invalidate the reference cache for the specified submodule.  Use
+ * submodule=NULL to invalidate the cache for the main module.  This
+ * function must be called if references are changed via a mechanism
+ * other than the refs API.
+ */
+extern void invalidate_ref_cache(const char *submodule);
+
 /** Setup reflog before using. **/
 int log_ref_setup(const char *ref_name, char *logfile, int bufsize);
 
-- 
1.7.7.rc2
