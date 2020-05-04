Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE4D3C3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2E3A2073B
	for <git@archiver.kernel.org>; Mon,  4 May 2020 19:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ml5kD+KU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726900AbgEDTEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 15:04:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727835AbgEDTEB (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 15:04:01 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83932C061A41
        for <git@vger.kernel.org>; Mon,  4 May 2020 12:04:01 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id y24so709613wma.4
        for <git@vger.kernel.org>; Mon, 04 May 2020 12:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=EIkPMG4kRISjawN0lo4ItJKCbCJkBbHZ40TpscAnGuQ=;
        b=ml5kD+KUNIbQuZnB9Lk3riYE0NZRR7P2OtJuGAmY0GuThAPBnLcswqCKkkwzCxmmZ5
         pI6cppJWlMVbohZz5RLDUWpU3pK87kGqn91nkczfV/lE/SjDnkXZEypDFnjVZBTLHd7Z
         TMgj2ZiOks6PWAnF6okIyg7uuYjCJIknsDnMH+1V4SnM8gBGumLn7VzbcU3D+TfaG5dO
         t/lkaP5M847v5yX/yc5T6TMwNlTaf/VR/rMhP6c+NzH2762Ywx/mDq8DGTJkJ5GTUvmP
         pzzzuJUGIFerOe26pJf8vgwTRYqGhKNJMN5lZ85IaHpiZTdkb5PKOzylYm2Y400QKcZ6
         oHGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=EIkPMG4kRISjawN0lo4ItJKCbCJkBbHZ40TpscAnGuQ=;
        b=no45SdmV+XUYLzeMkcbLb341VCBqLzHb+EU00t/XfUydhYO4RYPLOCc4R73gbydUw4
         qCWLNTv6ELPt+A+JH+H3hl0O8Bc3sjwmenB6XjwD/Mu8QWBVfi5ppCSUGA+WJrayNnzN
         r4Ch4lso/CvQ5hC2fLcZBIL4GtC5D/KwPWrR9o20cxrl8Bemv5L20jCWZsNFFH8ckhcX
         5tM0xi6fxCNOMCTTPWG8TTdn1RD9O6zFAsQSs9wyEkMgZmeqZPumElVblny/AsKxYYrf
         6YhTaXHp/D+oiHigxlcefB/RZNy2yDpTSea/1nZHyX+9Eqzdm63v0uRj5HOmpn1msZRU
         SZqA==
X-Gm-Message-State: AGi0PuZZY/447r+csrUOLwwkExnyigRyu//yE0pUl9GhquA+95Rr9LKO
        oFazFIX47zkqaDpJtH10OFXeJ+BO
X-Google-Smtp-Source: APiQypJIr6gzvC0qBAYuRVv8RMDJoD4ZSBKcOIykrpa4DBRw9lQuKaIx+maAKG7rdRrFmapIRBweSQ==
X-Received: by 2002:a1c:dc8b:: with SMTP id t133mr16587657wmg.117.1588619040060;
        Mon, 04 May 2020 12:04:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o6sm21791767wrw.63.2020.05.04.12.03.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2020 12:03:59 -0700 (PDT)
Message-Id: <846fe29fa4be9b1195e68d30bafba19c963a01f2.1588619029.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
References: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
        <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 04 May 2020 19:03:47 +0000
Subject: [PATCH v11 11/12] Add some reftable testing infrastructure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

* Add GIT_TEST_REFTABLE environment var to control default ref storage

* Add test_prerequisite REFTABLE. Skip t/t3210-pack-refs.sh for REFTABLE.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/clone.c      | 2 +-
 builtin/init-db.c    | 2 +-
 refs.c               | 6 +++---
 t/t3210-pack-refs.sh | 6 ++++++
 t/test-lib.sh        | 5 +++++
 5 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 4d0cf065e4a..780c5807415 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1109,7 +1109,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	}
 
 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
-		DEFAULT_REF_STORAGE, INIT_DB_QUIET);
+		default_ref_storage(), INIT_DB_QUIET);
 
 	if (real_git_dir)
 		git_dir = real_git_dir;
diff --git a/builtin/init-db.c b/builtin/init-db.c
index b7053b9e370..da5b4670c84 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -545,7 +545,7 @@ static const char *const init_db_usage[] = {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
-	const char *ref_storage_format = DEFAULT_REF_STORAGE;
+	const char *ref_storage_format = default_ref_storage();
 	const char *real_git_dir = NULL;
 	const char *work_tree;
 	const char *template_dir = NULL;
diff --git a/refs.c b/refs.c
index 299a5db8bf1..b9b3e7e7070 100644
--- a/refs.c
+++ b/refs.c
@@ -1823,7 +1823,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	r->refs_private = ref_store_init(r->gitdir,
 					 r->ref_storage_format ?
 						 r->ref_storage_format :
-						 DEFAULT_REF_STORAGE,
+						 default_ref_storage(),
 					 REF_STORE_ALL_CAPS);
 	return r->refs_private;
 }
@@ -1879,7 +1879,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		goto done;
 
 	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
+	refs = ref_store_init(submodule_sb.buf, default_ref_storage(),
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1893,7 +1893,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 {
-	const char *format = DEFAULT_REF_STORAGE; /* XXX */
+	const char *format = default_ref_storage();
 	struct ref_store *refs;
 	const char *id;
 
diff --git a/t/t3210-pack-refs.sh b/t/t3210-pack-refs.sh
index f41b2afb996..edaef2c175a 100755
--- a/t/t3210-pack-refs.sh
+++ b/t/t3210-pack-refs.sh
@@ -11,6 +11,12 @@ semantic is still the same.
 '
 . ./test-lib.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping pack-refs tests; incompatible with reftable'
+  test_done
+fi
+
 test_expect_success 'enable reflogs' '
 	git config core.logallrefupdates true
 '
diff --git a/t/test-lib.sh b/t/test-lib.sh
index 1b221951a8e..b2b16979407 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1514,6 +1514,11 @@ FreeBSD)
 	;;
 esac
 
+if test -n "$GIT_TEST_REFTABLE"
+then
+  test_set_prereq REFTABLE
+fi
+
 ( COLUMNS=1 && test $COLUMNS = 1 ) && test_set_prereq COLUMNS_CAN_BE_1
 test -z "$NO_PERL" && test_set_prereq PERL
 test -z "$NO_PTHREADS" && test_set_prereq PTHREADS
-- 
gitgitgadget

