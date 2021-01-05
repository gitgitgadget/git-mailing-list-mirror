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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40EE8C433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1085622D72
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730961AbhAETpE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:45:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730927AbhAETpD (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:45:03 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EFE1C0617AA
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:45 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id g185so623828wmf.3
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zKkRoTKMdXvXYan50w7uT55OsUoFQy+xWAnGaL50DuQ=;
        b=HpDCiNy73ifv5W5VXCEOWX9y89B+sS4HY3wN16pMYH06PaC7dDNrc63ogt2G6dbrNn
         s3ooDlVua/v7kMUTIWPqZ+rXllbu4MJEmQ3aC/edhXxhSFCVKw09rMLfOqj//qDCXjm4
         y/8gsT0LUtFelumbTtmm7wBKRXm92GJgF2NR5eETAshL0tGOy0i4BQlMBaEjHe+lJvut
         mWriwyuyrapWuMh5YavvymoMT7RZUkoIWAaGITLVHx9IMa4OBee1w0nGjx0Q7sb7LJyj
         GE4mWe+lp8QIDHtSUMX86adbKlRM6gZ41/Dv75JB5T5yXdpntjEelOSTQsYMSzPHXVpn
         Sj7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zKkRoTKMdXvXYan50w7uT55OsUoFQy+xWAnGaL50DuQ=;
        b=gvgJCrTDA1L8ivAAEKxtBZaH6U5oDZpKRaASlU/DDUOOrPX3ZazEW56bCh7vy2NW9H
         F4J7DcR4w8fTLytoaxO9tTG55P0uuzizF1VLyyu3vXbKmERGcxFW1uv+Cn+KBaeNfJ+0
         0vBMyRwM6RN4e/hPoMY5+s0zfrkS8BU0d7gJ5ExKyqcKPg/G5u9IvGhrfiB+uOJjjq9E
         vkhZADBbGJFd2nCTIX59icTZhHRGOP6qilR5+/aS+acrE6/r010QAswxyeyHtNg4ikZQ
         AVjQ/+s0GFaZ4lg1TjXbxeBU1qQLAIES71jsJcd7QIeLW4elByj0k25N/w6TO2W6d/I7
         KV8A==
X-Gm-Message-State: AOAM531vvlSEhNt7MOPzjkfCLwfmy3oz/9pnBmIB+ilyn+ChUJ1cJIeG
        diy6aDTRycOhJ5cA2IyuBdyGy92tZBLp5w==
X-Google-Smtp-Source: ABdhPJwxlFvhrdd8v8di4CknXzw28n4cAQF9w3mIGe8h7iAnVlrQa56LlPBdaqVeiZ5GTiSGaJV9dg==
X-Received: by 2002:a7b:c406:: with SMTP id k6mr643124wmi.90.1609875824080;
        Tue, 05 Jan 2021 11:43:44 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:43 -0800 (PST)
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
Subject: [PATCH v5 16/23] mktag: use puts(str) instead of printf("%s\n", str)
Date:   Tue,  5 Jan 2021 20:42:45 +0100
Message-Id: <20210105194252.627-17-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This introduces no functional change, but refactors the print-out of
the hash at the end to do the same thing with less code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/mktag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/mktag.c b/builtin/mktag.c
index 97ca5f28b1b..d89a3c201de 100644
--- a/builtin/mktag.c
+++ b/builtin/mktag.c
@@ -173,6 +173,6 @@ int cmd_mktag(int argc, const char **argv, const char *prefix)
 		die("unable to write tag file");
 
 	strbuf_release(&buf);
-	printf("%s\n", oid_to_hex(&result));
+	puts(oid_to_hex(&result));
 	return 0;
 }
-- 
2.29.2.222.g5d2a92d10f8

