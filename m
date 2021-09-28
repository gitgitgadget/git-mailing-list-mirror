Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2635AC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0AFCC611BD
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:14:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240642AbhI1NQT (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:16:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239811AbhI1NQR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:16:17 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DE19C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:38 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x20so13320185wrg.10
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:14:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=98NBot6U2akdiJwAVAWdVbKOgyUwozDN0iJD/t1K61I=;
        b=g2HYio2KbgNaq63ICc4I9y5i3rw6yN5VBjnSoZGrz7s1JU5UXmSVsPF0sLLfp36iHU
         Yg7M9vK87kpteAhiSXv9QzP8Ekqocs/cZFhdtFT4hlpeAcQVmbW4Xlrbiyb//2DGbrbp
         CEWciw7P24ft2iUXyLGL0IOTQqDZy7xMIfzk+po96cJkfIsZ+3ksS9U8KBSynG+pOZJk
         S2rjqhckZqAbSq7lDKYXLoRIXNtS7BVjPKAYvCkFTnz+BS2lZ313+qZw2cu4uPYl5wgI
         m7FOyr1HSEhIbbKz6ALG3cq9FglpURiBWG6DoHQTslo4YcHzMDkV90xpQXiIHnaQ27gZ
         LLRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=98NBot6U2akdiJwAVAWdVbKOgyUwozDN0iJD/t1K61I=;
        b=2/sbSzirJ6fF0gBbuX7BGwy7biPLCoNPvxrwjY8zry/Pt385W29/F5WISKadDRjYVq
         5PhC2aVrxzO0kNKlSO5TVWO7afZN8o5C4DVdCqud9E9C971+gUbrW7Ifgihekb89R96R
         tdMj7oy7tesRPCGJhPvQNKFDVt/ViAIXbeNr//5zbaGjFsKSUcoTV5YGHJifbltDHpwg
         h1uC/yPFODsO8a9mEIsf4Q814ZxO8Q/Un4poQlvan5W1vdUWK2LW5gUaAZGGEOg9oZ5j
         Fbas2L71MgkUpYR/kljGdcQS3AtyK5flNTiBrRKFHOLLbQswc1ZL1LC1b6decCVKZfNG
         tqFw==
X-Gm-Message-State: AOAM533+O1SNyszI+5sTfHrsF67oPqTmPmJRPTdD7KV4FIqExwxq9yGA
        /+5V4XkhA84h9O4asVrYOKjjtM1X8iqM4A==
X-Google-Smtp-Source: ABdhPJyydUmScVgLnR6r1P2/RZu3yLKrvyNK0CQULdAOnIh25nvgNvPQj5jHsUF0VUHdGvBPCl7a2Q==
X-Received: by 2002:a5d:4fd2:: with SMTP id h18mr5255750wrw.218.1632834876591;
        Tue, 28 Sep 2021 06:14:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l21sm2617981wmh.31.2021.09.28.06.14.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:14:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 01/10] parse-options.h: move PARSE_OPT_SHELL_EVAL between enums
Date:   Tue, 28 Sep 2021 15:14:22 +0200
Message-Id: <patch-01.10-19d1573a4e0-20210928T130905Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1339.g53eae12fb46
In-Reply-To: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20210928T130905Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a bad landmine of a bug which has been with us ever since
PARSE_OPT_SHELL_EVAL was added in 47e9cd28f8a (parseopt: wrap
rev-parse --parseopt usage for eval consumption, 2010-06-12).

It's an argument to parse_options() and should therefore be in "enum
parse_opt_flags", but it was added to the per-option "enum
parse_opt_option_flags" by mistake.

Therefore as soon as we'd have an enum member in the former that
reached its value of "1 << 8" we'd run into a seemingly bizarre bug
where that new option would turn on the unrelated PARSE_OPT_SHELL_EVAL
in "git rev-parse --parseopt" by proxy.

I manually checked that no other enum members suffered from such
overlap, by setting the values to non-overlapping values, and making
the relevant codepaths BUG() out if the given value was above/below
the expected (excluding flags=0 in the case of "enum
parse_opt_flags").

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/parse-options.h b/parse-options.h
index 39d90882548..3a3176ae65c 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -33,6 +33,7 @@ enum parse_opt_flags {
 	PARSE_OPT_KEEP_UNKNOWN = 1 << 3,
 	PARSE_OPT_NO_INTERNAL_HELP = 1 << 4,
 	PARSE_OPT_ONE_SHOT = 1 << 5,
+	PARSE_OPT_SHELL_EVAL = 1 << 6,
 };
 
 enum parse_opt_option_flags {
@@ -44,7 +45,6 @@ enum parse_opt_option_flags {
 	PARSE_OPT_NODASH = 1 << 5,
 	PARSE_OPT_LITERAL_ARGHELP = 1 << 6,
 	PARSE_OPT_FROM_ALIAS = 1 << 7,
-	PARSE_OPT_SHELL_EVAL = 1 << 8,
 	PARSE_OPT_NOCOMPLETE = 1 << 9,
 	PARSE_OPT_COMP_ARG = 1 << 10,
 	PARSE_OPT_CMDMODE = 1 << 11,
-- 
2.33.0.1340.ge9f77250f2b

