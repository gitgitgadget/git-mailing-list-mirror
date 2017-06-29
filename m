Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1A0851F623
	for <e@80x24.org>; Thu, 29 Jun 2017 22:22:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751927AbdF2WWs (ORCPT <rfc822;e@80x24.org>);
        Thu, 29 Jun 2017 18:22:48 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36770 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751887AbdF2WWo (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Jun 2017 18:22:44 -0400
Received: by mail-wm0-f66.google.com with SMTP id y5so4971351wmh.3
        for <git@vger.kernel.org>; Thu, 29 Jun 2017 15:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=WFtJnGMHqWzrEF/AZvVMPhz4l1gp9ps5B9uzTtkyl5Q=;
        b=qGUQMlz4QZEx/8W+keR18DoabjyMp8x8jb4pnjEDRUwk7z6N1Mot/CwyZX7YmKyqJI
         4BWf8b1ivf2CG1/EeZxMc2U/vqqRJi3PscnlePef0dDFd2h27HGwhLpjr9HQiwKcCcT1
         L6l8g2BTKePqQ1q21JetAxKrxLU+13jtIwHfI2Lfi6Ai4TT49s8l92sKOFLYLFMgf7yF
         8rOsqB1OyJtzJ6KZXUX3DrcIMgTSEqQA14xjcaccpTnmuWdpXnL2VYb0YhlY1Xzecw49
         UrkjNgXtSqZ8NW7GIVB5hF+Jhay7zbDE/upB/Cy6kcEFFlUc3wqkFyrEVxDZgZoWBn1D
         +bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=WFtJnGMHqWzrEF/AZvVMPhz4l1gp9ps5B9uzTtkyl5Q=;
        b=q3FFQFNq48OBA1U8f0qPzAdK9NteeDIPJcIcZuTrpetCdvoQIBr5qKTrTzZPyFrlb5
         Yi2/mx4lJ0RNXklyn3/CPJ0c8FcpaUgOWtQosTMs74+Opyfj7WxkLw1ZDgImup5Z6N/o
         W1cU+hYtRRwOAo871vcBLsp9oy+UjCpX72dnnpb861mtWtQfz6dmpHU7TdX/swXFK2q+
         NJifqkhpFG3wHkf4F5wCQPZKPkvf7pF0tT27GuuuKCuzOE7PrAeLwJra2P1U9HIToxK7
         57NKkQDSmIlW68G0RDb6O2OliYiX4vefrftAEFd8xJAOx2zi/kBQCxWvKNetjGHcsEiI
         TR1w==
X-Gm-Message-State: AKS2vOwfQ+rD0mKKIFgcHFAlDbxeWKyD/ccV48n5WX/5dQ1T9HXCHmAe
        kzd85r17Di9QjJurL6I=
X-Received: by 10.80.179.209 with SMTP id t17mr3214761edd.62.1498774962805;
        Thu, 29 Jun 2017 15:22:42 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id c36sm1181183edb.31.2017.06.29.15.22.41
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 29 Jun 2017 15:22:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        J Smith <dark.panda@gmail.com>,
        Joe Ratterman <jratt0@gmail.com>,
        Fredrik Kuivinen <frekui@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 5/6] grep: remove regflags from the public grep_opt API
Date:   Thu, 29 Jun 2017 22:22:21 +0000
Message-Id: <20170629222222.4694-6-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170629222222.4694-1-avarab@gmail.com>
References: <20170629222222.4694-1-avarab@gmail.com>
In-Reply-To: <20170628215809.23060-1-avarab@gmail.com>
References: <20170628215809.23060-1-avarab@gmail.com>
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

Even though grep_commit_pattern_type() is the only caller of
grep_set_pattern_type_option() it's simpler to reset the
extended_regexp_option flag in the latter, since 2/3 branches in the
former would otherwise need to reset it, this way we can do it in one
place.

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
index 7fcdaa0753..11a86548d6 100644
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
@@ -153,7 +152,6 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 	opt->linenum = def->linenum;
 	opt->max_depth = def->max_depth;
 	opt->pathname = def->pathname;
-	opt->regflags = def->regflags;
 	opt->relative = def->relative;
 	opt->output = def->output;
 
@@ -169,6 +167,24 @@ void grep_init(struct grep_opt *opt, const char *prefix)
 
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
@@ -177,7 +193,7 @@ static void grep_set_pattern_type_option(enum grep_pattern_type pattern_type, st
 		break;
 
 	case GREP_PATTERN_TYPE_ERE:
-		opt->regflags |= REG_EXTENDED;
+		opt->extended_regexp_option = 1;
 		break;
 
 	case GREP_PATTERN_TYPE_FIXED:
@@ -207,6 +223,11 @@ void grep_commit_pattern_type(enum grep_pattern_type pattern_type, struct grep_o
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
 
@@ -572,7 +593,7 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 {
 	struct strbuf sb = STRBUF_INIT;
 	int err;
-	int regflags = opt->regflags;
+	int regflags = REG_NEWLINE;
 
 	basic_regex_quote_buf(&sb, p->pattern);
 	if (opt->ignore_case)
@@ -591,12 +612,12 @@ static void compile_fixed_regexp(struct grep_pat *p, struct grep_opt *opt)
 
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
@@ -614,10 +635,10 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
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
@@ -641,7 +662,11 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
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

