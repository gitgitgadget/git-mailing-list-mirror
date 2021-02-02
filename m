Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FD7DC433E9
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2E564EDE
	for <git@archiver.kernel.org>; Tue,  2 Feb 2021 09:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbhBBJjS (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Feb 2021 04:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233075AbhBBJgh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Feb 2021 04:36:37 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35E85C0611C2
        for <git@vger.kernel.org>; Tue,  2 Feb 2021 01:34:25 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id s23so13254249pgh.11
        for <git@vger.kernel.org>; Tue, 02 Feb 2021 01:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=BjOmTy4dNmgRmOu+FOU2Diqsqn48K0alvnBzauFVVJY=;
        b=it9Ko8y6oe4GUZ8pPWO4UFAukV6NNrzvu40KckXYSkJ+r+R77ZmnHyVeCmzMWugV9u
         Kxk4M8xfafW+aPKv8pZT9oRx1jEwlXfNPrbqvaz6altqJl+58F6WRwRUjIqISRoHstTw
         LSG4pb2XBRGICGaZHbdxZ4QK8QM10//lXZUto60PQYNpcz2kOyzH/bOyEfANhKgLx0ow
         /7Z4qTmstKC5HgUkCjoJPMd7aMyZWTwx8vYnuGFEkYpld+fEgAnDIMfpRtMT0E48Tq89
         345SChESvMm2yw8vsLJlec1Ek7oAhXemNqTVDZZqJimVOIxvTKUwTvhyU90dTA1cAXVa
         IaEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BjOmTy4dNmgRmOu+FOU2Diqsqn48K0alvnBzauFVVJY=;
        b=IymL2dgzeTXoSyQjfTRM3A5iP5PELDc2mqZJcrHZaAXj3xbC/rMzDC6kl+Rijoaiwl
         Lo8dfx/743AIrB5S7oSfzFcFuf3gg9VOCl0cKp5fwy8voR2ndg42caXKPUjHTgG3Bxsn
         ZShFlqtUWzXaqnx4rTCiIrGNQV6VRxZuaOdSNkjOipvhf2HzUssTOzoVxRQpTiiR0eTd
         zdLmWNx/qaOGTA2oFa4/QVI3r0AYOllNU7BvvSo8tm+Z/XHKQHM+pD3rii6191OKPju9
         zDKOF2uwhdOQjJuHbB+gCIKQ4XtjuFM2Hp2viZFdmCzjix14fsx3uAz+FLwRUfTqkJZD
         TAIw==
X-Gm-Message-State: AOAM531nfib6XNDJRtiaVNZr5lls0V0SeA66omaVUDhf7BX98JYtnldL
        kr7FxJYpLkppN5dtcFuyERlbuoPAOjc=
X-Google-Smtp-Source: ABdhPJy3ld2XmaMXCqZds0xdLLD4vTDruUai29ayptGE5o+k3ABTbS4gMtb1pBO+5WV5Vp+UIelWzA==
X-Received: by 2002:a63:1519:: with SMTP id v25mr21145509pgl.217.1612258464589;
        Tue, 02 Feb 2021 01:34:24 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id e21sm20584462pgv.74.2021.02.02.01.34.20
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Feb 2021 01:34:20 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Subject: [PATCH 7/9] stash: declare ref_stash as an array
Date:   Tue,  2 Feb 2021 01:33:24 -0800
Message-Id: <b5f22de3fc320d23ba2c5342776b56770266ca5f.1612258145.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.478.g8a0d178c01
In-Reply-To: <cover.1612258145.git.liu.denton@gmail.com>
References: <cover.1612258145.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Save sizeof(const char *) bytes by declaring ref_stash as an array
instead of having a redundant pointer to an array.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 builtin/stash.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/stash.c b/builtin/stash.c
index 9bc85f91cd..6f2b58f6ab 100644
--- a/builtin/stash.c
+++ b/builtin/stash.c
@@ -87,7 +87,7 @@ static const char * const git_stash_save_usage[] = {
 	NULL
 };
 
-static const char *ref_stash = "refs/stash";
+static const char ref_stash[] = "refs/stash";
 static struct strbuf stash_index_path = STRBUF_INIT;
 
 /*
-- 
2.30.0.478.g8a0d178c01

