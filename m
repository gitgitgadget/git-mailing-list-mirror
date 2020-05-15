Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC984C433E0
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:44:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A714A2074D
	for <git@archiver.kernel.org>; Fri, 15 May 2020 10:44:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fi23onUm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728347AbgEOKoA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 06:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728013AbgEOKn7 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 06:43:59 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EC64C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:43:59 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 63so1522144oto.8
        for <git@vger.kernel.org>; Fri, 15 May 2020 03:43:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=izkREKZnZCMJHOMwoe4vx3oPCXoMb3tg8Qyr6GapkmM=;
        b=fi23onUmebVRnvt+srOnJDQ/AgM4v/ZZQgwLLxUEt/mm1z7FOOPs6Mu3LBFQxSfCIb
         d0hMWVs+Y1T7KsTww5t7rCthzpgzSjMZoVCKXUPJT8R/f8frSPAXBPnhwYoh7R8//xs4
         kKM9u/GxnQ0Egv/vb59lxTrzUMj6Eq2LePEc5QrGjIRSMFU748pLaL0DfZlrZPDI4AgB
         x6k+TsbJZrtMhuGxrkhTTY4akJt1HYuH+Gn6dcs5aDYFF4i9ijc/fNKu/5eL6RofTzK+
         +WxjZzz6zzZM2DpLpbmwu+/+D1yn5ZuagWu9T5ReTd+gu/95H1blYd9JOXoUsyEXfla6
         +PqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=izkREKZnZCMJHOMwoe4vx3oPCXoMb3tg8Qyr6GapkmM=;
        b=Utr1gWGzFDSxmgTnZ4mQERvRJoF+y6JRzfxhWMV3ZYyO1AzGbUZEz4VT97t8SdPPQl
         OuXc/qdQwLv74KnBedyAWIRMyY8lFZLViGa/9EmzJnRTzgFEJk6+oe9S6/lrADPmH+R3
         /tEmeod9/fFABhcni1r6P5geUeLEB+MZ4+7u4Z9j4XCALItTAAJU/pbNlvPBu9gpv0xU
         PzF64q8HCRYFYEp+11PWaMo047stU9QwwXM5gZdCHdFXqKxJ7i1F5fYhR0Ib+t1dBL4y
         M7h+rVd49s8IDLHutuHesJri9VOsH/e8mEH19L/uz9gzmmLGOy1fOMPQ/SJhS9koWFJ6
         W3BA==
X-Gm-Message-State: AOAM532mL2S/56H9U83WJ8xlpJGGKLdUqmfW/8hHa6/AYmZ5fLJ62gU7
        cwhRMLZv2zhQm6F1v7n/CKE=
X-Google-Smtp-Source: ABdhPJztEe/2R3zHFJjCN3ZsRivTa94mChjQRKwIH4r6nBQG8p9Jj5tduk81bqQY3tvxzf2UQVkX9Q==
X-Received: by 2002:a9d:883:: with SMTP id 3mr1700706otf.344.1589539438841;
        Fri, 15 May 2020 03:43:58 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id e4sm491051oou.33.2020.05.15.03.43.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 03:43:58 -0700 (PDT)
Subject: Re: [PATCH 00/13] upload-pack: use 'struct upload_pack_data'
 thoroughly, part 1
To:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
References: <20200515100454.14486-1-chriscool@tuxfamily.org>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <2860708f-2719-50b1-f1ae-7fd9c0538c52@gmail.com>
Date:   Fri, 15 May 2020 06:43:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <20200515100454.14486-1-chriscool@tuxfamily.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/15/2020 6:04 AM, Christian Couder wrote:
> In the thread started by:
> 
> https://lore.kernel.org/git/20200507095829.16894-1-chriscool@tuxfamily.org/
> 
> which led to the following bug fix commit:
> 
> 08450ef791 (upload-pack: clear filter_options for each v2 fetch
> command, 2020-05-08)
> 
> it was agreed that having many static variables in 'upload-pack.c',
> while upload_pack_v2() is called more than once per process, is very
> bug prone and messy, and that a good way forward would be to use
> 'struct upload_pack_data' thoroughly, especially in upload_pack()
> where it isn't used yet.
> 
> This patch series is the first part of an effort in this direction.
> 
> While there are still a lot of static variables at the top of
> 'upload-pack.c' after this patch series, it does a lot of ground work
> and a number of cleanups.

The patches here are carefully organized to make review easy. Thanks!

I was surprised to see how many local or static variables you were able
to remove using members that already existed in 'struct upload_pack_data'.
That made the changes here particularly easy to trust.

Reviewed-by: Derrick Stolee <dstolee@microsoft.com>

Thanks,
-Stolee

