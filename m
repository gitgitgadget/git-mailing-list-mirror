Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2FCCC433EF
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE44E61165
	for <git@archiver.kernel.org>; Sat,  6 Nov 2021 21:11:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234482AbhKFVNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Nov 2021 17:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235122AbhKFVNs (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Nov 2021 17:13:48 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2C1C061208
        for <git@vger.kernel.org>; Sat,  6 Nov 2021 14:11:06 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id s13so19565624wrb.3
        for <git@vger.kernel.org>; Sat, 06 Nov 2021 14:11:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=h3PacSA0xdu8HMu8VKvB3FAuSwsJnH1FAMXFwGrh1xA=;
        b=gIRXw8S/W6aFdtGSt42wlQbqgLol2wcdDdcaEur0iypiKodcgwRxznWc/T9vHUTcFW
         a/aBKiz0xr1Q53URPkIkgy4HevgbTYUN7mao8g8fXX0ytLm9BUjopXiW/neIrkN6C7zX
         LKS7Pof1vPJq5pjB5RIIjMSfS9JAO/b9UvhvnlJ4CHSLNOgFw1qVhHE/jBdDVcXj3aDv
         o5qdYp95nvU9ko/Vjp7P/Lgj1vl9HnIItn3XHyaojqA/ZlIGpZNsONj1l+Zv81zTBoTp
         f9ueTP0eMpD/QnvZWKq/P/jatawRj0H+hmAvSR/HAXWYyWba7x22ybEron3Y/BksY4Ae
         B9EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3PacSA0xdu8HMu8VKvB3FAuSwsJnH1FAMXFwGrh1xA=;
        b=eXMkkqryn8sqszThnuDhPP5M7X3lTBMVGKwrqXaqcpC+iHjOvqps5h+Nm8K6bChrL7
         N/y13elypNwdwTKIdm2i88dSLgr3kJ3EpcdOw+KYi3bo7Vlo/DS2Q3V4U5nmztx9LTYf
         Wco7WFz0v9hDdgIBdVgZvdybPbxCh/DYu6+g2ZnC6o3ZBTItcdDwpJ4zjGSQKlSt4yR3
         8fKhGOkzIvn+g30ZmmUvKNYhy2wz5mL5IglWz5epOrd5IGOoHOXv5YmP6ZmL1BYRyXP5
         VUSyS7kj3Y22KuoujwEQcBoCYyQcgeISiWhhzNNup/tOKfw8izx7wFWJZZKnmEfI8EFq
         QCfg==
X-Gm-Message-State: AOAM53293r2/HzACj1fqdjz6OM0PlPY/Eyi4EW0AJuMvWSGS6y88b21H
        jUsRPUHnz95XQnIefOJaTECRjWBKF9klCQ==
X-Google-Smtp-Source: ABdhPJye3/5BUoz7ZWEl38aOvkAodr/Foh5vEK2D6oP8ikOSqOED8sDz2M4KIHHGgFk9+QcmBrRp2w==
X-Received: by 2002:a5d:68cb:: with SMTP id p11mr41967607wrw.262.1636233065117;
        Sat, 06 Nov 2021 14:11:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4sm9123051wmq.31.2021.11.06.14.11.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Nov 2021 14:11:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 7/8] grep: simplify config parsing, change grep.<rx config> interaction
Date:   Sat,  6 Nov 2021 22:10:53 +0100
Message-Id: <patch-7.8-677a8f8520f-20211106T210711Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
References: <cover-0.8-00000000000-20211106T210711Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the interaction between "grep.patternType=default" and
"grep.extendedRegexp=true" to make setting "grep.extendedRegexp=true"
synonymous with setting "grep.patternType=extended".

This changes our existing config parsing behavior as detailed below,
but in a way that's consistent with how we parse other
configuration.

Pedantically speaking we're probably breaking past promises here, but
I doubt that this will impact anyone in practice. The reduction in
complexity and resulting consistency with other default config
behavior is worth it.

