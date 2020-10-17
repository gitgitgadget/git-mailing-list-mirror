Return-Path: <SRS0=oQO4=DY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52420C433DF
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 06:02:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1DFDF20720
	for <git@archiver.kernel.org>; Sat, 17 Oct 2020 06:02:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Arbp3APt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436959AbgJQGCL (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Oct 2020 02:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436906AbgJQGBk (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Oct 2020 02:01:40 -0400
Received: from mail-io1-xd43.google.com (mail-io1-xd43.google.com [IPv6:2607:f8b0:4864:20::d43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A544CC0604DD
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 19:44:05 -0700 (PDT)
Received: by mail-io1-xd43.google.com with SMTP id m17so6379525ioo.1
        for <git@vger.kernel.org>; Fri, 16 Oct 2020 19:44:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Lr4oWFYK041STzB6+R2MzxXzxEwZypGQLs8LvoPGH8c=;
        b=Arbp3APtwPQnsejsYG8utZ0IW0aXc+WN4jmX3wlujj5zWeDko8kd0/ZWrtoI73xfL8
         xR5F4YOea1Q+sCltY26NDclyH/VSILYcOBgTXqaAKHh12Q6pT8WkOCgkrCnBVYlhxYs0
         vT5mQSao153Xe6+K1xn7bCOY66DE7UhS1r04bR1RX9r4V/3IGiUayFXHIeNzg6ka+S+m
         ljtm7JuVWDwusHG66p4hNLTKcxIgN83G0+/nsWy/ont2cnSJbseUW2IO5MXukjPBe7Am
         97rB50sSdzOTYKsUqpu8NVRm6+1mAY8e1jarjiYSC1zv/Nj6oK1trOqhiSaPmyi5BnL/
         E8fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Lr4oWFYK041STzB6+R2MzxXzxEwZypGQLs8LvoPGH8c=;
        b=YE+6yDbNfufSeAR2NxyVRbaUqh0QiL2LZv0R15uTzWuGdxQZROjFPr77mc8HK9CtKC
         NNQ2RxWvbHEPtMCQLO3piLMR3IawQxKiD35vKHNo1rUiGqfXLzn3/cHazWycCuTWA6uF
         lLHlLSVmVTNo9a0gMbec0vSJ/07kxFxq9siW/jSgGR2EfjlmStnwy+dTOYuOWFD2H+eT
         dFo6/Q0ohcRV0cVXG48/XAEr1QL1dJNOESmuxBmbIiada+3yXiXE4/h9l99R/rT+ElMB
         8Ngy0FnE31/5T5za9/Khoj8u2zF7Duo8AA8nlsYksIq84rUSbuPQi13N7Dq7NxgoeARC
         T0FA==
X-Gm-Message-State: AOAM531YdLLgXteZCtGhNCEM9T+0WDXDVjxKKc+grGWOMBiUCNiZxJdz
        XMfwuCPC/9fwNsp4sedxNDYGXhEJpdNy8w==
X-Google-Smtp-Source: ABdhPJx/rCT9hQ9DyVtUKZCu0J6da4CfOfmzN8rPS1M5XQ7ohxih5Cn4ph7PQ+6HZvGynFIv3aEdIA==
X-Received: by 2002:a6b:b983:: with SMTP id j125mr4542315iof.201.1602902644858;
        Fri, 16 Oct 2020 19:44:04 -0700 (PDT)
Received: from localhost.localdomain ([173.239.199.165])
        by smtp.gmail.com with ESMTPSA id w23sm3641756iod.45.2020.10.16.19.44.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Oct 2020 19:44:04 -0700 (PDT)
From:   Caleb Tillman <caleb.tillman@gmail.com>
To:     git@vger.kernel.org
Cc:     Caleb Tillman <caleb.tillman@gmail.com>
Subject: [PATCH 1/1] Microproject - Use debug-friendly test_path_is_* functions.
Date:   Sat, 17 Oct 2020 02:43:53 +0000
Message-Id: <20201017024353.189792-2-caleb.tillman@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201017024353.189792-1-caleb.tillman@gmail.com>
References: <20201017024353.189792-1-caleb.tillman@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t0000-basic.sh - Replace an instance of test -f with test_path_is_file.

Signed-off-by: Caleb Tillman <caleb.tillman@gmail.com>
---
 t/t0000-basic.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t0000-basic.sh b/t/t0000-basic.sh
index 923281af93..eb99892a87 100755
--- a/t/t0000-basic.sh
+++ b/t/t0000-basic.sh
@@ -1191,7 +1191,7 @@ test_expect_success 'writing this tree with --missing-ok' '
 test_expect_success 'git read-tree followed by write-tree should be idempotent' '
 	rm -f .git/index &&
 	git read-tree $tree &&
-	test -f .git/index &&
+	test_path_is_file .git/index &&
 	newtree=$(git write-tree) &&
 	test "$newtree" = "$tree"
 '
-- 
2.25.1

