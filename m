Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7697FC46467
	for <git@archiver.kernel.org>; Tue, 10 Jan 2023 05:45:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231177AbjAJFpd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Jan 2023 00:45:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbjAJFoe (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Jan 2023 00:44:34 -0500
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E22641667
        for <git@vger.kernel.org>; Mon,  9 Jan 2023 21:44:10 -0800 (PST)
Received: by mail-ej1-x62a.google.com with SMTP id qk9so25816436ejc.3
        for <git@vger.kernel.org>; Mon, 09 Jan 2023 21:44:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I1zwBX8h2fV2lrJOvsQ4jfSES3qlf0gpExpUdDWDAEY=;
        b=cRsytfhFfvZZOQIqhJ8lUkotaMzU3hMn5sOlRTQHSguRhdmxLeCkSw4ysDBsoSKFpG
         MOsDzviTK0pOjD1mFnZUAZMK9X6wUj0t0pklEwMgDjD5U+jIFvmkIdei1H8NtJQbC7OS
         AsmjyR9D9gLxFW1UiQzn6AHRh/BACJe9503EN44zb9Iwy0dLZRxUc4/el+XWPL0QNJo/
         qPeySkVXo1FS832D40VZAEnTtWPWyBF1PMxGIT9raEp/uWb8g/xLjqMZItT5Ne/tIIE2
         Flm1GWpsjCQK9I+JZNri7inWEYXnhnuROqft5P6jT+hyMuK7Q0wyyIgpW0VYcxKI1KdI
         JW1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I1zwBX8h2fV2lrJOvsQ4jfSES3qlf0gpExpUdDWDAEY=;
        b=MATPKFn0J0jLE+HMylTFlTwoje6zzb3+fhzU4UfBwv6ltYV2XzuULH1C/iVSf9uWjc
         /wg71PsVBUSKx2Sf/ZAFngkCoAoQjZVn6QO7MdRioY6s3hYpZVFwp9gDHTQk1QETnkt9
         xCbdGNg8IjZR74aK52peFoidPXrSRBMfocQM3m31sCta+CYjTcfP8Vi9QRaqkvVDpVoZ
         b/7JAoPSKTHtWAGl2SdZFaZyVTNZrcqNAk1yxNdWnDesX49nkxLCN/T8ZKJZGHJz+Dbk
         8B40PC7T7b+RQaqAfDJWHMZryJBjTUsIeA66n2KHyqzaAbBAo3dVIoASsiXx9onuTfNU
         QIRw==
X-Gm-Message-State: AFqh2koPcNnZTGBQMOyzUVINiSwrlkCT0kb9xYb2Ky3LwrD6AGLsHPZT
        /UDzMSwrf7J+DSaNBfNgdSKGUxfvPRlEHw==
X-Google-Smtp-Source: AMrXdXsedWT7i+jMnjYP43D0tFffDtnkWBY83Ru9liC4avuPG7K/zMm9txKZXcc2uUUYKU24gF7Hog==
X-Received: by 2002:a17:906:4cd2:b0:7c0:e5c6:2a74 with SMTP id q18-20020a1709064cd200b007c0e5c62a74mr53546357ejt.34.1673329448238;
        Mon, 09 Jan 2023 21:44:08 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g21-20020a170906869500b0084d36fd208esm3428423ejx.18.2023.01.09.21.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Jan 2023 21:44:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 19/19] push: free_refs() the "local_refs" in set_refspecs()
Date:   Tue, 10 Jan 2023 06:43:39 +0100
Message-Id: <patch-v3-19.19-d51ed239a8a-20230110T054138Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1195.gabc92c078c4
In-Reply-To: <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
References: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com> <cover-v3-00.19-00000000000-20230110T054138Z-avarab@gmail.com>
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
 13 files changed, 20 insertions(+)

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
2.39.0.1195.gabc92c078c4

