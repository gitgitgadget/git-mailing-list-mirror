From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 04/12] ref-filter: introduce struct used_atom
Date: Wed, 17 Feb 2016 00:30:07 +0530
Message-ID: <1455649215-23260-5-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:00:04 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkqq-00088h-9h
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 19:59:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933188AbcBPS7v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 13:59:51 -0500
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35565 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755174AbcBPS7u (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 13:59:50 -0500
Received: by mail-pa0-f53.google.com with SMTP id ho8so109310308pac.2
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 10:59:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=hvlGmx4DsREkKZs49uKhKvlJe6mwr4XuBE8ffd0dKHs=;
        b=LhHFehct6C1ZWYNU7vRSi+HnbGfCXz4AbiepkCtalwW5dmdUbhtKp6pJ4na49+7k06
         NXqkLR0latZRMziBp1I0eAe/sKebeDgmam7KTkf5jI2L6aMsQeA5ZuA8jtWTWT7j3RHI
         1ansTYaaZ/3te4W0FvDpH5VfEFP3bm9Rlco9iwrDSas/YqmKdKOqZwTM67Khc06jXqIM
         dj+7h6gPuulAC2P2AxqDdG2Cb6DDhl1ypeem5r3MfejMoye/R6ZDui/K4lHEJFu2p0m6
         nypmE9qkY7dZW+HwxvL9W06BtcgbCvCdyazFadgbM3GdlTjm/08MfK5rBt2yS7gi3ws3
         3DlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=hvlGmx4DsREkKZs49uKhKvlJe6mwr4XuBE8ffd0dKHs=;
        b=HFkK0JEzciqdBD4BK//hXgg3vfHjNu/Dh9gB938wJbrKq3mzWe9od+cBCHfs4TUYe/
         zgsyWs3kIY057RldR3upZbaGIaPgLsC5s9HOrtvr6agAKSqvR1E/GshqEJnYdQuXF1cg
         XHvrUbHc28Atgugy6A3OUWUP/nyRKcvSBQT5Ay94YPIP3hdnLJxDsJTtyh2S1GGde5+q
         juaQgRdWe/viY9s1E2M68mAe/ifIUSF/8ce2IV9u7hemO/c7uxUws4fm171LG8jhPckJ
         K4eJCEmAF2qjEbC97joc11/eyVEL7JPfNKSZXLKwDd7PKnppYDDgiEqmNY36VxIGRnjx
         q2Eg==
X-Gm-Message-State: AG10YORG78Qru9LNRkk3ooyavzsVzGxoDuXTvlCuSHLpS8gCLzm6BLBLUlRpbfE9jl7DDQ==
X-Received: by 10.66.225.177 with SMTP id rl17mr33216527pac.46.1455649190038;
        Tue, 16 Feb 2016 10:59:50 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.10.59.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 10:59:49 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286416>

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
index c3a8372..3736dc3 100644
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
