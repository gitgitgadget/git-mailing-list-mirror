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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4EF3FC433EF
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 328AD60F6D
	for <git@archiver.kernel.org>; Tue,  7 Sep 2021 10:58:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343882AbhIGK7s (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Sep 2021 06:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343816AbhIGK7g (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Sep 2021 06:59:36 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB089C06175F
        for <git@vger.kernel.org>; Tue,  7 Sep 2021 03:58:29 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b6so13775494wrh.10
        for <git@vger.kernel.org>; Tue, 07 Sep 2021 03:58:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aZ5/7jrpsvS9HxZBssXcFY7qHBSYN3VAo6Q72TRhCYY=;
        b=D5vE9rWoHKay37Po61u5B2mG20QCjfMDu0EeaRJ4LZZzqHfb3GkOLVm8iBlw5DqIvT
         zNsR9wIWT00yVGL1nu5IvjtmXy2jHN0F4VEVHCdPwe7bDb6k1wqd1U+4xssIE9xjPNWA
         LQ19spKP9CyeHmorP0E7vZyak1Eesl18XL23Lx8/h0tG2QuOYV2/KyohnFCnttSTl3wW
         CjR4goc2zSWe9NwsG0sXxadebpUI5XdAKK+MGIWi9RhfkNPgKqi7powFNDJh7Lh/hh/+
         rztZwlwBTx7IkzduUVCYWndCQ7r2zVnDw9RGFp8pVmEVJwyM0sEZtIxPij6mYGdOLqSM
         A+9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aZ5/7jrpsvS9HxZBssXcFY7qHBSYN3VAo6Q72TRhCYY=;
        b=HhW/zYRJDVeNQKMIHHUsz78fhd8JhirChZpZTkAY5NUNTmJy9j4/5GwvSpEK7p8RKz
         ACVUr+XhIINRAgKWiNntaa7ySzr77gdbJuvSVXzbC419FPbdVHUcuBUykE7JFq5cDCD2
         OlzNf4VNA15YHzOB3fiCyd+HCSC5TBMO+2JqDyYThDI3nNJq5lzMr55y4Vw27uAsj6Jh
         aJer1veTjzZhdUxmItNO6V/z7gMuc5Z7PPW3jYzOvtvceXFfdvQkRaUwNHEvZbjUjJG4
         YxBpR9TJiUsWCpNeX8MqvCjgeUZGpVBl3vImlMP1x8TA5/GS5gHKK1BaEE3l1Jb/H6cX
         /1Zw==
X-Gm-Message-State: AOAM533LtMd7mrG5D+GVBhF9aUoQm3sbnnaUD2bHPz0zDsFl3PSU/V74
        5voGCHCN16Lcsy7bQsH+kPtAgJepLl+TJw==
X-Google-Smtp-Source: ABdhPJx8CGLI5nEtTuLOPcrjhfYGI67HvZ+qjcVLknzmIYpcYOzYH7ehot0xlqi4ybzI3k7esgf27Q==
X-Received: by 2002:adf:fb8f:: with SMTP id a15mr18328781wrr.92.1631012308279;
        Tue, 07 Sep 2021 03:58:28 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l16sm8255602wrh.44.2021.09.07.03.58.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Sep 2021 03:58:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 05/22] rev-list tests: test for behavior with invalid object types
Date:   Tue,  7 Sep 2021 12:58:00 +0200
Message-Id: <patch-v6-05.22-82db40ebf8a-20210907T104559Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.815.g21c7aaf6073
In-Reply-To: <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com> <cover-v6-00.22-00000000000-20210907T104558Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a blindspot in the tests for the "rev-list --disk-usage" feature
added in 16950f8384a (rev-list: add --disk-usage option for
calculating disk usage, 2021-02-09) to test for what happens when it's
asked to calculate the disk usage of invalid object types.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6115-rev-list-du.sh | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/t/t6115-rev-list-du.sh b/t/t6115-rev-list-du.sh
index b4aef32b713..edb2ed55846 100755
--- a/t/t6115-rev-list-du.sh
+++ b/t/t6115-rev-list-du.sh
@@ -48,4 +48,15 @@ check_du HEAD
 check_du --objects HEAD
 check_du --objects HEAD^..HEAD
 
+test_expect_success 'setup garbage repository' '
+	git clone --bare . garbage.git &&
+	garbage_oid=$(git -C garbage.git hash-object -t garbage -w --stdin --literally <one.t) &&
+	git -C garbage.git rev-list --objects --all --disk-usage &&
+
+	# Manually create a ref because "update-ref", "tag" etc. have
+	# no corresponding --literally option.
+	echo $garbage_oid >garbage.git/refs/tags/garbage-tag &&
+	test_must_fail git -C garbage.git rev-list --objects --all --disk-usage
+'
+
 test_done
-- 
2.33.0.815.g21c7aaf6073

