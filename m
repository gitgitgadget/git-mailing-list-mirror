Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4750AC00528
	for <git@archiver.kernel.org>; Thu, 27 Jul 2023 17:56:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230440AbjG0R4H (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jul 2023 13:56:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229778AbjG0R4D (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jul 2023 13:56:03 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17392685
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 10:56:02 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-583d63ca1e9so13153897b3.1
        for <git@vger.kernel.org>; Thu, 27 Jul 2023 10:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690480562; x=1691085362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Uxc3dklyOvk+mS+dzTERaEpCD0uZuP6xopFuZZLI+E=;
        b=KVBwP4URywx7a1rmDJkt1mWVnaes5lz7JqU+tz1U3aM90betAYgl1gKcnFe1O3rgWM
         fwVkY4QW2MGgZPaKDMRuIHgTju9rpXRk8C5q3C3pt7KykiF1svelRtcrua4H546cvtZV
         Tp3mEIZLHQFRk2tOr1j4OMov6PBTS/lpsZwB7Ytnbfc+0C5aJEDRB99PHAf8a4/X8yfo
         AZ9GB92cmkiCPO38R5EIzbAKyPurur3e+i0iAiC9RvFis3qHPLjiKBS6HgAvbB5LqtKH
         c0JsJkL61T4VGmHkrWK97MJC3OAmONjooXoqpKAAvbPCQPxer+y0z3Jb/xKsR1zbVYrj
         UMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690480562; x=1691085362;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Uxc3dklyOvk+mS+dzTERaEpCD0uZuP6xopFuZZLI+E=;
        b=ElmI162F1Bl5EVQu7AyEOeNUYEVVdysWr8w2H0n5Bu2yXp579lsPWe4Au1097u2mfp
         ETA662JqJytbs7BaOb3bv9R+ixi2CdD8u4sBM38a3pKBcSzCktSFrFT3MNgggI8Sr4R9
         hfvbUnETfhxVq2cWDdENOcxCmWIzskFSI7BmVrd8VHEwt++LJmCB8vkwsezNQXkfLKdh
         qSTrk8Fl0U3D/daU6fEK33xkJ4ht7YljR3cF9qjzCFJ7eVZHwduMqYy4rZuzW88KsteG
         7ZwKPbE8mAiofqQGp8iV2b3519SpoleAdM/c4cJwwjNzOOqCb6UX1pPpPZK2ZiHi2T8t
         Xy+w==
X-Gm-Message-State: ABy/qLbzpcGtXh+fo+pOxz/VYAEPShlpfJWtyyLNtHL1uOvDLmVfQhWY
        JZ9CPgzcsdWvGL9SiJl81zUyug==
X-Google-Smtp-Source: APBJJlG2kKpP0GsXDlTDrxBkhS3ym97wEp6ZUeMUKS/T84fNRFhi1ZVBuU8CZkIIW8Uk2LyblrdaIA==
X-Received: by 2002:a0d:fe86:0:b0:570:77b3:1c78 with SMTP id o128-20020a0dfe86000000b0057077b31c78mr20994ywf.25.1690480562141;
        Thu, 27 Jul 2023 10:56:02 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r64-20020a0dcf43000000b00583803487ccsm535296ywd.122.2023.07.27.10.56.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 10:56:01 -0700 (PDT)
Date:   Thu, 27 Jul 2023 13:56:00 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v6 0/7] Changed path filter hash fix and version bump
Message-ID: <ZMKvsObx+uaKA8zF@nand.local>
References: <xmqqzg3ib2ma.fsf@gitster.g>
 <20230727173905.356292-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230727173905.356292-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 27, 2023 at 10:39:05AM -0700, Jonathan Tan wrote:
> A test should be doable - we already have tests (the ones that use
> "get_first_changed_path_filter") that check the bytes of the filter
> generated, so we should be able to write a test that writes one version,
> writes the other, then checks the bytes.

Thanks for looking into it!

> > > So I think we want to be more careful about when we load the existing
> > > Bloom data or not. I think we probably want to load it in all cases, but
> > > only read it when we have compatible Bloom settings. That should stop us
> > > from exhibiting this kind of bug, but it also gives us a handle on
> > > existing Bloom data if we wanted to copy forward existing results where
> > > we can.
>
> The intention in the current patch set was to not load it at all when we
> have incompatible Bloom settings because it appeared quite troublesome
> to notate which Bloom filter in memory is of which version. If we want
> to copy forward existing results, we can change that, but I don't know
> whether it's worth doing that (and if we think it's worth doing, this
> should probably go in another patch set).

Yeah, I think having Bloom filters accessible from a commit-graph
regardless of whether or not it matches our Bloom filter version is
prerequisite to being able to implement something like this.

I feel like this is important enough to do in the same patch set, or the
same release to avoid surprising operators when their commit-graph write
suddenly recomputes all of its Bloom filters.

Since we already store the Bloom version that we're using in the
commit-graph file itself, shouldn't it be something along the lines of
sticking that value onto the bloom_filter when we read its contents?

Although I don't think that you'd even need to annotate each individual
filter, since you know that every pre-existing Bloom filter you are able
to find has the version given by:

    the_repository->objects->commit_graph->bloom_filter_settings->hash_version

right?

Thanks,
Taylor
