From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v4 08/12] ref-filter: introduce align_atom_parser()
Date: Sun, 31 Jan 2016 23:12:52 +0530
Message-ID: <1454262176-6594-9-git-send-email-Karthik.188@gmail.com>
References: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 31 18:43:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPw1p-000094-FD
	for gcvg-git-2@plane.gmane.org; Sun, 31 Jan 2016 18:43:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932935AbcAaRnE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 31 Jan 2016 12:43:04 -0500
Received: from mail-pf0-f195.google.com ([209.85.192.195]:34002 "EHLO
	mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932518AbcAaRmh (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 31 Jan 2016 12:42:37 -0500
Received: by mail-pf0-f195.google.com with SMTP id 65so6417122pfd.1
        for <git@vger.kernel.org>; Sun, 31 Jan 2016 09:42:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PtmQ8MtyoTO7yBZzS4y6jnoh5vadKmkvkZ/UUiViWjc=;
        b=q73oQ4fZq07Gl0UGCmcS8YSRtOLx6AwUopcQkYGICkXRUPQo2Y+IJlkYrxKj9bqWdB
         KQW/JHHMz/5f6Ti+lcMbNN47sAuywtjPdppAPE7J4fzUXz5n2h8XlMFoJRS4eZkOZqVd
         cAu2k7nY8nSXpw4KWTPEkQO5zSseM8jVwUWr84+rEE+iuuCN0v0J/PEfz7afSy2vN6d4
         Olxz8PWuwodf3XQmqlpduotpJIxwIDL64n/OQMuTD6BuKf9fUeFCK+af+ax5FP+L5uZz
         G4T8UmkoS3lm3G3M7iCDnGr4bq2e6PaqkKssAgqvuaK43ghOuWSJ6QmlmtksDDEhxHkl
         X5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PtmQ8MtyoTO7yBZzS4y6jnoh5vadKmkvkZ/UUiViWjc=;
        b=A5XwT0VRUu94/AahYw8pLlcfh4apzKr8hEo9NGkBSyHcNLnG/+bL0fnbpiSXdsRZyD
         VNP5MoSc35ibrcnBlJm2Tvq1jN64T+MPqCp0Sdg8HinVkyQFsdjGVTazq3aI+hEpRDBL
         3zjVNzFry654ZfcRtNpd8u8uvLsfWk3zQusTbWYwa/BdVLqm486JOJdhKGFLE6meWG5k
         QHLPgaogFeZuEephQ180+9FKJw4gMyy3pdtZZw5Rx7Zf1qRtkco6nPRiaqdpkloqTqYK
         EZOheTabIoqicis/ADHEuuJIp9PGliO5NxTJlX/a1IVSAl7N8/bfw8EN8f8DyLtlFrv6
         ZDEw==
X-Gm-Message-State: AG10YORrDJ5A5f23F/ZTpHMKAoZjNrudXuOKwUrmh21eSam9/PNXlvgsOo2LQ1dPg01wAg==
X-Received: by 10.98.64.195 with SMTP id f64mr31747335pfd.103.1454262156694;
        Sun, 31 Jan 2016 09:42:36 -0800 (PST)
Received: from ashley.localdomain ([106.51.132.212])
        by smtp.gmail.com with ESMTPSA id v26sm37274012pfi.56.2016.01.31.09.42.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 31 Jan 2016 09:42:36 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.0
In-Reply-To: <1454262176-6594-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285161>

Introduce align_atom_parser() which will parse an 'align' atom and
store the required alignment position and width in the 'used_atom'
structure for further usage in populate_value().

Since this patch removes the last usage of match_atom_name(), remove
the function from ref-filter.c.

Helped-by: Eric Sunshine <sunshine@sunshineco.com>
Helped-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
Signed-off-by: Karthik Nayak <Karthik.188@gmail.com>
---
 ref-filter.c | 91 ++++++++++++++++++++++++++----------------------------------
 1 file changed, 40 insertions(+), 51 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index e6b6b55..79a7e07 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,6 +16,11 @@
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
 
+struct align {
+	align_type position;
+	unsigned int width;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -31,6 +36,7 @@ static struct used_atom {
 	cmp_type type;
 	union {
 		char color[COLOR_MAXLEN];
+		struct align align;
 	} u;
 } *used_atom;
 static int used_atom_cnt, need_tagged, need_symref;
@@ -55,6 +61,37 @@ static align_type parse_align_position(const char *s)
 	return -1;
 }
 
+static void align_atom_parser(struct used_atom *atom, const char *arg)
+{
+	struct align *align = &atom->u.align;
+	struct strbuf **s, **to_free;
+	unsigned int width = ~0U;
+
+	if (!arg)
+		die(_("expected format: %%(align:<width>,<position>)"));
+	s = to_free = strbuf_split_str_omit_term(arg, ',', 0);
+
+	align->position = ALIGN_LEFT;
+
+	while (*s) {
+		int position;
+		arg = s[0]->buf;
+
+		if (!strtoul_ui(arg, 10, &width))
+			;
+		else if ((position = parse_align_position(arg)) >= 0)
+			align->position = position;
+		else
+			die(_("unrecognized %%(align) argument: %s"), arg);
+		s++;
+	}
+
+	if (width == ~0U)
+		die(_("positive width expected with the %%(align) atom"));
+	align->width = width;
+	strbuf_list_free(to_free);
+}
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -93,17 +130,12 @@ static struct {
 	{ "flag" },
 	{ "HEAD" },
 	{ "color", FIELD_STR, color_atom_parser },
-	{ "align" },
+	{ "align", FIELD_STR, align_atom_parser },
 	{ "end" },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
 
-struct align {
-	align_type position;
-	unsigned int width;
-};
-
 struct contents {
 	unsigned int lines;
 	struct object_id oid;
@@ -287,22 +319,6 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 	pop_stack_element(&state->stack);
 }
 
-static int match_atom_name(const char *name, const char *atom_name, const char **val)
-{
-	const char *body;
-
-	if (!skip_prefix(name, atom_name, &body))
-		return 0; /* doesn't even begin with "atom_name" */
-	if (!body[0]) {
-		*val = NULL; /* %(atom_name) and no customization */
-		return 1;
-	}
-	if (body[0] != ':')
-		return 0; /* "atom_namefoo" is not "atom_name" or "atom_name:..." */
-	*val = body + 1; /* "atom_name:val" */
-	return 1;
-}
-
 /*
  * In a format string, find the next occurrence of %(atom).
  */
@@ -844,7 +860,6 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
-		const char *valp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -908,34 +923,8 @@ static void populate_value(struct ref_array_item *ref)
 			else
 				v->s = " ";
 			continue;
-		} else if (match_atom_name(name, "align", &valp)) {
-			struct align *align = &v->u.align;
-			struct strbuf **s, **to_free;
-			int width = -1;
-
-			if (!valp)
-				die(_("expected format: %%(align:<width>,<position>)"));
-
-			s = to_free = strbuf_split_str_omit_term(valp, ',', 0);
-
-			align->position = ALIGN_LEFT;
-
-			while (*s) {
-				int position;
-
-				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
-					;
-				else if ((position = parse_align_position(s[0]->buf)) >= 0)
-					align->position = position;
-				else
-					die(_("improper format entered align:%s"), s[0]->buf);
-				s++;
-			}
-
-			if (width < 0)
-				die(_("positive width expected with the %%(align) atom"));
-			align->width = width;
-			strbuf_list_free(to_free);
+		} else if (starts_with(name, "align")) {
+			v->u.align = atom->u.align;
 			v->handler = align_atom_handler;
 			continue;
 		} else if (!strcmp(name, "end")) {
-- 
2.7.0
