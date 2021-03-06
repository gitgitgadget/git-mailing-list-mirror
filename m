Return-Path: <SRS0=58cf=IE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F71C433E9
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 067ED64FEA
	for <git@archiver.kernel.org>; Sat,  6 Mar 2021 11:06:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbhCFLFg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 6 Mar 2021 06:05:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbhCFLE5 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 6 Mar 2021 06:04:57 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F614C06175F
        for <git@vger.kernel.org>; Sat,  6 Mar 2021 03:04:57 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id f12so5214226wrx.8
        for <git@vger.kernel.org>; Sat, 06 Mar 2021 03:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PGJov++7vxA5xNHcVxuATxcfSA/mEm9mpfPaOCRVnLc=;
        b=Ia3IKW1p3o8e0WT0QPgEfDmkmqQev2hWxZPD8LVaN3y789oGat1A0z7IibyEna2hvu
         jtnkZqlQ+ObehDeNZkdcL8XRa/M6gWKWL43HdpOZiwYZmR6f9LpupK9Z4lpkDaEyeiFw
         6IxGIpg2yXs0N+ATRDD2SIBifeP7lSYwAoAwb8wAvy5kyCXxB1aY1EfYBP5jXBGCcgLn
         V/KZJBw0nCAaJnyP/Tigw1R9yFjZScqcAOR/R7jFrK9K3qAvt9HutOR4yFDi6OOQl7HT
         dE3gptqr6BrNW9yJScoIGhkk5JAs90VR4pRb/LYcYZq2TWTtehWAW9mJ5Zf/tHVAs5I/
         cQSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PGJov++7vxA5xNHcVxuATxcfSA/mEm9mpfPaOCRVnLc=;
        b=NdPTN7+HL10D2+yUUy/CyljFUGTe2MboaA0rHI8hk3OIm14x58lB7vN6Ob8Os6QjM1
         9FwIy684QkxC7VLYxs8vplMEQiyM8kKUqBqj4HR77mxOVhHXjlXyidhSV1EwatIu0MGc
         4e4NE421XwqaQKvW3ZwyhlmCSWXP2t3eq9bDqQXY1eQykYrPTO58M/kRFvWAH5MqryJR
         9AuDUmU/A+7+2QsQqtmMmFFFMnej2Gizn6X6IRytQ4CnZ7tmrzBnZ58WthDh/kjeSUGM
         ac4SmYUhFild1HI0wiDNtGOpYYkcCG+C5nvygrWH2N+VgSSRULT8XruXIHJhpjG5wpA9
         PLtQ==
X-Gm-Message-State: AOAM531loTh2TqcYCKif447ksKSGvFXG2yCqvx/HAETaQe8AIY9l6N2+
        qZu+H+58PsjxOkwAyVVR4ol9vb2jZ3UnQQ==
X-Google-Smtp-Source: ABdhPJxhRt3ul4Y6toloTJGxR+JYa05+6MH3XY4BDip0LEMsaUGK5N1bZRzIJehJhgBlq9Z0PrCHDg==
X-Received: by 2002:a5d:6a87:: with SMTP id s7mr13784855wru.312.1615028695757;
        Sat, 06 Mar 2021 03:04:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o7sm8470797wrs.16.2021.03.06.03.04.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 06 Mar 2021 03:04:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 05/22] fsck.h: indent arguments to of fsck_set_msg_type
Date:   Sat,  6 Mar 2021 12:04:22 +0100
Message-Id: <20210306110439.27694-6-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc0.126.g04f22c5b82
In-Reply-To: <20210218105840.11989-1-avarab@gmail.com>
References: <20210218105840.11989-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fsck.h b/fsck.h
index dc35924cbf5..5e488cef6b3 100644
--- a/fsck.h
+++ b/fsck.h
@@ -11,7 +11,7 @@ struct fsck_options;
 struct object;
 
 void fsck_set_msg_type(struct fsck_options *options,
-		const char *msg_id, const char *msg_type);
+		       const char *msg_id, const char *msg_type);
 void fsck_set_msg_types(struct fsck_options *options, const char *values);
 int is_valid_msg_type(const char *msg_id, const char *msg_type);
 
-- 
2.31.0.rc0.126.g04f22c5b82

