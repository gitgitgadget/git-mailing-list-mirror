Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 679A4C433F5
	for <git@archiver.kernel.org>; Tue, 11 Oct 2022 09:48:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229531AbiJKJsy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Oct 2022 05:48:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJKJsw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Oct 2022 05:48:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5130A7539B
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 02:48:50 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z97so19323168ede.8
        for <git@vger.kernel.org>; Tue, 11 Oct 2022 02:48:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hGNZgSWtm/XwslTionryFva4CotROUOLDV71YUdeuGQ=;
        b=okfWIBm5EJLoeBig3WBkM952HmasLd1kQdEZ50ltVj/aG7mlFQmiRSIxZyrtNTxf6I
         8UmHGAZUrE5JUmRUDUN1ZjBhKPjCvo80RxdalCMmVW7hXHSW6znBzj5jRV60S0hFv0fu
         GXe7oDvq0xsfOE9m9+oVqAWqdUHQV4FoYDAls+X9ZWuwb6/HMjyWqf/7e29KlLPtV8mL
         FhDSG2Vf1TGtKtyYQlY2ICtNAGAcLwbS4QsegFUdSNKFJ74HHexodQIMMd/f2PngC0NX
         Vf/S/Uiun8N1EyutF5DN4y5vf4ffdsrrrX95AmP2BhK94G0EgxJ+30lcUQVMQNvbUkVd
         aMyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hGNZgSWtm/XwslTionryFva4CotROUOLDV71YUdeuGQ=;
        b=gAEwMDeZ28JbLRJX49jUSg9op6nIQJnAS3FOCYT0RI7T7/LHC8d8V7AHYGk8ZpfY7Z
         5eExQS/KJNW9o0H1eca7vGJF44sV+wkKoXCEeGHaHDqvAOmczWT9d9UxtmXWzH+xW3ps
         9HwIcchxoPIHCZZsb7fg8hHIkdcMQKSRzXWa15L4Y8dd2uS212E+bR8AFVQd5JjUwWZC
         cM4yrRc4Bg0IDNZrgGQdm/WF1QWPHff9yGMxLy2oqLgv7Xc5fDp4GcXH8vl5zWqHFYkT
         v3gx7wGElaRp1KKpalCF1qvQpRXhfESjzGgP6U1I+w1KTNTRu2cZYDTb20SOT2dpnBUe
         67/Q==
X-Gm-Message-State: ACrzQf3BLDNHYOtHKU0BxyIR2S538QHG02TqBQWt0A1bR4+KIFXuGEam
        FNJMBwJG4KFs9FXZhVcYd/ZGfeoSNVde+w==
X-Google-Smtp-Source: AMsMyM4BTfXQ8j7h4k2JqIE3xhvJ0oUqXEyNwafCrOp7FgLac3JudESIPbzRVgOJNIDjq8dmmCedaw==
X-Received: by 2002:a05:6402:847:b0:45b:d50c:b9aa with SMTP id b7-20020a056402084700b0045bd50cb9aamr14364579edz.289.1665481728242;
        Tue, 11 Oct 2022 02:48:48 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e15-20020a50fb8f000000b00459f4974128sm8841867edq.50.2022.10.11.02.48.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 02:48:47 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, orygaw <orygaw@protonmail.com>,
        rsbecker@nexbridge.com, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2] grep.c: remove "extended" in favor of "pattern_expression", fix segfault
Date:   Tue, 11 Oct 2022 11:48:45 +0200
Message-Id: <patch-v2-1.1-6ad7627706f-20221011T094715Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.971.ge79ff6d20e7
In-Reply-To: <patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com>
References: <patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since 79d3696cfb4 (git-grep: boolean expression on pattern matching.,
2006-06-30) the "pattern_expression" member has been used for complex
queries (AND/OR...), with "pattern_list" being used for the simple OR
queries. Since then we've used both "pattern_expression" and its
associated boolean "extended" member to see if we have a complex
expression.

