Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC77C64ED6
	for <git@archiver.kernel.org>; Mon, 27 Feb 2023 05:05:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbjB0FF6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Feb 2023 00:05:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjB0FF4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 27 Feb 2023 00:05:56 -0500
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6F751C304
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 21:05:55 -0800 (PST)
Received: by mail-il1-x12b.google.com with SMTP id b16so3407087iln.3
        for <git@vger.kernel.org>; Sun, 26 Feb 2023 21:05:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677474355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aBeSrDBm2oo2o/bAse3wfjIjF/LpwRaapsDPi1m2f6U=;
        b=Kor/G+K7cVywvwT7dVTz15jHOF2Fnz5XA2iJ4yKSxYrwTZV8IeSg4YeuyV12ocZp9Z
         a8L9a6llSN0YYiTvsIdhj9qUicO93Cr7+35T3M1ck8Jb1QCsTASolesL3ui0ZVInxe6U
         m8FCLHmEsZRztPp+FppgGHMxa5Tgq/jWoihsSkExj+YY7SBaaRwNYz/th1SrfP+M5E7p
         S6Y75bEwpcO7hFdEYsWd4Qq8PO5g60fjS64mm3FNodzwuCTe7MFXi88jAs1keI48/EtK
         Zk2G1Tcd2p9lHKN7F5XGo0TAbuNZLKyV5Gp5N+nmFQ2XXDFWhw94/wL9Cg4S5zjVuUXv
         /YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677474355;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aBeSrDBm2oo2o/bAse3wfjIjF/LpwRaapsDPi1m2f6U=;
        b=7yAjgYYM4lMfzvySZ8RY5GKPBMdxn4gvZZLRDmiIfGVx47j9MOnbKQSRO6pgt1NMVB
         JP0opMHeFkWTlol68ZeMyQAPfUNc48Dh9K+WTEY4/mtmUWZnIXHSZ6pIGODaJVZmNKUi
         xpD2IvKj3gzhBokOAOHZxCC2r8wxIV3oKjngSeR1fw1GpRG6hbEG2sv8FY447CNAMAYf
         RY3VmjcpdCPjJQ1AejIRAVzuDEkM+rNYgWNn6i4fQhjXCA4rQRdYkx9DQurc1YRwqZlr
         uasgXGZCbNKa482AIm89X67hzRLddLlBAKiwt26lBzUcYNFqaBwJRvfMXCRkp8pBvR8q
         qG7A==
X-Gm-Message-State: AO0yUKX543dWgSGUFRXh41BRGnGzdoXhSyRbQmXtee9tW1fpfb6ifAJk
        ysFkEGi8fWBdQnHh6HrlEHxAQm9boq/wFg==
X-Google-Smtp-Source: AK7set+7xi3u/6jhJFzG5qQ6rIFgw8jfxZiOq1h1HVMbobudaQ8aSh/wnbaoH34JhEyRR5LgDh9bmQ==
X-Received: by 2002:a92:c242:0:b0:316:fcc6:6ec0 with SMTP id k2-20020a92c242000000b00316fcc66ec0mr12372547ilo.0.1677474354858;
        Sun, 26 Feb 2023 21:05:54 -0800 (PST)
Received: from localhost.localdomain (bras-base-london142cw-grc-20-69-158-191-243.dsl.bell.ca. [69.158.191.243])
        by smtp.googlemail.com with ESMTPSA id l15-20020a02ccef000000b003a4419ba0c2sm1736959jaq.139.2023.02.26.21.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Feb 2023 21:05:54 -0800 (PST)
From:   Shuqi Liang <cheskaqiqi@gmail.com>
To:     git@vger.kernel.org
Cc:     Shuqi Liang <cheskaqiqi@gmail.com>, vdye@github.com
Subject: [RFC PATCH 0/1] check-attr: integrate with sparse-index
Date:   Mon, 27 Feb 2023 00:05:42 -0500
Message-Id: <20230227050543.218294-1-cheskaqiqi@gmail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Integrate git check-attr with sparse-index.

Only add 'check-attr pathspec inside sparse definition' yet, just want to see 
if the added tests in this patch  on the right track.
Also, I have a question about git rev-parse. I read the documentation and wanted to add a test for it, 
but I noticed that Derrick already integrated it with sparse-index last year. 
Is there anything else I can do with git rev-parse to integrate with sparse-index, or should we just leave it be? 

Thanks!

Shuqi Liang (1):
  test check-attr pathspec inside sparse definition

 builtin/check-attr.c                     |  3 +++
 t/t1092-sparse-checkout-compatibility.sh | 19 +++++++++++++++++++
 2 files changed, 22 insertions(+)


base-commit: a38d39a4c50d1275833aba54c4dbdfce9e2e9ca1
-- 
2.39.0

