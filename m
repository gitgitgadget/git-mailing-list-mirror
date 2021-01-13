Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D3D1C433E0
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC36723329
	for <git@archiver.kernel.org>; Wed, 13 Jan 2021 15:21:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbhAMPVH (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 10:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbhAMPVH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 10:21:07 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25A6BC061575
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:20:27 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id a6so1288764qtw.6
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 07:20:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=raijniS9uiolOhH275Lf0ftA3oS2J8gnxZTOa0CJC/A=;
        b=xuVG6xrKbgQvW5u12qJKfsk0Gjr8X5HFfMBknrKUbyph84u0eScNvefkDliU4JozMO
         CNtrzrh4SS0TNA2zlQT32x2Ihcwu4fCX0NPfRd5+SN4+9bRCx7DZglCFoT2L/WPdjnTI
         75DjgKebKp9i8VgK2qt7YOEXL5NCFlUM3x7/Cykmh5tAgtYID8IXnu2q3J8gz1mVb1+Y
         bGGtqAypu9arkyBtrfnM376BSZ0NhN5JfBBk+xPGJ0hYwDnND/P2cU+Ue3wT5UFQiZNb
         NN9h0Qqo/6DPzymLyeEU0X6icHNTV6HhpGgPKcdRobhipTiVXbZIA2fiYdekas94tzNw
         KOVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=raijniS9uiolOhH275Lf0ftA3oS2J8gnxZTOa0CJC/A=;
        b=GxfQIzENoUeaYcpZnZdKsPGoTKbbzi5Hzw/szTwkwlHjYt+NrPumvaMnoiPxPSuNjX
         6AD4SNmOBuarvsJPndLInmSZUCgtLMsp0yb43sPWyvdgSCmd8003BUMQzrhA5R3YXGUO
         9aQQ3g4WT2YYJNYx5TZJydB9z7r3NkxA3CLQ6/XLq6v4nI544IFtk0BJZgrpOMIXClZ7
         DzvKsuIrnIzu2qDdBnam6u0cZL9h0A9fbxQTLPmTfozEZonO71o85u1yQmHxFew2wSuy
         DpAWaaHyw1p0srmRvb9IemHIm0JCYpR20Ozf1zhaSl+E7s319zj88JUvc1JBRWecTEsL
         wJvw==
X-Gm-Message-State: AOAM5319wru2hai+QFntCwXE6f4xtUFSDY+19LelLozwGp/aZu+BUng0
        aYnOoIt1XlW4DjjCpq3GVSQKaQ==
X-Google-Smtp-Source: ABdhPJwNVXkSe8nfhtfpFJ1DtSQfosn64jH91gOt48JpKS3fd+GYPFgbsPXAC/3NjRTql/6lU7S3jA==
X-Received: by 2002:aed:3051:: with SMTP id 75mr2719431qte.64.1610551226409;
        Wed, 13 Jan 2021 07:20:26 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:f17c:3911:cace:ed91])
        by smtp.gmail.com with ESMTPSA id l11sm1074141qtn.83.2021.01.13.07.20.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 07:20:25 -0800 (PST)
Date:   Wed, 13 Jan 2021 10:20:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Christian Couder <christian.couder@gmail.com>, git@vger.kernel.org,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <chriscool@tuxfamily.org>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH 2/2] fetch-pack: refactor writing promisor file
Message-ID: <X/8PtpCRJ4w19zGs@nand.local>
References: <20210112082159.2277214-1-chriscool@tuxfamily.org>
 <20210112082159.2277214-2-chriscool@tuxfamily.org>
 <X/701Isbo8M9W2VP@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <X/701Isbo8M9W2VP@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 13, 2021 at 08:25:40AM -0500, Jeff King wrote:
> > +void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought)
> > +{
> > +	int i;
> > +	FILE *output = xfopen(promisor_name, "w");
> > +
> > +	for (i = 0; i < nr_sought; i++)
> > +		fprintf(output, "%s %s\n", oid_to_hex(&sought[i]->old_oid),
> > +			sought[i]->name);
> > +	fclose(output);
> > +}
>
> We check errors on open via xfopen(), which is good. But we would not
> notice any problems writing via fprintf or fclose. Is it worth doing
> something like:
>
>   err = ferror(output);
>   err |= fclose(output);
>   return err ? -1 : 0;
>
> ?

I agree below that *not* doing this isn't a regression against the
current code, since it doesn't check either, but this could be done
relatively easily. It is appropriate for both callers of
write_promisor_file() to immediately die() if they get an error, so I
think that this is potentially worth doing.

> (As an aside, this ferror/fclose dance is awkward enough and has caused
> us enough questions in the past that I wonder if it is worth
> encapsulating into a wrapper).

From a quick grep through uses of ferror, there are a reasonable handful
of spots that I think could be improved if there was a ferror+fclose
helper, perhaps: xfclose().

> The existing callers behave the same way (checking open, but not the
> writes), so definitely not a regression. But the helper function may
> provide an opportunity to make things more robust without adding a lot
> of duplicated code.

Yep.

> -Peff

Thanks,
Taylor
