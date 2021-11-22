Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58529C433F5
	for <git@archiver.kernel.org>; Mon, 22 Nov 2021 11:54:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239459AbhKVL5w (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Nov 2021 06:57:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239451AbhKVL5t (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Nov 2021 06:57:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF76C061574
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 03:54:43 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id y12so75658935eda.12
        for <git@vger.kernel.org>; Mon, 22 Nov 2021 03:54:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=MaeO/72nBBhkdSNT+3xqHP35/jcDuKfNJNIjIDTY11Q=;
        b=m3vmGR2QjTRwBzDp9TdhQGP0zfGyg0AcjqpNerjm2OyQ0BA37nX61FxlG3zMp3LagH
         OmsNVDAkFkN838UDu0UdTWDHDQI8UnFj5uCViTbwAkidT8pwmBNvPnqDBNmXaKPE5wAD
         27hWXTRzCSvAa2iwMCsEZxGxqTi5fkDz/pnqeeuyOl0Kw9s1a5umWX7x3HQMAPib9lTd
         Yy375QqYsFXdUdf/GmIF8ZhzJP9oCCqDjMnWZO4hX94n14FwUzPmyPV1RTmaw8kfxzIf
         EHbzAW3gSM8XHotdNmPLfeUQo3xf4iTzUfPibb3nkOcjymk/kUfBjW9D7BtWxZiNxUHQ
         uoZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=MaeO/72nBBhkdSNT+3xqHP35/jcDuKfNJNIjIDTY11Q=;
        b=qeEgrp0Um/fu5LDpPY4AMcCYAgaH+iUm94Ba5e3Zp4r57D/UEu9G6V0Ucgff1XCmMZ
         J4mnydC0kcON1qCsM8pyq8bmv5IO5z0wsahyPaZcfP7YzRQTFtR+b4ktnWWafnOniz1l
         CUMtp4n4hr5vzUO2gLC/VSn5e0Vq0trI++/rDwrEtZbThJxxYH2mVD44wedcE2N3n0jR
         OZuGQY0NHKP8q8VPjJr6XTEsKuDpbRl9tfh0dS4O8PEGLdWWkDXi5luDQ51Ua01NHiz5
         0u3XenYJa0vhgvdD3a6HsjFSxQw0JgXTvagTwI0xbprFn4tj7aJtCR7FUtBV8lxbDcAp
         IsbA==
X-Gm-Message-State: AOAM532ZJOK4gDq/wcqMetcNQc0uZEgz2UESr6yu83MGRn0kagwm7TTE
        seVitAvgmHtdAg2deXtc7FA=
X-Google-Smtp-Source: ABdhPJw7sRc5ZqSS6e6JurpyF+bvYH4vVBXovgFXsuNU/Q8KLacx3QnP9ZR7hAG1otr+GFQyZeOkOA==
X-Received: by 2002:aa7:d510:: with SMTP id y16mr64667172edq.338.1637582081712;
        Mon, 22 Nov 2021 03:54:41 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id d18sm3961845edj.23.2021.11.22.03.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Nov 2021 03:54:41 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mp7uC-00109L-FI;
        Mon, 22 Nov 2021 12:54:40 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Fabian Stelzer <fs@gigacodes.de>
Cc:     git@vger.kernel.org, Adam Dinwoodie <adam@dinwoodie.org>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/3] test-lib: make BAIL_OUT() work in tests and prereq
Date:   Mon, 22 Nov 2021 12:52:42 +0100
References: <20211117090410.8013-3-fs@gigacodes.de>
 <20211120150401.254408-1-fs@gigacodes.de>
 <20211120150401.254408-4-fs@gigacodes.de>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.9
In-reply-to: <20211120150401.254408-4-fs@gigacodes.de>
Message-ID: <211122.86y25gz9q7.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Nov 20 2021, Fabian Stelzer wrote:

> BAIL_OUT() is meant to abort the whole test run and print a message with
> a standard prefix that can be parsed to stdout. Since for every test the
> normal fd`s are redirected in test_eval_ this output would not be seen
> when used within the context of a test or prereq like we do in
> test_have_prereq(). To make this function work in these contexts we move
> the setup of the fd aliases a few lines up before the first use of
> BAIL_OUT() and then have this function always print to the alias.
>
> Signed-off-by: Fabian Stelzer <fs@gigacodes.de>
> ---
>  t/test-lib.sh | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f61da562f6..96a09a26a1 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -589,6 +589,11 @@ USER_TERM="$TERM"
>  TERM=dumb
>  export TERM USER_TERM
>  
> +# Set up additional fds so we can control single test i/o
> +exec 5>&1
> +exec 6<&0
> +exec 7>&2
> +
>  _error_exit () {
>  	finalize_junit_xml
>  	GIT_EXIT_OK=t
> @@ -612,7 +617,7 @@ BAIL_OUT () {
>  	local bail_out="Bail out! "
>  	local message="$1"
>  
> -	say_color error $bail_out "$message"
> +	say_color error $bail_out "$message" >&5
>  	_error_exit
>  }
>  
> @@ -637,9 +642,6 @@ then
>  	exit 0
>  fi
>  
> -exec 5>&1
> -exec 6<&0
> -exec 7>&2

This doesn't break (I think) with your change here because you only
manipulate >&5, but I think the post-image would be lot clearer if...

>  if test "$verbose_log" = "t"
>  then
>  	exec 3>>"$GIT_TEST_TEE_OUTPUT_FILE" 4>&3

...this bit of code were moved up along with the "exec". They're
currently intentionally snuggled together as we conditionally set the
3rd and 4th fd depending on verbose/tee settings right after the setup
of 5/6/7, keeping them grouped in the post-image makes more sense than
splitting them up here.

