Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1930CC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3343613C5
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 22:22:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235225AbhGNWZL (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 18:25:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbhGNWZL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 18:25:11 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A91C06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:22:18 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id u7so4098117ion.3
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 15:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=1dEiUKFoCbCdAR0Dk0/LImQvy6+hrcgcj+uGAUO/XDk=;
        b=C+Uy21RrE0OZqBFWZZexXDLr86HkFi2UUFzD9DeXax9yAWA5p2t1M9INoPcgqbsIVk
         J3YslOlD+gD/I9OG9fU6HU+67czYIxtTKBZJWt5g8ux648uDgLrvHoiP23hl9AeNSvYT
         t7CyRYQMPNRJS6wrguUOnMx6pq0bJ0Yla9Dn7sBk/v80b61YHv1oYe+FxAZBebuXhmtZ
         PA4NU+3FeQ3pTVapJNsUJ5qp6Fz2PkeJvgqGY15uJl5vjfyILHWEDhzyWdu/u1C2y7u9
         fgOlY3RP6zHvG1I9/MY1vIF0rZvI5T2/X4MLH0aLhmcWl7LAZDDFzfdQydYE2yGft0eM
         WUmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=1dEiUKFoCbCdAR0Dk0/LImQvy6+hrcgcj+uGAUO/XDk=;
        b=RgSw28y3oE2LjxCbfUgbs9dMS7COAdDQE66+tjvup4e9Xyvh6ojdVPpnq1x/SuLYwR
         j/a9OD81diGyYXpM25cudPtm55Y1EIInvYu+3oyQnK1brtejP5/yv80dwmANLl8Fb7+M
         9x+wYM+nd2Dw6o9PwHyAaJTvqKnXfFQtS5CKmScfKoQ505SL2U5Mr6XHJ1DfUWp8O04l
         PHJb7zUnV8qxHm3stWvaWxFRMiwV/7OwiZrFO4kgGZTl2uUmAPZMun0uAwsRBjpvMojH
         yfvXpFfPB0mOrdnnV0tzIDZsKnSi1MVqCT1qs98m//jkBtH/OHlSWvwMMXwzKik36sOj
         PFPA==
X-Gm-Message-State: AOAM5319UkFN3c6UL6QAcmif+wwZNHFG523u3Mr0Ei7dy67UCVDyNPRC
        zBazKLj1qKFjcU2ZFu8QZhXArQ==
X-Google-Smtp-Source: ABdhPJykQUqyEExkc9uPzg/Y8vjMT3G0VHIGwHrjvrimDOONoxgDCEkscVslIeIYZBSoRjcQhdJTYg==
X-Received: by 2002:a6b:5c18:: with SMTP id z24mr284002ioh.88.1626301338285;
        Wed, 14 Jul 2021 15:22:18 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:3f15:e25d:cd63:d019])
        by smtp.gmail.com with ESMTPSA id m12sm1946197iln.43.2021.07.14.15.22.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 15:22:18 -0700 (PDT)
Date:   Wed, 14 Jul 2021 18:22:17 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: GIT_CONFIG and user.email/name
Message-ID: <YO9jmdW9oz+beUKg@nand.local>
References: <1C6C1E49-5EC1-420D-A72A-8C50BD1931A2@getmailspring.com>
 <YO8ordiN18sNP6tA@coredump.intra.peff.net>
 <xmqqeec0vczo.fsf@gitster.g>
 <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YO9YyTZdU4WadYGg@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 14, 2021 at 05:36:09PM -0400, Jeff King wrote:
> Here's a short series to improve things.
>
>   [1/3]: doc/git-config: explain --file instead of referring to GIT_CONFIG
>   [2/3]: doc/git-config: clarify GIT_CONFIG environment variable
>   [3/3]: doc/git-config: simplify "override" advice for FILES section
>
>  Documentation/git-config.txt | 28 +++++++++++++++++-----------
>  1 file changed, 17 insertions(+), 11 deletions(-)

Looks very good to me. I left a small note on the first patch, but you
should feel free to ignore it, since I'm not sure whether my suggestion
is an improvement or not ;).

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
