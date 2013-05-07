From: Jeff King <peff@peff.net>
Subject: [PATCH 1/2] peel_ref: rename "sha1" argument to "peeled"
Date: Mon, 6 May 2013 22:56:22 -0400
Message-ID: <20130507025621.GA23219@sigill.intra.peff.net>
References: <20130507025458.GA22912@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael Haggerty <mhagger@alum.mit.edu>,
	Johan Herland <johan@herland.net>,
	Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 07 04:56:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZY4q-0000nj-L1
	for gcvg-git-2@plane.gmane.org; Tue, 07 May 2013 04:56:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760310Ab3EGC4Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 22:56:25 -0400
Received: from cloud.peff.net ([50.56.180.127]:43781 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758548Ab3EGC4Y (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 22:56:24 -0400
Received: (qmail 15185 invoked by uid 102); 7 May 2013 02:56:44 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 May 2013 21:56:44 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 May 2013 22:56:22 -0400
Content-Disposition: inline
In-Reply-To: <20130507025458.GA22912@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223530>

The "sha1" argument of peel_ref is meant to hold the peeled
object name for output. Let's call it "peeled" which makes
it more clear that it is not an input sha1 (especially as we
will be adding such an input sha1 in the next patch).

Signed-off-by: Jeff King <peff@peff.net>
---
Simple cleanup for the next step.

 refs.c | 8 ++++----
 refs.h | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/refs.c b/refs.c
index de2d8eb..89f8141 100644
--- a/refs.c
+++ b/refs.c
@@ -1231,7 +1231,7 @@ static int filter_refs(const char *refname, const unsigned char *sha1, int flags
 	return filter->fn(refname, sha1, flags, filter->cb_data);
 }
 
-int peel_ref(const char *refname, unsigned char *sha1)
+int peel_ref(const char *refname, unsigned char *peeled)
 {
 	int flag;
 	unsigned char base[20];
@@ -1242,7 +1242,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		if (current_ref->flag & REF_KNOWS_PEELED) {
 			if (is_null_sha1(current_ref->u.value.peeled))
 			    return -1;
-			hashcpy(sha1, current_ref->u.value.peeled);
+			hashcpy(peeled, current_ref->u.value.peeled);
 			return 0;
 		}
 		hashcpy(base, current_ref->u.value.sha1);
@@ -1257,7 +1257,7 @@ int peel_ref(const char *refname, unsigned char *sha1)
 		struct ref_entry *r = find_ref(dir, refname);
 
 		if (r != NULL && r->flag & REF_KNOWS_PEELED) {
-			hashcpy(sha1, r->u.value.peeled);
+			hashcpy(peeled, r->u.value.peeled);
 			return 0;
 		}
 	}
@@ -1274,7 +1274,7 @@ fallback:
 	if (o->type == OBJ_TAG) {
 		o = deref_tag_noverify(o);
 		if (o) {
-			hashcpy(sha1, o->sha1);
+			hashcpy(peeled, o->sha1);
 			return 0;
 		}
 	}
diff --git a/refs.h b/refs.h
index a35eafc..1e8b4e1 100644
--- a/refs.h
+++ b/refs.h
@@ -61,7 +61,7 @@ extern int ref_exists(const char *);
 
 extern int ref_exists(const char *);
 
-extern int peel_ref(const char *refname, unsigned char *sha1);
+extern int peel_ref(const char *refname, unsigned char *peeled);
 
 /** Locks a "refs/" ref returning the lock on success and NULL on failure. **/
 extern struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1);
-- 
1.8.3.rc1.2.g12db477
