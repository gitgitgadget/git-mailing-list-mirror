Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB0AC32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 16:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353118AbiHSQdT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 12:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350107AbiHSQaN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 12:30:13 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6734C11A2CC
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:35 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id dc19so9594468ejb.12
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 09:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=a5kOu+CVaE1geMFPyJiqOQZfnMzR1YNKi9Ga+JFGs6k=;
        b=hO1clW2wYee1gSD6IjxNpi2me0II+nDvihMk3brhlZTL+6q42Ij34m5PG4PomrSay6
         ArhpnjTvYxFX3Wmo0MnG2e2k/4si4nBtuth/0bu+IS+HJTB7v4TTjhAr45MHqKHVvgnJ
         T6Y1kFgU1UUyXmaR9Ntf9+7mf9aHMHavD3A0zHtwR5ixLGA+amouIukYm5qTArppEsP/
         6ac84uOpyewF/T5fo5wlkD5Ql+Gqk0idLCp2jPghxW0fCyKWl/acIqrwhQ+LW9CI6W1y
         c5DvtTUtt8zPKNq/Pjbc9+vk5skkrN/qfLQ9/0cVKY1VHsHP7EXidhfAfaOwnh3Adw09
         8FkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=a5kOu+CVaE1geMFPyJiqOQZfnMzR1YNKi9Ga+JFGs6k=;
        b=CyRXiz7nEB/WA+k2VtJMMwlpsrtOwGK/IAGf4Y8DcE2zpF3T201U15I8JNg0F8Eagz
         vGLeB9YevFxIQy0ydFiu0lK9C+vaeK2GgVLvjFlC7h1qMjdb+WKvS0/skshuMwn/HRMN
         u3Dg9qyotCFCqu4o/1c8zvOzBzPZJm72aODJYVJsXxWOfpJaoVDd3HEOAXWmXsKCz8jv
         JAcq8u3NUL+erEADh6EFkPLZ6+WDUVtKb+iO7KMWP28AdDoqBctHcMcAG6GTI4rrGKhx
         0t95LF/rarPyaXpxrkZnOeWyAHvq0hLR9D9kfv+DiNy/0FRwDC3KpZ2VUG7ycWV0YfQi
         2IBQ==
X-Gm-Message-State: ACgBeo3LX3FqOa4ohrsNsRV90GBtMZ+guQ0EAEaFT3cmWPse+LXvxnNg
        XZtLdVv2qHhj8B8u+CYMuaWyb8MFyfQ=
X-Google-Smtp-Source: AA6agR4HFlyhHpvDNesoBymnUUuLu6tTWFqWqGfTsoyoKnWQZZTVFVxES/oD4O69f5rdlLSNSZlfAQ==
X-Received: by 2002:a17:907:2e0d:b0:731:7afa:f14f with SMTP id ig13-20020a1709072e0d00b007317afaf14fmr5544824ejc.704.1660925072079;
        Fri, 19 Aug 2022 09:04:32 -0700 (PDT)
Received: from localhost (84-236-78-250.pool.digikabel.hu. [84.236.78.250])
        by smtp.gmail.com with ESMTPSA id c22-20020aa7df16000000b0043bbcd94ee4sm3366571edy.51.2022.08.19.09.04.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 09:04:31 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH v2 00/20] parse-options: handle subcommands
Date:   Fri, 19 Aug 2022 18:03:51 +0200
Message-Id: <20220819160411.1791200-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.37.2.817.g36f84ce71d
In-Reply-To: <20220725123857.2773963-1-szeder.dev@gmail.com>
References: <20220725123857.2773963-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Several Git commands have subcommands to implement mutually exclusive
"operation modes", and they usually parse their subcommand argument
with a bunch of if-else if statements.

Teach parse-options to handle subcommands as well, which will result
in shorter and simpler code with consistent error handling and error
messages on unknown or missing subcommand, and it will also make
possible for our Bash completion script to handle subcommands
programmatically in a follow-up series.

