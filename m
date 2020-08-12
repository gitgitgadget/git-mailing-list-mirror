Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEF73C433E0
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 06:48:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0DD2076B
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 06:48:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WmXBHFMd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726716AbgHLGsk (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 02:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726629AbgHLGsj (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 02:48:39 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F378C06174A
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 23:48:39 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id m71so536860pfd.1
        for <git@vger.kernel.org>; Tue, 11 Aug 2020 23:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :content-transfer-encoding;
        bh=jOSMyAGITv/Mf2/B4Xls4G1Th9AA69T7/4PJXcwacog=;
        b=WmXBHFMdPpR+rvQpTEeYm3nw1iInVF3Pwf0YQPfcNNNgeh7DKzsScgOXi3jVcPYm/W
         QIxZmsV/xBqIO6eUa4b1Z7Whj8rrwOrq0c/o3KOgYaGKckiFxpljsf3e79u8cV4fjgsR
         zOpEvskCVBaZwcZRIHjaRKWobToXtkvLbdTDOu5tfNpvOHrntkGUDJ9+/Drr1jUnkwmG
         HO/XKMeBM53zczSj5AmSJbc2owVKZ4MklXJYUYULz7Bo87134sqYY4mwk7szDmBL4scb
         LYrHgBihpa1pcu224y7W50YMQOBJSVGdLJNx4GsCvM4OMRIiJRWxQI3yDSKRzwbapxHE
         oVvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:content-transfer-encoding;
        bh=jOSMyAGITv/Mf2/B4Xls4G1Th9AA69T7/4PJXcwacog=;
        b=QzZH3L1xMxCwvBnlOderw+J2bL3F385X4cduBqTTblDvSAeP5pG3Dlo1/5tiwhR+fF
         t0baNPreC2WtpTBq5rjqoXW5fgLp4EuCcvPKZVlpLLO42Gzm1l6wXoM61hdTiv1f+Si1
         xfqVhZ/zaU7EHg6lutfkNQeQCLqXNYZG+p9at9aRjP7m5UhUqTofUq3QVjM7Vsy4OJ8R
         AD9hIoeHEkD0QGZ3C//CxmCSCuath7+tFFqoJ/c499F/Tp80vE4TlKHmb8gbVXncAmJl
         9I29Df7Y4CjsfoNukfoDQLwNMPLH2daKpQDLVNyga6yV7fyxpSLj0QhE33Jn/zMq7Ta8
         ur7Q==
X-Gm-Message-State: AOAM530tobAptQcPYD06z5E3UIQhSVuwaEVY8wmg5zqo/BZPmUO34nze
        tlj7mFxqYqwtcyRx0cXuGaj24iU2KcKIfw==
X-Google-Smtp-Source: ABdhPJyVdcr9gs6oQeoaLyCD5BTN8AmPKhmnJ1Hvt7wq3xgIfw/oAz0ZzSPmGIWtxO3jxsU+PFFTew==
X-Received: by 2002:a63:531e:: with SMTP id h30mr3735468pgb.165.1597214918791;
        Tue, 11 Aug 2020 23:48:38 -0700 (PDT)
Received: from Abhishek-Arch ([2409:4064:609:de5a:309a:8147:c746:a173])
        by smtp.gmail.com with ESMTPSA id g15sm1173568pfh.70.2020.08.11.23.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 23:48:38 -0700 (PDT)
Date:   Wed, 12 Aug 2020 12:16:27 +0530
From:   Abhishek Kumar <abhishekkumar8222@gmail.com>
To:     git@vger.kernel.org
Cc:     stolee@gmail.com, jnareb@gmail.com, me@ttaylorr.com
Subject: [GSoC] Blog about weeks 9, 10
Message-ID: <20200812064627.GA40904@Abhishek-Arch>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello everyone!

Over the last two weeks, I worked on handling mixed commit-graph chains
and adding tests for the new premises - New Git can work with commit
graph files without generation data chunk and New Git handle mixed
commit-graph chains gracefully.

I apologize for the rather slow progress and missing out on the blog
post for Week 9 - My college has re-commenced classes on 3rd August, and
the transition to online learning has been chaotic and uncertain.

Thanks to Dr. Stolee, Dr. Narębski, and Taylor for their continued
reviews and guidance.

https://abhishekkumar2718.github.io/gsoc/2020/08/09/gsoc-weeks-9-10.html

Thanks
- Abhishek
