From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: [PATCH 2/2] invalidate_cached_refs(): expose this function in refs API
Date: Mon, 10 Oct 2011 07:46:14 +0200
Message-ID: <1318225574-18785-3-git-send-email-mhagger@alum.mit.edu>
References: <7v39f2rko5.fsf@alter.siamese.dyndns.org>
 <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 10 07:46:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RD8hD-00064v-7L
	for gcvg-git-2@lo.gmane.org; Mon, 10 Oct 2011 07:46:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751833Ab1JJFqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 10 Oct 2011 01:46:30 -0400
Received: from mail.berlin.jpk.com ([212.222.128.130]:56648 "EHLO
	mail.berlin.jpk.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751726Ab1JJFq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 10 Oct 2011 01:46:29 -0400
Received: from michael.berlin.jpk.com ([192.168.100.152])
	by mail.berlin.jpk.com with esmtp (Exim 4.50)
	id 1RD8bZ-0003hC-K0; Mon, 10 Oct 2011 07:40:49 +0200
X-Mailer: git-send-email 1.7.7.rc2
In-Reply-To: <1318225574-18785-1-git-send-email-mhagger@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183225>

Make invalidate_cached_refs() an official part of the refs API.  It is
currently a fact of life that code outside of refs.c mucks about with
references.  This change gives such code a way of informing the refs
module that it should no longer trust its cache.

Signed-off-by: Michael Haggerty <mhagger@alum.mit.edu>
---
 refs.c |    2 +-
 refs.h |    8 ++++++++
 2 files changed, 9 insertions(+), 1 deletions(-)

diff --git a/refs.c b/refs.c
index 49b73c4..0483ecc 100644
--- a/refs.c
+++ b/refs.c
@@ -223,7 +223,7 @@ static struct cached_refs *get_cached_refs(const char *submodule)
 	return refs;
 }
 
-static void invalidate_cached_refs(const char *submodule)
+void invalidate_cached_refs(const char *submodule)
 {
 	clear_cached_refs(get_cached_refs(submodule));
 }
diff --git a/refs.h b/refs.h
index 5de06e5..63dc68c 100644
--- a/refs.h
+++ b/refs.h
@@ -77,6 +77,14 @@ extern void unlock_ref(struct ref_lock *lock);
 /** Writes sha1 into the ref specified by the lock. **/
 extern int write_ref_sha1(struct ref_lock *lock, const unsigned char *sha1, const char *msg);
 
+/*
+ * Invalidate the reference cache for the specified submodule.  Use
+ * submodule=NULL to invalidate the cache for the main module.  This
+ * function must be called if references are changed via a mechanism
+ * other than the refs API.
+ */
+extern void invalidate_cached_refs(const char *submodule);
+
 /** Setup reflog before using. **/
 int log_ref_setup(const char *ref_name, char *logfile, int bufsize);
 
-- 
1.7.7.rc2
