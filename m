From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v3 11/16] ref-filter: introduce refname_atom_parser()
Date: Wed, 30 Mar 2016 15:09:55 +0530
Message-ID: <1459330800-12525-12-git-send-email-Karthik.188@gmail.com>
References: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 30 11:40:49 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alCcK-0001nn-Ie
	for gcvg-git-2@plane.gmane.org; Wed, 30 Mar 2016 11:40:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752418AbcC3Jkn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Mar 2016 05:40:43 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:33856 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752264AbcC3Jkg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Mar 2016 05:40:36 -0400
Received: by mail-pa0-f54.google.com with SMTP id fe3so36357447pab.1
        for <git@vger.kernel.org>; Wed, 30 Mar 2016 02:40:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=AIAM2EtSgiZWyjdIm6gVGQQgTfGwfJFqcNRWCBgaa3c=;
        b=f4Q+c2s0zUcO4p7i9VWpFNmn0vRYO6r70CoPCwhhENx53/CPgNGrF9M3wWrzsD3MX1
         Co2ZhjzX2OCHn5Kz+ns296eE4vSxfT53iGjbuTjMZVUEuHDgS+VfilaW7VBhRN7zzVN5
         dRpaA3VuV16niLspExKiC9hZOpv022b3dFP53OhgTbp3Xeef+Tw8PGGyF7t1VR/EnM6v
         oVJktzi6r1NgvxrQNa7GT4QyWhQD9lvl4+Uxp2dYM89dUudWYjXV+Htj1bXQWa2tE0uj
         Gv2AoqayOqf4sl4xs2QARDR6ZXT3LXQSMm+LfUe+deEp/DmHHlskNJc2/DppPYRNIFTf
         ffAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=AIAM2EtSgiZWyjdIm6gVGQQgTfGwfJFqcNRWCBgaa3c=;
        b=bVqn1ruM07iOkXajG2JJ3c3tJaGqRXcDCAWfoIXMT5VH3BmUN1WcrMN+k6XVEqEJwL
         z1e+F0gdlnurBRVUmUcRyq0DDFcFjzMxfxV4krfnHBqV5Hs9H8YxvskHJPirXEgCODPW
         oT2x5B7JWIlq8egLMalMoIC0UrJzfTnK+NO66qZPeGSEU3B8FdfsHboHmuHDnCEOY5Kt
         PUdqmYuQUja/yKj0Nd/0gup9YScHhsq+rmBFypcZwbkjwAllrO7h5IoETRhnH4+WDJPh
         ImVp3Jz4XQRa3T1XUVGnYJQhG3NpbPb198LvtM1f5SoDISsPk16PPL7KwW3YW7kXWqd/
         mZdg==
X-Gm-Message-State: AD7BkJJLybbQ1gPJv8YZb3NolTe80cNu3T8Kct4Gevk4DniXOukxsmNoU96LWGP8I/lbYA==
X-Received: by 10.66.246.165 with SMTP id xx5mr11421731pac.87.1459330836074;
        Wed, 30 Mar 2016 02:40:36 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.45])
        by smtp.gmail.com with ESMTPSA id r65sm4402606pfa.27.2016.03.30.02.40.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 30 Mar 2016 02:40:35 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1459330800-12525-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290289>

Introduce refname_atom_parser() which will parse the '%(refname)' atom
and store information into the 'used_atom' structure based on the
modifiers used along with the atom.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 70 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7b35e4f..dc1e404 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -63,6 +63,10 @@ static struct used_atom {
 			unsigned int length;
 		} objectname;
 		enum { S_FULL, S_SHORT } symref;
+		struct {
+			enum { R_NORMAL, R_SHORT, R_STRIP } option;
+			unsigned int strip;
+		} refname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -228,12 +232,27 @@ static void symref_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(symref) argument: %s"), arg);
 }
 
+static void refname_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		atom->u.refname.option = R_NORMAL;
+	else if (!strcmp(arg, "short"))
+		atom->u.refname.option = R_SHORT;
+	else if (skip_prefix(arg, "strip=", &arg)) {
+		atom->u.contents.option = R_STRIP;
+		if (strtoul_ui(arg, 10, &atom->u.refname.strip) ||
+			atom->u.refname.strip <= 0)
+			die(_("positive value expected refname:strip=%s"), arg);
+	} else
+		die(_("unrecognized %%(refname) argument: %s"), arg);
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
 	void (*parser)(struct used_atom *atom, const char *arg);
 } valid_atom[] = {
-	{ "refname" },
+	{ "refname", FIELD_STR, refname_atom_parser },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
 	{ "objectname", FIELD_STR, objectname_atom_parser },
@@ -1047,21 +1066,16 @@ static inline char *copy_advance(char *dst, const char *src)
 	return dst;
 }
 
-static const char *strip_ref_components(const char *refname, const char *nr_arg)
+static const char *strip_ref_components(const char *refname, unsigned int len)
 {
-	char *end;
-	long nr = strtol(nr_arg, &end, 10);
-	long remaining = nr;
+	long remaining = len;
 	const char *start = refname;
 
-	if (nr < 1 || *end != '\0')
-		die(_(":strip= requires a positive integer argument"));
-
 	while (remaining) {
 		switch (*start++) {
 		case '\0':
-			die(_("ref '%s' does not have %ld components to :strip"),
-			    refname, nr);
+			die("ref '%s' does not have %ud components to :strip",
+			    refname, len);
 		case '/':
 			remaining--;
 			break;
@@ -1153,6 +1167,18 @@ static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref
 		return ref->symref;
 }
 
+static const char *get_refname(struct used_atom *atom, struct ref_array_item *ref)
+{
+	if (ref->kind & FILTER_REFS_DETACHED_HEAD)
+		return get_head_description();
+	if (atom->u.refname.option == R_SHORT)
+		return shorten_unambiguous_ref(ref->refname, warn_ambiguous_refs);
+	else if (atom->u.refname.option == R_STRIP)
+		return strip_ref_components(ref->refname, atom->u.refname.strip);
+	else
+		return ref->refname;
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -1181,7 +1207,6 @@ static void populate_value(struct ref_array_item *ref)
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
 		const char *refname;
-		const char *formatp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -1192,11 +1217,9 @@ static void populate_value(struct ref_array_item *ref)
 			name++;
 		}
 
-		if (starts_with(name, "refname")) {
-			refname = ref->refname;
-			if (ref->kind & FILTER_REFS_DETACHED_HEAD)
-				refname = get_head_description();
-		} else if (starts_with(name, "symref"))
+		if (starts_with(name, "refname"))
+			refname = get_refname(atom, ref);
+		else if (starts_with(name, "symref"))
 			refname = get_symref(atom, ref);
 		else if (starts_with(name, "upstream")) {
 			const char *branch_name;
@@ -1273,21 +1296,6 @@ static void populate_value(struct ref_array_item *ref)
 		} else
 			continue;
 
-		formatp = strchr(name, ':');
-		if (formatp) {
-			const char *arg;
-
-			formatp++;
-			if (!strcmp(formatp, "short"))
-				refname = shorten_unambiguous_ref(refname,
-						      warn_ambiguous_refs);
-			else if (skip_prefix(formatp, "strip=", &arg))
-				refname = strip_ref_components(refname, arg);
-			else
-				die(_("unknown %.*s format %s"),
-				    (int)(formatp - name), name, formatp);
-		}
-
 		if (!deref)
 			v->s = refname;
 		else
-- 
2.7.4
