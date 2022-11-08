Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E97D6C43217
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 18:18:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234623AbiKHSSo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 13:18:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234557AbiKHSSO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 13:18:14 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F108323173
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 10:18:03 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id m22so3584601eji.10
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 10:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nKL/uTU/V95yC/7Jp1QK3uf/YzmYfPOq6QuRj/XP3PY=;
        b=RZZZUNuN6gxC31npuzEWDAbH4IZZ9sAwH0w7rqAXdFegWKyeAbUXbt8uJtvHxriNKA
         LmzDd9qmbD/oJLMo5mmbEyGorSUX24qTbD2o1vMmj+uc1WvcmefcXZLfNCjG2vaOomkV
         H4WDFUTvVRK+CHlWPGP/7uNdEZHapj2mHO5YqnxbdAQg4hpqX1eV3yLwvOslIc7ioJ3T
         N1qQ5FuGqsymT6gc4ho8Wk5DHw/i24LecYG1pbKy5uhAxVrN2DfYp58ZUQ9xxGgbTusT
         co621S0YOrV6hOGW7Mu21O2KVzN2S+78DdDeemRjZobqATpuPKeYCUAJnuxkXUpTx9tK
         I6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nKL/uTU/V95yC/7Jp1QK3uf/YzmYfPOq6QuRj/XP3PY=;
        b=5PcGwQLR1GlfOsUkwY9CFg6Vd2HUk5vmvRWXx4n75z7mvzuH3tnmZzcgptiYiR4eOC
         q9/QfovPIsE5iAoYlj7N926NQCAG1OH5uIwfm7uZ4BL5xE/iSIk6iNwTE3dn/yqGmnHW
         vzUw4zFnYvRcdjqD/B9e25f2LPRg0XASQt5upQkTqqppSF9JimHnrfftrgCKMFN0dDtN
         1enzYCYrv0ZhL1Yw0WMappIdWqGwNDtNjelJI7OMIr5Zjsk69wHmPzRbX+N1hiMqZDZX
         wPGH7naj/t+DqaUA+qIhQWEPKow8osDTfhhgKG0ZELJ8W0rRvaaQZ0ikoEjpwfPxF1zJ
         uGxg==
X-Gm-Message-State: ACrzQf2I1bHUFTmgYDmDPv1VfetZoQXqu/b0qDhKrAIzWsTv+VaeGuF8
        0iIVm0BsumGSiD7mi0u9jLBv96r0MjtLJQ==
X-Google-Smtp-Source: AMsMyM7uBjFForW1eNWDGnDyzOlRM8j+2bJstrPoOhgc2ASmTKR9m8S2yCB4hfD3ot5hWsXUqNCL6A==
X-Received: by 2002:a17:907:8a0a:b0:78d:b87d:e68a with SMTP id sc10-20020a1709078a0a00b0078db87de68amr52407118ejc.301.1667931482804;
        Tue, 08 Nov 2022 10:18:02 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id t18-20020a1709063e5200b007a62215eb4esm4994131eji.16.2022.11.08.10.18.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 10:18:02 -0800 (PST)
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
Subject: [PATCH v2 11/15] connected.c: free the "struct packed_git"
Date:   Tue,  8 Nov 2022 19:17:47 +0100
Message-Id: <patch-v2-11.15-15f0837697d-20221108T172650Z-avarab@gmail.com>
X-Mailer: git-send-email 2.38.0.1467.g709fbdff1a9
In-Reply-To: <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20221103T164632Z-avarab@gmail.com> <cover-v2-00.15-00000000000-20221108T172650Z-avarab@gmail.com>
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
2.38.0.1467.g709fbdff1a9

