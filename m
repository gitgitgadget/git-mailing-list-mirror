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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 433FEC433DB
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 19B0F22D6F
	for <git@archiver.kernel.org>; Tue,  5 Jan 2021 19:44:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730928AbhAEToy (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Jan 2021 14:44:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730920AbhAETox (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Jan 2021 14:44:53 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0541AC0617A3
        for <git@vger.kernel.org>; Tue,  5 Jan 2021 11:43:39 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id r3so364492wrt.2
        for <git@vger.kernel.org>; Tue, 05 Jan 2021 11:43:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=m+NzCUShth1URyf9aQUS8a/Nhf71EApFnPiYFtU90s8=;
        b=rL+PPi28PskpRrO0NNLvJ4db5SR9EC+ooZfwcmbbCvBZ2Se1Sz/pJ/8zpL1vyKw283
         szzB54L8IWUlC0/pIaUv2SsvPCGKEQ6RglQkNnWPKTE/qRtj7z7JWFQW3GFoAv8W29dt
         lI4aMXm/RYpVsEgJHHw2c7FBlh2NwAEcZ1jJJYaJeByLB/XrPemK7hFfPfbqwEvcj7CU
         YCxYosY0F9244Rbh5QrhmGkFuH1mkiXicP20ON6DtLjik7lbdCRb/w6P+4Zy44YYgKAh
         Ogp5jIWRlYf0KQbUq9i36bpGUxMQnlSdUreLR0Mxz8xE0VkTPJLhOGR0sWZcUq1XUWSF
         ZtDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=m+NzCUShth1URyf9aQUS8a/Nhf71EApFnPiYFtU90s8=;
        b=fp95tWUi5xDCWGWYcdSJ3pIEzAv+lWw1LmRoAPr3jH0DV0+ZMC2Wl1mdblPWOO0fOv
         a6deEUhV2To4NgMQvSnAXnO1aX3at4F1WYC3oTferuVx7wiMkyrs3kUuUlzDM+tq/6PO
         ds6hSTYzEwZAgBgWmER4SxJLsSk0VkF9afmDofuuYPDcvtRKPM/XIArpmKUInXSK7KlG
         4YLSl666T7dGxBGRrrg/Zyx8zeyz37hJpWooRH/1L3cMtrAOudUM+HjEcfNyoSt+CgNx
         0CFPKwHieb3r08UQs3cMmg3oC5bIK5yrDX+9fyPcdQtE4Vf41JUWooghuJhigl86/lBU
         cTyg==
X-Gm-Message-State: AOAM53147DFMwwShb9Qi4xJN+2Dn26+3XRejvhZWnCLZNOlmZ1x8gUSr
        B2JuAOg0V1kGFr3cGnBwNsQa7o0QyV8D8A==
X-Google-Smtp-Source: ABdhPJzlQMbdJZZ8NMvB6rNrErbnJQnwzaJ2VwP/tPr4N+lYtRuIV2HP+iHYbBXpod85FUV96TZClQ==
X-Received: by 2002:a05:6000:11c1:: with SMTP id i1mr1107271wrx.16.1609875817564;
        Tue, 05 Jan 2021 11:43:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s6sm151113wro.79.2021.01.05.11.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jan 2021 11:43:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 10/23] mktag tests: stress test whitespace handling
Date:   Tue,  5 Jan 2021 20:42:39 +0100
Message-Id: <20210105194252.627-11-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201223013606.7972-1-avarab@gmail.com>
References: <20201223013606.7972-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add tests for a couple of whitespace edge cases around the header/body
boundary.

I consider the requirement for a blank line before the empty body a
bug, it's a long-standing regression which goes against the command's
documented behavior. This bug will be addressed in a follow-up change.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index 048000cda9a..661b62f0912 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -337,6 +337,42 @@ EOF
 check_verify_failure 'detect invalid header entry' \
 	'^error: char.*: trailing garbage in tag header$'
 
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500
+
+
+this line comes after an extra newline
+EOF
+
+test_expect_success 'allow extra newlines at start of body' '
+	git mktag <tag.sig
+'
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500
+
+EOF
+
+test_expect_success 'require a blank line before an empty body (1)' '
+	git mktag <tag.sig
+'
+
+cat >tag.sig <<EOF
+object $head
+type commit
+tag mytag
+tagger T A Gger <tagger@example.com> 1206478233 -0500
+EOF
+
+check_verify_failure 'require a blank line before an empty body (2)' \
+	'^error: char.*: trailing garbage in tag header$'
+
 ############################################################
 # 24. create valid tag
 
-- 
2.29.2.222.g5d2a92d10f8

