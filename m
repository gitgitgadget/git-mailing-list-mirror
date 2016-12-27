Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7A9C7200E0
	for <e@80x24.org>; Tue, 27 Dec 2016 16:23:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755280AbcL0QXP (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Dec 2016 11:23:15 -0500
Received: from mail-pg0-f68.google.com ([74.125.83.68]:36030 "EHLO
        mail-pg0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755269AbcL0QXO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Dec 2016 11:23:14 -0500
Received: by mail-pg0-f68.google.com with SMTP id n5so12846610pgh.3
        for <git@vger.kernel.org>; Tue, 27 Dec 2016 08:23:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=2wa+b0+s0hzhtBk4OTpsyAccntub7tRULL9Nmexdc4g=;
        b=du7ciPrF/dadiuO2Pyk2c8AquDDeWDQtFMRnKXUPop1pi8cH3t4N0ItD0N3ZSkic1q
         q8nFwl24ddqh8ZZV6GpU1c8jxzYBczF1TX0aCMl2DtweFJuM6rw9IR1Famd940py8Vrl
         E2BjQtTUWyZOGAXJShpMbimU8dBvMUDDvbmMuq3wshPPHoVRIo755eHJZvVdnKd1rkaE
         tviGhKec7cwXP3Vh8z5K/kxzj8ZdNXfnaC502uKaervNQIz+It+y2Te8wc/f31Uhla7b
         7j95bhqVBliFafsN2nC3Y6h7yFY7gdiPV+hrLCnGkIyfcz8g49/RMrcq7qUHcF0z358e
         DvMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=2wa+b0+s0hzhtBk4OTpsyAccntub7tRULL9Nmexdc4g=;
        b=pDin0gajMKlGOircXvGmHPauTrmyV81AJ+Cnl1ULEjzeS+2ZtvUs8aj+8uj8DxEWit
         9ZyE6RwJYhQQtMpG8LhdGBNdn6j7EtrX3ezE3/eCQNCXIiX1gIoBTHNuN0hzUo3cMDt/
         qRy4WFu3QLGU1aaKwVvyuQf3hmcMQwW0ULsqSLpIqkKYU76u+SnFxLAm9xJoBDzvSHuH
         g0+ien8aLI653fg2tVPwmeG2WKmrCLO5QPK139V3taFijGQqMoWd23nl5dda+0yCyC1H
         SuLbYysJOVWWb/Pr5BAndNqkBPRTuRt0taWKr/3qy0IEmYZ2evGuYTdI/tfv6xz5jDxG
         3TQA==
X-Gm-Message-State: AIkVDXJvPTl5RUFgfI+YRi9WD+NQFtGnfDM+ZRtyzPTxjcITLq3v6h+2HuDpEX+bZbQXpw==
X-Received: by 10.98.16.132 with SMTP id 4mr30574126pfq.163.1482855793589;
        Tue, 27 Dec 2016 08:23:13 -0800 (PST)
Received: from AamlaJuice.corp.endurance.com ([115.110.127.198])
        by smtp.gmail.com with ESMTPSA id c64sm46517096pfa.91.2016.12.27.08.23.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 27 Dec 2016 08:23:12 -0800 (PST)
From:   Karthik Nayak <karthik.188@gmail.com>
X-Google-Original-From: Karthik Nayak <Karthik.188@gmail.com>
To:     git@vger.kernel.org
Cc:     jacob.keller@gmail.com, gitster@pobox.com,
        ramsay@ramsayjones.plus.com, Karthik Nayak <karthik.188@gmail.com>
Subject: [PATCH v9 01/20] ref-filter: implement %(if), %(then), and %(else) atoms
Date:   Tue, 27 Dec 2016 21:53:38 +0530
Message-Id: <20161227162357.28212-2-Karthik.188@gmail.com>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161227162357.28212-1-Karthik.188@gmail.com>
References: <20161227162357.28212-1-Karthik.188@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Karthik Nayak <karthik.188@gmail.com>

Implement %(if), %(then) and %(else) atoms. Used as
%(if)...%(then)...%(end) or %(if)...%(then)...%(else)...%(end). If the
format string between %(if) and %(then) expands to an empty string, or
to only whitespaces, then the whole %(if)...%(end) expands to the string
following %(then). Otherwise, it expands to the string following
%(else), if any. Nesting of this construct is possible.

This is in preparation for porting over `git branch -l` to use
ref-filter APIs for printing.

Add Documentation and tests regarding the same.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Matthieu Moy <matthieu.moy@grenoble-inp.fr>
Signed-off-by: Karthik Nayak <karthik.188@gmail.com>
---
 Documentation/git-for-each-ref.txt |  34 ++++++++++
 ref-filter.c                       | 134 +++++++++++++++++++++++++++++++++++--
 t/t6302-for-each-ref-filter.sh     |  76 +++++++++++++++++++++
 3 files changed, 237 insertions(+), 7 deletions(-)

diff --git a/Documentation/git-for-each-ref.txt b/Documentation/git-for-each-ref.txt
index abe13f3..5e80c34 100644
--- a/Documentation/git-for-each-ref.txt
+++ b/Documentation/git-for-each-ref.txt
@@ -149,6 +149,16 @@ align::
 	quoted, but if nested then only the topmost level performs
 	quoting.
 
+if::
+	Used as %(if)...%(then)...%(end) or
+	%(if)...%(then)...%(else)...%(end).  If there is an atom with
+	value or string literal after the %(if) then everything after
+	the %(then) is printed, else if the %(else) atom is used, then
+	everything after %(else) is printed. We ignore space when
+	evaluating the string before %(then), this is useful when we
+	use the %(HEAD) atom which prints either "*" or " " and we
+	want to apply the 'if' condition only on the 'HEAD' ref.
+
 In addition to the above, for commit and tag objects, the header
 field names (`tree`, `parent`, `object`, `type`, and `tag`) can
 be used to specify the value in the header field.
@@ -186,6 +196,14 @@ As a special case for the date-type fields, you may specify a format for
 the date by adding `:` followed by date format name (see the
 values the `--date` option to linkgit:git-rev-list[1] takes).
 
+Some atoms like %(align) and %(if) always require a matching %(end).
+We call them "opening atoms" and sometimes denote them as %($open).
+
+When a scripting language specific quoting is in effect, everything
+between a top-level opening atom and its matching %(end) is evaluated
+according to the semantics of the opening atom and its result is
+quoted.
+
 
 EXAMPLES
 --------
@@ -273,6 +291,22 @@ eval=`git for-each-ref --shell --format="$fmt" \
 eval "$eval"
 ------------
 
+
+An example to show the usage of %(if)...%(then)...%(else)...%(end).
+This prefixes the current branch with a star.
+
+------------
+git for-each-ref --format="%(if)%(HEAD)%(then)* %(else)  %(end)%(refname:short)" refs/heads/
+------------
+
+
+An example to show the usage of %(if)...%(then)...%(end).
+This prints the authorname, if present.
+
+------------
+git for-each-ref --format="%(refname)%(if)%(authorname)%(then) %(color:red)Authored by: %(authorname)%(end)"
+------------
+
 SEE ALSO
 --------
 linkgit:git-show-ref[1]
diff --git a/ref-filter.c b/ref-filter.c
index 1a97840..0a57872 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -22,6 +22,12 @@ struct align {
 	unsigned int width;
 };
 
+struct if_then_else {
+	unsigned int then_atom_seen : 1,
+		else_atom_seen : 1,
+		condition_satisfied : 1;
+};
+
 /*
  * An atom is a valid field atom listed below, possibly prefixed with
  * a "*" to denote deref_tag().
@@ -214,6 +220,9 @@ static struct {
 	{ "color", FIELD_STR, color_atom_parser },
 	{ "align", FIELD_STR, align_atom_parser },
 	{ "end" },
+	{ "if" },
+	{ "then" },
+	{ "else" },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -221,7 +230,7 @@ static struct {
 struct ref_formatting_stack {
 	struct ref_formatting_stack *prev;
 	struct strbuf output;
-	void (*at_end)(struct ref_formatting_stack *stack);
+	void (*at_end)(struct ref_formatting_stack **stack);
 	void *at_end_data;
 };
 
@@ -354,13 +363,14 @@ static void pop_stack_element(struct ref_formatting_stack **stack)
 	*stack = prev;
 }
 
-static void end_align_handler(struct ref_formatting_stack *stack)
+static void end_align_handler(struct ref_formatting_stack **stack)
 {
-	struct align *align = (struct align *)stack->at_end_data;
+	struct ref_formatting_stack *cur = *stack;
+	struct align *align = (struct align *)cur->at_end_data;
 	struct strbuf s = STRBUF_INIT;
 
-	strbuf_utf8_align(&s, align->position, align->width, stack->output.buf);
-	strbuf_swap(&stack->output, &s);
+	strbuf_utf8_align(&s, align->position, align->width, cur->output.buf);
+	strbuf_swap(&cur->output, &s);
 	strbuf_release(&s);
 }
 
@@ -374,6 +384,104 @@ static void align_atom_handler(struct atom_value *atomv, struct ref_formatting_s
 	new->at_end_data = &atomv->u.align;
 }
 
+static void if_then_else_handler(struct ref_formatting_stack **stack)
+{
+	struct ref_formatting_stack *cur = *stack;
+	struct ref_formatting_stack *prev = cur->prev;
+	struct if_then_else *if_then_else = (struct if_then_else *)cur->at_end_data;
+
+	if (!if_then_else->then_atom_seen)
+		die(_("format: %%(if) atom used without a %%(then) atom"));
+
+	if (if_then_else->else_atom_seen) {
+		/*
+		 * There is an %(else) atom: we need to drop one state from the
+		 * stack, either the %(else) branch if the condition is satisfied, or
+		 * the %(then) branch if it isn't.
+		 */
+		if (if_then_else->condition_satisfied) {
+			strbuf_reset(&cur->output);
+			pop_stack_element(&cur);
+		} else {
+			strbuf_swap(&cur->output, &prev->output);
+			strbuf_reset(&cur->output);
+			pop_stack_element(&cur);
+		}
+	} else if (!if_then_else->condition_satisfied) {
+		/*
+		 * No %(else) atom: just drop the %(then) branch if the
+		 * condition is not satisfied.
+		 */
+		strbuf_reset(&cur->output);
+	}
+
+	*stack = cur;
+	free(if_then_else);
+}
+
+static void if_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *new;
+	struct if_then_else *if_then_else = xcalloc(sizeof(struct if_then_else), 1);
+
+	push_stack_element(&state->stack);
+	new = state->stack;
+	new->at_end = if_then_else_handler;
+	new->at_end_data = if_then_else;
+}
+
+static int is_empty(const char *s)
+{
+	while (*s != '\0') {
+		if (!isspace(*s))
+			return 0;
+		s++;
+	}
+	return 1;
+}
+
+static void then_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *cur = state->stack;
+	struct if_then_else *if_then_else = NULL;
+
+	if (cur->at_end == if_then_else_handler)
+		if_then_else = (struct if_then_else *)cur->at_end_data;
+	if (!if_then_else)
+		die(_("format: %%(then) atom used without an %%(if) atom"));
+	if (if_then_else->then_atom_seen)
+		die(_("format: %%(then) atom used more than once"));
+	if (if_then_else->else_atom_seen)
+		die(_("format: %%(then) atom used after %%(else)"));
+	if_then_else->then_atom_seen = 1;
+	/*
+	 * If there exists non-empty string between the 'if' and
+	 * 'then' atom then the 'if' condition is satisfied.
+	 */
+	if (cur->output.len && !is_empty(cur->output.buf))
+		if_then_else->condition_satisfied = 1;
+	strbuf_reset(&cur->output);
+}
+
+static void else_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
+{
+	struct ref_formatting_stack *prev = state->stack;
+	struct if_then_else *if_then_else = NULL;
+
+	if (prev->at_end == if_then_else_handler)
+		if_then_else = (struct if_then_else *)prev->at_end_data;
+	if (!if_then_else)
+		die(_("format: %%(else) atom used without an %%(if) atom"));
+	if (!if_then_else->then_atom_seen)
+		die(_("format: %%(else) atom used without a %%(then) atom"));
+	if (if_then_else->else_atom_seen)
+		die(_("format: %%(else) atom used more than once"));
+	if_then_else->else_atom_seen = 1;
+	push_stack_element(&state->stack);
+	state->stack->at_end_data = prev->at_end_data;
+	state->stack->at_end = prev->at_end;
+}
+
 static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_state *state)
 {
 	struct ref_formatting_stack *current = state->stack;
@@ -381,14 +489,17 @@ static void end_atom_handler(struct atom_value *atomv, struct ref_formatting_sta
 
 	if (!current->at_end)
 		die(_("format: %%(end) atom used without corresponding atom"));
-	current->at_end(current);
+	current->at_end(&state->stack);
+
+	/*  Stack may have been popped within at_end(), hence reset the current pointer */
+	current = state->stack;
 
 	/*
 	 * Perform quote formatting when the stack element is that of
 	 * a supporting atom. If nested then perform quote formatting
 	 * only on the topmost supporting atom.
 	 */
-	if (!state->stack->prev->prev) {
+	if (!current->prev->prev) {
 		quote_formatting(&s, current->output.buf, state->quote_style);
 		strbuf_swap(&current->output, &s);
 	}
@@ -1049,6 +1160,15 @@ static void populate_value(struct ref_array_item *ref)
 		} else if (!strcmp(name, "end")) {
 			v->handler = end_atom_handler;
 			continue;
+		} else if (!strcmp(name, "if")) {
+			v->handler = if_atom_handler;
+			continue;
+		} else if (!strcmp(name, "then")) {
+			v->handler = then_atom_handler;
+			continue;
+		} else if (!strcmp(name, "else")) {
+			v->handler = else_atom_handler;
+			continue;
 		} else
 			continue;
 
diff --git a/t/t6302-for-each-ref-filter.sh b/t/t6302-for-each-ref-filter.sh
index d0ab09f..fed3013 100755
--- a/t/t6302-for-each-ref-filter.sh
+++ b/t/t6302-for-each-ref-filter.sh
@@ -327,4 +327,80 @@ test_expect_success 'reverse version sort' '
 	test_cmp expect actual
 '
 
+test_expect_success 'improper usage of %(if), %(then), %(else) and %(end) atoms' '
+	test_must_fail git for-each-ref --format="%(if)" &&
+	test_must_fail git for-each-ref --format="%(then) %(end)" &&
+	test_must_fail git for-each-ref --format="%(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(then) %(then) %(end)" &&
+	test_must_fail git for-each-ref --format="%(then) %(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(then) %(else)" &&
+	test_must_fail git for-each-ref --format="%(if) %(else) %(then) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(then) %(else) %(else) %(end)" &&
+	test_must_fail git for-each-ref --format="%(if) %(end)"
+'
+
+test_expect_success 'check %(if)...%(then)...%(end) atoms' '
+	git for-each-ref --format="%(refname)%(if)%(authorname)%(then) Author: %(authorname)%(end)" >actual &&
+	cat >expect <<-\EOF &&
+	refs/heads/master Author: A U Thor
+	refs/heads/side Author: A U Thor
+	refs/odd/spot Author: A U Thor
+	refs/tags/annotated-tag
+	refs/tags/doubly-annotated-tag
+	refs/tags/doubly-signed-tag
+	refs/tags/foo1.10 Author: A U Thor
+	refs/tags/foo1.3 Author: A U Thor
+	refs/tags/foo1.6 Author: A U Thor
+	refs/tags/four Author: A U Thor
+	refs/tags/one Author: A U Thor
+	refs/tags/signed-tag
+	refs/tags/three Author: A U Thor
+	refs/tags/two Author: A U Thor
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_success 'check %(if)...%(then)...%(else)...%(end) atoms' '
+	git for-each-ref --format="%(if)%(authorname)%(then)%(authorname)%(else)No author%(end): %(refname)" >actual &&
+	cat >expect <<-\EOF &&
+	A U Thor: refs/heads/master
+	A U Thor: refs/heads/side
+	A U Thor: refs/odd/spot
+	No author: refs/tags/annotated-tag
+	No author: refs/tags/doubly-annotated-tag
+	No author: refs/tags/doubly-signed-tag
+	A U Thor: refs/tags/foo1.10
+	A U Thor: refs/tags/foo1.3
+	A U Thor: refs/tags/foo1.6
+	A U Thor: refs/tags/four
+	A U Thor: refs/tags/one
+	No author: refs/tags/signed-tag
+	A U Thor: refs/tags/three
+	A U Thor: refs/tags/two
+	EOF
+	test_cmp expect actual
+'
+test_expect_success 'ignore spaces in %(if) atom usage' '
+	git for-each-ref --format="%(refname:short): %(if)%(HEAD)%(then)Head ref%(else)Not Head ref%(end)" >actual &&
+	cat >expect <<-\EOF &&
+	master: Head ref
+	side: Not Head ref
+	odd/spot: Not Head ref
+	annotated-tag: Not Head ref
+	doubly-annotated-tag: Not Head ref
+	doubly-signed-tag: Not Head ref
+	foo1.10: Not Head ref
+	foo1.3: Not Head ref
+	foo1.6: Not Head ref
+	four: Not Head ref
+	one: Not Head ref
+	signed-tag: Not Head ref
+	three: Not Head ref
+	two: Not Head ref
+	EOF
+	test_cmp expect actual
+'
+
 test_done
-- 
2.10.2

