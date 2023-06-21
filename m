Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BE9DEB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 11:54:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230464AbjFULym (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:54:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbjFULyk (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 07:54:40 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB784170A
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:54:36 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-561b7729a12so100652787b3.1
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:54:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687348476; x=1689940476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=clD4vu5VXzW3jXAmzzn/Km7VY/f/Tz9e5CliyY6vpPc=;
        b=c8WP/1n0vxnMsS3iIPxLSkqR7uj45/3w97VEd3DxdBq76Bs1aeT0+FhpgkgKKlL4iJ
         93KwBXHSJc778cGs5z5G0eR5UFqAH+Ed5Wru2LLUmJTe2cmQv3dDix2HDVoWgddFRU3O
         sqFj8rEeS189AbDBXynFXfoE77NG+AMHZCXUxvKXk8I0QXZmQ9CRmYMagUsXKfZ3JD2e
         FoQ+wON32t5knoMy3e8wyjDjCQUf14SsMvyg7Bgj1Jwi4XhGnaEUYkHiMPgrVmEDX2uP
         jj8KA+6t+i6ajDJ61i8VBtymIn9XDatIhSyMjYGGbiqIXFjyXMaRRxzuTi5oWCxuAVTs
         +RRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687348476; x=1689940476;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=clD4vu5VXzW3jXAmzzn/Km7VY/f/Tz9e5CliyY6vpPc=;
        b=b34yVaFbjHgjy3yCzY74zN5qTCmN+KDir6vurR6ANDdVqINuEejwYUXOWBqXSSzXPF
         f/pC/TsgzGW4yu2YZzGTgwxu3vhSpxfewrupgSX+7HW7BdOn7aOATAbEn1rNoqbAbhCE
         A9EhFTEhCOJ2c5nZlnaFB0+a6wU9Ho9amiEZIoJ2JXT6vfq/iEzk9EBDw0xFBtG6+ue9
         DWN1ezo9E81V8d2Zmbzw6px4Aino7B32v8I3pv+4gR+hQWFNtBbgyGcz7RkPpPU4EaOY
         Gq7FP9uaoPC8wxGPG9zERLbMSv00oMEJ+GJ5b0gIbZ+cx+izTMYNy6LdrzO3VO0brR3/
         i71A==
X-Gm-Message-State: AC+VfDxXhNmat1L25q3FkrZWHFKLOepJ5MKb7me6PS60mK7G/8+rYhSC
        tU4Utn3exk/weLyomEYf0gwFtg==
X-Google-Smtp-Source: ACHHUZ6iZo5ZM2ohhIYybyjpWYSojvQ8hFWszpug26mDgCUYnLXVN1wyCLe96iO6DChqIsI6wjmn8Q==
X-Received: by 2002:a81:848e:0:b0:56d:1ca0:fa55 with SMTP id u136-20020a81848e000000b0056d1ca0fa55mr14668346ywf.25.1687348476068;
        Wed, 21 Jun 2023 04:54:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id n205-20020a0dcbd6000000b0057064c14d14sm1072767ywd.11.2023.06.21.04.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:54:35 -0700 (PDT)
Date:   Wed, 21 Jun 2023 07:54:32 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Christian Couder <christian.couder@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 2/9] pack-objects: add `--print-filtered` to print
 omitted objects
Message-ID: <ZJLk+IMOHRrlpNho@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-3-christian.couder@gmail.com>
 <xmqq7cs4uyqe.fsf@gitster.g>
 <ZJLWgfCNoqE6xNqq@nand.local>
 <CAP8UFD1cAMg-54YTmW6N9sbi3KKs2OmPRz7zshWDGkStgiZnUQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP8UFD1cAMg-54YTmW6N9sbi3KKs2OmPRz7zshWDGkStgiZnUQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 21, 2023 at 01:11:38PM +0200, Christian Couder wrote:
> On Wed, Jun 21, 2023 at 12:52 PM Taylor Blau <me@ttaylorr.com> wrote:
> >
> > On Thu, Jun 15, 2023 at 03:50:17PM -0700, Junio C Hamano wrote:
>
> > > Makes sense.  It is a bit sad that we have to accumulate everything
> > > until the end at which time we have to dump the accumulated in bulk,
> > > but that is a current limitation of list-objects-filter API and not
> > > within the scope of this change.  We may in the longer term want to
> > > see if we can make the collection of filtered-out objects streamable
> > > by replacing the .omits object array with a callback function, or do
> > > something along that line.
> >
> > Hmm. I think it is possible to use something like `git pack-objects`'s
> > `--stdin-packs` mode to accomplish this without needing to keep track of
> > the set of discarded objects (i.e. those which don't match the filter).
> >
> > IIUC, the set of objects which don't match the filter is the same as the
> > set of all objects in packs beforehand, differenced with the set of
> > objects that shows up in the pack containing objects which *do* match
> > the filter.
> >
> > If you mark all of the "before" packs with `-` in the input to
> > `--stdin-packs`, and then pass along the pack containing the filtered
> > set without `-` (to indicate that the resulting pack should not contain
> > any objects which appear in that pack), I think you would end up with
> > the set of non-matching objects.
>
> I agree that it can be done like this, but I am not sure it's very
> efficient to do it like this. When we create the pack with filtered
> out objects, we know the set of objects we filtered out, so it doesn't
> seem efficient to make `git pack-objects --stdin-packs` read more
> packfiles or their indexes than necessary and compute that set of
> objects again.

Discovering that an object appears in one of the packs whose objects
we're excluding from the resulting pack is extremely cheap, since we
have a cache of just those packs (see the call to
`has_object_kept_pack()` in `want_found_object()`).

I'd think that in small cases the performance is probably worse, though
the working set would be small enough for the differences to not matter
that much in absolute terms.

In cases with many objects, storing all of their OIDs in memory would be
a pain.

Thanks,
Taylor
