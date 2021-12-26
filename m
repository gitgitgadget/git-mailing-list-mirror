Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E33B6C43219
	for <git@archiver.kernel.org>; Sun, 26 Dec 2021 22:37:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234770AbhLZWhh (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Dec 2021 17:37:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234767AbhLZWhd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Dec 2021 17:37:33 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94C4EC06173E
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:32 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f134-20020a1c1f8c000000b00345c05bc12dso7541857wmf.3
        for <git@vger.kernel.org>; Sun, 26 Dec 2021 14:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=K+wMw8Qxx5wh39g06x4amkOq2vdISbLAIQoKK9b5Kik=;
        b=e0gl7qXqKMyg/jGZ3KVyMpQm4mH5yaCSA6mgSh5rVMjoqK89hgOo3bNcc5ZP5Whviz
         fTnY/L2Dr8vw8ZS5+zkHqiQN6ZdctVVkcd9OJ1QJ7N5kgHSX8PJJC2tV2bzEgogHAqzY
         +fiG+jgGxWCfX2vaq5CT0k4cV9NGJoJSGTBnYqxlZQCX8z9DGEcwhqHRstI3D8Dqswnu
         3rC0qUUTkHGU2m0fb/6x7kCeULxX/dAwnRGCw3/OfoUtd/prI29he5m6oVG4TgOW8q9E
         mbJtbi3tNFCNx+tMJXNpz/JZqQd3o+qo718cN/Ue7KCir/i9F7RBiLWirZcIB+OiE5Lb
         nKjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=K+wMw8Qxx5wh39g06x4amkOq2vdISbLAIQoKK9b5Kik=;
        b=otlrxgqi3cq+5D52KaXpxZilD/agVUypLXE5+HNwIIbQxjW2M99vWqKX3tyzGRO1mU
         /q8dYZf9s7dKy0bgfT6jAErIun5oiKGhJ6Hn994eK19WtGsJ0Is5qyIma8NTj1UByCMr
         Le87PqOouycAn/QSDxRmKHdqeNo0cLr3Cei/HOkOOuZsP3busJBd10mj+7R+kL+LOkL6
         OwPAK9k2CIAoXGnMV3QdS1xn+54hCagZj2BzqonqbQY0TU0BAjoUp5t/KyjQ52DcNmPV
         wnmsOkxPldjYCiYuvPgNmf43wPAKHoF7unxsscpHn5C+SrdnvQLoV0ecMERC8FRucxCY
         URiQ==
X-Gm-Message-State: AOAM531m8cYFOGm5Xz1Tim/6vs1GSSIIZmTxyE/RN3aEsDq9LZliMu2j
        OyFFdbyyBuvKRcJmsE2EJQ1hi0N8P7WztKtD
X-Google-Smtp-Source: ABdhPJzKR7LPr2GovJafEWgnECprXm9T1WAwP0/UKJz1M+lJl2Crf1527Qttuqk4D0yTvQ4HPtRi1A==
X-Received: by 2002:a1c:1f88:: with SMTP id f130mr11357659wmf.91.1640558250876;
        Sun, 26 Dec 2021 14:37:30 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay29sm16289861wmb.13.2021.12.26.14.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Dec 2021 14:37:30 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 7/7] grep: simplify config parsing and option parsing
Date:   Sun, 26 Dec 2021 23:37:19 +0100
Message-Id: <patch-v6-7.7-88dfd40bf9e-20211226T223035Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1239.g84ae229c870
In-Reply-To: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
References: <cover-v5-0.7-00000000000-20211222T025214Z-avarab@gmail.com> <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
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

    In that context "the default" meant whatever the configuration
    system specified before that change, i.e. via grep.extendedRegexp.

 2. We'd support the existing "grep.extendedRegexp" option, but ignore
    it when the new "grep.patternType" option is set. We said we'd
    only ignore the older "grep.extendedRegexp" option "when the
    `grep.patternType` option is set. to a value other than
    'default'".

In a preceding commit we changed grep_config() to be called after
grep_init(), which means that much of the complexity here can go
away.

As before "grep.extendedRegexp" is a last-one-wins variable. We need
to maintain state inside parse_pattern_type_arg() to ignore it if a
non-"default" grep.patternType was seen, but otherwise flip between
BRE and ERE for "grep.extendedRegexp=[false|true]".

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
 builtin/grep.c | 10 +++---
 grep.c         | 83 ++++++++++++--------------------------------------
 grep.h         |  9 ++----
 revision.c     |  2 --
 4 files changed, 26 insertions(+), 78 deletions(-)

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
index 8dfa0300786..e964f402472 100644
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
@@ -61,11 +59,25 @@ int grep_config(const char *var, const char *value, void *cb)
 		return -1;
 
 	if (!strcmp(var, "grep.extendedregexp")) {
+		if (opt->extended_regexp_option == -1)
+			return 0;
 		opt->extended_regexp_option = git_config_bool(var, value);
+		if (opt->extended_regexp_option)
+			opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
+		else
+			opt->pattern_type_option = GREP_PATTERN_TYPE_BRE;
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
@@ -115,62 +127,6 @@ void grep_init(struct grep_opt *opt, struct repository *repo)
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
@@ -490,9 +446,10 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	p->fixed = opt->fixed;
+	p->fixed = opt->pattern_type_option == GREP_PATTERN_TYPE_FIXED;
 
-	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
+	if (opt->pattern_type_option != GREP_PATTERN_TYPE_PCRE &&
+	    memchr(p->pattern, 0, p->patternlen))
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
 	p->is_fixed = is_fixed(p->pattern, p->patternlen);
@@ -543,14 +500,14 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
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
index 495328e859c..298d0ea7574 100644
--- a/revision.c
+++ b/revision.c
@@ -2860,8 +2860,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	diff_setup_done(&revs->diffopt);
 
-	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
-				 &revs->grep_filter);
 	if (!is_encoding_utf8(get_log_output_encoding()))
 		revs->grep_filter.ignore_locale = 1;
 	compile_grep_patterns(&revs->grep_filter);
-- 
2.34.1.1239.g84ae229c870

