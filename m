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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3999AC4361B
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 220CE650F7
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:53:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233128AbhCPPxk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237948AbhCPPxA (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:53:00 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E250C061765
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:56 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y16so10751973wrw.3
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=sVCkc2L9MdJuhSkePx0IuyxRZyX7dqx0Hrl9GTag0H8=;
        b=nK1PlUCOXuLyFsAgGPuujGge1uk8DgKE0IHgWBczp8zWIsHgSfR1x3igfN7whvwkqh
         7XV85WtdUaMvm2Tkyab7ab3VRDD2DJ11+b/0EkAt4ohSM54zitErlG/1WRlAKV4Pf3TN
         TDFY4SV3kHy3WrAwpkSn0J+Eor4qzITz7/Az7YV5Gn54Q1qJpFd+wrwpLMyvKEd8mOe+
         Sp+jhblSgHt8kV8tIh4oanIXosQB/BkNyt3xcahYDZH2HqUv9S02hNySxwo2bEx93hyD
         WVy39RMYORdKo9tVR9IMgwAEnwk9PmuG+rEqJCRUo5gpv2AYRCxHxjZAgGaRVaqpBCSl
         Bj8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=sVCkc2L9MdJuhSkePx0IuyxRZyX7dqx0Hrl9GTag0H8=;
        b=lWQcxbnCKZuVeX/v4shRltM090nvERiswGDYO3AsCpA9BEFXUSzGcVL3nRoSOF7svS
         Bigfd++BHD6TD8D8b4q3xRAgkh1dV/8PopZ0Xk2CEmxhc8X3gQGHVaIfHcCQ/ELhLnYK
         wlLgYTJsUek7oP5/Mdim0WTDUUJr1Huj3mdFgkv8AQN2Luav7o3dNN1BRfXJvlbXoWlQ
         mKzAHVt2kmpc+jEB7MYd38kdwTrqJ+RIDCQmgUARtpR/W7ndbc2r5W0/QFbb1jgxq95F
         5wlVsX8hb91m7iVtNPGuclOfDkYYVzssK/0eOYS2X04gb07pObspPfG768aOdlBUS0d8
         SNww==
X-Gm-Message-State: AOAM533dCHSwJ7N0kvMFaip1xUoriU0uQ3eSwOmu1sLR4X+XN8XUV5IX
        ECs/Mk85/OYtHqrbsQonAMVguDPI2zFIDg==
X-Google-Smtp-Source: ABdhPJzDgk6JwBJHxjFoTnYpPqOqxzFSeXHyp7GZ6Ag62HuKsVNMtGYCJcxtKET1syiIuFD9GPph9A==
X-Received: by 2002:a5d:4ac4:: with SMTP id y4mr5612699wrs.86.1615909975002;
        Tue, 16 Mar 2021 08:52:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i11sm22224228wro.53.2021.03.16.08.52.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:52:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 8/9] show tests: add test for "git show <tree>"
Date:   Tue, 16 Mar 2021 16:52:43 +0100
Message-Id: <20210316155244.28328-9-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210315234344.28427-1-avarab@gmail.com>
References: <20210315234344.28427-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add missing tests for showing a tree with "git show". Let's test for
showing a tree, two trees, and that doing so doesn't recurse.

The only tests for this code added in 5d7eeee2ac6 (git-show: grok
blobs, trees and tags, too, 2006-12-14) were the tests in
t7701-repack-unpack-unreachable.sh added in ccc1297226b (repack:
modify behavior of -A option to leave unreferenced objects unpacked,
2008-05-09).

Let's add this common mode of operation to the "show" tests
themselves. It's more obvious, and the tests in
t7701-repack-unpack-unreachable.sh happily parse if we start buggily
emitting trees recursively.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7007-show.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index 42d3db6246..d6cc69e0f2 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -38,6 +38,45 @@ test_expect_success 'showing two commits' '
 	test_cmp expect actual.filtered
 '
 
+test_expect_success 'showing a tree' '
+	cat >expected <<-EOF &&
+	tree main1:
+
+	main1.t
+	EOF
+	git show main1: >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'showing two trees' '
+	cat >expected <<-EOF &&
+	tree main1^{tree}
+
+	main1.t
+
+	tree main2^{tree}
+
+	main1.t
+	main2.t
+	EOF
+	git show main1^{tree} main2^{tree} >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'showing a trees is not recursive' '
+	git worktree add not-recursive main1 &&
+	mkdir not-recursive/a &&
+	test_commit -C not-recursive a/file &&
+	cat >expected <<-EOF &&
+	tree HEAD^{tree}
+
+	a/
+	main1.t
+	EOF
+	git -C not-recursive show HEAD^{tree} >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'showing a range walks (linear)' '
 	cat >expect <<-EOF &&
 	commit $(git rev-parse main3)
-- 
2.31.0.256.gf0ddda3145

