Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C56C6FA8E
	for <git@archiver.kernel.org>; Sat, 25 Feb 2023 18:04:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjBYSEz (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Feb 2023 13:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjBYSEx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Feb 2023 13:04:53 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C07CC136DD
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:04:51 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id g12so1335846pfi.0
        for <git@vger.kernel.org>; Sat, 25 Feb 2023 10:04:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/SMTpOfqldeJGQgwOUAkCnal8AtHizdtrWadFLERZ70=;
        b=n8FjbQAIcXN90iKkD0q/VYxKGgC1IvhR3aRiaNd30xG8essDoZNuU+PcHFC744t78Y
         No/gArDhlVpfOxS6bvh4zdo7a+OkNua5vuTUDMD8f/UDWOflE2lwnPI0fj8HWHDTH3ux
         szwVG/JiHciueITfOynO7eYM68VLJ65d10IVAO4KKGSSzTtujw3mVQqtlP0ZAN7/Ou6e
         hN62mveKXObLsZfgEUj1R0dZPLgr9DxiqmA7SW4NpI0bydlZWV2UV/DONR9mjC56Rs5f
         bGbrBrrpg8HuPQPXKjHzX6DbtsbEpnu5n5yJ9x9nEBC3ColgcaECpG5eTU2WTBnJrgW5
         tJTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/SMTpOfqldeJGQgwOUAkCnal8AtHizdtrWadFLERZ70=;
        b=fTbRrfsQ4GImSoMv54K2o1t+0p9zRiNFjRRZcmC2NNEuOw/jdL8zSLazNO4Geu9ljK
         g9E9dzjdG+CcyP1S/z0mUEqf8hzadjm/YvyGQobuppKwqBDBEMYi0GSEM2Kd7w//IWEI
         GqITeXXaexL0zq1qILO9TwpJIhA07z5SLgn4JnJvS85auqeDIXvlPhNm+2NOCTMadEKV
         Ga9VVPVPLg5aqQvWHrWt3PPe2OiArRzr5UR+wlxFgBcVQSW1qIoXESpnr2hcc1L5KteV
         JEQmAzWG7WQ4ZqJYKjMIEiqsbBy922cQk3Es+nt8cFaVzWjJVAtkPdh1CGtFrfKH/A6n
         3tlQ==
X-Gm-Message-State: AO0yUKXNwgeJMmDDd8bqJSsdFHJrqZisOFJbHUJw9j1kpiZ8jhzyEazL
        +kKXfDHAkAXXT7KBBGhl9T/BzKIXyFs=
X-Google-Smtp-Source: AK7set/mDYS9kE+y67FZuBXrNEYXFOHJMst0dx9R55Du63pc0w1iIaIRL/DRcEa/Ojla6fxPGKHvwg==
X-Received: by 2002:a05:6a00:2da7:b0:5a8:9858:750a with SMTP id fb39-20020a056a002da700b005a89858750amr3095962pfb.13.1677348290622;
        Sat, 25 Feb 2023 10:04:50 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id x18-20020a62fb12000000b005cd17607358sm1473547pfm.87.2023.02.25.10.04.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Feb 2023 10:04:49 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v5 0/3] rebase: add a config option for --rebase-merges
Date:   Sat, 25 Feb 2023 11:03:22 -0700
Message-Id: <20230225180325.796624-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230223053410.644503-1-alexhenrie24@gmail.com>
References: <20230223053410.644503-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes from v4:

- deprecate --rebase-merges="" rather than removing it outright
- follow the established convention for what "" and NULL mean as
  booleans
- add tailored error message for conflicting options and tests for it
- rename parse_opt_merges to parse_opt_rebase_merges to avoid confusion
  with parse_opt_merge
- similarly, rename parse_merges_value to parse_rebase_merges_value
- move null check from parse_rebase_merges_value to
  parse_opt_rebase_merges
- remove tests that check whether the config system itself works

Suggestions not incorporated:

- remove the callback function
- make --rebase-merge without an argument override
  rebase.merges=rebase-cousins
- make rebase.merge accept only a subset of the possible boolean values,
  or change the meanings of some of those values
- make --rebase-merge="" and rebase.merge="" do different things without
  warning
- remove tests that verify that the command line option properly
  overrides the config option

Thanks to Johannes, Phillip, and Junio for your help making these
patches better. If you feel strongly about one of the unincorporated
suggestions, let's continue the discussion and try to figure out how to
make it happen.

