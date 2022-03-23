Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B961C433F5
	for <git@archiver.kernel.org>; Wed, 23 Mar 2022 20:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344776AbiCWUfC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Mar 2022 16:35:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344778AbiCWUee (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Mar 2022 16:34:34 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F7508D6A0
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:47 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id w4so3752776wrg.12
        for <git@vger.kernel.org>; Wed, 23 Mar 2022 13:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cjknNg288PavqaZvLc9/xcPnPravEz/pCRHH7I4mf5g=;
        b=SaIcpiHz1k6aumCQOHuqErr4Rjs0qNJNJu7CD6AtkyOVbgEka9lUu17epZLThpPwGi
         5ZZk/vqF6Dx9xyhC+nMgnffyONptp8KhoJHKcY2Y7cCoQJS9ypaB0QjbwQqFsrNRkSx5
         dpOgAFSM/kkBS5wHawmQC21D//Spmwq2aw+Iex7nLQ2tsPpsa49eKeShlMusL/KZhS4s
         775IEEgcHMwRmGY+f7jMwhY4HmLiOvkbiQOEgcaF1eAZ3oIqxTiKtTKc9aatfOH3eqnG
         3ckEDNeSt0IS/yzgOgJQEFudRVOIvOfLRJOV10InVAzWVgx6o1P+Qol7zCG7XuyY0+ng
         KJtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cjknNg288PavqaZvLc9/xcPnPravEz/pCRHH7I4mf5g=;
        b=uDevTytXg7eNoAqjddVy96eRhvQ4R9eSRRWaLjMRvywYoGPBZgqQv/a+j6wlYKgr0B
         Uh2aIlQsRcYGnyGJ5zbGzx8W1n7Bg7XM50jV8ohZ1IUONWlHUYpZ/Cvrasn4AJdTIZz5
         OsuJgJomnPyA/l6GY8DpN7YggAy2P+MZsi3x8YwAyA6JR3fQqV0CzDWKaYTMaityvKUx
         s3sn8LcbePymNk5c5385Q73xcNIE1TbeaJsszfK8PCdia6lKyK+Oe8ym1ehTY2PREhRW
         OjEa2ODSsqZB5Cn5M8WmUsfAbS8I305/sIBmqDNKqjHv8U1TcQlcfia95Uf7OKsv2i8M
         sDyw==
X-Gm-Message-State: AOAM532QqFy9GiPry+qdcxQQAC89adRG0z0wLSwHjyRWFdNgm9vbHfQb
        rHw8duh1gaPjnGWFYkL2oxVGqU7C0QxCEQ==
X-Google-Smtp-Source: ABdhPJyX1jn8aVfGqiWUuwyn+b8qRPQQgToyTHudcCa6/GThfIv8vhIT6nVw8VctBtmU1ucUtYc0uw==
X-Received: by 2002:a5d:6f0f:0:b0:203:d61c:42b0 with SMTP id ay15-20020a5d6f0f000000b00203d61c42b0mr1567742wrb.478.1648067565964;
        Wed, 23 Mar 2022 13:32:45 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6dac000000b00204119d37d0sm849843wrs.26.2022.03.23.13.32.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 13:32:45 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 22/27] revisions API: clear "boundary_commits" in release_revisions()
Date:   Wed, 23 Mar 2022 21:32:12 +0100
Message-Id: <patch-v2-22.27-827430315fa-20220323T203149Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1452.ga7cfc89151f
In-Reply-To: <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
References: <cover-00.24-00000000000-20220309T123321Z-avarab@gmail.com> <cover-v2-00.27-00000000000-20220323T203149Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Clear the "boundary_commits" object_array in release_revisions(). This
makes a few more tests pass under SANITIZE=leak, including
"t/t4126-apply-empty.sh" which started failed as an UNLEAK() in
cmd_format_patch() was removed in a preceding commit.

