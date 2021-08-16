Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA7CC4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:15:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43B2761374
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:15:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232656AbhHPBQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231609AbhHPBQ1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 21:16:27 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F26BC061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:56 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id t190so4136827qke.7
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MbPVCokt8k4WR9LTvM0Oi+cfW65if14am6Bat+7aDp0=;
        b=j33fgW5CSP9kkdwuCzJNXdzh26URw//XtjUQAcP3Qv9EZNZxX1gmr/gCSdRV7GtMXQ
         tI6bb+4jz7MNWFrH8ZjoGepBZd5p5g0X5td+TTLS942iUGUQEbWJs0jKyswtW5UxR34h
         YERNzuFw+fkYPRoEgjVdi5deWXVD7f+hlfnpGdWXy6wQZreHZJBKcyPsbhPjbOCB6sRB
         cMsLRA39wNmbgfB3mxMI1WB9Ru1RrVz909zrl0DDk5qx/USjpbp7qJ+lAj9SZM5rK414
         FFK+2ygc047GcHLtnn6KK+VnU7SKEez/OUCOAwDrPYIvrCN3KrNfAT+ntcgMCMMdZV3k
         QSxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MbPVCokt8k4WR9LTvM0Oi+cfW65if14am6Bat+7aDp0=;
        b=Y81aX6KJleyFr+pC9qhmgKGw9jOLLN8EFnvzsfCKThI2VpWp831oUr3BMMkIXp73y0
         83eoF9sgPBV6y27q5Ay9MLWSS3EYBOgA64y5n1sxtZkj7E/NJdAvXaFWCXy34Bg7tD0I
         5RWk8bxoclEqVtumppPjsihLT/RH1tEByHQsw4Rtnhg0BBEYLlHr7l4lqTzNuRCr/5o5
         9fh6PbO3upwW8JA+ZCF315AZG83hWnQzrwvz84BG5j0DXWfEntXkPqHxJPOV41uP8uKO
         8pBR6zLKCa3WrsF07jzfsa5r+Kle1AhuZmmo4SAFNpKkm8K55IiYFcWSIftDNRnd8V7h
         W/yg==
X-Gm-Message-State: AOAM533Fkkk/lDZKQty1mg9kZ021Igf/v65JjVxiPNAH0hFdqqa+Qf3J
        cc3/SMx4tYy7aKQ5s1qB++z+W2UfBzI=
X-Google-Smtp-Source: ABdhPJwac5orxDZRG6fHHkYHliZ3kU4s4EzLb4tnbtFVAsaEk3y5kmgF7bdgsIkRAmXnA1CQagMReQ==
X-Received: by 2002:a05:620a:2116:: with SMTP id l22mr13568896qkl.12.1629076555343;
        Sun, 15 Aug 2021 18:15:55 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f2sm4121181qth.11.2021.08.15.18.15.54
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 18:15:55 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 2/7] reftable: clarify zlib version dependency
Date:   Sun, 15 Aug 2021 18:15:33 -0700
Message-Id: <20210816011538.34199-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc2.476.g1b09a32a73
In-Reply-To: <20210816011538.34199-1-carenas@gmail.com>
References: <20210802190054.58282-1-carenas@gmail.com>
 <20210816011538.34199-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

3541411189 (reftable: reading/writing blocks, 2021-07-20) add a comment
explaining that a newer zlib version is required but being a little vague
about the specifics

make sure the zlib version is mentioned to aid on deciding to enable or
not the NO_UNCOMPRESS2 compatibility layer

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 reftable/block.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/reftable/block.c b/reftable/block.c
index 92f8e5abfa..eb5268dd3a 100644
--- a/reftable/block.c
+++ b/reftable/block.c
@@ -16,7 +16,9 @@ license that can be found in the LICENSE file or at
 #include <zlib.h>
 
 #ifdef NO_UNCOMPRESS2
-/* This is uncompress2, which is only available in zlib as of 2017.
+/*
+ * This is uncompress2, which is only available in zlib >= 1.2.9
+ * (released as of early 2017)
  */
 int uncompress2(Bytef *dest, uLongf *destLen, const Bytef *source,
 		uLong *sourceLen);
-- 
2.33.0.rc2.476.g1b09a32a73

