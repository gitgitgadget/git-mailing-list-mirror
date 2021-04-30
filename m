Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F5EEC433B4
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:57:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27B3961474
	for <git@archiver.kernel.org>; Fri, 30 Apr 2021 09:57:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbhD3J6b (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Apr 2021 05:58:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbhD3J6a (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Apr 2021 05:58:30 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F17FC06174A
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:57:42 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y7so5486436ejj.9
        for <git@vger.kernel.org>; Fri, 30 Apr 2021 02:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version;
        bh=gAZydTaDrvYCuxeWhkxKvxa0lEgOZYJp4RIwpcZ1OWE=;
        b=kczDehGjfRzb/7HwZY8vgKXMpazrl2mb2XF3PGygSiuD9+S8No2283q0SxLAk9tLiO
         PORxT4X8BDapckpDQTdFxSmF3+RfXTNn7DVllETU3BZPdbe0ez6vNCxotIEI2Qdnpi18
         p2BXORLmAOozG8AFkLVEPE9GMq8VA4/8y3BSHztEFYBT3uFxk05UkfZfcOVl8LIUThvc
         2QUrdPp9j5zRYUX/CLhjWQ4l2p9oNTdH4trcthE3nN6VQE7YcOAeW04QjuD4dasrFAiE
         ypc/4jrdV/WJVwY+qq9sNE/j3VWGsu4FKKtdslKRkC5rFD/ZToQ/J0ueRoNTV5vCvoS0
         hPZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version;
        bh=gAZydTaDrvYCuxeWhkxKvxa0lEgOZYJp4RIwpcZ1OWE=;
        b=ZX+rVpEisSIVKKLYbNsDxQ7BfthVzHw7T92eOx0Les+xCLyoIjTAD9UPV3SBfqFGQB
         Y8W/HUWMbfNYKkA7e26OTrJTWqGF5BxSkx4OUsR830qri6pu+JrtlpSUoS/KsJL4TsoS
         HnmXlMrnMHZopDarFDMWcgX1t0G0DEoKFY4ikZWuANT/i+gRtQLIaKsTpfkDtWvqzaAu
         xemxXFoPx0K879WWMzXx21VAGnPqoQtTL15eHn+pRXXq3A1hzVbSZxmrSpp/0WMEbDxS
         BUuIY9bBA7XcxdJmfWePf8m+1zSzsE68VTqQqunhpSH5V+4bQv13SsKv6HOnWrXTWGs0
         434A==
X-Gm-Message-State: AOAM531yfhFFTrH+nHGsI5ZAyKLCq52GA/T8V3U+tx9yyqBLS0rr015z
        CUi4jTvc1QJdWAgATPqOPoY=
X-Google-Smtp-Source: ABdhPJxjB6zdxM5b0giSegAeeqz8Z5v9jYC10gnH0rE/ufbiUkLRYCPniVUHqhn4jmQ/f2WZqphlyQ==
X-Received: by 2002:a17:906:414d:: with SMTP id l13mr3274942ejk.527.1619776661165;
        Fri, 30 Apr 2021 02:57:41 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id b9sm896322edt.2.2021.04.30.02.57.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Apr 2021 02:57:40 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Luke Shumaker <lukeshu@lukeshu.com>
Cc:     git@vger.kernel.org, Avery Pennarun <apenwarr@gmail.com>,
        Charles Bailey <cbailey32@bloomberg.net>,
        Danny Lin <danny0838@gmail.com>,
        "David A . Greene" <greened@obbligato.org>,
        David Aguilar <davvid@gmail.com>,
        Jakub Suder <jakub.suder@gmail.com>,
        James Denholm <nod.helm@gmail.com>, Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Roger L Strain <roger.strain@swri.org>,
        Techlive Zheng <techlivezheng@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Luke Shumaker <lukeshu@datawire.io>
Subject: Re: [PATCH v3 06/30] subtree: t7900: use 'test' for string equality
Date:   Fri, 30 Apr 2021 11:55:04 +0200
References: <20210426174525.3937858-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-1-lukeshu@lukeshu.com>
 <20210427211748.2607474-7-lukeshu@lukeshu.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.5.12
In-reply-to: <20210427211748.2607474-7-lukeshu@lukeshu.com>
Message-ID: <87r1isxffw.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Apr 27 2021, Luke Shumaker wrote:

> From: Luke Shumaker <lukeshu@datawire.io>
>
> t7900-subtree.sh defines its own `check_equal A B` function, instead of
> just using `test A = B` like all of the other tests.  Don't be special,
> get rid of `check_equal` in favor of `test`.
>
> Signed-off-by: Luke Shumaker <lukeshu@datawire.io>
> ---
>  contrib/subtree/t/t7900-subtree.sh | 60 ++++++++++++------------------
>  1 file changed, 24 insertions(+), 36 deletions(-)
>
> diff --git a/contrib/subtree/t/t7900-subtree.sh b/contrib/subtree/t/t7900-subtree.sh
> index 12b8cb03c7..76183153c9 100755
> --- a/contrib/subtree/t/t7900-subtree.sh
> +++ b/contrib/subtree/t/t7900-subtree.sh
> @@ -28,18 +28,6 @@ create () {
>  	git add "$1"
>  }
>  
> -check_equal () {
> -	test_debug 'echo'
> -	test_debug "echo \"check a:\" \"{$1}\""
> -	test_debug "echo \"      b:\" \"{$2}\""
> -	if test "$1" = "$2"
> -	then
> -		return 0
> -	else
> -		return 1
> -	fi
> -}

It looks like the reason this was used because when this fails just
having the "test" makes for bad debugging. I.e. if the values don't
match the $1 and $2 are not aligned, so it's hard to eyeball what went
wrong.

These days this is more idiomatic:

    echo "Add [...]" >expected
    last_commit_message >actual &&
    test_cmp expected actual

So I think in this case a better narrower improvement would be to keep
the check_equal function. I wonder if we shouldn't just in general in
t/test-lib.sh have a test_cmp_str for this use-case. I.e. a trivial
wrapper that echos the two strings to a file for you, before running
diff(1).
