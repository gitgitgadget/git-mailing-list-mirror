Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AAD5C433EF
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E935E610A1
	for <git@archiver.kernel.org>; Tue, 21 Sep 2021 22:40:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbhIUWmN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Sep 2021 18:42:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhIUWmN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Sep 2021 18:42:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1209C061574
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:43 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id t18so1335050wrb.0
        for <git@vger.kernel.org>; Tue, 21 Sep 2021 15:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Quh58VJpqXsc1O2wEB0DJlgbeIwDMjJcfvvoHyYy3mY=;
        b=Z8Qo81NBwwtxWlUTtDo4QxpKnuv3y5ITf6oiJCfCm3kcOFynw4llPOevzOojLJX2ZF
         +jcyAomg/MmrB1gCZ0EckP9oPLHSWloAWlPVx5ugp6GQKeuDFqlAl30z5YdlcsGKos1V
         ftrWrPtHCuIS2nKzPE54x9Gip+l6C1BfcNeHKJfgIlTyKFytz0gHxujzCFN4exvvpCia
         R3dK7cemu4Di+/JilgWByAq9aMd+n5OnCjRJMZCQc5tAiOBuI+L7b5X2rkYxjmZZK410
         8uXdxnR3LrS/GXa5fYNyyDf7MLhLebMjbHCJzUrz1a8F4WqgGkHQprxb9CckgMz8ZsyV
         6lWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Quh58VJpqXsc1O2wEB0DJlgbeIwDMjJcfvvoHyYy3mY=;
        b=leVKdlh04btJEwTHAnHnwut2ghTq6iWygxXJVozyicP0jkl3i8Exu75Inc6Ac93eH+
         w+oQUT3NQuW9zgomeOra0aZOd83WgK6Tes4apjcNtYer4FCl02ggsU5S1QcKpi5D/xmm
         fZJbqUDpiAkRCOf3aoqwJ+5K8BLT2hmVPa/fyZRAHB69mOfOwONeFhGebyUkJSvZ5D/s
         XcWiezjL5/SbBs/P1F+fL9qCmBpWLyYFQOgnfEFCL+TnDIn4ieBt+ZtDxyGDm3gq44Fl
         aeDL7DH22gxYOb11siSmhA60xorg/hh/GMIKv0JTd6NBwDeiiVLe2nTnVUQZqxCo6Rgx
         P0sQ==
X-Gm-Message-State: AOAM532dHpGP9VxgdYAbOiJJMqpG7aYbPfsrbruSp3cxP5UYyDRL8kMa
        WIqrDS1r1oZTZb8nL8AT9TfgwtEUFY0KfQ==
X-Google-Smtp-Source: ABdhPJxRLy30emsm7WOENXPYHHG7y8Y9roFGKlYEEDiAtFw9WyGK1mUPXGvjur67j4qHl4x5ohbpDw==
X-Received: by 2002:a5d:6c69:: with SMTP id r9mr30846959wrz.78.1632264041844;
        Tue, 21 Sep 2021 15:40:41 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm3846121wmp.48.2021.09.21.15.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Sep 2021 15:40:41 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] help: fix usage nits & bugs, completion shellscript->C
Date:   Wed, 22 Sep 2021 00:40:30 +0200
Message-Id: <cover-v3-0.9-00000000000-20210921T223223Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1098.gf02a64c1a2d
In-Reply-To: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
References: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series fixes various bugs & edge cases in the "git help" command,
and improves and splits the internal-only "--completion-for-config"
option into two, and as a result can get rid of an awk/sort -u
pipeline in the bash completion.

