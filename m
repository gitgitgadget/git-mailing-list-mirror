Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728D6C77B7D
	for <git@archiver.kernel.org>; Sat,  6 May 2023 00:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbjEFAUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 May 2023 20:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbjEFAU3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 May 2023 20:20:29 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CAF21981
        for <git@vger.kernel.org>; Fri,  5 May 2023 17:20:24 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-b9e66ce80acso3251407276.3
        for <git@vger.kernel.org>; Fri, 05 May 2023 17:20:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1683332424; x=1685924424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2juZC4ybvBQhvyzWVVevBm8t1m46IMkCvwpbNH22+h8=;
        b=Q8YPIxHZJsrNbPLj/5UhUcI1x/4M4sejfZloYTWIEt/uF6lClvKPFE3nxUTL4ny+mh
         iYvzhusv3piFYGPDYse9HT5iCq2JkeLxd/ThvO89NYaBPlayIZu9RxS57L8nhTYWeLXI
         alOfl0HB1tbwyp62DBDxzfZGaFLuPekOvg1Vda5lIjYfxlh8uiY8foOSPlKFV9nkpJFr
         OxrKfUw4VIL4Vke7lSomX2leyKacNogdL0BK9PJpO5QZJVR7dXQpvKVj6dByMeQSJr9D
         XgR71WaoUWH6reEEEKdotmgkiAVMH/mclfDppNSYPsOwXyk6mzH1QWwJsO8OotOvqpxe
         gr5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683332424; x=1685924424;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2juZC4ybvBQhvyzWVVevBm8t1m46IMkCvwpbNH22+h8=;
        b=X30Tb5eur6QB6cKqmMeEeZwM2jLT4ObZiOog1sTxDlQ6u5twS6Bt3uiEHooFDjd5Y2
         Noz4PwpE+EP7m5YxSVXi5RdTNwNEMLxi9NrhvJHpj65/pgaZWXVuh7F4j/P6wHuu5pFI
         6jCCSfSgfOLZXo+X1uq6VSj8nYRGfIUX7PBN9HwXqtaKiZCfed2zSz29eS6zrclx9rtN
         XHmXOG7vzwaaz25cITxLi7bDKn+DwgvwCGTD8HaaOqW86Y6+HVFn1YDXtlyzMiN6UZWz
         DvXpIAe/s4/iBuGyRfkDFapn256YiST/jGjR6H0zYDLckn2hKt7ZWFnLFZ1qhDnT8osi
         rr9Q==
X-Gm-Message-State: AC+VfDyQp2Zz5WhAdaps2lOvMRjofZcsQ8C+n8qxVr5skiCIEUzpJIwV
        uyr40gOA06hedMpTMm7WH7868g==
X-Google-Smtp-Source: ACHHUZ4STJuGgXwSFY/RNW9VIHF3VsyJ47yfUnw6zdpWCrr8i00cXrwEoIxlndW2Pn5U67914m4BOA==
X-Received: by 2002:a25:f826:0:b0:b9e:2fa2:352b with SMTP id u38-20020a25f826000000b00b9e2fa2352bmr3383327ybd.54.1683332423693;
        Fri, 05 May 2023 17:20:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m1-20020a056902118100b00b9949799ce3sm775003ybu.32.2023.05.05.17.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 17:20:23 -0700 (PDT)
Date:   Fri, 5 May 2023 20:20:22 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH v2] builtin/pack-objects.c: introduce
 `pack.extraCruftTips`
Message-ID: <ZFWdRoUOQJfP3db+@nand.local>
References: <8af478ebe34539b68ffb9b353bbb1372dfca3871.1682011600.git.me@ttaylorr.com>
 <73ad7b90e1fe6c15f41ff828651f7ab06076ffd8.1683072587.git.me@ttaylorr.com>
 <20230503195906.GA1796816@coredump.intra.peff.net>
 <ZFLSDS89y8P2+g/2@nand.local>
 <20230505212631.GB3321533@coredump.intra.peff.net>
 <20230505221357.GD3321533@coredump.intra.peff.net>
 <ZFWbuf34pVxJyRiM@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ZFWbuf34pVxJyRiM@nand.local>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, May 05, 2023 at 08:13:45PM -0400, Taylor Blau wrote:
> On Fri, May 05, 2023 at 06:13:57PM -0400, Jeff King wrote:
> > One thing that could make this a lot simpler is if the code was added to
> > "are we recent" code paths in the first place.
> >
> > Something like this:
>
> This is quite nice, and I think that it's a good direction to push this
> ~series~ patch in before queuing. That said, I wasn't sure about...
>
> > @@ -78,7 +144,7 @@ static void add_recent_object(const struct object_id *oid,
> >  	struct object *obj;
> >  	enum object_type type;
> >
> > -	if (mtime <= data->timestamp)
> > +	if (!obj_is_recent(oid, mtime, data))
> >  		return;
> >
> >  	/*
>
> ...this hunk. That only kicks in if you have other recent object(s),
> since the hooks are consulted as a side-effect of calling your new
> `obj_is_recent()` function.
>
> I think in most cases that's fine, but if you had no otherwise-recent
> objects around, then this code wouldn't kick in in the first place.
>
> I wonder if it might make more sense to call the hooks directly in
> add_unseen_recent_objects_to_traversal().

OK, no, this is fine, but we'd need to make sure that
want_recent_object() also understood the fake recent set here, since
add_recent_loose() and add_recent_packed() both bail early when
want_recent_object() returns 0.

Thanks,
Taylor
