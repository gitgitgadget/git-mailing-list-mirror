Return-Path: <SRS0=22YV=73=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28110C433E0
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 15:52:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EEEE52071A
	for <git@archiver.kernel.org>; Sun, 14 Jun 2020 15:52:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=jorgechamorro-com.20150623.gappssmtp.com header.i=@jorgechamorro-com.20150623.gappssmtp.com header.b="zEfGc6zZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgFNPv7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 14 Jun 2020 11:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726717AbgFNPv7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 14 Jun 2020 11:51:59 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C6AC05BD43
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 08:51:58 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id y20so12413627wmi.2
        for <git@vger.kernel.org>; Sun, 14 Jun 2020 08:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jorgechamorro-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=98jpeWcRSlU1e6ci+JNV2MRCR6hw0L4Y6v0IIt+e+Ws=;
        b=zEfGc6zZM4CwW1ZxCQ6mXz7eIekqBhCyacCVorE29OsTlIdo4oBs3lphhY23lrTw/w
         kRz8921QSnh4L8AAn678iIjCs+BzzZJCAFF17wYvojBtow5vKShoe/X7aRNXIUoiKK3D
         +lYeRbluUp0JVaXxY8QM4cHeC4k3lUcM9oF81DqgnHEJBmfNzoMgWjQT0AIiZrgbbJr6
         sluXn4lCSI/4Tit3kNx7N4u39r33l7aNmKJEaKJ8sXjAz5eb+YxEWuGGqfP47M5H0qPT
         zbNakLWZ0qHGGvapdXLpJt0OzDr93+2nLnLGdML/6Mn34JeYhcdi5QXQtS0dpeC4fsf7
         RMUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=98jpeWcRSlU1e6ci+JNV2MRCR6hw0L4Y6v0IIt+e+Ws=;
        b=avqefNmU1mJ6BIK+auIT+PlDJ6xLyCN64r78nXq11t9jo7C0AaUv5GoK9387t5dvui
         kK7ILcOWlMJnP7fiKLcBVeG9jSGZDVopuVNRPa7mj1w8sGX7HlhxczudSARUvCwCpFjR
         QuM3a84oEmzv1gAmTPgxKJR4W39EZpivA/994V60+mTfMJ1+lfCsyAxj61cScMPqMs7f
         WyhpQ+rnu8yOjburqhjA51dr81/u80cE67pm/IrSqi3pe3Mm6K/6phIlYD6zTGfJMJ7t
         Wx8QjlPZa/LTHcKtetMJy/caZjWE3LHn/nzkU96Z7/zxWtWQpF8UlD0lUER87Qx65dNL
         73ig==
X-Gm-Message-State: AOAM531K2zyndJ+Cx8Z16MeaVhDjv06EUHhID+LRZqOHeG5QiPDfPajl
        kvsKTZJ5TlD1f1avhjJRu1XW2VN1C3xZpg==
X-Google-Smtp-Source: ABdhPJyKbAr/LB3hrQ1RNNWtz4XFeXJAGh2PehNm4Fd1xAG+fAMaAIZrELHZhQNQVvuqMEC89IAKrA==
X-Received: by 2002:a7b:c11a:: with SMTP id w26mr8659144wmi.0.1592149915521;
        Sun, 14 Jun 2020 08:51:55 -0700 (PDT)
Received: from [192.168.10.50] (20.red-79-156-187.staticip.rima-tde.net. [79.156.187.20])
        by smtp.gmail.com with ESMTPSA id p9sm18320484wma.48.2020.06.14.08.51.54
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 14 Jun 2020 08:51:54 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 8.2 \(2104\))
Subject: Re: Rename offensive terminology (master)
From:   George Of The Jungle <jorge@jorgechamorro.com>
In-Reply-To: <0795A4A3-4D5B-4AAF-B032-499700DFFFA5@felt.demon.nl>
Date:   Sun, 14 Jun 2020 17:51:53 +0200
Cc:     Thomas Adam <thomas@xteddy.org>, Simon Pieters <simon@bocoup.com>,
        Git Users <git@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <431DBCD7-FFFE-4AD1-8BC9-0416F1F5668E@jorgechamorro.com>
References: <CAOhcEPZ6Ygm5fpiYpR1VnHv8ZrvMtOtjc+DwW2QZZy47JE45yA@mail.gmail.com> <0795A4A3-4D5B-4AAF-B032-499700DFFFA5@felt.demon.nl>
To:     "Michael Felt (aixtools)" <aixtools@felt.demon.nl>
X-Mailer: Apple Mail (2.2104)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

You say this =E2=80=9Cmaster=E2=80=9D has anything to do with slavery? =
Then be more explicit and true to history, and instead of master call it =
white. Sorted! If not please stop this nonsense thanks.=
