Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D546C47080
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:39:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17D79613A9
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 10:39:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhFAKlQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 06:41:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbhFAKlN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 06:41:13 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06954C061574
        for <git@vger.kernel.org>; Tue,  1 Jun 2021 03:39:31 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id i12so9728293qtr.7
        for <git@vger.kernel.org>; Tue, 01 Jun 2021 03:39:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-language:content-transfer-encoding;
        bh=73q5dl12Jghgjyx70RpiYsUMkSL+NxS1Xlf8JkmlP3o=;
        b=tKB0USy6WTfF0mj2z79eQSSAzSX8JHY4EN8kbs33mYBygi4d8aTC4YXOdx1zp3lwdh
         4EgGaZnvzTItmX3Xxze4GFip3zLuCiZYJE+mDXJlTGixExJOs3rgzL5dLYSWbWnHsKcL
         Xuh/o0yXwt4AwDh+I8jwhCxxF1QExLOiOyW6IGbzrhhrBkPSCbf7KKDLljhU/exWWIYA
         +Rk3SbeZlN6DhNZh76Zfz7rW46dpTWUpZ7FpR2SF9x5s4/KZaYTZ2jKenIXJXGiUBu18
         n3jo4KxbA31pLj9vumsiOPpWETYIgJATpEBFmwnAy0/swN1gkpGHlhhgvJRf2EN59LpJ
         IKqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=73q5dl12Jghgjyx70RpiYsUMkSL+NxS1Xlf8JkmlP3o=;
        b=tPRd7W3fu0jIPbmL2WPBQig3AKxeRtycyFpjgeSm9uAW54dR5cXoMoM7P/ON/kMRDa
         VBqj6zfS56V1yf92Rr5mEuwNyuLwBv2Ij7xlG1WnrkYnhwHPK3HEHQ58MwM219jCidOR
         GEPicvi4Y5gP6Eg1hr3HjCTjFzTBwXImofxS9lac3Hr0twhrdyVo2oQQ3OribjOfU/sf
         KgWv7XnH6N5dJ1Cn5pBx4uV7Vmnd0HRIr0MFs9lYYxhQMwmp/Cm2HdI/64lpy1NNXbYK
         RNC46GfpB/nlLugF3ZSGlBVm7GpzwFCY9o/pMIsqiJY/wv1xZJrBylGk/K+5dJn+IL6N
         czjA==
X-Gm-Message-State: AOAM532iNcKfKLJeB8wI/AAPp5bOy9Jfv/qF/Njds5fQUqE+FyzPKFtN
        9pwv5lUNBTrfkew6ofXasc215he3TUMuYQ==
X-Google-Smtp-Source: ABdhPJxrxy/sxuJHESU+1NeuEyAED9Jix0uzttaFnwrUksD3/dBDnqtmw4JS8uvbUXFq5jGqlX9VCA==
X-Received: by 2002:ac8:4a95:: with SMTP id l21mr2775593qtq.317.1622543969607;
        Tue, 01 Jun 2021 03:39:29 -0700 (PDT)
Received: from Derricks-MacBook-Pro.local ([2600:1700:e72:80a0:e809:8add:2f2c:424e])
        by smtp.gmail.com with ESMTPSA id q13sm11153404qkn.10.2021.06.01.03.39.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Jun 2021 03:39:29 -0700 (PDT)
Subject: Re: Removing Partial Clone / Filtered Clone on a repo
To:     Tao Klerks <tao@klerks.biz>, git@vger.kernel.org
References: <CAPMMpoim38J3=4pd0_fM2h=DN_PrEE_Osg2duU5Ur8WUZ5S1Pg@mail.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <032cabb2-652a-1d88-2e12-601b40a4020c@gmail.com>
Date:   Tue, 1 Jun 2021 06:39:28 -0400
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.14; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAPMMpoim38J3=4pd0_fM2h=DN_PrEE_Osg2duU5Ur8WUZ5S1Pg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/1/21 6:24 AM, Tao Klerks wrote:
> Hi folks,
> 
> I'm trying to deepen my understanding of the Partial Clone
> functionality for a possible deployment at scale (with a large-ish
> 13GB project where we are using date-based shallow clones for the time
> being), and one thing that I can't get my head around yet is how you
> "unfilter" an existing filtered clone.
> 
> The gitlab intro document
> (https://docs.gitlab.com/ee/topics/git/partial_clone.html#remove-partial-clone-filtering)
> suggests that you need to get the full list of missing blobs, and pass
> that into a fetch...:
> 
> git fetch origin $(git rev-list --objects --all --missing=print | grep
> -oP '^\?\K\w+')

I think the short answer is to split your "git rev-list" call
into batches by limiting the count. Perhaps pipe that command
to a file and then split it into batches of "reasonable" size.

Your definition of "reasonable" may vary, so try a few numbers.

> The official doc at https://git-scm.com/docs/partial-clone makes no
> mention of plans or goals (or non-goals) related to this "unfiltering"
> - is it something that we should expect a story to emerge around?

The design is not intended for this kind of "unfiltering". The
feature is built for repositories where doing so would be too
expensive (both network time and disk space) to be valuable.

Also, asking for the objects one-by-one like this is very
inefficient on the server side. A fresh clone can make use of
existing delta compression in a way that this type of request
cannot (at least, not easily). You _would_ be better off making
a fresh clone and then adding that pack-file to your
.git/objects/pack directory of the repository you want.

Could you describe more about your scenario and why you want to
get all objects?

Thanks,
-Stolee
