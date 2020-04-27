Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A24CC54FCB
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 619D42087E
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 20:20:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YmZ44LlI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726877AbgD0UUn (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 16:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726827AbgD0UUc (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 16:20:32 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9ED9C0A3BED
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:51 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id f13so22016326wrm.13
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 13:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=k4QBuZIDKlhGSR6tGTK5vS6Ldbu8D3/3CEEgJa+ScqE=;
        b=YmZ44LlI5gsBIQZBpjM/2wQBJRj+wbqAmrJh7tOdvGH2hsvLLAI8jz2xgb2/O4IUAA
         FHtnAqlY9Iu2h+EFwMuSBjfrYJhEx9TuWPXxA7ZSmC5RPBonsopjzjys2NCYn6hj3J3V
         167loOFc+lG+Zihxv2C0bliA7gVqQogX1dmBNwQ0jhqcMzalc4FEnSEpfqqooLtm2iOH
         JmsTILGrqH4+0IUhB0TNuGd7VIxB4ZeVuzV6X5F2Y6llMQP6Nh6GOdslV6V35NxTWd50
         rv1MjFKi/dRUS3+iQXQHACnc3LA4UryPLxdrgtPxYeWCAVAefLJ1rH6/TKfkk0RBbGsF
         PuPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=k4QBuZIDKlhGSR6tGTK5vS6Ldbu8D3/3CEEgJa+ScqE=;
        b=gojWWIdbBMWAKtN2oPak1CezqA31yYVYVIL2MPRXvxinuJPjA3tAezeLV7hydM17gc
         H6tx8MUex083iTsjaCgsm0ic0VgxtuHUGDy5z0N5T0j4JPWdR0THe7QFZO/oAkPqz+Wk
         8D7OjK6WQE9RBCo/qGkEjNMcKXWn29ip0RqktPvlj4QMshLSwUwqrZrelOFAlLUxLf2R
         9p8Ff4XcDisek5ygJcBkViBxUZj5SwQs12NEFxemvaakZ0SO5CbPN6H3A61sTqueOP4K
         4aVNgpzCrWHa8iSpr7BHlCc8NvZ5on8B9DG2Xw4aCQvYpSFibQ6+M77V5/fmVDD1PiLF
         rN5Q==
X-Gm-Message-State: AGi0PubNYZAfHvXh7ZndNha4qTgLip6Ebu000/+BNN/Wh93h15SDLoVS
        yFtv7PjO2dVrZ9TdEhMb7thMGzsv
X-Google-Smtp-Source: APiQypJjtn5Y6aU456Z5HJu8ad2d1HU0sQpa1dq5NRIXYyJx5+nPdFu/9p435xoRTgUNnxYyR+pBUA==
X-Received: by 2002:adf:8363:: with SMTP id 90mr27535506wrd.233.1588018430236;
        Mon, 27 Apr 2020 13:13:50 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id w18sm21703068wrn.55.2020.04.27.13.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 13:13:49 -0700 (PDT)
Message-Id: <8af67b85e49fe5d24a5958fe7bce77a183f74343.1588018418.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
        <pull.539.v10.git.1588018418.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 27 Apr 2020 20:13:37 +0000
Subject: [PATCH v10 11/12] Add some reftable testing infrastructure
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
 builtin/clone.c      |  2 +-
 builtin/init-db.c    |  2 +-
 refs.c               | 13 +++++++------
 t/t3210-pack-refs.sh |  6 ++++++
 t/test-lib.sh        |  5 +++++
 5 files changed, 20 insertions(+), 8 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 5259738de88..7a59781a327 100644
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
index eb2781ed6af..6aaa51ec74e 100644
--- a/builtin/init-db.c
+++ b/builtin/init-db.c
@@ -542,7 +542,7 @@ static const char *const init_db_usage[] = {
 int cmd_init_db(int argc, const char **argv, const char *prefix)
 {
 	const char *git_dir;
-	const char *ref_storage_format = DEFAULT_REF_STORAGE;
+	const char *ref_storage_format = default_ref_storage();
 	const char *real_git_dir = NULL;
 	const char *work_tree;
 	const char *template_dir = NULL;
diff --git a/refs.c b/refs.c
index cf1e645266f..7d7aad49e3c 100644
--- a/refs.c
+++ b/refs.c
@@ -1864,10 +1864,11 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	if (!r->gitdir)
 		BUG("attempting to get main_ref_store outside of repository");
 
-	r->refs_private = ref_store_init(
-                r->gitdir,
-                r->ref_storage_format ? r->ref_storage_format : DEFAULT_REF_STORAGE,
-                REF_STORE_ALL_CAPS);
+	r->refs_private = ref_store_init(r->gitdir,
+					 r->ref_storage_format ?
+						 r->ref_storage_format :
+						 default_ref_storage(),
+					 REF_STORE_ALL_CAPS);
 	return r->refs_private;
 }
 
@@ -1922,7 +1923,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		goto done;
 
 	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
+	refs = ref_store_init(submodule_sb.buf, default_ref_storage(),
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1936,7 +1937,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
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
index 0bb1105ec37..3877a91b268 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1502,6 +1502,11 @@ FreeBSD)
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

