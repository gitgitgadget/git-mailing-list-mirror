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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C749EC433E0
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:09:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C4A923731
	for <git@archiver.kernel.org>; Sat, 16 Jan 2021 17:09:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728020AbhAPRJi (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Jan 2021 12:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727896AbhAPRJe (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Jan 2021 12:09:34 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57BAC061350
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:11 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d13so12194338wrc.13
        for <git@vger.kernel.org>; Sat, 16 Jan 2021 07:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+tCtmgHtGnsWOu/Viqd5pWB2uBYsKnxNIFZPQRcr9rQ=;
        b=puLN0dB9lzGTnzdxRnU6Y/+JdriywTSRfw8PLB13ueH+DHDDyoymQvAK8LDRSIDhzI
         k5f9y3jzAhAzV56bYcenu2VIfIqqXHjDMVRq2lPqMrcPbkc+Kr3o78iNGhTtm6nFeSKH
         vGSof80lFuiKt2qsTGp5AfdaU7fV3KIPdvpmXTXuWx9f1i9gErxV7xrt5ZZK6BSw3gM4
         rd4TR4TctWrJUzu/rM4nw6S6OOp8kokt5vIFnqV+q5FYD0KMlg6VhA8rnro38A+52Ali
         P+ZEMt4dFDl/pRYSlMdm6+IG0FUfQVcT9Den52mOW3CqQpKqHCiAlWynIPD2v7fJBKiR
         H8Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+tCtmgHtGnsWOu/Viqd5pWB2uBYsKnxNIFZPQRcr9rQ=;
        b=Ab2avfyXyKsDS/YGroqy1wDGochDpOJOZt4GAvkHfZdCuKhQ9+v6+/zxE920/cHaRr
         mWZmo19h/KqYx/oPVmyF1rpiBj/zihk6qEP1VIwamMVwvuPTymlBjzOyjXWnqJqpKgCL
         9Y05s4zuGXamOfyguN7qeQCyEYtgVy0bc8JR0zHwFw7lb5jFzs0g1Q3Xn3+5M4v205+g
         UNlgj1nrmgo7K1s7vZGVHV7DqnmI0vsdYpi7/vs9nmBBwMOHMqvA6DrbT4hb2isaw8lD
         W/VAPaIU4yHssGny1sLcTlluK7Ao13BIg2CtJiWmVAVdLzHwS5fujcx96rl2Bzcxf1+z
         fW/w==
X-Gm-Message-State: AOAM5300uIx4R1QLbo2KDHX2/4H7JN3y73lAsJov4XYrRgo6W0Rz8S1f
        AQXnWibTDEDLXGbUBOOZl/oBii4k4oqGAw==
X-Google-Smtp-Source: ABdhPJx5bj+wGWPNVah8Bf0tXKRPuy3ildfVKw6PxPtOdEqA0yvN3YsMjEDoK1GlQ97eIPOUXaZkoA==
X-Received: by 2002:adf:fdd1:: with SMTP id i17mr18067338wrs.173.1610811370372;
        Sat, 16 Jan 2021 07:36:10 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s13sm20008855wra.53.2021.01.16.07.36.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Jan 2021 07:36:09 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 10/11] tests: split up bash detection library
Date:   Sat, 16 Jan 2021 16:35:53 +0100
Message-Id: <20210116153554.12604-11-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20210114233515.31298-1-avarab@gmail.com>
References: <20210114233515.31298-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Split up the detection for whether we're running under bash, and
whether it's the /bin/sh POSIX-y mode or the /bin/bash bash-y mode
into its own library.

This will soon be used very early in test-lib.sh itself to check for
the /bin/bash, so let's make this new file as small as possible.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/lib-bash-detection.sh | 8 ++++++++
 t/lib-bash.sh           | 4 +++-
 2 files changed, 11 insertions(+), 1 deletion(-)
 create mode 100644 t/lib-bash-detection.sh

diff --git a/t/lib-bash-detection.sh b/t/lib-bash-detection.sh
new file mode 100644
index 0000000000..8fbdae1d52
--- /dev/null
+++ b/t/lib-bash-detection.sh
@@ -0,0 +1,8 @@
+#!/bin/sh
+
+TEST_SH_IS_BIN_BASH=
+if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
+then
+	TEST_SH_IS_BIN_BASH=true
+	export TEST_SH_IS_BIN_BASH
+fi
diff --git a/t/lib-bash.sh b/t/lib-bash.sh
index b0b6060929..8fd06d2e58 100644
--- a/t/lib-bash.sh
+++ b/t/lib-bash.sh
@@ -2,7 +2,9 @@
 # to run under Bash; primarily intended for tests of the completion
 # script.
 
-if test -n "$BASH" && test -z "$POSIXLY_CORRECT"
+. ./lib-bash-detection.sh
+
+if test -n "$TEST_SH_IS_BIN_BASH"
 then
 	# we are in full-on bash mode
 	true
-- 
2.29.2.222.g5d2a92d10f8

