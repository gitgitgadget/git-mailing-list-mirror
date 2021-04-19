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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37777C433B4
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FEA56101E
	for <git@archiver.kernel.org>; Mon, 19 Apr 2021 10:53:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238488AbhDSKxt (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Apr 2021 06:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237914AbhDSKxk (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Apr 2021 06:53:40 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA813C061760
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:10 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id o9-20020a1c41090000b029012c8dac9d47so10895783wma.1
        for <git@vger.kernel.org>; Mon, 19 Apr 2021 03:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RPC/m9AGV7dxWKt5uG6CtdfLUgvEBWEG+qVhhHArvW8=;
        b=vH26Xpy221X/9ov2ANsCxETmz96MT5tTTWrcSwOSAbDLs9N2SpXDEGH3rZriFuMCOT
         /l8tSmYX5QMYMBKYqBZZfOp++JguALxyp7nO7pcsJtmAo/iiE+e86tggQpHPdad4UFLF
         NwRLWwA9TUUqM/PKp4D+BECQAFweJ+8jsnYvYMHldD7NEPs0F+9qLfNzeJtJgqmsSuqZ
         /5hFhqrqmWkgV0NLShpmApw1bC3hDCoshN9G1b2o4Fsh+tf6jtxvs7x1D62EYlhi+sgU
         YBPOJYzA80EoSABzZIoZXx8OIQmgOcZqn2/IegOHRLNzU4QqmaNXri1lzFCjqJNl8xnt
         KwtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RPC/m9AGV7dxWKt5uG6CtdfLUgvEBWEG+qVhhHArvW8=;
        b=J5tIWulRs8c+lNHse6uTVfShutNNRPl4ylH4p3LeQx3qYv85bq/3MZhAXVMJ8Vw5Xn
         08XScyz1KO6n740b0tZR1w1eqbLP+4LgIWQOaL3tasLuM4xMlxuSpZhuPSHsFRohcFrd
         cVkOGVk7Xt0H5rQVshizwJHG5gbpxtQ//UfKk+/38PMNifc+dEPEI+a+qH3GyrhTWTI6
         QG6JmeCHSDSmNCwCLaZca+YRbVy3ofxhO6aevvfsp0zJ2r8GzMvMH/274plhNP4PLiCc
         Sz8HId6yPMsx0SMCIoOFrb5v1RKhMDBfIbvLZIPjXMQK69JF81s8wr1172CG3rTC2VUB
         Zmkg==
X-Gm-Message-State: AOAM532zymonpJU1YQhvqzFhxFsihnYHCnlcJY4WIbF2BlWISCUO5PWZ
        9BNKeLfp331ecPZVh1B66GAc+9VsOrk=
X-Google-Smtp-Source: ABdhPJzIfLZ2FM3da9h9UoXQ3I8+sh7e9/Olxf36Kcn7ABKW0azhNHFNOFsx3/o4H5gr/F7K51QCFw==
X-Received: by 2002:a7b:ce1a:: with SMTP id m26mr21049568wmc.137.1618829589675;
        Mon, 19 Apr 2021 03:53:09 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h10sm7915556wrt.40.2021.04.19.03.53.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Apr 2021 03:53:09 -0700 (PDT)
Message-Id: <ba575839e422dfe241f7b567de14c10ec648f2e3.1618829583.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 19 Apr 2021 10:52:54 +0000
Subject: [PATCH 09/18] t5304: use "reflog expire --all" to clear the reflog
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

This is more explicit, and reduces the depency between test functions. It also
is more amenable to use with reftable, which has no concept of (non)existence of
a reflog

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5304-prune.sh | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index b447ce56a9b2..4ffc0076801e 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -94,26 +94,22 @@ test_expect_success 'prune: prune nonsense parameters' '
 '
 
 test_expect_success 'prune: prune unreachable heads' '
-
 	git config core.logAllRefUpdates false &&
-	mv .git/logs .git/logs.old &&
 	: > file2 &&
 	git add file2 &&
 	git commit -m temporary &&
 	tmp_head=$(git rev-list -1 HEAD) &&
 	git reset HEAD^ &&
+	git reflog expire --all &&
 	git prune &&
 	test_must_fail git reset $tmp_head --
-
 '
 
 test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 
 	git checkout --detach --quiet &&
 	git commit --allow-empty -m "detached commit" &&
-	# verify that there is no reflogs
-	# (should be removed and disabled by previous test)
-	test_path_is_missing .git/logs &&
+	git reflog expire --all &&
 	git prune -n >prune_actual &&
 	test_must_be_empty prune_actual
 
@@ -123,6 +119,7 @@ test_expect_success 'prune: prune former HEAD after checking out branch' '
 
 	head_oid=$(git rev-parse HEAD) &&
 	git checkout --quiet main &&
+	git reflog expire --all &&
 	git prune -v >prune_actual &&
 	grep "$head_oid" prune_actual
 
-- 
gitgitgadget