Since f41fb662f57 (revisions API: have release_revisions() release
"grep_filter", 2022-04-13) we've had a subtle bug relating to that: If
we supplied options that were only used for "complex queries", but
didn't supply the query itself we'd set "opt->extended", but would
have a NULL "pattern_expression". As a result these would segfault as
we tried to call "free_grep_patterns()" from "release_revisions()":

	git -P log -1 --invert-grep
	git -P log -1 --all-match

The root cause of this is that we were conflating the state management
we needed in "compile_grep_patterns()" itself with whether or not we
had an "opt->pattern_expression" later on.

In this cases as we're going through "compile_grep_patterns()" we have
no "opt->pattern_list" but have "opt->no_body_match" or
"opt->all_match". So we'd set "opt->extended = 1", but not "return" on
"opt->extended" as that's an "else if" in the same "if" statement.

That behavior is intentional and required, as the common case is that
we have an "opt->pattern_list" that we're about to parse into the
"opt->pattern_expression".

But we don't need to keep track of this "extended" flag beyond the
state management in compile_grep_patterns() itself. It needs it, but
once we're out of that function we can rely on
"opt->pattern_expression" being non-NULL instead for using these
extended patterns.

As 79d3696cfb4 itself shows we've assumed that there's a one-to-one
mapping between the two since the very beginning. I.e. "match_line()"
would check "opt->extended" to see if it should call "match_expr()",
and the first thing we do in that function is assume that we have a
"opt->pattern_expression". We'd then call "match_expr_eval()", which
would have died if that "opt->pattern_expression" was NULL.

