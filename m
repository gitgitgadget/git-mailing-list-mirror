Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98ABBC433F5
	for <git@archiver.kernel.org>; Wed, 16 Feb 2022 00:01:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244910AbiBPABw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Feb 2022 19:01:52 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244928AbiBPABd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Feb 2022 19:01:33 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89038CD324
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:17 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id q198-20020a1ca7cf000000b0037bb52545c6so2577469wme.1
        for <git@vger.kernel.org>; Tue, 15 Feb 2022 16:01:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9oMkaGI5POrIwEybiLqoBPyW//K37gPnXGqhTTqnhGM=;
        b=STbEBwRZiKzmnJ55fY8ETiqKLGX5Y2sR1J6Mx3Vd3zECWx6n3kwOu7Gw8TEphbFWl+
         IJ7+RGujLc+XIHZsATV98hG+XNtBLU4MXGYHRef3o/lvkx1sM1QCFj+oihDbK5ylZrGT
         smKiJS4een6wdAc+Vz6NHo1oaenIJpUNFY8cw2bmZIZrqLBS54bcOckSyzayv4fToKMI
         2YeMMkiY/iybFCEV1yGx5+mA0gLP2ib1SslOIWe0kXNUp5VmMtWA1nsEGBOWjzXeBSh8
         26Q7BtK2VCled6a3YC8Iy+KOxIOcg/gb+WIEdZAIty7Ae77ZAY7GwT2qSIjZQ3Z5dN7T
         0viA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9oMkaGI5POrIwEybiLqoBPyW//K37gPnXGqhTTqnhGM=;
        b=8NXnhrWKSgZta3TrjxF1Mq77rlE1PTrnmB8oo85ROnd/ZA6TRBF2jatzTOrFwvDRV5
         zriVHFsguSMtxsQgUpYFl5fv7ohQaiAl9TzTVCh4zgYh46eb0VZi3Adku3RPi8n2H/uj
         R5AXFESqZ5r4R4wHfYeA7wqbXv4y9Hu+TJd3sMjrrstmRXt+Y1gxWLAbknGfiFJ1xPD1
         vZZe+jwhXGimcjNtbF/qqXVn3KWgpDrcJdelXRIe23LXcrOhFG2xdJy1KYkBJPBo/BGZ
         VtRN72TOaMC9XvQnWmOcqoadul5YzFj0+ReOK+f+wPj3eZ9SdzxaG6FFPIep2Wysrwxi
         V8KA==
X-Gm-Message-State: AOAM533QDeRvTPpoDSUs6zF1ONh7CgeLFhZmPQ8zc31A+cTWXu4PZMPc
        lfuAoA+mZWG0/aHsTV4YwmKX1CfnKFMSgQ==
X-Google-Smtp-Source: ABdhPJxJEmQbOpObzg80yLpPgOdAdq4hosUkkNg/hzgOkc3/BcKZRh6CsdgdwsOe8PEkkqQh8gO9Yw==
X-Received: by 2002:a05:600c:1da4:b0:37c:729:f84d with SMTP id p36-20020a05600c1da400b0037c0729f84dmr5000015wms.131.1644969675752;
        Tue, 15 Feb 2022 16:01:15 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a12sm17260542wru.99.2022.02.15.16.01.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 16:01:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v11 10/10] grep: simplify config parsing and option parsing
Date:   Wed, 16 Feb 2022 01:00:39 +0100
Message-Id: <patch-v11-10.10-38bc5dc9461-20220216T000006Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1028.g9479bb34b83
In-Reply-To: <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
References: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com> <cover-v11-00.10-00000000000-20220216T000006Z-avarab@gmail.com>
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
    `grep.patternType` option is set to a value other than
    'default'".

In a preceding commit we changed grep_config() to be called after
grep_init(), which means that much of the complexity here can go
away.

As before both "grep.patternType" and "grep.extendedRegexp" are
last-one-wins variable, with "grep.extendedRegexp" yielding to
"grep.patternType", except when "grep.patternType=default".

Note that as the previously added tests indicate this cannot be done
on-the-fly as we see the config variables, without introducing more
state keeping. I.e. if we see:

    -c grep.extendedRegexp=false
    -c grep.patternType=default
    -c extendedRegexp=true

We need to select ERE, since grep.patternType=default unselects that
variable, which normally has higher precedence, but we also need to
select BRE in cases of:

    -c grep.extendedRegexp=true \
    -c grep.extendedRegexp=false

Which would not be the case for this, which select ERE:

    -c grep.patternType=extended \
    -c grep.extendedRegexp=false

Therefore we cannot do this on-the-fly in grep_config without also
introducing tracking variables for not only the pattern type, but what
the source of that pattern type was.

So we need to decide on the pattern after our config was fully
parsed. Let's do that by deferring the decision on the pattern type
until it's time to compile it in compile_regexp().

By that time we've not only parsed the config, but also handled the
command-line options. Those will set "opt.pattern_type_option" (*not*
"opt.extended_regexp_option"!).

At that point all we need to do is see if "grep.patternType" was
UNSPECIFIED in the end (including an explicit "=default"), if so we'll
use the "grep.extendedRegexp" configuration, if any.

See my 07a3d411739 (grep: remove regflags from the public grep_opt
API, 2017-06-29) for addition of the two comments being removed here,
i.e. the complexity noted in that commit is now going away.

1. https://lore.kernel.org/git/patch-v8-09.10-c211bb0c69d-20220118T155211Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c | 10 +++-----
 grep.c         | 69 +++++++-------------------------------------------
 grep.h         |  3 ---
 revision.c     |  2 --
 4 files changed, 13 insertions(+), 71 deletions(-)

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
index 62f2595f68a..d5ad9617d99 100644
--- a/grep.c
+++ b/grep.c
@@ -115,62 +115,6 @@ void grep_init(struct grep_opt *opt, struct repository *repo)
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
@@ -488,11 +432,16 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	int err;
 	int regflags = REG_NEWLINE;
 
+	if (opt->pattern_type_option == GREP_PATTERN_TYPE_UNSPECIFIED)
+		opt->pattern_type_option = (opt->extended_regexp_option
+					    ? GREP_PATTERN_TYPE_ERE
+					    : GREP_PATTERN_TYPE_BRE);
+
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	p->fixed = opt->fixed;
+	p->fixed = opt->pattern_type_option == GREP_PATTERN_TYPE_FIXED;
 
-	if (!opt->pcre2 &&
+	if (opt->pattern_type_option != GREP_PATTERN_TYPE_PCRE &&
 	    memchr(p->pattern, 0, p->patternlen))
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
@@ -544,14 +493,14 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
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
index 89a2ce51130..c722d25ed9d 100644
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
@@ -202,7 +200,6 @@ struct grep_opt {
 
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
2.35.1.1028.g9479bb34b83

