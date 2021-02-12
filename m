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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A999C433E9
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:30:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F38DB64E57
	for <git@archiver.kernel.org>; Fri, 12 Feb 2021 13:30:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231695AbhBLNau (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Feb 2021 08:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231594AbhBLNai (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Feb 2021 08:30:38 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F33C061788
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:58 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id u14so995877wmq.4
        for <git@vger.kernel.org>; Fri, 12 Feb 2021 05:29:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ga3hjK3G5BR1k22dRx4nay7A20oGKzQf2iEzgH13uP8=;
        b=Yi6rAKUWkdsFoM/wb5x4ppQjHdd9AP9wjftJurRcIbRhr4PCQpNa7nAwnuNDId8cqS
         6X5mm4AnRfRCdwiaAjt2JqUzO2Y0+0rkb8lxiaY6aYtnfGXQPNGCpUxwqjhWwKAwBU5P
         TnsSW2bupgwv60yLxlelxHqRIprvCthoXVvnTP6dXmdZFhYyRNPReQN/bxcI7Hl+Accc
         X11vPPDMV73e9QN+EYx9XiZ0gN2ifux1Cl63w5LbIKgWtCAiQdRhZ1g+dubjnLUC5n5Z
         ZTcM26fFwcYKwadEmat9brSzwAoMKdNwgmB/xB+aZVZHEwGm99LoMEKL9GXlTDTXbkmr
         diyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ga3hjK3G5BR1k22dRx4nay7A20oGKzQf2iEzgH13uP8=;
        b=aHsJh3cTSlxMkO5wrMkURfe2OkdsqYp4O3KgMGsWl8Syo5wwm9EbupLIUtFytHoee1
         9yPFLNH4ht4HTl1kEruBwHlyUi/vTo+7Ikgim4S96hf72kh+tPJzS6xbW4QgJj8Ml3Yg
         ZKjihnRh1QUCP1YvOFlvliBTrvpjkdpKEaDdxVMEAIF9ZbMbmix6tMlCJ1GJoYbC8UQ2
         MW1TD3EiMhOEP09iBGjeAJ0MxOrd/mIN1KICDidoEmyQ2i5yYjyzF56etEeoUb6alZNX
         wng72eAefJEPSgwnBINNJm1IP3riwZm78LDziPIDv8wk+vXNzSci3cTThxK1cUbWgeng
         4AKQ==
X-Gm-Message-State: AOAM531ToFJIKysBSIRLfpyeAs2B+DPaQozw3Wcd4YnxEKMvEjUcNgx3
        QeRXX/iXhlXjliYXmB3+ZWeXkbBLXHz7+w==
X-Google-Smtp-Source: ABdhPJxOdrh7xo+v5p9lh4XC7W50Vzb7pNXDRcQ9Htnym/Z36RYA7wzRxRRNwfZ1Jfk36mQMsyYHqQ==
X-Received: by 2002:a7b:cc16:: with SMTP id f22mr2641386wmh.131.1613136596604;
        Fri, 12 Feb 2021 05:29:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 13sm14060682wmj.11.2021.02.12.05.29.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Feb 2021 05:29:56 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/11] test lib: change "error" to "BUG" as appropriate
Date:   Fri, 12 Feb 2021 14:29:33 +0100
Message-Id: <20210212132942.17325-3-avarab@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5eaa7
In-Reply-To: <20210209214159.22815-1-avarab@gmail.com>
References: <20210209214159.22815-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change two uses of "error" in test-lib-functions.sh to "BUG".

In the first instance in "test_cmp_rev" the author of the "BUG"
function added in [1] had another in-flight patch adding this in [2],
and the two were never consolidated.

In the second case in "test_atexit" added in [3] that we could have
instead used "BUG" appears to have been missed.

1. 165293af3ce (tests: send "bug in the test script" errors to the
   script's stderr, 2018-11-19)

2. 30d0b6dccbc (test-lib-functions: make 'test_cmp_rev' more
   informative on failure, 2018-11-19)

3. 900721e15c4 (test-lib: introduce 'test_atexit', 2019-03-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib-functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 07976af81c8..4b7e09db63a 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1096,7 +1096,7 @@ test_cmp_rev () {
 	fi
 	if test $# != 2
 	then
-		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
+		BUG "test_cmp_rev requires two revisions, but got $#"
 	else
 		local r1 r2
 		r1=$(git rev-parse --verify "$1") &&
@@ -1207,7 +1207,7 @@ test_atexit () {
 	# doing so on Bash is better than nothing (the test will
 	# silently pass on other shells).
 	test "${BASH_SUBSHELL-0}" = 0 ||
-	error "bug in test script: test_atexit does nothing in a subshell"
+	BUG "test_atexit does nothing in a subshell"
 	test_atexit_cleanup="{ $*
 		} && (exit \"\$eval_ret\"); eval_ret=\$?; $test_atexit_cleanup"
 }
-- 
2.30.0.284.gd98b1dd5eaa7

