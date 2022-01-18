Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 390A2C433FE
	for <git@archiver.kernel.org>; Tue, 18 Jan 2022 15:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346159AbiARPzr (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Jan 2022 10:55:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346152AbiARPzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Jan 2022 10:55:42 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DEAC06173E
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:39 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso6938116wmj.2
        for <git@vger.kernel.org>; Tue, 18 Jan 2022 07:55:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fCZPOrkHqLyNI93iHC3spYA3L+KtLSTyfugjQrFwGao=;
        b=K0jOSl/TLN4nsPGMRkHrbXao2clFCP718HXavYocqFxI3zTJsk4j6Q2nTBw+TlXECK
         Njv3Pi0VztcSqY7bcD9cF+YVeoXe2matqDTIRunQlkWbFZeFvqLkBayZJGBscgp1Xmvb
         8IP9Pjej0rNbKM0tvoD89oOIcrJzH4zekGF5GSAM3sobCP4hpkWsiuUrsiCRXG/n49T/
         vXGzqUGzR4CYOpPa2lawkgvDLGecsBynbbo8PVPlZWdljsnLv50xC3KjFT7Cgg3BcSRW
         Lc/cJmjCyxyfb802yCYT0BSVga/a9YoSDNtxubbOuu6BW0u6ex6rqzqD1TJxkSsHYhZ7
         OdUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fCZPOrkHqLyNI93iHC3spYA3L+KtLSTyfugjQrFwGao=;
        b=7+kHmpSSUFZcES5nApuKbJfujZMbzeATGEu6mY6tjhLQlybRutAw4k3z02f2zFtMIX
         wCEwVtGsMyAi5rqmYkxP0Yr8ThnqTzUBeuEw1P38HBbtseTJNwf1Y2bVSHs36cbQzNUL
         aJyCO1j9yh3iuQXMVWuOXfvSMuFy9zxNS5OzVsiQhtSLis2f5gVPFqk9KmAfjiVFI9yE
         jISakcHYhxRKrdo9L0Ne9N6sIvBeU4u1rxMZ4ulhc2b8BOOcgMUqYP8bPRTc7gm8kbsw
         UWp65LN8HIhkC/ibrdflU0uIQvgARccELrFWHhscQmYAFzy4xoZYf5N4fmR5ZnnTZsoJ
         BVzA==
X-Gm-Message-State: AOAM533ejO32oC8TwzRXE7M3BFDTccuRG4/W5m4y30L/EsR3VrVuEumx
        WbbXoVbzTYSnlzNLLQ3lbwUSP3oEA+O2ZA==
X-Google-Smtp-Source: ABdhPJwMzkWAWdIXVM5J2WnjTD2m7IyzI+ZVquea9P6VaPwoIZnUBWKD06zwbPmGMiWoaxHSHD5PPA==
X-Received: by 2002:a7b:cb88:: with SMTP id m8mr23373356wmi.64.1642521337664;
        Tue, 18 Jan 2022 07:55:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f15sm1220522wrd.45.2022.01.18.07.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Jan 2022 07:55:37 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 09/10] grep: simplify config parsing and option parsing
Date:   Tue, 18 Jan 2022 16:55:21 +0100
Message-Id: <patch-v8-09.10-c211bb0c69d-20220118T155211Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc1.864.g57621b115b6
In-Reply-To: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
References: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com> <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com>
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

As before both "grep.patternType" and "grep.extendedRegexp" are
last-one-wins variable, with "grep.extendedRegexp" yielding to
"grep.patternType", except when "grep.patternType=default".

Note that this applies as we parse the config, i.e. a sequence of:

    -c grep.patternType=perl
    -c grep.extendedRegexp=true \
    -c grep.patternType=default

Should select ERE due to "grep.extendedRegexp=true and
grep.extendedRegexp=default", not BRE, even though that's the
"default" patternType. We can determine this as we parse the config,
because:

 * If we see "grep.extendedRegexp" we set the internal "ero" to its
   boolean value.

 * If we see "grep.extendedRegexp" but
   "grep.patternType=[default|<unset>]" is in effect we *don't* set
   the internal "pattern_type_option" to update the pattern type.

 * If we see "grep.patternType!=default" we can set our internal
   "pattern_type_option" directly, it doesn't matter what the state of
   "grep.extendedRegexp" is, but we don't forget what it was, in case
   we see a "grep.patternType=default" again.

 * If we see a "grep.patternType=default" we can set the pattern to
   ERE or BRE depending on whether we last saw a
   "grep.extendedRegexp=true" or
   "grep.extendedRegexp=[false|<unset>]".