The "die" was added in c922b01f54c (grep: fix segfault when "git grep
'('" is given, 2009-04-27), and can now be removed as it's now clearly
unreachable. We still do the right thing in the case that prompted
that fix:

	git grep '('
	fatal: unmatched parenthesis

Arguably neither the "--invert-grep" option added in [1] nor the
earlier "--all-match" option added in [2] were intended to be used
stand-alone, and another approach[3] would be to error out in those
cases. But since we've been treating them as a NOOP when given without
--grep for a long time let's keep doing that.

We could also return in "free_pattern_expr()" if the argument is
non-NULL, as an alternative fix for this segfault does [4]. That would
be more elegant in making the "free_*()" function behave like
"free()", but it would also remove a sanity check: The
"free_pattern_expr()" function calls itself recursively, and only the
top-level is allowed to be NULL, let's not conflate those two
conditions.

1. 22dfa8a23de (log: teach --invert-grep option, 2015-01-12)
2. 0ab7befa31d (grep --all-match, 2006-09-27)
3. https://lore.kernel.org/git/patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com/
4. http://lore.kernel.org/git/7e094882c2a71894416089f894557a9eae07e8f8.1665423686.git.me@ttaylorr.com

Reported-by: orygaw <orygaw@protonmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

Per the v1 feedback this v2 doesn't change any user-observable
behavior, except to address the segfault(s).

Per https://lore.kernel.org/git/Y0Rg9My2EaWl%2FWCU@nand.local/ it
sounds like Taylor's preparing his own v2 with a more narrow fix
focused on https://lore.kernel.org/git/Y0Rg9My2EaWl%2FWCU@nand.local/;
which we may or may not want to have instead of this as a quicker
band-aid.

But this attempts to address the root cause of the problem, which is
that grep.[ch] is effectively juggling two struct members that mean
the same thing, but whose state drifted apart.

Passing CI at: https://github.com/avar/git/actions/runs/3225227595
(actually https://github.com/avar/git/actions/runs/3225813488, but
when I was about to submit this I made a trivial whitespace fix in the
t/*.sh change).

Range-diff against v1:
1:  f4b90799fce ! 1:  6ad7627706f log: require --grep for --invert-grep and --all-match, fix segfault
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    log: require --grep for --invert-grep and --all-match, fix segfault
    +    grep.c: remove "extended" in favor of "pattern_expression", fix segfault
     
    -    Neither the "--invert-grep" option added in [1] nor the earlier
    -    "--all-match" option added in [2] were intended to be used
    -    stand-alone.
    +    Since 79d3696cfb4 (git-grep: boolean expression on pattern matching.,
    +    2006-06-30) the "pattern_expression" member has been used for complex
    +    queries (AND/OR...), with "pattern_list" being used for the simple OR
    +    queries. Since then we've used both "pattern_expression" and its
    +    associated boolean "extended" member to see if we have a complex
    +    expression.
     
    -    But due to how the built-in and the revision API interacted those
    -    options without the corresponding --grep would be ignored.
    +    Since f41fb662f57 (revisions API: have release_revisions() release
    +    "grep_filter", 2022-04-13) we've had a subtle bug relating to that: If
    +    we supplied options that were only used for "complex queries", but
    +    didn't supply the query itself we'd set "opt->extended", but would
    +    have a NULL "pattern_expression". As a result these would segfault as
    +    we tried to call "free_grep_patterns()" from "release_revisions()":
     
    -    Then in f41fb662f57 (revisions API: have release_revisions() release
    -    "grep_filter", 2022-04-13) this turned into a segfault, as we'd
    -    attempt to free() the non-existing --grep patterns.
    +            git -P log -1 --invert-grep
    +            git -P log -1 --all-match
     
    -    Arguably it makes more sense to add this check to
    -    compile_grep_patterns(), since it's possible to use the C API in the
    -    same way and trigger this segfault. But in practice the revision.c API
    -    is the only user of "no_body_match", and by placing the check here we
    -    can more sensibly emit a message that assumes that the user used
    -    "--invert-grep" without "--grep".
    +    The root cause of this is that we were conflating the state management
    +    we needed in "compile_grep_patterns()" itself with whether or not we
    +    had an "opt->pattern_expression" later on.
    +
    +    In this cases as we're going through "compile_grep_patterns()" we have
    +    no "opt->pattern_list" but have "opt->no_body_match" or
    +    "opt->all_match". So we'd set "opt->extended = 1", but not "return" on
    +    "opt->extended" as that's an "else if" in the same "if" statement.
    +
    +    That behavior is intentional and required, as the common case is that
    +    we have an "opt->pattern_list" that we're about to parse into the
    +    "opt->pattern_expression".
    +
    +    But we don't need to keep track of this "extended" flag beyond the
    +    state management in compile_grep_patterns() itself. It needs it, but
    +    once we're out of that function we can rely on
    +    "opt->pattern_expression" being non-NULL instead for using these
    +    extended patterns.
    +
    +    As 79d3696cfb4 itself shows we've assumed that there's a one-to-one
    +    mapping between the two since the very beginning. I.e. "match_line()"
    +    would check "opt->extended" to see if it should call "match_expr()",
    +    and the first thing we do in that function is assume that we have a
    +    "opt->pattern_expression". We'd then call "match_expr_eval()", which
    +    would have died if that "opt->pattern_expression" was NULL.
    +
    +    The "die" was added in c922b01f54c (grep: fix segfault when "git grep
    +    '('" is given, 2009-04-27), and can now be removed as it's now clearly
    +    unreachable. We still do the right thing in the case that prompted
    +    that fix:
    +
    +            git grep '('
    +            fatal: unmatched parenthesis
    +
    +    Arguably neither the "--invert-grep" option added in [1] nor the
    +    earlier "--all-match" option added in [2] were intended to be used
    +    stand-alone, and another approach[3] would be to error out in those
    +    cases. But since we've been treating them as a NOOP when given without
    +    --grep for a long time let's keep doing that.
    +
    +    We could also return in "free_pattern_expr()" if the argument is
    +    non-NULL, as an alternative fix for this segfault does [4]. That would
    +    be more elegant in making the "free_*()" function behave like
    +    "free()", but it would also remove a sanity check: The
    +    "free_pattern_expr()" function calls itself recursively, and only the
    +    top-level is allowed to be NULL, let's not conflate those two
    +    conditions.
     
         1. 22dfa8a23de (log: teach --invert-grep option, 2015-01-12)
         2. 0ab7befa31d (grep --all-match, 2006-09-27)
    +    3. https://lore.kernel.org/git/patch-1.1-f4b90799fce-20221010T165711Z-avarab@gmail.com/
    +    4. http://lore.kernel.org/git/7e094882c2a71894416089f894557a9eae07e8f8.1665423686.git.me@ttaylorr.com
     
         Reported-by: orygaw <orygaw@protonmail.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## revision.c ##
    -@@ revision.c: int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
    - 		die(_("options '%s' and '%s' cannot be used together"), "--no-walk", "--graph");
    - 	if (!revs->reflog_info && revs->grep_filter.use_reflog_filter)
    - 		die(_("the option '%s' requires '%s'"), "--grep-reflog", "--walk-reflogs");
    -+	if (!revs->grep_filter.pattern_expression) {
    -+		if (revs->grep_filter.no_body_match)
    -+			die(_("the option '%s' requires '%s'"), "--invert-grep", "--grep");
    -+		if (revs->grep_filter.all_match)
    -+			die(_("the option '%s' requires '%s'"), "--all-match", "--grep");
    -+	}
    + ## grep.c ##
    +@@ grep.c: void compile_grep_patterns(struct grep_opt *opt)
    + {
    + 	struct grep_pat *p;
    + 	struct grep_expr *header_expr = prep_header_patterns(opt);
    ++	int extended = 0;
    + 
    + 	for (p = opt->pattern_list; p; p = p->next) {
    + 		switch (p->token) {
    +@@ grep.c: void compile_grep_patterns(struct grep_opt *opt)
    + 			compile_regexp(p, opt);
    + 			break;
    + 		default:
    +-			opt->extended = 1;
    ++			extended = 1;
    + 			break;
    + 		}
    + 	}
    + 
    + 	if (opt->all_match || opt->no_body_match || header_expr)
    +-		opt->extended = 1;
    +-	else if (!opt->extended)
    ++		extended = 1;
    ++	else if (!extended)
    + 		return;
    + 
    + 	p = opt->pattern_list;
    +@@ grep.c: void free_grep_patterns(struct grep_opt *opt)
    + 		free(p);
    + 	}
      
    - 	if (revs->line_level_traverse &&
    - 	    (revs->diffopt.output_format & ~(DIFF_FORMAT_PATCH | DIFF_FORMAT_NO_OUTPUT)))
    +-	if (!opt->extended)
    ++	if (!opt->pattern_expression)
    + 		return;
    + 	free_pattern_expr(opt->pattern_expression);
    + }
    +@@ grep.c: static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x,
    + {
    + 	int h = 0;
    + 
    +-	if (!x)
    +-		die("Not a valid grep expression");
    + 	switch (x->node) {
    + 	case GREP_NODE_TRUE:
    + 		h = 1;
    +@@ grep.c: static int match_line(struct grep_opt *opt,
    + 	struct grep_pat *p;
    + 	int hit = 0;
    + 
    +-	if (opt->extended)
    ++	if (opt->pattern_expression)
    + 		return match_expr(opt, bol, eol, ctx, col, icol,
    + 				  collect_hits);
    + 
    +@@ grep.c: static int should_lookahead(struct grep_opt *opt)
    + {
    + 	struct grep_pat *p;
    + 
    +-	if (opt->extended)
    ++	if (opt->pattern_expression)
    + 		return 0; /* punt for too complex stuff */
    + 	if (opt->invert)
    + 		return 0;
    +
    + ## grep.h ##
    +@@ grep.h: struct grep_opt {
    + #define GREP_BINARY_TEXT	2
    + 	int binary;
    + 	int allow_textconv;
    +-	int extended;
    + 	int use_reflog_filter;
    + 	int relative;
    + 	int pathname;
     
      ## t/t4202-log.sh ##
     @@ t/t4202-log.sh: test_expect_success 'log --grep' '
      	test_cmp expect actual
      '
      
    -+test_expect_success 'log --invert-grep usage' '
    -+	test_expect_code 128 git log --invert-grep
    -+'
    ++for noop_opt in --invert-grep --all-match
    ++do
    ++	test_expect_success "log $noop_opt without --grep is a NOOP" '
    ++		git log >expect &&
    ++		git log $noop_opt >actual &&
    ++		test_cmp expect actual
    ++	'
    ++done
     +
      cat > expect << EOF
      second
      initial
    -
    - ## t/t7810-grep.sh ##
    -@@ t/t7810-grep.sh: test_expect_success 'log with multiple --grep uses union' '
    - 	test_cmp expect actual
    - '
    - 
    -+test_expect_success 'log --all-match usage' '
    -+	test_expect_code 128 git log --all-match
    -+'
    -+
    - test_expect_success 'log --all-match with multiple --grep uses intersection' '
    - 	git log --all-match --grep=i --grep=r --format=%s >actual &&
    - 	{

 grep.c         | 15 +++++++--------
 grep.h         |  1 -
 t/t4202-log.sh |  9 +++++++++
 3 files changed, 16 insertions(+), 9 deletions(-)

diff --git a/grep.c b/grep.c
index 52a894c9890..06eed694936 100644
--- a/grep.c
+++ b/grep.c
@@ -708,6 +708,7 @@ void compile_grep_patterns(struct grep_opt *opt)
 {
 	struct grep_pat *p;
 	struct grep_expr *header_expr = prep_header_patterns(opt);
+	int extended = 0;
 
 	for (p = opt->pattern_list; p; p = p->next) {
 		switch (p->token) {
@@ -717,14 +718,14 @@ void compile_grep_patterns(struct grep_opt *opt)
 			compile_regexp(p, opt);
 			break;
 		default:
-			opt->extended = 1;
+			extended = 1;
 			break;
 		}
 	}
 
 	if (opt->all_match || opt->no_body_match || header_expr)
-		opt->extended = 1;
-	else if (!opt->extended)
+		extended = 1;
+	else if (!extended)
 		return;
 
 	p = opt->pattern_list;
@@ -790,7 +791,7 @@ void free_grep_patterns(struct grep_opt *opt)
 		free(p);
 	}
 
-	if (!opt->extended)
+	if (!opt->pattern_expression)
 		return;
 	free_pattern_expr(opt->pattern_expression);
 }
@@ -971,8 +972,6 @@ static int match_expr_eval(struct grep_opt *opt, struct grep_expr *x,
 {
 	int h = 0;
 
-	if (!x)
-		die("Not a valid grep expression");
 	switch (x->node) {
 	case GREP_NODE_TRUE:
 		h = 1;
@@ -1052,7 +1051,7 @@ static int match_line(struct grep_opt *opt,
 	struct grep_pat *p;
 	int hit = 0;
 
-	if (opt->extended)
+	if (opt->pattern_expression)
 		return match_expr(opt, bol, eol, ctx, col, icol,
 				  collect_hits);
 
@@ -1370,7 +1369,7 @@ static int should_lookahead(struct grep_opt *opt)
 {
 	struct grep_pat *p;
 
-	if (opt->extended)
+	if (opt->pattern_expression)
 		return 0; /* punt for too complex stuff */
 	if (opt->invert)
 		return 0;
diff --git a/grep.h b/grep.h
index bdcadce61b8..6075f997e68 100644
--- a/grep.h
+++ b/grep.h
@@ -151,7 +151,6 @@ struct grep_opt {
 #define GREP_BINARY_TEXT	2
 	int binary;
 	int allow_textconv;
-	int extended;
 	int use_reflog_filter;
 	int relative;
 	int pathname;
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index cc15cb4ff62..2ce2b41174d 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -249,6 +249,15 @@ test_expect_success 'log --grep' '
 	test_cmp expect actual
 '
 
+for noop_opt in --invert-grep --all-match
+do
+	test_expect_success "log $noop_opt without --grep is a NOOP" '
+		git log >expect &&
+		git log $noop_opt >actual &&
+		test_cmp expect actual
+	'
+done
+
 cat > expect << EOF
 second
 initial
-- 
2.38.0.971.ge79ff6d20e7

