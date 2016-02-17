From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 11/11] ref-filter: introduce objectname_atom_parser()
Date: Wed, 17 Feb 2016 23:36:19 +0530
Message-ID: <1455732379-22479-12-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:07:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6VV-0007wY-Qw
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:07:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423578AbcBQSGM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:06:12 -0500
Received: from mail-pa0-f42.google.com ([209.85.220.42]:33728 "EHLO
	mail-pa0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423519AbcBQSGD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:06:03 -0500
Received: by mail-pa0-f42.google.com with SMTP id fl4so15180454pad.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:06:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=HNgObZq3GgbShUGJ+zUVtRRFh+76Vc2oKNT8Nmrtua8=;
        b=KSAdO1So5pNAsNDWDhvErA3Z4GMsV7JOHM1vFaxLibt/4LvZnW19/gcuNCPJCHnp9W
         GyyOTDJ8o7Kck7O3EacOGtGsHy4Tv/u8UZvmAj4/e5iTa2A+fGbdRi2P76JUJQAm0ftg
         7noSesWX/XAVIguw4AWOLcJ297eOd3uLqtqGZZekRY6nM9/yzzBKKHh/Buwo22CejnMs
         YJx1OZm9mJgqLPjfg5woGjLHcwW3O6FBgk+l3Ma+3rWbMSLclMoCQRSYJVf1LfwH7jyK
         A88NUvn3WJPI3bKxy89EDnwLuCD2RoTP5ra7zCDbkX8HI8m0Dnk0w1cm2ARweAT2RPQg
         wUrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=HNgObZq3GgbShUGJ+zUVtRRFh+76Vc2oKNT8Nmrtua8=;
        b=SsbfRfOTjfTcf0oaK8lzvj6U3aZakynq/GEXhee+9K/J8IJJUt5DRFrtAyVkZ403V9
         M64VH/YWwBmanVC+fIqKwpls+EJXZ/oB6+a51buqsQQT6txVQtpCFBnHqJY5NcIfDUyJ
         2Wmk2YhHSN/dqVu00xFvws1GS4OIpUcX4iP/L8+PuTn/d9IghbyEmILJz40dXmmi7FNW
         lyC1XCyLHC4jg8sfAMOhGKM8vCp+4U/aQle9u3DlUiFjiT2CqQysAcRcIeG/eVOC/2bh
         qmZNQ8FBUUWEejnwT+RrA1QTWWGJyu2RXLWU827T0Qqi4dRnnxLaZ1I78+Di6RYCk7WW
         m0Aw==
X-Gm-Message-State: AG10YOS/xIUhZ1hbictkOL/k2hp50uCYQrwH1qyoLuIM4hb0JKJH6S2E5tIFx/rXRe3JYw==
X-Received: by 10.66.55.102 with SMTP id r6mr3920468pap.67.1455732363065;
        Wed, 17 Feb 2016 10:06:03 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.06.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:06:02 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286528>

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
index d2946ea..d13d002 100644
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
