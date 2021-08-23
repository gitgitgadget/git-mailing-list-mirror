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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62182C4320E
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 42BAF613A5
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 12:13:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237136AbhHWMOh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 08:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236916AbhHWMOS (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 08:14:18 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB854C06175F
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:17 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id n5so13617193wro.12
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 05:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PXech6Rdmiw3MPVLRqAiVSGzLHwp9/VsJlNXOloLqnE=;
        b=gEbppAe6M1Ay7dCfYYgBhazGfJpgFHYBi7w5AttOVTvaJa7H2p1S0FdGrBBFWhL/9D
         YvSMM3VIFTnk5WNxQjiXgzAgjn+6kERrRaqeGnrq7rDQS8TaCwBBjAOQFO8+ww1ENjGc
         xYfTxbU6ZbpW5QmjykcAX6SnKkmgJXP9NoVRGraEb4HzjxOa4UooStIougWitUgzQygC
         zCb9YkWq0mW8l33Biw6ikLNCDJ2l7I2GdWCwoeewAtM0AQKwISJhFcVtICHwEvYAnt3W
         XvJJ2vuJY/lfWQg7CpUAmkTYyT91LPwWfTExR7qvN8eIMzjo/TSH0m3HXLurrox1wiWp
         G6Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PXech6Rdmiw3MPVLRqAiVSGzLHwp9/VsJlNXOloLqnE=;
        b=M4Vd3XDocLuNr4Cw3JlMoS9FUX80Bsu+y/Bgp2xOpSgQQf6MUyE6uVxdvbwdnWYiFT
         EQdk+P1m6ISvhqBNpbZGX9KdwcN8sJ6FFL5+GOf7Cxu0kvy4G/IQ7KTH6UsbIlNOsoVt
         ElzzZsAtZ0wTW4T8Zofp0xOm53Y1lwoj8cbQAi9+JAbywIEbNyMUuMBbNLpeq3dzNMda
         YNTS8gI5Hk+/Pyng1DxQlpcDsMnc2qd+jf7Y8V7xUW3coMStKprtxi1O7gbJjA+X/WMG
         DKaYcsJL19+tcn7Gi8bPS6GTeIV7TqyLFXd6ja+rh3gZ52rQqa/VrH0zrdC18nxsmCId
         ncZQ==
X-Gm-Message-State: AOAM533IWYO8JFkOfDMCX4gzjWmre48KiSil8uWq2yZpqsY5OTSRfgXC
        PhokpAlonPrWYdur9QjN7Kevwu9gXXkLV6YC
X-Google-Smtp-Source: ABdhPJxEWlg/fYgVsedLwNwjQDwi5SUjmHCJQ0fsnWpbRuNXesZ7hQNsAqstDXJ0MeIkhKWPNQdreQ==
X-Received: by 2002:a5d:47a4:: with SMTP id 4mr5692102wrb.329.1629720796074;
        Mon, 23 Aug 2021 05:13:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u10sm14824952wrt.14.2021.08.23.05.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 05:13:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>
Subject: [PATCH v4 24/28] t1401,t2011: parameterize HEAD.lock for REFFILES
Date:   Mon, 23 Aug 2021 14:12:35 +0200
Message-Id: <patch-v4-24.28-c926f1526aa-20210823T120208Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.gbaddc25a55e
In-Reply-To: <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
References: <pull.1054.v3.git.git.1629207607.gitgitgadget@gmail.com> <cover-v4-00.28-00000000000-20210823T120208Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1401-symbolic-ref.sh          | 11 +++++++++--
 t/t2011-checkout-invalid-head.sh | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/t/t1401-symbolic-ref.sh b/t/t1401-symbolic-ref.sh
index 132a1b885ac..1b51013aded 100755
--- a/t/t1401-symbolic-ref.sh
+++ b/t/t1401-symbolic-ref.sh
@@ -102,9 +102,16 @@ test_expect_success LONG_REF 'we can parse long symbolic ref' '
 	test_cmp expect actual
 '
 
+if test_have_prereq REFFILES
+then
+	HEAD_LOCK=HEAD.lock
+else
+	HEAD_LOCK=reftable/tables.list.lock
+fi
+
 test_expect_success 'symbolic-ref reports failure in exit code' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
+	test_when_finished "rm -f .git/$HEAD_LOCK" &&
+	>.git/$HEAD_LOCK &&
 	test_must_fail git symbolic-ref HEAD refs/heads/whatever
 '
 
diff --git a/t/t2011-checkout-invalid-head.sh b/t/t2011-checkout-invalid-head.sh
index e52022e1522..a56f7af442c 100755
--- a/t/t2011-checkout-invalid-head.sh
+++ b/t/t2011-checkout-invalid-head.sh
@@ -22,9 +22,16 @@ test_expect_success 'checkout main from invalid HEAD' '
 	git checkout main --
 '
 
+if test_have_prereq REFFILES
+then
+	HEAD_LOCK=HEAD.lock
+else
+	HEAD_LOCK=reftable/tables.list.lock
+fi
+
 test_expect_success 'checkout notices failure to lock HEAD' '
-	test_when_finished "rm -f .git/HEAD.lock" &&
-	>.git/HEAD.lock &&
+	test_when_finished "rm -f .git/$HEAD_LOCK" &&
+	>.git/$HEAD_LOCK &&
 	test_must_fail git checkout -b other
 '
 
-- 
2.33.0.662.gbaddc25a55e

