Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47B16C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D15CD206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 22:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XwG1G7MZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732075AbgKYWNB (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 17:13:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730399AbgKYWNB (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 17:13:01 -0500
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C541EC0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:00 -0800 (PST)
Received: by mail-wr1-x443.google.com with SMTP id k14so27290wrn.1
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 14:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/dLXU7tAWkAHF1s/vx/L5hX1jq6HKwkkegp+S9HQUl8=;
        b=XwG1G7MZurbmuSNTbzhlLEXy9YSwLBVtjaiUZXVx9gv/5+91ktBWu771aGb/gT5q7F
         8CftFddaThWpQrh9Kj+39eb+fi0V6+/97jfPLqCmgxQUGhQjbgjIxeLC6tUQPELnVsmo
         q2i6yLQqwRyWU/8G45aXmTbSCpzMxKswkxt0i7ey0z+BvmHfAexPq5fFqfMwOct3uHeB
         j4XP7+/22L4boJSjJt9NuSBRyYt07fGsJCshPstdVY1B1BX0X9AkExZHxuRnNRnOm+ph
         8xkii7zOyGTD2f37HEzbCePBjT3T7+S8QMivzHZ5BA7zZHhtEw/xKXASMl3E0WIHnq+/
         0aMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/dLXU7tAWkAHF1s/vx/L5hX1jq6HKwkkegp+S9HQUl8=;
        b=PPo8p9KSAAPC5p4ErVn5j4bDmmPWuxooDMiH5EQVph3wq01HRMmb+1A+WQKH8oJy/m
         ELDP1Gb4wV3s5LyxZ9x2jBW7XM648VZlcVWHQz8kkV4HZn3+hXJVDkrVn+JtQLPe5Ngf
         dKpp1KFaWDuRrostpoIgcGKp07c06Wqm6Zb7OpUZmtmEF1wT16SIDToTjEBqUApfLRIf
         vdUWh2J89Y+RLVcXaRfscQagfzhUhdLODajCSTe6HNQdaFeqY4e2+pNZoOEjdpHqYmhW
         ps6xnnQx2gmf9jCq4KgGTJSAnsyz8abz9+eq/cedyyIm5in8eJF9YX1i41o3O9ZO0UYu
         o3DA==
X-Gm-Message-State: AOAM533rnpPh/S+3AYYCTgUOAcbwNsoedY+nyPpmbQJPkoP5+iSJj0Yo
        FUOihG36EV4ZeLJ9eUTtC6WElcNv1kI=
X-Google-Smtp-Source: ABdhPJxpoZY+fvIqyhQCPCQ3TzYTm1+2Pg7XC0JeGBbGqK4p4z5UAn55LzlmFviQYAtFHMCR+iOaMA==
X-Received: by 2002:adf:ef4c:: with SMTP id c12mr53884wrp.242.1606342378666;
        Wed, 25 Nov 2020 14:12:58 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id s2sm6097332wmh.37.2020.11.25.14.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 14:12:57 -0800 (PST)
Message-Id: <pull.796.v3.git.1606342376.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
References: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 25 Nov 2020 22:12:48 +0000
Subject: [PATCH v3 0/8] config: add --fixed-value option
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Martin =?UTF-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <stolee@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As reported [1], 'git maintenance unregister' fails when a repository is
located in a directory with regex glob characters.

[1] 
https://lore.kernel.org/git/2c2db228-069a-947d-8446-89f4d3f6181a@gmail.com/T/#mb96fa4187a0d6aeda097cd95804a8aafc0273022

The discussed solution was to modify 'git config' to specify that the
'value_regex' argument should be treated as an exact string match. This is
the primary change in this series, with an additional patch at the end to
make 'git maintenance [un]register' use this option, when necessary.

While we're here, let's rename 'value_regex' to 'value_pattern' to make
things a bit clearer.

Updates in V3
=============

 * Renamed 'value_regex' to 'value_pattern' in code and 'value-pattern' in
   docs (except po/)
   
   
 * Reordered commits slightly to help with that rename.
   
   
 * Updated tests to use 'test_when_finished rm -f ...'
   
   
 * Changed all references to "glob" characters to "meta" characters.
   
   
 * Several other test modifications. Thanks, Emily, for the review!
   
   

Thanks, -Stolee

P.S. Happy Thanksgiving to those celebrating!

Derrick Stolee (8):
  config: convert multi_replace to flags
  config: replace 'value_regex' with 'value_pattern'
  t1300: test "set all" mode with value-pattern
  t1300: add test for --replace-all with value-pattern
  config: add --fixed-value option, un-implemented
  config: plumb --fixed-value into config API
  config: implement --fixed-value with --get*
  maintenance: use 'git config --fixed-value'

 Documentation/git-config.txt |  26 +++---
 builtin/branch.c             |   4 +-
 builtin/config.c             |  81 +++++++++++++++----
 builtin/gc.c                 |   5 +-
 builtin/remote.c             |   8 +-
 config.c                     |  75 ++++++++++--------
 config.h                     |  36 +++++++--
 t/t1300-config.sh            | 149 +++++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh       |  12 +++
 9 files changed, 321 insertions(+), 75 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-796%2Fderrickstolee%2Fmaintenance%2Fconfig-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-796/derrickstolee/maintenance/config-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/796

Range-diff vs v2:

 3:  0c152faa00 ! 1:  f0ed492096 config: convert multi_replace to flags
     @@ config.c: void git_config_set(const char *key, const char *value)
      - * if multi_replace==0, nothing, or only one matching key/value is replaced,
      - *     else all matching key/values (regardless how many) are removed,
      - *     before the new pair is written.
     -+ * if (flags & CONFIG_FLAGS_MULTI_REPLACE) == 0, at most one matching
     -+ *     key/value is replaced, else all matching key/values (regardless
     -+ *     how many) are removed, before the new pair is written.
     ++ * if flags contains the CONFIG_FLAGS_MULTI_REPLACE flag, all matching
     ++ *     key/values are removed before a single new pair is written. If the
     ++ *     flag is not present, then replace only the first match.
        *
        * Returns 0 on success.
        *
     @@ config.h: void git_config_set(const char *, const char *);
      +
      +/*
      + * When CONFIG_FLAGS_MULTI_REPLACE is specified, all matching key/values
     -+ * are removed before a new pair is written. If the flag is not present,
     -+ * then set operations replace only the first match.
     ++ * are removed before a single new pair is written. If the flag is not
     ++ * present, then set operations replace only the first match.
      + */
      +#define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
      +
 -:  ---------- > 2:  f135b001ad config: replace 'value_regex' with 'value_pattern'
 1:  ea3099719c ! 3:  3b72082326 t1300: test "set all" mode with value_regex
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    t1300: test "set all" mode with value_regex
     +    t1300: test "set all" mode with value-pattern
      
     -    Without additional modifiers, 'git config' attempts to set a single
     -    value in the .git/config file. When the value_regex parameter is
     -    supplied, this command behaves in a non-trivial manner.
     +    Without additional modifiers, 'git config <key> <value>' attempts
     +    to set a single value in the .git/config file. When the
     +    value-pattern parameter is supplied, this command behaves in a
     +    non-trivial manner.
      
     -    Consider 'git config key value value_regex'. The expected behavior
     -    is as follows:
     +    Consider 'git config <key> <value> <value-pattern>'. The expected
     +    behavior is as follows:
      
     -    1. If there are multiple existing values that match 'value_regex',
     +    1. If there are multiple existing values that match 'value-pattern',
             then the command fails. Users should use --replace-all instead.
      
     -    2. If there is one existing value that matches 'value_regex', then
     -       the new config has one entry where 'key=value'.
     -
     -    3. If there is no existing values match 'value_regex', then the
     +    2. If there is no existing values match 'value-pattern', then the
             'key=value' pair is appended, making this 'key' a multi-valued
             config setting.
      
     +    3. If there is one existing value that matches 'value-pattern', then
     +       the new config has one entry where 'key=value'.
     +
          Add a test that demonstrates these options. Break from the existing
          pattern in t1300-config.sh to use 'git config --file=<file>' instead of
     -    modifying .git/config directly. Also use 'git config --file=<file>
     -    --list' for config state comparison instead of the config file format.
     +    modifying .git/config directly to prevent possibly incompatible repo
     +    states. Also use 'git config --file=<file> --list' for config state
     +    comparison instead of the config file format. This makes the tests
     +    more readable.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ t/t1300-config.sh: test_expect_success '--replace-all does not invent newlines'
       	test_cmp expect .git/config
       '
       
     -+test_expect_success 'set all config with value_regex' '
     ++test_expect_success 'set all config with value-pattern' '
     ++	test_when_finished rm -f config initial &&
      +	git config --file=initial abc.key one &&
      +
     ++	# no match => add new entry
      +	cp initial config &&
      +	git config --file=config abc.key two a+ &&
      +	git config --file=config --list >actual &&
     @@ t/t1300-config.sh: test_expect_success '--replace-all does not invent newlines'
      +	EOF
      +	test_cmp expect actual &&
      +
     ++	# multiple matches => failure
      +	test_must_fail git config --file=config abc.key three o+ 2>err &&
      +	test_i18ngrep "has multiple values" err &&
     ++
     ++	# multiple values, no match => add
      +	git config --file=config abc.key three a+ &&
      +	git config --file=config --list >actual &&
      +	cat >expect <<-\EOF &&
     @@ t/t1300-config.sh: test_expect_success '--replace-all does not invent newlines'
      +	EOF
      +	test_cmp expect actual &&
      +
     -+	cp initial config &&
     -+	git config --file=config abc.key three o+ &&
     ++	# single match => replace
     ++	git config --file=config abc.key four h+ &&
      +	git config --file=config --list >actual &&
      +	cat >expect <<-\EOF &&
     -+	abc.key=three
     ++	abc.key=one
     ++	abc.key=two
     ++	abc.key=four
      +	EOF
      +	test_cmp expect actual
      +'
 2:  829d0ccd8c ! 4:  75fb74da83 t1300: add test for --replace-all with value_regex
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    t1300: add test for --replace-all with value_regex
     +    t1300: add test for --replace-all with value-pattern
      
          The --replace-all option was added in 4ddba79d (git-config-set: add more
     -    options) but was not tested along with the 'value_regex' parameter.
     -    Since we will be updating this option to optionally treat 'value_regex'
     +    options) but was not tested along with the 'value-pattern' parameter.
     +    Since we will be updating this option to optionally treat 'value-pattern'
          as a fixed string, let's add a test here that documents the current
          behavior.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
       ## t/t1300-config.sh ##
     -@@ t/t1300-config.sh: test_expect_success 'set all config with value_regex' '
     +@@ t/t1300-config.sh: test_expect_success 'set all config with value-pattern' '
       	test_cmp expect actual
       '
       
     -+test_expect_success '--replace-all and value_regex' '
     -+	rm -f config &&
     ++test_expect_success '--replace-all and value-pattern' '
     ++	test_when_finished rm -f config &&
      +	git config --file=config --add abc.key one &&
      +	git config --file=config --add abc.key two &&
      +	git config --file=config --add abc.key three &&
 4:  0e6a7371ed ! 5:  0c276ffcee config: add --fixed-value option, un-implemented
     @@ Metadata
       ## Commit message ##
          config: add --fixed-value option, un-implemented
      
     -    The 'git config' builtin takes a 'value_regex' parameter for several
     +    The 'git config' builtin takes a 'value-pattern' parameter for several
          actions. This can cause confusion when expecting exact value matches
     -    instead of regex matches, especially when the input string contains glob
     -    characters. While callers can escape the patterns themselves, it would
     -    be more friendly to allow an argument to disable the pattern matching in
     -    favor of an exact string match.
     +    instead of regex matches, especially when the input string contains
     +    metacharacters. While callers can escape the patterns themselves, it
     +    would be more friendly to allow an argument to disable the pattern
     +    matching in favor of an exact string match.
      
          Add a new '--fixed-value' option that does not currently change the
     -    behavior. The implementation will follow for each appropriate action.
     -    For now, check and test that --fixed-value will abort the command when
     -    included with an incompatible action or without a 'value_regex'
     -    argument.
     +    behavior. The implementation will be filled in by later changes for
     +    each appropriate action. For now, check and test that --fixed-value
     +    will abort the command when included with an incompatible action or
     +    without a 'value-pattern' argument.
      
          The name '--fixed-value' was chosen over something simpler like
          '--fixed' because some commands allow regular expressions on the
     @@ Documentation/git-config.txt: git-config - Get and set repository or global opti
       SYNOPSIS
       --------
       [verse]
     --'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
     -+'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
     +-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
     ++'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value-pattern]]
       'git config' [<file-option>] [--type=<type>] --add name value
     --'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
     --'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
     --'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
     --'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
     -+'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value_regex]
     -+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value_regex]
     -+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value_regex]
     -+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value_regex]
     +-'git config' [<file-option>] [--type=<type>] --replace-all name value [value-pattern]
     +-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value-pattern]
     +-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value-pattern]
     +-'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value-pattern]
     ++'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value-pattern]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value-pattern]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value-pattern]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value-pattern]
       'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
     --'git config' [<file-option>] --unset name [value_regex]
     --'git config' [<file-option>] --unset-all name [value_regex]
     -+'git config' [<file-option>] [--fixed-value] --unset name [value_regex]
     -+'git config' [<file-option>] [--fixed-value] --unset-all name [value_regex]
     +-'git config' [<file-option>] --unset name [value-pattern]
     +-'git config' [<file-option>] --unset-all name [value-pattern]
     ++'git config' [<file-option>] [--fixed-value] --unset name [value-pattern]
     ++'git config' [<file-option>] [--fixed-value] --unset-all name [value-pattern]
       'git config' [<file-option>] --rename-section old_name new_name
       'git config' [<file-option>] --remove-section name
       'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
     @@ Documentation/git-config.txt: See also <<FILES>>.
       	List all variables set in config file, along with their values.
       
      +--fixed-value::
     -+	When used with the `value_regex` argument, treat `value_regex` as
     ++	When used with the `value-pattern` argument, treat `value-pattern` as
      +	an exact string instead of a regular expression. This will restrict
      +	the name/value pairs that are matched to only those where the value
     -+	is exactly equal to the `value_regex`.
     ++	is exactly equal to the `value-pattern`.
      +
       --type <type>::
         'git config' will ensure that any input or output is valid under the given
     @@ builtin/config.c: static struct option builtin_config_options[] = {
       	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
       	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
       	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
     -+	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when matching values")),
     ++	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when comparing values to 'value-pattern'")),
       	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
       	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
       	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       		usage_builtin_config();
       	}
       
     ++	/* check usage of --fixed-value */
      +	if (fixed_value) {
      +		int allowed_usage = 0;
      +
      +		switch (actions) {
     ++		/* git config --get <name> <value-pattern> */
      +		case ACTION_GET:
     ++		/* git config --get-all <name> <value-pattern> */
      +		case ACTION_GET_ALL:
     ++		/* git config --get-regexp <name-pattern> <value-pattern> */
      +		case ACTION_GET_REGEXP:
     ++		/* git config --unset <name> <value-pattern> */
      +		case ACTION_UNSET:
     ++		/* git config --unset-all <name> <value-pattern> */
      +		case ACTION_UNSET_ALL:
      +			allowed_usage = argc > 1 && !!argv[1];
      +			break;
      +
     ++		/* git config <name> <value> <value-pattern> */
      +		case ACTION_SET_ALL:
     ++		/* git config --replace-all <name> <value> <value-pattern> */
      +		case ACTION_REPLACE_ALL:
      +			allowed_usage = argc > 2 && !!argv[2];
      +			break;
     ++
     ++		/* other options don't allow --fixed-value */
      +		}
      +
      +		if (!allowed_usage) {
     -+			error(_("--fixed-value only applies with 'value_regex'"));
     ++			error(_("--fixed-value only applies with 'value-pattern'"));
      +			usage_builtin_config();
      +		}
      +	}
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       
      
       ## t/t1300-config.sh ##
     -@@ t/t1300-config.sh: test_expect_success '--replace-all and value_regex' '
     +@@ t/t1300-config.sh: test_expect_success '--replace-all and value-pattern' '
       	test_cmp expect actual
       '
       
      +test_expect_success 'refuse --fixed-value for incompatible actions' '
     ++	test_when_finished rm -f config &&
      +	git config --file=config dev.null bogus &&
      +
      +	# These modes do not allow --fixed-value at all
     @@ t/t1300-config.sh: test_expect_success '--replace-all and value_regex' '
      +	test_must_fail git config --file=config --fixed-value --get-color dev.null &&
      +	test_must_fail git config --file=config --fixed-value --get-colorbool dev.null &&
      +
     -+	# These modes complain when --fixed-value has no value_regex
     ++	# These modes complain when --fixed-value has no value-pattern
      +	test_must_fail git config --file=config --fixed-value dev.null bogus &&
      +	test_must_fail git config --file=config --fixed-value --replace-all dev.null bogus &&
      +	test_must_fail git config --file=config --fixed-value --get dev.null &&
 5:  39718048cd ! 6:  763401da97 config: plumb --fixed-value into config API
     @@ Commit message
      
          The git_config_set_multivar_in_file_gently() and related methods now
          take a 'flags' bitfield, so add a new bit representing the --fixed-value
     -    option from 'git config'. This alters the purpose of the value_regex
     +    option from 'git config'. This alters the purpose of the value_pattern
          parameter to be an exact string match. This requires some initialization
          changes in git_config_set_multivar_in_file_gently() and a new strcmp()
          call in the matches() method.
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
       
      @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
     - 			error(_("--fixed-value only applies with 'value_regex'"));
     + 			error(_("--fixed-value only applies with 'value-pattern'"));
       			usage_builtin_config();
       		}
      +
     -+		flags = CONFIG_FLAGS_FIXED_VALUE;
     ++		flags |= CONFIG_FLAGS_FIXED_VALUE;
       	}
       
       	if (actions & PAGING_ACTIONS)
     @@ config.c: struct config_store_data {
       	size_t baselen;
       	char *key;
       	int do_not_match;
     -+	const char *literal_value;
     - 	regex_t *value_regex;
     ++	const char *fixed_value;
     + 	regex_t *value_pattern;
       	int multi_replace;
       	struct {
      @@ config.c: static int matches(const char *key, const char *value,
       {
       	if (strcmp(key, store->key))
       		return 0; /* not ours */
     -+	if (store->literal_value)
     -+		return !strcmp(store->literal_value, value);
     - 	if (!store->value_regex)
     ++	if (store->fixed_value)
     ++		return !strcmp(store->fixed_value, value);
     + 	if (!store->value_pattern)
       		return 1; /* always matches */
     - 	if (store->value_regex == CONFIG_REGEX_NONE)
     + 	if (store->value_pattern == CONFIG_REGEX_NONE)
      @@ config.c: int git_config_set_multivar_in_file_gently(const char *config_filename,
     - 			store.value_regex = NULL;
     - 		else if (value_regex == CONFIG_REGEX_NONE)
     - 			store.value_regex = CONFIG_REGEX_NONE;
     + 			store.value_pattern = NULL;
     + 		else if (value_pattern == CONFIG_REGEX_NONE)
     + 			store.value_pattern = CONFIG_REGEX_NONE;
      +		else if (flags & CONFIG_FLAGS_FIXED_VALUE)
     -+			store.literal_value = value_regex;
     ++			store.fixed_value = value_pattern;
       		else {
     - 			if (value_regex[0] == '!') {
     + 			if (value_pattern[0] == '!') {
       				store.do_not_match = 1;
      
       ## config.h ##
     @@ config.h: int git_config_key_is_valid(const char *key);
       
      +/*
      + * When CONFIG_FLAGS_FIXED_VALUE is specified, match key/value pairs
     -+ * by string comparison (not regex match) to the provided value_regex
     ++ * by string comparison (not regex match) to the provided value_pattern
      + * parameter.
      + */
      +#define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
     @@ t/t1300-config.sh: test_expect_success 'refuse --fixed-value for incompatible ac
       '
       
      +test_expect_success '--fixed-value uses exact string matching' '
     -+	GLOB="a+b*c?d[e]f.g" &&
     -+	rm -f initial &&
     -+	git config --file=initial fixed.test "$GLOB" &&
     ++	test_when_finished rm -f config initial &&
     ++	META="a+b*c?d[e]f.g" &&
     ++	git config --file=initial fixed.test "$META" &&
      +
      +	cp initial config &&
     -+	git config --file=config fixed.test bogus "$GLOB" &&
     ++	git config --file=config fixed.test bogus "$META" &&
      +	git config --file=config --list >actual &&
      +	cat >expect <<-EOF &&
     -+	fixed.test=$GLOB
     ++	fixed.test=$META
      +	fixed.test=bogus
      +	EOF
      +	test_cmp expect actual &&
      +
      +	cp initial config &&
     -+	git config --file=config --fixed-value fixed.test bogus "$GLOB" &&
     ++	git config --file=config --fixed-value fixed.test bogus "$META" &&
      +	git config --file=config --list >actual &&
     -+	printf "fixed.test=bogus\n" >expect &&
     ++	cat >expect <<-\EOF &&
     ++	fixed.test=bogus
     ++	EOF
      +	test_cmp expect actual &&
      +
      +	cp initial config &&
     -+	test_must_fail git config --file=config --unset fixed.test "$GLOB" &&
     -+	git config --file=config --fixed-value --unset fixed.test "$GLOB" &&
     ++	test_must_fail git config --file=config --unset fixed.test "$META" &&
     ++	git config --file=config --fixed-value --unset fixed.test "$META" &&
      +	test_must_fail git config --file=config fixed.test &&
      +
      +	cp initial config &&
     -+	test_must_fail git config --file=config --unset-all fixed.test "$GLOB" &&
     -+	git config --file=config --fixed-value --unset-all fixed.test "$GLOB" &&
     ++	test_must_fail git config --file=config --unset-all fixed.test "$META" &&
     ++	git config --file=config --fixed-value --unset-all fixed.test "$META" &&
      +	test_must_fail git config --file=config fixed.test &&
      +
      +	cp initial config &&
     -+	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
     -+	git config --file=config --list >actual &&
     -+	cat >expect <<-EOF &&
     -+	fixed.test=$GLOB
     -+	fixed.test=bogus
     -+	EOF
     -+	test_cmp expect actual &&
     -+
     -+	cp initial config &&
     -+	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
     ++	git config --file=config --replace-all fixed.test bogus "$META" &&
      +	git config --file=config --list >actual &&
      +	cat >expect <<-EOF &&
     -+	fixed.test=$GLOB
     ++	fixed.test=$META
      +	fixed.test=bogus
      +	EOF
      +	test_cmp expect actual &&
      +
     -+	git config --file=config --fixed-value --replace-all fixed.test bogus "$GLOB" &&
     ++	git config --file=config --fixed-value --replace-all fixed.test bogus "$META" &&
      +	git config --file=config --list >actual &&
      +	cat >expect <<-EOF &&
      +	fixed.test=bogus
 6:  8e0111c7b4 ! 7:  d813c84275 config: implement --fixed-value with --get*
     @@ Commit message
      
          The config builtin does its own regex matching of values for the --get,
          --get-all, and --get-regexp modes. Plumb the existing 'flags' parameter
     -    to the get_value() method so we can initialize the value_regex argument
     +    to the get_value() method so we can initialize the value-pattern argument
          as a fixed string instead of a regex pattern.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ builtin/config.c: static const char *const builtin_config_usage[] = {
       
       static char *key;
       static regex_t *key_regexp;
     -+static const char *value_regex;
     ++static const char *value_pattern;
       static regex_t *regexp;
       static int show_keys;
       static int omit_values;
     @@ builtin/config.c: static int collect_config(const char *key_, const char *value_
       		return 0;
       	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
       		return 0;
     -+	if (fixed_value && strcmp(value_regex, (value_?value_:"")))
     ++	if (fixed_value && strcmp(value_pattern, (value_?value_:"")))
      +		return 0;
       	if (regexp != NULL &&
       	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
     @@ builtin/config.c: static int collect_config(const char *key_, const char *value_
       }
       
      -static int get_value(const char *key_, const char *regex_)
     -+static int get_value(const char *key_, const char *regex_, int flags)
     ++static int get_value(const char *key_, const char *regex_, unsigned flags)
       {
       	int ret = CONFIG_GENERIC_ERROR;
       	struct strbuf_list values = {NULL};
     @@ builtin/config.c: static int get_value(const char *key_, const char *regex_)
       
      -	if (regex_) {
      +	if (regex_ && (flags & CONFIG_FLAGS_FIXED_VALUE))
     -+		value_regex = regex_;
     ++		value_pattern = regex_;
      +	else if (regex_) {
       		if (regex_[0] == '!') {
       			do_not_match = 1;
     @@ t/t1300-config.sh: test_expect_success '--fixed-value uses exact string matching
       '
       
      +test_expect_success '--get and --get-all with --fixed-value' '
     -+	GLOB="a+b*c?d[e]f.g" &&
     -+	rm -f config &&
     ++	test_when_finished rm -f config &&
     ++	META="a+b*c?d[e]f.g" &&
      +	git config --file=config fixed.test bogus &&
     -+	git config --file=config --add fixed.test "$GLOB" &&
     ++	git config --file=config --add fixed.test "$META" &&
      +
      +	git config --file=config --get fixed.test bogus &&
     -+	test_must_fail git config --file=config --get fixed.test "$GLOB" &&
     -+	git config --file=config --get --fixed-value fixed.test "$GLOB" &&
     ++	test_must_fail git config --file=config --get fixed.test "$META" &&
     ++	git config --file=config --get --fixed-value fixed.test "$META" &&
      +	test_must_fail git config --file=config --get --fixed-value fixed.test non-existent &&
      +
      +	git config --file=config --get-all fixed.test bogus &&
     -+	test_must_fail git config --file=config --get-all fixed.test "$GLOB" &&
     -+	git config --file=config --get-all --fixed-value fixed.test "$GLOB" &&
     ++	test_must_fail git config --file=config --get-all fixed.test "$META" &&
     ++	git config --file=config --get-all --fixed-value fixed.test "$META" &&
      +	test_must_fail git config --file=config --get-all --fixed-value fixed.test non-existent &&
      +
      +	git config --file=config --get-regexp fixed+ bogus &&
     -+	test_must_fail git config --file=config --get-regexp fixed+ "$GLOB" &&
     -+	git config --file=config --get-regexp --fixed-value fixed+ "$GLOB" &&
     ++	test_must_fail git config --file=config --get-regexp fixed+ "$META" &&
     ++	git config --file=config --get-regexp --fixed-value fixed+ "$META" &&
      +	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
      +'
      +
 7:  5a3acf8119 ! 8:  558775f83d maintenance: use 'git config --fixed-value'
     @@ Metadata
       ## Commit message ##
          maintenance: use 'git config --fixed-value'
      
     -    When a repository's leading directories contain regex glob characters,
     +    When a repository's leading directories contain regex metacharacters,
          the config calls for 'git maintenance register' and 'git maintenance
          unregister' are not careful enough. Use the new --fixed-value option
          to direct the config machinery to use exact string matches. This is a
     -    more robust option than excaping these arguments in a piecemeal fashion.
     +    more robust option than escaping these arguments in a piecemeal fashion.
      
          For the test, require that we are not running on Windows since the '+'
     -    character is not allowed on that filesystem.
     +    and '*' characters are not allowed on that filesystem.
      
          Reported-by: Emily Shaffer <emilyshaffer@google.com>
          Reported-by: Jonathan Nieder <jrnieder@gmail.com>
     @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
       	test_cmp before actual
       '
       
     -+test_expect_success !MINGW 'register and unregister with glob characters' '
     -+	GLOB="a+b*c" &&
     -+	git init "$GLOB" &&
     -+	git -C "$GLOB" maintenance register &&
     ++test_expect_success !MINGW 'register and unregister with regex metacharacters' '
     ++	META="a+b*c" &&
     ++	git init "$META" &&
     ++	git -C "$META" maintenance register &&
      +	git config --get-all --show-origin maintenance.repo &&
      +	git config --get-all --global --fixed-value \
     -+		maintenance.repo "$(pwd)/$GLOB" &&
     -+	git -C "$GLOB" maintenance unregister &&
     ++		maintenance.repo "$(pwd)/$META" &&
     ++	git -C "$META" maintenance unregister &&
      +	test_must_fail git config --get-all --global --fixed-value \
     -+		maintenance.repo "$(pwd)/$GLOB"
     ++		maintenance.repo "$(pwd)/$META"
      +'
      +
       test_expect_success 'start from empty cron table' '

-- 
gitgitgadget
