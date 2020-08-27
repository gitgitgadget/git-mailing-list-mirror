Return-Path: <SRS0=R9sp=CF=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03A58C433E1
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 14:31:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07A62087D
	for <git@archiver.kernel.org>; Thu, 27 Aug 2020 14:31:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv4ljqmE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbgH0Obe (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727048AbgH0ObT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Aug 2020 10:31:19 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429EEC061264
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 07:31:19 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id m22so7907909eje.10
        for <git@vger.kernel.org>; Thu, 27 Aug 2020 07:31:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=62xPqj1aycAYkVIs+FMGP2VelBgnqJcrkp6PmO5qMPI=;
        b=Tv4ljqmEotJurEAqdlU5XSTZycwBeGP0lMuYppty7ce44Aqh0dnZgSqrT63SViI9Vk
         NQqEeQ0M29igep5sPockIHNUbk1K+WrO0Rj7iEkS7JQuP2y+d7Z/S8b9urWb5r81xtOk
         gan6J0dus/J2T0YprTfG+fPrZOnN/4fTD307oQycmmp/rxfWBrDvhVolljoxSDHMl/zr
         dX47vVHREo8095PuYpi6E8esZzvWFVs1OYJTlsMDHK+QpVWYx59qa44TmXX9F+Ff/76w
         enGriCDPc7Am9dPOVutFYO8oerdwsMThPDZ9zrrfel5/66Y0xHkgUAcd59Ybn644egDa
         SBbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=62xPqj1aycAYkVIs+FMGP2VelBgnqJcrkp6PmO5qMPI=;
        b=EU5J2vy/UyWiZfRjb6/2vXxiJ+v4/4KjRXTh2RZY7RZVD4fpSjTPn3n2aJHZO1V0k5
         44x3wHiwrvu20bCEqIs4TSMAEbrh7AhadyKuk5uhELY8rPphFaCVpnI1zkvjtnm5r7+U
         hPDItLLaFioVvBqryVus3mPa15NvPXa1Y/7B7+bCnjm+2I9KfXUJcuQ+y9Od5ZxEDWe3
         6OInsaZa3mChGq6X+mvvJP8XeqCIbYZye2momiUJTm5QwxgtBWKs9HcgR884lt/rfXKC
         QcK7p0DVbTdBdWW9GLzK718zyIEjjlo4CeGZNLxwFMol4ghNoWTgNX5lPxNJsajUN82y
         isKQ==
X-Gm-Message-State: AOAM532Dllxuf39TpXMwbQqY82Dy6+1jtwN3MgbCcw3XveDQ+sgNBWNp
        aKiWEqXUjhpQ2nVQ1vz0sMPlMqMRBU35vEObIudl2Gk4FQm9Sg==
X-Google-Smtp-Source: ABdhPJw9coueDIVPKgfr5vQj9rYxMOmfdZHAa3SYZXKMu8Va2+/0Y2fnF6aY9wTwLqIF4lMbbElBaElIR2qZwon1IHE=
X-Received: by 2002:a17:906:25d3:: with SMTP id n19mr20356802ejb.551.1598538677684;
 Thu, 27 Aug 2020 07:31:17 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 27 Aug 2020 16:31:06 +0200
Message-ID: <CAP8UFD3uXLS3TqeQ=nKJqfkjMTMBfBWMSmb24=mAjSt14hsdCg@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 66
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, lwn@lwn.net,
        Chris Torek <chris.torek@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?B?5a2Z5LiW6b6ZIHN1bnNoaWxvbmc=?= <sunshilong369@gmail.com>,
        Carlo Arenas <carenas@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 66th edition of Git Rev News is now published:

https://git.github.io/rev_news/2020/08/27/edition-66/

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/455
