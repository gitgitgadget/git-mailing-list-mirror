Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DF43C4708F
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 06:34:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 091176139A
	for <git@archiver.kernel.org>; Tue,  1 Jun 2021 06:34:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233166AbhFAGgR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Jun 2021 02:36:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232906AbhFAGgP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Jun 2021 02:36:15 -0400
Received: from mail-oo1-xc36.google.com (mail-oo1-xc36.google.com [IPv6:2607:f8b0:4864:20::c36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 995BAC061574
        for <git@vger.kernel.org>; Mon, 31 May 2021 23:34:34 -0700 (PDT)
Received: by mail-oo1-xc36.google.com with SMTP id p67-20020a4a2f460000b0290245cdf2d1a4so55720oop.8
        for <git@vger.kernel.org>; Mon, 31 May 2021 23:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=KEA4iXfpmQhxVo0xccoAGCy1gpe84VA4+L1T4eZz+Js=;
        b=C+YFsE5YmR7ilG2CXGH4KzEObzptF54/1XtHlpZCT2x0ZViIGFKyVODrYg8/Jtddic
         FsccosGEu3e5CvnsEf6x1DvpzAjf+ATL50Iq3GNDtV64F9/Ce0IxPok+Do290IBBYqJu
         xdAb4dW2oHEzPQHJSWA3Tha2k55Iq/NHOM/2/nj6J3wjB5MaMFeI49MbI4IOutGtWper
         we+s3m5Rz/erfInE55EBPNNvro4eOQn+TzBrU0A0FHD+vKNuVglEcgGxC4RkherrMbmf
         qMCcFyH7dEaRHpwHjeV3v9XetJEqx1SgIZ2jyU59uDiCc4Dswnt16q2ZmeXDinfDvK5c
         kvzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=KEA4iXfpmQhxVo0xccoAGCy1gpe84VA4+L1T4eZz+Js=;
        b=OvmZcuv2RqNDbIkwPHky+k3h6RcvnsfolUyuQU756J+iKhUoyTvlAFLOa/xTGO8afh
         QDooIvDeJUtGNrlHKhQ9xWwyXSZrHsJ1jmo02H16TJ/XJdtfkYM0FJlwrrBNlCTgBwW0
         5T0nei8wNmVAfzsPaJNM59EtrvjENBTbzuufBiIkeq2U+t9ZSuJKXyE6nAgAmWnXeZb6
         P7hnaj0if3u6I2xMN0webEteqNZWqgzSmIsZXqujxzZvicucKOjTt0Ml2livxiGaEaIb
         evHJI5AJxz7IUYWpFQh3uskuHiTwOVP7tLERzIDSSMapPewUjOl0PBJjYjjiBpBWzhmx
         SlTQ==
X-Gm-Message-State: AOAM533/C4DSQijShX1Sm/pVzxyUcohQE0SVyf9mZV1F+8PpML76uZu8
        JF74m57e0eUD8V3gRKICjFg=
X-Google-Smtp-Source: ABdhPJwiaGkZP/LXUabVxbnpQQAXJQ2txJyQH9Mn1WqEn8UeQwTUYW+wE4ZDcffX+1Xofa8PPMLHCQ==
X-Received: by 2002:a4a:e084:: with SMTP id w4mr18742079oos.59.1622529274012;
        Mon, 31 May 2021 23:34:34 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id e22sm3516628otl.74.2021.05.31.23.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 23:34:33 -0700 (PDT)
Date:   Tue, 01 Jun 2021 01:34:32 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     ZheNing Hu <adlternative@gmail.com>,
        ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Message-ID: <60b5d4f87f30c_e359f2085e@natae.notmuch>
In-Reply-To: <YLWSRBJHiph+Bejo@coredump.intra.peff.net>
References: <pull.965.git.1622363366722.gitgitgadget@gmail.com>
 <YLP/GEN0qIXvWEUn@coredump.intra.peff.net>
 <CAOLTT8Q0zbxh8X03ZmgAzHadTbE4-Af+AB3POOUF2n22u8RExw@mail.gmail.com>
 <YLT2UfCZyQIXWIOv@coredump.intra.peff.net>
 <60b509be97423_24d2820856@natae.notmuch>
 <YLWSRBJHiph+Bejo@coredump.intra.peff.net>
Subject: Re: [PATCH] [GSOC] cat-file: fix --batch report changed-type bug
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Mon, May 31, 2021 at 11:07:26AM -0500, Felipe Contreras wrote:
> 
> > Jeff King wrote:
> > > The simplest test is just:
> > > 
> > >   git -C all-two cat-file --batch-all-objects --batch="%(objectname)" >/dev/null
> > > 
> > > which will currently fail. It would be nice to verify that its output is
> > > sensible, but I'm not sure how to easily do that (it will spew a bunch
> > > of binary tree data, and it cannot even be parsed reliably since we
> > > haven't output the sizes).
> > 
> > I use ruby to parse binary data from git all the time:
> > 
> >         git log --format='%b%x00' |
> >                 ruby -e 'ARGF.each("\0", chomp: true) { |chunk| p chunk }'
> 
> I doubt we'd want to add a ruby dependency to our test suite, but sure,
> we could do the same thing with perl.

I don't mean in the final patches, I mean while the patches are
being developed.

Once it's clear what the code should do, and how to verify it's doing
what it's supposed to be doing, we can decide how the test suite should
verify it.

Ruby is great for prototyping.

-- 
Felipe Contreras
