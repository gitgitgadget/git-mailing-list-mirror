From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 12/12] ref-filter: introduce objectname_atom_parser()
Date: Wed, 17 Feb 2016 00:30:15 +0530
Message-ID: <1455649215-23260-13-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:00:41 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkrO-0000Ga-Jb
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 20:00:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933217AbcBPTAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 14:00:25 -0500
Received: from mail-pa0-f45.google.com ([209.85.220.45]:36688 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933120AbcBPTAR (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 14:00:17 -0500
Received: by mail-pa0-f45.google.com with SMTP id yy13so107759165pab.3
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 11:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5aEH+KGgdfdqpQu1Ms5rXALcpHmpn4mraQ3w/n1Y3To=;
        b=p8WUs+igSqOmWSaYcjg4KzzlTM2x4NqTgJK0DupdFWBb0HC9ah9bJg5LpXORj82Ny1
         Gp0e97oStDhnmKvOyBwZgyhlk4psA6TBqZZpcdFK4PRItMS855+Cg7MDq8hGZZ6WGrUY
         39Hohp0+1VbO/jOxyB45Gc7TP7RRFWcgSOoS0oaOdVjHwL+fZCYv8eYuWCXKfjYMYEHt
         aqFhQd8KN2dg50QM4Fc4VM2UqCQOsfYbKQcpvZiQ8l+LKE/h5/I8dymQLaoCjyRVurMY
         DFzudVi7k+ixP9iJFkdLZXXj1eg1pvp13MQTEhYwWgz5yT9oB+2HOm6zBqiUNzkMy9CC
         6sMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5aEH+KGgdfdqpQu1Ms5rXALcpHmpn4mraQ3w/n1Y3To=;
        b=hfbd0GUNQYmb3bA52QV0ULudU6EP7ncipAQyHmiNW0mJTlPN3bm4UbiqTEdF1B4tbP
         t6ZhizutqH75QWZwMcO3vMe23e9aYo8oc3EPIXmeMGB2CCzYZTJLWofcHGNYK3PpnPOP
         V8X507bJDMW2A/t3k+tdeFx+iDBsFeuOuwg4PTX+TpSkjNarypOROzth8ycKLzZxJ5aS
         2t0Qp0ohkD4FWQDvMLvwdGzPoZFJnvIu9vQThH+GaKDEk+W1eSH0Xlok+g/r2RpWI9vG
         qSxUuEGwVYzKX7F+GUXDZ1M7wM0l0q0Mj9ntTM+lw65M1YD/pycv4Rvb4shyNrRpyRgN
         DsrQ==
X-Gm-Message-State: AG10YOS5V5BfBr12CSTM1aHGnt7jK0YkWcmOEING6XdMXkeAbo1r1+Ot07ak1Xu/oeH45Q==
X-Received: by 10.66.228.201 with SMTP id sk9mr33041013pac.1.1455649217041;
        Tue, 16 Feb 2016 11:00:17 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.11.00.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 11:00:16 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286424>

Introduce objectname_atom_parser() which will parse the
'%(objectname)' atom and store information into the 'used_atom'
structure based on the modifiers used along with the atom.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 35 ++++++++++++++++++++++++-----------
 1 file changed, 24 insertions(+), 11 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 3895a8c..21f4937 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -43,6 +43,7 @@ static struct used_atom {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
 			unsigned int nlines;
 		} contents;
+		enum { O_FULL, O_SHORT } objectname;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -102,6 +103,16 @@ static void contents_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized %%(contents) argument: %s"), arg);
 }
 
+static void objectname_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		atom->u.objectname = O_FULL;
+	else if (!strcmp(arg, "short"))
+		atom->u.objectname = O_SHORT;
+	else
+		die(_("unrecognized %%(objectname) argument: %s"), arg);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -160,7 +171,7 @@ static struct {
 	{ "refname" },
 	{ "objecttype" },
 	{ "objectsize", FIELD_ULONG },
-	{ "objectname" },
+	{ "objectname", FIELD_STR, objectname_atom_parser },
 	{ "tree" },
 	{ "parent" },
 	{ "numparent", FIELD_ULONG },
@@ -440,15 +451,17 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
 }
 
 static int grab_objectname(const char *name, const unsigned char *sha1,
-			    struct atom_value *v)
+			   struct atom_value *v, struct used_atom *atom)
 {
-	if (!strcmp(name, "objectname")) {
-		v->s = xstrdup(sha1_to_hex(sha1));
-		return 1;
-	}
-	if (!strcmp(name, "objectname:short")) {
-		v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
-		return 1;
+	if (starts_with(name, "objectname")) {
+		if (atom->u.objectname == O_SHORT) {
+			v->s = xstrdup(find_unique_abbrev(sha1, DEFAULT_ABBREV));
+			return 1;
+		} else if (atom->u.objectname == O_FULL) {
+			v->s = xstrdup(sha1_to_hex(sha1));
+			return 1;
+		} else
+			die("BUG: unknown %%(objectname) option");
 	}
 	return 0;
 }
@@ -472,7 +485,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->oid.hash, v);
+			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
 	}
 }
 
@@ -996,7 +1009,7 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname, v)) {
+		} else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
-- 
2.7.1