Changes since v1:

  - Commit message updates.
  - Put the troublesome subcommand arg between `' in error messages.
  - Use designated initializers for OPT_SUBCOMMAND.
  - Remove the unused 'kept_unknown' flag from 'struct parse_opt_ctx_t'
    (it was used in WIP version of this patch series, that I didn't manage
    to remove completely).
  - Drop cmd_worktree()'s NO_PARSEOPT flag in the right patch.
  - Use 'git -C ...' instead of ( cd ... && ... ) in t5505's new tests.
  - Update API doc and BUG() string to mention PARSE_OPT_KEEP_UNKNOWN_OPT.
  - Minor test helper refactorings.


SZEDER Gábor (20):
  git.c: update NO_PARSEOPT markings
  t3301-notes.sh: check that default operation mode doesn't take
    arguments
  t5505-remote.sh: check the behavior without a subcommand
  t0040-parse-options: test parse_options() with various
    'parse_opt_flags'
  api-parse-options.txt: fix description of OPT_CMDMODE
  parse-options: PARSE_OPT_KEEP_UNKNOWN only applies to --options
  parse-options: clarify the limitations of PARSE_OPT_NODASH
  parse-options: drop leading space from '--git-completion-helper'
    output
  parse-options: add support for parsing subcommands
  builtin/bundle.c: let parse-options parse subcommands
  builtin/commit-graph.c: let parse-options parse subcommands
  builtin/gc.c: let parse-options parse 'git maintenance's subcommands
  builtin/hook.c: let parse-options parse subcommands
  builtin/multi-pack-index.c: let parse-options parse subcommands
  builtin/notes.c: let parse-options parse subcommands
  builtin/reflog.c: let parse-options parse subcommands
  builtin/remote.c: let parse-options parse subcommands
  builtin/sparse-checkout.c: let parse-options parse subcommands
  builtin/stash.c: let parse-options parse subcommands
  builtin/worktree.c: let parse-options parse subcommands

 Documentation/technical/api-parse-options.txt |  49 +++-
 builtin/archive.c                             |   2 +-
 builtin/bisect--helper.c                      |   2 +-
 builtin/blame.c                               |   1 +
 builtin/bundle.c                              |  25 +-
 builtin/commit-graph.c                        |  30 +--
 builtin/difftool.c                            |   2 +-
 builtin/env--helper.c                         |   2 +-
 builtin/fast-export.c                         |   2 +-
 builtin/gc.c                                  |  42 +--
 builtin/hook.c                                |  12 +-
 builtin/log.c                                 |   4 +-
 builtin/multi-pack-index.c                    |  51 ++--
 builtin/notes.c                               |  43 ++-
 builtin/reflog.c                              |  43 +--
 builtin/remote.c                              |  70 +++--
 builtin/revert.c                              |   2 +-
 builtin/shortlog.c                            |   1 +
 builtin/sparse-checkout.c                     |  48 ++--
 builtin/stash.c                               |  59 ++--
 builtin/worktree.c                            |  31 +--
 diff.c                                        |   2 +-
 git.c                                         |  14 +-
 parse-options.c                               | 118 +++++++-
 parse-options.h                               |  29 +-
 t/helper/test-parse-options.c                 | 127 +++++++++
 t/helper/test-serve-v2.c                      |   2 +-
 t/helper/test-tool.c                          |   2 +
 t/helper/test-tool.h                          |   2 +
 t/t0040-parse-options.sh                      | 255 ++++++++++++++++++
 t/t3301-notes.sh                              |   5 +
 t/t3903-stash.sh                              |   2 +-
 t/t5318-commit-graph.sh                       |   4 +-
 t/t5505-remote.sh                             |  20 ++
 t/t7900-maintenance.sh                        |  10 +-
 35 files changed, 803 insertions(+), 310 deletions(-)

Range-diff:
 1:  78448310f9 !  1:  8128131f7b git.c: update NO_PARSEOPT markings
    @@ Commit message
         Update this list, and remove this flag from the commands that by now
         use parse-options.
     
    +    After this change we can TAB complete --options of the plumbing
    +    commands 'commit-tree', 'mailinfo' and 'mktag'.
    +
         Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
     
      ## git.c ##
    @@ git.c: static struct cmd_struct commands[] = {
      	{ "mktree", cmd_mktree, RUN_SETUP },
      	{ "multi-pack-index", cmd_multi_pack_index, RUN_SETUP },
      	{ "mv", cmd_mv, RUN_SETUP | NEED_WORK_TREE },
    -@@ git.c: static struct cmd_struct commands[] = {
    - 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
    - 	{ "version", cmd_version },
    - 	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
    --	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
    -+	{ "worktree", cmd_worktree, RUN_SETUP },
    - 	{ "write-tree", cmd_write_tree, RUN_SETUP },
    - };
    - 
 2:  dee73c9832 =  2:  a8895169e7 t3301-notes.sh: check that default operation mode doesn't take arguments
 3:  4ce0c7717b !  3:  ecc7ca97e7 t5505-remote.sh: check the behavior without a subcommand
    @@ t/t5505-remote.sh: test_expect_success 'add invalid foreign_vcs remote' '
      '
      
     +test_expect_success 'without subcommand' '
    -+	(
    -+		cd test &&
    -+		git remote >actual &&
    -+		echo origin >expect &&
    -+		test_cmp expect actual
    -+	)
    ++	echo origin >expect &&
    ++	git -C test remote >actual &&
    ++	test_cmp expect actual
     +'
     +
     +test_expect_success 'without subcommand accepts -v' '
    -+	cat >test/expect <<-EOF &&
    ++	cat >expect <<-EOF &&
     +	origin	$(pwd)/one (fetch)
     +	origin	$(pwd)/one (push)
     +	EOF
    -+	(
    -+		cd test &&
    -+		git remote -v >actual &&
    -+		test_cmp expect actual
    -+	)
    ++	git -C test remote -v >actual &&
    ++	test_cmp expect actual
     +'
     +
     +test_expect_success 'without subcommand does not take arguments' '
    -+	(
    -+		cd test &&
    -+		test_expect_code 129 git remote origin 2>err &&
    -+		grep "^error: Unknown subcommand:" err
    -+	)
    ++	test_expect_code 129 git -C test remote origin 2>err &&
    ++	grep "^error: Unknown subcommand:" err
     +'
     +
      cat >test/expect <<EOF
 4:  7e7bf30b32 !  4:  84c1aa3318 t0040-parse-options: test parse_options() with various 'parse_opt_flags'
    @@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, const char **arg
      	return ret;
      }
     +
    ++static void print_args(int argc, const char **argv)
    ++{
    ++	for (int i = 0; i < argc; i++)
    ++		printf("arg %02d: %s\n", i, argv[i]);
    ++}
    ++
     +static int parse_options_flags__cmd(int argc, const char **argv,
     +				    enum parse_opt_flags test_flags)
     +{
    @@ t/helper/test-parse-options.c: int cmd__parse_options(int argc, const char **arg
     +	argc = parse_options(argc, argv, NULL, options, usage, test_flags);
     +
     +	printf("opt: %d\n", opt);
    -+	for (int i = 0; i < argc; i++)
    -+		printf("arg %02d: %s\n", i, argv[i]);
    ++	print_args(argc, argv);
     +
     +	return 0;
     +}
    @@ t/t0040-parse-options.sh: test_expect_success '--end-of-options treats remainder
     +test_expect_success 'NO_INTERNAL_HELP works for -h' '
     +	test_expect_code 129 test-tool parse-options-flags --no-internal-help cmd -h 2>err &&
     +	cat err &&
    -+	grep "^error: unknown switch \`h'\''" err &&
    ++	grep "^error: unknown switch \`h$SQ" err &&
     +	grep "^usage: " err
     +'
     +
 5:  8515609ac2 =  5:  40b51c9992 api-parse-options.txt: fix description of OPT_CMDMODE
 6:  60885e91cf =  6:  7f561992a5 parse-options: PARSE_OPT_KEEP_UNKNOWN only applies to --options
 7:  2e1d40b4f0 =  7:  27a66b0fcd parse-options: clarify the limitations of PARSE_OPT_NODASH
 8:  2e4f9259ba =  8:  722a47874a parse-options: drop leading space from '--git-completion-helper' output
 9:  caf0a395df !  9:  b65385a02d parse-options: add support for parsing subcommands
    @@ Commit message
             return fn(argc, argv, prefix);
     
         Here each OPT_SUBCOMMAND specifies the name of the subcommand and the
    -    function implementing it, and the same pointer to 'fn' where
    -    parse_options() will store the function associated with the given
    -    subcommand.  There is no need to check whether 'fn' is non-NULL before
    -    invoking it: if there were no subcommands given on the command line
    -    then the parse_options() call would error out and show usage.  In case
    -    a command has a default operation mode, 'fn' should be initialized to
    -    the function implementing that mode, and parse_options() should be
    -    invoked with the PARSE_OPT_SUBCOMMAND_OPTIONAL flag.
    +    function implementing it, and the address of the same 'fn' subcommand
    +    function pointer.  parse_options() then processes the arguments until
    +    it finds the first argument matching one of the subcommands, sets 'fn'
    +    to the function associated with that subcommand, and returns, leaving
    +    the rest of the arguments unprocessed.  If none of the listed
    +    subcommands is found among the arguments, parse_options() will show
    +    usage and abort.
    +
    +    If a command has a default operation mode, 'fn' should be initialized
    +    to the function implementing that mode, and parse_options() should be
    +    invoked with the PARSE_OPT_SUBCOMMAND_OPTIONAL flag.  In this case
    +    parse_options() won't error out when not finding any subcommands, but
    +    will return leaving 'fn' unchanged.  Note that if that default
    +    operation mode has any --options, then the PARSE_OPT_KEEP_UNKNOWN_OPT
    +    flag is necessary as well (otherwise parse_options() would error out
    +    upon seeing the unknown option meant to the default operation mode).
     
         Some thoughts about the implementation:
     
    -      - Arguably it is a bit weird that the same pointer to 'fn' have to
    -        be specified as 'value' for each OPT_SUBCOMMAND, but we need a way
    -        to tell parse_options() where to put the function associated with
    -        the given subcommand, and I didn't like the alternatives:
    +      - The same pointer to 'fn' must be specified as 'value' for each
    +        OPT_SUBCOMMAND, because there can be only one set of mutually
    +        exclusive subcommands; parse_options() will BUG() otherwise.
    +
    +        There are other ways to tell parse_options() where to put the
    +        function associated with the subcommand given on the command line,
    +        but I didn't like them:
     
               - Change parse_options()'s signature by adding a pointer to
                 subcommand function to be set to the function associated with
    @@ Documentation/technical/api-parse-options.txt: Flags are the bitwise-or of:
     +	Don't error out when no subcommand is specified.
     +
     +Note that `PARSE_OPT_STOP_AT_NON_OPTION` is incompatible with subcommands;
    -+while `PARSE_OPT_KEEP_DASHDASH` and `PARSE_OPT_KEEP_UNKNOWN` can only be
    ++while `PARSE_OPT_KEEP_DASHDASH` and `PARSE_OPT_KEEP_UNKNOWN_OPT` can only be
     +used with subcommands when combined with `PARSE_OPT_SUBCOMMAND_OPTIONAL`.
     +
      Data Structure
    @@ parse-options.c: static void parse_options_start_1(struct parse_opt_ctx_t *ctx,
     +			BUG("subcommands are incompatible with PARSE_OPT_STOP_AT_NON_OPTION");
     +		if (!(flags & PARSE_OPT_SUBCOMMAND_OPTIONAL)) {
     +			if (flags & PARSE_OPT_KEEP_UNKNOWN_OPT)
    -+				BUG("subcommands are incompatible with PARSE_OPT_KEEP_UNKNOWN unless in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
    ++				BUG("subcommands are incompatible with PARSE_OPT_KEEP_UNKNOWN_OPT unless in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
     +			if (flags & PARSE_OPT_KEEP_DASHDASH)
     +				BUG("subcommands are incompatible with PARSE_OPT_KEEP_DASHDASH unless in combination with PARSE_OPT_SUBCOMMAND_OPTIONAL");
     +		}
    @@ parse-options.c: enum parse_opt_result parse_options_step(struct parse_opt_ctx_t
     +					 * So we are done parsing.
     +					 */
     +					return PARSE_OPT_DONE;
    -+				error(_("unknown subcommand: %s"), arg);
    ++				error(_("unknown subcommand: `%s'"), arg);
     +				usage_with_options(usagestr, options);
     +			case PARSE_OPT_COMPLETE:
     +			case PARSE_OPT_HELP:
     +			case PARSE_OPT_ERROR:
     +			case PARSE_OPT_DONE:
     +			case PARSE_OPT_NON_OPTION:
    ++				/* Impossible. */
     +				BUG("parse_subcommand() cannot return these");
     +			}
      		}
    @@ parse-options.c: enum parse_opt_result parse_options_step(struct parse_opt_ctx_t
     +		}
      		if (!(ctx->flags & PARSE_OPT_KEEP_UNKNOWN_OPT))
      			return PARSE_OPT_UNKNOWN;
    -+		ctx->kept_unknown = 1;
      		ctx->out[ctx->cpidx++] = ctx->argv[0];
    - 		ctx->opt = NULL;
    - 	}
     @@ parse-options.c: int parse_options(int argc, const char **argv,
      	case PARSE_OPT_COMPLETE:
      		exit(0);
    @@ parse-options.h: struct option {
      #define OPT_ALIAS(s, l, source_long_name) \
      	{ OPTION_ALIAS, (s), (l), (source_long_name) }
      
    -+#define OPT_SUBCOMMAND(l, v, fn)      { OPTION_SUBCOMMAND, 0, (l), (v), NULL, \
    -+					NULL, 0, NULL, 0, NULL, 0, (fn) }
    -+#define OPT_SUBCOMMAND_F(l, v, fn, f) { OPTION_SUBCOMMAND, 0, (l), (v), NULL, \
    -+					NULL, (f), NULL, 0, NULL, 0, (fn) }
    ++#define OPT_SUBCOMMAND_F(l, v, fn, f) { \
    ++	.type = OPTION_SUBCOMMAND, \
    ++	.long_name = (l), \
    ++	.value = (v), \
    ++	.flags = (f), \
    ++	.subcommand_fn = (fn) }
    ++#define OPT_SUBCOMMAND(l, v, fn)    OPT_SUBCOMMAND_F((l), (v), (fn), 0)
     +
      /*
       * parse_options() will filter out the processed options and leave the
    @@ parse-options.h: struct parse_opt_ctx_t {
      	int argc, cpidx, total;
      	const char *opt;
      	enum parse_opt_flags flags;
    -+	unsigned has_subcommands:1,
    -+		 kept_unknown:1;
    ++	unsigned has_subcommands;
      	const char *prefix;
      	const char **alias_groups; /* must be in groups of 3 elements! */
      	struct option *updated_options;
    @@ t/helper/test-parse-options.c: int cmd__parse_options_flags(int argc, const char
      	return parse_options_flags__cmd(argc, argv, test_flags);
      }
     +
    -+static void print_subcommand_args(const char *fn_name, int argc,
    -+				  const char **argv)
    -+{
    -+	int i;
    -+	printf("fn: %s\n", fn_name);
    -+	for (i = 0; i < argc; i++)
    -+		printf("arg %02d: %s\n", i, argv[i]);
    -+}
    -+
     +static int subcmd_one(int argc, const char **argv, const char *prefix)
     +{
    -+	print_subcommand_args("subcmd_one", argc, argv);
    ++	printf("fn: subcmd_one\n");
    ++	print_args(argc, argv);
     +	return 0;
     +}
     +
     +static int subcmd_two(int argc, const char **argv, const char *prefix)
     +{
    -+	print_subcommand_args("subcmd_two", argc, argv);
    ++	printf("fn: subcmd_two\n");
    ++	print_args(argc, argv);
     +	return 0;
     +}
     +
    @@ t/t0040-parse-options.sh: test_expect_success 'KEEP_UNKNOWN_OPT | NO_INTERNAL_HE
     +
     +test_expect_success 'subcommand - unknown subcommand shows error and usage' '
     +	test_expect_code 129 test-tool parse-subcommand cmd nope 2>err &&
    -+	grep "^error: unknown subcommand: nope" err &&
    ++	grep "^error: unknown subcommand: \`nope$SQ" err &&
     +	grep ^usage: err
     +'
     +
     +test_expect_success 'subcommand - subcommands cannot be abbreviated' '
     +	test_expect_code 129 test-tool parse-subcommand cmd subcmd-o 2>err &&
    -+	grep "^error: unknown subcommand: subcmd-o$" err &&
    ++	grep "^error: unknown subcommand: \`subcmd-o$SQ$" err &&
     +	grep ^usage: err
     +'
     +
     +test_expect_success 'subcommand - no negated subcommands' '
     +	test_expect_code 129 test-tool parse-subcommand cmd no-subcmd-one 2>err &&
    -+	grep "^error: unknown subcommand: no-subcmd-one" err &&
    ++	grep "^error: unknown subcommand: \`no-subcmd-one$SQ" err &&
     +	grep ^usage: err
     +'
     +
