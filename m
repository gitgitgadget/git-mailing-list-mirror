Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 816F9EB64D8
	for <git@archiver.kernel.org>; Thu, 22 Jun 2023 11:05:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231726AbjFVLFw (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jun 2023 07:05:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbjFVLFW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jun 2023 07:05:22 -0400
Received: from mail-vk1-xa33.google.com (mail-vk1-xa33.google.com [IPv6:2607:f8b0:4864:20::a33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 675121FDD
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 04:05:21 -0700 (PDT)
Received: by mail-vk1-xa33.google.com with SMTP id 71dfb90a1353d-4753de0807dso855490e0c.2
        for <git@vger.kernel.org>; Thu, 22 Jun 2023 04:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687431920; x=1690023920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=U2HB30LqJ383E4R7zYcyf11X2vVfZLvFQvRdGN3nGbA=;
        b=O1R06bS07rJSp8FAiIbO0N5aEqWtZwg5ToSZAAA/b9ZnsAGOxhqnr6abRb1NKPPX+S
         5RhNOOg8PvFZkzU7PSennrM3ij8p/WDrVndbnyCNNZRo9zL98ypuZ/kJrtkeq0Y+jXWU
         cnv0WaNxNg/hZWHiAPXxcRdp6S7wz+koW40lzBL8Gg+wmu67bKUw/WsV7s8C5xgJNeED
         KgsBvYD5OJwrh74rkLA4NewVHNNE+PGj1QGBqMZcChVw5rytw9aCC9/bWe+/bLKWZ2nU
         lBlUnjcoUVzJM0sW62E47mu9zb5/uVfMv76p+OgNmTLIsd+9rJOgyMJ/8TRI8EgXDezK
         RWuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687431920; x=1690023920;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U2HB30LqJ383E4R7zYcyf11X2vVfZLvFQvRdGN3nGbA=;
        b=Y4xYF5FCJyxBEMOopGTlrdnMlmOOc8bD9oliTxtRz6vPpsvIEY5sFFPdQ6k+IRxJMG
         psRBugnbKgGCalERK+REFYGs9jXkpZjH5J2uUvAs6e+Kn7Me62D1w7pDT1zalUYNjo3+
         vvWCkxFxAVRABNkZAoIsyPnHcJ9LdOuGWydw9reNi9LxdtLT3Sx+CGP7uSmAz6VC7h8r
         MafwlyyjXrD2xSJ9zxDUc3OUTUsoQ266XKub+YtBPg0ehrJwIPQGrRh6/Y8aTeFiuU8Q
         fg4Ccy1WTchLcBqPTiS7X+okJ2ex/DC1nQF7wgoUUbebrgNrcEl7XeZLK07JmTt0GTDq
         9pSQ==
X-Gm-Message-State: AC+VfDzmYOhvgUhZrPCCIeSgBrzVsi/iGvVYr+KpXj1XaN/o+biqLgu3
        7vVCp8HSYpzgc4wVwA6o5yb0vA==
X-Google-Smtp-Source: ACHHUZ78z6f2DR/P0NGjcai+qRvB8KVj6utTZKcpHK2zFT2H52GFyEDuQv35Cdz1t8771rN4bdziKQ==
X-Received: by 2002:a1f:c401:0:b0:471:6345:7c40 with SMTP id u1-20020a1fc401000000b0047163457c40mr7040001vkf.13.1687431919043;
        Thu, 22 Jun 2023 04:05:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d11-20020a814f0b000000b00568b941e5e3sm1759637ywb.72.2023.06.22.04.05.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jun 2023 04:05:18 -0700 (PDT)
Date:   Thu, 22 Jun 2023 07:05:15 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
Message-ID: <ZJQq64eOkOxh8Qyt@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-7-christian.couder@gmail.com>
 <xmqqmt10s0cw.fsf@gitster.g>
 <ZJLdBHNFPfxHp3C0@nand.local>
 <CAP8UFD0PY283_C3K8N1cE=Rc98W7CfMArD5kzSnO-6yBqM3sTw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD0PY283_C3K8N1cE=Rc98W7CfMArD5kzSnO-6yBqM3sTw@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 05:04:48PM +0200, Christian Couder wrote:
> On Wed, Jun 21, 2023 at 1:20 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Thu, Jun 15, 2023 at 05:43:27PM -0700, Junio C Hamano wrote:
> > > Christian Couder <christian.couder@gmail.com> writes:
> > >
> > > > After cloning with --filter=<filter-spec>, for example to avoid
> > > > getting unneeded large files on a user machine, it's possible
> > > > that some of these large files still get fetched for some reasons
> > > > (like checking out old branches) over time.
> > > >
> > > > In this case the repo size could grow too much for no good reason and a
> > > > way to filter out some objects would be useful to remove the unneeded
> > > > large files.
> > >
> > > Makes sense.
> > >
> > > If we repack without these objects, when the repository has a
> > > promisor remote, we should be able to rely on that remote to supply
> > > them on demand, once we need them again, no?
> >
> > I think in theory, yes, but this patch series (at least up to this
> > point) does not seem to implement that functionality by marking the
> > relevant remote(s) as promisors, if they weren't already.
>
> Yeah, it's not part of this patch series to implement all the features
> that could be useful in the case of promisor remotes. This patch
> series only hopes to implement a `repack --filter=...` option that can
> help in a number of different use cases. I'm open to opinions about
> whether or not the doc and commit messages should talk, and how much,
> about use cases related to promisor remotes.
>
> > > [...] It does smell somewhat similar to the cruft packs but not
> > > really (the choice over there is between exploding to loose and
> > > keeping in a pack, and never involves loss of objects).
> >
> > Indeed. `pack-objects`'s `--stdin-packs` and `--cruft` work similarly,
> > and I believe that we could use `--stdin-packs` here instead of having
> > to store the list of objects which don't meet the filter's spec. IOW, I
> > think that this similarity is no coincidence...
>
> Yeah, I agree that we could use `--stdin-packs` to implement `repack
> --filter=...`. I am just not sure it's the best path forward
> performance wise in the long run. So others' opinions are welcome
> about that.

I think it would almost certainly have comparable performance in most
cases, and significantly better performance in large repositories. IIUC,
the current system has to remember the OID of every object which did not
pass the filter, and then construct a pack containing just those
objects.

It would be nice from a memory-savings perspective to not have to
remember these OIDs. But it also just seems error prone to me to do so:
what if we lose an OID, or reorder the list?

I dunno. I feel pretty strongly that implementing this in terms of:

  - Write a filtered pack.
  - Construct the list of existing packs (marked with '-') and the
    filtered pack.
  - Pass that as input to `git pack-objects --stdin-packs`
  - If '-d' given, delete any existing pack(s).

Thanks,
Taylor
