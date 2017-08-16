Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AC5BD1F667
	for <e@80x24.org>; Wed, 16 Aug 2017 20:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752603AbdHPUQx (ORCPT <rfc822;e@80x24.org>);
        Wed, 16 Aug 2017 16:16:53 -0400
Received: from vie01a-dmta-pe08-1.mx.upcmail.net ([84.116.36.20]:62954 "EHLO
        vie01a-dmta-pe05-1.mx.upcmail.net" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752569AbdHPUQv (ORCPT
        <rfc822;git@vger.kernel.org>); Wed, 16 Aug 2017 16:16:51 -0400
Received: from [172.31.216.44] (helo=vie01a-pemc-psmtp-pe02)
        by vie01a-dmta-pe08.mx.upcmail.net with esmtp (Exim 4.88)
        (envelope-from <martin.koegler@chello.at>)
        id 1di4kD-0005yU-3X
        for git@vger.kernel.org; Wed, 16 Aug 2017 22:16:49 +0200
Received: from master.zuhause ([80.108.242.240])
        by vie01a-pemc-psmtp-pe02 with SMTP @ mailcloud.upcmail.net
        id xwGn1v0095BuuEg01wGoN5; Wed, 16 Aug 2017 22:16:48 +0200
X-SourceIP: 80.108.242.240
Received: by master.zuhause (Postfix, from userid 1006)
        id EFF8145D4622; Wed, 16 Aug 2017 22:16:46 +0200 (CEST)
From:   Martin Koegler <martin.koegler@chello.at>
To:     git@vger.kernel.org, gitster@pobox.com, Johannes.Schindelin@gmx.de
Cc:     Martin Koegler <martin.koegler@chello.at>
Subject: [Patch size_t V3 17/19] Convert ref-filter to size_t
Date:   Wed, 16 Aug 2017 22:16:29 +0200
Message-Id: <1502914591-26215-18-git-send-email-martin@mail.zuhause>
X-Mailer: git-send-email 2.1.4
In-Reply-To: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
References: <1502914591-26215-1-git-send-email-martin@mail.zuhause>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Martin Koegler <martin.koegler@chello.at>

Signed-off-by: Martin Koegler <martin.koegler@chello.at>
---
 ref-filter.c | 34 +++++++++++++++++-----------------
 1 file changed, 17 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 5c903a5..30f249c 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -724,7 +724,7 @@ static int grab_objectname(const char *name, const unsigned char *sha1,
 }
 
 /* See grab_values */
-static void grab_common_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_common_values(struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	int i;
 
@@ -739,7 +739,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = typename(obj->type);
 		else if (!strcmp(name, "objectsize")) {
 			v->value = sz;
-			v->s = xstrfmt("%lu", sz);
+			v->s = xstrfmt("%" PRIuMAX, (uintmax_t)sz);
 		}
 		else if (deref)
 			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
@@ -747,7 +747,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 }
 
 /* See grab_values */
-static void grab_tag_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_tag_values(struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	int i;
 	struct tag *tag = (struct tag *) obj;
@@ -769,7 +769,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 }
 
 /* See grab_values */
-static void grab_commit_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_commit_values(struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	int i;
 	struct commit *commit = (struct commit *) obj;
@@ -786,7 +786,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 		}
 		else if (!strcmp(name, "numparent")) {
 			v->value = commit_list_count(commit->parents);
-			v->s = xstrfmt("%lu", (unsigned long)v->value);
+			v->s = xstrfmt("%" PRIuMAX, (uintmax_t)v->value);
 		}
 		else if (!strcmp(name, "parent")) {
 			struct commit_list *parents;
@@ -802,7 +802,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 	}
 }
 
-static const char *find_wholine(const char *who, int wholen, const char *buf, unsigned long sz)
+static const char *find_wholine(const char *who, int wholen, const char *buf, size_t sz)
 {
 	const char *eol;
 	while (*buf) {
@@ -848,7 +848,7 @@ static const char *copy_email(const char *buf)
 	return xmemdupz(email, eoemail + 1 - email);
 }
 
-static char *copy_subject(const char *buf, unsigned long len)
+static char *copy_subject(const char *buf, size_t len)
 {
 	char *r = xmemdupz(buf, len);
 	int i;
@@ -898,7 +898,7 @@ static void grab_date(const char *buf, struct atom_value *v, const char *atomnam
 }
 
 /* See grab_values */
-static void grab_person(const char *who, struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_person(const char *who, struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	int i;
 	int wholen = strlen(who);
@@ -957,11 +957,11 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	}
 }
 
-static void find_subpos(const char *buf, unsigned long sz,
-			const char **sub, unsigned long *sublen,
-			const char **body, unsigned long *bodylen,
-			unsigned long *nonsiglen,
-			const char **sig, unsigned long *siglen)
+static void find_subpos(const char *buf, size_t sz,
+			const char **sub, size_t *sublen,
+			const char **body, size_t *bodylen,
+			size_t *nonsiglen,
+			const char **sig, size_t *siglen)
 {
 	const char *eol;
 	/* skip past header until we hit empty line */
@@ -1005,7 +1005,7 @@ static void find_subpos(const char *buf, unsigned long sz,
  * If 'lines' is greater than 0, append that many lines from the given
  * 'buf' of length 'size' to the given strbuf.
  */
-static void append_lines(struct strbuf *out, const char *buf, unsigned long size, int lines)
+static void append_lines(struct strbuf *out, const char *buf, size_t size, int lines)
 {
 	int i;
 	const char *sp, *eol;
@@ -1026,11 +1026,11 @@ static void append_lines(struct strbuf *out, const char *buf, unsigned long size
 }
 
 /* See grab_values */
-static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_sub_body_contents(struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	int i;
 	const char *subpos = NULL, *bodypos = NULL, *sigpos = NULL;
-	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
+	size_t sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
 		struct used_atom *atom = &used_atom[i];
@@ -1100,7 +1100,7 @@ static void fill_missing_values(struct atom_value *val)
  * pointed at by the ref itself; otherwise it is the object the
  * ref (which is a tag) refers to.
  */
-static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, unsigned long sz)
+static void grab_values(struct atom_value *val, int deref, struct object *obj, void *buf, size_t sz)
 {
 	grab_common_values(val, deref, obj, buf, sz);
 	switch (obj->type) {
-- 
2.1.4

