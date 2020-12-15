Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 588F9C2BBCA
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2085322D57
	for <git@archiver.kernel.org>; Wed, 16 Dec 2020 00:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728028AbgLPABh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Dec 2020 19:01:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726055AbgLOXvV (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Dec 2020 18:51:21 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F7D3C0613D3
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:50:41 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id y23so784963wmi.1
        for <git@vger.kernel.org>; Tue, 15 Dec 2020 15:50:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Pfi9XVGq8gv7aDC1epg/yZxFP7gigGEww8CHVVa2hsc=;
        b=CqKKouLlsAMnhMK2AoUifNRMVE5TQ61Tnx2hUZbxj3Fe2SMWOrjmQNOQ2U7GojlZIU
         0SPXgsMdfkrR1Kwd9QYS7a5bbVzVE1s1YvrWNdTuXHqx14TVyWgBoJ9vrz/bamjZUuLP
         Ciamrid67flJaOSsl4QG/RhPfUqBKqLWbEQlNp75Sh4AnMjmHCs9YfI+lPC0v+8czodO
         qhTXeXVujxg9mk5DMvIv+voxtT0Ax+gH/bP4WbnA7tslmo/6XK9O0azlCUwAMigrvkMb
         sx9YoWD2Jv46p00iEXRqcGr4BNrPf9B9x77Kk772fs+0D0pdJ2EO9zpsEa9+aeQS5tbA
         ideA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Pfi9XVGq8gv7aDC1epg/yZxFP7gigGEww8CHVVa2hsc=;
        b=AWpGmJ0PstaQlTLpVGvUvrN1Pl8DAOBJwynoltCXu1LU/tD5lhPJEADymw9YGt6SBN
         vifaALLYpXGMSxpNnWbl1dyaM4cWBg3R9CUqLl8dF4LqNPcMkgW+9j0Ooi4+m2sXpXGV
         gl5LM3JiMvYz7fXNjk5SqM/B4VvBGVe6ZoRFsoArhbACuuKjXIhfob2pphd5kIskwEKn
         hg2YCX0/aY3kaoCcrZCsOWUVC1uRsqBTmT+tAP3617HLhcB/kYhWoNfJT4BdWVLiKWO0
         3Ts1O94xUZhxKwnXJ9MMEunvr1xDNZk0vwhyM467/u6sm8k3/+swGkvWP/1FuDY3DaqI
         T5PA==
X-Gm-Message-State: AOAM531aHM8/GPAaOeOqC03Q9esGXAGpse2Rctgg9yMr6+qr/CiPdD91
        gV55aXsC/HO4XWPZrKVkEAUJgbBbxzDPow==
X-Google-Smtp-Source: ABdhPJx+E6EhrpEOHmGkiLiT5O1atMZSQUhFrw5Ljp4KANp+CnhBEaiIE2Ac4Wsxoj6wWo2t6flQKA==
X-Received: by 2002:a1c:25c2:: with SMTP id l185mr793226wml.113.1608076240066;
        Tue, 15 Dec 2020 15:50:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f9sm417703wrh.9.2020.12.15.15.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Dec 2020 15:50:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 0/2] Make v2.30.0-rc0 compile on SunCC
Date:   Wed, 16 Dec 2020 00:50:25 +0100
Message-Id: <20201215235027.10401-1-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <xmqq7dpkdup6.fsf@gitster.c.googlers.com>
References: <xmqq7dpkdup6.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The first patch is needed for $subject, I figured I'd let 2/2 tag
along, but as it itself notes it's just one of numerous warnings SunCC
emits on our sources. Seems sensible to fix while we're at it though.

Ævar Arnfjörð Bjarmason (2):
  strmap: do not "return" in a void function
  style: do not "break" in switch() after "return"

 apply.c               | 2 --
 builtin/fast-export.c | 1 -
 strmap.h              | 4 ++--
 3 files changed, 2 insertions(+), 5 deletions(-)

-- 
2.29.2.222.g5d2a92d10f8

