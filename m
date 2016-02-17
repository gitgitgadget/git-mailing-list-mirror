From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 09/11] ref-filter: introduce remote_ref_atom_parser()
Date: Wed, 17 Feb 2016 23:36:17 +0530
Message-ID: <1455732379-22479-10-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:06:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6UI-0006wo-He
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:06:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423555AbcBQSGB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:06:01 -0500
Received: from mail-pa0-f44.google.com ([209.85.220.44]:35011 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423519AbcBQSF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:58 -0500
Received: by mail-pa0-f44.google.com with SMTP id ho8so15548912pac.2
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=0kFtbTUa4Tu4wwwQ7zrQADxCgYGWkvuFU8kUhazXRAc=;
        b=Bn+TCGek2Q1yC0JCl+4hAhzue7iVbPzTWUKe/wXTXI4zW3avKY4ayyouBI7c4Ddg44
         3JsxWUSxb1ZgG5EZfuD7tagPRPdxMg+DtfMprrUHV0uZaMyQjn6UGHUWNJhdmU5u/rJy
         9b8Ie7Pb+rKpWcXpCNEZiUctaCl5I6ihGOFRaFvmGs911s9jR+3wy5OCzDDfpeHoyysK
         Kv+/YOlTkAzUnoxd9Cbp8VZWwbplNRigowaL9pEVSkDZueGXpaikIcuSdGDosn4BqwdZ
         rCt+YXSJGnYrHdtmm4zqgTrbO22AQItAQmbbXfTA8/b1AjO1xejSHdT4yKacX+ecCDWT
         a3PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=0kFtbTUa4Tu4wwwQ7zrQADxCgYGWkvuFU8kUhazXRAc=;
        b=RGWShAXHJiXYu65oOvBZ3U6GOdntaRA2Z7/iS/aCUozFsWD013hTDOGXaVENQVRkYd
         F35EZsM5RT6KaWGfBPI8UKICAR5sgCVs2B+/8mDNdoDJ0WW9OhV8Kp54pgu+nm1t3CGT
         xFh2j8Myj25Syr6m3y7uWFw8rL4eMiV0Nal3Mfl7DOoQTVEO1APqlyAQ5Uo2tNcgepkH
         TO2FrtwO70Pg5O+ozGdoAbRjYq7/fYVkuHWYw0Szoma1uA4CksMerot4+3NtPDjRquv/
         09ed0TYBEadl/LVJ53xv2fEXxzpgGnN63bt+UwNDGDmgzvUtuL88G5WCUOgBu8N/1niN
         3lsw==
X-Gm-Message-State: AG10YOTUwQE++cxuwZvUZyL3IDTX9NHg5bPK5yA/CWtQpAVy7bbpsgbWhHods9dW0h+ONw==
X-Received: by 10.66.142.132 with SMTP id rw4mr3959312pab.26.1455732358400;
        Wed, 17 Feb 2016 10:05:58 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:57 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286523>

Introduce remote_ref_atom_parser() which will parse the '%(upstream)'
and '%(push)' atoms and store information into the 'used_atom'
structure based on the modifiers used along with the corresponding
atom.

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 103 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 61 insertions(+), 42 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 2255dcc..7df5085 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -37,6 +37,8 @@ static struct used_atom {
 	union {
 		char color[COLOR_MAXLEN];
 		struct align align;
+		enum { RR_NORMAL, RR_SHORTEN, RR_TRACK, RR_TRACKSHORT }
+			remote_ref;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -50,6 +52,20 @@ static void color_atom_parser(struct used_atom *atom, const char *color_value)
 		die(_("unrecognized color: %%(color:%s)"), color_value);
 }
 
+static void remote_ref_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg)
+		atom->u.remote_ref = RR_NORMAL;
+	else if (!strcmp(arg, "short"))
+		atom->u.remote_ref = RR_SHORTEN;
+	else if (!strcmp(arg, "track"))
+		atom->u.remote_ref = RR_TRACK;
+	else if (!strcmp(arg, "trackshort"))
+		atom->u.remote_ref = RR_TRACKSHORT;
+	else
+		die(_("unrecognized format: %%(%s)"), atom->name);
+}
+
 static align_type parse_align_position(const char *s)
 {
 	if (!strcmp(s, "right"))
@@ -132,8 +148,8 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
-	{ "upstream" },
-	{ "push" },
+	{ "upstream", FIELD_STR, remote_ref_atom_parser },
+	{ "push", FIELD_STR, remote_ref_atom_parser },
 	{ "symref" },
 	{ "flag" },
 	{ "HEAD" },
@@ -840,6 +856,43 @@ static const char *strip_ref_components(const char *refname, const char *nr_arg)
 	return start;
 }
 
