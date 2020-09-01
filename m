Return-Path: <SRS0=kr1+=CK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1BA6C433E2
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:07:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BAB82067C
	for <git@archiver.kernel.org>; Tue,  1 Sep 2020 13:07:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MSUUXyFy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726929AbgIANH1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Sep 2020 09:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726858AbgIANE3 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Sep 2020 09:04:29 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ED90C061244
        for <git@vger.kernel.org>; Tue,  1 Sep 2020 06:04:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id mm21so586933pjb.4
        for <git@vger.kernel.org>; Tue, 01 Sep 2020 06:04:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:reply-to:references:mime-version
         :content-disposition:in-reply-to;
        bh=7fKiuNzejdwjQHPhtvKEF0wu5ZLOWMs0hemueUsUhCo=;
        b=MSUUXyFyquKrxwqYFeVlhS+YhJbSAUsUx7di38DS6mZshskHXJAAmy97jdq3Q5qkZY
         vRwMqlHbkmI2YEXLgZqlg8di8z4gZe1z/2DlhkUm0rV7o0Jhr9GKdsqrKaDpUsSHF49M
         4tkeGmPIZHrNEqmuGpKZXXmnUP2YUkhxQxr1607hWkUc1tBKgvkYM7gnm2/bJV1bvKc1
         NpZEEB2fIPjOcuJFjazZvj5qrcKrvEHJvUKYrnHP4iI2sC7PxH55wMD0nmRd8FjWJSOm
         Y/r8JWN4mDK2AC7RCho7BFjUFE1/Ft8dM+tdusq0QTFB8yKQP0PYRqf2lqkcIstSJE8r
         BWLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:reply-to
         :references:mime-version:content-disposition:in-reply-to;
        bh=7fKiuNzejdwjQHPhtvKEF0wu5ZLOWMs0hemueUsUhCo=;
        b=LBKKrb0n1ICiOM/0ChULwF0A2iM4Cm9VeEio8kFcICqn7sP+AK92RMCZY5FCpQ/+WH
         kVIMmw9MFTdE5l87uEHg1cAKv+IpDynajl+apQi0KstO/8RDVUS2sTXtEk9dkV0ZhTlg
         6utAB0Nb7EY/jMS8qAZoqDWGp49MetBeXdSSZiA535/3F5f2cMpjaAPCGaZ8P7Gmg7aE
         SX8GUB95GMRxsSiFd1AkZz6qBXO7g48cVW9Doa9tabctnEKADcg1mDksdAwQTQC7Xchn
         IN1eyXoUBZTVIJzkJbt8f8Sl4DV6SPR/PUhav/DGjp29PwO3/z7D4z7zKHOC1x4cW+XM
         rvSg==
X-Gm-Message-State: AOAM533GovreZctHTCg7VJm15q4pE5kgNBb1GeEgKwGqjTvCROj3AxvK
        eFxUZdBtTks3+d7NfXHvRAg=
X-Google-Smtp-Source: ABdhPJxdqdIlw/yQcBT7y8bPVxt0hZBw8n+nGGwZURk5FxmNdknvEFoTnXtKptIR7d9qeewsV6BUjQ==
X-Received: by 2002:a17:90a:6b07:: with SMTP id v7mr1573072pjj.138.1598965452849;
        Tue, 01 Sep 2020 06:04:12 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:79b:52ed:48f6:b1a4:ca3c:754b])
        by smtp.gmail.com with ESMTPSA id k29sm2130366pgf.21.2020.09.01.06.04.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 06:04:11 -0700 (PDT)
Date:   Tue, 1 Sep 2020 18:31:52 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     abhishekkumar8222@gmail.com, git@vger.kernel.org,
        gitgitgadget@gmail.com, jnareb@gmail.com
Subject: Re: [PATCH v3 11/11] doc: add corrected commit date info
Message-ID: <20200901130152.GA4186@Abhishek-Arch>
Reply-To: e7bbce30-93a6-b7e2-844b-5f2af4dbddf3@gmail.com
References: <pull.676.v2.git.1596941624.gitgitgadget@gmail.com>
 <pull.676.v3.git.1597509583.gitgitgadget@gmail.com>
 <f6f91af30587ec24e2eee052c89a536cbff42c4f.1597509583.git.gitgitgadget@gmail.com>
 <85y2m6fhkm.fsf@gmail.com>
 <20200827063951.GA16268@Abhishek-Arch>
 <e7bbce30-93a6-b7e2-844b-5f2af4dbddf3@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e7bbce30-93a6-b7e2-844b-5f2af4dbddf3@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Aug 27, 2020 at 09:15:56AM -0400, Derrick Stolee wrote:
> On 8/27/2020 2:39 AM, Abhishek Kumar wrote:
> > Thinking about this, I feel creating a new section called "Handling
> > Mixed Generation Number Chains" made more sense:
> > 
> >   ## Handling Mixed Generation Number Chains
> > 
> >   With the introduction of generation number v2 and generation data chunk,
> >   the following scenario is possible:
> > 
> >   1. "New" Git writes a commit-graph with a GDAT chunk.
> >   2. "Old" Git writes a split commit-graph on top without a GDAT chunk.
> 
> I like the idea of this section, and this setup is good.
> 
> >   The commits in the lower layer will be interpreted as having very large
> >   generation values (commit date plus offset) compared to the generation
> >   numbers in the top layer (toplogical level). This violates the
> >   expectation that the generation of a parent is strictly smaller than the
> >   generation of a child. In such cases, we revert to using topological
> >   levels for all layers to maintain backwards compatability.
> 
> s/toplogical/topological
> 
> But also, we don't want to phrase this as "in this case, we do the wrong
> thing" but instead
> 
>   A naive approach of using the newest available generation number from
>   each layer would lead to violated expectations: the lower layer would
>   use corrected commit dates which are much larger than the topological
>   levels of the higher layer. For this reason, Git inspects each layer
>   to see if any layer is missing corrected commit dates. In such a case,
>   Git only uses topological levels.
> 
> >   When writing a new layer in split commit-graph, we write a GDAT chunk
> >   only if the topmost layer has a GDAT chunk. This guarantees that if a
> >   lyer has GDAT chunk, all lower layers must have a GDAT chunk as well.
> 
> s/lyer/layer
> 
> Perhaps leaving this at a higher level than referencing "GDAT chunk" is
> advisable. Perhaps use "we write corrected commit dates" or "all lower
> layers must store corrected commit dates as well", for example.
> 
> >   Rewriting layers follows similar approach: if the topmost layer below
> >   set of layers being rewriteen (in the split commit-graph chain) exists,
> >   and it does not contain GDAT chunk, then the result of rewrite does not
> >   have GDAT chunks either.
> 
> This could use more positive language to make it clear that sometimes
> we _do_ want to write corrected commit dates when merging layers:
> 
>   When merging layers, we do not consider whether the merged layers had
>   corrected commit dates. Instead, the new layer will have corrected
>   commit dates if and only if all existing layers below the new layer
>   have corrected commit dates.

Thanks, that is a great suggestion! Using positive language is more
straightforward and easier to understand.

> 
> Thanks,
> -Stolee
