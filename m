Return-Path: <SRS0=EnZj=DB=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	PDS_TONAME_EQ_TOLOCAL_SHORT,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47D95C4363D
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C11C72396E
	for <git@archiver.kernel.org>; Thu, 24 Sep 2020 10:32:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ESeKLicH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727404AbgIXKch (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Sep 2020 06:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727349AbgIXKch (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Sep 2020 06:32:37 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D08F0C0613CE
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 03:32:36 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id e23so3789202eja.3
        for <git@vger.kernel.org>; Thu, 24 Sep 2020 03:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=b9jc+/WQ1suEDTZMRtpItErOoAPzOV+OS+sA+/8mfLs=;
        b=ESeKLicHBg9VN8Ye+kJMuq4NSK1VZOklDufam+Kgp43AyYSABw0D6CJSKgX04hGMhe
         fi2a1TS1j6KUygNo5Vf+GW3qquxuoNBbs6sj7B3binuZG7vMhOwSSytPGywKhmlr+wFQ
         WhwWjCm96Gzj812e32rhXtFJkAQtLpNIz5Vut0rPjb9WAtXLeszM3o0yJMHPBB49a9t7
         ckqsiiFWdNvMrL/JWAx7oYv08SmkhTACafDi2RZH39mI6WNjdI31qQkjFBKxhZfByY9S
         j+80qC3rwHcdgtO1wfkx9i+3meLijUEozR46bKGjPA+hhNgWKAX7oNqLiBJ2H/xw4ElR
         wC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=b9jc+/WQ1suEDTZMRtpItErOoAPzOV+OS+sA+/8mfLs=;
        b=pNLH6h1LCSM3rNXnEjJdSrv9utG7Jj2PNfRnQSVle57ehR08B9zVxcJacDrdX6AU87
         vONPLDxrpKnQB026k6h2QNvM7sCWYsmVysgBX+F1E5EKbRuGCfKxGpm3fost4agynRqb
         T9mK+zCZ9YfExm8HNEOtwKrpW0eUdd3yzwkJdsZaQWwDNTeI4WsOwHKRorjELxDmqju2
         2oxMfUQyKHCCAjeyHvE4w67MoLUBWAB+ZZeJVNbC2ntb8pg7tYEkc4W5qY1P7eWtuM51
         eBPBXL504iQagIG4kUslbDjbljzjp+RkAafTRwaY7PlGxl53PUQsBXhJpHvZ4IRB1fEp
         A19g==
X-Gm-Message-State: AOAM531v8E5TdbhCFPLh9CrMOJ77DakuhT6m8Pjb6K1y0BHilfwAJB16
        d1WdWbcAZr9OQz2f4dWGzb5HCBM6eRKI/3F9gbquK6+FE4Q68xGd
X-Google-Smtp-Source: ABdhPJyFo0BikRAF0OjbQ9+mgztHRDGZ4++94eKM6+N4gsQ34QROpWE6jpSVxSXoCeGfIjWF/0APfd6B/mphKxqBE/o=
X-Received: by 2002:a17:906:3791:: with SMTP id n17mr290937ejc.216.1600943555277;
 Thu, 24 Sep 2020 03:32:35 -0700 (PDT)
MIME-Version: 1.0
From:   Christian Couder <christian.couder@gmail.com>
Date:   Thu, 24 Sep 2020 12:32:23 +0200
Message-ID: <CAP8UFD1A2qD2WzjbUUAz6Vq53n7tQ31RQfR85nDpJ2q2wcuE1A@mail.gmail.com>
Subject: [ANNOUNCE] Git Rev News edition 67
To:     git <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Jakub Narebski <jnareb@gmail.com>,
        Markus Jansen <mja@jansen-preisler.de>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>, lwn@lwn.net,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Abhishek Kumar <abhishekkumar8222@gmail.com>,
        Shourya Shukla <shouryashukla.oo@gmail.com>,
        Hariom verma <hariom18599@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Derrick Stolee <stolee@gmail.com>,
        Heba Waly <heba.waly@gmail.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Ethan Rahn <erahn@arista.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        git-inclusion-summit@googlegroups.com,
        Carmen Andoh <candoh@google.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi everyone,

The 67th edition of Git Rev News is now published:

  https://git.github.io/rev_news/2020/09/24/edition-67/

Thanks a lot to Ethan Rahn, Philippe Blain and Junio Hamano who helped
this month!

Enjoy,
Christian, Jakub, Markus and Kaartic.

PS: An issue for the next edition is already opened and contributions
are welcome:

https://github.com/git/git.github.io/issues/460
