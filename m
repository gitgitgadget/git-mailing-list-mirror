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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCE13C56202
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 693A02080A
	for <git@archiver.kernel.org>; Mon, 23 Nov 2020 16:05:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="doezNZJW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388607AbgKWQFN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Nov 2020 11:05:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732655AbgKWQFM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Nov 2020 11:05:12 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29EC3C0613CF
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:12 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id r3so815264wrt.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2020 08:05:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=rmhIq6gaGnwB+2ypg/VnYy4wF3i0X+oRgShUOt1qYVc=;
        b=doezNZJWMVMB/t5Y01POXRtuVWJlClgauNsQYzZnoGm9jtAlyByCzLCEOES8TwV4NB
         5P+deFGnvHPL1r2guG3KFWVHmou5oczbtLuaqlNRmGo6WnodZE9jvetC5KMg1qJb1lF1
         9kQCt2sna5VcywvxeG6wRlkPQVgHBmhSpeObJt+rI3y82c/tQA/JVDWoYdyMY0r9BUIl
         yGoyLkvDrDuQD7uXamVFa9qgXEpbS7baS3wcG2meqLOy3qH+nSG/0Y3cY+KS2EMH7OvG
         jRGoUIPNXavjmOryWREQhPNu4E0iWvTZVIKpCSYbCwmNSgYNyi33QaYOholmQMP2irFY
         2MgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=rmhIq6gaGnwB+2ypg/VnYy4wF3i0X+oRgShUOt1qYVc=;
        b=TGC48Xr2s+Ndp/aWptR9FDwAJCn9tum58nw6RSprEjL53/FpHLL/h6MuwNoY6VcbO/
         WWuMAkL2yoxbT/KHPU6tu1GAOfuiJGXxyEnMyaJc4x+CjPb6Jdb4UngruQtN+sdlm6Pw
         Rhjq60twGfzT2PBfwS77OcBfQRKGFUOzDrEeAD6XLvgTRxHYvU4FqZEUs65jH814/gJN
         +fpXnBschyhgeAuwz5RaRy46MexSnvAw9ka7akjK+Orgaqq+V1Z9WhObCY+u1kzFH0rq
         nVOYbOE1tREV3fPOU7ytbcpt3Yt6qlOwLAskgxUTX9j9e8kkL5ttid9o9nN6b1tNb8QF
         j59Q==
X-Gm-Message-State: AOAM532nKoyUltIG+RmZEtT+NSrh5yjb9FAhv8hOsAPLyt56YhSvMxAP
        2ipcBm6M+cV0sX+TJsnsYrFC/fwnaeE=
X-Google-Smtp-Source: ABdhPJyXUvLqS0Nplv3FNca/T7O9up2/Xc62LzMwnaFCAHsV0TmD0YAe4nRATqJ2Ox0PFbm2C2MKTA==
X-Received: by 2002:a5d:40cd:: with SMTP id b13mr400951wrq.52.1606147509758;
        Mon, 23 Nov 2020 08:05:09 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d8sm17165780wmb.11.2020.11.23.08.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2020 08:05:08 -0800 (PST)
Message-Id: <pull.796.v2.git.1606147507.gitgitgadget@gmail.com>
In-Reply-To: <pull.796.git.1605801143.gitgitgadget@gmail.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Nov 2020 16:05:00 +0000
Subject: [PATCH v2 0/7] config: add --fixed-value option
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

Updates in V2
=============

 * Updated the test structure for the new tests in t1300-config.sh
   
   
 * Renamed option from '--literal-value' to '--fixed-value'
   
   
 * Use 'unsigned flags' instead of 'int flags'. This changes more prototypes
   than before.
   
   
 * Move flag definitions closer to method declarations.
   
   
 * Test the uses of --fixed-value to reject when value_regex is missing.
   
   

Thanks, -Stolee

Derrick Stolee (7):
  t1300: test "set all" mode with value_regex
  t1300: add test for --replace-all with value_regex
  config: convert multi_replace to flags
  config: add --fixed-value option, un-implemented
  config: plumb --fixed-value into config API
  config: implement --fixed-value with --get*
  maintenance: use 'git config --fixed-value'

 Documentation/git-config.txt |  20 +++--
 builtin/branch.c             |   4 +-
 builtin/config.c             |  59 +++++++++++---
 builtin/gc.c                 |   5 +-
 builtin/remote.c             |   8 +-
 config.c                     |  29 ++++---
 config.h                     |  36 +++++++--
 t/t1300-config.sh            | 148 +++++++++++++++++++++++++++++++++++
 t/t7900-maintenance.sh       |  12 +++
 9 files changed, 278 insertions(+), 43 deletions(-)


