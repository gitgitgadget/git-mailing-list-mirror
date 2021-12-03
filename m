Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9290FC433EF
	for <git@archiver.kernel.org>; Fri,  3 Dec 2021 10:20:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379861AbhLCKXy (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Dec 2021 05:23:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379849AbhLCKXo (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Dec 2021 05:23:44 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 148D9C06175B
        for <git@vger.kernel.org>; Fri,  3 Dec 2021 02:20:15 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id d24so4795312wra.0
        for <git@vger.kernel.org>; Fri, 03 Dec 2021 02:20:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bugnlNEMlH9NB+u6AMjYl2hMQxzz2SFjcy54lLTBNnA=;
        b=KIhyLU2YrlM5O/DGnd882LqqGTSQcIe66iYp+Jqw+1Xuc/AMyorDUdPhQl1ti8e5pt
         tQfb/qrJG/jqydIf8z3Bt7St2iA28wwp1iJurPK8kMKX6wroF2YFGpN/aRSaIVZo+you
         Gd3/PHKBWLZGvniPBAqZ2nhJSoe7YACAtPFiVuSp5DDDZP2kgszph2mdmg69UxSQxaeb
         esk8HVERjXj7BINoHxWHhpqcmDU4cLCj3vFH+YBfTVjABj8H/shVuV8UpsDlvK9zxr7E
         Q1J8dZC1Wm1Xrqn2Tk13sNk0AQX33UMoJWc0hrMbwxe1NSk5d6gbV9J5o1Wuc5+i4oQ5
         nZXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bugnlNEMlH9NB+u6AMjYl2hMQxzz2SFjcy54lLTBNnA=;
        b=d9eIlIMadrQaTh9PXUWsHR8ARo1lYIRODJz9BUX3F4pkVznscDBYEANQn9UOF89jAD
         jlDqMpw39ptqCM0D1F+UtbDbYiRbDCT9o4zfXxSuXj3fOuz5F3aGt2iIUKoQAkDp5DDi
         p2SBhmO60Wtaawj+h5GEd2Tw3BewbnNwhAmnerZSLo8QeNilXKLiteWcI6V/5ppgv6wP
         C4DGvmc5PQ/NA+faFfSLtiq7fJYsrO8yXSNnwlrpJ8p2hj8DW8Hy/b96Y6HF3FNoq2mm
         aTFtD/2I7sXyenYbCeyela6h9gBWrzgiVz+hiNjEE6vrY+92LVka3pQKhqGejQOqIumq
         Xt/A==
X-Gm-Message-State: AOAM533CSBiSpN7YXsHY3948+x6jxlinKNkR1PBJpHwdc5gcTReeswc8
        oTIZGrva5Jmr2sXpk1yD6cOUOynATD1EOw==
X-Google-Smtp-Source: ABdhPJyG4SgtPvUSPQiPEre/eg+LO8nfQFzyZO45MdvGOzpDzFuvISu1s5t0brVqO7qP9oT0mwJjGw==
X-Received: by 2002:adf:e484:: with SMTP id i4mr21241234wrm.49.1638526813346;
        Fri, 03 Dec 2021 02:20:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r8sm2798448wrz.43.2021.12.03.02.20.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Dec 2021 02:20:12 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 7/7] grep: simplify config parsing and option parsing
Date:   Fri,  3 Dec 2021 11:19:54 +0100
Message-Id: <patch-v4-7.7-efbd1c50b43-20211203T101348Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.875.gb925cffed1e
In-Reply-To: <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v4-0.7-00000000000-20211203T101348Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Simplify the parsing of "grep.patternType" and
"grep.extendedRegexp". This changes no behavior, but gets rid of
complex parsing logic that isn't needed anymore.

When "grep.patternType" was introduced in 84befcd0a4a (grep: add a
grep.patternType configuration setting, 2012-08-03) we promised that:

 1. You can set "grep.patternType", and "[setting it to] 'default'
    will return to the default matching behavior".

 2. We'd support the existing "grep.extendedRegexp" option, but ignore
    it when the new "grep.patternType" option is set. We said we'd
    only ignore the older "grep.extendedRegexp" option "when the
    `grep.patternType` option is set. to a value other than
    'default'".

In a preceding commit we changed grep_config() to be called after
grep_init(), which means that much of the complexity here can go
away.

Now as before when we only understand a "grep.extendedRegexp" setting
of "true", and if "grep.patterntype=default" is set we'll interpret it
as "grep.patterntype=basic", except if we previously saw a
"grep.extendedRegexp", then it's interpreted as
"grep.patterntype=extended".

See my 07a3d411739 (grep: remove regflags from the public grep_opt
API, 2017-06-29) for addition of the two comments being removed here,
i.e. the complexity noted in that commit is now going away.

We don't need grep_commit_pattern_type() anymore, we can instead have
OPT_SET_INT() in "builtin/grep.c" manipulate the "pattern_type_option"
member in "struct grep_opt" directly.

We can also do away with the indirection of the "int fixed" and "int
pcre2" members in favor of using "pattern_type_option" directly in
"grep.c".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 10 +++----
 grep.c         | 81 +++++++++++---------------------------------------
 grep.h         |  9 ++----
 revision.c     |  2 --
 4 files changed, 24 insertions(+), 78 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 0ea124321b6..942c4b25077 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -845,7 +845,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int i;
 	int dummy;
 	int use_index = 1;
-	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 	int allow_revs;
 
 	struct option options[] = {
@@ -879,16 +878,16 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 			N_("descend at most <depth> levels"), PARSE_OPT_NONEG,
 			NULL, 1 },
 		OPT_GROUP(""),
-		OPT_SET_INT('E', "extended-regexp", &pattern_type_arg,
+		OPT_SET_INT('E', "extended-regexp", &opt.pattern_type_option,
 			    N_("use extended POSIX regular expressions"),
 			    GREP_PATTERN_TYPE_ERE),
-		OPT_SET_INT('G', "basic-regexp", &pattern_type_arg,
+		OPT_SET_INT('G', "basic-regexp", &opt.pattern_type_option,
 			    N_("use basic POSIX regular expressions (default)"),
 			    GREP_PATTERN_TYPE_BRE),
-		OPT_SET_INT('F', "fixed-strings", &pattern_type_arg,
+		OPT_SET_INT('F', "fixed-strings", &opt.pattern_type_option,
 			    N_("interpret patterns as fixed strings"),
 			    GREP_PATTERN_TYPE_FIXED),
-		OPT_SET_INT('P', "perl-regexp", &pattern_type_arg,
+		OPT_SET_INT('P', "perl-regexp", &opt.pattern_type_option,
 			    N_("use Perl-compatible regular expressions"),
 			    GREP_PATTERN_TYPE_PCRE),
 		OPT_GROUP(""),
@@ -982,7 +981,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, grep_usage,
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	grep_commit_pattern_type(pattern_type_arg, &opt);
 
 	if (use_index && !startup_info->have_repository) {
 		int fallback = 0;
diff --git a/grep.c b/grep.c
index 8dfa0300786..b5342064066 100644
--- a/grep.c
+++ b/grep.c
@@ -33,9 +33,7 @@ static const char *color_grep_slots[] = {
 
 static int parse_pattern_type_arg(const char *opt, const char *arg)
 {
-	if (!strcmp(arg, "default"))
-		return GREP_PATTERN_TYPE_UNSPECIFIED;
-	else if (!strcmp(arg, "basic"))
+	if (!strcmp(arg, "basic"))
 		return GREP_PATTERN_TYPE_BRE;
 	else if (!strcmp(arg, "extended"))
 		return GREP_PATTERN_TYPE_ERE;
@@ -61,11 +59,23 @@ int grep_config(const char *var, const char *value, void *cb)
 		return -1;
 
 	if (!strcmp(var, "grep.extendedregexp")) {
+		if (opt->extended_regexp_option)
+			return 0;
 		opt->extended_regexp_option = git_config_bool(var, value);
+		if (opt->extended_regexp_option)
+			opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
+		return 0;
+	}
+
+	if (!strcmp(var, "grep.patterntype") &&
+	    !strcmp(value, "default")) {
+		opt->pattern_type_option = opt->extended_regexp_option == 1
+			? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
 		return 0;
 	}
 
 	if (!strcmp(var, "grep.patterntype")) {
+		opt->extended_regexp_option = -1; /* ignore */
 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
 		return 0;
 	}
@@ -115,62 +125,6 @@ void grep_init(struct grep_opt *opt, struct repository *repo)
 	opt->header_tail = &opt->header_list;
 }
 
-static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
-{
-	/*
-	 * When committing to the pattern type by setting the relevant
-	 * fields in grep_opt it's generally not necessary to zero out
-	 * the fields we're not choosing, since they won't have been
-	 * set by anything. The extended_regexp_option field is the
-	 * only exception to this.
-	 *
-	 * This is because in the process of parsing grep.patternType
-	 * & grep.extendedRegexp we set opt->pattern_type_option and
-	 * opt->extended_regexp_option, respectively. We then
-	 * internally use opt->extended_regexp_option to see if we're
-	 * compiling an ERE. It must be unset if that's not actually
-	 * the case.
-	 */
-	if (pattern_type != GREP_PATTERN_TYPE_ERE &&
-	    opt->extended_regexp_option)
-		opt->extended_regexp_option = 0;
-
-	switch (pattern_type) {
-	case GREP_PATTERN_TYPE_UNSPECIFIED:
-		/* fall through */
-
-	case GREP_PATTERN_TYPE_BRE:
-		break;
-
-	case GREP_PATTERN_TYPE_ERE:
-		opt->extended_regexp_option = 1;
-		break;
-
-	case GREP_PATTERN_TYPE_FIXED:
-		opt->fixed = 1;
-		break;
-
-	case GREP_PATTERN_TYPE_PCRE:
-		opt->pcre2 = 1;
-		break;
-	}
-}
-
-void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_opt *opt)
-{
-	if (pattern_type != GREP_PATTERN_TYPE_UNSPECIFIED)
-		grep_set_pattern_type_option(pattern_type, opt);
-	else if (opt->pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
-		grep_set_pattern_type_option(opt->pattern_type_option, opt);
-	else if (opt->extended_regexp_option)
-		/*
-		 * This branch *must* happen after setting from the
-		 * opt->pattern_type_option above, we don't want
-		 * grep.extendedRegexp to override grep.patternType!
-		 */
-		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);
-}
-
 static struct grep_pat *create_grep_pat(const char *pat, size_t patlen,
 					const char *origin, int no,
 					enum grep_pat_token t,
@@ -490,9 +444,10 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	p->fixed = opt->fixed;
+	p->fixed = opt->pattern_type_option == GREP_PATTERN_TYPE_FIXED;
 
-	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
+	if (opt->pattern_type_option != GREP_PATTERN_TYPE_PCRE &&
+	    memchr(p->pattern, 0, p->patternlen))
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
 	p->is_fixed = is_fixed(p->pattern, p->patternlen);
@@ -543,14 +498,14 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
-	if (opt->pcre2) {
+	if (opt->pattern_type_option == GREP_PATTERN_TYPE_PCRE) {
 		compile_pcre2_pattern(p, opt);
 		return;
 	}
 
 	if (p->ignore_case)
 		regflags |= REG_ICASE;
-	if (opt->extended_regexp_option)
+	if (opt->pattern_type_option == GREP_PATTERN_TYPE_ERE)
 		regflags |= REG_EXTENDED;
 	err = regcomp(&p->regexp, p->pattern, regflags);
 	if (err) {
diff --git a/grep.h b/grep.h
index b651eb291f7..ab2ce833b40 100644
--- a/grep.h
+++ b/grep.h
@@ -94,8 +94,7 @@ enum grep_expr_node {
 };
 
 enum grep_pattern_type {
-	GREP_PATTERN_TYPE_UNSPECIFIED = 0,
-	GREP_PATTERN_TYPE_BRE,
+	GREP_PATTERN_TYPE_BRE = 0,
 	GREP_PATTERN_TYPE_ERE,
 	GREP_PATTERN_TYPE_FIXED,
 	GREP_PATTERN_TYPE_PCRE
@@ -143,7 +142,6 @@ struct grep_opt {
 	int unmatch_name_only;
 	int count;
 	int word_regexp;
-	int fixed;
 	int all_match;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
@@ -152,7 +150,6 @@ struct grep_opt {
 	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
-	int pcre2;
 	int relative;
 	int pathname;
 	int null_following_name;
@@ -162,7 +159,7 @@ struct grep_opt {
 	int funcname;
 	int funcbody;
 	int extended_regexp_option;
-	int pattern_type_option;
+	enum grep_pattern_type pattern_type_option;
 	int ignore_locale;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
@@ -181,7 +178,6 @@ struct grep_opt {
 	.relative = 1, \
 	.pathname = 1, \
 	.max_depth = -1, \
-	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
 	.colors = { \
 		[GREP_COLOR_CONTEXT] = "", \
 		[GREP_COLOR_FILENAME] = "", \
@@ -200,7 +196,6 @@ struct grep_opt {
 
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo);
-void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
 void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
diff --git a/revision.c b/revision.c
index a82e31df869..d08c7ae6c35 100644
--- a/revision.c
+++ b/revision.c
@@ -2855,8 +2855,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	diff_setup_done(&revs->diffopt);
 
-	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
-				 &revs->grep_filter);
 	if (!is_encoding_utf8(get_log_output_encoding()))
 		revs->grep_filter.ignore_locale = 1;
 	compile_grep_patterns(&revs->grep_filter);
-- 
2.34.1.875.gb925cffed1e

