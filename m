Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E126C56202
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:17:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3204B206D9
	for <git@archiver.kernel.org>; Wed, 25 Nov 2020 17:17:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="KVzPMKC5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbgKYRR1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 25 Nov 2020 12:17:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730293AbgKYRR1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 25 Nov 2020 12:17:27 -0500
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C21C0613D4
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:17:26 -0800 (PST)
Received: by mail-pl1-x644.google.com with SMTP id l1so1427565pld.5
        for <git@vger.kernel.org>; Wed, 25 Nov 2020 09:17:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=SDAGTAxJcPLShctwTAX6V5Q/yuUqinJJ8GwLYkk/0pY=;
        b=KVzPMKC5wp+kkyOa2f05xaZOIdGKDs9hhpYkh4wqXGkRAHsEs5emIToYpYRAWThyIl
         EXVMlJuTysndvArnitbPmDr4aEG3HPgPkEmF1v5C1+APuNcmQm9eDixwCbZjT2TREQ/W
         yvQSDvM6SHCV8gPacDQDkCG1PiLYoggNAMktlWzBprhfsFJx79UgbIYkmbWJA4SE3bZY
         hMFny3i0ikf4iZumbdirqVSW5tPCZ3hbfDk/85fG9xWqgNWgoiYCOcMnKaA0xIh33Q7h
         NOAotZ/fMyIWIB4eq/4tkm2/8sCbuMrOhHxwesp24f0RYWkCJgdjBAGH72wWt3AkQygR
         pilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=SDAGTAxJcPLShctwTAX6V5Q/yuUqinJJ8GwLYkk/0pY=;
        b=FxViXcvnsrz24X5ct4WoFHZz7LdSwgoHKQDrpee528n5haWQUBzwx8IeJNOJVTtvBe
         j4lHvznxdNpDK6/FP/rwDJGAKTIbpykmO6iKus6ofWx77iSImST21ahA7JNp5QuXy2yx
         5W3/LELdJ4jXU5iG5Y6RBmnvVvkgWjNqvQ+tqKDBe+hIpFBy892m6Z1HCWx5OOxZeEux
         hFdWIKgmR+AxyJBQ+PTrICJjP/FKT8QHp5R47xzU/2EaBoNWfS0GCxBtgCKeetNIQ0Er
         bTBaiWZRfifB7rdZDtVYGT2jZPFRF6Jht++Vcuz4r0wsU5+ofzJ4N0bp1TjPoS7nKTWW
         qjMg==
X-Gm-Message-State: AOAM533tHAlCIoOTqbBTd4OlCQGblv25+BWp94Ukoqd1dblxSVwL42zg
        mWnigvxXgqonltzdEMsZHY0ImAf7i5OthvOX
X-Google-Smtp-Source: ABdhPJwnRFNi1QxGp6V9kcCypA9rCuz/tBhT/WgXecetDHSKttIov8Uk09X3ivXH/tAB7ybETzKtWA==
X-Received: by 2002:a17:902:7606:b029:da:1f26:a1bf with SMTP id k6-20020a1709027606b02900da1f26a1bfmr3640216pll.53.1606324646159;
        Wed, 25 Nov 2020 09:17:26 -0800 (PST)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id n68sm2479524pfn.161.2020.11.25.09.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2020 09:17:25 -0800 (PST)
Date:   Wed, 25 Nov 2020 12:17:22 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, peff@peff.net
Subject: [PATCH 0/2] midx: prevent against racily disappearing packs
Message-ID: <cover.1606324509.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here are a couple of patches that Peff and I wrote after noticing a
problem where racily disappearing .idx files can cause a segfault. While
investigating, we fixed a related issue which is described and fixed in
the second patch.

(I'm a little behind in responding to review on the reachability
generation improvements patches, but had these in my backlog and they
seemed relatively easy to send and remove from my TODO list. So, here
they are :-).)

Thanks,
Taylor

Taylor Blau (2):
  packfile.c: protect against disappearing indexes
  midx.c: protect against disappearing packs

 midx.c                      |  2 +-
 packfile.c                  | 19 ++-----------------
 t/t5319-multi-pack-index.sh | 30 ++++++++++++++++++++++++++++--
 3 files changed, 31 insertions(+), 20 deletions(-)

--
2.29.2.368.ge1806d1bdc