This also re-marks the various tests relying on "git format-patch" as
passing under "SANITIZE=leak", in the preceding "revisions API users:
use release_revisions() in builtin/log.c" commit those were marked as
failing as we removed the UNLEAK(rev) from cmd_format_patch() in
"builtin/log.c".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 revision.c                           | 1 +
 t/t4021-format-patch-numbered.sh     | 1 +
 t/t4028-format-patch-mime-headers.sh | 2 ++
 t/t4036-format-patch-signer-mime.sh  | 1 +
 t/t4122-apply-symlink-inside.sh      | 1 +
 t/t4126-apply-empty.sh               | 1 +
 t/t6110-rev-list-sparse.sh           | 1 +
 t/t9001-send-email.sh                | 1 +
 t/t9116-git-svn-log.sh               | 1 -
 9 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/revision.c b/revision.c
index 0f9ded78f5b..020f32f6eca 100644
--- a/revision.c
+++ b/revision.c
@@ -2958,6 +2958,7 @@ void release_revisions(struct rev_info *revs)
 		return;
 	release_revisions_commit_list(revs);
 	object_array_clear(&revs->pending);
+	object_array_clear(&revs->boundary_commits);
 	release_revisions_cmdline(&revs->cmdline);
 	list_objects_filter_release(&revs->filter);
 	clear_pathspec(&revs->prune_data);
diff --git a/t/t4021-format-patch-numbered.sh b/t/t4021-format-patch-numbered.sh
index 9be65fd4440..1219aa226dc 100755
--- a/t/t4021-format-patch-numbered.sh
+++ b/t/t4021-format-patch-numbered.sh
@@ -5,6 +5,7 @@
 
 test_description='Format-patch numbering options'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4028-format-patch-mime-headers.sh b/t/t4028-format-patch-mime-headers.sh
index 204ba673cb5..60cb819c42e 100755
--- a/t/t4028-format-patch-mime-headers.sh
+++ b/t/t4028-format-patch-mime-headers.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='format-patch mime headers and extra headers do not conflict'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'create commit with utf-8 body' '
diff --git a/t/t4036-format-patch-signer-mime.sh b/t/t4036-format-patch-signer-mime.sh
index 98d9713d8b2..48655bcc789 100755
--- a/t/t4036-format-patch-signer-mime.sh
+++ b/t/t4036-format-patch-signer-mime.sh
@@ -2,6 +2,7 @@
 
 test_description='format-patch -s should force MIME encoding as needed'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4122-apply-symlink-inside.sh b/t/t4122-apply-symlink-inside.sh
index aa52de401b9..96965373036 100755
--- a/t/t4122-apply-symlink-inside.sh
+++ b/t/t4122-apply-symlink-inside.sh
@@ -4,6 +4,7 @@ test_description='apply to deeper directory without getting fooled with symlink'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t4126-apply-empty.sh b/t/t4126-apply-empty.sh
index 66a7ba8ab8f..ece9fae207d 100755
--- a/t/t4126-apply-empty.sh
+++ b/t/t4126-apply-empty.sh
@@ -2,6 +2,7 @@
 
 test_description='apply empty'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t6110-rev-list-sparse.sh b/t/t6110-rev-list-sparse.sh
index 13c1da53528..ddefc7f24ee 100755
--- a/t/t6110-rev-list-sparse.sh
+++ b/t/t6110-rev-list-sparse.sh
@@ -4,6 +4,7 @@ test_description='operations that cull histories in unusual ways'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t9001-send-email.sh b/t/t9001-send-email.sh
index 84d0f40d76a..dfa6b20f7a6 100755
--- a/t/t9001-send-email.sh
+++ b/t/t9001-send-email.sh
@@ -4,6 +4,7 @@ test_description='git send-email'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # May be altered later in the test
diff --git a/t/t9116-git-svn-log.sh b/t/t9116-git-svn-log.sh
index 34f6c80dea3..d74d7b2de68 100755
--- a/t/t9116-git-svn-log.sh
+++ b/t/t9116-git-svn-log.sh
@@ -5,7 +5,6 @@
 
 test_description='git svn log tests'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'setup repository and import' '
-- 
2.35.1.1452.ga7cfc89151f

