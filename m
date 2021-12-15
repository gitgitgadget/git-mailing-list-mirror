Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1D46CC433EF
	for <git@archiver.kernel.org>; Wed, 15 Dec 2021 21:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229883AbhLOVhr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Dec 2021 16:37:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbhLOVhq (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Dec 2021 16:37:46 -0500
Received: from mail-qv1-xf32.google.com (mail-qv1-xf32.google.com [IPv6:2607:f8b0:4864:20::f32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F3C06173E
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 13:37:45 -0800 (PST)
Received: by mail-qv1-xf32.google.com with SMTP id m6so4404240qvh.10
        for <git@vger.kernel.org>; Wed, 15 Dec 2021 13:37:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=hLbZ3qp1LYQyUccEnWPAyWiWi/7Q9WtUf09gq+DsArw=;
        b=mqAyF2zjdUBOC6NMU3k3LQd4htLV1L4JSJ7Rg0W06wKWRbXIY32Pg+1ashSyQUFrVB
         5hgLWjyT6nRymLnwg8uo8Fj873k/y9p8D2thZeK83SI4/2FJmKVhYlzrtzAKDZ7kPO5O
         MLTJ4rVZwJiYETsSywa4H4Fw1dXL54IxVVqReFKbsL2TrS2ccJFXIDpPyBTvnRtsIvGH
         lF065p/+8FNdPXBoZqCCD1rQFSTyudnOEfvo9B8X3HQUWtuPhe0Dj08EXoLjFmwaJ5zh
         fsIQNPeK4/pmDci1jrA9O8EOYFxZFumvosjIAakmH+qgwDlsqkTSyfFG5R3kgRysIiKG
         RgpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=hLbZ3qp1LYQyUccEnWPAyWiWi/7Q9WtUf09gq+DsArw=;
        b=6NUx/cG7dKzJaXtnJQWLtRHQ81SbEK/HwCm4HdHilgynpt/Ksz1AkjS5wg3FPqmqPO
         Rp7uKL9UR2e3bqGUb9VHgVrIbYhUYdWnQ++K0bTAZ16xqGLTVUH3Sx7X8rxEz8x/L1NH
         /BMkr//HdyKraSFljg07c/fVreUC0puELiPeJVMrkEMiqdCHTY/FShhog9Xi4BMMOF2F
         cDKGaYDJATJJBHkhrbnGLcFcfFHjCKqFMXv96MYyBWXovuJazHL1+P5GzesbnOOCGxMS
         8J+SIygf3kPPekPfCXun1o1Ea4NO0YZxFlj4GYqqeXltdrWFFxHqXtZ4QhSVDW7SBRwu
         M5mA==
X-Gm-Message-State: AOAM5320Vq9cMZl5oKf/ce3pCKR/fAJmvDa8njWdSjcG3V3tlmXhWoaL
        A2cCS4gvPX4VTaOkO8BvcMNJiyEVOfVAzLAU
X-Google-Smtp-Source: ABdhPJzvQHsNPqld1bA2O0Y63WPqxgvtV5oc+vnefPHGoMifEzWo5qhu3J2m4sZt0AqvalNfVOuVFA==
X-Received: by 2002:a05:6214:d84:: with SMTP id e4mr13549599qve.128.1639604264922;
        Wed, 15 Dec 2021 13:37:44 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h11sm1692739qko.18.2021.12.15.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 13:37:44 -0800 (PST)
Date:   Wed, 15 Dec 2021 16:37:32 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org, peff@peff.net,
        stolee@gmail.com
Subject: Re: [PATCH v2 0/8] midx: prevent bitmap corruption when permuting
 pack order
Message-ID: <YbpgHBcyq/2+nLJB@nand.local>
References: <cover.1638991570.git.me@ttaylorr.com>
 <cover.1639446906.git.me@ttaylorr.com>
 <xmqqee6d648n.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqee6d648n.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 15, 2021 at 11:46:16AM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > Here is a reroll of my series which fixes a serious problem with MIDX bitmaps by
> > which they can become corrupt when permuting their pack order.
>
> This seems to depend on tb/cruft-packs that is not yet in 'next', so
> I'll redo this topic branch by forking it at 'master', merging the
> other topic in, and then queuing these 8 patches.

Hmm. They shouldn't depend on that topic. My local copy depends on
abe6bb3905 (The first batch to start the current cycle, 2021-11-29), but
I'm happy to rebase things if basing on abe6bb3905 was a mistake.

> > So I'm definitely open to suggestions there, but otherwise this series should go
> > a long ways towards fixing my design mistake of having the MIDX .rev file be
> > separate from the MIDX itself.
>
> Yeah, a single file with different chunks is a good way to ensure
> atomicity of update.
>
> A note to reviewers.
>
> We need to make sure that not just we can still read .rev in
> existing repositories (and convert it to the new chunk) correctly,
> but also decide what to do to older versions of Git once the
> repository is touched by this new version.  Would they be upset to
> see no .rev files or is it just the performance thing (and it is
> more correct to recompute the reverse index on the fly)?  Should the
> new chunk be made mandatory to cause them notice that they should
> not muck with the repository, or is it optional?  Things like that.

An old client that is looking in a repository where the reverse index is
stored as a chunk inside of the MIDX (and does not appear as a separate
file on disk) will not be able to read the MIDX's bitmap. We could
compute the reverse index on the fly (as we did for a long time with
single packs) but it is slow, and older clients obviously would not know
how to do it.

But the failure is graceful(ish): we'll get a warning that says we
couldn't find a reverse index, and then carry on pretending that the
MIDX did not have a bitmap.

    ~/s/git [nand] (master) $ git.compile multi-pack-index write --bitmap
    Selecting bitmap commits: 73008, done.
    Building bitmaps: 100% (319/319), done.
    ~/s/git [nand] (master) $ rm -f .git/objects/pack/multi-pack-index-*.rev
    ~/s/git [nand] (master) $ git.compile rev-list --count --objects --use-bitmap-index HEAD
    warning: multi-pack bitmap is missing required reverse index
    warning: ignoring extra bitmap file:
    .git/objects/pack/pack-00465554dc3f3d96ac89a0ecc73cb5f5abbb35a5.pack
    warning: multi-pack bitmap is missing required reverse index
    warning: ignoring extra bitmap file:
    .git/objects/pack/pack-00465554dc3f3d96ac89a0ecc73cb5f5abbb35a5.pack
    307913

As far as whether or not the chunk is necessary, it only *needs* to be
present in the MIDX if there is a corresponding MIDX bitmap. We could
generate it always, but this series keeps in the tradition of the .rev
file and only writes it when we are also writing a bitmap.

> Thanks.

Thanks,
Taylor
