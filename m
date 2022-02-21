Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93111C433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 19:39:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiBUTjZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 14:39:25 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbiBUTjX (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 14:39:23 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F06BA22531
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:38:58 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id gb39so35906328ejc.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 11:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tXGL2Eur04KdsYe1QsFckC0J8ZjJOj8mgtoiKk+PY0s=;
        b=dPWfmH/QN8btTMfPrhK6EjRNczG87IQHAvWF9KVAjMCx9DT3WamnWRU1eoTh01KLXD
         0ZMJL2cfuLgTjZ60adf5FAXGJoStY1suk1fgBnARt0hI6BkVoCJF0R7JZj20QJG8WPr6
         NBjm4sv62PgGkxEdu1V/F96uvOiAzPFzjqPlCIHbNaIZoGQzNAPpDX4gNTF3/EfsMWhr
         agD72v2Wuy0xrQudpqG3JdBuealsdWSZlotdOKQxy0Hjilr3SDfPf40hkCD58apmCt0h
         vaeSByJHI25ARxcc6DN2i4qEdWfSF+vsKwSYivubrZ+OcOK+nEkPbnL4Of5PfwajcuBg
         K8KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tXGL2Eur04KdsYe1QsFckC0J8ZjJOj8mgtoiKk+PY0s=;
        b=k1D5onN3vzFVJCwKtDyQQZyYItE6VAqf5KwqkgcZnz6O9Xkk/9yh/jtVwVufNa0vG/
         iwPr/OphYsQgXFrE52CeYIIrde40f0qqnpnQ88JNovBOMVyDMlXOtuZjj0BsVyhUXOkc
         1S7tMUtd44tyKQDcOdU/i4ferc1aiKSSw2zlsK/zRUkvackAwaZ3xLifzyRvKVZF5dR6
         crrQecqTjq0JCNs5bw8oL0KD4ip+WsoWbQiUTAmLTfzrmUO/utgHcU25tf//tY7aFbEg
         9bY20ZzNEbn3ek+HP+cMbp8+yk/uxN9wzjbql7kYX/cOvxkLWPRlI8bLWT0rrRuujZMW
         /5qQ==
X-Gm-Message-State: AOAM530XXUc2iQ+Damw7FeklcOSDs0TjKJY/rW9+Xgf8CXOTyu+eTeTx
        7Aiu/Z0vpDz3V6VPi67vZH8fNqlqDYjYWQ==
X-Google-Smtp-Source: ABdhPJw75Jp/FMVR/9AD1W+GMFbpGRJ57wGBZ6TfnCCmwwX17cvAvboIU9QD1lKVGSZs+hGPX+BTWg==
X-Received: by 2002:a17:907:3f25:b0:6b0:5e9a:83 with SMTP id hq37-20020a1709073f2500b006b05e9a0083mr17501339ejc.659.1645472337278;
        Mon, 21 Feb 2022 11:38:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c25sm8718199edu.103.2022.02.21.11.38.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 11:38:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>, Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 0/9] help: tests, parse_options() sanity, fix "help -g" regression
Date:   Mon, 21 Feb 2022 20:38:43 +0100
Message-Id: <cover-v2-0.9-00000000000-20220221T193708Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1132.ga1fe46f8690
In-Reply-To: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A late re-roll of [1] which addresses all the comments Eric Sunshine
raised, thanks for the review, and sorry the v2 took so long!

As the range-diff shows the main change is a mid-series set of changes
to sanity check more "git help <opts>" incompaitibilities. The
SYNOPSIS issues etc. Eric noted have also been fixed.

1. https://lore.kernel.org/git/cover-0.7-00000000000-20211228T153456Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (9):
  help doc: add missing "]" to "[-a|--all]"
  help.c: use puts() instead of printf{,_ln}() for consistency
  help tests: test "git" and "git help [-a|-g] spacing
  help.c: split up list_all_cmds_help() function
  help: note the option name on option incompatibility
  help: correct usage & behavior of "git help --all"
  help: error if [-a|-g|-c] and [-i|-m|-w] are combined
  help: add --no-[external-commands|aliases] for use with --all
  help: don't print "\n" before single-section output

 Documentation/git-help.txt | 15 ++++--
 builtin/help.c             | 63 +++++++++++++++++++++----
 help.c                     | 37 +++++++++++----
 help.h                     |  2 +-
 t/t0012-help.sh            | 94 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 187 insertions(+), 24 deletions(-)

