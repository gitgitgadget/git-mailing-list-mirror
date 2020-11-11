Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E729C388F9
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 09:54:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BADE820729
	for <git@archiver.kernel.org>; Wed, 11 Nov 2020 09:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SmjBm8OQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727265AbgKKJyi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Nov 2020 04:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgKKJyh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Nov 2020 04:54:37 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF42EC0613D1
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 01:54:35 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id h2so1695694wmm.0
        for <git@vger.kernel.org>; Wed, 11 Nov 2020 01:54:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=b08tbApdHqoPqdxPbXMeOE5JK97Y6rlefkNf5M5K/Os=;
        b=SmjBm8OQm/WORi0kn2mLSXlUM8n23ntjj++UBzVpUqi+X30apgngI+EE8QDUxnwgWi
         WtIqJUf0XOsrsnd6NCuGZQTYnKTlKJ5HMti25FHkF02+HIVOMZsbajFD/6uPNCJUKi7z
         QELeToRZ7584XkMB52EUCOqqnWSAp+b07WP3zekwmHaXYxThwNvYyvnlWR+WUCUtCBho
         /59tjUnX7FGjpS8v494AVL0TkclJaFQxyfnZ7iTE4hygSmMI5JTtW4O78l80w+2gWWoy
         DqaGVoiBilqonn8+YnRzbENXVWGDo33kO8PAtBg4+4YC2niW36PlmPoJISzamfl0y7UX
         4gcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=b08tbApdHqoPqdxPbXMeOE5JK97Y6rlefkNf5M5K/Os=;
        b=DeC//7t+kZLqm0x5fb7JTfCUp3jKoTPAW30uBncZeiwh0qcz7oCinh2PfsXKo5ag3b
         3/G1omPZYlV0vOvEbipwXd7xWCJt4AXLMJLWm8VuLF0O6aM8C9ioIw8morTIfGu+rGD/
         RP0hznYLPEEOgoTJa2npYrttP82/pNzmO8uqu8rdlVC7IXD0DvhS7TKeg3EZrUtk5EJ8
         Q5m1SdO4qHnfqRnPkG3ERJ17mP8QXCq3xmobo4kamnSPlCssuKa/ZbNoS4LfAeVatvu4
         SdYaD7ehJWk5AxkpkYpak2kMEgX/NHlQTJGBmMJ1lbXL6CYjqnGDNyfAIuR4B7ULiq6q
         0dTQ==
X-Gm-Message-State: AOAM53048bh/XwhCbtQntw5HxcVIxRZ4MOMSs70kZ4ZGQZxegztcGpmG
        Vk52b7Mg/eDwDyaFz8XB1o3GqQ1vk971GA==
X-Google-Smtp-Source: ABdhPJyk71SdDvhCZLlHiJW5FCHxvaZcU17NqUKd6ogcJQffptnQSKx0ubJTbH8Uw56sO+8uCYRndQ==
X-Received: by 2002:a7b:c201:: with SMTP id x1mr3066637wmi.42.1605088474344;
        Wed, 11 Nov 2020 01:54:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g131sm1983374wma.35.2020.11.11.01.54.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2020 01:54:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        James Knight <james.d.knight@live.com>,
        "Randall S . Becker" <randall.becker@nexbridge.ca>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] config.mak.uname: remove unused the NO_R_TO_GCC_LINKER flag
Date:   Wed, 11 Nov 2020 10:54:19 +0100
Message-Id: <20201111095420.1446-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201111095420.1446-1-avarab@gmail.com>
References: <20201111095420.1446-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The NO_R_TO_GCC_LINKER flag was still being on some platforms. It
hasn't been used since my 0f50c8e32c8 ("Makefile: remove the
NO_R_TO_GCC_LINKER flag", 2019-05-17).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 config.mak.uname | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/config.mak.uname b/config.mak.uname
index c7eba69e54e..8d7b96f8b9b 100644
--- a/config.mak.uname
+++ b/config.mak.uname
@@ -636,7 +636,6 @@ ifneq (,$(wildcard ../THIS_IS_MSYSGIT))
 	prefix =
 	INSTALL = /bin/install
 	EXTLIBS += /mingw/lib/libz.a
-	NO_R_TO_GCC_LINKER = YesPlease
 	INTERNAL_QSORT = YesPlease
 	HAVE_LIBCHARSET_H = YesPlease
 	NO_GETTEXT = YesPlease
@@ -669,7 +668,6 @@ else
 			-fstack-protector-strong
 		EXTLIBS += -lntdll
 		INSTALL = /bin/install
-		NO_R_TO_GCC_LINKER = YesPlease
 		INTERNAL_QSORT = YesPlease
 		HAVE_LIBCHARSET_H = YesPlease
 		NO_GETTEXT =
@@ -695,7 +693,6 @@ ifeq ($(uname_S),QNX)
 	NO_MKDTEMP = YesPlease
 	NO_NSEC = YesPlease
 	NO_PTHREADS = YesPlease
-	NO_R_TO_GCC_LINKER = YesPlease
 	NO_STRCASESTR = YesPlease
 	NO_STRLCPY = YesPlease
 endif
-- 
2.29.2.222.g5d2a92d10f8

