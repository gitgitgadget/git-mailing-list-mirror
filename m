Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61770C4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234407AbiL3CTv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234293AbiL3CTJ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:19:09 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E28518381
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:59 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id u18so27479027eda.9
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mU8tTIWIarld+XBLkKwAevtMdAA0ewGRb+ylIvC3+vQ=;
        b=dpzZ1CWKmDR7/gcYY4YQfQrWEfVlp78jGvQeUIbifmgKU5XQdqY7+mMnamjC/Q748o
         kMDHNNHvK7N6Er74sJYqf9izAwbLlPHHNk2GmPXQ765QOSAHcrAOr+c7+VdtSl3tJRgF
         EFl1XjGMO8aWnBtdzm/so3Gn8OcmVtdVcLPoDwBpqZLBisCWIAFfcIvRFnysCU68cjXa
         hHYqA/o61Av55wD/NOtrUTpCNSvD+sVhKwQ/ZkNs6FBIhsZaL7snkQ8xqf7pbrL8MjHR
         rGdd1PnnWqaFZ77gqXhR7GZrPB9+k7yOcQQyQ2a29OOqAj61Jmkd8QuvMSJts8pb2Uf/
         jJdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mU8tTIWIarld+XBLkKwAevtMdAA0ewGRb+ylIvC3+vQ=;
        b=VX95DWmkwAZsMQUuUoByz2+24r/lN5dizu3NDvelbNBbl3DAVuXPprW9GmSnszvvUA
         FYBVqnBsxR1g8TBfEWVXJlyTeAJ8ihPzlZOEL/pziyuvSV4zVticjQMDx8n+hB+lDSzS
         gy+Z2t2g7pedYRj3HZii0sXdmHMTQboKnlUsnEP5G0mQvaW6JMo7qaWC0iioO9qZNP3E
         dKWk8I2FCZCTVtEXuWdV3q+dJI+SBqIw8a010DTrvKruiK6xiVuwkUUzGKRuATPP3CS9
         TM04h14BqwdNNYDawRytzVrBiStaAMSzmom3iiOPyS7Gk7bXDT9Q54aHEJYCdnpksfwG
         fB4Q==
X-Gm-Message-State: AFqh2kqfSUQVdScvm2taghKLUvrDRHrch+HaFGsRLiGJ8N416zBHTI2X
        UtPNXq4gqpnDqJV55v8y2NXqUKaKkhC5VQ==
X-Google-Smtp-Source: AMrXdXtffSc/IBC3nftitScLWkLXUdxDghmYt+tjVargQ6hvU0iSnbpAfKJwYQfSZLyBsvedewjyaA==
X-Received: by 2002:aa7:ccc2:0:b0:477:8ab8:43e0 with SMTP id y2-20020aa7ccc2000000b004778ab843e0mr25396532edt.2.1672366737824;
        Thu, 29 Dec 2022 18:18:57 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:57 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 20/20] push: free_refs() the "local_refs" in set_refspecs()
Date:   Fri, 30 Dec 2022 03:18:35 +0100
Message-Id: <patch-v2-20.20-e5af27134df-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
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
2.39.0.1153.g589e4efe9dc