Range-diff against v1:
 1:  652dae26bf4 =  1:  c4b66c36c17 help doc: add missing "]" to "[-a|--all]"
 2:  f84662469a3 =  2:  124643c4b35 help.c: use puts() instead of printf{,_ln}() for consistency
 3:  3956937cf3b !  3:  3e39116f197 help tests: test "git" and "git help [-a|-g] spacing
    @@ t/t0012-help.sh: test_expect_success 'git help --config-sections-for-completion'
     +'
     +
      test_expect_success 'generate builtin list' '
    + 	mkdir -p sub &&
      	git --list-cmds=builtins >builtins
    - '
 4:  f040dd549b4 =  4:  f9c4d5e2d28 help.c: split up list_all_cmds_help() function
 5:  12ff152bd57 <  -:  ----------- help: error if [-a|-g|-c] and [-i|-m|-w] are combined
 -:  ----------- >  5:  e5c49089106 help: note the option name on option incompatibility
 -:  ----------- >  6:  868e8a6cf83 help: correct usage & behavior of "git help --all"
 -:  ----------- >  7:  992ee6580ac help: error if [-a|-g|-c] and [-i|-m|-w] are combined
 6:  a5ef9f69530 !  8:  c81c0cbbcdb help: add --no-[external-commands|aliases] for use with --all
    @@ Documentation/git-help.txt: git-help - Display help information about Git
      --------
      [verse]
     -'git help' [-a|--all] [--[no-]verbose]
    -+'git help' [-a|--all] [--[no-]verbose] [--[no-](external-commands|aliases)]
    ++'git help' [-a|--all] [--[no-]verbose] [--[no-]external-commands] [--[no-]aliases]
      'git help' [[-i|--info] [-m|--man] [-w|--web]] [<command>|<guide>]
      'git help' [-g|--guides]
      'git help' [-c|--config]
     @@ Documentation/git-help.txt: OPTIONS
    - 	Prints all the available commands on the standard output. This
    - 	option overrides any given command or guide name.
    + --all::
    + 	Prints all the available commands on the standard output.
      
     +--no-external-commands::
     +	When used with `--all`, exclude the listing of external "git-*"
    @@ builtin/help.c: static const char *html_path;
      	OPT_CMDMODE('a', "all", &cmd_mode, N_("print all available commands"),
      		    HELP_ACTION_ALL),
     +	OPT_BOOL(0, "external-commands", &show_external_commands,
    -+		 N_("show external commands in --all?")),
    -+	OPT_BOOL(0, "aliases", &show_aliases, N_("show aliases in --all?")),
    ++		 N_("show external commands in --all")),
    ++	OPT_BOOL(0, "aliases", &show_aliases, N_("show aliases in --all")),
      	OPT_HIDDEN_BOOL(0, "exclude-guides", &exclude_guides, N_("exclude guides")),
      	OPT_SET_INT('m', "man", &help_format, N_("show man page"), HELP_FORMAT_MAN),
      	OPT_SET_INT('w', "web", &help_format, N_("show manual in web browser"),
    @@ builtin/help.c: static struct option builtin_help_options[] = {
      
      static const char * const builtin_help_usage[] = {
     -	N_("git help [-a|--all] [--[no-]verbose]]"),
    -+	N_("git help [-a|--all] [--[no-]verbose]] [--[no-](external-commands|aliases)]"),
    ++	N_("git help [-a|--all] [--[no-]verbose]] [--[no-]external-commands] [--[no-]aliases]"),
      	N_("git help [[-i|--info] [-m|--man] [-w|--web]] [<command>]"),
      	N_("git help [-g|--guides]"),
      	N_("git help [-c|--config]"),
    @@ builtin/help.c: int cmd_help(int argc, const char **argv, const char *prefix)
     +
      	switch (cmd_mode) {
      	case HELP_ACTION_ALL:
    - 		no_format();
    + 		opt_mode_usage(argc, "--all", help_format);
      		if (verbose) {
      			setup_pager();
     -			list_all_cmds_help();
 7:  08fd12fe7b4 =  9:  08dc693dc3e help: don't print "\n" before single-section output
-- 
2.35.1.1132.ga1fe46f8690

