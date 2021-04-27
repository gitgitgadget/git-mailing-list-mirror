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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42375C433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 155DF610FA
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237785AbhD0KkD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:40:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238359AbhD0KjR (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:17 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6DAEC061574
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:32 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id b19-20020a05600c06d3b029014258a636e8so2415881wmn.2
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ysi4oObk5JM1CaxHZuYRof/NRZf4UYF0Gr6BxiTvA3w=;
        b=VHXrxDuLsr2eBnbt6Dhd0X4tmh0iFmeyF17nhE1BZDUkN0925xBTgrRA5+d090ZVgQ
         1D+DFOsopvrY3PFl2nm91tse1N+UvF//FadYAABGbrl9LfCadZSf8OJBAI5XgPtIKZfr
         fpGNQTgna1NKxsta9h5mG0Qo0foZpVmeKd023yoH0dUJyY2NiNGNEjoZM5L3thb4FDMV
         YVJNHZ0uAFZWN7uLt4bmkdNSWQRuBV2haWk8tSoiKO/ud4mjEItokxSAsj4lfchiOCGp
         HFCFrLYSXt5dpniKn+ux1K4jyaIHBlLoGERP8fAcRvbx/4R4ojv2Uwl9lvQjf0w51k/A
         y56g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ysi4oObk5JM1CaxHZuYRof/NRZf4UYF0Gr6BxiTvA3w=;
        b=pdqYGVi0lQLcqH64S8iEJDcExA8XbHsu7wG422u4CL0/z8FFsOghMTpdqnFszfU/2w
         ZpiRMhK+J0k+Kzve7PdnruCvtCGm2qZrIMpiTF5vDMterHi87Q5V5afKxYwhd0x0aYzl
         /R6GJf4tTipWHJC8tQ/GFbw41XaShsL+u9aGdLN5f7166Dgd86O3PVgbIc/bVgMm1eel
         Ic3Nd7/lxPKHqbtIKuX7m/U4UQMdVoVShiZhUcwzswU0kAr5vqRC3WWkXTr7HsfxyEq4
         xGeed4SWA9lrmVfwHY36AsY9kmsdJNM5C7O8BQRX1UPZ3I/9fay0CkMJHt7WY7H42Ei9
         8hTQ==
X-Gm-Message-State: AOAM533zVVJG6STYkXQOz1uOepO8PMblmztQs0UDhHb9wZHpD/qjOdlq
        Dp+8IGuIvyE+qa4F/DcnX66GpSW6xmg=
X-Google-Smtp-Source: ABdhPJwjmWe/2jcv02UwFOh+PvbennRjbz5yK5rr/ntRkk1W4+dmTr3isVq5d+AkQ4c8FsTXD8M3wQ==
X-Received: by 2002:a7b:c091:: with SMTP id r17mr3564872wmh.28.1619519911792;
        Tue, 27 Apr 2021 03:38:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i17sm3412414wrn.87.2021.04.27.03.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:31 -0700 (PDT)
Message-Id: <180847f4db1470bcc585a93f662eb5e60ea010ea.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:14 +0000
Subject: [PATCH v2 13/21] test-lib: provide test prereq REFFILES
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

REFFILES can be used to mark tests that are specific to the packed/loose ref
storage format and its limitations. Marking such tests is a preparation for
introducing the reftable storage backend.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/README      | 6 ++++++
 t/test-lib.sh | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/t/README b/t/README
index fd9375b146d1..723bd3387fb7 100644
--- a/t/README
+++ b/t/README
@@ -1114,6 +1114,12 @@ use these, and "test_set_prereq" for how to define your own.
 
    Git wasn't compiled with NO_PTHREADS=YesPlease.
 
+ - REFFILES
+
+   Test is specific to packed/loose ref storage, and should be
+   disabled for other ref storage backends
+
+
 Tips for Writing Tests
 ----------------------
 
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 3dec266221cd..4a0c08e81e12 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1483,6 +1483,8 @@ parisc* | hppa*)
 	;;
 esac
 
+test_set_prereq REFFILES
+
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
-- 
gitgitgadget

