From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH 10/15] ref-filter: introduce refname_atom_parser()
Date: Sun,  6 Mar 2016 17:34:57 +0530
Message-ID: <1457265902-7949-11-git-send-email-Karthik.188@gmail.com>
References: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 06 13:05:45 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXRQ-00026H-Bx
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 13:05:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbcCFMFi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 07:05:38 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33432 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751470AbcCFMFa (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 07:05:30 -0500
Received: by mail-pf0-f169.google.com with SMTP id 124so63520113pfg.0
        for <git@vger.kernel.org>; Sun, 06 Mar 2016 04:05:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hUx4KXiJG+UzOI5ewTZ/ep4i0KsGAzbywEkzIQOB2aw=;
        b=tuTphJFTIfPY9I/sQbF6Z4B+T5E6/IM1a/2g0s0IZeu+hpYWjQ7G2Dl7mJ+ZYoJ1o3
         eVb9hddaB8eQvr8IwsgZKwN7u4204648nMVm4ZK/17rk+Q5Wrl4zn1keok1gtZ51w/Gm
         X/37x/9sbXu94eGNFRn2BMf2e31UAkXKr2NjoadeU4r8KhIqCOBss7HgytTMaJegovUv
         LAhcgQ9jTFmuNRaaqje4rHuIACgcGhTxCVUQGATJKFY0mwz0fh+TVCrbZrX4MXehPoIR
         oSJmhOFMZVxhEcEEdcqfVAT1/8J0oLz+FJSbN03/bAqn5RsZ+Na/P52qGqP/R/eL4+9A
         aKSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hUx4KXiJG+UzOI5ewTZ/ep4i0KsGAzbywEkzIQOB2aw=;
        b=RiyxsL5tnckp4QaCcdjQhn1NK73p23EB0uiABHdjWhFa2fn1+8s9PGVud7NOJhsDQo
         Jau2gtgIfcqdr/xKmdohi3IZ1+V29UcZ0yUcGcdTPFmm0wvnrtVbhwJR8tZm5s6vBVwv
         2zhK58niJqwmX6eehXFl9UNBfp9+BkFPP8Ok/T3uc00BZS3asI3NHUaaexD/8Fh08brM
         2MUVIZhIQD6E5XEa7/ppOeJXSP0cjiA6YauHZ0aZOPve5n1c4JjXVbBw40vAxpwvpAJW
         DPPWNxll/zEmVqNp5qBDcSMcCfNrdLqs175C/y4ki4rw3VBQPYinDc+X1dofg+kacFsO
         SlrA==
X-Gm-Message-State: AD7BkJLLZQ7NjQDO283DYg11FBLlLcPO59m+rbgKEOI6vRTwmmkEQmwwsVNFTd8/KYdrlA==
X-Received: by 10.98.8.200 with SMTP id 69mr26157475pfi.39.1457265929719;
        Sun, 06 Mar 2016 04:05:29 -0800 (PST)
Received: from localhost.localdomain ([106.51.240.143])
        by smtp.gmail.com with ESMTPSA id n66sm17536850pfj.39.2016.03.06.04.05.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 06 Mar 2016 04:05:28 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.2
In-Reply-To: <1457265902-7949-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288351>

Introduce refname_atom_parser() which will parse the '%(refname)' atom
and store information into the 'used_atom' structure based on the
modifiers used along with the atom.

Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 70 +++++++++++++++++++++++++++++++++---------------------------
 1 file changed, 39 insertions(+), 31 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 59eb280..2393800 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -59,6 +59,10 @@ static struct used_atom {
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
@@ -212,12 +216,27 @@ static void symref_atom_parser(struct used_atom *atom, const char *arg)
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
@@ -1038,21 +1057,16 @@ static inline char *copy_advance(char *dst, const char *src)
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
@@ -1144,6 +1158,18 @@ static const char *get_symref(struct used_atom *atom, struct ref_array_item *ref
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
@@ -1172,7 +1198,6 @@ static void populate_value(struct ref_array_item *ref)
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
 		const char *refname;
-		const char *formatp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -1182,11 +1207,9 @@ static void populate_value(struct ref_array_item *ref)
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
@@ -1264,21 +1287,6 @@ static void populate_value(struct ref_array_item *ref)
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
2.7.2
