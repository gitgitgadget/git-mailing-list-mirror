Return-Path: <SRS0=DNVg=EI=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E81DC00A89
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 11:37:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37762207C3
	for <git@archiver.kernel.org>; Mon,  2 Nov 2020 11:37:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUe/Faac"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728597AbgKBLhu (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Nov 2020 06:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728414AbgKBLht (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Nov 2020 06:37:49 -0500
Received: from mail-io1-xd2d.google.com (mail-io1-xd2d.google.com [IPv6:2607:f8b0:4864:20::d2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43799C0617A6
        for <git@vger.kernel.org>; Mon,  2 Nov 2020 03:37:49 -0800 (PST)
Received: by mail-io1-xd2d.google.com with SMTP id o11so3305106ioo.11
        for <git@vger.kernel.org>; Mon, 02 Nov 2020 03:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qEU/5Y3gFUbTA6k0mf1FuzecD+lcMbcmsi69xsl54/4=;
        b=MUe/FaacvlBpqAUxldaJ52iOKYF2RmUn6tHaevFoi4kpkojJg0tgHqA55msoGlHbKS
         yx9gfE7otGH1U4dciz2UXMTkxhYcCWfgPP+LuUcpWNQArhy0/q6WbmnsZDbK4vwhbeTq
         o8t7EUo9cBlJJUEcK18RPuUmtjf530PjWR11DOGOm/RO+VZYe6trrQVWFauswumUFCqQ
         E2qXApRjmViJyqIzRy1nXd4fB9Qk0l5LANk17p4lus9Y6rco9WPGuia4CrtV2b4a0yhY
         5T1Rxnk5lGAfcTdXXJcNzHARQHfmWUOJxoeBGGH+uK7HPpKhrB8fac8nuo8HwzO1xyWr
         wMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=qEU/5Y3gFUbTA6k0mf1FuzecD+lcMbcmsi69xsl54/4=;
        b=MaiIwB0UDAzFLeJh3Mexw/44in58u/aWKG2fTJSe2CGMUuA6eu6yn40MjZ+LkCCjRs
         Zg9DcRfRP2oihxbhHXyO6D7cifHFjscZebWOuS5S7Oe+bMSo6BssFRHre1KJVUQtRyVN
         IdTOn90GQQckvWa4IqtQBPbeRx2N39L9msIASon7ijBPD9Pzv4dFOedW5MgNzOcv4DcM
         jVydxdBPn4bkAmuf8J+rrp9zKaoK4+D0zIw13QoG7UhBa17uTeJhM5OjWA1kHuMcoqJy
         AeRskN3lVNmnieHc4FTKKDFumqwiGhCD2aHC4kFnaV4eZzxTXVuQq19O6j06BVGAxSNn
         iiQg==
X-Gm-Message-State: AOAM532wYdv9zZBz+V/ifWhgqVcvy91UB7qR77z7Szz8dGZR+zWjyrOL
        j9Ce0GB0KNwqnBRVwR4gi+/qvwBDapm5kUop1AJXUv+uDZ8j314w
X-Google-Smtp-Source: ABdhPJyOkYuEXssgkeNH/DOQL4xkBXTCgrjRX2dNE2fErh5uPav0eGmlk+MyB9+PRb/PFvEPSqkAl67M0z8FSq7q/EY=
X-Received: by 2002:a6b:c8c1:: with SMTP id y184mr10019751iof.109.1604317068381;
 Mon, 02 Nov 2020 03:37:48 -0800 (PST)
MIME-Version: 1.0
From:   Wenyin Wei <wenyin.wei.ww@gmail.com>
Date:   Mon, 2 Nov 2020 19:37:37 +0800
Message-ID: <CABKv=+456ECj_JgHZwnjPt_3H4odWmuM=3+G0FF+X+0noVcCfg@mail.gmail.com>
Subject: Broken-point Continuingly-cloning
To:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Dear Git Community,

Consider the number of large repositories using Git has increased
these years dramatically, is it possible for Git to make a
discontinuous clone way? The required continuity for a git clone has
been hard for large repos, and developers have strived by the somewhat
ugly way, `git fetch =E2=80=93depth=3D<increasing n>`.

1. https://stackoverflow.com/questions/38618885/error-rpc-failed-curl-trans=
fer-closed-with-outstanding-read-data-remaining
2. https://stackoverflow.com/questions/60878838/git-rpc-failed-curl-18-tran=
sfer-closed-with-outstanding-read-data-remaining

It would be appreciated for many developers to see that git could
support something like broken-point continuingly-cloning. I am not
sure whether the `git clone git@......` way supports this
functionality, but even so, some mirror hubs in China, to accelerate
cloning, only support the `https` way and then become anxious while
cloning. Anticipate your comments and reply.

Best Wishes,
Wenyin Wei
