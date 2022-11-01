Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1214AFA373D
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 03:34:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiKADeu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 Oct 2022 23:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKADes (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 Oct 2022 23:34:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4236713F9D
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 20:34:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id n12so34061773eja.11
        for <git@vger.kernel.org>; Mon, 31 Oct 2022 20:34:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0pR4Mq8M4NonzIojpgZEfNXPdiOhLCTVd5Tv0KhEM6o=;
        b=FUrHFgrdlriCMM/5VNCjQlJcNKb0q5CdckbwfbjNGw+5X7U5IbSV3d6EAN39vSzuFk
         n3NuWwi2oLrWv1rX+kwHrrui5deKqVEkhrIV3JNSQVyIpf6zw8HJ/jMu2lNL5GImfaRe
         Qp6LfBfQP/bGRftxMjTPFxuvzxyIZFG7geMGBJuXMEevua9mfvdljymAjpkbJ1T24Q0U
         lAHh0Sr2GLrZIH13GfwzcMrVTZV9Gf0aXZgwzk5wMaEDEwB+ax4jd1s7gOpKeyIURT4x
         QoBnEzZZ4DPMjTH/tcMt8TZKL8LxMEVa8jywi7WntMRo5hLPOlw2XdAd9wHQezLD+jPR
         diWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:user-agent:references:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0pR4Mq8M4NonzIojpgZEfNXPdiOhLCTVd5Tv0KhEM6o=;
        b=eza4ZpHIflB5ikdfDXgoCR8n4Z3zsd7aLyWB7ltQlZ/k1xcqJJO0chRs0xZpy/4yHz
         IBZ6jvuCry3Kx90C6dhhF+ddIafCv/yK12Gj9l42XZeZlzGDxwgg4sF2HLsQBiVM36Es
         X4hO8WB0BdRXo/xxjIuGKcI1vn39mYnvYtCFf4qVgP/KQRlG5YzYgU+beF1F1OzprJxw
         z7DzICKJC7LtQk0v/Mx2gB3B49uByxZy79yTbm+zVMIFM1pooYewCN6fwbM/69fdemYd
         a3ZlQ6rjHj4KHAN5B5aX7Cq2v2MOGUHyEwEe6FYeUkenvupgBiBszyL9o/SaOaGKgzxU
         +bSQ==
X-Gm-Message-State: ACrzQf0xqxn46ByQ18w/Wrowj9OUqhRWdpjYjeMnGmB+HGD6w3zBsfpF
        DcC5e8rlHoeNkEx6E0+qRa8=
X-Google-Smtp-Source: AMsMyM46/eTKdmLEghrJKbPiNmxXcD3eAIw27BHHkXQppOR+/oDMefobNqeQcxqfP+MPGjdPeEIuNA==
X-Received: by 2002:a17:906:2bc7:b0:72f:dc70:a3c6 with SMTP id n7-20020a1709062bc700b0072fdc70a3c6mr16645432ejg.645.1667273685773;
        Mon, 31 Oct 2022 20:34:45 -0700 (PDT)
Received: from gmgdl (dhcp-077-248-183-071.chello.nl. [77.248.183.71])
        by smtp.gmail.com with ESMTPSA id c6-20020a056402120600b0045d74aa401fsm3900709edw.60.2022.10.31.20.34.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 20:34:45 -0700 (PDT)
Received: from avar by gmgdl with local (Exim 4.96)
        (envelope-from <avarab@gmail.com>)
        id 1opi32-00B1xA-2V;
        Tue, 01 Nov 2022 04:34:44 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Jeff King <peff@peff.net>
Cc:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 2/2] t5516/t5601: be less strict about the number of
 credential warnings
Date:   Tue, 01 Nov 2022 04:29:31 +0100
References: <Y2CDrZNgNZ+flJBK@coredump.intra.peff.net>
 <Y2CD6GBl6ORqKsug@coredump.intra.peff.net>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.9.0
In-reply-to: <Y2CD6GBl6ORqKsug@coredump.intra.peff.net>
Message-ID: <221101.861qqn5ovf.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Mon, Oct 31 2022, Jeff King wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>

Whatever our difference of opinion about the usefulness of not asserting
that a thing doesn't get worse, even if it isn't perfect (c.f.:
https://lore.kernel.org/git/221101.86a65b5q9q.gmgdl@evledraar.gmail.com/)
I think that...

> It is unclear as to _why_, but under certain circumstances the warning
> about credentials being passed as part of the URL seems to be swallowed
> by the `git remote-https` helper in the Windows jobs of Git's CI builds.

..this description dosen't match what the patch is doing, okey, so
there's a case where the remote helper swallows the warnings, i.e. we'll
emit fewer than we expected...

> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  t/t5551-http-fetch-smart.sh | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
>
> diff --git a/t/t5551-http-fetch-smart.sh b/t/t5551-http-fetch-smart.sh
> index bbe3d5721f..64c6c9f59e 100755
> --- a/t/t5551-http-fetch-smart.sh
> +++ b/t/t5551-http-fetch-smart.sh
> @@ -597,17 +597,17 @@ test_expect_success 'clone warns or fails when using username:password' '
>  	git -c transfer.credentialsInUrl=warn \
>  		clone $url_userpass attempt2 2>err &&
>  	grep "warning: $message" err >warnings &&
> -	test_line_count = 2 warnings &&
> +	test_line_count -ge 1 warnings &&
>  
>  	test_must_fail git -c transfer.credentialsInUrl=die \
>  		clone $url_userpass attempt3 2>err &&
>  	grep "fatal: $message" err >warnings &&
> -	test_line_count = 1 warnings &&
> +	test_line_count -ge 1 warnings &&
>  
>  	test_must_fail git -c transfer.credentialsInUrl=die \
>  		clone $url_userblank attempt4 2>err &&
>  	grep "fatal: $message" err >warnings &&
> -	test_line_count = 1 warnings
> +	test_line_count -ge 1 warnings
>  '
>  
>  test_expect_success 'clone does not detect username:password when it is https://username@domain:port/' '
> @@ -630,17 +630,17 @@ test_expect_success 'fetch warns or fails when using username:password' '
>  
>  	git -c transfer.credentialsInUrl=warn fetch $url_userpass 2>err &&
>  	grep "warning: $message" err >warnings &&
> -	test_line_count = 3 warnings &&
> +	test_line_count -ge 1 warnings &&
>  
>  	test_must_fail git -c transfer.credentialsInUrl=die \
>  		fetch $url_userpass 2>err &&
>  	grep "fatal: $message" err >warnings &&
> -	test_line_count = 1 warnings &&
> +	test_line_count -ge 1 warnings &&
>  
>  	test_must_fail git -c transfer.credentialsInUrl=die \
>  		fetch $url_userblank 2>err &&
>  	grep "fatal: $message" err >warnings &&
> -	test_line_count = 1 warnings
> +	test_line_count -ge 1 warnings
>  '
>  
>  
> @@ -654,7 +654,7 @@ test_expect_success 'push warns or fails when using username:password' '
>  	test_must_fail git -c transfer.credentialsInUrl=die \
>  		push $url_userpass 2>err &&
>  	grep "fatal: $message" err >warnings &&
> -	test_line_count = 1 warnings
> +	test_line_count -ge 1 warnings
>  '

...but then why are we modifying these codepaths that have nothing to do
with invoking the remote helper, i.e. where we die early before we get
to that?

And even if some of this was invoking that remote helper and we were
modifying it blindly, then presumably the helper swallowing it would
result in 0 some of the time, so "-ge 1" would be wrong.

(That's not the case, but it's why I think the patch doesn't make much
sense).
