Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 080A920C4C
	for <e@80x24.org>; Mon, 12 Jun 2017 20:43:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752725AbdFLUnn (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Jun 2017 16:43:43 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:36260 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752610AbdFLUnm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Jun 2017 16:43:42 -0400
Received: by mail-pg0-f65.google.com with SMTP id v18so15319197pgb.3
        for <git@vger.kernel.org>; Mon, 12 Jun 2017 13:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=p91OF4bwtt3/VHZLdWluureZSJWf2GyXHA9yIQDRMxA=;
        b=DzHL4iqcUyoGrg32ZQhF2/Cn2Ahl8NUr+Pd+gkK0Q6l/ufujbW+ieSEmv+DRe0zPHw
         jKTy/Uu5Zct7etdkUIsI2oKFB5TKMCjNu7vZ7Zo9rsH18menzh4q2F61FAJJGDmd8TeH
         Z80QJmcPH2+8KBvPnm4D2DSzm0kykKEFC7KY9+Fy6M5oH7lVM+2xu/vRcIB3fIwl1B9F
         p73fL9D0RW/1UI8f/1X+FK/T6ClMfTAm3JDYIvF3KMJ6ES9IBgwnbPQrV15AeFfKt5nV
         Vaq7sKzv9tmYx0+Rbt47yr+cm+i+Wp3OqhpWgsRps19i5WVZKbrX+LkUpAtKLQewNekM
         Y2JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=p91OF4bwtt3/VHZLdWluureZSJWf2GyXHA9yIQDRMxA=;
        b=Wt0elsj7Xe8US3daQKlKdzAzrHhez9MyvGTtNpaIkqNnf8bm69pW1lDsbByBUOgJsB
         O5cYkqzo2at/g5PGJBx2wqE9ADySBbOph7aAVrwDIYYXravW4TCenakv8sKU5KLGLVqU
         /WAPFSazUfYDMpGkRvJ67AS2aHrrM9wGz0S3rgrUHreYd0j/inkjliLCqOniCslJZH2H
         ngmOBg7z5crI3AXlIcpdXFxurVsgmfTUArODB1RHSUqnkvHGXVaojOAzwtg0x1zlxg3i
         Ovr/C3h0VXo59veIgn/1Rx3g0126v13tBxntBwnTN3V7lYrLp2bV3BtqzDXW8QeOpi0Y
         cWVw==
X-Gm-Message-State: AODbwcBaQq/9KsHhE9vKBYHguF4Uer4WKV6vWe1fOfmqOrBVUkvP25v8
        9aFY/fSG5G5gpQ==
X-Received: by 10.98.224.194 with SMTP id d63mr52495948pfm.174.1497300221673;
        Mon, 12 Jun 2017 13:43:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:695d:4129:fb97:59df])
        by smtp.gmail.com with ESMTPSA id c27sm21103126pfj.107.2017.06.12.13.43.40
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 12 Jun 2017 13:43:40 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 8/8] Use the early config machinery to expand aliases
References: <cover.1496951503.git.johannes.schindelin@gmx.de>
        <af40ce088de03130a5edfae187bb8274b5a9d3a9.1496951503.git.johannes.schindelin@gmx.de>
        <20170610100730.j62kh2hayt6zknr5@sigill.intra.peff.net>
        <20170610101057.yeemax73c2t6truz@sigill.intra.peff.net>
