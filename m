Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBEEC77B75
	for <git@archiver.kernel.org>; Tue, 18 Apr 2023 19:53:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232694AbjDRTxv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Apr 2023 15:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231262AbjDRTxu (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Apr 2023 15:53:50 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5455975D
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:53:49 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id b10so2402029ybk.9
        for <git@vger.kernel.org>; Tue, 18 Apr 2023 12:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1681847629; x=1684439629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=phTYGAlo1vSNa1nVFOJbQC9HssLOJGtBYS95aRKgwXM=;
        b=XU2yKNV7jWLZWNWO/PSespzKnIYb6j2gPVK7hoOfSWhD+tVB15sVuVSHseHsg3KFnM
         zEE0gufXLmXEBDdXvWIb37T9eKkfRarCXXF+Y4PvMtUnYnIhMWaumJ3qVXnr6llDoWKg
         pqn1OsMn+9bAuI6w4R4rAG5auilqXNm4UTYSj/KtHnvVtpF5VnF5DqP3zEYhvi+K/9Cv
         8iyUIzFGsk5feGbDu6QHiPJIehXTtUgeovAOXlo6ak0dnv/plCS8l4zgCZatOLC1bcRx
         poTBZsW7I6jSD2dB3eG25j44R/1Zi+oqJLbnw97yoaTVv0n8WoKFabXo+P4luj2YeQrt
         oZlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681847629; x=1684439629;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=phTYGAlo1vSNa1nVFOJbQC9HssLOJGtBYS95aRKgwXM=;
        b=bbDaSMKzfCtPgDlyCUiO4qC0xnkOskMsiX+OuZNUgDK+/wihmvw6j96NsGYHEfZ0+8
         /RW06fAN8uOsoT1Z6PB3aE6TjnG+brEITun+p7mWNbK+7ISmRYBTfVSpjbV2U8Ovj2XY
         qfmdY52wYny5FOcYXzM/83LWCDtQwV/1t6wsr/sT8zcCc9eSoz5NRTUHArONgERd/J4e
         6+Ut08Eu/vbHFkHH8aML3xee4u2T4ZuPPEXQDFXHt/imsNB/KgE0NmwMQ7Npxq30yvoW
         P0EMtaZHIBui2FQxtg3Cr881Zd5fyV98OZ+SIePDjw4lCVOamQdZgyTUNfecqIfv23OF
         +NiA==
X-Gm-Message-State: AAQBX9dLvDvxj+3pUf4BQkDEjoBW/jJ7Vgy7ijWE2t8Nr+jNtUdryry7
        d8XwWXfhwAHCys75AlmUxz7/qA==
X-Google-Smtp-Source: AKy350aM39hO+b0B8Tr1g99vlkoyfQ532WhSlpVc2Asu7M/YSv1tWWTT/ey6cQxuLwPwGhlTMhOiFg==
X-Received: by 2002:a05:6902:1248:b0:b94:d854:cc7c with SMTP id t8-20020a056902124800b00b94d854cc7cmr5242115ybu.12.1681847628864;
        Tue, 18 Apr 2023 12:53:48 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 200-20020a250bd1000000b00b8f3e224dcesm3913626ybl.13.2023.04.18.12.53.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 12:53:48 -0700 (PDT)
Date:   Tue, 18 Apr 2023 15:53:47 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 00/10] gc: enable cruft packs by default
Message-ID: <ZD71Sxh9vviM06T3@nand.local>
References: <cover.1681764848.git.me@ttaylorr.com>
 <20230418110424.GD516715@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230418110424.GD516715@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 18, 2023 at 07:04:24AM -0400, Jeff King wrote:
> On Mon, Apr 17, 2023 at 04:54:11PM -0400, Taylor Blau wrote:
>
> > The series is structured as follows:
> >
> >   - The first two patches are cleanup.
> >   - The third patches fixes an oversight where the code for `git gc`'s
> >     `--keep-largest-pack` option would incorrectly consider cruft packs.
> >   - The next five patches are test preparation.
> >   - Then the substantive patch, to actually graduate `gc.cruftPacks` and
> >     enable it by default.
> >   - The final patch is some cleanup that can only take place towards the
> >     end of the series.
>
> Thanks, this was a pleasant read. Besides Junio's small fixup in the
> docs, everything I pointed out was minor enough that it wouldn't be a
> big deal to go in as-is.

Thanks, both, for the review. Most (all?) of the clean-up was all pretty
minor, but I would have rerolled here regardless. New version incoming
just as soon as CI says it's all good.

Thanks,
Taylor
