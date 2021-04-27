Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C54F3C43460
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8FE1D611ED
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235932AbhD0Kju (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238245AbhD0KjO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:14 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1502C06175F
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:29 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id n2so5779693wrm.0
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=GINUYoeKtVZX7Ae2Vsi9H9ikU3XWyESu7g709miUeWI=;
        b=BEMBmKi8Vnmfys+/mS93yldvG68qZP7autZrZERTfesq08IH1LcaK+8Yz8eiHyWxZg
         iosxniDLBr0KGpHFxVXT6uCGbLlkC7Ch2C73A9mxhHU4z+L4mrTg1HEChIh3qNwytK1J
         xnyob+QE66iqy88ORzl7uqU0wC8mZbf2PgsAz8v92LkVdsfHavACzVQJgsbwIcuWO3BJ
         ntuf6pHHy74k1yr6W4sulFfUesVtCELXX9ZiyQUEsDeMqXKblzMPxmkIccKAxgwRvo9l
         2iQi7tgSHu7nhlrGL6LwbGw/kNhYFYPgmEVvHwr0s+6w/aK0PDsQ53Iqgg3CuiLT29TD
         FqEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=GINUYoeKtVZX7Ae2Vsi9H9ikU3XWyESu7g709miUeWI=;
        b=p25coBIG+yj61EccoRCLSGJAcM5f95Mi7eTuEupOUiTgXUAQOKuh+rAFGiDuvWHrdG
         5O9RnyzGzrN2+Z4N++/2xkH9GBOJGZH9mVUKRth9zCMWnMRxxIakzTPVzKTJOjHOTXHh
         nyiShQbfXIY5EiBzcyK5GFYUEXsMnXLM+z/NMP0r2Vrw95fhC4o3zExc+WVeJVytX8S2
         8n52oTmp7hzPW2AkWrKH3BWG7FAPbw1ebpWEKYjt/bAJJ+/OXtyfPq2bHGuEGIFXxaLf
         YR27q4IkSyWxk7tkDbuaHitKpzz1mNPLskmLGIQp7rB/ZnmLGpdGTp4xITkPyGuTsLrC
         MmHQ==
X-Gm-Message-State: AOAM530FYxSNPnHn1hSFudOMEx4uK4HjdT6lfaRlsob1yxSBArhj2Tm1
        NT0rjd3S6JKskqlOtjKo3KDVut7gSOM=
X-Google-Smtp-Source: ABdhPJyIXEehblzaLTpC+hdT1EB7IAr4guIxrMOZPNkglN7IiJRQgu3Rltx2Zh86/RbhkGAyAWI9hw==
X-Received: by 2002:adf:e602:: with SMTP id p2mr14377455wrm.119.1619519908665;
        Tue, 27 Apr 2021 03:38:28 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u2sm2042550wmc.22.2021.04.27.03.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:28 -0700 (PDT)
Message-Id: <89cc215c601437147cd4f7c6641ac0382d951190.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:08 +0000
Subject: [PATCH v2 07/21] t1301: fix typo in error message
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1301-shared-repo.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index ac947bff9fcf..84bf1970d8bf 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -124,7 +124,7 @@ test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
 		: happy
 		;;
 	*)
-		echo Ooops, .git/logs/refs/heads/main is not 0662 [$actual]
+		echo Ooops, .git/logs/refs/heads/main is not 066x [$actual]
 		false
 		;;
 	esac
-- 
gitgitgadget

