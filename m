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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C406C49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F672613EE
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232792AbhFXT01 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232549AbhFXT00 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:26 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A199C06175F
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:07 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id j11-20020a05600c1c0bb02901e23d4c0977so6339998wms.0
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=r74sy+MCQGW6eg8JXuVZq+Mwu1KQa/1FjO7RH2tQbSQ=;
        b=QeFq8owbdLGePnoU40FzBpokITR+JBIBp9RRuvZv9rqIKo5NT05uqyORFmM0XG4JdY
         ReiTJsOy/eroWt9z1ZOgxLGBmCNIN8hDPn/7R3rtUNECBpSs6onk1gpjvDz1n4VXn50i
         xuy08Daw6Xuh+hLTSiWPGGD12iNyXbslWDLozCWDKhGKvBkQATdOD/7WzrNfGRV441PU
         DmTesQjffoUQYjf/DXnZnriUSSDR3+Cp31csjCeLsS17sqr2FKDzUoFUPTI0tDi7BWlJ
         soztrwU02AVqiHTfpH4PCd1bxrUuEtLcs8UevnnpdwXS3Pb2xCQz+qrBPzqRfswenPdr
         /CLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r74sy+MCQGW6eg8JXuVZq+Mwu1KQa/1FjO7RH2tQbSQ=;
        b=t2KvaKPvzhBHpL0wDmPikqSP/6IYsAVMNhYMr60yK/ldmX4H0kVdQ9EMjZUjDFgEZa
         U/TriPlc/qDg884v008IUWGGyeNHKBMpTc4Yr/dlXo0xYybQp0p/7GOpzHG9jhV0k8MR
         tTAMB9lm4KjfWDn3iNP6Yw9Wmqb5i4YeNRQoHnlI1jWWDfQQ7/+YAesfnGy7c2vi7KSS
         17FLEYUg/SpuGjnknG+477SHcACX2BTvAVfGlnHTMSxGsOhrjMB4qxIPfbxkiqKSkuOR
         Qa3UJBhxUkRo3e72LxLvjsvbg70pJ5UqGrBqldar0oa5bvG2d4QI89bP2YxdSFhm52xd
         kmmQ==
X-Gm-Message-State: AOAM5334M28hfigjSoPnWfEWkiLQwnXAIbpx2Q43eQlAQc7SAmLUxAgt
        5XRmZ+i18J3i3hoX0BKqHnzj6DNUUmyDPA==
X-Google-Smtp-Source: ABdhPJzMc7ZpWonVsATC2CdSAm8fOiMauoXLhUPSIBqygXEUWR9bZjw1anJBd77wmho4tswOL889Rg==
X-Received: by 2002:a1c:6408:: with SMTP id y8mr6223884wmb.30.1624562645441;
        Thu, 24 Jun 2021 12:24:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 02/21] fsck tests: add test for fsck-ing an unknown type
Date:   Thu, 24 Jun 2021 21:23:40 +0200
Message-Id: <patch-02.21-79630a99433-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the fsck tests by checking what we do when we
encounter an unknown "garbage" type produced with hash-object's
--literally option.

This behavior needs to be improved, which'll be done in subsequent
patches, but for now let's test for the current behavior.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 1563b35f88c..f36ec1e2f4a 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -863,4 +863,16 @@ test_expect_success 'detect corrupt index file in fsck' '
 	test_i18ngrep "bad index file" errors
 '
 
+test_expect_success 'fsck hard errors on an invalid object type' '
+	test_create_repo garbage-type &&
+	empty_blob=$(git -C garbage-type hash-object --stdin -w -t blob </dev/null) &&
+	garbage_blob=$(git -C garbage-type hash-object --stdin -w -t garbage --literally </dev/null) &&
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+	test_must_fail git -C garbage-type fsck >out.actual 2>err.actual &&
+	test_cmp err.expect err.actual &&
+	test_must_be_empty out.actual
+'
+
 test_done
-- 
2.32.0.606.g2e440ee2c94

