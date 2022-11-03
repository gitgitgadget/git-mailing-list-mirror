Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05F22C433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 17:07:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232144AbiKCRHy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Nov 2022 13:07:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbiKCRHO (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Nov 2022 13:07:14 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C22551E727
        for <git@vger.kernel.org>; Thu,  3 Nov 2022 10:06:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id b2so7033315eja.6
        for <git@vger.kernel.org>; Thu, 03 Nov 2022 10:06:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E4v7icDfu/OQKXzWPfvKBbeZMM4HvdINEjPk1wpME8Q=;
        b=Gv9SMWLPlWA3+BkAt1Wz5rKwuUwEr7/hIq9mhGukdBErDL80lUTxF+xyWjsHkNDclP
         +OCFeO6NetSdPTu6lBe3boO3r5Cua+Th8LrujUJn8dGL9TKENaPTvprMTpwtuJikvjly
         Q8Dz4nb5aHRmn7iFEpRGgkk37VMitnxXFKBgpjhah8K+V4Tv1CgnNCkOPYebA/quurxT
         fw1Jld5yYpHTPNFhD66lbzduy88UEeub0zp1xSWjkc2EggpwUF1bMkq1FEPw/y1ac3Y2
         OHNO7UGD0h3BXLK/3Jl5wNhUqDDK5h0JvgYHhYE0kdW7xW3sQeLo7MBYQXK5tsBudPRp
         Jo8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E4v7icDfu/OQKXzWPfvKBbeZMM4HvdINEjPk1wpME8Q=;
        b=DnfVPtTPtA/lBhOXNMHDMAWXcDd6FDLNoICW5L8zP7ldcefgRpPTTcDvSYrJVxEUpW
         llgIgW1CL4obFgXROqRqC+cMngjnmd5CA4gLPggL4mW+g9EKEmRqbI3lUEQ3Z2T5fbyI
         r8jZ5jV6J50mPKLW7ckDgeC39Wyjwy5abvwfzTothsBJk4LXHOqMNlroFXwmkBfFEnrM
         rhjzRaxEyyi42SnlLod5qL5QoDS1pYSW1BbuWHhJnUehn34Ubj72bo9XhWbDKzK0EM4M
         HiVbE7qDcoPfsCjBW/6mPcKM3AWPeQN24WB/goPxMd3ZSYXOyN9+Jgs0P/U0D4GFprpc
         V1nw==
X-Gm-Message-State: ACrzQf12tqUTRZ8ge5fHjEdZ4W1VB0w37W3jqz+Hm2DQp73mmX7pST8f
        RW2dxaN2Kj9SF8UK36yXC6n0WhBFsxW5rg==
X-Google-Smtp-Source: AMsMyM42nQoUc8gcklz92XW5aybJhCokPisz/+ma5g1u3pdEBjlM1rv8yna1MYtoUNm4t6jYat37Pw==
X-Received: by 2002:a17:906:eec1:b0:782:6384:76be with SMTP id wu1-20020a170906eec100b00782638476bemr29872581ejb.756.1667495189916;
        Thu, 03 Nov 2022 10:06:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id v4-20020aa7d644000000b0044e01e2533asm741882edr.43.2022.11.03.10.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 10:06:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 11/17] connected.c: free the "struct packed_git"
Date:   Thu,  3 Nov 2022 18:06:10 +0100
Message-Id: <patch-11.17-c7722f68ae2-20221103T164632Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1451.g86b35f4140a
In-Reply-To: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The "new_pack" we allocate in check_connected() wasn't being
free'd. Let's do that before we return from the function. This has
leaked ever since "new_pack" was added to this function in
c6807a40dcd (clone: open a shortcut for connectivity check,
2013-05-26).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 connected.c                         | 6 +++++-
 t/t3050-subprojects-fetch.sh        | 1 +
 t/t4067-diff-partial-clone.sh       | 1 +
 t/t5544-pack-objects-hook.sh        | 2 ++
 t/t5610-clone-detached.sh           | 1 +
 t/t5611-clone-config.sh             | 1 +
 t/t5614-clone-submodules-shallow.sh | 1 +
 t/t5617-clone-submodules-remote.sh  | 1 +
 8 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/connected.c b/connected.c
