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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0175C43460
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BC87461057
	for <git@archiver.kernel.org>; Wed, 31 Mar 2021 19:10:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235831AbhCaTKZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Mar 2021 15:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235186AbhCaTJ4 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Mar 2021 15:09:56 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF683C061574
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:55 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id b9so20703794wrt.8
        for <git@vger.kernel.org>; Wed, 31 Mar 2021 12:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k+ouMxm6OWhfRZpBy4rxJ1hRXdJVm6z2702rZDMZamc=;
        b=tVxL12NZSD5kbwTrR4hLVy+K31qhSMPJoQgmjhbNpw+clcZu86bYjbGFJOyv5TJDAz
         tilneLJZPK+rj1UTUdSTg8O0PiT0jAiazT6B8wv+tXKjZiJWhfOg/oelbogajRnt69Xu
         Nm3RGgQYuAKQRA/e+mjQxbX/l6OTOKy22JmhpJ8i/lzr7fi/1hkMOCbND6DhpVvNXZ2b
         9srmgvzfJ+GpUThh4sVnpetUKAONV0zXwXCSlrylgG+5F62nI6v66wty86ya1+6rYEU5
         mHVJ/crpKfFyLpBbgh92lIMw5d2eumBw5KWvh9urC/uKgJ0JmPJD/lzriDxpLybafIpz
         +AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k+ouMxm6OWhfRZpBy4rxJ1hRXdJVm6z2702rZDMZamc=;
        b=k6VM3TdH8omcuYiyP9SGI0/A5jxYdF0QfYp7L+GwC/7pAp7P88Lqcm89Rlb/XK7uVH
         +dd/sVNJRcFsA4aKLZc/qN8+JScvXKATk4Td3C6KWTgeUlVAn33pAFHGL5aPVJqAVhdJ
         U5077Jln4tKODi47ORM6fk8C40PD62Cu4nlQm/WmajNT8n0AfLMNdHJzQtqcUezTLacA
         Zcmlip2wbmlg1imo1whzJ5nA0JS10ywS5yHef7fIJLBWNf4r/zkaBKTHjw2TEX2G+ovW
         IHU7HR6bTjbZRdogqR4TVS3u8RG52quZWhP68rzUyP/UMFtEg+Kv6d8J82CEJ9B63xw7
         0jMg==
X-Gm-Message-State: AOAM530DnkYzdOaq5Lg3AZmI3hsL9dWbYPQL4Pz8zMtG+t3+demk7f5o
        hzwzo4RS0wXmTiD/FChRnTNHU842KmJ77w==
X-Google-Smtp-Source: ABdhPJzupruQUw6K/x1LuZH9NJBnGIcGx9Kanr72kXEptydMzOHz83Tm+tl2LLiBSojtIKe2XNaoZA==
X-Received: by 2002:a5d:5708:: with SMTP id a8mr5211169wrv.185.1617217794085;
        Wed, 31 Mar 2021 12:09:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l8sm6019268wrx.83.2021.03.31.12.09.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Mar 2021 12:09:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 05/18] mktree tests: test that "mode" is passed when sorting
Date:   Wed, 31 Mar 2021 21:09:33 +0200
Message-Id: <patch-05.19-b3289f7bbe5-20210331T190531Z-avarab@gmail.com>
X-Mailer: git-send-email 2.31.1.474.g72d45d12706
In-Reply-To: <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
References: <87o8fcqrg8.fsf@evledraar.gmail.com> <cover-00.19-00000000000-20210331T190531Z-avarab@gmail.com>
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
2.31.1.474.g72d45d12706

