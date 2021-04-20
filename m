Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DD53C43460
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 393DF613C5
	for <git@archiver.kernel.org>; Tue, 20 Apr 2021 12:50:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232214AbhDTMv2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Apr 2021 08:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232142AbhDTMvX (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Apr 2021 08:51:23 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB21C06138A
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:48 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id r20so8322971ejo.11
        for <git@vger.kernel.org>; Tue, 20 Apr 2021 05:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=mHlZGE2cRBb9rU/eSH2dLczIIaxNn4HD6ikT+XjEC4o=;
        b=XahadcUdIHFbunRCO3lha3wMrLexM47k7SUHh3NVlZf3r/yoafPSORQPMdhTX/pQLc
         wSXxQObjD9BBL90wc6B2p4SCzAdmHVMr8KiB6RX1gryfZQo5kWu6hxrfQnEcBlEeAXBr
         8UmJpdrfIePNIy7ixcVgkP51Kusftdc8/gB5/EhgkVcKEYogkFNKSbePvjUK6ucNZH5C
         WjwQVXw0a3On3j9FnxtNgPqpPnk+fvhuqtJ3mTiDuramfsqxrl4M7e3PIKPpBa6g0YZX
         nrH5pl0WD7vRuhyxKqn5m3RH7OoV6EAN3rKfATfBSJCysfzl4cKu+ekZYX1qjX1cLm4C
         K0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mHlZGE2cRBb9rU/eSH2dLczIIaxNn4HD6ikT+XjEC4o=;
        b=UwH6gFHcwlUxtgpNjKfTJfXKSJz+/1NNtcKooJvA8LK+BtPXMAWBlnHVyZibNRHGXf
         oWULPKvQROwA8KI2gLyaxQ85Fo0l0Ii3/JO9bdMZuftYeaNfHoKVl6qgKCzaMeI4obzD
         Pq21r3B1uTCSSw7Vf4KKqligWq2GSZbK/nJKENDFJ4X/EShy5IYBLr5nbuXZwi7wi4m+
         VeL/rX2JmZZReYl5bIEnhe6M9d1Vs/U6LyQJLLrAvGR4HoohahUw+sl9rXxA1Ef4DkDZ
         C9TfrqUe3UvDi+QOPlNm0d7hK5HlK0gEPoBPgAn4Hnw9X+SCtFAuIYpvTVcqp8z37HWo
         mRIA==
X-Gm-Message-State: AOAM530/zLJgw0fM5Ivw0FvuwsvimXPOYOr0UXNQTAUQgtIWwKCyAmwt
        nEtXH2U0k2Nn/X4rgw3piDf4r/9nuGKDUQ==
X-Google-Smtp-Source: ABdhPJwtpdn3nhHZTZCjJXyTbQ1GcpcsE5mhGJR+iVoxgs4rA9bsrrug2e60WBwkX4ujr7v22yzRNQ==
X-Received: by 2002:a17:906:d18a:: with SMTP id c10mr26992070ejz.271.1618923047053;
        Tue, 20 Apr 2021 05:50:47 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f3sm12630900eje.45.2021.04.20.05.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 05:50:46 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 02/10] hash-object tests: more detailed test for invalid type
Date:   Tue, 20 Apr 2021 14:50:35 +0200
Message-Id: <patch-02.10-0b48389325-20210420T124428Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.723.ga5d7868e4a
In-Reply-To: <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com> <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tests added in b7994af0f92 (type_from_string_gently: make
sure length matches, 2015-04-17) to check the return code and error
that's emitted.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1007-hash-object.sh | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/t/t1007-hash-object.sh b/t/t1007-hash-object.sh
index 64b340f227..74486f6f1a 100755
--- a/t/t1007-hash-object.sh
+++ b/t/t1007-hash-object.sh
@@ -230,11 +230,19 @@ test_expect_success 'corrupt tag' '
 '
 
 test_expect_success 'hash-object complains about bogus type name' '
-	test_must_fail git hash-object -t bogus --stdin </dev/null
+	test_must_fail git hash-object -t bogus --stdin 2>actual </dev/null &&
+	cat >expect <<-\EOF &&
+	fatal: invalid object type "bogus"
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success 'hash-object complains about truncated type name' '
-	test_must_fail git hash-object -t bl --stdin </dev/null
+	test_must_fail git hash-object -t bl --stdin 2>actual </dev/null &&
+	cat >expect <<-\EOF &&
+	fatal: invalid object type "bl"
+	EOF
+	test_cmp expect actual
 '
 
 test_expect_success '--literally' '
-- 
2.31.1.723.ga5d7868e4a

