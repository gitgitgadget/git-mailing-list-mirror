Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7116A208EB
	for <e@80x24.org>; Mon,  6 Aug 2018 14:32:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730565AbeHFQl1 (ORCPT <rfc822;e@80x24.org>);
        Mon, 6 Aug 2018 12:41:27 -0400
Received: from mail-pg1-f179.google.com ([209.85.215.179]:43176 "EHLO
        mail-pg1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728626AbeHFQl1 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Aug 2018 12:41:27 -0400
Received: by mail-pg1-f179.google.com with SMTP id d17-v6so6306661pgv.10
        for <git@vger.kernel.org>; Mon, 06 Aug 2018 07:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=4SFEp8cYXMbPcSiEd3Br+3io3nRt7Q2WeHIeIwVwY3k=;
        b=OzEkE2S1pt/JOE9H4h1bERKgyMWUX30uwCLAgOUpZbM6ekdcrQFYokUY4DaYj95Hrf
         EKmCWHlKAFTw6ofSyOkQw2EixtjruetF8qyjFjrae/46siRSYhF5R29m4c4Gt9wrT/N8
         KPhI2y6rXqy6RQ2LRCcmY3eWhTcIFzIkAE1RUeH7ORkTXMPDVS1lXibx+UYBBa6RIiaU
         jc8YVc6MhEpu2+O5/2detTqsFADiUfjijYP4UA+03rYz8mVXj1Ldmpv1FSDp0O8UnD/9
         LO3OGgoMsEuLoa1DSCmuszZwEduweMhp/r/170zp+B+mn89sVWNUb53kBX08UnHJn8df
         xFYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=4SFEp8cYXMbPcSiEd3Br+3io3nRt7Q2WeHIeIwVwY3k=;
        b=Dmd/AAKCACDlM4Esux/l5IopvGS3jvEoII5CaiWwnik1WaxeCo05ZbzV5GJqdD4ziR
         VH3dvGC+56w2gpRL+LC1eygoeJFoEz+VLj4JRUe+2Naq6LUKtqT2es59IW/4Jkn0LXNe
         ma+fDZt6TphihhPItTYSMRNfAVwALvk2omHkRsWdha+cO/9J21HATUavTFpd2cZAlRxQ
         oFPjREJAPYzFSMx2HsuZ/+qQoINKomXYFWMjFYyP5axxrGK1f10KDgJmK2SkWkVQ7Odc
         BGn8gXG/OqNUXhtKQbn8UM0jhijjItKRKYh+nIUwxBLnzU+FkSGDQRx6vKJ1Jr1/trSN
         05Xw==
X-Gm-Message-State: AOUpUlGd5DaLJ2MOhtUfuT9i/IYfA6h/K2WPevxGtCmtlAOCtzB406CR
        zpBliigiCQeYr4KjrCK8hJY=
X-Google-Smtp-Source: AAOMgpddBun+B6+8Exal+/7lftgEBUGDnhrSGPi0rdhgWHWk7WZgItmlHvb/LMTxaosiZ26v6UfgoQ==
X-Received: by 2002:a63:f713:: with SMTP id x19-v6mr14736517pgh.233.1533565924342;
        Mon, 06 Aug 2018 07:32:04 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id k64-v6sm25126194pfg.141.2018.08.06.07.32.03
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 06 Aug 2018 07:32:03 -0700 (PDT)
Date:   Mon, 6 Aug 2018 07:32:02 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Alexander Mills <alexander.d.mills@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: concurrent access to multiple local git repos is error prone
Message-ID: <20180806143202.GA97564@aiede.svl.corp.google.com>
References: <CA+KyZp4fxRfnPNozEtwgLPuFAnEsXCBPPubzNjv0wUMnBV_eww@mail.gmail.com>
 <CA+KyZp43YGf1qLDHOtrfjJxREcaVQNN12iMLDL5qX=RXhmMCYQ@mail.gmail.com>
 <20180805014631.GD258270@aiede.svl.corp.google.com>
 <CA+KyZp5i0EXPJ10v+SXmHWCYvZ7=XT8K8gcka0qxCBYXq=OevA@mail.gmail.com>
 <20180805061312.GA44140@aiede.svl.corp.google.com>
 <CA+KyZp4Yc4_Xaw3v+BPwxi_PW75=GXmj=Re7EpsurXi2_hMc9w@mail.gmail.com>
 <20180805081116.GG44140@aiede.svl.corp.google.com>
 <CA+KyZp760a3yTF6ghiNh=c5FoU36MN3cdQU5J8NF2Ss+nwRqyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+KyZp760a3yTF6ghiNh=c5FoU36MN3cdQU5J8NF2Ss+nwRqyQ@mail.gmail.com>
User-Agent: Mutt/+ (31e72e18) (2018-08-06)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

(administrivia: please don't top-post)
Hi Alex,

Alexander Mills wrote:

> Yeah this concurrency problem is real. Not only does it happen with
> `git status` the same thing happens with `git rev-parse
> --show-toplevel`.

Sorry for the confusion --- I didn't mean to claim your experience was
not real!

What I wanted to make clear is that

 1. Git is designed to allow concurrent reads of a repository (and
    pushes to a repository).  If it doesn't work, that is a simple bug,
    not a design goal.

 2. Plenty of people rely on concurrently accessing repositories, so
    if it doesn't work, then (i) we definitely want to know and (ii)
    we're going to need a lot of detail to figure out what's happening,
    so we can fix it.

Does that make it clearer?

> What happens is that I get no stdout when repos are accessed
> concurrently (and no stderr). If I limit concurrency to 1, the problem
> goes away. When I up the concurrency, the problem is sporadic, which
> is the exact signal for a concurrency/race-condition related issue.
> The signs are damn clear. I have seen this problem on MacOS I think a
> year back on a different project, but I never reported it b/c I hadn't
> really verified it.
>
> Like I said I am on Ubuntu. I have 3 git repos that are incorporated
> into the tool that's generating the problem. For one repo I got this:
>
> $ git fsck
>
> Checking object directories: 100% (256/256), done.
> dangling tree 4b825dc642cb6eb9a060e54bf8d69288fbee4904
>
> For `$ git version --build-options` I have:
>
> git version 2.17.1
> cpu: x86_64
> no commit associated with this build
> sizeof-long: 8

Thanks.  My best idea for a next step is that if you can come up with a
reproduction recipe, that would be very helpful.

It doesn't have to reproduce 100% of the time, but e.g. if you have a
script that reproduces it 50% of the time, I can run that script in a
loop.

Thanks,
Jonathan
