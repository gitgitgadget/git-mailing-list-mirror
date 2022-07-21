Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B47EAC43334
	for <git@archiver.kernel.org>; Thu, 21 Jul 2022 06:52:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232190AbiGUGwM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Jul 2022 02:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232024AbiGUGv6 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Jul 2022 02:51:58 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1E25E320
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:56 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b6so478375wmq.5
        for <git@vger.kernel.org>; Wed, 20 Jul 2022 23:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=OIuPs1VnBLMTS8tPZZf7HQTHzw1xX62Sct060lnv1AU=;
        b=dHAwkxTXLheBNMnBgLtdFCAvxjGNV7aFW973OjXIcg/VlO5XFdHrRri8U0sow8uMxR
         TfHTrN3EW042hCF7Z3zrnWVoyr2MXC3SFe6IDvut1vexKF7V7spOA93HjEVfhiONabyl
         PeVpn8nYQrVovi1sEGooFtO6F/EIX0iOT3hqnZSDW1MO+fQEnbLD4fVeKzLLvLiHd8MP
         VcoWWijM+2hpt1VkaueGg8udRl5n4izgEy3y7y7KsyRC8jKbtYUPB+I0YP1i+PBbZ+FF
         FYffiMWd7hB/sfNDN7VfPSJTBiWMxD9kpABNk8tPVH5AXvooUn5kNgh76ITPlbKO84Te
         4rmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=OIuPs1VnBLMTS8tPZZf7HQTHzw1xX62Sct060lnv1AU=;
        b=bkh96VThTu8UbkGaqkYg8+O8tXIh+KuQXZIkVHQuKe18I1VVaNdHYLfZ08F9vT5zNm
         lw4tJCr8qzeya9GweDab6CPnKNLFEtTAJ8FY66fVCkvNyRWY1xpoMOPq0uksVjwvL+YX
         UkWAddzu6A4oY6XZ2wHDFw2s6WvTpW/1EHVvkNMn3YAnwbg2hpVprwmh/QRDyTmGEvB3
         0rD5rhh8GmBF60CutvgzLsXa9sb0DuZlIL/oCk5aDVS8wXl+uzn6t3N/Z6ag2F0H885j
         YpNQWnbWXPTlPMxHB+NEO297Y50VEr+nfdHwRkLJn3IoQzrRzfn4LgznnKyKpJnFJkIC
         VqSw==
X-Gm-Message-State: AJIora9vaxPw320mr8wmHBitW9EjPkOQy61+Mf+F/AuYUObFi1jCuD3a
        lwV9wvSLe/NnikWzwpedhLNOSPjC++Brbw==
X-Google-Smtp-Source: AGRyM1ve63IWEyMFEXQehSBKgq0QEmF0AZe1WNf1UDA23xLxMEeTwpOdZlDgIz5rfcTZBDsK95D6aA==
X-Received: by 2002:a05:600c:1d1b:b0:3a3:e2:42d1 with SMTP id l27-20020a05600c1d1b00b003a300e242d1mr6813394wms.137.1658386314883;
        Wed, 20 Jul 2022 23:51:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n124-20020a1c2782000000b003a2c67aa6c0sm1006746wmn.23.2022.07.20.23.51.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 23:51:54 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 6/6] log tests: don't use "exit 1" outside a sub-shell
Date:   Thu, 21 Jul 2022 08:51:43 +0200
Message-Id: <patch-6.6-259b4618fcb-20220721T064349Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1095.g64a1e8362fd
In-Reply-To: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220721T064349Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change an "exit 1" added in ac52d9410e5 (t4205: cover `git log
--reflog -z` blindspot, 2019-11-19) to use "return 1" instead, which
curiously was done in an adjacent test case added in the same commit.

Using "exit 1" outside a sub-shell will cause the test framework
itself to exit on failure, which isn't what we want to do here.

This issue was spotted with the in-flight
"GIT_TEST_PASSING_SANITIZE_LEAK=check" test mode[1]. This "git show"
invocation currently leaks memory, and we'd thus "exit 1". This change
was initially part of that topic[2] to demonstrate the correctness of
the "check" implementation.

1. https://lore.kernel.org/git/patch-07.10-0961df2ab6c-20220719T205710Z-avarab@gmail.com/
2. https://lore.kernel.org/git/patch-10.10-9cedf0cb0e2-20220719T205710Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4205-log-pretty-formats.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t4205-log-pretty-formats.sh b/t/t4205-log-pretty-formats.sh
index e448ef2928a..0404491d6ee 100755
--- a/t/t4205-log-pretty-formats.sh
+++ b/t/t4205-log-pretty-formats.sh
@@ -156,7 +156,7 @@ test_expect_success 'NUL termination with --reflog --pretty=oneline' '
 	for r in $revs
 	do
 		git show -s --pretty=oneline "$r" >raw &&
-		cat raw | lf_to_nul || exit 1
+		cat raw | lf_to_nul || return 1
 	done >expect &&
 	# the trailing NUL is already produced so we do not need to
 	# output another one
-- 
2.37.1.1095.g64a1e8362fd

