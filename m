Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C15F7C64EC4
	for <git@archiver.kernel.org>; Wed,  8 Mar 2023 23:13:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCHXNg (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Mar 2023 18:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjCHXNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Mar 2023 18:13:25 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 195AA58496
        for <git@vger.kernel.org>; Wed,  8 Mar 2023 15:13:21 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id n6so139077plf.5
        for <git@vger.kernel.org>; Wed, 08 Mar 2023 15:13:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678317200;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7nEr11zWtU8SqARSJp43NRLIgy8F5gnNbaeVU9kss0=;
        b=ptpiZjxj043Mh912PUW6CB7Ih0zeJMoKVqapTPsPZdFuRR6+4yufamb2TELNNjlDzB
         B2XvnATHA7hUD8EID3+LXQE1LJsXgfzmThYWK55uLdYwrPCS0OCd5PD4c3S1L9zLXYTy
         4fbo+KZAUdqzQXNfyZJMf7q6OdOBmFRx8x8G8TKrMOj/tAPm288kCCnWLPW6EORmGl+c
         AkPLOKIA/FxWZzbY2GUF5gUJ9YLPogRMVTRBah0N+GRsaP6vtL/CSehMRHgzTIe7XjRJ
         UfjsFXylbte8SqIJlYw7zLuiiZwCWFfZRnXk9t0o1kjzhc1y62qb/LH6K2jjvfAIX741
         7bpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678317200;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=w7nEr11zWtU8SqARSJp43NRLIgy8F5gnNbaeVU9kss0=;
        b=wFm4UQ6LubFqmNsioNF6m0Ft3NRP8lTvYyoeq1zcCDj3jJSRHx4oG8dK8B/mktb++f
         hp2OvMIGThszrhySL3iF0uK/6rWEO3Zgk9hmcyd806dDC80nD412JG3J3Hnxs7RjcVqM
         qLDeHdvtrzh1KFBYTN/tOe9n8MbcgJGDLk2d0XVz+dbpMCgKAojrvOHZshc97AGtXaKX
         nPmB4rIU8tiB5uqVhiSmzJX2q5svwHWV2KIzD2UI59z7s/ewN178eyHbjJficamIsyuA
         PfTy7WspN7QbHKFjU3Z+Wyi1EXZEtmR3CmVgzyL/N4b5LBzF4daSBXduZBORC9VBgo3C
         2pyw==
X-Gm-Message-State: AO0yUKX297ParXekTFifXnCmB0qRn2QDRg0qUuNYtOs3ZSmPGGHeZWfD
        XLSlhxUZt80XkG4SHPooTtjCi82GVuo=
X-Google-Smtp-Source: AK7set+dqz8RDjW0L0ibw9977kuNwujrst7CxZJui0xtBLD5ZmwfgWNFygYjNys06X5TGmbiTd+hBg==
X-Received: by 2002:a17:90a:350:b0:23a:340d:fa49 with SMTP id 16-20020a17090a035000b0023a340dfa49mr4438812pjf.32.1678317200192;
        Wed, 08 Mar 2023 15:13:20 -0800 (PST)
Received: from localhost (83.92.168.34.bc.googleusercontent.com. [34.168.92.83])
        by smtp.gmail.com with ESMTPSA id ge12-20020a17090b0e0c00b00230b8431323sm267167pjb.30.2023.03.08.15.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 15:13:19 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2] fetch: pass --no-write-fetch-head to subprocesses
References: <20230308100438.908471-1-e@80x24.org> <xmqqwn3rta2c.fsf@gitster.g>
        <20230308222205.M679514@dcvr>
Date:   Wed, 08 Mar 2023 15:13:19 -0800
In-Reply-To: <20230308222205.M679514@dcvr> (Eric Wong's message of "Wed, 8 Mar
        2023 22:22:05 +0000")
Message-ID: <xmqqttyurg4w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> +test_expect_success 'git fetch --all --no-write-fetch-head' '
> +	(cd test &&
> +	rm -f .git/FETCH_HEAD &&
> +	git fetch --all --no-write-fetch-head &&
> +	test_path_is_missing .git/FETCH_HEAD)
> +'

The style used in the other script might be more modern, but given
that the existing one (in the post context) uses the same older
style, I think that would be OK.

>  test_expect_success 'git fetch --all should continue if a remote has errors' '
>  	(git clone one test2 &&
>  	 cd test2 &&
> diff --git a/t/t5526-fetch-submodules.sh b/t/t5526-fetch-submodules.sh
> index b9546ef8e5..8ffb300f2d 100755
> --- a/t/t5526-fetch-submodules.sh
> +++ b/t/t5526-fetch-submodules.sh
> @@ -167,6 +167,19 @@ test_expect_success "fetch --recurse-submodules recurses into submodules" '
>  	verify_fetch_result actual.err
>  '
>  
> +test_expect_success "fetch --recurse-submodules honors --no-write-fetch-head" '
> +	(
> +		cd downstream &&
> +		fh=$(find . -name FETCH_HEAD -type f) &&
> +		rm -f $fh &&

I do not like this part.  The "rm -f" we saw in the "fetch --all" test
was "make sure it is missing, so that we can be sure that presence
after running 'git fetch' *is* a bug".  But using $fh later ...

> +		git fetch --recurse-submodules --no-write-fetch-head &&
> +		for f in $fh
> +		do
> +			test_path_is_missing $f || return 1
> +		done

... like this means now we depend on FETCH_HEAD being in all
submodule repositories before we start this step.

I think we should instead enumerate submodule repositories, instead
of enumerating existing .git/FETCH_HEAD files.

> +	)
> +'
> +
>  test_expect_success "submodule.recurse option triggers recursive fetch" '
>  	add_submodule_commits &&
>  	(
