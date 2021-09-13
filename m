Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2298EC43219
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 04BFA6101E
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 00:13:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236811AbhIMAOw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Sep 2021 20:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234094AbhIMAOw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Sep 2021 20:14:52 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36047C061574
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:13:37 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id u19-20020a7bc053000000b002f8d045b2caso5366031wmc.1
        for <git@vger.kernel.org>; Sun, 12 Sep 2021 17:13:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=KEoN96mgyNmp9kkI+rs2LeDYoaCPTvANOj0oN88d9yc=;
        b=afKael4xI5ml0jKo+bOVkEslaSB3Pbe3GlVUPOCL88IudOydCda2cIuZHUINGn+SS6
         BfkR9GhZqqkaJZIZ7U3gpr7JoSeYSm/OMCxQ+O/3QrTC9vmLYImnv/DS+6otkYNjOKrm
         Z21eJ/wzpmSxLLD8efSSGMXMHYR4csuHFmI3vlKueP2q4eTncJKyYN1JR/XXNvA9Vpw3
         BJFFaPYCA1pIBEc5oOk8fpIHK5HGvGOiKioe0fdH2GtrUFBUErn4otAxSkmXbmxoHL08
         GCRvE/UZglK4g7RX5HyAYCTYe+J+FkKy2OftZOIpSn3ro9DTwbxRwTkF8ISJIjPly9Bx
         Zljw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=KEoN96mgyNmp9kkI+rs2LeDYoaCPTvANOj0oN88d9yc=;
        b=gsOcx2V1gxh+vQ7qaEZctYnZA3FuIeqrsvPoLsg07QGZzI2BiWTI2uT9OLt91qc3hD
         uvZGjjTv8Vng+fOL/2NzviUke4BnuIpc6ltOGifU9+duLUwO0LZhbI8hkjFkUxCcw2gl
         8t74EDvcRJqaZyaEsMcP6UqZlrUCGEq7qf+VjeqP3OwZjkkq6NN82zdhJddaf7j3P/8+
         sHy9dxPptI80qLdSgQJkrQYObfpS19tINoIXveWouFa92MN/s/O8CKjwDun3i1OHpkmP
         erwwniCko8N6eZgI0riGVaW03M6yv4JmvRMGZX2hAu4ube9ITKVknMTJJUpewinHy+MX
         9+bQ==
X-Gm-Message-State: AOAM530rPo8RORLJC5VkghPng2FpDXVBXQXOBGEbIADfts6QHF939ubo
        O9vrDxmiBlRF1lbqwNQw9WmW9sewqBiTJw==
X-Google-Smtp-Source: ABdhPJyi2nvRumbL/8ertAqJbYBKkyZO7y/EDhs1o306w7jouRiG7h1GWtM3vFvcofrcRdlAshHtjw==
X-Received: by 2002:a05:600c:4fc8:: with SMTP id o8mr8398899wmq.153.1631492015184;
        Sun, 12 Sep 2021 17:13:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j14sm5827974wrp.21.2021.09.12.17.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Sep 2021 17:13:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Carlo Arenas <carenas@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 0/4] parse-options: properly align continued usage output
Date:   Mon, 13 Sep 2021 02:13:18 +0200
Message-Id: <cover-v4-0.4-00000000000-20210912T235347Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1001.g3ab2ac1eaae
In-Reply-To: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
References: <cover-v3-0.6-00000000000-20210911T190239Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series changes usage_with_options_internal() in parse-options.c
to properly align continued "\n" usage output.

This v4 essentially goes back to the version of this in v1. In v2 I'd
addressed Eric's comments in [1] by trying to remove the last three
in-tree users of this part of the API.

But if "git rev-parse --parseopt" is going to be bug-for-bug
compatible with existing out-of-tree users[2] then changing that
becomes a non-starter.

So let's keep the existing behavior (which also had at least one other
weird & undocumented edge case, which we now test for).

