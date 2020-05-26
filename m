Return-Path: <SRS0=GnTn=7I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5ECB3C433E0
	for <git@archiver.kernel.org>; Tue, 26 May 2020 17:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3953F2073B
	for <git@archiver.kernel.org>; Tue, 26 May 2020 17:10:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fw9CtUnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729823AbgEZRKq (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 May 2020 13:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388093AbgEZRKp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 26 May 2020 13:10:45 -0400
Received: from mail-ed1-x542.google.com (mail-ed1-x542.google.com [IPv6:2a00:1450:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FEE5C03E96D
        for <git@vger.kernel.org>; Tue, 26 May 2020 10:10:45 -0700 (PDT)
Received: by mail-ed1-x542.google.com with SMTP id m21so1745022eds.13
        for <git@vger.kernel.org>; Tue, 26 May 2020 10:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=4m7BzKUsqI6EbekP1BCGoP0yVNGwyAUGYcGQwYwrwFw=;
        b=fw9CtUnnxgY0MbK1Wz0qR3dlFSbGS3Y5nHBXoFLP6Pkw6E5yZ5VgId8K9lEADojBZv
         jSfgcMP/AZaswkZQfEmT/mMGWWrRJCTpsIdYChCHwT8AWWvMAl/lou3ZO/2UkylmM/Ft
         YPtuJVuE3WuRyeMRvVoYKGd+LVqfOposQyznuA1+oG9j067/YHfUc9Qb6Ac0evAbcbBh
         wFTAaTQ1z3v80NDjac2It61XisUKHDypusHlnsx12kyiJLQyrhFIhgF8I1q2rTrs05m7
         yq3k01u1NbXs7+m1ceT12w5nHJsc+B3a/lcNT3VK6234HymrQNEclHGnuDnxkT8qk3/q
         iL+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=4m7BzKUsqI6EbekP1BCGoP0yVNGwyAUGYcGQwYwrwFw=;
        b=k2EDRP1Z/lr2tlIfjA/YES82qIl30qOJihTlBrrKjJoQuwvulw2nURJoxSVqSxyGj/
         YOyKloDBzkd34O9RgLS1HUfFeFSaosMgG8J/UuRR6vRV0Ym0yBOZIUIfFl+oPFrF0+/r
         FOmKoOjocF9Tmtl12kOOvIuKRAtC9Ij0otVS1ZLteHKGFTivYxIe16xnh1HEdg55ox6H
         dtc7/pDomfOS0yqd93ngTtnrEktqtMDgVYI94njD1XbWCA/GXT9yBViHFQ6saYzVqj2A
         f0CxIqkTYbF8i0MlDYhBBwdTTUFn9El7t17AQmLfLPy72WNuKdzaCcfUhfKxSWq9FfQl
         YMTg==
X-Gm-Message-State: AOAM53231N/1bN7s9+f/z10iSH2qXbzq7WGkX9lZtsuMniFnP4bRSwph
        JElw/LmQItrD+8MwKMmk+x4kT8j1defezvbraMYxINfUpnM=
X-Google-Smtp-Source: ABdhPJwQtWohl/NY7unLA7bPtjhDCsL8fvm6mlf0dkOygDYns6oemTpBj3/FpZhWJa3wpQE7c4w86u2sLuXjrBrVaWw=
X-Received: by 2002:a50:9d46:: with SMTP id j6mr21634837edk.362.1590513043455;
 Tue, 26 May 2020 10:10:43 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Tue, 26 May 2020 19:10:32 +0200
Message-ID: <CAP8UFD3MvaAPMUwc=hW-bayDbNpxSX3jtMiPQro4b2Ai17GkNg@mail.gmail.com>
Subject: Draft of Git Rev News edition 63
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Damien Robert <damien.olivier.robert@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Elijah Newren <newren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone!

A draft of a new Git Rev News edition is available here:

  https://github.com/git/git.github.io/blob/master/rev_news/drafts/edition-63.md

Everyone is welcome to contribute in any section either by editing the
above page on GitHub and sending a pull request, or by commenting on
this GitHub issue:

  https://github.com/git/git.github.io/issues/430

You can also reply to this email.

In general all kinds of contribution, for example proofreading,
suggestions for articles or links, help on the issues in GitHub, and
so on, are very much appreciated.

I tried to cc everyone who appears in this edition, but maybe I missed
some people, sorry about that.

Jakub, Markus, Kaartic and me plan to publish this edition on Thursday
May 28th in the evening.

Thanks,
Christian.
