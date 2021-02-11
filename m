Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 245F7C433E0
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 15:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5F5761490
	for <git@archiver.kernel.org>; Thu, 11 Feb 2021 15:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229933AbhBKPA0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 11 Feb 2021 10:00:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbhBKOzs (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 11 Feb 2021 09:55:48 -0500
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350B2C061756
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 06:54:53 -0800 (PST)
Received: by mail-qt1-x829.google.com with SMTP id v3so4314021qtw.4
        for <git@vger.kernel.org>; Thu, 11 Feb 2021 06:54:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KL4gYNgHNAoyJ5VxenSL8NZeylUMV26DqMeYrmJkc0w=;
        b=UNAb0aaR3P5KWWfzl1H9OTmQQNdd0YQphSPk84ZKQpQ9W7QDw6EKJTUv38WYl9jiPD
         SuD1yH9FqPxYTZFu/yoE5hUQBFUf33xrbNLnQAT52J3gCLU0aAxcZiExyGAEnCwC8JU/
         U7IO+qVnsVk+emQRBm01qdi6iAEc3i2vTX1VSGX5MuM/lGLiPH9vryLKMGyH6ZuadTo3
         tomX2nlz/dkyvmNH+C4+ZfKNdTCzitCtUb0gxTn6FsrlSqGot+jxtzRX3+7Jx6UcQIxc
         mHif35uUrv+sJdghJzEE6WYsLKIzKYCl2rbc5A4mEC+HGssEdNAPDVske5SYzV/6Ckdh
         JtYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KL4gYNgHNAoyJ5VxenSL8NZeylUMV26DqMeYrmJkc0w=;
        b=YLqx0VR0QCohLSVccmDWYiJonT/K1r66jwNkfQr6chptMF8Nb0gErPjMBYoHkj86cx
         dvfEDeQTI822OQlbke2+L+gexafKylEBJHEXE88Ko0tClZJJhMzGyPpOc0sxEvfLBOz5
         S14MX1OX+vWEOCGKPW4v/Z5on0GdO9MLa/xPKgLYjefY7IJ8Yjq9rLrV47/2sEjTizwS
         RAOPgcavw+2I6QXUkhULmT52AmGX237V9RcNz+KyO7AwDc96WYR3H6/DAsOTQo9cue9G
         sUMWpG9zBfRPhlIb6utQaDcXkdXM8HEIX6UJTRdFAM4GO+4b3FoZ/hTQRqHn9ELh8wwk
         UStA==
X-Gm-Message-State: AOAM530TWt7Eclwj4XS12K7/WtjT2gEIaP0vX29PjxjI3AKmCEY82AzB
        d5BYYPsd7gxF0prgF5lkkFP+7g==
X-Google-Smtp-Source: ABdhPJwY/1TJG7L7RerhERXqtMG6SafnRc1eHuU6L6rRUrw+CzYH7wLxvgse2hr0LN/cqbT0TDkxCw==
X-Received: by 2002:a05:622a:1cb:: with SMTP id t11mr7455171qtw.282.1613055292455;
        Thu, 11 Feb 2021 06:54:52 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:666f:3d4:2894:5ee9])
        by smtp.gmail.com with ESMTPSA id b82sm4072886qkc.34.2021.02.11.06.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Feb 2021 06:54:52 -0800 (PST)
Date:   Thu, 11 Feb 2021 09:54:49 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        dstolee@microsoft.com, peff@peff.net
Subject: Re: [PATCH 7/9] pack-revindex: read multi-pack reverse indexes
Message-ID: <YCVFOcQ7Uo1ujvAt@nand.local>
References: <cover.1612998106.git.me@ttaylorr.com>
 <4c5e64c5fcb2948a0598d6e0c70097a9561716a9.1612998106.git.me@ttaylorr.com>
 <xmqqpn17xcnk.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpn17xcnk.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Feb 10, 2021 at 11:54:23PM -0800, Junio C Hamano wrote:
> Taylor Blau <me@ttaylorr.com> writes:
>
> > diff --git a/pack-revindex.c b/pack-revindex.c
> > index 83fe4de773..da4101f4b2 100644
> > --- a/pack-revindex.c
> > +++ b/pack-revindex.c
> > @@ -3,6 +3,7 @@
> >  #include "object-store.h"
> >  #include "packfile.h"
> >  #include "config.h"
> > +#include "midx.h"
>
> This seems to assume that the topic tb/pack-revindex-on-disk is
> already there?

Yeah, this topic depends on tb/pack-revindex-on-disk, which looks like
will be merged to master according to your last What's Cooking email.

> Just trying to establish what dependencies the bunch of topics have
> among themselves.

Thanks, I hope that it wasn't too much trouble.

Taylor
