Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7DF6C433E0
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:16:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AD5522076E
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 20:16:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726177AbhANUQ3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 15:16:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725869AbhANUQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 15:16:28 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED025C061575
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 12:15:47 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id a1so2917541qvd.13
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 12:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=FEx+gF0z+2FK+VX7JoC04egKHxZ01jI5jkosD4qfWjw=;
        b=TbbVPUwNk+6d6xVKE+WCBmMDoVrhXTfwh+Ii3ozESt0+DP4g75/qmVauFCc4WJ9s03
         4rBYArRhV/eZqcHrUrXtieXztcnZ406baaeiB9AWkCv0rAuukG8CQdlV/N5mTfmeoY5t
         wYqUSFaSPQj70yGaeCNPZt0uLJELVMJILJDu/MqSq2MIdKcU2SVzctK2U3moLvOxgbsU
         P8aetHNNReCCdDnQH+S3wsXsv/ID7FZyPibOEaWCJjOB8/Aa4DW9A+3DFwyP7Vd1eW5P
         FS+mcD3MKEliUEo8u1H0oZWR/KMF7eZcLwcVDpH4CYeXKR+brRndcW1idgNy+cdjmB9q
         xJsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FEx+gF0z+2FK+VX7JoC04egKHxZ01jI5jkosD4qfWjw=;
        b=ql1dw7WJNuAoUA2c74BptJeo2w8ScAKjSLCKEnZsA5XQY/cScvV7EMVUqhRkv4v+21
         YIXejaP32OTgtW7wsPg7VMOJWhSDOWxtD4dqi3cs3JOLjdZNx80ik89oh8KtVudenmMP
         4/EJEc4K5nkWyoU8B7ib3dfPE2Z5DL76x6dIR9I+mB2hh/oCYP+weUgCclvjnl9FSUD3
         /GDpYWTJrJwOqlmNBVQiD5NUIn9fbApndMK71weO4i780uS8x0pxhumdJimmmqyfDyVR
         A5uaCQtXcXvFTjuI4KyyVsz69oZKNDxCDHImtWMxlUiWyP8WLVVd+9UREZk+YQxbWYwO
         SJBw==
X-Gm-Message-State: AOAM531moQe2vL4Hkxd7ZmAUJ7YhiNgn4hqoxVE5DdBaok7jfxv7hSBw
        E2TjgXJTnGKgCgnb4e3rQl4Mlw==
X-Google-Smtp-Source: ABdhPJyJAy8EGZoRBgcP3S/vnUKbFtgJGk3DP/UR1j2gFxFI4pfdSCQIMB6vWM85Ozcqs0sOVcQfTg==
X-Received: by 2002:ad4:4c03:: with SMTP id bz3mr8555366qvb.18.1610655347096;
        Thu, 14 Jan 2021 12:15:47 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:d2a9:3030:291b:4b4])
        by smtp.gmail.com with ESMTPSA id r22sm3721314qkk.67.2021.01.14.12.15.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 12:15:46 -0800 (PST)
Date:   Thu, 14 Jan 2021 15:15:44 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>, Taylor Blau <me@ttaylorr.com>,
        git@vger.kernel.org, dstolee@microsoft.com, jrnieder@gmail.com
Subject: Re: [PATCH v2 15/20] for_each_object_in_pack(): convert to new
 revindex API
Message-ID: <YACmcG4bNugX3WfK@nand.local>
References: <cover.1610129796.git.me@ttaylorr.com>
 <cover.1610576604.git.me@ttaylorr.com>
 <e7574763513294b71071b032d5cd3aa0976969dd.1610576604.git.me@ttaylorr.com>
 <xmqq8s8wyq5i.fsf@gitster.c.googlers.com>
 <YACcoNY/SiEbBSgh@coredump.intra.peff.net>
 <YAClXle+utN/VnVZ@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAClXle+utN/VnVZ@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 14, 2021 at 03:11:10PM -0500, Jeff King wrote:
> On Thu, Jan 14, 2021 at 02:33:53PM -0500, Jeff King wrote:
>
> > So "pos" in this case is not wrong. But I agree that it could stand to
> > be more clear. Saying "nth" does not help things IMHO (there is an "nth"
> > pack position, as well).
> >
> > But maybe this makes it more clear (or possibly just the name change
> > without the comment):
>
> Here it is again, but with a signoff and commit message, and done on top
> of your series (so if we agree this is a good resolution, it can just be
> picked up on top, but I am also happy for it to be squashed into patch
> 15).

Much appreciated. This looks good to me (and I have no opinion whether
it is picked up on top, or squashed into patch 15).

  Acked-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
