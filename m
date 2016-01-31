From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 12/12] ref-filter: introduce objectname_atom_parser()
Date: Sun, 31 Jan 2016 23:12:56 +0530
Message-ID: <1454262176-6594-13-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:47:15 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw5i-0006lb-9Q
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:47:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932845AbcAaRrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:47:10 -0500
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35755 "EHLO
	mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932527AbcAaRpJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:45:09 -0500
Received: by mail-pf0-f193.google.com with SMTP id 66so5972048pfe.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:45:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=yrlA4ewRaoLQy9M8PWKdGDvuO1wWR8SiYowIe3nCZqA=;
        b=GBNL4HvgnE+sw+mDgth1RZlMogAcSL0CRNl/omYkqGKOJZVN3BzVyncyTbAUHLakqR
         UcJFktMCEIM/fdxGNQmhkB9DZX94BWKLi6GC+Wz4SVin8VaoMQsSf/ugS0BESQIC6p5l
         k81aQMhK7WZU4yl2h5v9GPo0F+qs8XE/I+oY/DbUx7wN1YnmOOcPor279l+hfwgs26VZ
         Wvhzw8kxlZafMtBZ9bnahji4VVUnAJg2C7oWqyjhQYX+UKjC9fI4PNPWXhEJZo+iU++1
         A3zLZdqmnB0l7301+bjsJVzB3w9UI8S8CK1EDkha0vhNw6PAXpknUwZbMYxLNZC584E/
         3Jlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=yrlA4ewRaoLQy9M8PWKdGDvuO1wWR8SiYowIe3nCZqA=;
        b=Ree0ViVqvsq/uWWs5dhg/ZAOqYEHhQ2SNCsDoyeCHSBgL/gY+cc+oJx3MuqaIkNpGv
         DFp9EgZ8OsT7RmdIBU9XpG607EG2oo+VkakhCF76/1yfl/pMliUddFO7I5Pdn4vVlW84
         NerqZ08kysKZP1oYZMSSWLKPoK/cD6bYE23cZUb9jvCFXmczqRyUap76J9Dm+aCh0dFb
         B7+0kvCBfJ63REZ0cpFggC8fM8rBOY9kePS8B8QMxJdeclhVmYTERYTX4O2LV0I/p9SG
         HcMDpPAwUciIrAriycAAnIghMzH68nlqpotjy4VqluscZib1lPYE8sKUlYW0M6QkSZ8s
         B4Aw==
X-Gm-Message-State: AG10YOQJXw6qso5I6WYS2D66jw/Nuyf3gPFv4qP2zetyHgs1Db6kueqlQH/e07dRgY6aDg==
X-Received: by 10.98.71.136 with SMTP id p8mr31496598pfi.131.1454262308553;
        Sun, 31 Jan 2016 09:45:08 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.45.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:45:07 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285168>

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
index b2043a0..d48e2a3 100644
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
@@ -439,15 +450,17 @@ static void *get_obj(const unsigned char *sha1, struct object **obj, unsigned lo
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
@@ -471,7 +484,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 			v->s = xstrfmt("%lu", sz);
 		}
 		else if (deref)
-			grab_objectname(name, obj->oid.hash, v);
+			grab_objectname(name, obj->oid.hash, v, &used_atom[i]);
 	}
 }
 
@@ -995,7 +1008,7 @@ static void populate_value(struct ref_array_item *ref)
 				v->s = xstrdup(buf + 1);
 			}
 			continue;
-		} else if (!deref && grab_objectname(name, ref->objectname, v)) {
+		} else if (!deref && grab_objectname(name, ref->objectname, v, atom)) {
 			continue;
 		} else if (!strcmp(name, "HEAD")) {
 			const char *head;
-- 
2.7.0
