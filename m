Return-Path: <SRS0=aK8K=3V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08A2C33CB3
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 17:38:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AF91820679
	for <git@archiver.kernel.org>; Sat,  1 Feb 2020 17:38:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I2BIisdw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgBARi6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 1 Feb 2020 12:38:58 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:39605 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726169AbgBARi6 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 1 Feb 2020 12:38:58 -0500
Received: by mail-pg1-f194.google.com with SMTP id 4so5364943pgd.6
        for <git@vger.kernel.org>; Sat, 01 Feb 2020 09:38:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAHqtN6WCx8Rkx3VT3EEhg7qOCIqwKF7tHlrQZHVP9Y=;
        b=I2BIisdwGsG8yJpHfFc+OZS/C6HWAMb2UajlLMr4gXJ6+EC9dXSVZ5UrMtgqEz0/t/
         KV6sVArTB+kPs1/0AG6dV41/v+6qHgo9yCbR/JquDbQDGEkzNLBowYwT8djV4K4LnTX1
         zQ6S+gdgT4aJat6BNEhepbhJmO2Gul0optuHGKcKrBJJ7RmPCkXqxkuYoral2xuuXW7c
         jWUoQyqArYOyLfQiRt9R5LXX10WugqHB9Sn1cHA8+ljo/55zlu5l8CYx6Z3K3Cj+3Uk6
         OlA46p4F9nXNWqvsf2bj7fau2V7jpPQqgG8fAMUCveeJ2yOsCVvEP+mnMK67m5Qm7htl
         M7hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ZAHqtN6WCx8Rkx3VT3EEhg7qOCIqwKF7tHlrQZHVP9Y=;
        b=SA7jt2UTrA4EgsNADbBvo3aLYWE4r4kpYorvx8gPaFzZynmuOjIAx4h+5qJMw32Wpi
         xmqNGUTeOBrP00NIDjdya/SPUAKcJ06CGMHLe4XN/i2pclKHsgl2p/vnwnmHXLFIT5zA
         vyrUtUBUfnUkaU3kYQiMItdlwZJPBmN9vM9AcsF86FEhUVRAKWfUMAwhXVxYuwd7swiV
         GUlt6mb4CShypt57jaBAhr2ygOib3H3myz+2TL4f+ce8qrZic6h5DYkn2nljNhmNLF8e
         L8Jp8R6zh5Yo4pUVFw90AH5N94MZhS7pGYkxNJlH7uPeV2WvskbCHwfn/wQMIlq0rB0M
         /Scg==
X-Gm-Message-State: APjAAAUh08HhKqWx1VVLCFuOk5bIqWqfAtvG2zgnMlHDWQNmjNFMRJh8
        hGOIke5cxHaprp3qAerfXvM=
X-Google-Smtp-Source: APXvYqz4gshiXacwpZYYwB79E7tI/D1LuodjCnhs0GgLuGJhHfGO6xxN430s3s30f5XmBeRdr6+hRg==
X-Received: by 2002:a63:e74e:: with SMTP id j14mr16199668pgk.231.1580578737541;
        Sat, 01 Feb 2020 09:38:57 -0800 (PST)
Received: from konoha.iitr.ac.in ([103.37.201.177])
        by smtp.gmail.com with ESMTPSA id h3sm14149281pji.9.2020.02.01.09.38.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Feb 2020 09:38:56 -0800 (PST)
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     Johannes.Schindelin@gmx.de
Cc:     jnareb@gmail.com, christian.couder@gmail.com, t.gummerer@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, stolee@gmail.com,
        Shourya Shukla <shouryashukla.oo@gmail.com>
Subject: [GSoC] Finalising a project
Date:   Sat,  1 Feb 2020 23:08:41 +0530
Message-Id: <20200201173841.13760-1-shouryashukla.oo@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello Johannes,

Following your and Derrick Stolee's discussion[1][2], I wanted to ask
if it would be okay if I start working on the conversion of 'git
submodule' from now itself because I inferred that it would take
quite some time to complete and one season may not be enough for
the same. Also, if the need calls, I will keep working on it post
GSoC as well as it would keep the continuum in place. I understand
that it is not an easy project and will take quite some time to complete.

As of now, I am researching how the previous commands were converted
and check if maybe those ways are feasible to convert 'git-submodule'
too.

I would love to recieve everyone's guidance on this problem and learn
ways to solve this!  :)

Regards,
Shourya Shukla

[1]: https://lore.kernel.org/git/nycvar.QRO.7.76.6.2001311007590.46@tvgsbejvaqbjf.bet/
[2]: https://lore.kernel.org/git/39a8c249-f0bc-fb0f-2ed5-5ecceb6d4789@gmail.com/
