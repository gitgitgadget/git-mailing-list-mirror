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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B491C433FE
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10E38610A6
	for <git@archiver.kernel.org>; Mon, 13 Sep 2021 15:45:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236106AbhIMPq6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Sep 2021 11:46:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244685AbhIMPqm (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Sep 2021 11:46:42 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ED03C0A8894
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:28 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id m9so15317223wrb.1
        for <git@vger.kernel.org>; Mon, 13 Sep 2021 08:19:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5NiZ1dey39+kkiAnyp/BnURcm4AUhPyCNBo/a7YNbQM=;
        b=huHJTJcvMO5LQ1Qy/sNHcnP7gtJXeqTLqiL3fJQD55gZ8PtzbbqhwNz74PBOGj3J4g
         Inq9Y5yFXedyqAJnmXx8/oJi/RyYzWr+VHPhuxdjuoKUBfXCHi7HBX6QTu5nGavh/eji
         IGHxZD7vevIRmiEI+1zvLfbP1o/pTVdAW0OrrZ8o0lEP8gfPAKok+fD1LIYhP0ckXEod
         ehPTZZvtU8L9ViEZcRmKCYipiSJ9UZfnPICLk2j94fsA4WWT9Ioaz4NYul2KkZXl9ip7
         6JPbArr/2oFur8MnoLKI/XwBRJNqpsV7lwhdB+d+to2ordJE4FiuXVvFVZj6r2g75ptB
         bldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5NiZ1dey39+kkiAnyp/BnURcm4AUhPyCNBo/a7YNbQM=;
        b=emTp68ZOlEdfJX+dXC3XRLSqlNXSO6Agazcy0kozxFqAEJ8r4KClzuv8xRexEDUYCp
         z8nSpEEHQ0UTgpMRQKZUV2NTmcMfLJYN432jlQIuIE5BAeJOWyt1DP68Q255sfbVhb1M
         E8GVZ5TCASqHeFaK2bytVxk7GGTWV/NpxuBcm7AfL6BpFgb5hgkOVD9LgCw1ketzO1su
         YDLaC1OrcyYEnNrPxCtuQXiSOIge/usRB6sK6x8EZJ138YYN7GXfTyVWCHdyB/xPG/I/
         jWi+/T9ofPLUUUTzjV5BAYBtD2NYTL5iGTxe5Ns0UL+ATTka1o/OZmIOr6sVvo+cLnG9
         Mhtg==
X-Gm-Message-State: AOAM533gJ7iuj7Rbv/XT4NvqfeQtk8n5osrds/Kh17e9fSKzJbs9PSyh
        +cDaJqtEp1IuK+DLUHOS44R/iUbFEz8=
X-Google-Smtp-Source: ABdhPJw3wbJBDWofi4Lrb2QKebsLY6NtTfbrEe19lnuKE4+GqEgix/5e1z93vKhjPyw3HK7hiXBQuw==
X-Received: by 2002:adf:8070:: with SMTP id 103mr13050939wrk.74.1631546367113;
        Mon, 13 Sep 2021 08:19:27 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l187sm7067617wml.39.2021.09.13.08.19.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Sep 2021 08:19:26 -0700 (PDT)
Message-Id: <61a37c89f1e97c00b28daf1ce7a0c4253ecec9fb.1631546362.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
References: <pull.1033.git.1631094563.gitgitgadget@gmail.com>
        <pull.1033.v2.git.1631546362.gitgitgadget@gmail.com>
From:   "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 13 Sep 2021 15:19:16 +0000
Subject: [PATCH v2 05/11] t3407: use test_path_is_missing
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Phillip Wood <phillip.wood@dunelm.org.uk>

At the end of the test we expect the state directory to be missing,
but the tests only check it is not a directory.

Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
---
 t/t3407-rebase-abort.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/t/t3407-rebase-abort.sh b/t/t3407-rebase-abort.sh
index 2c70230a4eb..7eba9ec1619 100755
--- a/t/t3407-rebase-abort.sh
+++ b/t/t3407-rebase-abort.sh
@@ -30,7 +30,7 @@ testrebase() {
 		test_path_is_dir "$state_dir" &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$state_dir"
+		test_path_is_missing "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --skip" '
@@ -42,7 +42,7 @@ testrebase() {
 		test_cmp_rev HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$state_dir"
+		test_path_is_missing "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort after --continue" '
@@ -57,7 +57,7 @@ testrebase() {
 		test_cmp_rev ! HEAD main &&
 		git rebase --abort &&
 		test_cmp_rev to-rebase pre-rebase &&
-		test ! -d "$state_dir"
+		test_path_is_missing "$state_dir"
 	'
 
 	test_expect_success "rebase$type --abort does not update reflog" '
@@ -92,7 +92,7 @@ test_expect_success 'rebase --apply --quit' '
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
 	test_cmp_rev HEAD $head_before &&
-	test ! -d .git/rebase-apply
+	test_path_is_missing .git/rebase-apply
 '
 
 test_expect_success 'rebase --merge --quit' '
@@ -103,7 +103,7 @@ test_expect_success 'rebase --merge --quit' '
 	head_before=$(git rev-parse HEAD) &&
 	git rebase --quit &&
 	test_cmp_rev HEAD $head_before &&
-	test ! -d .git/rebase-merge
+	test_path_is_missing .git/rebase-merge
 '
 
 test_done
-- 
gitgitgadget