We could equally call this new adjust_pattern_type() in
compile_regexp(), i.e. this fixup on top of this passes all our
tests (with -U0 for brevity):

    @@ -60,0 +61 @@ static void adjust_pattern_type(enum grep_pattern_type *pto, const int ero)
    +static int ero = -1;
    @@ -65 +65,0 @@ int grep_config(const char *var, const char *value, void *cb)
    -       static int ero = -1;
    @@ -72 +71,0 @@ int grep_config(const char *var, const char *value, void *cb)
    -               adjust_pattern_type(&opt->pattern_type_option, ero);
    @@ -80 +78,0 @@ int grep_config(const char *var, const char *value, void *cb)
    -               adjust_pattern_type(&opt->pattern_type_option, ero);
    @@ -445,0 +444,2 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
    +       if (ero != -1)
    +               adjust_pattern_type(&opt->pattern_type_option, ero);

But doing it as we stream the git_config() makes it
clear that we can determine the interplay between these two variables
as we go. We don't need to wait until we see the last value of the two
configuration variables.

This is true because of the rationale above, and because the
subsequent code in compile_regexp() treats
"pattern_type_option=GREP_PATTERN_TYPE_{UNSPECIFIED,BRE}"
equally. I.e. we'll end up with different internal
""pattern_type_option" values there for:

    # UNSPECIFIED
    -c grep.patternType=default
    # BRE
    -c grep.extendedRegexp=false -c grep.patternType=default

But the difference won't matter, which simplifies some of this logic,
we never need to adjust a "grep.patternType" if we didn't see a
"grep.extendedRegexp" before. We can also remove the
"extended_regexp_option" member from "struct grep_opt" in favor of a
static variable in grep_config().

The command-line parsing in cmd_grep() can then completely ignore
"grep.extendedRegexp". Whatever effect it had before that step won't
matter if we see -G, -E, -P etc.

See my 07a3d411739 (grep: remove regflags from the public grep_opt
API, 2017-06-29) for addition of the two comments being removed here,
i.e. the complexity noted in that commit is now going away.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 10 +++----
 grep.c         | 77 +++++++++++---------------------------------------
 grep.h         |  4 ---
 revision.c     |  2 --
 4 files changed, 20 insertions(+), 73 deletions(-)

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
index 60228a95a4f..bb487e994d0 100644
--- a/grep.c
+++ b/grep.c
@@ -48,6 +48,12 @@ static int parse_pattern_type_arg(const char *opt, const char *arg)
 
 define_list_config_array_extra(color_grep_slots, {"match"});
 
+static void adjust_pattern_type(enum grep_pattern_type *pto, const int ero)
+{
+	if (*pto == GREP_PATTERN_TYPE_UNSPECIFIED)
+		*pto = ero ? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
+}
+
 /*
  * Read the configuration file once and store it in
  * the grep_defaults template.
@@ -56,17 +62,22 @@ int grep_config(const char *var, const char *value, void *cb)
 {
 	struct grep_opt *opt = cb;
 	const char *slot;
+	static int ero = -1;
 
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
 	if (!strcmp(var, "grep.extendedregexp")) {
-		opt->extended_regexp_option = git_config_bool(var, value);
+		ero = git_config_bool(var, value);
+		adjust_pattern_type(&opt->pattern_type_option, ero);
 		return 0;
 	}
 
 	if (!strcmp(var, "grep.patterntype")) {
 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
+		if (ero == -1)
+			return 0;
+		adjust_pattern_type(&opt->pattern_type_option, ero);
 		return 0;
 	}
 
@@ -115,62 +126,6 @@ void grep_init(struct grep_opt *opt, struct repository *repo)
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
@@ -490,9 +445,9 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	p->fixed = opt->fixed;
+	p->fixed = opt->pattern_type_option == GREP_PATTERN_TYPE_FIXED;
 
-	if (!opt->pcre2 &&
+	if (opt->pattern_type_option != GREP_PATTERN_TYPE_PCRE &&
 	    memchr(p->pattern, 0, p->patternlen))
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
@@ -544,14 +499,14 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
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
index 89a2ce51130..ab0f8290784 100644
--- a/grep.h
+++ b/grep.h
@@ -143,7 +143,6 @@ struct grep_opt {
 	int unmatch_name_only;
 	int count;
 	int word_regexp;
-	int fixed;
 	int all_match;
 	int no_body_match;
 	int body_hit;
@@ -154,7 +153,6 @@ struct grep_opt {
 	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
-	int pcre2;
 	int relative;
 	int pathname;
 	int null_following_name;
@@ -163,7 +161,6 @@ struct grep_opt {
 	int max_depth;
 	int funcname;
 	int funcbody;
-	int extended_regexp_option;
 	enum grep_pattern_type pattern_type_option;
 	int ignore_locale;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
@@ -202,7 +199,6 @@ struct grep_opt {
 
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo);
-void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
 void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
diff --git a/revision.c b/revision.c
index d6e0e2b23b5..dd301e30147 100644
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
2.35.0.rc1.864.g57621b115b6

