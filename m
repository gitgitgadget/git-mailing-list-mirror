Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12379C433E9
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B743023122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438083AbhALVhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436871AbhALUTh (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:37 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F32FFC0617A7
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:30 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id 91so3834327wrj.7
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Dj1Cbb2WzdiwGMOLPxlsdX0/nBb1sg62xe7BLduS/Gs=;
        b=dGgp6RB9diTuIzEoERtegrVXxZ7psZhuva9zDAsskj+AOyx103qtrBx9wXvVdYUOxA
         Aygy5omzgM0WhoAqLHkPCS0+47Zkb2B64FjSq76dMkSAMXbMZxFLAGVnBvE8Qev6n3GO
         N0BAUiQeFFGt33yx5NSJnFW1QSrtOn45Fuxl/0DhW8GMSzsNUD1SQ7wrKSOl5XtXJNiU
         8DHSSgqO4CyeUf2gA/fCtG5Caw0zTDLXhmCsXm9QKApiA5oSX1Zi5J3gehFvcklATEV2
         7gZ3cKT83E4wlgl9NjhzkBWW12QWIy0LPSd9tVNQOyleYMwDdhy5zWOaSTniq1+yHQ/E
         2zHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Dj1Cbb2WzdiwGMOLPxlsdX0/nBb1sg62xe7BLduS/Gs=;
        b=rXIeMUIIn54PpJXA6tW/ryeNWA+uTCA7yZLK7OGSz/Fb77reMEb4WHyoeikaV8awdN
         SIDrFC/gqA1aBKSJejnulj5SW3bNmVobwSwzS8jfr8EGba3sadPSIdfIc74sOcRFcCCL
         zdV1BvSV2xNZynPFe0nAT1irc6TWMVeByf/E5GKDKNdFG018yWcC17QJO3a7BcjU302m
         jZy8QjE69vOppdNGRx2L1/YOuNgRRMzFBxBXtOvJTZhs32CGQtr4tzpYaKemLgwo+3Bc
         0XPFeql2l1tbWiPYBBltSIXeUdItgtko2JPFdSIUdvkebrw7lG2gObwrQi+MorJ0jsic
         s+0Q==
X-Gm-Message-State: AOAM5320Ah1RvBohh2CaoCTczkwUsrLQsdtS9JMVW3Q1hMYbOL/RXUSk
        n1ouaMW5he77vfCUoLAKEUptpCJlJ2bUkw==
X-Google-Smtp-Source: ABdhPJwLStk12N2WMF2tduCM/kH+SCjWbfz33TlT3HKzKXVJhTbXyoyIVS5pYnUxuJqrMZemSxywxg==
X-Received: by 2002:adf:c18d:: with SMTP id x13mr552781wre.128.1610482709521;
        Tue, 12 Jan 2021 12:18:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/22] mailmap tests: add a test for "not a blob" error
Date:   Tue, 12 Jan 2021 21:17:53 +0100
Message-Id: <20210112201806.13284-10-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for one of the error conditions added in
938a60d64f (mailmap: clean up read_mailmap error handling,
2012-12-12).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index 03a98d9635..78d56e0566 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -333,6 +333,15 @@ test_expect_success 'mailmap.blob can be missing' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mailmap.blob might be the wrong type' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
+
+	git -c mailmap.blob=HEAD: shortlog HEAD >actual 2>err &&
+	test_i18ngrep "mailmap is not a blob" err &&
+	test_cmp expect actual
+'
+
 test_expect_success 'mailmap.blob defaults to off in non-bare repo' '
 	git init non-bare &&
 	(
-- 
2.29.2.222.g5d2a92d10f8

