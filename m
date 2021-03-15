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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73D86C433E0
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4626164F5F
	for <git@archiver.kernel.org>; Mon, 15 Mar 2021 23:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbhCOXok (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 15 Mar 2021 19:44:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbhCOXoI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 15 Mar 2021 19:44:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EECEC06175F
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:08 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t9so6540135wrn.11
        for <git@vger.kernel.org>; Mon, 15 Mar 2021 16:44:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5XRvbQUaSCZxKF4KUbnIXx+zExCkL9kQ6E9ZbSTCRUE=;
        b=Uk69rG14jbI0xXA+AN3yv62dcOCluo1b9HfTXRE9pc0agrawW6Tysd5dQKH+2BI7iY
         p9gaB1Pk3G0OLfTzK/0BlWBBHxpARgviLAvmQyiAI4RnjvrcMXAlwYb8yOmk4gMVVRfX
         GgCpm2O++RqFPYhgnAy4Clikb1TC+vw2Jl9Nzy4ZAziXwuIKAU0vnXAruE3JIX87mJpS
         PSyCoeidFJ4TfMw2y+ECGb8eh+DwYa0UtILrGAWRwGvoEbim8t/QayQDRmq6iDkW0iDf
         4jkZkRpA1xOvPs+n03NxcFZUElMLP0lb6xX5PF2PxQ9XH2NVRyNWdVp7bv+SpHj1BHxr
         3UbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5XRvbQUaSCZxKF4KUbnIXx+zExCkL9kQ6E9ZbSTCRUE=;
        b=pt9OSG1s+KOCm8ItIdv9rG1IsVWP7yJ+X0SLmyhdj2/Y3hSS3SxNQ942cjBodv829H
         c3Yq/hNhay5vtPzH0swVP8iJ1N02HJ8xZJMfyZ1eu7trzKhrgVH5tq0diGKtMebfAtrp
         E0lxzrJ5lvPihBwhmx/gV/Ys89fNAuWR+Wmrf/kh1QNFa6qJv2MGY4CpMmk9Gb0WIS2Z
         /ZUKgZh/6s2XCFaUDRMVpYESRHs1TUBhpLMvjgX/iF+9t8go6OhBkq5PUXfTWg35Msf/
         x6eoDm/a21WIaihLoUHUXEHBPgPeYcUWjFaKh1ZC6bMhMZ/I1RvX51QOeSRsLLxC0K4Q
         pnMg==
X-Gm-Message-State: AOAM530tziS3yFkp5dSL7xw/QI7a/q3sQ+TUNuNBYJTlsbrbBV2G+ply
        mqcX766Nz4wBODTZfWdfZiEVKTkV7/D0qg==
X-Google-Smtp-Source: ABdhPJyhRPp1LRh5H7XdXjLgBePPHHYAThWd4zYsdmz0V53Z0cF7JMfvcB5fgd+kviIE9ouL+1qFEQ==
X-Received: by 2002:a5d:47ab:: with SMTP id 11mr1864616wrb.153.1615851846822;
        Mon, 15 Mar 2021 16:44:06 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm20417268wrt.70.2021.03.15.16.44.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Mar 2021 16:44:06 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 8/9] show tests: add test for "git show <tree>"
Date:   Tue, 16 Mar 2021 00:43:43 +0100
Message-Id: <20210315234344.28427-9-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.rc2.211.g1d0b8788b3
In-Reply-To: <20210308022138.28166-1-avarab@gmail.com>
References: <20210308022138.28166-1-avarab@gmail.com>
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
index 42d3db62468..37ce718b231 100755
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
+	tree main1:
+
+	main1.t
+
+	tree main2:
+
+	main1.t
+	main2.t
+	EOF
+	git show main1: main2: >actual &&
+	test_cmp expected actual
+'
+
+test_expect_success 'showing a trees is not recursive' '
+	git worktree add not-recursive main1 &&
+	mkdir not-recursive/a &&
+	test_commit -C not-recursive a/file &&
+	cat >expected <<-EOF &&
+	tree a/file:
+
+	a/
+	main1.t
+	EOF
+	git -C not-recursive show a/file: >actual &&
+	test_cmp expected actual
+'
+
 test_expect_success 'showing a range walks (linear)' '
 	cat >expect <<-EOF &&
 	commit $(git rev-parse main3)
-- 
2.31.0.rc2.211.g1d0b8788b3

