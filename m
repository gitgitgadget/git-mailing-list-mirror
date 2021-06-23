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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328A7C49EA5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1ABAA611C1
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 17:48:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbhFWRvI (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 13:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229916AbhFWRuz (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 13:50:55 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49333C061760
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:37 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id f16-20020a05600c1550b02901b00c1be4abso4530070wmg.2
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 10:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4SHIst7Nvi43yv3p56yqhdJAVTZm8P3l7rVrJAktOlA=;
        b=k24hrVkbHCUrpPh8eqleJ8zUPX+EoWErZhXZ3qkinbTQ5eyY1BtwucCAcsmG5OLoxP
         rWPrVaB8rjdcy7qYYNXW7UodFdfThTI6aVU0tEe+DHt6U+jkEBUVb/bUSe9uYeXnQUcV
         5Qd9xJ5eww9xbYkhtPndSXYn1QAeqBGlI+oIsludja/qHlkEcutZywHWmvqtrwcMB32e
         hrmOaDqoakTRgFpq3nTxTN8hhVli3p0xbP8vqPrenzA5yBUdQ2O2zCJhZ089PSpoCSy2
         +xPMEv3qKYv0Yk5RMweHf8oWgt9Bb2WLkG+LvKuNhy8nbMQvO6e2mQ/DNSZ9MRVzThDf
         1SCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4SHIst7Nvi43yv3p56yqhdJAVTZm8P3l7rVrJAktOlA=;
        b=tAWaCoHuovZtp984p8Im5yN2oFetcJuuTTVo6f89D5lANQKZ2uyJ4Ebj5FifcywBm1
         PGzDlCPh7Q0/e873Jcu2fXMx6ZrcepxU2aF6ZN/cXzJYzybgc8BaIXevLAPIBkq95JKy
         SK14qrlanfOQOkDT6Tl+07TTGCYNqdy7e6YMhORPScjAXClbQ+p9g//leRHd7Xc8invV
         xPrMqt3AQ2nIl+pVw3LAecXxfIkJFTo82HchDG3ntyHytqq0ckTEfdvVvaK7B0AmxmiF
         cS6iEA0Pfsxcldu2PW2IQ+qt2R5vtz3Lh41GJ+A58tzk0qjmPyN/h1uwEcfHNcV0OXm1
         J2tQ==
X-Gm-Message-State: AOAM530g/XxMlMQexDHzesr9qKtbrvnRBkhsaaySpQ2UcaKgMaOlM23a
        gfCHSLKhxUUEW0wYKOIeZx9hDgK2WCkGsg==
X-Google-Smtp-Source: ABdhPJwTkxn/hi4GM/eg7u2e7cft3vUAkdvpFMrCq3roVB+sMI6C7wXfJ31WVwYUYS1AzlIYtmFPUA==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr1103158wmq.12.1624470515663;
        Wed, 23 Jun 2021 10:48:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x25sm6678281wmj.23.2021.06.23.10.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Jun 2021 10:48:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/25] midx perf: add a perf test for multi-pack-index
Date:   Wed, 23 Jun 2021 19:48:09 +0200
Message-Id: <patch-09.25-c7a51927cad-20210623T155626Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.599.g3967b4fa4ac
In-Reply-To: <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
References: <YNKWsTsQgB2Ijxu7@nand.local> <cover-00.25-00000000000-20210623T155626Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a basic write and verify performance test for the multi-pack-index
command.

The reason for doing the "write" also in a "test_expect_success" is to
be friendly to skipping the "write" test as a perf test (which would
run N times) but still being guaranteed to have a midx to verify by
the time we get to the "verify" test.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/perf/p5319-multi-pack-index.sh | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)
 create mode 100755 t/perf/p5319-multi-pack-index.sh

diff --git a/t/perf/p5319-multi-pack-index.sh b/t/perf/p5319-multi-pack-index.sh
new file mode 100755
index 00000000000..39769602ab7
--- /dev/null
+++ b/t/perf/p5319-multi-pack-index.sh
@@ -0,0 +1,21 @@
+#!/bin/sh
+
+test_description='Test midx performance'
+
+. ./perf-lib.sh
+
+test_perf_large_repo
+
+test_expect_success 'setup multi-pack-index' '
+	git multi-pack-index write
+'
+
+test_perf 'midx write' '
+	git multi-pack-index write
+'
+
+test_perf 'midx verify' '
+	git multi-pack-index verify
+'
+
+test_done
-- 
2.32.0.599.g3967b4fa4ac

