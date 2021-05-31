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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC735C47082
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8D22460231
	for <git@archiver.kernel.org>; Mon, 31 May 2021 17:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233962AbhEaRmI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 31 May 2021 13:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhEaRk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 31 May 2021 13:40:56 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA57C008750
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:47 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id f17so5164168wmf.2
        for <git@vger.kernel.org>; Mon, 31 May 2021 09:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=l17v4eWcuIz5pcAQi/ukzjzeTtk5+12BXmBJ1RlUYcI=;
        b=AqUdijP/GN2Rm66zvJwVgCoiTW/TBbG/f/Mutx/H3pzJCBUtgkjquYuGeDXB9iip3B
         Dv4yY+a//IxGfqWZ1uH3rmBYPjwuFfgPCvD3Y9pYMEfO6Ed5g90iW2VkXrdDWq9YnGIQ
         +aeh/Yqn/j/NpbYys+GErQWMVPB5pQrATvPdom6qpHHDVs1LMsN1VMLdQBQsFBinzson
         CN6ad6UtnvQ91qe8bCMPoBsdGMJgA2jY16qKem2d+rHQKou6HiXZ6Xc6NB+yvWR0r/gB
         0zB7UxkpSrU2d8mY3QO6Po0Dm7fAViPsVxFWNcx8o/iGoFnzdAssaa/BVzKzoVi079cB
         8+cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=l17v4eWcuIz5pcAQi/ukzjzeTtk5+12BXmBJ1RlUYcI=;
        b=qYoKCN16Z5Q12pHY8gzpXx/YRhugcOpWRfU6H5WV4Vu15kTA3bZXdkO0LJX7bStAVf
         j4r7s/RARvMutl2cA4nSvtnDIIWoWeRuxVeUQbiq7lea/IOSFR/3kWKbaLxnerZuqVwe
         HQX82Lr5D+1Vsdiy+OWmO4L9D5GcfD86M4Y0Q8k9UJq8NkzaHjITVw/cXRe+g2CbxD2K
         g0zBBmwRgigAIsl4Ul1/ZUUzKLy5VA90L6+QnzYX6Fh3DVxQ4v5Tb1GxO8G25QGIeLMy
         I+jXlbr+2eU7Ve0xY4t7v02JwQkMqkQicJ8QKx0pJAp6pOexXnSxF5pj4E0wOY/6qtMM
         pWgQ==
X-Gm-Message-State: AOAM532XviLntJNwkLcHP/zDaUG+AaGYgJRXWlbSfZx9MfkLTgA8Av8y
        MumzuhCOeAkHcdi5BCoVeRud1LlDosI=
X-Google-Smtp-Source: ABdhPJzlPearRAOnj3qMUEEbGRXreHiX1SGqyV7gxdc15uEb8vu45/fPmQAjeFAEg9hq+VjURKsnsA==
X-Received: by 2002:a7b:c185:: with SMTP id y5mr21811305wmi.63.1622480206618;
        Mon, 31 May 2021 09:56:46 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u3sm292306wre.76.2021.05.31.09.56.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 May 2021 09:56:46 -0700 (PDT)
Message-Id: <8c552699fdbcebe645d860a1048d1e1d5f268831.1622480197.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
References: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
        <pull.1008.v3.git.git.1622480197.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 31 May 2021 16:56:29 +0000
Subject: [PATCH v3 14/22] test-lib: provide test prereq REFFILES
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     SZEDER =?UTF-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Han-Wen Nienhuys <hanwen@google.com>,
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
Reviewed-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/README      | 6 ++++++
 t/test-lib.sh | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/t/README b/t/README
index 1a2072b2c8a2..9e7012230203 100644
--- a/t/README
+++ b/t/README
@@ -1126,6 +1126,12 @@ use these, and "test_set_prereq" for how to define your own.
 
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
index adaf03543e81..76929a886fbf 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1488,6 +1488,8 @@ parisc* | hppa*)
 	;;
 esac
 
+test_set_prereq REFFILES
+
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
-- 
gitgitgadget

