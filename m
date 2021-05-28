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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64149C47087
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43AD1611C9
	for <git@archiver.kernel.org>; Fri, 28 May 2021 12:11:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236297AbhE1MNW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 May 2021 08:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235255AbhE1MNU (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 May 2021 08:13:20 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30CE8C06174A
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:44 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id n4so3102883wrw.3
        for <git@vger.kernel.org>; Fri, 28 May 2021 05:11:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MlicDSbKY3+IsStW6iHd8sEA8jZjwjf/HhdAOmz7pVM=;
        b=Sz+DuW7e0xK3AcCcl2/Ziq0JUQ6IJCtR4TWwYVb4UWCoNo9qldxuJ4JVSV5bwu0yne
         ro3sC+75AvM1J0P8Ve9I3tKNvFpm3m+Rw7xCdNmJ5/yDFaSeGzRhrEuZ5NidRhkLJ7Yv
         cI3f6d3QpBzMjFrPiX4ApOFL24UjZ7c1pb1HJQZa+AThIPvbDXjrn7XafGJL/OdY9hI7
         atG1C0A4lK8G1X8DNpXACADfio2mrg9awLxHKhwNuXtSfHmM0iExIu14u2fu4UVRoZIv
         fofTilb5x3Uu8DI8eq14TS+VqOvJ84Ql60rKE1svdgDe+D4Q7nH6IrP85DFZ1hAZNGJ3
         b4XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlicDSbKY3+IsStW6iHd8sEA8jZjwjf/HhdAOmz7pVM=;
        b=JYoy7Y16x64YnE80Eny2KK2lLJGDYf3e33d2HxboBRMw1g2Iad/JY1Qb+9HyXbkUCF
         3R2I9LuXzqNhErEhQ+26APIN59D12wR6gdZJpzDsU0RAkuKvvP/EEGcK0Z6WxZu/2iHR
         oGdCE/61C2Atdtza/DdmH0FZlRIG3/XLb6si9mefeQ0nYX39UJNJsPMg441WLv/AB3Ot
         +ArUINHQ9eywM/vd/6t8AJ+TYB9WGk2g5w3JtplBBvXWHZ6y1FnviFrLaJLBobS6b87N
         JDfHS4kBVBvcRogCbYW+ZZ6R2huNK1y0jxPMTNfvr9HA+LqZj9ta7+FQLe49hHWHAkSA
         eGUg==
X-Gm-Message-State: AOAM533c0atqhnSkrqWqr7dyVJkqoTGD7kEaTbihg/06/on9rbJTBodn
        5ETRICbncIKCO1ILvfVvWCLAe7E9DcSLcw==
X-Google-Smtp-Source: ABdhPJzUDf5ORsojsK31YQP5FfygWzu8wVQFTm4xZvQ3kuOCdCBmr4r895agmwQGVJiNnSVzrrvvsQ==
X-Received: by 2002:adf:d081:: with SMTP id y1mr8258756wrh.179.1622203902492;
        Fri, 28 May 2021 05:11:42 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c15sm7372269wro.21.2021.05.28.05.11.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 May 2021 05:11:42 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Josh Steadmon <steadmon@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/31] gc tests: add a test for the "pre-auto-gc" hook
Date:   Fri, 28 May 2021 14:11:04 +0200
Message-Id: <patch-02.31-eb37693f7dc-20210528T110515Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.rc1.460.g26a014da44c
In-Reply-To: <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
References: <87lf80l1m6.fsf@evledraar.gmail.com> <cover-00.31-00000000000-20210528T110515Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a missing test for the behavior of the pre-auto-gc hook added in
0b85d92661e (Documentation/hooks: add pre-auto-gc hook, 2008-04-02).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t6500-gc.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index 60d961b5260..10c7ae7f09c 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -95,6 +95,52 @@ test_expect_success 'gc --keep-largest-pack' '
 	)
 '
 
+test_expect_success 'pre-auto-gc hook can stop auto gc' '
+	cat >err.expect <<-\EOF &&
+	no gc for you
+	EOF
+
+	git init pre-auto-gc-hook &&
+	(
+		cd pre-auto-gc-hook &&
+		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
+		echo >&2 no gc for you &&
+		exit 1
+		EOF
+
+		git config gc.auto 3 &&
+		git config gc.autoDetach false &&
+
+		# We need to create two object whose sha1s start with 17
+		# since this is what git gc counts.  As it happens, these
+		# two blobs will do so.
+		test_commit "$(test_oid obj1)" &&
+		test_commit "$(test_oid obj2)" &&
+
+		git gc --auto >../out.actual 2>../err.actual
+	) &&
+	test_must_be_empty out.actual &&
+	test_cmp err.expect err.actual &&
+
+	cat >err.expect <<-\EOF &&
+	will gc for you
+	Auto packing the repository for optimum performance.
+	See "git help gc" for manual housekeeping.
+	EOF
+
+	(
+		cd pre-auto-gc-hook &&
+		write_script ".git/hooks/pre-auto-gc" <<-\EOF &&
+		echo >&2 will gc for you &&
+		exit 0
+		EOF
+		git gc --auto >../out.actual 2>../err.actual
+	) &&
+
+	test_must_be_empty out.actual &&
+	test_cmp err.expect err.actual
+'
+
 test_expect_success 'auto gc with too many loose objects does not attempt to create bitmaps' '
 	test_config gc.auto 3 &&
 	test_config gc.autodetach false &&
-- 
2.32.0.rc1.458.gd885d4f985c

