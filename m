Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF3CFC433FE
	for <git@archiver.kernel.org>; Wed,  2 Nov 2022 22:01:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbiKBWBu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 18:01:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiKBWBs (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 18:01:48 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAC059FDC
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 15:01:47 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id w14so180597wru.8
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 15:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MjQp3qa4vMHQjaHGmDz94ql7nws+blmQaHptzfes1hE=;
        b=ayKv2yrLpASr/ruK3VOgAvw3AU/Q8M1lsd6mIPjnMd/nJNHG9hPFRDHAXKeVqJgD2z
         2bKNY7gHsdtdpkSnEdxPQ/bG6Xq1eSVJLAbRl6FBIsMMXacIa0B6fiABmihE79UlfjL9
         /pueob8vBc8KlS7Qh5DrXP10dCXgm2NJEAP/sE/PbDzCGfvTSpHoL4vUHcyBYk3q1iQU
         jblVPHhhjxODz4I0dk6aCVXfVjry+pZsVwRaLYvX/ZieS92YWu/JcGGm9pLZmoD1XPI+
         9iT0gIY3WaDHnd5RPZuNoj8tu3DLJPtc6wvVgThQg55M4pQWMDltA5xdH94PDHxYUV+q
         +ZvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MjQp3qa4vMHQjaHGmDz94ql7nws+blmQaHptzfes1hE=;
        b=u/Jn0SVwSfoQj+vpfEDs6JOpvOvXkcDZEl0Yz1kbFYQYmcBkjXeoXGPXDlTV0DoDGR
         LYqzeATDA0IdluMtgteSGN96kE8cJBIZMtp2n97ZinD2pu9VPcB0Tb3bkTsVElDFi/Uo
         DpxJeMvxozml98jed++Xiuorw84AwIk+mcqQhYj0VOJUsl1QMsyNElqdR01Vpw/8jKgN
         8eUEiL0hbJqh0yRNeXz2w7ArPiSOG60CTebPNlWBsLflaeZKKsq9jpJq5cdBEYaTsoe8
         aMGzu7AMPf5sPKVUwc19LtIDV68N4ZVYwUH08C6NJZMjjhuXk0rHNYqAojElAgwzgQoo
         TSew==
X-Gm-Message-State: ACrzQf1yUkITaSsbesEyJ71sPYviDr/aaUQuhbQMtyDGSJd0ABjrvQcB
        KkFFZn443JzQFgm/GihN4tMSl8Fv5Rc=
X-Google-Smtp-Source: AMsMyM6IL0YaoE/IoyH9CRcu07R9pwXj5MljxdhDdhIkyxFu0ozBUwR0vo7EuzwvtPvuhjjPQTYUMQ==
X-Received: by 2002:a05:6000:808:b0:236:9822:718d with SMTP id bt8-20020a056000080800b002369822718dmr16708978wrb.254.1667426506233;
        Wed, 02 Nov 2022 15:01:46 -0700 (PDT)
Received: from localhost (84-236-78-97.pool.digikabel.hu. [84.236.78.97])
        by smtp.gmail.com with ESMTPSA id n6-20020a05600c4f8600b003cf4d99fd2asm3701017wmq.6.2022.11.02.15.01.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 15:01:45 -0700 (PDT)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>, man dog <dogman888888@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 0/3] line-log: plug some memory leaks
Date:   Wed,  2 Nov 2022 23:01:39 +0100
Message-Id: <20221102220142.574890-1-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.38.1.564.g99c012faba
In-Reply-To: <Y2BElOFGJ8JinYxC@nand.local>
References: <Y2BElOFGJ8JinYxC@nand.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch plugs the reported big memory leak, the second one
plugs a minor leak, and the little cleanup in the third puts the
cherry on top.

SZEDER Gábor (3):
  line-log: free diff queue when processing non-merge commits
  line-log: free the diff queues' arrays when processing merge commits
  diff.c: use diff_free_queue()

 diff.c     | 17 +++++++++--------
 diffcore.h |  1 +
 line-log.c |  7 +++----
 3 files changed, 13 insertions(+), 12 deletions(-)

-- 
2.38.1.564.g99c012faba

