Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B870C43381
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:38:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19D7922AAA
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:38:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732853AbhAYXiB (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:38:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732674AbhAYXhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:37:54 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEF9C061573
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:08 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id i9so1134344wmq.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ia1PMLHKnyJAlBeAtqma1paKnplzTJwxWYtpvsgpo0s=;
        b=lo5yhCHCVMOeTs0+fnTJ95GiOZQshDw/YTAPSlQku4Nc1kP95+BC59t3Dw7MxbiS0P
         PZyaSuPT5HTEfQWHG2XQjibNVA3DlBq/FBC2+yKvIYawYHQYmlfB1iY7pqDTQ0Z1p9h8
         lBa7kAuKWij6symco32r76ThF7hz5IgLgvdJCMyxzABeYBW4xIrNh7v0S5GfO7ofQOQy
         +GLJwQPe7c/ErbrhluhTMK4bZ3XAIMlF7r9jdVQVrTIRjcErpRN2M48yB3q8gJDIfyeT
         X1EvkxkxtbUZQbqsycv/hZOXDpGnZxiLnOEL/AZJtru63II3+hLajVTEkpp2/rZpAi1P
         RI3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Ia1PMLHKnyJAlBeAtqma1paKnplzTJwxWYtpvsgpo0s=;
        b=IdEkTUyzs3a4r6AozgYU7h6LFWwtPCXnlBcoykGYLNkCrjGq/aPSAQ1GKXhkuy8vF7
         0LulDnwH8QYIPHHWMo39o2b629vSzvAtrIelx6t1Z4Pblcl/R1QmBpAcH1fAV1Y7XPsG
         9toEKlWjW5JwAAxrSX4qyzcggYD9TlxSYiSwEg5NykuswlL/04mL1DzNz/ab74Dt7kj9
         OUO0cUIxfls6ebpnLGtlZfRaTsRlAa1FDS/TadQASHVzwwTqht6OQajiP4bNnMG6UYvV
         ThaOQBCoKw2La95T9DKcdEjavjO0CesBUbYuhV2ZQtxL/wzwUOP657ProZY4dXBYEKHZ
         LjHw==
X-Gm-Message-State: AOAM530BMpAnguiKMP4ZJfrWwEemFLtcWnk4IakPSnKHfVA8MJbhnWPF
        BIeNmf2yEazIAz/Pry8OGutte7Q15UX1Lg==
X-Google-Smtp-Source: ABdhPJxPufBU6DWyVV7mdLAsSUwXiowSLAy+P1YvATnV0bNSdmUZhrndhc0f0cnA9+rS5Mtexvi36A==
X-Received: by 2002:a1c:6484:: with SMTP id y126mr2160749wmb.45.1611617827162;
        Mon, 25 Jan 2021 15:37:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y67sm810604wmg.47.2021.01.25.15.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:06 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Michael J Gruber <git@grubix.eu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] grep/log: remove hidden --debug and --grep-debug options
Date:   Tue, 26 Jan 2021 00:36:51 +0100
Message-Id: <20210125233651.31537-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the hidden "grep --debug" and "log --grep-debug" options added
in 17bf35a3c7b (grep: teach --debug option to dump the parse tree,
2012-09-13).

At the time these options seem to have been intended to go along with
a documentation discussion and to help the author of relevant tests to
perform ad-hoc debugging on them[1].

Reasons to want this gone:

 1. They were never documented, and the only (rather trivial) use of
    them in our own codebase for testing is something I removed back
    in e01b4dab01e (grep: change non-ASCII -i test to stop using
    --debug, 2017-05-20).

 2. Googling around doesn't show any in-the-wild uses I could dig up,
    and on the Git ML the only mentions after the original discussion
    seem to have been when they came up in unrelated diff contexts, or
    that test commit of mine.

 3. An exception to that is c581e4a7499 (grep: under --debug, show
    whether PCRE JIT is enabled, 2019-08-18) where we added the
    ability to dump out when PCREv2 has the JIT in effect.

    The combination of that and my earlier b65abcafc7a (grep: use PCRE
    v2 for optimized fixed-string search, 2019-07-01) means Git prints
    this out in its most common in-the-wild configuration:

        $ git log  --grep-debug --grep=foo --grep=bar --grep=baz --all-match
        pcre2_jit_on=1
        pcre2_jit_on=1
        pcre2_jit_on=1
        [all-match]
        (or
         pattern_body<body>foo
         (or
          pattern_body<body>bar
          pattern_body<body>baz
         )
        )

        $ git grep --debug \( -e foo --and -e bar \) --or -e baz
        pcre2_jit_on=1
        pcre2_jit_on=1
        pcre2_jit_on=1
        (or
         (and
          patternfoo
          patternbar
         )
         patternbaz
        )

