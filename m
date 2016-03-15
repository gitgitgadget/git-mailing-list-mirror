From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v2 11/16] ref-filter: introduce refname_atom_parser()
Date: Tue, 15 Mar 2016 22:17:11 +0530
Message-ID: <1458060436-1215-12-git-send-email-Karthik.188@gmail.com>
References: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, jacob.keller@gmail.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 15 17:48:05 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1afs8a-000108-Mn
	for gcvg-git-2@plane.gmane.org; Tue, 15 Mar 2016 17:48:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965287AbcCOQrx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2016 12:47:53 -0400
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33579 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965097AbcCOQru (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2016 12:47:50 -0400
Received: by mail-pf0-f169.google.com with SMTP id 124so35898558pfg.0
        for <git@vger.kernel.org>; Tue, 15 Mar 2016 09:47:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VsgUxtpVfjdoqI1GoIHdg/QJuJdr65ebk7wUV3knUDU=;
        b=Owkr74cUh3DzKq048LJizlN3NCTheZuqH8q58gHwuqKImN1vQ1+/VpC59soYUEC7Sa
         /fWl9eBlXF8ut/gaC5F59tOYebhERc4Of9Qa78SDw6sbMeHDbJkdVZTvFK/R+mkMl56b
         XKlpKNVpzxbECceeL0v0+9aMEzWY7mF7mgW7Hh9k9sSge+4boefskfUAFsQ6onTRgWsF
         fi16PuX5w3ZD3dvR/tRDc/fo3XKkQU2jW8Oefo9CX+FpfTuczTcoKTAHpiuv9hICJPEM
         DfffEiwhR0n0Ui8JzBTq2uQ3WRKKlTnW4Hn+ZlSAKx+/OmPske9alwScInyB4/buTWfG
         +W8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=VsgUxtpVfjdoqI1GoIHdg/QJuJdr65ebk7wUV3knUDU=;
        b=T9b7CDAmKPoHTYU/a3kXZ3auSt4KsDCpnvM9F00Mh9ugOZpeMmoEvaotOTQFTveRVk
         3CghMCodwcBFaPN9zuz5OiOxmtMDSyBxIUMkmPZtfrRTpewQY8IaNM6Iwo5H+YTcJoS5
         QaXKS/C5EHHYJ3PbrEXu+dUGCU8mQ6NDOI4wvt5jXm1w0k1bDe6U4eTID9J9DooGX7R7
         AbPppFwPy4oL/asmuTPwQT6RJrAZVvXjGizFiApVWMtlZvVvmSjMAE16/lS0ORaYFk7y
         xLrH9AYcwbQs0qS75FMVo6wdrLd19EocFVDzQDpObUws4KSsaQ8AbP8J8cdj6K4Cnm50
         r65Q==
X-Gm-Message-State: AD7BkJKq+Gw5nzvecuxGn4LqQZs8RBuA+IcK8PZkUdgryNnF42BB1PF0rvEQMYqvZ2zOBw==
X-Received: by 10.98.75.10 with SMTP id y10mr40054501pfa.32.1458060469191;
        Tue, 15 Mar 2016 09:47:49 -0700 (PDT)
Received: from localhost.localdomain ([106.51.243.87])
        by smtp.gmail.com with ESMTPSA id i1sm40874361pfj.17.2016.03.15.09.47.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 15 Mar 2016 09:47:48 -0700 (PDT)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.3
In-Reply-To: <1458060436-1215-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288872>

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
2.7.3
