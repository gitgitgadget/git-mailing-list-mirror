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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C0BFC433B4
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA2636127A
	for <git@archiver.kernel.org>; Tue, 27 Apr 2021 10:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235956AbhD0Kj5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Apr 2021 06:39:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238291AbhD0KjP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Apr 2021 06:39:15 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68761C06175F
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:32 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id i21-20020a05600c3555b029012eae2af5d4so6788964wmq.4
        for <git@vger.kernel.org>; Tue, 27 Apr 2021 03:38:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=dg9jCCW7nSsv9yF5hGXFIkFdi+RzDW55ABM6rE35tLg=;
        b=A2scK9hiOF9qgCkgMa4Pnv1ziwJrrgSyk5n4aAQeh493Yb5Y08RbeZvd9I1jFcHZWr
         jjHu0StTadFM5tYZp/mIi/Nl1i2Eo4O3+2qPPYKPbhvkHxCxahmCKeXz5zs+kHSqxSVz
         +q3zlRr4g7rf6WxAFCMtzgKLFrZfVIFTv2yTcePrw06erk3uNjGyaPSyk4BoQAJev/z2
         uAowwgIYMN2bYPxywYXFBQrqPLlqpZF8l+zDPXtRcaT3HpJB742bkNuuEKWMVD5wYSkd
         i41eHJt9KbKP8sBsyKi3JGUrRPB0CklzmBj/Hn70/pwcyEttJtJVnzw/PgTTwY9WDAmJ
         euiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=dg9jCCW7nSsv9yF5hGXFIkFdi+RzDW55ABM6rE35tLg=;
        b=h5f8fUdJueJW8LyYHUIcHgImETX961PWoqbSfYdKYlXmrbBxfCIsSCYWZsUvf+TgSh
         UbhWiwsU9Oa/kQz1mtI2pE2JNTNuydQs7Nenbod59TW895AaoNJXBrFYL4TxNcLadugr
         g5bboo2OtouwqqhtpAbOfLc42ZbnqyfTqAe3dN+bW5AHAKDYqoGBN21Mw+0bBAyDmKQ2
         cJ/Q3pLKYAILHM14RfjvgRL3fur7wTtM4mn2COAE50bSLl9dvofCF/O+kuZNXPmU8Z4Y
         ie6/zLLVEM88UQb6X3geCW+to74qhfugnYQEyztS/3km1VgqC9L1yWK3eqAA7npcii/i
         kv/g==
X-Gm-Message-State: AOAM533TeeMqS/DVduOvzCEWyh3Net7ZfAZ/DQbAhzjVUT8/dK3r4hef
        9IWm5gMOFExz+WQIFNt6shbsS8n9fEk=
X-Google-Smtp-Source: ABdhPJwhtokTwbZHtY0kIpjenUO6JDFoRPQurkdkfxjviEgDw88LBaR5UtIjRuoe0XrE7ArtN2IxuQ==
X-Received: by 2002:a7b:ce17:: with SMTP id m23mr3633683wmc.124.1619519911221;
        Tue, 27 Apr 2021 03:38:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a142sm2142165wmd.7.2021.04.27.03.38.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Apr 2021 03:38:30 -0700 (PDT)
Message-Id: <d8e80d83b6f8ee929b187aaffd5f37c3c981b50b.1619519903.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
References: <pull.1008.git.git.1618829583.gitgitgadget@gmail.com>
        <pull.1008.v2.git.git.1619519903.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 27 Apr 2021 10:38:13 +0000
Subject: [PATCH v2 12/21] t5304: use "reflog expire --all" to clear the reflog
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

This is more explicit, and reduces the depency between test functions. It also
is more amenable to use with reftable, which has no concept of (non)existence of
a reflog

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 t/t5304-prune.sh | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 7f47f13c78e8..7b850ae26171 100755
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -81,12 +81,12 @@ test_expect_success 'prune: prune nonsense parameters' '
 
 test_expect_success 'prune: prune unreachable heads' '
 	git config core.logAllRefUpdates false &&
-	mv .git/logs .git/logs.old &&
-	: > file2 &&
+	>file2 &&
 	git add file2 &&
 	git commit -m temporary &&
 	tmp_head=$(git rev-list -1 HEAD) &&
 	git reset HEAD^ &&
+	git reflog expire --all &&
 	git prune &&
 	test_must_fail git reset $tmp_head --
 '
@@ -94,9 +94,7 @@ test_expect_success 'prune: prune unreachable heads' '
 test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 	git checkout --detach --quiet &&
 	git commit --allow-empty -m "detached commit" &&
-	# verify that there is no reflogs
-	# (should be removed and disabled by previous test)
-	test_path_is_missing .git/logs &&
+	git reflog expire --all &&
 	git prune -n >prune_actual &&
 	test_must_be_empty prune_actual
 '
@@ -104,6 +102,7 @@ test_expect_success 'prune: do not prune detached HEAD with no reflog' '
 test_expect_success 'prune: prune former HEAD after checking out branch' '
 	head_oid=$(git rev-parse HEAD) &&
 	git checkout --quiet main &&
+	git reflog expire --all &&
 	git prune -v >prune_actual &&
 	grep "$head_oid" prune_actual
 '
-- 
gitgitgadget

