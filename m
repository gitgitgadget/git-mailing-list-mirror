Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BC09C433F5
	for <git@archiver.kernel.org>; Fri,  7 Jan 2022 11:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347054AbiAGLRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Jan 2022 06:17:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347032AbiAGLRh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Jan 2022 06:17:37 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 069B4C061245
        for <git@vger.kernel.org>; Fri,  7 Jan 2022 03:17:37 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r10so2766337wrc.3
        for <git@vger.kernel.org>; Fri, 07 Jan 2022 03:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=FdaLq2g91xR8v/nESoeGXauk+rr++iaeFdoli+1AYtQ=;
        b=KgRI6+K7VIr5Bde4YUmOL/TKMoAAON4Nz15erRjXaCsquA2NriH/8/HK2oqJpMvnMt
         4QSeRgmi1FvJPAW7B2dZGVlLTebl+kZFQYAu02UJGRziDiaeTLGF2g7F6tyz2jvedwxS
         V5mmSQlp8ckMqvjy7PaeouSWpFesHdsNA8kDxH4YDGDhcDFed+Lc68D4FN8S540WAwG7
         Vbt+PFKS4RsPUu1rk0BF7xasyjr6WDXy7Qy/oB3yb5qBlN+FZ/Rb73maxjvOFGy8Vabb
         ki+0KJI8N8O96hxv7J5gONCyEmfLYpTnR4TeMMnx1K4I+M9zuFdH5plRLeI8W9mRkRHX
         bKXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=FdaLq2g91xR8v/nESoeGXauk+rr++iaeFdoli+1AYtQ=;
        b=X4vMlLwK2/boaFCCG6EIdZIspD9+mApxp+JIrXD3/d00P9GwWCPU6tgkQsst1Qz19H
         fSbTWsb91D9s9qbgs3t9bjoeV0qu2MTAYAEoblb/ZsjDzLBGrGOlTlQNl52nYnAh+dZ/
         Z32XF79fBsBbW01810izQsoUAG0E/KcMpu2J0JQpSSeSyosjZWv5B7cjfDg/IeQZjDO7
         nZCxuaLQAk7D4v2yKMN4W31ra1uVQfYfMjUP6+fX5TPwwKFTH4WaYzTF9OZV8OEdNwFh
         5FxwrIm93cRrC9HOisM5LiV071BMoSH6ZauT/yBZKMjvmAh5GsJh/4MQSKnLYW1pb1tn
         66zg==
X-Gm-Message-State: AOAM530pj79fE1OxnkDNAk8N2aWKkQHxMXvRF6grEP+Cin722n7uWreV
        uLhvdVmxwT/lCujS0sK8bHkGiuGVyFg=
X-Google-Smtp-Source: ABdhPJxDEgqIZn8Ip1GnPGaJ5WG1QOGT3od7kBQZ9WEKDtHn93you5mso/bz0BJZb8ya51vCHrl/OA==
X-Received: by 2002:a5d:6081:: with SMTP id w1mr53559862wrt.361.1641554255565;
        Fri, 07 Jan 2022 03:17:35 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g12sm5351564wrd.71.2022.01.07.03.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 03:17:35 -0800 (PST)
Message-Id: <82d0b6ab8d2dc3198216aac9551927dfd6d91cc0.1641554252.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1105.v4.git.1641554252.gitgitgadget@gmail.com>
References: <pull.1105.v3.git.1641508499.gitgitgadget@gmail.com>
        <pull.1105.v4.git.1641554252.gitgitgadget@gmail.com>
From:   "Marc Strapetz via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 07 Jan 2022 11:17:30 +0000
Subject: [PATCH v4 3/4] t7508: add tests capturing racy timestamp handling
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Marc Strapetz <marc.strapetz@syntevo.com>,
        Marc Strapetz <marc.strapetz@syntevo.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Marc Strapetz <marc.strapetz@syntevo.com>

"git status" fixes racy timestamps regardless of the worktree being
dirty or not. The new test cases capture this behavior.

Signed-off-by: Marc Strapetz <marc.strapetz@syntevo.com>
---
 t/t7508-status.sh | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/t/t7508-status.sh b/t/t7508-status.sh
index b9efd2613d0..2b7ef6c41a4 100755
--- a/t/t7508-status.sh
+++ b/t/t7508-status.sh
@@ -1654,4 +1654,26 @@ test_expect_success '--no-optional-locks prevents index update' '
 	! test_is_magic_mtime .git/index
 '
 
+test_expect_success 'racy timestamps will be fixed for clean worktree' '
+	echo content >racy-dirty &&
+	echo content >racy-racy &&
+	git add racy* &&
+	git commit -m "racy test files" &&
+	# let status rewrite the index, if necessary; after that we expect
+	# no more index writes unless caused by racy timestamps; note that
+	# timestamps may already be racy now (depending on previous tests)
+	git status &&
+	test_set_magic_mtime .git/index &&
+	git status &&
+	! test_is_magic_mtime .git/index
+'
+
+test_expect_success 'racy timestamps will be fixed for dirty worktree' '
+	echo content2 >racy-dirty &&
+	git status &&
+	test_set_magic_mtime .git/index &&
+	git status &&
+	! test_is_magic_mtime .git/index
+'
+
 test_done
-- 
gitgitgadget

