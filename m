Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8208EC64E7C
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 18:25:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F79922249
	for <git@archiver.kernel.org>; Wed,  2 Dec 2020 18:25:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389311AbgLBSZz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Dec 2020 13:25:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729173AbgLBSZy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Dec 2020 13:25:54 -0500
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DE9C0613D4
        for <git@vger.kernel.org>; Wed,  2 Dec 2020 10:25:08 -0800 (PST)
Received: by mail-pg1-x544.google.com with SMTP id g18so1614417pgk.1
        for <git@vger.kernel.org>; Wed, 02 Dec 2020 10:25:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1EfIChaM2Q99M0nbBEoI56UXhXlGfQ7RTlRu1y21qBw=;
        b=vNzKHAFZ9jv2/2A7RvxV5wDbR3o2jaaHbOYPCXjxdzmM7f5dmx/IbOeNdxeitwrfq0
         LnNL1VFKf1Wc1u+AJqGgHLGrK4Rtv7KYrKO3EP5B43RdvgFt48iheYs6OEyCv3t4POBr
         XDAKcRnNHQR3t8BZ5sW2Q3e1G8SsqJpk59lUQuYJvOu4cZTNiYdGPOXG5LOjlapnMeys
         EV0YL6aEVsCJnbmMP1q1PPjiSDrONrQ2V5ajOcjlmNcaR2Pu+nEkcgkZCsv9EmoEAHSS
         ZuXOqHPbU0KNYx+aRarvYBkDiMU4u9txvFC0wOrA/vRbPGw+pqJ4sw0m63jCY5zli03W
         15HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1EfIChaM2Q99M0nbBEoI56UXhXlGfQ7RTlRu1y21qBw=;
        b=i2IuMGbMGdLRnM8b66oUcqS/ro3PS4aM6iYLYfFjZbBOjw36cESh06qadliWr913jL
         kGyIEP45Qeykz/ac27i6+NAWFUc1cGWt9Yx9QthppnREjQ4wq/CiNRy41gNZ9Aqz+7l/
         qGZXuUpc4Cw7wEy8MQntU7RFPNG02K1wOkH7Fpt46uyzVDyZLhVRC5CjJLsq5lOXAl2g
         vjb0E0ubFzwsFcXbTxYMG3+saHza/MaFKnCV1KAcJ0CtlBzXcP2r9A1m2VxY7Af1ZDge
         w0+Az7wY0hNiNjRnuy4b5ilWqgHL7NN/FivJoHWrifegFSjQ73BBPh7zwHEXuRurNuPi
         aEbg==
X-Gm-Message-State: AOAM530nCe0ujN4gzmlGNtdc5bFlByMpGUBsoEjWtuMWK7xtPk3sfi02
        P0iWshfvQcbppwTdyqfJHrdSCA==
X-Google-Smtp-Source: ABdhPJwL0XreJMJdF1DR0MDV34zEhFoChNJeFIFbfBEdSyWNoB0VPMYiaQOhY3GSL8ddQ0lxOmQ4hQ==
X-Received: by 2002:a63:c43:: with SMTP id 3mr1042981pgm.222.1606933508454;
        Wed, 02 Dec 2020 10:25:08 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id v24sm388223pgi.61.2020.12.02.10.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Dec 2020 10:25:07 -0800 (PST)
Date:   Wed, 2 Dec 2020 13:25:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Derrick Stolee <stolee@gmail.com>,
        git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        peff@peff.net, martin.agren@gmail.com, szeder.dev@gmail.com
Subject: Re: [PATCH v2 24/24] pack-bitmap-write: better reuse bitmaps
Message-ID: <X8fcAZU30P5MdfRR@nand.local>
References: <42399a1c2e52e1d055a2d0ad96af2ca4dce6b1a0.1605649533.git.me@ttaylorr.com>
 <20201202080808.3482917-1-jonathantanmy@google.com>
 <X8fCViBtnDek6oAI@nand.local>
 <39441f40-f496-af81-87c1-9d7e04fdef20@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <39441f40-f496-af81-87c1-9d7e04fdef20@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Dec 02, 2020 at 01:22:27PM -0500, Derrick Stolee wrote:
> >> We could even skip the whole maximal stuff (for commits with existing
> >> bitmaps) and replace "c_ent->maximal = 1;" above with "add to list that
> >> we're going to append to bb->commits at the very end". That has the
> >> advantage of not having to redefine "maximal".
> >
> > Hmm. I'd trust Stolee's opinion over mine here, so I'll be curious what
> > he has to say.
>
> It would be equivalent to add it to the list and then continuing the
> loop instead of piggy-backing on the if (c_ent->maximal) block, followed
> by a trivial loop over the (nullified) parents.

Jonathan: does that seem OK to you to leave it as-is? If you don't have
strong objections, I'll go ahead with sending v3 a little later today.

Thanks,
Taylor
