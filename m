Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B20CF1F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727604AbfENSsK (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:10 -0400
Received: from mail-yw1-f65.google.com ([209.85.161.65]:36067 "EHLO
        mail-yw1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727599AbfENSsJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:09 -0400
Received: by mail-yw1-f65.google.com with SMTP id q185so207232ywe.3
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EGsmOKPIL5P0IKvn2T3Nwt3q7pHwGfvyAH8FIELiDbU=;
        b=LxaNeJSOhkxTvq7pyLzoTdlrJP6hKsKDzxBcFPR23T1+2p7/eGkfqaw1Vnh++In8X5
         vWSjl5sZjTV9FlQU+Ux2LWPG5FXfoYbNaXCDnPOx7N3WWnYbA1YnbO06w8Mx9bc92Pm8
         hE/yzMmLE4fuVKg+OQSDL2mK0Wm0bJdWm75HroZoFm8JYBpZVlOxWij5UgQutTje7FEN
         cESIB4OmRTqrVMlEvXaqQrprf+3FbTVV8wb6q4ipA1Zv9qyD1cKzh5qngMdVkohhaRxc
         xrLCkP1XKcO3gMjXnDY+FJO8gOKiLoMWbrAgPVNZN/ZYMVC+poHmThUSNwruRsLuyie/
         JWUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EGsmOKPIL5P0IKvn2T3Nwt3q7pHwGfvyAH8FIELiDbU=;
        b=DugfYExAv7wcFlVTLeUaODMMmz8oJI0WfIXuMn+iandIC2d6rFALFalUcqg/vbgSlw
         P1L/PiFV1/5I553DU53IJ+BNCPmCbNz+Z+ORq5REpIABV3V3qmT/hTFM1zPGukWQZyMd
         Tc4PL2jGHvSY+uplcaGtUbWsFRGXtgMcGwTYEK8LdLW8AAyE/iQfBMcH2xH82+O2X/II
         mVPgqXcFE9lSBWZgC7VVhQRoz0r3fwfuziuzEyRynSPJ7tXOZiQLs5ESfVn8Drn5iOyz
         qnuKvxtacCAqaU1XW0DARrmr8ejTMBw3023U9U+rFocl6SCgD3fLZjzhU9aewXSNxN6t
         HS6A==
X-Gm-Message-State: APjAAAUNl6o29VvW2HOkH0c+cLlULcw/a5pVFZe+XE7sB38aEVXLfqJ3
        BqOtcgnMvSXK0adMTiHeuEtyd5wxLeo=
X-Google-Smtp-Source: APXvYqwOP0RqUkPJWFUjOOF9FeJ39LbSwNY4kKgIDEtib8gr8GnMBxEviwBXWYo3K/ZJcEIqBquLiA==
X-Received: by 2002:a0d:dd8c:: with SMTP id g134mr18581807ywe.84.1557859688274;
        Tue, 14 May 2019 11:48:08 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.48.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:48:07 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 09/11] multi-pack-index: test expire while adding packs
Date:   Tue, 14 May 2019 18:47:52 +0000
Message-Id: <20190514184754.3196-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

During development of the multi-pack-index expire subcommand, a
version went out that improperly computed the pack order if a new
pack was introduced while other packs were being removed. Part of
the subtlety of the bug involved the new pack being placed before
other packs that already existed in the multi-pack-index.

Add a test to t5319-multi-pack-index.sh that catches this issue.
The test adds new packs that cause another pack to be expired, and
creates new packs that are lexicographically sorted before and
after the existing packs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t5319-multi-pack-index.sh | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 6e47e5d0b2..8e04ce2821 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -478,4 +478,36 @@ test_expect_success 'expire removes repacked packs' '
 	)
 '
 
+test_expect_success 'expire works when adding new packs' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/A
+		^refs/heads/B
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/B
+		^refs/heads/C
+		EOF
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/C
+		^refs/heads/D
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/a-pack <<-EOF &&
+		refs/heads/D
+		^refs/heads/E
+		EOF
+		git multi-pack-index write &&
+		git pack-objects --revs .git/objects/pack/z-pack <<-EOF &&
+		refs/heads/E
+		EOF
+		git multi-pack-index expire &&
+		ls .git/objects/pack/ | grep idx >expect &&
+		test-tool read-midx .git/objects | grep idx >actual &&
+		test_cmp expect actual &&
+		git multi-pack-index verify
+	)
+'
+
 test_done
-- 
2.22.0.rc0