I.e. for each pattern we're considering for the and/or/--all-match
etc. debugging we'll now diligently spew out another identical line
saying whether the PCREv2 JIT is on or not.

I think that nobody's complained about that rather glaringly obviously
bad output says something about how much this is used, i.e. it's
not.

The need for this debugging aid for the composed grep/log patterns
seems to have passed, and the desire to dump the JIT config seems to
have been another one-off around the time we had JIT-related issues on
the PCREv2 codepath. That the original author of this debugging
facility seemingly hasn't noticed the bad output since then[2] is
probably some indicator.

1. https://lore.kernel.org/git/cover.1347615361.git.git@drmicha.warpmail.net/
2. https://lore.kernel.org/git/xmqqk1b8x0ac.fsf@gitster-ct.c.googlers.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c |   5 ---
 grep.c         | 101 +------------------------------------------------
 grep.h         |   1 -
 revision.c     |   2 -
 4 files changed, 2 insertions(+), 107 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index ca259af4416..55d06c95130 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -216,8 +216,6 @@ static void start_threads(struct grep_opt *opt)
 		int err;
 		struct grep_opt *o = grep_opt_dup(opt);
 		o->output = strbuf_out;
-		if (i)
-			o->debug = 0;
 		compile_grep_patterns(o);
 		err = pthread_create(&threads[i], NULL, run, o);
 
@@ -936,9 +934,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			   N_("indicate hit with exit status without output")),
 		OPT_BOOL(0, "all-match", &opt.all_match,
 			N_("show only matches from files that match all patterns")),
-		OPT_SET_INT_F(0, "debug", &opt.debug,
-			      N_("show parse tree for grep expression"),
-			      1, PARSE_OPT_HIDDEN),
 		OPT_GROUP(""),
 		{ OPTION_STRING, 'O', "open-files-in-pager", &show_in_pager,
 			N_("pager"), N_("show matching files in the pager"),
diff --git a/grep.c b/grep.c
index efeb6dc58db..21f0ee03be9 100644
--- a/grep.c
+++ b/grep.c
@@ -400,8 +400,6 @@ static void compile_pcre1_regexp(struct grep_pat *p, const struct grep_opt *opt)
 
 #if defined(PCRE_CONFIG_JIT) && !defined(NO_LIBPCRE1_JIT)
 	pcre_config(PCRE_CONFIG_JIT, &p->pcre1_jit_on);
-	if (opt->debug)
-		fprintf(stderr, "pcre1_jit_on=%d\n", p->pcre1_jit_on);
 
 	if (p->pcre1_jit_on)
 		study_options = PCRE_STUDY_JIT_COMPILE;
@@ -508,8 +506,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 	}
 
 	pcre2_config(PCRE2_CONFIG_JIT, &p->pcre2_jit_on);
