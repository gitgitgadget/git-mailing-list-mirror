Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ED4C77B72
	for <git@archiver.kernel.org>; Mon, 17 Apr 2023 23:03:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjDQXDN (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Apr 2023 19:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjDQXDM (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Apr 2023 19:03:12 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAA31737
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 16:03:11 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id v9so7130116ybm.0
        for <git@vger.kernel.org>; Mon, 17 Apr 2023 16:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681772590; x=1684364590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=qFc+uHdW/xZT9XTsozxH73zb1Foz3JMWKPVGXk7K+IY=;
        b=apdo8BMbTGf6v7Z2eObfWDpzxhEuuXdYlFAxdfvjwDcWtt6wg+yZh57/oUMyuLFpQ1
         nuosrmEUYt7cONfDpX/Hr0l8Ez5XB5UH80r1I38VH5amcGrNjIE1sn3QZcamEjFLklds
         ZZZx3UtpjZ2cicJwykYJoX3xCOk9J7z9HY0VRuMFAvPsxXxP81IEt59rojxhqQfsWGm6
         2D9wm7VcbP5mSwsLC08TAu8Kf6hr62kMtI2Q0QfCsWfWR/hJ5xSedboPmteFhVDDQdIe
         BGSi8w5eNCWAJJuBjIxilel4R1dr6GIEAcCJBr3WaOtyN9AjsSj+tM9YxnS97xNlzajQ
         Urug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681772590; x=1684364590;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFc+uHdW/xZT9XTsozxH73zb1Foz3JMWKPVGXk7K+IY=;
        b=Oe0GKVjb6jAJH/lzFP3x8U9Vl5G4xTmrkjAVkGwb/IbpG++SjdfJoVpUvdMcaSwLRn
         aEuepOwYHgYhZOEd1AbsIwA2PbPpsnf6/LE9XbYIvN4mfmd542yqhQe8vCf1EOZtuX7d
         MJicWyII4MaivTGSHv1NGNmILlqfeT4WlitcLuwHtWBIFIkS0AznJ3a7KnpbxZioFkE0
         wd1HUBWPLfqGR5yBGqllNnkl+HrHcaXHqnjz4umq57E4BDh2ZjAJAfzQkKRW46lNsPs8
         Z6hftRZye1THxrBVSoouZpYhL7aiehkSVM+K7CXUYO5073AdZYNM0k6cJjH18eN5QW8u
         TLqQ==
X-Gm-Message-State: AAQBX9dA2qYbrSKwou5Uz7mEydF4c5E+24CYt7xXsY4WudSxJNrTmhlc
        ytFGoyLLJlLaM1iCskTF0Wo25Q==
X-Google-Smtp-Source: AKy350bzVJ2fXEVEn9v+UaL3knZ5Pdo8ltGBhOBzwtVcRmJxexovC/Yw8Hl//5sM1wxI+bimCHV5Pg==
X-Received: by 2002:a25:5203:0:b0:b8f:1fd3:56df with SMTP id g3-20020a255203000000b00b8f1fd356dfmr16042913ybb.11.1681772590325;
        Mon, 17 Apr 2023 16:03:10 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id t13-20020a5b07cd000000b00b925820de5dsm783749ybq.38.2023.04.17.16.03.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Apr 2023 16:03:09 -0700 (PDT)
Date:   Mon, 17 Apr 2023 19:03:08 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
Subject: Re: [PATCH 03/10] builtin/gc.c: ignore cruft packs with
 `--keep-largest-pack`
Message-ID: <ZD3QLMs8/+DLKZM6@nand.local>
References: <cover.1681764848.git.me@ttaylorr.com>
 <796df920ad6af0ee9101a0f3f80edbc793987336.1681764848.git.me@ttaylorr.com>
 <xmqqildui0gk.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqildui0gk.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Apr 17, 2023 at 03:54:35PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >   - The same is true for `gc.bigPackThreshold`, if the size of the cruft
> >     pack exceeds the limit set by the caller.
>
> This is not as cut-and-dried clear as the previous one.  "This pack
> is so large that it is not worth rewriting it only to expunge a
> handful of objects that are no longer reachable from it" is the main
> motivation to use this configuration, but doesn't some part of the
> same reasoning apply equally to a large cruft pack?  But let's
> assume that the configuration is totally irrelevant to cruft packs
> and read on.

This is an inherent design trade-off. I imagine that callers who want to
avoid rewriting their (large) cruft packs would prefer to generate a new
cruft pack on top with just the recently accumulated unreachable
objects.

That kind of works, except if you need to prune objects that are packed
in an earlier cruft pack. If you have `gc.bigPackThreshold`, there is no
way to do this if you need to expire objects that are in cruft packs
above that threshold.

A user may find themselves frustrated when trying to `git gc --prune`
some sensitive object(s) from their repository doesn't appear to work,
only to discover that `gc.bigPackThreshold` is set somewhere in their
configuration.

Writing (largely) the same cruft pack to expunge a few objects isn't
ideal, but it is better than the status quo. And if you have so many
unreachable objects that this is a concern, it is probably time to prune
anyway.

It is possible that in the future we could support writing multiple
cruft packs (we already handle the presence of multiple cruft packs
fine, just don't expose an easy way for the user to write >1 of them).
And at that point we would be able to relax this patch a bit and allow
`gc.bigPackThreshold` to cover cruft packs, too. But in the meantime,
the benefit of avoiding loose object explosions outweighs the possible
drawbacks here, IMHO.

> >  --keep-largest-pack::
> > -	All packs except the largest pack and those marked with a
> > -	`.keep` files are consolidated into a single pack. When this
> > -	option is used, `gc.bigPackThreshold` is ignored.
> > +	All packs except the largest pack, any packs marked with a
> > +	`.keep` file, and any cruft pack(s) are consolidated into a
> > +	single pack. When this option is used, `gc.bigPackThreshold` is
> > +	ignored.
>
> "except the largest pack" -> "except the largest, non-cruft pack"

Indeed, good eyes.

Thanks,
Taylor
