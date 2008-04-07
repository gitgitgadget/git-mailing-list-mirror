From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: [PATCH 1/2] decorate: use "const struct object"
Date: Mon, 7 Apr 2008 14:40:07 +0100 (BST)
Message-ID: <alpine.DEB.1.00.0804071439480.430@eeepc-johanness>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Apr 07 15:41:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JirbA-00055I-1C
	for gcvg-git-2@gmane.org; Mon, 07 Apr 2008 15:41:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757507AbYDGNke (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Apr 2008 09:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757482AbYDGNke
	(ORCPT <rfc822;git-outgoing>); Mon, 7 Apr 2008 09:40:34 -0400
Received: from mail.gmx.net ([213.165.64.20]:52943 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753510AbYDGNke (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Apr 2008 09:40:34 -0400
Received: (qmail invoked by alias); 07 Apr 2008 13:40:32 -0000
Received: from unknown (EHLO eeepc-johanness.st-andrews.ac.uk) [138.251.11.75]
  by mail.gmx.net (mp049) with SMTP; 07 Apr 2008 15:40:32 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1+atCcnb5Sa+CdvRM0BGZZ84zsfTTs2JsXqcPUnm0
	7GcnUBlnUHyvWG
X-X-Sender: user@eeepc-johanness
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/78975>


We use the object only as key for the decoration, therefore we should
access it as const struct object.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 decorate.c |   10 +++++-----
 decorate.h |    6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/decorate.c b/decorate.c
index 23f6b00..3aee3b7 100644
--- a/decorate.c
+++ b/decorate.c
@@ -6,13 +6,13 @@
 #include "object.h"
 #include "decorate.h"
 
-static unsigned int hash_obj(struct object *obj, unsigned int n)
+static unsigned int hash_obj(const struct object *obj, unsigned int n)
 {
 	unsigned int hash = *(unsigned int *)obj->sha1;
 	return hash % n;
 }
 
-static void *insert_decoration(struct decoration *n, struct object *base, void *decoration)
+static void *insert_decoration(struct decoration *n, const struct object *base, void *decoration)
 {
 	int size = n->size;
 	struct object_decoration *hash = n->hash;
@@ -47,7 +47,7 @@ static void grow_decoration(struct decoration *n)
 	n->nr = 0;
 
 	for (i = 0; i < old_size; i++) {
-		struct object *base = old_hash[i].base;
+		const struct object *base = old_hash[i].base;
 		void *decoration = old_hash[i].decoration;
 
 		if (!base)
@@ -58,7 +58,7 @@ static void grow_decoration(struct decoration *n)
 }
 
 /* Add a decoration pointer, return any old one */
-void *add_decoration(struct decoration *n, struct object *obj, void *decoration)
+void *add_decoration(struct decoration *n, const struct object *obj, void *decoration)
 {
 	int nr = n->nr + 1;
 
@@ -68,7 +68,7 @@ void *add_decoration(struct decoration *n, struct object *obj, void *decoration)
 }
 
 /* Lookup a decoration pointer */
-void *lookup_decoration(struct decoration *n, struct object *obj)
+void *lookup_decoration(struct decoration *n, const struct object *obj)
 {
 	int j;
 
diff --git a/decorate.h b/decorate.h
index 1fa4ad9..e732804 100644
--- a/decorate.h
+++ b/decorate.h
@@ -2,7 +2,7 @@
 #define DECORATE_H
 
 struct object_decoration {
-	struct object *base;
+	const struct object *base;
 	void *decoration;
 };
 
@@ -12,7 +12,7 @@ struct decoration {
 	struct object_decoration *hash;
 };
 
-extern void *add_decoration(struct decoration *n, struct object *obj, void *decoration);
-extern void *lookup_decoration(struct decoration *n, struct object *obj);
+extern void *add_decoration(struct decoration *n, const struct object *obj, void *decoration);
+extern void *lookup_decoration(struct decoration *n, const struct object *obj);
 
 #endif
-- 
1.5.5.rc0.208.g1d50