10:  cac17fa063 = 10:  3526a93d90 builtin/bundle.c: let parse-options parse subcommands
11:  9cfd5875fb ! 11:  a9533e14a5 builtin/commit-graph.c: let parse-options parse subcommands
    @@ t/t5318-commit-graph.sh: test_expect_success 'usage' '
      test_expect_success 'usage shown with an error on unknown sub-command' '
      	cat >expect <<-\EOF &&
     -	error: unrecognized subcommand: unknown
    -+	error: unknown subcommand: unknown
    ++	error: unknown subcommand: `unknown'\''
      	EOF
      	test_expect_code 129 git commit-graph unknown 2>stderr &&
      	grep error stderr >actual &&
12:  cab2adf79b ! 12:  501a2bd1b5 builtin/gc.c: let parse-options parse 'git maintenance's subcommands
    @@ t/t7900-maintenance.sh: test_systemd_analyze_verify () {
     +	test_expect_code 129 git maintenance -h >actual &&
     +	test_i18ngrep "usage: git maintenance <subcommand>" actual &&
     +	test_expect_code 129 git maintenance barf 2>err &&
    -+	test_i18ngrep "unknown subcommand: barf" err &&
    ++	test_i18ngrep "unknown subcommand: \`barf'\''" err &&
     +	test_i18ngrep "usage: git maintenance" err &&
      	test_expect_code 129 git maintenance 2>err &&
     +	test_i18ngrep "error: need a subcommand" err &&
13:  6a16515cd8 ! 13:  a38a61756b builtin/hook.c: let parse-option parse subcommands
    @@ Metadata
     Author: SZEDER Gábor <szeder.dev@gmail.com>
     
      ## Commit message ##
    -    builtin/hook.c: let parse-option parse subcommands
    +    builtin/hook.c: let parse-options parse subcommands
     
         'git hook' parses its currently only subcommand with an if statement.
         parse-options has just learned to parse subcommands, so let's use that
14:  a5a7f28ced = 14:  f511717008 builtin/multi-pack-index.c: let parse-options parse subcommands
15:  0104f48ae1 = 15:  220bbf16cf builtin/notes.c: let parse-options parse subcommands
16:  250e12ddfc = 16:  d0e7329f42 builtin/reflog.c: let parse-options parse subcommands
17:  90a2968469 ! 17:  9af71fd655 builtin/remote.c: let parse-options parse subcommands
    @@ builtin/remote.c: static int set_url(int argc, const char **argv)
      }
     
      ## t/t5505-remote.sh ##
    -@@ t/t5505-remote.sh: test_expect_success 'without subcommand does not take arguments' '
    - 	(
    - 		cd test &&
    - 		test_expect_code 129 git remote origin 2>err &&
    --		grep "^error: Unknown subcommand:" err
    -+		grep "^error: unknown subcommand:" err
    - 	)
    +@@ t/t5505-remote.sh: test_expect_success 'without subcommand accepts -v' '
    + 
    + test_expect_success 'without subcommand does not take arguments' '
    + 	test_expect_code 129 git -C test remote origin 2>err &&
    +-	grep "^error: Unknown subcommand:" err
    ++	grep "^error: unknown subcommand:" err
      '
      
    + cat >test/expect <<EOF
18:  dc5c071b51 = 18:  2bd2d40bb3 builtin/sparse-checkout.c: let parse-options parse subcommands
19:  5c7cd8cbed = 19:  e8b7fdd2d8 builtin/stash.c: let parse-options parse subcommands
20:  4d884dfe62 ! 20:  6d8108292f builtin/worktree.c: let parse-options parse subcommands
    @@ builtin/worktree.c: static int repair(int ac, const char **av, const char *prefi
     +	ac = parse_options(ac, av, prefix, options, worktree_usage, 0);
     +	return fn(ac, av, prefix);
      }
    +
    + ## git.c ##
    +@@ git.c: static struct cmd_struct commands[] = {
    + 	{ "verify-tag", cmd_verify_tag, RUN_SETUP },
    + 	{ "version", cmd_version },
    + 	{ "whatchanged", cmd_whatchanged, RUN_SETUP },
    +-	{ "worktree", cmd_worktree, RUN_SETUP | NO_PARSEOPT },
    ++	{ "worktree", cmd_worktree, RUN_SETUP },
    + 	{ "write-tree", cmd_write_tree, RUN_SETUP },
    + };
    + 
-- 
2.37.2.817.g36f84ce71d

