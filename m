Return-Path: <SRS0=mA98=7A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2C3AC433E3
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89C9220829
	for <git@archiver.kernel.org>; Mon, 18 May 2020 20:31:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ilR842sZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726938AbgERUbl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 18 May 2020 16:31:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgERUbh (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 May 2020 16:31:37 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A21C05BD0C
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:36 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id j5so13419830wrq.2
        for <git@vger.kernel.org>; Mon, 18 May 2020 13:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=hBVohhNDI3iqKnPyhhbX3l2hv5Ymm0kpxzuw3g4/7Zg=;
        b=ilR842sZN2H3rPU0bipJpyZhQVwYKMr8V4ymKphpcpdv5OXyd9oB13nwVqMe82yE7h
         +kogyA6B5f5UF//2H0153rlfUQVpULqZ3/wFPAbqCxWJKglJiGyEbMvdVBY9LYL5AhZ1
         pjzeoY7Ffq/iR7X5R7nJ5olCokERpAjRkwCOuoY7Boz03IvG1KlgzVMcivGwdCsoYM8U
         6Oig20t5Ww1qNThvQkuW7ENogE85E0RzEW6lQaoFGdzjDggvsetLDeF12tGncuwk7UPJ
         OSZduQVli2uGT6Y5MqLHd32IcuidJsZfPBmaoSRDidWJW4oS2yPYYhS6sAZFggt4/0/H
         KcaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=hBVohhNDI3iqKnPyhhbX3l2hv5Ymm0kpxzuw3g4/7Zg=;
        b=GDjRMMxeMPDic94QXH6+2o5puTKitHYbhEWjmlsM/EmJGSlPWXDlLBNUno7Wie9dwh
         j/a1fUp9jFt35tJKVc/kZTQCbIzlDyERMPmRe4FlsXgxjrFnECw+j5aqSREcEuybIreb
         QCcW2n7lghVJYi85MRAAei7Jt6hWvVipLjAc+vMFLqGgkwj0rIHzyx7HxuIB6Ek3UXSM
         8iU12CEHqD4kbhKHC5Z4bV2nvwHPsSIMoBDGKKZ+XEmi/q9170RGwH3KgmevnNl1BJYP
         G0MSQCEm3Pu3c/kGDPbCBc4qNMdNhgwIKusEeHAXhfDKusJ5czsqPCPNO9DtJjYCEd9i
         jpLw==
X-Gm-Message-State: AOAM532KYRwUc3MNBtexCZU/sTYAlOJxbvfvsZQScml+hyLAFm6AKClF
        9gkiBaFH7Eks5CQp2VFNkxb3EJAh
X-Google-Smtp-Source: ABdhPJy5oHpFfMyav3tmOuCgC42nWCIqL6AvQ1khYtNjlWYellR80xo+0fjJKOorrUWvwlEeS+jkqA==
X-Received: by 2002:a5d:6803:: with SMTP id w3mr21735394wru.151.1589833895024;
        Mon, 18 May 2020 13:31:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id u65sm925098wmg.8.2020.05.18.13.31.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 13:31:34 -0700 (PDT)
Message-Id: <7764ebf09562357a48ab7dca393d6250e4eedcf6.1589833884.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
References: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <pull.539.v14.git.1589833884.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 18 May 2020 20:31:24 +0000
Subject: [PATCH v14 9/9] Add reftable testing infrastructure
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

* Add test_prerequisite REFTABLE.

* Skip some tests that are incompatible:

  * t3210-pack-refs.sh - does not apply
  * t9903-bash-prompt - The bash mode reads .git/HEAD directly
  * t1450-fsck.sh - manipulates .git/ directly to create invalid state

Major test failures:

 * t1400-update-ref.sh - Reads from .git/{refs,logs} directly
 * t1404-update-ref-errors.sh - Manipulates .git/refs/ directly
 * t1405 - inspecs .git/ directly.

t6030-bisect-porcelain.sh                - 62 of 72
t2400-worktree-add.sh                    - 58 of 69
t3200-branch.sh                          - 58 of 145
t7406-submodule-update.sh                - 54 of 54
t5601-clone.sh                           - 51 of 105
t9903-bash-prompt.sh                     - 50 of 66
t1404-update-ref-errors.sh               - 44 of 53
t5510-fetch.sh                           - 40 of 171
t7400-submodule-basic.sh                 - 38 of 111
t3514-cherry-pick-revert-gpg.sh          - 36 of 36
..

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/clone.c               | 2 +-
 builtin/init-db.c             | 2 +-
 refs.c                        | 6 +++---
 t/t1409-avoid-packing-refs.sh | 6 ++++++
 t/t1450-fsck.sh               | 6 ++++++
 t/t3210-pack-refs.sh          | 6 ++++++
 t/t9903-bash-prompt.sh        | 6 ++++++
 t/test-lib.sh                 | 5 +++++
 8 files changed, 34 insertions(+), 5 deletions(-)

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
index 9b456a46712..6886330da41 100644
--- a/refs.c
+++ b/refs.c
@@ -1743,7 +1743,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	r->refs_private = ref_store_init(r->gitdir,
 					 r->ref_storage_format ?
 						 r->ref_storage_format :
-						 DEFAULT_REF_STORAGE,
+						 default_ref_storage(),
 					 REF_STORE_ALL_CAPS);
 	if (getenv("GIT_DEBUG_REFS")) {
 		r->refs_private = debug_wrap(r->refs_private);
@@ -1802,7 +1802,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		goto done;
 
 	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
+	refs = ref_store_init(submodule_sb.buf, default_ref_storage(),
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1816,7 +1816,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
 struct ref_store *get_worktree_ref_store(const struct worktree *wt)
 {
-	const char *format = DEFAULT_REF_STORAGE; /* XXX */
+	const char *format = default_ref_storage();
 	struct ref_store *refs;
 	const char *id;
 
diff --git a/t/t1409-avoid-packing-refs.sh b/t/t1409-avoid-packing-refs.sh
index be12fb63506..c6f78325563 100755
--- a/t/t1409-avoid-packing-refs.sh
+++ b/t/t1409-avoid-packing-refs.sh
@@ -4,6 +4,12 @@ test_description='avoid rewriting packed-refs unnecessarily'
 
 . ./test-lib.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping pack-refs tests; incompatible with reftable'
+  test_done
+fi
+
 # Add an identifying mark to the packed-refs file header line. This
 # shouldn't upset readers, and it should be omitted if the file is
 # ever rewritten.
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 449ebc5657c..9f605433033 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -8,6 +8,12 @@ test_description='git fsck random collection of tests
 
 . ./test-lib.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping tests; incompatible with reftable'
+  test_done
+fi
+
 test_expect_success setup '
 	test_oid_init &&
 	git config gc.auto 0 &&
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
diff --git a/t/t9903-bash-prompt.sh b/t/t9903-bash-prompt.sh
index ab5da2cabc4..5deaaf968b0 100755
--- a/t/t9903-bash-prompt.sh
+++ b/t/t9903-bash-prompt.sh
@@ -7,6 +7,12 @@ test_description='test git-specific bash prompt functions'
 
 . ./lib-bash.sh
 
+if test_have_prereq REFTABLE
+then
+  skip_all='skipping tests; incompatible with reftable'
+  test_done
+fi
+
 . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
 
 actual="$TRASH_DIRECTORY/actual"
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
