Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20830C433ED
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08074601FE
	for <git@archiver.kernel.org>; Sun, 21 Mar 2021 00:02:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229996AbhCUACP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 20 Mar 2021 20:02:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbhCUABd (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 20 Mar 2021 20:01:33 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66A16C061762
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t4so2419516wrn.11
        for <git@vger.kernel.org>; Sat, 20 Mar 2021 17:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P6K9HooH2urrBKX6gfb+Z9MZ1cYKVhdJ/6XaBM0Rha4=;
        b=ef4b3N+JLMIlOZ+FeA/Bh4VQrFigE7r3iKwz1fdDEqeZxh+uq8wwWBG+v0YoWQjwA7
         6FHbygoIS2b94hzP4UxNG09UmEzXT0um9cwVpDu+XtEbAmfljQiXHfOVCwpL8/tSysqd
         emAKBjVUJDA4vvSSkdP5E249oCfP2UJlFSU4L4usEEh4GDpVc1Lr/ceC+sI2sLSsY7Z+
         UB4CsZX5Aq7Z0y4+bGd4TII9guvW/KajVkCnaieUdYTI+obuOYCu7kZHtOanlHzoDXdb
         +z2Me5KfD9J/NDyxzz5ELZRbs9gZ9/GZZMVUmVgNlcepn2zgpOAqvUdySdzkeRYs5Lft
         1FEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P6K9HooH2urrBKX6gfb+Z9MZ1cYKVhdJ/6XaBM0Rha4=;
        b=fB+8BUgCag1U5wCqGsu2NcYQG1hV7CbCUD+KkoF6Fxo83LCmC27bou0BYn0gANXatL
         XfSvDCLf9T0Fmg6ZBtaHxeF1XlFUP6I28ppTGWJG+uM/TdsO0AxP+gKqVS0YpKS/43OC
         +/mrJ0Nnn3RBHTJ4qAymp19C7WF9V4NIEFISwvK6TNskX1gkGv41RaKbLQXFRA7kWJTH
         TLeSTbdZlL33Zuq4a/gdCBsfXlchzSoLmUAx7DQwXOp4ZSO5DjPZW9slWseBwJv89nFz
         +/x3620tPR3uZHArk47G5sq+9rcuZgHK8tkrc1HJWSZ40CK7BMPvn32FfmfXHMIXEz+0
         0tOQ==
X-Gm-Message-State: AOAM533YQFnCw4Z3oEDLXod+WF1Ez1lVpk53ZiTA77OF8Tklepsd//WQ
        rW8IajbymSmTQQ4IkNJdOCNY6G+lO7VsVw==
X-Google-Smtp-Source: ABdhPJzfGOqu7RCcIEi0Uu/l47ZJQAIUfHNKTFmperKJiBXurtrQO2AWPJfWcT49pfXM5YVDfoT9Eg==
X-Received: by 2002:adf:f148:: with SMTP id y8mr10990927wro.107.1616284890911;
        Sat, 20 Mar 2021 17:01:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g5sm15304834wrq.30.2021.03.20.17.01.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Mar 2021 17:01:30 -0700 (PDT)
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
Subject: [PATCH v4 06/29] mktree tests: test that "mode" is passed when sorting
Date:   Sun, 21 Mar 2021 01:00:39 +0100
Message-Id: <b0546197b1bf02db941eeb3aa818344452d21da9.1616282534.git.avarab@gmail.com>
X-Mailer: git-send-email 2.31.0.282.gcc1ec606501
In-Reply-To: <cover.1616282533.git.avarab@gmail.com>
References: <20210316155829.31242-1-avarab@gmail.com> <cover.1616282533.git.avarab@gmail.com>
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
index 5071ac63a5b..46125190b45 100755
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
2.31.0.286.gc175f2cb894

