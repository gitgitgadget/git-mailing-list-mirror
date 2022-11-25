Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D1C4332F
	for <git@archiver.kernel.org>; Fri, 25 Nov 2022 09:54:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230198AbiKYJyp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Nov 2022 04:54:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbiKYJyZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Nov 2022 04:54:25 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A635547336
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:50 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id b12so5976921wrn.2
        for <git@vger.kernel.org>; Fri, 25 Nov 2022 01:51:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K97VYJtXJU/6Zcf2HJgJN9sBULrzaTMz4Baw3NiWSg4=;
        b=agGuu+NYgF+STjuT+BYpNlQu1QmzkEnp41/ikr9+oTUdP5xa4/jotPUS6YqzZWCCsz
         XGJa/qRqkup5DQZHnr8r8vknUbNFc+gerZV2Ufki9bhNvWIFTG4ieaa6xgovzHQwkifk
         CrrMe9bs4lNRe27rqQKRReQR/r/gKC8PXvPoJbqxjDPqlnzwWlzJfLyLEPomu9NZty4K
         pRBLwoHSz02/nPy7s8h3Ykxw9gsDkfJXnHq1+snofB/+ugrmME7sC3lmiEjmf3ExBWIt
         Ji6Jz2tTp8E8fZHxgOBMjvT9KOPVlrvUS0XEogRFgjWR3A+PhDMR9xEnc5YFCN/VaLO5
         SxZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K97VYJtXJU/6Zcf2HJgJN9sBULrzaTMz4Baw3NiWSg4=;
        b=eqicMxiryPBuMYiTiHwzeGNiMmXj1cB4NBZGD5knWpSonqNk3S14R7Tvvx92Flu5jK
         83+PEU0oqQ0mZBGAsP3ppxyCgh+VgKS0ZpI7TAy/4HT3pOccweiLb7eIDwxugjDwYigI
         pypzW2DlNK0XZkVD04h93fiJ/MNLgDzH21eCG5eG1KpzkiFcIlFgVRmAHe0BL63+6c0+
         /WWQdM2JS/SNGRyDH5+BymVIKXW18UhvlXLprlZb136dUQMtmWXgspafKyBO+/+x71ki
         vdVpQYXnM0KLjLRe2YiL3PdFdPBbhL+SBQTrfeGNNaNPpd8Aq6L6ht5JTQS6OQvAPUC0
         TjJg==
X-Gm-Message-State: ANoB5pnj6WOjyQ8gbFG/04lnT8asQ6RIUPZOhr7VaFwF39ch3MKaksPe
        2/LErleeCW97QQ6pV+bmMUGe8QbrDFPvsgUR
X-Google-Smtp-Source: AA0mqf6OfTd5A4rQ0HvEKno/na++f5rJkqZtH7/K1NzsaqtIIK04na+HpLOsJQ8i2wMSUy14FrT11g==
X-Received: by 2002:a05:6000:124d:b0:242:10a:6667 with SMTP id j13-20020a056000124d00b00242010a6667mr3664821wrx.39.1669369882507;
        Fri, 25 Nov 2022 01:51:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z6-20020adfe546000000b0023655e51c33sm3420975wrm.4.2022.11.25.01.51.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Nov 2022 01:51:21 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/9] for-each-repo tests: test bad --config keys
Date:   Fri, 25 Nov 2022 10:50:02 +0100
Message-Id: <patch-v3-1.9-5c8819ff388-20221125T093159Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.rc0.955.ge9b241be664
In-Reply-To: <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20221101T225822Z-avarab@gmail.com> <cover-v3-0.9-00000000000-20221125T093158Z-avarab@gmail.com>
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
index c6e0d655630..a099abc652e 100755
--- a/t/t0068-for-each-repo.sh
+++ b/t/t0068-for-each-repo.sh
@@ -39,4 +39,10 @@ test_expect_success 'do nothing on empty config' '
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
2.39.0.rc0.955.ge9b241be664

