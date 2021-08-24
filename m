Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05B0AC4338F
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:14:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E56FC61371
	for <git@archiver.kernel.org>; Tue, 24 Aug 2021 20:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235069AbhHXUPi (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Aug 2021 16:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhHXUPi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Aug 2021 16:15:38 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C442C061757
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 13:14:53 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y5so2675825edp.8
        for <git@vger.kernel.org>; Tue, 24 Aug 2021 13:14:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=g7DluW0q2/ga5gnUiQzMwCA24X/4q+Gok1rzHhC+MTY=;
        b=Wm3Mc54RzBBND44rs6re8aCe9At7avWC0zF01GvI8WeVVKnx2/EKp0Og6W8hPu43uN
         VB7IH0Q31JSEjTZ84Hnx4xm9NEWx050j9mC1jGkbl1GxdUy0NGfTTYGr7OhYz5lmD9Cc
         XiRgBNU1+yqVA+/urGrbxbq/XlAbnqReV4a1CI2eT90KHy93ORHJDMo1Zrzd5aFyJ62C
         oYdoxZS1hXGi6wxRV/qw9pmQvuoKv0O2yhTUjIJPawCDXcBmH81S+SCFBRQ/zG8UmrKn
         DOhcfjV69UotyPHblM1MATIUtedPEW5es27LsYPJve4W9gly/soyHzCkWKQugu+VRJje
         lRqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=g7DluW0q2/ga5gnUiQzMwCA24X/4q+Gok1rzHhC+MTY=;
        b=tEmJZQeI4EeOX5VuN8biU8I82JFkbdH5DNEJs6y2ZnEt9KaSo+MDcFg5ScpA9jdS1L
         glupFsHfeDSKJxI6h/7mmLlT0p/XV4qiJG8/PqkKE4aUCrdLuD9zb4orp+rdIowyKt0z
         BP1az2aChBSs28aLn+3EhsLcmfH6ait+Y8H9hph49clJw69C6f+/U1v81Db1zCrTKnFR
         aCseL8Hls9xzP+QR0AjRn+2GA7uh6JatJ++93D5Z6M8gk0cDBxaRf+OjEMoFWuOd4dY3
         sAGd6KcQo2V0rwPTn9Eks50sC4fd+A7arvchTBYFyRjVcq/tOano5Jv7A5/mhHgq5qoJ
         8m6w==
X-Gm-Message-State: AOAM533epezx4Bfudb7iKoAx4ouvR8a5FgoCx8o/TrruYBhYDePPzNwT
        4QKZ8Kr6LYR1BthIc+6p+g8=
X-Google-Smtp-Source: ABdhPJwCBHoBgzbuPgHYvfGs4OiPYDQs1iiE4PQgMUEWgVqzs+gWhp54QR6kSF3m3rYPVt6IUeFjaQ==
X-Received: by 2002:a05:6402:1012:: with SMTP id c18mr24443389edu.98.1629836091885;
        Tue, 24 Aug 2021 13:14:51 -0700 (PDT)
Received: from evledraar (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id y10sm1985199eda.47.2021.08.24.13.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 13:14:51 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v3 6/6] hook: allow out-of-repo 'git hook' invocations
Date:   Tue, 24 Aug 2021 22:12:04 +0200
References: <20210819033450.3382652-1-emilyshaffer@google.com>
 <20210819033450.3382652-7-emilyshaffer@google.com>
User-agent: Debian GNU/Linux 11 (bullseye); Emacs 27.1; mu4e 1.5.13
In-reply-to: <20210819033450.3382652-7-emilyshaffer@google.com>
Message-ID: <87ilzueh1g.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Wed, Aug 18 2021, Emily Shaffer wrote:

> Since hooks can now be supplied via the config, and a config can be
> present without a gitdir via the global and system configs, we can start
> to allow 'git hook run' to occur without a gitdir. This enables us to do
> things like run sendemail-validate hooks when running 'git send-email'
> from a nongit directory.

Sensible goal. Perhaps we should note in an earlier commit when
config-based hooks are introduced something like:

    Even though we've added config-based hooks, they currently only work
    if we can find a .git directory, even though certain commands such
    as "git send-email" (or only that command?) can be run outside of a
    git directory. A subsequent commit will address that edge-case.

> [...]
> Notes:
>     For hookdir hooks, do we want to run them in nongit dir when core.hooksPath
>     is set? For example, if someone set core.hooksPath in their global config and
>     then ran 'git hook run sendemail-validate' in a nongit dir?
> [...]
>  git.c           |  2 +-
>  hook.c          |  2 +-
>  t/t1800-hook.sh | 20 +++++++++++++++-----
>  3 files changed, 17 insertions(+), 7 deletions(-)
>
> diff --git a/git.c b/git.c
> index 540909c391..39988ee3b0 100644
> --- a/git.c
> +++ b/git.c
> @@ -538,7 +538,7 @@ static struct cmd_struct commands[] = {
>  	{ "grep", cmd_grep, RUN_SETUP_GENTLY },
>  	{ "hash-object", cmd_hash_object },
>  	{ "help", cmd_help },
> -	{ "hook", cmd_hook, RUN_SETUP },
> +	{ "hook", cmd_hook, RUN_SETUP_GENTLY },
>  	{ "index-pack", cmd_index_pack, RUN_SETUP_GENTLY | NO_PARSEOPT },
>  	{ "init", cmd_init_db },
>  	{ "init-db", cmd_init_db },
> diff --git a/hook.c b/hook.c
> index 581d87cbbd..2e08156546 100644
> --- a/hook.c
> +++ b/hook.c
> @@ -218,7 +218,7 @@ struct list_head *list_hooks_gently(const char *hookname)
>  
>  	/* Add the hook from the hookdir. The placeholder makes it easier to
>  	 * allocate work in pick_next_hook. */
> -	if (find_hook_gently(hookname))
> +	if (have_git_dir() && find_hook_gently(hookname))
>  		append_or_move_hook(hook_head, NULL);
>  
>  	return hook_head;
> diff --git a/t/t1800-hook.sh b/t/t1800-hook.sh
> index ef2432f53a..a7e45c0d16 100755
> --- a/t/t1800-hook.sh
> +++ b/t/t1800-hook.sh
> @@ -118,15 +118,25 @@ test_expect_success 'git hook run -- pass arguments' '
>  	test_cmp expect actual
>  '
>  
> -test_expect_success 'git hook run -- out-of-repo runs excluded' '
> -	write_script .git/hooks/test-hook <<-EOF &&
> -	echo Test hook
> -	EOF
> +test_expect_success 'git hook run: out-of-repo runs execute global hooks' '
> +	test_config_global hook.global-hook.event test-hook --add &&
> +	test_config_global hook.global-hook.command "echo no repo no problems" --add &&
> +
> +	echo "global-hook" >expect &&
> +	nongit git hook list test-hook >actual &&
> +	test_cmp expect actual &&
> +
> +	echo "no repo no problems" >expect &&
>  
> -	nongit test_must_fail git hook run test-hook
> +	nongit git hook run test-hook 2>actual &&
> +	test_cmp expect actual
>  '
>  
>  test_expect_success 'git -c core.hooksPath=<PATH> hook run' '
> +	write_script .git/hooks/test-hook <<-EOF &&
> +	echo Test hook
> +	EOF
> +
>  	mkdir my-hooks &&
>  	write_script my-hooks/test-hook <<-\EOF &&
>  	echo Hook ran $1 >>actual

If the only user of this is git-send-email, let's have tests for this in
t/t9001-send-email.sh. That should also address your "Notes" above,
i.e. let's just test it with core.hooksPath and see what the interaction
looks like.
