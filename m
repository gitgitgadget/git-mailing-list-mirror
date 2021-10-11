Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8E60C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A408760C4A
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 19:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234610AbhJKT2D (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 15:28:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbhJKT2C (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 15:28:02 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEF98C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:26:01 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m22so59579033wrb.0
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 12:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fi+NU42fKZpMsKafUPVRB52/pjED2bHsi+heva2qhyM=;
        b=ibxBa77aXmXlC5juXnNw9UakWf3E4gp11hyA7zrrkEDr+ld/8ZssPWsBGoViZ3SW+m
         ppd+pbqZmUDZIZWX+yuJ74ZXfju6nfI5xUx2AISdVdDN2vwdZA/ItwIDmcHDkVFCYgO2
         xTMyARziE2u2LdSAwXmNbbyke7lYhp7JahB2Tkb0UWMGY8gg2bFlKS/bIhYRwlpsIU1d
         dp94lwWS1IOu6nZLy2xdPcsGY1ie5EcEs3tWQPuqAtN7IJHR0nvN+GpB3dhmGg8nl6QZ
         vnYOHmPA8NblyBKMvjNaVHFVoPHKxz1L7WF1z8MBDUOUqI/Yl8Ww/iXS1tcpANlKTFAC
         EeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=fi+NU42fKZpMsKafUPVRB52/pjED2bHsi+heva2qhyM=;
        b=yHgatO4Aes/wYdc2iSKq1eBWcI6+xzPYlvrghAvl/fnRUM+rr3tRRpi8zsthSDd4AC
         TgVKIz8vJcSy37i93ACMcKAIEq01EH7EdtdeOmubL5coe5N+zQ1ePlAGxc5SCiulVnwu
         ezmhBbHiD9zBXcr1NBdiyEtFB4nwmTVHdskA5K7XaOzX5AiTqOa16MT51kMJEF6fVRh3
         oyRTcXpUITJb+EWlTNbA+Fs6b1P4h8HUgc5jtlkaWqp4Wcs5dibDUWyKPYYmBPl6Wvvm
         qf+FJQ5ZxaBu7lrVgUxRiAYKDRQBHwm3yAbi726ZMquuDrNr4NYi5aRlbzssJGojn0Kh
         M9kA==
X-Gm-Message-State: AOAM533BjMr0xxVb28WArngXyYFt8fzH9V3UaUKZ4wlCisPYyae3bm55
        Ze23jM/kUsIcoEr0dTUs4W/Pe0xMUGM=
X-Google-Smtp-Source: ABdhPJyZIahiQS5Nphg7xgtXT48tiVgVPyYi6f34oUSJ1CHftMFai8GQ7NK90iaUWAPw5Pv0jTWxRw==
X-Received: by 2002:a05:6000:168d:: with SMTP id y13mr19020785wrd.172.1633980360601;
        Mon, 11 Oct 2021 12:26:00 -0700 (PDT)
Received: from localhost.localdomain ([2a01:e0a:2c2:db70:6136:8fe1:d969:6eb6])
        by smtp.gmail.com with ESMTPSA id b19sm423627wmb.1.2021.10.11.12.26.00
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Oct 2021 12:26:00 -0700 (PDT)
From:   Robin Dupret <robin.dupret@gmail.com>
X-Google-Original-From: Robin Dupret <robin.dupret@hey.com>
To:     git@vger.kernel.org
Subject: [PATCH] http-backend: remove a duplicated code branch
Date:   Mon, 11 Oct 2021 21:25:45 +0200
Message-Id: <20211011192546.1571-1-robin.dupret@hey.com>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


---

Hello,

This patch simply factorize two code paths into a single one.

Just wanted to say thanks for this piece of software and all
the work you are doing on it ; thank you very much !

I hope I properly followed the contributing guidelines ; if not,
sorry.

Have a nice day.

