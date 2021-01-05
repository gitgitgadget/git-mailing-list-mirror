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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD31DC433E6
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B746222D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730942AbhAETo7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbhAEToy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:54 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F853C0617A7
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:43 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g185so623759wmf.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lCKf2NBbDpDsTMTjqpZ3kMR5PrX6KPli2kTefNDk+II=;
        b=G0skBFnSUxbHBDSDKAOjkM9L4FgLqlP8usTaJqxyxIbDcFOgy0jSP0WqUmY10Z28rD
         Kv+wLZCsprmDZnDpLEjfVb6eXHeenlkqOhzUlrBaxkTqkzxUaHKjAlCYAuTJHZtfSCKS
         GpcNaUN8X50hQ9pgV9Ja9Vyem778phuaaHG/r/GirvaVZbO7H5Z5ypJdqg7cT3AQB/tM
         QKsTA3hd53I8Qf6yV7n0eMhNZVcYqlb/V/GN6U8JEY61YXdinHw7yfSmzVJpRD6RlbLX
         1EzHfXy0OFDYZPxZ1XSEbGhkIzt/WzZqjMqe612/oIDo0n2etqW4T/bxdYLtzt7mLWmi
         Thrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lCKf2NBbDpDsTMTjqpZ3kMR5PrX6KPli2kTefNDk+II=;
        b=V9UyixFyD19RGaGigZ+IMkCDVUloi+iapqHiGTBJE/g3bfA+CVY8nV73ftIB2fivjb
         MHVsjuyPDxn9UsAs60RRkeMZ5zidT72WkKZ0aLHG3Zg+lkeooP5CcW2vwzvYrXsg4k2g
         o8RgM3KdMaY/fvQKZUKD3ltyyP9xW8ecA5gWXu7KuSvdWJGsDpEDHSKUa/CZ4Gmnscag
         lKGVwvNMIuhVOQ7NfYa7AlGe6sw+sUfPskhnSjcgit5Mr3yWu0xYvL9EbjwReyavBr8X
         ZdJBJr9cdgDwmBISfW6C0/r9VbMObEXtgZobOTMrwBOZXfpSbre9k2POn6p65gKW4KK1
         zzwQ==
X-Gm-Message-State: AOAM531StDggnwnHgkWjc2kbFgI6hmrWUESWXE2az5fT8AxLeLOHwpVi
        d7v8/4DTN7xKSh6rxy7rOX6LwaJ7UUElWg==
X-Google-Smtp-Source: ABdhPJxsbC4jz7sms1poKgYLUzVDrnkpZFTfpeyrrySj862JLwZE2qWs3FY/brCKkCAY6orET2VuWg==
X-Received: by 2002:a7b:c389:: with SMTP id s9mr576911wmj.159.1609875822011;
        Tue, 05 Jan 2021 11:43:42 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 14/23] mktag: use default strbuf_read() hint
Date:   Tue,  5 Jan 2021 20:42:43 +0100
Message-Id: <20210105194252.627-15-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the hardcoded hint of 2^12 to 0. The default strbuf hint is
perfectly fine here, and the only reason we were hardcoding it is
because it survived migration from a pre-strbuf fixed-sized buffer.

See fd17f5b5f77 (Replace all read_fd use with strbuf_read, and get rid
of it., 2007-09-10) for that migration.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 4982d3a93ef..ff7ac8e0e5d 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -161,7 +161,7 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 	if (argc != 1)
 		usage("git mktag");
 
-	if (strbuf_read(&buf, 0, 4096) < 0) {
+	if (strbuf_read(&buf, 0, 0) < 0) {
 		die_errno("could not read from stdin");
 	}
 
-- 
2.29.2.222.g5d2a92d10f8

