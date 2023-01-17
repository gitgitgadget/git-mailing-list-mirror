Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C10CC6379F
	for <git@archiver.kernel.org>; Tue, 17 Jan 2023 17:13:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234902AbjAQRNK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 17 Jan 2023 12:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbjAQRMZ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 17 Jan 2023 12:12:25 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D35746701
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:42 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id s21so1795493edi.12
        for <git@vger.kernel.org>; Tue, 17 Jan 2023 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQVKx0iy6w2tlH8jJSWhs9XAxMlzpSUXsOXqhZO1U4o=;
        b=HfvQNnGpHJCRxfDfsiSNHKRUddPcfN5xAz5YFwCJ/eec17+02LhvefNypgEIpFbjZi
         6UwAwSVyDdJyZx+af2gcbr+ZdOXe9sarzyim9RIGUIPRVAxIEDtlNQR+XkwOyt1IxDol
         iKMKDeFU68mL6e0tbEIv3VnPES6GtEeoDucU28Mdu0DBoNffvUKP7tOyxv/rXHj28LaO
         07dmmm2uIOJ2BQeNKdnmnQ476DiGHx8UbaHTkE8LRsJFHXKXHKSOVXfS3CvW9bq8WItN
         OS+ri0zpP0yf6otjuyBixpWoiPVNgGmDejmRV0tAD7gZjx2EUqTccs5o1wI3Mx3APXGz
         eynw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UQVKx0iy6w2tlH8jJSWhs9XAxMlzpSUXsOXqhZO1U4o=;
        b=k1LNwsByCzAJ+lIaUmgPHbXNgBabutm9T+Kjc5y7HoOyNzB12lhaz4pssWZeCn/tNL
         REvam2Ogc37SI+AiSm2i8TVOSSqqY5oBwFJnucy0DDyqAJ2kHL+L4zH0Os3NIF0AUvi0
         MPmh33iiwvz93QJS3nZt0H1P6+4lLT6l+eVdHaWHmCG7T0S2RckI8ApeXtwKlV8nDCdF
         +LI75yaJB4tuOndys/z9OMdX9DKMZPe84aJnLM3e6gSKtn8YAdqhgm49Q8F8mmipTZab
         VuWBcTKkSiMWgO58XFpr8JxlvrZRcWx3wmq9Li+wWKsnTasMTQ00LMvjPqItfvRYmgzv
         CKig==
X-Gm-Message-State: AFqh2koP1NoeKNBcgN8MetpdNwiPVmP9likjE2OsIZMCXfZM0jAeil/o
        D3EKvaH+W0mfpwAvmTSxGDBCMfzl4SKdPQ==
X-Google-Smtp-Source: AMrXdXvqhz6B8KxAHs7Z56ZmuD/5DGxsk2JQwEFav9PSZyYEa/yspLHmHmgkBY5eo9oUXSyiKt/vmA==
X-Received: by 2002:a05:6402:3220:b0:49e:1d59:794f with SMTP id g32-20020a056402322000b0049e1d59794fmr7445380eda.22.1673975501533;
        Tue, 17 Jan 2023 09:11:41 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id m2-20020a509302000000b0046892e493dcsm13191268eda.26.2023.01.17.09.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jan 2023 09:11:41 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 19/19] push: free_refs() the "local_refs" in set_refspecs()
Date:   Tue, 17 Jan 2023 18:11:24 +0100
Message-Id: <patch-v4-19.19-b3aee41d0b4-20230117T151202Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1225.g30a3d88132d
In-Reply-To: <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
References: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com> <cover-v4-00.19-00000000000-20230117T151201Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since this code was added in
ca02465b413 (push: use remote.$name.push as a refmap, 2013-12-03).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/push.c                          | 1 +
 t/t1416-ref-transaction-hooks.sh        | 1 +
 t/t2402-worktree-list.sh                | 1 +
 t/t5504-fetch-receive-strict.sh         | 1 +
 t/t5523-push-upstream.sh                | 1 +
 t/t5529-push-errors.sh                  | 2 ++
 t/t5546-receive-limits.sh               | 2 ++
 t/t5547-push-quarantine.sh              | 2 ++
 t/t5606-clone-options.sh                | 1 +
 t/t5810-proto-disable-local.sh          | 2 ++
 t/t5813-proto-disable-ssh.sh            | 2 ++
 t/t7409-submodule-detached-work-tree.sh | 1 +
 t/t7416-submodule-dash-url.sh           | 2 ++
 t/t7450-bad-git-dotfiles.sh             | 2 ++
 14 files changed, 21 insertions(+)

