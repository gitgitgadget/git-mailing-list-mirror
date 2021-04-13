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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8254C433B4
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB914613AB
	for <git@archiver.kernel.org>; Tue, 13 Apr 2021 14:02:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237908AbhDMOCb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Apr 2021 10:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237548AbhDMOCH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Apr 2021 10:02:07 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 196B6C06138F
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:47 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id y20-20020a1c4b140000b029011f294095d3so10740223wma.3
        for <git@vger.kernel.org>; Tue, 13 Apr 2021 07:01:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=KGRjbi4uVmoUD8RSU3rrrD/0eMwup9huQ9SZfnCO0NI=;
        b=lVlbP1rYJUmsvuM/pruoyICbrCbc1W385IgvmRScyjArDnAToiYOhuAUqBNuiZIqqT
         uuixrLgVDmCkHmAzAG+gIiI+mJoyeYMW0tZ6FD2NTu6/rEebVQInrGXU3zrV/BWpZ3ju
         vcuZQ4+ZOBaFQWXI6j8WdF/ugIf0EbtcsYsBM1jetb7p57eQJCSZ7ELc8S1wSZTFLGHQ
         iPA2DB0NtmkosHFZMIItPsSP/5B5c7ZgXVUptYzNeBvJ+8rgApxdWhj96k3Ys38ilt7G
         DcAWVPQdcrtSHmZox+nFwxwDzafAU4WIAMKEj5INLkr7M9nja4StvBcSBv+3Oq22XpKe
         QwNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=KGRjbi4uVmoUD8RSU3rrrD/0eMwup9huQ9SZfnCO0NI=;
        b=O4fkTgrIjA9me8MKVMgBue9NmXvKHMDVF0AwMYLnqy4RLtI/AI2YN+DFqfWKc0v6jC
         rqG4Iro3AcDIs82BqioNsTycttRU1PRl609ZQQsnAekCtOxs8UfHQ1mXB+FVcjRl0Dpq
         TYrM84OulzalyOtb/jx7f7ftPDFBa5A+7qPRW4e/nR1tp/Ahm1+1x7uk6JGbb8PDIdvh
         XbhhSZLfOJjKg8M3iXrdVi1VZssMh3v/b1/t4WjgL1e9E3tNjd90KBo/NzrinUrLVif4
         3gQ/lmhMSopcKycf90M8U0sOzKk2YxFv68BER6M9ZMnS12VUtBU8EEKdNWsi5K7M8g63
         0UVQ==
X-Gm-Message-State: AOAM531D9WwPvYKIPPXX6R8rrUX3EihYGcMTm/5RtNl+Mt/tA9GrTtse
        YbeB4CPjwQvHois3+maJRra3ezPfKrQ=
X-Google-Smtp-Source: ABdhPJzw6pp2RiTtoI2Ojzc9k4zIPoELpMIsy7nZJZeExAZuHcWenOTZrUOXcCD/NOhzlMnE1ospUA==
X-Received: by 2002:a7b:c303:: with SMTP id k3mr173288wmj.100.1618322505816;
        Tue, 13 Apr 2021 07:01:45 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a15sm20190174wrr.53.2021.04.13.07.01.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Apr 2021 07:01:45 -0700 (PDT)
Message-Id: <9d1183ddd280b1e9a580dcbfe9761ceec8d0bc80.1618322498.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.git.1618322497.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 13 Apr 2021 14:01:37 +0000
Subject: [PATCH 10/10] fsmonitor: test with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

During the effort to protect uses of the index to operate on a full
index, we did not modify fsmonitor.c. This is because it already works
effectively with only the change to index_name_stage_pos(). The only
thing left to do is to test that it works correctly.

These tests are added to demonstrate that the behavior is the same
across a full index and a sparse index, but also that file modifications
to a tracked directory outside of the sparse cone will trigger
ensure_full_index().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 t/t7519-status-fsmonitor.sh | 48 +++++++++++++++++++++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/t/t7519-status-fsmonitor.sh b/t/t7519-status-fsmonitor.sh
index 23879d967297..306157d48abf 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -78,6 +78,7 @@ test_expect_success 'setup' '
 	expect*
 	actual*
 	marker*
+	trace2*
 	EOF
 '
 
@@ -400,4 +401,51 @@ test_expect_success 'status succeeds after staging/unstaging' '
 	)
 '
 
+test_expect_success 'status succeeds with sparse index' '
+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
+	git status --porcelain=v2 >expect &&
+	git sparse-checkout init --cone --sparse-index &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git status --porcelain=v2 >actual &&
+	test_region ! index ensure_full_index trace2.txt &&
+	test_cmp expect actual &&
+	rm trace2.txt &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+	EOF
+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	git status --porcelain=v2 >expect &&
+	git sparse-checkout init --cone --sparse-index &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git status --porcelain=v2 >actual &&
+	test_region ! index ensure_full_index trace2.txt &&
+	test_cmp expect actual &&
+	rm trace2.txt &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1/modified\0"
+	EOF
+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	git status --porcelain=v2 >expect &&
+	git sparse-checkout init --cone --sparse-index &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git status --porcelain=v2 >actual &&
+	test_region ! index ensure_full_index trace2.txt &&
+	test_cmp expect actual &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1a/modified\0"
+	EOF
+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	git status --porcelain=v2 >expect &&
+	git sparse-checkout init --cone --sparse-index &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git status --porcelain=v2 >actual &&
+	test_region index ensure_full_index trace2.txt &&
+	test_cmp expect actual
+'
+
 test_done
-- 
gitgitgadget
