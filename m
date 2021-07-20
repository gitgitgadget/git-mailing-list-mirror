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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93241C07E9B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 71BBF610C7
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 17:09:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232726AbhGTQ2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 12:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232770AbhGTQY1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 12:24:27 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBFDC0613DC
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:04 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id k4so26769177wrc.8
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 10:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=luGuMJDPRMnjXEoCSqhvE+ut/GB0VLXv5Jme/aSENz4=;
        b=idRStOs6G5y/+xB61Ep3mlx8ysx5wrAQ82R96AANi6GK05JFj9DSYRulvzfC8/+4co
         vsVelgGFsxFku+TgQet1vBZvpEbdeZ5GLQwh5F+/wcPG0NXzZXBMlwYlnv9cSK2CG/jt
         rVUmk32XrPtjM9pAaQup53Z3wplO60h0ZFudpzdOjfDdFvJYGIud5iuACuCYOfendaXZ
         pSPUT5ERgQsLRwnCeT9tKMUiesFC3xaNCH1ZxyEeHAkxJTcM7vliZIW1tKKx1+uopsvz
         X/Y2h4EiEmjsNn3njBeZFyKk2B2vSIFzRjVht5O/Wce+/jQAv2ei/299YzcelXiOn8vj
         q2VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=luGuMJDPRMnjXEoCSqhvE+ut/GB0VLXv5Jme/aSENz4=;
        b=d2l5OkP4YggkV7x15aLT2AloDWfCuCsoohw+zjpRiXbg81tyD8/cuftUjynB7iBwE8
         EZqsm6x9i6PNtASMfyvOin1DpIbB3xLl6O0+kll3dhrSU3UOE9HcmK261RQR/HsIfBx2
         NW6OcU9aar9Bntb+M+OSRFGnO+aCV5VkN6/44MITT9gUl2XNivX0Q3azUdxzd9DyA0Jd
         UXeAOH8I/n+XUcXKo4msSgFymYgjyVC3hmkTG9blXtjKIBOtiCgum/BaROvqaYCMvYCZ
         DQZZLfJiTGJV/KlX9RrCAw0P06tPHKmoYXkCSPhGBwvgeDSnCr58Y+HlIXA5LlibQkuP
         j/VA==
X-Gm-Message-State: AOAM53154g4VgcmN3cKWgyQoTSDTbF+uUc+1F0SQR2La2hsKyDOC+5ty
        dedY7bKGkBxih3YYDpaC6TiJTR8L+Z4=
X-Google-Smtp-Source: ABdhPJwSJUDXAL61SKAYphmSFHCkwSgddOgX4ggOIHYxWYaD9r71OT8YSsroBO4PEm1qCP3LQk5ICQ==
X-Received: by 2002:a05:6000:1a86:: with SMTP id f6mr17223858wry.127.1626800703151;
        Tue, 20 Jul 2021 10:05:03 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v11sm23779911wrs.4.2021.07.20.10.05.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 10:05:02 -0700 (PDT)
Message-Id: <73eece0caacb7519edf338f040f08d381456df88.1626800687.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
References: <pull.1054.git.git.1626800686.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 20 Jul 2021 17:04:43 +0000
Subject: [PATCH 23/26] t1301: document what needs to be done for reftable
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

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t1301-shared-repo.sh | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
index 84bf1970d8b..a5755b4a434 100755
--- a/t/t1301-shared-repo.sh
+++ b/t/t1301-shared-repo.sh
@@ -22,9 +22,10 @@ test_expect_success 'shared = 0400 (faulty permission u-w)' '
 	)
 '
 
+# TODO(hanwen): for REFTABLE should inspect group-readable of .git/reftable/
 for u in 002 022
 do
-	test_expect_success POSIXPERM "shared=1 does not clear bits preset by umask $u" '
+	test_expect_success REFFILES,POSIXPERM "shared=1 does not clear bits preset by umask $u" '
 		mkdir sub && (
 			cd sub &&
 			umask $u &&
@@ -114,7 +115,8 @@ test_expect_success POSIXPERM 'info/refs respects umask in unshared repo' '
 	test_cmp expect actual
 '
 
-test_expect_success POSIXPERM 'git reflog expire honors core.sharedRepository' '
+# For reftable, the check on .git/reftable/ is sufficient.
+test_expect_success REFFILES,POSIXPERM 'git reflog expire honors core.sharedRepository' '
 	umask 077 &&
 	git config core.sharedRepository group &&
 	git reflog expire --all &&
@@ -201,7 +203,7 @@ test_expect_success POSIXPERM 're-init respects core.sharedrepository (remote)'
 	test_cmp expect actual
 '
 
-test_expect_success POSIXPERM 'template can set core.sharedrepository' '
+test_expect_success REFFILES,POSIXPERM 'template can set core.sharedrepository' '
 	rm -rf child.git &&
 	umask 0022 &&
 	git config core.sharedrepository 0666 &&
-- 
gitgitgadget

