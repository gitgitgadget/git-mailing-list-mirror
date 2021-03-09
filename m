Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0AFEC433DB
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:53:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B17AB65253
	for <git@archiver.kernel.org>; Tue,  9 Mar 2021 20:53:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231863AbhCIUwm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Mar 2021 15:52:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231941AbhCIUwX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Mar 2021 15:52:23 -0500
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B81BC06174A
        for <git@vger.kernel.org>; Tue,  9 Mar 2021 12:52:23 -0800 (PST)
Received: by mail-oo1-xc33.google.com with SMTP id g46so3373991ooi.9
        for <git@vger.kernel.org>; Tue, 09 Mar 2021 12:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=bahsawfpIkRfTO8SakyEN5weTt9pH+avZJPsvl2mH1Q=;
        b=oBkDeQ46uz0v5Sjd2qKDBGSFobLJUvm8Z5sJpT6knUNT+xH3MS9EQq+DipNh26tYpL
         EZcllW4hsZ9ohqqUkgy1ul3PSw8L5k8RsIOmpbhSDuTvi78rMaEasIm8Bw31+fuW0tKO
         0SutWeKAi3GKVbqv51i39ZHBKN4isujWp8zUFzDaoYXvIeLH1Q5eL8GKgjNvyIyjUqNK
         CQ4LVFLvdkkrPuPyJ5U8eZJbhSRKlMyPaQhNdX2d+KFfSMf2IyvIquZFqWTf98/Gn8iI
         u2crkFC6imHocq0Ilxt4tCHQi8WWJ4v9A9ExbMXdokGWg2S3TKB9gTW8WpiP3vSHCwfk
         3d2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bahsawfpIkRfTO8SakyEN5weTt9pH+avZJPsvl2mH1Q=;
        b=e7Doy7eRmyZ/PZWi9KJWTy891/hxZKiY9weL5xoAQjEz+st6rqMG8Wnw5wUQUEGls8
         xSjO4s3eB7hfHze84Bi9Do1Dafunglx5Y6/KqH7Loh0iVNz+xvpu1NTKIj/Dl9EMXMuF
         0tCoM8tf5SH+lSAWjZoLaBLmNerb1ta8YxvQO8fv3GFnBsQrXcagnMwOnDS5vhIxec/N
         zZzSPy/1tZa5dzQQskOpa6a57GrjL2NzEdI2Le2bkeITB0zmG2PVGfM8Ke6Sh5x0WTQZ
         +34+TEXZLCzVwo4r9LMFXNPpE1v8lUVhSMHOlwYuZbUzsmwuaOv8FBpYOHQXnwnnmAC5
         aWPg==
X-Gm-Message-State: AOAM531IFaxByMhv3RtyaS+GmUv91ydmfyUn3Xm6FZ8cyFzUlYkYv0EV
        d55FzQZGs+7ttpDHBGX4Nno=
X-Google-Smtp-Source: ABdhPJwbRmE5O5lFK6EAb5n27RB+1AB0sUawTxdSvSmk1nPtt0AKkWaJKIg9zDvNy7yywC9y3glCuw==
X-Received: by 2002:a4a:3012:: with SMTP id q18mr23723528oof.21.1615323142404;
        Tue, 09 Mar 2021 12:52:22 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:88a7:dd04:71df:86ee? ([2600:1700:e72:80a0:88a7:dd04:71df:86ee])
        by smtp.gmail.com with ESMTPSA id v2sm3100988ota.59.2021.03.09.12.52.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Mar 2021 12:52:21 -0800 (PST)
Subject: Re: [PATCH 16/20] sparse-checkout: toggle sparse index from builtin
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <6d6b230e3318007150aebefebc16dfb8b9b6c401.1614111270.git.gitgitgadget@gmail.com>
 <CAN0heSqPTASn61KKGvWEA3ronaWEPWGP23LUg36JiMxxHEd0zQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <466cb063-0481-cfa6-cc3e-8ca26d73c8fb@gmail.com>
Date:   Tue, 9 Mar 2021 15:52:19 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSqPTASn61KKGvWEA3ronaWEPWGP23LUg36JiMxxHEd0zQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2/24/2021 2:11 PM, Martin Ågren wrote:
> On Wed, 24 Feb 2021 at 00:57, Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> +that is not completely understood by other tools. Enabling sparse index
>> +enables the `extensions.spareseIndex` config value, which might cause
> 
> s/sparese/sparse

Thanks!

 
>> +other tools to stop working with your repository. If you have trouble with
>> +this compatibility, then run `git sparse-checkout sparse-index disable` to
>> +remove this config and rewrite your index to not be sparse.
> 
> While I'm commenting on this..:
> 
> There are several "layers" here, for lack of a better term. "Enabling foo
> enables bar which may cause baz. If you fail due to baz, try dropping
> bar by dropping foo." If I remove any mention of the config variable from
> your text, I get the following.
> 
>  Enabling sparse index might cause other tools to stop working with your
>  repository. If you have trouble with this compatibility, then run `git
>  sparse-checkout sparse-index disable` to rewrite your index to not be
>  sparse.
> 
> I'm tempted to suggest such a rewrite to relieve readers of knowing of
> the middle step, which you could say is more of an implementation
> detail. But if we think that the symptoms / error messages might involve
> "extensions.sparseIndex" or, as would be the case with an older Git
> installation,
> 
>   fatal: unknown repository extensions found:
>           sparseindex
> 
> maybe there is some value in mentioning the config item by name. Just
> thinking out loud, really, and I don't have any strong opinion. I only
> came here to point out the typo in the docs.
 
I agree that the layers are confusing. We could rearrange and have
a similar flow to what you recommend by mentioning the extension at
the end:

**WARNING:** Using a sparse index requires modifying the index in a way
that is not completely understood by other tools. If you have trouble with
this compatibility, then run `git sparse-checkout sparse-index disable` to
rewrite your index to not be sparse. Older versions of Git will not
understand the `sparseIndex` repository extension and may fail to interact
with your repository until it is disabled.

Thanks,
-Stolee
