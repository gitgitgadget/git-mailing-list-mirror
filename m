Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09F1DC433EF
	for <git@archiver.kernel.org>; Tue, 28 Dec 2021 01:07:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234321AbhL1BHv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Dec 2021 20:07:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbhL1BHu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Dec 2021 20:07:50 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50D68C06173E
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:50 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id a9so35151193wrr.8
        for <git@vger.kernel.org>; Mon, 27 Dec 2021 17:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bPWyBFVhy9twRpqxSqse12VSgcgxAGEpRwsrVn3I0uQ=;
        b=pfBiyNJjIQWSnrzIeVLibOEe0fvhDhdZH1ksl6diHBQjBzG7pFzat5fdnnIDRoo/Gw
         4OzV8/pdfAwyn7j0hCrQ2O6xbOB1jCKS3spF+ldYjEFMdYHpj6EoChFtDfwaeF0kZaeA
         OG7pGj9nYtos0x+Wy+ZXb7sZ56QLLWVD/BlM4FpxR3EaezDv/VdouiGEwlQU1o2QWbDf
         U6xvzxqZ0eLNSf4fHJ7G/ihLM290x2L5WoblKGHJVT9PPX4E4viQRoqxkpJ9e4tU7G7u
         uPF1Jo9RBfFD3Vgts8NJHMTFryM/b/quetyPWic3JUg4O2LFbpBt1C7yPqaSWFbZn58v
         JV2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bPWyBFVhy9twRpqxSqse12VSgcgxAGEpRwsrVn3I0uQ=;
        b=exU7gQSVYxVuuZNZcM5HQ5hE/0a4D1fylzyNEokPKq5mqE2FNOjahcT4spAnYrLwyK
         L+E7MSLmJiJgYow2QAcDY1dHBUuLkDX58qSv0NpAL/sqeGpoExezXJWjqLEH3anlodrZ
         ctLln6cg0RqO+unAffPO+tR5JcIPakowSqDR/RndofU0mlkQ+URVo7oDoczrSebEoijm
         cOJTEeNPZIHIYTJMYJrBIl6hFBHWy0RDVYHmZavbDFAn2YDXYvebkAm7vzWxl+oTzFCt
         fyncHBwB7U5QGcadnuK1qWgwvLlJgWibOMJN6oKneUGhQaTzr0WCqSR/jcJAHvEZeUy4
         0eWw==
X-Gm-Message-State: AOAM531HoWBEkUyAlRYVBHrFsRHVTEsVQ8bU+B8Ul/4sUOuGc5qeRyXb
        WBFsrXcYhoetKPnVrZlyAsScjdTGsTg3WN0B
X-Google-Smtp-Source: ABdhPJyN/5E4Y7ppMVri6NwM/4qHWaT/7KsD0pweHdOw+RHqWIA1I4BNt5vL2ir+maM4t9UOLJFLCg==
X-Received: by 2002:a5d:604e:: with SMTP id j14mr13643592wrt.119.1640653668147;
        Mon, 27 Dec 2021 17:07:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b197sm16910973wmb.24.2021.12.27.17.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Dec 2021 17:07:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 00/10] grep: simplify & delete "init" & "config" code
Date:   Tue, 28 Dec 2021 02:07:35 +0100
Message-Id: <cover-v7-00.10-00000000000-20211228T004707Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1250.g6a242c1e9ad
In-Reply-To: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
References: <cover-v6-0.7-00000000000-20211226T223035Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A re-roll that should *hopefully* address the comments Junio had in
https://lore.kernel.org/git/xmqq4k6tyj8r.fsf@gitster.g/; To quote
those:

> Junio C Hamano <gitster@pobox.com> writes:
> [...]
> By the way, the example I gave you for the previous round, and
> similarly the one in the message I am responding to were all written
> to help you realize that it is simply a broken approach if we do not
> keep "default" as default and instead resolve it to either "basic"
> or "extended" too early.  The goal of these examples was *NOT* to
> tell you "this single thing is broken with the code in this round so
> let's fix it".

Yes, the v6 was broken. Sorry about that. Between re-rolling some
other things and coming back to this series I managed to miss some of
those subtleties.

> So let me try to be a bit more explicit.  Let's not do another round
> of "I think this is a moral equivalent of what you want, even though
> it is not done the way you suggested." I think we wasted a reroll or
> three with that attitude in changes leading to v6 already, after I
> gave my review to v5, and I think the v5 review essentially was a
> repeat of my review for v3's 3/7, so if I conveyed the point clearly
> enough back then, perhaps we didn't have to waste your time on v4
> and v5, either.  Sorry about that.
>
> So, here is what this step of the series SHOULD do:

So, at the risk of another wasted re-roll this doesn't exactly
implement what you suggested, but I think it'll finally cover all the
basis of being bug-for-bug compatible with the old implementation now.