+static void fill_remote_ref_details(struct used_atom *atom, const char *refname,
+				    struct branch *branch, const char **s)
+{
+	int num_ours, num_theirs;
+	if (atom->u.remote_ref == RR_SHORTEN)
+		*s = shorten_unambiguous_ref(refname, warn_ambiguous_refs);
+	else if (atom->u.remote_ref == RR_TRACK) {
+		if (stat_tracking_info(branch, &num_ours,
+				       &num_theirs, NULL))
+			return;
+
+		if (!num_ours && !num_theirs)
+			*s = "";
+		else if (!num_ours)
+			*s = xstrfmt("[behind %d]", num_theirs);
+		else if (!num_theirs)
+			*s = xstrfmt("[ahead %d]", num_ours);
+		else
+			*s = xstrfmt("[ahead %d, behind %d]",
+				     num_ours, num_theirs);
+	} else if (atom->u.remote_ref == RR_TRACKSHORT) {
+		if (stat_tracking_info(branch, &num_ours,
+				       &num_theirs, NULL))
+			return;
+
+		if (!num_ours && !num_theirs)
+			*s = "=";
+		else if (!num_ours)
+			*s = "<";
+		else if (!num_theirs)
+			*s = ">";
+		else
+			*s = "<>";
+	} else /* RR_NORMAL */
+		*s = refname;
+}
+
 /*
  * Parse the object referred by ref, and grab needed value.
  */
@@ -891,8 +944,9 @@ static void populate_value(struct ref_array_item *ref)
 			branch = branch_get(branch_name);
 
 			refname = branch_get_upstream(branch, NULL);
-			if (!refname)
-				continue;
+			if (refname)
+				fill_remote_ref_details(atom, refname, branch, &v->s);
+			continue;
 		} else if (starts_with(name, "push")) {
 			const char *branch_name;
 			if (!skip_prefix(ref->refname, "refs/heads/",
@@ -903,6 +957,8 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
+			fill_remote_ref_details(atom, refname, branch, &v->s);
+			continue;
 		} else if (starts_with(name, "color:")) {
 			v->s = atom->u.color;
 			continue;
@@ -944,7 +1000,6 @@ static void populate_value(struct ref_array_item *ref)
 
 		formatp = strchr(name, ':');
 		if (formatp) {
-			int num_ours, num_theirs;
 			const char *arg;
 
 			formatp++;
@@ -953,43 +1008,7 @@ static void populate_value(struct ref_array_item *ref)
 						      warn_ambiguous_refs);
 			else if (skip_prefix(formatp, "strip=", &arg))
 				refname = strip_ref_components(refname, arg);
-			else if (!strcmp(formatp, "track") &&
-				 (starts_with(name, "upstream") ||
-				  starts_with(name, "push"))) {
-
-				if (stat_tracking_info(branch, &num_ours,
-						       &num_theirs, NULL))
-					continue;
-
-				if (!num_ours && !num_theirs)
-					v->s = "";
-				else if (!num_ours)
-					v->s = xstrfmt("[behind %d]", num_theirs);
-				else if (!num_theirs)
-					v->s = xstrfmt("[ahead %d]", num_ours);
-				else
-					v->s = xstrfmt("[ahead %d, behind %d]",
-						       num_ours, num_theirs);
-				continue;
-			} else if (!strcmp(formatp, "trackshort") &&
-				   (starts_with(name, "upstream") ||
-				    starts_with(name, "push"))) {
-				assert(branch);
-
-				if (stat_tracking_info(branch, &num_ours,
-							&num_theirs, NULL))
-					continue;
-
-				if (!num_ours && !num_theirs)
-					v->s = "=";
-				else if (!num_ours)
-					v->s = "<";
-				else if (!num_theirs)
-					v->s = ">";
-				else
-					v->s = "<>";
-				continue;
-			} else
+			else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
 		}
-- 
2.7.1
