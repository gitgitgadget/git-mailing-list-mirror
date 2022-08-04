Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D276AC19F2D
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 13:38:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239908AbiHDNib (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 09:38:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239898AbiHDNia (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 09:38:30 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DB7422C8
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 06:38:28 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id bk11so15448000wrb.10
        for <git@vger.kernel.org>; Thu, 04 Aug 2022 06:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:date:subject:fcc:content-transfer-encoding
         :mime-version:to:cc;
        bh=mc5ijKfyCeq4CNziKSaYEYldV36XG+ORC9pN1i744eE=;
        b=hUKvWLnTcivMFAG2lutGHdr4QZYf9slil9G5z7J3+utC0g+ZUnuIDkqgECuEZDL91A
         cG8SQeNtW6f4WP8Gxr7/+oZFJfOKe3xYcgHcJCbbHwRZr/OdGmxYC+d0uKpgqSAwfVJf
         Xt7eIYEzmOMEMfB1Vq6qG+lwUMLHhXeX0OEoLwyS9+3FrtRuXelOyGNxPiLK6OuSaXw2
         HVYutcE/xUea7BuqqsEap1AIKNK/6TnSrbISuJJEqEsZEI/bpNSD8WzD4w+Na+1WnXbu
         A2fJx2xe7kYNEH0Wbv3VH+CapBmupXBZIZqNM4reetcgsbTIPXQ9Cigcuy6Wh6h2YuNf
         TlQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=mc5ijKfyCeq4CNziKSaYEYldV36XG+ORC9pN1i744eE=;
        b=tqLorPoE8oxr+l1Z4qTjDsNVxrUL5TlcQbPQ+V4CAn1qMDcXqFOcqQvsk1l9Dii5x+
         TjXGFAQJ1+HxR4XdV2T0jA3ExJPBBcIyQSgFwJ8pjaLo3MmalxOJb+RGHdXYFGBbbws4
         a3s+v2eszzxZx0KAYjCBmR4Y7dlXswDMNuwxjmp74NDQ74ULfDv6hhSCCcUYxyYR48t8
         /6IgTQDBgr8OmukxBm86YLegok58q1Hha2HRBncch4LLn7Y0pBr9lL7L/dl+dm5EbzW2
         Rl9aIPhJmFOjSeqTPfelbcSpzbSYqcmdHNa75/CVY2okeiZDs83zl2q61JgMtrLH424I
         8ODA==
X-Gm-Message-State: ACgBeo0z9D1GX5/6F/sHgbehIX9OftLpwzuSoCUTL8G8XyRgRLIrp0zl
        e9yA9KBMgMr06wdzhkl8SLBzym+QB5s=
X-Google-Smtp-Source: AA6agR45uYcEQrPxgwWAOPb4TUOzNNMlY/vf9DxWVoUPI/NpNI5wh7EjKMjwMk0VuBq+g4MlhTbdtA==
X-Received: by 2002:a5d:5a0f:0:b0:220:5930:dc65 with SMTP id bq15-20020a5d5a0f000000b002205930dc65mr1434192wrb.229.1659620306919;
        Thu, 04 Aug 2022 06:38:26 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i29-20020a1c541d000000b003a5125049c9sm1557419wmb.9.2022.08.04.06.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Aug 2022 06:38:26 -0700 (PDT)
Message-Id: <pull.1311.git.1659620305757.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 04 Aug 2022 13:38:25 +0000
Subject: [PATCH] tests: cache glibc version check
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Elia Pinto <gitter.spiros@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Jeff King <peff@peff.net>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

131b94a10a ("test-lib.sh: Use GLIBC_TUNABLES instead of MALLOC_CHECK_
on glibc >= 2.34", 2022-03-04) introduced a check for the version of
glibc that is in use. This check is performed as part of
setup_malloc_check() which is called at least once for each test. As
the test involves forking `getconf` and `expr` cache the result and
use that within setup_malloc_check() to avoid forking these extra
processes for each test.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
    tests: cache glibc version check
    
    A recent discussion on the list[1] reminded me that this patch was
    waiting to be sent.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1311%2Fphillipwood%2Fwip%2Ftest-cache-glibc-tunables-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1311/phillipwood/wip/test-cache-glibc-tunables-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/1311

 t/test-lib.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 7726d1da88a..ad81c78fce7 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -557,14 +557,19 @@ then
 		: nothing
 	}
 else
+	_USE_GLIBC_TUNABLES=
+	if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
+	   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
+	   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
+	then
+		_USE_GLIBC_TUNABLES=YesPlease
+	fi
 	setup_malloc_check () {
 		local g
 		local t
 		MALLOC_CHECK_=3	MALLOC_PERTURB_=165
 		export MALLOC_CHECK_ MALLOC_PERTURB_
-		if _GLIBC_VERSION=$(getconf GNU_LIBC_VERSION 2>/dev/null) &&
-		   _GLIBC_VERSION=${_GLIBC_VERSION#"glibc "} &&
-		   expr 2.34 \<= "$_GLIBC_VERSION" >/dev/null
+		if test -n "$_USE_GLIBC_TUNABLES"
 		then
 			g=
 			LD_PRELOAD="libc_malloc_debug.so.0"

base-commit: 23b219f8e3f2adfb0441e135f0a880e6124f766c
-- 
gitgitgadget
