Return-Path: <SRS0=KQVw=7S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA91C433E5
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 440C6207ED
	for <git@archiver.kernel.org>; Fri,  5 Jun 2020 18:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aM9mLQhn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgFESDs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 5 Jun 2020 14:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728137AbgFESDn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 5 Jun 2020 14:03:43 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37150C08C5C7
        for <git@vger.kernel.org>; Fri,  5 Jun 2020 11:03:41 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id l26so9223738wme.3
        for <git@vger.kernel.org>; Fri, 05 Jun 2020 11:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Wi/ubpbEOVvP9iFkpwc/A8f8eg4ZfOZtOAnE8N/lnos=;
        b=aM9mLQhnOij8B6EhsUIBGmtHDS99Wh65Pgm6/bkMYJLJJPmoAK0gSWc7Z6rrSzfZVg
         +V1mmXisgSeUM+iso/dxHfFs0gi916EI/SbyWZoG3KfS/cYE6NWjXr/KsSVc32d1cb7S
         eS6JxO5SO64s83KT/p4KOTfAJWjPPGrOmQae1yDyf5RsXt3/VgNW+T5loGzljrWJ+MPW
         jnBXyFDFW0NS93wXdr6oLeKtmxWhVibc5O1dd/NFaI/y067P1Gkhe+6y2niQ+c41Llmy
         hNdLR1WERRsW3lXSbYm+tGq+KfvFciOt6376Yod6WzipUMWW57QvM6LzbtP/wpTRfXwh
         NimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Wi/ubpbEOVvP9iFkpwc/A8f8eg4ZfOZtOAnE8N/lnos=;
        b=YbSY+9y7hMhPB8Ui0iGp4J/ori67PK2+cG0a6/w9QO5Yo7ln3c+Es91vIXn2nWAXqG
         g243jIzsm78sBIVEQIplKR0AEabEl/uH9fqPobef9puCpNod1MSpk/LaxrxZo3nuQROK
         LevIq7IMqBXvbp4Kgs4aAn5T8NgLUEQ6w6eAoU2Vz7BqaQ+3Ue7HM+/OtAt0YhPm87ZH
         RdJiEkR93jwo/uFo1+3nWzcmhldLesSht9rCeswFD9P8T81IRt7ZsTCD0mpAExyYT4pe
         iOwnLA++khv8wc9awvq8px4tgZcQz1/6AVa/2ibErj47bX5B3hc2iIV1fG5gSMxaSntd
         a/Qg==
X-Gm-Message-State: AOAM531s5jcZppXQYwtzoWRkoLzobV4mzUpY1yXzmsVq9xnzDjBGo+EG
        eNh2cocPHMhAEnXngV4jRWNvQzn3
X-Google-Smtp-Source: ABdhPJxwWmpg9o5TwZi6fEC+75XmiuTaZQFQIKyVTH0yU9F+LiYVKE4/DEr2MLjlBVnYVqiJmP5D9w==
X-Received: by 2002:a1c:de46:: with SMTP id v67mr3828513wmg.146.1591380219665;
        Fri, 05 Jun 2020 11:03:39 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id o10sm11953697wrq.40.2020.06.05.11.03.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2020 11:03:39 -0700 (PDT)
Message-Id: <a03c882b075bf891f13a2d0720f619baf1772c53.1591380200.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
References: <pull.539.v15.git.1590695209.gitgitgadget@gmail.com>
        <pull.539.v16.git.1591380199.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 05 Jun 2020 18:03:18 +0000
Subject: [PATCH v16 14/14] Add reftable testing infrastructure
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

Worst offenders:

t1400-update-ref.sh                      - 82 of 185
t2400-worktree-add.sh                    - 58 of 69
t1404-update-ref-errors.sh               - 44 of 53
t3514-cherry-pick-revert-gpg.sh          - 36 of 36
t5541-http-push-smart.sh                 - 29 of 38
t6003-rev-list-topo-order.sh             - 29 of 35
t3420-rebase-autostash.sh                - 28 of 42
t6120-describe.sh                        - 21 of 82
t3430-rebase-merges.sh                   - 18 of 24
t2018-checkout-branch.sh                 - 15 of 22
..

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 builtin/clone.c               | 2 +-
 refs.c                        | 6 +++---
 t/t1409-avoid-packing-refs.sh | 6 ++++++
 t/t1450-fsck.sh               | 6 ++++++
 t/t3210-pack-refs.sh          | 6 ++++++
 t/t9903-bash-prompt.sh        | 6 ++++++
 t/test-lib.sh                 | 5 +++++
 7 files changed, 33 insertions(+), 4 deletions(-)

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
diff --git a/refs.c b/refs.c
index bd1f3cc0e45..ba5239b8421 100644
--- a/refs.c
+++ b/refs.c
@@ -1748,7 +1748,7 @@ struct ref_store *get_main_ref_store(struct repository *r)
 	r->refs_private = ref_store_init(r->gitdir,
 					 r->ref_storage_format ?
 						 r->ref_storage_format :
-						 DEFAULT_REF_STORAGE,
+						 default_ref_storage(),
 					 REF_STORE_ALL_CAPS);
 	if (getenv("GIT_DEBUG_REFS")) {
 		r->refs_private = debug_wrap(r->refs_private);
@@ -1807,7 +1807,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 		goto done;
 
 	/* assume that add_submodule_odb() has been called */
-	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
+	refs = ref_store_init(submodule_sb.buf, default_ref_storage(),
 			      REF_STORE_READ | REF_STORE_ODB);
 	register_ref_store_map(&submodule_ref_stores, "submodule",
 			       refs, submodule);
@@ -1821,7 +1821,7 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 
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
index 344a2aad82f..09669203249 100755
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
index dbc027ff267..3ce9b957b1b 100644
--- a/t/test-lib.sh
+++ b/t/test-lib.sh
@@ -1504,6 +1504,11 @@ parisc* | hppa*)
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
