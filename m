Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 186A4C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:40:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E49ED6108E
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 21:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344806AbhIAVlW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 17:41:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhIAVlV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 17:41:21 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0FD0C061575
        for <git@vger.kernel.org>; Wed,  1 Sep 2021 14:40:24 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id z1so1025411ioh.7
        for <git@vger.kernel.org>; Wed, 01 Sep 2021 14:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IkAnwZ8QLUljxmaVhhXdPwQ4sm3yo/IDvxFU/7VxUh8=;
        b=pdG2WtBvwPwhb8vTz0w5oczaqbzoudOLYcbEu13uMtOUEtpw8xQhoyrKEL6CUu0i9U
         gjc7S7QEbDqBtoqc3cve/KfBXhQXF/lGDLdNTat6ZUM9QMM/6tjLHSZgCzmlwuF0KjhR
         MeCGU91dqkd4DCqizNnZzX4sgz9TCPHCuX5zmkcptQjWtqWe9IxqodAlRaiCHyToANnv
         7CgGbgY51v7J1wE4cHKLOmX6oQqgUr0jm+oEAHNR4Xszi8Am948vNwy6e5TcySyXgE6N
         rMdUPfsz/NR/q7w0ehmEC4A0JT100H/tuJy6Ey3s4qEg5Id8a4QqX+d5bZnTK2luLu9C
         OgYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IkAnwZ8QLUljxmaVhhXdPwQ4sm3yo/IDvxFU/7VxUh8=;
        b=JyuNWrmWRiCq6F7GEWXlUmibCV6cTxxMFRGh69VjruqARnNU5lCTBvjQvyZeFtw43F
         c2KudgHwct5eFYqEF8ZDKb9htVRA4LbKh9BxB5rjgWnixM/mvLXZDlvoMssrpD8m0H2E
         Sz8G6ECw15nmmFEie/Btq9+0H6DOcgX4ZZKK2n2fN1vugqqoiUleA9apt+m6/2rf2PT8
         mjUbXa3tyvtpb2N4sfW75FFR3rH7LmP3F52YhzZKapdoceSHw50vYms3L7DNpcZxX1OK
         eoJT5ubbsyqbLbv9lUGHweA3Fap6aAZrCybdhbDJBDImBedZRoNypF5AV8PGhVp+sUTP
         uuhw==
X-Gm-Message-State: AOAM5329bB/dXhsh42F6cw6Uas6e++xHNZiz9EdYUbzoL8Wv1h9JxjfR
        jIRRFukrf9O2DASFTyt+SwOEPjl4UmE0YhNX
X-Google-Smtp-Source: ABdhPJyFzdbuhOTpqAJAdQbWvvp4W8teM6XJtqQlsFThvjHyzvksW4U/1g8R3dzrgGDtAdnw/ph3yQ==
X-Received: by 2002:a02:c7d2:: with SMTP id s18mr27845jao.22.1630532423949;
        Wed, 01 Sep 2021 14:40:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x12sm395144ill.6.2021.09.01.14.40.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Sep 2021 14:40:23 -0700 (PDT)
Date:   Wed, 1 Sep 2021 17:40:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] pack-write,repack: prevent opening packs too early
Message-ID: <YS/zRlL40SkanszX@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <YS75P7r33NIBmFh2@coredump.intra.peff.net>
 <YS8BwgfurPzhT4xh@nand.local>
 <YS8IqxNbxy0YrXSe@coredump.intra.peff.net>
 <YS8LyanAqro3PDlm@nand.local>
 <YS8Y8Ag1Ya+Sn2zg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS8Y8Ag1Ya+Sn2zg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 01, 2021 at 02:08:48AM -0400, Jeff King wrote:
> On Wed, Sep 01, 2021 at 01:12:41AM -0400, Taylor Blau wrote:
>
> > On Wed, Sep 01, 2021 at 12:59:23AM -0400, Jeff King wrote:
> > > So anyway. I think we definitely want the index-pack.c change. We
> > > _could_ stop there and change the read side as a separate series, but I
> > > think that until we do, the ordering changes on the write side aren't
> > > really doing that much. They're shrinking the race a little, I guess,
> > > but it's still very much there.
> >
> > Yeah, now that I've had a chance to look at it it seems pretty
> > straightforward. Probably limited to checks in prepare_pack(), and
> > add_pack_to_midx(), which are the lone two callbacks of
> > for_each_file_in_pack_dir().
>
> Yes, that matches what I'd expect.

Hmm. As I was wondering about about, this is more complicated than meets
the eye. Consider t5616.36, which tests that repacking does not loosen
promisor objects.

In builtin/repack.c:repack_promisor_object(), the repack builtin tells
pack-objects about the pack that it just wrote with `--keep-pack` (and
we rely on that working in order to not loosen all of the objects that
we just wrote).

Except when we iterate through `get_all_packs()`, we don't see the keep
pack yet, because it is still prefixed with .tmp.

So, this does get kind of tricky. There are some internal callers that
do want to know about .tmp packs and a whole host of other callers that
don't or shouldn't. Maybe that should point us towards "we should be
more careful about the order we write packs in, even temporary ones".

But alternatively, perhaps it should point us to "this must not actually
be happening very often, otherwise we would have heard more complaints."
So, ultimately I'm not sure of the best way forward. I'll have to think
on it some more...

Thanks,
Taylor