When "grep.patternType" was introduced in 84befcd0a4a (grep: add a
grep.patternType configuration setting, 2012-08-03) we made two
seemingly contradictory promises:

 1. You can set "grep.patternType", and "[setting it to] 'default'
    will return to the default matching behavior".

 2. Support the existing "grep.extendedRegexp" option, but ignore it
    when the new "grep.patternType" is set, *except* "when the
    `grep.patternType` option is set. to a value other than 'default'".

I think that 84befcd0a4a probably didn't intend this behavior, but
instead ended up conflating our internal "unspecified" state with a
user's explicit desire to set the configuration back to the
default.

I.e. a user would correctly expect this to keep working:

    # ERE grep
    git -c grep.extendedRegexp=true grep <pattern>

And likewise for "grep.patternType=default" to take precedence over
the disfavored "grep.extendedRegexp" option, i.e. the usual "last set
wins" semantics.

    # BRE grep
    git -c grep.extendedRegexp=true -c grep.patternType=basic grep <pattern>

But probably not for this to ignore the new "grep.patternType" option
entirely, say if /etc/gitconfig was still setting
"grep.extendedRegexp", but "~/.gitconfig" used the new
"grep.patternType" (and wanted to use the "default" value):

    # Was ERE, now BRE
    git -c grep.extendedRegexp=true grep.patternType=default grep <pattern>

I think that in practice nobody or almost nobody is going to be
relying on this obscure interaction, and as shown here it makes the
config parsing much simpler. We no longer have to carry a complex
state machine in "grep_commit_pattern_type()" and
"grep_set_pattern_type_option()".

We can also do away with the "int fixed" and "int pcre2" members in
favor of using "pattern_type_option" directly in "grep.c", as well as
dropping the "pattern_type_arg" variable in "builtin/grep.c" in favor
of using the "pattern_type_option" member directly.

See my 07a3d411739 (grep: remove regflags from the public grep_opt
API, 2017-06-29) for addition of the two comments being removed here,
i.e. the complexity noted in that commit is now going away.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Documentation/config/grep.txt |  3 +-
 Documentation/git-grep.txt    |  3 +-
 builtin/grep.c                | 10 ++---
 grep.c                        | 71 +++++------------------------------
 grep.h                        |  6 +--
 revision.c                    |  2 -
 t/t7810-grep.sh               |  2 +-
 7 files changed, 17 insertions(+), 80 deletions(-)

diff --git a/Documentation/config/grep.txt b/Documentation/config/grep.txt
index 44abe45a7ca..2669b1757d3 100644
--- a/Documentation/config/grep.txt
+++ b/Documentation/config/grep.txt
@@ -12,8 +12,7 @@ grep.patternType::
 
 grep.extendedRegexp::
 	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
+	option is ignored when the `grep.patternType` option is set.
 
 grep.threads::
 	Number of grep worker threads to use.
diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
index 3d393fbac1b..078dfeadf50 100644
--- a/Documentation/git-grep.txt
+++ b/Documentation/git-grep.txt
@@ -348,8 +348,7 @@ grep.patternType::
 
 grep.extendedRegexp::
 	If set to true, enable `--extended-regexp` option by default. This
-	option is ignored when the `grep.patternType` option is set to a value
-	other than 'default'.
+	option is ignored when the `grep.patternType` option is set.
 
 grep.threads::
 	Number of grep worker threads to use. If unset (or set to 0), Git will
diff --git a/builtin/grep.c b/builtin/grep.c
index 7f95f44e948..a4964baf9c0 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -849,7 +849,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	int i;
 	int dummy;
 	int use_index = 1;
