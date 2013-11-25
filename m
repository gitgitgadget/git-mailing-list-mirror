From: Thomas Rast <tr@thomasrast.ch>
Subject: [PATCH 2/2] commit-slab: declare functions "static inline"
Date: Mon, 25 Nov 2013 20:02:01 +0100
Message-ID: <f4d1ff9f487f797da35faa86c72d11832903a50d.1385405977.git.tr@thomasrast.ch>
References: <cover.1385405977.git.tr@thomasrast.ch>
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 25 20:02:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vl1QV-0004WG-08
	for gcvg-git-2@plane.gmane.org; Mon, 25 Nov 2013 20:02:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757430Ab3KYTCV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Nov 2013 14:02:21 -0500
Received: from psi.thgersdorf.net ([176.9.98.78]:56220 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757203Ab3KYTCT (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Nov 2013 14:02:19 -0500
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 6AE644D658F;
	Mon, 25 Nov 2013 20:02:18 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id pvbEOOzTMKTB; Mon, 25 Nov 2013 20:02:08 +0100 (CET)
Received: from linux-k42r.v.cablecom.net (unknown [213.55.184.244])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 357144D659F;
	Mon, 25 Nov 2013 20:02:07 +0100 (CET)
X-Mailer: git-send-email 1.8.5.rc3.397.g2a3acd5
In-Reply-To: <cover.1385405977.git.tr@thomasrast.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238330>

This shuts up compiler warnings about unused functions.

While there, also remove the redundant second declaration of
stat_##slabname##realloc.

Signed-off-by: Thomas Rast <tr@thomasrast.ch>
---
 commit-slab.h | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/commit-slab.h b/commit-slab.h
index d77aaea..d5c353e 100644
--- a/commit-slab.h
+++ b/commit-slab.h
@@ -45,8 +45,8 @@ struct slabname {							\
 };									\
 static int stat_ ##slabname## realloc;					\
 									\
-static void init_ ##slabname## _with_stride(struct slabname *s,		\
-					    unsigned stride)		\
+static inline void init_ ##slabname## _with_stride(struct slabname *s,	\
+						   unsigned stride)	\
 {									\
 	unsigned int elem_size;						\
 	if (!stride)							\
@@ -58,12 +58,12 @@ struct slabname {							\
 	s->slab = NULL;							\
 }									\
 									\
-static void init_ ##slabname(struct slabname *s)			\
+static inline void init_ ##slabname(struct slabname *s)			\
 {									\
 	init_ ##slabname## _with_stride(s, 1);				\
 }									\
 									\
-static void clear_ ##slabname(struct slabname *s)			\
+static inline void clear_ ##slabname(struct slabname *s)		\
 {									\
 	int i;								\
 	for (i = 0; i < s->slab_count; i++)				\
@@ -73,8 +73,8 @@ struct slabname {							\
 	s->slab = NULL;							\
 }									\
 									\
-static elemtype *slabname## _at(struct slabname *s,			\
-				const struct commit *c)			\
+static inline elemtype *slabname## _at(struct slabname *s,		\
+				       const struct commit *c)		\
 {									\
 	int nth_slab, nth_slot;						\
 									\
@@ -94,8 +94,7 @@ struct slabname {							\
 		s->slab[nth_slab] = xcalloc(s->slab_size,		\
 					    sizeof(**s->slab) * s->stride);		\
 	return &s->slab[nth_slab][nth_slot * s->stride];				\
-}									\
-									\
-static int stat_ ##slabname## realloc
+}
+
 
 #endif /* COMMIT_SLAB_H */
-- 
1.8.5.rc3.397.g2a3acd5
