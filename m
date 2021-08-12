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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B72FC4320E
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 13:42:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 300226108C
	for <git@archiver.kernel.org>; Thu, 12 Aug 2021 13:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237589AbhHLNml (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Aug 2021 09:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237464AbhHLNmj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Aug 2021 09:42:39 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA634C061756
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 06:42:13 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id w21-20020a7bc1150000b02902e69ba66ce6so4622281wmi.1
        for <git@vger.kernel.org>; Thu, 12 Aug 2021 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Ie/vTpaZjoYYM+wcuUOybM98pAjxfGBaT/FQqhdXUAA=;
        b=qeuCdl0uCNDkf1+XZeuLQ/vTGDBgk7i+9GzbSMHy7/2W359u5vCvAXTHwKsORQa13s
         U4vZ3HPLqvO1AAXFE9/O/ryy0wZ7x7lcH9rERLkm/9HKcC3t3Og/CqBx2Yh65bAt/trU
         3qJJkuzSRreCg+sX/Bo+gLGbkV4JINN9fvzKDN4ZtC9xTq4kPsCbLLimAc0PaiyyiB5D
         DGhXyzBbrp2hg/Bvlz2smeedtNael1fQ1qi906DHr0e6BzbGnAvbkM0UMC58ynevcSZm
         TKBbxZIERcOlvip0CFqvC9bK9iynbo9MO9ys0agb6ZPBRTBKMAgpb5I2IffguWEZV9IO
         qEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Ie/vTpaZjoYYM+wcuUOybM98pAjxfGBaT/FQqhdXUAA=;
        b=Hf8qkuugPFUUFR+w/0UeljmrT58OX6ykgzyi0502TDzXiCTNm7Uj/n2aME8mEZIViX
         ITz42BMruj8LGfIMrYc7NlKB8KubotSZcmIqBVT6MlQIgkGXPhnXbJiqyJmNmTGRKqIY
         okTrtCh53Gs1N5Z53m2+k1UJvyYoV+NETNJzToS5xhPW7uUK77auqv2ZxOXaeZnc7ymj
         USqez7VVCno9ufxDLzmPhd05Jtyhg+5cuWM3l5RNTjh/4zgJNmFtl4C+95HSDs5QK/Bh
         Hkhg23KnhJiNRmyw3B2jNF/QnGuc0Km1y+Bg+rvVbTiW1ygKBHpLTj6+4CPPPFNeUU0/
         Vx2Q==
X-Gm-Message-State: AOAM533uMSiuJF8aVOxZ1R/vUdiORC+d9pdLnyZL4Ie23z5y4tCEzLCK
        OUBxvYtg4d8zP5cgXFKXjCxOEg/UvNA=
X-Google-Smtp-Source: ABdhPJzyQEKDcSjne0NDYIVe2jllbBzVSD/1fz4rJvdccHgszDV8ic3DB/07tN6mTln7AteIdmzTbQ==
X-Received: by 2002:a7b:c144:: with SMTP id z4mr15312059wmi.55.1628775732478;
        Thu, 12 Aug 2021 06:42:12 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id j194sm10709010wmj.3.2021.08.12.06.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Aug 2021 06:42:12 -0700 (PDT)
Message-Id: <84fe5823b4fa2572c2e0080e746131a4ec148ad3.1628775729.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
References: <pull.1013.git.1628587917.gitgitgadget@gmail.com>
        <pull.1013.v2.git.1628775729.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 12 Aug 2021 13:42:08 +0000
Subject: [PATCH v2 2/3] rebase --apply: restore some tests
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

980b482d28 ("rebase tests: mark tests specific to the am-backend with
--am", 2020-02-15) sought to prepare tests testing the "apply" backend
in preparation for 2ac0d6273f ("rebase: change the default backend
from "am" to "merge"", 2020-02-15). However some tests seem to have
been missed leading to us testing the "merge" backend twice. This
patch fixes some cases that I noticed while adding tests to these
files, I have not audited all the other rebase test files. I've
reworded a couple of the test descriptions to make it clear which
backend they are testing.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3403-rebase-skip.sh     | 2 +-
 t/t3418-rebase-continue.sh | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3403-rebase-skip.sh b/t/t3403-rebase-skip.sh
index 6365c5af2f7..a44e68d0ffb 100755
--- a/t/t3403-rebase-skip.sh
+++ b/t/t3403-rebase-skip.sh
@@ -52,7 +52,7 @@ test_expect_success setup '
 	'
 
 test_expect_success 'rebase with git am -3 (default)' '
-	test_must_fail git rebase main
+	test_must_fail git rebase --apply main
 '
 
 test_expect_success 'rebase --skip can not be used with other options' '
diff --git a/t/t3418-rebase-continue.sh b/t/t3418-rebase-continue.sh
index f4c2ee02bc9..bda5e5db802 100755
--- a/t/t3418-rebase-continue.sh
+++ b/t/t3418-rebase-continue.sh
@@ -21,7 +21,7 @@ test_expect_success 'setup' '
 	git checkout main
 '
 
-test_expect_success 'interactive rebase --continue works with touched file' '
+test_expect_success 'merge based rebase --continue with works with touched file' '
 	rm -fr .git/rebase-* &&
 	git reset --hard &&
 	git checkout main &&
@@ -31,12 +31,12 @@ test_expect_success 'interactive rebase --continue works with touched file' '
 	git rebase --continue
 '
 
-test_expect_success 'non-interactive rebase --continue works with touched file' '
+test_expect_success 'apply based rebase --continue works with touched file' '
 	rm -fr .git/rebase-* &&
 	git reset --hard &&
 	git checkout main &&
 
-	test_must_fail git rebase --onto main main topic &&
+	test_must_fail git rebase --apply --onto main main topic &&
 	echo "Resolved" >F2 &&
 	git add F2 &&
 	test-tool chmtime =-60 F1 &&
@@ -254,7 +254,7 @@ test_rerere_autoupdate () {
 	'
 }
 
-test_rerere_autoupdate
+test_rerere_autoupdate --apply
 test_rerere_autoupdate -m
 GIT_SEQUENCE_EDITOR=: && export GIT_SEQUENCE_EDITOR
 test_rerere_autoupdate -i
-- 
gitgitgadget

