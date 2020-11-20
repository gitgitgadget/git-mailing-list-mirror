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
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE5F8C63777
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 85E3E2240B
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 16:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GRWzN1uc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730168AbgKTQxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 11:53:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730167AbgKTQxq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 11:53:46 -0500
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300A5C0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:53:46 -0800 (PST)
Received: by mail-wr1-x441.google.com with SMTP id d12so10640019wrr.13
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 08:53:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=RuxTs9b83Ix89XzYOrfwLE1zdEVUR0xwuJweDaIwmhI=;
        b=GRWzN1ucTzLuaoLc9sJyb26un5u98fI4EyB7gg86fBEYeho6A1QjK9R95MiT30iIbP
         pRIx/TRuXil4kLv3cT9Re3HSGmQFBHJtuRJ9L+nEL4WSPEYsix5ACdvaIWnoJ4lL9hVa
         EXJf1E+p2ZadRyaVwVdWThT1ro4uddplF3b9+rCnffIlpCQgjQmS3PqfgSJc1b3NfoQe
         fqoAPk+F8d1XfoLQ9ED+5p0dcT+DEb4BFS4QqxJUcZGgsWVskK2+HbgZUr5htFlEXrNo
         fphehlnq+FNglhJs8qnXBQPoqHf+5d0s1XVtb2ENJyjGWFOSju3skpVgj1D30pz4M12c
         LRqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=RuxTs9b83Ix89XzYOrfwLE1zdEVUR0xwuJweDaIwmhI=;
        b=K+QOvRsE0yd9/eYWB3R1eLA54CAYZ6P3aH/jhqa8r1Me7T96G7ddwdXAU8MeIqeHF/
         VpV+z9NuZoFzAXoAoXpnCUHUqy5nviNebhci8CkaN4mbryhviOIsPtMKbX4UsdnqtpJh
         x8R+pDlrbeCSUnWS05Okeq6LUCYttN5/cq+MqFgqpOpqCSJgL5vfpAPKpbogQ8/LzXQ4
         ElY4kkWUcOVgF5cjbHCDJH31cc610edDJieUs3FUhlhgvu67e0f/tzW4/7oEhOop8lHi
         k0wIhA4LiSB+iG0R8RvdTS5KCCY1+K7fuz72fJlwRlB7w8S5V5Wm44tKHfWwq6pFD411
         v1+A==
X-Gm-Message-State: AOAM533eepa1827Vq8yBy+PGywzUjwarKkvrSmt+nyAVHsUMTobX90iP
        z6zb1lISHBzWE04H4CybI8FRU6DuiV4=
X-Google-Smtp-Source: ABdhPJy1FZzoTAxchCJ8ioif7D/V7duIaUFCtF9pGRDbLPkFLCQPfI/Dt5l/SLTIusp0/h49l9vvHg==
X-Received: by 2002:a5d:4402:: with SMTP id z2mr16799357wrq.76.1605891224816;
        Fri, 20 Nov 2020 08:53:44 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c5sm5717103wrb.64.2020.11.20.08.53.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Nov 2020 08:53:44 -0800 (PST)
Message-Id: <de4b4d207b41c82718896f8e65dae663abd8e0bb.1605891222.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
References: <pull.919.git.git.1605891222.gitgitgadget@gmail.com>
From:   "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 20 Nov 2020 16:53:40 +0000
Subject: [PATCH 1/3] t7012: add a testcase demonstrating stash apply bugs in
 sparse checkouts
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     matheus.bernardino@usp.br, dstolee@microsoft.com,
        Elijah Newren <newren@gmail.com>,
        Elijah Newren <newren@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Elijah Newren <newren@gmail.com>

Applying stashes in sparse-checkouts, particularly when the patterns
used to define the present paths have changed between when the stash was
created and when it is applied, has a number of bugs.  The primary
problem is perhaps that stashes can be only partially applied (sometimes
without any warning or error being displayed and with 0 exit status).
In addition, there are cases where partial stash application comes with
non-translated error messages and an early abort.  The first is when
there are files present despite the SKIP_WORKTREE bit being set, in
which case the error message shown is:

    error: Entry 'PATHNAME' not uptodate. Cannot merge.

The other situation is when a stash contains new files to add to the
working tree; in this case, the code aborts early (but after at least
partial stash application) with the following error message being shown:

    error: NEWFILE: does not exist and --remove not passed
    fatal: Unable to process path NEWFILE

Add a test that can trigger all three of these problems that carefully
checks that the working copy and SKIP_WORKTREE bits are as expected
after the stash application...but currently marked as expected to fail.

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

