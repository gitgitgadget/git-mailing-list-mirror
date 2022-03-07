Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC41C433F5
	for <git@archiver.kernel.org>; Mon,  7 Mar 2022 12:49:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242603AbiCGMun (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Mar 2022 07:50:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242560AbiCGMuZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Mar 2022 07:50:25 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BA84DF72
        for <git@vger.kernel.org>; Mon,  7 Mar 2022 04:49:31 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id o18-20020a05600c4fd200b003826701f847so10679472wmq.4
        for <git@vger.kernel.org>; Mon, 07 Mar 2022 04:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=azQfPC/3v3XQSWhmONyL8Nx5lgr2NV4t/qPpxbfKHkQ=;
        b=J+bH2dHQR9fupigIjFM2jnIhNvydI/xWqr0oInilm6vSUmPBOSRl885FWQ2/QMc7zJ
         xJ5h3oZkAgbzx5O0TXz7t2Q3vu9EO+JXiwqgHs/wnKzmzgnAGUvSYlEznjXXEHQaOamk
         G81B5Wz+kZ2Ux1J9G4zij5rdcm6A5yCwWXf3SoBjBZW3+sWveiK31+ZO6mo3y2uVtUpR
         2TIApKmkWsX3XUubgHMuf/gbdXyGf5eVRqJ3Ubih+m4j2S8LhSGbbzzGVYPt4XzYiIY0
         z65gnI+yXOJHXxbFfAe+bzwe3xT3Paoc5wt/hvJrGEI8TPc1+lkyQ16jpr6sTE4VANCU
         UWqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=azQfPC/3v3XQSWhmONyL8Nx5lgr2NV4t/qPpxbfKHkQ=;
        b=Mrw0KT4JmnFIqz9kZ1g95XAdkuz0vqoqvSSCfiNDEeUevoLl1zk6HXF3QDxSvoEka5
         i7/yjdHn351ftluyIrEG1sWLAMFA79sJOSx+NsqchS0FbdPx6vA3rCqmXkBcor1OGKaW
         TQTCadtfzxwiLCQqdoqhNWbF41JwD9OvT+76GTBQ6ipB0bkTvNc/HWFS4V0kV5b23DZN
         9o/ESR8ThMWIIeFYB+2cGN/ol8/+MlvUD71VnOHwLcEhxQPJWUXm6GnZhh/6wl3WobPF
         WqPTIVuyxgBFYdj1wh5MST0KiahdDnIQMvNDqsGuYxB/IjEvzuaBnlBuyLd/7L0FVMl7
         Ke+w==
X-Gm-Message-State: AOAM5337yOR3qCu3LIJDQBp8i4qoYkG6XMfoR5AqqEiN+vMza+21AQjj
        ng2ELqOKeoHADOYl1g5QT4XVInkrjB7Q2Q==
X-Google-Smtp-Source: ABdhPJxm+0cupVOwQPXOe5lCGf/q6AfZfHmKmYQ/2VJfVl+7Qg/dI7P9DXX/lXPN5iCloI9koF5sBA==
X-Received: by 2002:a7b:c8c2:0:b0:389:9746:847c with SMTP id f2-20020a7bc8c2000000b003899746847cmr7959661wml.156.1646657369604;
        Mon, 07 Mar 2022 04:49:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o3-20020a1c7503000000b0038100e2a1adsm12729091wmc.47.2022.03.07.04.49.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 04:49:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 06/15] apply tests: use "test_must_fail" instead of ad-hoc pattern
Date:   Mon,  7 Mar 2022 13:48:57 +0100
Message-Id: <patch-v2-06.15-7952ae1f3b5-20220307T124817Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1242.gfeba0eae32b
In-Reply-To: <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20220307T124817Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change a fragile test pattern introduced in 6b763c424e4 (git-apply: do
not read past the end of buffer, 2007-09-05). Before this we wouldn't
distinguish normal "git apply" failures from segfaults or abort().

I'd previously marked this test as passing under SANITIZE=leak in
f54f48fc074 (leak tests: mark some apply tests as passing with
SANITIZE=leak, 2021-10-31). Let's remove that annotation as this test
will no longer pass.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t4123-apply-shrink.sh | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/t/t4123-apply-shrink.sh b/t/t4123-apply-shrink.sh
index dfa053ff28e..3ef84619f53 100755
--- a/t/t4123-apply-shrink.sh
+++ b/t/t4123-apply-shrink.sh
@@ -2,8 +2,6 @@
 
 test_description='apply a patch that is larger than the preimage'
 
-
-TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 cat >F  <<\EOF
@@ -41,20 +39,8 @@ test_expect_success setup '
 '
 
 test_expect_success 'apply should fail gracefully' '
-
-	if git apply --index patch
-	then
-		echo Oops, should not have succeeded
-		false
-	else
-		status=$? &&
-		echo "Status was $status" &&
-		if test -f .git/index.lock
-		then
-			echo Oops, should not have crashed
-			false
-		fi
-	fi
+	test_must_fail git apply --index patch &&
+	test_path_is_missing .git/index.lock
 '
 
 test_done
-- 
2.35.1.1242.gfeba0eae32b

