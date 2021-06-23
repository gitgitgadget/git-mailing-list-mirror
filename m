Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63FDCC2B9F4
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:14:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AEAC60FF1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 02:14:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFWCQX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 22:16:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbhFWCQW (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 22:16:22 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B4E2C061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:14:06 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id j12so960639qtv.11
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 19:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=xBeRTVhKb9WRQjvJbrS23vZt00mGlEqjZhKxzXOG9bI=;
        b=U9fxGtl5B1UCgoeg0TKuGiH5sYoGMVc3GeVUGGuc6TtdyTGqnzrWfkJaDULyOy/L1E
         ORYRZh428ECpe3YELF3PKguKYrCrtqqbxzMhlCAlnY/6g7SDFJKtFQbrXRx3s5rkQUCY
         laOTNlhF2yi3H0p9pgcw528CJw3HxC6DBLSV+FtFBwbHAknrM+JDYNDo0IfQVNdcrMjk
         k1LCZAdEv/XR1VIKbmSXVNOJ2KUo7kNo0UyCmKGEO2u2yErTvkzr2uXC3fb0QCGkbWsh
         nnB8R4g3Es7y/erVZ4XJyCWKP/iffcj/Ukp13P2DCUAL8qSuBAoNes4sOkmMhK9PeuYM
         +xvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=xBeRTVhKb9WRQjvJbrS23vZt00mGlEqjZhKxzXOG9bI=;
        b=mssszMIlXmuqxi/j+b2L0uhcYcPaA3s9w1/XiAv9BskL+j6Wxtzg3kdnoKu9oqgp6Z
         r64l9vB3t15r6QXwF0mcKfVXGA2kdNaj+faG9QCoBFks1xl+NWr/7b0iAY3H2ID6307j
         EupEN+rxPCoulqozFrynWQuVqvmBcm9Zf084ti7fWJymAmiyJeCPig97wKS2bIVQENWh
         g3r2yhTHSN6fmFqVbnS1uhQikEq26rYqAHX9bCbaKgXYQpAkOxTeossYEEaNqn6+FB6x
         kIx5rXSQFdlKE7aXqB6J5NYayyP5sr6HX1PbgyqR+p/uu8ndAoX6pTeGnT+pNoFD9Har
         ey4g==
X-Gm-Message-State: AOAM5339KBX00QccJvGg+2LCtWltBF7yF+Nh28lbXDmAzp8ZDhnZa+sw
        bThSkzoquAMo58qS8M+7M2M=
X-Google-Smtp-Source: ABdhPJyUDhSilkiO4FaArAAv+31fqDT0emCjzH2HRZSbJUMFpwOoBaIbH5HvpT8GCdqlEBJr2jQX0g==
X-Received: by 2002:ac8:4e29:: with SMTP id d9mr1808540qtw.136.1624414445369;
        Tue, 22 Jun 2021 19:14:05 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:4074:43e7:25da:a93b? ([2600:1700:e72:80a0:4074:43e7:25da:a93b])
        by smtp.gmail.com with ESMTPSA id v19sm14395774qkf.42.2021.06.22.19.14.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 19:14:04 -0700 (PDT)
Subject: Re: [PATCH v3 0/5] Optimization batch 13: partial clone optimizations
 for merge-ort
To:     Elijah Newren <newren@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <dstolee@gmail.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.969.v2.git.1623796907.gitgitgadget@gmail.com>
 <pull.969.v3.git.1624349082.gitgitgadget@gmail.com>
 <3a397e04-88a1-1205-a465-75dc2fd7e93d@gmail.com>
 <CABPp-BH9vy3otHvAxR2T6JmVKtH2+EKj-A7NxGsuoqnZA_Bykg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <8f1edc60-f754-541b-1d66-7f5ec49eff55@gmail.com>
Date:   Tue, 22 Jun 2021 22:14:03 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <CABPp-BH9vy3otHvAxR2T6JmVKtH2+EKj-A7NxGsuoqnZA_Bykg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/22/2021 2:45 PM, Elijah Newren wrote:
> On Tue, Jun 22, 2021 at 9:10 AM Derrick Stolee <stolee@gmail.com> wrote:

I want to focus on this item:

>> 2. I watched for the partial clone logic to kick in and download blobs.
>>    Some of these were inevitable: we need the blobs to resolve edit/edit
>>    conflicts. Most cases none were downloaded at all, so this series is
>>    working as advertised. There _was_ a case where the inexact rename
>>    detection requested a large list of files (~2900 in three batches) but
>>    _then_ said "inexact rename detection was skipped due to too many
>>    files". This is a case that would be nice to resolve in this series. I
>>    will try to find exactly where in the code this is being triggered and
>>    report back.
> 
> This suggests perhaps that EITHER there was a real modify/delete
> conflict (because you have to do full rename detection to rule out
> that the modify/delete was part of some rename), OR that there was a
> renamed file modified on both sides that did not keep its original
> basename (because that combination is needed to bypass the various
> optimizations and make it fall back to full inexact rename detection).
> Further, in either case, there were enough adds/deletes that full
> inexact detection is still a bit expensive.  It'd be interesting to
> know which case it was.  What happens if you set merge.renameLimit to
> something higher (the default is surprisingly small)?

The behavior I'd like to see is that the partial clone logic is not
run if we are going to download more than merge.renameLimit files.
Whatever is getting these missing blobs is earlier than the limit
check, but it should be after instead.

It's particularly problematic that Git does all the work to get the
blobs, but then gives up and doesn't even use them for rename
detection.

I'm happy that we download necessary blobs when there are a few
dozen files that need inexact renames. When it gets into the
thousands, then we jump into a different category of user experience.

Having a stop-gap of rename detection limits is an important way to
avoid huge amounts of file downloads in these huge repo cases. Users
can always opt into a larger limit if they really do want that rename
detection to work at such a large scale, but we still need protections
for the vast majority of cases where a user isn't willing to pay the
cost of downloading these blobs.

Thanks,
-Stolee
