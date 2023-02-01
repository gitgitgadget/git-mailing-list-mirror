Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CEACC05027
	for <git@archiver.kernel.org>; Wed,  1 Feb 2023 17:45:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230245AbjBARpc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Feb 2023 12:45:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBARpb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Feb 2023 12:45:31 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFA7A5DC
        for <git@vger.kernel.org>; Wed,  1 Feb 2023 09:45:30 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id e8-20020a17090a9a8800b0022c387f0f93so2973760pjp.3
        for <git@vger.kernel.org>; Wed, 01 Feb 2023 09:45:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5Boc6EA49a6rAsTPNo6vnwuHClyaQfUyPUZxzFjGUDY=;
        b=KfcqSLmRNh4gDAZkoj658Jg+uq59qB/sl+Nfij7djZO8zGkcaHjVDHSnL9Wfn44JR4
         39G1YErGF8c1fMhkVrF5RYCmizN2qPhMplifHRrpsjNxHo7yIDl9Bmq7hRCR1pCrRddK
         oStG4oFDkvEVBO2odp1Q++y/wevAv6H4QZJbKDODfqvpl0vEh8hOB2LEuijowXHrDcjd
         kJTLT/XIO68HAPoZBDOu3wGbc+Z5OJ1FDxNN9WwuuBpVi2Ry3i0EOWcIxbbs7yqeaVN5
         emsZeRZymZ1fsX0JwC6wNNkZogxh6STdqf175MEQ6sSjvfWQkcx2+v6c+N4X6AtYK5Ns
         mmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=5Boc6EA49a6rAsTPNo6vnwuHClyaQfUyPUZxzFjGUDY=;
        b=JSaMFc2cJpbvD+ZvW3MVXlTLk0GpS0AH7NsVj5z8Hfm993RTAeOY25ZR/bXFD5JHUV
         7hRomyM+ahgDGc6pVEA3LD8sqbHqf9l8j2KltZS4oUrmw/5pJTmQyZ9xMfZ9l/MoReYe
         I5vgxj8IxBVxTzKK0s7Qm2CQzD4+aUa5FHC95UL7ea13fotjGH5OVn9eZjF8cfZk9/eY
         2bF4bFQWjhD5Vms/p/c4+DBnXQrgHP4nGOs2cZ4APira7YdP+WgHfSfUyYSopB9mOBr1
         rcnuuG+m2UWS92otFOabEThaSuCydC7EEhjYgBwweoTLq0cq6kV92eeTPzRViX2a+I/W
         EmWg==
X-Gm-Message-State: AO0yUKUoUUXMyFsT0qqur5dLtjgxKamFXmYFSJGbV+J9iztEWdWQVWuh
        xRFU7k6jVcGDb1L92vCcV6Fw18psJVQ=
X-Google-Smtp-Source: AK7set9dO16RxN/dFYmkMr2fyi77DHTmv3hLSiLvRwRbosXytAH0QY8zawScmfZ9plFetV5HHSPz6Q==
X-Received: by 2002:a17:90a:1955:b0:22b:f1d2:784 with SMTP id 21-20020a17090a195500b0022bf1d20784mr3145571pjh.42.1675273529397;
        Wed, 01 Feb 2023 09:45:29 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id ml17-20020a17090b361100b0022ca3278a8bsm1629602pjb.30.2023.02.01.09.45.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Feb 2023 09:45:28 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Orgad Shaneh <orgads@gmail.com>
Subject: Re: [PATCH] clean: flush after each line
References: <pull.1447.git.git.1675246158282.gitgitgadget@gmail.com>
Date:   Wed, 01 Feb 2023 09:45:28 -0800
In-Reply-To: <pull.1447.git.git.1675246158282.gitgitgadget@gmail.com> (Orgad
        Shaneh via GitGitGadget's message of "Wed, 01 Feb 2023 10:09:18
        +0000")
Message-ID: <xmqqedr91dqf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Orgad Shaneh via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Orgad Shaneh <orgads@gmail.com>
>
> Some platforms don't automatically flush after \n, and this causes delay
> of the output, and also sometimes incomplete file names appear until the
> next chunk is flushed.
>
> Reported here: https://github.com/git-for-windows/git/issues/3706
>
> Signed-off-by: Orgad Shaneh <orgads@gmail.com>
> ---
>     clean: flush after each line

We do not flush after every line when producing output from "git
diff", "git status".  I do not want to see "git clean" special
cased, as such a solution will not scale.

> diff --git a/builtin/clean.c b/builtin/clean.c
> index b2701a28158..f3de8170f9a 100644
> --- a/builtin/clean.c
> +++ b/builtin/clean.c
> @@ -270,8 +270,10 @@ static int remove_dirs(struct strbuf *path, const char *prefix, int force_flag,
>  
>  	if (!*dir_gone && !quiet) {
>  		int i;
> -		for (i = 0; i < dels.nr; i++)
> +		for (i = 0; i < dels.nr; i++) {
>  			printf(dry_run ?  _(msg_would_remove) : _(msg_remove), dels.items[i].string);
> +			fflush(stdout);
> +		}

If the standard output is connected to an interactive terminal, this
might make sense (but then that equally applies to "git status",
"git diff" and all other commands), but shouldn't the stdout follow
the simple "Output streams that refer to terminal devices are always
line buffered by default" rule?

I think this should be fixed at the platform level, either by
talking to the platform maintainers.  An acceptable workaround may
be to have an #ifdef'ed hack early in our start-up code, e.g.

	void sanitize_stdfds(void)
	{
		int fd = ...;
		if (fd > 2)
			close(fd);
	#ifdef BUGGY_STDOUT_FULLY_BUFFERED
		if (isatty(1))
			setlinebuf(stdout);
	#endif
	}

somewhere that is reached early from common-main.c::main().

That way, we do not have to carry a special-case in builtin/clean.c
and watch out for other commands that produce multiple lines of
output start needing a workaround on platforms with such a buffering
behaviour.

> @@ -544,6 +546,7 @@ static int parse_choice(struct menu_stuff *menu_stuff,
>  			clean_print_color(CLEAN_COLOR_ERROR);
>  			printf(_("Huh (%s)?\n"), (*ptr)->buf);
>  			clean_print_color(CLEAN_COLOR_RESET);
> +			fflush(stdout);
>  			continue;

This is clearly interactive codepath, and I do not think we mind an
extra fflush().  But it would be redundant if we fix the stdio on
such a platform.

>  		}
>  
>
> base-commit: 2fc9e9ca3c7505bc60069f11e7ef09b1aeeee473
