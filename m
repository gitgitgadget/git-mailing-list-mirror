From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 03/11] ref-filter: introduce struct used_atom
Date: Wed, 17 Feb 2016 23:36:11 +0530
Message-ID: <1455732379-22479-4-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:05:54 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6U4-0006mT-BJ
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:05:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423478AbcBQSFr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:05:47 -0500
Received: from mail-pf0-f169.google.com ([209.85.192.169]:33756 "EHLO
	mail-pf0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423438AbcBQSFo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:44 -0500
Received: by mail-pf0-f169.google.com with SMTP id q63so15377019pfb.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wXrJFONGE9SYbk0j2f1XhoU1Y45sinaurpND0oD+OW4=;
        b=pucnH5jHN8ydm31oM21rcDk1eovkRxH8xs639YuBXdDYAe2iAD4ja1Zq9FCd2KAw7Z
         tPYyhbR7U39hLT829S2YDLo0CoDWAp0mjGrnu2GpPmjCHgVosQ9pQ5AkAOVIUFeMjHfn
         BPtMK2U+wew74qlYv5fGSYLMv0+YeGJdikUQtjSiHN379rBNFGZc17rnqMxKzKwXWFNZ
         5XvhV21ksIYRVsJLqkffdNVwtHY5Znhy8hQwWCyEtdb8nWkC7sJXjZwerW9GCo7EJkXX
         cIdBf+xsuPh5ZaCDWXTSJowyQkhTlDxnietTEPDcqdPghrHTYYGs7PY8BdqNQfSptEfI
         5+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wXrJFONGE9SYbk0j2f1XhoU1Y45sinaurpND0oD+OW4=;
        b=NONxoCqnKd6L9+PUi9QYBC9Et6dWJiORX+YPS3SjY+HxJRyHz2tOf8mZ4msV2yySZn
         zIU/4JakxfxbHQn+xZUA4CXCxNp9Gs4p80/PvFWZa3LDZWGrIDnVPxkPE51qILFzCrhy
         x0kMykr47bVYhaTLAzVb+NQlNDr3PxSNznbBRJQbQEVV8RPt1Y660J1ZKJHMmV+xCIbd
         H/n5n0Kr82mVSeAtPONH1GFdKf5/zuTTYTPc9l7Gov52bSpQMwtl/Y+b2oQLj3MbMj9Z
         QDKkfOZ+aNOpXFRoP8XUd/zQ2oj7/Jt4MWofECn/i3VB2Nd4XKaExZpyeC3NHZqC2Svy
         8k8Q==
X-Gm-Message-State: AG10YOSKzgQRegwJLa3G+1DbKiw01FhbfuOTsPHxZZgns1lP00yn+7cP/tV0Y3rA8u/csg==
X-Received: by 10.98.74.202 with SMTP id c71mr4005774pfj.25.1455732344381;
        Wed, 17 Feb 2016 10:05:44 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:43 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286520>

Introduce the 'used_atom' structure to replace the existing
implementation of 'used_atom' (which is a list of atoms). This helps
us parse atoms beforehand and store required details into the
'used_atom' for future usage.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 6a73c5b..8139709 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -26,8 +26,10 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
  * indexed with the "atom number", which is an index into this
  * array.
  */
-static const char **used_atom;
-static cmp_type *used_atom_type;
+static struct used_atom {
+	const char *name;
+	cmp_type type;
+} *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
 
@@ -122,8 +124,8 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 
 	/* Do we have the atom already used elsewhere? */
 	for (i = 0; i < used_atom_cnt; i++) {
-		int len = strlen(used_atom[i]);
-		if (len == ep - atom && !memcmp(used_atom[i], atom, len))
+		int len = strlen(used_atom[i].name);
+		if (len == ep - atom && !memcmp(used_atom[i].name, atom, len))
 			return i;
 	}
 
@@ -150,12 +152,11 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	at = used_atom_cnt;
 	used_atom_cnt++;
 	REALLOC_ARRAY(used_atom, used_atom_cnt);
-	REALLOC_ARRAY(used_atom_type, used_atom_cnt);
-	used_atom[at] = xmemdupz(atom, ep - atom);
-	used_atom_type[at] = valid_atom[i].cmp_type;
+	used_atom[at].name = xmemdupz(atom, ep - atom);
+	used_atom[at].type = valid_atom[i].cmp_type;
 	if (*atom == '*')
 		need_tagged = 1;
-	if (!strcmp(used_atom[at], "symref"))
+	if (!strcmp(used_atom[at].name, "symref"))
 		need_symref = 1;
 	return at;
 }
@@ -315,7 +316,7 @@ int verify_ref_format(const char *format)
 		at = parse_ref_filter_atom(sp + 2, ep);
 		cp = ep + 1;
 
-		if (skip_prefix(used_atom[at], "color:", &color))
+		if (skip_prefix(used_atom[at].name, "color:", &color))
 			need_color_reset_at_eol = !!strcmp(color, "reset");
 	}
 	return 0;
@@ -359,7 +360,7 @@ static void grab_common_values(struct atom_value *val, int deref, struct object
 	int i;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -383,7 +384,7 @@ static void grab_tag_values(struct atom_value *val, int deref, struct object *ob
 	struct tag *tag = (struct tag *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -405,7 +406,7 @@ static void grab_commit_values(struct atom_value *val, int deref, struct object
 	struct commit *commit = (struct commit *) obj;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -535,7 +536,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	const char *wholine = NULL;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -573,7 +574,7 @@ static void grab_person(const char *who, struct atom_value *val, int deref, stru
 	if (!wholine)
 		return;
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		if (!!deref != (*name == '*'))
 			continue;
@@ -663,7 +664,7 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &val[i];
 		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
@@ -809,7 +810,7 @@ static void populate_value(struct ref_array_item *ref)
 
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i];
+		const char *name = used_atom[i].name;
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
 		const char *refname;
@@ -1464,7 +1465,7 @@ static int cmp_ref_sorting(struct ref_sorting *s, struct ref_array_item *a, stru
 {
 	struct atom_value *va, *vb;
 	int cmp;
-	cmp_type cmp_type = used_atom_type[s->atom];
+	cmp_type cmp_type = used_atom[s->atom].type;
 
 	get_ref_atom_value(a, s->atom, &va);
 	get_ref_atom_value(b, s->atom, &vb);
-- 
2.7.1
