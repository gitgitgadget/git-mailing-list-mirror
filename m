Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E28A6C4332F
	for <git@archiver.kernel.org>; Mon, 19 Dec 2022 18:46:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbiLSSqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Dec 2022 13:46:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiLSSqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Dec 2022 13:46:34 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6A5C26E2
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:46:32 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id a16so14200556edb.9
        for <git@vger.kernel.org>; Mon, 19 Dec 2022 10:46:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4hzBCptF5NmY1jL4PYh+mLMEaMMl35WqFnQKwsW+5dw=;
        b=gg2Vxvc6s37ZRwBy42r/vrztjgSynXWIv1i/ZENdqEnPAmHiLX1PnazKMn9gRENjdg
         JJSC8CsRy16XKmVkYJr7WSF7jtX6x1drwMDEeYWmbw2pjQemgvuFIssueuvy2t0uyJxn
         We8wf+wpwGVrvsIcdLMVd4CYDFnZQ2s9UfNf/px/9sIBHpVLVJGHhymQgGjMdRFT/ySv
         wXxfyXk8Owu46C89qWxTfSYTqGKSEswdUJoDH3q/9/ASnaD4bASdju44htXTCK8N39w2
         ujrhI3MXWsRY0Zn3WOPOg+Hp8+fx3jcoK0QBLZHeQ5Rql4+MsDYwhX6ijJTwEVPKmdJX
         XhWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4hzBCptF5NmY1jL4PYh+mLMEaMMl35WqFnQKwsW+5dw=;
        b=yIDeCJCL9ILJ1MGYwwCghUaiUBba4b7yd0171/4sam5Ysae6qBF1LTlxqZB0agPMxO
         UEs1UNYYc1BgHP6461pDXt07SzF6nfiEkUOx8U0lgMjAtn6Fu9Xt8dSuVPASLNnj522B
         U1fKqFgqbvEAs1Lirwd3VJjefGXIrzMZDCWPT8Bn1Co7/buAp+DGCDnBe6xITZUkvvkP
         w6RSTNVMYyv4VaKSsB6RQNfyFo/tUkIT3fAYIKjNXz6WmP2WIjc81TXiVMjpkkkrBcsc
         GO+v+M4YWToLRp+6ZnhvZPK0L/f88g7g5q0S89xr5gG6llnx5j8SlbAuVc5lpqhuzFE7
         PgwQ==
X-Gm-Message-State: ANoB5plpILI9HITx017Xf+pBL92X7wxfHCBLGy6tI3Q2JZ0xOA+nv85R
        jvP0OKJG5vAWDPxcTCpMrDmrTl78sQD35w==
X-Google-Smtp-Source: AA0mqf7ZHWgiW1Kcs+1xFYPQctaVm3OVu2xT/9O1h4sbw4iBRTVBbHJhLbO5N841mrgPn75erUc4pA==
X-Received: by 2002:a05:6402:e9e:b0:470:2270:c508 with SMTP id h30-20020a0564020e9e00b004702270c508mr26496117eda.41.1671475590985;
        Mon, 19 Dec 2022 10:46:30 -0800 (PST)
Received: from gmgdl (j84076.upc-j.chello.nl. [24.132.84.76])
        by smtp.gmail.com with ESMTPSA id a2-20020a170906274200b007bb86679a32sm4719232ejd.217.2022.12.19.10.46.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Dec 2022 10:46:30 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1p7L9i-006ik5-0M;
        Mon, 19 Dec 2022 19:46:30 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Rose via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Seija Kijin <doremylover123@gmail.com>
Subject: Re: [PATCH] win32: close handles of threads that have been joined
Date:   Mon, 19 Dec 2022 19:40:37 +0100
References: <pull.1406.git.git.1671474876207.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <pull.1406.git.git.1671474876207.gitgitgadget@gmail.com>
Message-ID: <221219.86ili7xmd5.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Dec 19 2022, Rose via GitGitGadget wrote:

> From: Seija Kijin <doremylover123@gmail.com>
>
> After joining threads, the handle to the original thread
> should be closed as it no longer needs to be open.
>
> Signed-off-by: Seija Kijin <doremylover123@gmail.com>
> ---
>     win32: close handles of threads that have been joined
>     
>     After joining threads, the handle to the original thread should be
>     closed as it no longer needs to be open.
>     
>     Signed-off-by: Seija Kijin doremylover123@gmail.com
>
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1406%2FAtariDreams%2Fjoin-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1406/AtariDreams/join-v1
> Pull-Request: https://github.com/git/git/pull/1406
>
>  compat/win32/pthread.c | 22 ++++++++++++++--------
>  1 file changed, 14 insertions(+), 8 deletions(-)
>
> diff --git a/compat/win32/pthread.c b/compat/win32/pthread.c
> index 2e7eead42cb..de89667ef70 100644
> --- a/compat/win32/pthread.c
> +++ b/compat/win32/pthread.c
> @@ -39,14 +39,20 @@ int win32_pthread_join(pthread_t *thread, void **value_ptr)
>  {
>  	DWORD result = WaitForSingleObject(thread->handle, INFINITE);
>  	switch (result) {
> -		case WAIT_OBJECT_0:
> -			if (value_ptr)
> -				*value_ptr = thread->arg;
> -			return 0;
> -		case WAIT_ABANDONED:
> -			return EINVAL;
> -		default:
> -			return err_win_to_posix(GetLastError());
> +	case WAIT_OBJECT_0:
> +		if (value_ptr)
> +			*value_ptr = thread->arg;
> +		/* detach the thread once the join succeeds */
> +		CloseHandle(thread->handle);
> +		return 0;
> +	case WAIT_ABANDONED:
> +		/* either thread is not joinable or another thread is waiting on
> +		 * this, so we do not detatch */

See CodingGuidelines for how multi-line comments should look like.

	/*
	 * Like this
	 * Another line etc.
	 */
> +		return EINVAL;
> +	default:
> +	case WAIT_FAILED:
> +		/* the function failed so we do not detach */
> +		return err_win_to_posix(GetLastError());

The post-image adhares to our CodingGuidelines better than the
pre-image, but please split up such re-indentation into a "prep" change.
Manually looking at this with "git show -w" shows the actual (and
smaller) functional change.

You add a "case" for WAIT_FAILED", but keep "default".

I have no idea about this API, but a search turned up:
https://learn.microsoft.com/en-us/windows/win32/api/synchapi/nf-synchapi-waitforsingleobject

That seems to suggest that it only returns 4 possible values.

Rather than having the "default" case shouldn't we (and this is just a
suggestion, and should be its own prep change in any case) do:

	switch (result) {
	case WAIT_OBJECT_0:
		return ...;
	case WAIT_ABANDONED:
		return ...;
	case WAIT_TIMEOUT:
	case WAIT_FAILED:
		return ...;
	default:
		BUG("unhandled result %d", result);
	}

I.e. instead of keeping "default" you can just list "WAIT_TIMEOUT".

I don't know if that's OK with this API, it does say "If the function
succeeds, the return value indicates, so maybe that "default" handles a
lot more still?



