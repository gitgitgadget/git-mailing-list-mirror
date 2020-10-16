Return-Path: <SRS0=w+PN=DX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3BBAC433E7
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 17:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6374920874
	for <git@archiver.kernel.org>; Fri, 16 Oct 2020 17:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rjGeYxXV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732302AbgJPRZJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Oct 2020 13:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731784AbgJPRZI (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Oct 2020 13:25:08 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1DD4C061755
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 10:25:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id q5so3784970wmq.0
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 10:25:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=7oHEZjoxWUgvSdAdG57ic38hqJrOjbcYlbFKoiB55dA=;
        b=rjGeYxXVG99Nb96acU2ZbLpQI6IUZ9fOz4Ul5ggu5fccblen0DkK9pdhY7AcASIxit
         j+7RhfWt4SpokIIIHN25Kar056CThHJLhSq3FFp9tQZoCwAoYcNHRdigfwMb1IFsvGJE
         e400dllJqEAAuhD+omp4Cdr46iYDqlnC/OBhb1okqKlj2QYiAd8c0/KkgnmLMb5hlqAh
         lBq/Re9up/R7mRa4+mTrLUKApbanKLlUbsH+dGH1BVQcnWgYdxQzLPdr965Ldll+gMOC
         zqCzZuZL38++ZGDuI6p5BYqeIJmimP2qOjOTezWDNOPYlYGXDPUXCCDKwtqu6zF3bkF2
         wqDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7oHEZjoxWUgvSdAdG57ic38hqJrOjbcYlbFKoiB55dA=;
        b=rFuDt2X7rJ22YfOMUmBzWk+/sGjB5B9YhSNA6kz87n27de4kqBUupEvGfq+CH6mzCl
         t+ZL6Lcl79aNwFBJXX0B65A9x8r7WcjTEfpnLquCnNY2AuQ99vVrzyiU9Ge9b/oLoonv
         GUB/owGoNGJx9J0QOAI/qxlnQqH6Agv6luwy8dZ4bwK/IODeWyboGEjy35H8DXykfuVq
         TZIdmvM4cqgNmybQQeKuZyf+kMaYoZSo54RFbLip4FsNOax+PzJnqSvWqt5l3/nus4qJ
         ZFNEDJ3Defox9DhvpXOqigvNxnlaC2jdT0eNVlCykz0XFKmI1BlOh7mkgKOppYDDR/7X
         k+QQ==
X-Gm-Message-State: AOAM5327aOoxZVODJ+yrroT92dJ3VKpfVpE6UVjyMsS+Tg+3vXkEanFD
        PoxPHN0EpWn223A9SRVSn3E=
X-Google-Smtp-Source: ABdhPJwTcWT/OVkbIPdv5x53YHoQyqyl3VNc4JKfKJ6iyMg87AckaJrJGxNYfHNqPfpHl7O53JcgFw==
X-Received: by 2002:a1c:9949:: with SMTP id b70mr4913960wme.116.1602869106697;
        Fri, 16 Oct 2020 10:25:06 -0700 (PDT)
Received: from [192.168.1.201] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.googlemail.com with ESMTPSA id n9sm4428763wrq.72.2020.10.16.10.25.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2020 10:25:05 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] sequencer: fix gpg option passed to merge
 subcommand
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?Q?Samuel_=c4=8cavoj?= <samuel@cavoj.net>,
        git@vger.kernel.org,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20201012234901.1356948-1-samuel@cavoj.net>
 <d2491759-e761-647b-7e76-3515b8eeaf3f@gmail.com>
 <xmqqy2k9ixvz.fsf@gitster.c.googlers.com>
 <31ce457b-e71c-0ca0-e5be-a9aebb9cf785@gmail.com>
 <xmqqy2k6cejl.fsf@gitster.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4bbf0055-ed50-6560-7208-dce9378389c8@gmail.com>
Date:   Fri, 16 Oct 2020 18:25:05 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqy2k6cejl.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 16/10/2020 17:37, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> ... Reviewers that only read the patch without loading up the
>> test file in their editor have no indication that the test should be
>> clearing the config variable.
> 
> It is not a review if the code being updated is not checked for
> sanity in its own context, is it?

It is disappointing that you have chosen to cut the original to those 
few lines and reply just to them. The original message made the broader 
point that having to check the previous tests in a file to figure out 
what the state is at the beginning of any new test that gets added makes 
life harder than it needs to be both for contributors and reviewers.

Phillip
