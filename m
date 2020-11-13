Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F02C55ABD
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 06:48:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB5C222201
	for <git@archiver.kernel.org>; Fri, 13 Nov 2020 06:48:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MZ1e8Bdg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726231AbgKMGrs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 13 Nov 2020 01:47:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725999AbgKMGrs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 13 Nov 2020 01:47:48 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A159C0613D1
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 22:47:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id 23so8472025wrc.8
        for <git@vger.kernel.org>; Thu, 12 Nov 2020 22:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=g4PjB8H93snAqM+4yo4NY1iyRlGtxRqDjEn/T0CWrFg=;
        b=MZ1e8BdgDhHE9bOUZpFqaTZn6k8nk2xTZsC4bpx2Skx3uDz1cwIXOjCByGnIlZ/5AG
         VtxbbXbM/z2i5MTuWTuV+qRnWHJTUybytdjo9D8g5WqR/QoOARUr2PHqFudGSj25S0QP
         YCMERDBXU5ocd1VboY1Seix27TzMPYhG01/FYAPQjdMkiUiUTRC2rCQcCBZF9yc1n4UL
         CWwERIsKZRErEJ2u3WLMyZDXkr9VP8FIrnstIYfTLCMpORzJb+QznK4C21ewOATO4O4w
         71YFV71ALXQqsEuKe5uNFZIZynkPmUkRxSd4PUnlSh3jOsoFuZT1HM2jFgOfFqsLTy4J
         4mJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=g4PjB8H93snAqM+4yo4NY1iyRlGtxRqDjEn/T0CWrFg=;
        b=eZIMZ4wcTUAlTJdkB/USk73rvFKCgldrRUdBbo7exC6d/ABO5OGo+18iS6r6diQ5cE
         apyA16l0EUb+7g87x8GxqlXD/lWJdIPza3mhJijUue9bgIFC2IOKtUS/eJbTgcTkXUBi
         9zlxgGEBJqx4mEsWHp92mZbRPYOk0Aj0DDbav9xcqswAUKFXg0+Xg6S6IlrijF6boubr
         SVj0x6UDLIratRrl2Po46E0h1Z32w5gvxKQAugauNFkwsZznTR3Uqnrqj2G2gwRCVi4d
         YGG+/Z4BlDql56JDrAnxk0DlaBHO+Co/s1G9oOJAThH4twmwd3wS6pq2DNNpt5c10Mmh
         LHGA==
X-Gm-Message-State: AOAM532JL5vVu13FbyXsXK9Bk7oNaGN63TWUWuSTTxIlUV7NZSlJCpT6
        3nelBWmUV1G+YkYcFImeEDBttvhaH5DKyJHHYoA=
X-Google-Smtp-Source: ABdhPJysaMhptAycQGB5Pn2SS+zeWWjqLm4XNnmbpsfA/ArXXG0Fk2RiIuXqoiLtpoRwk6doyIpkErnsspm0Ijlwiy0=
X-Received: by 2002:a5d:474f:: with SMTP id o15mr1431911wrs.100.1605250054340;
 Thu, 12 Nov 2020 22:47:34 -0800 (PST)
MIME-Version: 1.0
References: <CAMP44s3BJ3dGsLJ-6yA-Po459=+m826KD9an4+P3qOY1vkbxZg@mail.gmail.com>
 <20201113010107.GL6252@camp.crustytoothpaste.net> <CAMP44s1U1FevS7NrAYxvgVyzfR5tnD9-+BbPdw5bKnaNHkyD+A@mail.gmail.com>
 <nbCkLegnP_kb-16UzAuDChE0p68ZtRD_3ZN3o3BJHYBYpUxTWuKjvhCSKT7zRZl_sckHrkyJl2fwePFUBR-HtDcEV0rHuac6Ygg-FrrYsYI=@goodman-wilson.com>
In-Reply-To: <nbCkLegnP_kb-16UzAuDChE0p68ZtRD_3ZN3o3BJHYBYpUxTWuKjvhCSKT7zRZl_sckHrkyJl2fwePFUBR-HtDcEV0rHuac6Ygg-FrrYsYI=@goodman-wilson.com>
From:   Felipe Contreras <felipe.contreras@gmail.com>
Date:   Fri, 13 Nov 2020 00:47:23 -0600
Message-ID: <CAMP44s1vx==-0Sh_dN66k-u_LwUSqQRn+ckMrYMHhz7i8ZVr2Q@mail.gmail.com>
Subject: Re: The master branch rename, and avoiding another v1.6.0 git-foo fiasco
To:     "D.E. Goodman-Wilson" <don@goodman-wilson.com>
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Nov 13, 2020 at 12:02 AM D.E. Goodman-Wilson
<don@goodman-wilson.com> wrote:
> > Did we hear the testimony of a single black person that was offended
> by the word?
>
> > Nobody affected by this change actually asked for this change
>
> Five minutes searching Twitter will reveal a great number of Black git users championing this change.

This is anecdotal evidence.

We all live in our own digital bubble. Every person's Twitter feed is
different, and Google search results depend on where you live, and
your past searches.

You may find "a great number" of users that match that criteria, what
I find is only people criticizing the move, and after five minutes I
haven't found a single black person actually offended by the current
name.

> How is reopening this discussion anything but a distraction?

This discussion never happened.

Everyone in the June thread argued about the different names of the
potential branch, and the culture war implications. Virtually *nobody*
argued about the manner of implementation: deprecation period, clear
warnings, Git 3.0 consideration.

I'd argue *that* was the distraction.

In 2008 people started multiple threads *after* the sudden change to
git-foo without warning happened.

If we do the same, this discussion will happen again. I'm just the
canary in the coal mine giving you a heads up.

Choosing to ignore the very real danger doesn't make the very real
danger go away, you are just delaying it and making it potentially
bigger. You choose to ignore the canary at your own peril. This is
precisely what happened in 2008.

Cheers.

-- 
Felipe Contreras