Since the v2 I:

 * Read & tried to address all the feedback in one way or another

 * We now use OPT_CMDMODE() in builtin/help.c, that's indeed much
   nicer

 * I kept the preceding non-OPT_CMDMODE() steps pretty much as-is,
   since we can't use OPT_CMDMODE() until we've explained ad changed
   --all, --guides and --config to all be mutually exclusive.

 * The "vars" completion helper is now called --completion-for-config,
   which as 8/9 explains is done for backwards compatibility.

 * There's a new post-cleanup 9/9 which moves the "colopts" code into
   the help.c library where it's used, this was in response to Junio's
   comment asking about why I'd moved a git_config() call. That older
   code was buggy, but now our git_config() usage makes more sense.

1. https://lore.kernel.org/git/cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  help: correct the usage string in -h and documentation
  help: correct usage & behavior of "git help --guides"
  help tests: add test for --config output
  help: correct logic error in combining --all and --config
  help: correct logic error in combining --all and --guides
  help: simplify by moving to OPT_CMDMODE()
  help tests: test --config-for-completion option & output
  help / completion: make "git help" do the hard work
  help: move column config discovery to help.c library

 Documentation/git-help.txt             |   9 +-
 builtin/help.c                         | 131 ++++++++++++++++---------
 contrib/completion/git-completion.bash |  21 ++--
 help.c                                 |  16 ++-
 help.h                                 |   2 +-
 parse-options.h                        |   6 +-
 t/t0012-help.sh                        |  49 +++++++++
 7 files changed, 166 insertions(+), 68 deletions(-)

