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
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8778C4338F
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0F30610C9
	for <git@archiver.kernel.org>; Mon, 16 Aug 2021 01:16:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbhHPBQ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 15 Aug 2021 21:16:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232627AbhHPBQ2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 15 Aug 2021 21:16:28 -0400
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914EBC061764
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:57 -0700 (PDT)
Received: by mail-qv1-xf34.google.com with SMTP id g6so8503364qvj.8
        for <git@vger.kernel.org>; Sun, 15 Aug 2021 18:15:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SCeyvfYxhD/eCklDGCQBmDroB5NDN+IxZZ4/yfwA6aU=;
        b=IWzvVp5Kr93IzhhA+ZodGVqnkraXoFgYHUJhl6onRfHgJTPlsPRFiFCTi75BSXZsZb
         HY6Jzfci/eqK4MJaRIWU+9DCaY8Xq0sHOWN2D35QV7qUfz8g0x/AiTyA2qFJaod10h3Y
         a9+XA/z7+I9+yDIqfH8NLye4Ffky9g1IV/e2X/ktqgltQAQFfzc+RFW74Dbgvk3GPYOs
         DODxhHdd9rcm+Id1yc9viBev1F496ECzQTAR+n0NgfNwlFvTcSf3RZlVWC6e2/UZ2oPM
         rjmhwC+y3x0pI8IC3pWzCY1R+F3f1Kh3KTBb+J+6KR1likAUJ7xDMbHTbRBkI7b3pJjJ
         wTBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SCeyvfYxhD/eCklDGCQBmDroB5NDN+IxZZ4/yfwA6aU=;
        b=cetke/p/6w4s7iGp4Rqn1mlAFsCuDyvIXe2iw2o1WueBE4IyY9tkZDcWkjzs9a+GNq
         nW5zz/5VsBLSvDgvUDMw1klii1adzxQ9qA811VX1rYYxZ2T0xxi4+3Mm/bMSwPIk2YqF
         W7zHQ7InCpyOteYZRjIH5we65ayNRAtRRtfrM0bUDpLcsvsszq4HEiUbg93WANUOF9Ns
         Jl43qB3wdVjNxsXOydOUwEb75iOyn5Uh9Vu6o03rIjTvRD6+gK1YlHubcETLBPQti4R3
         n2h+Gy3Q/vPG8lb7ZOVe1FepctrMHPonMkIbL2YsQ6NTO9UW2KopAsaiWP3sNyScrkhj
         exUg==
X-Gm-Message-State: AOAM533qmGfh/P79uoXrYg/1LvHHdsD93lFZfMuwVYOwZl88MNw8Mq39
        UmluI2KXt0NEFDkmF1fww3dlMG0uMMk=
X-Google-Smtp-Source: ABdhPJwUkV/mihL5Ohz4hjZRSZNlnegkxJlATYdiYQrH53q5w5UcM0NmSXaoFgYzre0OYqogx3AHCg==
X-Received: by 2002:a0c:f8cf:: with SMTP id h15mr13761125qvo.15.1629076556596;
        Sun, 15 Aug 2021 18:15:56 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id f2sm4121181qth.11.2021.08.15.18.15.55
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Aug 2021 18:15:56 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, gitster@pobox.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH v2 3/7] openbsd: allow reftable building with zlib 1.2.3
Date:   Sun, 15 Aug 2021 18:15:34 -0700
Message-Id: <20210816011538.34199-4-carenas@gmail.com>
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

all released versions of OpenBSD (up to 6.9) include an older than 1.2.9
version of zlib in base.

enable the compat uncompress2 function until is no longer needed (likely
at least until the next 2 future releases are not yet EOL)

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 config.mak.uname | 1 +
 1 file changed, 1 insertion(+)

diff --git a/config.mak.uname b/config.mak.uname
index a2b156e338..019c88d5df 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -256,6 +256,7 @@ ifeq ($(uname_S),FreeBSD)
 	FILENO_IS_A_MACRO = UnfortunatelyYes
 endif
 ifeq ($(uname_S),OpenBSD)
+	NO_UNCOMPRESS2 = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_MEMMEM = YesPlease
 	USE_ST_TIMESPEC = YesPlease
-- 
2.33.0.rc2.476.g1b09a32a73

