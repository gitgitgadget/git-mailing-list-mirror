Return-Path: <SRS0=B2P3=AY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C44BC433E3
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 06:58:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24E0520663
	for <git@archiver.kernel.org>; Mon, 13 Jul 2020 06:58:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=zoom.us header.i=@zoom.us header.b="D/5yHxVQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727834AbgGMG60 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726077AbgGMG6Z (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Jul 2020 02:58:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B57BAC061794
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 23:58:25 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id o1so5116470plk.1
        for <git@vger.kernel.org>; Sun, 12 Jul 2020 23:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=zoom.us; s=google;
        h=from:to:cc:references:in-reply-to:subject:date:message-id
         :mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=R8x/1WwVNknuZ+Lb9zSBnzsR1dHbDe76dAaEQQx2wRE=;
        b=D/5yHxVQBuNer8mrlv0n2ZwEMKoIlA2r28n32rcbbT/uqHVJ1bvV5D8PomvtcBm+Y9
         AZItEQ4AxlAFhYVlpkN4UDfpFWLVIPYeMHmEbeje4J5DzAKBJ68YGbqPOR5XCosLupxb
         kFtX35Ur8aobjjpbLxwtLOp493DawAS0c8Vpc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:references:in-reply-to:subject:date
         :message-id:mime-version:content-transfer-encoding:thread-index
         :content-language;
        bh=R8x/1WwVNknuZ+Lb9zSBnzsR1dHbDe76dAaEQQx2wRE=;
        b=HwmkPKrOj0cmFBL8KIc6fLQPxNkWwM5yhzsTNdpKdCTutPHaMu35lL5tZSv7azuJK3
         QgWz9qAKAsKsOSQ393/JAyfsptBChtl9T0TqS4XTxMElrKPuxgJPk6RjNGxpEixRmAsP
         U0ubTAUy1tkyfkAA1MdcuTo0Q8b1SjSn9bRykw4xg/ogjBDF4lbrEwHvnvIinqCJ1NyZ
         YkuwdOYAXYZo9BxoCaY/OyxjbE4pqk34S7NX/PQYguexH+hY8DLccFkqpoAJwquSZqBV
         wRuAAB/tFicSZTDERqatKVWkZl1t++jcim1DWJ3V0LeDNgPiGVBzT8UuyHQYCh3PLFjr
         t88w==
X-Gm-Message-State: AOAM533onZQo4Yy/i2u4OBXI1RzRSEfkPgEiEe+8r6mMD6X3uyr/E409
        Hj0gR0cxNflFdEqA9tbDu8XB0T/0RJkCjZhd2yAoVDhXjKVeJgCZ+xtt7JciR38uEJLw/Bfjzgy
        h1Inb02t9zXH0y4gHUNk4u+jL0oRGj3UxF1PVujuaiulC3Nbmq/fFezCE+Q==
X-Google-Smtp-Source: ABdhPJwRur+unlAcv1pKc6sY+mE2orUW7dIKhIoMEhK7Gwadlcx1ufK1uaJZk7XlIS3YN7okShUPpw==
X-Received: by 2002:a17:90b:19d4:: with SMTP id nm20mr19819044pjb.206.1594623504655;
        Sun, 12 Jul 2020 23:58:24 -0700 (PDT)
Received: from DESKTOPLINSUN ([38.99.100.2])
        by smtp.gmail.com with ESMTPSA id s30sm12029945pgn.34.2020.07.12.23.58.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Jul 2020 23:58:23 -0700 (PDT)
From:   <lin.sun@zoom.us>
To:     "'Junio C Hamano'" <gitster@pobox.com>,
        "'sunlin via GitGitGadget'" <gitgitgadget@gmail.com>
Cc:     <git@vger.kernel.org>, "'sunlin'" <sunlin7@yahoo.com>
References: <pull.781.v15.git.git.1594543148959.gitgitgadget@gmail.com> <pull.781.v16.git.git.1594544903477.gitgitgadget@gmail.com>     <xmqqzh84pq3l.fsf@gitster.c.googlers.com> <xmqq5zasov21.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq5zasov21.fsf@gitster.c.googlers.com>
Subject: RE: [PATCH v16] Support auto-merge for meld to follow the vim-diff behavior
Date:   Mon, 13 Jul 2020 14:58:19 +0800
Message-ID: <16ebc01d658e2$ffbce130$ff36a390$@zoom.us>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQG+/t8vdFv1e8wS+CAYrPJEinGPDQHePt4NAhTR4ZECoCJZCaj/Jp+w
Content-Language: en-us
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

> As this adds a new feature to "git config", it also needs updates to =
Documentation/git-config.txt and tests for the feature, and it probably =
makes sense to make it a two-patch series.  Everything related to the =
"git config" enhancement as 1/2, and change to mergetools/meld as 2/2.
Thank you for your comments, these are key points for adding new feature =
into git.
I'll try my best to make new pull-requests for option `--bool-or-string` =
after current feature is applied upstream.=20

Regards
Lin

