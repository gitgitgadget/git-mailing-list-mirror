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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7375EC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59BBB6146B
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 21:34:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244116AbhDWVfZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 17:35:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244030AbhDWVfL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 17:35:11 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C47B8C06174A
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:32 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id k4-20020a7bc4040000b02901331d89fb83so1893833wmi.5
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 14:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=jft80CHL8Z17lSl9Y7GRz9Mo3mBcOwwYstAOc67pnXo=;
        b=SIAn0+wT2qVtVtc6/hchH3asEqhuSDTH8vdhN2UXR0CkfPq3BS7CHwgKsA60XhSk08
         HJJBxxPA0I6NZNg3vPy/rgroN294WhyhkdW3uO2OWOCw6i3uZjFYyVcZuEUe5ledgZnR
         8G/TBi7a/uVu6H+wWMM33tzxmlTeI/MRoi0UIoyInUclkq85yjfIXZ7DTy8sD7wHv7+a
         wOlyuD9bVyY5pRV3brXoIEY++vuz1jYYXNLLZYbf53yNJtPPrI6HI0b2XOVyvT6HB6Zc
         X2g1ymGCUDTJz2a5SPj9tun9N4gL9L51NM93Cr0mgIKm8poH7FpnIfKTT+6D1LTvkKTZ
         mqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=jft80CHL8Z17lSl9Y7GRz9Mo3mBcOwwYstAOc67pnXo=;
        b=PnlL8AmJ//hKiIkARGlVoWZ7MRbwuZPet21CvHMM1VsS9T3FEghBYESeLzguDn3AbZ
         mfoEI+WBOj+dx4+NKSHQXMvwni9eHTH3uVk4e4BfVayhDBWhkGHc6P5/xF3sgsAB6/ZJ
         626Av9hT5OqUTrD3+XZPBivWtmwmHK1J5vMotFVXpyOFGg3t6hHswEsffu4Bo7ups6qn
         05aeHmaLUKYo+afXeu+QtW3wYUFo/M/UntXxPiUN/vmR/XSsjX5CU90cQj+edLxQRwGR
         Pd32lKoMhOAjvFKWxpL30a6hPrW15bMLci83OImo22BOc0NYpQwAiEkrllW66sSyK0kk
         qAMQ==
X-Gm-Message-State: AOAM533g3NnFd43muymGrmgTOUw6ofd+AnjErF4JZ5t9zvnA2xvUAI5l
        cdIidGUEQF3N2Bz7L0EF47/sfJsnRw4=
X-Google-Smtp-Source: ABdhPJzEOHaZS/8A7n0qqB2bB6iFNQ4IjPj4zhnoAGF+bXde9G/6OnzQVSCI/rBzZ87EPiMVqU3KuQ==
X-Received: by 2002:a1c:64c4:: with SMTP id y187mr7562530wmb.162.1619213671564;
        Fri, 23 Apr 2021 14:34:31 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id q7sm10323661wrr.62.2021.04.23.14.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 14:34:31 -0700 (PDT)
Message-Id: <1fd033a6ebb2eebc85667920e93a4eeeab1b4fe0.1619213666.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
References: <pull.932.git.1618322497.gitgitgadget@gmail.com>
        <pull.932.v2.git.1619213665.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 21:34:25 +0000
Subject: [PATCH v2 8/8] fsmonitor: test with sparse index
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, newren@gmail.com,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <stolee@gmail.com>,
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
index 45d025f96010..f70fe961902e 100755
--- a/t/t7519-status-fsmonitor.sh
+++ b/t/t7519-status-fsmonitor.sh
@@ -73,6 +73,7 @@ test_expect_success 'setup' '
 	expect*
 	actual*
 	marker*
+	trace2*
 	EOF
 '
 
@@ -383,4 +384,51 @@ test_expect_success 'status succeeds after staging/unstaging' '
 	)
 '
 
+# Usage:
+# check_sparse_index_behavior [!]
+# If "!" is supplied, then we verify that we do not call ensure_full_index
+# during a call to 'git status'. Otherwise, we verify that we _do_ call it.
+check_sparse_index_behavior () {
+	git status --porcelain=v2 >expect &&
+	git sparse-checkout init --cone --sparse-index &&
+	git sparse-checkout set dir1 dir2 &&
+	GIT_TRACE2_EVENT="$(pwd)/trace2.txt" GIT_TRACE2_EVENT_NESTING=10 \
+		git status --porcelain=v2 >actual &&
+	test_region $1 index ensure_full_index trace2.txt &&
+	test_cmp expect actual &&
+	rm trace2.txt &&
+	git sparse-checkout disable
+}
+
+test_expect_success 'status succeeds with sparse index' '
+	git reset --hard &&
+
+	test_config core.fsmonitor "$TEST_DIRECTORY/t7519/fsmonitor-all" &&
+	check_sparse_index_behavior ! &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+	EOF
+	git config core.fsmonitor .git/hooks/fsmonitor-test &&
+	check_sparse_index_behavior ! &&
+
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1/modified\0"
+	EOF
+	check_sparse_index_behavior ! &&
+
+	cp -r dir1 dir1a &&
+	git add dir1a &&
+	git commit -m "add dir1a" &&
+
+	# This one modifies outside the sparse-checkout definition
+	# and hence we expect to expand the sparse-index.
+	write_script .git/hooks/fsmonitor-test<<-\EOF &&
+		printf "last_update_token\0"
+		printf "dir1a/modified\0"
+	EOF
+	check_sparse_index_behavior
+'
+
 test_done
-- 
gitgitgadget
