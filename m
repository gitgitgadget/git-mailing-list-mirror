Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7E75C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 12:38:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A42642070A
	for <git@archiver.kernel.org>; Thu, 21 May 2020 12:38:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h5W9ahjL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728222AbgEUMi2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 08:38:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728084AbgEUMi2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 08:38:28 -0400
Received: from mail-oi1-x241.google.com (mail-oi1-x241.google.com [IPv6:2607:f8b0:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C07AC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 05:38:26 -0700 (PDT)
Received: by mail-oi1-x241.google.com with SMTP id j145so6090081oib.5
        for <git@vger.kernel.org>; Thu, 21 May 2020 05:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8qwTrVsn89v2dOWyAhL4w2LZKy8tM77G29bzF/jyi4Y=;
        b=h5W9ahjLqMEuefSnLpH2CM5kj0VYm/DNULww1r0jvxrlfsgBf3Vhem3E3+caFRnQ0L
         MrM7SXoabf0SV9diRMhdzX9b3T+3H8iEjBTy4tVRiNJJDPo+mPFef7wS3I+oRU73JmMd
         gFTjrRMcI11caq9x7tWASW0rdZu8OQBHPIba9zti72OqJlsIrbX90UAxhkF6Ad0P7zbM
         oVLs42kVgcclx3vBAGez4prKEtuAo5fhgEDsWLNxJdSWzbqcU6Vd3GnGqWo3sMiIubk8
         TPfGqeAo7mSCwoxLRiRUPWlFLsQdOf59JH9zKT3b8J46JWhfP7YgKzbqCqeV6ykwqWDa
         fSaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8qwTrVsn89v2dOWyAhL4w2LZKy8tM77G29bzF/jyi4Y=;
        b=FZS9SXavOjFeG84hN2Oz8hLjRkEWy+xdV4Ce8eDjYs2ptWzU83gnK61NWC/oWrtrmq
         Ow6lqb3bPOarBC2IhJsajVTYC03+syZSy2IYhdiAgMHvP5QyJC+Fk88TH8j1gSDw8/4k
         nn5HrrNmFIbXQKi+EqVEzybcF1THam38qC51IXkhkU7RifZgjmked3z6rt3j/m9uRfhA
         8zQDcoWpywhNSfEqEfeNNEGNpD7pgLLrYJzPuXOtN1k3DloEVQzG4DPRRy2cA718xre9
         HqR044HtTyVP6x7byvfBOfWoxmCVMbSL7bD5Z8IFzpYoyUUT5Mw9WR+gOJ8hiB+TDpfa
         +gHg==
X-Gm-Message-State: AOAM533/tuHjF+PyqiQN8d9+1ZrbLH1dsZ1r3sve1RvzLVMqRlcj/HtD
        Hrxhd6QZJTYRihhCxGYMZZc=
X-Google-Smtp-Source: ABdhPJz4ho29/e8hWybgARGojkr4fPcpqF05yLFzMdgyGOxdOJTsQLw8b1fZnTMGLkGJDyqI7r9CEg==
X-Received: by 2002:aca:72ca:: with SMTP id p193mr6807631oic.34.1590064705342;
        Thu, 21 May 2020 05:38:25 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id j6sm14552ots.61.2020.05.21.05.38.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 05:38:24 -0700 (PDT)
Subject: Re: [PATCH v2 0/2] Improve Fix code coverage for checkout
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org
Cc:     Derrick Stolee <dstolee@microsoft.com>,
        Junio C Hamano <gitster@pobox.com>
References: <ef72aedf-4264-e386-9563-050c54483c93@gmail.com>
 <20200521020712.1620993-1-sandals@crustytoothpaste.net>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <d5845a16-df61-0497-5af9-75d0174a0fc1@gmail.com>
Date:   Thu, 21 May 2020 08:38:23 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200521020712.1620993-1-sandals@crustytoothpaste.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/2020 10:07 PM, brian m. carlson wrote:
> Patch #1 reduces the number of options in the scenario which Stolee
> mentioned above.  There's now just a NULL and a non-NULL case, and the
> NULL case is now relatively straightforward and uninteresting.

I'm glad you and Junio were able to simplify this case!

> Patch #2 adds a test for the particular set of options which will
> trigger this case as an independent test.  I didn't think it made sense
> to put this in t0021, since ultimately that set of options isn't about
> conversions and it would seem out of place there, so I put it in t2060.
> 
> I'm ultimately on the fence for this case, because I think it's really a
> corner case and testing this is probably not that interesting, so my
> preference is for us to pick up patch 1 and drop patch 2.  However, I
> added patch 2 in case we do indeed want a test for this, and I'll let
> Junio and others decide on what's best.

I think the test is helpful, since it is not very complicated to set up.

The test you created for t0021-conversion.sh earlier was quite complicated
and required internal knowledge to get going. However, this test only uses
porcelain commands to trigger the conditional.

From the discussion here, it is not obvious that info->commit is ever NULL,
so having the test can prevent a future change from making that same
assumption.

This series is Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks,
-Stolee
