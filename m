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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4068FC433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06D7361206
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 17:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243788AbhDLRP6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 13:15:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243509AbhDLRP6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 13:15:58 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DF54C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:40 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id x7so13714110wrw.10
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 10:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eN5uZnZgRnZjzuMEKvzsYPjOsQUzf7NFqV8RyTi216I=;
        b=qQH2JDn4CX9KLw/Ni5Qyh5HE89n8HahXLbBO23T5clVhKxmCa6WYK0UdgUA/0o8AdV
         Lp2Da4u4nk6eNFXvRIjOmfVMEqqRj2Mgd4Refy2SypwuKcJTuFSWknLYXQnn37sT3HsL
         TY1dIWMUtQiRZANcSbV8U5xu4727bfnPbbb1anhAfg88/EOhInlx+polFtnYur+RmUiT
         nn1tBdpW5Ql7l4X2tzx9qCyeWZyXku8ppKStscC2z1RkJzZhEDyniGk7C1jexWHVTQvC
         Fwon1SOr4fVoU0AwmkiPQdrIfpdE16248qOycNsCMG+J8Kc1tyvV5FS5AROQzmdgy4A5
         Z14w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eN5uZnZgRnZjzuMEKvzsYPjOsQUzf7NFqV8RyTi216I=;
        b=QsL6fbil4sFwnWyGBnWTACN879cKjGaHj4MYFvtSv0DJv84ccLI3F+puSzDA1uGfNy
         yKNmm32/IXObJD4o1/AOthkQIwFY6x87Islj61iB5mx2eZ/Rd54KrfkKNyklWbpRSs5o
         Dohr+odBTH8z8aURDzXxkJ2Alwj3Mvk+hQ33E15nPF277fpORFK5+FXM4JL34/cfPmRT
         kaJbJ29bRJw653uI5iOnmAf0INNaY9DUUOnfVSn79SqYVP6ntw2T9P2+fiXN//sFC+qg
         MFkFH6x9OCr7GR9FEnQ+IqB0tUZzBjB1jSKvGap1bltHdDCnS8RTqm9Dh16YyRBK6Dn8
         mJ/Q==
X-Gm-Message-State: AOAM532v0zSFNaGqi/AwY+x+Pm5u6CQtqt9fL5uBW5YfphAMidOIgsRX
        TFTHXRoDlMo3JCPm9awxs00BPR06Fsr2bA==
X-Google-Smtp-Source: ABdhPJyyKk2w/rFi2P0g4bc2uF3XUIKY8AhEKBDu+5rVrSqoXRZQCPGr5OU0W82jpguvbYFrhuH1UQ==
X-Received: by 2002:a5d:4a8b:: with SMTP id o11mr5569486wrq.233.1618247738680;
        Mon, 12 Apr 2021 10:15:38 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j1sm7828625wrr.33.2021.04.12.10.15.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 10:15:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 01/22] grep/pcre2 tests: reword comments referring to kwset
Date:   Mon, 12 Apr 2021 19:15:08 +0200
Message-Id: <patch-01.22-cfe934d6081-20210412T170457Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.639.g3d04783866f
In-Reply-To: <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
References: <20210216115801.4773-1-avarab@gmail.com> <cover-00.22-00000000000-20210412T170457Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The kwset optimization has not been used by grep since
48de2a768cf (grep: remove the kwset optimization, 2019-07-01).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7816-grep-binary-pattern.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t7816-grep-binary-pattern.sh b/t/t7816-grep-binary-pattern.sh
index 60bab291e49..9d67a5fc4cf 100755
--- a/t/t7816-grep-binary-pattern.sh
+++ b/t/t7816-grep-binary-pattern.sh
@@ -59,7 +59,7 @@ test_expect_success 'setup' "
 	git commit -m.
 "
 
-# Simple fixed-string matching that can use kwset (no -i && non-ASCII)
+# Simple fixed-string matching
 nul_match P P P '-F' 'yQf'
 nul_match P P P '-F' 'yQx'
 nul_match P P P '-Fi' 'YQf'
@@ -78,7 +78,7 @@ nul_match P P P '-Fi' '[Y]QF'
 nul_match P P P '-F' 'æQ[ð]'
 nul_match P P P '-F' '[æ]Qð'
 
-# The -F kwset codepath can't handle -i && non-ASCII...
+# Matching pattern and subject case with -i
 nul_match P 1 1 '-i' '[æ]Qð'
 
 # ...PCRE v2 only matches non-ASCII with -i casefolding under UTF-8
-- 
2.31.1.639.g3d04783866f

