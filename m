Return-Path: <SRS0=3l3d=A2=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F231C433E3
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 03:20:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BB9420674
	for <git@archiver.kernel.org>; Wed, 15 Jul 2020 03:20:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DAFxHHk+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgGODUT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725977AbgGODUS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jul 2020 23:20:18 -0400
Received: from mail-qt1-x843.google.com (mail-qt1-x843.google.com [IPv6:2607:f8b0:4864:20::843])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEE0C061755
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 20:20:17 -0700 (PDT)
Received: by mail-qt1-x843.google.com with SMTP id b25so651514qto.2
        for <git@vger.kernel.org>; Tue, 14 Jul 2020 20:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=HBvkXETgPD7NvoTk+7Y1sdVzZQZJhyfLs8DyuWkunOM=;
        b=DAFxHHk+VYR9WgS+5zsqO1sWnyIPVbUlQMfRljyMVgYEwT5BVoKsEJTZwbDey0JNm1
         UXo19m8GbjFR2WIJOKIIM2w/phj8giXOzpkEl22wzGDzob6kJOH/wtDOoFDWRF3OPxiD
         +C6MItbJQmqYDN3pt+pXe+sErxa9qP41jsSzyPjD/ixXjwNNqpnXOq7Hxs6lRPLKc2Cl
         N1FwP9cnUmrf/QYMHjqZj/r4td4Xb+9IfFcs46mu335m/zhx3K46xPeLmE3DDJWJdnUN
         l5BpeVvp5YsGPV/k4oFOjCcGvEtZdkS5oNE43Rdo1u5UNbvzIwNDaHhw0nknVrCquqvj
         3zzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HBvkXETgPD7NvoTk+7Y1sdVzZQZJhyfLs8DyuWkunOM=;
        b=Ozy7tloMq/K2NxditEF0xZxlI5C59TyssKvi/yuabO5GKpsP4HKGfPIGg6QyiisLBS
         DQuMsHoiHfFIc30q8ehmKcdBrAZDj7ThsC1KR7QTX6bM5Gmerwm7+1+ph/ylBfjednQM
         K6Fx/jbCrPEAFT9K7QVI6KDTtnzjktawLgWYKWJpGQKwwjCpvhY3P8DPg4AqIje64nJd
         C3etfWYnmG1eApO+AvDEP2n+fSkPH2TDlanS/6TdK+XG90fElJzWDPUAlbBfVHANV6GN
         tAzjW6A2pm9ZW+KfOz9j+iwhgxaIoxfq11yadKJUunhzNsoY3INhVz4fiv7vOE1tHtlc
         S4uQ==
X-Gm-Message-State: AOAM531+nuqecs25U+NjOxk0R0lr4jW4UubQwwCXHtpJZWSPWCpqWf0E
        p9GFG7ey0F83pFH81QxHi4Q=
X-Google-Smtp-Source: ABdhPJxw0ezewbzdqXi+A7Qm17ezCsCcM/PouFs0NBJRv85Lui8iAqh8g1q6Z9yXvEljU1m59u0dFQ==
X-Received: by 2002:aed:2fa1:: with SMTP id m30mr8228046qtd.306.1594783217063;
        Tue, 14 Jul 2020 20:20:17 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id x34sm1284253qtd.44.2020.07.14.20.20.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 20:20:16 -0700 (PDT)
Date:   Tue, 14 Jul 2020 23:20:14 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     phillip.wood@dunelm.org.uk,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Git mailing list <git@vger.kernel.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [RFC] should `git rebase --keep-base` imply
 `--reapply-cherry-picks` ?
Message-ID: <20200715032014.GA10818@generichostname>
References: <0EA8C067-5805-40A7-857A-55C2633B8570@gmail.com>
 <20200714031017.GA15143@generichostname>
 <9c6dff59-b204-1ace-e0aa-0885dd502214@gmail.com>
 <nycvar.QRO.7.76.6.2007142236060.52@tvgsbejvaqbjf.bet>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <nycvar.QRO.7.76.6.2007142236060.52@tvgsbejvaqbjf.bet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

On Tue, Jul 14, 2020 at 10:38:23PM +0200, Johannes Schindelin wrote:
> > To me the question is why are we looking at the upstream commits at all
> > with `--keep-base`? I had expected `rebase --keep-base` to be the same
> > as `rebase $(git merge-base [--fork-point] @{upstream} HEAD)` but
> > looking at the code it seems to be `rebase --onto $(git merge-base
> > @{upstream} HEAD) @{upstream}`. I didn't really follow the development
> > of this feature - is there a reason we don't just use the merge-base as
> > the upstream commit?

It behaves this way mostly for unimportant reasons. The first is that my
workflow before implementing this feature invoked running
`git rebase --onto master... master` and I wanted to replicate that.

More importantly, one feature of using the upstream I considered is
documented in t3431. Essentially, if we have the following graph,

	A---B---D---E    (master)
	     \
	      C*---F---G (side)
	
	C was formerly part of master but master was rewound to remove C

running `git rebase --keep-base --fork-point master` would drop C.

> Those are interesting questions, indeed.
> 
> And I dare to suspect that the answer is indeed: `--keep-base` really
> should not only substitute `onto` but also `upstream` with the merge base.

I would be open to changing the behaviour since the commit dropping
isn't really a feature that I use very often. However, I am worried
about pulling the rug out from other people if they use it since this is
a documented feature in git-rebase.txt.

Thanks,
Denton

> Ciao,
> Dscho