-	int pattern_type_arg = GREP_PATTERN_TYPE_UNSPECIFIED;
 	int allow_revs;
 
 	struct option options[] = {
@@ -883,16 +882,16 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
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
@@ -986,7 +985,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	argc = parse_options(argc, argv, prefix, options, grep_usage,
 			     PARSE_OPT_KEEP_DASHDASH |
 			     PARSE_OPT_STOP_AT_NON_OPTION);
-	grep_commit_pattern_type(pattern_type_arg, &opt);
 
 	if (use_index && !startup_info->have_repository) {
 		int fallback = 0;
diff --git a/grep.c b/grep.c
index fb3f63c63ef..dda8e536fe3 100644
--- a/grep.c
+++ b/grep.c
@@ -60,8 +60,10 @@ int grep_config(const char *var, const char *value, void *cb)
 	if (userdiff_config(var, value) < 0)
 		return -1;
 
-	if (!strcmp(var, "grep.extendedregexp")) {
-		opt->extended_regexp_option = git_config_bool(var, value);
+	if (opt->pattern_type_option == GREP_PATTERN_TYPE_UNSPECIFIED &&
+	    !strcmp(var, "grep.extendedregexp") &&
+	    git_config_bool(var, value)) {
+		opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
 		return 0;
 	}
 
@@ -115,62 +117,6 @@ void grep_init(struct grep_opt *opt, struct repository *repo)
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
@@ -492,9 +438,10 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	p->fixed = opt->fixed;
+	p->fixed = opt->pattern_type_option == GREP_PATTERN_TYPE_FIXED;
 
-	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
+	if (opt->pattern_type_option != GREP_PATTERN_TYPE_PCRE &&
+	    memchr(p->pattern, 0, p->patternlen))
 		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
 
 	p->is_fixed = is_fixed(p->pattern, p->patternlen);
@@ -545,14 +492,14 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
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
index 30a7dfd3294..e4e548aed90 100644
--- a/grep.h
+++ b/grep.h
@@ -143,7 +143,6 @@ struct grep_opt {
 	int unmatch_name_only;
 	int count;
 	int word_regexp;
-	int fixed;
 	int all_match;
 #define GREP_BINARY_DEFAULT	0
 #define GREP_BINARY_NOMATCH	1
@@ -152,7 +151,6 @@ struct grep_opt {
 	int allow_textconv;
 	int extended;
 	int use_reflog_filter;
-	int pcre2;
 	int relative;
 	int pathname;
 	int null_following_name;
@@ -161,8 +159,7 @@ struct grep_opt {
 	int max_depth;
 	int funcname;
 	int funcbody;
-	int extended_regexp_option;
-	int pattern_type_option;
+	enum grep_pattern_type pattern_type_option;
 	int ignore_locale;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
@@ -201,7 +198,6 @@ struct grep_opt {
 
 int grep_config(const char *var, const char *value, void *);
 void grep_init(struct grep_opt *, struct repository *repo);
-void grep_commit_pattern_type(enum grep_pattern_type, struct grep_opt *opt);
 
 void append_grep_pat(struct grep_opt *opt, const char *pat, size_t patlen, const char *origin, int no, enum grep_pat_token t);
 void append_grep_pattern(struct grep_opt *opt, const char *pat, const char *origin, int no, enum grep_pat_token t);
diff --git a/revision.c b/revision.c
index 9f9b0d2429e..ed29d245c89 100644
--- a/revision.c
+++ b/revision.c
@@ -2864,8 +2864,6 @@ int setup_revisions(int argc, const char **argv, struct rev_info *revs, struct s
 
 	diff_setup_done(&revs->diffopt);
 
-	grep_commit_pattern_type(GREP_PATTERN_TYPE_UNSPECIFIED,
-				 &revs->grep_filter);
 	if (!is_encoding_utf8(get_log_output_encoding()))
 		revs->grep_filter.ignore_locale = 1;
 	compile_grep_patterns(&revs->grep_filter);
diff --git a/t/t7810-grep.sh b/t/t7810-grep.sh
index 6b6423a07c3..a59a9726357 100755
--- a/t/t7810-grep.sh
+++ b/t/t7810-grep.sh
@@ -443,7 +443,7 @@ do
 	'
 
 	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=default" '
-		echo "${HC}ab:abc" >expected &&
+		echo "${HC}ab:a+bc" >expected &&
 		git \
 			-c grep.extendedRegexp=true \
 			-c grep.patternType=default \
-- 
2.34.0.rc1.741.gab7bfd97031

