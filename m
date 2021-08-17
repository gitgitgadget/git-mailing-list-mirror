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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 060FAC4320A
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D72FB60FD9
	for <git@archiver.kernel.org>; Tue, 17 Aug 2021 13:23:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239942AbhHQNYR (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Aug 2021 09:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240028AbhHQNYL (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Aug 2021 09:24:11 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B68C0612A6
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id h13so28673855wrp.1
        for <git@vger.kernel.org>; Tue, 17 Aug 2021 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=h0jP/WQTQwK/dNNHt3JH4FuVCZwq3HAW8lG1yL7NHbc=;
        b=Ia03hKAOnsJFd7zwknfj6Rdx5lulrzUSt4EowWqK8J7YmbBhfnl7D+e0PbBEpmLP4A
         o5SiL+rfXBYJJ9qRkf0yicKiQlSE3T2i8oFnDR6a9IvspsubjzoaUacEYrGskSdaxq+o
         Kfme+GOD3o4GPWP+Bbhyq3N+6O08TkyHhT0SHG1WWc84al2bI7aSnZ6jueok5+TXG+Sq
         iqM1EP9V+rtHgAKGlKzvXfbvo9jx28x99UcXuRBh8DEUqo7Vd8gjHfaV9fDVyqHtEdhi
         Xsd2ABi7/FNLfBhGmLeMl8YYxkClYsdlAW62m7mNtE9OnrLfTxPdN3qIbLp7R3imvA4v
         H09A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=h0jP/WQTQwK/dNNHt3JH4FuVCZwq3HAW8lG1yL7NHbc=;
        b=GGafUibTXBi9JHktRVejVgVLVCri0QaZCOZn+bf3KJWdNJqh+M4OCh0DtLc7/2l4Yu
         2SFdK/XfX+ZlJGIbAqvNOKUqiZqjiLJio40Id9oAsyBx9HC91KW2GPCLxNWOWsRBG27t
         UQOv4mpUpfkVuwc/toBuaeFlWYao92ufPlHsxbUqbL+b/jnbX3XuQ7n63EjE4H1roUuY
         DQDTe4EwQd8VLRRIAWk1KwWNzfPMTEXF3SCNNbERTJGx6JKO9z0vPxUOfzPCayPIHH2N
         ZCrxJgm6XTwVR6yYwbbDMbj/rdFwTGFCpdRUKIGY9R/waCOYVpm+YQEBCwKeIWtPpUxF
         wkGA==
X-Gm-Message-State: AOAM532ByGznuTrFLOSbuzLB9kZB3d3CK225k85lylXg8FqPJ6aMRQ10
        gQhGMD1XiX1liva8m6okOyHjp+rAue8=
X-Google-Smtp-Source: ABdhPJyYAtrcra51mpP4boE2RFpKKaqbu3WjJGZleTQuyzf6moejGKoocdHVlxCHFnm8d+3ZfPJnng==
X-Received: by 2002:adf:f5d2:: with SMTP id k18mr4063370wrp.362.1629206605682;
        Tue, 17 Aug 2021 06:23:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id y3sm2422228wma.32.2021.08.17.06.23.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 06:23:25 -0700 (PDT)
Message-Id: <e66106f7a99d94145eec983ea5e72b7cf8a8a479.1629206603.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
References: <pull.1009.v2.git.1628625013.gitgitgadget@gmail.com>
        <pull.1009.v3.git.1629206602.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 17 Aug 2021 13:23:15 +0000
Subject: [PATCH v3 1/8] t7519: rewrite sparse index test
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com, matheus.bernardino@usp.br,
        stolee@gmail.com, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

The sparse index is tested with the FS Monitor hook and extension since
f8fe49e (fsmonitor: integrate with sparse index, 2021-07-14). This test
was very fragile because it shared an index across sparse and non-sparse
behavior. Since that expansion and contraction could cause the index to
lose its FS Monitor bitmap and token, behavior is fragile to changes in
'git sparse-checkout set'.

Rewrite the test to use two clones of the original repo: full and
sparse. This allows us to also keep the test files (actual, expect,
trace2.txt) out of the repos we are testing with 'git status'.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 38 ++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index deea88d4431..6f2cf306f66 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -389,43 +389,47 @@ test_expect_success 'status succeeds after staging/unstaging' '
 # If "!" is supplied, then we verify that we do not call ensure_full_index
 # during a call to 'git status'. Otherwise, we verify that we _do_ call it.
 check_sparse_index_behavior () {
-	git status --porcelain=v2 >expect &&
-	git sparse-checkout init --cone --sparse-index &&
-	git sparse-checkout set dir1 dir2 &&
+	git -C full status --porcelain=v2 >expect &&
 	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
-		git status --porcelain=v2 >actual &&
+		git -C sparse status --porcelain=v2 >actual &&
 	test_region $1 index ensure_full_index trace2.txt &&
 	test_region fsm_hook query trace2.txt &&
 	test_cmp expect actual &&
-	rm trace2.txt &&
-	git sparse-checkout disable
+	rm trace2.txt
 }
 
 test_expect_success 'status succeeds with sparse index' '
-	git reset --hard &&
+	git clone . full &&
+	git clone . sparse &&
+	git -C sparse sparse-checkout init --cone --sparse-index &&
+	git -C sparse sparse-checkout set dir1 dir2 &&
 
-	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
-	check_sparse_index_behavior ! &&
-
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	write_script .git/hooks/fsmonitor-test <<-\EOF &&
 		printf "last_update_token\0"
 	EOF
-	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	git -C full config core.fsmonitor ../.git/hooks/fsmonitor-test &&
+	git -C sparse config core.fsmonitor ../.git/hooks/fsmonitor-test &&
 	check_sparse_index_behavior ! &&
 
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	write_script .git/hooks/fsmonitor-test <<-\EOF &&
 		printf "last_update_token\0"
 		printf "dir1/modified\0"
 	EOF
 	check_sparse_index_behavior ! &&
 
-	cp -r dir1 dir1a &&
-	git add dir1a &&
-	git commit -m "add dir1a" &&
+	git -C sparse sparse-checkout add dir1a &&
+
+	for repo in full sparse
+	do
+		cp -r $repo/dir1 $repo/dir1a &&
+		git -C $repo add dir1a &&
+		git -C $repo commit -m "add dir1a" || return 1
+	done &&
+	git -C sparse sparse-checkout set dir1 dir2 &&
 
 	# This one modifies outside the sparse-checkout definition
 	# and hence we expect to expand the sparse-index.
-	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+	write_script .git/hooks/fsmonitor-test <<-\EOF &&
 		printf "last_update_token\0"
 		printf "dir1a/modified\0"
 	EOF
-- 
gitgitgadget

