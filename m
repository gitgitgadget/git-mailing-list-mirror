Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1D22C433FE
	for <git@archiver.kernel.org>; Tue,  1 Nov 2022 23:05:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiKAXFn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Nov 2022 19:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230437AbiKAXFf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Nov 2022 19:05:35 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C54EB60D6
        for <git@vger.kernel.org>; Tue,  1 Nov 2022 16:05:34 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id n12so40816472eja.11
        for <git@vger.kernel.org>; Tue, 01 Nov 2022 16:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i6ZTDxDgk9EXDWQ5ERWaMY5EREdXCe/IMcrYmEU6YnE=;
        b=Iv55SiBpi029qd7MEjKLv70DwXBHL4eIYh0LWfNjTJsv5iG4RU267gkCGJObAcLFoS
         lNkuoR103xCorhEGWiQof6zSK+0gO7LruBqgadOICaCUoXUl8rysEEAncR642JhX7Ti/
         qQIxwbzhHDNP3ZQKVzkbJt6u+C4KbNwMrmRf745I1OH5qCCW1U5pUuMLHMxXkpKp3fTA
         n2OCm8tl2+sEtA+voCsgoh6Rrn3TzMFxhcH9bSBHaD1A5py+sb0Rpw0184v75CupNgsC
         eh5D6ShatyWnWnzgkxPwcH4rCe1sOV/B7CIKwgswnh+9sMCRRxTVCTV3AQiGOgsohkFC
         StZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i6ZTDxDgk9EXDWQ5ERWaMY5EREdXCe/IMcrYmEU6YnE=;
        b=D13OkhaihtL4NshWo7lzqJXiBzSLhHMTSrVh1/ePkkxzM+pK+bh1mIKLldQKunS6bL
         L1/woyz8gmcV3Xhf+qmPmiNQm/PMDQc4lR9j9pzKQXT/ZJatbMISb2j6HQKd0uk1/2T6
         Fz5Zmx9w/0ma2z6Pqo6IrCwNAUj0qNNpFnO3UYXZJqBFWd0qvukMhsgk/AyZNJanyylQ
         LewS1em2WD8lhHG4Q3KtSjTECWnwoRNfz5WUkNS8yZzxqFIkb5BjrNsXE0Qwk1jSBH/j
         nRFa5XgH6twr23PSyfTbziWvPNaNgBc3bLvSpSP4WJ4hED3FK9Q/Sv7zsrzXjMKSwwv2
         vymA==
X-Gm-Message-State: ACrzQf0gLQu2rmd0mBXVYyhZAg4Z5f/nDgzhw/aMQL1WTE4doQhhJ/Mg
        fWm5/oCUMIqbeSzTVAdV7KeqwNa4s+kkVQ==
X-Google-Smtp-Source: AMsMyM7nfQZFRjjL1QnrABFWN3MrQkbiphVFdYvy5dC7kk2CTcLKqZyfYNsxZg8xtCBDqH7n9IXJoQ==
X-Received: by 2002:a17:907:b602:b0:7ad:e82c:3355 with SMTP id vl2-20020a170907b60200b007ade82c3355mr7273128ejc.3.1667343933078;
        Tue, 01 Nov 2022 16:05:33 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f18-20020a17090631d200b0078cb06c2ef9sm4645202ejf.8.2022.11.01.16.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 16:05:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/9] for-each-repo tests: test bad --config keys
Date:   Wed,  2 Nov 2022 00:05:12 +0100
Message-Id: <patch-v2-1.9-b8fd3bea4d1-20221101T225823Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1280.g8136eb6fab2
In-Reply-To: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
References: <cover-00.10-00000000000-20221026T151328Z-avarab@gmail.com> <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As noted in 6c62f015520 (for-each-repo: do nothing on empty config,
2021-01-08) this command wants to ignore a non-existing config key,
but it's been conflating that with bad config keys.

A subsequent commit will address that, but for now let's fix the gaps
in test coverage, and show what we're currently doing in these cases.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t0068-for-each-repo.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t0068-for-each-repo.sh b/t/t0068-for-each-repo.sh
index 4675e852517..6bba0c5f4c2 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -33,4 +33,10 @@ test_expect_success 'do nothing on empty config' '
 	git for-each-repo --config=bogus.config -- help --no-such-option
 '
 
+test_expect_success 'bad config keys' '
+	git for-each-repo --config=a &&
+	git for-each-repo --config=a.b. &&
+	git for-each-repo --config="'\''.b"
+'
+
 test_done
-- 
2.38.0.1280.g8136eb6fab2

