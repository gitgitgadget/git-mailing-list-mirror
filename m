Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD408C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C7578613AE
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 12:32:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231365AbhGEMfR (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 08:35:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbhGEMfN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 08:35:13 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2EEC061574
        for <git@vger.kernel.org>; Mon,  5 Jul 2021 05:32:36 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id x22-20020a9d6d960000b0290474a76f8bd4so16553451otp.5
        for <git@vger.kernel.org>; Mon, 05 Jul 2021 05:32:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CS0EQ9MfPPVqM6Y/VLVqs7hHXSZ6SLu2Z2ulk8QOCYs=;
        b=V5+sbKNqhxd/f+GvjRwn00sxdEFoz3PsGRFTT/OJUqtn1MtLba4ZtSnE8Mmyf9eNKn
         0gIbFwlVlKe4Jo5jEaYnhnF9nqOFbh9mtW6Ed4HwVxGsBCyBc1eu7D8Rk1BNn4+6P1MB
         ebfAEVvyMWVgr6q0+CS35RRjbix3vovzZ67Lj/tpvb1CDemrhM97XarucpMNggTLhMxH
         u933CeamoOfN9S0vw6CSUOjKWCXkbq1pdMVXjpQa2L5a3puhmLSd8mc3eUosAW+djBOD
         LTSU6KC7iMp5y7OooEs9QgqN92eSBvdUj/SSigzT4EnXaVU7rKuLprtosKueNA+BMtS8
         6J4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CS0EQ9MfPPVqM6Y/VLVqs7hHXSZ6SLu2Z2ulk8QOCYs=;
        b=gG3JH1XgNwjNgh+/DS5fzRXOSoQmMy2FOX6/vnp1S9VPoKm0tslXIk1ypEImCCHeFm
         FDbfwYOcgJBF/wt/FvP/b0dU9D3l5ByPqzg/dRMUJ1jnjAbxB8T074eGLFAis6oGc/2T
         +v+RmWBo2jK4boLcjtCOVNkjfhQNLYKJzO+e1PHTitnH0MTurdyxZMBD/7ik0ERWHrpn
         qWqtqcKzvjXHRHjEbdbUI7pqynv64J5eAIcN9/c6M8vDjVv/QbTKKZh66ysalnvOWCzV
         dxZPAtTE5G8eRgrbvlD8l3o/SxAA6eHDcFGTIGWcv0eB//gsjFGT0wIvOmDjQ6GC5Nyi
         CKWA==
X-Gm-Message-State: AOAM532TXuC3Ai4DqsL01exn+mBDSMqebCXJPfbBpznMVenk/p56PB0Q
        Uy2Opu3RKDfrsBKcDR7ygGhCEkVooAeZeQ==
X-Google-Smtp-Source: ABdhPJxFBpq9D06mnABHJvlq7M2jjDmzL+e5ZwvqJ0kxEP+ukVwO0fvQyD0jf0kVqMi3Qe9GKKfcZA==
X-Received: by 2002:a9d:4104:: with SMTP id o4mr11129727ote.139.1625488355398;
        Mon, 05 Jul 2021 05:32:35 -0700 (PDT)
Received: from localhost (fixed-187-189-187-231.totalplay.net. [187.189.187.231])
        by smtp.gmail.com with ESMTPSA id 186sm2215229ooe.28.2021.07.05.05.32.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jul 2021 05:32:35 -0700 (PDT)
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     git@vger.kernel.org
Cc:     Alex Henrie <alexhenrie24@gmail.com>,
        Richard Hansen <rhansen@rhansen.org>,
        Junio C Hamano <gitster@pobox.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RFC PATCH 14/35] update: reverse the order of parents
Date:   Mon,  5 Jul 2021 07:31:48 -0500
Message-Id: <20210705123209.1808663-15-felipe.contreras@gmail.com>
X-Mailer: git-send-email 2.32.0.36.g70aac2b1aa
In-Reply-To: <20210705123209.1808663-1-felipe.contreras@gmail.com>
References: <20210705123209.1808663-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The order of the parents in git pull is wrong, many big threads [1] [2]
have been started because of that.

There's no need for git update to repeat that mistake.

[1] https://lore.kernel.org/git/20130522115042.GA20649@inner.h.apk.li/
[2] https://lore.kernel.org/git/4ay6w9i74cygt6ii1b0db7wg.1398433713382@email.android.com/

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 builtin/update.c  | 2 +-
 t/t5563-update.sh | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/builtin/update.c b/builtin/update.c
index 5946b383f5..94e83532a8 100644
--- a/builtin/update.c
+++ b/builtin/update.c
@@ -59,7 +59,7 @@ static int run_merge(void)
 	int ret;
 	struct strvec args = STRVEC_INIT;
 
-	strvec_pushl(&args, "merge", "FETCH_HEAD", NULL);
+	strvec_pushl(&args, "merge", "--reverse-parents", "FETCH_HEAD", NULL);
 
 	ret = run_command_v_opt(args.v, RUN_GIT_CMD);
 	strvec_clear(&args);
diff --git a/t/t5563-update.sh b/t/t5563-update.sh
index 833a5285da..72d6a357a1 100755
--- a/t/t5563-update.sh
+++ b/t/t5563-update.sh
@@ -53,7 +53,9 @@ test_expect_success 'git update non-fast-forward with merge' '
 	git commit -m new &&
 	git checkout -b test -t other &&
 	git reset --hard master &&
-	git update --merge
+	git update --merge &&
+	test_cmp_rev @^2 master &&
+	test_cmp_rev @^1 other
 	)
 '
 
-- 
2.32.0.36.g70aac2b1aa

