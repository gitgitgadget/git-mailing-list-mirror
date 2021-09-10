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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9441DC433EF
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7255F61100
	for <git@archiver.kernel.org>; Fri, 10 Sep 2021 11:30:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232784AbhIJLb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Sep 2021 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232537AbhIJLb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Sep 2021 07:31:27 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35FB0C061574
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:16 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id g16so2156556wrb.3
        for <git@vger.kernel.org>; Fri, 10 Sep 2021 04:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CScxchun0IGE4F54QA74ikvO0lE/HgcYiZkwErIEqcY=;
        b=MlqmT3OhYWnNJiZ5NXJRXfzYR7eSpJDJMLUvNXHE7FIL2MCsSFX+U1Y7N2Hd3A/5NZ
         WFGHzsOx3ZuDaF5BfnT4u+wb308/iDAaXxuBU091BXbFeO3xIm38RaAlxfcRoCaXyxuM
         uZu6PLE0ZZd3nvmZhMQ0PpD0JT+QGsqp3N+YHQ5vQ2WtnnPVtKuawT5H7dcKh2w0YwQO
         Ga8x8yB1tTzNR85SaXjd+Q41jCN/58kWNXSvE4vcmVgodkNCR3nfQcud0DOMaAHkKos4
         WXvNqQscMOXh0a1H70jkRtroGhFPcNcMtlEQ8hWpMPbFACjqWC+UwfyfYNLvICbPmlLt
         3WiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CScxchun0IGE4F54QA74ikvO0lE/HgcYiZkwErIEqcY=;
        b=kAIH5AmdHFsGTYEPti+I5SD9TpKDLM1JRxPw1OyRaU3Rcz7fDpGiYn5nKQdsV+95x6
         TJlJlDqdDnvr/PfbvpWsFj0nu413XLEYMDSufJFy3JG2j0UYbViG0H8sQhGOtigGgItQ
         0ysq/u+vDubRWXOG/oHtfxOSYOSo5335ryTHdF3ZhWklvOZ03ZdwYV2tnrcS7eGBUwYd
         j1LEGLPBc4KYMT1OiDPyjLQ1FaQeOpTRcW8RdNzrAV3++sZiSizDlkjC55Es9vx1YRrd
         R7FAb0/A4+8U3uPXv2lfAcwy3NaM36wOqSwO7/u+YqEyFc54cy43DOgRQRKuRAilO8re
         U3xA==
X-Gm-Message-State: AOAM5329Yel6kR+K9WswgF16YYWxCh5hgeSzfDtbs3vLhAQwlcFUn6Z3
        MZTvP71SKT4B1BvF/vyZbZikYlH5aQZDlQ==
X-Google-Smtp-Source: ABdhPJxNrJaRowNn27DY0zTV1abbxpvlfndpFQe6LXxcXas7pEfYMJAj1x+Xk+QyREttVq3wxMBPNw==
X-Received: by 2002:adf:f1c4:: with SMTP id z4mr2838845wro.418.1631273414526;
        Fri, 10 Sep 2021 04:30:14 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6sm4103278wmp.1.2021.09.10.04.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Sep 2021 04:30:14 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/5] help: fix usage nits & bugs, completion shellscript->C
Date:   Fri, 10 Sep 2021 13:28:41 +0200
Message-Id: <cover-v2-0.5-00000000000-20210910T112545Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.873.g125ff7b9940
In-Reply-To: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com>
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

For v1, see : https://lore.kernel.org/git/cover-0.6-00000000000-20210908T151949Z-avarab@gmail.com/

This should address all the feedback on v1 and more. I dropped the 4/6
refactoring change, we now also specifically say what option
combinations are bad before emitting usage info, as requested by Eric
Sunshine.

Ævar Arnfjörð Bjarmason (5):
  help: correct the usage string in -h and documentation
  help: correct usage & behavior of "git help --guides"
  help tests: add test for --config output
  help: correct logic error in combining --all and --config
  help / completion: make "git help" do the hard work

 Documentation/git-help.txt             |   9 +-
 builtin/help.c                         | 110 ++++++++++++++++++-------
 contrib/completion/git-completion.bash |  21 +++--
 t/t0012-help.sh                        |  46 +++++++++++
 4 files changed, 140 insertions(+), 46 deletions(-)

