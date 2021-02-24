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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BC81C433DB
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E761464F07
	for <git@archiver.kernel.org>; Wed, 24 Feb 2021 19:58:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235189AbhBXT5v (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 24 Feb 2021 14:57:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbhBXTyC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Feb 2021 14:54:02 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB480C0611BC
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id j187so2806274wmj.1
        for <git@vger.kernel.org>; Wed, 24 Feb 2021 11:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VTwTfO2Vsf34BBWSStSex3cH9HB1CCCFG4WlnLZ4Jis=;
        b=NOB2adVFe3SG0O4Ej+Uoutb3y12KsOZC81iCyROwIqQHSWCKN3B6cNjVLB7w/VZvjv
         2m9vB9E++R7ZVe+VLTrBgzrHMRBJZLEtLUgAfVXsY8X4KYbrVhE2+LRwxkSyp5YY5Kdi
         tfKIcS7qxFEFuOptEm9k9eiQYsiu1YnxoYrWlvp7XMBP0S9uIyk60AMz8CfyXvlOZjff
         ZnyP/9sBrNBaVDVgz/s6IsLJ5tX2YDIneSDin3P+gkTUQNRlx0OQMB3Mx0VyDBw6Ohnr
         I/1CcoCWburDUTdLJ+HlL7kQDC1eKcVZyhLtlNQJ3Vk4GXPlaw8ESqIN8DIr5sbfU4+I
         65GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VTwTfO2Vsf34BBWSStSex3cH9HB1CCCFG4WlnLZ4Jis=;
        b=gJU37ipdZsKmAK0TBB7+HgM1aPTSFgDUbwrsLr9NaJGuN4Mf7q93qlm+IQ1SI+2yG0
         TABc3BCGN8L4s9gh3ovxPAykv0vSTkXFDcvr7B1hJB5RtY4Az9fj2x+PzuXMtCxiBf1b
         nAPnQ8Qfm8vTyVU503xmC0VA28D0Uvj33pEe+kjhTRmVnRcxt3aS3nd95LG+3P3LpA33
         4teVlwHIuz7LR9cKfO3qRQrHDiu6yszz4/RvViJW+Hx0YZ9FnDoX7gCzGR3mYkaI+xNx
         6UUBMW9hqH7WxRYiJgYQgMIGBU0VerHOPgU/g1Fxb7pTRRrZR1992kwLbJ6fKkw47HSP
         Toog==
X-Gm-Message-State: AOAM5326PEI2DI6/HVLMdNUXZZCMFk6l8FlCtSEU9/ukP8KotppnL05T
        mfilTDzCzTxes8lUoT+i/o7ehrWPjX5MgA==
X-Google-Smtp-Source: ABdhPJzrQUKjRrffT/5kwi0E3aDa2IA801Bx8Qw8bW6HTDFsJHa0EjxowUMbLhVFU91WQdCA3lC0TA==
X-Received: by 2002:a1c:7312:: with SMTP id d18mr5162696wmb.155.1614196336307;
        Wed, 24 Feb 2021 11:52:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y2sm4786072wrp.39.2021.02.24.11.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Feb 2021 11:52:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Adam Spiers <git@adamspiers.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Chris Torek <chris.torek@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 28/35] userdiff tests: assert empty hunk header context on -U<large>
Date:   Wed, 24 Feb 2021 20:51:22 +0100
Message-Id: <20210224195129.4004-29-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210215154427.32693-1-avarab@gmail.com>
References: <20210215154427.32693-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Assert the existing behavior that under -U<large> we'll show no hunk
header context, where <large> takes us past the potential hunk header
we'd have extracted.

I'm just picking a number over nine thousand as a really large number
we're unlikely to exceed in these tests.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4018-diff-funcname.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/t/t4018-diff-funcname.sh b/t/t4018-diff-funcname.sh
index ca23d156666..ba10d1f5313 100755
--- a/t/t4018-diff-funcname.sh
+++ b/t/t4018-diff-funcname.sh
@@ -130,6 +130,13 @@ test_diff_funcname () {
 		test_cmp expected actual
 	' &&
 
+	test_expect_success "$desc -U9001" '
+		git diff -U9001 "$what" >diff &&
+		last_diff_context_line diff >actual &&
+		echo >blank &&
+		test_cmp blank actual
+	' &&
+
 	test_expect_success "teardown: $desc" '
 		# In case any custom config was set immediately before
 		# the test itself in the test file
-- 
2.30.0.284.gd98b1dd5eaa7

