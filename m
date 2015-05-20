From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 1/4] for-each-ref: rename refinfo members to match similar structures
Date: Wed, 20 May 2015 18:48:21 +0530
Message-ID: <1432127904-21070-1-git-send-email-karthik.188@gmail.com>
References: <555C88C2.8060902@gmail.com>
Cc: matthieu.moy@grenoble-inp.fr, christian.couder@gmail.com,
	Jeff King <peff@peff.net>,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 20 15:19:57 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yv3ue-0002tJ-8z
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 15:19:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752039AbbETNT0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 09:19:26 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:33783 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752888AbbETNSj (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 09:18:39 -0400
Received: by pdbqa5 with SMTP id qa5so68829569pdb.0
        for <git@vger.kernel.org>; Wed, 20 May 2015 06:18:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=cGtAoYyp+23dYl087KP8jItrqZjrPOuayP1g2YCRVu4=;
        b=Ka11xJZeXGTicFYtQqiKjMAwL8s5PQ9L/ooZY8/YbjcoGUH6qSirUHfnep6rPPiZTd
         3HqQ3po+eo6RnTQHPeeJETGYXs64aLxxe5JhgUpR/zEAnyeEEzrl6GNTKkwzNcO0WcX1
         vt63gJrhMXxdS/7HPxqUv/jVtbfGQl4mKti3zRND2QAAJ45u4cdxLv5sfQsMY+UzQaGI
         eeL7XlH92qjnd1QqLlBwh9218iEnbNtQb8tlY/gx/PZx9INf25dGKoyZl0yRwdP/R0Z8
         LDHwapKullm4epXaxq5sl9MHn5gZaalQEauc1qOivnqHxdOmDi4HkP/jlxXAMp8Ns/KC
         BX3Q==
X-Received: by 10.70.127.231 with SMTP id nj7mr62944701pdb.110.1432127918901;
        Wed, 20 May 2015 06:18:38 -0700 (PDT)
Received: from ashley.localdomain ([106.51.128.148])
        by mx.google.com with ESMTPSA id g2sm16230585pdn.3.2015.05.20.06.18.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 20 May 2015 06:18:38 -0700 (PDT)
X-Mailer: git-send-email 2.4.1
In-Reply-To: <555C88C2.8060902@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269465>

From: Jeff King <peff@peff.net>

Written-by: Jeff King <peff@peff.net>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 83f9cf9..2721228 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -32,9 +32,9 @@ struct ref_sort {
 };
 
 struct refinfo {
-	char *refname;
-	unsigned char objectname[20];
-	int flag;
+	char *name;
+	unsigned char sha1[20];
+	int flags;
 	const char *symref;
 	struct atom_value *value;
 };
@@ -632,9 +632,9 @@ static void populate_value(struct refinfo *ref)
 
 	ref->value = xcalloc(used_atom_cnt, sizeof(struct atom_value));
 
-	if (need_symref && (ref->flag & REF_ISSYMREF) && !ref->symref) {
+	if (need_symref && (ref->flags & REF_ISSYMREF) && !ref->symref) {
 		unsigned char unused1[20];
-		ref->symref = resolve_refdup(ref->refname, RESOLVE_REF_READING,
+		ref->symref = resolve_refdup(ref->name, RESOLVE_REF_READING,
 					     unused1, NULL);
 		if (!ref->symref)
 			ref->symref = "";
@@ -655,14 +655,14 @@ static void populate_value(struct refinfo *ref)
 		}
 
 		if (starts_with(name, "refname"))
-			refname = ref->refname;
+			refname = ref->name;
 		else if (starts_with(name, "symref"))
 			refname = ref->symref ? ref->symref : "";
 		else if (starts_with(name, "upstream")) {
 			/* only local branches may have an upstream */
-			if (!starts_with(ref->refname, "refs/heads/"))
+			if (!starts_with(ref->name, "refs/heads/"))
 				continue;
-			branch = branch_get(ref->refname + 11);
+			branch = branch_get(ref->name + 11);
 
 			if (!branch || !branch->merge || !branch->merge[0] ||
 			    !branch->merge[0]->dst)
@@ -677,9 +677,9 @@ static void populate_value(struct refinfo *ref)
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
-			if (ref->flag & REF_ISSYMREF)
+			if (ref->flags & REF_ISSYMREF)
 				cp = copy_advance(cp, ",symref");
-			if (ref->flag & REF_ISPACKED)
+			if (ref->flags & REF_ISPACKED)
 				cp = copy_advance(cp, ",packed");
 			if (cp == buf)
 				v->s = "";
@@ -688,7 +688,7 @@ static void populate_value(struct refinfo *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname, v)) {
+		} else if (!deref && grab_objectname(name, ref->sha1, v)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
@@ -696,7 +696,7 @@ static void populate_value(struct refinfo *ref)
 
 			head = resolve_ref_unsafe("HEAD", RESOLVE_REF_READING,
 						  sha1, NULL);
-			if (!strcmp(ref->refname, head))
+			if (!strcmp(ref->name, head))
 				v->s = "*";
 			else
 				v->s = " ";
@@ -774,13 +774,13 @@ static void populate_value(struct refinfo *ref)
 	return;
 
  need_obj:
-	buf = get_obj(ref->objectname, &obj, &size, &eaten);
+	buf = get_obj(ref->sha1, &obj, &size, &eaten);
 	if (!buf)
 		die("missing object %s for %s",
-		    sha1_to_hex(ref->objectname), ref->refname);
+		    sha1_to_hex(ref->sha1), ref->name);
 	if (!obj)
 		die("parse_object_buffer failed on %s for %s",
-		    sha1_to_hex(ref->objectname), ref->refname);
+		    sha1_to_hex(ref->sha1), ref->name);
 
 	grab_values(ref->value, 0, obj, buf, size);
 	if (!eaten)
@@ -808,10 +808,10 @@ static void populate_value(struct refinfo *ref)
 	buf = get_obj(tagged, &obj, &size, &eaten);
 	if (!buf)
 		die("missing object %s for %s",
-		    sha1_to_hex(tagged), ref->refname);
+		    sha1_to_hex(tagged), ref->name);
 	if (!obj)
 		die("parse_object_buffer failed on %s for %s",
-		    sha1_to_hex(tagged), ref->refname);
+		    sha1_to_hex(tagged), ref->name);
 	grab_values(ref->value, 1, obj, buf, size);
 	if (!eaten)
 		free(buf);
@@ -877,9 +877,9 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	 * by maxcount logic.
 	 */
 	ref = xcalloc(1, sizeof(*ref));
-	ref->refname = xstrdup(refname);
-	hashcpy(ref->objectname, sha1);
-	ref->flag = flag;
+	ref->name = xstrdup(refname);
+	hashcpy(ref->sha1, sha1);
+	ref->flags = flag;
 
 	cnt = cb->grab_cnt;
 	REALLOC_ARRAY(cb->grab_array, cnt + 1);
-- 
2.4.1
