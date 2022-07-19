Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD07CCA47F
	for <git@archiver.kernel.org>; Tue, 19 Jul 2022 14:10:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238896AbiGSOKg (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 Jul 2022 10:10:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238864AbiGSOKN (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Jul 2022 10:10:13 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE84A664C2
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:29:03 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id z1so11959386plb.1
        for <git@vger.kernel.org>; Tue, 19 Jul 2022 06:29:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zgaoGiB2Kf3OuCcRTLdGJUx9rzt8YmZKI0IFLSLl510=;
        b=PpYRATyWU3ygx3tqw2p/5bxNSf5ono71pPEaYP8CGADbqubsOLOb5eNdFIUxYyN1iv
         mRahjjNfk7XnJlu3jnvZSNZu/Wd1ZqK0ew3ps2Mhvp4bXCWLo3jt2zTZQatUZbbQu9f8
         A+4i9jxhe4C4/eS+CkJz3eg/iEFy0rZbniRBTj4JXEV0PZCUyc1CnAxbxQTgwftWouaJ
         otqvmnH2GDW80pcfBCWH9ecYHw7dtMwhnvCO53kyFrJtqa9Qq3OdWR7rwZEij/O/nCqz
         ww497Z9c2w+1VNa8+uVykLWWFYksSSo7SyLEETiE2Tk26NHAchyf4FMzHyQSBpuEwZfc
         RcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zgaoGiB2Kf3OuCcRTLdGJUx9rzt8YmZKI0IFLSLl510=;
        b=dugT53IM2o8yIy1CtC7wgaIAQMBjz0w6Q99Wo0CQ8dItva7mGUxpcl9wzgFkfDsTPu
         6pptSpTctxnKykivJiDQO1U3XK09j+3/6IwV2g7ay6lzQqtIjTcOn4LMfNrzteatSCxJ
         9bhR0Qkbe9lKfEDf/AE7vi/dqPpo9bCZdJhvMBSEJyiIt/QMAyHQyB2Wkx3V+SJNK1RT
         ovBdaPpSjaX4h9y0QA6CwJj9DR6hpLxpiNJVWnu6WmtaP71Wxg+MKtLiSi1FCl2iQXES
         hYgFhXxjyO02KxkqUakidZjMD6o0TuBOINgQsShlUAp9VYEJuhbF0EPD5NmggpPBWDDA
         UmuA==
X-Gm-Message-State: AJIora/4giVAVbek0KFq1PRnR5hDJ4s7JTh6UA0vg+viFkP8W9/Agvm1
        vtOT+wsMpA7pyoEwnvndyiqmgKJ9JWFCUxmk
X-Google-Smtp-Source: AGRyM1s07OhguYQs5tV3ucz3EYGgGo9ecZsOXEcsrgyzVS6TckfWI0FgPIzcYBcWg8dWbJ3s2K9Q3g==
X-Received: by 2002:a17:90a:2c0d:b0:1ef:c839:c34b with SMTP id m13-20020a17090a2c0d00b001efc839c34bmr45520873pjd.39.1658237343236;
        Tue, 19 Jul 2022 06:29:03 -0700 (PDT)
Received: from ffyuanda.localdomain ([101.206.227.243])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b0016be834d544sm624424pls.237.2022.07.19.06.29.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Jul 2022 06:29:02 -0700 (PDT)
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
To:     git@vger.kernel.org
Cc:     vdye@github.com, derrickstolee@github.com, gitster@pobox.com,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
Subject: [PATCH v1 5/7] mv: remove BOTH from enum update_mode
Date:   Tue, 19 Jul 2022 21:28:07 +0800
Message-Id: <20220719132809.409247-6-shaoxuan.yuan02@gmail.com>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
References: <20220719132809.409247-1-shaoxuan.yuan02@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since BOTH is not practically used anywhere in the code and its meaning
is unclear, remove it.

Signed-off-by: Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
---
 builtin/mv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/builtin/mv.c b/builtin/mv.c
index 2e9d577227..d05914a233 100644
--- a/builtin/mv.c
+++ b/builtin/mv.c
@@ -21,7 +21,6 @@ static const char * const builtin_mv_usage[] = {
 };
 
 enum update_mode {
-	BOTH = 0,
 	WORKING_DIRECTORY = (1 << 1),
 	INDEX = (1 << 2),
 	SPARSE = (1 << 3),
-- 
2.37.0

