Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA570C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:37:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A653C60240
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 13:37:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbhCONhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 09:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbhCONgx (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 09:36:53 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDBDBC06174A
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:36:52 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id r24so6983324otp.12
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 06:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H0IHIslo2ui2Lqa6gDYwy9G475HuOopPqRo75aMoLds=;
        b=hR5onX65HIBa5Ec3AbPREe3CK25/L3n2kSmo+nvwIbPilHQo+NIvNgl3POsXOQUz6W
         SZyPB+RGg2Q9oZ+xcNY8Gc8MXMwuupxYC4WyBN11J+TBrXSBVVSZafYW0dexPNJ/Lh+g
         ZMKU3nTrkAF2c+0Ux6Xncnyy4bR5h/nh07XpWRuS8venOS80t1aZ0Wkv3SKzbP+wATli
         OOg40uhbqnA2gm961g4Mal+vKPyqMepvqyO4IR8vA34S7ezppt8axH060hyX8Vi2FKpv
         8M1MV9kVYwfZkv3fR17mL71/Dr92gxOREFFHO/rabAy30t8Gzp0NoMvV4Onwz68ecwrQ
         RYcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H0IHIslo2ui2Lqa6gDYwy9G475HuOopPqRo75aMoLds=;
        b=IRGADfFzYHZM3CeBmR8OPI4wogXXw19NPKUxYvseJgVwZsbD9D2qKn9SGMpOi8BTNR
         a7qIeKMJS1B4q7Jdb/CV0Om2NEpDfGPc472sgiu1jGh2EcDBTZ1W4PtKeaLDpet9XCMw
         VeE9LcLIclyg2Vqag70aVMYUGeTBDUAX8BhcgP6JDRRWdb9k1F2q0k2h9B+trtc4NKxo
         VNoKVl7KE8k1v8sB0PD4Hu9cksiYB23okOIQwiiLSnCozAabWv2goCkUbJCnmnCQm6sL
         PkF03e53Hnx6z8FDry3RbrWgawzLaMdX3E0o4DBQB5TIZXBQ5AvgkaYJo0lMWoaFJXlc
         G3mg==
X-Gm-Message-State: AOAM531fMCCDf/K/gTlhjsU5auT+G77V1szXcn7wY+EpgjIDqoi0U+p7
        L1K7a4KWWpXB6FCFRyyXTYo=
X-Google-Smtp-Source: ABdhPJxRNgqvawe1VtMsHJOMRpiLxmvuqhKEOM5h5ybpDULHsFGDf+gTrXhZjJAsBQ2pz+JdsWiiHA==
X-Received: by 2002:a05:6830:802:: with SMTP id r2mr13960402ots.110.1615815412208;
        Mon, 15 Mar 2021 06:36:52 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:44e0:e2f9:fa7e:56fa? ([2600:1700:e72:80a0:44e0:e2f9:fa7e:56fa])
        by smtp.gmail.com with ESMTPSA id 3sm7295369otw.58.2021.03.15.06.36.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Mar 2021 06:36:51 -0700 (PDT)
Subject: Re: [PATCH 16/20] sparse-checkout: toggle sparse index from builtin
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>
Cc:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Elijah Newren <newren@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= =?UTF-8?Q?_Duy?= 
        <pclouds@gmail.com>, Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.883.git.1614111270.gitgitgadget@gmail.com>
 <6d6b230e3318007150aebefebc16dfb8b9b6c401.1614111270.git.gitgitgadget@gmail.com>
 <CAN0heSqPTASn61KKGvWEA3ronaWEPWGP23LUg36JiMxxHEd0zQ@mail.gmail.com>
 <466cb063-0481-cfa6-cc3e-8ca26d73c8fb@gmail.com>
 <CAN0heSpu7mWCXTu3qUKN1VEiH3rqHpstEU_k1LktNhV-z8b2pQ@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <03e4b93d-cba7-1ee4-e22e-d3c5a5d56175@gmail.com>
Date:   Mon, 15 Mar 2021 09:36:50 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAN0heSpu7mWCXTu3qUKN1VEiH3rqHpstEU_k1LktNhV-z8b2pQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/14/2021 4:08 PM, Martin Ågren wrote:
> On Tue, 9 Mar 2021 at 21:52, Derrick Stolee <stolee@gmail.com> wrote:
>>
>> I agree that the layers are confusing. We could rearrange and have
>> a similar flow to what you recommend by mentioning the extension at
>> the end:
>>
>> **WARNING:** Using a sparse index requires modifying the index in a way
>> that is not completely understood by other tools. If you have trouble with
>> this compatibility, then run `git sparse-checkout sparse-index disable` to
>> rewrite your index to not be sparse. Older versions of Git will not
>> understand the `sparseIndex` repository extension and may fail to interact
>> with your repository until it is disabled.
> 
> I like it. I find this easier to read than the previous version. That
> said, is `git sparse-index sparse-checkout disable` really the way to do
> this? I don't see a "sparse-index" subcommand of git-sparse-checkout.
> ... Hmm, no, after building and installing your patches, I get
> 
>   $ git sparse-checkout sparse-index disable
>   usage: git sparse-checkout (init|list|set|add|reapply|disable) <options>
> 
> Should that be `git sparse-checkout init --no-sparse-index`? I just
> tried that on a fresh, empty repo. It seems to work in the sense that it
> drops the config item. I'm guessing re-initing a sparse checkout is a
> safe and sane thing to do?

Yes! Sorry I missed updating this instance when changing the
design. Your suggestion is indeed the proper way to disable the
sparse-index.
 
> I don't find any tests for this. If re-initing should be ok and in
> particular if it should allow toggling the use of sparse index, it might
> be good having a test. At a minimum to see that the command passes and
> that the config item goes away? And check that the actual index is
> rewritten back to the "old" format? (Sorry if you have that already and
> I'm just bad at finding it.)

We have tests already that 'git sparse-checkout init' will preserve
existing sparse-checkout patterns.

I should definitely have a test to ensure that '--no-sparse-index'
rewrites the index to be a full one. Thanks!

-Stolee
