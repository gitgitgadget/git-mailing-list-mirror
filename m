Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B0F2C433EF
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 21:21:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241607AbiBDVVB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 16:21:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237265AbiBDVU6 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 16:20:58 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF9AC061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 13:20:56 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m26so5440127wms.0
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 13:20:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z7KOah3KKY40bIsiFlKmZsi6qJ+guwEZ9rqE5qm+f1Y=;
        b=k2UCKaY/0wQzLflZtmB9pbkflU6Zi3HXvZt59KZPXM4ZwyfrSxqWYZ/uw1D2htXfh0
         2u3fDcYWTpupGA3SRUMWXyzpCV34zAMCy7UvMMrxw4To6W30IAA11l/4y64N4xdm7lKz
         qndEX7jMGU8Q7x8YA4Hb8mlJnMYMNUQBmPXB1b7hvONOLDUupF+nKdyd5dc+hftD6/AH
         JHn6+RKn6iJDodXu6qyZMlveKZNaJeCezbfLA3nbGov621gactPanCB7S1XSq5hJiR4W
         2hJXZAAseksUSFhGgGvvNocwJWR7dAePG/83UipAolsVMBiZgRYZburLIDfv3h75cASb
         /RfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z7KOah3KKY40bIsiFlKmZsi6qJ+guwEZ9rqE5qm+f1Y=;
        b=0+rnVQMYfi/At0szziiQdCdUVRGyAZa8+AtRPobnRmUvAlPGA332wMcsG5GNizGjKS
         r6PzjGVS41+CUaFmGGgW8amt+ET2eK0metsGGDCfdJ/KwX5DGjd+NeQx3MDUbF5T5u8y
         7W9w0NH20rEMMzGeQV5KJ9+mQr3J8h1Kpuzj6eRhQ8En7auV5beMGmPO3fyG1OeOG1FS
         JJtH2Iy1junDMGTx4Fp+8dhbS9OX0CBgT5gTzgMMJRgGGleh02MFnCq/rDY34l2ACmyT
         cqoHaeRy/4D1phyv4WQVFPrB0Lvd+RNDO5zVbKTxmafN7TJ6z0J9zstf9ErSo0gDBk0S
         pUnw==
X-Gm-Message-State: AOAM531rxsBD31YduKvKOryljZgC2cDtsRW9BIXLxRom8lwYyqCs0kDe
        jCSokeqFMoLOd4eJYciX9ENi10HZhtt3Bg==
X-Google-Smtp-Source: ABdhPJyjOnS4RHLtIbqeaORfUGcxWM4Mm8O+d4WphGG7uI09Z21o1qIjoTG622s+6oLzZHBWg90Csw==
X-Received: by 2002:a05:600c:20d3:: with SMTP id y19mr505369wmm.1.1644009654675;
        Fri, 04 Feb 2022 13:20:54 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o21sm2321598wmh.36.2022.02.04.13.20.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 13:20:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 0/9] grep: simplify & delete "init" & "config" code
Date:   Fri,  4 Feb 2022 22:20:42 +0100
Message-Id: <cover-v10-0.9-00000000000-20220204T211534Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
References: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series makes using the grep.[ch] API easier, by having it follow
the usual pattern of being initialized with:

    defaults -> config -> command-line

This is to make some follow-up work easier, this is a net code
deletion if we exclude newly added tests.

Changes since v9:

 * Integrated the proposed fixup from Junio's branch, and updated both
   the tests and commit messages accordingly. I changed "BRE" and
   "ERE" in the test descriptions to indicate what we're expecting to
   match as, and added the relevant test's from Junio's comments on an
   earlier round.

Junio: Sorry about the back & forth on this series. Each time I came
back to it it had been a while, and between a large mail queue and
fixing some isolated issues manged to lose the larger problem you were
pointing out. Thanks again!

Ævar Arnfjörð Bjarmason (9):
  grep.h: remove unused "regex_t regexp" from grep_opt
  log tests: check if grep_config() is called by "log"-like cmds
  grep tests: add missing "grep.patternType" config tests
  built-ins: trust the "prefix" from run_builtin()
  grep.c: don't pass along NULL callback value
  grep API: call grep_config() after grep_init()
  grep.h: make "grep_opt.pattern_type_option" use its enum
  grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
  grep: simplify config parsing and option parsing

 builtin/grep.c    |  27 +++++------
 builtin/log.c     |  13 +++++-
 builtin/ls-tree.c |   2 +-
 git.c             |   1 +
 grep.c            | 113 ++++++----------------------------------------
 grep.h            |  31 +++++++++----
 revision.c        |   4 +-
 t/t4202-log.sh    |  24 ++++++++++
 t/t7810-grep.sh   |  96 +++++++++++++++++++++++++++++++++++++++
 9 files changed, 185 insertions(+), 126 deletions(-)

