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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DCE2C71156
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:26:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11E8E20870
	for <git@archiver.kernel.org>; Tue,  1 Dec 2020 22:26:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJmz1KA0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726815AbgLAW0K (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Dec 2020 17:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725916AbgLAW0J (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Dec 2020 17:26:09 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A08A2C0613D4
        for <git@vger.kernel.org>; Tue,  1 Dec 2020 14:25:23 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id k14so5363369wrn.1
        for <git@vger.kernel.org>; Tue, 01 Dec 2020 14:25:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=A+pnDjNzYC12lo4A9P68XXv7/ynTxmaaizYaLQ8ZpLM=;
        b=cJmz1KA0jCsIPC/qozPhox2GsXE3eNJveZFs66FoNK9BQh9zV2kWyPKqscIvSfAs57
         x5rW65i53X1vwAu2aFYR1coG5tLiAXA/yoUNUOHqFrmfUgGD/GpQ27qOiaFhqgdXb+tR
         kwUGKtd3+fBfBxdMiWLB+q1jCWqIf0CCM2AV9cVf33aB+/VaZ4r88D4opSwSYGoacnx5
         3NvmDGp3U97Uhpimr0qp0b02ctjdLsjX+wWwxgRqBDhEN+jv776h6a+xX6CjynNYh2a3
         GLs6SRbSuxipyPXwojqBLXd4zrj23i+O369sMHPzGcHVjadFVIU0uiesU/jAHWsLT7YW
         nbgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=A+pnDjNzYC12lo4A9P68XXv7/ynTxmaaizYaLQ8ZpLM=;
        b=uO8eNYilfgZsyMVcphmUjhaseYfKGiPUcAUdeSPHHc8v5+oXUba9w8lcCQsbh2QcW+
         ggnaewkaVMMT3KLoElz6q+i8VDJWY/SOBXk9N5xjlg/LRlPihPzuOx7VQZ6AhtUshiKh
         pyE2umxS/JqTWAXP71rLLmBPZ1pUEQ6eUPdmV3ugoWKYIsIAPurpPXwuOJ2fPDoZ+FC8
         QdqM1cUD9arpslN2ggZ59WfJu6Say01bIIm9+v1oTVsKj2fjn4vyCHdhKJB2VKRB24Lv
         fEVbKuP5WgnhLisBGQHZA8XbVe4nPjETczQjn/M4pf+1twSUO7fZ2PTqFvZLokm76StT
         w9qg==
X-Gm-Message-State: AOAM530Goh52VW166qA9mwXES7SXKRH9wAbP5JON7DOUhBS3P4OLIuHh
        bpyZ0EJoO/M4+bK9WE+CUF8FQs4Ca08=
X-Google-Smtp-Source: ABdhPJxQ8t5fXtKQfOi1YcktF8w6BFsYA+Ke52tCJyKXPcN+i6BGo4ZeZhZOyuobtjlc6dmsrZpp0Q==
X-Received: by 2002:adf:f9c4:: with SMTP id w4mr6659345wrr.64.1606861522074;
        Tue, 01 Dec 2020 14:25:22 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id t15sm1655290wmn.19.2020.12.01.14.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Dec 2020 14:25:21 -0800 (PST)
Message-Id: <2155bbfe205588387208690abf8071d462c69d64.1606861519.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.919.v2.git.git.1606861519.gitgitgadget@gmail.com>
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
        <pull.919.v2.git.git.1606861519.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 01 Dec 2020 22:25:16 +0000
Subject: [PATCH v2 1/3] t7012: add a testcase demonstrating stash apply bugs
 in sparse checkouts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>, chris.torek@gmail.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Applying stashes in sparse-checkouts, particularly when the patterns
used to define the sparseness have changed between when the stash was
created and when it is applied, has a number of bugs.  The primary
problem is that stashes are sometimes only partially applied.  In most
such cases, it does so silently without any warning or error being
displayed and with 0 exit status.

There are, however, a few cases when non-translated error messages are
shown and the stash application aborts early.  The first is when there
are files present despite the SKIP_WORKTREE bit being set, in which case
the error message shown is:

    error: Entry 'PATHNAME' not uptodate. Cannot merge.

The other situation is when a stash contains new files to add to the
working tree; in this case, the code aborts early but still has the
stash partially applied, and shows the following error message:

    error: NEWFILE: does not exist and --remove not passed
    fatal: Unable to process path NEWFILE

Add a test that can trigger all three of these problems.  Have it
carefully check that the working copy and SKIP_WORKTREE bits are as
expected after the stash application.  The test is currently marked as
expected to fail, but subsequent commits will implement the fixes and
toggle the expectation.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t7012-skip-worktree-writing.sh | 88 ++++++++++++++++++++++++++++++++
 1 file changed, 88 insertions(+)

diff --git a/t/t7012-skip-worktree-writing.sh b/t/t7012-skip-worktree-writing.sh
index 7476781979..a184ee97fb 100755
--- a/t/t7012-skip-worktree-writing.sh
+++ b/t/t7012-skip-worktree-writing.sh
@@ -149,6 +149,94 @@ test_expect_success '--ignore-skip-worktree-entries leaves worktree alone' '
 		--diff-filter=D -- keep-me.t
 '
 
+test_expect_failure 'stash restore in sparse checkout' '
+	test_create_repo stash-restore &&
+	(
+		cd stash-restore &&
+
+		mkdir subdir &&
+		echo A >subdir/A &&
+		echo untouched >untouched &&
+		echo removeme >removeme &&
+		echo modified >modified &&
+		git add . &&
+		git commit -m Initial &&
+
+		echo AA >>subdir/A &&
+		echo addme >addme &&
+		echo tweaked >>modified &&
+		rm removeme &&
+		git add addme &&
+
+		git stash push &&
+
+		git sparse-checkout set subdir &&
+
+		# Ensure after sparse-checkout we only have expected files
+		cat >expect <<-EOF &&
+		S modified
+		S removeme
+		H subdir/A
+		S untouched
+		EOF
+		git ls-files -t >actual &&
+		test_cmp expect actual &&
+
+		test_path_is_missing addme &&
+		test_path_is_missing modified &&
+		test_path_is_missing removeme &&
+		test_path_is_file    subdir/A &&
+		test_path_is_missing untouched &&
+
+		# Put a file in the working directory in the way
+		echo in the way >modified &&
+		git stash apply &&
+
+		# Ensure stash vivifies modifies paths...
+		cat >expect <<-EOF &&
+		H addme
+		H modified
+		H removeme
+		H subdir/A
+		S untouched
+		EOF
+		git ls-files -t >actual &&
+		test_cmp expect actual &&
+
+		# ...and that the paths show up in status as changed...
+		cat >expect <<-EOF &&
+		A  addme
+		 M modified
+		 D removeme
+		 M subdir/A
+		?? actual
+		?? expect
+		?? modified.stash.XXXXXX
+		EOF
+		git status --porcelain | \
+			sed -e s/stash......./stash.XXXXXX/ >actual &&
+		test_cmp expect actual &&
+
+		# ...and that working directory reflects the files correctly
+		test_path_is_file    addme &&
+		test_path_is_file    modified &&
+		test_path_is_missing removeme &&
+		test_path_is_file    subdir/A &&
+		test_path_is_missing untouched &&
+
+		# ...including that we have the expected "modified" file...
+		cat >expect <<-EOF &&
+		modified
+		tweaked
+		EOF
+		test_cmp expect modified &&
+
+		# ...and that the other "modified" file is still present...
+		echo in the way >expect &&
+		test_cmp expect modified.stash.*
+	)
+'
+
 #TODO test_expect_failure 'git-apply adds file' false
 #TODO test_expect_failure 'git-apply updates file' false
 #TODO test_expect_failure 'git-apply removes file' false
-- 
gitgitgadget

