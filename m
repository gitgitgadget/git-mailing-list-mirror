Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 399ADC00140
	for <git@archiver.kernel.org>; Tue,  2 Aug 2022 15:33:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbiHBPdc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 Aug 2022 11:33:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiHBPd2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 Aug 2022 11:33:28 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18803245
        for <git@vger.kernel.org>; Tue,  2 Aug 2022 08:33:27 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id z12so8249061wrs.9
        for <git@vger.kernel.org>; Tue, 02 Aug 2022 08:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=tgChNrS7fQOcP7/OEzMOsMfRte8cqps57oLMctyZhb8=;
        b=XYtVAKzkU02JHNwLuJxVmwfcLPOKflm4QwXdVJWlxioR67rZkRxKDkEl5ZGWY/Oda5
         aR4Ew67mL3SKYA3zF/mO9HcPUvcqEimnyaI9AHU8BKLVgmYt4Pi0nP5ENeD0NAs2DcF1
         HL4k00uUlgjJP2P2/Yj3QGzFYXdpB82YEsWVqBGmYYjWsXm0MfzjY1/Vq2JgPfFcU5hT
         7PbEmK6JTu3bN216weMW1uhd58Z83qy4NAxUhiSkJtUjIDdT5VmoZWOCx2qCjVi+TuZU
         9MBby9/BUJNCDjP2fGe2Q4ACWbhN0emNWe/UxdcLDICAPrDGNuevy4f9vKDOiT5LbviL
         kv/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=tgChNrS7fQOcP7/OEzMOsMfRte8cqps57oLMctyZhb8=;
        b=yT9diieF1UH+VB5U5oJmDd64OLBRGxFvM67C21/RZw6ABmj3IKgL2z2vmhiOmHPIBI
         eoBLV4vXMkRFusG04w/LZfvg5yHs671K5o/w0Aau3OGN8+cCOGIDUy98s77qb6xXxeyr
         dKufqizCcIJEtSUe8nQhvAHxjfev5gficTATdU8ftzJ6Izvwfug3dGoyHB+WAqRWCHJZ
         VKszKi+1apYQJKceCGcyXSeUJgsVdfBARLDaGfymUIPMysnU6qIgA3KR4cWGMefcpys5
         L9LCXDFb3dGpiIfd3lsw9v+GbBepaR0C4EiRXHt/VJS8nOHFcqWFPnhGTgEBxZyXSX+T
         y6qQ==
X-Gm-Message-State: ACgBeo0b4RrK9/IvXrFuyEHBm8qomk8nxxQty9LvcHwKyZnIb27r51sp
        IBhKKXoXtheGjkFQTiyVVhQnGFCl6MMnzQ==
X-Google-Smtp-Source: AA6agR7oTkwFOdL9NnFnYplhz4tuZd4rn8G0jpcIOMmVRYjSnwrcxfIZp6vXt32kHD17aengb3KMEQ==
X-Received: by 2002:adf:f90c:0:b0:21f:1384:bf2f with SMTP id b12-20020adff90c000000b0021f1384bf2fmr13105415wrr.596.1659454405317;
        Tue, 02 Aug 2022 08:33:25 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id y7-20020adffa47000000b0021e9396b135sm15332531wrr.37.2022.08.02.08.33.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 08:33:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 3/6] log: fix a memory leak in "git show <revision>..."
Date:   Tue,  2 Aug 2022 17:33:13 +0200
Message-Id: <patch-v3-3.6-83fc1835fe5-20220802T152925Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1233.ge8b09efaedc
In-Reply-To: <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com> <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak in code added in 5d7eeee2ac6 (git-show: grok blobs,
trees and tags, too, 2006-12-14). As we iterate over a "<revision>..."
command-line and encounter ad OBJ_COMMIT we want to use our "struct
rev_info", but with a "pending" array of one element: the one commit
we're showing in the loop.

To do this 5d7eeee2ac6 saved away a pointer to rev.pending.objects and
rev.pending.nr for its iteration. We'd then clobber those (and alloc)
when we needed to show an OBJ_COMMIT.

We'd therefore leak the "rev.pending" we started out with, and only
free the new "rev.pending" in the "OBJ_COMMIT" case arm as
prepare_revision_walk() would draw it down.

Let's fix this memory leak. Now when we encounter an OBJ_COMMIT we
save away the "rev.pending" before clearing it. We then add a single
commit to it, which our indirect invocation of prepare_revision_walk()
will remove. After that we restore the "rev.pending".

