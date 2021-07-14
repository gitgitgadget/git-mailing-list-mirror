Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFDB1C07E95
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3CD2611AC
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 00:54:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237199AbhGNA5A (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Jul 2021 20:57:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237113AbhGNA5A (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Jul 2021 20:57:00 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32D98C0613E9
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k32so486582wms.4
        for <git@vger.kernel.org>; Tue, 13 Jul 2021 17:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HC9RNt9ejO/O1yy2AYqthhDhP74VNo4+BUHxfvHwf44=;
        b=JaXxQJ6jx134HKcp0puOEnswWoCJ4wEq9pD7swEn6cl/2lu/0cnd5hIfq5BNXB6I0T
         90Wdv8Bf9x9WqlNtDCKsJqfRzfj3DANMGC/p6NRBpEDPFzzEBkqeXBfQk3p6tZ/CUHEj
         Oyct2KJufFFIL1qvet3FRtscT2KYM3L8P9cAD3cQOJyY5dp8wzoVLAAL5aaDWm+s4b4u
         EGpH1R3PZDyywyMybBXXdkiMRgDeKK9v4bHw9sGHCrlF58lio+3Z3NSEZuyPUtofDpRw
         80Y8dwBbwRzX09CGZ990mOxt3PBrh14TuqY4RUbUb7jeuLVB/lhclvn7JHM5Tg9B3hS/
         hRNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HC9RNt9ejO/O1yy2AYqthhDhP74VNo4+BUHxfvHwf44=;
        b=RGqH91+iCULYX7xl0uQlJTRrQnpbyfbw/ae6bBPxICMe1pD8LTl/8kXMxEPoO3A+Jd
         /Nsxt+V/nBEQVUxAuLxSVb4xfrmFVlGQNqavhP/LG7E8gKYiX7OQUjCZa5W12KEerHM3
         aGk/s8OW7eSx+PXF/MZZhZRjkIsrihKarM6Whl9+0IdUfi7KFtuNFZEVjusW38biXosz
         J6TpGAfg9tesWK4q1OxlW7QD67e1yLjD0vEvwUeYhfI5YwgyETO++2H7lb9ddjEgMEa1
         tfm0zJ3eLiCbWS9UcHgS5B9KVgGhPuxjo9PUwoJ/DbgMUdePg2ETFjhWjAqZ0ycq0LsL
         QgcA==
X-Gm-Message-State: AOAM532tXRhdwxKFP2dzQQfp6gjkIKbwaYWNtHKjdXYexLOmsdhBnFi8
        BKrJXZOQVYOPDtidFju4q9hHquQ0fHZtggzf
X-Google-Smtp-Source: ABdhPJz49lij50qLAG6UwX1utjayeadDXMtU0J4IE/SBYTjESDH0nGI3/OycIjnvPq7eijxYfFfJrA==
X-Received: by 2002:a05:600c:6d8:: with SMTP id b24mr960728wmn.111.1626224047547;
        Tue, 13 Jul 2021 17:54:07 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g3sm463315wru.95.2021.07.13.17.54.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Jul 2021 17:54:07 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/5] serve tests: add missing "extra delim" test
Date:   Wed, 14 Jul 2021 02:54:01 +0200
Message-Id: <patch-1.5-67aa814115-20210714T005115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.788.ge724008458
In-Reply-To: <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210712T164208Z-avarab@gmail.com> <cover-0.5-0000000000-20210714T005115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the object-info protocol v2 call was added in
a2ba162cda2 (object-info: support for retrieving object info,
2021-04-20) we didn't add a corresponding test here.

We had tests for ls-refs and fetch already since
4845b772458 (upload-pack: handle unexpected delim packets,
2020-03-27), but the same behavior in object-info (which is clearly
copied from the template of "ls-refs") did not have the corresponding
tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5704-protocol-violations.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 5c941949b9..95f68e1d4b 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -32,4 +32,21 @@ test_expect_success 'extra delim packet in v2 fetch args' '
 	test_i18ngrep "expected flush after fetch arguments" err
 '
 
+test_expect_success 'extra delim packet in v2 object-info args' '
+	# protocol expects 0000 flush after the 0001
+	test-tool pkt-line pack >input <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	0001
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	fatal: object-info: expected flush after arguments
+	EOF
+	test_must_fail env GIT_PROTOCOL=version=2 \
+		git upload-pack . <input 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
 test_done
-- 
2.32.0.788.ge724008458

