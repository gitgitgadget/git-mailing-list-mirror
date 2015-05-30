From: Karthik Nayak <karthik.188@gmail.com>
Subject: [WIP/PATCH v4 3/8] for-each-ref: rename 'refinfo' to 'ref_array_item'
Date: Sat, 30 May 2015 23:23:26 +0530
Message-ID: <1433008411-8550-3-git-send-email-karthik.188@gmail.com>
References: <5569EF77.4010300@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 30 19:54:11 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YykxW-0005uc-1m
	for gcvg-git-2@plane.gmane.org; Sat, 30 May 2015 19:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757668AbbE3RyF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 May 2015 13:54:05 -0400
Received: from mail-pa0-f51.google.com ([209.85.220.51]:34767 "EHLO
	mail-pa0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757279AbbE3RyC (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 May 2015 13:54:02 -0400
Received: by pabru16 with SMTP id ru16so81249707pab.1
        for <git@vger.kernel.org>; Sat, 30 May 2015 10:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Rzz8FBlLK/we/wMwJdXf6KQn6PikXXvrlLE3CsDhQek=;
        b=HGVtp6AvdVTjVPjc3mwhsprOoBlxtMAlGDy/AlhxXUg8KLuB16oa0MhjSJT8X3Jb8y
         w2WqYiVkBSyCTwboUlF85JlQmQfDgxLi7VLJT+MLGihUjSQ0VzUDqnsNyaGceZU1wNbP
         TVZmsNKPRR8GMt4mGLwdxQigXJ/1QFvl7oyGA7gfxhHJir5Qabdekdg8RLqWFd8EOlJV
         l0wTlS/D/mZIVwoH+D21i1to5HqI/7BZ9DfShR0digwrOJV6G9WWJ6P714L2oE/V1EnB
         3e4T3/U9tmk0ezFLon/pDfCWIyow08G3VLiDiqWU839NYm6iRi3QRB+CK3LJxRlUgHq7
         wcXA==
X-Received: by 10.70.0.143 with SMTP id 15mr25889764pde.13.1433008441697;
        Sat, 30 May 2015 10:54:01 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id ob15sm9317839pdb.40.2015.05.30.10.53.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 30 May 2015 10:54:01 -0700 (PDT)
X-Mailer: git-send-email 2.4.2
In-Reply-To: <5569EF77.4010300@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270296>

Rename 'refinfo' to 'ref_array_item' as a preparatory step for introduction of new structures in the forthcoming patch.

Re-order the fields in 'ref_array_item' so that refname can be
eventually converted to a FLEX_ARRAY.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 919d45e..e634fd2 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -31,12 +31,12 @@ struct ref_sort {
 	unsigned reverse : 1;
 };
 
-struct refinfo {
-	char *refname;
+struct ref_array_item {
 	unsigned char objectname[20];
 	int flag;
 	const char *symref;
 	struct atom_value *value;
+	char *refname;
 };
 
 static struct {
@@ -85,7 +85,7 @@ static struct {
  * a "*" to denote deref_tag().
  *
  * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  refinfo
+ * of properties that we need to extract out of objects.  ref_array_item
  * structure will hold an array of values extracted that can be
  * indexed with the "atom number", which is an index into this
  * array.
@@ -622,7 +622,7 @@ static inline char *copy_advance(char *dst, const char *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct refinfo *ref)
+static void populate_value(struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
@@ -821,7 +821,7 @@ static void populate_value(struct refinfo *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
+static void get_value(struct ref_array_item *ref, int atom, struct atom_value **v)
 {
 	if (!ref->value) {
 		populate_value(ref);
@@ -831,7 +831,7 @@ static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
 }
 
 struct grab_ref_cbdata {
-	struct refinfo **grab_array;
+	struct ref_array_item **grab_array;
 	const char **grab_pattern;
 	int grab_cnt;
 };
@@ -860,12 +860,12 @@ static int match_name_as_path(const char **pattern, const char *refname)
 	return 0;
 }
 
-/* Allocate space for a new refinfo and copy the objectname and flag to it */
-static struct refinfo *new_refinfo(const char *refname,
-				   const unsigned char *objectname,
-				   int flag)
+/* Allocate space for a new ref_array_item and copy the objectname and flag to it */
+static struct ref_array_item *new_ref_array_item(const char *refname,
+						 const unsigned char *objectname,
+						 int flag)
 {
-	struct refinfo *ref = xcalloc(1, sizeof(struct refinfo));
+	struct ref_array_item *ref = xcalloc(1, sizeof(struct ref_array_item));
 	ref->refname = xstrdup(refname);
 	hashcpy(ref->objectname, objectname);
 	ref->flag = flag;
@@ -880,7 +880,7 @@ static struct refinfo *new_refinfo(const char *refname,
 static int grab_single_ref(const char *refname, const unsigned char *sha1, int flag, void *cb_data)
 {
 	struct grab_ref_cbdata *cb = cb_data;
-	struct refinfo *ref;
+	struct ref_array_item *ref;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -890,7 +890,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	if (*cb->grab_pattern && !match_name_as_path(cb->grab_pattern, refname))
 		return 0;
 
-	ref = new_refinfo(refname, sha1, flag);
+	ref = new_ref_array_item(refname, sha1, flag);
 
 	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
 	cb->grab_array[cb->grab_cnt++] = ref;
@@ -898,7 +898,7 @@ static int grab_single_ref(const char *refname, const unsigned char *sha1, int f
 	return 0;
 }
 
-static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
+static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
 	int cmp;
@@ -925,8 +925,8 @@ static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b
 static struct ref_sort *ref_sort;
 static int compare_refs(const void *a_, const void *b_)
 {
-	struct refinfo *a = *((struct refinfo **)a_);
-	struct refinfo *b = *((struct refinfo **)b_);
+	struct ref_array_item *a = *((struct ref_array_item **)a_);
+	struct ref_array_item *b = *((struct ref_array_item **)b_);
 	struct ref_sort *s;
 
 	for (s = ref_sort; s; s = s->next) {
@@ -937,10 +937,10 @@ static int compare_refs(const void *a_, const void *b_)
 	return 0;
 }
 
-static void sort_refs(struct ref_sort *sort, struct refinfo **refs, int num_refs)
+static void sort_refs(struct ref_sort *sort, struct ref_array_item **refs, int num_refs)
 {
 	ref_sort = sort;
-	qsort(refs, num_refs, sizeof(struct refinfo *), compare_refs);
+	qsort(refs, num_refs, sizeof(struct ref_array_item *), compare_refs);
 }
 
 static void print_value(struct atom_value *v, int quote_style)
@@ -1007,7 +1007,7 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-static void show_ref(struct refinfo *info, const char *format, int quote_style)
+static void show_ref(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
@@ -1080,7 +1080,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
-	struct refinfo **refs;
+	struct ref_array_item **refs;
 	struct grab_ref_cbdata cbdata;
 
 	struct option opts[] = {
-- 
2.4.2
