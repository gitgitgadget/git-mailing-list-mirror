Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A818DC48BC2
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A59A6128A
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 00:27:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231185AbhFVA3j (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 20:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbhFVA3i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 20:29:38 -0400
Received: from mail-oi1-x230.google.com (mail-oi1-x230.google.com [IPv6:2607:f8b0:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 158BFC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:22 -0700 (PDT)
Received: by mail-oi1-x230.google.com with SMTP id d19so21898303oic.7
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 17:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RgZNj90QvPp5WheG0qBuoQCj6QlsOtSkGCI90a1D3sU=;
        b=Oev5gjNZHgNzlMfqE9K/mwcz50aYm91qbMvc9K1A7ldTF0CTAyU5QWyhfvieSNtONg
         YHfZTjfV/53EN1cXXyFG1mEO2TrcE5bVZ2iEaZaBR/IRY568ganCziDH5WuIxR/RNmGl
         Q1UHGdgxCeVEn/y8tCbIt0p43pXdib0/3keH20q8K+u6mrCbcAVSvibFAv3s7IJELOEF
         dQMWYbmxAiQm6KOoIBAQmFAufa2OgctyWtd/xb5xcn2v1Tbkf8CDrkve8hdsmifHsK9y
         Yap1zZBe22XFVRYP/icOf4ccSfxFVFbRhCk+wbXUxB2aO114ItZICdSfA8No1FYv2WCm
         mlNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RgZNj90QvPp5WheG0qBuoQCj6QlsOtSkGCI90a1D3sU=;
        b=Ry6tKiacKKXoSZoDJRZuRH1AL+KfkbhAsVeP+7EVX/cNQQKyAvBGn5tL9aN3hk1CX+
         /HcIGAakQ3a3MK1RN99a2dnNGlJjBkx+As9r0JjK5Nbp/gsyf2ShuBa2Xyk2BLCpKRI6
         0+j3AOEzSbvsB0JxzIZNATAiK1onYPoQwZeADXgERZWco1ZOkaFaKW6+hi9QM6C0mTq8
         5IMN2XBf9ok5TbLRwQushY1nClQKXAC13vgLSBl+7hGfj7E8rj+pwJYm5W07pTmxFSTg
         47fxWzGoJ+6I2iH47JNOMmBGGDjU01KI+YJ1iuMExTo5qZfe2MB7mGYX84m4SBVOKHRZ
         E11g==
X-Gm-Message-State: AOAM5308Mm8Qp6Pc6PUkrxy8FfKdLiPHiV/8lq9QRJTq+RWXfa2qPzT3
        olQOCh+47gCi9ELoZh26dXausWHXcrA5Bw==
X-Google-Smtp-Source: ABdhPJyanQpxNX1h6zYdBRKL5CeB6b5zs8HT6zPMYKWZXZz6+lPkuz0OU67uIa5cq81ja9wtiWwehg==
X-Received: by 2002:a05:6808:1315:: with SMTP id y21mr1060086oiv.44.1624321641085;
        Mon, 21 Jun 2021 17:27:21 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id q26sm165882ood.7.2021.06.21.17.27.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 17:27:20 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v2 4/4] test: document broken merge.conflictStyle handling
Date:   Mon, 21 Jun 2021 19:27:14 -0500
Message-Id: <20210622002714.1720891-5-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210622002714.1720891-1-felipe.contreras@gmail.com>
References: <20210622002714.1720891-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Currently both merge.conflictStyle and --conflict=diff3 don't work
together for `git commit --merge`, since the former wrongly overrides
the later.

There is no easy way to fix this, so mark it as broken for now.

Signee-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t6440-config-conflict-markers.sh | 31 ++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t6440-config-conflict-markers.sh b/t/t6440-config-conflict-markers.sh
index c51512ced6..3ba993a6a8 100755
--- a/t/t6440-config-conflict-markers.sh
+++ b/t/t6440-config-conflict-markers.sh
@@ -82,4 +82,35 @@ test_expect_success 'notes' '
 	)
 '
 
+test_expect_failure 'checkout' '
+	test_create_repo checkout &&
+	(
+		test_commit checkout &&
+
+		test_write_lines a b c d e >content &&
+		git add content &&
+		git commit -m initial &&
+
+		git checkout -b simple master &&
+		test_write_lines a c e >content &&
+		git commit -a -m simple &&
+
+		test_write_lines b d >content &&
+		git checkout --merge master &&
+		! grep "^|||||||" content &&
+
+		git config merge.conflictstyle merge &&
+
+		git checkout -f simple &&
+		test_write_lines b d >content &&
+		git checkout --merge --conflict=diff3 master &&
+		grep "^|||||||" content &&
+
+		git checkout -f simple &&
+		test_write_lines b d >content &&
+		git checkout --merge --conflict=merge master &&
+		! grep "^|||||||" content
+	)
+'
+
 test_done
-- 
2.32.0

