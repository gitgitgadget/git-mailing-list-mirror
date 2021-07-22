Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 307BEC63799
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:20:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 271B6604DC
	for <git@archiver.kernel.org>; Thu, 22 Jul 2021 18:20:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229556AbhGVRhG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Jul 2021 13:37:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229474AbhGVRhF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Jul 2021 13:37:05 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCF7C061575
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 11:17:40 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s5so6245584ild.5
        for <git@vger.kernel.org>; Thu, 22 Jul 2021 11:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=HeTYaPq5caXtTJl5jLr4aC1keyUQKag2wl1q2UjrgGs=;
        b=Wuk5yWlRkkYICoHEAbXcC8Fs7it/AcfEj/LQz+fEF1k6AhaOiRkTVc+n5RV1DVvHNF
         3r+fqI8uyavRM66TMFZEaKhXBBhNzXp3YYy3zR/GRsnqFc6ecTj3oWrurg/7VvF8YOYI
         aAhKEScIf5lZkU4xeOTh4NjH64n6rjlOHxGtEVPeHDb46xM3w7tZOw3u3qSqC3dORkXP
         cleVQ3gUmMZZBUiCi+b3vbDhKMB1YtAXZ3sBXkY7uhc8vwVQ80JoyxLvxgYXYYU0WO4C
         sYL+40NK2dahaxJZC6cqvvP2gG6Dfidvyg1lr646c7CHrlZ6S+rrpEMGdgoqMVxsi5Q0
         khKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=HeTYaPq5caXtTJl5jLr4aC1keyUQKag2wl1q2UjrgGs=;
        b=YawGkYqTdW5EI4Ck7cSpW0vqK68HFUmES6fKgltssye3KvL2wb10Dx7yBKLYFOAQ7T
         xJjShKT4Lfz5t4nuzENQcMEBLVWnoeBViLZMOYbV71QlkoEyh851K0X6l8G/zrZ3qPkm
         r5fPA3fYFFJrqPGFgPszFqRoT5SSOBVGDpMwpBP2kbZQI2V+ZrFJdifl3knFXxqicEJ3
         LGw8DZrBAvUhEGCa0rk5vlZ026R+5gDhzo2HI1YGvCbIXl7l2/LkqonjR2DRUm/+p6oA
         03TRS//ZFFdANNzOU66EhfnbP2Vb/fBYo+49HGtDoE9PEyI8IFvt3VPF1AtNxHaW8imp
         boKg==
X-Gm-Message-State: AOAM531LK3ZkP7XSJPvBseyoTXP50EK/PZa3cBEn5ihDVpv1K99Mdy40
        kArgsDv4RIzGNWRv/EFERWyPWg==
X-Google-Smtp-Source: ABdhPJy2tOpaJzlmSLFpMRkZrNkcehURlIYXpQvsbVpdHmy6+Br8hjOSaQ9LDJQoMDzNpsnNjvdZWw==
X-Received: by 2002:a92:1908:: with SMTP id 8mr743723ilz.149.1626977859906;
        Thu, 22 Jul 2021 11:17:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r16sm15009915iln.30.2021.07.22.11.17.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 11:17:39 -0700 (PDT)
Date:   Thu, 22 Jul 2021 14:17:39 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 0/2] bundle tests: modernize, fix missing coverage &
 test_cmp
Message-ID: <YPm2QwoDu9TtkXQJ@nand.local>
References: <cover-0.2-00000000000-20210720T115052Z-avarab@gmail.com>
 <cover-0.2-00000000000-20210721T235251Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.2-00000000000-20210721T235251Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jul 22, 2021 at 01:53:27AM +0200, Ævar Arnfjörð Bjarmason wrote:
> A trivial series to improve the bundle tests a bit. This is split off
> from some larger changes to "git bundle" I have cooking, where the
> "test_cmp" in 2/2 helped assert & catch regressions.

Thanks, this version looks great to me, so I'd be happy to see it get
picked up.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
