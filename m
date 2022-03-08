Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4496C433F5
	for <git@archiver.kernel.org>; Tue,  8 Mar 2022 00:52:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344106AbiCHAxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 19:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344043AbiCHAxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 19:53:37 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF64AD
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 16:52:41 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id z7so3988454iom.1
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 16:52:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nEFoWyAzUeFOHkNtQnyprL8gcZV3SYG3dyP0gLOZcfY=;
        b=vPg4XzH2W+olo5n7UUv+BhS6HL92ntwspgyTV6g3aBom0/38anSAagy+Z8eu70cV2b
         TlXXHztDp8dbKbuu9lH1JzwuveL6FALKO5TTwAqhDMYMxSXgpCOzqa/Hqww7ZkFH7Eg4
         wZCReDtcNegmUKN5psXtOCtoL0jhBFMUG4ozYW5AlIfBJRHACaJVOCMSJCrVpNIF65bB
         nZg5TsR1RtAx+VVpecNiRAZi+9KUFheqTw39MmeEoDpaCItD3SpgjPgOXyzXNYgowE2I
         ejSxs8yC4isCY2G/mWNOvExg6HoJtfNgTf6pEu06Y4NN8FIgsy4Ot/WW7u3GrJJLF/1i
         HDWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nEFoWyAzUeFOHkNtQnyprL8gcZV3SYG3dyP0gLOZcfY=;
        b=JV3PTlUQ+YbAPmW4JxzOz80a5XxJjDPkzjZGQ1bSWP6LDV9EMGP1kqTpyv5a2EoucW
         hRK1gvqtGbSah5C4/0MhFxHNme1O86GrLDp10dDW+hviwfjO9sreJsnoNiOI4LKhsIEo
         pnGmny6Kx5f2euwBohxZsDmLJiyZzA3Jyr0do1uF1Iv02QkrgeTALLLFmQY9AuMVvK2L
         7XNtxEBaiiRkpkibEZi/8ooWQiLtthQ0tJ7m72dNlW4nUGb2w6FjYjBq7+82TrnjH3Jl
         l5YhS92eeoByDCkfga+bVzcO0SKKfcgB8rLaQHlpA6Nmo9Sg3uSkfzWTl4Iiz68UCANx
         gaKg==
X-Gm-Message-State: AOAM531kFcP2VkGUgYF0d3okGCnathk+hlIQ75m6Zq+EM+DyuxWLB6Lh
        /6aT4UxeWmuIk9mCpLgaoMNbAg==
X-Google-Smtp-Source: ABdhPJznZEKrbvSHfM3/NHJbkIk/Krdb1huY3cfDOu49Yko9HCaFjA012IZrRAQ0biPllf7+3k/k/A==
X-Received: by 2002:a05:6638:4189:b0:314:5435:76a1 with SMTP id az9-20020a056638418900b00314543576a1mr12734908jab.263.1646700760628;
        Mon, 07 Mar 2022 16:52:40 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z7-20020a6b0a07000000b0064154e26264sm9319427ioi.0.2022.03.07.16.52.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 16:52:40 -0800 (PST)
Date:   Mon, 7 Mar 2022 19:52:39 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: tb/cruft-packs (was Re: What's cooking in git.git (Mar 2022,
 #01; Thu, 3))
Message-ID: <Yiao1+Zdlj9zZgCQ@nand.local>
References: <xmqqv8wu2vag.fsf@gitster.g>
 <0870b8f0-976a-cf2f-f34f-7e966b9c426f@github.com>
 <YiZJiPVMZwPXbfrK@google.com>
 <YiZMhuI/DdpvQ/ED@nand.local>
 <ebfac323-7567-6327-f5e6-0fd9e0356550@github.com>
 <YiZoojeTodMr+Ypw@google.com>
 <332f9b54-edfb-50e7-46a7-2e46d3b574e4@github.com>
 <xmqqpmmxqwe6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpmmxqwe6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Mar 07, 2022 at 01:34:57PM -0800, Junio C Hamano wrote:
> Derrick Stolee <derrickstolee@github.com> writes:
>
> > ... Git does not
> > support parallel writers doing significant updates like full
> > repacks and GCs and instead relies on the user to control the
> > concurrency there.
>
> At least when we set out to give our users Git, allowing such
> concurrent writing without corrupting repositories was what we aimed
> to achieve.  If you did two simultanenous repacks, one of the may
> fail while trying to acquire a lock or two, so from waste-avoidance
> perspective, there is a strong incentive on the user's side to make
> sure such housecleaning tasks are not triggered needlessly and
> simultanously, but it shouldn't lead to repository corruption.

It is not true that `git repack` does not support parallel writers.

Indeed, `repack` doesn't hold any locks on the repository ahead of time,
but the concurrent writers situation will at worst leave us in a state
where objects appear twice across multiple packs.

So yes, users are incentivized to limit multiple repack processes from
stomping on each other and wasting effort, but multiple writers running
`git repack` cannot corrupt a repository.

Thanks,
Taylor
