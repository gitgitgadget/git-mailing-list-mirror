Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A743AC47096
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:25:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FBF2613FF
	for <git@archiver.kernel.org>; Thu,  3 Jun 2021 22:25:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230361AbhFCW13 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Jun 2021 18:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbhFCW13 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Jun 2021 18:27:29 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B565BC061756
        for <git@vger.kernel.org>; Thu,  3 Jun 2021 15:25:33 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id h24-20020a9d64180000b029036edcf8f9a6so7317334otl.3
        for <git@vger.kernel.org>; Thu, 03 Jun 2021 15:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=pcrY4566SHEO1zATAa0iI6g0mOOyp5dRo1qEhJ09XPg=;
        b=lqiR7Q4WxiQVSeIqNES2WD7UfuUCWRLUTOB2vD20N3sIVm25sRD/eobv/RKsiBNzLk
         A+uKC/QytmwF4e/YDzbyRUOkb9zp6NWUq1jKSK0cB1ZppUZmJaNUzRs/GWyTru9zw1xu
         2wHyJp8jDS7FChshllIFsyhl8ZTpNmExl/p1PB68/QR4CUH+fVUh6M0YPqljT8Zv7OaI
         vQoaymFl3wdHC3Hl6QbYpPQm2Ph6+NiImGKkY/QjWaDreff0KLZIUQWBvvnNhgTZbrGq
         tVgUyZN0q/VDncQCZ2xuUjzRW+Hl03UOaoHF27uuwLnfpFZi/ibjM+SvKsBPkGhpq93Q
         rfmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=pcrY4566SHEO1zATAa0iI6g0mOOyp5dRo1qEhJ09XPg=;
        b=PF9G+Xf/m8ru/5JMnbxfIDURvXLUjlyziDDt2IxXtmK5ZOyuLZ2SjL2cm0wOpQUsqx
         vDmgg6vIhrb+DkyZdjnRcMVg6ZnOojdKUgyhl+gxMiRqUzMaBCXj6sl1f41JDff+brh1
         8lo8kUEXJPW23+QyvJVjBbm/2F7vrQbx7pAR3W3r6gFtnLwSOghgT8UNuhepeVAoWjFY
         37TWcjXUqTNqCiCgKm1b9G3XM0CFnlNz9elhW7AGf1KHnOypYeMMQ0K5TuhZiOwV0hpk
         mebH3u7yEattxgTUvYAn2RCB8YfHlWzZaA3ZlrlVFrPeawagMDi0+oVgtepSOLxXnmen
         LD8g==
X-Gm-Message-State: AOAM532ehZz/DwT+nG1XLetnu3uhmyk6auGrySGhwyzYZUr3JH0LqXAy
        gJeaBhrFPYnzC37a1llTNIc=
X-Google-Smtp-Source: ABdhPJwLIxhEApc6bTo4m0k+gRG41Kq4etRq/nMNRUFXESNi1xrazyRQGXwVZn95/rw8jhwa5jNQxA==
X-Received: by 2002:a05:6830:1c3d:: with SMTP id f29mr1288800ote.248.1622759133109;
        Thu, 03 Jun 2021 15:25:33 -0700 (PDT)
Received: from localhost (fixed-187-190-78-172.totalplay.net. [187.190.78.172])
        by smtp.gmail.com with ESMTPSA id p25sm56583ood.4.2021.06.03.15.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 15:25:32 -0700 (PDT)
Date:   Thu, 03 Jun 2021 17:25:30 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Jeff King <peff@peff.net>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, Stefan Beller <sbeller@google.com>,
        David Turner <novalis@novalis.org>,
        Brandon Williams <bmwill@google.com>, git@vger.kernel.org
Message-ID: <60b956da36dad_39f8372088d@natae.notmuch>
In-Reply-To: <YLlEx5qlN7rgehaP@coredump.intra.peff.net>
References: <20170720232040.GA159617@aiede.mtv.corp.google.com>
 <d0da02a8b6f0272fa70ae3b1dc80fee6c6ee8d18.1501111803.git.mhagger@alum.mit.edu>
 <87y2bv0yvl.fsf@evledraar.gmail.com>
 <YLkwCTcRT/9s8+5R@coredump.intra.peff.net>
 <60b93a264cb7_39da0420855@natae.notmuch>
 <YLlEx5qlN7rgehaP@coredump.intra.peff.net>
Subject: Re: [PATCH] packed_ref_store: handle a packed-refs file that is a
 symlink
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King wrote:
> On Thu, Jun 03, 2021 at 03:23:02PM -0500, Felipe Contreras wrote:
> 
> > Jeff King wrote:
> > > Preemptively finding portability problems may save work in the long
> > > term. And people may even be using Git on AIX and just ignoring test
> > > failures, or they have GNU coreutils installed anyway, etc. But it would
> > > also save work if we can ignore platforms that nobody uses.
> > 
> > I agree, but the Git project is overly preoccupied (IMO) with
> > hypothetical issues some hypothetical users might have in some
> > hypothetical situations, and that is used as a rationale to block changes
> > that would improve the experience of the vast majority of users.
> > 
> > This is not a hypothetical issue, and yet you are suggesting to
> > discount it?
> > 
> > I don't disagree, but this is not consistent.
> 
> I don't think they're the same issue at all.

> One is: we have millions of users, and this change may affect some of
> them negatively, so we may want to err on the side of caution.

This language may sound nice, but it doesn't match the behavior, which is
much more akin to "this change may affect some of them negatively,
therefore we must tune it forever so it never actually happens".

Few people would object to erring on the side of caution.

> The other is: this has been accidentally broken for four years and
> nobody complained, so perhaps nobody is actually using it.

Yes, maybe. Or maybe they haven't reported it yet.

Either way I was confusing this issue with another one. This one does
seem much less serious than I was thinking.

Cheers.

-- 
Felipe Contreras
