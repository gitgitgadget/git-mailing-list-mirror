Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E72ADC433FE
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 09:33:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiBXJeE (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 04:34:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232773AbiBXJdu (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 04:33:50 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 750EE26A38F
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:20 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id j22so1951576wrb.13
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 01:33:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Tv7US9ezN+TjDoLv6WRI3hm7Ci2ArAafugL/zO2pNwg=;
        b=Z4AAQLXS/a+Z/D38MlUiHv7HvpsJjdRrucHtFRVYBN8qVtEJg60M5VvXYh4aKzhuco
         IC6LWcfUMDdvIHF86ghUzBm2hTxukmS09AvVDqwukFYehZRHpkmflWqndTLn/RkkO2Eo
         AKzgbJLjSYkfo/1cB5oFVBltAaTGrr5jzbxRWsNN2La+T5fxKwIDBWNTi19GYQ0nUKQl
         jwRJgwDEytpvbwQGkqeK6oCITQbnrq6pBGSTpTOvzgqf/bZNWzwrghWDfo0WbdD4m+ht
         syNWLCKRjROcmGEFx/axbSxLmuS7vqbuz8+tl8Jw71lKatuGohKse12wzxh/Edl0xaZW
         LKfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Tv7US9ezN+TjDoLv6WRI3hm7Ci2ArAafugL/zO2pNwg=;
        b=7HrkZZOu9zEwoqmwMlbAJ4GRrwYnPZEwhg9xoDSA0/aZ8mQPgGooZ5EKuuzqkZVPrv
         f9xccreYBHLVEN0e09e1l+5c/T8EsRuXn+HamNE+Qgmz+uADIF0YjGpnQGVDrsT7jThl
         2Aa7nA/rcsIDyT45o1Cc2u9GfmXCeNgkh9xzIBKppU5nztt3MtO84vff++Su1yjiHmnf
         u5hcYOZt1P/KdS0z3J3Z0elGq8LTvdjBTLPYH5Tx1MPWLpNEb+lg2zeAfIGi7C2YYjLN
         5xgepZvwmMVmQRy3FW9oXGIy0QMvXiapMNxnIHpxHdUcxTTV5WQE2v+qmSv0tupZiZYN
         mBow==
X-Gm-Message-State: AOAM5335TLCl+BMT9QNNtzAB0+S9D7yQlEfbSTRzWLvvW3y/r3EE3+Sb
        o0IoCF/Flusd4YMgoGb/8H0U8l5CoUGcAA==
X-Google-Smtp-Source: ABdhPJy5ZAOBKEIyTFw8Ke8w/pT5IgBr6DeyRi/d9pkEJIy28VMABxy/k02sd3qOftCABFzzh+gRJA==
X-Received: by 2002:a5d:6d0c:0:b0:1ea:9ac5:7848 with SMTP id e12-20020a5d6d0c000000b001ea9ac57848mr1473146wrq.185.1645695198763;
        Thu, 24 Feb 2022 01:33:18 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id q13sm2109742wrd.78.2022.02.24.01.33.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Feb 2022 01:33:18 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 09/12] convert.c: use designated initializers for "struct stream_filter*"
Date:   Thu, 24 Feb 2022 10:33:04 +0100
Message-Id: <patch-09.12-5ad9f535f18-20220224T092805Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1157.g524e2d5a0db
In-Reply-To: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20220224T092805Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the "struct stream_filter_vtbl" and "struct stream_filter"
assignments in convert.c to use designated initializers.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 convert.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/convert.c b/convert.c
index df7186bd813..3d53a75a784 100644
--- a/convert.c
+++ b/convert.c
@@ -1574,12 +1574,12 @@ static void null_free_fn(struct stream_filter *filter)
 }
 
 static struct stream_filter_vtbl null_vtbl = {
-	null_filter_fn,
-	null_free_fn,
+	.filter = null_filter_fn,
+	.free = null_free_fn,
 };
 
 static struct stream_filter null_filter_singleton = {
-	&null_vtbl,
+	.vtbl = &null_vtbl,
 };
 
 int is_null_stream_filter(struct stream_filter *filter)
@@ -1683,8 +1683,8 @@ static void lf_to_crlf_free_fn(struct stream_filter *filter)
 }
 
 static struct stream_filter_vtbl lf_to_crlf_vtbl = {
-	lf_to_crlf_filter_fn,
-	lf_to_crlf_free_fn,
+	.filter = lf_to_crlf_filter_fn,
+	.free = lf_to_crlf_free_fn,
 };
 
 static struct stream_filter *lf_to_crlf_filter(void)
@@ -1779,8 +1779,8 @@ static void cascade_free_fn(struct stream_filter *filter)
 }
 
 static struct stream_filter_vtbl cascade_vtbl = {
-	cascade_filter_fn,
-	cascade_free_fn,
+	.filter = cascade_filter_fn,
+	.free = cascade_free_fn,
 };
 
 static struct stream_filter *cascade_filter(struct stream_filter *one,
@@ -1931,8 +1931,8 @@ static void ident_free_fn(struct stream_filter *filter)
 }
 
 static struct stream_filter_vtbl ident_vtbl = {
-	ident_filter_fn,
-	ident_free_fn,
+	.filter = ident_filter_fn,
+	.free = ident_free_fn,
 };
 
 static struct stream_filter *ident_filter(const struct object_id *oid)
-- 
2.35.1.1157.g524e2d5a0db

