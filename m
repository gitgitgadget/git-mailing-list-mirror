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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E3DAC432C3
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5D1C23122
	for <git@archiver.kernel.org>; Tue, 12 Jan 2021 21:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438088AbhALVhY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Jan 2021 16:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436875AbhALUTi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Jan 2021 15:19:38 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28096C0617AA
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:34 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id c5so3842364wrp.6
        for <git@vger.kernel.org>; Tue, 12 Jan 2021 12:18:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4sXaunXpiEs9/dvTUkulS/Q647AX0OJ89L8T2tHibYw=;
        b=QGxxoyHElVbgUxwtCG8P+WuOH74nB9Kb5eDVUnRlc6yTXwyEnZQUgw0XGClAqfyBGw
         d8jVeMHZR7SgZi2BwOMIdeTCSHU2N+bq/16vMRpc4HDS6EeZ8Idz0jah5iBdnhr8qk/X
         26r977P7r2UIZOKie++8sx+Gq3Rh1nzzGmZ7DX7J9OXf4KmvrY4n5/70PpNHPgqDl0uV
         +y8vevLsUE4W0WWxov+nkn7Rt5ZfqBC+/pviu+QJk2kS/u2+uTFVXy6C33igz3d5o91O
         pvM74QcRwOMZfdJG6FDWeXn2iDhwLZYSeUNoHAT2RnFtj4qcUB4JSY79Cjg4c7A03t4X
         QNAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4sXaunXpiEs9/dvTUkulS/Q647AX0OJ89L8T2tHibYw=;
        b=bMYmLKYjlsSTdTLWdrTIOCQfuzrS1hBohUXxtZWmFADQpFO/clnxzO5ZbVC9KKUrSV
         lrwShPsGZCY9Y0XfCmtRLCWuHv/Olmvnp1yXm40k2TvNoIj8Njc7jPPGS8sof2zs4B+j
         y1Cc6jpmEx+YCAEcwqKQdS8sVYaa5Lj7NfOX+DH4OFFJE7ptKezISfwkCe9mCGYe6Vr2
         Y1exb4imruT2cRpqQ43WuKnria8JMrP1GCDpFYTIAWfJl79tZZ2WiEavO1aYONZiQcnK
         F+ort2utn7mM1yB8F3Gw57mR+mkKJU2RGbcjQqUziNZnVo2ruxn+cYbCiq7keZo49SSn
         Yv0g==
X-Gm-Message-State: AOAM530to3jqWAswEcGW34p6vCoBWctKaqYTWcc8UR3R6Q7HprZJ0FCs
        DbsElx2F9PiVKPxPIRysiPPDr0KrpR6I8A==
X-Google-Smtp-Source: ABdhPJxHJXSwfiRPFhJGR+18DUS/dayZFs2pU5cqCIgi9C8kJZZXF0XBgZEcNS9OMFdGhZgDNMQFHg==
X-Received: by 2002:adf:db44:: with SMTP id f4mr526312wrj.169.1610482712638;
        Tue, 12 Jan 2021 12:18:32 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c10sm7095374wrb.92.2021.01.12.12.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Jan 2021 12:18:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/22] mailmap: test for silent exiting on missing file/blob
Date:   Tue, 12 Jan 2021 21:17:55 +0100
Message-Id: <20210112201806.13284-12-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210105130359.21139-1-avarab@gmail.com>
References: <20210105130359.21139-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

That we silently ignore missing mailmap.file or mailmap.blob values is
intentional. See 938a60d64f (mailmap: clean up read_mailmap error
handling, 2012-12-12). However, nothing tested for this. Let's do that
by checking that stderr is empty in those cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4203-mailmap.sh | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index a42b454756..2b342d7f7c 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -309,6 +309,24 @@ test_expect_success 'mailmap.file overrides mailmap.blob' '
 	test_cmp expect actual
 '
 
+test_expect_success 'mailmap.file can be missing' '
+	test_when_finished "rm .mailmap" &&
+	cp default.map .mailmap &&
+
+	test_config mailmap.file nonexistent &&
+	cat >expect <<-\EOF &&
+	Repo Guy (1):
+	      initial
+
+	nick1 (1):
+	      second
+
+	EOF
+	git shortlog HEAD >actual 2>err &&
+	test_must_be_empty err &&
+	test_cmp expect actual
+'
+
 test_expect_success 'mailmap.blob can be missing' '
 	test_when_finished "rm .mailmap" &&
 	cp default.map .mailmap &&
@@ -321,7 +339,8 @@ test_expect_success 'mailmap.blob can be missing' '
 	      second
 
 	EOF
-	git -c mailmap.blob=map:nonexistent shortlog HEAD >actual &&
+	git -c mailmap.blob=map:nonexistent shortlog HEAD >actual 2>err &&
+	test_must_be_empty err &&
 	test_cmp expect actual
 '
 
-- 
2.29.2.222.g5d2a92d10f8

