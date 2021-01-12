Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37A18C433DB
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:57:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F18E12311D
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 16:57:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390934AbhALQ5V (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 11:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725843AbhALQ5U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 11:57:20 -0500
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF2F0C061786
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:56:40 -0800 (PST)
Received: by mail-qv1-xf35.google.com with SMTP id a13so1202985qvv.0
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 08:56:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WAP1eFRBpQYQXA5H6yQYRCBcsBnyp2X6IrHxs+16ESQ=;
        b=FTJw8B0B/0uoImcEpe01V1R+82tBr/5b+FATNnLrdk/fibbzEVZvFLzNI4muX7eLM0
         XHIKo1lBIybzk467BZNI8kLAL36nK/e4vtPjDUZTTsgLHwUTsv4qbQbmTmabmSqs7VK3
         xkooAU7sOV/0CoR/hD8AXFFlQbjlIFz/E8xrB6VK2UijJ+Q8Kvzwf4TVw805Ob21eJos
         t1HEnMqHgspEbE3kkiFlF+wysVNjHcYbKtaXDN1g3OZ56z/1PSA0GgmiiaV7vglxVlpq
         X4zNjgscPN71rExbhZ3T0KdiyOKt7ZJIEIwNEOutZ/0fHslbwSHetg8V1gTFyampyu5/
         rvQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WAP1eFRBpQYQXA5H6yQYRCBcsBnyp2X6IrHxs+16ESQ=;
        b=GY2XJZMybntdnbPTKeLU460G25JID2C/1Iau/83NT/TcQ4skTVLBoZ8lmCdpDte2Z/
         GMy0BbZkaHWlwJ7fhSpvR3NMoW7CKLYwAq9R+UStvakhuNHONWhtrnekoGfVCljrN/+a
         Zbm+5IPZk/2nsDzs/+NRco3pneFtBDNzwfSkzED6qYp4g+6N0+0cjfTdtr/upHdHCiq6
         i66kyfhv9TvM9VHGN85UorTsjVNtObAlyIy+dYebmbUthk5JgB/B074FwoSdSudTvT7D
         byJ810dySNCPhg/Pok7GjwIUCtNXbBUoJetbMRnejS4Iv6G1TF/wqwrlADDuf8orUlv7
         wd5A==
X-Gm-Message-State: AOAM530S7bjeBncYR+SO9AIcWV6+LlEwjaZZYzo2vlaI+v1gDtOEk/Ew
        Q8xY46ksV2iuNmkwvaAF+QW4ISdYRfNkqA==
X-Google-Smtp-Source: ABdhPJwWOsgNMWKMN3j6J7dtuvuPh+/5v7C8FI3JjkA6Adqf380m3usjZlbXkFkQM/Xei5uuW7qQ4g==
X-Received: by 2002:a0c:a541:: with SMTP id y59mr271588qvy.61.1610470599983;
        Tue, 12 Jan 2021 08:56:39 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:42e2:d139:3745:d47])
        by smtp.gmail.com with ESMTPSA id 127sm1592655qkj.51.2021.01.12.08.56.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 08:56:39 -0800 (PST)
Date:   Tue, 12 Jan 2021 11:56:36 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jrnieder@gmail.com
Subject: Re: [PATCH 14/20] unpack_entry(): convert to new revindex API
Message-ID: <X/3UxI01yNmgQ0hq@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <13c49ed40ca72b7ab50939244616f0a90b5bf7f6.1610129796.git.me@ttaylorr.com>
 <X/1qUphaPD1Pvk+X@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/1qUphaPD1Pvk+X@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jan 12, 2021 at 04:22:26AM -0500, Jeff King wrote:
> We have "pos" and "nr". What's the difference? :)
>
> I think pack_pos and index_pos might be harder to get confused.

Much clearer, thanks.

> > +			off_t len;
> > +
> > +			if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
> > +				data = NULL;
> > +				goto out;
> > +			}
>
> Nice to see the error check here. As with the previous commit, we
> probably want to error(), just as we would for errors below.

Yup, good call.

> Do we also need to call mark_bad_packed_object()? I guess we can't,
> because we only have the offset, and not the oid (the code below uses
> nth_packed_object_id(), but it is relying on the revindex, which we know
> just failed to work).
>
> I'm just wondering if an error here is going to put us into an infinite
> loop of retrying the lookup in the same pack over and over. Let's
> see...our caller is ultimately packed_object_info(), but it too does not
> have the oid. It returns an error up to do_oid_object_info_extended().
> Which yes, does mark_bad_packed_object() itself. Good. So I think we are
> fine, and arguably these lower-level calls to mark_bad_packed_object()
> are not necessary. But they do not hurt either.

Thanks, this rationale is helpful to have. I included an abridged
version of it in the patch message.

> -Peff

Thanks,
Taylor
