Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDED1C433FE
	for <git@archiver.kernel.org>; Fri, 18 Feb 2022 21:02:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239598AbiBRVCS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 18 Feb 2022 16:02:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233324AbiBRVCQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 18 Feb 2022 16:02:16 -0500
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163D628B619
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 13:01:58 -0800 (PST)
Received: by mail-wr1-x431.google.com with SMTP id e3so16576542wra.0
        for <git@vger.kernel.org>; Fri, 18 Feb 2022 13:01:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=li+HO9LUlhnZ0IAHiHiMVInKYWDY4qzUmyKsPgj2b8c=;
        b=Vv1QGREmif2cpg8a4p3f2uoUqx5v82UrobXlCIzCMIW31jKw6cAhV2LMHp2yvuFpHx
         r9/M75vd7FqNVZLX15jx5qzw3IfPRDqzDwdGwqBHetypvri9VcCNKd9UyriqA8Oq5cU9
         1IgrWuEDPO76fPIutOK91+C4DkdK2Ld0q6y0abwr3s9bTEXdph7HdTCkPTFlTJGNEptS
         k+s3DBfhsh72NX406MOl6YACRXXgEmc5w1WURCRrNhC4LO8gV5u6KZt7kyDqIfum0oOg
         CoqLRGKHDqgnkSILf/Udt1Zwoq6jE2PtoTNBs2QL8RSxCCy6fMCuST28lcHWq8WTIdZt
         QZYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=li+HO9LUlhnZ0IAHiHiMVInKYWDY4qzUmyKsPgj2b8c=;
        b=VMW/r4t0Cg+ORfxi7ysKK8kRCYg/v4usGs7y5rnZcd3f8KEZ8P/TCD5IHz5MTpdv73
         8ICH2lZD8dSge0Jsnt4j+Lkx1qYgssQu1f397od+nvjJtYh7/Mmjz31i5lu4xm+Vc+hi
         mghQu9frnpaF8+8z9MDQ8Uxm6ZAummZWTfsjAA0KA+tdBclAF4adpqszpeiuv/kbMvcD
         IxptjnC8eyBmdfys1lS9unf22x+8h4Cmbe/vXk6MWSMTKca9/n0dnhmrinVL2r2Es+zM
         U/zWfnmsR8bnGVV/DJ/w9s6SYbsQf+HzadBvfLda/VdgnYvaTSVRcHsJMYShWE7g0e0T
         Q/mQ==
X-Gm-Message-State: AOAM5304V1GF0wkCtllqIKUPbBfo8SbCkFMfceSFnFsfca3eqMC1UQQp
        sVE5ktM+3in+h4pXfp9Cu+IXcHs0nfSWng==
X-Google-Smtp-Source: ABdhPJwKmPnLwoOnDBUecmX8qyX+8Vn+kTwihY4Sn3bBAEy8IECUPHKfditOkTMw71DUnQ1EUJ3DGQ==
X-Received: by 2002:adf:ec03:0:b0:1e4:98f6:2563 with SMTP id x3-20020adfec03000000b001e498f62563mr7313565wrn.168.1645218116387;
        Fri, 18 Feb 2022 13:01:56 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n15sm14238018wri.33.2022.02.18.13.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 13:01:55 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/4] test-lib: make $GIT_BUILD_DIR an absolute path
Date:   Fri, 18 Feb 2022 22:01:43 +0100
Message-Id: <patch-2.4-4c53c6157ac-20220218T205753Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1031.g277d4562d2e
In-Reply-To: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
References: <cover-0.4-00000000000-20220218T205753Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the GIT_BUILD_DIR from a path like "/path/to/build/t/.." to
"/path/to/build". The "TEST_DIRECTORY" here is already made an
absolute path a few lines above this.

This will be helpful to LSAN_OPTIONS which will want to strip the
build directory path from filenames, which we couldn't do if we had a
"/.." in there.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/test-lib.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3212966a82f..4f523b82ce5 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -34,7 +34,7 @@ then
 	# elsewhere
 	TEST_OUTPUT_DIRECTORY=$TEST_DIRECTORY
 fi
-GIT_BUILD_DIR="$TEST_DIRECTORY"/..
+GIT_BUILD_DIR="${TEST_DIRECTORY%/t}"
 
 # Prepend a string to a VAR using an arbitrary ":" delimiter, not
 # adding the delimiter if VAR is empty. I.e. a generalized:
-- 
2.35.1.1031.g277d4562d2e

