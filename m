Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7978EB64D7
	for <git@archiver.kernel.org>; Wed, 21 Jun 2023 12:08:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231841AbjFUMIr (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Jun 2023 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229803AbjFUMIp (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Jun 2023 08:08:45 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A611710
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:08:44 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1acfdbb394dso1179560fac.2
        for <git@vger.kernel.org>; Wed, 21 Jun 2023 05:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1687349324; x=1689941324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1qcHa69v14BmYhgp6KxQQ0GNbD5LUCz+sNpxHAHHdG4=;
        b=s9dgRXx8qW4WZxxNnwOKD9QsRjLvXNPEtRloo/xm8quz0H1MZachTHLi69ee1YCaEh
         UCZvCZNVnp8wMfe56OBrkf63F4nqxp5cRnQMk0UF+pEk/q/xllSAqr9+YeVWA5ayx2+x
         vtknXB1Pj+7CMkG1RLc3CWu2W4vJVvMLqreK9DZbTCvkdPnH8Hrm95WYFBo5amfE4pqL
         fBD1GVsCCFyRtrdThuNFqUZ1uH64HxslxC1nd/xpVRikFb76NQ+IvMSrYJdZeyiQdNVH
         bNJYYlJmkCLTOkxpV6Bu5VGiYPP8cC6sjlL/XRVTu+VdcVT+lcoowbz+40gT8vdMv1UN
         wQjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687349324; x=1689941324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1qcHa69v14BmYhgp6KxQQ0GNbD5LUCz+sNpxHAHHdG4=;
        b=Dj2bXXE4Q87aTdS2+IN/oKQP7Kn2h66/v6ZyinfJqN1wrZBk1WtBPXrhg0exCHYrey
         +qrP+UTip9zOrJKpnAxNVqoAe2XK94w/dWvx9ZRm53Gy825wqeENUx2ju+b5VS0lHSPX
         aZbw8e76BxkNQWQkgHTPxy5g1m3eWTlI/zD47gP8VuoeAo7xsnDgz8iht2ur47BDEZFm
         gKoo9qfx6ZpebqbMdqwI0xgP2lzWlAdzcznO+TiDMKFonMRU8fB0CNwMIaMDGu9ZYMaA
         X1t4YRrvuWbH6QDcg6xsYts7GaFvKsNEZTrj04r+VQRMx8iv3B5DvXY9EIGdCgCoamYL
         sVgg==
X-Gm-Message-State: AC+VfDylyCVieASLm03SDoRkDt7Gikyu9y+ZqTqFbFsMtYWLlfYHmXd0
        5xbiPRIu92IUyTsmRwXM4TQXHe1quGzBFfglg1YOV8XK
X-Google-Smtp-Source: ACHHUZ6hp5yiM9DArAwwboeySQTWSjVMc3KRX6B/ERbvh7hH0wRSi8mou5T33c+XZbDxvCqW96Vf6A==
X-Received: by 2002:a05:6870:628a:b0:1aa:2a9f:7ea4 with SMTP id s10-20020a056870628a00b001aa2a9f7ea4mr5810672oan.21.1687349323862;
        Wed, 21 Jun 2023 05:08:43 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id z7-20020a818907000000b0056d304e224dsm1066623ywf.90.2023.06.21.05.08.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Jun 2023 05:08:43 -0700 (PDT)
Date:   Wed, 21 Jun 2023 08:08:40 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v4 1/4] gitformat-commit-graph: describe version 2 of BDAT
Message-ID: <ZJLoSDcETsPMyONL@nand.local>
References: <cover.1684790529.git.jonathantanmy@google.com>
 <cover.1686677910.git.jonathantanmy@google.com>
 <a3b52af4c96db9a8164119e8ace0541db47b6815.1686677910.git.jonathantanmy@google.com>
 <xmqqlegn3tz3.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqlegn3tz3.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 13, 2023 at 02:58:24PM -0700, Junio C Hamano wrote:
> "bloom" -> "Bloom", probably, as the name comes from the name of its
> inventor (just like we spell "Boolean", not "boolean").

Indeed.

> > +	when char is signed and the repository has path names that have characters >=
> > +	0x80; Git supports reading and writing them, but this ability will be removed
> > +	in a future version of Git.
>
> Makes sense.
>
> I wonder if we want to mention what the undesired misbehaviour the
> "bug" causes and what we do to avoid getting affected by the bug
> here.  If we can say something like "When querying for a pathname
> with a byte with high-bit set, the buggy filter may produce false
> negative, making the filter unusable, but asking for a pathname
> without such a byte produces no false negatives (even though we may
> get false positives).  When Git reads version 1 filter data, it
> refrains from using it for processing paths with high-bit set to
> avoid triggering the bug", then it would be ideal.

Your description of the bug matches my understanding of the issue, that
a corrupt filter would produce false negatives and thus be unusable.

I skimmed through the rest of the series, and couldn't find a spot where
we do the latter, i.e. still use v1 filters as long as we don't have any
characters in the path with high-order bits set.

I think this would be as simple as modifying the Bloom filter query
function to return "maybe" before even trying to hash a path with at
least one character with its high-bit set.

Apologies if this functionality is implemented and I just missed it.

Thanks,
Taylor
