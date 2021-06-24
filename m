Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433CBC48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 04:22:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10F32613CB
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 04:22:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229464AbhFXEZK (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 00:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbhFXEZK (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 00:25:10 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC31CC061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 21:22:50 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id bb20so2706872pjb.3
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 21:22:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=eqOhn0oSFyr7vppy8NzzLe+OnrJnZVvKlRtanhtMONk=;
        b=jBUa5nq3woJ8+iArbiCsN3nL5M2vugCK8MSwnUv4c/upWVc14kTy3VcMqaxL/iZ1DK
         2rXMFqDi4lG3vpXGuCz3RN250zltwXha/iUTpRqO0KWwnkDtsSDJxs7i1PiQIbLez2vJ
         8l2/HOxFdGJ/sskVAJZKMMZLOoiFF3xR2b+oG+aJIlFnzHgHnK9rq7H0+Nn3Ui8YizjO
         RZmZ9Vn2wIFewlnqx+EhqXEeh1BYWTWGFbXWE62qA8SDd007hkXDu4YBXcSsMxX93Zh5
         EPVUnMfrK6qe2VCva6FfR7fftMSeBXnhLVHyuB1SNT+vlIcJFVwa4pA88EbdY/YzGsvm
         +0GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=eqOhn0oSFyr7vppy8NzzLe+OnrJnZVvKlRtanhtMONk=;
        b=OJ3UXYWtQb4NnpKTj7IuWlN/tsIvqIPtAy+WYz+sYmo73+Jtzh8eS1WGtwC/tlsVSk
         WZN7v1nzEdjb0mLWuriCm5Jw8x/d4hjEJrT7S/A6+S6etEEZuO8IsN9UUf1NGJIaVGoI
         mmtggkppc1DYo53GRBVhLyOexh6ONDdj0F9YT5Z6iWjsEk9yjaEfuAduTSV01BDeCpNV
         GYHOa2FjGYcI/XBEF7p6TMnr9RcU18UCQzhSnM3rRQ9hzJIhTzOz/7rx+1GISjtluMJA
         CWWTK88DWQF2B3Gw8fhjwhXJbDWZpM5wEJQptVeVHhruO1vlKfqFE2tcuQ7COdBungOQ
         7uyQ==
X-Gm-Message-State: AOAM533ZC2pjcO7fRjIRP5wHfps9oM2WyY/0HZkOqaj6vYa9f1eG9Luk
        doM34UwW3cr45moN9nmV+3s28kwAY9o=
X-Google-Smtp-Source: ABdhPJxFpzeoUMOK0kCfe5x5Br/Wz0JReZ4knxXrAeYbDF4XUH1ga7/xQ/HeZKApzarMPSUheeIMhw==
X-Received: by 2002:a17:90a:c002:: with SMTP id p2mr12724614pjt.132.1624508570254;
        Wed, 23 Jun 2021 21:22:50 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-70.three.co.id. [223.255.225.70])
        by smtp.gmail.com with ESMTPSA id u20sm1236926pfn.189.2021.06.23.21.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Jun 2021 21:22:49 -0700 (PDT)
Subject: Re: [PATCH 4/4] midx: report checksum mismatches during 'verify'
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     peff@peff.net, dstolee@microsoft.com
References: <cover.1624473543.git.me@ttaylorr.com>
 <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <dab8eb4a-3e8e-ea3f-20ba-5164655841f2@gmail.com>
Date:   Thu, 24 Jun 2021 11:22:47 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <94e9de44e3b52513c5ab48aecd74f809dc34cbe3.1624473543.git.me@ttaylorr.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 24/06/21 01.39, Taylor Blau wrote:
> But it does not check that the file's trailing checksum matches the data
> that it records. So, if an on-disk corruption happened to occur in the
> final few bytes (and all other data was recorded correctly), we would:
> 
>    - get a clean result from 'git multi-pack-index verify', but
>    - be unable to reuse the existing MIDX when writing a new one (since
>      we now check for checksum mismatches before reusing a MIDX)
> 
> Teach the 'verify' sub-command to recognize corruption in the checksum
> by calling midx_checksum_valid().
...
> +	if (!midx_checksum_valid(m))
> +		midx_report(_("incorrect checksum"));
> +
...
> +test_expect_success 'verify incorrect checksum' '
> +	pos=$(($(wc -c <$objdir/pack/multi-pack-index) - 1)) &&
> +	corrupt_midx_and_verify $pos "\377" $objdir "incorrect checksum"
> +'
> +

We're in the context of checksum mismatches because of on-disk 
corruption, so why didn't the message say "incorrect checksum, possibly 
corrupt"?

-- 
An old man doll... just what I always wanted! - Clara