Alex Henrie (3):
  rebase: add documentation and test for --no-rebase-merges
  rebase: deprecate --rebase-merges=""
  rebase: add a config option for --rebase-merges

 Documentation/config/rebase.txt        | 10 ++++
 Documentation/git-rebase.txt           |  5 +-
 builtin/rebase.c                       | 75 ++++++++++++++++++-------
 t/t3422-rebase-incompatible-options.sh | 12 ++++
 t/t3430-rebase-merges.sh               | 78 ++++++++++++++++++++++++++
 5 files changed, 160 insertions(+), 20 deletions(-)

Range-diff against v4:
1:  e6d44a194c = 1:  76e38ef9f8 rebase: add documentation and test for --no-rebase-merges
2:  393b43c4e1 ! 2:  c6099e6dee rebase: stop accepting --rebase-merges=""
    @@ Metadata
     Author: Alex Henrie <alexhenrie24@gmail.com>
     
      ## Commit message ##
    -    rebase: stop accepting --rebase-merges=""
    +    rebase: deprecate --rebase-merges=""
     
         The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
         empty string argument) has been an undocumented synonym of
    -    --rebase-merges=no-rebase-cousins. Stop accepting that syntax to avoid
    +    --rebase-merges=no-rebase-cousins. Deprecate that syntax to avoid
         confusion when a rebase.merges config option is introduced, where
    -    rebase.merges="" will be equivalent to not passing --rebase-merges.
    +    rebase.merges="" will be equivalent to --no-rebase-merges.
     
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      			 N_("use 'merge-base --fork-point' to refine upstream")),
      		OPT_STRING('s', "strategy", &options.strategy,
     @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    - 		imply_merge(&options, "--exec");
      
      	if (rebase_merges) {
    --		if (!*rebase_merges)
    + 		if (!*rebase_merges)
     -			; /* default mode; do nothing */
    --		else if (!strcmp("rebase-cousins", rebase_merges))
    -+		if (!strcmp("rebase-cousins", rebase_merges))
    ++			warning(_("--rebase-merges with an empty string "
    ++				  "argument is deprecated and will stop "
    ++				  "working in a future version of Git. Use "
    ++				  "--rebase-merges=no-rebase-cousins "
    ++				  "instead."));
    + 		else if (!strcmp("rebase-cousins", rebase_merges))
      			options.rebase_cousins = 1;
      		else if (strcmp("no-rebase-cousins", rebase_merges))
    - 			die(_("Unknown mode: %s"), rebase_merges);
     
      ## t/t3430-rebase-merges.sh ##
     @@ t/t3430-rebase-merges.sh: test_expect_success 'do not rebase cousins unless asked for' '
      	EOF
      '
      
    -+test_expect_success '--rebase-merges="" is invalid syntax' '
    -+	echo "fatal: Unknown mode: " >expect &&
    -+	test_must_fail git rebase --rebase-merges="" HEAD^ 2>actual &&
    -+	test_cmp expect actual
    ++test_expect_success '--rebase-merges="" is deprecated' '
    ++	git rebase --rebase-merges="" HEAD^ 2>actual &&
    ++	grep deprecated actual
     +'
     +
      test_expect_success 'refs/rewritten/* is worktree-local' '
3:  b1b6fbfa86 ! 3:  95cba9588c rebase: add a config option for --rebase-merges
    @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
      have `<upstream>` as direct ancestor will keep their original branch point,
     
      ## builtin/rebase.c ##
    +@@ builtin/rebase.c: struct rebase_options {
    + 	int fork_point;
    + 	int update_refs;
    + 	int config_autosquash;
    ++	int config_rebase_merges;
    + 	int config_update_refs;
    + };
    + 
    +@@ builtin/rebase.c: struct rebase_options {
    + 		.allow_empty_message = 1,               \
    + 		.autosquash = -1,                       \
    + 		.config_autosquash = -1,                \
    ++		.rebase_merges = -1,                    \
    ++		.config_rebase_merges = -1,             \
    + 		.update_refs = -1,                      \
    + 		.config_update_refs = -1,               \
    + 	}
     @@ builtin/rebase.c: static int run_specific_rebase(struct rebase_options *opts)
      	return status ? -1 : 0;
      }
      
    -+static void parse_merges_value(struct rebase_options *options, const char *value)
    ++static void parse_rebase_merges_value(struct rebase_options *options, const char *value)
     +{
    -+	if (value) {
    -+		if (!strcmp("no-rebase-cousins", value))
    -+			options->rebase_cousins = 0;
    -+		else if (!strcmp("rebase-cousins", value))
    -+			options->rebase_cousins = 1;
    -+		else
    -+			die(_("Unknown mode: %s"), value);
    -+	}
    -+
    -+	options->rebase_merges = 1;
    ++	if (!strcmp("no-rebase-cousins", value))
    ++		options->rebase_cousins = 0;
    ++	else if (!strcmp("rebase-cousins", value))
    ++		options->rebase_cousins = 1;
    ++	else
    ++		die(_("Unknown rebase-merges mode: %s"), value);
     +}
     +
      static int rebase_config(const char *var, const char *value, void *data)
    @@ builtin/rebase.c: static int rebase_config(const char *var, const char *value, v
      		return 0;
      	}
      
    -+	if (!strcmp(var, "rebase.merges") && value && *value) {
    -+		opts->rebase_merges = git_parse_maybe_bool(value);
    -+		if (opts->rebase_merges < 0)
    -+			parse_merges_value(opts, value);
    ++	if (!strcmp(var, "rebase.merges")) {
    ++		opts->config_rebase_merges = git_parse_maybe_bool(value);
    ++		if (opts->config_rebase_merges < 0) {
    ++			opts->config_rebase_merges = 1;
    ++			parse_rebase_merges_value(opts, value);
    ++		}
     +		return 0;
     +	}
     +
    - 	if (!strcmp(var, "rebase.backend")) {
    - 		return git_config_string(&opts->default_backend, var, value);
    - 	}
    + 	if (!strcmp(var, "rebase.updaterefs")) {
    + 		opts->config_update_refs = git_config_bool(var, value);
    + 		return 0;
     @@ builtin/rebase.c: static int parse_opt_empty(const struct option *opt, const char *arg, int unset)
      	return 0;
      }
      
    -+static int parse_opt_merges(const struct option *opt, const char *arg, int unset)
    ++static int parse_opt_rebase_merges(const struct option *opt, const char *arg, int unset)
     +{
     +	struct rebase_options *options = opt->value;
     +
    -+	if (unset)
    -+		options->rebase_merges = 0;
    -+	else
    -+		parse_merges_value(options, arg);
    ++	options->rebase_merges = !unset;
    ++
    ++	if (arg) {
    ++		if (!*arg) {
    ++			warning(_("--rebase-merges with an empty string "
    ++				  "argument is deprecated and will stop "
    ++				  "working in a future version of Git. Use "
    ++				  "--rebase-merges=no-rebase-cousins "
    ++				  "instead."));
    ++			arg = "no-rebase-cousins";
    ++		}
    ++		parse_rebase_merges_value(options, arg);
    ++	}
     +
     +	return 0;
     +}
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     +		OPT_CALLBACK_F('r', "rebase-merges", &options, N_("mode"),
      			N_("try to rebase merges instead of skipping them"),
     -			PARSE_OPT_OPTARG, NULL, (intptr_t)"no-rebase-cousins"},
    -+			PARSE_OPT_OPTARG, parse_opt_merges),
    ++			PARSE_OPT_OPTARG, parse_opt_rebase_merges),
      		OPT_BOOL(0, "fork-point", &options.fork_point,
      			 N_("use 'merge-base --fork-point' to refine upstream")),
      		OPT_STRING('s', "strategy", &options.strategy,
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      		imply_merge(&options, "--exec");
      
     -	if (rebase_merges) {
    --		if (!strcmp("rebase-cousins", rebase_merges))
    +-		if (!*rebase_merges)
    +-			warning(_("--rebase-merges with an empty string "
    +-				  "argument is deprecated and will stop "
    +-				  "working in a future version of Git. Use "
    +-				  "--rebase-merges=no-rebase-cousins "
    +-				  "instead."));
    +-		else if (!strcmp("rebase-cousins", rebase_merges))
     -			options.rebase_cousins = 1;
     -		else if (strcmp("no-rebase-cousins", rebase_merges))
     -			die(_("Unknown mode: %s"), rebase_merges);
     -		options.rebase_merges = 1;
    -+	if (options.rebase_merges)
    - 		imply_merge(&options, "--rebase-merges");
    +-		imply_merge(&options, "--rebase-merges");
     -	}
    - 
    +-
      	if (options.type == REBASE_APPLY) {
      		if (ignore_whitespace)
    + 			strvec_push(&options.git_am_opts,
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    + 				break;
    + 
    + 		if (i >= 0 || options.type == REBASE_APPLY) {
    +-			if (is_merge(&options))
    +-				die(_("apply options and merge options "
    +-					  "cannot be used together"));
    +-			else if (options.autosquash == -1 && options.config_autosquash == 1)
    ++			if (options.autosquash == -1 && options.config_autosquash == 1)
    + 				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
    ++			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
    ++				die(_("apply options are incompatible with rebase.merges.  Consider adding --no-rebase-merges"));
    + 			else if (options.update_refs == -1 && options.config_update_refs == 1)
    + 				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
    ++			else if (is_merge(&options))
    ++				die(_("apply options and merge options "
    ++					  "cannot be used together"));
    + 			else
    + 				options.type = REBASE_APPLY;
    + 		}
    +@@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix)
    + 	options.update_refs = (options.update_refs >= 0) ? options.update_refs :
    + 			     ((options.config_update_refs >= 0) ? options.config_update_refs : 0);
    + 
    ++	if (options.rebase_merges == 1)
    ++		imply_merge(&options, "--rebase-merges");
    ++	options.rebase_merges = (options.rebase_merges >= 0) ? options.rebase_merges :
    ++				((options.config_rebase_merges >= 0) ? options.config_rebase_merges : 0);
    ++
    + 	if (options.autosquash == 1)
    + 		imply_merge(&options, "--autosquash");
    + 	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
    +
    + ## t/t3422-rebase-incompatible-options.sh ##
    +@@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
    + 		grep -e --no-autosquash err
    + 	"
    + 
    ++	test_expect_success "$opt incompatible with rebase.merges" "
    ++		git checkout B^0 &&
    ++		test_must_fail git -c rebase.merges=true rebase $opt A 2>err &&
    ++		grep -e --no-rebase-merges err
    ++	"
    ++
    + 	test_expect_success "$opt incompatible with rebase.updateRefs" "
    + 		git checkout B^0 &&
    + 		test_must_fail git -c rebase.updateRefs=true rebase $opt A 2>err &&
    +@@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
    + 		git -c rebase.autosquash=true rebase --no-autosquash $opt A
    + 	"
    + 
    ++	test_expect_success "$opt okay with overridden rebase.merges" "
    ++		test_when_finished \"git reset --hard B^0\" &&
    ++		git checkout B^0 &&
    ++		git -c rebase.merges=true rebase --no-rebase-merges $opt A
    ++	"
    ++
    + 	test_expect_success "$opt okay with overridden rebase.updateRefs" "
    + 		test_when_finished \"git reset --hard B^0\" &&
    + 		git checkout B^0 &&
     
      ## t/t3430-rebase-merges.sh ##
    -@@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is invalid syntax' '
    - 	test_cmp expect actual
    +@@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated' '
    + 	grep deprecated actual
      '
      
    -+test_expect_success 'rebase.merges="" is equivalent to not passing --rebase-merges' '
    -+	test_config rebase.merges "" &&
    -+	git checkout -b config-merges-blank E &&
    -+	git rebase C &&
    -+	test_cmp_graph C.. <<-\EOF
    -+	* B
    -+	* D
    -+	o C
    -+	EOF
    -+'
    -+
     +test_expect_success 'rebase.merges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
     +	test_config rebase.merges rebase-cousins &&
     +	git checkout -b config-rebase-cousins main &&
    @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is invalid syn
     +	o H
     +	EOF
     +'
    -+
    -+test_expect_success 'local rebase.merges=false overrides global rebase.merges=true' '
    -+	test_config_global rebase.merges true &&
    -+	test_config rebase.merges false &&
    -+	git checkout -b override-global-config E &&
    -+	git rebase C &&
    -+	test_cmp_graph C.. <<-\EOF
    -+	* B
    -+	* D
    -+	o C
    -+	EOF
    -+'
    -+
    -+test_expect_success 'local rebase.merges="" does not override global rebase.merges=true' '
    -+	test_config_global rebase.merges no-rebase-cousins &&
    -+	test_config rebase.merges "" &&
    -+	git checkout -b no-override-global-config E &&
    -+	before="$(git rev-parse --verify HEAD)" &&
    -+	test_tick &&
    -+	git rebase C &&
    -+	test_cmp_rev HEAD $before
    -+'
     +
      test_expect_success 'refs/rewritten/* is worktree-local' '
      	git worktree add wt &&
-- 
2.39.2

