Return-Path: <SRS0=h2Q9=DZ=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1468FC433E7
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 06:11:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B25C82087C
	for <git@archiver.kernel.org>; Sun, 18 Oct 2020 06:11:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zxn2du+A"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725919AbgJRGLC (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Oct 2020 02:11:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725275AbgJRGLC (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Oct 2020 02:11:02 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CF3C061755
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 23:11:02 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id p9so7233112ilr.1
        for <git@vger.kernel.org>; Sat, 17 Oct 2020 23:11:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MXLkuTQcRG5zfj9qf+wm3G0wFF8IjirkTh7vLPUzjc=;
        b=Zxn2du+AKbM7K3drQKaGi3fJwuZWz55dAA+7mu+T8zwwH5nX3DpZJKfDA/APEaN4wi
         LeWidei3Rat9tVKtWw8o7jpl2uUP24pycN3OaVboavRJkpBtNURIqoF9TS45jH8VEZea
         0qvA1iMbpidRJievqbnXvVaAEYi2ExrXBI9JOjzHkyp/DHt1J/d69T9O5dVM7xfwXfZ3
         fRBNmiln+v37+rm9QU4CS0msICf4M+jdfwJc9me9/Q05fg2pekvzI+CnX1PYPtCHVdVl
         AeCWzo2sycqXf0vpbv78rd96VwSSES79bnw+bPInRDEhc0fzkhfmqpT7hTNttZWdil6K
         b6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4MXLkuTQcRG5zfj9qf+wm3G0wFF8IjirkTh7vLPUzjc=;
        b=p8H3/cgV0NvZtYRrX4KGVsiOEiU2MbUijBmUCEGUt2sTGyr/KmZNnFM/dVf+cVTgxp
         vbbHeGfh2ygzl/2nYTBangTEaynaZjreRf1dv/uPoKcbSyZxEbEJLOIoUeXc5xOpHUjp
         //FliYj3nqm7eLOfLecAAuLkiD9kCF3V+4aOGMplCBX0tUFF0WCnB21CJS57AB6ioVa1
         67Q28K1zxm+OhDZLb5oDrEIYKBz3eQnYhdKxcx7shO+Fni9tBR4rmR0BiOCPGHmNuEIx
         sAZj1Hd92+SD2K8FmyjLmhByCRAbIT3Lcnf1kQ9DB3fFJiH3RmlzwRU9WIFHH9JMC40y
         Iefw==
X-Gm-Message-State: AOAM531Tps5KAfAq/6ZuGvB7SR2+pJdo4kg/WwJj8CPHEE/vAelanaNO
        i5+mA53XhgWjbCl9Ovz9UVQgwud0cTYtbw==
X-Google-Smtp-Source: ABdhPJx2I8FeBLIqGHslDVH1CgSU09ciUI9L0N8NPCezA+JXXH1ICzwCzSnD5cIun7E8VVh4SdE/MQ==
X-Received: by 2002:a05:6e02:f85:: with SMTP id v5mr7677486ilo.47.1603001461102;
        Sat, 17 Oct 2020 23:11:01 -0700 (PDT)
Received: from localhost.localdomain ([45.56.140.65])
        by smtp.gmail.com with ESMTPSA id g17sm6554670ilq.15.2020.10.17.23.10.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Oct 2020 23:11:00 -0700 (PDT)
From:   Caleb Tillman <caleb.tillman@gmail.com>
To:     git@vger.kernel.org
Cc:     Caleb Tillman <caleb.tillman@gmail.com>
Subject: [Outreachy-Microproject][PATCH 1/1] t0000: replace 'test -[def]' with helpers
Date:   Sun, 18 Oct 2020 06:10:52 +0000
Message-Id: <20201018061052.32350-1-caleb.tillman@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The test_path_is* functions provide debug-friendly upon failure.

Signed-off-by: Caleb Tillman <caleb.tillman@gmail.com>
---
Outreachy microproject, revised submission.
 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 923281af93..eb99892a87 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
 test_expect_success 'git read-tree followed by write-tree should be idempotent' '
 	rm -f .git/index &&
 	git read-tree $tree &&
-	test -f .git/index &&
+	test_path_is_file .git/index &&
 	newtree=$(git write-tree) &&
 	test "$newtree" = "$tree"
 '
-- 
2.25.1

