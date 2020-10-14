Return-Path: <SRS0=1eW7=DV=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67382C433E7
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:11:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DDB4420691
	for <git@archiver.kernel.org>; Wed, 14 Oct 2020 19:11:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ly0pZyjX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390243AbgJNTLE (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Oct 2020 15:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389693AbgJNTLE (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Oct 2020 15:11:04 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 224DAC061755
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:11:03 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 10so380176pfp.5
        for <git@vger.kernel.org>; Wed, 14 Oct 2020 12:11:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7K3cnw8C9uUt1pgvtCW00xXcmeyNYUd1C+Jof4ER/kg=;
        b=Ly0pZyjXllKtXLAiqz3M80O/f/+3aWH3iLbn3eviCHhDZjVaSmwLbTAfBbv/Gtyw5u
         H+KEZOE9dw29ESvPPaR9bVEN1LW0yPOz4BuwhSsm0WvpCACt1V4V5LNFuxyz9R+Ofctu
         gkBg4kTbPr/BRc2A/m28rvCyKJaKIFm3sOqRjA+AHXFYr0m/hN9sJ/HTPueUdjTfpKfj
         B/II7ncpcl4cxTcIra6idJEkDau2Z5wp2MJrvKupBk03ras2tcETczBHREq6Gpn+fiYT
         1fH4kCJBGjBvK43t21/du5uu7rTFrsYlVrwaZtagK07A0tqgKQWt38vrff3lGQXH+Bqx
         jnCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7K3cnw8C9uUt1pgvtCW00xXcmeyNYUd1C+Jof4ER/kg=;
        b=ogHps+TBCBmUMnMBfnyznK5Qr5Tz7WDUdxn6GxuienqsyD7Bq97q+y46rVOr6u6wED
         ATAMwnBeQu9pecS7S1R/FSTeF0KmFKBdzmvffyA0BVm1pX+CkJ/1wrbrdidZaZgZGe31
         4ePNitNwbo5TO3Ny5BwOJc+94cTMWpjdPt58zilAVTpv3lJoR3DBIAJV6pwylnae/a4/
         qy3C01LDln5cr/V684BYOEqWCCvWr3qWqW9qYJQZMY8QeXhYKAfNJbowqwAgNAldC+Ew
         qao1Gc8nBLPR7FSH2VwMYXTsmWzDv1VwLAokka2zSpnz5Zy9Y4/pC4mDuQE6hg1ldAch
         tnOQ==
X-Gm-Message-State: AOAM532V25qcmtl6CIyszlpELtbAHxBNR5z5//NvNyMaZeIWETcB94MP
        I1P4Qhna3rFn6GFpXUKpzLG6gXGnbxzsyHHHC2ms+g==
X-Google-Smtp-Source: ABdhPJy8Rsajq26rJKcKb5aAYfK/7TTv0Me8bf1FIYj7f+vcpSt0BmBJMnr5BlHbRPwQaI6jEom2HnbS1m4XWm+L2TI=
X-Received: by 2002:a63:dc4f:: with SMTP id f15mr353931pgj.332.1602702662500;
 Wed, 14 Oct 2020 12:11:02 -0700 (PDT)
MIME-Version: 1.0
References: <20201013191729.2524700-1-smcallis@google.com> <20201013191729.2524700-3-smcallis@google.com>
 <20201013211453.GB3678071@coredump.intra.peff.net> <CAM4o00eCKP1+f=xBw4LJfNqrstEnutAe9StxknW9qLMtPBdhKQ@mail.gmail.com>
In-Reply-To: <CAM4o00eCKP1+f=xBw4LJfNqrstEnutAe9StxknW9qLMtPBdhKQ@mail.gmail.com>
From:   Sean McAllister <smcallis@google.com>
Date:   Wed, 14 Oct 2020 13:10:46 -0600
Message-ID: <CAM4o00fO++JMNdES03JKRyxmZtiLjkrJ2nux0-TZYBdH2+0ijA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] http: automatically retry some requests
To:     Jeff King <peff@peff.net>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Masaya Suzuki <masayasuzuki@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Oct 14, 2020 at 1:09 PM Sean McAllister <smcallis@google.com> wrote:
>
> On Tue, Oct 13, 2020 at 3:14 PM Jeff King <peff@peff.net> wrote:
> >
> > I do think you could be leveraging CURLINFO_RETRY_AFTER rather than
> > implementing your own header parsing, though.
> >
> Ah I didn't know about CURLINFO_RETRY_AFTER, I'll look at that and use
> it if I can.
>
I took a look, it looks like CURLINFO_RETRY_AFTER was only added in
7.66 (September, 2019),  so
I don't think it's reasonable to rely on it for getting the
Retry-After value in this case.