I started this re-roll by implementing it exactly as you suggested,
along with new tests (both your fixup, and more), but as the updated
commit message in 09/10 details found that I could convert it back to
a state machine around a static variable in "grep_config()", which has
the advantage of getting rid of more "struct grep_opt" fields annd
narrowing the behavior to just that function.

More comments on the range-diff below:

Ævar Arnfjörð Bjarmason (10):
  grep.h: remove unused "regex_t regexp" from grep_opt
  log tests: check if grep_config() is called by "log"-like cmds

No changes.

  grep tests: add missing "grep.patternType" config tests

A couple of new tests.

  built-ins: trust the "prefix" from run_builtin()
  grep.c: don't pass along NULL callback value
  grep API: call grep_config() after grep_init()

No changes.

  grep.h: make "grep_opt.pattern_type_option" use its enum
  grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"

I split these two off from the previous tip commit to make the diff
for the next one smaller.

  grep: simplify config parsing and option parsing

Changed, as noted above.

  grep.[ch]: remove GREP_PATTERN_TYPE_UNSPECIFIED

With that new behavior we can also get rid of
GREP_PATTERN_TYPE_UNSPECIFIED. It's still implicitly there as == 0,
but for a non-switch'd enum type treating these as "flags" makes more
sense, and makes the code in grep_config() more straightforward &
brief.

 builtin/grep.c    |  27 +++++-----
 builtin/log.c     |  13 ++++-
 builtin/ls-tree.c |   2 +-
 git.c             |   1 +
 grep.c            | 126 +++++++++-------------------------------------
 grep.h            |  34 +++++++++----
 revision.c        |   4 +-
 t/t4202-log.sh    |  24 +++++++++
 t/t7810-grep.sh   |  68 +++++++++++++++++++++++++
 9 files changed, 168 insertions(+), 131 deletions(-)

