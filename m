Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB786C433E0
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:12:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C7161938
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 11:12:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbhC2LLg (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 07:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231524AbhC2LL2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 07:11:28 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04FE6C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 04:11:28 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id v10so9165874pgs.12
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 04:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:cc:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=sHS07tIYcDIt2QAuoiBoRLCodYBCZa4jEmJUqSLO2RE=;
        b=iXN39/xXsNZG83I7WD6ruMJh5vgQdiKztanK7RObIKjLiVC+bXfPm2PG4AJB8Ffv+d
         Zy8skPyPbBskAaPs3JWbFQe/B7c7b3Y2NqCYTb8kg03jbgBAjxDTCZSLAk5dl1V3ZbJU
         IjFyf/8bua3kJiALdLlJ49gZAszrKfuVSsGp8RxC1CMbumrIc2rpQv1qlTXBoI93Vqsi
         FgdyMcvxh9ozXRlHitXziKzCx4G2yRpSh2R+kefd540nsoYhxDtwpJdmHQp7dL1+V5Nt
         9rBB1rBYNfbfJYhFSj2IWfZx0P9dbSTCIpz4W0LJCi5q2Jxcis/AXIelouMoWDuLK8lt
         fJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:cc:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=sHS07tIYcDIt2QAuoiBoRLCodYBCZa4jEmJUqSLO2RE=;
        b=N3TD3JGKtV5dVr6JsuhufIWejELfK1blU61dahrjd9MPXLrnzqTlSHL7h+X8f5a4Ag
         ioQZeb9K6GK6pDkjaYykSbe3noLUyaIG5n4Z4vVAlPVihJN2KEjOG+6/3YSwLJOGDpux
         KcJ9mY0i4JPEDB6/AIRpiAaGvxf5f8qgjlI5iPT5+n/2nkc5D4bJ7R4sihrUvMDlxmOM
         3zKmidoBoNGREWQlKfpxOFoCSq2p7VPTCbYoUteWrwg+w+AhSLBYjoHhZVIjFKPv6RPp
         vH2cZ4qYKDpatcx2JdL/Q226QwW8H5gSkgfinreP1zcHy+4zpBa0L2lVMEVAORLsCPzD
         nxWA==
X-Gm-Message-State: AOAM531g+qCHMK9Qaad97doJNoUnj7gvzAaUqgikU3FWH84Rh6wmZsaQ
        XGlth/foP5r/lu/S9N1/9pU=
X-Google-Smtp-Source: ABdhPJxRZdBbzEo4o1OLkZDH1LR7YW0Wu01gjm+8Wn2ipEl7DkGSSovqBHMOMCv6yp5e+OCXh9LHqA==
X-Received: by 2002:a63:e1b:: with SMTP id d27mr23536443pgl.135.1617016287645;
        Mon, 29 Mar 2021 04:11:27 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-74.three.co.id. [180.214.232.74])
        by smtp.gmail.com with ESMTPSA id q17sm18360944pfq.171.2021.03.29.04.11.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Mar 2021 04:11:27 -0700 (PDT)
Subject: Re: [PATCH v2] Documentation: updated documentation for git commit
 --date
To:     Chinmoy Chakraborty <chinmoy12c@gmail.com>, git@vger.kernel.org
References: <pull.918.git.1616926790227.gitgitgadget@gmail.com>
 <pull.918.v2.git.1616936099778.gitgitgadget@gmail.com>
 <6a9d24a9-6942-97fc-550f-6b9b61264a78@gmail.com>
 <98c196c4-31ff-4df1-9215-77d115771583@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>
Message-ID: <5f69547a-723c-05d4-e00c-c7a5d6760315@gmail.com>
Date:   Mon, 29 Mar 2021 18:11:25 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <98c196c4-31ff-4df1-9215-77d115771583@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/03/21 13.02, Chinmoy Chakraborty wrote:

> I think initially it was suggested as a joke, but actually implemented
> 
> to demonstrate the ability for users to include their own custom
> 
> time/date periods.
> 
Hmmm...

The commit you mentioned (a8aca418d6484400d6804e22717bd49ca06c28e9)
said that:

>     Thanks for pointing out tea-time.
> 
>     This is also written to easily extended to allow people to add their own
>     important dates like Christmas and their own birthdays.
> 

But it seems like the predefined dates/times were hard-coded, so to extend
--date option to allow more predefined date/times, Git sources need to
be edited.

Maybe we can make git config option (commit.predefined_times [FIXME: suggest
better name]) so user can easily add ones.

Also, I asked to you: can I set --date to arbitrary date (like 09/29/2009
19:59)?

[CC] Junio, what about this patch?

-- 
An old man doll... just what I always wanted! - Clara
