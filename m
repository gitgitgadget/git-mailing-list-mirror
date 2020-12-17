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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A49A6C2BB9A
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80BE822D74
	for <git@archiver.kernel.org>; Thu, 17 Dec 2020 01:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732809AbgLQBIi (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Dec 2020 20:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731351AbgLQBIg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Dec 2020 20:08:36 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E59FC0611CB
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:22 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id k10so4019612wmi.3
        for <git@vger.kernel.org>; Wed, 16 Dec 2020 17:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=yVF+gyGriYlGq54eBRzupiWJuPknTUR9Y993OwwQ4Rg=;
        b=iQcPaeirSkZBVgAH+afVFx1Au1uIBKyxbbgpE9vWlV02lMwObq6gcIeLR83ZCXin00
         sXT2jHazr7vmnEvgR/HDmvTK+jb3uaZcpyesUsVQB8Vbqd/AXjp9Wxl4zepn0K60xDPT
         UjhBtDWJs7+ez8iPj3tAZq5HZ29CEOPrqsny4wA5jMWm60itj81FFhp0+tJa//s7aj3H
         XzsMAtioQj+zpSTB3KweTwTTEjOKXkI7HSzvKRyozq1EUe4FpAnObz8/A+DcaRnTH6mZ
         dSbMpd2rqwe3D/8ujbwF3vKzpFxOTuOGyJsMlEs7Wnk7dEaTAGnAVp3klmwQ37+Py84o
         R4qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=yVF+gyGriYlGq54eBRzupiWJuPknTUR9Y993OwwQ4Rg=;
        b=Xgehm8HkLrDEgKOqwnrQvCU4kUHt/vMy6uh78tnWVYR7izS8QBcP9O9ibomypQu9iR
         HjnG4C7VInJqsaE4FNTubqn6aW3PaOJSSnWuy56KDOkOP9pn7p3ds3rwvvhm48CRwLut
         3lA2u44JJmRRSQ1hUOio2lFPIcmU2EI6GU0cJH8gKE8vrO/H3yA6aQhpj1MXHg2FSanh
         T3AbsQH0DagU+JCdgzQq1ro/5eKdgVHAS9RKayat/BZjlbYZ+8JakYWiL/PbhZds1H+w
         zRmPaZmVPaf0VgP+p8cX/MKKkWHFQeuKrwCLyFQaQxmT2I3wU5ySmEprjpxDgd0TLFtv
         kZjw==
X-Gm-Message-State: AOAM530L/XP47HxqUAU9jrqJ9LVgwMfgwlH/HeoVr4DbwCsX26AlyDX9
        AXuiEy1rmHvRTn7ICBsTWNcMM2VbR5A=
X-Google-Smtp-Source: ABdhPJxZ3irR+ky4u+HRQs4KAV9WRJXAvBgduGvQoD5PneOJHa1wBndSc1FJSQT2sj177Y002LT/MQ==
X-Received: by 2002:a1c:3b44:: with SMTP id i65mr5990676wma.9.1608167241010;
        Wed, 16 Dec 2020 17:07:21 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z64sm5165449wme.10.2020.12.16.17.07.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Dec 2020 17:07:20 -0800 (PST)
Message-Id: <3dc48ce96867005b55f44e41e9baab7f0750ab98.1608167230.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.816.git.1608167230.gitgitgadget@gmail.com>
References: <pull.816.git.1608167230.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 17 Dec 2020 01:07:10 +0000
Subject: [PATCH 11/11] tests: drop the `PREPARE_FOR_MAIN_BRANCH` prereq
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

We no longer use it.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/test-lib.sh | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/t/test-lib.sh b/t/test-lib.sh
index a863ccee7e9..9fa7c1d0f6d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1712,14 +1712,6 @@ test_lazy_prereq REBASE_P '
 	test -z "$GIT_TEST_SKIP_REBASE_P"
 '
 
-# Special-purpose prereq for transitioning to a new default branch name:
-# Some tests need more than just a mindless (case-preserving) s/master/main/g
-# replacement. The non-trivial adjustments are guarded behind this
-# prerequisite, acting kind of as a feature flag
-test_lazy_prereq PREPARE_FOR_MAIN_BRANCH '
-	test "$GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME" = main
-'
-
 # Ensure that no test accidentally triggers a Git command
 # that runs 'crontab', affecting a user's cron schedule.
 # Tests that verify the cron integration must set this locally
-- 
gitgitgadget
