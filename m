Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FD69C433EF
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 03:51:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DB7CC60F38
	for <git@archiver.kernel.org>; Sun, 12 Sep 2021 03:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232720AbhILDwy (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Sep 2021 23:52:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231939AbhILDwx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Sep 2021 23:52:53 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 691BDC061574
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 20:51:40 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d18so3661459pll.11
        for <git@vger.kernel.org>; Sat, 11 Sep 2021 20:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=2CnLmwE3SilmEzZok06mYgb1q0ZEIs89iHj7zIIAYV8=;
        b=BkCD5HFtLzthxxa35XuIbC9L2ZvWTf6gROpNBXwhe8V75axa89krJUsBHOxDwU6DVt
         W5KE6Iqg34FAqsAtBrTr1Kyadl4ZRq+EFvrqTW+YQhhQtdK1LJmRiOMLkEFaqxAupo7m
         SbAVeRVbVMs+rAlY+/IcyQywGetLuWbPSeULptdSmzQMPY/1s2tjkOXNNWyIuaiClVAw
         WLMnv3EWb1IATVmZTA9Lek99siljQtFUoLJVanftuaHA5nYt2FxaaWE9AjgqV2iCZkLV
         QowE2RlAZtPF71h1334iDmUK3RLCbZ93LrxrJrNcUrExRM60GXOlBY7vUrykzysLEzfZ
         XfPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=2CnLmwE3SilmEzZok06mYgb1q0ZEIs89iHj7zIIAYV8=;
        b=ze3LSS6nRknT8I/f40tAnXI8d2lNzRrKTfVbkiJTG/VVbLWi5uUk7qC/XqgvXTssu7
         ZQNe9Bn+D7Z00pzYsuBduaHWrM2v5XVXS/gXkzWCwzld3IZboBKx6pfjRoG4rZh6ayQ3
         bDfV65UOpfeDag8O+aLR1Axo2TgXUUDZN3u1aJHa8//9a8/L1532Lkkfs4hr0AMeha42
         0O/5bUtEa14+lZOaZ7pSfhppNBtEqK2d2MyPmtPu9lwx4P7cMlZb5BWrgahpPMhhGtD2
         4qUNTAI4p7MjPsf+UlzBz9Vq6HUIQW+V/1AqGoG0ieyIS1KYiPXfN+p4ksUtxhKOd30e
         GovQ==
X-Gm-Message-State: AOAM533u5Px3OeaAZcBKet77TnAKETx25IdOtJOBEk3DCxEaFfJlA/nU
        ZKKO8/cvBbm2+LT47C65l2s2tYmRrW4=
X-Google-Smtp-Source: ABdhPJw61ruCpCs093V6YKerwW5XfM9JbVc8DBO+o78I0CJqeXwNDh/fblZbbfT953k6w0l3Ch58Mg==
X-Received: by 2002:a17:90a:1a19:: with SMTP id 25mr5809028pjk.227.1631418699461;
        Sat, 11 Sep 2021 20:51:39 -0700 (PDT)
Received: from Derricks-MacBook-Pro.local ([2600:6c5e:517f:f73e:c13a:5a43:8d62:620f])
        by smtp.gmail.com with ESMTPSA id p18sm3505815pgk.28.2021.09.11.20.51.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Sep 2021 20:51:38 -0700 (PDT)
Subject: Re: [PATCH v2 0/5] packfile: use oidset for bad objects
To:     Taylor Blau <me@ttaylorr.com>
Cc:     =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
References: <4a702bfe-afd0-669a-c893-0262289c24b8@web.de>
 <e50c1465-59de-7fe1-de01-800404c7640e@web.de>
 <9cdf54db-132e-d771-e177-6673f7ad02bf@gmail.com>
 <YT1dCAuCE7xIIIk/@nand.local> <YT1l75uQ50e2IaXM@nand.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <4d76db59-e049-32c3-c4dd-ab7f70cbc20b@gmail.com>
Date:   Sat, 11 Sep 2021 23:51:36 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <YT1l75uQ50e2IaXM@nand.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/11/21 10:29 PM, Taylor Blau wrote:
> On Sat, Sep 11, 2021 at 09:51:04PM -0400, Taylor Blau wrote:
>> On Sat, Sep 11, 2021 at 07:59:40PM -0400, Derrick Stolee wrote:
>>> I initially hesitated to support the drop of
>>> nth_midxed_pack_entry(), since it was designed with things
>>> like midx bitmaps in mind (specifically, to also support
>>> lex-order-to-stable-order conversions).
>>
>> I didn't know that nth_midxed_pack_entry was designed with either
>> purpose in mind, since it predates midx bitmaps by quite a bit.
> 
> Thinking on it more, I can imagine that you wrote this function
> aspirationally envisioning something like MIDX bitmaps. And since you
> and I discussed the design together quite a bit, I imagine that that's
> the case ;-).
> 
> But I agree that after reading this series again, that the inline-ing
> suggested makes sense (and doesn't conflict with any series I have in
> flight which don't add any new callers).

I'm thinking more to my original design of the multi-pack-index.
At that time, I was thinking about the possible integration
with bitmaps based on my experience in other systems which used
a stable object order to allow writing bitmaps asynchronously
with respect to the multi-pack-index write and object packing.

One thing that you did when first considering bitmaps over the
multi-pack-index was to demonstrate that a stable object order
is not required, which surprised and delighted me. It greatly
reduced the complexity of the problem, and being able to inline
this method is only one small fallout from that simplicity.

Thanks,
-Stolee
