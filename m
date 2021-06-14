Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B0E2C2B9F4
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:29:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F35EE6023E
	for <git@archiver.kernel.org>; Mon, 14 Jun 2021 17:29:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235553AbhFNRbv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Jun 2021 13:31:51 -0400
Received: from mail-ed1-f45.google.com ([209.85.208.45]:34676 "EHLO
        mail-ed1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbhFNRbu (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Jun 2021 13:31:50 -0400
Received: by mail-ed1-f45.google.com with SMTP id cb9so47614361edb.1
        for <git@vger.kernel.org>; Mon, 14 Jun 2021 10:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/jpJVRnkB1L+V+Uqt/jbB4jvJFO0VP24uMxtZFsOE7U=;
        b=aThW4LT9IJG7pkZWgeZDjiiWWkXX7zkWKDbPGizulElYox9+s114Vhld4hkqPx5dTD
         w6lDb7MYgDCwEHQ74nGpgfrLgKl8INSs1dPBtLqTGYnv3nkkJz0X4FaTt1BE/CZviA2H
         S+CymjwfsX4RUUjZ/a1FU/4mQ/KHtf4c6wKxB/dkqOX9gDuAi0lw7P0YlUPqnwYA+y8Y
         /+qi71wHA+c1w9IgBw+lJMt0X0847ZrypG6hiSx5NxvxOOzF/vtVESG7ki5+AxuCi7Ll
         ohNVMOixn0wek9oCo97WDqP/rJhU76k0JbACVnXaZCaoqEkr35E8+7nmWiXx4EEkaGQ7
         gZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/jpJVRnkB1L+V+Uqt/jbB4jvJFO0VP24uMxtZFsOE7U=;
        b=SAvknb2IYVL72WZRHuNm/fJgwfJorsBNihPdQrKKkTg60JLI1Wa0+vdrFlbOCbcbiI
         ydBHltezHMCrmDu1TnR+AtVTcSijQV0/u3oojOzL46C9VKj1pBdrIwsOGnDl8gtIdo0I
         U4K59uvYn1ErxojrnPmVgAQFfbvbquyiqgNvlHYNMtX/sTCI7MF4QYNSKlFf+GcMSvLi
         EyNYQVcKqoaLJheDEHt1Zv7Y8O6ejGn9o/H1UaG64HHIYdQdSYslZJWEqo2RTezGCFF5
         85Nh9DRw5AN0ZhCv5cu9o2g4pQHABDUXfxd9md9wNK5sSj8BKvqKhMvTl8lgZ0geg39K
         ufYQ==
X-Gm-Message-State: AOAM530zdUuyinSrkSdLJqoyJCVUAurWr92/thgSRf/33rQ3OKn0UZUL
        jF3x8ebvorhu7ZLPxPweO8iEbwzK7h8B7w==
X-Google-Smtp-Source: ABdhPJy5HbZYO3HjgrfZUNZ/BjLgrTdxi+zMLMFPrnaQ2SZVmiszh5+6tUf378Aj6Lzv9TRGqd+0Fw==
X-Received: by 2002:aa7:c818:: with SMTP id a24mr18859288edt.53.1623691709926;
        Mon, 14 Jun 2021 10:28:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a24sm9376233edt.96.2021.06.14.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Jun 2021 10:28:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/6] mktag tests: test for-each-ref
Date:   Mon, 14 Jun 2021 19:28:22 +0200
Message-Id: <patch-5.6-8a626fc63a1-20210614T172422Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.555.g0268d380f7b
In-Reply-To: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a "for-each-ref" for all the mktag tests. This test would have
caught the segfault which was fixed in c6854508808 (ref-filter: fix
NULL check for parse object failure, 2021-04-01). Let's make sure we
test that code more exhaustively.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index f5a51d11f81..7d0ad3c8e62 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -50,7 +50,7 @@ check_verify_failure () {
 		rm -rf bad-tag &&
 
 		git init --bare bad-tag &&
-		git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig
+		bad_tag=$(git -C bad-tag hash-object -t tag -w --stdin --literally <tag.sig)
 	'
 
 	test_expect_success "hash-object & fsck unreachable: $subject" '
@@ -75,6 +75,16 @@ check_verify_failure () {
 		# will always fail.
 		test_must_fail git -C bad-tag fsck
 	'
+
+	test_expect_success "for-each-ref: $subject" '
+		echo "$bad_tag" >"bad-tag/$tag_ref" &&
+
+		printf "%s tag\t%s\n" "$bad_tag" "$tag_ref" >expected &&
+		git -C bad-tag for-each-ref "$tag_ref" >actual &&
+		test_cmp expected actual &&
+
+		test_must_fail git -C bad-tag for-each-ref --format="%(*objectname)"
+	'
 }
 
 test_expect_mktag_success() {
-- 
2.32.0.555.g0268d380f7b

