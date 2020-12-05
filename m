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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53A11C4361A
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20AF322DFB
	for <git@archiver.kernel.org>; Sat,  5 Dec 2020 01:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbgLEBkT (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Dec 2020 20:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726291AbgLEBkT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Dec 2020 20:40:19 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDF3C061A4F
        for <git@vger.kernel.org>; Fri,  4 Dec 2020 17:39:38 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id k14so7047282wrn.1
        for <git@vger.kernel.org>; Fri, 04 Dec 2020 17:39:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+yV2ertU3lDVq8kwL2aaldVbUEeGIBApWXa/dR5L7bg=;
        b=rtZ1Fj3RA0RJvrBCZBB5aBzvorGSVqbXBSZW1Isxiy4oDabfc+T4xpaokVySWi5T/w
         iBtZHT3RNGbQoU0WO3utz9ictqGKHkvjgH2bvSNnGePwjY4J3Txc+5+/pZCSEHJlkeI1
         n/WI9yj/q87pnWPWnbAQk2du3wjOgJ7DOeJ66x2SBxPXwz/6UMGOgr2M23os5wYHTqzv
         zMxLIY2Ebq+APsc4VXoJ5wGtPFAWVaZFaB3AU5/hElL7vh3ExzNiujJ0iZNu8UReHfTU
         dTvysrLQWTqu6V30HU58letRtiLAowgD5cBk/OQvVnH9n2Gm5LQfTfd6DdET7VkcswSX
         IFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+yV2ertU3lDVq8kwL2aaldVbUEeGIBApWXa/dR5L7bg=;
        b=h+1sfq+Ubj2rgMIOJ//ymk30W5cC9US+g42Z0KfxOnYVsQDyWT1m+5yIbiKP7BqW5B
         NCNWhrsXvfKMw6NuGfy6ArWxmWweBDT5zrKPzMpKhx5AiABESWz6NggGUX2CcQoQHl7W
         wRSLovFdt+uAyeIhxsIbZUogc/7Q4nU9T55u0Hh7fmf+qp4icw5OSkGDienyhCvxFBsq
         hcb7IR9CgBrKxGY/PhYUzeisuq019133gdLvA5p4EBmAsHwORrDqViFWj47JyRRHmlQ/
         IBOVQcH0mmzqnzqMBXoNb95GDnL+vT+HixsI/qyv8C0XzzApHOHllHq/PayGMJSrib6Q
         DtyA==
X-Gm-Message-State: AOAM531f4PXvZHPOReZY3xcGZkAz9FvS1ZOlUZ6WJqpxcP/YHnKonBKd
        EQTzobc3f7fRX9jlXaw23yHrHViy40+cHg==
X-Google-Smtp-Source: ABdhPJxVMLgqVPK5u90x9GG9udsJDHOF6cb6RMdL7Op8QEWwA8DJxnDNIZdT1Ka+VAVOkfjhVEIHVA==
X-Received: by 2002:adf:de12:: with SMTP id b18mr7846602wrm.187.1607132377436;
        Fri, 04 Dec 2020 17:39:37 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a1sm5537821wrv.61.2020.12.04.17.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 17:39:36 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] pretty format %(trailers) test: split a long line
Date:   Sat,  5 Dec 2020 02:39:14 +0100
Message-Id: <20201205013918.18981-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201025212652.3003036-1-anders@0x63.nu>
References: <20201025212652.3003036-1-anders@0x63.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split a very long line in a test introduced in 0b691d86851 (pretty:
add support for separator option in %(trailers), 2019-01-28). This
makes it easier to read, and it'll be used as a template in follow-up
commits.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 42544fb07a0..bf9b30ff3d6 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -723,7 +723,12 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
 
 test_expect_success 'pretty format %(trailers:separator) changes separator' '
 	git log --no-walk --pretty=format:"X%(trailers:separator=%x00,unfold)X" >actual &&
-	printf "XSigned-off-by: A U Thor <author@example.com>\0Acked-by: A U Thor <author@example.com>\0[ v2 updated patch description ]\0Signed-off-by: A U Thor <author@example.com>X" >expect &&
+	(
+		printf "XSigned-off-by: A U Thor <author@example.com>\0" &&
+		printf "Acked-by: A U Thor <author@example.com>\0" &&
+		printf "[ v2 updated patch description ]\0" &&
+		printf "Signed-off-by: A U Thor <author@example.com>X"
+	) >expect &&
 	test_cmp expect actual
 '
 
-- 
2.29.2.222.g5d2a92d10f8