base-commit: 0016b618182f642771dc589cf0090289f9fe1b4f
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-796%2Fderrickstolee%2Fmaintenance%2Fconfig-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-796/derrickstolee/maintenance/config-v2
Pull-Request: https://github.com/gitgitgadget/git/pull/796

Range-diff vs v1:

 1:  2da2131114 ! 1:  ea3099719c t1300: test "set all" mode with value_regex
     @@ Commit message
             'key=value' pair is appended, making this 'key' a multi-valued
             config setting.
      
     -    Add a test that demonstrates these options.
     +    Add a test that demonstrates these options. Break from the existing
     +    pattern in t1300-config.sh to use 'git config --file=<file>' instead of
     +    modifying .git/config directly. Also use 'git config --file=<file>
     +    --list' for config state comparison instead of the config file format.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ t/t1300-config.sh: test_expect_success '--replace-all does not invent newlines'
       '
       
      +test_expect_success 'set all config with value_regex' '
     -+	q_to_tab >initial <<-\EOF &&
     -+	[abc]
     -+	Qkey = one
     -+	EOF
     ++	git config --file=initial abc.key one &&
      +
     -+	cp initial .git/config &&
     -+	git config abc.key two a+ &&
     -+	q_to_tab >expect <<-\EOF &&
     -+	[abc]
     -+	Qkey = one
     -+	Qkey = two
     ++	cp initial config &&
     ++	git config --file=config abc.key two a+ &&
     ++	git config --file=config --list >actual &&
     ++	cat >expect <<-\EOF &&
     ++	abc.key=one
     ++	abc.key=two
      +	EOF
     -+	test_cmp expect .git/config &&
     ++	test_cmp expect actual &&
      +
     -+	test_must_fail git config abc.key three o+ 2>err &&
     ++	test_must_fail git config --file=config abc.key three o+ 2>err &&
      +	test_i18ngrep "has multiple values" err &&
     -+	git config abc.key three a+ &&
     -+	q_to_tab >expect <<-\EOF &&
     -+	[abc]
     -+	Qkey = one
     -+	Qkey = two
     -+	Qkey = three
     ++	git config --file=config abc.key three a+ &&
     ++	git config --file=config --list >actual &&
     ++	cat >expect <<-\EOF &&
     ++	abc.key=one
     ++	abc.key=two
     ++	abc.key=three
      +	EOF
     -+	test_cmp expect .git/config &&
     ++	test_cmp expect actual &&
      +
     -+	cp initial .git/config &&
     -+	git config abc.key three o+ &&
     -+	q_to_tab >expect <<-\EOF &&
     -+	[abc]
     -+	Qkey = three
     ++	cp initial config &&
     ++	git config --file=config abc.key three o+ &&
     ++	git config --file=config --list >actual &&
     ++	cat >expect <<-\EOF &&
     ++	abc.key=three
      +	EOF
     -+	test_cmp expect .git/config
     ++	test_cmp expect actual
      +'
      +
       test_done
 2:  1237289706 ! 2:  829d0ccd8c t1300: add test for --replace-all with value_regex
     @@ Commit message
      
       ## t/t1300-config.sh ##
      @@ t/t1300-config.sh: test_expect_success 'set all config with value_regex' '
     - 	test_cmp expect .git/config
     + 	test_cmp expect actual
       '
       
      +test_expect_success '--replace-all and value_regex' '
     -+	q_to_tab >.git/config <<-\EOF &&
     -+	[abc]
     -+	Qkey = one
     -+	Qkey = two
     -+	Qkey = three
     ++	rm -f config &&
     ++	git config --file=config --add abc.key one &&
     ++	git config --file=config --add abc.key two &&
     ++	git config --file=config --add abc.key three &&
     ++	git config --file=config --replace-all abc.key four "o+" &&
     ++	git config --file=config --list >actual &&
     ++	cat >expect <<-\EOF &&
     ++	abc.key=four
     ++	abc.key=three
      +	EOF
     -+	q_to_tab >expect <<-\EOF &&
     -+	[abc]
     -+	Qkey = four
     -+	Qkey = three
     -+	EOF
     -+	git config --replace-all abc.key four "o+" &&
     -+	test_cmp expect .git/config
     ++	test_cmp expect actual
      +'
      +
       test_done
 3:  c9caed3854 ! 3:  0c152faa00 config: convert multi_replace to flags
     @@ Commit message
      
          We will extend the flexibility of the config API. Before doing so, let's
          take an existing 'int multi_replace' parameter and replace it with a new
     -    'int flags' parameter that can take multiple options as a bit field.
     +    'unsigned flags' parameter that can take multiple options as a bit field.
      
          Update all callers that specified multi_replace to now specify the
          CONFIG_FLAGS_MULTI_REPLACE flag. To add more clarity, extend the
          documentation of git_config_set_multivar_in_file() including a clear
     -    labeling of its arguments. Other config API methods in config.h do not
     -    require a change to their prototypes, but they have an equivalent update
     -    to their implementations.
     +    labeling of its arguments. Other config API methods in config.h require
     +    only a change of the final parameter from 'int' to 'unsigned'.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
      
     @@ config.c: void git_config_set(const char *key, const char *value)
       					   const char *key, const char *value,
       					   const char *value_regex,
      -					   int multi_replace)
     -+					   int flags)
     ++					   unsigned flags)
       {
       	int fd = -1, in_fd = -1;
       	int ret;
     @@ config.c: int git_config_set_multivar_in_file_gently(const char *config_filename
       void git_config_set_multivar_in_file(const char *config_filename,
       				     const char *key, const char *value,
      -				     const char *value_regex, int multi_replace)
     -+				     const char *value_regex, int flags)
     ++				     const char *value_regex, unsigned flags)
       {
       	if (!git_config_set_multivar_in_file_gently(config_filename, key, value,
      -						    value_regex, multi_replace))
     @@ config.c: void git_config_set_multivar_in_file(const char *config_filename,
       
       int git_config_set_multivar_gently(const char *key, const char *value,
      -				   const char *value_regex, int multi_replace)
     -+				   const char *value_regex, int flags)
     ++				   const char *value_regex, unsigned flags)
       {
       	return git_config_set_multivar_in_file_gently(NULL, key, value, value_regex,
      -						      multi_replace);
     @@ config.c: void git_config_set_multivar_in_file(const char *config_filename,
       
       void git_config_set_multivar(const char *key, const char *value,
      -			     const char *value_regex, int multi_replace)
     -+			     const char *value_regex, int flags)
     ++			     const char *value_regex, unsigned flags)
       {
       	git_config_set_multivar_in_file(NULL, key, value, value_regex,
      -					multi_replace);
     @@ config.c: void git_config_set_multivar_in_file(const char *config_filename,
       static int section_name_match (const char *buf, const char *name)
      
       ## config.h ##
     -@@ config.h: enum config_event_t {
     - 	CONFIG_EVENT_ERROR
     - };
     +@@ config.h: void git_config_set(const char *, const char *);
       
     + int git_config_parse_key(const char *, char **, size_t *);
     + int git_config_key_is_valid(const char *key);
     +-int git_config_set_multivar_gently(const char *, const char *, const char *, int);
     +-void git_config_set_multivar(const char *, const char *, const char *, int);
     +-int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, int);
     ++
     ++/*
     ++ * The following macros specify flag bits that alter the behavior
     ++ * of the git_config_set_multivar*() methods.
     ++ */
     ++
      +/*
      + * When CONFIG_FLAGS_MULTI_REPLACE is specified, all matching key/values
      + * are removed before a new pair is written. If the flag is not present,
     @@ config.h: enum config_event_t {
      + */
      +#define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
      +
     - /*
     -  * The parser event function (if not NULL) is called with the event type and
     -  * the begin/end offsets of the parsed elements.
     ++int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
     ++void git_config_set_multivar(const char *, const char *, const char *, unsigned);
     ++int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
     + 
     + /**
     +  * takes four parameters:
      @@ config.h: int git_config_set_multivar_in_file_gently(const char *, const char *, const cha
        * - the value regex, as a string. It will disregard key/value pairs where value
        *   does not match.
     @@ config.h: int git_config_set_multivar_in_file_gently(const char *, const char *,
      +				     const char *key,
      +				     const char *value,
      +				     const char *value_regex,
     -+				     int flags);
     ++				     unsigned flags);
       
       /**
        * rename or remove sections in the config file
 4:  28493184b6 ! 4:  0e6a7371ed config: add --literal-value option, un-implemented
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    config: add --literal-value option, un-implemented
     +    config: add --fixed-value option, un-implemented
      
          The 'git config' builtin takes a 'value_regex' parameter for several
          actions. This can cause confusion when expecting exact value matches
     @@ Commit message
          be more friendly to allow an argument to disable the pattern matching in
          favor of an exact string match.
      
     -    Add a new '--literal-value' option that does not currently change the
     +    Add a new '--fixed-value' option that does not currently change the
          behavior. The implementation will follow for each appropriate action.
     -    For now, check and test that --literal-value will abort the command when
     -    included with an incompatible action.
     +    For now, check and test that --fixed-value will abort the command when
     +    included with an incompatible action or without a 'value_regex'
     +    argument.
      
     -    The name '--literal-value' was chosen over something simpler like
     -    '--literal' because some commands allow regular expressions on the
     +    The name '--fixed-value' was chosen over something simpler like
     +    '--fixed' because some commands allow regular expressions on the
          key in addition to the value.
      
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ Documentation/git-config.txt: git-config - Get and set repository or global opti
       --------
       [verse]
      -'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
     -+'git config' [<file-option>] [--type=<type>] [--literal-value] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
     ++'git config' [<file-option>] [--type=<type>] [--fixed-value] [--show-origin] [--show-scope] [-z|--null] name [value [value_regex]]
       'git config' [<file-option>] [--type=<type>] --add name value
      -'git config' [<file-option>] [--type=<type>] --replace-all name value [value_regex]
      -'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get name [value_regex]
      -'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] --get-all name [value_regex]
      -'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--name-only] --get-regexp name_regex [value_regex]
     -+'git config' [<file-option>] [--type=<type>] [--literal-value] --replace-all name value [value_regex]
     -+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--literal-value] --get name [value_regex]
     -+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--literal-value] --get-all name [value_regex]
     -+'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--literal-value] [--name-only] --get-regexp name_regex [value_regex]
     ++'git config' [<file-option>] [--type=<type>] [--fixed-value] --replace-all name value [value_regex]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get name [value_regex]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] --get-all name [value_regex]
     ++'git config' [<file-option>] [--type=<type>] [--show-origin] [--show-scope] [-z|--null] [--fixed-value] [--name-only] --get-regexp name_regex [value_regex]
       'git config' [<file-option>] [--type=<type>] [-z|--null] --get-urlmatch name URL
      -'git config' [<file-option>] --unset name [value_regex]
      -'git config' [<file-option>] --unset-all name [value_regex]
     -+'git config' [<file-option>] [--literal-value] --unset name [value_regex]
     -+'git config' [<file-option>] [--literal-value] --unset-all name [value_regex]
     ++'git config' [<file-option>] [--fixed-value] --unset name [value_regex]
     ++'git config' [<file-option>] [--fixed-value] --unset-all name [value_regex]
       'git config' [<file-option>] --rename-section old_name new_name
       'git config' [<file-option>] --remove-section name
       'git config' [<file-option>] [--show-origin] [--show-scope] [-z|--null] [--name-only] -l | --list
     @@ Documentation/git-config.txt: See also <<FILES>>.
       --list::
       	List all variables set in config file, along with their values.
       
     -+--literal-value::
     ++--fixed-value::
      +	When used with the `value_regex` argument, treat `value_regex` as
      +	an exact string instead of a regular expression. This will restrict
      +	the name/value pairs that are matched to only those where the value
     @@ builtin/config.c: static int respect_includes_opt = -1;
       static struct config_options config_options;
       static int show_origin;
       static int show_scope;
     -+static int literal;
     ++static int fixed_value;
       
       #define ACTION_GET (1<<0)
       #define ACTION_GET_ALL (1<<1)
     -@@ builtin/config.c: static int show_scope;
     - #define ACTION_GET_COLORBOOL (1<<14)
     - #define ACTION_GET_URLMATCH (1<<15)
     - 
     -+#define ACTION_LITERAL_ALLOWED (\
     -+	ACTION_GET |\
     -+	ACTION_GET_ALL |\
     -+	ACTION_GET_REGEXP |\
     -+	ACTION_REPLACE_ALL |\
     -+	ACTION_UNSET |\
     -+	ACTION_UNSET_ALL |\
     -+	ACTION_SET_ALL\
     -+)
     -+
     - /*
     -  * The actions "ACTION_LIST | ACTION_GET_*" which may produce more than
     -  * one line of output and which should therefore be paged.
      @@ builtin/config.c: static struct option builtin_config_options[] = {
       	OPT_BIT(0, "rename-section", &actions, N_("rename section: old-name new-name"), ACTION_RENAME_SECTION),
       	OPT_BIT(0, "remove-section", &actions, N_("remove a section: name"), ACTION_REMOVE_SECTION),
       	OPT_BIT('l', "list", &actions, N_("list all"), ACTION_LIST),
     -+	OPT_BOOL(0, "literal-value", &literal, N_("use literal equality when matching values")),
     ++	OPT_BOOL(0, "fixed-value", &fixed_value, N_("use string equality when matching values")),
       	OPT_BIT('e', "edit", &actions, N_("open an editor"), ACTION_EDIT),
       	OPT_BIT(0, "get-color", &actions, N_("find the color configured: slot [default]"), ACTION_GET_COLOR),
       	OPT_BIT(0, "get-colorbool", &actions, N_("find the color setting: slot [stdout-is-tty]"), ACTION_GET_COLORBOOL),
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       		usage_builtin_config();
       	}
       
     -+	if (literal && !(actions & ACTION_LITERAL_ALLOWED)) {
     -+		error(_("--literal only applies with 'value_regex'"));
     -+		usage_builtin_config();
     ++	if (fixed_value) {
     ++		int allowed_usage = 0;
     ++
     ++		switch (actions) {
     ++		case ACTION_GET:
     ++		case ACTION_GET_ALL:
     ++		case ACTION_GET_REGEXP:
     ++		case ACTION_UNSET:
     ++		case ACTION_UNSET_ALL:
     ++			allowed_usage = argc > 1 && !!argv[1];
     ++			break;
     ++
     ++		case ACTION_SET_ALL:
     ++		case ACTION_REPLACE_ALL:
     ++			allowed_usage = argc > 2 && !!argv[2];
     ++			break;
     ++		}
     ++
     ++		if (!allowed_usage) {
     ++			error(_("--fixed-value only applies with 'value_regex'"));
     ++			usage_builtin_config();
     ++		}
      +	}
      +
       	if (actions & PAGING_ACTIONS)
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
      
       ## t/t1300-config.sh ##
      @@ t/t1300-config.sh: test_expect_success '--replace-all and value_regex' '
     - 	test_cmp expect .git/config
     + 	test_cmp expect actual
       '
       
     -+test_expect_success 'refuse --literal-value for incompatible actions' '
     -+	git config dev.null bogus &&
     -+	test_must_fail git config --literal-value --add dev.null bogus &&
     -+	test_must_fail git config --literal-value --get-urlmatch dev.null bogus &&
     -+	test_must_fail git config --literal-value --get-urlmatch dev.null bogus &&
     -+	test_must_fail git config --literal-value --rename-section dev null &&
     -+	test_must_fail git config --literal-value --remove-section dev &&
     -+	test_must_fail git config --literal-value --list &&
     -+	test_must_fail git config --literal-value --get-color dev.null &&
     -+	test_must_fail git config --literal-value --get-colorbool dev.null &&
     -+	test_must_fail git config --literal-value --edit
     ++test_expect_success 'refuse --fixed-value for incompatible actions' '
     ++	git config --file=config dev.null bogus &&
     ++
     ++	# These modes do not allow --fixed-value at all
     ++	test_must_fail git config --file=config --fixed-value --add dev.null bogus &&
     ++	test_must_fail git config --file=config --fixed-value --get-urlmatch dev.null bogus &&
     ++	test_must_fail git config --file=config --fixed-value --get-urlmatch dev.null bogus &&
     ++	test_must_fail git config --file=config --fixed-value --rename-section dev null &&
     ++	test_must_fail git config --file=config --fixed-value --remove-section dev &&
     ++	test_must_fail git config --file=config --fixed-value --list &&
     ++	test_must_fail git config --file=config --fixed-value --get-color dev.null &&
     ++	test_must_fail git config --file=config --fixed-value --get-colorbool dev.null &&
     ++
     ++	# These modes complain when --fixed-value has no value_regex
     ++	test_must_fail git config --file=config --fixed-value dev.null bogus &&
     ++	test_must_fail git config --file=config --fixed-value --replace-all dev.null bogus &&
     ++	test_must_fail git config --file=config --fixed-value --get dev.null &&
     ++	test_must_fail git config --file=config --fixed-value --get-all dev.null &&
     ++	test_must_fail git config --file=config --fixed-value --get-regexp "dev.*" &&
     ++	test_must_fail git config --file=config --fixed-value --unset dev.null &&
     ++	test_must_fail git config --file=config --fixed-value --unset-all dev.null
      +'
      +
       test_done
 5:  5881b2d987 ! 5:  39718048cd config: plumb --literal-value into config API
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    config: plumb --literal-value into config API
     +    config: plumb --fixed-value into config API
      
          The git_config_set_multivar_in_file_gently() and related methods now
     -    take a 'flags' bitfield, so add a new bit representing the
     -    --literal-value option from 'git config'. This alters the purpose of the
     -    value_regex parameter to be an exact string match. This requires some
     -    initialization changes in git_config_set_multivar_in_file_gently() and a
     -    new strcmp() call in the matches() method.
     +    take a 'flags' bitfield, so add a new bit representing the --fixed-value
     +    option from 'git config'. This alters the purpose of the value_regex
     +    parameter to be an exact string match. This requires some initialization
     +    changes in git_config_set_multivar_in_file_gently() and a new strcmp()
     +    call in the matches() method.
      
     -    The new CONFIG_FLAGS_LITERAL_VALUE flag is initialized in
     -    builtin/config.c based on the --literal-value option, and that needs to
     -    be updated in several callers.
     +    The new CONFIG_FLAGS_FIXED_VALUE flag is initialized in builtin/config.c
     +    based on the --fixed-value option, and that needs to be updated in
     +    several callers.
      
          This patch only affects some of the modes of 'git config', and the rest
          will be completed in the next change.
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       	given_config_source.file = xstrdup_or_null(getenv(CONFIG_ENVIRONMENT));
       
      @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
     - 		error(_("--literal only applies with 'value_regex'"));
     - 		usage_builtin_config();
     + 			error(_("--fixed-value only applies with 'value_regex'"));
     + 			usage_builtin_config();
     + 		}
     ++
     ++		flags = CONFIG_FLAGS_FIXED_VALUE;
       	}
     -+	if (literal)
     -+		flags = CONFIG_FLAGS_LITERAL_VALUE;
       
       	if (actions & PAGING_ACTIONS)
     - 		setup_auto_pager("config", 1);
      @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix)
       		value = normalize_value(argv[0], argv[1]);
       		UNLEAK(value);
     @@ config.c: int git_config_set_multivar_in_file_gently(const char *config_filename
       			store.value_regex = NULL;
       		else if (value_regex == CONFIG_REGEX_NONE)
       			store.value_regex = CONFIG_REGEX_NONE;
     -+		else if (flags & CONFIG_FLAGS_LITERAL_VALUE)
     ++		else if (flags & CONFIG_FLAGS_FIXED_VALUE)
      +			store.literal_value = value_regex;
       		else {
       			if (value_regex[0] == '!') {
       				store.do_not_match = 1;
      
       ## config.h ##
     -@@ config.h: enum config_event_t {
     +@@ config.h: int git_config_key_is_valid(const char *key);
        */
       #define CONFIG_FLAGS_MULTI_REPLACE (1 << 0)
       
      +/*
     -+ * When CONFIG_FLAGS_LITERAL_VALUE is specified, match key/value pairs
     ++ * When CONFIG_FLAGS_FIXED_VALUE is specified, match key/value pairs
      + * by string comparison (not regex match) to the provided value_regex
      + * parameter.
      + */
     -+#define CONFIG_FLAGS_LITERAL_VALUE (1 << 1)
     ++#define CONFIG_FLAGS_FIXED_VALUE (1 << 1)
      +
     - /*
     -  * The parser event function (if not NULL) is called with the event type and
     -  * the begin/end offsets of the parsed elements.
     + int git_config_set_multivar_gently(const char *, const char *, const char *, unsigned);
     + void git_config_set_multivar(const char *, const char *, const char *, unsigned);
     + int git_config_set_multivar_in_file_gently(const char *, const char *, const char *, const char *, unsigned);
      
       ## t/t1300-config.sh ##
     -@@ t/t1300-config.sh: test_expect_success 'refuse --literal-value for incompatible actions' '
     - 	test_must_fail git config --literal-value --edit
     +@@ t/t1300-config.sh: test_expect_success 'refuse --fixed-value for incompatible actions' '
     + 	test_must_fail git config --file=config --fixed-value --unset-all dev.null
       '
       
     -+test_expect_success '--literal-value uses exact string matching' '
     ++test_expect_success '--fixed-value uses exact string matching' '
      +	GLOB="a+b*c?d[e]f.g" &&
     -+	q_to_tab >initial <<-EOF &&
     -+	[literal]
     -+	Qtest = $GLOB
     -+	EOF
     ++	rm -f initial &&
     ++	git config --file=initial fixed.test "$GLOB" &&
      +
     -+	cp initial .git/config &&
     -+	git config literal.test bogus "$GLOB" &&
     -+	q_to_tab >expect <<-EOF &&
     -+	[literal]
     -+	Qtest = $GLOB
     -+	Qtest = bogus
     ++	cp initial config &&
     ++	git config --file=config fixed.test bogus "$GLOB" &&
     ++	git config --file=config --list >actual &&
     ++	cat >expect <<-EOF &&
     ++	fixed.test=$GLOB
     ++	fixed.test=bogus
      +	EOF
     -+	test_cmp expect .git/config &&
     -+	cp initial .git/config &&
     -+	git config --literal-value literal.test bogus "$GLOB" &&
     -+	q_to_tab >expect <<-EOF &&
     -+	[literal]
     -+	Qtest = bogus
     -+	EOF
     -+	test_cmp expect .git/config &&
     ++	test_cmp expect actual &&
     ++
     ++	cp initial config &&
     ++	git config --file=config --fixed-value fixed.test bogus "$GLOB" &&
     ++	git config --file=config --list >actual &&
     ++	printf "fixed.test=bogus\n" >expect &&
     ++	test_cmp expect actual &&
      +
     -+	cp initial .git/config &&
     -+	test_must_fail git config --unset literal.test "$GLOB" &&
     -+	git config --literal-value --unset literal.test "$GLOB" &&
     -+	test_must_fail git config literal.test &&
     ++	cp initial config &&
     ++	test_must_fail git config --file=config --unset fixed.test "$GLOB" &&
     ++	git config --file=config --fixed-value --unset fixed.test "$GLOB" &&
     ++	test_must_fail git config --file=config fixed.test &&
      +
     -+	cp initial .git/config &&
     -+	test_must_fail git config --unset-all literal.test "$GLOB" &&
     -+	git config --literal-value --unset-all literal.test "$GLOB" &&
     -+	test_must_fail git config literal.test &&
     ++	cp initial config &&
     ++	test_must_fail git config --file=config --unset-all fixed.test "$GLOB" &&
     ++	git config --file=config --fixed-value --unset-all fixed.test "$GLOB" &&
     ++	test_must_fail git config --file=config fixed.test &&
      +
     -+	cp initial .git/config &&
     -+	git config --replace-all literal.test bogus "$GLOB" &&
     -+	q_to_tab >expect <<-EOF &&
     -+	[literal]
     -+	Qtest = $GLOB
     -+	Qtest = bogus
     ++	cp initial config &&
     ++	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
     ++	git config --file=config --list >actual &&
     ++	cat >expect <<-EOF &&
     ++	fixed.test=$GLOB
     ++	fixed.test=bogus
      +	EOF
     -+	test_cmp expect .git/config &&
     ++	test_cmp expect actual &&
      +
     -+	cp initial .git/config &&
     -+	git config --replace-all literal.test bogus "$GLOB" &&
     -+	git config --literal-value --replace-all literal.test bogus "$GLOB" &&
     -+	test_cmp_config bogus literal.test
     ++	cp initial config &&
     ++	git config --file=config --replace-all fixed.test bogus "$GLOB" &&
     ++	git config --file=config --list >actual &&
     ++	cat >expect <<-EOF &&
     ++	fixed.test=$GLOB
     ++	fixed.test=bogus
     ++	EOF
     ++	test_cmp expect actual &&
     ++
     ++	git config --file=config --fixed-value --replace-all fixed.test bogus "$GLOB" &&
     ++	git config --file=config --list >actual &&
     ++	cat >expect <<-EOF &&
     ++	fixed.test=bogus
     ++	fixed.test=bogus
     ++	EOF
     ++	test_cmp expect actual
      +'
      +
       test_done
 6:  7c8e3769c7 ! 6:  8e0111c7b4 config: implement --literal-value with --get*
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    config: implement --literal-value with --get*
     +    config: implement --fixed-value with --get*
      
          The config builtin does its own regex matching of values for the --get,
          --get-all, and --get-regexp modes. Plumb the existing 'flags' parameter
     @@ builtin/config.c: static int collect_config(const char *key_, const char *value_
       		return 0;
       	if (use_key_regexp && regexec(key_regexp, key_, 0, NULL, 0))
       		return 0;
     -+	if (literal && strcmp(value_regex, (value_?value_:"")))
     ++	if (fixed_value && strcmp(value_regex, (value_?value_:"")))
      +		return 0;
       	if (regexp != NULL &&
       	    (do_not_match ^ !!regexec(regexp, (value_?value_:""), 0, NULL, 0)))
     @@ builtin/config.c: static int get_value(const char *key_, const char *regex_)
       	}
       
      -	if (regex_) {
     -+	if (regex_ && (flags & CONFIG_FLAGS_LITERAL_VALUE))
     ++	if (regex_ && (flags & CONFIG_FLAGS_FIXED_VALUE))
      +		value_regex = regex_;
      +	else if (regex_) {
       		if (regex_[0] == '!') {
     @@ builtin/config.c: int cmd_config(int argc, const char **argv, const char *prefix
       		check_argc(argc, 2, 2);
      
       ## t/t1300-config.sh ##
     -@@ t/t1300-config.sh: test_expect_success '--literal-value uses exact string matching' '
     - 	test_cmp_config bogus literal.test
     +@@ t/t1300-config.sh: test_expect_success '--fixed-value uses exact string matching' '
     + 	test_cmp expect actual
       '
       
     -+test_expect_success '--get and --get-all with --literal-value' '
     ++test_expect_success '--get and --get-all with --fixed-value' '
      +	GLOB="a+b*c?d[e]f.g" &&
     -+	q_to_tab >.git/config <<-EOF &&
     -+	[literal]
     -+	Qtest = bogus
     -+	Qtest = $GLOB
     -+	EOF
     ++	rm -f config &&
     ++	git config --file=config fixed.test bogus &&
     ++	git config --file=config --add fixed.test "$GLOB" &&
      +
     -+	git config --get literal.test bogus &&
     -+	test_must_fail git config --get literal.test "$GLOB" &&
     -+	git config --get --literal-value literal.test "$GLOB" &&
     -+	test_must_fail git config --get --literal-value literal.test non-existent &&
     ++	git config --file=config --get fixed.test bogus &&
     ++	test_must_fail git config --file=config --get fixed.test "$GLOB" &&
     ++	git config --file=config --get --fixed-value fixed.test "$GLOB" &&
     ++	test_must_fail git config --file=config --get --fixed-value fixed.test non-existent &&
      +
     -+	git config --get-all literal.test bogus &&
     -+	test_must_fail git config --get-all literal.test "$GLOB" &&
     -+	git config --get-all --literal-value literal.test "$GLOB" &&
     -+	test_must_fail git config --get-all --literal-value literal.test non-existent &&
     ++	git config --file=config --get-all fixed.test bogus &&
     ++	test_must_fail git config --file=config --get-all fixed.test "$GLOB" &&
     ++	git config --file=config --get-all --fixed-value fixed.test "$GLOB" &&
     ++	test_must_fail git config --file=config --get-all --fixed-value fixed.test non-existent &&
      +
     -+	git config --get-regexp literal+ bogus &&
     -+	test_must_fail git config  --get-regexp literal+ "$GLOB" &&
     -+	git config --get-regexp --literal-value literal+ "$GLOB" &&
     -+	test_must_fail git config --get-regexp --literal-value literal+ non-existent
     ++	git config --file=config --get-regexp fixed+ bogus &&
     ++	test_must_fail git config --file=config --get-regexp fixed+ "$GLOB" &&
     ++	git config --file=config --get-regexp --fixed-value fixed+ "$GLOB" &&
     ++	test_must_fail git config --file=config --get-regexp --fixed-value fixed+ non-existent
      +'
      +
       test_done
 7:  1d1c2fd23e ! 7:  5a3acf8119 maintenance: use 'git config --literal-value'
     @@ Metadata
      Author: Derrick Stolee <dstolee@microsoft.com>
      
       ## Commit message ##
     -    maintenance: use 'git config --literal-value'
     +    maintenance: use 'git config --fixed-value'
      
          When a repository's leading directories contain regex glob characters,
          the config calls for 'git maintenance register' and 'git maintenance
     -    unregister' are not careful enough. Use the new --literal-value option
     +    unregister' are not careful enough. Use the new --fixed-value option
          to direct the config machinery to use exact string matches. This is a
          more robust option than excaping these arguments in a piecemeal fashion.
      
     +    For the test, require that we are not running on Windows since the '+'
     +    character is not allowed on that filesystem.
     +
          Reported-by: Emily Shaffer <emilyshaffer@google.com>
          Reported-by: Jonathan Nieder <jrnieder@gmail.com>
          Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
     @@ builtin/gc.c: static int maintenance_register(void)
       	config_get.git_cmd = 1;
      -	strvec_pushl(&config_get.args, "config", "--global", "--get", "maintenance.repo",
      +	strvec_pushl(&config_get.args, "config", "--global", "--get",
     -+		     "--literal-value", "maintenance.repo",
     ++		     "--fixed-value", "maintenance.repo",
       		     the_repository->worktree ? the_repository->worktree
       					      : the_repository->gitdir,
       			 NULL);
     @@ builtin/gc.c: static int maintenance_unregister(void)
       	config_unset.git_cmd = 1;
       	strvec_pushl(&config_unset.args, "config", "--global", "--unset",
      -		     "maintenance.repo",
     -+		     "--literal-value", "maintenance.repo",
     ++		     "--fixed-value", "maintenance.repo",
       		     the_repository->worktree ? the_repository->worktree
       					      : the_repository->gitdir,
       		     NULL);
     @@ t/t7900-maintenance.sh: test_expect_success 'register and unregister' '
       	test_cmp before actual
       '
       
     -+test_expect_success 'register and unregister with glob characters' '
     ++test_expect_success !MINGW 'register and unregister with glob characters' '
      +	GLOB="a+b*c" &&
      +	git init "$GLOB" &&
      +	git -C "$GLOB" maintenance register &&
      +	git config --get-all --show-origin maintenance.repo &&
     -+	git config --get-all --global --literal-value \
     ++	git config --get-all --global --fixed-value \
      +		maintenance.repo "$(pwd)/$GLOB" &&
      +	git -C "$GLOB" maintenance unregister &&
     -+	test_must_fail git config --get-all --global --literal-value \
     ++	test_must_fail git config --get-all --global --fixed-value \
      +		maintenance.repo "$(pwd)/$GLOB"
      +'
      +

-- 
gitgitgadget
