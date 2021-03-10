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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86E88C4332B
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 12:41:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5E2A664FE5
	for <git@archiver.kernel.org>; Wed, 10 Mar 2021 12:41:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231286AbhCJMku (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Mar 2021 07:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbhCJMk2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Mar 2021 07:40:28 -0500
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53CE6C061760
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 04:40:28 -0800 (PST)
Received: by mail-ej1-x629.google.com with SMTP id p8so38384613ejb.10
        for <git@vger.kernel.org>; Wed, 10 Mar 2021 04:40:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=w0Vhs4cok7DE4dIbr//fMG5jEVRVkRz7N1CMfIBaiDc=;
        b=Yb8I05mxyR4d85CPej10F4jy6I99gwzodv/kjjkeBWlSd5NdGlKShwhd4PwK0zrGoo
         J2JP45TXYNb6UeoIypLQccvD7z+IUsNvCgdtn1W9puQqlwnlnlEG6sJH+oPTI5Kb2xlW
         Buj920J1toIT0AxxB7SThTF6itQ04mB1aD5yjbl9/bmcHuvjpGkliD9jt/i4OZCaZaGT
         1XOEVVLv+dENrSHICJoUidqBbRNAfw8lKdl7XEhqBmV1IneHlYzJvvcUHVOxoGh2eeqi
         vawZg5cg/MlgTuvnz16y5pg4SREouc6+Hp+BLbijWcYpzkPiwdvUsIF3Wxen+yX2SZWH
         tZMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=w0Vhs4cok7DE4dIbr//fMG5jEVRVkRz7N1CMfIBaiDc=;
        b=e+0mIXenaGVqZcv2E0r7aDtYRk4BohxzORF6ImGmwYFB8aGTkOCDzOUqEywPxOerdN
         iauQIShOLaXAfAnmdwJiXZhQLfVokayUJQJ5AFRno0MKwUPt+ZV9AliJWioDipC0ZWyB
         ri0SA/Pz+Rl2XKjylOooz3UZGjSqq3cRb0rcbwPYD8FF96dtAjh6jO5zcR+GEX6QPEy1
         O7AdA2BU6mV472JMXTx/rS3xiLCs4uZqu7yaM85ihCXMhtjWGcRa1pd6kUkMWFuTIT4d
         Q3YMRYrIgQgfdKPszuuQov7i6V2rjMqukjloc6BI3BFip0h+xZi5MmH0Ts+MUOyU4Vsa
         mJhQ==
X-Gm-Message-State: AOAM533T17Tpr24AM7UEu00NPg3I/anFlaX3Z3diItC9BVP2i9p7Tdn6
        4Wc5lR7bKC89nX8ras/UWBr3Tls8N3PeTw==
X-Google-Smtp-Source: ABdhPJy4k90E/+WrW8ALeSCjSIDUMHcO4dFRgRlEQIG2V5yWH0cWjDmVrNctN2EVXLeN72OdTLwwzA==
X-Received: by 2002:a17:906:f9db:: with SMTP id lj27mr3413457ejb.399.1615380026777;
        Wed, 10 Mar 2021 04:40:26 -0800 (PST)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id h2sm9989931ejk.32.2021.03.10.04.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Mar 2021 04:40:26 -0800 (PST)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: Re: [PATCH v6 16/21] mingw: try to work around issues with the test
 cleanup
References: <pull.31.v5.git.gitgitgadget@gmail.com>
 <pull.31.v6.git.gitgitgadget@gmail.com>
 <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <991b41afa4a83a73f59a72504d269d64d12ecf8f.1548771561.git.gitgitgadget@gmail.com>
Date:   Wed, 10 Mar 2021 13:40:25 +0100
Message-ID: <87zgzbgp1i.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Jan 29 2019, Johannes Schindelin via GitGitGadget wrote:

> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It seems that every once in a while in the Git for Windows SDK, there
> are some transient file locking issues preventing the test clean up to
> delete the trash directory. Let's be gentle and try again five seconds
> later, and only error out if it still fails the second time.
>
> This change helps Windows, and does not hurt any other platform
> (normally, it is highly unlikely that said deletion fails, and if it
> does, normally it will fail again even 5 seconds later).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  t/test-lib.sh | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index f31a1c8f79..9c0ca5effb 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1104,7 +1104,11 @@ test_done () {
>  			error "Tests passed but trash directory already removed before test cleanup; aborting"
>  
>  			cd "$TRASH_DIRECTORY/.." &&
> -			rm -fr "$TRASH_DIRECTORY" ||
> +			rm -fr "$TRASH_DIRECTORY" || {
> +				# try again in a bit
> +				sleep 5;
> +				rm -fr "$TRASH_DIRECTORY"
> +			} ||
>  			error "Tests passed but test cleanup failed; aborting"
>  		fi
>  		test_at_end_hook_

I saw this sleep while reading some test-lib.sh code, doesn't this break
df4c0d1a79 (test-lib: abort when can't remove trash directory,
2017-04-20) for non-Windows platforms?

Your CL for v3 suggests this was only encountered in Azure VMs:
https://lore.kernel.org/git/pull.31.v3.git.gitgitgadget@gmail.com/

Aside from this obscure issue, wouldn't it make more sense to have some
optional "I'm under CI" flag to skip the teardown one test at a time as
we're probably about to shut off the transitory VM soon?

I skip some tests, but the test suite creates ~950MB of trash for
me. Maybe cheaper for some to just keep that around and have it all
removed at the end.
