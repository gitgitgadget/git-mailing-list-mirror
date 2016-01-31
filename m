From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 06/12] ref-filter: introduce color_atom_parser()
Date: Sun, 31 Jan 2016 23:12:50 +0530
Message-ID: <1454262176-6594-7-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:43:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw1i-0008My-FI
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:43:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932852AbcAaRnB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:43:01 -0500
Received: from mail-pa0-f68.google.com ([209.85.220.68]:35005 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932417AbcAaRmd (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:42:33 -0500
Received: by mail-pa0-f68.google.com with SMTP id gi1so6165747pac.2
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:42:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WL9oF4rpkOCN3Cj18DxwvRZ0HtWsAjhEeT1B8OkceZ0=;
        b=j0WfihGgoxlmTIZgUXGUpgag0ZdneQ7IUw8SemQWilPg2AQ20H8v7MZML9uC0Tygm0
         fkRE459RcdFzmJxz8B/GVJSVFBbNFVCA/4d+FeuLF29uI5i15CpskGU65R5s5kFImReF
         +nvIkk7PsH3NZX8BwnGcS8YtyLLWCNm/HYG8j9x7IoJYH6fx0n2pP9rRLo75+V76GpSH
         qiOpzgsa34F9DK9cXudnoAwbDOflZ+3hhlTqEJcY/ScUvISqQ+hW2mkFSeNpJ4u5/FHW
         buWKKkiA++J8XHoAN1NN7TGTNtTMoBM+NoA2nfBVQLhTjslXN4+7CzyNFrN1vsD7rZu5
         RFsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WL9oF4rpkOCN3Cj18DxwvRZ0HtWsAjhEeT1B8OkceZ0=;
        b=mFOGLlWpem8ntu1jMPyp5M5zq2hwMfFT9deAV4yuQbo7RPkb1onvW+wWFfcTZYTE2d
         uayNkSwxRw4OFjx4dUqThU17EJ9sl38zFCxwKJA6UTePa22noky7ElxegSRRYzBMyXp+
         FNmSvYod9Zayff2jFAeSMSIcka4sTZLnC5vF/9JrMHz2V3tFW/FBhjjdHnksHdwLy6VG
         xwd6vyEdbYIVN8Pcp3D0GvF+dXKMyddmFkyirLAkFMVJ+Owu5sQvcWS5mLaUErR2qTXv
         eBfcp2D4iW76Nu84f2/URpdrgZSK9FRaM4kW0D6bQJ52TG3o55wWHX1TbFj3tt2hj3wD
         sa1g==
X-Gm-Message-State: AG10YOSLUk6ipDuf7c4MkyO6rwJPSr4b5ZfiEJm9DILSjvKywFapkJfHm84xx1uDV15kYQ==
X-Received: by 10.66.242.17 with SMTP id wm17mr31333330pac.155.1454262152450;
        Sun, 31 Jan 2016 09:42:32 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.42.30
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:42:31 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285159>

Introduce color_atom_parser() which will parse a "color" atom and
store its color in the "used_atom" structure for further usage in
populate_value().

Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 92b4419..7adff67 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -29,10 +29,21 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 static struct used_atom {
 	const char *name;
 	cmp_type type;
+	union {
+		char color[COLOR_MAXLEN];
+	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
 static int need_color_reset_at_eol;
 
+static void color_atom_parser(struct used_atom *atom, const char *color_value)
+{
+	if (!color_value)
+		die(_("expected format: %%(color:<color>)"));
+	if (color_parse(color_value, atom->u.color) < 0)
+		die(_("invalid color value: %s"), atom->u.color);
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -70,7 +81,7 @@ static struct {
 	{ "symref" },
 	{ "flag" },
 	{ "HEAD" },
-	{ "color" },
+	{ "color", FIELD_STR, color_atom_parser },
 	{ "align" },
 	{ "end" },
 };
@@ -157,6 +168,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	used_atom[at].type = valid_atom[i].cmp_type;
 	if (arg)
 		arg = used_atom[at].name + (arg - atom) + 1;
+	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
@@ -815,6 +827,7 @@ static void populate_value(struct ref_array_item *ref)
 
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
+		struct used_atom *atom = &used_atom[i];
 		const char *name = used_atom[i].name;
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
@@ -855,14 +868,8 @@ static void populate_value(struct ref_array_item *ref)
 			refname = branch_get_push(branch, NULL);
 			if (!refname)
 				continue;
-		} else if (match_atom_name(name, "color", &valp)) {
-			char color[COLOR_MAXLEN] = "";
-
-			if (!valp)
-				die(_("expected format: %%(color:<color>)"));
-			if (color_parse(valp, color) < 0)
-				die(_("unable to parse format"));
-			v->s = xstrdup(color);
+		} else if (starts_with(name, "color:")) {
+			v->s = atom->u.color;
 			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
-- 
2.7.0
