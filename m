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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 608BBC49EA6
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3A2F8610C7
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 19:24:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232953AbhFXT0d (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 15:26:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232954AbhFXT0b (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 15:26:31 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26CBC061574
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j2so7861396wrs.12
        for <git@vger.kernel.org>; Thu, 24 Jun 2021 12:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4MtujD+6pMiNA1yl+cJmDv+cTMG3TLBDvf8CgdvgKrw=;
        b=vOMd5qFpxEvGgx/H1r2K2Xdk30SXoZqRC5FOZLZmVRTYDiH52DtoWT2biZD1iJc6Vp
         9VHZ4RJiF+/IkT1KzbGfvs4iawrM+NcO7qjGU/RC5Lcrkj+Lx3/i/pqM9Ta5xg9cnZWG
         PHXBYSgkhpt8AUxrACMV/AF4/jjCiYIfcQwHXL2x37xUaqGLiWfVtHWxsXHHtrlvonml
         z8gI9nRzDp4JB2MWnOzW2/qa6hcNvqF012Hj03vVMcFIaYqLGSKFtiGJ/gWkA86GMGKR
         E+Myl76FQqQmoJx+KB7TF14CvaNEWw1wVQEmuxTf279kzF29qS+is5tupeUx55SmM1EJ
         M+Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4MtujD+6pMiNA1yl+cJmDv+cTMG3TLBDvf8CgdvgKrw=;
        b=Qs7IqDvrNM9ywxjQDRt1bOlcCD1OqI4SKtA7Vf1KlRFhW8geahEpaQlnK8PByBQNZg
         MmoXvmjKkbZp67RFFLYUPCn9WT2VB3XTTGiu8+6GBfxZ3dDMGofQ+qhViJQzC4/MVbn7
         KvfAHKxjgNj1jkMeJCSrVKOkc9nNQbPZ9pyGHBResJ7BuxVOXswjmqZZWFvs2FbyjJ8Z
         /Nx5pnOeWEmAHjyv0DCfLWC/103sfLGNLjbKwoDBbmxMUAabFaPtltxdYf6pnCyp59wa
         PCuMJNJc5mdWqxa5DIY+CiERBTzgM7NSyt5zu9uaKCm+oa1phbqH0zw3sEiS2Y+GOjJE
         WmGQ==
X-Gm-Message-State: AOAM533sha73LjMGse4RywhXH6srtvy9MVFBSNmRN6INKyiAxdWzujq/
        S7n6x0w7Nv2RUBQqpCbuYGbNntDEvEcnLw==
X-Google-Smtp-Source: ABdhPJzLpuvG+B9e5gyVDTORfdkei9p8fBkxmCN+/BQ8FOv3PgE99BgLp4bMgqcUI/3/4dp7wzrVWg==
X-Received: by 2002:a5d:4e0b:: with SMTP id p11mr6417879wrt.132.1624562649986;
        Thu, 24 Jun 2021 12:24:09 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id e11sm3898495wrs.64.2021.06.24.12.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 12:24:09 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Johannes Sixt <j6t@kdbg.org>,
        Jonathan Tan <jonathantanmy@google.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 07/21] cat-file tests: test for current --allow-unknown-type behavior
Date:   Thu, 24 Jun 2021 21:23:45 +0200
Message-Id: <patch-07.21-d797d2e8e9d-20210624T191755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.606.g2e440ee2c94
In-Reply-To: <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
References: <cover-00.17-0000000000-20210520T111610Z-avarab@gmail.com> <cover-00.21-00000000000-20210624T191754Z-avarab@gmail.com>
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
2.32.0.606.g2e440ee2c94

