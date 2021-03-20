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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DEBFC433E0
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D68D461934
	for <git@archiver.kernel.org>; Sat, 20 Mar 2021 22:39:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhCTWii (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 18:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229884AbhCTWiN (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 18:38:13 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70D57C061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:13 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id 61so12735563wrm.12
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 15:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wkikqtckOxxRMS9tyl7Rl5yFN9jrcYkDDHWAvlagGdE=;
        b=OxMsDWPcsq7iBEJc6zeWnm62JIaLWlSHD9VIbuJSDGfr2ecv81PCjy2co5eMlwgs7X
         JPk30XaY+x/8t+5lJor9IjLNLO9nQ/ZcEco9G75hdyIq2yrKFEYJjI08DXFaPfzxxqHm
         X29u+Q0vm9PC7sJSrLKDn4AbYrJX9hfB/yZ2F2aBtKeAadcC6aZ0i3mBZAAR9+RYG5kq
         7jjSAfS9Y5hlVM/Qny/XzSjmedyeylyxRZFAiYLKqD+o0dGuJiRgV10OUI+oY6iOtubb
         XPx28wnDGYsW9+xfbiyqB+QThe/bcz9nsHAh9u4UsuYH/hdOY+p07eExcfB6YyE8YFTe
         nHRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wkikqtckOxxRMS9tyl7Rl5yFN9jrcYkDDHWAvlagGdE=;
        b=RojFyr/qzyCgjgwRXRcwxb+QdAgzbUXL9RTl4WLHLmAIAQtmyCssqk0/xloXw8o822
         J61SWbzFHhSsrNbpZAX5v6hs8sK2kD5zrNDRwRjDSndHJqV2QN0tx0RMnE7g8/wFK0am
         MImltIpcFzKikt3QDWfqp5ZlkK97UeD4EZeAWsIuI/BIQmYLbAZrIMOf+N574f4Le7B2
         Q5Jya/MuKCaXv7Hv1WanrYCduiKMREjqjnrbGWZZQZxD0h2ULQdDqeymgseqhDI0gGfg
         CylH9fuKNB60ltCGE95m/tqJPwJFmycP5hNeD+IL79TvG6KzByLIcLfwUkYCVgWhu2IP
         7NPA==
X-Gm-Message-State: AOAM531y6z/7a97UHbIPtMNEGsrviBTOvHWiPFO0qYydqMNjVIZGgapn
        lBEzHWkS93DuwS9xpLUaHCuLgkNeLTGhmQ==
X-Google-Smtp-Source: ABdhPJzTFFPePROCDwKb83pSnn9XEaqD+i9pCrkQZezTrp8MHLhWJdOmtS8bjCIqyM1TNYImAG10Jg==
X-Received: by 2002:a5d:6a87:: with SMTP id s7mr10979827wru.312.1616279891921;
        Sat, 20 Mar 2021 15:38:11 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v2sm21472697wmj.1.2021.03.20.15.38.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 15:38:11 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 1/8] show tests: add test for "git show <tree>"
Date:   Sat, 20 Mar 2021 23:37:44 +0100
Message-Id: <c307eb53331c3f9c6132aa8c1a493dd5d37ec324.1616279653.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.286.gc175f2cb894
In-Reply-To: <cover.1616279653.git.avarab@gmail.com>
References: <xmqqpmzxy939.fsf@gitster.g> <cover.1616279653.git.avarab@gmail.com>
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
t7701-repack-unpack-unreachable.sh happily pass if we start buggily
emitting trees recursively.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7007-show.sh | 39 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index 42d3db62468..d6cc69e0f2c 100755
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
2.31.0.286.gc175f2cb894

