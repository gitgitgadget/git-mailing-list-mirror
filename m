Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D132FC43217
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 19:19:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbhLITXb (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 14:23:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbhLITX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 14:23:26 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F249C061D76
        for <git@vger.kernel.org>; Thu,  9 Dec 2021 11:19:41 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id g191-20020a1c9dc8000000b0032fbf912885so4899678wme.4
        for <git@vger.kernel.org>; Thu, 09 Dec 2021 11:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oMfFgikx2r76Wkr0fNEgQzdwiZtpZrjZUSMyPQhhh4Y=;
        b=FFquYVNL1GYWWobZAeku26zDK58q2jPlgriMotYBpoBAgwpYLQJse4GSSDBIK54ZD2
         JKzy1DtMrh4UFEVQqkEcmTIuwfCZ/gimk1yqb4j7q5BGkVJH4Pn1fRVhty+h4ORTYoH6
         5r1WBbX+R72Y4M3mDLuSXTWU6v1G7jSdg5LOJGU1WQvtC01Mh+rhDyhWxDhjy0Q8j3L9
         LqQKHbG5GxdBToX0+atVWOTu5neOErJssfC+Of2XwnCC+IVa4eO3wJGk7anQcWBYk3p9
         mJlAM+x1eTFDNrsavxIT8NkHPJ6mrfRX1ENc0Fq5wz4YmC7TTJs7WfhxhNeHrqT0HtFh
         VNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oMfFgikx2r76Wkr0fNEgQzdwiZtpZrjZUSMyPQhhh4Y=;
        b=bdOzOsdN0B9/gAEm7lx9amTyfObGEFqK4x9rkflBPq7jMlGrlIgF7ZYEXpk4Eb5yg5
         ogTz6F70O3ZDPtcZSUSUcbkQa3xlo/QTaraEI3TzBacq2zw07Z+R3M+fGILGuqen8QDr
         OmwybrC/K4clXLykJrn8HYNxRfr1+PHFtbT7coymCTJJE0550DhGbXwW/aSrdDpswiRY
         22U24783sUwWkxI/SsdI/sUf8N7uU5l7BdU1gNY43FiRjqT+XKmoNgwuMw2NOHBrNOXM
         rJjMytxEVbi8SBmV/DYewRoFMLATiPXfEv6P3cc/3hRqHxfy3IIDim96/fFITPe7bh3o
         aYNw==
X-Gm-Message-State: AOAM530Xh2VykdPZjsa5wwWrx+9lqDGHIFkrKhNix9/0GPdcEZqbYtSy
        2p6B//d5m4cKgt5NOm9+eExb3ehTc1nnWw==
X-Google-Smtp-Source: ABdhPJwwqaRnZ5bwcupdEIPiHOT5au3sKoILhR/rM4CIFw8IBVDSYSoW6y1HcU8tkb9QjkGq0KRgrg==
X-Received: by 2002:a1c:1c8:: with SMTP id 191mr9602290wmb.90.1639077579439;
        Thu, 09 Dec 2021 11:19:39 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id x13sm562180wrr.47.2021.12.09.11.19.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Dec 2021 11:19:38 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [RFC PATCH 08/10] linear-assignment.c: detect signed add/mul on GCC and Clang
Date:   Thu,  9 Dec 2021 20:19:25 +0100
Message-Id: <RFC-patch-08.10-794d494bedd-20211209T191653Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g0f9292b224d
In-Reply-To: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
References: <RFC-cover-00.10-00000000000-20211209T191653Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Extend the cost_index() inline function added in the preceding commit
with signed overflow detection that'll work on GCC[1] and
Clang[2]. See 320d0b493a2 (add helpers for detecting size_t overflow,
2016-02-19) for the existing git-compat-util.h helpers to detect
signed overflow.

This fixes a segfault on that happens when "range-diff" is given a
very large range to work with, such as the difference between
git.git's "master" the git-for-windows fork:

    $ git -P range-diff --creation-factor=50 origin/master...git-for-windows/main
    fatal: integer overflow in cost[47395 + ((47396 * 45309) = -2147454537)] addition

There are known bugs with using these functions in some versions of
GCC, as we'll see in a subsequent commit we're better off detecting
those with the "intprops.h" library, but for now let's add a simpler
implementation that relies on the bare minimum of compiler checking.

1. https://gcc.gnu.org/onlinedocs/gcc/Integer-Overflow-Builtins.html#Integer-Overflow-Builtins
2. https://clang.llvm.org/docs/LanguageExtensions.html#checked-arithmetic-builtins

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 linear-assignment.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/linear-assignment.c b/linear-assignment.c
index e9cec16132a..b6597b622c8 100644
--- a/linear-assignment.c
+++ b/linear-assignment.c
@@ -10,7 +10,14 @@ static inline int cost_index(int *cost, int a, int b, int c)
 {
 	int r;
 
+#if defined(__GNUC__) || defined(__clang__)
+	if (__builtin_mul_overflow(a, c, &r))
+		die(_("integer overflow in cost[%d + %d * %c] multiplication"), b, a, c);
+	if (__builtin_add_overflow(b, r, &r))
+		die(_("integer overflow in cost[%d + ((%d * %d) = %d)] addition"), b, a, c, r);
+#else
 	r = b + a * c;
+#endif
 
 	return r;
 }
-- 
2.34.1.930.g0f9292b224d

