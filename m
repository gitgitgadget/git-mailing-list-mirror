Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE327C433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:30:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAE56207F7
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 13:30:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LyDM2ByG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726804AbgHLNak (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 09:30:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727050AbgHLNae (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 09:30:34 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B021CC06174A
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:30:34 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id p4so2021791qkf.0
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 06:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=8WslAht57zxv0e5BM9avpRuXSheJjJwmJyxSEOKnNdQ=;
        b=LyDM2ByGlfXgsWLedhjwPDZhs/C6uSTNodvx72Kj8yHCymuoVZTJoY7k2ZhaI0XbcP
         Q5AtkCCSNcR7FWO+MEVa7WL042wMw83eACXV75BSGqe0Tzdf/uhalOiMh6SpXobTRSne
         Ywsp6GdQVAhUgOLKHyjKCKkfGIK5SbIxaqCW0NjllI6CfJqTIZRJNxORfQjjc2IPxWLU
         aFifTUoIa25HK+2E99mb7ZGH1dRwd34w8UCSDfd7Rfo9eqdbdbcYBNI3Voy2CwWrlwKq
         b/Pf8lGz8t4i0Twu0XaSaYeHQliOhMpLr430rfcZfFgnGjlqNRNdpvBfVvpJ5zaPV3VJ
         kjtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8WslAht57zxv0e5BM9avpRuXSheJjJwmJyxSEOKnNdQ=;
        b=HWdTVcQDnAJbt/m+BtPKdpFpSGv+rjcM198tgFMQaSNBdi1etR+j748GRWG0rKsX2a
         BLoiWFC+UEJS+DHogsbJ3Ys8daD0xeq2ZyhPyYZnaSBeQzOt6VTrmUrzVy885InG3QgX
         zlxSneQrmT3lkQtU3fgTskdk+yn2o1SxpLAHd7DhSf14DYINrafdYZk772Xwjfw+SfBc
         f4bl4BbfkdLA4LEQzqz2mcZY+0XsG0R0BmRb1uwjoDXp+OWcl5h9TM/9yQlU/hDDoXth
         aNPbIcKyr3FFohvYDxw2NPMMu1L0UH6jAi5aCatyfisFNuGtHv5sDvoQ52bHvydGNkzn
         Y+5w==
X-Gm-Message-State: AOAM5313hU5AAJi48GM2/p6Wfz04DEWPF/HiuJ/MRCBvFM3tSm1KXaZU
        FdvzuuztA5SX7h4lb60fQQJdt7hT00CSDQ==
X-Google-Smtp-Source: ABdhPJzayplE6egiOGXuqLu5xLL/9efjpxO57A5YXTSUUHmi8F3ABNJgibX0GKGCZcDinANrjp2rlw==
X-Received: by 2002:a37:a09:: with SMTP id 9mr6046142qkk.290.1597239033348;
        Wed, 12 Aug 2020 06:30:33 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14? ([2600:1700:e72:80a0:79ce:9d5a:1dc3:8f14])
        by smtp.gmail.com with ESMTPSA id k31sm2357599qtd.60.2020.08.12.06.30.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 06:30:31 -0700 (PDT)
Subject: Re: [PATCH 05/11] maintenance: add commit-graph task
To:     =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>, sluongng@gmail.com,
        Jonathan Tan <jonathantanmy@google.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.695.git.1596728921.gitgitgadget@gmail.com>
 <902b742032ae19087392538936cc81768a59e0e1.1596728921.git.gitgitgadget@gmail.com>
 <CAN0heSrvJ4nZnMH=CPyNrZTkEXsZm2htT5kzN+RfzPXgXW=oSA@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <0380dcbf-82a0-68d0-b421-9f5c5a640ab5@gmail.com>
Date:   Wed, 12 Aug 2020 09:30:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <CAN0heSrvJ4nZnMH=CPyNrZTkEXsZm2htT5kzN+RfzPXgXW=oSA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/7/2020 6:29 PM, Martin Ågren wrote:
> On Thu, 6 Aug 2020 at 18:50, Derrick Stolee via GitGitGadget
> <gitgitgadget@gmail.com> wrote:
>> diff --git a/Documentation/git-maintenance.txt b/Documentation/git-maintenance.txt
>> index 089fa4cedc..35b0be7d40 100644
>> --- a/Documentation/git-maintenance.txt
>> +++ b/Documentation/git-maintenance.txt
>> @@ -35,6 +35,24 @@ run::
>>  TASKS
>>  -----
>>
>> +commit-graph::
>> +       The `commit-graph` job updates the `commit-graph` files incrementally,
>> +       then verifies that the written data is correct. If the new layer has an
>> +       issue, then the chain file is removed and the `commit-graph` is
>> +       rewritten from scratch.
>> ++
>> +The verification only checks the top layer of the `commit-graph` chain.
>> +If the incremental write merged the new commits with at least one
>> +existing layer, then there is potential for on-disk corruption being
>> +carried forward into the new file. This will be noticed and the new
>> +commit-graph file will be clean as Git reparses the commit data from
>> +the object database.
> 
> This reads somewhat awkwardly. I think what you mean is something like
> "is there a risk for on-disk corruption? yes, but no: we're clever
> enough to detect it and avoid it". So from a user's point of view, I
> think this is too detailed.
> 
> How about
> 
>  The verification checks the top layer of the resulting `commit-graph` chain.
>  This ensures that the maintenance task leaves the top layer in a shape
>  that matches the object database, even if it was ostensibly constructed
>  by "merging in" existing, incorrect layers.
> 
> ? I don't quite like it -- it's a bit too technical -- but it describes
> the end result which the user should care about -- on-disk data is
> consistent and correct -- rather than how we got there.
> 
> Perhaps:
> 
>  It is ensured that the resulting "top layer" is correct. This should
>  help avoid most on-disk corruption of the commit-graph and ensure
>  that the commit-graph matches the object database.
> 
> Don't know whether that's entirely true though...

This is my understanding. We focus on the data we just wrote to see
if anything went wrong at a lower level (i.e. filesystem or RAM
corruption during the write process) instead of the data "at rest".

> Food for thought, perhaps.
> 
> There's something probabilistic about this whole thing: If a low layer
> is corrupt, you might "eventually" get to replace it. I suppose it could
> make sense to go "verify the whole thing, drop however many top layers
> we need to drop to get only correct layers, then generate a new layer
> (and merge and whatnot) on top of that". But the proposed commit message
> makes it fairly clear that this would have other drawbacks and that we
> don't really expect corrupt layers in the first place.

Right. And we want to keep the amount of work to be very small in most
cases, amortizing the cost of the big merge operations across many much
smaller runs. Perhaps a later change could introduce an option to drop
the '--shallow' option and check the entire chain, for users willing to
pay that price.

Back to the point of your comments: I'm not sure this second paragraph
is required at all in the documentation. The first paragraph already
says:

	...then verifies that the written data is correct.

This "written data" _is_ the top layer of the chain. There is probably
no reason to dig deeper into _why_ we do this in this user-facing
documentation.

So, I propose just deleting this paragraph. What do you think?

Thanks for keeping a close eye on documentation changes! I updated
my local branch to include the '+' problem from your other reply.

Thanks,
-Stolee

