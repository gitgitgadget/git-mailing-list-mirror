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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AB01C433FE
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 147A322B48
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 15:53:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731170AbgLIPxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 10:53:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731114AbgLIPxH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 10:53:07 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3878EC0613D6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 07:52:27 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id t16so2279440wra.3
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 07:52:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j2ZTSvWySxS2pIoV3RsjQzL7KBtb1JQBiJDaBIgVfGA=;
        b=j6a21c8IX3zOXw0QOJ6tXPBCK0c6eAWAtIP+rxlXMx/Ru8NW30xfI9uWRFaXAA0vaQ
         KcAq3LBKdIJZ+CjDj3uEmwup2sqhtoJT6Tfn5VhCES76lOyZl9ukmM8zMiR2JpzfpAOA
         cJF5FB7+Avn4wg0Nqg/zvYFE6DLzhFNofC+zfNc8lGmgDXdieA3VHn2eZMj+U9gnlhZh
         Xcu7VYsr2pRx0UBvOLq+WqI/ee9IySZoijLUB3JO0OrKCzaRq/ct58KaFybraOB5Q8Pa
         qqkWrDCFhOexybWdvPyAjiYg+7ayQlHskMOkchdGTDE6+YPx1naTnio9cgrlSfY2QydB
         egTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j2ZTSvWySxS2pIoV3RsjQzL7KBtb1JQBiJDaBIgVfGA=;
        b=KYL2WbsSVSJpgq95MVhE+HkZDXFRLvWWWGnDnSaKtUmUAyMYedFYjkZ4nu9NPQRHVh
         o3R1UpKFY/hHhPNPK0A7Hy+N9x0SZpym4rOCwd1i3blDoT7EeCIv5vxOPIwxv4UQEjr1
         7LVFKiOTbugtL/Mnu27Nm+E8aXFWtZ62a1QvHRXiH/VysRPrYUmZlDw8silseXx4YtPZ
         DMI+neJqI+xxfGMPHyDj4x/znx1ef5H0omLll7LP000OAVd+suzN7pTG46RYM1D/Tb03
         udK3hA5up2qF9ihc3xdE9wRpHrjqfIsnwQhqyjZTfdYF2Ae8ckVHDQkUu9hlSMjLsK7m
         L3VA==
X-Gm-Message-State: AOAM532tH1O6bNpKpSJKdu4wkmEAQia4kM0zYjq8y7v5PggrAUqO4qTW
        RJCSkD2ZKgY4rK86vWiC04Moo3VxTlDStw==
X-Google-Smtp-Source: ABdhPJzzgBZSI+eoJ5bG6LcsMNg2v0z1rYrMA+FN4Bvte8xyrfUDP0d3AZeMy/u3TamgbAzhekA7zQ==
X-Received: by 2002:a5d:660b:: with SMTP id n11mr3395190wru.407.1607529145905;
        Wed, 09 Dec 2020 07:52:25 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b7sm4424495wrv.47.2020.12.09.07.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 07:52:25 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Anders Waldenborg <anders@0x63.nu>, christian.couder@gmail.com,
        peff@peff.net, jonathantanmy@google.com,
        Hariom Verma <hariom18599@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/5] pretty format %(trailers) test: split a long line
Date:   Wed,  9 Dec 2020 16:52:04 +0100
Message-Id: <20201209155208.17782-2-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201206002449.31452-1-avarab@gmail.com>
References: <20201206002449.31452-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split a very long line in a test introduced in 0b691d86851 (pretty:
add support for separator option in %(trailers), 2019-01-28). This
makes it easier to read, especially as follow-up commits will copy
this test as a template.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index 204c149d5a4..5e5452212d2 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -717,7 +717,12 @@ test_expect_success '%(trailers:key=foo,valueonly) shows only value' '
 
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

