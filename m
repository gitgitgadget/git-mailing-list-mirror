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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE06C433E0
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:31:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8C72464E28
	for <git@archiver.kernel.org>; Thu, 18 Feb 2021 12:31:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbhBRMaQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Feb 2021 07:30:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230396AbhBRLB0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Feb 2021 06:01:26 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AC4CC0617A7
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:51 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id t15so2377248wrx.13
        for <git@vger.kernel.org>; Thu, 18 Feb 2021 02:58:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6G52t8Rfu7Wdt6m5/mgN4vZp9G3xuh+VHhZbl9A7XQY=;
        b=n7Y2vqe9gvJY/09bLW6kIdRMQymz4duEZOEHFhGJmMdlMemdv7GuNx0pA0ONTu6c3F
         q+FcqSyQOUlRUFz+FZhz8J/MqoN3/zsgBxMSxyWLnQ6HzTtcTcRQed//aGM9kKof/OHs
         IipUXtaqUQstP9LT/yDqq8EexRrqCKykeSy7g0Qk0gvTmABCkHTuy1dWTXGEqr5gUoov
         cIG3rNDnWB9LZ0pGBhFu5QUS3cKyPfvCx9k+RgrvQO0Z1BxvSaHZCIWSMpvfgoRthu9s
         8riQmse37vf4ynCUgPNuNYNjIokgdxV1qu1FqQa5XjcW4VoYy6PYZxYolI9gMOHXn+q9
         VqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6G52t8Rfu7Wdt6m5/mgN4vZp9G3xuh+VHhZbl9A7XQY=;
        b=K9z8CT6YZLzKsb2aWjE5gLPc2FB7OGMiOJdEJPbyXuPdp0prwoqbXrFBxL1CiNHOOC
         +rm3s+ct0Nrlnf+mnOQ2R8uCesAGSuq/TtP9pVP8Bl564q5oCscT8JAUB9x1EeOwkIf9
         r6gh9Hlmy0c7XVhyWKh/bMQNzhX3FZYlHgogKH2B3unIJqAhzcqnJlew8ahaieakd9x8
         8TFXMolfqqYqc109+HbSNUm345XrOSXEqdbEredcqFrTcrHAXCHZYQpDpsPa7ONtuBhq
         7lDEBfD1ShKm3TVAJ/o3NZq4yOdhuGmwIFzHhSa3o47gfcoUIKadJWozpwj1D/vBtuMb
         wfIA==
X-Gm-Message-State: AOAM532JaPz/VLa+T1Fi6BPg3rffBHRyVinegfqmCVlvm4fQPKpQiAud
        wYMam//dC2W0HHGkdiXZtiLKmy3eb2fmzg==
X-Google-Smtp-Source: ABdhPJx7iy0yiMayj0Fdz3CTgWxUGJz6xJlo7b0UAAUU7Y9Zv47mW34odXFYuO+P8o+WMxRT7DPX8Q==
X-Received: by 2002:adf:e70e:: with SMTP id c14mr3762902wrm.54.1613645929505;
        Thu, 18 Feb 2021 02:58:49 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l7sm8604376wrn.11.2021.02.18.02.58.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Feb 2021 02:58:48 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/10] fsck.c: undefine temporary STR macro after use
Date:   Thu, 18 Feb 2021 11:58:38 +0100
Message-Id: <20210218105840.11989-9-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210217194246.25342-1-avarab@gmail.com>
References: <20210217194246.25342-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In f417eed8cde (fsck: provide a function to parse fsck message IDs,
2015-06-22) the "STR" macro was introduced, but that short macro name
was not undefined after use as was done earlier in the same series for
the MSG_ID macro in c99ba492f1c (fsck: introduce identifiers for fsck
messages, 2015-06-22).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 fsck.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fsck.c b/fsck.c
index 7c53080ad48..88884e91c89 100644
--- a/fsck.c
+++ b/fsck.c
@@ -100,6 +100,7 @@ static struct {
 	{ NULL, NULL, NULL, -1 }
 };
 #undef MSG_ID
+#undef STR
 
 static void prepare_msg_ids(void)
 {
-- 
2.30.0.284.gd98b1dd5eaa7

