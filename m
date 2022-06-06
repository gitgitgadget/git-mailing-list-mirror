Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46083C43334
	for <git@archiver.kernel.org>; Mon,  6 Jun 2022 17:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229998AbiFFRpn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Jun 2022 13:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229961AbiFFRpm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Jun 2022 13:45:42 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0C62BABA1
        for <git@vger.kernel.org>; Mon,  6 Jun 2022 10:45:40 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id x5so14729870edi.2
        for <git@vger.kernel.org>; Mon, 06 Jun 2022 10:45:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=kn9gSoC4zkHv5Q4VwMI3zKNp1nmYcuGzgNtogaSeezQ=;
        b=agf//RG4LBMNO1xV5s24RpIMYCSlO2I3UAPh4TPkZF/hJRruLf8NdoQWZ+KzMF6z+K
         vP37k9PkTWq0ztUPPaSSxWLCUFNAQrfeZsct8rHnzttWLlvTGq7gRPuo1LwboKXyldPH
         LdWJVzoqILThT78kq7TL/TOTzumjX35zrEA+ExwfcxhedPY654WOtR4wGAfOxzanFd82
         bDuOYvGDOuIGvZK+f/w+xxwQZKvSqLn9/RTpcZatZHfNhLLtzzkkgoqA+nb3lFg2Vin3
         ubt68fElAi87R1ETKE2yZD+/JUQJMUUU1kl43M4i+aTRX6ZFWA4DuOF1sf3ZpHnXrTyt
         NBbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=kn9gSoC4zkHv5Q4VwMI3zKNp1nmYcuGzgNtogaSeezQ=;
        b=7m4IsyyzSI9w7rI5Mr/4zUWTyigscfCyWFpKieP/1ZPHoWuQc92Y/1rzFjqQutGjIH
         +DVajLLNUDnzTVTjlb+JnyuENmSbBrYge4weKt5jIOABS9TBTYsB3Iz5n1eE/HYI2Br2
         Xgow9aUV+JRM+ek/aaRGppxZBsGukL6QZlhIeNLADe9Jkdxqsk/ouomfBskHe1D0CzzZ
         mX3AOEfAWANCuo0LjYODFo+oZliWDMyvEQ1ew4OjssVweRcGwtzMPsOsrNfP8l+wkpOg
         V8bR+LNZDLzMGunWqOcQMS0j+czcavDC7Xg5xwX4UOGVKO0TSJX8bF6Mt2hHgLkFz8q6
         g5Tw==
X-Gm-Message-State: AOAM532KMIpSz/A3BdqoljhJjl9Fnc1hB4j4rZPuE8apVbuu2cTSa5EF
        3xedjW1cVoTeLINvT3Lhnsb1HvjBG7Y=
X-Google-Smtp-Source: ABdhPJwRPpWYAo1q+gZ1oISOny9dF7qEH9KFTtbno59iCpYx0CSaQ6DITbXpWi4CH97CNNf7d9rneg==
X-Received: by 2002:aa7:c846:0:b0:431:6c7b:26af with SMTP id g6-20020aa7c846000000b004316c7b26afmr4684297edt.123.1654537534161;
        Mon, 06 Jun 2022 10:45:34 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id i7-20020a170906444700b0070e238ff66fsm4517622ejp.96.2022.06.06.10.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 10:45:29 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nyGn7-002IX0-9F;
        Mon, 06 Jun 2022 19:45:25 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Brandon Williams <bmwill@google.com>,
        Stefan Beller <sbeller@google.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: [PATCH] ls-files.c: add --only-object-name option
Date:   Mon, 06 Jun 2022 19:42:33 +0200
References: <pull.1250.git.1654509678718.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.7.12
In-reply-to: <pull.1250.git.1654509678718.gitgitgadget@gmail.com>
Message-ID: <220606.86zgipvg7e.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Jun 06 2022, ZheNing Hu via GitGitGadget wrote:

