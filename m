From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 03/11] for-each-ref: rename 'refinfo' to 'ref_array_item'
Date: Sun, 14 Jun 2015 01:07:21 +0530
Message-ID: <1434224249-21476-3-git-send-email-karthik.188@gmail.com>
References: <CAOLa=ZR6hRFZjXmSPh+rUS6EROdjP8d3tgP0+Yh5VDBdngCOkA@mail.gmail.com>
 <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Cc: christian.couder@gmail.com, Matthieu.Moy@grenoble-inp.fr,
	Karthik Nayak <karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 13 21:38:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3rGG-0002Ek-UN
	for gcvg-git-2@plane.gmane.org; Sat, 13 Jun 2015 21:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751135AbbFMTic (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Jun 2015 15:38:32 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:34363 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751377AbbFMTia (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jun 2015 15:38:30 -0400
Received: by pdbki1 with SMTP id ki1so44655162pdb.1
        for <git@vger.kernel.org>; Sat, 13 Jun 2015 12:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LRg75zYWjZTwClp218LF215PcuZcTzLpSmeXFzARkE0=;
        b=hetpkLu2rBAPDmgCzMLB3DsctZuhg/dCWpDz4fhiDMkVQ+Mu0Xa/2d70s2nj9OAm9L
         muRXd8Xu+K+KJPnffUecWLcDQkAp5YjOvAeqND24dG2rbWMxKCEvrMxYaiGVIi2nisAz
         OVTvxwzwmOpOxvslpe8OGVE+/esl+TZyxzAyhnuvPyR+hNRAbyZCsaa8wmhQTDz9FKJd
         FA8ZkPxSxGLDgGySSNn7SOjkTSXFD9Bozy7S4J6X8mcAKzvtXqc7eD9x+2oJAwG2htcQ
         mReVHWl/X7aiNh0ep9vjw66/m/mgRnBG5TmFgCXNpMrNO4fs4CQrRhuFWjT29SjXIMPT
         jVSw==
X-Received: by 10.66.55.41 with SMTP id o9mr32800390pap.148.1434224309146;
        Sat, 13 Jun 2015 12:38:29 -0700 (PDT)
Received: from ashley.localdomain ([106.51.130.23])
        by mx.google.com with ESMTPSA id nn6sm7388954pdb.79.2015.06.13.12.38.26
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 13 Jun 2015 12:38:28 -0700 (PDT)
X-Mailer: git-send-email 2.4.3.435.g2403634.dirty
In-Reply-To: <1434224249-21476-1-git-send-email-karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271566>

Rename 'refinfo' to 'ref_array_item' as a preparatory step for
introduction of new structures in the forthcoming patch.

Re-order the fields in 'ref_array_item' so that refname can be
eventually converted to a FLEX_ARRAY.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 builtin/for-each-ref.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index f0d7d44..d1b7e81 100644
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
@@ -86,7 +86,7 @@ static struct {
  * a "*" to denote deref_tag().
  *
  * We parse given format string and sort specifiers, and make a list
- * of properties that we need to extract out of objects.  refinfo
+ * of properties that we need to extract out of objects.  ref_array_item
  * structure will hold an array of values extracted that can be
  * indexed with the "atom number", which is an index into this
  * array.
@@ -623,7 +623,7 @@ static inline char *copy_advance(char *dst, const char *src)
 /*
  * Parse the object referred by ref, and grab needed value.
  */
-static void populate_value(struct refinfo *ref)
+static void populate_value(struct ref_array_item *ref)
 {
 	void *buf;
 	struct object *obj;
@@ -835,7 +835,7 @@ static void populate_value(struct refinfo *ref)
  * Given a ref, return the value for the atom.  This lazily gets value
  * out of the object by calling populate value.
  */
-static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
+static void get_value(struct ref_array_item *ref, int atom, struct atom_value **v)
 {
 	if (!ref->value) {
 		populate_value(ref);
@@ -845,7 +845,7 @@ static void get_value(struct refinfo *ref, int atom, struct atom_value **v)
 }
 
 struct grab_ref_cbdata {
-	struct refinfo **grab_array;
+	struct ref_array_item **grab_array;
 	const char **grab_pattern;
 	int grab_cnt;
 };
@@ -875,12 +875,12 @@ static int match_name_as_path(const char **pattern, const char *refname)
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
@@ -896,7 +896,7 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 			   int flag, void *cb_data)
 {
 	struct grab_ref_cbdata *cb = cb_data;
-	struct refinfo *ref;
+	struct ref_array_item *ref;
 
 	if (flag & REF_BAD_NAME) {
 		  warning("ignoring ref with broken name %s", refname);
@@ -911,14 +911,14 @@ static int grab_single_ref(const char *refname, const struct object_id *oid,
 	 * to do its job and the resulting list may yet to be pruned
 	 * by maxcount logic.
 	 */
-	ref = new_refinfo(refname, oid->hash, flag);
+	ref = new_ref_array_item(refname, oid->hash, flag);
 
 	REALLOC_ARRAY(cb->grab_array, cb->grab_cnt + 1);
 	cb->grab_array[cb->grab_cnt++] = ref;
 	return 0;
 }
 
-static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b)
+static int cmp_ref_sort(struct ref_sort *s, struct ref_array_item *a, struct ref_array_item *b)
 {
 	struct atom_value *va, *vb;
 	int cmp;
@@ -945,8 +945,8 @@ static int cmp_ref_sort(struct ref_sort *s, struct refinfo *a, struct refinfo *b
 static struct ref_sort *ref_sort;
 static int compare_refs(const void *a_, const void *b_)
 {
-	struct refinfo *a = *((struct refinfo **)a_);
-	struct refinfo *b = *((struct refinfo **)b_);
+	struct ref_array_item *a = *((struct ref_array_item **)a_);
+	struct ref_array_item *b = *((struct ref_array_item **)b_);
 	struct ref_sort *s;
 
 	for (s = ref_sort; s; s = s->next) {
@@ -957,10 +957,10 @@ static int compare_refs(const void *a_, const void *b_)
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
@@ -1027,7 +1027,7 @@ static void emit(const char *cp, const char *ep)
 	}
 }
 
-static void show_ref(struct refinfo *info, const char *format, int quote_style)
+static void show_ref(struct ref_array_item *info, const char *format, int quote_style)
 {
 	const char *cp, *sp, *ep;
 
@@ -1100,7 +1100,7 @@ int cmd_for_each_ref(int argc, const char **argv, const char *prefix)
 	const char *format = "%(objectname) %(objecttype)\t%(refname)";
 	struct ref_sort *sort = NULL, **sort_tail = &sort;
 	int maxcount = 0, quote_style = 0;
-	struct refinfo **refs;
+	struct ref_array_item **refs;
 	struct grab_ref_cbdata cbdata;
 
 	struct option opts[] = {
-- 
2.4.3.435.g2403634.dirty
