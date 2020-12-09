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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72559C47434
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:04:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 43F7523A02
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 20:04:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387962AbgLIUEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 15:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729464AbgLIUC7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 15:02:59 -0500
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAF4C0617A6
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 12:02:03 -0800 (PST)
Received: by mail-wm1-x344.google.com with SMTP id k10so2622558wmi.3
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 12:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=LMaLfHsrFtR5TbYrAS2TUcw4yJ/c8dS9VHRIf5BDh/o=;
        b=KLCIWSD6wLRG0Ovkh1mYXihBOp+G4e2QQ8IurwXeh4DkQJf6GZtUtvCxydKz4NSpWf
         OaziyLWBgAwFBObYl66HsV67tVqGgI2Udpfl4bFs5tFRTZErPD4E/DBnIpzFs5/Tdvxp
         3HyO6Rfdv9zxp/NJXNQAL1gZLVxyZKt6piBlN4oS2o0uKjTy+iV+iIDUxXv2IWuXKd8z
         JB9GpWYTUJrcBwi47l7/oMHU49eXaWEf0xUk4/B7dw7l0U6xAFH/EiIODDeN8MwFXrqO
         uzyDO9YySz6W026JF+ZKwpTatrEwe7VIKKBQoCtlTmnWxV85365IYKKxLkSuJ0BNjctu
         TKPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=LMaLfHsrFtR5TbYrAS2TUcw4yJ/c8dS9VHRIf5BDh/o=;
        b=Fbu/cQUoQv265JJM3V/x9S9OpkhQoGOFGqkmwacqVLr0mRVcdxBssNSqRiBUUuKqe9
         VBF15qa/WjWP/3Y1eO6sQJfzsEOmZJ1IcsTj+OZ5qprR73j6J0u8exrejkYH1+sEt2xA
         q2KJ3vt2atecEAbgeMT/YGahKTacgeoovXnazQamzX9wKhqtcWqcDIILmF9trjLZ+L7m
         ZvWevHkVX/nFCq4K8k/Ow3hHmLTwjaX8TkXqd6m8+zMW9MFOao6buJiRRAqJGI6yqa9M
         7h/5uCfQoacACYAL70d/nPzcHMIwmejJPDxd1vT7m3zgx416Ztw7du8GJfC5n74WgVCO
         2/nA==
X-Gm-Message-State: AOAM531HLzvuUqQ9f7/Aue49MhWbHm3ZUuIKvtsAGvbut9pqWhh8PvYk
        l5V5Q1GfyvFxWdiu4GUndwv7bGvSrfvF9Q==
X-Google-Smtp-Source: ABdhPJzL21CPMnY53+/7hxf7rJBo0iy2n56rOEQvZkGWST6duk7niqgdrp8SeGWJ558cRczwq+Dbww==
X-Received: by 2002:a1c:750f:: with SMTP id o15mr4494276wmc.144.1607544122229;
        Wed, 09 Dec 2020 12:02:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id 34sm5762128wrh.78.2020.12.09.12.02.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 12:02:01 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 04/10] mktag tests: don't needlessly use a subshell
Date:   Wed,  9 Dec 2020 21:01:34 +0100
Message-Id: <20201209200140.29425-5-avarab@gmail.com>
X-Mailer: git-send-email 2.29.2.222.g5d2a92d10f8
In-Reply-To: <20201126222257.5629-1-avarab@gmail.com>
References: <20201126222257.5629-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The use of a subshell dates back to e9b20943b77 (t/t3800: do not use a
temporary file to hold expected result., 2008-01-04). It's not needed
anymore, if it ever was.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3800-mktag.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index d696aa4e52e..0e411e3c45f 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -14,7 +14,7 @@ test_description='git mktag: tag object verify test'
 check_verify_failure () {
 	expect="$2"
 	test_expect_success "$1" '
-		( test_must_fail git mktag <tag.sig 2>message ) &&
+		test_must_fail git mktag <tag.sig 2>message &&
 		grep "$expect" message
 	'
 }
-- 
2.29.2.222.g5d2a92d10f8

