Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4855AC433F5
	for <git@archiver.kernel.org>; Mon, 21 Feb 2022 21:43:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234241AbiBUVnY (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Feb 2022 16:43:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230430AbiBUVnW (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Feb 2022 16:43:22 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018A122BC4
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 13:42:59 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id f14so9929359ioz.1
        for <git@vger.kernel.org>; Mon, 21 Feb 2022 13:42:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=c3pbXlwjdhYM349mJqHZQ9iuQuKZhR2Ex6gTBWZEHNU=;
        b=fZ0161Qnysm8Z3Fzcej3F2tShHHB6fHLEbO8gveW6C4M478Acrj8jz8yhZZvccd7hV
         gbiOpYgl3xgwRqhIGYaVJ/f2fn6nW0afl6hpiXz4b51iftZQNsjfHJS6SON5x0e0xZht
         9nUdI11lG8HRbD07Lo7QoS0W9/Z/lYbyFtSSY2RshBVlMfPJa91/4/DU7MtMWkR3yIO7
         cHwOJnDHA4k5yUwbJDYHU4dbfIZaTnfcYaiVGcNNzDJiASH0BM3B87ckAJt1ajdcem0Y
         pSHvdqd6bBtcDxVMqsCApKswHQTVv5hhq1hfJ8jspzuOkwmXHai+C5cbNWoKMCZcoagS
         kvCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=c3pbXlwjdhYM349mJqHZQ9iuQuKZhR2Ex6gTBWZEHNU=;
        b=CZXmll1UvU+o0soHJ2oFoKmMW4RAuSchLzY/BImhAoy+0Y+u/7+Jmbv/FeWSndg7p+
         Phk6rdtkP95BiwUNx4w3IXhQDwW1IJPswB62L2NVoPLhJO8Ry6gBd19dwVhjxAsn7LaX
         TYJF1qbAxMhtYplosuvg+obkxfwIBosWqGBJlAEtA90qnSfYnCNKeMC/2Pppk86qGBPN
         Vn5QtGR3AIzR2KvNm3ZtfhI9nqgUa6433a3ptSyC/AK3xkwHfWeHZqjbLJtHvydKjSIv
         YM60qdJDQhK96zvNmYlTujrFXYTFLGG6Iey+EayYksk5VurHMlFjbjzYA7Dq/110pZU8
         RQMg==
X-Gm-Message-State: AOAM532HKlr3EYVGlOnJ4ZeCio/u9u2oJc118j7FObFSA4dC+J0d5UM7
        gtlcKQql2oSlKQipZT/vm1RD/Q==
X-Google-Smtp-Source: ABdhPJx770rKrHkJwDr7m42OCAaE0aQspfT+GSBuHbZ5uUWx5pJifzzT8DiEsRClYSkHg/PKO9lJRA==
X-Received: by 2002:a05:6602:150a:b0:632:c10c:55ff with SMTP id g10-20020a056602150a00b00632c10c55ffmr16910853iow.16.1645479778352;
        Mon, 21 Feb 2022 13:42:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s10sm8604950ild.84.2022.02.21.13.42.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 13:42:57 -0800 (PST)
Date:   Mon, 21 Feb 2022 16:42:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, John Cai <johncai86@gmail.com>,
        Robert Coup <robert.coup@koordinates.com>,
        John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 0/4] [RFC] repack: add --filter=
Message-ID: <YhQHYQ9b9bYYv10r@nand.local>
References: <pull.1206.git.git.1643248180.gitgitgadget@gmail.com>
 <pull.1206.v2.git.git.1644372606.gitgitgadget@gmail.com>
 <CAFLLRpJ1aDyLb4qAoQwYDyGdP1_PH8kzLAQCKJpQwiYiapZ5Aw@mail.gmail.com>
 <CB2ACEF7-76A9-4253-AD43-7BC842F9576D@gmail.com>
 <YhMC+3FdSEZz22qX@nand.local>
 <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAP8UFD2dpicW64eqBK47g43xDWA1qv2BMBEOSqj_My5PUs8TSg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 21, 2022 at 10:10:15PM +0100, Christian Couder wrote:
> > > Also, to have more protection we can either
> > >
> > > 1. add a config value that needs to be set to true for repack to remove
> > > objects (repack.allowDestroyFilter).
>
> I don't think it's of much value. We don't have such config values for
> other possibly destructive operations.
>
> > > 2. --filter is dry-run by default and prints out objects that would have been removed,
> > > and it has to be combined with another flag --destroy in order for it to actually remove
> > > objects from the odb.
>
> I am not sure it's of much value either compared to naming it
> --filter-destroy. It's likely to just make things more difficult for
> users to understand.

On this and the above, I agree with Christian.

> > I share the same concern as Robert and Stolee do. But I think this issue
> > goes deeper than just naming.
> >
> > Even if we called this `git repack --delete-filter` and only ran it with
> > `--i-know-what-im-doing` flag, we would still be leaving repository
> > corruption on the table, just making it marginally more difficult to
> > achieve.
>
> My opinion on this is that the promisor object mechanism assumes by
> design that some objects are outside a repo, and that this repo
> shouldn't care much about these objects possibly being corrupted.

For what it's worth, I am fine having a mode of repack which allows us
to remove objects that we know are stored by a promisor remote. But this
series doesn't do that, so users could easily run `git repack -d
--filter=...` and find that they have irrecoverably corrupted their
repository.

I think that there are some other reasonable directions, though. One
which Robert and I discussed was making it possible to split a
repository into two packs, one which holds objects that match some
`--filter` criteria, and one which holds the objects that don't match
that filter.

Another option would be to prune the repository according to objects
that are already made available by a promisor remote.

An appealing quality about the above two directions is that the first
doesn't actually remove any objects, just makes it easier to push a
whole pack of unwanted objects off to a promsior remote. The second
prunes the repository according to objects that are already made
available by the promisor remote. (Yes, there is a TOCTOU race there,
too, but it's the same prune-while-pushing race that Git already has
today).

> I am not against a name and some docs that strongly state that users
> should be very careful when using such a command, but otherwise I
> think such a command is perfectly ok. We have other commands that by
> design could lead to some objects or data being lost.

I can think of a handful of ways to remove objects which are unreachable
from a repository, but I am not sure we have any ways to remove objects
which are reachable.

> > But as it stands right now, I worry that this feature is too easily
> > misused and could result in unintended repository corruption.
>
> Are you worrying about the UI or about what it does?
>
> I am ok with improving the UI, but I think what it does is reasonable.

I am more worried about the proposal's functionality than its UI,
hopefully my concerns there are summarized above.

Thanks,
Taylor