index 74a20cb32e7..b7770825c7b 100644
--- a/connected.c
+++ b/connected.c
@@ -85,6 +85,7 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 promisor_pack_found:
 			;
 		} while ((oid = fn(cb_data)) != NULL);
+		free(new_pack);
 		return 0;
 	}
 
@@ -118,8 +119,10 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 	else
 		rev_list.no_stderr = opt->quiet;
 
-	if (start_command(&rev_list))
+	if (start_command(&rev_list)) {
+		free(new_pack);
 		return error(_("Could not run 'git rev-list'"));
+	}
 
 	sigchain_push(SIGPIPE, SIG_IGN);
 
@@ -151,5 +154,6 @@ int check_connected(oid_iterate_fn fn, void *cb_data,
 		err = error_errno(_("failed to close rev-list's stdin"));
 
 	sigchain_pop(SIGPIPE);
+	free(new_pack);
 	return finish_command(&rev_list) || err;
 }
diff --git a/t/t3050-subprojects-fetch.sh b/t/t3050-subprojects-fetch.sh
index f1f09abdd9b..38846941655 100755
--- a/t/t3050-subprojects-fetch.sh
+++ b/t/t3050-subprojects-fetch.sh
@@ -2,6 +2,7 @@
 
 test_description='fetching and pushing project with subproject'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4067-diff-partial-clone.sh b/t/t4067-diff-partial-clone.sh
index 28f42a4046e..f60f5cbd65f 100755
--- a/t/t4067-diff-partial-clone.sh
+++ b/t/t4067-diff-partial-clone.sh
@@ -2,6 +2,7 @@
 
 test_description='behavior of diff when reading objects in a partial clone'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'git show batches blobs' '
diff --git a/t/t5544-pack-objects-hook.sh b/t/t5544-pack-objects-hook.sh
index 54f54f8d2eb..1a9e14bbccd 100755
--- a/t/t5544-pack-objects-hook.sh
+++ b/t/t5544-pack-objects-hook.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test custom script in place of pack-objects'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create some history to fetch' '
diff --git a/t/t5610-clone-detached.sh b/t/t5610-clone-detached.sh
index a7ec21eda5a..022ed3d87c3 100755
--- a/t/t5610-clone-detached.sh
+++ b/t/t5610-clone-detached.sh
@@ -4,6 +4,7 @@ test_description='test cloning a repository with detached HEAD'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 head_is_detached() {
diff --git a/t/t5611-clone-config.sh b/t/t5611-clone-config.sh
index 4b3877216ee..727caff4433 100755
--- a/t/t5611-clone-config.sh
+++ b/t/t5611-clone-config.sh
@@ -4,6 +4,7 @@ test_description='tests for git clone -c key=value'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'clone -c sets config in cloned repo' '
diff --git a/t/t5614-clone-submodules-shallow.sh b/t/t5614-clone-submodules-shallow.sh
index 0c85ef834ab..c2a2bb453ee 100755
--- a/t/t5614-clone-submodules-shallow.sh
+++ b/t/t5614-clone-submodules-shallow.sh
@@ -2,6 +2,7 @@
 
 test_description='Test shallow cloning of repos with submodules'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
diff --git a/t/t5617-clone-submodules-remote.sh b/t/t5617-clone-submodules-remote.sh
index 68843382493..5a4d7936a72 100755
--- a/t/t5617-clone-submodules-remote.sh
+++ b/t/t5617-clone-submodules-remote.sh
@@ -5,6 +5,7 @@ test_description='Test cloning repos with submodules using remote-tracking branc
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 pwd=$(pwd)
-- 
2.38.0.1451.g86b35f4140a

