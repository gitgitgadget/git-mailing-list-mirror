Return-Path: <SRS0=Nv7C=AP=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B759BC433E0
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 21:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 829AE20771
	for <git@archiver.kernel.org>; Sat,  4 Jul 2020 21:47:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX2VUffk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727929AbgGDVrH (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jul 2020 17:47:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726643AbgGDVrH (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jul 2020 17:47:07 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA3E1C061794
        for <git@vger.kernel.org>; Sat,  4 Jul 2020 14:47:06 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id z17so31113914edr.9
        for <git@vger.kernel.org>; Sat, 04 Jul 2020 14:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+sGKzthxWNcNn31EGOnU74X2eIlRGomN75hyfWBh8Co=;
        b=VX2VUffkXd+4g95RjyDRekFb/LRplfXgBTZFvWVgJlbwGOjkxzTF74KM++WgKosVJ8
         fAzoPQHzc3IQggy+LJsWpKO3GR6frsSUXa1gQqXQPRjrtcpnzdNtbftW++RLo/KPkUA2
         8vFILEAo47OJhcAzUKCJcQbY3jnsy5a0U38FmADxeTdQJC/oHactBMn55B0X56nzkLGF
         toYkJV9rMYTT+oNVPzEnzpMaSqyG0+1LrAxaJsQi30hdWt5kSb1BFx8EOfW9/AdakEPK
         TfMX3IJ+2sikyaoXKHbyzbSWCXiqmyphSUlgnuBQ1llk9LCjcN6pByKqTGUlMhLGrDVc
         /1mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+sGKzthxWNcNn31EGOnU74X2eIlRGomN75hyfWBh8Co=;
        b=Ue2emOBNt53YhwFRjR5dcUgV+3nQUjkUCWvTmQdDhYwwSNtVqJbUYZRmp1n1RMo280
         Tp323n/DgyRc4iR5Edo5Ez7fQ2tMRFfwy2uB6p2pWfnS+KqGxLEkqEmmqXpFyzpN7nSx
         RDMIFksTZlVa0SrWzn2b14zA1Jk/Eb1Kib1cbQj4c0rDRz9Kwaj8s5BhaVCraL5Sy31p
         8kl2a1cfFlQ/AzPhlYtr7oRFGlWHlakCNPOFrgV8XQ58wa+BV6fs9geL4KFUvfzJE4Wo
         bMDa/esEmHbebaMrY1DolclAqcRe9AuNA87hXletvLLM27Qd+Q3mRgii0BKFXYbIqqWB
         f79w==
X-Gm-Message-State: AOAM530dz3dtd7+/fLrpYXQhujbnPotD/V9NB5D9rsfedHV+lN3fmpbo
        RqkBx5l1JJMHFP9jpxrCGElGphssBmYB8UqfH/ui7vgZ
X-Google-Smtp-Source: ABdhPJztFFg57OS74TkzQw6+Z5EtcBZdawDIbj7t0vWgTU8LZhEy6ybku8gDS1Yw6Z1uUmDhbTUn+8/Iq15InLOF0Pk=
X-Received: by 2002:a50:b0a1:: with SMTP id j30mr47760431edd.387.1593899225606;
 Sat, 04 Jul 2020 14:47:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200702192409.21865-1-shouryashukla.oo@gmail.com>
 <20200702192409.21865-4-shouryashukla.oo@gmail.com> <nycvar.QRO.7.76.6.2007031659580.50@tvgsbejvaqbjf.bet>
 <20200704152802.GA46571@konoha>
In-Reply-To: <20200704152802.GA46571@konoha>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Sat, 4 Jul 2020 23:46:54 +0200
Message-ID: <CAP8UFD1PZ=S401xUAiwcC4LJ+m-X0L2Lv6jQ84OfTZD4hP0K_w@mail.gmail.com>
Subject: Re: [PATCH 3/4] diff: change scope of the function count_lines()
To:     Shourya Shukla <shouryashukla.oo@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        git <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Jul 4, 2020 at 5:28 PM Shourya Shukla
<shouryashukla.oo@gmail.com> wrote:
>
> On 03/07 05:07, Johannes Schindelin wrote:

> > In addition, as with all such changes, we need to be careful to consider
> > whether unrelated function names coming in from system headers might
> > clash. In this case, I think `count_lines()` is a bit too generic, but
> > will probably not clash. Personally, I would probably have opted for
> > `count_lines_in_string()`.
>
> I do not see it clashing with any other functions. Do we need to change
> the name still (maybe to make the functions purpose even more clear)?

This patch might not be needed at all according to Dscho's review of
another patch in this series.
