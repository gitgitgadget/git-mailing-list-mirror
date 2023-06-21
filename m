Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F88EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 11:21:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232430AbjFULVR (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbjFULVE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 07:21:04 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2D8170C
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:20:40 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6b58558c824so2489458a34.0
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 04:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687346439; x=1689938439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=td+C5VL72W32RYhlmvNIdBGe6xKCRAsQL9hfL1nTb58=;
        b=F73KN0dxSLw++ddsfBSkcZxfiNbLKi1pEMM8jEX9ZLhdVWnOAGG7JI/KG7Iisz7CiM
         Wj+jnrhWYTPTFEG6EAHX4GR2NYI1cT56R8N24e2XgC8g/id50eZ5ihDMGB8u2Xu0GjEG
         1x46oUd9mHD07qUyJxbYcQTVcFAzUpR+atUdmSO17H8yibB3S+NXotHVDJKOy1iQOM64
         aZ1FN4ob7FciQHdjfRYt+3W/SG2DrHHwkMSriiPNzLsRHH3LoTQZEvnax8HYK2+cdjSt
         kvkiTFAnliGN5SRRkMzJRFhdNs2CpT/bh4Cx/vJvdvvrVn5BtFR+Fl9TYpQjabBAg2qK
         J0zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687346439; x=1689938439;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=td+C5VL72W32RYhlmvNIdBGe6xKCRAsQL9hfL1nTb58=;
        b=GwH/sE4iCZ5zliUuqZnHD7rd2wKqzE4lKqYsyUjkRrJjabQwWgVhGmZMtU0JTBo+oK
         gPsmzTSRDeCLdwnjnDAgQ3RmdJyP+LfWo4psyI1j3CrZuEBXhrurUls1F00l7N9kNxBh
         IJTgUmRShC2N1j5i/vYX0HAuwX2Jl+zhuA05MOHJ1mYv/LfxLpIQR5fDwEYW2rea+z60
         ZHOPTsb9qYg+mHf5/AyoHOcF1yOWFudOdKOlVJTRzEMDYO0+LGQwZYmt0Cm1OoU7L7GH
         e4u0f1hTW3QbkW1gAOP8Xf6qpVfAKEvXW5dm4nbnt7lCsVIh786+7zNMumzf6zLZwDax
         UBcg==
X-Gm-Message-State: AC+VfDzZpCozGNk4u4V5e0035KGeiGDcf6VJSJYKpgH9lupslfAbQAs2
        b8lqBMj1pNf4YfXtvCDzHtRRMQ==
X-Google-Smtp-Source: ACHHUZ48qJUtHTRVVQfg2Yuz504nnro4f9RSvftOIDX81dMPP72qts3uqd8aTUwHO7PcMNlQfLNnAQ==
X-Received: by 2002:a05:6359:2ea4:b0:12f:1567:1502 with SMTP id rp36-20020a0563592ea400b0012f15671502mr11518288rwb.28.1687346439123;
        Wed, 21 Jun 2023 04:20:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id d187-20020a0df4c4000000b0055a07e36659sm1034340ywf.145.2023.06.21.04.20.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 04:20:38 -0700 (PDT)
Date:   Wed, 21 Jun 2023 07:20:36 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 6/9] repack: add `--filter=<filter-spec>` option
Message-ID: <ZJLdBHNFPfxHp3C0@nand.local>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
 <20230614192541.1599256-7-christian.couder@gmail.com>
 <xmqqmt10s0cw.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqmt10s0cw.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 15, 2023 at 05:43:27PM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
> > After cloning with --filter=<filter-spec>, for example to avoid
> > getting unneeded large files on a user machine, it's possible
> > that some of these large files still get fetched for some reasons
> > (like checking out old branches) over time.
> >
> > In this case the repo size could grow too much for no good reason and a
> > way to filter out some objects would be useful to remove the unneeded
> > large files.
>
> Makes sense.
>
> If we repack without these objects, when the repository has a
> promisor remote, we should be able to rely on that remote to supply
> them on demand, once we need them again, no?

I think in theory, yes, but this patch series (at least up to this
point) does not seem to implement that functionality by marking the
relevant remote(s) as promisors, if they weren't already.

> [...] It does smell somewhat similar to the cruft packs but not
> really (the choice over there is between exploding to loose and
> keeping in a pack, and never involves loss of objects).

Indeed. `pack-objects`'s `--stdin-packs` and `--cruft` work similarly,
and I believe that we could use `--stdin-packs` here instead of having
to store the list of objects which don't meet the filter's spec. IOW, I
think that this similarity is no coincidence...

Thanks,
Taylor
