Return-Path: <SRS0=lBg5=3Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 084F6C352A2
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:19:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CCDE422314
	for <git@archiver.kernel.org>; Wed,  5 Feb 2020 15:19:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hrSddb8g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgBEPTW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:19:22 -0500
Received: from mail-qk1-f195.google.com ([209.85.222.195]:45994 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726534AbgBEPTV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Feb 2020 10:19:21 -0500
Received: by mail-qk1-f195.google.com with SMTP id x1so2127414qkl.12
        for <git@vger.kernel.org>; Wed, 05 Feb 2020 07:19:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=o0lMgfRJtXZDsveOHHOSYlGAv1i1AGUnWvXNT6pLPpI=;
        b=hrSddb8gssYha5muc71A4lo7EWGW3nYM/whTRHrLpHuQu3dnlsXYS7oatLWYVIdw0H
         r+Q6hSVHuxruQ+6MKQOdAAM97kCBvXPJx1KIy8xE4Nrqqnzws066mrUGC0fyww51TM2t
         2MLL0hxeDy7RzkD33hFWKJxeaG92T8ewXIoB/SYJ94HA1EyEfvxehUeMTidz4CLbPewU
         QPhaI/bXwJlxQLyhbstgv9ggmb5oehExQT45YSLfXaO1wevqgxTTRMTnX8MXksjmnZV5
         r5WBcCYmKMZK35zoCmgRGb/mCf+GF/CmqzheOZ4/+wTIuZe5EZ6i68goN15105/KpMmC
         YtIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=o0lMgfRJtXZDsveOHHOSYlGAv1i1AGUnWvXNT6pLPpI=;
        b=HzFq5bC2OFBppx3CVM8AKvE8663fMFUiThwHAU3IfB9lCj4yP/XtgEkzEYoLeg8dXB
         oljvE6rAt8WPiLbb/T5jrr/ajPODtxM0tYdwYmnhD8QURz4zPuUIJL/TgKV22yYIKkci
         XpP4XkhkYGm0K/cldg6NQecYR8Zdm3wqUBZRM32B3wf+QsNjfsFJFH9wB+52/38D4cGp
         a9fNQPYDAUYcTD4wVKKF1YwFaBVk2Tn9XTGO3IUFw2bLmtaix+wivKkFzafuRgPnrHeL
         KIn9Br2549jyVow6ogy1mFdgQbNMEpjbiJB/04iKMsJjJ8MbwCahn1kiUuNPM7eK5YxE
         zcog==
X-Gm-Message-State: APjAAAVJ/xzSmF42gOjc5aMP4GNBXfOEarRCiALIOntz2z0B5dLhKXON
        fXMe60o/i7I4Z2Jfk76qI2E=
X-Google-Smtp-Source: APXvYqz3Koy+LjFcVShzcQXVrEo5eTCXdH66Hdrsz4VCEzTKoGQn64Ari66voMT5fQvACcQgo4JBnA==
X-Received: by 2002:ae9:e901:: with SMTP id x1mr31959198qkf.117.1580915960860;
        Wed, 05 Feb 2020 07:19:20 -0800 (PST)
Received: from ?IPv6:2001:4898:6808:13e:c9b5:7cd5:1ee4:5066? ([2001:4898:a800:1010:7aeb:7cd5:1ee4:5066])
        by smtp.gmail.com with ESMTPSA id c186sm7333217qke.124.2020.02.05.07.19.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:19:20 -0800 (PST)
Subject: Re: [PATCH 10/10] name-rev: release unused name strings
To:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git Mailing List <git@vger.kernel.org>
Cc:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
References: <084909f8-fefa-1fe0-b2ce-74eff47c4972@web.de>
 <4eddc458-6294-9b9c-857b-50ba484a7168@web.de>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <35b282f8-c3a9-e7e3-5ea8-0542e7ce24ac@gmail.com>
Date:   Wed, 5 Feb 2020 10:19:16 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:73.0) Gecko/20100101
 Thunderbird/73.0
MIME-Version: 1.0
In-Reply-To: <4eddc458-6294-9b9c-857b-50ba484a7168@web.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/4/2020 4:26 PM, René Scharfe wrote:
> The runtime actually increases slightly from:
> 
> Benchmark #1: ./git -C ../linux/ name-rev --all
>   Time (mean ± σ):     828.8 ms ±   5.0 ms    [User: 797.2 ms, System: 31.6 ms]
>   Range (min … max):   824.1 ms … 838.9 ms    10 runs
> 
> ... to:
> 
> Benchmark #1: ./git -C ../linux/ name-rev --all
>   Time (mean ± σ):     847.6 ms ±   3.4 ms    [User: 807.9 ms, System: 39.6 ms]
>   Range (min … max):   843.4 ms … 854.3 ms    10 runs
> 
> Why is that?  In the Chromium repo, ca. 44000 free(3) calls in
> create_or_update_name() release almost 1GB, while in the Linux repo
> 240000+ calls release a bit more than 5MB, so the average discarded
> name is ca.  1000x longer in the latter.
> 
> Overall I think it's the right tradeoff to make, as it helps curb the
> memory usage in repositories with big discarded names, and the added
> overhead is small.

I agree this trade-off is worth it. Your reasoning for why it is
happening makes sense, too.

> +	if (is_valid_rev_name(name)) {
> +		if (!is_better_name(name, taggerdate, distance, from_tag))
> +			return NULL;
> +
> +		/*
> +		 * This string might still be shared with ancestors
> +		 * (generation > 0).  We can release it here regardless,
> +		 * because the new name that has just won will be better
> +		 * for them as well, so name_rev() will replace these
> +		 * stale pointers when it processes the parents.
> +		 */
> +		if (!name->generation)
> +			free(name->tip_name);
> +	}

And here, this idea of "still be shared with ancestors" is confusing
without the additional context that the name-rev algorithm is using
depth-first-search to find the "best" name. At this point, we are
trying to replace the existing name with a better one, and use
"generation == 0" to declare "I am the initial owner of tip_name".
The rest of the ancestors will replace their tip_name pointer with
the new name, all while not accessing this freed memory.

Keeping such dangling references to freed memory is certainly
dangerous, but these references are short-lived within the name_rev()
method. That limits the possible ways this could cause issues in
the future.

Thanks,
-Stolee

