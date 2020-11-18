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
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDCD9C63798
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6017D246EA
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 14:49:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="exRrj3I9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbgKROtP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 09:49:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgKROtP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 09:49:15 -0500
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17FD0C0613D4
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:49:15 -0800 (PST)
Received: by mail-wm1-x341.google.com with SMTP id c9so3269287wml.5
        for <git@vger.kernel.org>; Wed, 18 Nov 2020 06:49:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=9qslaTPO+s7Jj3mATmmfB/HDokSEiRFEEkxLgAF/jQI=;
        b=exRrj3I9Er2LweYMiObriR5CioJAsSaRbZLQay2BzY1ZTtb+iJtwoQIOuSH6RdDCOG
         hLTfMlND0EKG3SQ5g4eEpcIWdwkORkLyLY7eDTpB1PyxPspJv5Pnry+AxkyAc/exnoWl
         Dm1T9+q4iD/+snQ4MpLM0Qa2dxnFUdZGA9W1fJXuxloKYpLoHYdVFBDheONBsAbXs2Oy
         bkeRAlgh9QLZ9ib8cEhWWV4HHXCaBSXyqsSzdRh8uKeuNfBeafXAE9Dagk+m+pCSCL+t
         G/NPJhMFMlZyl9Z1lt66Nj91yYthNWywz3hXmzYHixUhB3tq1PjBgL8DBgxR2DQLjaJK
         NPzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=9qslaTPO+s7Jj3mATmmfB/HDokSEiRFEEkxLgAF/jQI=;
        b=bT4hHJZQ5HBg2kqftIVnKazaDhEq4q3DSNb2llgxYJ7tueYFNSNtsrqBidrZqPjDmr
         Hqtojgxd34OvvuGz/ZI8+TS183XgUG3a0u2lIab6mlVljFE6XPL8XwLaD309NSk18Wk7
         QygV199C/pjEZ14Y02nNfq7dTaw5nFEBb5rHvUUGzU4e8a2w00ZvX7NAh8pmCGJOEchE
         1hI22P+JFe+aL0HJvWtNtYDBQyws4Zu3q4fempWzzEzQjcWu2aonLitWfWFojyWdRrLW
         /9Kir57BjSn9d3aaQ+CflTl91G9xuAD4fsG2lcJx/EyiYCEghZnmCrVmOPuFEpyOZbs+
         P8Gw==
X-Gm-Message-State: AOAM531KEhrJMze60MtqkWnquNv3vBnQVrSIodOzTtpNnlyIMY6+X1eJ
        zQT2/WeqdEuUYoCNC6opv9tC1o+oWVs=
X-Google-Smtp-Source: ABdhPJyJINgBKH1366g5aLm28O0yLWfdQD/M2hW2VXgnJDZnP+LNVDiJwQwfKu9iKS4najmRiebwsg==
X-Received: by 2002:a7b:c92a:: with SMTP id h10mr417383wml.138.1605710950786;
        Wed, 18 Nov 2020 06:49:10 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id e6sm4031324wme.27.2020.11.18.06.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Nov 2020 06:49:10 -0800 (PST)
Message-Id: <7a750f1317143bf4488c21bd11c4e59558a3d7c6.1605710947.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.792.git.1605710947.gitgitgadget@gmail.com>
References: <pull.792.git.1605710947.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 18 Nov 2020 14:49:07 +0000
Subject: [PATCH 3/3] t2106: ensure that the checkout fails for the expected
 reason
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

During the transition of the test suite to a new default branch name, it
was noticed that this test case succeeded for the wrong reason when the
default branch name was overridden.

While we fixed that in the previous commit, let's make sure that we look
for a tell-tale in the error message that the `git checkout` failed for
the reason we wanted it to fail.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t2106-update-index-assume-unchanged.sh | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/t/t2106-update-index-assume-unchanged.sh b/t/t2106-update-index-assume-unchanged.sh
index 3396f23363..2d450daf5c 100755
--- a/t/t2106-update-index-assume-unchanged.sh
+++ b/t/t2106-update-index-assume-unchanged.sh
@@ -20,7 +20,8 @@ test_expect_success 'do not switch branches with dirty file' '
 	git checkout other &&
 	echo dirt >file &&
 	git update-index --assume-unchanged file &&
-	test_must_fail git checkout -
+	test_must_fail git checkout - 2>err &&
+	test_i18ngrep overwritten err
 '
 
 test_done
-- 
gitgitgadget
