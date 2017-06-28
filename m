Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42DB220285
	for <e@80x24.org>; Wed, 28 Jun 2017 21:58:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751723AbdF1V6n (ORCPT <rfc822;e@80x24.org>);
        Wed, 28 Jun 2017 17:58:43 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34467 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751655AbdF1V6l (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Jun 2017 17:58:41 -0400
Received: by mail-wm0-f68.google.com with SMTP id p204so9047355wmg.1
        for <git@vger.kernel.org>; Wed, 28 Jun 2017 14:58:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=KavPQX7uPIglZ/88NENrE/KwrcDGtYsJ5gyKBZUF7EA=;
        b=PiJPwVCKXjWPpF8/0T7DF3/ELXdlE5npQxGjtsVbqcg3smT7HHghC0JXVlcHy45db9
         XoF4EVjH6iOytLUqBHm+7enkQ2kJM9TkJAkxM3bwa/lk0nbZWHgkhGM1zTCjYcsDyqTn
         j2z41xnL68TkaxpCGosjsb25L5LtPy2+wR96YZdgfMXySy7PuO/A8TZWusMP52Tv+sxQ
         gE2Mv4i+oTlSZ9Tqndr0RqTNiSXzJy6bJh8E+SZtnPQSAggZG7v1TqIvQuBRSsACqOfu
         UfBhKATgwyOcv6pGyNxaT1IgN3C36YJRaxuNi8InyfR0yfJW3EiU58hxAzhhuZZeP4mP
         VbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=KavPQX7uPIglZ/88NENrE/KwrcDGtYsJ5gyKBZUF7EA=;
        b=qsUVTp4PJRnlT2xEEbtdKt0q9GHaTw9BiZuQ+ptCfa6Fj2sFGn5zrm/NwMnS08c88y
         cCjMjYSoAvUTbEnsL8ZshytkbNTMHnx+RggSnp/un75tZB0QqdxlfS8m1M3UIt+gI/KW
         yu3HkaAfNhrcgMGf2i/eB3NXlk1s1LllIXaH9ZzAaX01g4YpSP4MhNmBipNDUrULqOV0
         nNPdmRkP6T1aV9uRBtymlnPnBEFC5gUytvOjm8vLloUN0vZrGISNfUOqkjtX65jlhhOM
         X6OWqTfiyIO5dD9bt2QdhpIV56215pRVWJJKFfLPdyNIKcXxvXMXWJmWCs/CeUOPSs30
         yvfg==
X-Gm-Message-State: AKS2vOx32ltf26LN4UKfqVNxTP00EMVO1ApIj4LOJDNeQ7pACJpknoRM
        VcR0a0KaU2aiTdVMhY8=
X-Received: by 10.80.134.217 with SMTP id 25mr9198777edu.73.1498687114135;
        Wed, 28 Jun 2017 14:58:34 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id g25sm1926975eda.59.2017.06.28.14.58.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Jun 2017 14:58:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] grep: remove regflags from the public grep_opt API
Date:   Wed, 28 Jun 2017 21:58:09 +0000
Message-Id: <20170628215809.23060-6-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
In-Reply-To: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
References: <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Refactor calls to the grep machinery to always pass opt.ignore_case &
opt.extended_regexp_option instead of setting the equivalent regflags
bits.

