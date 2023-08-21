Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21BD5EE49A0
	for <git@archiver.kernel.org>; Mon, 21 Aug 2023 20:23:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230466AbjHUUX5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Aug 2023 16:23:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230461AbjHUUX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Aug 2023 16:23:56 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B05FA11C
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:23:53 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6bc886d1504so2948347a34.0
        for <git@vger.kernel.org>; Mon, 21 Aug 2023 13:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1692649433; x=1693254233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hokmuZnWtwginqIu420T90ZdslvwYqF9ZE+IQV1WTCM=;
        b=ZmrXdMYUbDruwovDTQMNpgkMRhoXJNa2TkDjTlTdpQ2xoVb0/icDQej89pMVoZ83mm
         FEcKle6ktvjZGWAo23k7gQ37rfm7tm3hGdT378dppcgceBsDLBLd8SdhOQ9SJ4WaFK1I
         oNvI47k8j7oK55NP19GOYQOyqzYFEAAhayUPwvoYhuYovnyaku23YMH2oR3RLDxeiDe0
         th8mBR/eniGfvd5CQN5QH0Jok8MXWf87xKJtzw+XK0EVQchdc2Fcwh2fzjpSPdJKseSH
         PCH4WB1DKgp8Zu+gAco2OV6Ocu2jwaWk6tazqWjiPSep5AeXx9OrOVfwLFAvvYAGxs/M
         BpHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692649433; x=1693254233;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hokmuZnWtwginqIu420T90ZdslvwYqF9ZE+IQV1WTCM=;
        b=BuMBKxqBYpAM6vtc5sWD11wSFXnk7IOWTfAdQT/VcPcvguGhLHVmaLYrYQQqfrMNbP
         CaaUHdgK+ub3x05+OnGbdb+sda9Mox9hlO8/HBnPEu8St8Pch3jw97l56Dr++oPWJO4l
         Hq3Wm13tVg7vjVGmXZvo9YoXulIY9r7wLW6sL/fAt4rpfpFzblqdDdhV0St1lzNjv5Ah
         jp0gXWEHHyRD2vybkN6DGAwmuxZ3f2kkwhE8ZEK4QA//VRFZhTOZmo9kEPS8ABzqDhDE
         ex6GfgqmxBgjKbrdGkGdSxfoATd+DKf+1+CvrOv8Luo0wv0XPsMndVVn12oWViJeRs5m
         8WDg==
X-Gm-Message-State: AOJu0YxlWY7GklYjoK3S3D3IkX60h8LqwU1W3f+x/wR6r81vAAHOgkqX
        LIKTM+HNVfmzwO2eY5suJGF+G1++qix4caJTv5qBbA==
X-Google-Smtp-Source: AGHT+IHgbsJX2Qql7sVNRRcv3RsOcnBP2zWVbLQunKV1RXxviFfqP85w49cF/OrMn+AXsF5jAsZJJg==
X-Received: by 2002:a05:6358:6f82:b0:139:e7db:3f3f with SMTP id s2-20020a0563586f8200b00139e7db3f3fmr7006303rwn.10.1692649432922;
        Mon, 21 Aug 2023 13:23:52 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id o199-20020a0dccd0000000b005704c4d3579sm2418024ywd.40.2023.08.21.13.23.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 13:23:52 -0700 (PDT)
Date:   Mon, 21 Aug 2023 16:23:51 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 2/6] bloom: prepare to discard incompatible Bloom
 filters
Message-ID: <ZOPH1714y4iPyeB5@nand.local>
References: <a4cb5fe69247ba737a8373948c1f4ff8a150d283.1691426160.git.me@ttaylorr.com>
 <20230811214806.3326560-1-jonathantanmy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230811214806.3326560-1-jonathantanmy@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 11, 2023 at 02:48:06PM -0700, Jonathan Tan wrote:
> Taylor Blau <me@ttaylorr.com> writes:
> > diff --git a/bloom.h b/bloom.h
> > index 330a140520..2b1c124bb5 100644
> > --- a/bloom.h
> > +++ b/bloom.h
> > @@ -110,8 +110,24 @@ struct bloom_filter *get_or_compute_bloom_filter(struct repository *r,
> >  						 const struct bloom_filter_settings *settings,
> >  						 enum bloom_filter_computed *computed);
> >
> > -#define get_bloom_filter(r, c) get_or_compute_bloom_filter( \
> > -	(r), (c), 0, NULL, NULL)
> > +/*
> > + * Find the Bloom filter associated with the given commit "c".
> > + *
> > + * If any of the following are true
> > + *
> > + *   - the repository does not have a commit-graph
> > + *   - it has a commit-graph, but reading the commit-graph is disabled
> > + *   - the given commit does not have a Bloom filter computed
> > + *   - there is a Bloom filter for commit "c", but it cannot be read because
> > + *     disabled
>
> s/disabled/version incompatibility/, I think.

Well spotted, thanks.

Thanks,
Taylor
