Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E155C6FA8E
	for <git@archiver.kernel.org>; Sun,  5 Mar 2023 05:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjCEFIK (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 00:08:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjCEFII (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 00:08:08 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F34F3BB98
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 21:08:05 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id q189so3675321pga.9
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 21:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677992885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5yWg0dWDtwT6mDknoA7/aCXzuwrHnpN0YSWyVDcXnQU=;
        b=LEdrR2BBDxxBRkSpKmbLPnpgFeFSjBX/+ih6QrfX2VPCzqLFKVXGE/1X87nG0UII7U
         CyEpb9JWZjV8/hQGN9nIYWwqH+ZvQiXdV9jUOPb+sfwZ5OWkf9GoFogH9TLGHulPmtC4
         UhVqeWmWYvTcd9Pwi9RUucPDI0lMsQHiuZuV/OtE1QmzczcxxTTsE1zfzfAHCS5omp2Z
         JgN5ARbVn7T33jCReJ+dfla8tUDYtPn7YrNVupNw+SVGHXRYplqGYRnctqnS0+ahtxxo
         wAAW9RbDRN+yCEOIn2x3jS1yzaArHrOmoS/JiRhgmBX7j3x1C/OzgZZwhOlrxoS//46E
         fOyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677992885;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5yWg0dWDtwT6mDknoA7/aCXzuwrHnpN0YSWyVDcXnQU=;
        b=xnNq0JWXo5NzbmfEQz/pflWcqeIFtMXP6/yLfFpmC6c47TDmCkQg91WVg02UjvEeio
         jYQ7H9Selo2J+e1h0ahp0AdQnYGBFlMZE19y9gsm5BTcIlKZGybTqZvatNM764QMCS6U
         tJDH/cPBFN7Ci06zltt2PWHzhCBsNsZiquB6uX0y1y4aj/iT3s6hFCxxZCMZo3EcEpIx
         VM0XCV4BLPV8DOrDITjDFJmIHy6etmrLOa5oUblf3Co6rM5ZI6+FfAAWfLUy8cI0/R6Y
         yv1AFqzZ8rWkS/E2QoGk7qACjYNfQAj/hQ1KCo3DCw/+2nh746k6V9pDZbaSaQVf+Vlq
         U/dA==
X-Gm-Message-State: AO0yUKWK3yS2JrAlRyCWaM+thth4FozJKfFVm0CdiP8EGEsIozzTrbR4
        y22qK5lX62KtWp4wY0o5XdYSgmNHTqssjg==
X-Google-Smtp-Source: AK7set/4pun76PrydD107lwSdScnKPhvkS3eGprHasb9EOcBEw5qYs+hgMne36qII6QXCfEWPgcUDg==
X-Received: by 2002:aa7:98de:0:b0:5df:3aa1:10c5 with SMTP id e30-20020aa798de000000b005df3aa110c5mr6575360pfm.14.1677992884929;
        Sat, 04 Mar 2023 21:08:04 -0800 (PST)
Received: from xavier.lan ([2607:fa18:92fe:92b::2a2])
        by smtp.gmail.com with ESMTPSA id v6-20020aa78506000000b005dd975176c3sm3996769pfn.53.2023.03.04.21.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Mar 2023 21:08:04 -0800 (PST)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, tao@klerks.biz, gitster@pobox.com,
        newren@gmail.com, phillip.wood123@gmail.com,
        Johannes.Schindelin@gmx.de, sorganov@gmail.com,
        chooglen@google.com, calvinwan@google.com, jonathantanmy@google.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v6 0/3] rebase: document, clean up, and introduce a config option for --rebase-merges
Date:   Sat,  4 Mar 2023 22:07:06 -0700
Message-Id: <20230305050709.68736-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230225180325.796624-1-alexhenrie24@gmail.com>
References: <20230225180325.796624-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This patch series introduces a rebase.rebaseMerges config option to
accommodate users who would like --rebase-merges to be on by default and
to facilitate turning on --rebase-merges by default without
configuration in a future version of Git. It also cleans up and
documents the behavior of the --rebase-merges command line option to
avoid confusion about how the config option and the command line option
interact.

Changes from v5:
- Add commit message note about --no-rebase-merges having always worked
- Add commit message note about the test for --no-rebase-merges being
  somewhat contrived
- Rephrase the documentation to avoid using the phrase "By default" with
  two different meanings, and in so doing clarify that --rebase-merges
  without an argument is not the same as --no-rebase-merges and not
  passing --rebase-merges is not the same as passing
  --rebase-merges=no-rebase-cousins
- Add commit message note about keeping --rebase-merges="" for now out
  of an abundance of caution
- Rephrase the warning about --rebase-merges="" to recommend
  --rebase-merges without an argument instead, and clarify that that
  will do the same thing
- Remove the test for --rebase-merges=""
- Rename the config option from rebase.merges to rebase.rebaseMerges and
  explain why in the commit message
- Add commit message note about why "true" is a valid option for
  rebase.rebaseMerges and why --rebase-merges without an argument does
  not clobber the mode specified in rebase.rebaseMerges
- Rephrase the documentation to clarify that --rebase-merges without an
  argument does not clobber the mode specified in rebase.rebaseMerges
- Add another test for incompatible options

Suggestions on v5 not incorporated in v6:
- Make --rebase-merges without an argument clobber the mode specified in
  rebase.rebaseMerges
- Remove the test for --rebase-merges=no-rebase-cousins overriding
  rebase.rebaseMerges=rebase-cousins
- In the tests, check the graph itself instead of checking that the
  graph has not changed by checking that the commit hash has not changed

Thanks to Glen, Calvin, Junio, Jonathan, Elijah, and Phillip for your
feedback on v5. As before, if you feel strongly about one of the
suggestions that I have not incorporated into v6, or if you see
something else amiss, let's continue the discussion.

Alex Henrie (3):
  rebase: add documentation and test for --no-rebase-merges
  rebase: deprecate --rebase-merges=""
  rebase: add a config option for --rebase-merges

 Documentation/config/rebase.txt        | 11 ++++
 Documentation/git-rebase.txt           | 19 ++++---
 builtin/rebase.c                       | 75 ++++++++++++++++++-------
 t/t3422-rebase-incompatible-options.sh | 17 ++++++
 t/t3430-rebase-merges.sh               | 78 ++++++++++++++++++++++++++
 5 files changed, 174 insertions(+), 26 deletions(-)

Range-diff against v5:
1:  76e38ef9f8 ! 1:  bf08c03ba7 rebase: add documentation and test for --no-rebase-merges
    @@ Metadata
      ## Commit message ##
         rebase: add documentation and test for --no-rebase-merges
     
    +    As far as I can tell, --no-rebase-merges has always worked, but has
    +    never been documented. It is especially important to document it before
    +    a rebase.rebaseMerges option is introduced so that users know how to
    +    override the config option on the command line. It's also important to
    +    clarify that --rebase-merges without an argument is not the same as
    +    --no-rebase-merges and not passing --rebase-merges is not the same as
    +    passing --rebase-merges=no-rebase-cousins.
    +
    +    A test case is necessary to make sure that --no-rebase-merges keeps
    +    working after its code is refactored in the following patches of this
    +    series. The test case is a little contrived: It's unlikely that a user
    +    would type both --rebase-merges and --no-rebase-merges at the same time.
    +    However, if an alias is defined which includes --rebase-merges, the user
    +    might decide to add --no-rebase-merges to countermand that part of the
    +    alias but leave alone other flags set by the alias.
    +
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
      ## Documentation/git-rebase.txt ##
    @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
     +	resolved/re-applied manually. `--no-rebase-merges` can be used to
     +	countermand a previous `--rebase-merges`.
      +
    - By default, or when `no-rebase-cousins` was specified, commits which do not
    - have `<upstream>` as direct ancestor will keep their original branch point,
    +-By default, or when `no-rebase-cousins` was specified, commits which do not
    +-have `<upstream>` as direct ancestor will keep their original branch point,
    +-i.e. commits that would be excluded by linkgit:git-log[1]'s
    +-`--ancestry-path` option will keep their original ancestry by default. If
    +-the `rebase-cousins` mode is turned on, such commits are instead rebased
    +-onto `<upstream>` (or `<onto>`, if specified).
    ++When rebasing merges, there are two modes: `rebase-cousins` and
    ++`no-rebase-cousins`. If the mode is not specified, it defaults to
    ++`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
    ++`<upstream>` as direct ancestor will keep their original branch point, i.e.
    ++commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
    ++option will keep their original ancestry by default. In `rebase-cousins` mode,
    ++such commits are instead rebased onto `<upstream>` (or `<onto>`, if
    ++specified).
    + +
    + It is currently only possible to recreate the merge commits using the
    + `ort` merge strategy; different merge strategies can be used only via
     
      ## t/t3430-rebase-merges.sh ##
     @@ t/t3430-rebase-merges.sh: test_expect_success 'with a branch tip that was cherry-picked already' '
2:  c6099e6dee ! 2:  26f98b8400 rebase: deprecate --rebase-merges=""
    @@ Commit message
     
         The unusual syntax --rebase-merges="" (that is, --rebase-merges with an
         empty string argument) has been an undocumented synonym of
    -    --rebase-merges=no-rebase-cousins. Deprecate that syntax to avoid
    -    confusion when a rebase.merges config option is introduced, where
    -    rebase.merges="" will be equivalent to --no-rebase-merges.
    +    --rebase-merges without an argument. Deprecate that syntax to avoid
    +    confusion when a rebase.rebaseMerges config option is introduced, where
    +    rebase.rebaseMerges="" will be equivalent to --no-rebase-merges.
    +
    +    It is not likely that anyone is actually using this syntax, but just in
    +    case, deprecate the empty string argument instead of dropping support
    +    for it immediately.
     
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     +			warning(_("--rebase-merges with an empty string "
     +				  "argument is deprecated and will stop "
     +				  "working in a future version of Git. Use "
    -+				  "--rebase-merges=no-rebase-cousins "
    -+				  "instead."));
    ++				  "--rebase-merges without an argument "
    ++				  "instead, which does the same thing."));
      		else if (!strcmp("rebase-cousins", rebase_merges))
      			options.rebase_cousins = 1;
      		else if (strcmp("no-rebase-cousins", rebase_merges))
    -
    - ## t/t3430-rebase-merges.sh ##
    -@@ t/t3430-rebase-merges.sh: test_expect_success 'do not rebase cousins unless asked for' '
    - 	EOF
    - '
    - 
    -+test_expect_success '--rebase-merges="" is deprecated' '
    -+	git rebase --rebase-merges="" HEAD^ 2>actual &&
    -+	grep deprecated actual
    -+'
    -+
    - test_expect_success 'refs/rewritten/* is worktree-local' '
    - 	git worktree add wt &&
    - 	cat >wt/script-from-scratch <<-\EOF &&
3:  95cba9588c ! 3:  402365256c rebase: add a config option for --rebase-merges
    @@ Commit message
         rebase: add a config option for --rebase-merges
     
         The purpose of the new option is to accommodate users who would like
    -    --rebase-merges to be on by default and to facilitate possibly turning
    -    on --rebase-merges by default without configuration in a future version
    -    of Git.
    +    --rebase-merges to be on by default and to facilitate turning on
    +    --rebase-merges by default without configuration in a future version of
    +    Git.
    +
    +    Name the new option rebase.rebaseMerges, even though it is a little
    +    redundant, for consistency with the name of the command line option and
    +    to be clear when scrolling through values in the [rebase] section of
    +    .gitconfig.
    +
    +    In the future, the default rebase-merges mode may change from
    +    no-rebase-cousins to rebase-cousins. Support setting rebase.rebaseMerges
    +    to the nonspecific value "true" for users who do not need or want to
    +    care about the default changing in the future. Similarly, for users who
    +    have --rebase-merges in an alias and want to get the future behavior
    +    now, use the specific rebase-merges mode from the config if a specific
    +    mode is not given on the command line.
     
         Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
     
    @@ Documentation/config/rebase.txt: rebase.rescheduleFailedExec::
      rebase.forkPoint::
      	If set to false set `--no-fork-point` option by default.
     +
    -+rebase.merges::
    ++rebase.rebaseMerges::
     +	Whether and how to set the `--rebase-merges` option by default. Can
     +	be `rebase-cousins`, `no-rebase-cousins`, or a boolean. Setting to
     +	true is equivalent to `--rebase-merges` without an argument, setting to
     +	`rebase-cousins` or `no-rebase-cousins` is equivalent to
     +	`--rebase-merges` with that value as its argument, and setting to false
     +	is equivalent to `--no-rebase-merges`. Passing `--rebase-merges` on the
    -+	command line without an argument overrides a `rebase.merges=false`
    -+	configuration but does not override other values of `rebase.merge`.
    ++	command line without an argument overrides a `rebase.rebaseMerges=false`
    ++	configuration, but the absence of a specific rebase-merges mode on the
    ++	command line does not counteract a specific mode set in the configuration.
     
      ## Documentation/git-rebase.txt ##
     @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
    @@ Documentation/git-rebase.txt: See also INCOMPATIBLE OPTIONS below.
      	manual amendments in these merge commits will have to be
      	resolved/re-applied manually. `--no-rebase-merges` can be used to
     -	countermand a previous `--rebase-merges`.
    -+	countermand both the `rebase.merges` config option and a previous
    ++	countermand both the `rebase.rebaseMerges` config option and a previous
     +	`--rebase-merges`.
      +
    - By default, or when `no-rebase-cousins` was specified, commits which do not
    - have `<upstream>` as direct ancestor will keep their original branch point,
    + When rebasing merges, there are two modes: `rebase-cousins` and
    +-`no-rebase-cousins`. If the mode is not specified, it defaults to
    +-`no-rebase-cousins`. In `no-rebase-cousins` mode, commits which do not have
    +-`<upstream>` as direct ancestor will keep their original branch point, i.e.
    +-commits that would be excluded by linkgit:git-log[1]'s `--ancestry-path`
    +-option will keep their original ancestry by default. In `rebase-cousins` mode,
    +-such commits are instead rebased onto `<upstream>` (or `<onto>`, if
    +-specified).
    ++`no-rebase-cousins`. If the mode is not specified on the command line or in
    ++the `rebase.rebaseMerges` config option, it defaults to `no-rebase-cousins`.
    ++In `no-rebase-cousins` mode, commits which do not have `<upstream>` as direct
    ++ancestor will keep their original branch point, i.e. commits that would be
    ++excluded by linkgit:git-log[1]'s `--ancestry-path` option will keep their
    ++original ancestry by default. In `rebase-cousins` mode, such commits are
    ++instead rebased onto `<upstream>` (or `<onto>`, if specified).
    + +
    + It is currently only possible to recreate the merge commits using the
    + `ort` merge strategy; different merge strategies can be used only via
     
      ## builtin/rebase.c ##
     @@ builtin/rebase.c: struct rebase_options {
    @@ builtin/rebase.c: static int rebase_config(const char *var, const char *value, v
      		return 0;
      	}
      
    -+	if (!strcmp(var, "rebase.merges")) {
    ++	if (!strcmp(var, "rebase.rebasemerges")) {
     +		opts->config_rebase_merges = git_parse_maybe_bool(value);
     +		if (opts->config_rebase_merges < 0) {
     +			opts->config_rebase_merges = 1;
    @@ builtin/rebase.c: static int parse_opt_empty(const struct option *opt, const cha
     +			warning(_("--rebase-merges with an empty string "
     +				  "argument is deprecated and will stop "
     +				  "working in a future version of Git. Use "
    -+				  "--rebase-merges=no-rebase-cousins "
    -+				  "instead."));
    -+			arg = "no-rebase-cousins";
    ++				  "--rebase-merges without an argument "
    ++				  "instead, which does the same thing."));
    ++			return 0;
     +		}
     +		parse_rebase_merges_value(options, arg);
     +	}
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     -			warning(_("--rebase-merges with an empty string "
     -				  "argument is deprecated and will stop "
     -				  "working in a future version of Git. Use "
    --				  "--rebase-merges=no-rebase-cousins "
    --				  "instead."));
    +-				  "--rebase-merges without an argument "
    +-				  "instead, which does the same thing."));
     -		else if (!strcmp("rebase-cousins", rebase_merges))
     -			options.rebase_cousins = 1;
     -		else if (strcmp("no-rebase-cousins", rebase_merges))
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
     +			if (options.autosquash == -1 && options.config_autosquash == 1)
      				die(_("apply options are incompatible with rebase.autosquash.  Consider adding --no-autosquash"));
     +			else if (options.rebase_merges == -1 && options.config_rebase_merges == 1)
    -+				die(_("apply options are incompatible with rebase.merges.  Consider adding --no-rebase-merges"));
    ++				die(_("apply options are incompatible with rebase.rebaseMerges.  Consider adding --no-rebase-merges"));
      			else if (options.update_refs == -1 && options.config_update_refs == 1)
      				die(_("apply options are incompatible with rebase.updateRefs.  Consider adding --no-update-refs"));
     +			else if (is_merge(&options))
    @@ builtin/rebase.c: int cmd_rebase(int argc, const char **argv, const char *prefix
      	options.autosquash = (options.autosquash >= 0) ? options.autosquash :
     
      ## t/t3422-rebase-incompatible-options.sh ##
    +@@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
    + 		test_must_fail git rebase $opt --reapply-cherry-picks A
    + 	"
    + 
    ++	test_expect_success "$opt incompatible with --rebase-merges" "
    ++		git checkout B^0 &&
    ++		test_must_fail git rebase $opt --rebase-merges A
    ++	"
    ++
    + 	test_expect_success "$opt incompatible with --update-refs" "
    + 		git checkout B^0 &&
    + 		test_must_fail git rebase $opt --update-refs A
     @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
      		grep -e --no-autosquash err
      	"
      
    -+	test_expect_success "$opt incompatible with rebase.merges" "
    ++	test_expect_success "$opt incompatible with rebase.rebaseMerges" "
     +		git checkout B^0 &&
    -+		test_must_fail git -c rebase.merges=true rebase $opt A 2>err &&
    ++		test_must_fail git -c rebase.rebaseMerges=true rebase $opt A 2>err &&
     +		grep -e --no-rebase-merges err
     +	"
     +
    @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
      		git -c rebase.autosquash=true rebase --no-autosquash $opt A
      	"
      
    -+	test_expect_success "$opt okay with overridden rebase.merges" "
    ++	test_expect_success "$opt okay with overridden rebase.rebaseMerges" "
     +		test_when_finished \"git reset --hard B^0\" &&
     +		git checkout B^0 &&
    -+		git -c rebase.merges=true rebase --no-rebase-merges $opt A
    ++		git -c rebase.rebaseMerges=true rebase --no-rebase-merges $opt A
     +	"
     +
      	test_expect_success "$opt okay with overridden rebase.updateRefs" "
    @@ t/t3422-rebase-incompatible-options.sh: test_rebase_am_only () {
      		git checkout B^0 &&
     
      ## t/t3430-rebase-merges.sh ##
    -@@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated' '
    - 	grep deprecated actual
    +@@ t/t3430-rebase-merges.sh: test_expect_success 'do not rebase cousins unless asked for' '
    + 	EOF
      '
      
    -+test_expect_success 'rebase.merges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
    -+	test_config rebase.merges rebase-cousins &&
    ++test_expect_success '--rebase-merges="" is deprecated' '
    ++	git rebase --rebase-merges="" HEAD^ 2>actual &&
    ++	grep deprecated actual
    ++'
    ++
    ++test_expect_success 'rebase.rebaseMerges=rebase-cousins is equivalent to --rebase-merges=rebase-cousins' '
    ++	test_config rebase.rebaseMerges rebase-cousins &&
     +	git checkout -b config-rebase-cousins main &&
     +	git rebase HEAD^ &&
     +	test_cmp_graph HEAD^.. <<-\EOF
    @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated'
     +	EOF
     +'
     +
    -+test_expect_success '--no-rebase-merges overrides rebase.merges=no-rebase-cousins' '
    -+	test_config rebase.merges no-rebase-cousins &&
    ++test_expect_success '--no-rebase-merges overrides rebase.rebaseMerges=no-rebase-cousins' '
    ++	test_config rebase.rebaseMerges no-rebase-cousins &&
     +	git checkout -b override-config-no-rebase-cousins E &&
     +	git rebase --no-rebase-merges C &&
     +	test_cmp_graph C.. <<-\EOF
    @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated'
     +	EOF
     +'
     +
    -+test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.merges=rebase-cousins' '
    -+	test_config rebase.merges rebase-cousins &&
    ++test_expect_success '--rebase-merges=no-rebase-cousins overrides rebase.rebaseMerges=rebase-cousins' '
    ++	test_config rebase.rebaseMerges rebase-cousins &&
     +	git checkout -b override-config-rebase-cousins main &&
     +	git rebase --rebase-merges=no-rebase-cousins HEAD^ &&
     +	test_cmp_graph HEAD^.. <<-\EOF
    @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated'
     +	EOF
     +'
     +
    -+test_expect_success '--rebase-merges overrides rebase.merges=false' '
    -+	test_config rebase.merges false &&
    ++test_expect_success '--rebase-merges overrides rebase.rebaseMerges=false' '
    ++	test_config rebase.rebaseMerges false &&
     +	git checkout -b override-config-merges-false E &&
     +	before="$(git rev-parse --verify HEAD)" &&
     +	test_tick &&
    @@ t/t3430-rebase-merges.sh: test_expect_success '--rebase-merges="" is deprecated'
     +	test_cmp_rev HEAD $before
     +'
     +
    -+test_expect_success '--rebase-merges does not override rebase.merges=rebase-cousins' '
    -+	test_config rebase.merges rebase-cousins &&
    ++test_expect_success '--rebase-merges does not override rebase.rebaseMerges=rebase-cousins' '
    ++	test_config rebase.rebaseMerges rebase-cousins &&
     +	git checkout -b no-override-config-rebase-cousins main &&
     +	git rebase --rebase-merges HEAD^ &&
     +	test_cmp_graph HEAD^.. <<-\EOF
-- 
2.39.2