The bug fixed when making -i work with -P in commit 9e3cbc59d5 ("log:
make --regexp-ignore-case work with --perl-regexp", 2017-05-20) was
really just plastering over the code smell which this change fixes.

See my "Re: [PATCH v3 05/30] log: make --regexp-ignore-case work with
--perl-regexp"[1] for the discussion leading up to this.

The reason for adding the extensive commentary here is that I
discovered some subtle complexity in implementing this that really
should be called out explicitly to future readers.

Before this change we'd rely on the difference between
`extended_regexp_option` and `regflags` to serve as a membrane between
our preliminary parsing of grep.extendedRegexp and grep.patternType,
and what we decided to do internally.

Now that those two are the same thing, it's necessary to unset
`extended_regexp_option` just before we commit in cases where both of
those config variables are set. See 84befcd0a4 ("grep: add a
grep.patternType configuration setting", 2012-08-03) for the code and
documentation related to that.

The explanation of why the if/else branches in
grep_commit_pattern_type() are ordered the way they are exists in that
commit message, but I think it's worth calling this subtlety out
explicitly with a comment for future readers.

Unrelated to that: I could have factored out the default REG_NEWLINE
flag into some custom GIT_GREP_H_DEFAULT_REGFLAGS or something, but
since it's just used in two places I didn't think it was worth the
effort.

As an aside we're really lacking test coverage regflags being
initiated as 0 instead of as REG_NEWLINE. Tests will fail if it's
removed from compile_regexp(), but not if it's removed from
compile_fixed_regexp(). I have not dug to see if it's actually needed
in the latter case or if the test coverage is lacking.

1. <CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com>
   (https://public-inbox.org/git/CACBZZX6Hp4Q4TOj_X1fbdCA4twoXF5JemZ5ZbEn7wmkA=1KO2g@mail.gmail.com/)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/grep.c |  2 --
 grep.c         | 43 ++++++++++++++++++++++++++++++++++---------
 grep.h         |  1 -
 revision.c     |  2 --
 4 files changed, 34 insertions(+), 14 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index f61a9d938b..b682966439 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -1169,8 +1169,6 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 
 	if (!opt.pattern_list)
 		die(_("no pattern given."));
-	if (!opt.fixed && opt.ignore_case)
-		opt.regflags |= REG_ICASE;
 
 	/*
 	 * We have to find "--" in a separate pass, because its presence
diff --git a/grep.c b/grep.c
index 736e1e00d6..51aaad9f03 100644
--- a/grep.c
+++ b/grep.c
@@ -35,7 +35,6 @@ void init_grep_defaults(void)
 	memset(opt, 0, sizeof(*opt));
 	opt->relative = 1;
 	opt->pathname = 1;
-	opt->regflags = REG_NEWLINE;
 	opt->max_depth = -1;
 	opt->pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED;
 	color_set(opt->color_context, "");
@@ -154,7 +153,6 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->linenum = def->linenum;
 	opt->max_depth = def->max_depth;
 	opt->pathname = def->pathname;
-	opt->regflags = def->regflags;
 	opt->relative = def->relative;
 	opt->output = def->output;
 
@@ -170,6 +168,24 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 
 static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, struct grep_opt *opt)
 {
+	/*
+	 * When committing to the pattern type by setting the relevant
+	 * fields in grep_opt it's generally not necessary to zero out
+	 * the fields we're not choosing, since they won't have been
+	 * set by anything. The extended_regexp_option field is the
+	 * only exception to this.
+	 *
+	 * This is because in the process of parsing grep.patternType
+	 * & grep.extendedRegexp we set opt->pattern_type_option and
+	 * opt->extended_regexp_option, respectively. We then
+	 * internally use opt->extended_regexp_option to see if we're
+	 * compiling an ERE. It must be unset if that's not actually
+	 * the case.
+	 */
+	if (pattern_type != GREP_PATTERN_TYPE_ERE &&
+	    opt->extended_regexp_option)
+		opt->extended_regexp_option = 0;
+
 	switch (pattern_type) {
 	case GREP_PATTERN_TYPE_UNSPECIFIED:
 		/* fall through */
@@ -178,7 +194,7 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 		break;
 
 	case GREP_PATTERN_TYPE_ERE:
-		opt->regflags |= REG_EXTENDED;
+		opt->extended_regexp_option = 1;
 		break;
 
 	case GREP_PATTERN_TYPE_FIXED:
@@ -208,6 +224,11 @@ void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_o
 	else if (opt->pattern_type_option != GREP_PATTERN_TYPE_UNSPECIFIED)
 		grep_set_pattern_type_option(opt->pattern_type_option, opt);
 	else if (opt->extended_regexp_option)
+		/*
+		 * This branch *must* happen after setting from the
+		 * opt->pattern_type_option above, we don't want
+		 * grep.extendedRegexp to override grep.patternType!
+		 */
 		grep_set_pattern_type_option(GREP_PATTERN_TYPE_ERE, opt);
 }
 
@@ -573,7 +594,7 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int err;
-	int regflags = opt->regflags;
+	int regflags = REG_NEWLINE;
 
 	basic_regex_quote_buf(&sb, p->pattern);
 	if (opt->ignore_case)
@@ -592,12 +613,12 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 
 static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
-	int icase, ascii_only;
+	int ascii_only;
 	int err;
+	int regflags = REG_NEWLINE;
 
 	p->word_regexp = opt->word_regexp;
 	p->ignore_case = opt->ignore_case;
-	icase	       = opt->regflags & REG_ICASE || p->ignore_case;
 	ascii_only     = !has_non_ascii(p->pattern);
 
 	/*
@@ -615,10 +636,10 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 	if (opt->fixed ||
 	    has_null(p->pattern, p->patternlen) ||
 	    is_fixed(p->pattern, p->patternlen))
-		p->fixed = !icase || ascii_only;
+		p->fixed = !p->ignore_case || ascii_only;
 
 	if (p->fixed) {
-		p->kws = kwsalloc(icase ? tolower_trans_tbl : NULL);
+		p->kws = kwsalloc(p->ignore_case ? tolower_trans_tbl : NULL);
 		kwsincr(p->kws, p->pattern, p->patternlen);
 		kwsprep(p->kws);
 		return;
@@ -642,7 +663,11 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
 		return;
 	}
 
-	err = regcomp(&p->regexp, p->pattern, opt->regflags);
+	if (p->ignore_case)
+		regflags |= REG_ICASE;
+	if (opt->extended_regexp_option)
+		regflags |= REG_EXTENDED;
+	err = regcomp(&p->regexp, p->pattern, regflags);
 	if (err) {
 		char errbuf[1024];
 		regerror(err, &p->regexp, errbuf, 1024);
diff --git a/grep.h b/grep.h
index b8f93bfc2d..0c091e5104 100644
--- a/grep.h
+++ b/grep.h
@@ -162,7 +162,6 @@ struct grep_opt {
 	char color_match_selected[COLOR_MAXLEN];
 	char color_selected[COLOR_MAXLEN];
 	char color_sep[COLOR_MAXLEN];
-	int regflags;
 	unsigned pre_context;
 	unsigned post_context;
 	unsigned last_shown;
diff --git a/revision.c b/revision.c
index e181ad1b70..207103d211 100644
--- a/revision.c
+++ b/revision.c
@@ -1362,7 +1362,6 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	init_grep_defaults();
 	grep_init(&revs->grep_filter, prefix);
 	revs->grep_filter.status_only = 1;
-	revs->grep_filter.regflags = REG_NEWLINE;
 
 	diff_setup(&revs->diffopt);
 	if (prefix && !revs->diffopt.prefix) {
@@ -2022,7 +2021,6 @@ static int handle_revision_opt(struct rev_info *revs, int argc, const char **arg
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_ERE;
 	} else if (!strcmp(arg, "--regexp-ignore-case") || !strcmp(arg, "-i")) {
 		revs->grep_filter.ignore_case = 1;
-		revs->grep_filter.regflags |= REG_ICASE;
 		DIFF_OPT_SET(&revs->diffopt, PICKAXE_IGNORE_CASE);
 	} else if (!strcmp(arg, "--fixed-strings") || !strcmp(arg, "-F")) {
 		revs->grep_filter.pattern_type_option = GREP_PATTERN_TYPE_FIXED;
-- 
2.13.1.611.g7e3b11ae1

