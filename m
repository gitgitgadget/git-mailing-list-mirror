Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB55FC433F5
	for <git@archiver.kernel.org>; Wed, 25 May 2022 00:16:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242862AbiEYAQk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 20:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiEYAQj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 20:16:39 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93905DD0F
        for <git@vger.kernel.org>; Tue, 24 May 2022 17:16:38 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-e656032735so24320653fac.0
        for <git@vger.kernel.org>; Tue, 24 May 2022 17:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=iKdmtzS+rkb2uwKq1ozmqBbSD2r8ADhfVf+MQLgmVe0=;
        b=0fvtfYR9iEgbIEWwm7H2bh4GLNa6nISu7yi8i59Fe6ksygo8jnMHyphtpDt7M9Jm1v
         b1Lalpo1hofLsMkDJ3OO9FGcuL1BaMzkPZf+0P6KMetvsIv4Cll01P0ZQqQmECiRaVL5
         nT/9drpVIM7uwz+s64ithCfhTDd36HompYJsrB2DZAAsNJxi6fEIYfzblEtiFjhFZNos
         rI7ird/Ea1dYc41UfTnA2YyExqwHXlqSHAelquLWZWkrODjL+uqB1d1HYSHphJPGVSuW
         I8ozsgtW7S0J2fujHChpe614I53YYks5qogybGT5hjopBm/dQGRgXArefya2aBr1r6Ay
         A2kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=iKdmtzS+rkb2uwKq1ozmqBbSD2r8ADhfVf+MQLgmVe0=;
        b=eZiX+I6M5VPRM3Yv1PHZDqGCz2ijpB+uHAVwbGcNpzwDawADDYCQo7HAOZQ29Mn9Vj
         obNXuYRxUAm7Qw7+qNQRULBHM0PMDq/O29AsqtHge44+1DfLr2KVjROd10u+iPC6Xr3m
         U2ncRXpZxd9eKgzAaeuYwS4XILt70r3gn4si6Jiqxy32aXXu8c3NFBIazx7Vgz0+QYAY
         tH3E6/5pBT/brLaE22+wX311CTC5iPuuyb9zgW/cgbeDfvPCnd8xoUB7z8P/Qn+oPoWX
         GVtomPqjcI9RR7U5pezRrkpf02R9gTOrpYtVJzMnFcsq44l9zgax3rybbFk7Fa9svzVH
         xw3A==
X-Gm-Message-State: AOAM530IQ5tPFnbmT7ADHT7VBs2E1LPhHm+MQd+0VWanlj/QYBQ82Lsg
        5P8iz28Pr7GzLyEfJgsdK6KNbg==
X-Google-Smtp-Source: ABdhPJwNGQoG/QBv7GA88iQus5HbOsvFoUNhQgSMI1isPuHLeBhawpJX084LmRkPxW2mFQwS5P26fQ==
X-Received: by 2002:a05:6870:602a:b0:f1:42cf:8296 with SMTP id t42-20020a056870602a00b000f142cf8296mr4005568oaa.111.1653437796931;
        Tue, 24 May 2022 17:16:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m3-20020a0568301e6300b006068c4af381sm5489783otr.54.2022.05.24.17.16.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 17:16:36 -0700 (PDT)
Date:   Tue, 24 May 2022 20:16:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, vdye@github.com, jonathantanmy@google.com
Subject: Re: [PATCH v2 0/4] pack-objects: fix a pair of MIDX bitmap-related
 races
Message-ID: <Yo11Yv9jgn5kDouL@nand.local>
References: <cover.1652458395.git.me@ttaylorr.com>
 <cover.1653418457.git.me@ttaylorr.com>
 <xmqqfskyfw68.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqfskyfw68.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 02:38:39PM -0700, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> >          verbatim reuse (c.f., `write_reused_pack_verbatim()`).
>
> Unlike "e.g." and "i.e.", I think these should all be "cf." (there
> are many others).

Oops. You learn something new everyday! ;-)

> >     +    This patch handles the "preferred" pack (c.f., the section
> >     +    "multi-pack-index reverse indexes" in
> >     +    Documentation/technical/pack-format.txt) specially, since pack-objects
> >     +    depends on reusing exact chunks of that pack verbatim in
> >     +    reuse_partial_packfile_from_bitmap(). So if that pack cannot be loaded,
> >     +    the utility of a bitmap is significantly diminished.
>
> It explains why we care about the "preferred" pack, which is a nice
> clarification.  It hints that the other packs do not matter as much,
> and it is clearly stated that how they are handled is ...
>
> >     +    Similar to dc1daacdcc, we could technically just add this check in
> >     +    reuse_partial_packfile_from_bitmap(), since it's possible to use a MIDX
> >     +    .bitmap without needing to open any of its packs. But it's simpler to do
> >     +    the check as early as possible, covering all direct uses of the
> >     +    preferred pack. Note that doing this check early requires us to call
> >     +    prepare_midx_pack() early, too, so move the relevant part of that loop
> >     +    from load_reverse_index() into open_midx_bitmap_1().
> >     +
> >     +    Subsequent patches handle the non-preferred packs in a slightly
> >     +    different fashion.
>
> ... left for later steps.
>
> Excellent write-up.

Thanks very much!

Taylor
