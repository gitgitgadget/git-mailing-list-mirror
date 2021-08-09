Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F123C4338F
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 06:30:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3DFE761055
	for <git@archiver.kernel.org>; Mon,  9 Aug 2021 06:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233288AbhHIGaj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 9 Aug 2021 02:30:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233285AbhHIGah (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 9 Aug 2021 02:30:37 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF843C0613CF
        for <git@vger.kernel.org>; Sun,  8 Aug 2021 23:30:17 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id kl2so8414836qvb.11
        for <git@vger.kernel.org>; Sun, 08 Aug 2021 23:30:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zjOhvZHxZGWrtRDaP/beG7zzYAP6PHJOKlH7N9Bg1Os=;
        b=V5PUsUl6+nSh5X7TsRywvumUpfM2lklcjaI+g/DisV8q3UjNo9YrJFA2tWbDQrWw0X
         bnb/PqnVXnd0xRcS8g9hjwG3KAS9ZVddo8xwCdor1+N2VSmFgpvZZQCKsozPtv30H9+4
         TkgWaAVZYXevvC0hz5tQHQ3YxWHz1ZesF2w0W637Vp/KbvooCP+d1KoFAv5IIxxNkc/4
         MUAMAsMkkemCVkdHsx0DwDj8q0hsqg3SUrT6v1PYGbSiVB+G7439XhkS+p6U5u1/lc42
         isd3khlyhHwSJ1hdnjM6idGr1st5Bz/drFZMf8Zk5XXkyZwPoyFCX7rekuaUcFJFs/Bi
         BC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zjOhvZHxZGWrtRDaP/beG7zzYAP6PHJOKlH7N9Bg1Os=;
        b=ncjjYvxD+lzPJBmSDBEfSam9fBimKEjsi18KlQKDCSA7Mkx6LovTB3CYRBGG6cuQjk
         GgwNdo67fn10gkmIDBVTqCX5WzglhdgJDvBko/0XDnh2C3LMpJ2EbF4g+kD3FM9Cog/B
         AI1NJywCV2O6eik4SDEmxd5nCaeVT0KiJ7TEkiwj1qkm3SmIFp3xuFrAqKAysgDXlVuj
         qUN70hX/8xlOYe58R61hCjVck/d7ktF3fsiJ6JgxQkVm19C4enYd7gNOTjANHTPq8x5X
         UHSjst5EQMq0wniyX9NZmNofWX6M58FUTS7IqLaIvDSEUyRhmN6OcPVzrb8Gc9k/EFNV
         3raw==
X-Gm-Message-State: AOAM531zPBUgcIraVhriRABZobytayHE0Fpzmh76Q1E4iUV0yIy/XP17
        qplbeg7T8wqMUyzKtWRN5a+pb+0vecc=
X-Google-Smtp-Source: ABdhPJzi0R7UucXe2BsXJy3fQTU5ZoYNHu310rAkxxg6/pIr3OydW3rnzJCbzBwtiNBMQAT4twReOw==
X-Received: by 2002:a0c:e908:: with SMTP id a8mr22217415qvo.61.1628490616874;
        Sun, 08 Aug 2021 23:30:16 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 10sm1239994qkv.135.2021.08.08.23.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 08 Aug 2021 23:30:16 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     jeffhost@microsoft.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/2] fixup! fsmonitor--daemon: implement handle_client callback
Date:   Sun,  8 Aug 2021 23:30:04 -0700
Message-Id: <20210809063004.73736-3-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.rc1.373.gc715f1a457
In-Reply-To: <20210809063004.73736-1-carenas@gmail.com>
References: <20210809063004.73736-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

fsmonitor: avoid extra ; for KHASH_INIT

builtin/fsmonitor--daemon.c:622:75: error: ISO C does not allow extra ';' outside of a function [-Werror=pedantic]
  622 | KHASH_INIT(str, const char *, int, 0, kh_str_hash_func, kh_str_hash_equal);
      |                                                                           ^

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 builtin/fsmonitor--daemon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/fsmonitor--daemon.c b/builtin/fsmonitor--daemon.c
index 25f18f2726..d018af346f 100644
--- a/builtin/fsmonitor--daemon.c
+++ b/builtin/fsmonitor--daemon.c
@@ -619,7 +619,7 @@ static int fsmonitor_parse_client_token(const char *buf_token,
 	return 0;
 }
 
-KHASH_INIT(str, const char *, int, 0, kh_str_hash_func, kh_str_hash_equal);
+KHASH_INIT(str, const char *, int, 0, kh_str_hash_func, kh_str_hash_equal)
 
 static int do_handle_client(struct fsmonitor_daemon_state *state,
 			    const char *command,
-- 
2.33.0.rc1.373.gc715f1a457

