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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8095C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 813096101E
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237479AbhDSKxj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232344AbhDSKxh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:37 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F7EC061760
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:06 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id t14-20020a05600c198eb029012eeb3edfaeso7939971wmq.2
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=pVIbHKHPh41o4/BwEY9XmDMRkGcfQAbU60mJBDzyIg4=;
        b=XSC6Bk6a8Gp7l3CzKkVIiTM9cANPI+jVkT/RLCV/VuIMTvmPrDKE8wo1U7ffP9VuCi
         8h3LSc/C9GdR1f3bOy0x5ePCKLtPg/oyl2xsumC1/ZP2WrTVmCDcNUFRKb55gOF8QJ+A
         HyILrQ0DKxe3IU//3ux9Q24Rd8h724d69R0QRxlHss2EfVJc2ejr03YABXVyMrDWGEGp
         Vo9Do40o94RPtLvWSlS0UHODX14i3eATfKCIaWUGDd4RVm1+EN1+woD70n0B8WTdHtfg
         H4A0lH0/0Q8AiH7/hZ22Xw9gKosQL6gQZQLKjxNIWC7t9OoYoOkrNSecT4aesoVC7Trz
         ivyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=pVIbHKHPh41o4/BwEY9XmDMRkGcfQAbU60mJBDzyIg4=;
        b=U6xGR3c6wxmkxVDVWeisjKwm8RVWj6PfaQ4cEHRD17AQFjIBsmb7QQVi39WOcBWLgf
         uSrgX7qYfvYqLwQhs9rD6FEkcF+ojLEzddaV5ALbtud7tQpCgj+LjTmn0GHDmbponDc1
         eckDmIVn2JF3UO4yLYkWOeqNmDVX5Bqhdx521ZvQmp1rK2zX67UaADrnHdJT8+HiQ9Qa
         2uOWsjwkdFQRgnHvuXaioH3j/myTPujl40G/rs/N5Jbi5TkZNK/tNApXhI988i7XHQ/D
         O7TllD59lR5QaWi2SZNjRPdzO2zX6WQLNYkhjc+/GipJ8CDh0+cm0XS7O/LylLPZMuPa
         B+aQ==
X-Gm-Message-State: AOAM531muHPL1Fkw+zTbm8mnRdbMi3V9EIzxJPFsOHf5hpIpQWFzzswe
        RVOUAYaUX7sCxoargB2P4kd4j7S4VQI=
X-Google-Smtp-Source: ABdhPJxYbsoVXJRdhGbc8O1ziww+M5l/UinH/A8j8k/8x88vru+H0NLlOf/2X70GnnywAGOb2xwTag==
X-Received: by 2002:a1c:e309:: with SMTP id a9mr20586903wmh.63.1618829585279;
        Mon, 19 Apr 2021 03:53:05 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 61sm23798563wrm.52.2021.04.19.03.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:05 -0700 (PDT)
Message-Id: <91ef012cbcc9a3106fa51236e20458f108e50ce9.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:46 +0000
Subject: [PATCH 01/18] t4202: split testcase for invalid HEAD symref and HEAD
 hash
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

Reftable will prohibit invalid hashes at the storage level, but
git-symbolic-ref can still create branches ending in ".lock".

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t4202-log.sh | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 350cfa35936a..c575deaad4fb 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1834,14 +1834,17 @@ test_expect_success 'log --graph --no-walk is forbidden' '
 	test_must_fail git log --graph --no-walk
 '
 
-test_expect_success 'log diagnoses bogus HEAD' '
+test_expect_success 'log diagnoses bogus HEAD hash' '
 	git init empty &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep does.not.have.any.commits stderr &&
 	echo 1234abcd >empty/.git/refs/heads/main &&
 	test_must_fail git -C empty log 2>stderr &&
-	test_i18ngrep broken stderr &&
-	echo "ref: refs/heads/invalid.lock" >empty/.git/HEAD &&
+	test_i18ngrep broken stderr'
+
+test_expect_success 'log diagnoses bogus HEAD symref' '
+	git init empty &&
+	git --git-dir empty/.git symbolic-ref HEAD refs/heads/invalid.lock &&
 	test_must_fail git -C empty log 2>stderr &&
 	test_i18ngrep broken stderr &&
 	test_must_fail git -C empty log --default totally-bogus 2>stderr &&
-- 
gitgitgadget

