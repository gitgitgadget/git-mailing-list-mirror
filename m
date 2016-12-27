Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B2387200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755368AbcL0QXW (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:22 -0500
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36378 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755283AbcL0QXT (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:19 -0500
Received: by mail-pf0-f196.google.com with SMTP id c4so18371564pfb.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=A2kEEDNMtkBcBFbbUKMWpklXMatu4FYPOxM0VD1Jiwo=;
        b=jr0YdyCiE3FmyUVgn8vxgBz7mbBxczr2fV5hAzEymBJ1bYhFoqb/P5abxpOClYUHf9
         EFuPGjZF+YFhK2cj7xLX9OaFq8SghKnncTgFxKY4Q56Z+BHxW2TmCFkmyQwMdTm6MInZ
         MUVnw/BFk7B5GNpJOSLSUhc1FkeXWpyKxkKb3A98DIhoJO0NwHRXMYxXbypuBYeJ2wKB
         NxgwFuug4Bh2sfj9YbKbyDiCgrhEeyC+co6kVMxnLBZKXP6FIgdbOJ6lpakJPgCPeRy5
         3vzRnQYl+MqYnFGGIVwyKeU0ShhEipt1QoYtiSpB0si9ZTNe4DF2t18jz1/YBX2N2zSa
         7i9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=A2kEEDNMtkBcBFbbUKMWpklXMatu4FYPOxM0VD1Jiwo=;
        b=S//y1NabuREFLkq6PgXoqP8HJ/cDu8uf9XP6IbO/NBrqsUsZDrKGuaIbH/jMWJgoNw
         FZDVGGfhKUSiKU/8kGFaPx14w/4+rGm9SydB92PeFIb/XH0IHtNbQ+T3a6GUBam/6umw
         Tme3Nn+fN4/DPFHH/hcU5Qp2lLPKmKK+exLA3Q7MtYo5PFwjnuZrIDErsSAzyKVl7U7R
         rXaPPtfNYnzCj/MEKoR26IKgQMAzoHUn78oqa8A2TMby97mAcuCPusVACdON8nBO6j8P
         amEd8w9ivNLt4Fa8QU3lt4miVWQ7p4C01ngZmkpapJPbrhZF3FF4CQVKHibunFT9DyPB
         XMhA==
X-Gm-Message-State: AIkVDXJisBAilPK9omBGTah8AgYlsqbdLzTjiP+pWDwJJseN7TxYRBXUg+c0vQe6RI8E7A==
X-Received: by 10.99.54.140 with SMTP id d134mr59327216pga.132.1482855798891;
        Tue, 27 Dec 2016 08:23:18 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:18 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 03/20] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date:   Tue, 27 Dec 2016 21:53:40 +0530
Message-Id: <20161227162357.28212-4-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Implement %(if:equals=<string>) wherein the if condition is only
satisfied if the value obtained between the %(if:...) and %(then) atom
is the same as the given '<string>'.

Similarly, implement (if:notequals=<string>) wherein the if condition
is only satisfied if the value obtained between the %(if:...) and
%(then) atom is different from the given '<string>'.

This is done by introducing 'if_atom_parser()' which parses the given
%(if) atom and then stores the data in used_atom which is later passed
on to the used_atom of the %(then) atom, so that it can do the required
comparisons.

Add tests and Documentation for the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  3 +++
 ref-filter.c                       | 46 +++++++++++++++++++++++++++++++++-----
 t/t6302-for-each-ref-filter.sh     | 18 +++++++++++++++
 3 files changed, 62 insertions(+), 5 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index 5e80c34..39aab09 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -158,6 +158,9 @@ if::
 	evaluating the string before %(then), this is useful when we
 	use the %(HEAD) atom which prints either "*" or " " and we
 	want to apply the 'if' condition only on the 'HEAD' ref.
+	Append ":equals=<string>" or ":notequals=<string>" to compare
+	the value between the %(if:...) and %(then) atoms with the
+	given string.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index f31c4b6..e002629 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -16,6 +16,7 @@
 #include "trailer.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
+typedef enum { COMPARE_EQUAL, COMPARE_UNEQUAL, COMPARE_NONE } cmp_status;
 
 struct align {
 	align_type position;
@@ -23,6 +24,8 @@ struct align {
 };
 
 struct if_then_else {
+	cmp_status cmp_status;
+	const char *str;
 	unsigned int then_atom_seen : 1,
 		else_atom_seen : 1,
 		condition_satisfied : 1;
@@ -50,6 +53,10 @@ static struct used_atom {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB, C_TRAILERS } option;
 			unsigned int nlines;
 		} contents;
+		struct {
+			cmp_status cmp_status;
+			const char *str;
+		} if_then_else;
 		enum { O_FULL, O_SHORT } objectname;
 	} u;
 } *used_atom;
