Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13B57C433DF
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 14:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E87222054F
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 14:53:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PCqNa91Q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727866AbgH0Oxw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727863AbgH0NP7 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 09:15:59 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59542C06121B
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 06:15:58 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id o12so5738495qki.13
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 06:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PfKa/v5U6FMVPvXJmgP6FpiQlSaYGckxVuFddgrtR1g=;
        b=PCqNa91QbFlcNO0sxxA6f4SVD3S0jaMfreAM6hAoV9bMqMYif/HsZfnmCuGiweMerB
         UUpd6iyGEkm7UyRr+91Zqa0uGneEnlDzDX7VeH1jkTAobqOn41b7UGZCXa1Yfs+V+N2/
         tYDhfYEE+j0D76pmMS2z+lADvyJ5ltj5m7mrrmYSWtg3v6sNHsp9Vkuz8ao1RqhwFb2M
         yYB0GW4J8YxFpAZTxG2k0h6+8oMYj6TnLzTdPH4GYRLhttawPcTWMJqMB1IIWIR/Er+r
         16r35T2bIUBA88UJ1VPs/A2gji7482V5MWdRsGlgDz0/RbzUOyjqrrnTEqTGn1WMZd61
         +bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PfKa/v5U6FMVPvXJmgP6FpiQlSaYGckxVuFddgrtR1g=;
        b=uF5tFCUBdebfNCBM3V6crdCoLb/4Uhe/sfVKSPfTB2E3kWXaEom8KXB5dsvxGDdLhg
         TZAqlO54T4W3bFdrhcCbUQQq00inlX8RxiFGBLHZ/ohy4yvBfYDAWqeQFgmQFzc+tMKK
         vsPKMLZRu9jii0mkuu4pE5sBVQ0lg888wDg/VnHZ2dYjTRflehtVqxOF14xm9AcA1auy
         X+SDxOeKovuj2yJZ68kFBaobgNkypJFOXOXT35dOln6qL5QLJx6/92sjTqf6v7M06Oqo
         t/1ki7Zr1KS0Of33h9XxK29ywd9xJDPqXv7VObykqO7XKJ+OD8FuY/4UGmJl2YPr7oNt
         pOtg==
X-Gm-Message-State: AOAM530U2QHNC1TOltW2nfvhkHjozifwtc/nmuf7Xu2tJnKJLYv07PKT
        FvMQ+lrNwTjdUycgl2e3HoDWrlLE+0EnGUA3
X-Google-Smtp-Source: ABdhPJxLENlSS9sHOAsdw44myUX6RWDNZDE7snaGb2yEkR1wOMXbjL370ARu5m5BJE8MKN21UDjZlA==
X-Received: by 2002:a05:620a:4f6:: with SMTP id b22mr6420807qkh.489.1598534157444;
        Thu, 27 Aug 2020 06:15:57 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:b932:a679:4c12:1a2a? ([2600:1700:e72:80a0:b932:a679:4c12:1a2a])
        by smtp.gmail.com with ESMTPSA id y3sm1740700qkd.132.2020.08.27.06.15.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Aug 2020 06:15:56 -0700 (PDT)
Subject: Re: [PATCH v3 11/11] doc: add corrected commit date info
To:     85y2m6fhkm.fsf@gmail.com,
        =?UTF-8?Q?Jakub_Nar=c4=99bski?= <jnareb@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, me@ttaylorr.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <f6f91af30587ec24e2eee052c89a536cbff42c4f.1597509583.git.gitgitgadget@gmail.com>
 <85y2m6fhkm.fsf@gmail.com> <20200827063951.GA16268@Abhishek-Arch>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e7bbce30-93a6-b7e2-844b-5f2af4dbddf3@gmail.com>
Date:   Thu, 27 Aug 2020 09:15:56 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:80.0) Gecko/20100101
 Thunderbird/80.0
MIME-Version: 1.0
In-Reply-To: <20200827063951.GA16268@Abhishek-Arch>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/27/2020 2:39 AM, Abhishek Kumar wrote:
> Thinking about this, I feel creating a new section called "Handling
> Mixed Generation Number Chains" made more sense:
> 
>   ## Handling Mixed Generation Number Chains
> 
>   With the introduction of generation number v2 and generation data chunk,
>   the following scenario is possible:
> 
>   1. "New" Git writes a commit-graph with a GDAT chunk.
>   2. "Old" Git writes a split commit-graph on top without a GDAT chunk.

I like the idea of this section, and this setup is good.

>   The commits in the lower layer will be interpreted as having very large
>   generation values (commit date plus offset) compared to the generation
>   numbers in the top layer (toplogical level). This violates the
>   expectation that the generation of a parent is strictly smaller than the
>   generation of a child. In such cases, we revert to using topological
>   levels for all layers to maintain backwards compatability.

s/toplogical/topological

But also, we don't want to phrase this as "in this case, we do the wrong
thing" but instead

  A naive approach of using the newest available generation number from
  each layer would lead to violated expectations: the lower layer would
  use corrected commit dates which are much larger than the topological
  levels of the higher layer. For this reason, Git inspects each layer
  to see if any layer is missing corrected commit dates. In such a case,
  Git only uses topological levels.

>   When writing a new layer in split commit-graph, we write a GDAT chunk
>   only if the topmost layer has a GDAT chunk. This guarantees that if a
>   lyer has GDAT chunk, all lower layers must have a GDAT chunk as well.

s/lyer/layer

Perhaps leaving this at a higher level than referencing "GDAT chunk" is
advisable. Perhaps use "we write corrected commit dates" or "all lower
layers must store corrected commit dates as well", for example.

>   Rewriting layers follows similar approach: if the topmost layer below
>   set of layers being rewriteen (in the split commit-graph chain) exists,
>   and it does not contain GDAT chunk, then the result of rewrite does not
>   have GDAT chunks either.

This could use more positive language to make it clear that sometimes
we _do_ want to write corrected commit dates when merging layers:

  When merging layers, we do not consider whether the merged layers had
  corrected commit dates. Instead, the new layer will have corrected
  commit dates if and only if all existing layers below the new layer
  have corrected commit dates.

Thanks,
-Stolee
