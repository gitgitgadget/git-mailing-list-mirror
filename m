Return-Path: <SRS0=4a08=AG=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA58FC433E0
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 09:11:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE81C20720
	for <git@archiver.kernel.org>; Thu, 25 Jun 2020 09:11:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mJ409xqb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389907AbgFYJLW (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 25 Jun 2020 05:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727878AbgFYJLV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 25 Jun 2020 05:11:21 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477CBC061573
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 02:11:21 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so2397945edy.1
        for <git@vger.kernel.org>; Thu, 25 Jun 2020 02:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=v9nYfTLZcRM1D7Mrf+11GsFY5/g05dpJBB7ZAbxFT9E=;
        b=mJ409xqbsmtvsXO/llhZgeIX6OpRaLTH/7lki/LeIZ+/RfthAMJBgvjz3QfWyE5O0D
         0fmKe1qIx0DEpWR/P0SGugbthNoMmAS6HcQu27noE6b1Xa5qRySPp/PyHrljyT+PC3RM
         2X3eZAweoh1jaDJ/92FegXBi0g6bJHD6BhlNFzkpp5dskfDBqOYhCnz5brvoufYMB0t6
         EihCOam1Zy5cNkP0YXYYQJILlUqfM9gOUm91UUD81gwxV1dNXzNDPxneu8txZ4TyQR0v
         yVolUXsRfQe/E3DCfebU279APKUjFKcEYkm41ZHddK/rFBZ6suFILXtP65T6NYIAp446
         hJOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=v9nYfTLZcRM1D7Mrf+11GsFY5/g05dpJBB7ZAbxFT9E=;
        b=jmjSY2cID47D3cnrVMqYlcprfe6yYSWxuO0lHbXdzW+g3zyqnprJvjBNsqEdJoD3zP
         jCE+VhluwXGeoUCBXtnkUwO4XMjii+7O38PCILvLKwzLVxkcMYjr7sW0xOsOQrg7JUfA
         OK1/Tba4cZOysEixupugpReyR3ScidaxQMbbG3GCZhEk0O3Mi76ZL8PGuejLq49HYe+n
         oGp4OKHmo20ZES7pT0Akabg/DK42LqlcelUDFaOgNeAsTEBHqWiopKsMvjYA5CIj1BJS
         t++uilF6kZ4etXYs5vh67bpNRrcy/kp/R3a2BNQI9STn1FGteN4GNwX/TwMwBROyfMAw
         1wCg==
X-Gm-Message-State: AOAM531Gb/XFCx6IeD/Fv8J/3eyPQDZVq7evB0PDMk/B5t30nj+B+3Qm
        z5HdRLupGk17+mFlY2taVVYyRTq2PFhO+KjIPTIeDCxiCgM=
X-Google-Smtp-Source: ABdhPJz2MvCgx9XUmCCF3yiemci/A4lb/gNSc0mBVvoh0zM3RWDecdyRoIrdVvYhls6Bvij6Xt3tzqub5kGTjTdATQE=
X-Received: by 2002:a05:6402:1153:: with SMTP id g19mr30138008edw.127.1593076278329;
 Thu, 25 Jun 2020 02:11:18 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 25 Jun 2020 11:11:07 +0200
Message-ID: <CAP8UFD3vfShPWQzhj28sTfXORzR-k5sJSmeenZf-G7uBMBM6=w@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 64
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, lwn@lwn.net,
        Jonathan Nieder <jrnieder@gmail.com>,
        Xin Li <delphij@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Wong <e@80x24.org>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 64th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/06/25/edition-64/

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:
https://github.com/git/git.github.io/issues/441
