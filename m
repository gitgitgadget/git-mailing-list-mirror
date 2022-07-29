Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47A36C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 08:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235166AbiG2Ib0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235203AbiG2IbT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 04:31:19 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EE4E7CB4F
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:18 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id r1-20020a05600c35c100b003a326685e7cso3989584wmq.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 01:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=3yiCk39RLUoE/EgYmUffkQZ7xX5v+DE4d375BmN4no0=;
        b=QQY1OdjOtVaVsTrHqR3BCBd4RA53frEVMhNAcUdP4pWOGv3lljtqBQRctM/pJXrhVi
         wsvLs9oJF3LjeORYo9h5lv8Jb6ZOCAlCYB3BJTiC8f9sTteC88LIiOuMI07vxkMAO3DH
         xVwzyvVw2jcXcwD2MiswXyVb/P/iHSOi6oPw/pkTh8b5Lu50wwCK6uUFaCyfRqBsQTnE
         Zc4hYWZpQqhigw/q/h4plUfmZmYk0rV3vPuDAU8vCjY53d1tydcRcIldjuEdBNlKnTTp
         SuY85AXuLpXfmPfR8NM/qppQhGzN4fcqcjwfzR18zZpvoyFKduio1sGyH9L77/xR/nyg
         Sp7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=3yiCk39RLUoE/EgYmUffkQZ7xX5v+DE4d375BmN4no0=;
        b=kuuM0kjufTnFZnAdrIcY+w9R/a9fr16slNNuM3JKDS+mpAvkOHVDAqG/C6D/9emD8k
         HhhQLFwOm6Eul83KWOQE8anYY3MEzk16dToseBk3nuney4ATg7SWPNAB4V0LukH3yYx6
         AHy/mkxl5GLuKBGMamaqET7nYnaWVNzzt2ELPcJnz4iN15xXpXZlDEBrKk+32NUJGJlf
         hpqRjf0bW/HIgeomf7DFgvs//CRr8/K5yyFdiCvBBpW2GtXSfOSVJkK6hi0ohvIyBUG4
         Mg3krp+mGWCsJfynUyr9w/u16xLvFW5hyCQxf9G4iURMh2IiFur0jaScY4rRc8CKb/bM
         BJDA==
X-Gm-Message-State: AJIora+YrdHPGRc1rp3N/Ez0AWkfGdfwkqpJB4h6asX+A7BKaNQHzl/K
        85M5IM1H0d3RXIVLl5TvJt+oAyrLTFtiRg==
X-Google-Smtp-Source: AGRyM1trZgkMFuEI1gf9DovXpNpQoxqufkrdxMzgf2S+aZTHNXu0KSoXX3wfiLmXsc+v6wUPNMznOw==
X-Received: by 2002:a05:600c:384c:b0:3a4:a146:2a04 with SMTP id s12-20020a05600c384c00b003a4a1462a04mr1307546wmr.176.1659083475891;
        Fri, 29 Jul 2022 01:31:15 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id f13-20020adfe90d000000b0021f0c0c62d1sm2325467wrm.13.2022.07.29.01.31.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 01:31:15 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 4/6] log: fix common "rev.pending" memory leak in "git show"
Date:   Fri, 29 Jul 2022 10:31:06 +0200
Message-Id: <patch-v2-4.6-54b632c1124-20220729T082919Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1196.g8af3636bc64
In-Reply-To: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20220713T130511Z-avarab@gmail.com> <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a very common memory leak introduced in 5d7eeee2ac6 (git-show: grok blobs,
trees and tags, too, 2006-12-14).

When "git show" displays commits it needs to temporarily clobbers the
"rev.pending" array, but by doing so we'll fail to
release_revisions(), as we have for most other uses of "struct
rev_info" since 2da81d1efb0 (Merge branch 'ab/plug-leak-in-revisions',
2022-06-07).

In the preceding commit this code was made to use a more extendable
pattern, which we can now complete. Once we've clobbered our
"rev.pending" and invoked "cmd_log_walk_no_free()" we need to
"object_array_clear()" our old "rev.pending".

So in addition to the now-populated &pending array, to avoid leaking
the memory related to the one member array we've created. The
&rev.pending was already being object_array_clear()'d by the
release_revisions() added in f6bfea0ad01 (revisions API users: use
release_revisions() in builtin/log.c, 2022-04-13), now we'll also
correctly free the previous data (f6bfea0ad01 noted this memory leak
as an outstanding TODO).

This way of doing it is making assumptions about the internals of
"struct rev_info", in particular that the "pending" member is
stand-alone, and that no other state is referring to it. But we've
been making those assumptions ever since 5d7eeee2ac6 (git-show: grok
blobs, trees and tags, too, 2006-12-14).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/log.c                                    | 3 ++-
 t/t0203-gettext-setlocale-sanity.sh              | 1 +
 t/t1020-subdirectory.sh                          | 1 +
 t/t3307-notes-man.sh                             | 1 +
 t/t3920-crlf-messages.sh                         | 2 ++
 t/t4069-remerge-diff.sh                          | 1 +
 t/t7007-show.sh                                  | 1 +
 t/t7503-pre-commit-and-pre-merge-commit-hooks.sh | 1 +
 t/t9122-git-svn-author.sh                        | 1 -
 t/t9162-git-svn-dcommit-interactive.sh           | 1 -
 10 files changed, 10 insertions(+), 3 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 6135f8191a9..5c7e254e994 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -701,6 +701,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 		return cmd_log_deinit(cmd_log_walk(&rev), &rev);
 
 	memcpy(&pending, &rev.pending, sizeof(rev.pending));
+	memcpy(&rev.pending, &blank, sizeof(rev.pending));
 	rev.diffopt.no_free = 1;
 	for (i = 0; i < pending.nr && !ret; i++) {
 		struct object *o = pending.objects[i].item;
@@ -744,7 +745,6 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			rev.shown_one = 1;
 			break;
 		case OBJ_COMMIT:
-			memcpy(&rev.pending, &blank, sizeof(rev.pending));
 			add_object_array(o, name, &rev.pending);
 			ret = cmd_log_walk_no_free(&rev);
 			break;
@@ -752,6 +752,7 @@ int cmd_show(int argc, const char **argv, const char *prefix)
 			ret = error(_("unknown type: %d"), o->type);
 		}
 	}
+	object_array_clear(&pending);
 
 	rev.diffopt.no_free = 0;
 	diff_free(&rev.diffopt);
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
2.37.1.1196.g8af3636bc64

