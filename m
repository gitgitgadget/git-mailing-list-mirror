Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17D33C433B4
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D0B4A60233
	for <git@archiver.kernel.org>; Thu,  8 Apr 2021 21:51:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbhDHVve (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 8 Apr 2021 17:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232158AbhDHVvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Apr 2021 17:51:33 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F43AC061760
        for <git@vger.kernel.org>; Thu,  8 Apr 2021 14:51:18 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id hq27so5455047ejc.9
        for <git@vger.kernel.org>; Thu, 08 Apr 2021 14:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=R9nw8ySuFs6faNnVLdfE3Ib4ytihEOksdl3PO8RKMio=;
        b=G7dqp9kmuDfLGbS815HPvyveNuwHN2E4/Y04n7Al6/M/MLReoluHSUhqK8WBMnGLyk
         o5r7RHxyRetn0dkKfr/fTFHdD9VW+42LHcxDiCFNoGV240w45bJ3LvMTyi5U83lbw45E
         d3OUchKCtW5doXqD0qaIJK33geyDU/L5vr6MkUVLnFkKa0ThURm8c8XaRl45dDoJ2nsk
         UbD1uqaqZzpXfvnYnL6ZZgIOWJhq4uR9v5do1NAFaAAp3xMuIg6v/lhQp3dWSOdF/IY2
         GLqDouKdYqZA6Dit9iZOWNxiZzHSISuHNgTablyJKVRFqsef3mNDCMBTV3XgWIXAE7vC
         bWRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=R9nw8ySuFs6faNnVLdfE3Ib4ytihEOksdl3PO8RKMio=;
        b=IDMAPYB5djBq81zyto9e5XZCQ/62aVqrFqXY7lcX5DjAoPOniCxUBz2U4eQD59t6mo
         P7utwfsF9YoOAQb65G0vfTiLqWsAGB9sa+svWJmodT1ofnKng2X+FeVgid8YTyXt09Yd
         jyQb7/B8c1RHzI9fGy4aQag3OKwzqx4eJJoqW73F+6WHfgMCJASisEl/JRF3iCh0IGeV
         iuX6ZgsDDNUYP2AOH74Kib9z58520WJfkR5WssRPn4uBqsUo5gStg97bH9ZhGoTCm0YT
         KoMTBdUxRT8G7OyhmTdVwVPCtI4Idu5Br6vDWo4nkZYQrTYkIDWP4WWyJq9pN/7bRo+d
         QHLQ==
X-Gm-Message-State: AOAM531Hk1nRSoW+mOLplfquY7qGtIue344KxYMLye1P3SdMRbslXKkP
        RajkQB84h0m7u/2ioKuSp3Q=
X-Google-Smtp-Source: ABdhPJwxqd14t2/ZJxhdGWd8fc+i2SViiTSGDKHxdRM5Fq0MnbKFdzEFuRUgY65LKkdo4OhUrCHq2Q==
X-Received: by 2002:a17:906:9385:: with SMTP id l5mr4574251ejx.32.1617918677214;
        Thu, 08 Apr 2021 14:51:17 -0700 (PDT)
Received: from szeder.dev (94-21-58-238.pool.digikabel.hu. [94.21.58.238])
        by smtp.gmail.com with ESMTPSA id y7sm310631edq.88.2021.04.08.14.51.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Apr 2021 14:51:17 -0700 (PDT)
Date:   Thu, 8 Apr 2021 23:51:15 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Sergey Organov <sorganov@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Philip Oakley <philipoakley@iee.email>,
        Elijah Newren <newren@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/9] diff-merges: introduce log.diffMerges config variable
Message-ID: <20210408215115.GB1938@szeder.dev>
References: <20210407225608.14611-1-sorganov@gmail.com>
 <20210407225608.14611-4-sorganov@gmail.com>
 <20210408213736.GB2947267@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20210408213736.GB2947267@szeder.dev>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 08, 2021 at 11:37:36PM +0200, SZEDER Gábor wrote:
> On Thu, Apr 08, 2021 at 01:56:02AM +0300, Sergey Organov wrote:
> > New log.diffMerges configuration variable sets the format that
> > --diff-merges=def will be using. The default is "separate".
> > 
> > Signed-off-by: Sergey Organov <sorganov@gmail.com>
> > ---
> >  builtin/log.c |  2 ++
> >  diff-merges.c | 11 +++++++++++
> >  diff-merges.h |  2 ++
> >  3 files changed, 15 insertions(+)
> 
> Please don't forget to document this new configuration variable.

Oh, just noticed that you do document it in the last patch of the
series, and, similarly, you add new options early in this patch series
and add the corresponding documentation in the second to last patch.
Please squash in those documentation updates into the corresponding
patches.

