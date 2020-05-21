Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8D69C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF5120759
	for <git@archiver.kernel.org>; Thu, 21 May 2020 17:54:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AoZ3k2Xy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728635AbgEURyj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 May 2020 13:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727966AbgEURyj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 May 2020 13:54:39 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E21FBC061A0E
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:54:38 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id c3so6157231otr.12
        for <git@vger.kernel.org>; Thu, 21 May 2020 10:54:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HZLUy5bcwAwyIh+MjAecaSZK0AWpMDYqSA48P5EuO8s=;
        b=AoZ3k2XyoD9BDv8E93Ssbvg9/g3yLylQrQK32s4yy0rbjijkoc4+JsEabdPVsmTMD2
         SedNlwDWc4xBwHVFEyIM5p5Y1dJTqAb7ls6YqbAMw3YR6krIN1VNU6CWbtPzBikaHk/0
         ObgvftH7+L1CSwtWzOS5zN1DMMZX4wXcR4F8+2hfbj3iwFArdfhfkKUc84G1W/OeSfBH
         Asl7c1AhmnlKUNnqo8vuWquM4OZU3slua/oLro4ve5yiin4EmEdAaCOf0X8yWLZtz9Ag
         /vyXA1tOMrWC2/PV7f/GJ7I4umvSaoflORjOMNiuGjnLEt5zVCc+Spbe6/taLkFzYOqX
         tbng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=HZLUy5bcwAwyIh+MjAecaSZK0AWpMDYqSA48P5EuO8s=;
        b=MEfr5bFGdCD7tPA8u0hB6jsIRjOCDTC1HSPNhidQxQzKQLZKMQCYxPV0sGiFwibPP0
         IAz7ZNJ3mp4dO0sXmGSGkWPkD6IH/kenqc3CQVOr2u6x4f46PWeSQW6w4zbUOTL3IJLM
         C1AHqgvDufaRtsGdR0Cmp0ygl1oz/hdMAwpLpUyUK0CfONZMHcZS9hp9yiNoVz5AxXdm
         t+V3/KSPDHrsznuJe1so2jXf7cRtGVXcCwnq6Hiaw6a1RxBdXrdNY1mlwBXO83xSIi1K
         B0uXqowWxRNZDB+F7raCRfWpajclpSu1CowmXJRCkWDiVdni5KL2NOhMfZKZIidh3fyk
         F3Uw==
X-Gm-Message-State: AOAM531Xz2+a1XXhKu9nQY36Q0Ir2ZbvY2N99Yd/iEBCUMKEuG4qEquF
        GqQx3bA0J1sZbJCpS8uCIg5zLLwuX2Q=
X-Google-Smtp-Source: ABdhPJxHT9VY+6W2SVtR4inyetFwGZItT/ceuDX1ygA3/ubaUdO0rKbBlp8n+ERGeSPdt6mDghMTEA==
X-Received: by 2002:a05:6830:1292:: with SMTP id z18mr7864418otp.333.1590083678039;
        Thu, 21 May 2020 10:54:38 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id 34sm1754043otq.67.2020.05.21.10.54.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 10:54:37 -0700 (PDT)
Subject: Re: [PATCH 06/10] sparse-checkout: use oidset to prevent repeat blobs
To:     Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Taylor Blau <me@ttaylorr.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.627.git.1588857462.gitgitgadget@gmail.com>
 <fcf948bda7aebcc5f88c17f5b308b2ce0cc285f5.1588857462.git.gitgitgadget@gmail.com>
 <CABPp-BEkf0TVTt4=adJ9x70j814frL932vxyQCpm74AQiHWwGQ@mail.gmail.com>
 <CABPp-BGcjpJOht7ip_cPcHEtd3kx5fCwm=i19narWCEfCUwWAQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <b78b124a-81f2-933a-775d-1d8256e83e05@gmail.com>
Date:   Thu, 21 May 2020 13:54:36 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:77.0) Gecko/20100101
 Thunderbird/77.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BGcjpJOht7ip_cPcHEtd3kx5fCwm=i19narWCEfCUwWAQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 5/20/2020 11:49 PM, Elijah Newren wrote:
> Replying to my own questions...
> 
> On Wed, May 20, 2020 at 9:40 AM Elijah Newren <newren@gmail.com> wrote:
>>
>> On Thu, May 7, 2020 at 6:21 AM Derrick Stolee via GitGitGadget
>> <gitgitgadget@gmail.com> wrote:
>>>
>>> From: Derrick Stolee <dstolee@microsoft.com>
>>>
>>> As we parse the in-tree config files that store the sparse.dir values
>>> used to create an in-tree sparse-checkout definition, we can easily
>>> avoid parsing the same file multiple times by using an oidset on those
>>> blobs. We only parse if the oid is new to the oidset.
>>>
>>> This is unlikely to have a major performance benefit right now, but will
>>> be extremely important when we introduce the sparse.inherit options to
>>> link multiple files in a directed graph. This oidset will prevent
>>> infinite loops when cycles exist in that digraph, or exponential blowups
>>> even in the case of a directed acyclic graph.
>>
>> I'm still not sure if I like the idea of having a mirror dependency
>> structure separate from (and duplicative of) the build code; I'm still
>> mulling that over.
> 
> I mentioned this to a few other buildsystem folks at $DAYJOB.  They
> were strongly opposed to having more than one source of truth, but
> generating the git in-tree sparse values from the official build
> system files, with commit hooks and build system checks to make sure
> they get updated seemed like it'd be fine or not concern them much.

The intention is that these files are "downstream" from the build
system. As the build changes, it would adjust the config files to
tell Git what to do.

>> It's good that you've protected against infinite loops.
>>
>> Is there any reason to prefer swallowing infinite loops rather than
>> warning or flagging as an error?  (I'm not sure, just thinking my
>> questions out loud.)
> 
> The buildsystem folks also reminded me that we have cylic dependencies
> already, and although it's absolutely ugly, it is somewhat forced on
> us by a combination of different external tools that we can't change.
> As such, warnings or errors would be really annoying and we'd be one
> of the ones to want to turn them off.  So drop that idea from me.  :-)

This is more common than one might think!

Thanks for taking a look,
-Stolee
