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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CFFC433E9
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 23AA664E3A
	for <git@archiver.kernel.org>; Tue,  9 Feb 2021 22:29:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbhBIW2x (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Feb 2021 17:28:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234369AbhBIWX4 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Feb 2021 17:23:56 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDDD8C0401D9
        for <git@vger.kernel.org>; Tue,  9 Feb 2021 13:42:15 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id u14so66858wmq.4
        for <git@vger.kernel.org>; Tue, 09 Feb 2021 13:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=la6gQl7erSD+nEyVnvBFQcLJJeu2/gq/KXt2BLbMiXM=;
        b=hQ6wojKsnC79pGnmJTSvV0/iA8V+JMx8fv7jGdPzA9a+7Yl6dJ+2lzeVeeVxmCo8Pc
         tThTHUK3cKbbQ2C/eMU609jPaPW8PcO5xaNzAlIZGNAsVQc6O6RdXq4AgD/ZbKHQ5W0P
         kahtQjQc8iMvfeen4n2mphyYrAjaIUnetGnVklZzXbkVrYRgb8jYDPyzUq5izMMfGot1
         E+V5+8GYWJyr7QOPf1sObjfueve5PdnwLfjon9EOMMoAHgVCzJBDo+i9rhWbSqK8qJXy
         WUpDLQHHf587Pk7D1xPyTsRhTbszru7O/88pRdebR9n45S0fNCPGaC+JVdLZslez9Hco
         IyoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=la6gQl7erSD+nEyVnvBFQcLJJeu2/gq/KXt2BLbMiXM=;
        b=N8/90Ys8VTG2g7PV+kJHgWaH2mqdIeVMEfK/dw69QcCGLM3CDAiC5KZs2yXczeFzwz
         LWJFIyuZKH8GdhhFvZljvDg24T33PUgNhHbDVFBwgpTY3Um+eRjNRPpSufjSvqAQFvBV
         g9bYrJ83Puh9stDq2pBIHLjwZM9dcr1otNPx8xg8tW6eklG26kemcWnvobMpcTCZPFa1
         gxCUseVrjZhgoBOuPMOQrIMLM4IqaSAFQUPe9s1/6828PwtO2D4MCUPcCcw2rXkhYby6
         cCIPQ6fRsJGbnyYkQFevz+uuRSGgfcDQgm1msZewbGNuRZOW6ReSdPEgBihHQ68Tr9KN
         N2Wg==
X-Gm-Message-State: AOAM53136eR9L6QUkhFX36YUyR95dY/a3+jYcUT2grMjeVOVsMY8oxEr
        HvzAViJICbFHYHdNcIVBBSSKGmwbxVsnXw==
X-Google-Smtp-Source: ABdhPJwlqM4nVZbKQtuhv7HCnPafu591H5h0bPDba3+OBtnOMgzNOjESCRZ/1TAmdjSWXtw0BEwCsQ==
X-Received: by 2002:a05:600c:3515:: with SMTP id h21mr79873wmq.179.1612906934201;
        Tue, 09 Feb 2021 13:42:14 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m205sm38710wmf.40.2021.02.09.13.42.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Feb 2021 13:42:13 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 02/12] test lib: change "error" to "BUG" as appropriate
Date:   Tue,  9 Feb 2021 22:41:49 +0100
Message-Id: <20210209214159.22815-3-avarab@gmail.com>
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
index 6bca0023168..0d40f8a598e 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -1105,7 +1105,7 @@ test_cmp_rev () {
 	fi
 	if test $# != 2
 	then
-		error "bug in the test script: test_cmp_rev requires two revisions, but got $#"
+		BUG "test_cmp_rev requires two revisions, but got $#"
 	else
 		local r1 r2
 		r1=$(git rev-parse --verify "$1") &&
@@ -1216,7 +1216,7 @@ test_atexit () {
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

