From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 10/11] ref-filter: introduce contents_atom_parser()
Date: Wed, 17 Feb 2016 23:36:18 +0530
Message-ID: <1455732379-22479-11-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:06:17 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6UM-00071Z-Lc
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:06:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423563AbcBQSGF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:06:05 -0500
Received: from mail-pf0-f174.google.com ([209.85.192.174]:32867 "EHLO
	mail-pf0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423530AbcBQSGB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:06:01 -0500
Received: by mail-pf0-f174.google.com with SMTP id q63so15380663pfb.0
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:06:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FDqng/3c1Lyj6Utimc4awGgBkGAc+GWFohbnPN1FVxo=;
        b=GQjIl7FALaMs/Wt38HEIrO+bGfBtWjAImgTwaU5Sx4WBWCCWs1NL4XhLRSj5kOb1Tz
         +cy5+sWNI6D9qL10XaK9SwysfVXvJDYr14h/DYoTT9ePw95gJMB0qf2T0H6Y0VmnAFq+
         Mk2MoZKMZylunmwOoVuJjgtYrm3BEPW8kfiLaGpDtX+XZOs4g5TspA4RQrub/9EbRdrg
         Qzmzkoklnzpsed72teLQNKSEnF2njj7HadZLhuYsTIgJr+G2PSd0Mp+8UM88wkrdAo5C
         dz6AqBmONunpKWoZdnKpI71mPOhoJI+OYcwKud82OBvdNKcZR79uTz88J9t+JKVIdNF4
         xkoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FDqng/3c1Lyj6Utimc4awGgBkGAc+GWFohbnPN1FVxo=;
        b=H82K4SXEogyLFJbtMTRPBT74fhHhqh6uwJ0CYMf3Tx+Lvw9oIA2Gez7olxrXNkCelz
         p9VJYLpAkppkzrv+RBjjtBO0XSMOw/nK0WmrlaOZdQcyiQSf3TOWSWfR3bcwoa21DeOx
         dPqx/b3oquRcxeUAB/okSh4GFFfOnD3Fi0V3ZXibdST2ximafUd7pYaZYRCIVbG3BwTZ
         zAATVqaKuNkAdboe+0sCJGpRmJvM7wKW5T+G9e7if8g6/hOuHXmI/wdq/hyRI+yoktlk
         r24JjBpNuz8Uj1qxxoib7GJQFQgaZ9eJ15sCYeoKPlqNzqXAYuCMASMvmpCGNwCqNc2Z
         DbDA==
X-Gm-Message-State: AG10YOQGQtMib35z51og8qzwWTB8fDD38KYtF5AfseIKeycpcgl67EngDP6BqsPV6EtEVA==
X-Received: by 10.98.17.92 with SMTP id z89mr4054396pfi.16.1455732360720;
        Wed, 17 Feb 2016 10:06:00 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.58
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:06:00 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286526>

Introduce contents_atom_parser() which will parse the '%(contents)'
atom and store information into the 'used_atom' structure based on the
modifiers used along with the atom. Also introduce body_atom_parser()
and subject_atom_parser() for parsing atoms '%(body)' and '%(subject)'
respectively.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 79 ++++++++++++++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 29 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 7df5085..d2946ea 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -39,6 +39,10 @@ static struct used_atom {
 		struct align align;
 		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
 			remote_ref;
+		struct {
+			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
+			unsigned int nlines;
+		} contents;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -66,6 +70,38 @@ static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
 		die(_("unrecognized format: %%(%s)"), atom->name);
 }
 
+static void body_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (arg)
+		die("%%(body) does not take arguments");
+	atom->u.contents.option = C_BODY_DEP;
+}
+
+static void subject_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (arg)
+		die("%%(subject) does not take arguments");
+	atom->u.contents.option = C_SUB;
+}
+
+static void contents_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		atom->u.contents.option = C_BARE;
+	else if (!strcmp(arg, "body"))
+		atom->u.contents.option = C_BODY;
+	else if (!strcmp(arg, "signature"))
+		atom->u.contents.option = C_SIG;
+	else if (!strcmp(arg, "subject"))
+		atom->u.contents.option = C_SUB;
+	else if (skip_prefix(arg, "lines=", &arg)) {
+		atom->u.contents.option = C_LINES;
+		if (strtoul_ui(arg, 10, &atom->u.contents.nlines))
+			die(_("positive value expected contents:lines=%s"), arg);
+	} else
+		die(_("unrecognized %%(contents) argument: %s"), arg);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -145,9 +181,9 @@ static struct {
 	{ "taggerdate", FIELD_TIME },
 	{ "creator" },
 	{ "creatordate", FIELD_TIME },
-	{ "subject" },
-	{ "body" },
-	{ "contents" },
+	{ "subject", FIELD_STR, subject_atom_parser },
+	{ "body", FIELD_STR, body_atom_parser },
+	{ "contents", FIELD_STR, contents_atom_parser },
 	{ "upstream", FIELD_STR, remote_ref_atom_parser },
 	{ "push", FIELD_STR, remote_ref_atom_parser },
 	{ "symref" },
@@ -160,11 +196,6 @@ static struct {
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
-struct contents {
-	unsigned int lines;
-	struct object_id oid;
-};
-
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
@@ -181,7 +212,6 @@ struct atom_value {
 	const char *s;
 	union {
 		struct align align;
-		struct contents contents;
 	} u;
 	void (*handler)(struct atom_value *atomv, struct ref_formatting_state *state);
 	unsigned long ul; /* used for sorting when not FIELD_STR */
@@ -733,20 +763,16 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 	unsigned long sublen = 0, bodylen = 0, nonsiglen = 0, siglen = 0;
 
 	for (i = 0; i < used_atom_cnt; i++) {
-		const char *name = used_atom[i].name;
+		struct used_atom *atom = &used_atom[i];
+		const char *name = atom->name;
 		struct atom_value *v = &val[i];
-		const char *valp = NULL;
 		if (!!deref != (*name == '*'))
 			continue;
 		if (deref)
 			name++;
 		if (strcmp(name, "subject") &&
 		    strcmp(name, "body") &&
-		    strcmp(name, "contents") &&
-		    strcmp(name, "contents:subject") &&
-		    strcmp(name, "contents:body") &&
-		    strcmp(name, "contents:signature") &&
-		    !starts_with(name, "contents:lines="))
+		    !starts_with(name, "contents"))
 			continue;
 		if (!subpos)
 			find_subpos(buf, sz,
@@ -754,28 +780,23 @@ static void grab_sub_body_contents(struct atom_value *val, int deref, struct obj
 				    &bodypos, &bodylen, &nonsiglen,
 				    &sigpos, &siglen);
 
-		if (!strcmp(name, "subject"))
-			v->s = copy_subject(subpos, sublen);
-		else if (!strcmp(name, "contents:subject"))
+		if (atom->u.contents.option == C_SUB)
 			v->s = copy_subject(subpos, sublen);
-		else if (!strcmp(name, "body"))
+		else if (atom->u.contents.option == C_BODY_DEP)
 			v->s = xmemdupz(bodypos, bodylen);
-		else if (!strcmp(name, "contents:body"))
+		else if (atom->u.contents.option == C_BODY)
 			v->s = xmemdupz(bodypos, nonsiglen);
-		else if (!strcmp(name, "contents:signature"))
+		else if (atom->u.contents.option == C_SIG)
 			v->s = xmemdupz(sigpos, siglen);
-		else if (!strcmp(name, "contents"))
-			v->s = xstrdup(subpos);
-		else if (skip_prefix(name, "contents:lines=", &valp)) {
+		else if (atom->u.contents.option == C_LINES) {
 			struct strbuf s = STRBUF_INIT;
 			const char *contents_end = bodylen + bodypos - siglen;
 
-			if (strtoul_ui(valp, 10, &v->u.contents.lines))
-				die(_("positive value expected contents:lines=%s"), valp);
 			/*  Size is the length of the message after removing the signature */
-			append_lines(&s, subpos, contents_end - subpos, v->u.contents.lines);
+			append_lines(&s, subpos, contents_end - subpos, atom->u.contents.nlines);
 			v->s = strbuf_detach(&s, NULL);
-		}
+		} else if (atom->u.contents.option == C_BARE)
+			v->s = xstrdup(subpos);
 	}
 }
 
-- 
2.7.1
