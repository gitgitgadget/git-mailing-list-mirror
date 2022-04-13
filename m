Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56E0BC433EF
	for <git@archiver.kernel.org>; Wed, 13 Apr 2022 20:03:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238680AbiDMUFW (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Apr 2022 16:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238638AbiDMUE7 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Apr 2022 16:04:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D6E37C7B3
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:23 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id q8so1542492wmc.0
        for <git@vger.kernel.org>; Wed, 13 Apr 2022 13:02:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iEvi1ymFe5THNC3zqKJyzC7Pex7PWuXIit+ed3BzBhg=;
        b=CV+S2LJrN9D95xeh8Pit3XHYd0Yk7VYxiosnKmi5IC/y9sv1FgikXLTscIj91i1i7i
         Jg1vQ3CAUPjnDmvb7Izj/7npiAeCymKrZz7J+PBRrpVW92KNxfHjzm5ZUtxd70EBz3Rw
         9bK08NfQ3enr4yYlrZdq+mHsGdM1HKTXN8MIO9piMA5i40UvdAYsBzctAP/6MtD6CMc2
         LlDgErYhX6tuPXrO4vJ6rek9ypEptUQazm0T3H9746izq7+0f2RFWlduXnAvmu728kha
         TATyHYQiUKddOb6OICS6U6i3qkMJRTfgFnnlivw1U0GX0Jg1CP1YuljljPt/oxozeJNc
         S8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iEvi1ymFe5THNC3zqKJyzC7Pex7PWuXIit+ed3BzBhg=;
        b=V6Sci2ZMK9ua6xOwrl6c61fDKdxcdJkno2tXqGlFedJp2Xr1DN8QrKsLLeulUWkTLw
         VW7HdMWnvRmSkZsn6gxoGR20jTmVXFR7tfzM7FDEZo2VrdrfDeryv9eXrfv8Z5rwYjNP
         T9D3z2cSHybYWNKV4RKvK7bF+NTo0gjl+uNyQ8EUBr8rpoeDMAG1ULb1QwV2sMCRJoJV
         +DIcDWfORubsL/c2azzKMwVqxBkPeMUYtWclstIwFHZXOftw0y8YYpn8u7GCZt99TXT5
         zQDHP7G0VnK7QsBmLGOqeXtkLkS5vQ/fwmN8q8ekyThFIG5LM00BzGdNrp0OmtTaUFep
         cxtg==
X-Gm-Message-State: AOAM5309LH6r/ycuUWj7tmMKf86YNwv7AMTeu5vOuI026GCfD2QFxZpl
        b96TKt3ZgL45VNrY8qKox0hsAJJXfAQ/VQ==
X-Google-Smtp-Source: ABdhPJwPjhgKuVDfiGGlAQHmxjgZ/68OKuC/nqrepJP1Ogzy+GTviTBeOC6hh2Mu/2I0ozS83dwuNg==
X-Received: by 2002:a05:600c:3ba9:b0:38e:c8c6:ae0d with SMTP id n41-20020a05600c3ba900b0038ec8c6ae0dmr317590wms.120.1649880141729;
        Wed, 13 Apr 2022 13:02:21 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o4-20020a5d6484000000b002057ad822d4sm35220498wri.48.2022.04.13.13.02.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 13:02:20 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Phillip Wood <phillip.wood123@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6 22/27] revisions API: clear "boundary_commits" in release_revisions()
Date:   Wed, 13 Apr 2022 22:01:51 +0200
Message-Id: <patch-v6-22.27-69745303734-20220413T195935Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.rc2.843.g193535c2aa7
In-Reply-To: <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
References: <cover-v5-00.27-00000000000-20220402T102002Z-avarab@gmail.com> <cover-v6-00.27-00000000000-20220413T195935Z-avarab@gmail.com>
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
index 6f444eaaeba..5aa6dec4532 100644
--- a/revision.c
+++ b/revision.c
@@ -2947,6 +2947,7 @@ void release_revisions(struct rev_info *revs)
 {
 	free_commit_list(revs->commits);
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
index 42694fe5841..01c74b8b075 100755
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
2.36.0.rc2.843.g193535c2aa7

