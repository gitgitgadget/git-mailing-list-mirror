Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C123EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 15:10:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233235AbjFUPKk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 11:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjFUPKW (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 11:10:22 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FCB4EFF
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 08:05:38 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3f8fb0e7709so58899995e9.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 08:05:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687359901; x=1689951901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tpzERtMV+2Nz3y5lvrI8GwvAO7JwhIXbhDL1TNXQ59Q=;
        b=rIBvGivwVjJTbp1c6sKMkmwtNrnlfaeuRSXfwkh4zpNJosfZ/Fg2qlkJqnRjeoIjuZ
         nV6Y8MlZ4Vp63U5n0EgO6GF93kRhXUFsFRpdt76s2a2bgar5YxoVQFtuqHVQU3jxBw2L
         DfLWYH7SKIm6XFhdxUYvgf6/q21eSKdhC45DHJyVglsvmxYlhrj6SwGb0cCMbrN2u9zu
         o+FZ1UHe7BEa/PIrEDE9OnxpxZCwHf0M70ztZbH7uM6uo/XfkzS+17DgQxnG0M/iS6kO
         0DQxdbG3qEzgghvH3D7KCkfV7PgPfJR9mPgChQ9irdZlp5QRn9BvPCBy1JeKLg/ajMoa
         9tUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687359901; x=1689951901;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tpzERtMV+2Nz3y5lvrI8GwvAO7JwhIXbhDL1TNXQ59Q=;
        b=doVY4qAthm2IjNrCNx4RX7lzHHVwtdho8A0eMMG3Kb4or8jt4rak1gcR9pxeTk0wHI
         kYSIjQ5lvAxYqrxptz6PNYmbnSF7fL6wdn7zQ6LBP88c6mDyCpFECcXfwCIKRYBC0qXj
         6ztZO+EDiPrjg5mDcn8KSmqdl1F0AZj02v/1DW22uum4U81EitX0CaKw21tCZGI5JwOX
         Cnfzp6i1eXS+7CO1yrgOHMQxwAIndiA60VS/OPVkPqcyZDuWljDtJQSGCBG20DZc8IPm
         tlojfg00dO2CtFGvNNIEFGvpXdTUca71viokDlgRv2pi+xY1lZ2IKV0iybGtKdoKpGsX
         dxOw==
X-Gm-Message-State: AC+VfDwQZtiu3DEly/XK1+bGlE9Dxil3TOXJJamlT4MkZnIpXHefIXyW
        8xm98byoN7sTvZKpBJSl0GGNh5rEXiHYqhqDiSk=
X-Google-Smtp-Source: ACHHUZ7TuG752Vlv9AEdtz7321h4xr+q6J5hEgiHaxCJUnN7c9czdPyrGAggpMCZ+rDcR5ePlp40Wr0lSYjHWsk/efQ=
X-Received: by 2002:a1c:7c0a:0:b0:3f9:b58:df5f with SMTP id
 x10-20020a1c7c0a000000b003f90b58df5fmr8676205wmc.41.1687359900849; Wed, 21
 Jun 2023 08:05:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-7-christian.couder@gmail.com> <xmqqmt10s0cw.fsf@gitster.g>
 <ZJLdBHNFPfxHp3C0@nand.local>
In-Reply-To: <ZJLdBHNFPfxHp3C0@nand.local>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Wed, 21 Jun 2023 17:04:48 +0200
Message-ID: <CAP8UFD0PY283_C3K8N1cE=Rc98W7CfMArD5kzSnO-6yBqM3sTw@mail.gmail.com>
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 1:20=E2=80=AFPM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> On Thu, Jun 15, 2023 at 05:43:27PM -0700, Junio C Hamano wrote:
> > Christian Couder <christian.couder@gmail.com> writes:
> >
> > > After cloning with --filter=3D<filter-spec>, for example to avoid
> > > getting unneeded large files on a user machine, it's possible
> > > that some of these large files still get fetched for some reasons
> > > (like checking out old branches) over time.
> > >
> > > In this case the repo size could grow too much for no good reason and=
 a
> > > way to filter out some objects would be useful to remove the unneeded
> > > large files.
> >
> > Makes sense.
> >
> > If we repack without these objects, when the repository has a
> > promisor remote, we should be able to rely on that remote to supply
> > them on demand, once we need them again, no?
>
> I think in theory, yes, but this patch series (at least up to this
> point) does not seem to implement that functionality by marking the
> relevant remote(s) as promisors, if they weren't already.

Yeah, it's not part of this patch series to implement all the features
that could be useful in the case of promisor remotes. This patch
series only hopes to implement a `repack --filter=3D...` option that can
help in a number of different use cases. I'm open to opinions about
whether or not the doc and commit messages should talk, and how much,
about use cases related to promisor remotes.

> > [...] It does smell somewhat similar to the cruft packs but not
> > really (the choice over there is between exploding to loose and
> > keeping in a pack, and never involves loss of objects).
>
> Indeed. `pack-objects`'s `--stdin-packs` and `--cruft` work similarly,
> and I believe that we could use `--stdin-packs` here instead of having
> to store the list of objects which don't meet the filter's spec. IOW, I
> think that this similarity is no coincidence...

Yeah, I agree that we could use `--stdin-packs` to implement `repack
--filter=3D...`. I am just not sure it's the best path forward
performance wise in the long run. So others' opinions are welcome
about that.

Also, as Junio said, this patch series is not responsible for the fact
that traverse_commit_list_filtered() stores oids into an oidset
instead of using a callback function. Fixing this would likely avoid
accumulating oids in memory. And creating a packfile by sending oids
into pack-objects is something that is already done by
repack_promisor_objects(). So even if `--filter=3D...` is not reusing
`--stdin-packs`, it is still reusing a lot of existing mechanisms.

Thanks,
Christian.
