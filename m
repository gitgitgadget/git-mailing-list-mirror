Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27A49C433B4
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EE1CB6108B
	for <git@archiver.kernel.org>; Wed,  7 Apr 2021 23:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhDGXGj (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Apr 2021 19:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbhDGXGi (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Apr 2021 19:06:38 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B14BC061760
        for <git@vger.kernel.org>; Wed,  7 Apr 2021 16:06:28 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id l4so30324299ejc.10
        for <git@vger.kernel.org>; Wed, 07 Apr 2021 16:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version;
        bh=89Rc5pVtzeO5DIDH4l4Gdpnod2Q7e/NJzSVXQViJP7k=;
        b=LL/s7e3t0mA6mzO78O7IWpoYqk1MT3/KcVpDPhs/Q3wYQR7gZs/6WvtTZxzgBS51cS
         Y8rxALrB3AEg+e6DrAxDFhNdF1LqbH04HjBiWEhj56UTZ6aaXb2uP16lcv3w17PLSjmc
         jwZPWc5yck0MxGwP412J4YMN6jsxwwoPReK977IH/kqHSUwdcOdwV2CZkaegClydmure
         OROXF50YrX2w3GwcZUyEui6q4txeizfba8dSF/ILVl58Z8DRSsy2gxhRV/zj0XqxMnqZ
         bZyP/aWWOa3rFifbFegwPutNHYP3RpMWIfSuYRM6S69SRrF90D8DeWaUPF3pC2W1kAV6
         /nQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version;
        bh=89Rc5pVtzeO5DIDH4l4Gdpnod2Q7e/NJzSVXQViJP7k=;
        b=YxXsJIWf3aAOwYVePioJ5LC2++6gPKtHhDnFydMAM30dl2nfiLLKyui2OcFCwiICnV
         OJH7x1IgtPlAeYG79if26q60HBzDq2ZeT5JaFD5nZK1QlcJe7QuzwsexWPTQ62pRyaw8
         AbdmXuVhxvNziiU1pENdVNEodzkbDhCTfLTW0NmoAL2T99vlsDH0wUqYKRXG54sVB04N
         gn6NYgsjIGGmcb/M2hs3wutAwssRk2a8xXjK6LZqqezxIhwkOmoI9aFFr1VnRkGsk2St
         FPvwrM2YXFKKDN63XMR/b8eTuE3Ool03n7MRCfptsZ1BTqtGCkiDSfKCeov01s2GTpxf
         mBuA==
X-Gm-Message-State: AOAM531JmS+EmzMRy5DEprZN2f8j5Ny1OIxcCuQRV2TqfnRUjYGcru3S
        WQxxzuRdFU49p3Ht4k3QD9I=
X-Google-Smtp-Source: ABdhPJwvlj3X3I/Vj7kU4SDQ+rmpNx+kKwEu+XlpHHkpc3//Pfze9+qadqaYBdPajplyeuhySyycCQ==
X-Received: by 2002:a17:906:9b08:: with SMTP id eo8mr6694081ejc.284.1617836787250;
        Wed, 07 Apr 2021 16:06:27 -0700 (PDT)
Received: from evledraar (j57224.upc-j.chello.nl. [24.132.57.224])
        by smtp.gmail.com with ESMTPSA id e15sm9565627ejr.66.2021.04.07.16.06.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Apr 2021 16:06:26 -0700 (PDT)
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 6/9] t4013: add tests for log.diffMerges config
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210407225608.14611-7-sorganov@gmail.com>
User-agent: Debian GNU/Linux bullseye/sid; Emacs 27.1; mu4e 1.4.15
In-reply-to: <20210407225608.14611-7-sorganov@gmail.com>
Date:   Thu, 08 Apr 2021 01:06:26 +0200
Message-ID: <87v98xitjh.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Apr 08 2021, Sergey Organov wrote:

> Test that wrong values are denied.
>
> Test that the value of log.diffMerges properly affects both
> --diff-merges=def and -m.
>
> Signed-off-by: Sergey Organov <sorganov@gmail.com>
> ---
>  t/t4013-diff-various.sh | 26 ++++++++++++++++++++++++++
>  1 file changed, 26 insertions(+)
>
> diff --git a/t/t4013-diff-various.sh b/t/t4013-diff-various.sh
> index 275a6790896d..ee4afca06ced 100755
> --- a/t/t4013-diff-various.sh
> +++ b/t/t4013-diff-various.sh
> @@ -460,6 +460,32 @@ test_expect_success 'log --diff-merges=def matches --diff-merges=separate' '
>  	test_cmp expected actual
>  '
>  
> +test_expect_success 'deny wrong log.diffMerges config' '
> +	git config log.diffMerges wrong-value &&
> +	test_expect_code 128 git log &&
> +	git config --unset log.diffMerges

Don't use "git config", but "test_config" at the start, then you don't
need the --unset at the end, it'll happen automatically. Ditto for the
following tests.

> +'
> +
> +test_expect_success 'git config log.diffMerges first-parent' '
> +	git log -p --diff-merges=first-parent master >result &&
> +	process_diffs result >expected &&
> +	git config log.diffMerges first-parent &&
> +	git log -p --diff-merges=def master >result &&
> +	process_diffs result >actual &&
> +	git config --unset log.diffMerges &&
> +	test_cmp expected actual
> +'
> +
> +test_expect_success 'git config log.diffMerges first-parent vs -m' '
> +	git log -p --diff-merges=first-parent master >result &&
> +	process_diffs result >expected &&
> +	git config log.diffMerges first-parent &&
> +	git log -p -m master >result &&
> +	process_diffs result >actual &&
> +	git config --unset log.diffMerges &&
> +	test_cmp expected actual
> +'
> +
>  test_expect_success 'log -S requires an argument' '
>  	test_must_fail git log -S
>  '

