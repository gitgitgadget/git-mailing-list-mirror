Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6694C34033
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 04:18:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DC2322527
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 04:18:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IZj8Wuz+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726266AbgBRESS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Feb 2020 23:18:18 -0500
Received: from mail-wr1-f65.google.com ([209.85.221.65]:37812 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726166AbgBRESS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Feb 2020 23:18:18 -0500
Received: by mail-wr1-f65.google.com with SMTP id w15so22201809wru.4
        for <git@vger.kernel.org>; Mon, 17 Feb 2020 20:18:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mUc5Afj4YkT6YDQKs8UdNrMGyNM/zQK3oY+jl2rU29U=;
        b=IZj8Wuz+Ws8DsNtLIttV5PKmwp34XlQxpIo21EvNXJi9US8y4mQ71/zoadcy55D/o9
         oZyZFcF8zqp5nfi/ey/qyqaXMhE7Gldu/LG6DBJq2jEwP0YO6A2OmrVdqlHWnCg1YvBq
         kkP8LLWCI2QZPVWOaju596lCqiDJFxchVwCr7pgZUVkqxwBUjlGHS66E8IF2rGYaaZJk
         P6jc9vjx/fP/jz0kxx8Y/+FWCeC9Z+m2KlOaUBzdKoxzH6waqVHppZP4n1pg0pICPc7U
         BV1HgF/SutsBTX6jr67WiIWOF4Fwfn84y3yk5Wzysg7Mr3hPx9Rha6C188nQiSnOoMTB
         V9iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mUc5Afj4YkT6YDQKs8UdNrMGyNM/zQK3oY+jl2rU29U=;
        b=mDRJseaLrx5VkuJuCfde8oeL8Zhs+K0oWQotmjUIq7Rs1tu0xhNCVRpNsMivOG/jV9
         Ax3U76l3OjJ0xHHJR9Eeg/E+RRH7lmk5UMPexVYAUdORPzUg59iV25xOVxTFjJisyaAY
         MImDFuvwOuESbq1soDShymhSJk3RVfVpKJjxCkBDF/z+PsaPBotz3I05k25R60BXRpnt
         79MdywMKdfjSGUxvVEttP1AAlI2mFAkn2pIbtE5rlXC5dScKFJMlPYu/tOEo4g/MqSFf
         z0qjDhUi9MvbXE/12GtXvaXUzh0R9Dgrh8XtoOCvjOsdIfs/TbXF7KU6RK/haYNvKACk
         73hw==
X-Gm-Message-State: APjAAAVFTjM0IOYJYTkggF/BmjT8j+TcXIGEfeiUvEnK8Vo9Dnsicxq8
        dg5XK3ouHfHJVo2/cMOchYQH3/xPWNg2jg==
X-Google-Smtp-Source: APXvYqxQ/tVK0xBvUPL4ZZND/2qNqR8rhj5RjyPjQKmWe03Fp6p4bl2cXOTxSf/H038WNfLJvJ643Q==
X-Received: by 2002:a5d:4c84:: with SMTP id z4mr26856377wrs.423.1581999496739;
        Mon, 17 Feb 2020 20:18:16 -0800 (PST)
Received: from localhost.localdomain ([41.234.233.158])
        by smtp.gmail.com with ESMTPSA id k16sm4228083wru.0.2020.02.17.20.18.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2020 20:18:16 -0800 (PST)
From:   Robear Selwans <rwagih.rw@gmail.com>
X-Google-Original-From: Robear Selwans <robear.selwans@outlook.com>
To:     git@vger.kernel.org
Cc:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [GSoC][RFC][PATCH 1/2] STRBUF_INIT_CONST: a new way to initialize strbuf
Date:   Tue, 18 Feb 2020 04:18:04 +0000
Message-Id: <20200218041805.10939-2-robear.selwans@outlook.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200218041805.10939-1-robear.selwans@outlook.com>
References: <20200218041805.10939-1-robear.selwans@outlook.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A new function `STRBUF_INIT_CONST(const_str)` was added to allow for a
quick initialization of strbuf.

Details:
Using `STRBUF_INIT_CONST(str)` creates a new struct of type `strbuf` and
initializes its `buf`, `len` and `alloc` as `str`, `strlen(str)` and
`0`, respectively.

Use Case:
This is meant to be used to initialize strbufs with constant values and
thus, only allocating memory when needed.

Usage Example:
```
strbuf env_var = STRBUF_INIT_CONST("dev");
```

This was added according to the issue opened at [https://github.com/gitgitgadget/git/issues/398]

Signed-off-by: Robear Selwans <robear.selwans@outlook.com>
---
 strbuf.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/strbuf.h b/strbuf.h
index bfa66569a4..1a1753424c 100644
--- a/strbuf.h
+++ b/strbuf.h
@@ -71,6 +71,7 @@ struct strbuf {
 
 extern char strbuf_slopbuf[];
 #define STRBUF_INIT  { .alloc = 0, .len = 0, .buf = strbuf_slopbuf }
+#define STRBUF_INIT_CONST(const_str)  { .alloc = 0, .len = strlen(const_str), .buf = const_str }
 
 /*
  * Predeclare this here, since cache.h includes this file before it defines the
-- 
2.17.1

