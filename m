Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2EC1C432BE
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:30:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CB1A161057
	for <git@archiver.kernel.org>; Wed,  1 Sep 2021 04:30:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbhIAEa6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Sep 2021 00:30:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbhIAEa5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Sep 2021 00:30:57 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B51FC061575
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 21:30:01 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id f6so2506659iox.0
        for <git@vger.kernel.org>; Tue, 31 Aug 2021 21:30:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JitV/tQxGnhMEsXcaxxiRAYhhKKuydjNS46Lsm56eys=;
        b=ciGVKEPL65tAHqmDWxDD7695QpI1AojcN9YU4PC6Lr/c4Kd8h1Hzvxg7orC+R+JMYe
         kB5B3yadhESYJGdAq/AgYRmSz19CtI3gnOgF3m+cf2V430ph51mCDjbJAywSD6bVp3NP
         wewawHKGaUZFN7ePLvFNENZhTraj0G2pHROU+q41svFv1khgitrCUd8l/hsHjSNbeMRP
         YLMmgzeHVZW8JDg+tPO5eCBS6X1qsCN+1rQ+bUxOgsBmKlDfK4xv9SCv0ttcvLZaasiS
         0gvrQ/nGWDCQzXTdXKLWjVJGDP+zx8t8JuwMe6y/9uFSrdXk5UL0JBG4bQtYwF2T5Y2A
         1m3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JitV/tQxGnhMEsXcaxxiRAYhhKKuydjNS46Lsm56eys=;
        b=JqzZ5FYt98xi09qvSYE03zkcyNJLUWuZ/NAVmfQAcYY7tCDxFqTRpkuGuW/rz+cl/t
         Vs3/n1LtJ+i2Z6X0NmQxJC6YGC344yt3WrMhQHjwcS9AN1npuadnp016bGqNJsd3GxuI
         6PHk5EbEUu/xLxGTnC0f3ZPf3tB4TlrtkoUq5JZKmQ/MCqSUa8VzVEevSbX0ykqMJwyJ
         3Ug/lxbVv1lwYzdqNQWr0D9r5BADGQcIoEjydKxltXFkj8p66Ll48wLypZrYQF8eB0XQ
         0qmLzdGjcuqdisrgiRcOQA8nAtsZ3PjM2R3UGoBs0ktL0rCo00DwEKcvGcibD31BYW9+
         ng0A==
X-Gm-Message-State: AOAM530N3pWLM3WWDmszkHd1KOam3m+D7b+Vuy0gbx5Zb+ha0nhipn4d
        S6LhLHVS8pYnYJGOVYVXMjtEDWhdVRZQwc6w
X-Google-Smtp-Source: ABdhPJxO8J68ofNij09ZakKmo0/jKtomEC/jEzPHjNY2Uh15SzAIP/rW7z1IkscsFqq9PCT+UM5YNQ==
X-Received: by 2002:a6b:5c0c:: with SMTP id z12mr19332320ioh.171.1630470600545;
        Tue, 31 Aug 2021 21:30:00 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id p12sm11204416ilp.87.2021.08.31.21.29.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Aug 2021 21:30:00 -0700 (PDT)
Date:   Wed, 1 Sep 2021 00:29:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 0/2] pack-write,repack: prevent opening packs too early
Message-ID: <YS8BwgfurPzhT4xh@nand.local>
References: <cover.1630461918.git.me@ttaylorr.com>
 <YS75P7r33NIBmFh2@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YS75P7r33NIBmFh2@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Aug 31, 2021 at 11:53:35PM -0400, Jeff King wrote:
> So far so good. But the other obvious way to get a pack idx is via
> index-pack (especially "--stdin").
>
> It looks like we'd want the same re-ordering to happen in
> builtin/index-pack.c:final(), which is where we rename the temporary
> files into place.

Sure, that's easy enough.

> We _might_ also want to re-order the calls to write_idx_file() and
> write_rev_file() in its caller, given that simultaneous readers are
> happy to read our tmp_pack_* files. I guess the same might apply to the
> actual file write order pack-objects, too? I'm not sure if that's even
> possible, though; do we rely on side effects of generating the .idx when
> generating the other meta files?

These are a little trickier. write_idx_file() is also responsible for
rearranging the objects array into index (name) order on the way out,
which write_rev_file() depends on in order to build up its mapping.

So you could sort the array at the call-site before calling either
function, but it gets awkward since there are a handful of other callers
of write_idx_file() besides the two we're discussing.

It could be done, but it feels like the wrong approach, because...

> I think it might be more sensible if the reading side was taught to
> ignore ".tmp-*" and "tmp_*" (and possibly even ".*", though it's
> possible somebody is relying on that).

...this seems like the much-better way to go. Git shouldn't have to
worry about what order it writes the temporary files in, only what order
those temporary files are made non-temporary.

But I need to do some more investigation to make sure there aren't any
other implications. So I'm happy to wait on that, or send a new version
of this series with a patch to fix the race in
builtin/index-pack.c:final(), too.

(Unrelated to your suggestions above) another consideration for "stuff
to do later" would be to flip the default of pack.writeReverseIndex. I
had intentions to do that in the 2.32 cycle, but I forgot about it.

> -Peff

Thanks,
Taylor
