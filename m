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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43F55C4332B
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 22CB222573
	for <git@archiver.kernel.org>; Wed, 23 Dec 2020 01:39:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727315AbgLWBjJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Dec 2020 20:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727310AbgLWBjI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Dec 2020 20:39:08 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A1CC0611CD
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:56 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id d26so16942290wrb.12
        for <git@vger.kernel.org>; Tue, 22 Dec 2020 17:37:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WAn87zif05wzQ/mymNx3QqCaxERkvseXvbutVRgQtII=;
        b=RkyZ5+joywEZDrEDXaky55O8CevnjnjZ3Q6LBJ6I75T3fknwEZw3CJmtfNEyxBAhzf
         WvmCk6NZDyFKpyVYRf3Oc8kpoR1kV1vL9/SVISpsFm7+/8OumgzG17h3VH+7pLA24Uhw
         dWJd1OnZhy5EmqCuhiNux2t1WVWEhjbads/ATUQvtlHQxyp1W7sbi4V+bRXHrmkL6fIe
         Y5NyUBzsHCN4XMr0vTRV5aJWeIjrQ2e5UasDltU05KtD9xSnq98FgURrOBsdaqMb4+nj
         KyDQUawpv9Av63U1LZOWVW4LFBu4YWr1/vqM9bMUoFhtSXn3NiPhgX2fyvlEfUmVw8eY
         rNdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WAn87zif05wzQ/mymNx3QqCaxERkvseXvbutVRgQtII=;
        b=Ir778+Zw4Bv0ojozDfngV7M2vdznB0aiv99w2PcQlVfUAIbD2OhVboBT811xFbjj+b
         S0T1KCiRRuycikk3Xx1AaJjKT4GkV6uT4D7+TKooy/XS7d8GguwUX9vizRzC8BH6j+6v
         dfnFcO+tuujtou31fhlcmP/FI/PciMHH8tdRiACj2O4SmZeQE4+HoFPM7+hieoRWYsMn
         bYIGUNHBA7vpQyvVWTSPbsBwLu7Bfbq7AQZ6ap7zYOyQwJA9NIxhBMghHJ4+C51OYUoI
         Mes0ZE9pLR0SX3auiW7HblhtSm8RjY4f3Z5DlkApdtOH2Rif2L3SiQZz7iTckcymZkDy
         c7PQ==
X-Gm-Message-State: AOAM530QZQWAFH11o7VsN7jNOYrJPj2bhyVPp5C0sjoT1g0DXMoV41xQ
        mv6XlcBSpbs9DXnca1eLUgeW29Q9xq6DmA==
X-Google-Smtp-Source: ABdhPJzRFv9VMJuBJYu+BhQmcHef7U3crRgHj3hcS1KAC/JTerOHVyTh8Kq8cpBV6/Y9TO4ynubnWQ==
X-Received: by 2002:adf:b359:: with SMTP id k25mr27168385wrd.98.1608687475347;
        Tue, 22 Dec 2020 17:37:55 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d191sm28492563wmd.24.2020.12.22.17.37.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Dec 2020 17:37:54 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 13/20] mktag: use puts(str) instead of printf("%s\n", str)
Date:   Wed, 23 Dec 2020 02:35:58 +0100
Message-Id: <20201223013606.7972-14-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201209200140.29425-1-avarab@gmail.com>
References: <20201209200140.29425-1-avarab@gmail.com>
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
index 97ca5f28b1..d89a3c201d 100644
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