This v4 also has a fix for the "saw_empty_line" bug Eric noted in [2]
(which wasn't applicable to v2..v3), and takes some of his suggestions
for simplifying the loop (but not all, I still kept it as one loop).

1. https://lore.kernel.org/git/f8560b11-ba56-0a52-8bb4-5b71f0657764@sunshineco.com/
2. https://lore.kernel.org/git/xmqqpmtdjuqj.fsf@gitster.g/

Ævar Arnfjörð Bjarmason (4):
  parse-options API users: align usage output in C-strings
  send-pack: properly use parse_options() API for usage string
  git rev-parse --parseopt tests: add more usagestr tests
  parse-options: properly align continued usage output

 Documentation/git-send-pack.txt |  4 +-
 builtin/ls-remote.c             |  4 +-
 builtin/send-pack.c             |  8 ++--
 builtin/show-branch.c           |  6 +--
 builtin/stash.c                 |  2 +-
 builtin/tag.c                   |  4 +-
 parse-options.c                 | 76 +++++++++++++++++++++++++++------
 t/t1502-rev-parse-parseopt.sh   | 54 +++++++++++++++++++++++
 8 files changed, 132 insertions(+), 26 deletions(-)

Range-diff against v3:
1:  ad857e80fd8 < -:  ----------- credential-cache{,--daemon}: don't build under NO_UNIX_SOCKETS
2:  036eb0efb5b < -:  ----------- blame: replace usage end blurb with better option spec
4:  5638d2bc832 ! 1:  64d8647340d built-ins: "properly" align continued usage output
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    built-ins: "properly" align continued usage output
    +    parse-options API users: align usage output in C-strings
     
    -    Let's "fix" various "git <cmd> -h" output by "properly" aligning the
    -    output in cases where we continue usage output after a "\n". The "fix"
    -    and "properly" scare quotes are because this actually makes things
    -    worse in some cases, because e.g. in the case of "git tag -h" the
    -    "\t\t" effectively works around how parse-options.c aligns this
    -    output.
    +    In preparation for having continued usage lines properly aligned in
    +    "git <cmd> -h" output, let's have the "[" on the second such lines
    +    align with the "[" on the first line.
     
    -    But two wrongs don't make a right, let's "fix" this by making it worse
    -    temporarily, in anticipation of improving parse-options.c to handle
    -    this alignment.
    +    In some cases this makes the output worse, because e.g. the "git
    +    ls-remote -h" output had been aligned to account for the extra
    +    whitespace that the usage_with_options_internal() function in
    +    parse-options.c would add.
     
    -    The issue is that we should have whitespace corresponding to the
    -    length of the command name here, e.g. in the case of "git ls-remote"
    -    it should be 14 characters, or the length of ""git ls-remote
    -    ". Instead we had 21 characters in builtin/ls-remote.c, those extra 7
    -    characters are the length of "usage: " (and also " or:"). So in the C
    -    locale the resulting output aligns nicely:
    +    In other cases such as builtin/stash.c (not changed here), we were
    +    aligned in the C strings, but since that didn't account for the extra
    +    padding in usage_with_options_internal() it would come out looking
    +    misaligned, e.g. code like this:
     
    -        $ git ls-remote -h
    -        usage: git ls-remote [--heads] [--tags] [--refs] [--upload-pack=<exec>]
    -                             [-q | --quiet] [--exit-code] [--get-url]
    -                             [--symref] [<repository> [<refs>...]]
    +            N_("git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
    +               "          [-u|--include-untracked] [-a|--all] [-m|--message <message>]\n"
     
    -    But that's fragile, we might not be under the C locale. We really
    -    should have parse-options.c itself add this padding. In a subsequent
    -    commit I'll make it do that.
    +    Would emit:
     
    -    In the case of "tag" and "show-branch" and "stash save" the output was
    -    not properly aligned, although in the "git tag" case it was
    -    near-enough (aligned with the "-" in "git tag -l") to look good,
    -    assuming C locale & a tab-width of 8. In any case, let's align this in
    -    a way that looks obviously correct when looking at the source itself,
    -    and then improve parse-options.c itself.
    +       or: git stash [push [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]
    +              [-u|--include-untracked] [-a|--all] [-m|--message <message>]
    +
    +    Let's change all the usage arrays which use such continued usage
    +    output via "\n"-embedding to be like builtin/stash.c.
    +
    +    This makes the output worse temporarily, but in a subsequent change
    +    I'll improve the usage_with_options_internal() to take this into
    +    account, at which point all of the strings being changed here will
    +    emit prettier output.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
5:  821e5e14132 = 2:  f10ff775c69 send-pack: properly use parse_options() API for usage string
3:  e23a8231f38 ! 3:  05a0c7cac37 parse-options: stop supporting "" in the usagestr array
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    parse-options: stop supporting "" in the usagestr array
    +    git rev-parse --parseopt tests: add more usagestr tests
     
    -    The strings in the the "usagestr" array have special handling for the
    -    empty string dating back to f389c808b67 (Rework make_usage to print
    -    the usage message immediately, 2007-10-14).
    +    Add tests for the "usagestr" passed to parse-options.c
    +    usage_with_options_internal() through cmd_parseopt().
     
    -    We'll prefix all strings after the first one with "or: ". Then if we
    -    encountered a "" we'll emit all strings after that point verbatim
    -    without any "or: " prefixing.
    -
    -    In the preceding commits we got rid of the two users of this
    -    undocumented part of the API. Let's remove it in preparation for
    -    improving the output emitted by usage_with_options_internal().
    -
    -    I think we might want to use this in the future, but in that case
    -    we'll be much better off with an API that emulates the
    -    non-parse_options() way that git.c does this.
    -
    -    That git.c code uses a separate "git_usage_string" and
    -    "git_more_info_string". See b7d9681974e (Print info about "git help
    -    COMMAND" on git's main usage pages, 2008-06-06). By splitting the two
    -    up we can emit something in the middle, as indeed git.c does.
    -
    -    I'd like our "git <cmd> -h" info to be more helpful, and I'd also like
    -    parse_options() to handle the "git" command itself, because of the
    -    limitations of how this was done in usage_with_options_internal() we
    -    couldn't migrate a caller like git.c to parse_options().
    -
    -    So let's just remove this for now, it has no users, and once we want
    -    to do this again we can simply add another argument to the relevant
    -    functions, or otherwise hook into things so that we can print
    -    something at the end and/or middle.
    -
    -    It's possible that this change introduce breakage somewhere. We'd only
    -    catch these cases at runtime, and the "git rev-parse --parseopt"
    -    command is used by shellscripts, see bac199b7b17 (Update
    -    git-sh-setup(1) to allow transparent use of git-rev-parse --parseopt,
    -    2007-11-04). I've grepped the codebase for "OPTIONS_SPEC",
    -    "char.*\*.*usage\[\]" etc. I'm fairly sure there no outstanding users
    -    of this functionality.
    +    These test for edge cases in the existing behavior related to the
    +    "--parseopt" interface doing its own line-splitting with
    +    strbuf_getline(), and the native C interface expecting and potentially
    +    needing to handle newlines within the strings in the array it
    +    accepts. The results are probably something that wasn't anticipated,
    +    but let's make sure we stay backwards compatible with it.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    - ## builtin/rev-parse.c ##
    -@@ builtin/rev-parse.c: static int cmd_parseopt(int argc, const char **argv, const char *prefix)
    - 	for (;;) {
    - 		if (strbuf_getline(&sb, stdin) == EOF)
    - 			die(_("premature end of input"));
    -+		if (!sb.len)
    -+			die(_("empty lines are not permitted before the `--' separator"));
    - 		ALLOC_GROW(usage, unb + 1, usz);
    -+
    - 		if (!strcmp("--", sb.buf)) {
    - 			if (unb < 1)
    - 				die(_("no usage string given before the `--' separator"));
    -
    - ## parse-options.c ##
    -@@ parse-options.c: static int usage_with_options_internal(struct parse_opt_ctx_t *ctx,
    - 		fprintf(outfile, "cat <<\\EOF\n");
    - 
    - 	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
    --	while (*usagestr && **usagestr)
    -+	while (*usagestr) {
    - 		/*
    - 		 * TRANSLATORS: the colon here should align with the
    - 		 * one in "usage: %s" translation.
    - 		 */
    - 		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
    --	while (*usagestr) {
    --		if (**usagestr)
    --			fprintf_ln(outfile, _("    %s"), _(*usagestr));
    --		else
    --			fputc('\n', outfile);
    --		usagestr++;
    - 	}
    - 
    - 	need_newline = 1;
    -
    - ## t/helper/test-parse-options.c ##
    -@@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, const char **argv)
    - 	const char *prefix = "prefix/";
    - 	const char *usage[] = {
    - 		"test-tool parse-options <options>",
    --		"",
    --		"A helper function for the parse-options API.",
    - 		NULL
    - 	};
    - 	struct string_list expect = STRING_LIST_INIT_NODUP;
    -
    - ## t/t0040-parse-options.sh ##
    -@@ t/t0040-parse-options.sh: test_description='our own option parser'
    - cat >expect <<\EOF
    - usage: test-tool parse-options <options>
    - 
    --    A helper function for the parse-options API.
    --
    -     --yes                 get a boolean
    -     -D, --no-doubt        begins with 'no-'
    -     -B, --no-fear         be brave
    -
      ## t/t1502-rev-parse-parseopt.sh ##
    -@@ t/t1502-rev-parse-parseopt.sh: test_description='test git rev-parse --parseopt'
    - test_expect_success 'setup optionspec' '
    - 	sed -e "s/^|//" >optionspec <<\EOF
    - |some-command [options] <args>...
    --|
    --|some-command does foo and bar!
    - |--
    - |h,help    show the help
    - |
    -@@ t/t1502-rev-parse-parseopt.sh: EOF
    - test_expect_success 'setup optionspec-no-switches' '
    - 	sed -e "s/^|//" >optionspec_no_switches <<\EOF
    - |some-command [options] <args>...
    --|
    --|some-command does foo and bar!
    - |--
    - EOF
    - '
    -@@ t/t1502-rev-parse-parseopt.sh: EOF
    - test_expect_success 'setup optionspec-only-hidden-switches' '
    - 	sed -e "s/^|//" >optionspec_only_hidden_switches <<\EOF
    - |some-command [options] <args>...
    --|
    --|some-command does foo and bar!
    - |--
    - |hidden1* A hidden switch
    - EOF
    -@@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'test --parseopt help output' '
    - |cat <<\EOF
    - |usage: some-command [options] <args>...
    - |
    --|    some-command does foo and bar!
    --|
    - |    -h, --help            show the help
    - |    --foo                 some nifty option --foo
    - |    --bar ...             some cool option --bar with an argument
    -@@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'test --parseopt help output no switches' '
    - |cat <<\EOF
    - |usage: some-command [options] <args>...
    - |
    --|    some-command does foo and bar!
    --|
    - |EOF
    - END_EXPECT
    - 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_no_switches &&
    -@@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'test --parseopt help output hidden switches' '
    - |cat <<\EOF
    - |usage: some-command [options] <args>...
    - |
    --|    some-command does foo and bar!
    --|
    - |EOF
    - END_EXPECT
    - 	test_expect_code 129 git rev-parse --parseopt -- -h > output < optionspec_only_hidden_switches &&
    -@@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'test --parseopt help-all output hidden switches' '
    - |cat <<\EOF
    - |usage: some-command [options] <args>...
    - |
    --|    some-command does foo and bar!
    --|
    - |    --hidden1             A hidden switch
    - |
    - |EOF
    -@@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'test --parseopt invalid switch help output' '
    - |error: unknown option `does-not-exist'\''
    - |usage: some-command [options] <args>...
    - |
    --|    some-command does foo and bar!
    --|
    - |    -h, --help            show the help
    - |    --foo                 some nifty option --foo
    - |    --bar ...             some cool option --bar with an argument
     @@ t/t1502-rev-parse-parseopt.sh: test_expect_success 'test --parseopt --stuck-long and short option with unset op
      	test_cmp expect output
      '
      
    -+test_expect_success 'test --parseopt help output hidden switches' '
    -+	sed -e "s/^|//" >optionspec-trailing-line <<-\EOF &&
    -+	|some-command [options] <args>...
    ++test_expect_success 'test --parseopt help output: "wrapped" options normal "or:" lines' '
    ++	sed -e "s/^|//" >spec <<-\EOF &&
    ++	|cmd [--some-option]
    ++	|    [--another-option]
    ++	|cmd [--yet-another-option]
    ++	|--
    ++	|h,help    show the help
    ++	EOF
    ++
    ++	sed -e "s/^|//" >expect <<-\END_EXPECT &&
    ++	|cat <<\EOF
    ++	|usage: cmd [--some-option]
    ++	|   or:     [--another-option]
    ++	|   or: cmd [--yet-another-option]
    ++	|
    ++	|    -h, --help            show the help
     +	|
    ++	|EOF
    ++	END_EXPECT
    ++
    ++	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
    ++	test_cmp expect actual
    ++'
    ++
    ++test_expect_success 'test --parseopt help output: multi-line blurb after empty line' '
    ++	sed -e "s/^|//" >spec <<-\EOF &&
    ++	|cmd [--some-option]
    ++	|    [--another-option]
     +	|
    ++	|multi
    ++	|line
    ++	|blurb
     +	|--
     +	|h,help    show the help
     +	EOF
     +
    -+	cat >expect <<-\EOF &&
    -+	fatal: empty lines are not permitted before the `--'"'"' separator
    -+	EOF
    ++	sed -e "s/^|//" >expect <<-\END_EXPECT &&
    ++	|cat <<\EOF
    ++	|usage: cmd [--some-option]
    ++	|   or:     [--another-option]
    ++	|
    ++	|    multi
    ++	|    line
    ++	|    blurb
    ++	|
    ++	|    -h, --help            show the help
    ++	|
    ++	|EOF
    ++	END_EXPECT
     +
    -+	test_must_fail git rev-parse --parseopt -- -h >out < optionspec-trailing-line 2>actual &&
    -+	test_must_be_empty out &&
    ++	test_must_fail git rev-parse --parseopt -- -h >out <spec >actual &&
     +	test_cmp expect actual
     +'
     +
6:  0df2840ce4e ! 4:  55480dee680 parse-options: properly align continued usage output
    @@ Commit message
         automatically, 2007-10-15) which isn't RTL-safe, but that code would
         be easy to fix. Let's not introduce new RTL translation problems here.
     
    -    I'm also adding a check to catch the mistake of needlessly adding a
    -    trailing "\n", such as:
    -
    -            N_("git stash save [-p|--patch] [-k|--[no-]keep-index] [-q|--quiet]\n"
    -               "          [-u|--include-untracked] [-a|--all] [<message>]\n"),
    -
    -    Or even a mistake like adding just one "\n" in a string with no other
    -    newlines:
    -
    -            N_("git stash list [<options>]\n"),
    -
    -    This catches the cases already tested for in cmd_parseopt(), but this
    -    covers the purely C API. As noted a preceding commit that added the
    -    die() to cmd_parseopt() I'm fairly confident that this will be
    -    triggered by no in-tree user I've missed.
    -
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## parse-options.c ##
    @@ parse-options.c: static int usage_with_options_internal(struct parse_opt_ctx_t *
     +	 * one in "usage: %s" translation.
     +	 */
     +	const char *or_prefix = _("   or: %s");
    -+
     +	/*
     +	 * TRANSLATORS: You should only need to translate this format
     +	 * string if your language is a RTL language (e.g. Arabic,
    @@ parse-options.c: static int usage_with_options_internal(struct parse_opt_ctx_t *
     +	 */
     +	const char *usage_continued = _("%*s%s");
     +	const char *prefix = usage_prefix;
    ++	int saw_empty_line = 0;
     +
      	if (!usagestr)
      		return PARSE_OPT_HELP;
    @@ parse-options.c: static int usage_with_options_internal(struct parse_opt_ctx_t *
      		fprintf(outfile, "cat <<\\EOF\n");
      
     -	fprintf_ln(outfile, _("usage: %s"), _(*usagestr++));
    - 	while (*usagestr) {
    +-	while (*usagestr && **usagestr)
     -		/*
     -		 * TRANSLATORS: the colon here should align with the
     -		 * one in "usage: %s" translation.
     -		 */
     -		fprintf_ln(outfile, _("   or: %s"), _(*usagestr++));
    + 	while (*usagestr) {
    +-		if (**usagestr)
    +-			fprintf_ln(outfile, _("    %s"), _(*usagestr));
    +-		else
    +-			fputc('\n', outfile);
    +-		usagestr++;
    ++		const char *str = _(*usagestr++);
     +		struct string_list list = STRING_LIST_INIT_DUP;
     +		unsigned int j;
     +
    -+		string_list_split(&list, _(*usagestr++), '\n', -1);
    ++		if (!saw_empty_line && !*str)
    ++			saw_empty_line = 1;
    ++
    ++		string_list_split(&list, str, '\n', -1);
     +		for (j = 0; j < list.nr; j++) {
     +			const char *line = list.items[j].string;
     +
    -+			if (!*line)
    -+				BUG("empty or trailing line in usage string");
    -+
    -+			if (!j)
    ++			if (saw_empty_line && *line)
    ++				fprintf_ln(outfile, _("    %s"), line);
    ++			else if (saw_empty_line)
    ++				fputc('\n', outfile);
    ++			else if (!j)
     +				fprintf_ln(outfile, prefix, line);
     +			else
     +				fprintf_ln(outfile, usage_continued,
-- 
2.33.0.1001.g3ab2ac1eaae