diff --git a/builtin/push.c b/builtin/push.c
index 60ac8017e52..f48e4c6a856 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -129,6 +129,7 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
 		} else
 			refspec_append(&rs, ref);
 	}
+	free_refs(local_refs);
 }
 
 static int push_url_of_remote(struct remote *remote, const char ***url_p)
diff --git a/t/t1416-ref-transaction-hooks.sh b/t/t1416-ref-transaction-hooks.sh
index 27731722a5b..b32ca798f9f 100755
--- a/t/t1416-ref-transaction-hooks.sh
+++ b/t/t1416-ref-transaction-hooks.sh
@@ -5,6 +5,7 @@ test_description='reference transaction hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t2402-worktree-list.sh b/t/t2402-worktree-list.sh
index 79e0fce2d90..9ad9be0c208 100755
--- a/t/t2402-worktree-list.sh
+++ b/t/t2402-worktree-list.sh
@@ -5,6 +5,7 @@ test_description='test git worktree list'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5504-fetch-receive-strict.sh b/t/t5504-fetch-receive-strict.sh
index ac4099ca893..14e8af1f3b7 100755
--- a/t/t5504-fetch-receive-strict.sh
+++ b/t/t5504-fetch-receive-strict.sh
@@ -4,6 +4,7 @@ test_description='fetch/receive strict mode'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup and inject "corrupt or missing" object' '
diff --git a/t/t5523-push-upstream.sh b/t/t5523-push-upstream.sh
index fdb42920564..c9acc076353 100755
--- a/t/t5523-push-upstream.sh
+++ b/t/t5523-push-upstream.sh
@@ -4,6 +4,7 @@ test_description='push with --set-upstream'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-terminal.sh
 
diff --git a/t/t5529-push-errors.sh b/t/t5529-push-errors.sh
index ce85fd30ad1..0247137cb36 100755
--- a/t/t5529-push-errors.sh
+++ b/t/t5529-push-errors.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='detect some push errors early (before contacting remote)'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup commits' '
diff --git a/t/t5546-receive-limits.sh b/t/t5546-receive-limits.sh
index 0b0e987fdb7..eed3c9d81ab 100755
--- a/t/t5546-receive-limits.sh
+++ b/t/t5546-receive-limits.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='check receive input limits'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # Let's run tests with different unpack limits: 1 and 10000
diff --git a/t/t5547-push-quarantine.sh b/t/t5547-push-quarantine.sh
index 1876fb34e51..9f899b8c7d7 100755
--- a/t/t5547-push-quarantine.sh
+++ b/t/t5547-push-quarantine.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='check quarantine of objects during push'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create picky dest repo' '
diff --git a/t/t5606-clone-options.sh b/t/t5606-clone-options.sh
index cf221e92c4d..27f9f776389 100755
--- a/t/t5606-clone-options.sh
+++ b/t/t5606-clone-options.sh
@@ -4,6 +4,7 @@ test_description='basic clone options'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t5810-proto-disable-local.sh b/t/t5810-proto-disable-local.sh
index c1ef99b85c2..862610256fb 100755
--- a/t/t5810-proto-disable-local.sh
+++ b/t/t5810-proto-disable-local.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test disabling of local paths in clone/fetch'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 
diff --git a/t/t5813-proto-disable-ssh.sh b/t/t5813-proto-disable-ssh.sh
index 3f084ee3065..2e975dc70ec 100755
--- a/t/t5813-proto-disable-ssh.sh
+++ b/t/t5813-proto-disable-ssh.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='test disabling of git-over-ssh in clone/fetch'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY/lib-proto-disable.sh"
 
diff --git a/t/t7409-submodule-detached-work-tree.sh b/t/t7409-submodule-detached-work-tree.sh
index 374ed481e9c..574a6fc526e 100755
--- a/t/t7409-submodule-detached-work-tree.sh
+++ b/t/t7409-submodule-detached-work-tree.sh
@@ -13,6 +13,7 @@ TEST_NO_CREATE_REPO=1
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7416-submodule-dash-url.sh b/t/t7416-submodule-dash-url.sh
index 3ebd9859814..7cf72b9a076 100755
--- a/t/t7416-submodule-dash-url.sh
+++ b/t/t7416-submodule-dash-url.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='check handling of disallowed .gitmodule urls'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t7450-bad-git-dotfiles.sh b/t/t7450-bad-git-dotfiles.sh
index ba1f569bcbb..0d0c3f2c683 100755
--- a/t/t7450-bad-git-dotfiles.sh
+++ b/t/t7450-bad-git-dotfiles.sh
@@ -12,6 +12,8 @@ Such as:
 
   - symlinked .gitmodules, etc
 '
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-pack.sh
 
-- 
2.39.0.1225.g30a3d88132d

