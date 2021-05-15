Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22A6C433ED
	for <git@archiver.kernel.org>; Sat, 15 May 2021 13:30:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86243613C5
	for <git@archiver.kernel.org>; Sat, 15 May 2021 13:30:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbhEONbj (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 15 May 2021 09:31:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbhEONbg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 15 May 2021 09:31:36 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49208C061573
        for <git@vger.kernel.org>; Sat, 15 May 2021 06:30:23 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id z3so2202646oib.5
        for <git@vger.kernel.org>; Sat, 15 May 2021 06:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=7RaoLg9PhuP5qpDumkw6NvCpizQ+qa8IgdEn5AUbwYg=;
        b=pqAYqrWvnqjz7hVwUb77v3zeax4IUklwjATD7LIowOksyox9pQ1jXZ5vBspEUkZPeZ
         Z4RVpTJ7folFfjf4NzpPMcxvEE+ooCuVfBMECMuxpXqaZQ8oNEbZady4HtCaist9C4PO
         PhZqjQ1FHB0rWCf/g0VXX9klIqcDx1n934b347Uzc9cg/Ayrr6MCrNCkJ+dc+OU3o41k
         K1ysZhXHBxTNg5YyR8+mMQn6AVNenVGrnSwPagdW8YxvklDTXb9OlBDhbIX0OMW8Kcii
         79Dr/tFI5Ih3dhbGEEpGJVddr8tUGXpfJxRKApKzdZ8EPZvJ/fQfMpAtwEBgHxXN0txo
         K3Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=7RaoLg9PhuP5qpDumkw6NvCpizQ+qa8IgdEn5AUbwYg=;
        b=Kin/bmttfXgzv5/GRhaL1Slhq8VdAb6YPk7kk39jXdQAg61S+N8al1UHRhN3yNNsrF
         NI9/E99NZKAWa4r4Irr8pbf91BC2T80jFGIZCMTPUXZlnOwB4rm0teIa5nHYWlvoNDsf
         lnCmJsBt13a412ecAjdDSfQQvYLlRMkXx1xEBRmCjUItfq3nLp+RbbkO0VO7sUL/iF6T
         WzcCgmvH/950JO32XU4pVVN3JDgH88M1NqcG8VjZ+fLy1WDDWmiaCcysVAcKdcifDOGG
         rZfBZ/G4LvXVTxUeMIAz6ous06NxUygZOsbMkScnNeRnOpVRa7HbuUFwoET3XFX2YZcc
         5yrg==
X-Gm-Message-State: AOAM5324aMwu5YYd3gQcXm9cj9u46T7W+RrMl5PnbiOeXNjb5py3jro1
        D7ViZOHxXhBCVHqFuWn1Z3hAJBfuehrDPg==
X-Google-Smtp-Source: ABdhPJz/YPNlfb1yvgWFE/chZ05FgEumGttIGW1n6wxzMgRroUuR+v98k56pQC2e6MZiMswjg1TluQ==
X-Received: by 2002:a05:6808:54d:: with SMTP id i13mr37648677oig.100.1621085422630;
        Sat, 15 May 2021 06:30:22 -0700 (PDT)
Received: from localhost (fixed-187-189-165-231.totalplay.net. [187.189.165.231])
        by smtp.gmail.com with ESMTPSA id 9sm1726966oie.51.2021.05.15.06.30.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 May 2021 06:30:22 -0700 (PDT)
Date:   Sat, 15 May 2021 08:30:21 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?TWFydGluIMOFZ3Jlbg==?= <martin.agren@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, Jeff King <peff@peff.net>
Message-ID: <609fccedc384_c10bc208f2@natae.notmuch>
In-Reply-To: <YJ3ASK/LezQ86ct1@camp.crustytoothpaste.net>
References: <609b2828309fc_678ff2082@natae.notmuch>
 <20210512021138.63598-1-sandals@crustytoothpaste.net>
 <20210512021138.63598-2-sandals@crustytoothpaste.net>
 <609b5d814b95c_678ff208d6@natae.notmuch>
 <YJ3ASK/LezQ86ct1@camp.crustytoothpaste.net>
Subject: Re: [PATCH 2/2] doc: remove GNU_ROFF option
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

brian m. carlson wrote:
> On 2021-05-12 at 04:45:53, Felipe Contreras wrote:
> > I'm not sure of all that, but my machine uses Arch Linux, it ships with
> > groff, I've never used GNU_ROFF=1, and I can copy text with apostrophes
> > from the genrated man pages just fine.
> 
> I'll rephrase to be clearer.  Solaris 10 is still security supported,
> but no major Linux distro is, and I think we'll be both be fine dropping
> support for OSes shipped in 2005.
> 
> I'm glad to hear confirmation that things work for you, though.

I took at deep-dive and it turns Arch Linux configures groff to convert
\' to ', so even if git was doing something wrong, I wouldn't have
noticed.

Docbook fixed their problem in 2010, and I just sent a patch for
asciidoctor to properly fix their code as well. It should work on groff
though.

The configuration is in: `/usr/share/groff/site-tmac/man.local`, if you
want to check what your system is doing.

Cheers.

-- 
Felipe Contreras
