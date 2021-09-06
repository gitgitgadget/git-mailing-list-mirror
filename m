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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0668CC433F5
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:55:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E241960F9E
	for <git@archiver.kernel.org>; Mon,  6 Sep 2021 07:55:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240356AbhIFH4n (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Sep 2021 03:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240297AbhIFH4m (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Sep 2021 03:56:42 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 646DBC061575
        for <git@vger.kernel.org>; Mon,  6 Sep 2021 00:55:38 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id u9so8414030wrg.8
        for <git@vger.kernel.org>; Mon, 06 Sep 2021 00:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/FVCsYnbT268dF7cqOVNkGC2vLh8wLLomcHSJchcMw=;
        b=ImvgT5KORZPq59lV8PQ3B9n+mhY1CvIFJBTFqHXgg3we5H7gbZj45AS9yRv4696Kwv
         hVdBd4iOTjTCRnHkJGQgU6bHKRVHfUqow5HdUB3zrCtHEYssZdKRyKBXh9gyqxRyid3I
         LZuiFP8FAP5qywXQ8zMSeGVPdXEBAlAf7ucdZ0LbMOO/3H6xj0BsH9xu7vxIgq1vZgEM
         CIZmW89GBZMy9oFq5LUxZl2Aa0INf5SVhKpWKVxJ0+/Rzu+jSF7cBFdxYat9bVOAte31
         3Kc/eCYyTq4Uea7LIEpUgjGy95npaGXZlDZCrAFCYAxZkHespfxUJbd6YMtcgRkpUTLO
         5H6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=g/FVCsYnbT268dF7cqOVNkGC2vLh8wLLomcHSJchcMw=;
        b=k5P03cSE3qdAjv1T0Q1UQjXL/2NWJMv6/O9ld2N4+G4mS6YZG6I771mIo8cNRVBTxi
         W21FaDW5bxuF6UOvdXcVyHGBPUHaknoDsh5U0utKgeyw2BCXk6l2+F7YFX3xv9hN8F7P
         9+/KXvWy/lqPRN/zV2dbaCRMLKd6ZrtZMP7rvpQehK/e3EuyhpN5gWSrzKmhVMV8k+79
         4LbJUUt7S2Sr25Pfst3xWvxlk3DmxAz+eIGgVf/QUsyPZ2dV9zU4Ome/n/n9pr3XuuT9
         /nuEt5bRMjMoDC5r1ioHKHOsT/AI29lvG3BDLbVSWEdsD06fpu2qs6dm04/RcV5E4ag5
         Q9yg==
X-Gm-Message-State: AOAM533MDVsPrQjSPsnBgcQV/BRX/YwnMLu8MtLacbD53X4fRTfVjZQ3
        WguqcFekeuKZvsjtO0iYt6u6gv0WREyJ2A==
X-Google-Smtp-Source: ABdhPJw7vkUguGjxUodSXM3J9f87rFhvplcL/RPSJf3YEEqr3bxBUJERMIE3uJ+oTxWq0Vo1dB0etQ==
X-Received: by 2002:a5d:63d2:: with SMTP id c18mr11685152wrw.240.1630914936773;
        Mon, 06 Sep 2021 00:55:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z2sm6291392wma.45.2021.09.06.00.55.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Sep 2021 00:55:36 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] Makefile: remove the check_bindir script
Date:   Mon,  6 Sep 2021 09:55:33 +0200
Message-Id: <patch-1.1-996c05525db-20210906T075527Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.821.gfd4106eadbd
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This script was added in f28ac70f48 (Move all dashed-form commands to
libexecdir, 2007-11-28) when commands such as "git-add" lived in the
bin directory, instead of the git exec directory.

This notice helped someone incorrectly installing version v1.6.0 and
later into a directory built for a pre-v1.6.0 git version.

We're now long past the point where anyone who'd be helped by this
warning is likely to be doing that, so let's just remove this check
and warning to simplify the Makefile.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 Makefile     |  3 +--
 check_bindir | 13 -------------
 2 files changed, 1 insertion(+), 15 deletions(-)
 delete mode 100755 check_bindir

diff --git a/Makefile b/Makefile
index 429c276058d..60c995696c1 100644
--- a/Makefile
+++ b/Makefile
@@ -3099,8 +3099,7 @@ endif
 		  ln "$$execdir/git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		  ln -s "git-remote-http$X" "$$execdir/$$p" 2>/dev/null || \
 		  cp "$$execdir/git-remote-http$X" "$$execdir/$$p" || exit; } \
-	done && \
-	./check_bindir "z$$bindir" "z$$execdir" "$$bindir/git-add$X"
+	done
 
 .PHONY: install-gitweb install-doc install-man install-man-perl install-html install-info install-pdf
 .PHONY: quick-install-doc quick-install-man quick-install-html
diff --git a/check_bindir b/check_bindir
deleted file mode 100755
index 623eadcbb7d..00000000000
--- a/check_bindir
+++ /dev/null
@@ -1,13 +0,0 @@
-#!/bin/sh
-bindir="$1"
-gitexecdir="$2"
-gitcmd="$3"
-if test "$bindir" != "$gitexecdir" && test -x "$gitcmd"
-then
-	echo
-	echo "!! You have installed git-* commands to new gitexecdir."
-	echo "!! Old version git-* commands still remain in bindir."
-	echo "!! Mixing two versions of Git will lead to problems."
-	echo "!! Please remove old version commands in bindir now."
-	echo
-fi
-- 
2.33.0.821.gfd4106eadbd