Date:   Mon, 12 Jun 2017 13:43:39 -0700
In-Reply-To: <20170610101057.yeemax73c2t6truz@sigill.intra.peff.net> (Jeff
        King's message of "Sat, 10 Jun 2017 06:10:57 -0400")
Message-ID: <xmqq1sqpndhg.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Sat, Jun 10, 2017 at 06:07:30AM -0400, Jeff King wrote:
>
>> But couldn't we just unconditionally do:
>> 
>>   setup_git_directory_gently();
>> 
>> here to move into the top-level if there is one, without caring about
>> cdup_dir at all?
>
> IOW, drop your patch 4, and then squash patches 7 and 8 into this:

That looks a lot simpler.

> diff --git a/alias.c b/alias.c
> index 3b90397a9..6bdc93630 100644
> --- a/alias.c
> +++ b/alias.c
> @@ -1,14 +1,31 @@
>  #include "cache.h"
>  
> +struct config_alias_data
> +{
> +	struct strbuf key;
> +	char *v;
> +};
> +
> +static int config_alias_cb(const char *key, const char *value, void *d)
> +{
> +	struct config_alias_data *data = d;
> +
> +	if (!strcmp(key, data->key.buf))
> +		return git_config_string((const char **)&data->v, key, value);
> +
> +	return 0;
> +}
> +
>  char *alias_lookup(const char *alias)
>  {
> -	char *v = NULL;
> -	struct strbuf key = STRBUF_INIT;
> -	strbuf_addf(&key, "alias.%s", alias);
> -	if (git_config_key_is_valid(key.buf))
> -		git_config_get_string(key.buf, &v);
> -	strbuf_release(&key);
> -	return v;
> +	struct config_alias_data data = { STRBUF_INIT, NULL };
> +
> +	strbuf_addf(&data.key, "alias.%s", alias);
> +	if (git_config_key_is_valid(data.key.buf))
> +		read_early_config(config_alias_cb, &data);
> +	strbuf_release(&data.key);
> +
> +	return data.v;
>  }
>  
>  #define SPLIT_CMDLINE_BAD_ENDING 1
> diff --git a/git.c b/git.c
> index 8ff44f081..4e556fa9a 100644
> --- a/git.c
> +++ b/git.c
> @@ -16,50 +16,6 @@ const char git_more_info_string[] =
>  	   "to read about a specific subcommand or concept.");
>  
>  static int use_pager = -1;
> -static char *orig_cwd;
> -static const char *env_names[] = {
> -	GIT_DIR_ENVIRONMENT,
> -	GIT_WORK_TREE_ENVIRONMENT,
> -	GIT_IMPLICIT_WORK_TREE_ENVIRONMENT,
> -	GIT_PREFIX_ENVIRONMENT
> -};
> -static char *orig_env[4];
> -static int save_restore_env_balance;
> -
> -static void save_env_before_alias(void)
> -{
> -	int i;
> -
> -	assert(save_restore_env_balance == 0);
> -	save_restore_env_balance = 1;
> -	orig_cwd = xgetcwd();
> -	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
> -		orig_env[i] = getenv(env_names[i]);
> -		orig_env[i] = xstrdup_or_null(orig_env[i]);
> -	}
> -}
> -
> -static void restore_env(int external_alias)
> -{
> -	int i;
> -
> -	assert(save_restore_env_balance == 1);
> -	save_restore_env_balance = 0;
> -	if (!external_alias && orig_cwd && chdir(orig_cwd))
> -		die_errno("could not move to %s", orig_cwd);
> -	free(orig_cwd);
> -	for (i = 0; i < ARRAY_SIZE(env_names); i++) {
> -		if (external_alias &&
> -		    !strcmp(env_names[i], GIT_PREFIX_ENVIRONMENT))
> -			continue;
> -		if (orig_env[i]) {
> -			setenv(env_names[i], orig_env[i], 1);
> -			free(orig_env[i]);
> -		} else {
> -			unsetenv(env_names[i]);
> -		}
> -	}
> -}
>  
>  static void commit_pager_choice(void) {
>  	switch (use_pager) {
> @@ -250,19 +206,17 @@ static int handle_alias(int *argcp, const char ***argv)
>  	const char **new_argv;
>  	const char *alias_command;
>  	char *alias_string;
> -	int unused_nongit;
> -
> -	save_env_before_alias();
> -	setup_git_directory_gently(&unused_nongit);
>  
>  	alias_command = (*argv)[0];
>  	alias_string = alias_lookup(alias_command);
>  	if (alias_string) {
>  		if (alias_string[0] == '!') {
> +			int nongit_ok;
>  			struct child_process child = CHILD_PROCESS_INIT;
>  
> +			setup_git_directory_gently(&nongit_ok);
> +
>  			commit_pager_choice();
> -			restore_env(1);
>  
>  			child.use_shell = 1;
>  			argv_array_push(&child.args, alias_string + 1);
> @@ -308,8 +262,6 @@ static int handle_alias(int *argcp, const char ***argv)
>  		ret = 1;
>  	}
>  
> -	restore_env(0);
> -
>  	errno = saved_errno;
>  
>  	return ret;
> diff --git a/t/t7006-pager.sh b/t/t7006-pager.sh
> index 83881ec3a..20b4d83c2 100755
> --- a/t/t7006-pager.sh
> +++ b/t/t7006-pager.sh
> @@ -391,7 +391,7 @@ test_expect_success TTY 'core.pager in repo config works and retains cwd' '
>  	)
>  '
>  
> -test_expect_failure TTY 'core.pager is found via alias in subdirectory' '
> +test_expect_success TTY 'core.pager is found via alias in subdirectory' '
>  	sane_unset GIT_PAGER &&
>  	test_config core.pager "cat >via-alias" &&
>  	(
