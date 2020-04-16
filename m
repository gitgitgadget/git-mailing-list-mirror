Return-Path: <SRS0=FNL0=6A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BC09C2BB55
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 00:52:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 69AE4208E0
	for <git@archiver.kernel.org>; Thu, 16 Apr 2020 00:52:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="vUbDskDz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405196AbgDPAwv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Apr 2020 20:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405170AbgDPAwp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Apr 2020 20:52:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AB25C061A0C
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 17:52:44 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a32so595180pje.5
        for <git@vger.kernel.org>; Wed, 15 Apr 2020 17:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=2zrNzW0++4+A+szm5FfFFzC2C9b8eRKqIQNhPSdBhlI=;
        b=vUbDskDz8J3Im55nt3MGjBO9m44GZUJwUYVT9GICm6AsBUD10QWoWp3McLLicguCBq
         3fAHkp/f3WT7Wm9B9a9/vhTtj+URUxGbanab+tY3wywZjTpLSPdEkXts/78k/29f72Kf
         t5RD0MpOK7n8L/fVJ/omGhS5R2qEP2WWr69BabOKe+63/VzWSbcv2TiQUaC7NPchxG4e
         7GxzA9FrG0ISzK6SKmwzFChsKaJd/0uAGTyidnPC8Z/1hkX4WS/hakzdSN5/IOhyNDYW
         tBXgWH+vRjGdr50OIZHjAIQiXH3wg3+hNPNbSeUPORJrHZ/5Cuh9Y0N9ImK6qVFhXnkR
         Jrdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=2zrNzW0++4+A+szm5FfFFzC2C9b8eRKqIQNhPSdBhlI=;
        b=jescJGAb/ig80NH68HjYdlBhrcIabqxqnPCRgrHwSohRYI3EOLx0w77uZ2kSIydEx/
         v0IOdXOJrXKTE86act91OmKoRGKB55SfRgtiryXxFK0dUGROpC6Syiy5tAyZXUrc10Kw
         T4fYE32kLwjhZrt59QJAwJQjK+DZD3Q4EIYX5kPLZ8Yw1beTEBKu9D7IOxO63g6XP1T3
         Lks68fRVPJS2IeiJYhz4KVsrQqJyxeh/LkjVv8o0Ox/5LT1rN/UjbADBffo+Op7eJBz9
         GUziHwlt2CSEgZai/aHXvSHctB8vAFwQLty24NsDohyugS89NInV4wQcvTCqiJT3Knmh
         1y0g==
X-Gm-Message-State: AGi0PuZ0uxzlFseYhTtAPM2QmiU7yBo3MMmZ4mF/BEEAg8RA6LpX2WtS
        +SByvU4IiZFflyGbO8QLwe5gtA==
X-Google-Smtp-Source: APiQypKZ5J7QSCrb3cc1dLLeS5wRirTg0A+7LBFLg08l6XLd9MXORMRwLkZ5A2M0EFiYL+qevBxk2Q==
X-Received: by 2002:a17:90a:ec02:: with SMTP id l2mr2039618pjy.126.1586998364058;
        Wed, 15 Apr 2020 17:52:44 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id a13sm15198058pfc.26.2020.04.15.17.52.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2020 17:52:43 -0700 (PDT)
Date:   Wed, 15 Apr 2020 18:52:41 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jakub =?utf-8?B?TmFyxJlic2tp?= <jnareb@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Taylor Blau <me@ttaylorr.com>,
        Garima Singh <garimasigit@gmail.com>,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 1/3] revision: complicated pathspecs disable filters
Message-ID: <20200416005241.GB36156@syl.local>
References: <pull.609.git.1586566981.gitgitgadget@gmail.com>
 <9cc31c289aa785f026eec84452ed68e80505d95e.1586566981.git.gitgitgadget@gmail.com>
 <xmqqeesthfbf.fsf@gitster.c.googlers.com>
 <44ce43e2-6cf0-0e48-18eb-f02543d81bf4@gmail.com>
 <xmqqmu7d9b6j.fsf@gitster.c.googlers.com>
 <f57c7908-55ae-deae-e9ea-1909549e628c@gmail.com>
 <99e0ae2c-6b65-24e4-3d2b-1dff619a5daa@gmail.com>
 <CANQwDwdcM-hc+Nyc0nBnp79W0BuH2PfdgM6WLqET3sPn1GYc-A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CANQwDwdcM-hc+Nyc0nBnp79W0BuH2PfdgM6WLqET3sPn1GYc-A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 16, 2020 at 12:18:33AM +0200, Jakub Narębski wrote:
> On Wed, 15 Apr 2020 at 20:37, Derrick Stolee <stolee@gmail.com> wrote:
> [...]
> > -->8--
> > From 89beb9598daabb19e3c896bbceeb0fc1b9ccc6ca Mon Sep 17 00:00:00 2001
> > From: Derrick Stolee <dstolee@microsoft.com>
> > Date: Wed, 15 Apr 2020 18:04:25 +0000
> > Subject: [PATCH] bloom: compute all Bloom hashes from lowercase
> >
> > The changed-path Bloom filters currently hash path strings using
> > the exact string for the path. This makes it difficult* to use the
> > filters when restricting to case-insensitive pathspecs.
> >
> > * I say "difficult" because it is possible to generate all 2^n
> >   options for the case of a path and test them all, but this is
> >   a bad idea and should not be done. "Impossible" is an appropriate
> >   alternative.
> >
> > THIS IS A BREAKING CHANGE. Commit-graph files with changed-path
> > Bloom filters computed by a previous commit will not be compatible
> > with the filters computed in this commit, nor will we get correct
> > results when testing across these incompatible versions. Normally,
> > this would be a completely unacceptable change, but the filters
> > have not been released and hence are still possible to update
> > before release.
> >
> > TODO: If we decide to move in this direction, then the following
> > steps should be done (and some of them should be done anyway):
> >
> > * We need to document the Bloom filter format to specify exactly
> >   how we compute the filter data. The details should be careful
> >   enough that someone can reproduce the exact file format without
> >   looking at the C code.
> >
> > * That document would include the tolower() transformation that is
> >   being done here.
>
> Why not modify the BDAT chunk to include version of
> case folding transformation or other collation algorithm
> (other transformation).that is done prior to computing
> the Bloom filter key? Though that might be unnecessary
> flexibility...

If this ends up being something that we want to do, I agree with
Stolee's reasoning that this should be a breaking change. If we were,
say, several months into having Bloom filters in a release and decided
at that point to make the change, then: sure, supporting both by writing
a bit in the BDAT chunk makes sense.

But, we're many months away from that state yet, and so I don't think
the cost of rebuilding what few commit-graphs exist with bloom filters
in them today to support both ordinary and lower-cased paths in the
filter.

Anyway, I'm still not sold on this idea in general (nor do I understand
it that others are), so I'll respond in more detail in another part of
the thread...

> For example the value of 0x00 in such field of BDAT
> chunk header would mean no transformation, while
> the value of 0x01 would mean per-character tolower()
> or Unicode equivalent of it.
>
> Best,
> --
> Jakub Narębski

Thanks,
Taylor