-	if (opt->debug)
-		fprintf(stderr, "pcre2_jit_on=%d\n", p->pcre2_jit_on);
 	if (p->pcre2_jit_on) {
 		jitret = pcre2_jit_compile(p->pcre2_pattern, PCRE2_JIT_COMPLETE);
 		if (jitret)
@@ -535,9 +531,6 @@ static void compile_pcre2_pattern(struct grep_pat *p, const struct grep_opt *opt
 			BUG("pcre2_pattern_info() failed: %d", patinforet);
 		if (jitsizearg == 0) {
 			p->pcre2_jit_on = 0;
-			if (opt->debug)
-				fprintf(stderr, "pcre2_jit_on=%d: (*NO_JIT) in regex\n",
-					p->pcre2_jit_on);
 			return;
 		}
 	}
@@ -616,8 +609,6 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (opt->ignore_case)
 		regflags |= REG_ICASE;
 	err = regcomp(&p->regexp, sb.buf, regflags);
-	if (opt->debug)
-		fprintf(stderr, "fixed %s\n", sb.buf);
 	strbuf_release(&sb);
 	if (err) {
 		char errbuf[1024];
@@ -812,87 +803,6 @@ static struct grep_expr *compile_pattern_expr(struct grep_pat **list)
 	return compile_pattern_or(list);
 }
 
-static void indent(int in)
-{
-	while (in-- > 0)
-		fputc(' ', stderr);
-}
-
-static void dump_grep_pat(struct grep_pat *p)
-{
-	switch (p->token) {
-	case GREP_AND: fprintf(stderr, "*and*"); break;
-	case GREP_OPEN_PAREN: fprintf(stderr, "*(*"); break;
-	case GREP_CLOSE_PAREN: fprintf(stderr, "*)*"); break;
-	case GREP_NOT: fprintf(stderr, "*not*"); break;
-	case GREP_OR: fprintf(stderr, "*or*"); break;
-
-	case GREP_PATTERN: fprintf(stderr, "pattern"); break;
-	case GREP_PATTERN_HEAD: fprintf(stderr, "pattern_head"); break;
-	case GREP_PATTERN_BODY: fprintf(stderr, "pattern_body"); break;
-	}
-
-	switch (p->token) {
-	default: break;
-	case GREP_PATTERN_HEAD:
-		fprintf(stderr, "<head %d>", p->field); break;
-	case GREP_PATTERN_BODY:
-		fprintf(stderr, "<body>"); break;
-	}
-	switch (p->token) {
-	default: break;
-	case GREP_PATTERN_HEAD:
-	case GREP_PATTERN_BODY:
-	case GREP_PATTERN:
-		fprintf(stderr, "%.*s", (int)p->patternlen, p->pattern);
-		break;
-	}
-	fputc('\n', stderr);
-}
-
-static void dump_grep_expression_1(struct grep_expr *x, int in)
-{
-	indent(in);
-	switch (x->node) {
-	case GREP_NODE_TRUE:
-		fprintf(stderr, "true\n");
-		break;
-	case GREP_NODE_ATOM:
-		dump_grep_pat(x->u.atom);
-		break;
-	case GREP_NODE_NOT:
-		fprintf(stderr, "(not\n");
-		dump_grep_expression_1(x->u.unary, in+1);
-		indent(in);
-		fprintf(stderr, ")\n");
-		break;
-	case GREP_NODE_AND:
-		fprintf(stderr, "(and\n");
-		dump_grep_expression_1(x->u.binary.left, in+1);
-		dump_grep_expression_1(x->u.binary.right, in+1);
-		indent(in);
-		fprintf(stderr, ")\n");
-		break;
-	case GREP_NODE_OR:
-		fprintf(stderr, "(or\n");
-		dump_grep_expression_1(x->u.binary.left, in+1);
-		dump_grep_expression_1(x->u.binary.right, in+1);
-		indent(in);
-		fprintf(stderr, ")\n");
-		break;
-	}
-}
-
-static void dump_grep_expression(struct grep_opt *opt)
-{
-	struct grep_expr *x = opt->pattern_expression;
-
-	if (opt->all_match)
-		fprintf(stderr, "[all-match]\n");
-	dump_grep_expression_1(x, 0);
-	fflush(NULL);
-}
-
 static struct grep_expr *grep_true_expr(void)
 {
 	struct grep_expr *z = xcalloc(1, sizeof(*z));
@@ -973,7 +883,7 @@ static struct grep_expr *grep_splice_or(struct grep_expr *x, struct grep_expr *y
 	return z;
 }
 
-static void compile_grep_patterns_real(struct grep_opt *opt)
+void compile_grep_patterns(struct grep_opt *opt)
 {
 	struct grep_pat *p;
 	struct grep_expr *header_expr = prep_header_patterns(opt);
@@ -993,7 +903,7 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
 
 	if (opt->all_match || header_expr)
 		opt->extended = 1;
-	else if (!opt->extended && !opt->debug)
+	else if (!opt->extended)
 		return;
 
 	p = opt->pattern_list;
@@ -1016,13 +926,6 @@ static void compile_grep_patterns_real(struct grep_opt *opt)
 	opt->all_match = 1;
 }
 
-void compile_grep_patterns(struct grep_opt *opt)
-{
-	compile_grep_patterns_real(opt);
-	if (opt->debug)
-		dump_grep_expression(opt);
-}
-
 static void free_pattern_expr(struct grep_expr *x)
 {
 	switch (x->node) {
diff --git a/grep.h b/grep.h
index b5c4e223a8f..5248c6ef7ea 100644
--- a/grep.h
+++ b/grep.h
@@ -136,7 +136,6 @@ struct grep_opt {
 	int word_regexp;
 	int fixed;
 	int all_match;
-	int debug;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
 #define GREP_BINARY_TEXT	2
diff --git a/revision.c b/revision.c
index 1bb590ece78..657e5502532 100644
--- a/revision.c
+++ b/revision.c
@@ -2489,8 +2489,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 	} else if ((argcount = parse_long_opt("grep", argv, &optarg))) {
 		add_message_grep(revs, optarg);
 		return argcount;
-	} else if (!strcmp(arg, "--grep-debug")) {
-		revs->grep_filter.debug = 1;
 	} else if (!strcmp(arg, "--basic-regexp")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_BRE;
 	} else if (!strcmp(arg, "--extended-regexp") || !strcmp(arg, "-E")) {
-- 
2.29.2.222.g5d2a92d10f8

