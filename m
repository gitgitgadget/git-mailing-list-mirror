Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E721EC433EF
	for <git@archiver.kernel.org>; Thu, 27 Jan 2022 11:56:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240945AbiA0L4v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 27 Jan 2022 06:56:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240926AbiA0L4n (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jan 2022 06:56:43 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31D9AC06173B
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:43 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id l25so4239391wrb.13
        for <git@vger.kernel.org>; Thu, 27 Jan 2022 03:56:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Wt3robNpnb4+HD1ub9ElFGfPODrIvq0Oz10+w4tO1zQ=;
        b=RVTbLujsNN3VZbxcBXhdbZheA/zyM81wSFqhzlhg7t17D1jlnHWJWbteXfyvrcfR2Q
         qXpDUiYaknzy0VrfL1TSUZcwktBXvUbf5axbSsKdV6Kn9W9KqRWRYGaEcx8ZoDhMRqy0
         5Kidvy0KqbyslpYy6GuSHU5ucKwwg3UySSpy+z304Ksim1wN/wFJhV2l2L5ySZRHb4Bm
         Hp2KrvL38Xwrv5y88R6hxZsQNa3sdt2Higt95YER8r0x0D8ouQrmxMbCmNFWJ0bP3Cz3
         LY8FE1n67wiJNmrMr2F1Huo5ldqMZcy1Lc7pBZqfq5EpNeya+hmkIaoqhUHXf6d2V1ET
         vcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Wt3robNpnb4+HD1ub9ElFGfPODrIvq0Oz10+w4tO1zQ=;
        b=n4eVW/TsJ4lJx5Rhkq/IgV/Dtf0VCdWTYHBDdDvwCroDPGpZTq0sibkOoSQw4sRMKB
         QSFQ7AmPIOkQkDMf063vRzNb/Pag4Dr9QMTfWpCdIJj/XVN7fROBJ4GyAFiaisGDCWMj
         5HI//ePDX05HaxLwiEk84szShi+S1WfygC+hT3BE2/Rkuhf8DYB/c8gR6/BBMTFA0aek
         lyhkSVdYijqnjmnO1UVB92+5hQ2y0APq9cDmdm2TViCfbP+2jzlwV+bmZwoFfmIZGfp+
         0HhMG7AChcTjc8QQQe71dMlJXsmIMJdEugxb/uVXJCjv3b/jB+wCLHiLEgGV52boNyUn
         vNiA==
X-Gm-Message-State: AOAM532YLuWcoNgaA20uVzTXHA2e67ncVI7KN4nXaSXJFNmInfBNbzbR
        SDKlm1lCz6VvrZKpZUZq+aes3pAtcTRqlA==
X-Google-Smtp-Source: ABdhPJw9746/rE0UKF9k/XCorOT+PlBm6YdMab2cwvGJCRt9ZL0DUrCUm+z9pF9k51GgAP4K9r0Xqg==
X-Received: by 2002:adf:908f:: with SMTP id i15mr2961670wri.256.1643284601581;
        Thu, 27 Jan 2022 03:56:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i94sm1910663wri.21.2022.01.27.03.56.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 03:56:40 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, J Smith <dark.panda@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 7/9] grep.h: make "grep_opt.pattern_type_option" use its enum
Date:   Thu, 27 Jan 2022 12:56:29 +0100
Message-Id: <patch-v9-7.9-e09616056b4-20220127T115058Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.894.g563b84683b9
In-Reply-To: <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
References: <cover-v8-00.10-00000000000-20220118T155211Z-avarab@gmail.com> <cover-v9-0.9-00000000000-20220127T115058Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "pattern_type_option" member of "struct grep_opt" to use
the enum type we use for it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 grep.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/grep.h b/grep.h
index 3112d1c2a38..89a2ce51130 100644
--- a/grep.h
+++ b/grep.h
@@ -164,7 +164,7 @@ struct grep_opt {
 	int funcname;
 	int funcbody;
 	int extended_regexp_option;
-	int pattern_type_option;
+	enum grep_pattern_type pattern_type_option;
 	int ignore_locale;
 	char colors[NR_GREP_COLORS][COLOR_MAXLEN];
 	unsigned pre_context;
-- 
2.35.0.894.g563b84683b9