Our "rev.pending" will then get free'd by the release_revisions()
added in f6bfea0ad01 (revisions API users: use release_revisions() in
builtin/log.c, 2022-04-13)

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c                                    | 6 ++++++
 t/t0203-gettext-setlocale-sanity.sh              | 1 +
 t/t1020-subdirectory.sh                          | 1 +
 t/t3307-notes-man.sh                             | 1 +
 t/t3920-crlf-messages.sh                         | 2 ++
 t/t4069-remerge-diff.sh                          | 1 +
 t/t7007-show.sh                                  | 1 +
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 1 +
 t/t9122-git-svn-author.sh                        | 1 -
 t/t9162-git-svn-dcommit-interactive.sh           | 1 -
 10 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 88a5e98875a..b4b1d974617 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -743,11 +743,17 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
+		{
+			struct object_array old;
+
+			memcpy(&old, &rev.pending, sizeof(old));
 			rev.pending.nr = rev.pending.alloc = 0;
 			rev.pending.objects = NULL;
 			add_object_array(o, name, &rev.pending);
 			ret = cmd_log_walk_no_free(&rev);
+			memcpy(&rev.pending, &old, sizeof(rev.pending));
 			break;
+		}
 		default:
 			ret = error(_("unknown type: %d"), o->type);
 		}
diff --git a/t/t0203-gettext-setlocale-sanity.sh b/t/t0203-gettext-setlocale-sanity.sh
index 0ce1f22eff6..86cff324ff1 100755
--- a/t/t0203-gettext-setlocale-sanity.sh
+++ b/t/t0203-gettext-setlocale-sanity.sh
@@ -5,6 +5,7 @@
 
 test_description="The Git C functions aren't broken by setlocale(3)"
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./lib-gettext.sh
 
 test_expect_success 'git show a ISO-8859-1 commit under C locale' '
diff --git a/t/t1020-subdirectory.sh b/t/t1020-subdirectory.sh
index 9fdbb2af80e..45eef9457fe 100755
--- a/t/t1020-subdirectory.sh
+++ b/t/t1020-subdirectory.sh
@@ -6,6 +6,7 @@
 test_description='Try various core-level commands in subdirectory.
 '
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 . "$TEST_DIRECTORY"/lib-read-tree.sh
 
diff --git a/t/t3307-notes-man.sh b/t/t3307-notes-man.sh
index 1aa366a410e..ae316502c45 100755
--- a/t/t3307-notes-man.sh
+++ b/t/t3307-notes-man.sh
@@ -4,6 +4,7 @@ test_description='Examples from the git-notes man page
 
 Make sure the manual is not full of lies.'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
diff --git a/t/t3920-crlf-messages.sh b/t/t3920-crlf-messages.sh
index 0276edbe3d3..4c661d4d54a 100755
--- a/t/t3920-crlf-messages.sh
+++ b/t/t3920-crlf-messages.sh
@@ -1,6 +1,8 @@
 #!/bin/sh
 
 test_description='Test ref-filter and pretty APIs for commit and tag messages using CRLF'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 LIB_CRLF_BRANCHES=""
diff --git a/t/t4069-remerge-diff.sh b/t/t4069-remerge-diff.sh
index 35f94957fce..9e7cac68b1c 100755
--- a/t/t4069-remerge-diff.sh
+++ b/t/t4069-remerge-diff.sh
@@ -2,6 +2,7 @@
 
 test_description='remerge-diff handling'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # This test is ort-specific
diff --git a/t/t7007-show.sh b/t/t7007-show.sh
index d6cc69e0f2c..f908a4d1abc 100755
--- a/t/t7007-show.sh
+++ b/t/t7007-show.sh
@@ -2,6 +2,7 @@
 
 test_description='git show'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success setup '
diff --git a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
index ad1eb64ba0d..aa004b70a8d 100755
--- a/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
+++ b/t/t7503-pre-commit-and-pre-merge-commit-hooks.sh
@@ -5,6 +5,7 @@ test_description='pre-commit and pre-merge-commit hooks'
 GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=main
 export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'root commit' '
diff --git a/t/t9122-git-svn-author.sh b/t/t9122-git-svn-author.sh
index 527ba3d2932..0fc289ae0f0 100755
--- a/t/t9122-git-svn-author.sh
+++ b/t/t9122-git-svn-author.sh
@@ -2,7 +2,6 @@
 
 test_description='git svn authorship'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'setup svn repository' '
diff --git a/t/t9162-git-svn-dcommit-interactive.sh b/t/t9162-git-svn-dcommit-interactive.sh
index e2aa8ed88a9..b3ce033a0d3 100755
--- a/t/t9162-git-svn-dcommit-interactive.sh
+++ b/t/t9162-git-svn-dcommit-interactive.sh
@@ -4,7 +4,6 @@
 
 test_description='git svn dcommit --interactive series'
 
-TEST_FAILS_SANITIZE_LEAK=true
 . ./lib-git-svn.sh
 
 test_expect_success 'initialize repo' '
-- 
2.37.1.1233.ge8b09efaedc