Range-diff against v9:
 1:  b9372cde017 =  1:  184f7e0c5bd grep.h: remove unused "regex_t regexp" from grep_opt
 2:  30219a0ae9d =  2:  ac397cc6a18 log tests: check if grep_config() is called by "log"-like cmds
 3:  a75b288340b !  3:  3464c76cfd7 grep tests: add missing "grep.patternType" config tests
    @@ Commit message
         followed by a "grep.extendedRegexp=false" behaves as though
         "grep.extendedRegexp" wasn't provided.
     
    +    See [1] for the source of some of these tests, and their
    +    initial (pseudocode) implementation, and [2] for a later discussion
    +    about a breakage due to missing testing (which had been noted in [1]
    +    all along).
    +
    +    1. https://lore.kernel.org/git/xmqqv8zf6j86.fsf@gitster.g/
    +    2. https://lore.kernel.org/git/xmqqpmoczwtu.fsf@gitster.g/
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Signed-off-by: Junio C Hamano <gitster@pobox.com>
     
    @@ t/t7810-grep.sh: do
     +		test_cmp expected actual
     +	'
     +
    -+	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (BRE)" '
    ++	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (ERE)" '
     +		echo "${HC}ab:abc" >expected &&
     +		git \
     +			-c grep.patternType=fixed \
    @@ t/t7810-grep.sh: do
     +	'
     +
     +	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (ERE)" '
    ++		echo "${HC}ab:abc" >expected &&
    ++		git \
    ++			-c grep.extendedRegexp=false \
    ++			-c grep.patternType=default \
    ++			-c grep.extendedRegexp=true \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
    ++
    ++	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (BRE)" '
    ++		echo "${HC}ab:a+bc" >expected &&
    ++		git \
    ++			-c grep.extendedRegexp=true \
    ++			-c grep.extendedRegexp=false \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
    ++
    ++	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (BRE)" '
    ++		echo "${HC}ab:abc" >expected &&
    ++		git \
    ++			-c grep.extendedRegexp=false \
    ++			-c grep.extendedRegexp=true \
    ++			-c grep.patternType=default \
    ++			grep "a+b*c" $H ab >actual &&
    ++		test_cmp expected actual
    ++	'
    ++
    ++	test_expect_success "grep $L with grep.extendedRegexp and grep.patternType are both last-one-wins independently (BRE)" '
     +		echo "${HC}ab:a+bc" >expected &&
     +		git \
     +			-c grep.patternType=default \
    @@ t/t7810-grep.sh: do
     +			grep "a+b*c" $H ab >actual &&
     +		test_cmp expected actual
     +	'
    -+
     +	test_expect_success "grep $L with grep.patternType=extended and grep.patternType=default" '
     +		echo "${HC}ab:a+bc" >expected &&
     +		git \
 4:  6e7f9730a7d =  4:  c6ada96298a built-ins: trust the "prefix" from run_builtin()
 5:  fbcfea84696 =  5:  1f09de53e07 grep.c: don't pass along NULL callback value
 6:  96c8cc7806e =  6:  ce646154538 grep API: call grep_config() after grep_init()
 7:  e09616056b4 =  7:  6446b4f0f33 grep.h: make "grep_opt.pattern_type_option" use its enum
 8:  61fc6a4dac8 =  8:  df8ba5aba68 grep.c: do "if (bool && memchr())" not "if (memchr() && bool)"
 9:  445467e87f7 !  9:  ccbdfa48315 grep: simplify config parsing and option parsing
    @@ Commit message
         last-one-wins variable, with "grep.extendedRegexp" yielding to
         "grep.patternType", except when "grep.patternType=default".
     
    -    Note that this applies as we parse the config, i.e. a sequence of:
    +    Note that as the previously added tests indicate this cannot be done
    +    on-the-fly as we see the config variables, without introducing more
    +    state keeping. I.e. if we see:
     
    -        -c grep.patternType=perl
    -        -c grep.extendedRegexp=true \
    +        -c grep.extendedRegexp=false
             -c grep.patternType=default
    +        -c extendedRegexp=true
    +
    +    We need to select ERE, since grep.patternType=default unselects that
    +    variable, which normally has higher precedence, but we also need to
    +    select BRE in cases of:
     
    -    should select ERE due to "grep.extendedRegexp=true and
    -    grep.patternType=default". We can determine this as we parse the
    -    config, because:
    +        -c grep.extendedRegexp=true \
    +        -c grep.extendedRegexp=false
     
    -     * If we see "grep.extendedRegexp" we set "extended_regexp_option" to
    -       its boolean value.
    +    Which would not be the case for this, which select ERE:
     
    -     * If we see "grep.extendedRegexp" but
    -       "grep.patternType=[default|<unset>]" is in effect we *don't* set
    -       the internal "pattern_type_option" to update the pattern type.
    +        -c grep.patternType=extended \
    +        -c grep.extendedRegexp=false
     
    -     * If we see "grep.patternType!=default" we can set our internal
    -       "pattern_type_option" directly, it doesn't matter what the state of
    -       "extended_regexp_option" is, but we don't forget what it was, in
    -       case we see a "grep.patternType=default" again.
    +    Therefore we cannot do this on-the-fly in grep_config without also
    +    introducing tracking variables for not only the pattern type, but what
    +    the source of that pattern type was.
     
    -     * If we see a "grep.patternType=default" we can set the pattern to
    -       ERE or BRE depending on whether we last saw a
    -       "grep.extendedRegexp=true" or
    -       "grep.extendedRegexp=[false|<unset>]".
    +    So we need to decide on the pattern after our config was fully
    +    parsed. Let's do that by deferring the decision on the pattern type
    +    until it's time to compile it in compile_regexp().
     
    -    With this change the "extended_regexp_option" member is only used
    -    within grep_config(), and in the current codebase we could equally
    -    track it as a "static" variable within that function, see [1] for a
    -    version for this patch that did that. We're keeping it a struct member
    -    to make that function reentrant, in case it ends up mattering in the
    -    future.
    +    By that time we've not only parsed the config, but also handled the
    +    command-line options. Those will set "opt.pattern_type_option" (*not*
    +    "opt.extended_regexp_option"!).
     
    -    The command-line parsing in cmd_grep() can then completely ignore
    -    "grep.extendedRegexp". Whatever effect it had before that step won't
    -    matter if we see -G, -E, -P etc.
    +    At that point all we need to do is see if "grep.patternType" was
    +    UNSPECIFIED in the end (including an explicit "=default"), if so we'll
    +    use the "grep.extendedRegexp" configuration, if any.
     
         See my 07a3d411739 (grep: remove regflags from the public grep_opt
         API, 2017-06-29) for addition of the two comments being removed here,
    @@ builtin/grep.c: int cmd_grep(int argc, const char **argv, const char *prefix)
      		int fallback = 0;
     
      ## grep.c ##
    -@@ grep.c: static int parse_pattern_type_arg(const char *opt, const char *arg)
    - 
    - define_list_config_array_extra(color_grep_slots, {"match"});
    - 
    -+static void adjust_pattern_type(enum grep_pattern_type *pto, const int ero)
    -+{
    -+	if (*pto == GREP_PATTERN_TYPE_UNSPECIFIED)
    -+		*pto = ero ? GREP_PATTERN_TYPE_ERE : GREP_PATTERN_TYPE_BRE;
    -+}
    -+
    - /*
    -  * Read the configuration file once and store it in
    -  * the grep_defaults template.
    -@@ grep.c: int grep_config(const char *var, const char *value, void *cb)
    - 
    - 	if (!strcmp(var, "grep.extendedregexp")) {
    - 		opt->extended_regexp_option = git_config_bool(var, value);
    -+		adjust_pattern_type(&opt->pattern_type_option,
    -+				    opt->extended_regexp_option);
    - 		return 0;
    - 	}
    - 
    - 	if (!strcmp(var, "grep.patterntype")) {
    - 		opt->pattern_type_option = parse_pattern_type_arg(var, value);
    -+		if (opt->extended_regexp_option == -1)
    -+			return 0;
    -+		adjust_pattern_type(&opt->pattern_type_option,
    -+				    opt->extended_regexp_option);
    - 		return 0;
    - 	}
    - 
     @@ grep.c: void grep_init(struct grep_opt *opt, struct repository *repo)
      	opt->header_tail = &opt->header_list;
      }
    @@ grep.c: void grep_init(struct grep_opt *opt, struct repository *repo)
      					const char *origin, int no,
      					enum grep_pat_token t,
     @@ grep.c: static void compile_regexp(struct grep_pat *p, struct grep_opt *opt)
    + 	int err;
    + 	int regflags = REG_NEWLINE;
      
    ++	if (opt->pattern_type_option == GREP_PATTERN_TYPE_UNSPECIFIED)
    ++		opt->pattern_type_option = (opt->extended_regexp_option
    ++					    ? GREP_PATTERN_TYPE_ERE
    ++					    : GREP_PATTERN_TYPE_BRE);
    ++
      	p->word_regexp = opt->word_regexp;
      	p->ignore_case = opt->ignore_case;
     -	p->fixed = opt->fixed;
    @@ grep.h: struct grep_opt {
      	int pathname;
      	int null_following_name;
     @@ grep.h: struct grep_opt {
    - 	.relative = 1, \
    - 	.pathname = 1, \
    - 	.max_depth = -1, \
    -+	.extended_regexp_option = -1, \
    - 	.pattern_type_option = GREP_PATTERN_TYPE_UNSPECIFIED, \
    - 	.colors = { \
    - 		[GREP_COLOR_CONTEXT] = "", \
    -@@ grep.h: struct grep_opt {
      
      int grep_config(const char *var, const char *value, void *);
      void grep_init(struct grep_opt *, struct repository *repo);
-- 
2.35.1.940.ge7a5b4b05f2