Range-diff against v6:
 1:  b62e6b6162a =  1:  b62e6b6162a grep.h: remove unused "regex_t regexp" from grep_opt
 2:  0edcdb50afd =  2:  0edcdb50afd log tests: check if grep_config() is called by "log"-like cmds
 3:  1b724d5e2e9 !  3:  e1b4b5b77e0 grep tests: add missing "grep.patternType" config tests
    @@ t/t7810-grep.sh: do
     +		test_cmp expected actual
     +	'
     +
    ++	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (BRE)" '
    ++		echo "${HC}ab:abc" >expected &&
    ++		git \
    ++			-c grep.patternType=fixed \
    ++			-c grep.extendedRegexp=true \
    ++			-c grep.patternType=default \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
    ++
    ++	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (ERE)" '
    ++		echo "${HC}ab:a+bc" >expected &&
    ++		git \
    ++			-c grep.patternType=default \
    ++			-c grep.extendedRegexp=true \
    ++			-c grep.patternType=basic \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
    ++
     +	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
     +		echo "${HC}ab:a+bc" >expected &&
     +		git \
    @@ t/t7810-grep.sh: do
      	test_expect_success "grep $L with grep.patternType=extended and grep.extendedRegexp=false" '
      		echo "${HC}ab:abc" >expected &&
      		git \
    +@@ t/t7810-grep.sh: do
    + 		test_cmp expected actual
    + 	'
    + 
    ++	test_expect_success "grep $L with grep.extendedRegexp=false and grep.patternType=default" '
    ++		echo "${HC}ab:abc" >expected &&
    ++		git \
    ++			-c grep.extendedRegexp=false \
    ++			-c grep.patternType=extended \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
    ++
    + 	test_expect_success "grep $L with grep.extendedRegexp=true and grep.patternType=basic" '
    + 		echo "${HC}ab:a+bc" >expected &&
    + 		git \
 4:  f4876552771 =  4:  6d91a765fd7 built-ins: trust the "prefix" from run_builtin()
 5:  069b0339146 =  5:  844b4727ca3 grep.c: don't pass along NULL callback value
 6:  e38eca56959 =  6:  d9cf9bf5e37 grep API: call grep_config() after grep_init()
 -:  ----------- >  7:  57ecc5c0d65 grep.h: make "grep_opt.pattern_type_option" use its enum
 -:  ----------- >  8:  7dbeafde26b grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
 7:  88dfd40bf9e !  9:  c6ca39b4554 grep: simplify config parsing and option parsing
    @@ Commit message
         grep_init(), which means that much of the complexity here can go
         away.
     
    -    As before "grep.extendedRegexp" is a last-one-wins variable. We need
    -    to maintain state inside parse_pattern_type_arg() to ignore it if a
    -    non-"default" grep.patternType was seen, but otherwise flip between
    -    BRE and ERE for "grep.extendedRegexp=[false|true]".
    +    As before both "grep.patternType" and "grep.extendedRegexp" are
    +    last-one-wins variable, with "grep.extendedRegexp" yielding to
    +    "grep.patternType", except when "grep.patternType=default".
    +
    +    Note that this applies as we parse the config, i.e. a sequence of:
    +
    +        -c grep.patternType=perl
    +        -c grep.extendedRegexp=true \
    +        -c grep.patternType=default
    +
    +    Should select ERE due to "grep.extendedRegexp=true and
    +    grep.extendedRegexp=default", not BRE, even though that's the
    +    "default" patternType. We can determine this as we parse the config,
    +    because:
    +
    +     * If we see "grep.extendedRegexp" we set the internal "ero" to its
    +       boolean value.
    +
    +     * If we see "grep.extendedRegexp" but
    +       "grep.patternType=[default|<unset>]" is in effect we *don't* set
    +       the internal "pattern_type_option" to update the pattern type.
    +
    +     * If we see "grep.patternType!=default" we can set our internal
    +       "pattern_type_option" directly, it doesn't matter what the state of
    +       "grep.extendedRegexp" is, but we don't forget what it was, in case
    +       we see a "grep.patternType=default" again.
    +
    +     * If we see a "grep.patternType=default" we can set the pattern to
    +       ERE or BRE depending on whether we last saw a
    +       "grep.extendedRegexp=true" or
    +       "grep.extendedRegexp=[false|<unset>]".
    +
    +    We could equally call this new adjust_pattern_type() in
    +    compile_regexp(), i.e. this fixup on top of this passes all our
    +    tests (with -U0 for brevity):
    +
    +        @@ -60,0 +61 @@ static void adjust_pattern_type(enum grep_pattern_type *pto, const int ero)
    +        +static int ero = -1;
    +        @@ -65 +65,0 @@ int grep_config(const char *var, const char *value, void *cb)
    +        -       static int ero = -1;
    +        @@ -72 +71,0 @@ int grep_config(const char *var, const char *value, void *cb)
    +        -               adjust_pattern_type(&opt->pattern_type_option, ero);
    +        @@ -80 +78,0 @@ int grep_config(const char *var, const char *value, void *cb)
    +        -               adjust_pattern_type(&opt->pattern_type_option, ero);
    +        @@ -445,0 +444,2 @@ static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
    +        +       if (ero != -1)
    +        +               adjust_pattern_type(&opt->pattern_type_option, ero);
    +
    +    But doing it as we stream the git_config() makes it
    +    clear that we can determine the interplay between these two variables
    +    as we go. We don't need to wait until we see the last value of the two
    +    configuration variables.
    +
    +    This is true because of the rationale above, and because the
    +    subsequent code in compile_regexp() treats
    +    "pattern_type_option=GREP_PATTERN_TYPE_{UNSPECIFIED,BRE}"
    +    equally. I.e. we'll end up with different internal
    +    ""pattern_type_option" values there for:
    +
    +        # UNSPECIFIED
    +        -c grep.patternType=default
    +        # BRE
    +        -c grep.extendedRegexp=false -c grep.patternType=default
    +
    +    But the difference won't matter, which simplifies some of this logic,
    +    we never need to adjust a "grep.patternType" if we didn't see a
    +    "grep.extendedRegexp" before. We can also remove the
    +    "extended_regexp_option" member from "struct grep_opt" in favor of a
    +    static variable in grep_config().
    +
    +    The command-line parsing in cmd_grep() can then completely ignore
    +    "grep.extendedRegexp". Whatever effect it had before that step won't
    +    matter if we see -G, -E, -P etc.
     
         See my 07a3d411739 (grep: remove regflags from the public grep_opt
         API, 2017-06-29) for addition of the two comments being removed here,
         i.e. the complexity noted in that commit is now going away.
     
    -    We don't need grep_commit_pattern_type() anymore, we can instead have
    -    OPT_SET_INT() in "builtin/grep.c" manipulate the "pattern_type_option"
    -    member in "struct grep_opt" directly.
    -
    -    We can also do away with the indirection of the "int fixed" and "int
    -    pcre2" members in favor of using "pattern_type_option" directly in
    -    "grep.c".
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/grep.c ##
    @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
      		int fallback = 0;
     
      ## grep.c ##
    -@@ grep.c: static const char *color_grep_slots[] = {
    +@@ grep.c: static int parse_pattern_type_arg(const char *opt, const char *arg)
      
    - static int parse_pattern_type_arg(const char *opt, const char *arg)
    - {
    --	if (!strcmp(arg, "default"))
    --		return GREP_PATTERN_TYPE_UNSPECIFIED;
    --	else if (!strcmp(arg, "basic"))
    -+	if (!strcmp(arg, "basic"))
    - 		return GREP_PATTERN_TYPE_BRE;
    - 	else if (!strcmp(arg, "extended"))
    - 		return GREP_PATTERN_TYPE_ERE;
    + define_list_config_array_extra(color_grep_slots, {"match"});
    + 
    ++static void adjust_pattern_type(enum grep_pattern_type *pto, const int ero)
    ++{
    ++	if (*pto == GREP_PATTERN_TYPE_UNSPECIFIED)
    ++		*pto = ero ? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
    ++}
    ++
    + /*
    +  * Read the configuration file once and store it in
    +  * the grep_defaults template.
     @@ grep.c: int grep_config(const char *var, const char *value, void *cb)
    + {
    + 	struct grep_opt *opt = cb;
    + 	const char *slot;
    ++	static int ero = -1;
    + 
    + 	if (userdiff_config(var, value) < 0)
      		return -1;
      
      	if (!strcmp(var, "grep.extendedregexp")) {
    -+		if (opt->extended_regexp_option == -1)
    -+			return 0;
    - 		opt->extended_regexp_option = git_config_bool(var, value);
    -+		if (opt->extended_regexp_option)
    -+			opt->pattern_type_option = GREP_PATTERN_TYPE_ERE;
    -+		else
    -+			opt->pattern_type_option = GREP_PATTERN_TYPE_BRE;
    -+		return 0;
    -+	}
    -+
    -+	if (!strcmp(var, "grep.patterntype") &&
    -+	    !strcmp(value, "default")) {
    -+		opt->pattern_type_option = opt->extended_regexp_option == 1
    -+			? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
    +-		opt->extended_regexp_option = git_config_bool(var, value);
    ++		ero = git_config_bool(var, value);
    ++		adjust_pattern_type(&opt->pattern_type_option, ero);
      		return 0;
      	}
      
      	if (!strcmp(var, "grep.patterntype")) {
    -+		opt->extended_regexp_option = -1; /* ignore */
      		opt->pattern_type_option = parse_pattern_type_arg(var, value);
    ++		if (ero == -1)
    ++			return 0;
    ++		adjust_pattern_type(&opt->pattern_type_option, ero);
      		return 0;
      	}
    + 
     @@ grep.c: void grep_init(struct grep_opt *opt, struct repository *repo)
      	opt->header_tail = &opt->header_list;
      }
    @@ grep.c: static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
     -	p->fixed = opt->fixed;
     +	p->fixed = opt->pattern_type_option == GREP_PATTERN_TYPE_FIXED;
      
    --	if (memchr(p->pattern, 0, p->patternlen) && !opt->pcre2)
    +-	if (!opt->pcre2 &&
     +	if (opt->pattern_type_option != GREP_PATTERN_TYPE_PCRE &&
    -+	    memchr(p->pattern, 0, p->patternlen))
    + 	    memchr(p->pattern, 0, p->patternlen))
      		die(_("given pattern contains NULL byte (via -f <file>). This is only supported with -P under PCRE v2"));
      
    - 	p->is_fixed = is_fixed(p->pattern, p->patternlen);
     @@ grep.c: static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
      		return;
      	}
    @@ grep.c: static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
      	if (err) {
     
      ## grep.h ##
    -@@ grep.h: enum grep_expr_node {
    - };
    - 
    - enum grep_pattern_type {
    --	GREP_PATTERN_TYPE_UNSPECIFIED = 0,
    --	GREP_PATTERN_TYPE_BRE,
    -+	GREP_PATTERN_TYPE_BRE = 0,
    - 	GREP_PATTERN_TYPE_ERE,
    - 	GREP_PATTERN_TYPE_FIXED,
    - 	GREP_PATTERN_TYPE_PCRE
     @@ grep.h: struct grep_opt {
      	int unmatch_name_only;
      	int count;
    @@ grep.h: struct grep_opt {
      	int pathname;
      	int null_following_name;
     @@ grep.h: struct grep_opt {
    + 	int max_depth;
      	int funcname;
      	int funcbody;
    - 	int extended_regexp_option;
    --	int pattern_type_option;
    -+	enum grep_pattern_type pattern_type_option;
    +-	int extended_regexp_option;
    + 	enum grep_pattern_type pattern_type_option;
      	int ignore_locale;
      	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
    - 	unsigned pre_context;
    -@@ grep.h: struct grep_opt {
    - 	.relative = 1, \
    - 	.pathname = 1, \
    - 	.max_depth = -1, \
    --	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
    - 	.colors = { \
    - 		[GREP_COLOR_CONTEXT] = "", \
    - 		[GREP_COLOR_FILENAME] = "", \
     @@ grep.h: struct grep_opt {
      
      int grep_config(const char *var, const char *value, void *);
 -:  ----------- > 10:  b764c09d2b7 grep.[ch]: remove GREP_PATTERN_TYPE_UNSPECIFIED
-- 
2.34.1.1250.g6a242c1e9ad

