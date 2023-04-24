Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9ABC77B61
	for <git@archiver.kernel.org>; Mon, 24 Apr 2023 16:51:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231799AbjDXQvm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Apr 2023 12:51:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232239AbjDXQvY (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2023 12:51:24 -0400
Received: from mail-oo1-xc32.google.com (mail-oo1-xc32.google.com [IPv6:2607:f8b0:4864:20::c32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BC0A5FB
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:51:02 -0700 (PDT)
Received: by mail-oo1-xc32.google.com with SMTP id 006d021491bc7-541b69cbe87so3719563eaf.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2023 09:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682355061; x=1684947061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlvY/gLWCEYjlHyoLi+mPQutE02K+TOVJ6CE8QhKHtU=;
        b=DIdUotC4uwRaAFj7cEP2Hqc5HKk+G64jRnSwnyOmDa5t5Jv/kI25ScMMx/MfPoORQ4
         /HjfhA5D7El/D6dWSLRHpZTw56HUcfMG2+CEUFNEcb2dgZImDxgF4h0J1G0z9NIIiGRK
         Gd4CU5Q2YcexzD97VMDSjFAjG7WE20tcNuL/wl3BxOiT8hQAu1KwrTHph2h05+Hk8BST
         +ItuL1MO5FjyQYCCvv0990sGAIyNb515j8n1+Gg8uEIq1UkObBei2+HgpqC1IkLLpdNW
         kkQ0zvMQryEx53wkbq05qS5UpEcHd/pW9OsP9xL/e1qthht0uuV+EtXEa9uFpC64rms1
         taEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682355061; x=1684947061;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LlvY/gLWCEYjlHyoLi+mPQutE02K+TOVJ6CE8QhKHtU=;
        b=SNi42DJLD3+FTvQi9HXhOnboPXr/0UL++pHK7/FgEVzeD4kP3TBYuAjdrYp4XK0ExZ
         +JYKN/A+ZkyRtsnusaBE8KA0G0eTHW3seCpXJUXA/LmGy7E+um88KAN12Kn/Yzellz4l
         VGB/tCRv0jKeHNuxGChKFFL4pUNdWLkkaostj8hb1DRWAN5TwZHnMqSU5DiA78sXEj87
         TaPmhC04Eiwx4JHLvM0/Ty/kKjVqHDomDr91YVVUzeEaBj2FYr8WhNmA8aEfLO3Pffwy
         uvn8e+zJ4OhVCmEo5ri1NKA319grSd9LwRJ7bF0vfsMbHLy34XOVa0J8jsa6Ku/9ujb7
         SW4w==
X-Gm-Message-State: AAQBX9cIaqYXf9ASBIrWwGS6a5R4SiV+3Sj5UfQbfjv9hK42V+zqiwHg
        K/QYSGfsg+TyUagqgkvPJCTErmTQJ0w=
X-Google-Smtp-Source: AKy350YpFN+Ig4GEZgSdyZDXfUgIPeSDkc3rBZQue/qpj6G0yOWdx7vsLf5f5OgyLITwwV0V00XW9Q==
X-Received: by 2002:a4a:dc86:0:b0:545:fb94:34a7 with SMTP id g6-20020a4adc86000000b00545fb9434a7mr5736312oou.1.1682355061561;
        Mon, 24 Apr 2023 09:51:01 -0700 (PDT)
Received: from localhost ([2806:2f0:4060:fff1:4ae7:daff:fe31:3285])
        by smtp.gmail.com with ESMTPSA id k34-20020a4a94a5000000b0054156478f2esm5062070ooi.44.2023.04.24.09.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Apr 2023 09:51:00 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
        Todd Zullinger <tmz@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 14/15] version-gen: refactor GIT_VERSION string
Date:   Mon, 24 Apr 2023 10:50:40 -0600
Message-Id: <20230424165041.25180-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.40.0+fc1
In-Reply-To: <20230424165041.25180-1-felipe.contreras@gmail.com>
References: <20230424165041.25180-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 GIT-VERSION-GEN | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
index 5b75cb4976..a1c50cb06b 100755
--- a/GIT-VERSION-GEN
+++ b/GIT-VERSION-GEN
@@ -13,5 +13,7 @@ VN=$(get_version)
 
 : "${VN:=$DEF_VER}"
 
-test -r $GVF && test "GIT_VERSION = $VN" = "$(cat $GVF)" && exit
-echo "GIT_VERSION = $VN" | tee $GVF >&2
+NEW="GIT_VERSION = $VN"
+
+test -r $GVF && test "$NEW" = "$(cat $GVF)" && exit
+echo "$NEW" | tee $GVF >&2
-- 
2.40.0+fc1