@@ -179,6 +186,21 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
 	string_list_clear(&params, 0);
 }
 
+static void if_atom_parser(struct used_atom *atom, const char *arg)
+{
+	if (!arg) {
+		atom->u.if_then_else.cmp_status = COMPARE_NONE;
+		return;
+	} else if (skip_prefix(arg, "equals=", &atom->u.if_then_else.str)) {
+		atom->u.if_then_else.cmp_status = COMPARE_EQUAL;
+	} else if (skip_prefix(arg, "notequals=", &atom->u.if_then_else.str)) {
+		atom->u.if_then_else.cmp_status = COMPARE_UNEQUAL;
+	} else {
+		die(_("unrecognized %%(if) argument: %s"), arg);
+	}
+}
+
+
 static struct {
 	const char *name;
 	cmp_type cmp_type;
@@ -220,7 +242,7 @@ static struct {
 	{ "color", FIELD_STR, color_atom_parser },
 	{ "align", FIELD_STR, align_atom_parser },
 	{ "end" },
-	{ "if" },
+	{ "if", FIELD_STR, if_atom_parser },
 	{ "then" },
 	{ "else" },
 };
@@ -422,6 +444,9 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	struct ref_formatting_stack *new;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
 
+	if_then_else->str = atomv->atom->u.if_then_else.str;
+	if_then_else->cmp_status = atomv->atom->u.if_then_else.cmp_status;
+
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = if_then_else_handler;
@@ -453,10 +478,17 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
 		die(_("format: %%(then) atom used after %%(else)"));
 	if_then_else->then_atom_seen = 1;
 	/*
-	 * If there exists non-empty string between the 'if' and
-	 * 'then' atom then the 'if' condition is satisfied.
+	 * If the 'equals' or 'notequals' attribute is used then
+	 * perform the required comparison. If not, only non-empty
+	 * strings satisfy the 'if' condition.
 	 */
-	if (cur->output.len && !is_empty(cur->output.buf))
+	if (if_then_else->cmp_status == COMPARE_EQUAL) {
+		if (!strcmp(if_then_else->str, cur->output.buf))
+			if_then_else->condition_satisfied = 1;
+	} else 	if (if_then_else->cmp_status == COMPARE_UNEQUAL) {
+		if (strcmp(if_then_else->str, cur->output.buf))
+			if_then_else->condition_satisfied = 1;
+	} else if (cur->output.len && !is_empty(cur->output.buf))
 		if_then_else->condition_satisfied = 1;
 	strbuf_reset(&cur->output);
 }
@@ -1158,7 +1190,11 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!strcmp(name, "end")) {
 			v->handler = end_atom_handler;
 			continue;
-		} else if (!strcmp(name, "if")) {
+		} else if (starts_with(name, "if")) {
+			const char *s;
+
+			if (skip_prefix(name, "if:", &s))
+				v->s = xstrdup(s);
 			v->handler = if_atom_handler;
 			continue;
 		} else if (!strcmp(name, "then")) {
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index fed3013..a09a1a4 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -403,4 +403,22 @@ test_expect_success 'ignore spaces in %(if) atom usage' '
 	test_cmp expect actual
 '
 
+test_expect_success 'check %(if:equals=<string>)' '
+	git for-each-ref --format="%(if:equals=master)%(refname:short)%(then)Found master%(else)Not master%(end)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	Found master
+	Not master
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check %(if:notequals=<string>)' '
+	git for-each-ref --format="%(if:notequals=master)%(refname:short)%(then)Not master%(else)Found master%(end)" refs/heads/ >actual &&
+	cat >expect <<-\EOF &&
+	Found master
+	Not master
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.2

