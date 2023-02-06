Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71245C05027
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 23:09:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230223AbjBFXJb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 18:09:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230257AbjBFXIy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 18:08:54 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B53032515
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 15:08:28 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id mc11so38697254ejb.10
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 15:08:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qbKpJivg5mwqDYN753Piyui4ktEEBmy0/cA1S1WuRWI=;
        b=VZz9KAg4jL2cWiK6m7AplVkmT1eIjG/t7ONDqWCghTh6Ff0ByTEdVv2x9wRa6mhtqg
         T2iaHdmTSvX+K+Wj4Wmy9O7VQj8yW6uuqkjndgCZ7i7HGTo+Gl/mI8ILFqRz7id52pQj
         Fx3iFWO5UzdY3BbAPs2Jb6Htwwp96DA04ZJ4HHYqbLHIbxtdCRxKQLXWucSCx8sLZbz6
         0t3tM/5eUOIG5o/7he5DwIv+kQVn9wm5EY7ARp4i5XVEDu3DwBvY42JSsDkx5mv6LQAO
         jbs0q4RzW39PfbkL5aLwRWwyMZEc+9It5jaWlfRBzKOyy03D01Ex8ZH2hUnZFPZddZTV
         XfPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qbKpJivg5mwqDYN753Piyui4ktEEBmy0/cA1S1WuRWI=;
        b=He4I1kwjj4i0lhcpJyvzoAFUEks0Edlt0IVwma2T6Ar4imfybwof9pNwvv3ukY+QqI
         K0bKSwGWZ9NKqLG3Pv2d90nnN3Gj+svgIGENzklcnzdSyjWh5n5YO1qvbDqbQmQGTfUm
         9LQ6m090YJp0zvNJPzWkLmoeEUaZAxDpKeE+8ziJ4MGD3G4WR+pW0Efr3uogbautntE8
         JBCXMdfU1fOP6x0F4ZflQ+N5Z8DgbB1p8bx9Cg6GPxp6rhFo7H4mYdZpfGvAI2kOjUkA
         NrgCrBybbB7HNDzeJfX2AnYnt4CXy3MefJUNxhLj3p16dvDvGJ0X18IHH9iScKFX2cNF
         vpNg==
X-Gm-Message-State: AO0yUKWA1nIqOG8rkcaJe1eKXXCyREsLosf4jUdxtR2LkxU3cQtKOLnP
        dvSfH042anLtxwc43e+GJINExX0K1RcSvNKL
X-Google-Smtp-Source: AK7set/eUQOj0ptQ+yzeUKK0gZcx82trn9+O1wrDPj8zq2Q1DdTqRqwuIKg6qyTdXfb2ImAifs478g==
X-Received: by 2002:a17:906:3a8f:b0:88f:a236:69e6 with SMTP id y15-20020a1709063a8f00b0088fa23669e6mr1131881ejd.7.1675724907558;
        Mon, 06 Feb 2023 15:08:27 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s15-20020a170906a18f00b0089d5aaf85besm2673586ejy.219.2023.02.06.15.08.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 15:08:26 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Elijah Newren <newren@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 19/19] push: free_refs() the "local_refs" in set_refspecs()
Date:   Tue,  7 Feb 2023 00:07:54 +0100
Message-Id: <patch-v7-19.19-ba8e5496d96-20230206T230142Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.1.1425.gac85d95d48c
In-Reply-To: <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
References: <cover-v6-00.19-00000000000-20230202T094704Z-avarab@gmail.com> <cover-v7-00.19-00000000000-20230206T230141Z-avarab@gmail.com>
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
2.39.1.1425.gac85d95d48c

