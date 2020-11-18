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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B9A1C5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:04:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FE3A21D1A
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 19:04:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P3akTZYU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgKRTEf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 14:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726268AbgKRTEe (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 14:04:34 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC465C0613D6
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:04:34 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id j7so3305165wrp.3
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 11:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=96n3bDmMhKAbN8kxt2oYeVvRkYgif/tYg2S4TMMsPWU=;
        b=P3akTZYU2E8sGO6jPvCA2PkKepisEM+2CUdi6a0t4UB73zyjVw2hAra+3FLg3DifEJ
         JUrAZlN/SvbjVtRm0sxKb5B9jMLT361k3KiHKr6htCbccIXKkCkRQIeXbcWhIrmjiCV/
         GMWYQ7NmGX2ItB/fejy7IbBBCTnrJufhV0NfLigeC+Py6EyddcFi86pH0goX17OK9Uyr
         KnlzQ3x9w/axJ943YiQfsuHX8MnHcWKhuNCqSek+vcv8ZZJw8TlvPJ9L3je1enpAjnaX
         s4EKCXFS//0oKCXYvNQXLsLih33XJfTmIN2WpdOTZzZBMG7DEGBUaVDEDSC6TNXCsmMU
         JNgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=96n3bDmMhKAbN8kxt2oYeVvRkYgif/tYg2S4TMMsPWU=;
        b=GP4ZgVJ7Ik5S3XB5FIVmgnh9KN4NLaTulhO/MLlNfuTOmG+5WWdWZ0mioZ9ZIkEUtG
         vmJyAICK9AadwV10O20lY6QP8ksA2D6FspJ0jdkz3UOCBmKE8mOFMSlFKCUTpSPcAwHe
         we4GYhop8kdE7miQOVrPJfuciM16upIjixbdUC9jfp498pyMhuNfDT8lV5Dzqf6RCpJl
         LhLIXuWXXFUQad46rlBTBGY1ryhowZdtlaBUu8uesdqIRsAwMnmOzhDWhLcAkxQ0aGvw
         SDVZLhu4eKwkyd7j9gIuvPza33RW5WaN2Q0rvlXQk7jsj75cgPFWZ4e9GBHzGCFGBz6q
         EHIw==
X-Gm-Message-State: AOAM5315YurCwt1e70HPvgUe05Hjc74UqBlUYnh9zEA4XMhyvFayirEf
        y1873sE28r09JseoAWxNLslcV+pnomM=
X-Google-Smtp-Source: ABdhPJwT24QLZn5nh4DEwNwhwZcmb3X6fSV41PlduIF0i255j9eY+LeLzqH5m9hB7HuLWYzOtVndMw==
X-Received: by 2002:adf:fec6:: with SMTP id q6mr6428325wrs.168.1605726272928;
        Wed, 18 Nov 2020 11:04:32 -0800 (PST)
Received: from localhost.localdomain (78-131-14-45.pool.digikabel.hu. [78.131.14.45])
        by smtp.gmail.com with ESMTPSA id n23sm5313432wmk.24.2020.11.18.11.04.30
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Nov 2020 11:04:32 -0800 (PST)
From:   =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>
Subject: [PATCH 2/2] tests: fix description of 'test_set_prereq'
Date:   Wed, 18 Nov 2020 20:04:14 +0100
Message-Id: <20201118190414.32616-2-szeder.dev@gmail.com>
X-Mailer: git-send-email 2.29.2.612.g41c40d3f73
In-Reply-To: <20201118190414.32616-1-szeder.dev@gmail.com>
References: <20201118190414.32616-1-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

'test_set_prereq's description claims that prereqs can be specified to
'test_expect_code', but that is not the case (it is not meant to run a
test _case_, but a git command), so remove it.

OTOH that description doesn't mention 'test_external' and
'test_external_without_stderr' that do accept prereqs, so mention
them.

Signed-off-by: SZEDER Gábor <szeder.dev@gmail.com>
---
 t/test-lib-functions.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 94395b9807..21b2ea55b7 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -423,7 +423,7 @@ write_script () {
 # - Explicitly using test_have_prereq.
 #
 # - Implicitly by specifying the prerequisite tag in the calls to
-#   test_expect_{success,failure,code}.
+#   test_expect_{success,failure} and test_external{,_without_stderr}.
 #
 # The single parameter is the prerequisite tag (a simple word, in all
 # capital letters by convention).
-- 
2.29.2.612.g41c40d3f73

