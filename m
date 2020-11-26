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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7F5FC64E7B
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 787F521527
	for <git@archiver.kernel.org>; Thu, 26 Nov 2020 22:23:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cfkvy5jf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391799AbgKZWXQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 26 Nov 2020 17:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391790AbgKZWXP (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 26 Nov 2020 17:23:15 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAAAC0617A7
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:15 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id z7so3698380wrn.3
        for <git@vger.kernel.org>; Thu, 26 Nov 2020 14:23:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sgLR052BmWKstzCMaXV7x0thq6EyIOUZ/6tWgNnVfVE=;
        b=cfkvy5jfG95ahGFBTFxy3cw0yiEcgYUNhqCG0pd0hn0e4uvd1bA52f0EebAyeH0Ndg
         oRaRC8luC2BhXtxBi7Iik/IC8lE9kG4uF7vvbyuuOKSFQuIeeIvUBW69ueAl9Z5hclTY
         nuSImIAMEGS3ZZpuu1rIuk6G9lmb1NKoD2/yYwFPxzyfVojWx6+F9WVJKVQ/nbqmRjWf
         bZ2Tcjg0fqMDY63SBn8Ga3RFtFhPyKDAqzvj/cLj5IycGSmgVWNB5tjzQH61dHk/FVGE
         mmIRE9NyqpfMUG70nXdUFXiQTyMjHVT2msba/fyJVGavLObkK8UkbtMutNs3iP8qFTCC
         Bs2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sgLR052BmWKstzCMaXV7x0thq6EyIOUZ/6tWgNnVfVE=;
        b=Y31dr8jBmqcofwXalUgTmCpwuJwfRNodYUQoGv9vbOHmGWsVlhwirqYSq+B/zfK4nT
         ElGDZkBeQ73aeKdtE1YYmy8laF5Q31DKwvDXN+GtVSiQVJtrV7MD6AWerXOBXL8J7dRK
         Qr25jiUx/E6Om7EFow1QMt6eV5yBuuYq6Qu5jaTf2MpLFzkNkuhxQ854Wgda1TLvpJvK
         eju7YMdNE90Ksqrj1PE2wFIPTaGmJx/2pykuxpyhuRuwxJM63OedhZ4mkovY8X0Yr+r1
         ugMYumpxNws/MJqqwxuz1e9hLlsIWg+RApJhuEexqsJDM7BAa6pg50wWJrE3fPh9L0Vp
         YS5w==
X-Gm-Message-State: AOAM531wZsp3UZosW+JS+TVTbfmz1SWb66Du8LKSj+z2XHX3CcfT+Nd3
        Q2M6erh0YRd+fCYdCl2Ve3mDZvKnBBdNzQ==
X-Google-Smtp-Source: ABdhPJxX8lVypa6Xzt8qyV5/9XHqIjen2Ver1aS3oj1ucmBIlvkjwKdB2aVb/YoWqM/wuiCJN4ryJA==
X-Received: by 2002:a5d:51c1:: with SMTP id n1mr6498749wrv.395.1606429393917;
        Thu, 26 Nov 2020 14:23:13 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e3sm11283237wro.90.2020.11.26.14.23.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Nov 2020 14:23:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/10] mktag tests: don't needlessly use a subshell
Date:   Thu, 26 Nov 2020 23:22:52 +0100
Message-Id: <20201126222257.5629-6-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126012854.399-1-avarab@gmail.com>
References: <20201126012854.399-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of a subshell dates back to e9b20943b77 (t/t3800: do not use a
temporary file to hold expected result., 2008-01-04). It's not needed
anymore, if it ever was.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index d696aa4e52..0e411e3c45 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -14,7 +14,7 @@ test_description='git mktag: tag object verify test'
 check_verify_failure () {
 	expect="$2"
 	test_expect_success "$1" '
-		( test_must_fail git mktag <tag.sig 2>message ) &&
+		test_must_fail git mktag <tag.sig 2>message &&
 		grep "$expect" message
 	'
 }
-- 
2.29.2.222.g5d2a92d10f8

