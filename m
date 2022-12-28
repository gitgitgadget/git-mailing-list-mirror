Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6142C4167B
	for <git@archiver.kernel.org>; Wed, 28 Dec 2022 18:00:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbiL1SAi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 28 Dec 2022 13:00:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233656AbiL1SAc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 28 Dec 2022 13:00:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AEF167C0
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id y16so15544046wrm.2
        for <git@vger.kernel.org>; Wed, 28 Dec 2022 10:00:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ykWqZXWyl7svJ+WNwzbKCePyys9rgWLoCf4uryIgFVk=;
        b=o7QIMe2CPmfRtnLIsbwkCEtvzbystEA/zwe9X6EFXOkrZjf/0gXFmloC/jAB8ikQtO
         RccrJdaT6s8DLKz7xBrswllvYpglGwhBVFHNA2Jn3JVFcM28tEBFAwntjKA3jSo8V7HR
         puu735EDbVCTP4hhHnu9p3hvdU3vASvVjRT72LG16QDq4MRD2sVala5MiHIwZ3TBFYCp
         8qWmoXqD4hkE3q1ks6rYeTzrWYbZ2X0elDwuP5Tx7O59ovpE/t4aEz9K6GyP1Vzngirg
         gQXAOfOrgBiplyKaqQiENGay6ntoCVmPjfSx7bxNi05F9SE2IAQeRItfrFw7FCKUZxpV
         ytIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ykWqZXWyl7svJ+WNwzbKCePyys9rgWLoCf4uryIgFVk=;
        b=XGFtQRzMNglUA5eQSo7vYFcP3Q43HEyGBt4jC58sRsttWDV48pDqgimGOAwZ9R6IZv
         ALaIDQSlfVSJlSTQRvj0KtzTTPLSUuzLcmFHZRfzOhm0RVcota0Ra7DL8GxjZNtimEes
         HFEyTsEBbOtefE2bC9tTvPQ5J9I5iyLFyJFKM6mq4EwKrkIpai1/Mev7iwamVUmpucsA
         2TKfcEIG9VyIy9ahx7eLOqTTIchN43IT8aWx+6PBw0uPb5nDopWsRHObpP1sVDu2//S8
         BseToc9dgjxkkrRfeqr1ys7E6glZ02swBkq13P6s5+9tHl2grBbZLRmKwWq6iTuijeze
         5kSw==
X-Gm-Message-State: AFqh2krV26QU9BHvM/Cp/1eUBZQC8aMzoBd6taiR3Lm7JekMSHC8LZjE
        h4cUcUkLA3ihlgJ5TJ3/ntQmH4FtcepjOg==
X-Google-Smtp-Source: AMrXdXsht7dEHH0PKOZop1C3Fps4aKI+kf+jFx8uW1Bbky0Zuto0gDZ6aMEEvMoou40bWT4+MGLaHw==
X-Received: by 2002:a5d:4b81:0:b0:274:ecce:b3bf with SMTP id b1-20020a5d4b81000000b00274ecceb3bfmr11161859wrt.61.1672250429036;
        Wed, 28 Dec 2022 10:00:29 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id c8-20020a5d4148000000b002428c4fb16asm16022480wrq.10.2022.12.28.10.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Dec 2022 10:00:28 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 03/20] bundle.c: don't leak the "args" in the "struct child_process"
Date:   Wed, 28 Dec 2022 19:00:03 +0100
Message-Id: <patch-03.20-a8b373ddef9-20221228T175512Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.gb0033028ca9
In-Reply-To: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a leak that's been here since 7366096de9d (bundle API: change
"flags" to be "extra_index_pack_args", 2021-09-05), if can't verify
the bundle we didn't call child_process_clear() to clear the "args".

But rather than doing that let's verify the bundle before we start
preparing the process we're going to spawn, if we get an error we
don't need to push anything to the "args".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 bundle.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/bundle.c b/bundle.c
index 4ef7256aa11..9ebb10a8f72 100644
--- a/bundle.c
+++ b/bundle.c
@@ -627,6 +627,10 @@ int unbundle(struct repository *r, struct bundle_header *header,
 	     enum verify_bundle_flags flags)
 {
 	struct child_process ip = CHILD_PROCESS_INIT;
+
+	if (verify_bundle(r, header, flags))
+		return -1;
+
 	strvec_pushl(&ip.args, "index-pack", "--fix-thin", "--stdin", NULL);
 
 	/* If there is a filter, then we need to create the promisor pack. */
@@ -638,8 +642,6 @@ int unbundle(struct repository *r, struct bundle_header *header,
 		strvec_clear(extra_index_pack_args);
 	}
 
-	if (verify_bundle(r, header, flags))
-		return -1;
 	ip.in = bundle_fd;
 	ip.no_stdout = 1;
 	ip.git_cmd = 1;
-- 
2.39.0.1153.gb0033028ca9