> From: ZheNing Hu <adlternative@gmail.com>
>
> `git ls-files --stage` default output format is:
>
> [<tag> ]<mode> <object> <stage> <file>
>
> sometime we want to find a path's corresponding objectname,
> we will parse the output and extract objectname from it
> again and again.
>
> So introduce a new option `--only-object-name` which can only
> output objectname when giving `--stage` or `--resolve-undo`.
>
> Signed-off-by: ZheNing Hu <adlternative@gmail.com>
> ---
>     ls-files.c: add --only-object-name option
>     
>     Something we want to extract objectname from git ls-files --stage, but
>     git ls-file don't support something like --format=%(objectname) (which
>     git ls-tree have implemented)
>     
>     So now add a new option --only-object-name which can only output
>     objectname.
>     
>     (Maybe we should add something like git ls-files --format ?)

Yes I think that would be very useful, especially if we could see if
some of the code could be shared (maybe not).

But in any case shouldn't this be called --name-only to go with "git
ls-tree"'s version of this? Or is there some subtle difference I'm
missing...?

> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1250%2Fadlternative%2Fzh%2Fls-file-only-objectname-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1250/adlternative/zh/ls-file-only-objectname-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1250
>
>  Documentation/git-ls-files.txt |  6 +++++-
>  builtin/ls-files.c             | 18 +++++++++++++++++-
>  t/t2030-unresolve-info.sh      | 33 +++++++++++++++++++++++++++++++++
>  t/t3004-ls-files-basic.sh      | 32 ++++++++++++++++++++++++++++++++
>  4 files changed, 87 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-ls-files.txt b/Documentation/git-ls-files.txt
> index 0dabf3f0ddc..0e3f4f094f3 100644
> --- a/Documentation/git-ls-files.txt
> +++ b/Documentation/git-ls-files.txt
> @@ -13,7 +13,7 @@ SYNOPSIS
>  		[-c|--cached] [-d|--deleted] [-o|--others] [-i|--|ignored]
>  		[-s|--stage] [-u|--unmerged] [-k|--|killed] [-m|--modified]
>  		[--directory [--no-empty-directory]] [--eol]
> -		[--deduplicate]
> +		[--deduplicate] [--only-object-name]
>  		[-x <pattern>|--exclude=<pattern>]
>  		[-X <file>|--exclude-from=<file>]
>  		[--exclude-per-directory=<file>]
> @@ -88,6 +88,10 @@ OPTIONS
>  	When any of the `-t`, `--unmerged`, or `--stage` option is
>  	in use, this option has no effect.
>  
> +--only-object-name:
> +	When giving `--stage` or `--resolve-undo` , only output `<object>`
> +	instead of `[<tag> ]<mode> <object> <stage> <file>` format.
> +
>  -x <pattern>::
>  --exclude=<pattern>::
>  	Skip untracked files matching pattern.
> diff --git a/builtin/ls-files.c b/builtin/ls-files.c
> index e791b65e7e9..fd9c10e9f94 100644
> --- a/builtin/ls-files.c
> +++ b/builtin/ls-files.c
> @@ -26,6 +26,7 @@ static int show_deleted;
>  static int show_cached;
>  static int show_others;
>  static int show_stage;
> +static int only_object_name;
>  static int show_unmerged;
>  static int show_resolve_undo;
>  static int show_modified;
> @@ -241,10 +242,15 @@ static void show_ce(struct repository *repo, struct dir_struct *dir,
>  		if (!show_stage) {
>  			fputs(tag, stdout);
>  		} else {
> +			const char *object_name = repo_find_unique_abbrev(repo, &ce->oid, abbrev);
> +			if (only_object_name) {
> +				printf("%s%c", object_name, line_terminator);
> +				return;
> +			}
>  			printf("%s%06o %s %d\t",
>  			       tag,
>  			       ce->ce_mode,
> -			       repo_find_unique_abbrev(repo, &ce->oid, abbrev),
> +			       object_name,
>  			       ce_stage(ce));
>  		}
>  		write_eolinfo(repo->index, ce, fullname);
> @@ -274,6 +280,10 @@ static void show_ru_info(struct index_state *istate)
>  		for (i = 0; i < 3; i++) {
>  			if (!ui->mode[i])
>  				continue;
> +			if (only_object_name) {
> +				printf("%s%c", find_unique_abbrev(&ui->oid[i], abbrev), line_terminator);
> +				continue;
> +			}
>  			printf("%s%06o %s %d\t", tag_resolve_undo, ui->mode[i],
>  			       find_unique_abbrev(&ui->oid[i], abbrev),
>  			       i + 1);
> @@ -635,6 +645,8 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  			DIR_SHOW_IGNORED),
>  		OPT_BOOL('s', "stage", &show_stage,
>  			N_("show staged contents' object name in the output")),
> +		OPT_BOOL(0, "only-object-name", &only_object_name,
> +			N_("only show staged contents' object name in the output")),
>  		OPT_BOOL('k', "killed", &show_killed,
>  			N_("show files on the filesystem that need to be removed")),
>  		OPT_BIT(0, "directory", &dir.flags,
> @@ -734,6 +746,10 @@ int cmd_ls_files(int argc, const char **argv, const char *cmd_prefix)
>  		die("ls-files --recurse-submodules does not support "
>  		    "--error-unmatch");
>  
> +	if (only_object_name && !show_stage && !show_resolve_undo)
> +		die("ls-files --only-object-name only used with --stage "
> +		    "or --resolve-undo");

missing _().

> +
>  	parse_pathspec(&pathspec, 0,
>  		       PATHSPEC_PREFER_CWD,
>  		       prefix, argv);
> diff --git a/t/t2030-unresolve-info.sh b/t/t2030-unresolve-info.sh
> index f691e6d9032..d940226c5f9 100755
> --- a/t/t2030-unresolve-info.sh
> +++ b/t/t2030-unresolve-info.sh
> @@ -32,6 +32,31 @@ check_resolve_undo () {
>  	test_cmp "$msg.expect" "$msg.actual"
>  }
>  
> +check_resolve_undo_only_object_name() {
> +	msg=$1
> +	shift
> +	while case $# in
> +	0)	break ;;
> +	1|2|3)	die "Bug in check-resolve-undo test" ;;

Use the "BUG"  helper in thaht case.
> +	esac
> +	do
> +		path=$1
> +		shift
> +		for stage in 1 2 3
> +		do
> +			sha1=$1
> +			shift
> +			case "$sha1" in
> +			'') continue ;;
> +			esac
> +			sha1=$(git rev-parse --verify "$sha1")

missing && here when invoking "git".

> +test_expect_success 'git ls-files --stage with --only-object-name' '
> +	git init test &&
> +	test_when_finished "rm -rf test" &&

FWIW you can do all the below with -C to relevant commands and skip the
sub-shell.

> +	(
> +		cd test &&
> +		echo a >a.txt &&
> +		echo b >b.txt &&
> +		git add a.txt b.txt &&
> +		oid1=$(git hash-object a.txt) &&
> +		oid2=$(git hash-object b.txt) &&
> +		git ls-files --stage --only-object-name >actual &&
> +		cat >expect <<-EOF &&
> +		$oid1
> +		$oid2
> +		EOF
> +		test_cmp expect actual
> +	)
> +'
> +
> +test_expect_success 'git ls-files --only-object-name without --stage or --resolve-undo' '
> +	git init test &&
> +	test_when_finished "rm -rf test" &&
> +	(
> +		cd test &&
> +		echo a >a.txt &&
> +		echo b >b.txt &&
> +		git add a.txt b.txt &&
> +		test_must_fail git ls-files --only-object-name 2>stderr &&
> +		test_i18ngrep "fatal: ls-files --only-object-name only used with --stage or --resolve-undo" stderr

use "grep", not "test_i18ngrep".
