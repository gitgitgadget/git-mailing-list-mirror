Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 238EEC433F5
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:19:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 051B7610EA
	for <git@archiver.kernel.org>; Mon,  1 Nov 2021 19:19:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232596AbhKATVx (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Nov 2021 15:21:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232557AbhKATVp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 1 Nov 2021 15:21:45 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB2C2C061714
        for <git@vger.kernel.org>; Mon,  1 Nov 2021 12:19:11 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id u18so29607897wrg.5
        for <git@vger.kernel.org>; Mon, 01 Nov 2021 12:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GidmjIFNcP7j/e1ZPgu8nPlDBFhXnVItXLabv+APjnE=;
        b=Oivb+woXZzPxA7Mrc1c6eKeEMKeGd2oCA6CyDlmAiP8c8xbPUumYtw6OA7qqOSYqV6
         ZXX20p5lDmVy/akVd7VIGyBYtEYLSmgXhY+5sTIUbLmmR7dkNAil6bT+zIFzLXCmY1th
         QAQRaMLEUURql1B7816yn5YyeK6uO84b+ATsV296Fyu+es0aGuKyKrr7Ab9xiEZzF50N
         5dA6DB3DFKawZv0NKWNfBxalquDkvN8DC3FeIYf4PctSI0vxYh3SzAQfsgNB/TDzfKTf
         /UzA0PTjgzoopGmjZTmtj8YiBImJ4n8D9ekcZcEki2J/klm66MqIRCpRjDuZCvlSSWmC
         VKFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GidmjIFNcP7j/e1ZPgu8nPlDBFhXnVItXLabv+APjnE=;
        b=p22lyYojYPT03Tiey6xXbRp41vR5Tg/BrLDXAtZQDRozK4K455hmbYbae1KVJtY8nM
         81b07MAPFdkXcDIWnF3gIGuGz8OOIygqPJvXY820aTzUR6bo5qA+EXy1J5TBM9IcdnO5
         fcJvgSzA0C2CC0Gz75Bjaz6nvOs6KtLuVt9IrxYlHbvtnOBeX08O/amUDchXA2K4Aeqb
         Q+B0OUgBmK7XD5L0XMiXL1TIIFCnaeNsQ7Gpc/LB1j0WIxIkaI2h1vWeMODCbY5ycN+a
         eeJne8QzYkJHio6AzRRBUtjLHHNtM7wxXqlbz3SgyL+p3zhjQcHQ5yNhEU4Ft8CgkFzZ
         Xb0g==
X-Gm-Message-State: AOAM530LgTQ7EaDH8RX8dEwujt59xesf6NDxjd4G4ZzRoR19cc8LIf32
        VlLCRn0VIc6q0rFgJ1jy6Q+Rnd7vXYm6te5Y
X-Google-Smtp-Source: ABdhPJyZiKVoXBhxg38W4boQUx8CV3o3mojcgcWNFi2g4WFtHs/BQXTwRTyFXiZ99FenqmizPc/V0A==
X-Received: by 2002:a05:6000:2a3:: with SMTP id l3mr9332086wry.415.1635794350303;
        Mon, 01 Nov 2021 12:19:10 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v185sm339437wme.35.2021.11.01.12.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Nov 2021 12:19:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Paul Smith <paul@mad-scientist.net>,
        Sibi Siddharthan <sibisiddharthan.github@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] Makefile: add a utility to dump variables
Date:   Mon,  1 Nov 2021 20:19:03 +0100
Message-Id: <patch-v2-2.3-97738b056cf-20211101T191231Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1570.g069344fdd45
In-Reply-To: <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
References: <patch-1.1-bbacbed5c95-20211030T223011Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211101T191231Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add handy "print-var-%" and "print-list-%" targets, these can both be
used for ad-hoc debugging, and to integrate the Makefile into some
other build system which needs to extract information from it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Makefile b/Makefile
index 100658dfa43..4139bcf675c 100644
--- a/Makefile
+++ b/Makefile
@@ -590,6 +590,14 @@ TEST_OBJS =
 TEST_PROGRAMS_NEED_X =
 THIRD_PARTY_SOURCES =
 
+# Utility to dump whatever variables are defined here
+print-var-%:
+	@echo $($*)
+
+print-list-%:
+	@echo $* =
+	@for v in $($*); do echo $* += $$v; done
+
 # Having this variable in your environment would break pipelines because
 # you cause "cd" to echo its destination to stdout.  It can also take
 # scripts to unexpected places.  If you like CDPATH, define it for your
-- 
2.33.1.1570.g069344fdd45

