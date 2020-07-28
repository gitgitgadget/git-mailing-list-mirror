Return-Path: <SRS0=DRt7=BH=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD52EC433DF
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 10:11:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9EBFD20714
	for <git@archiver.kernel.org>; Tue, 28 Jul 2020 10:11:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="th1YJ8B6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgG1KLj (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728516AbgG1KLj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Jul 2020 06:11:39 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5884EC061794
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 03:11:39 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id k4so9624788pld.12
        for <git@vger.kernel.org>; Tue, 28 Jul 2020 03:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=k73telhHFROxIl2DIa+/QkE4ALA3J8AO3JF3kK32bjk=;
        b=th1YJ8B6hcuVT6ENkBRSMtYkIXG/7hyo1FZImDZhY/NaGIO/GD6LNQZ8hOZkP0PNw6
         hrUNFqcnShVwQOgh5XxzoQJXgi5jVV/3Pry2X79C96PdxEE9zpe1bDkDjvFCSuawdRd5
         DjgBuECNlDaTFXsTn+ta3stT+UXezwrRztdhvUfQEjkJDzxSubGz3TrlVUCZOUVbSvmD
         kPDT2ek5cGdZM2aop58/c8OueN9M4PtZaoVMqrievIQJIM2LpfqoKmYbatSg26caDUi7
         5znR5UJ88OqdnrGsDrcSYEku34pGDSqgJCWGVSlG7jVCqyh5DbtHiBrwW2p3J35Ksq/W
         KOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=k73telhHFROxIl2DIa+/QkE4ALA3J8AO3JF3kK32bjk=;
        b=lpwR2KxcZqhSzhfWell6iCU8JnmABrea5sPRz4OylWjGWlRsioInSL1K19x4OinN/f
         nI55EAN6hk7ppPW6/oPRD/Q4nk8Jdt32oA3cInIkcvCcE9rKJmYhtppvs3eQtBy4Ad0Z
         3x7vuIXLcrpRRw1ylt5xxWRuyamEuF501aEy38ejdwoE4ji53K817xxf4HP2pkYAjylX
         Uj0FMoeQ7yjXdZz1NriOy5AbMPgjQVI774s38JYfugHYZvie2auOu+IFU5VNSeSPE5/O
         w5jD06OTI9s2nPJ70al3K+NsKZzU+717F0AGjnsodxSHn7/0V8YbgbXRGE6a6T/LT1PT
         jh6Q==
X-Gm-Message-State: AOAM530Ga9xzXPenqPLWNd63esBhV3CRW/APBtqjFuRsZ54AO4ciMXbh
        vck1FIedF/hKStJYIdlF60vRd7PujJU=
X-Google-Smtp-Source: ABdhPJwYt7s5D/KRS1a78PYm6Y5PYetnslZucn+S7toA/48/bNLyLE/MHedtlmYm3JULFcDKEBMcTA==
X-Received: by 2002:a17:90a:182:: with SMTP id 2mr3626436pjc.114.1595931098218;
        Tue, 28 Jul 2020 03:11:38 -0700 (PDT)
Received: from konoha ([45.127.46.214])
        by smtp.gmail.com with ESMTPSA id d4sm44998pju.56.2020.07.28.03.11.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:11:37 -0700 (PDT)
Date:   Tue, 28 Jul 2020 15:41:31 +0530
From:   Shourya Shukla <shouryashukla.oo@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, christian.couder@gmail.com,
        kaartic.sivaraam@gmail.com, Johannes.Schindelin@gmx.de
Subject: [GSoC] Shourya's Blog
Message-ID: <20200728101131.GA30110@konoha>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello all!

This is the twelfth installation of my weekly blog covering what I have
learned in GSoC and other like stuff.
https://shouryashukla.blogspot.com/2020/07/gsoc-week-12.html

Feel free to comment!

Regards,
Shourya Shukla
