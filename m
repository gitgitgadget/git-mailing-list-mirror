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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65BE9C433ED
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 25F9C613C5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:22:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231393AbhDTMWl (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:22:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbhDTMWl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:22:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 991EBC06174A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:09 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id k26so20969629wrc.8
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9Zt4mTy7ptiU6X+xKENr0MX+oJpAnPVNmt7f8N0ZNKo=;
        b=lXB+zb45eMLmnbnuCOgGJncZFR0LLlcsrfk2+qcZfCsnC7YqC3ZEyFyXT4UKfZfw4K
         vHGeUPyotEnEXc17kiNEb95CmKofJTtRh9NlV1OENm/yYY41yEradAfQvMuOXpiflTVV
         mstzbTth2Xn0iXp1Ek+j5hakDBcs1D7kslLGFSXq2/l8+Eme+Pg/alJUbDEI+E3948Ps
         5hEIDPXTU5YCMvQrJwhq4FmiUAMnkgBVXHYhlKBTP6yg+s4i4TRTFpnGQOuColJuuDNf
         D0fHOUmABe9hz6mYUdIX/xZ2Q2IsDCzxtkqb+L1w7HU0jjvCZYbrftOI212GonJ+0r3+
         xr0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9Zt4mTy7ptiU6X+xKENr0MX+oJpAnPVNmt7f8N0ZNKo=;
        b=Fg/Z9usYzGIF1500DkqhVpNZRQmt5cEZy/YNcNQ4Yt4WKzvIaWj8M4I9wTcq9StgOd
         P3Rdc8hpkzsfYZpVEXZ9+TOVGKw4tqju7mIFdiBA6qKFPbftEnVidtcglikkk/RTN8VV
         H68DLpfbs9Qlb0TvP7Tjzhflgo6MvrPcKfw7p5ErThXhpUc69/cC34WFZXg/o0ARy+f/
         /RN0JJSNDnp0Oi1nDmoFnWeyCwDoWr4aHEUqYEF5qgEDbE1UpPoYHvcRDBxaO4vxlugU
         HQI7nv+pN9epUNNaHY+CO2n+rOYq1oOFiqbUQ7axc52fuwmlm+uJUGBUGVphQVNxZKCi
         xQiA==
X-Gm-Message-State: AOAM5301weAA9bcQs5mEi2SDoyuqhYtMu4ZMrpk+/rfSYD4dBtDBxE6q
        tvBpqNO2iUytyKsFXK4FlTRwvi11vpaVGA==
X-Google-Smtp-Source: ABdhPJz0ZxQymGQmdEzsWaB34XLU9vdA1ehd2KUX33xLIcTeiR2frsaJ+XLdLf4Vl3owKSBEwKVLFQ==
X-Received: by 2002:adf:e7c2:: with SMTP id e2mr20965607wrn.248.1618921328082;
        Tue, 20 Apr 2021 05:22:08 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm30541768wru.90.2021.04.20.05.22.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:22:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Matthieu Moy <git@matthieu-moy.fr>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/12] check-non-portable-shell: check for "test <cond> -a/-o <cond>"
Date:   Tue, 20 Apr 2021 14:21:52 +0200
Message-Id: <patch-01.12-a8b483bc77-20210420T121833Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.gf6bad1b9ba1
In-Reply-To: <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210417T124424Z-avarab@gmail.com> <cover-00.12-0000000000-20210420T121833Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a check for -a/-o in "test", as a follow-up to the
CodingGuidelines having recommended against their use since
897f964c0dc (CodingGuidelines: avoid "test <cond> -a/-o <cond>",
2014-05-20).

These constructs are considered obsolescent by POSIX[1]. GNU has
likewise warned against them[2] for a few decades.

These will only match the simplistic forms of `test -X blah` (where
"-X" is some single letter option), but will miss expressions such as
`test "$foo" = bar`. We stop at "&" or "|" to try not to overmatch
things like:

    test whatever && ls -a foo
    test whatever && foo -o outfile

1. https://pubs.opengroup.org/onlinepubs/9699919799/utilities/test.html#tag_20_128_16
2. https://www.gnu.org/savannah-checkouts/gnu/autoconf/manual/autoconf-2.70/html_node/Limitations-of-Builtins.html

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/check-non-portable-shell.pl | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/check-non-portable-shell.pl b/t/check-non-portable-shell.pl
index fd3303552b..894aa0a4f9 100755
--- a/t/check-non-portable-shell.pl
+++ b/t/check-non-portable-shell.pl
@@ -41,6 +41,8 @@ sub err {
 	/^\s*declare\s+/ and err 'arrays/declare not portable';
 	/^\s*[^#]\s*which\s/ and err 'which is not portable (use type)';
 	/\btest\s+[^=]*==/ and err '"test a == b" is not portable (use =)';
+	/\btest\s+-[a-z]\s+[^&|]+\s+-a\s+/ and err '"test A && test B" preferred to "test A -a B"';
+	/\btest\s+-[a-z]\s+[^&|]+\s+-o\s+/ and err '"test A || test B" preferred to "test A -o B"';
 	/\bwc -l.*"\s*=/ and err '`"$(wc -l)"` is not portable (use test_line_count)';
 	/\bhead\s+-c\b/ and err 'head -c is not portable (use test_copy_bytes BYTES <file >out)';
 	/(?:\$\(seq|^\s*seq\b)/ and err 'seq is not portable (use test_seq)';
-- 
2.31.1.723.gf6bad1b9ba1

