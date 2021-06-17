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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C72A2C2B9F4
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF39B60FDA
	for <git@archiver.kernel.org>; Thu, 17 Jun 2021 10:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231903AbhFQKoY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Jun 2021 06:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231984AbhFQKoT (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Jun 2021 06:44:19 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C51AC061574
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id y13-20020a1c4b0d0000b02901c20173e165so3429921wma.0
        for <git@vger.kernel.org>; Thu, 17 Jun 2021 03:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=A11HEYz9uf6kil7FsMfFll+6e0aKtiYD9p0x+lCJ9tI=;
        b=McLW62SVBEa++ff6+vp1oM4WD+JsLwKXkWBpUdYzvtM09iv6BIAmVI+/yxe89I8/GR
         Q2IWCivbZQWrmk2oMf6NOmIECijKmSAhU56QCfWTUHhwMSMt9MprRrxihLXCnNTLHVkQ
         Ihww7e5IMfG9GW9136YzmU1L5u3Gk5OPTWG0cPR0e1FQB8ILhazKf+IfwjZv5ffNtr2E
         Q4F94j3dlnZF1N6YLmMF75m9RKadr7Xv6GMy4hrc8Nhwlem3lmpteR7fFE1x7Gsxkh0I
         39C+chd0l2/r/nS+EHym0MWgtg/nTgzlBlkiQrmKwWTG+eJfxpwJDGaSLpxWUCcReBEi
         7J2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=A11HEYz9uf6kil7FsMfFll+6e0aKtiYD9p0x+lCJ9tI=;
        b=MLmk3VwAFwZATMbea7Q+Fhrz94xGVcgywnuplZQ/d4RaJjZ/NgQzm8nTaVkZY1N/yW
         QkgJIwJasKlCDKUH4YHup5ZyMoNaAjVw8Z2go3C0Dp3f6EcU+UH0+4tnh1mYLyKt2bDO
         M0oTUM52nEzXB5+Fl5KpOs/E4VxvMgPAPP3pqjbkn0b2izbQKBzBTTqF4k0ikamHwcIz
         fgj/AVkFT+RT8wJyk1Qwh3pr5A3ALuPETwu6maWhTiBIASQMO7ykebKA4MgtmVF3Ufh4
         nnljxRSmsG58Xz9JPaZECjZoe5yNZ+el7CIm9lIM/BJZmvK2Y/urQ1Kvd+X3M489S+qV
         I7Gg==
X-Gm-Message-State: AOAM5332UGnzv47BKYyP/bO3whiQWRo/cuioeHFzMVXTLZStVssR99FO
        6ayOO9lrrWBVxSaHVSsm8W0G/cGMGQN/yA==
X-Google-Smtp-Source: ABdhPJw3ZGs1lZoWl+De+kVG84hQ9fl1hnw8nrzjZ6+aFTE2Bdu0q1crVs0i8igvOjDz0VN3r3+Pzg==
X-Received: by 2002:a1c:a901:: with SMTP id s1mr4299154wme.184.1623926529059;
        Thu, 17 Jun 2021 03:42:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id p10sm4784607wrr.33.2021.06.17.03.42.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Jun 2021 03:42:08 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Olga Telezhnaya <olyatelezhnaya@gmail.com>,
        Jeff King <peff@peff.net>, Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 6/6] mktag tests: test fast-export
Date:   Thu, 17 Jun 2021 12:42:02 +0200
Message-Id: <patch-6.6-797c8d3a87-20210617T104011Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.571.gdba276db2c
In-Reply-To: <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20210614T172422Z-avarab@gmail.com> <cover-0.6-0000000000-20210617T104011Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Pass the bad tags we've created in the mktag tests through
fast-export, it will die on the bad object or ref, let's make sure
that happens.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index bb71303399..0544d58a6e 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -91,6 +91,14 @@ check_verify_failure () {
 
 		test_must_fail git -C bad-tag for-each-ref --format="%(*objectname)"
 	'
+
+	test_expect_success "fast-export & fast-import: $subject" '
+		# Make sure the earlier test created it for us
+		git rev-parse "$bad_tag" &&
+
+		test_must_fail git -C bad-tag fast-export --all &&
+		test_must_fail git -C bad-tag fast-export "$bad_tag"
+	'
 }
 
 test_expect_mktag_success() {
-- 
2.32.0.571.gdba276db2c

