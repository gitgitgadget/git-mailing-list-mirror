Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.2 required=3.0 tests=BAYES_40,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82C23C07E96
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 12:53:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 65020611AF
	for <git@archiver.kernel.org>; Tue,  6 Jul 2021 12:53:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235309AbhGFM4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jul 2021 08:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235163AbhGFM4U (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jul 2021 08:56:20 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A0EC06175F
        for <git@vger.kernel.org>; Tue,  6 Jul 2021 05:53:41 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id i8so13072601wrp.12
        for <git@vger.kernel.org>; Tue, 06 Jul 2021 05:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=Vv41yUdwKVrssNzjpbdNVT93avKwRS09xV49A7JCd80=;
        b=rewlb47YKfEa3xHwD3KAlM79Ym/OeBoWXgQ8S+xHrZX1Fq0hWAsyOG/z/9kVDtnGOy
         LsOI8hz4OhxHLWTDAJ9puKkzL2OkVnQiR3DhNxNW06gL/amljgwvLU5Y2UuiDwJb4lYa
         cObz6ER0l5WEvItMGNU1g6wL+ooQ0wAx4I7y5P4V8yz53B0aNXIByZemAPevNy6mSlaw
         +1va9hN3xU82bSrxkhhwqj6z+vaZuUf0K9u8D6EQNa/tXFUbswTwRrpzjLxAxbPutsA6
         Yd+A5eDI2AM1tpaj4HvW7ja6P0MXPvxhFt1NVX/Rba9/n5zz1/kEs3C/L6njxl5vUIst
         ao4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=Vv41yUdwKVrssNzjpbdNVT93avKwRS09xV49A7JCd80=;
        b=GTBM0+EWWJlJV3hOXRfGvrELoBKG56x7uPAzc6ru99m3pX18djfjvjwhKbDDb3w1c8
         ymfd5jbPg3TQVQybe35qBo6UQOCUq7QW3fpEuQrtNFeWKMo0UDrGcTesxZe8sTK+hC17
         T2TlDVSrjzqqwIxxh6nPZ5g5nRxBLRtiRAGtE69X4W35KxVmI6l51QudhDp91uW4Ua0m
         R6G/Vy9Bv/auwa7vVg4qWuzlUaOIyQXloAC2rMsz680R4jadbw/Cz5iZvNOEDGffMnRU
         5S8WmMoaSkBJzaBOEkbqi136Fe6Olht68MUXb5YBIxY9DSjzsPlA36IghSQcEzyiHXc1
         sXXA==
X-Gm-Message-State: AOAM5308OkhGiJhp30wBDnYv7oAI3Nrm8/GspsX6f8fSuOfri0MpwvR3
        B8ca0EMvNihsMH4VAZLsAEuqPb28Gg7xXTMeug0=
X-Google-Smtp-Source: ABdhPJyVr8NTiI2qPckSAxvSBjGu4hJBNUMCxikFMftKNwjdEzpdCSE7i6K7QheMmsZAQkXf/PJTdQ==
X-Received: by 2002:a05:6000:1d1:: with SMTP id t17mr15384176wrx.267.1625576019994;
        Tue, 06 Jul 2021 05:53:39 -0700 (PDT)
Received: from [192.168.43.18] ([197.210.55.2])
        by smtp.gmail.com with ESMTPSA id m18sm5447624wmi.32.2021.07.06.05.53.37
        for <git@vger.kernel.org>
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 06 Jul 2021 05:53:39 -0700 (PDT)
Message-ID: <60e45253.1c69fb81.336b9.8891@mx.google.com>
From:   "Fr. Gregory" <covertechindia@gmail.com>
X-Google-Original-From: Fr. Gregory
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: RESERVATION
To:     git@vger.kernel.org
Date:   Tue, 06 Jul 2021 05:53:32 -0700
Reply-To: fr.gregorymullaney@yahoo.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,
   Can you be our interpreter for 4 weeks?
We are three males and a female on a tour
We want the work to start from 1st AUGUST,2021.The 4 weeks interpretation c=
ould be extended depending on your initial performance.Get back to me with =
the cost for the 4 weeks.

Best Regards
Jenny


