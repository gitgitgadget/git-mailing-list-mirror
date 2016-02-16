From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 06/12] ref-filter: introduce color_atom_parser()
Date: Wed, 17 Feb 2016 00:30:09 +0530
Message-ID: <1455649215-23260-7-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:00:19 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkqw-0008IR-Hm
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 20:00:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933212AbcBPS76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 13:59:58 -0500
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33397 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933189AbcBPS75 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 13:59:57 -0500
Received: by mail-pa0-f43.google.com with SMTP id fl4so95993071pad.0
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 10:59:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=i5XDIvQv1ke8l70+Tww3kKqtBw3WCATXbMmBivNU+3s=;
        b=xligPyeXTlqJGa8W3WX2eaKxCpnJIHdgdYgGLh+JtsZ24CD6CFZs6k5yHpKSWfvPdI
         Vm9+sgTv/OxQG2gEI6GjZrUHctYeiFi6ejdu7+CwCeIGOKM1G8YcvSuNigTPfoK20zbC
         +IDbpjCsGzlLtCzLcDf0ChiWuHXwJSNyWQRcUHDOiKOcCz25UeP+q00Y8OW8eM+dmcfb
         GNVpTaaLl87/OyyFfHgxZlrwSP6NFgZ0DgxYstcRWwIOxcImssLMU2zCZi0PsTYhJbbx
         kQMC402Ei0Prmyd7SbDTxLEaGT1YqVJU2RoBvVlDQZXkkWKqC0iAEFkCQZ1ioawQnKHf
         D3Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=i5XDIvQv1ke8l70+Tww3kKqtBw3WCATXbMmBivNU+3s=;
        b=ejtDv5JnVpyWvoHMcCDzuGwV4A8GHvjQ8QYthGS3EN6VOeqhDOP7TAZ16nxlsLjNl8
         Y33dQpsROWJ2KiEdZJvvsxYJJuL4V9+OBSc+wFf29Q178pi1TG+wPnAor0nw0uCxqezX
         tqiMzqRo/sVj0xAAj4K/ATqoS8n0lJi1uyEOsVnaol4DIC1aaUCH4uLIjgvnr81u1uKj
         KmoQtX+lKMS1+6XG5c8bEJVQHLmPSR+5b7mHTDDl7Iwjwgu57Tn6KfzN4acf7BgSjpeb
         S+WjPc5lnpLYxx9V4kuqelF7VLDEk4KT5zV2fY1cgKFtBGp+0c1LWY/ykc8OGMUUEev/
         o+7Q==
X-Gm-Message-State: AG10YORHK4pAGV6lrMlfqpMi1T/uIMZ7tGKvwq8WSX1qyRHznynDhXeelQt3W/xpZoURtQ==
X-Received: by 10.67.14.138 with SMTP id fg10mr33253609pad.145.1455649196709;
        Tue, 16 Feb 2016 10:59:56 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.10.59.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 10:59:56 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286420>

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
index 974c412..f401da6 100644
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
