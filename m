Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FD25C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 09:54:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbjBBJyQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 04:54:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232598AbjBBJxt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 04:53:49 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 219633401B
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 01:53:18 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id o18so1157487wrj.3
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 01:53:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8jEc1apoOfoCEKcr38kLtFCQVvqJUioy2AOjyZ5C0m8=;
        b=pnhG8XF9Lm+mY3VtDChhRpqHcSXEiWDencG/qRP08/XB64d1aAfwLLPM4IPMSl0+h6
         HlaxCJc6zU8lNKv1gZRMg72hzSawhz+zDGTgedl3IOHmBArWHtFq6u+aFJ3WbbB2GUIU
         gTHYizAswZ6H6GsS8msCIptSHCxMp/8ZqzbYzvFcfcgG8ajbkXvlDo0q2Mii8R9/WbyL
         HdLFca2THqrtCr+8Fgq0p6F3SL71WkmndIWrdl4W9FBg0Cg6LZGxgfnMQx01flqj0Dnp
         Ewh5X3k1QyfvM7JE16F33Oi2hH9NGnGhUoVTvCqqCKI/rjl9ntORpCSGajU32R2dONpl
         QfuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8jEc1apoOfoCEKcr38kLtFCQVvqJUioy2AOjyZ5C0m8=;
        b=YP3+cDqIca+pG5ylUsT9E4+aEf514VTH9Nr18wz/JXuoqAas7N03p1IVlilLfSapQ7
         wNySMkdCAmCAqDJKPE9FCFfh0OMrGw6X5dgQblU4iDxjhbafDErBqKt9iKu3X55K8Gzl
         yIrqChTr3JyGezY0Cy6YAhSGCzJJDfDw8HJPDuCa+dqbBzU7PJc84c2OIXZrVn6XMSrR
         7nvDE8CNhqK/4RQuHw8f+3YttddY06rdw04NJvvT6Gtshn/X0mAokjggH2tfNI3bKFOG
         EFI8JOKWo4983N4RNT0td7I9pwO5tcCdYosB/oZw1bo5gaI7fV5XdsHlWr1Z9cZFRIxe
         gZQg==
X-Gm-Message-State: AO0yUKWULy8t2887tZZAUg7nc85nvQEV/wCPd22dqOI3UGAciVQ3R/T6
        1lzb7N8XGra4ws6+O2XkanSnV3ELNdPF83QN
X-Google-Smtp-Source: AK7set/1m46D61nYfxmCPlocmykUTTPeKqs0lm2CnL1vA5AOKQkelUMoPmQuxWkvf7ztw90DPCU5Uw==
X-Received: by 2002:a5d:4d01:0:b0:2b6:7876:3cd4 with SMTP id z1-20020a5d4d01000000b002b678763cd4mr5257009wrt.16.1675331596241;
        Thu, 02 Feb 2023 01:53:16 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id i13-20020a1c540d000000b003db03725e86sm4356234wmb.8.2023.02.02.01.53.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Feb 2023 01:53:15 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 19/19] push: free_refs() the "local_refs" in set_refspecs()
Date:   Thu,  2 Feb 2023 10:52:50 +0100
Message-Id: <patch-v6-19.19-67076dfba6d-20230202T094704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1392.g63e6d408230
In-Reply-To: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
References: <cover-v5-00.19-00000000000-20230118T120334Z-avarab@gmail.com> <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us since this code was added in
ca02465b413 (push: use remote.$name.push as a refmap, 2013-12-03).

The "remote = remote_get(...)" added in the same commit would seem to
leak based only on the context here, but that function is a wrapper
for sticking the remotes we fetch into "the_repository->remote_state".

See fd3cb0501e1 (remote: move static variables into per-repository
struct, 2021-11-17) for the addition of code in repository.c that
free's the "remote" allocated here.

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
index 97b35eca3ab..8f7d326ab3f 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -134,6 +134,7 @@ static void set_refspecs(const char **refs, int nr, const char *repo)
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
index 88d3c56750a..0b8ab4afdbe 100755
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
2.39.1.1392.g63e6d408230

