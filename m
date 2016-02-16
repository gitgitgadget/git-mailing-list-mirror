From: Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v5 08/12] ref-filter: introduce align_atom_parser()
Date: Wed, 17 Feb 2016 00:30:11 +0530
Message-ID: <1455649215-23260-9-git-send-email-Karthik.188@gmail.com>
References: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Cc: gitster@pobox.com, sunshine@sunshineco.com,
	Karthik Nayak <Karthik.188@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 16 20:00:22 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aVkr9-0008UQ-2r
	for gcvg-git-2@plane.gmane.org; Tue, 16 Feb 2016 20:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933221AbcBPTAH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2016 14:00:07 -0500
Received: from mail-pa0-f49.google.com ([209.85.220.49]:34452 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933217AbcBPTAD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2016 14:00:03 -0500
Received: by mail-pa0-f49.google.com with SMTP id fy10so68376191pac.1
        for <git@vger.kernel.org>; Tue, 16 Feb 2016 11:00:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PLruhpfA+LN/CXHWcmIz0miuBP3JO7jdOJbA6Bv5hME=;
        b=l7JMeg/MsK/M4ADDnhlZAa882tlYwMgGtl9Ia05DJPEsad/9CHfj6yXVHZZ29pxxkt
         pZ03a31p31TK6pfoQLePZxabUeasiw1hh3SEsjG1deoeW2FyF5LRTKkCiubo2sCoVR5E
         n7259D5QHZP0hzXfYCnuDKfjWdOrfzbYyGKKowbLl98at/4R1vcr9cCqw44hhi4oPEOx
         x50idyJ4xLRfzPFSAKtJiyvDyjya70iguOQTuWprFguyNQHxKAsDVVHZ9giOxNksU+A8
         c+bx9Da4nG68v4AO8h4Iv3kDg8fVMj7XvfYTr+flvkEjluK40tdeRFqniEBUBJdxN4aL
         uvGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PLruhpfA+LN/CXHWcmIz0miuBP3JO7jdOJbA6Bv5hME=;
        b=Y94QtDEEM12df/Jx4h45N0UNi2VuIfvKfAP8aX5/PaURzAWGKJe5Wy8rHs7G2ciHoO
         pRjbWcstwf9lpiQm4eNI0aC83SC42kWxlPrMlqS6BmBVe1w+EZBgDFVOo6zpxQTyWGyJ
         KDZAbs1B/5jWmAYCg6dPZ6sCFGfGKTI9GtDVnbHkfKha4v1ruqcX1FAWyEA8JRsUzHn1
         3YXO2Re5dcTmV2MwVUs7gTgPQa2yATcDzFQgnvSF0AOSWqeBTtXSXeCGeLrF+OIL4iKL
         2GjoKwEKeu4pICizCg0CgZm1VKv0roKBIib5eRZeMCEg72RZkR+Wc3USIa07UB5NAeNz
         SsbA==
X-Gm-Message-State: AG10YORk7wtGokht5N03wVHk60VudEqOUHy2tbWqoiFY9JzSQi5mGPiaIFgp9oL56CDtyg==
X-Received: by 10.66.63.104 with SMTP id f8mr33072334pas.109.1455649203329;
        Tue, 16 Feb 2016 11:00:03 -0800 (PST)
Received: from ashley.localdomain ([106.51.133.38])
        by smtp.gmail.com with ESMTPSA id 27sm47469677pfh.48.2016.02.16.11.00.00
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 16 Feb 2016 11:00:02 -0800 (PST)
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
X-Mailer: git-send-email 2.7.1
In-Reply-To: <1455649215-23260-1-git-send-email-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/286419>

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
index a08ea83..4a9711f 100644
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
+	struct strbuf **v, **to_free;
+	unsigned int width = ~0U;
+
+	if (!arg)
+		die(_("expected format: %%(align:<width>,<position>)"));
+	v = to_free = strbuf_split_str_omit_term(arg, ',', 0);
+
+	align->position = ALIGN_LEFT;
+
+	while (*v) {
+		int position;
+		const char *s = v[0]->buf;
+
+		if (!strtoul_ui(s, 10, &width))
+			;
+		else if ((position = parse_align_position(s)) >= 0)
+			align->position = position;
+		else
+			die(_("unrecognized %%(align) argument: %s"), s);
+		v++;
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
@@ -288,22 +320,6 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
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
@@ -845,7 +861,6 @@ static void populate_value(struct ref_array_item *ref)
 		int deref = 0;
 		const char *refname;
 		const char *formatp;
-		const char *valp;
 		struct branch *branch = NULL;
 
 		v->handler = append_atom;
@@ -909,34 +924,8 @@ static void populate_value(struct ref_array_item *ref)
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
2.7.1
