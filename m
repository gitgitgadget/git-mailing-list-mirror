Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B143C4332F
	for <git@archiver.kernel.org>; Mon, 29 Nov 2021 18:28:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348031AbhK2Sbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Nov 2021 13:31:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238087AbhK2S3g (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Nov 2021 13:29:36 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDA5C12B689
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:51:04 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id o19-20020a1c7513000000b0033a93202467so12616387wmc.2
        for <git@vger.kernel.org>; Mon, 29 Nov 2021 06:51:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xQ4LA7xdlyiw+yzqOobBPxz1K3Bkmb5LglWgE065zr4=;
        b=qUhe3Bkx09YbpyAz5BwdDujPKjMYcFPENcyFXKzqn/rQ7qx5pz4dwh46FeObaUUEo1
         LRHDxeqkUeADIiVW8BJwC9Gan6oM+4RsKKCk8zKecSg0xvsz+2oawzHWGNm123I42u1k
         Yep6wTYuh+PDsXEkXJ3cvJoHHEyi01stGMU7M0Bvbf79WWYnLSl0OF1nhqtGptjhRA5f
         VgUqyoVynFYWA4Prkt5dZ175KuWijIGlSdzQUsidgI9ak+//7ztPGureXGAiSZuLwaRC
         T/NIJ/byFINb5D6JVyc1wjDERVrghlvZs7tq6z++lADyTFmMNWxqMhnjUbianS3UDsro
         wroQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xQ4LA7xdlyiw+yzqOobBPxz1K3Bkmb5LglWgE065zr4=;
        b=b5iJqKB1eEeLCj0D2NJ8XXMx0c0r3sMJNCF30SoEqu3bI7/X0Yxui97em0QXXJBMsx
         vrha7Tc9sI7AYnVQsdw/7G7OvpsZOwl53Zx2xmYM6RB51YikDX4ny6L7kGcq5HRGy8Og
         iF9taHohMg//i72S3tNlndIqYOxtaOGQVmSrk2Dah436vtdnCqv6YDY72j+232Xv/Wfr
         V/GJ3mrSN6fSNJmRwTyhIs1CIatz4s90CwXMn9Q3c776hw0OFPunYvT1OYo1mXM/bgTA
         bZIuAKAojSpXyLCEiPalrGNMunXjOGnBg6VxkgCfcfq7VUl8tDgVTf6ViVKo4CMKmvy2
         W32w==
X-Gm-Message-State: AOAM532D7cwcRQL7JpXCIsijOfJb54i3KljfIxsA8x6aFg2EhveiQfFc
        CAUj0RgMeCaYXryWTKqqaEOV94VvrY2C1w==
X-Google-Smtp-Source: ABdhPJxDRQ2Isqs4mO+yFkmMz+t9oXxmFuCH/DDZr+n4kfzpngXqtjb1dvPZxFDtNesqbpu3tG5l0Q==
X-Received: by 2002:a05:600c:3586:: with SMTP id p6mr37282672wmq.34.1638197462958;
        Mon, 29 Nov 2021 06:51:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b11sm19579946wmj.35.2021.11.29.06.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Nov 2021 06:51:02 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 7/7] grep: simplify config parsing and option parsing
Date:   Mon, 29 Nov 2021 15:50:53 +0100
Message-Id: <patch-v3-7.7-f40ab932cb1-20211129T143956Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.841.gf15fb7e6f34
In-Reply-To: <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
References: <cover-v2-0.8-00000000000-20211110T013632Z-avarab@gmail.com> <cover-v3-0.7-00000000000-20211129T143956Z-avarab@gmail.com>
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
2.34.1.841.gf15fb7e6f34

