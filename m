Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 32C311FF72
	for <e@80x24.org>; Tue, 24 Oct 2017 17:02:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751559AbdJXRCz (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Oct 2017 13:02:55 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:47582 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751495AbdJXRCy (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Oct 2017 13:02:54 -0400
Received: by mail-wr0-f196.google.com with SMTP id y39so21412335wrd.4
        for <git@vger.kernel.org>; Tue, 24 Oct 2017 10:02:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=qdJ9RNOLxLakIAL2u747Mr9TvuEh859yxdgVkc7p1/4=;
        b=Xp+b0HXO/PHiSuKAHPgplLtw38R3iHlhVKGF+CBpm/LZP4YCbduIcM7mb4M5Dqv/RK
         9awPSuzXCXOyrYlevyFyAc3O7x5YSJcUa7faTodEB2VgWSN1MQUL5P3BtD/K4Fo7sV3/
         kaam2tG2k3c20F+OQqTaPeos9qg+RzcIfaWQPHw0fzHmxf2/XnhkzqfIYrosigPNSgo0
         HxXkGwLc7OiY2oTL39cpqCBYAxoSW1RrLoz/G/APsXrf+LExiLMYg3Ej2QZUNECSJaFc
         URmzJjcGAiwmNFb66N9lRpRW4c8UlFC+prMrsxhnT+397BmKt3v0hCdIhq2ttoLfmOdK
         Yj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=qdJ9RNOLxLakIAL2u747Mr9TvuEh859yxdgVkc7p1/4=;
        b=jawpkN6cb3BNDC4GGQvr+pUcM5r5WfIOF+m1E1J/G4Lqj09vAhYWRkpCQ+Kp8r54zn
         1rQUjmn7JLN8Tub/6JPHOz46wyeTbnl0v37xTKHKI5biUF+Qzr2UlvkqOaHkKycJq5Jl
         pq5LKVqA/qWHZC1nWQGIV1xt0mLZc2SKpJCMeYdVd9LvgBhNVEqk3Dtw2OMskOdqFypb
         LzraVGIPbSL0WJ/OmDJIBIFH4zvCuKGgMhtCyTRtBoSZ17yjEvzXH3/dFNox9CiDM6L8
         0PAilOrHprJb0OX31HehiJGEKj8M1OsnvuOgFpqwYgBoCocuhb1x/tkQnk7fupnFwSn+
         VJbA==
X-Gm-Message-State: AMCzsaUOoqJuLuyiJCECU8DyclWzfbK2JyXYiQl0C5IKehmNveyNzKzK
        xc1KdVVN8U5hS/SZWwldNK+Gnw==
X-Google-Smtp-Source: ABhQp+SGPxaIw102lmymI8Y8+ScuZCLyfO42NP6ScZOtURSpLGuVPoJLWk7gxK0EYO/UNltnvDYoew==
X-Received: by 10.223.161.210 with SMTP id v18mr6759539wrv.76.1508864573353;
        Tue, 24 Oct 2017 10:02:53 -0700 (PDT)
Received: from junior.corp.audiocodes.com ([164.138.117.251])
        by smtp.gmail.com with ESMTPSA id f6sm729232wre.66.2017.10.24.10.02.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 24 Oct 2017 10:02:51 -0700 (PDT)
From:   orgads@gmail.com
To:     git@vger.kernel.org
Cc:     Orgad Shaneh <orgads@gmail.com>
Subject: [PATCH] add a test for "describe --contains" with mixed tags
Date:   Tue, 24 Oct 2017 20:02:42 +0300
Message-Id: <20171024170242.31894-1-orgads@gmail.com>
X-Mailer: git-send-email 2.15.0.rc2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Orgad Shaneh <orgads@gmail.com>

If a repository has early lightweight tags and annotated tags later,
running git describe --contains for an early commit used the annotated
tag for reference, instead of the lightweight tag which was closer.

This has been fixed in ef1e74065c19cc427c4a1b322154fd55d7a3588b,
and regression was tweaked in 5554451de61cb90e530f30b96e62d455e1eff6a1.

Add a test for that to avoid further regressions.

Signed-off-by: Orgad Shaneh <orgads@gmail.com>
---
 t/t6120-describe.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 1c0e8659d..08427f4b5 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -340,4 +340,20 @@ test_expect_success ULIMIT_STACK_SIZE 'describe works in a deep repo' '
 	test_cmp expect actual
 '
 
+test_expect_success 'describe --contains for light before annotated' '
+	test_tick &&
+	git commit --allow-empty -m First &&
+	test_tick &&
+	git commit --allow-empty -m Second &&
+	test_tick &&
+	git commit --allow-empty -m Third &&
+	test_tick &&
+	git tag light-before-annotated HEAD^ &&
+	test_tick &&
+	git tag -a -m annotated annotated-after-light
+
+'
+
+check_describe light-before-annotated~1 --contains light-before-annotated~1
+
 test_done
-- 
2.15.0.rc2

