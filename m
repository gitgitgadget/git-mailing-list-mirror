Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53765C43334
	for <git@archiver.kernel.org>; Sat,  9 Jul 2022 00:27:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229495AbiGIA1F (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Jul 2022 20:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiGIA1E (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Jul 2022 20:27:04 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5CB8688A
        for <git@vger.kernel.org>; Fri,  8 Jul 2022 17:27:03 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id a15so345605pfv.13
        for <git@vger.kernel.org>; Fri, 08 Jul 2022 17:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=e5fB5fFFpFue9R9/4BYFkC7gCiWXcEkNk6iMoaW1nus=;
        b=n0ZUJ+c7V7vBWWaXVspyJzBdy5SG8lKkj3RuOExK4A/XAMmwUkLISMCb/lYlYqUBf1
         T8Ff2vnH6ZYMIjJCC4pZrObgmiSEr0mNZP1g4xGQAf6AAoDaMJO+MJ01jAaKAO6TKQ1X
         GltIwp4m/Qp53DfbVT15d5o3yg5+2DW4W5Kpz/guZ54ZG8ug+PWRNAjTJXrw6qoNT7rH
         eAjdicEjRiKbxKKqh2PyLRX2YZFN4sXOd0xz1CLkfhli0Xs/QBoNTpIXo5vHikjWuISV
         nefd36yw1nDUZ48vYt4Tc/LpBdAFQOVOaI1YY0IyZ3wINp9kU8D4TCLbMP4ETTlaK87L
         O5Rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=e5fB5fFFpFue9R9/4BYFkC7gCiWXcEkNk6iMoaW1nus=;
        b=5Y2BrTRSGJBCLrv4qsmiZeKje+r+SXzSJ9UACGhNmaOtB+lcVIALfiWAkX3YXENUPr
         Vh7wYZSLUXjamsb80QPNX4wSyCp7M52Rgmwsc9Xuj7DxnJp1b2f40J9MzO5A33Rrer9q
         SALKY0DLgOY6TOGOp3hBX9Z18a7mfmHHO3Nsa+c+YTJFpE3lqA+vMAtf3PS7uiyP5ZC3
         0V4Lcpb9A6dBgh8nr3zvZBFZf0bbWeynNCKg5ROr86Sm10UoZ//nNjv0JFQSKbjPkGoh
         67F8Fn7qLIik5mX0XWf82rJPmNlMDDyZxDmDuJt0gv6nQdd4A90ki8lcdvHQZBul9ShO
         lzVw==
X-Gm-Message-State: AJIora9eSL/TsBaNPK8VbfcmJ+U/bSAgSW3CGWRCPDEyTc9gybqyAf4Q
        hTxcAITsljdGtx7n2pfXbqs=
X-Google-Smtp-Source: AGRyM1v4jctKM6dAIooXh+tR/cZJJAoAWMhWpBVXYFAmnjkdz4GDqOY0qnacyCHFZG24Qs1dxmpb1w==
X-Received: by 2002:a05:6a00:2449:b0:528:3a29:e79d with SMTP id d9-20020a056a00244900b005283a29e79dmr6302096pfj.39.1657326422771;
        Fri, 08 Jul 2022 17:27:02 -0700 (PDT)
Received: from Carlos-MacBook-Pro-2.local (173-164-135-253-SFBA.hfc.comcastbusiness.net. [173.164.135.253])
        by smtp.gmail.com with ESMTPSA id h20-20020a63df54000000b0040c9213a414sm49077pgj.46.2022.07.08.17.27.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 17:27:02 -0700 (PDT)
Date:   Fri, 8 Jul 2022 17:26:58 -0700
From:   Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
To:     =?utf-8?B?56iL5rSL?= <chengyang@xiaomi.com>
Cc:     "lilinchao@oschina.cn" <lilinchao@oschina.cn>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        git <git@vger.kernel.org>,
        =?utf-8?B?5L2V5rWp?= <hehao@xiaomi.com>,
        Xin7 Ma =?utf-8?B?6ams6ZGr?= <maxin7@xiaomi.com>,
        =?utf-8?B?5Yeh5Yab6L6J?= <fanjunhui@xiaomi.com>,
        =?utf-8?B?55+z5aWJ5YW1?= <shifengbing@xiaomi.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: possible bug with commit-graph causing git to fork bomb (was Re:
 [External Mail]Re: Git fork process infinitely and never stop)
Message-ID: <20220709002658.vt34nnzhxefg72d3@Carlos-MacBook-Pro-2.local>
References: <9d3b79239a314f72a099040a26ef9ad8@xiaomi.com>
 <8e1d019e-6456-ed05-7d3e-a0c4beeb35fa@gmail.com>
 <8ccd27ef3a344596b6237e98e1a5f204@xiaomi.com>
 <202207061520052718298@oschina.cn>
 <e071496cfdb04cce8eac322febb6af45@xiaomi.com>
 <11f76b2382934edcb97eb201f0a78a67@xiaomi.com>
 <bd33fa6079c2485fb6ee741be05d3f7e@xiaomi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd33fa6079c2485fb6ee741be05d3f7e@xiaomi.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jul 08, 2022 at 10:45:08AM +0000, 程洋 wrote:
> Any feedback on this?

My guess is that the problem has been difficult enough to reproduce with
the instructions you provided and because of the top posting that the
people most likely to come up with a solution are not even aware yet of
the issue.

I changed the subject and I am including some of your discovery below
and copying someone that might know better, but trying to find a way
to provide a repository where this could be replicated locally (maybe
using the --anonymize option mentioned in the thread) or a copy of the
repository (not in an attachment) if it is not sensitive would be of a
lot of help.

Also, I heard rumours that most of the people working with that feature
that you might have identified as problematic might be off this week, so
might need to wait a little longer.

Carlo

PS. also, try to post your responses inline like this one.

------ CUT BELOW FOR PROBABLY RELEVANT INFORMATION FROM THREAD ------

Stolee

> To be a supplement.
> If I delete .git/objects/info/commit-graph,  everything works well As well as fetch with `-c core.commitGraph=false`

This would seem to indicate that something in the repository might be
triggered by the commit-graph code.

> if I execute `git fetch --filter=blob:none --quiet --progress miui --prune --tags +refs/heads/*:refs/remotes/miui/* +refs/heads/miui13-s-thor-vendor-stable:refs/remotes/miui/miui13-s-thor-vendor-stable`  on version 2.25.1. It just throw error rather than infinite loop, like this youtube video "https://www.youtube.com/watch?v=qvYTvVRE0FU&feature=youtu.be"

maybe a regression?

Carlo
