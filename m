Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA719C433DB
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:03:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99C2423A5C
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 23:03:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730851AbhANXDl (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Jan 2021 18:03:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730770AbhANXDk (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Jan 2021 18:03:40 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B716AC061757
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:03:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id v1so3971286pjr.2
        for <git@vger.kernel.org>; Thu, 14 Jan 2021 15:03:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZCxlk2J6nEyPCEWCoEFchZ+ZfqXmOUrCRYs1+jgRX3A=;
        b=S73FG5/NhoI5eIJWFr2boWdhjjRZY8d1c7lTHjMmv/3i0Cbn5koin5vHSjw9X2iPVs
         benmHBsAQnQScKfcOg3OCTuOXheQTdd9soNKDTnBLjuGSQCuz0DUAPk1UZCOjYw+5m2u
         uhU8u3+fIlMia+qT0etxOifMiD5GJUMrx4L8pRSxmF071SqweupmwLie8ksfrJEJlXXE
         RYeDB62PTofUUZCIaYZ0d93/202yrEf2SqwsOG0BAR3huQOs0xFRq8vUQYHx9NpUCwd8
         FOXBlolTKftLOKdyzMTbrvvgC3Y6gT5xvLfFiOlzGEB3at0JMgPapWBrw5xVqFMhR834
         XqHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZCxlk2J6nEyPCEWCoEFchZ+ZfqXmOUrCRYs1+jgRX3A=;
        b=uPECeZYphYgy3lH5NOkFtlqn7OelWdIqV10/yr5mSNNipMH0YXtoi5ScntEhsyJsh5
         FHgyMv9KXON288tYwzmAW/Y/U5op3qzl0zgVhNf3WimvJ/lQ3MJ61E4bp7ASYCiX7ZYN
         MljhMMkFMQERyHALAPlDFglG1e3HIG5RbVnAWSMfhXaO9Ed5I3sllFTv0qXvayFerL6N
         C9I1MvF0m2KzuwBnIk6WYuMv62K9v87cdoLZwwggA57rAdJM20lESdjq7tLBpnL2c2cq
         yDcxwGJvG8/4l/sE2cyZmaZs2iP6d1mnp0ZpSFBMCvhlXZABu59hYbXwykXaMbKyRTXF
         8tiQ==
X-Gm-Message-State: AOAM5310ASAQTvRtYNmtK9a3FzoLTjNNfFW3hW4Acc/h902GpBmydSlm
        JetStu8oPtHbjT2ZfQij+NhZNxTZDpY=
X-Google-Smtp-Source: ABdhPJxWJ7bxI3SUfvN1hkOlmTl3iHHkozO4M0zgyHuYNw+0EwK1UbeV/KrvTDveRwzKW+U/iUTXDw==
X-Received: by 2002:a17:90a:3989:: with SMTP id z9mr7326780pjb.198.1610665380090;
        Thu, 14 Jan 2021 15:03:00 -0800 (PST)
Received: from archbookpro.hsd1.ca.comcast.net ([2601:647:4201:c540::414c])
        by smtp.gmail.com with ESMTPSA id n1sm6030261pfu.28.2021.01.14.15.02.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jan 2021 15:02:59 -0800 (PST)
From:   Denton Liu <liu.denton@gmail.com>
To:     Git Mailing List <git@vger.kernel.org>
Cc:     Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] test-lib-functions.sh: fix usage for test_commit()
Date:   Thu, 14 Jan 2021 15:02:40 -0800
Message-Id: <e9add5f066cb0209ff9f6a0ef71584b54afd04d7.1610665323.git.liu.denton@gmail.com>
X-Mailer: git-send-email 2.30.0.284.gd98b1dd5ea
In-Reply-To: <cover.1610665323.git.liu.denton@gmail.com>
References: <20210112201806.13284-1-avarab@gmail.com> <cover.1610665323.git.liu.denton@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The usage comment for test_commit() shows that the --author option
should be given as `--author=<author>`. However, this is incorrect as it
only works when given as `--author <author>`. Correct this erroneous
text.

Also, for the sake of correctness, fix the description as well since we
invoke `git commit` with `--author <author>`, not `--author=<author>`.

Signed-off-by: Denton Liu <liu.denton@gmail.com>
---
 t/test-lib-functions.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index b0a5d74dc7..cea73cb8f0 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -188,8 +188,8 @@ debug () {
 #	"<file>"
 #   --signoff
 #	Invoke "git commit" with --signoff
-#   --author=<author>
-#	Invoke "git commit" with --author=<author>
+#   --author <author>
+#	Invoke "git commit" with --author <author>
 #
 # This will commit a file with the given contents and the given commit
 # message, and tag the resulting commit with the given tag name.
-- 
2.30.0.284.gd98b1dd5ea

