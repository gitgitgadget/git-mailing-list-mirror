Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FDDBC11F66
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E926613C2
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 13:37:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbhGJNk2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 09:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbhGJNkX (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 09:40:23 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2689DC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:37 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id t5so2645650wrw.12
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 06:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5xgIl1pTpg0BPbreigDZ4CheXIt1UgPqr3BtcDUT9xY=;
        b=QaNpcCv+3opECwtoximP1B3yCMIsT8zu1gERhwvx2F1CHRKAOYg7A72LqC52azMDeC
         kZ+LaWFutkKU7soQFBPkM/ai5A9XKOG1bt0AK9/GcV++ydrBYiAZOjOD4wWb45hQBTgb
         +m+F273XmrsVRa7bkGWERF/ivM2yVbJ7UifoFbdHE7q//JZowT5OxQt56bp02Y1UpNmp
         LvueCiwaBpzqCMK2lM1WZ+kVThnftaz1FqjUDrH76RomSp5mI/72d50AKc/bXcCA5wLd
         GKshJHwT1pPmMW545jxiXE5V5sJHNNI+27oyHoE1naG64/Rrngl2hdjRYBZRso75R/5c
         bM1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5xgIl1pTpg0BPbreigDZ4CheXIt1UgPqr3BtcDUT9xY=;
        b=dIZtpdttlEOIZBEZ1eYVpQw/eYkq2yoaAzNgRFEePkdvVaE+8RoR7hxtOy3ZgWOOsp
         mY3E2xGLu+6/57dFN61A37Da0SebhLZWD9TfDlubbab+TJKHJzAJUZGsrUkdpGjTwEnA
         Gc7rYfxRbUiBjHbCd5tlysxyx+ChA6osbOB+HGDqJ5rv4v/HSHUXo3eheKCJ46AN8Y52
         CV7c7Ud8pJ4cXHaT2ZLPmEKhOTXH028yO8JlUxWrknjwS+Z9lnOA6X1CLkkYFpjV2bsD
         9wg5MXvqkA8ZUNTINby7s3qM3CmdFWrv9A97elVNImMLL/ngF6bQjkKfKgHZ65f4g85T
         fkpA==
X-Gm-Message-State: AOAM531Ptfoig80q+BAjwDvzbcXAkPSnWZrRwDyGmF88l1yrrrwhJTlu
        nEb9nmjCkoi/jaXHPx3vdhppDQwkFdmbdQ==
X-Google-Smtp-Source: ABdhPJyAk2NoihiGqzvOPeE4L2cR77zxaVCqm4PycuUVL3CN0+llksMyz/Su0JyfC60OLZEju0nskQ==
X-Received: by 2002:adf:f346:: with SMTP id e6mr31177803wrp.28.1625924255547;
        Sat, 10 Jul 2021 06:37:35 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id j17sm17612787wmq.9.2021.07.10.06.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 06:37:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Andrei Rybak <rybak.a.v@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 07/21] cat-file tests: test for current --allow-unknown-type behavior
Date:   Sat, 10 Jul 2021 15:37:10 +0200
Message-Id: <patch-07.21-a00dfea3fb8-20210710T133203Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
References: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com> <cover-00.21-00000000000-20210710T133203Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add more tests for the current --allow-unknown-type behavior. As noted
in [1] I don't think much of this makes sense, but let's test for it
as-is so we can see if the behavior changes in the future.

1. https://lore.kernel.org/git/87r1i4qf4h.fsf@evledraar.gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 61 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 7f10a92f0e4..86fd2a90ca7 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -361,6 +361,46 @@ test_expect_success 'die on broken object under -t and -s without --allow-unknow
 	test_must_be_empty out.actual
 '
 
+test_expect_success '-e is OK with a broken object without --allow-unknown-type' '
+	git cat-file -e $bogus_sha1
+'
+
+test_expect_success '-e can not be combined with --allow-unknown-type' '
+	test_expect_code 128 git cat-file -e --allow-unknown-type $bogus_sha1
+'
+
+test_expect_success '-p cannot print a broken object even with --allow-unknown-type' '
+	test_must_fail git cat-file -p $bogus_sha1 &&
+	test_expect_code 128 git cat-file -p --allow-unknown-type $bogus_sha1
+'
+
+test_expect_success '<type> <hash> does not work with objects of broken types' '
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type "bogus"
+	EOF
+	test_must_fail git cat-file $bogus_type $bogus_sha1 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'broken types combined with --batch and --batch-check' '
+	echo $bogus_sha1 >bogus-oid &&
+
+	cat >err.expect <<-\EOF &&
+	fatal: invalid object type
+	EOF
+
+	test_must_fail git cat-file --batch <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual &&
+
+	test_must_fail git cat-file --batch-check <bogus-oid 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
+test_expect_success 'the --batch and --batch-check options do not combine with --allow-unknown-type' '
+	test_expect_code 128 git cat-file --batch --allow-unknown-type <bogus-oid &&
+	test_expect_code 128 git cat-file --batch-check --allow-unknown-type <bogus-oid
+'
+
 test_expect_success "Type of broken object is correct" '
 	echo $bogus_type >expect &&
 	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
@@ -372,6 +412,27 @@ test_expect_success "Size of broken object is correct" '
 	git cat-file -s --allow-unknown-type $bogus_sha1 >actual &&
 	test_cmp expect actual
 '
+
+test_expect_success 'the --allow-unknown-type option does not consider replacement refs' '
+	cat >expect <<-EOF &&
+	$bogus_type
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual &&
+
+	# Create it manually, as "git replace" will die on bogus
+	# types.
+	head=$(git rev-parse --verify HEAD) &&
+	mkdir -p .git/refs/replace &&
+	echo $head >.git/refs/replace/$bogus_sha1 &&
+
+	cat >expect <<-EOF &&
+	commit
+	EOF
+	git cat-file -t --allow-unknown-type $bogus_sha1 >actual &&
+	test_cmp expect actual
+'
+
 bogus_type="abcdefghijklmnopqrstuvwxyz1234679"
 bogus_content="bogus"
 bogus_size=$(strlen "$bogus_content")
-- 
2.32.0.636.g43e71d69cff

