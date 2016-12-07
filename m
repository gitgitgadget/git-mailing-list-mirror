Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id A1F2920259
	for <e@80x24.org>; Wed,  7 Dec 2016 15:38:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753405AbcLGPhy (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Dec 2016 10:37:54 -0500
Received: from mail-pg0-f66.google.com ([74.125.83.66]:33791 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752802AbcLGPgv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Dec 2016 10:36:51 -0500
Received: by mail-pg0-f66.google.com with SMTP id 3so23837644pgd.0
        for <git@vger.kernel.org>; Wed, 07 Dec 2016 07:36:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xrlJhAWMvQ2vWzb33lZD8UlhbMX4gPLwJj+vxhXw7GM=;
        b=pwAtx98UNK5ZIUcx3eAviq7K0iUR7nja2ZYIhgQnkJ5zmw5RuWIJEkF9NwzDKOu6AJ
         E7bjFJH3RJ0u03K40BfTQnkjyy/b1EFh2TbqL1+ijngvvbSKgozUwDIk1mId2oBydMFe
         dKxXgurhXcfg05XInVDTHaPlBQPxMy4ybmlKtthqX8oMiTLw/Qlm5WcrGz9NihndkjLY
         jl06ghpFN8Qdb2Gzhn8W8TBhNVU8Gg8A7z8dd3Avj/72w74Aj+jJRzzX28Mpi7VBY43O
         mGYmwu2TzcMEc8glZ+brRIZ/sGQq+TLDaqsg37fAoxL/VdEl0wsthKckk9rkW1Ip063G
         NmAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xrlJhAWMvQ2vWzb33lZD8UlhbMX4gPLwJj+vxhXw7GM=;
        b=itEDePsyhRUAyUP7aBJPgVcnuVEzTxkALcXUr+QS4Fiejugc+LcdF3B4/vXyMMp2oe
         1ALIMVSoNdT1BJN729T8aITMLC0+X6Zwj2oUN/dSUFXm3iGs2ohzDgZQsohhg6J+UI+p
         /Eg1Gh1gymZpXGVZ9N94Lzr1QZBMBfJNs77nLZ3q4rA7XpdXqdx/Iv+s+PWvqjAMEJ7r
         vs3IB7rlZSJU5/kpjvYdpOLm8X6xwPPH9iiY6ETvZQUdIdKM5a9ZiHG6BdWrvhNredxK
         KVIiNVjSXIRECsVzc0YX+VO4KeI4fvP4pOspVrt2nNQwsPt0aeF0fG+ywdlOlB74dtpM
         ymaQ==
X-Gm-Message-State: AKaTC033G3HDsNTrGt9+kmyXyAOWql2clVx6S6YB76Fe+G+rkHBLTIS+6afc3VE8JIKdRQ==
X-Received: by 10.98.155.9 with SMTP id r9mr70136489pfd.71.1481124970102;
        Wed, 07 Dec 2016 07:36:10 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([122.15.255.69])
        by smtp.gmail.com with ESMTPSA id l7sm43584459pfg.35.2016.12.07.07.36.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 07 Dec 2016 07:36:09 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com, jnareb@gmail.com,
        Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v8 03/19] ref-filter: implement %(if:equals=<string>) and %(if:notequals=<string>)
Date:   Wed,  7 Dec 2016 21:06:11 +0530
Message-Id: <20161207153627.1468-4-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161207153627.1468-1-Karthik.188@gmail.com>
References: <20161207153627.1468-1-Karthik.188@gmail.com>
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
index 3018969..392df6b 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -155,6 +155,9 @@ if::
 	evaluating the string before %(then), this is useful when we
 	use the %(HEAD) atom which prints either "*" or " " and we
 	want to apply the 'if' condition only on the 'HEAD' ref.
+	Append ":equals=<string>" or ":notequals=<string>" to compare
+	the value between the %(if:...) and %(then) atoms with the
+	given string.
 
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
diff --git a/ref-filter.c b/ref-filter.c
index 5166326..7a21256 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -15,6 +15,7 @@
 #include "version.h"
 
 typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
+typedef enum { COMPARE_EQUAL, COMPARE_UNEQUAL, COMPARE_NONE } cmp_status;
 
 struct align {
 	align_type position;
@@ -22,6 +23,8 @@ struct align {
 };
 
 struct if_then_else {
+	cmp_status cmp_status;
+	const char *str;
 	unsigned int then_atom_seen : 1,
 		else_atom_seen : 1,
 		condition_satisfied : 1;
@@ -49,6 +52,10 @@ static struct used_atom {
 			enum { C_BARE, C_BODY, C_BODY_DEP, C_LINES, C_SIG, C_SUB } option;
 			unsigned int nlines;
 		} contents;
+		struct {
+			cmp_status cmp_status;
+			const char *str;
+		} if_then_else;
 		enum { O_FULL, O_SHORT } objectname;
 	} u;
 } *used_atom;
@@ -169,6 +176,21 @@ static void align_atom_parser(struct used_atom *atom, const char *arg)
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
@@ -209,7 +231,7 @@ static struct {
 	{ "color", FIELD_STR, color_atom_parser },
 	{ "align", FIELD_STR, align_atom_parser },
 	{ "end" },
-	{ "if" },
+	{ "if", FIELD_STR, if_atom_parser },
 	{ "then" },
 	{ "else" },
 };
@@ -411,6 +433,9 @@ static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_stat
 	struct ref_formatting_stack *new;
 	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
 
+	if_then_else->str = atomv->atom->u.if_then_else.str;
+	if_then_else->cmp_status = atomv->atom->u.if_then_else.cmp_status;
+
 	push_stack_element(&state->stack);
 	new = state->stack;
 	new->at_end = if_then_else_handler;
@@ -442,10 +467,17 @@ static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_st
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
@@ -1138,7 +1170,11 @@ static void populate_value(struct ref_array_item *ref)
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

