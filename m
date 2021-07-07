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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EC5BC07E9C
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:21:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 796B461CA8
	for <git@archiver.kernel.org>; Wed,  7 Jul 2021 10:21:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbhGGKYi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Jul 2021 06:24:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbhGGKYh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Jul 2021 06:24:37 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14540C06175F
        for <git@vger.kernel.org>; Wed,  7 Jul 2021 03:21:57 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id n33so1487088wms.1
        for <git@vger.kernel.org>; Wed, 07 Jul 2021 03:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=TkOEYabzD3h7VS0ExMAbyQuxQgU50HerE+NhEoacG1M=;
        b=azMH/KYHOi+08lkqNLBe0LrGilvN4lA8Xc8KcciCPt2hxUkd+tLlxO5boKHmpmfnbY
         tOxMKHpTKLr+NQZyj8xY4A8+S2PM5FUIA0uMDhJfnbIXByPaqbh9DoPjckqBH7E7/ON5
         fF+vM/mO/UhLkDr6khbCV/+9qPltLh3FMab47HmDZZ/zB72votqqy0WkitUDK8yWN4YN
         PenKwQB7XTYdIx5So2vARsaHeDaqVaW9IlavaNKxAOr88TNxh7SsnW5Yg+sTw5s8zT4V
         2nv10VFkZf27HW/fTeSH/nGVW6vzl8flud1sK+PAa2fM6sNnxJygCHdOA95qvSAOjhqy
         oJ/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=TkOEYabzD3h7VS0ExMAbyQuxQgU50HerE+NhEoacG1M=;
        b=JryvW5516v/IsNicB6wJQs+zt39+bxkCiGDMOoARZEXTFfoZitcDAU/FuOBBZK7wl5
         EdGp7LHKSdVjzkkfqVwI/A8GX4BrasVE90mvmeTJTnB2cRJUwOmDlwhfY68bFYWJr4nk
         QoU56FtIOPPfbjqbe8bv7gNW2SHL6ueCEvzVPuY29nR8tERF286zKaV5aSbXwqlO7S1k
         PWLfbzUzYquWWiNdVQm8ZtmTiBCXzBS8YIV/YdjPCh94TDOfbVW9qbjK/mPKyF25pBBe
         KA4EZJy6+weaxNi27yraREkR/jPW6sYNA6Jsj7owHGkRBHczdg3kjowDxI5DgZOS0Jsr
         8aYg==
X-Gm-Message-State: AOAM533HRL/9lLB0xhXbC60mtADxLkMesMzkI1y7N+MtT3lk4aVfDf/X
        W/JKw7UXIUmjihnQglQwO1aLyP1dJovYtA==
X-Google-Smtp-Source: ABdhPJzZbV171Q7VmYUH8fRO7FKW1FeGfEZx8bYtirK9NIx60aOo96oE7r6g1rhri9B9DJ4GgSxBEA==
X-Received: by 2002:a7b:c092:: with SMTP id r18mr26266309wmh.181.1625653315288;
        Wed, 07 Jul 2021 03:21:55 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y8sm19701187wrr.76.2021.07.07.03.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Jul 2021 03:21:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/5] serve tests: add missing "extra delim" test
Date:   Wed,  7 Jul 2021 12:21:45 +0200
Message-Id: <patch-1.5-fcb53980597-20210707T101549Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.636.g43e71d69cff
In-Reply-To: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210707T101549Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the object-info protocol v2 call was added in
a2ba162cda2 (object-info: support for retrieving object info,
2021-04-20) we didn't add a corresponding test here.

We had tests for ls-refs and fetch already since
4845b772458 (upload-pack: handle unexpected delim packets,
2020-03-27), but the same behavior in object-info (which is clearly
copied from the template of "ls-refs") did not have the corresponding
tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t5704-protocol-violations.sh | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/t/t5704-protocol-violations.sh b/t/t5704-protocol-violations.sh
index 5c941949b98..95f68e1d4b7 100755
--- a/t/t5704-protocol-violations.sh
+++ b/t/t5704-protocol-violations.sh
@@ -32,4 +32,21 @@ test_expect_success 'extra delim packet in v2 fetch args' '
 	test_i18ngrep "expected flush after fetch arguments" err
 '
 
+test_expect_success 'extra delim packet in v2 object-info args' '
+	# protocol expects 0000 flush after the 0001
+	test-tool pkt-line pack >input <<-EOF &&
+	command=object-info
+	object-format=$(test_oid algo)
+	0001
+	0001
+	EOF
+
+	cat >err.expect <<-\EOF &&
+	fatal: object-info: expected flush after arguments
+	EOF
+	test_must_fail env GIT_PROTOCOL=version=2 \
+		git upload-pack . <input 2>err.actual &&
+	test_cmp err.expect err.actual
+'
+
 test_done
-- 
2.32.0.636.g43e71d69cff

