Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CD4AC4332B
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:08:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0B86B22B2E
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:08:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727814AbhAPRGP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:06:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726993AbhAPQbd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 11:31:33 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3B54C06134E
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:09 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id k10so9872182wmi.3
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+n0wOh4VnlU3xMbjFdkWk1y1M2k6/3Isy3eUWGa3Lnw=;
        b=s0eCdhtQoiGTHaNLPel86bCfRVDDyQ8KvfxCMyvUZGHUqHoSbz90s3JsWkXTMZhWBr
         KcY80eo3CLdGDq9L601PfWFUv2oVEMknrn9rEq64PX0kmdAG/vkZzmNFhiN2g+B74rSY
         TboTiTV8SopWimzbLWgcA8RpMcGZtTgzUVXDuOmQAqEhemuJRdXpFByCEVtNDnNM6p7S
         +7MSTMA0RXsn13nIgEHPjsZhzzUR6TX/43ECUOtFlJxE54IpNa6lWz7ms1iFh6dm3uA2
         WWQS1PPBHxoVj5M466jCCHoXla1vrPrgOYY9zBdQiC44EF3WAs2lMmeMiB8Kl/SC7S15
         DPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+n0wOh4VnlU3xMbjFdkWk1y1M2k6/3Isy3eUWGa3Lnw=;
        b=Q9sZI0WI97MAdWnexPwd+VlSB9xuUGN3t9Q4n95Er7eLRKIlGD7YcziFUQ1pq5uqzb
         +t3+zS0H1cQ0eyVOcJx1ATUCoQxfBKlNTcyt9q0wZYDr/vOLr5HF2GI6WUnIXgPgAbAR
         EkP7yTyxoEpnTB5BuIJ5WG5v0Ao58FVU3rTs4eeaBTUHfovocSI4h6aK2qwP2ZDFbRoo
         hkbaPWgsRwHMBjy1yI8/pEroWql5mQiP+w21I9XxsQ8wQQXr1do/uM8CsCoj3epFyNKT
         8T+xosyqrymZa5wMXdRAqQgea2BJwtRqG7ii5woOVsmPv/JmG/LVbYpiQ/IHsHboWla2
         9T9A==
X-Gm-Message-State: AOAM530P5jYjYKF+QG79nolQpoUoo9lj/2UD19t5jOrsZ/xbxyNk+OAB
        33cN8dD6iNwc1lD3uuX1J5vkn/bL71yuAQ==
X-Google-Smtp-Source: ABdhPJyarlqvo58lWnuYXhu1eZnqha6U88nyg19hE3s6eRHxOl/BO44uNUEXXf8jiqQV6nQdOjjRGQ==
X-Received: by 2002:a1c:9ad5:: with SMTP id c204mr10860570wme.65.1610811368147;
        Sat, 16 Jan 2021 07:36:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/11] upload-pack tests: avoid a non-zero "grep" exit status
Date:   Sat, 16 Jan 2021 16:35:51 +0100
Message-Id: <20210116153554.12604-9-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Continue changing a test that 763b47bafa (t5703: stop losing return
codes of git commands, 2019-11-27) already refactored. A follow-up
commit will add support for testing under bash's "set -o pipefail",
under that mode this test will fail because sometimes there's no
commits in the "objs" output.

It's easier to just fix this than to exempt these tests under a
soon-to-be added "set -o pipefail" test mode. So let's do that.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5703-upload-pack-ref-in-want.sh | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/t/t5703-upload-pack-ref-in-want.sh b/t/t5703-upload-pack-ref-in-want.sh
index eab966985b..420cf2bbde 100755
--- a/t/t5703-upload-pack-ref-in-want.sh
+++ b/t/t5703-upload-pack-ref-in-want.sh
@@ -16,7 +16,11 @@ get_actual_commits () {
 	test-tool pkt-line unpack-sideband <out >o.pack &&
 	git index-pack o.pack &&
 	git verify-pack -v o.idx >objs &&
-	grep commit objs | cut -d" " -f1 | sort >actual_commits
+	>actual_commits &&
+	if grep -q commit objs
+	then
+		grep commit objs | cut -d" " -f1 | sort >actual_commits
+	fi
 }
 
 check_output () {
-- 
2.29.2.222.g5d2a92d10f8