Range-diff against v2:
 1:  b10bfd21f14 =  1:  5341ddbe23e help: correct the usage string in -h and documentation
 2:  039639a0dd3 !  2:  e24ab59bc94 help: correct usage & behavior of "git help --guides"
    @@ Commit message
     
         As noted in 65f98358c0c (builtin/help.c: add --guide option,
         2013-04-02) and a133737b809 (doc: include --guide option description
    -    for "git help", 2013-04-02) which introduced the --guide option it
    +    for "git help", 2013-04-02) which introduced the --guide option, it
         cannot be combined with e.g. <command>.
     
    -    Change both the usage string to reflect that, and test and assert for
    -    this behavior in the command itself. Now that we assert this in code
    -    we don't need to exhaustively describe the previous confusing behavior
    -    in the documentation either, instead of silently ignoring the provided
    +    Change the command and the "SYNOPSIS" section to reflect that desired
    +    behavior. Now that we assert this in code we don't need to
    +    exhaustively describe the previous confusing behavior in the
    +    documentation either, instead of silently ignoring the provided
         argument we'll now error out.
     
    -    The comment being removed was added in 15f7d494380 (builtin/help.c:
    -    split "-a" processing into two, 2013-04-02). The "Ignore any remaining
    -    args" part of it is now no longer applicable as explained above, let's
    -    just remove it entirely, it's rather obvious that if we're returning
    -    we're done.
    +    The "We're done. Ignore any remaining args" comment added in
    +    15f7d494380 (builtin/help.c: split "-a" processing into two,
    +    2013-04-02) can now be removed, it's obvious that we're asserting the
    +    behavior with the check of "argc".
    +
    +    The "--config" option is still missing from the synopsis, it will be
    +    added in a subsequent commit where we'll fix bugs in its
    +    implementation.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ t/t0012-help.sh: test_expect_success 'basic help commands' '
      '
      
     +test_expect_success 'invalid usage' '
    -+	test_expect_code 129 git help -g git-add
    ++	test_expect_code 129 git help -g add
     +'
     +
      test_expect_success "works for commands and guides by default" '
 3:  258282095de !  3:  6a8965e1b5b help tests: add test for --config output
    @@ Commit message
         2018-05-26) looks like. We should not be emitting anything except
         config variables and the brief usage information at the end here.
     
    +    The second test regexp here might not match three-level variables in
    +    general, as their second level could contain ".", but in this case
    +    we're always emitting what we extract from the documentation, so it's
    +    all strings like:
    +
    +        foo.<name>.bar
    +
    +    If we did introduce something like variable example content here we'd
    +    like this to break, since we'd then be likely to break the
    +    git-completion.bash.
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## t/t0012-help.sh ##
    @@ t/t0012-help.sh: test_expect_success 'git help -g' '
     +	git help -c >help.output &&
     +	cat >expect <<-\EOF &&
     +
    -+	'"'"'git help config'"'"' for more information
    ++	'\''git help config'\'' for more information
     +	EOF
     +	grep -v -E \
     +		-e "^[^.]+\.[^.]+$" \
 4:  32d73d5273c !  4:  d5df231954a help: correct logic error in combining --all and --config
    @@ builtin/help.c: static const char * const builtin_help_usage[] = {
      };
      
     @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
    - 	int nongit;
    - 	enum help_format parsed_help_format;
    - 	const char *page;
    -+	int need_config = 0;
    - 
    - 	argc = parse_options(argc, argv, prefix, builtin_help_options,
      			builtin_help_usage, 0);
      	parsed_help_format = help_format;
      
    @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
     +		usage_msg_opt(_("--guides cannot be combined with command or guide names"),
      			      builtin_help_usage, builtin_help_options);
      
    --	if (show_all) {
    -+	need_config = show_all || show_config;
    -+	if (need_config)
    - 		git_config(git_help_config, NULL);
    -+
    -+	if (show_all) {
    - 		if (verbose) {
    - 			setup_pager();
    - 			list_all_cmds_help();
    + 	if (show_all) {
     @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
      		list_commands(colopts, &main_cmds, &other_cmds);
      	}
    @@ t/t0012-help.sh: test_expect_success 'basic help commands' '
      '
      
      test_expect_success 'invalid usage' '
    --	test_expect_code 129 git help -g git-add
    -+	test_expect_code 129 git help -g git-add &&
    -+	test_expect_code 129 git help -c git-add &&
    -+	test_expect_code 129 git help -g git-add &&
    -+
    -+	test_expect_code 129 git help -a -c &&
    -+	test_expect_code 129 git help -g -c
    +-	test_expect_code 129 git help -g add
    ++	test_expect_code 129 git help -g add &&
    ++	test_expect_code 129 git help -a -c
      '
      
      test_expect_success "works for commands and guides by default" '
 -:  ----------- >  5:  bf3ac71f256 help: correct logic error in combining --all and --guides
 -:  ----------- >  6:  b52269eeab9 help: simplify by moving to OPT_CMDMODE()
 -:  ----------- >  7:  cc031c8d339 help tests: test --config-for-completion option & output
 5:  e995a42cb8d !  8:  836e19f8612 help / completion: make "git help" do the hard work
    @@ Commit message
         We can instead simply do the relevant parsing ourselves (we were doing
         most of it already), and call string_list_remove_duplicates() after
         already sorting the list, so the caller doesn't need to invoke "sort
    -    -u".
    +    -u". The "--config-for-completion" output is the same as before after
    +    being passed through "sort -u".
     
    -    This changes the output of the section list to emit lines like "alias"
    -    instead of "alias.". The dot suffix is better done as an argument to
    -    __gitcomp().
    +    Then add a new "--config-sections-for-completion" option. Under that
    +    output we'll emit config sections like "alias" (instead of "alias." in
    +    the --config-for-completion output).
     
    -    This means that we'll have the list_config_help() function do a bit
    -    more work, let's switch its "for_human" to passing a full
    -    "show_config", but as an enum type so we can have the compiler check
    -    what values we're expecting to get.
    +    We need to be careful to leave the "--config-for-completion" option
    +    compatible with users git, but are still running a shell with an older
    +    git-completion.bash. If we e.g. changed the option name they'd see
    +    messages about git-completion.bash being unable to find the
    +    "--config-for-completion" option.
    +
    +    Such backwards compatibility isn't something we should bend over
    +    backwards for, it's only helping users who:
    +
    +     * Upgrade git
    +     * Are in an old shell
    +     * The git-completion.bash in that shell hasn't cached the old
    +       "--config-for-completion" output already.
    +
    +    But since it's easy in this case to retain compatibility, let's do it,
    +    the older versions of git-completion.bash won't care that the input
    +    they get doesn't change after a "sort -u".
    +
    +    While we're at it let's make "--config-for-completion" die if there's
    +    anything left over in "argc", and do the same in the new
    +    "--config-sections-for-completion" option.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/help.c ##
    -@@ builtin/help.c: static const char *html_path;
    +@@ builtin/help.c: enum help_format {
    + 	HELP_FORMAT_WEB
    + };
      
    - static int show_all = 0;
    - static int show_guides = 0;
    --static int show_config;
     +enum show_config_type {
    -+	SHOW_CONFIG_UNSET = 0,
     +	SHOW_CONFIG_HUMAN,
     +	SHOW_CONFIG_VARS,
     +	SHOW_CONFIG_SECTIONS,
    -+} show_config;
    - static int verbose = 1;
    - static unsigned int colopts;
    - static enum help_format help_format = HELP_FORMAT_NONE;
    ++};
    ++
    + static enum help_action {
    + 	HELP_ACTION_ALL = 1,
    + 	HELP_ACTION_GUIDES,
    + 	HELP_ACTION_CONFIG,
    + 	HELP_ACTION_CONFIG_FOR_COMPLETION,
    ++	HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION,
    + } cmd_mode;
    + 
    + static const char *html_path;
     @@ builtin/help.c: static struct option builtin_help_options[] = {
    - 	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
    - 	OPT_BOOL('g', "guides", &show_guides, N_("print list of useful guides")),
    - 	OPT_BOOL('c', "config", &show_config, N_("print all configuration variable names")),
    --	OPT_SET_INT_F(0, "config-for-completion", &show_config, "", 2, PARSE_OPT_HIDDEN),
    -+	OPT_SET_INT_F(0, "config-for-completion-vars", &show_config, "",
    -+		      SHOW_CONFIG_VARS, PARSE_OPT_HIDDEN),
    -+	OPT_SET_INT_F(0, "config-for-completion-sections", &show_config, "",
    -+		      SHOW_CONFIG_SECTIONS, PARSE_OPT_HIDDEN),
    - 	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
    - 	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
    - 			HELP_FORMAT_WEB),
    + 		    HELP_ACTION_CONFIG),
    + 	OPT_CMDMODE_F(0, "config-for-completion", &cmd_mode, "",
    + 		    HELP_ACTION_CONFIG_FOR_COMPLETION, PARSE_OPT_HIDDEN),
    ++	OPT_CMDMODE_F(0, "config-sections-for-completion", &cmd_mode, "",
    ++		    HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION, PARSE_OPT_HIDDEN),
    + 
    + 	OPT_END(),
    + };
     @@ builtin/help.c: struct slot_expansion {
      	int found;
      };
    @@ builtin/help.c: static void list_config_help(int for_human)
     +			break;
     +		case SHOW_CONFIG_VARS:
     +			break;
    -+		case SHOW_CONFIG_UNSET:
    -+			BUG("should not get SHOW_CONFIG_UNSET here");
      		}
     -
      		wildcard = strchr(var, '*');
    @@ builtin/help.c: static void list_config_help(int for_human)
      
      static enum help_format parse_help_format(const char *format)
     @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
    + 		printf("%s\n", _(git_more_info_string));
      		return 0;
    - 	}
    - 
    --	if (show_config) {
    --		int for_human = show_config == 1;
    -+	switch (show_config) {
    -+	case SHOW_CONFIG_UNSET:
    -+		break;
    -+	case SHOW_CONFIG_VARS:
    -+	case SHOW_CONFIG_SECTIONS:
    -+		list_config_help(show_config);
    - 
    --		if (!for_human) {
    --			list_config_help(for_human);
    --			return 0;
    --		}
    + 	case HELP_ACTION_CONFIG_FOR_COMPLETION:
    +-		list_config_help(0);
    ++		no_extra_argc(argc);
    ++		list_config_help(SHOW_CONFIG_VARS);
     +		return 0;
    -+	case SHOW_CONFIG_HUMAN:
    ++	case HELP_ACTION_CONFIG_SECTIONS_FOR_COMPLETION:
    ++		no_extra_argc(argc);
    ++		list_config_help(SHOW_CONFIG_SECTIONS);
    + 		return 0;
    + 	case HELP_ACTION_CONFIG:
    + 		no_extra_argc(argc);
      		setup_pager();
    --		list_config_help(for_human);
    -+		list_config_help(show_config);
    +-		list_config_help(1);
    ++		list_config_help(SHOW_CONFIG_HUMAN);
      		printf("\n%s\n", _("'git help config' for more information"));
    -+
      		return 0;
      	}
    - 
     
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: __git_config_vars=
    @@ contrib/completion/git-completion.bash: __git_config_vars=
      {
      	test -n "$__git_config_vars" ||
     -	__git_config_vars="$(git help --config-for-completion | sort -u)"
    -+	__git_config_vars="$(git help --config-for-completion-vars)"
    ++	__git_config_vars="$(git help --config-for-completion)"
     +}
     +
     +__git_config_sections=
     +__git_compute_config_sections ()
     +{
     +	test -n "$__git_config_sections" ||
    -+	__git_config_sections="$(git help --config-for-completion-sections)"
    ++	__git_config_sections="$(git help --config-sections-for-completion)"
      }
      
      # Completes possible values of various configuration variables.
    @@ contrib/completion/git-completion.bash: __git_complete_config_variable_name ()
      }
     
      ## t/t0012-help.sh ##
    -@@ t/t0012-help.sh: test_expect_success 'git help -c' '
    - 	test_cmp expect actual
    +@@ t/t0012-help.sh: test_expect_success 'invalid usage' '
    + 	test_expect_code 129 git help -a -g &&
    + 
    + 	test_expect_code 129 git help -g -c &&
    +-	test_expect_code 0 git help --config-for-completion add
    ++	test_expect_code 129 git help --config-for-completion add &&
    ++	test_expect_code 129 git help --config-sections-for-completion add
      '
      
    -+test_expect_success 'git help --config-for-completion-vars' '
    -+	git help -c >human &&
    -+	grep -E \
    -+	     -e "^[^.]+\.[^.]+$" \
    -+	     -e "^[^.]+\.[^.]+\.[^.]+$" human |
    -+	     sed -e "s/\*.*//" -e "s/<.*//" |
    -+	     sort -u >human.munged &&
    -+
    -+	git help --config-for-completion-vars >vars &&
    -+	test_cmp human.munged vars
    -+'
    -+
    -+test_expect_success 'git help --config-for-completion-sections' '
    + test_expect_success "works for commands and guides by default" '
    +@@ t/t0012-help.sh: test_expect_success 'git help --config-for-completion' '
    + 	     sort -u >human.munged &&
    + 
    + 	git help --config-for-completion >vars &&
    +-	sort -u <vars >vars.new &&
    +-	mv vars.new vars &&
    + 	test_cmp human.munged vars
    + '
    + 
    ++test_expect_success 'git help --config-sections-for-completion' '
     +	git help -c >human &&
     +	grep -E \
     +	     -e "^[^.]+\.[^.]+$" \
    @@ t/t0012-help.sh: test_expect_success 'git help -c' '
     +	     sed -e "s/\..*//" |
     +	     sort -u >human.munged &&
     +
    -+	git help --config-for-completion-sections >sections &&
    ++	git help --config-sections-for-completion >sections &&
     +	test_cmp human.munged sections
     +'
     +
 -:  ----------- >  9:  29ee7cf375b help: move column config discovery to help.c library
-- 
2.33.0.1098.gf02a64c1a2d

