From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH v3 3/7] invalidate_ref_cache(): expose this function in refs API
Date: Wed, 12 Oct 2011 20:44:23 +0200
Message-ID: <1318445067-19279-4-git-send-email-mhagger@alum.mit.edu>
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
X-From: git-owner@vger.kernel.org Wed Oct 12 20:49:49 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RE3sB-0006MY-8Q
	for gcvg-git-2@lo.gmane.org; Wed, 12 Oct 2011 20:49:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754007Ab1JLStm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Oct 2011 14:49:42 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:58205 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754003Ab1JLStl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Oct 2011 14:49:41 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RE3mU-0008JO-7T; Wed, 12 Oct 2011 20:43:54 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318445067-19279-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183391>

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
index cc72609..b08d476 100644
--- a/refs.c
+++ b/refs.c
@@ -202,7 +202,7 @@ static struct cached_refs *get_cached_refs(const char *submodule)
 	return refs;
 }
 
-static void invalidate_ref_cache(const char *submodule)
+void invalidate_ref_cache(const char *submodule)
 {
 	clear_cached_refs(get_cached_refs(submodule));
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
