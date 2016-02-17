From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v6 05/11] ref-filter: introduce color_atom_parser()
Date: Wed, 17 Feb 2016 23:36:13 +0530
Message-ID: <1455732379-22479-6-git-send-email-Karthik.188@gmail.com>
References: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 17 19:05:58 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aW6U8-0006ok-QC
	for gcvg-git-2@plane.gmane.org; Wed, 17 Feb 2016 19:05:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423494AbcBQSFw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Feb 2016 13:05:52 -0500
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34683 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423479AbcBQSFt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Feb 2016 13:05:49 -0500
Received: by mail-pa0-f52.google.com with SMTP id fy10so15116154pac.1
        for <git@vger.kernel.org>; Wed, 17 Feb 2016 10:05:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WwMF79UuHGPQXTOfGWC9iwGHjlYSJghKh/AJXQlH7d8=;
        b=Sh96rqMYbMzSA859Fcs9uO5ug6LtdXaTHAAaVK9uvXUEkJ0ooeHS7fZLB0td/TiFzf
         uKLWpdxJ1UbRLB5uo6imonLc5K3OCZ34ntMt+eTzLKwa6vlmOSAdh+KKM/NJY5u9+dPu
         VjgcIefWXW9ct7D9CVKtFJrmxzj0gNENZOnS+13OkkxVQwX83FBwYSYQj/a7Srfg4q+U
         ap5QmR1VekbaAPFvnEZ6BpcIDGOPQnImNrkkG/Wwa5SIqnZHzG6cph1Gaxw3CGahWOwe
         hmcNvPathVgb7rSnA8o5lV2h0J3xVKentz1k/7eLmMRrctzUjeR7tWQiLcIdHofl/nNx
         CoEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WwMF79UuHGPQXTOfGWC9iwGHjlYSJghKh/AJXQlH7d8=;
        b=MpLhjKo44f9gnz5g8VvO7BTGbd9Yy1df3Kx3bi6gtcoo9QtnSuCKIRFXyKPtgObU1b
         r5RqP8FbjJiPWOBY+1G7LI/HjcUcaO5Hqp5syvqPPLXPT7l/R6y9+AUFeuDwHoEAA5lR
         gUG0eeWbM239cDxECI4cT+kfI96VvBBGR97hZLpyo2bQ7M2ZNfFZD/ho3hrog47Uekfr
         bH5UDSqxc8hKe9zFAlOCs2ZprDn2bc16444crTf0jsVvgB+VkwLQ9iCAMj3pwmSH+RSd
         EKkIqNLvUXkU31jniotArCi5ZoyDPHjd/Ztg46X23Z6CEXxB6y7DB/POVwxDSmnsECkk
         HVxQ==
X-Gm-Message-State: AG10YOSQl79KxiLzgF6Ve8cS/WL8x54Q8WcLLDuGOSjGHKNzQmiqqbR+8HvfJ/10vZHEqQ==
X-Received: by 10.66.54.78 with SMTP id h14mr3858968pap.127.1455732349234;
        Wed, 17 Feb 2016 10:05:49 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id cf6sm4105793pad.41.2016.02.17.10.05.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 17 Feb 2016 10:05:48 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455732379-22479-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286521>

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
index 8a34ba1..c90d2f4 100644
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
+		die(_("unrecognized color: %%(color:%s)"), color_value);
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
@@ -158,6 +169,7 @@ int parse_ref_filter_atom(const char *atom, const char *ep)
 	used_atom[at].type = valid_atom[i].cmp_type;
 	if (arg)
 		arg = used_atom[at].name + (arg - atom) + 1;
+	memset(&used_atom[at].u, 0, sizeof(used_atom[at].u));
 	if (valid_atom[i].parser)
 		valid_atom[i].parser(&used_atom[at], arg);
 	if (*atom == '*')
@@ -816,6 +828,7 @@ static void populate_value(struct ref_array_item *ref)
 
 	/* Fill in specials first */
 	for (i = 0; i < used_atom_cnt; i++) {
+		struct used_atom *atom = &used_atom[i];
 		const char *name = used_atom[i].name;
 		struct atom_value *v = &ref->value[i];
 		int deref = 0;
@@ -856,14 +869,8 @@ static void populate_value(struct ref_array_item *ref)
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
2.7.1
