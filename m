Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592A5C07E98
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 06:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4127E613E1
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 06:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhGEGVc (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 02:21:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbhGEGV3 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 02:21:29 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0592C061574
        for <git@vger.kernel.org>; Sun,  4 Jul 2021 23:18:52 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id j11so22272099edq.6
        for <git@vger.kernel.org>; Sun, 04 Jul 2021 23:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=8Gcd5kvcQicQjRjSBndg2WdDYkcqifpHBxyFQT/D8ew=;
        b=P3yFT/oXxsO8rcRdag2uwan1MSrw/bbywRRO6wkwfSp35wFk0rSHjF9Fe5aNDIxXFG
         FFdu0bNyaZ/B0+ErRRXbXxzj9vVrYqSs+an1zkGFGQNGrgDKQJOkf8DTTlntt7riprmH
         MJwzEB4J/voQ6G8ieIYV3wbDAubTgg/mpcaedWl4OK9X2dPRMfHzkoWHWkB/ipeqm566
         R5FKUpC+/A7wp9DumpAGl0FkLT386oQNCWjvBpzVjWFzVYbuU7+bM6ukJZOddnzIEIbL
         k3iFUDgGs5egrK5oUf/kwLo4oFdvCC1z8Jzt0M8YSKeFcMoYERZv/OV81JgQdVu+RiKv
         cdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=8Gcd5kvcQicQjRjSBndg2WdDYkcqifpHBxyFQT/D8ew=;
        b=Z0TrZ2X9cEbZ5Ty+W7K2+hUrCJJgitll7f5jveyeEcM90LtEl1R2IGF8OeTCwgp4SC
         e07iwOFA5+Cx9JaUfG14skXiWeDWIGT8MQ6aTwB3ylr/ANeC7KL6i1gTBh1P9P8cfGzq
         u0mFOtou2LNzjFGF30saxVMONcslwWhhIeYw2hk00q5pTcournPKOpis2HUhG1PSRpof
         UarUoOklOfZZvQ89Mdp4ZFQF7S2qVRPS0XvFTFuX/WoScyMSFk9PZyLM1icTt4vrPjfC
         U2jmlzGdjh2MtfEAh8q46JhVcZhBRbLZ6hKhSnzommm18UgodTTJUFTwQOZNmsmV1uuf
         7DJA==
X-Gm-Message-State: AOAM532jplYu5wKer6pKNY9p/5sFmejbPXgPsoD91/a3vkCWqCLkJnDc
        3UBHJoMPW/7IqgVzwnGZIQyajU4QwV4=
X-Google-Smtp-Source: ABdhPJy2EFssB4la4mM9OqoHqlUdcJusbzGlq1Tmhppnh8K7SFMAxutRWemk73oBMULAdNMU2141uA==
X-Received: by 2002:a05:6402:6:: with SMTP id d6mr2275941edu.236.1625465931238;
        Sun, 04 Jul 2021 23:18:51 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id l4sm1008976edr.72.2021.07.04.23.18.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jul 2021 23:18:50 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Andrei Rybak <rybak.a.v@gmail.com>
Cc:     git@vger.kernel.org, Christian Couder <christian.couder@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH resend] help: convert git_cmd to page in one place
Date:   Mon, 05 Jul 2021 08:15:25 +0200
References: <20210626163219.4137317-1-rybak.a.v@gmail.com>
 <20210704153912.2742106-1-rybak.a.v@gmail.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210704153912.2742106-1-rybak.a.v@gmail.com>
Message-ID: <87tul9706u.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sun, Jul 04 2021, Andrei Rybak wrote:

> Depending on the chosen format of help pages, git-help uses function
> show_man_page, show_info_page, or show_html_page.  The first thing all
> three functions do is to convert given `git_cmd` to a `page` using
> function cmd_to_page.
>
> Move the common part of these three functions to function cmd_help to
> avoid code duplication.
>
> Signed-off-by: Andrei Rybak <rybak.a.v@gmail.com>
> Reviewed-by: Felipe Contreras <felipe.contreras@gmail.com>
> ---

This patch looks good to me:

> Resending to make sure that this patch isn't forgotten.
> Originally sent as https://lore.kernel.org/git/20210626163219.4137317-1-rybak.a.v@gmail.com/
>
>  builtin/help.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/help.c b/builtin/help.c
> index bb339f0fc8..b7eec06c3d 100644
> --- a/builtin/help.c
> +++ b/builtin/help.c
> @@ -436,10 +436,9 @@ static void exec_viewer(const char *name, const char *page)
>  		warning(_("'%s': unknown man viewer."), name);
>  }
>  
> -static void show_man_page(const char *git_cmd)
> +static void show_man_page(const char *page)
>  {
>  	struct man_viewer_list *viewer;
> -	const char *page = cmd_to_page(git_cmd);
>  	const char *fallback = getenv("GIT_MAN_VIEWER");
>  
>  	setup_man_path();
> @@ -453,9 +452,8 @@ static void show_man_page(const char *git_cmd)
>  	die(_("no man viewer handled the request"));
>  }
>  
> -static void show_info_page(const char *git_cmd)
> +static void show_info_page(const char *page)
>  {
> -	const char *page = cmd_to_page(git_cmd);
>  	setenv("INFOPATH", system_path(GIT_INFO_PATH), 1);
>  	execlp("info", "info", "gitman", page, (char *)NULL);
>  	die(_("no info viewer handled the request"));
> @@ -486,9 +484,8 @@ static void open_html(const char *path)
>  	execl_git_cmd("web--browse", "-c", "help.browser", path, (char *)NULL);
>  }
>  
> -static void show_html_page(const char *git_cmd)
> +static void show_html_page(const char *page)
>  {
> -	const char *page = cmd_to_page(git_cmd);
>  	struct strbuf page_path; /* it leaks but we exec bellow */
>  
>  	get_html_page_path(&page_path, page);
> @@ -548,6 +545,7 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  {
>  	int nongit;
>  	enum help_format parsed_help_format;
> +	const char *page;
>  
>  	argc = parse_options(argc, argv, prefix, builtin_help_options,
>  			builtin_help_usage, 0);
> @@ -606,16 +604,17 @@ int cmd_help(int argc, const char **argv, const char *prefix)
>  
>  	argv[0] = check_git_cmd(argv[0]);
>  
> +	page = cmd_to_page(argv[0]);

Nit not requring a re-roll: I'd snuggle this with the argv[0], not the
switch statement, i.e. like the existing code.

>  	switch (help_format) {
>  	case HELP_FORMAT_NONE:
>  	case HELP_FORMAT_MAN:
> -		show_man_page(argv[0]);
> +		show_man_page(page);
>  		break;
>  	case HELP_FORMAT_INFO:
> -		show_info_page(argv[0]);
> +		show_info_page(page);
>  		break;
>  	case HELP_FORMAT_WEB:
> -		show_html_page(argv[0]);
> +		show_html_page(page);
>  		break;
>  	}

More generally (not the fault of this patch) the control flow in that
file is quite a mess. I wondered why we can't just add this to
check_git_cmd() then, it's also only called in that one place.

We can, but it and cmd_to_page() return in multiple places, and
help_unknown_cmd() might return, might exit(1) itself etc, so fixing
similar to my 338abb0f045 (builtins + test helpers: use return instead
of exit() in cmd_*, 2021-06-08) should probably be part of some general
refactoring... :)
