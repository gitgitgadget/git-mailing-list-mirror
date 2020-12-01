Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0B75C64E7B
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5769821741
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 20:55:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E/JHQ2iU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387632AbgLAUzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 15:55:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725899AbgLAUzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 15:55:42 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2453C0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 12:55:02 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id f12so3032906oto.10
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 12:55:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=OnWszd/fA8Br7R0VADkUDI3hf2mOENhai6ysMFOotAM=;
        b=E/JHQ2iUMBuGD6oOV6tpy/6GMuYeATvByHVnhFhbewTihRj5ChVKCZzA7/RMVbZ11G
         TxceMic6Evr6Ka+/oQ9eEwgGWlNtFifF0u9W431aFJia/asVf5Kdtxim9kzIRF2EoOEw
         /+YbD9byHyAlxvX/kNUoU41ln2KfOGHsrIvkILHWSdem4pUoxrT9YjNCG+aA6Czyleyk
         +2knbgmWW54lM8XI+B1Hu2TkwJ/I0PxnX/Md6ealkIwFMeVOqgko+CiRGwZKQESS20jr
         0/lAArYlBhWpYKeHOzFhO8ddKWOpPNmyaZWq7hBtt0eS9AaRNcZ3VXl+wIWhiTJQbVoj
         GaUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OnWszd/fA8Br7R0VADkUDI3hf2mOENhai6ysMFOotAM=;
        b=nNe4uXPJ0im6ElRTe0rKhfw7jz/q8p8XE3XBqd5rhidyIn1n3QzglOpymTstkLtSTe
         4OwU9ETlaFr9RfueuziCG0Qvz4swCxx4GBeqgG+jQeIBQTtOjvPbirkmMCuhOg6HFNxm
         YCUXPBAWmNSgXgPkdQEYeknKS5MoN6G3P3xlFJNVU/MVa03GJ+ZbwGXVfgy4ViTTSNyU
         p+jsrBD8zIbMX48emDW/amKZPk0HLlshhm+YDvNSoRxr2f1mwoJDC6z0oBgwy4XTughr
         yyor4vSQ7tHWsKgmrk/RrBbbK6MwEI04bcDgaIFGf9wy4afCsfh8WunHRs/9NsTIGPKY
         /hRg==
X-Gm-Message-State: AOAM5301sJQXVSX7KvrK8UAxEFiRHZn1qy1lZVbdbt8iuKRcJqgqroYg
        Jei6lxSUi7MjCXLCc61FnNJPjGyISoZQNQ==
X-Google-Smtp-Source: ABdhPJxpO+Tw0hugv8MbvRzKty6qzXbMZbAYWrjp6j114yzDw/OiMR9V363HZ8NrbrwvCD3EL6RM/A==
X-Received: by 2002:a9d:851:: with SMTP id 75mr3356948oty.102.1606856101391;
        Tue, 01 Dec 2020 12:55:01 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id e81sm169133oia.30.2020.12.01.12.55.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Dec 2020 12:55:00 -0800 (PST)
Subject: Re: t7900's new expensive test
To:     Jeff King <peff@peff.net>,
        Thomas Braun <thomas.braun@virtuell-zuhause.de>
Cc:     Derrick Stolee <dstolee@microsoft.com>, git@vger.kernel.org
References: <20201113050631.GA744608@coredump.intra.peff.net>
 <323fd904-a7ee-061d-d846-5da5afbc88b2@virtuell-zuhause.de>
 <20201116041051.GA883199@coredump.intra.peff.net>
 <1403797985.37893.1606777048311@ox.hosteurope.de>
 <X8YnsGsUl53OKFno@coredump.intra.peff.net>
 <X8YrbDpC9/EjRr95@coredump.intra.peff.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <373f3dfe-828b-430d-b88e-5e23302090cb@gmail.com>
Date:   Tue, 1 Dec 2020 15:55:00 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:84.0) Gecko/20100101
 Thunderbird/84.0
MIME-Version: 1.0
In-Reply-To: <X8YrbDpC9/EjRr95@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/1/2020 6:39 AM, Jeff King wrote:
> On Tue, Dec 01, 2020 at 06:23:28AM -0500, Jeff King wrote:
> 
>> I'm not sure if EXPENSIVE is the right ballpark, or if we'd want a
>> VERY_EXPENSIVE. On my machine, the whole test suite for v2.29.0 takes 64
>> seconds to run, and setting GIT_TEST_LONG=1 bumps that to 103s. It got a
>> bit worse since then, as t7900 adds an EXPENSIVE test that takes ~200s
>> (it's not strictly additive, since we can work in parallel on other
>> tests for the first bit, but still, yuck).
> 
> Since Stolee is on the cc and has already seen me complaining about his
> test, I guess I should expand a bit. ;)

Ha. I apologize for causing pain here. My thought was that GIT_TEST_LONG=1
was only used by someone really willing to wait, or someone specifically
trying to investigate a problem that only triggers on very large cases.

In that sense, it's not so much intended as a frequently-run regression
test, but a "run this if you are messing with this area" kind of thing.
Perhaps there is a different pattern to use here?

> There are some small wins possible (e.g., using "commit --quiet" seems
> to shave off ~8s when we don't even think about writing a diff), but
> fundamentally the issue is that it just takes a long time to "git add"
> the 5.2GB worth of random data. I almost wonder if it would be worth it
> to hard-coded the known sha1 and sha256 names of the blobs, and write
> them straight into the appropriate loose object file. I guess that is
> tricky, though, because it actually needs to be a zlib stream, not just
> the output of "test-tool genrandom".
>
> Though speaking of which, another easy win might be setting
> core.compression to "0". We know the random data won't compress anyway,
> so there's no point in spending cycles on zlib.

The intention is mostly to expand the data beyond two gigabytes, so
dropping compression to get there seems like a good idea. If we are
not compressing at all, then perhaps we can reliably cut ourselves
closer to the 2GB limit instead of overshooting as a precaution.
 
> Doing this:
> 
> diff --git a/t/t7900-maintenance.sh b/t/t7900-maintenance.sh
> index d9e68bb2bf..849c6d1361 100755
> --- a/t/t7900-maintenance.sh
> +++ b/t/t7900-maintenance.sh
> @@ -239,6 +239,8 @@ test_expect_success 'incremental-repack task' '
>  '
>  
>  test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
> +	test_config core.compression 0 &&
> +
>  	for i in $(test_seq 1 5)
>  	do
>  		test-tool genrandom foo$i $((512 * 1024 * 1024 + 1)) >>big ||
> @@ -257,7 +259,7 @@ test_expect_success EXPENSIVE 'incremental-repack 2g limit' '
>  		return 1
>  	done &&
>  	git add big &&
> -	git commit -m "Add big file (2)" &&
> +	git commit -qm "Add big file (2)" &&
>  
>  	# ensure any possible loose objects are in a pack-file
>  	git maintenance run --task=loose-objects &&
> 
> seems to shave off ~140s from the test. I think we could get a little
> more by cleaning up the enormous objects, too (they end up causing the
> subsequent test to run slower, too, though perhaps it was intentional to
> impact downstream tests).

Cutting out 70% out seems like a great idea. I don't think it was super
intentional to slow down those tests.

Thanks,
-Stolee

