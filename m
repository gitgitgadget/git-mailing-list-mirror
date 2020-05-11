Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33066C54E8F
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 11252206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uuL/7MAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731589AbgEKTqv (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731556AbgEKTqp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:45 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0A3C05BD09
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:45 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id u16so20716961wmc.5
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=/4+ZDsnN+VU4FmRfjD7kE6TLaZznGdCr8rN/CRYP0Bo=;
        b=uuL/7MAtTcLJj1MKO5p+qPyllXseG6ZwGVW/Gt50kVqqcHNHfU2cvmqhVQYVh4pplH
         WbniH8bZTvF0nCkb6FCAwGIi+Uie4KWHgWNvS1jWU+6nW4qLkwKX4L9Y5R9FIw/akWD+
         HuKQufE4ZYbSPUIFs9Cx4vuL/jPq7Ytara77m/g+TPZAbN8A+oMpsVgjwyZyu8qxCffR
         rBSezqWvUCqykGGRAh6yDZhs94K5b7OxIXgGmeZmBLZ0gH+Na+IcoQroPgShpfS6L+cf
         SRhB/G0wWRvz0ebwAVs04ePdbLPAVvJDHW61OBzh/emfjc8nFlph8uMVCcs7IVYNKjW2
         7Qyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=/4+ZDsnN+VU4FmRfjD7kE6TLaZznGdCr8rN/CRYP0Bo=;
        b=QFDgfL8zVa8So6texaqa+V7WSQ9rpIMslzEwE2z7vzsUT+H2/WFfxDBDv1k9I6g/d5
         +rieo81HbxdXQSuyOwC/uYZNjOxeluvHJAdEz5HJR8bGg35qJMFUDNu4YJV9pGupQC8D
         jkdzTJTmjJFLdKQNI0NoqcY9fKtfqBApbt21GnYhNN+5cUoQT4Z32PtxW2w225Y2XwnZ
         uXfyjafA/wYO9eSButggZY93Iv4uaHMmKCROiA/ZVXZiEjZ0117wcO8ZAk5Qj7f2ZLRh
         Wlp1dbEh+0UW36euACt/kVFh/L7Cj0hOskd7y+OvjArSheM45jFnfM5CjXl91bgsVvoh
         PBKg==
X-Gm-Message-State: AGi0PuY1+lPPH7tA5vZtoXw/vhxlBqYEemfxk6MKRg9s6+bPMy1h2/gp
        MA/5H3M4M+giREnOrR3g8AKVwWu9
X-Google-Smtp-Source: APiQypJC9aXHA9aQZY4VWwK2ThUtYJ3mi51irP9WDBRMz9+rbMoVYDGcUpwQ6O0Flnmeu+U4su6rMA==
X-Received: by 2002:a05:600c:2299:: with SMTP id 25mr12343145wmf.138.1589226403574;
        Mon, 11 May 2020 12:46:43 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l13sm2787419wrm.55.2020.05.11.12.46.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:43 -0700 (PDT)
Message-Id: <0e732d30b516855a7e91240a9055712b26905b2e.1589226388.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:28 +0000
Subject: [PATCH v13 13/13] Add some reftable testing infrastructure
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

Major test failures:

 * t9903-bash-prompt - The bash mode reads .git/HEAD directly
 * t1400-update-ref.sh - Reads from .git/{refs,logs} directly
 * t1404-update-ref-errors.sh - Manipulates .git/refs/ directly
 * t1405 - inspecs .git/ directly.
 * t1450-fsck.sh - manipulates .git/ directly to create invalid state
 * Rebase, cherry-pick: pseudo refs aren't written through the refs backend.

Other tests by decreasing brokenness:

t1407-worktree-ref-store.sh              - 5 of 5
t1413-reflog-detach.sh                   - 7 of 7
t1415-worktree-refs.sh                   - 11 of 11
t3908-stash-in-worktree.sh               - 2 of 2
t4207-log-decoration-colors.sh           - 2 of 2
t5515-fetch-merge-logic.sh               - 17 of 17
t5900-repo-selection.sh                  - 8 of 8
t6016-rev-list-graph-simplify-history.sh - 12 of 12
t5573-pull-verify-signatures.sh          - 15 of 16
t5612-clone-refspec.sh                   - 12 of 13
t5514-fetch-multiple.sh                  - 11 of 12
t6030-bisect-porcelain.sh                - 64 of 71
t5533-push-cas.sh                        - 15 of 17
t5539-fetch-http-shallow.sh              - 7 of 8
t7413-submodule-is-active.sh             - 7 of 8
t2400-worktree-add.sh                    - 59 of 69
t0100-previous.sh                        - 5 of 6
t7419-submodule-set-branch.sh            - 5 of 6
t1404-update-ref-errors.sh               - 44 of 53
t6003-rev-list-topo-order.sh             - 29 of 35
t1409-avoid-packing-refs.sh              - 9 of 11
t5541-http-push-smart.sh                 - 31 of 38
t5407-post-rewrite-hook.sh               - 13 of 16
t9903-bash-prompt.sh                     - 52 of 66
t1414-reflog-walk.sh                     - 9 of 12
t1507-rev-parse-upstream.sh              - 21 of 28
t2404-worktree-config.sh                 - 9 of 12
t1505-rev-parse-last.sh                  - 5 of 7
t7510-signed-commit.sh                   - 16 of 23
t2018-checkout-branch.sh                 - 15 of 22
(..etc)



Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/clone.c               | 2 +-
 builtin/init-db.c             | 2 +-
 refs.c                        | 6 +++---
 t/t1409-avoid-packing-refs.sh | 6 ++++++
 t/t3210-pack-refs.sh          | 6 ++++++
 t/test-lib.sh                 | 5 +++++
 6 files changed, 22 insertions(+), 5 deletions(-)

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
index e8751415a9e..70c11b05391 100644
--- a/refs.c
+++ b/refs.c
@@ -1742,7 +1742,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	r->refs_private = ref_store_init(r->gitdir,
 					 r->ref_storage_format ?
 						 r->ref_storage_format :
-						 DEFAULT_REF_STORAGE,
+						 default_ref_storage(),
 					 REF_STORE_ALL_CAPS);
 	return r->refs_private;
 }
@@ -1798,7 +1798,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		goto done;
 
 	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
+	refs = ref_store_init(submodule_sb.buf, default_ref_storage(),
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1812,7 +1812,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
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
index baf94546da1..21740e2c13d 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1516,6 +1516,11 @@ FreeBSD)
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