Range-diff against v1:
1:  b5c79d87847 = 1:  b10bfd21f14 help: correct the usage string in -h and documentation
2:  1ebd443e43c ! 2:  039639a0dd3 help: correct usage string for "git help --guides"
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    help: correct usage string for "git help --guides"
    +    help: correct usage & behavior of "git help --guides"
     
         As noted in 65f98358c0c (builtin/help.c: add --guide option,
         2013-04-02) and a133737b809 (doc: include --guide option description
    @@ Commit message
         argument we'll now error out.
     
         The comment being removed was added in 15f7d494380 (builtin/help.c:
    -    split "-a" processing into two, 2013-04-02) and is no longer
    -    applicable as explained above.
    +    split "-a" processing into two, 2013-04-02). The "Ignore any remaining
    +    args" part of it is now no longer applicable as explained above, let's
    +    just remove it entirely, it's rather obvious that if we're returning
    +    we're done.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ builtin/help.c: static struct option builtin_help_options[] = {
      };
      
     @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
    - 	int nongit;
    - 	enum help_format parsed_help_format;
    - 	const char *page;
    -+	int standalone = 0;
    - 
    - 	argc = parse_options(argc, argv, prefix, builtin_help_options,
      			builtin_help_usage, 0);
      	parsed_help_format = help_format;
      
     +	/* Options that take no further arguments */
    -+	standalone = show_config || show_guides;
    -+	if (standalone && argc)
    -+		usage_with_options(builtin_help_usage, builtin_help_options);
    ++	if (argc && show_guides)
    ++		usage_msg_opt(_("--guides cannot be combined with other options"),
    ++			      builtin_help_usage, builtin_help_options);
     +
      	if (show_all) {
      		git_config(git_help_config, NULL);
      		if (verbose) {
     @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
    - 	if (show_guides)
    - 		list_guides_help();
      
    --	if (show_all || show_guides) {
    -+	if (show_all || standalone) {
    + 	if (show_all || show_guides) {
      		printf("%s\n", _(git_more_info_string));
     -		/*
     -		* We're done. Ignore any remaining args
    @@ t/t0012-help.sh: test_expect_success 'basic help commands' '
      '
      
     +test_expect_success 'invalid usage' '
    -+	test_expect_code 129 git help -c git-add &&
     +	test_expect_code 129 git help -g git-add
     +'
     +
3:  d0a8045c9ed = 3:  258282095de help tests: add test for --config output
4:  e4bc7e57a6d < -:  ----------- help: refactor "for_human" control flow in cmd_help()
5:  bcc640d32a1 ! 4:  32d73d5273c help: correct logic error in combining --all and --config
    @@ builtin/help.c: static const char * const builtin_help_usage[] = {
      };
      
     @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
    + 	int nongit;
      	enum help_format parsed_help_format;
      	const char *page;
    - 	int standalone = 0;
     +	int need_config = 0;
      
      	argc = parse_options(argc, argv, prefix, builtin_help_options,
    @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
      	parsed_help_format = help_format;
      
     +	/* Incompatible options */
    -+	if (show_all + !!show_config + show_guides > 1)
    -+		usage_with_options(builtin_help_usage, builtin_help_options);
    ++	if (show_all && show_config)
    ++		usage_msg_opt(_("--config and --all cannot be combined"),
    ++			      builtin_help_usage, builtin_help_options);
    ++
    ++	if (show_config && show_guides)
    ++		usage_msg_opt(_("--config and --guides cannot be combined"),
    ++			      builtin_help_usage, builtin_help_options);
     +
      	/* Options that take no further arguments */
    - 	standalone = show_config || show_guides;
    - 	if (standalone && argc)
    - 		usage_with_options(builtin_help_usage, builtin_help_options);
    ++	if (argc && show_config)
    ++		usage_msg_opt(_("--config cannot be combined with command or guide names"),
    ++			      builtin_help_usage, builtin_help_options);
    + 	if (argc && show_guides)
    +-		usage_msg_opt(_("--guides cannot be combined with other options"),
    ++		usage_msg_opt(_("--guides cannot be combined with command or guide names"),
    + 			      builtin_help_usage, builtin_help_options);
      
     -	if (show_all) {
     +	need_config = show_all || show_config;
    @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
     -	if (show_guides)
     -		list_guides_help();
     -
    --	if (show_all || standalone) {
    +-	if (show_all || show_guides) {
     -		printf("%s\n", _(git_more_info_string));
     -		return 0;
     -	}
    @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
     
      ## t/t0012-help.sh ##
     @@ t/t0012-help.sh: test_expect_success 'basic help commands' '
    + '
      
      test_expect_success 'invalid usage' '
    - 	test_expect_code 129 git help -c git-add &&
     -	test_expect_code 129 git help -g git-add
     +	test_expect_code 129 git help -g git-add &&
    ++	test_expect_code 129 git help -c git-add &&
    ++	test_expect_code 129 git help -g git-add &&
     +
     +	test_expect_code 129 git help -a -c &&
     +	test_expect_code 129 git help -g -c
6:  940061e84d1 ! 5:  e995a42cb8d help / completion: make "git help" do the hard work
    @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
      
     -	if (show_config) {
     -		int for_human = show_config == 1;
    --
    --		if (for_human)
    --			setup_pager();
    --		list_config_help(for_human);
    --		if (for_human)
     +	switch (show_config) {
     +	case SHOW_CONFIG_UNSET:
     +		break;
    -+	case SHOW_CONFIG_HUMAN:
    -+		setup_pager();
    -+		/* fallthrough */
     +	case SHOW_CONFIG_VARS:
     +	case SHOW_CONFIG_SECTIONS:
     +		list_config_help(show_config);
    -+		if (show_config == SHOW_CONFIG_HUMAN)
    - 			printf("\n%s\n", _("'git help config' for more information"));
      
    +-		if (!for_human) {
    +-			list_config_help(for_human);
    +-			return 0;
    +-		}
    ++		return 0;
    ++	case SHOW_CONFIG_HUMAN:
    + 		setup_pager();
    +-		list_config_help(for_human);
    ++		list_config_help(show_config);
    + 		printf("\n%s\n", _("'git help config' for more information"));
    ++
      		return 0;
    + 	}
    + 
     
      ## contrib/completion/git-completion.bash ##
     @@ contrib/completion/git-completion.bash: __git_config_vars=
-- 
2.33.0.873.g125ff7b9940

