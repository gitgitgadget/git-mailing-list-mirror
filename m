From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 11/16] ref-filter: introduce refname_atom_parser()
Date: Sun, 10 Apr 2016 00:15:10 +0530
Message-ID: <1460227515-28437-12-git-send-email-Karthik.188@gmail.com>
References: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Cc: jacob.keller@gmail.com, gitster@pobox.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 09 20:45:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aoxtN-0003o8-CS
	for gcvg-git-2@plane.gmane.org; Sat, 09 Apr 2016 20:45:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759152AbcDISpu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 9 Apr 2016 14:45:50 -0400
Received: from mail-ig0-f193.google.com ([209.85.213.193]:35934 "EHLO
	mail-ig0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759100AbcDISps (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 9 Apr 2016 14:45:48 -0400
Received: by mail-ig0-f193.google.com with SMTP id kb1so6499455igb.3
        for <git@vger.kernel.org>; Sat, 09 Apr 2016 11:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=48iHU1oObfPOF/hK/Asg3/z6N7Qchj5jfNdaKha51TU=;
        b=E9ULk0X9jFA41Ctkni9BSLmEtFWJ4JxAwlXZlaobY0tH//qnLerDDirmrMsV5OeCTF
         lQOgdSAjNEUyvHjSPEFkcc3iNYR2GAsUsxAka+yfQwaBxbFGKJzStaoi+rxbw4RS1fOA
         ip7i4/gsPE7RFQdtqYpcFsXA+hKTX0hveAttDSbj+hFqMDSyT1+iQ25LtEp5P0H9i1nt
         81mQ7zOhKzrMYJQogBQmUlaY9DELPBt8RGG+Qrng3uZ2gQatCHUWHNKfnKtLonfoMyuT
         AhkcoPQgUnO4RWOJEAyWJMYiYxCczpRZol3NYklxLsgvs5J6OsuDcV3pvZhVhUO9qKAp
         znVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=48iHU1oObfPOF/hK/Asg3/z6N7Qchj5jfNdaKha51TU=;
        b=KrycNPTwSlwxCnuJ3A3R4Oc5xsPykt+vvmssqeubt0VVeuWTqR6x/IF8BRFvraIk3J
         MuZlx7eVezvN6sy+n0wRTmnuGWeYizPwwcx3GQaI5uibGXiBJEiaaltbHv23LgVuKhWV
         hUKjG+z/QRDbT3npHOWS2Q2jiOmYCnC/b+wGScLd5b3bjQRKYBXH/yKQSA2JosQsS+9g
         VXKmPR//4DQfmTQ5u8fV42KYzL7HgHGnLbMcvmre1IuLnM5Eq0m94/aRw9RlPOxspG2L
         Bxge36RpDdckRs81IAzITwlUU0g6dDtsS807wBB3UKTBej59XndAg3IKCxIUNOn5GRhI
         YDrg==
X-Gm-Message-State: AD7BkJIaeCPYD1tAXXoRTv0ZCT1EdjywRqTsy/jNUiV4c5d0Zq7A+hCCuTUNVA9EKTCNLw==
X-Received: by 10.50.8.102 with SMTP id q6mr10420180iga.37.1460227547798;
        Sat, 09 Apr 2016 11:45:47 -0700 (PDT)
Received: from localhost.localdomain ([106.51.241.12])
        by smtp.gmail.com with ESMTPSA id be7sm7132351igb.1.2016.04.09.11.45.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sat, 09 Apr 2016 11:45:47 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.8.0
In-Reply-To: <1460227515-28437-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/291116>

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
2.8.0
