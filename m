Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 277C0C43331
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 109C364FEA
	for <git@archiver.kernel.org>; Tue, 16 Mar 2021 15:59:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbhCPP7T (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 16 Mar 2021 11:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238254AbhCPP6u (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 16 Mar 2021 11:58:50 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46953C0613D7
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:45 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id e18so7705225wrt.6
        for <git@vger.kernel.org>; Tue, 16 Mar 2021 08:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6zSKsCLQNz24hJmFrPJMkcXP/jg6YRPbN11deTsmjMc=;
        b=JmaioLxXYrv7vgtJ702yvWfAjWnQigiY+LVcxeeg5DzcKwLicjyhSYW/0F1c2yIyxo
         K+0M908Ih9cITRwMm+sHR0x43VRnkczNi2eYaWhcyLle7UaSf+DogSfbqukLe5hIyZxQ
         b8RoNDhoGEpo8N3hg6xBiN/97dpPo0B3wuTf2hQwqLmhDsRTxzIhacLZBFrF7yVfgwFe
         Olh02RibkIOTaOsDbqqdxulI1Gs19wykLvWpczl98uQOaD4bpg8Cqrwzs4veJKHnOwAs
         h3XchvIa9x+jzhToQp0R1LotDTSS+bq5cIN3AmxGGvrFcNTJxb12BeiKXqud9LBwgQct
         SvMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6zSKsCLQNz24hJmFrPJMkcXP/jg6YRPbN11deTsmjMc=;
        b=KnArCr9pY5CpmcAN6gHlJ5VwlTrwXPTNs9jdNFaNZQO+X/jo+QqmlKkxPYg3I4VXFF
         YhiuRBA6cmfLoC3rEhhquas6LsOCUb0HUflzkxoVVQ49ivLdEtblFgPwuihSfTUUa1XY
         TjTC6iZAzozL46YQ/VIfbKukTZ46LtixHy86bkyQ2YsdQB5DX/Nk/EbiV0nHSud4E1x5
         Tmgj5kvpXwHyn2tkf/lSYAt7Q/irOJWyokqGyh7ObQXnKXihYEhyBomFNILFTv+/+5KD
         /Y3Jxts6l6cPCKm4evdC/QYN7mSJeyQerAzBags/LyLXHtD2SfhzBnAeKGDCQ17XjPS6
         8m9A==
X-Gm-Message-State: AOAM532JM444le8aPfvEx3jnFu5EWDwfIrnpAdRGSw+wwowlLRfPIGDb
        RVgZhDJPj8cR4I/gvw+Srbqyf25rtGpebQ==
X-Google-Smtp-Source: ABdhPJyJPK8g+gZTGQtLrIqtDn0QVzPSCJB5/D+g6wfP1D7ZM4VjcqmUB4mLZZGsMFoCG4qMabR9ag==
X-Received: by 2002:a5d:4523:: with SMTP id j3mr5878075wra.288.1615910323706;
        Tue, 16 Mar 2021 08:58:43 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m132sm3439060wmf.45.2021.03.16.08.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Mar 2021 08:58:43 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        Kirill Smelkov <kirr@navytux.spb.ru>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 07/32] mktree tests: test that "mode" is passed when sorting
Date:   Tue, 16 Mar 2021 16:58:04 +0100
Message-Id: <20210316155829.31242-8-avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.256.gf0ddda3145
In-Reply-To: <20210316021312.13927-1-avarab@gmail.com>
References: <20210316021312.13927-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Add a test for the mode being passed to ent_compare(). That code dates
back to 83f50539a9 (git-mktree: reverse of git-ls-tree., 2006-02-20)
and there's never been a test for that particular edge case. Now we
have one.

I don't see how anything could run into this in practice. In order for
that mode sorting to matter as a tiebreaker we need to have a
duplicate entry in the tree, i.e. two "foo" entries, one a blob and
one a tree. This asserts that if that happens we'll sort on the modes
we encounter in such an invalid entry, i.e. we expect the tree entry
before the blob.

As shown here we'd need to disable the fsck.duplicateEntries error to
get to the point of running "mktree", so I doubt anyone's pushing this
sort of data around.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1450-fsck.sh | 44 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5071ac63a5..46125190b4 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -318,6 +318,50 @@ test_expect_success 'tree entry with type mismatch' '
 	test_i18ngrep ! "dangling blob" out
 '
 
+test_expect_success 'tree entry with duplicate type mismatching objects' '
+	test_create_repo duplicate-entry &&
+	(
+		cd duplicate-entry &&
+		blob="$(printf "foo" | git hash-object -w --stdin)" &&
+		tree="$(printf "100644 blob $blob\tfoo" | git mktree)" &&
+		commit="$(git commit-tree $tree -m "first commit")" &&
+		git cat-file commit $commit >good-commit &&
+
+		# First bad commit, wrong type, but in the right order
+		printf "40000 A\0$(echo $tree | hex2oct)" >broken-tree-A &&
+		printf "100644 A\0$(echo $blob | hex2oct)" >broken-tree-B &&
+		cat broken-tree-A broken-tree-B >broken-tree.1 &&
+		broken_tree1="$(git hash-object -w --literally -t tree broken-tree.1)" &&
+		bad_commit1="$(git commit-tree $broken_tree1 -m "bad commit 1")" &&
+		git cat-file commit $bad_commit1 >bad-commit.1 &&
+		git update-ref refs/heads/broken-commit-1 $bad_commit1 &&
+
+		test_must_fail git fsck &&
+		git -c fsck.duplicateEntries=warn fsck 2>err &&
+		grep " in tree .*$broken_tree1: duplicateEntries" err &&
+
+		# Second bad commits, wrong types and order
+		cat broken-tree-B broken-tree-A >broken-tree.2 &&
+		broken_tree2="$(git hash-object -w --literally -t tree broken-tree.2)" &&
+		bad_commit2="$(git commit-tree $broken_tree2 -m "bad commit 2")" &&
+		git cat-file commit $bad_commit2 >bad-commit.2 &&
+		git update-ref refs/heads/broken-commit-2 $bad_commit2 &&
+
+		test_must_fail git fsck &&
+		git -c fsck.duplicateEntries=warn fsck 2>err &&
+		grep " in tree .*$broken_tree2: duplicateEntries" err &&
+
+		# git mktree should "fix" the order of this already broken data
+		git ls-tree broken-commit-1 >broken-tree-1-ls &&
+		git ls-tree broken-commit-2 >broken-tree-2-ls &&
+		! test_cmp broken-tree-1-ls broken-tree-2-ls &&
+
+		git mktree <broken-tree-1-ls >broken-mktree-1 &&
+		git mktree <broken-tree-2-ls >broken-mktree-2 &&
+		test_cmp broken-mktree-1 broken-mktree-2
+	)
+'
+
 test_expect_success 'tag pointing to nonexistent' '
 	badoid=$(test_oid deadbeef) &&
 	cat >invalid-tag <<-EOF &&
-- 
2.31.0.256.gf0ddda3145

