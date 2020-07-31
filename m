Return-Path: <SRS0=dkLL=BK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BFC433DF
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCFCF22B3F
	for <git@archiver.kernel.org>; Fri, 31 Jul 2020 15:27:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TZ/1nhSf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728217AbgGaP10 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 31 Jul 2020 11:27:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbgGaP1X (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 31 Jul 2020 11:27:23 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54815C06174A
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:23 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so28348238wrs.11
        for <git@vger.kernel.org>; Fri, 31 Jul 2020 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=n7PPJArisvcQrXPVDM1uIVWYpIdPAIQkSMV3OMV/YjI=;
        b=TZ/1nhSfjqeUDPXsJPQp8gwMz3Of/SP0O8Pn+572h7YjyKP3gsKkMPMC+2u6/gbU2U
         z2+vX/wONunnljy+MKu+nVttRUtoY1raiYKcsf8vE4djQ48v6uhK7Ay/mT0yRqOr/IGy
         273HZlPztm6h1GqMTl+HwIatawb1fi/a3aVgtzgTJNB+8NRofIzlV2eB0Pganc9VWi/K
         w2nh6A0pt+kwUGBIQfbqaScQM+U754vXwWMFwYX3LreD+VCIE9RQSNJZQa5JMKXyVwPw
         3DzkX49oYeN/rEH+PLTvMlI6HOsY+sY2LuEit/1hlap6xSi6aFu5Zy/Jw8tI6GgjYhsS
         3P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=n7PPJArisvcQrXPVDM1uIVWYpIdPAIQkSMV3OMV/YjI=;
        b=D2Z9WCbR9mjMM+JjEqYc3xDsAOnLUUKGPVV36/ga1mURxGS0x5ed72fGDqg30fz7kE
         TrPYA+ufjUKMWmP3y/S/IGNjMU+wxlx9ON/3t1SlzqFLTI5fanUph9OuFTKtr79iNtIw
         E2SoAutkOR4Juk31RC0Dj5MruiIj8/z62tWFy7Oxl5kvmFvPpXvQEeWrZWakh/bP6zsl
         4W7RPlLT60lTTc9JqsH9t0uopwAM+S/jZrX/M9IWw7XlD7gcpoyzUdLSEt4j50vPJjsL
         uOWx9lvqaMLHdmokA7Anpj7q4OEVuV+jgFWvpBO109U9J+58YiF96t6mmn81ZCR4NtFo
         h/bQ==
X-Gm-Message-State: AOAM5338UMCPQBwuXmfhAD/MSmF3q7q1fNGmFPGgiRX8Dn3C946fdURi
        hU1gH7ZBrrZPoWqiWvb6MCQjX4+9
X-Google-Smtp-Source: ABdhPJzTJwC18tT2c09j0RPtZBz487a56pABw63f3i1TArroEDqAbMuV9xDj0wvP3issUosErUhpNw==
X-Received: by 2002:adf:8282:: with SMTP id 2mr3918291wrc.76.1596209240211;
        Fri, 31 Jul 2020 08:27:20 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id 33sm15204462wri.16.2020.07.31.08.27.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jul 2020 08:27:19 -0700 (PDT)
Message-Id: <pull.539.v20.git.1596209237.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
References: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 31 Jul 2020 15:26:56 +0000
Subject: [PATCH v20 00/21] Reftable support git-core
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the reftable library, and hooks it up as a ref backend. 

This is still based on next, as there are conflicts basing on master.

Includes testing support, to test: make -C t/ GIT_TEST_REFTABLE=1

Summary 455 tests fail

v24

 * rebase
 * FETCH_HEAD special casing

Han-Wen Nienhuys (19):
  refs: add \t to reflog in the files backend
  Split off reading loose ref data in separate function
  t1400: use git rev-parse for testing PSEUDOREF existence
  Modify pseudo refs through ref backend storage
  Make HEAD a PSEUDOREF rather than PER_WORKTREE.
  Make refs_ref_exists public
  Treat CHERRY_PICK_HEAD as a pseudo ref
  Treat REVERT_HEAD as a pseudo ref
  Move REF_LOG_ONLY to refs-internal.h
  Iteration  over entire ref namespace is iterating over "refs/"
  Add .gitattributes for the reftable/ directory
  Add reftable library
  Add standalone build infrastructure for reftable
  Reftable support for git-core
  Read FETCH_HEAD as loose ref
  Hookup unittests for the reftable library.
  Add GIT_DEBUG_REFS debugging mechanism
  Add reftable testing infrastructure
  Add "test-tool dump-reftable" command.

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

SZEDER Gábor (1):
  git-prompt: prepare for reftable refs backend

 Documentation/git-update-ref.txt              |   13 +-
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   47 +-
 builtin/clone.c                               |    4 +-
 builtin/commit.c                              |   34 +-
 builtin/init-db.c                             |   55 +-
 builtin/merge.c                               |    2 +-
 builtin/worktree.c                            |   29 +-
 cache.h                                       |    8 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 contrib/completion/git-prompt.sh              |    7 +-
 path.c                                        |    2 -
 path.h                                        |    9 +-
 ref-filter.c                                  |    7 +-
 refs.c                                        |  171 +-
 refs.h                                        |    6 +
 refs/debug.c                                  |  387 +++++
 refs/files-backend.c                          |   45 +-
 refs/refs-internal.h                          |   20 +
 refs/reftable-backend.c                       | 1415 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/BUILD                                |  203 +++
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   33 +
 reftable/VERSION                              |    1 +
 reftable/WORKSPACE                            |   14 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  432 +++++
 reftable/block.h                              |  129 ++
 reftable/block_test.c                         |  157 ++
 reftable/compat.c                             |   98 ++
 reftable/compat.h                             |   48 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |  212 +++
 reftable/file.c                               |   95 ++
 reftable/iter.c                               |  242 +++
 reftable/iter.h                               |   72 +
 reftable/merged.c                             |  317 ++++
 reftable/merged.h                             |   43 +
 reftable/merged_test.c                        |  286 ++++
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  744 +++++++++
 reftable/reader.h                             |   65 +
 reftable/record.c                             | 1126 +++++++++++++
 reftable/record.h                             |  143 ++
 reftable/record_test.c                        |  410 +++++
 reftable/refname.c                            |  209 +++
 reftable/refname.h                            |   38 +
 reftable/refname_test.c                       |   99 ++
 reftable/reftable-tests.h                     |   22 +
 reftable/reftable.c                           |  154 ++
 reftable/reftable.h                           |  585 +++++++
 reftable/reftable_test.c                      |  632 ++++++++
 reftable/stack.c                              | 1225 ++++++++++++++
 reftable/stack.h                              |   50 +
 reftable/stack_test.c                         |  787 +++++++++
 reftable/strbuf.c                             |  206 +++
 reftable/strbuf.h                             |   88 +
 reftable/strbuf_test.c                        |   39 +
 reftable/system.h                             |   53 +
 reftable/test_framework.c                     |   69 +
 reftable/test_framework.h                     |   64 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/tree_test.c                          |   62 +
 reftable/update.sh                            |   19 +
 reftable/writer.c                             |  663 ++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 reftable/zlib.BUILD                           |   36 +
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 sequencer.c                                   |   56 +-
 setup.c                                       |   10 +-
 t/helper/test-reftable.c                      |   20 +
 t/helper/test-tool.c                          |    2 +
 t/helper/test-tool.h                          |    2 +
 t/t0031-reftable.sh                           |  185 +++
 t/t0033-debug-refs.sh                         |   18 +
 t/t1400-update-ref.sh                         |   30 +-
 t/t1405-main-ref-store.sh                     |    5 +-
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    5 +
 wt-status.c                                   |    6 +-
 89 files changed, 13076 insertions(+), 256 deletions(-)
 create mode 100644 refs/debug.c
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/BUILD
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/WORKSPACE
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/compat.c
 create mode 100644 reftable/compat.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/reftable_test.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/strbuf.c
 create mode 100644 reftable/strbuf.h
 create mode 100644 reftable/strbuf_test.c
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100755 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100644 reftable/zlib.BUILD
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0031-reftable.sh
 create mode 100755 t/t0033-debug-refs.sh


base-commit: e8ab941b671da6890181aea5b5755d1d9eea24ec
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v20
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v20
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v19:

  1:  596c316da4 <  -:  ---------- lib-t6000.sh: write tag using git-update-ref
  2:  277da0cf7e <  -:  ---------- t3432: use git-reflog to inspect the reflog for HEAD
  3:  125695ce92 <  -:  ---------- checkout: add '\n' to reflog message
  -:  ---------- >  1:  05ced51683 refs: add \t to reflog in the files backend
  -:  ---------- >  2:  d0f0680c0e Split off reading loose ref data in separate function
  -:  ---------- >  3:  716cb30c1b t1400: use git rev-parse for testing PSEUDOREF existence
  4:  5715681b3f !  4:  400ffe531f Write pseudorefs through ref backends.
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    Write pseudorefs through ref backends.
     +    Modify pseudo refs through ref backend storage
      
     -    Pseudorefs store transient data in in the repository. Examples are HEAD,
     -    CHERRY_PICK_HEAD, etc.
     +    The previous behavior was introduced in commit 74ec19d4be
     +    ("pseudorefs: create and use pseudoref update and delete functions",
     +    Jul 31, 2015), with the justification "alternate ref backends still
     +    need to store pseudorefs in GIT_DIR".
      
     -    These refs have always been read through the ref backends, but they were written
     -    in a one-off routine that wrote an object ID or symref directly into
     -    .git/<pseudo_ref_name>.
     +    Refs such as REBASE_HEAD are read through the ref backend. This can
     +    only work consistently if they are written through the ref backend as
     +    well. Tooling that works directly on files under .git should be
     +    updated to use git commands to read refs instead.
      
     -    This causes problems when introducing a new ref storage backend. To remedy this,
     -    extend the ref backend implementation with a write_pseudoref_fn and
     -    update_pseudoref_fn.
     +    The following behaviors change:
     +
     +    * Updates to pseudorefs (eg. ORIG_HEAD) with
     +      core.logAllRefUpdates=always will create reflogs for the pseudoref.
     +
     +    * non-HEAD pseudoref symrefs are also dereferenced on deletion. Update
     +      t1405 accordingly.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## refs.c ##
     -@@ refs.c: int ref_exists(const char *refname)
     - 	return refs_ref_exists(get_main_ref_store(the_repository), refname);
     - }
     + ## Documentation/git-update-ref.txt ##
     +@@ Documentation/git-update-ref.txt: still see a subset of the modifications.
     + 
     + LOGGING UPDATES
     + ---------------
     +-If config parameter "core.logAllRefUpdates" is true and the ref is one under
     +-"refs/heads/", "refs/remotes/", "refs/notes/", or the symbolic ref HEAD; or
     +-the file "$GIT_DIR/logs/<ref>" exists then `git update-ref` will append
     +-a line to the log file "$GIT_DIR/logs/<ref>" (dereferencing all
     +-symbolic refs before creating the log name) describing the change
     +-in ref value.  Log lines are formatted as:
     ++If config parameter "core.logAllRefUpdates" is true and the ref is one
     ++under "refs/heads/", "refs/remotes/", "refs/notes/", or a pseudoref
     ++like HEAD or ORIG_HEAD; or the file "$GIT_DIR/logs/<ref>" exists then
     ++`git update-ref` will append a line to the log file
     ++"$GIT_DIR/logs/<ref>" (dereferencing all symbolic refs before creating
     ++the log name) describing the change in ref value.  Log lines are
     ++formatted as:
     + 
     +     oldsha1 SP newsha1 SP committer LF
       
     -+int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid)
     -+{
     -+	return refs_delete_pseudoref(get_main_ref_store(the_repository),
     -+				     pseudoref, old_oid);
     -+}
     -+
     - static int filter_refs(const char *refname, const struct object_id *oid,
     - 			   int flags, void *data)
     - {
     +
     + ## refs.c ##
      @@ refs.c: long get_files_ref_lock_timeout_ms(void)
       	return timeout_ms;
       }
     @@ refs.c: long get_files_ref_lock_timeout_ms(void)
      -
      -	return 0;
      -}
     - 
     +-
       int refs_delete_ref(struct ref_store *refs, const char *msg,
       		    const char *refname,
     + 		    const struct object_id *old_oid,
      @@ refs.c: int refs_delete_ref(struct ref_store *refs, const char *msg,
     + 	struct ref_transaction *transaction;
     + 	struct strbuf err = STRBUF_INIT;
       
     - 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
     - 		assert(refs == get_main_ref_store(the_repository));
     +-	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
     +-		assert(refs == get_main_ref_store(the_repository));
      -		return delete_pseudoref(refname, old_oid);
     -+		return refs_delete_pseudoref(refs, refname, old_oid);
     - 	}
     - 
     +-	}
     +-
       	transaction = ref_store_transaction_begin(refs, &err);
     + 	if (!transaction ||
     + 	    ref_transaction_delete(transaction, refname, old_oid,
      @@ refs.c: int refs_update_ref(struct ref_store *refs, const char *msg,
     + 	struct strbuf err = STRBUF_INIT;
     + 	int ret = 0;
       
     - 	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
     - 		assert(refs == get_main_ref_store(the_repository));
     +-	if (ref_type(refname) == REF_TYPE_PSEUDOREF) {
     +-		assert(refs == get_main_ref_store(the_repository));
      -		ret = write_pseudoref(refname, new_oid, old_oid, &err);
     -+		ret = refs_write_pseudoref(refs, refname, new_oid, old_oid,
     -+					   &err);
     - 	} else {
     - 		t = ref_store_transaction_begin(refs, &err);
     - 		if (!t ||
     -@@ refs.c: int head_ref(each_ref_fn fn, void *cb_data)
     - 	return refs_head_ref(get_main_ref_store(the_repository), fn, cb_data);
     - }
     - 
     -+int refs_write_pseudoref(struct ref_store *refs, const char *pseudoref,
     -+			 const struct object_id *oid,
     -+			 const struct object_id *old_oid, struct strbuf *err)
     -+{
     -+	return refs->be->write_pseudoref(refs, pseudoref, oid, old_oid, err);
     -+}
     -+
     -+int refs_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
     -+			  const struct object_id *old_oid)
     -+{
     -+	return refs->be->delete_pseudoref(refs, pseudoref, old_oid);
     -+}
     -+
     - struct ref_iterator *refs_ref_iterator_begin(
     - 		struct ref_store *refs,
     - 		const char *prefix, int trim, int flags)
     -
     - ## refs.h ##
     -@@ refs.h: int update_ref(const char *msg, const char *refname,
     - 	       const struct object_id *new_oid, const struct object_id *old_oid,
     - 	       unsigned int flags, enum action_on_err onerr);
     - 
     -+/* Pseudorefs (eg. HEAD, CHERRY_PICK_HEAD) have a separate routines for updating
     -+   and deletion as they cannot take part in normal transactional updates.
     -+   Pseudorefs should only be written for the main repository.
     -+*/
     -+int refs_write_pseudoref(struct ref_store *refs, const char *pseudoref,
     -+			 const struct object_id *oid,
     -+			 const struct object_id *old_oid, struct strbuf *err);
     -+int refs_delete_pseudoref(struct ref_store *refs, const char *pseudoref,
     -+			  const struct object_id *old_oid);
     -+int delete_pseudoref(const char *pseudoref, const struct object_id *old_oid);
     -+
     - int parse_hide_refs_config(const char *var, const char *value, const char *);
     - 
     - /*
     -
     - ## refs/files-backend.c ##
     -@@ refs/files-backend.c: static int lock_raw_ref(struct files_ref_store *refs,
     - 	return ret;
     - }
     - 
     -+static int files_write_pseudoref(struct ref_store *ref_store,
     -+				 const char *pseudoref,
     -+				 const struct object_id *oid,
     -+				 const struct object_id *old_oid,
     -+				 struct strbuf *err)
     -+{
     -+	struct files_ref_store *refs =
     -+		files_downcast(ref_store, REF_STORE_READ, "write_pseudoref");
     -+	int fd;
     -+	struct lock_file lock = LOCK_INIT;
     -+	struct strbuf filename = STRBUF_INIT;
     -+	struct strbuf buf = STRBUF_INIT;
     -+	int ret = -1;
     -+
     -+	if (!oid)
     -+		return 0;
     -+
     -+	strbuf_addf(&filename, "%s/%s", refs->gitdir, pseudoref);
     -+	fd = hold_lock_file_for_update_timeout(&lock, filename.buf, 0,
     -+					       get_files_ref_lock_timeout_ms());
     -+	if (fd < 0) {
     -+		strbuf_addf(err, _("could not open '%s' for writing: %s"),
     -+			    buf.buf, strerror(errno));
     -+		goto done;
     -+	}
     -+
     -+	if (old_oid) {
     -+		struct object_id actual_old_oid;
     -+
     -+		if (read_ref(pseudoref, &actual_old_oid)) {
     -+			if (!is_null_oid(old_oid)) {
     -+				strbuf_addf(err, _("could not read ref '%s'"),
     -+					    pseudoref);
     -+				rollback_lock_file(&lock);
     -+				goto done;
     -+			}
     -+		} else if (is_null_oid(old_oid)) {
     -+			strbuf_addf(err, _("ref '%s' already exists"),
     -+				    pseudoref);
     -+			rollback_lock_file(&lock);
     -+			goto done;
     -+		} else if (!oideq(&actual_old_oid, old_oid)) {
     -+			strbuf_addf(err,
     -+				    _("unexpected object ID when writing '%s'"),
     -+				    pseudoref);
     -+			rollback_lock_file(&lock);
     -+			goto done;
     -+		}
     -+	}
     -+
     -+	strbuf_addf(&buf, "%s\n", oid_to_hex(oid));
     -+	if (write_in_full(fd, buf.buf, buf.len) < 0) {
     -+		strbuf_addf(err, _("could not write to '%s'"), filename.buf);
     -+		rollback_lock_file(&lock);
     -+		goto done;
     -+	}
     -+
     -+	commit_lock_file(&lock);
     -+	ret = 0;
     -+done:
     -+	strbuf_release(&buf);
     -+	strbuf_release(&filename);
     -+	return ret;
     -+}
     -+
     -+static int files_delete_pseudoref(struct ref_store *ref_store,
     -+				  const char *pseudoref,
     -+				  const struct object_id *old_oid)
     -+{
     -+	struct files_ref_store *refs =
     -+		files_downcast(ref_store, REF_STORE_READ, "delete_pseudoref");
     -+	struct strbuf filename = STRBUF_INIT;
     -+	int ret = -1;
     -+
     -+	strbuf_addf(&filename, "%s/%s", refs->gitdir, pseudoref);
     -+
     -+	if (old_oid && !is_null_oid(old_oid)) {
     -+		struct lock_file lock = LOCK_INIT;
     -+		int fd;
     -+		struct object_id actual_old_oid;
     -+
     -+		fd = hold_lock_file_for_update_timeout(
     -+			&lock, filename.buf, 0,
     -+			get_files_ref_lock_timeout_ms());
     -+		if (fd < 0) {
     -+			error_errno(_("could not open '%s' for writing"),
     -+				    filename.buf);
     -+			goto done;
     -+		}
     -+		if (read_ref(pseudoref, &actual_old_oid))
     -+			die(_("could not read ref '%s'"), pseudoref);
     -+		if (!oideq(&actual_old_oid, old_oid)) {
     -+			error(_("unexpected object ID when deleting '%s'"),
     -+			      pseudoref);
     -+			rollback_lock_file(&lock);
     -+			goto done;
     -+		}
     -+
     -+		unlink(filename.buf);
     -+		rollback_lock_file(&lock);
     -+	} else {
     -+		unlink(filename.buf);
     -+	}
     -+	ret = 0;
     -+done:
     -+	strbuf_release(&filename);
     -+	return ret;
     -+}
     -+
     - struct files_ref_iterator {
     - 	struct ref_iterator base;
     - 
     -@@ refs/files-backend.c: struct ref_storage_be refs_be_files = {
     - 	files_rename_ref,
     - 	files_copy_ref,
     - 
     -+	files_write_pseudoref,
     -+	files_delete_pseudoref,
     -+
     - 	files_ref_iterator_begin,
     - 	files_read_raw_ref,
     - 
     -@@ refs/files-backend.c: struct ref_storage_be refs_be_files = {
     - 	files_reflog_exists,
     - 	files_create_reflog,
     - 	files_delete_reflog,
     --	files_reflog_expire
     -+	files_reflog_expire,
     - };
     +-	} else {
     +-		t = ref_store_transaction_begin(refs, &err);
     +-		if (!t ||
     +-		    ref_transaction_update(t, refname, new_oid, old_oid,
     +-					   flags, msg, &err) ||
     +-		    ref_transaction_commit(t, &err)) {
     +-			ret = 1;
     +-			ref_transaction_free(t);
     +-		}
     ++	t = ref_store_transaction_begin(refs, &err);
     ++	if (!t ||
     ++	    ref_transaction_update(t, refname, new_oid, old_oid, flags, msg,
     ++				   &err) ||
     ++	    ref_transaction_commit(t, &err)) {
     ++		ret = 1;
     ++		ref_transaction_free(t);
     + 	}
     + 	if (ret) {
     + 		const char *str = _("update_ref failed for ref '%s': %s");
      
     - ## refs/packed-backend.c ##
     -@@ refs/packed-backend.c: static int packed_copy_ref(struct ref_store *ref_store,
     - 	BUG("packed reference store does not support copying references");
     - }
     - 
     -+static int packed_write_pseudoref(struct ref_store *ref_store,
     -+				  const char *pseudoref,
     -+				  const struct object_id *oid,
     -+				  const struct object_id *old_oid,
     -+				  struct strbuf *err)
     -+{
     -+	BUG("packed reference store does not support writing pseudo-references");
     -+}
     -+
     -+static int packed_delete_pseudoref(struct ref_store *ref_store,
     -+				   const char *pseudoref,
     -+				   const struct object_id *old_oid)
     -+{
     -+	BUG("packed reference store does not support deleting pseudo-references");
     -+}
     -+
     - static struct ref_iterator *packed_reflog_iterator_begin(struct ref_store *ref_store)
     - {
     - 	return empty_ref_iterator_begin();
     -@@ refs/packed-backend.c: struct ref_storage_be refs_be_packed = {
     - 	packed_rename_ref,
     - 	packed_copy_ref,
     - 
     -+	packed_write_pseudoref,
     -+	packed_delete_pseudoref,
     -+
     - 	packed_ref_iterator_begin,
     - 	packed_read_raw_ref,
     - 
     -@@ refs/packed-backend.c: struct ref_storage_be refs_be_packed = {
     - 	packed_reflog_exists,
     - 	packed_create_reflog,
     - 	packed_delete_reflog,
     --	packed_reflog_expire
     -+	packed_reflog_expire,
     - };
     + ## t/t1400-update-ref.sh ##
     +@@ t/t1400-update-ref.sh: test_expect_success 'core.logAllRefUpdates=always creates reflog by default' '
     + 	git reflog exists $outside
     + '
     + 
     +-test_expect_success 'core.logAllRefUpdates=always creates no reflog for ORIG_HEAD' '
     ++test_expect_success 'core.logAllRefUpdates=always creates reflog for ORIG_HEAD' '
     + 	test_config core.logAllRefUpdates always &&
     + 	git update-ref ORIG_HEAD $A &&
     +-	test_must_fail git reflog exists ORIG_HEAD
     ++	git reflog exists ORIG_HEAD
     + '
     + 
     + test_expect_success '--no-create-reflog overrides core.logAllRefUpdates=always' '
     +@@ t/t1400-update-ref.sh: test_expect_success 'git cat-file blob master@{2005-05-26 23:42}:F (expect OTHER
     + test_expect_success 'given old value for missing pseudoref, do not create' '
     + 	test_must_fail git update-ref PSEUDOREF $A $B 2>err &&
     + 	test_must_fail git rev-parse PSEUDOREF &&
     +-	test_i18ngrep "could not read ref" err
     ++	test_i18ngrep "unable to resolve reference" err
     + '
     + 
     + test_expect_success 'create pseudoref' '
     +@@ t/t1400-update-ref.sh: test_expect_success 'overwrite pseudoref with correct old value' '
     + test_expect_success 'do not overwrite pseudoref with wrong old value' '
     + 	test_must_fail git update-ref PSEUDOREF $D $E 2>err &&
     + 	test $C = $(git rev-parse PSEUDOREF) &&
     +-	test_i18ngrep "unexpected object ID" err
     ++	test_i18ngrep "cannot lock ref.*expected" err
     + '
     + 
     + test_expect_success 'delete pseudoref' '
     +@@ t/t1400-update-ref.sh: test_expect_success 'do not delete pseudoref with wrong old value' '
     + 	git update-ref PSEUDOREF $A &&
     + 	test_must_fail git update-ref -d PSEUDOREF $B 2>err &&
     + 	test $A = $(git rev-parse PSEUDOREF) &&
     +-	test_i18ngrep "unexpected object ID" err
     ++	test_i18ngrep "cannot lock ref.*expected" err
     + '
     + 
     + test_expect_success 'delete pseudoref with correct old value' '
      
     - ## refs/refs-internal.h ##
     -@@ refs/refs-internal.h: typedef int copy_ref_fn(struct ref_store *ref_store,
     - 			  const char *oldref, const char *newref,
     - 			  const char *logmsg);
     - 
     -+typedef int write_pseudoref_fn(struct ref_store *ref_store,
     -+			       const char *pseudoref,
     -+			       const struct object_id *oid,
     -+			       const struct object_id *old_oid,
     -+			       struct strbuf *err);
     -+
     -+/*
     -+ * Deletes a pseudoref. Deletion always succeeds (even if the pseudoref doesn't
     -+ * exist.), except if old_oid is specified. If it is, it can fail due to lock
     -+ * failure, failure reading the old OID, or an OID mismatch
     -+ */
     -+typedef int delete_pseudoref_fn(struct ref_store *ref_store,
     -+				const char *pseudoref,
     -+				const struct object_id *old_oid);
     -+
     - /*
     -  * Iterate over the references in `ref_store` whose names start with
     -  * `prefix`. `prefix` is matched as a literal string, without regard
     -@@ refs/refs-internal.h: struct ref_storage_be {
     - 	rename_ref_fn *rename_ref;
     - 	copy_ref_fn *copy_ref;
     - 
     -+	write_pseudoref_fn *write_pseudoref;
     -+	delete_pseudoref_fn *delete_pseudoref;
     -+
     - 	ref_iterator_begin_fn *iterator_begin;
     - 	read_raw_ref_fn *read_raw_ref;
     - 
     + ## t/t1405-main-ref-store.sh ##
     +@@ t/t1405-main-ref-store.sh: test_expect_success 'create_symref(FOO, refs/heads/master)' '
     + test_expect_success 'delete_refs(FOO, refs/tags/new-tag)' '
     + 	git rev-parse FOO -- &&
     + 	git rev-parse refs/tags/new-tag -- &&
     +-	$RUN delete-refs 0 nothing FOO refs/tags/new-tag &&
     ++	m=$(git rev-parse master) &&
     ++	REF_NO_DEREF=1 &&
     ++	$RUN delete-refs $REF_NO_DEREF nothing FOO refs/tags/new-tag &&
     ++	test_must_fail git rev-parse --symbolic-full-name FOO &&
     + 	test_must_fail git rev-parse FOO -- &&
     + 	test_must_fail git rev-parse refs/tags/new-tag --
     + '
  -:  ---------- >  5:  e9df96925b Make HEAD a PSEUDOREF rather than PER_WORKTREE.
  5:  c8cf2d2ce1 =  6:  d33ea20fba Make refs_ref_exists public
  6:  e36b29de79 <  -:  ---------- Treat BISECT_HEAD as a pseudo ref
  7:  1676df9851 !  7:  d12f6e905c Treat CHERRY_PICK_HEAD as a pseudo ref
     @@ Metadata
       ## Commit message ##
          Treat CHERRY_PICK_HEAD as a pseudo ref
      
     -    Check for existence and delete CHERRY_PICK_HEAD through pseudo ref functions.
     +    Check for existence and delete CHERRY_PICK_HEAD through ref functions.
          This will help cherry-pick work with alternate ref storage backends.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     @@ sequencer.c: static void print_advice(struct repository *r, int show_hint,
       		 * of the commit itself so remove CHERRY_PICK_HEAD
       		 */
      -		unlink(git_path_cherry_pick_head(r));
     -+		refs_delete_pseudoref(get_main_ref_store(r), "CHERRY_PICK_HEAD",
     -+				      NULL);
     ++		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
     ++				NULL, 0);
       		return;
       	}
       
     @@ sequencer.c: static int do_commit(struct repository *r,
       		strbuf_release(&sb);
       		if (!res) {
      -			unlink(git_path_cherry_pick_head(r));
     -+			refs_delete_pseudoref(get_main_ref_store(r),
     -+					      "CHERRY_PICK_HEAD", NULL);
     ++			refs_delete_ref(get_main_ref_store(r), "",
     ++					"CHERRY_PICK_HEAD", NULL, 0);
       			unlink(git_path_merge_msg(r));
       			if (!is_rebase_i(opts))
       				print_commit_summary(r, NULL, &oid,
     @@ sequencer.c: static int do_pick_commit(struct repository *r,
       	} else if (allow == 2) {
       		drop_commit = 1;
      -		unlink(git_path_cherry_pick_head(r));
     -+		refs_delete_pseudoref(get_main_ref_store(r), "CHERRY_PICK_HEAD",
     -+				      NULL);
     ++		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
     ++				NULL, 0);
       		unlink(git_path_merge_msg(r));
       		fprintf(stderr,
       			_("dropping %s %s -- patch contents already upstream\n"),
     @@ sequencer.c: void sequencer_post_commit_cleanup(struct repository *r, int verbos
      -	if (file_exists(git_path_cherry_pick_head(r))) {
      -		if (!unlink(git_path_cherry_pick_head(r)) && verbose)
      +	if (refs_ref_exists(get_main_ref_store(r), "CHERRY_PICK_HEAD")) {
     -+		if (!refs_delete_pseudoref(get_main_ref_store(r),
     -+					   "CHERRY_PICK_HEAD", NULL) &&
     ++		if (!refs_delete_ref(get_main_ref_store(r), "",
     ++				     "CHERRY_PICK_HEAD", NULL, 0) &&
      +		    verbose)
       			warning(_("cancelling a cherry picking in progress"));
       		opts.action = REPLAY_PICK;
     @@ sequencer.c: static int do_merge(struct repository *r,
       
       		strbuf_release(&ref_name);
      -		unlink(git_path_cherry_pick_head(r));
     -+		refs_delete_pseudoref(get_main_ref_store(r), "CHERRY_PICK_HEAD",
     -+				      NULL);
     ++		refs_delete_ref(get_main_ref_store(r), "", "CHERRY_PICK_HEAD",
     ++				NULL, 0);
       		rollback_lock_file(&lock);
       
       		rollback_lock_file(&lock);
     @@ sequencer.c: static int commit_staged_changes(struct repository *r,
      -		if (file_exists(cherry_pick_head) && unlink(cherry_pick_head))
      +		if (refs_ref_exists(get_main_ref_store(r),
      +				    "CHERRY_PICK_HEAD") &&
     -+		    refs_delete_pseudoref(get_main_ref_store(r),
     -+					  "CHERRY_PICK_HEAD", NULL))
     ++		    refs_delete_ref(get_main_ref_store(r), "",
     ++				    "CHERRY_PICK_HEAD", NULL, 0))
       			return error(_("could not remove CHERRY_PICK_HEAD"));
       		if (!final_fixup)
       			return 0;
  8:  0a5f97ea34 !  8:  224f7bf224 Treat REVERT_HEAD as a pseudo ref
     @@ sequencer.c: void sequencer_post_commit_cleanup(struct repository *r, int verbos
      -	if (file_exists(git_path_revert_head(r))) {
      -		if (!unlink(git_path_revert_head(r)) && verbose)
      +	if (refs_ref_exists(get_main_ref_store(r), "REVERT_HEAD")) {
     -+		if (!refs_delete_pseudoref(get_main_ref_store(r), "REVERT_HEAD",
     -+					   NULL) &&
     ++		if (!refs_delete_ref(get_main_ref_store(r), "", "REVERT_HEAD",
     ++				     NULL, 0) &&
      +		    verbose)
       			warning(_("cancelling a revert in progress"));
       		opts.action = REPLAY_REVERT;
  9:  9463ed9093 =  9:  4b601b545c Move REF_LOG_ONLY to refs-internal.h
 10:  a116aebe11 ! 10:  ea8a78374f Iterate over the "refs/" namespace in for_each_[raw]ref
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    Iterate over the "refs/" namespace in for_each_[raw]ref
     +    Iteration  over entire ref namespace is iterating over "refs/"
     +
     +    This changes behavior for in for_each_[raw]ref and
     +    for_each_fullref_in_pattern.
      
          This happens implicitly in the files/packed ref backend; making it
          explicit simplifies adding alternate ref storage backends, such as
     @@ Commit message
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     + ## ref-filter.c ##
     +@@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
     + {
     + 	struct string_list prefixes = STRING_LIST_INIT_DUP;
     + 	struct string_list_item *prefix;
     ++	const char *all = "refs/";
     + 	int ret;
     + 
     + 	if (!filter->match_as_path) {
     +@@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
     + 		 * prefixes like "refs/heads/" etc. are stripped off,
     + 		 * so we have to look at everything:
     + 		 */
     +-		return for_each_fullref_in("", cb, cb_data, broken);
     ++		return for_each_fullref_in(all, cb, cb_data, broken);
     + 	}
     + 
     + 	if (filter->ignore_case) {
     +@@ ref-filter.c: static int for_each_fullref_in_pattern(struct ref_filter *filter,
     + 		 * so just return everything and let the caller
     + 		 * sort it out.
     + 		 */
     +-		return for_each_fullref_in("", cb, cb_data, broken);
     ++		return for_each_fullref_in(all, cb, cb_data, broken);
     + 	}
     + 
     + 	if (!filter->name_patterns[0]) {
     + 		/* no patterns; we have to look at everything */
     +-		return for_each_fullref_in("", cb, cb_data, broken);
     ++		return for_each_fullref_in(all, cb, cb_data, broken);
     + 	}
     + 
     + 	find_longest_prefixes(&prefixes, filter->name_patterns);
     +
       ## refs.c ##
      @@ refs.c: static int do_for_each_ref(struct ref_store *refs, const char *prefix,
       
 11:  e4545658ed = 11:  0606b2a1c8 Add .gitattributes for the reftable/ directory
 12:  169f6c7f54 = 12:  12d98125c2 Add reftable library
 13:  d155240b16 = 13:  70ce4ce49d Add standalone build infrastructure for reftable
 14:  073bff7279 ! 14:  7af3b2340e Reftable support for git-core
     @@ builtin/init-db.c: int init_db(const char *git_dir, const char *real_git_dir,
       		git_config_set("receive.denyNonFastforwards", "true");
       	}
       
     -+	git_config_set("extensions.refStorage", ref_storage_format);
     ++	if (!strcmp(ref_storage_format, "reftable"))
     ++		git_config_set("extensions.refStorage", ref_storage_format);
      +
       	if (!(flags & INIT_DB_QUIET)) {
       		int len = strlen(git_dir);
     @@ cache.h: int path_inside_repo(const char *prefix, const char *path);
       void sanitize_stdfds(void);
       int daemonize(void);
      @@ cache.h: struct repository_format {
     + 	int is_bare;
       	int hash_algo;
     - 	int has_extensions;
       	char *work_tree;
      +	char *ref_storage;
       	struct string_list unknown_extensions;
     + 	struct string_list v1_only_extensions;
       };
     - 
      
       ## refs.c ##
      @@
     @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
      -	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
      +	r->refs_private = ref_store_init(r->gitdir,
      +					 r->ref_storage_format ?
     -+						       r->ref_storage_format :
     -+						       default_ref_storage(),
     ++						 r->ref_storage_format :
     ++						 default_ref_storage(),
      +					 REF_STORE_ALL_CAPS);
       	return r->refs_private;
       }
     @@ refs/reftable-backend.c (new)
      +	struct reftable_addition *add = NULL;
      +	struct reftable_stack *stack =
      +		transaction->nr ?
     -+			      stack_for(refs, transaction->updates[0]->refname) :
     -+			      refs->main_stack;
     ++			stack_for(refs, transaction->updates[0]->refname) :
     ++			refs->main_stack;
      +	int err = refs->err;
      +	if (err < 0) {
      +		goto done;
     @@ refs/reftable-backend.c (new)
      +	return git_reftable_transaction_finish(ref_store, transaction, errmsg);
      +}
      +
     -+struct write_pseudoref_arg {
     -+	struct reftable_stack *stack;
     -+	const char *pseudoref;
     -+	const struct object_id *new_oid;
     -+	const struct object_id *old_oid;
     -+};
     -+
     -+static int write_pseudoref_table(struct reftable_writer *writer, void *argv)
     -+{
     -+	struct write_pseudoref_arg *arg = (struct write_pseudoref_arg *)argv;
     -+	uint64_t ts = reftable_stack_next_update_index(arg->stack);
     -+	int err = 0;
     -+	struct reftable_ref_record read_ref = { NULL };
     -+	struct reftable_ref_record write_ref = { NULL };
     -+
     -+	reftable_writer_set_limits(writer, ts, ts);
     -+	if (arg->old_oid) {
     -+		struct object_id read_oid;
     -+		err = reftable_stack_read_ref(arg->stack, arg->pseudoref,
     -+					      &read_ref);
     -+		if (err < 0)
     -+			goto done;
     -+
     -+		if ((err > 0) != is_null_oid(arg->old_oid)) {
     -+			err = REFTABLE_LOCK_ERROR;
     -+			goto done;
     -+		}
     -+
     -+		/* XXX If old_oid is set, and we have a symref? */
     -+
     -+		if (err == 0 && read_ref.value == NULL) {
     -+			err = REFTABLE_LOCK_ERROR;
     -+			goto done;
     -+		}
     -+
     -+		hashcpy(read_oid.hash, read_ref.value);
     -+		if (!oideq(arg->old_oid, &read_oid)) {
     -+			err = REFTABLE_LOCK_ERROR;
     -+			goto done;
     -+		}
     -+	}
     -+
     -+	write_ref.refname = (char *)arg->pseudoref;
     -+	write_ref.update_index = ts;
     -+	if (!is_null_oid(arg->new_oid))
     -+		write_ref.value = (uint8_t *)arg->new_oid->hash;
     -+
     -+	err = reftable_writer_add_ref(writer, &write_ref);
     -+done:
     -+	assert(err != REFTABLE_API_ERROR);
     -+	reftable_ref_record_clear(&read_ref);
     -+	return err;
     -+}
     -+
     -+static int git_reftable_write_pseudoref(struct ref_store *ref_store,
     -+					const char *pseudoref,
     -+					const struct object_id *oid,
     -+					const struct object_id *old_oid,
     -+					struct strbuf *errbuf)
     -+{
     -+	struct git_reftable_ref_store *refs =
     -+		(struct git_reftable_ref_store *)ref_store;
     -+	struct reftable_stack *stack = stack_for(refs, pseudoref);
     -+	struct write_pseudoref_arg arg = {
     -+		.stack = stack,
     -+		.pseudoref = pseudoref,
     -+		.new_oid = oid,
     -+	};
     -+	struct reftable_addition *add = NULL;
     -+	int err = refs->err;
     -+	if (err < 0) {
     -+		goto done;
     -+	}
     -+
     -+	err = reftable_stack_reload(stack);
     -+	if (err) {
     -+		goto done;
     -+	}
     -+	err = reftable_stack_new_addition(&add, stack);
     -+	if (err) {
     -+		goto done;
     -+	}
     -+	if (old_oid) {
     -+		struct object_id actual_old_oid;
     -+
     -+		/* XXX this is cut & paste from files-backend - should factor
     -+		 * out? */
     -+		if (read_ref(pseudoref, &actual_old_oid)) {
     -+			if (!is_null_oid(old_oid)) {
     -+				strbuf_addf(errbuf,
     -+					    _("could not read ref '%s'"),
     -+					    pseudoref);
     -+				goto done;
     -+			}
     -+		} else if (is_null_oid(old_oid)) {
     -+			strbuf_addf(errbuf, _("ref '%s' already exists"),
     -+				    pseudoref);
     -+			goto done;
     -+		} else if (!oideq(&actual_old_oid, old_oid)) {
     -+			strbuf_addf(errbuf,
     -+				    _("unexpected object ID when writing '%s'"),
     -+				    pseudoref);
     -+			goto done;
     -+		}
     -+	}
     -+
     -+	err = reftable_addition_add(add, &write_pseudoref_table, &arg);
     -+	if (err < 0) {
     -+		strbuf_addf(errbuf, "reftable: pseudoref update failure: %s",
     -+			    reftable_error_str(err));
     -+	}
     -+
     -+	err = reftable_addition_commit(add);
     -+	if (err < 0) {
     -+		strbuf_addf(errbuf, "reftable: pseudoref commit failure: %s",
     -+			    reftable_error_str(err));
     -+	}
     -+
     -+done:
     -+	assert(err != REFTABLE_API_ERROR);
     -+	reftable_addition_destroy(add);
     -+	return err;
     -+}
     -+
     -+static int reftable_delete_pseudoref(struct ref_store *ref_store,
     -+				     const char *pseudoref,
     -+				     const struct object_id *old_oid)
     -+{
     -+	struct strbuf errbuf = STRBUF_INIT;
     -+	int ret = git_reftable_write_pseudoref(ref_store, pseudoref, &null_oid,
     -+					       old_oid, &errbuf);
     -+	/* XXX what to do with the error message? */
     -+	strbuf_release(&errbuf);
     -+	return ret;
     -+}
     -+
      +struct write_delete_refs_arg {
      +	struct reftable_stack *stack;
      +	struct string_list *refnames;
     @@ refs/reftable-backend.c (new)
      +static int git_reftable_reflog_exists(struct ref_store *ref_store,
      +				      const char *refname)
      +{
     -+	/* always exists. */
     -+	return 1;
     ++	struct reftable_iterator it = { NULL };
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, refname);
     ++	struct reftable_merged_table *mt = reftable_stack_merged_table(stack);
     ++	struct reftable_log_record log = { NULL };
     ++	int err = refs->err;
     ++
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++	err = reftable_merged_table_seek_log(mt, &it, refname);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++	err = reftable_iterator_next_log(&it, &log);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++
     ++	if (strcmp(log.refname, refname)) {
     ++		err = 1;
     ++	}
     ++
     ++done:
     ++	reftable_iterator_destroy(&it);
     ++	reftable_log_record_clear(&log);
     ++	return !err;
      +}
      +
      +static int git_reftable_create_reflog(struct ref_store *ref_store,
     @@ refs/reftable-backend.c (new)
      +	git_reftable_rename_ref,
      +	git_reftable_copy_ref,
      +
     -+	git_reftable_write_pseudoref,
     -+	reftable_delete_pseudoref,
     -+
      +	git_reftable_ref_iterator_begin,
      +	git_reftable_read_raw_ref,
      +
     @@ repository.h: struct repository {
       	 */
      
       ## setup.c ##
     -@@ setup.c: static int check_repo_format(const char *var, const char *value, void *vdata)
     - 			if (!value)
     - 				return config_error_nonbool(var);
     - 			data->partial_clone = xstrdup(value);
     --		} else if (!strcmp(ext, "worktreeconfig"))
     -+		} else if (!strcmp(ext, "worktreeconfig")) {
     - 			data->worktree_config = git_config_bool(var, value);
     --		else
     -+		} else if (!strcmp(ext, "refstorage")) {
     -+			data->ref_storage = xstrdup(value);
     -+		} else
     - 			string_list_append(&data->unknown_extensions, ext);
     +@@ setup.c: static enum extension_result handle_extension(const char *var,
     + {
     + 	if (!strcmp(ext, "noop-v1")) {
     + 		return EXTENSION_OK;
     ++	} else if (!strcmp(ext, "refstorage")) {
     ++		data->ref_storage = xstrdup(value);
     ++		return EXTENSION_OK;
       	}
     +-
     + 	return EXTENSION_UNKNOWN;
     + }
       
      @@ setup.c: void clear_repository_format(struct repository_format *format)
     - 	string_list_clear(&format->unknown_extensions, 0);
     + 	string_list_clear(&format->v1_only_extensions, 0);
       	free(format->work_tree);
       	free(format->partial_clone);
      +	free(format->ref_storage);
  -:  ---------- > 15:  a6449d4346 Read FETCH_HEAD as loose ref
 15:  04c86e7395 ! 16:  f13e4798c4 Hookup unittests for the reftable library.
     @@ Makefile: t/helper/test-svn-fe$X: $(VCSSVN_LIB)
       	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) $(filter %.a,$^) $(LIBS)
       
       check-sha1:: t/helper/test-tool$X
     +@@ Makefile: cocciclean:
     + clean: profile-clean coverage-clean cocciclean
     + 	$(RM) *.res
     + 	$(RM) $(OBJECTS)
     +-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB) $(REFTABLE_LIB)
     ++	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
     + 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
     + 	$(RM) $(TEST_PROGRAMS)
     + 	$(RM) $(FUZZ_PROGRAMS)
      
       ## t/helper/test-reftable.c (new) ##
      @@
 16:  c751265705 ! 17:  679dc37871 Add GIT_DEBUG_REFS debugging mechanism
     @@ builtin/worktree.c: static int add_worktree(const char *path, const char *refnam
       	strbuf_reset(&sb);
      -	if (get_main_ref_store(the_repository)->be == &refs_be_reftable) {
      +
     -+	/* XXX: check GIT_TEST_REFTABLE because GIT_DEBUG_REFS obscures the
     -+	 * instance type. */
     -+	if (get_main_ref_store(the_repository)->be == &refs_be_reftable ||
     -+	    getenv("GIT_TEST_REFTABLE") != NULL) {
     ++	if (!strcmp(ref_store_backend_name(get_main_ref_store(the_repository)),
     ++		    "reftable")) {
       		/* XXX this is cut & paste from reftable_init_db. */
       		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
       		write_file(sb.buf, "%s", "ref: refs/heads/.invalid\n");
      
       ## refs.c ##
     +@@ refs.c: int ref_storage_backend_exists(const char *name)
     + 	return find_ref_storage_backend(name) != NULL;
     + }
     + 
     ++const char *ref_store_backend_name(struct ref_store *refs)
     ++{
     ++	return refs->be->name;
     ++}
     ++
     + /*
     +  * How to handle various characters in refnames:
     +  * 0: An acceptable character for refs
      @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
     - 						       r->ref_storage_format :
     - 						       default_ref_storage(),
     + 						 r->ref_storage_format :
     + 						 default_ref_storage(),
       					 REF_STORE_ALL_CAPS);
      +	if (getenv("GIT_DEBUG_REFS")) {
      +		r->refs_private = debug_wrap(r->gitdir, r->refs_private);
     @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
       }
       
      
     + ## refs.h ##
     +@@ refs.h: int reflog_expire(const char *refname, const struct object_id *oid,
     + int ref_storage_backend_exists(const char *name);
     + 
     + struct ref_store *get_main_ref_store(struct repository *r);
     ++const char *ref_store_backend_name(struct ref_store *refs);
     + 
     + /**
     +  * Submodules
     +
       ## refs/debug.c (new) ##
      @@
      +
     @@ refs/debug.c (new)
      +struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store)
      +{
      +	struct debug_ref_store *res = malloc(sizeof(struct debug_ref_store));
     ++	struct ref_storage_be *be_copy = malloc(sizeof(*be_copy));
     ++	*be_copy = refs_be_debug;
     ++	be_copy->name = ref_store_backend_name(store);
      +	fprintf(stderr, "ref_store for %s\n", gitdir);
      +	res->refs = store;
     -+	base_ref_store_init((struct ref_store *)res, &refs_be_debug);
     ++	base_ref_store_init((struct ref_store *)res, be_copy);
      +	return (struct ref_store *)res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res =
      +		drefs->refs->be->delete_refs(drefs->refs, msg, refnames, flags);
     ++	int i = 0;
     ++	fprintf(stderr, "delete_refs {\n");
     ++	for (i = 0; i < refnames->nr; i++)
     ++		fprintf(stderr, "%s\n", refnames->items[i].string);
     ++	fprintf(stderr, "}: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	return res;
      +}
      +
     -+static int debug_write_pseudoref(struct ref_store *ref_store,
     -+				 const char *pseudoref,
     -+				 const struct object_id *oid,
     -+				 const struct object_id *old_oid,
     -+				 struct strbuf *err)
     -+{
     -+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
     -+	int res = drefs->refs->be->write_pseudoref(drefs->refs, pseudoref, oid,
     -+						   old_oid, err);
     -+	char o[100] = "null";
     -+	char n[100] = "null";
     -+	if (oid)
     -+		oid_to_hex_r(o, oid);
     -+	if (old_oid)
     -+		oid_to_hex_r(n, old_oid);
     -+	fprintf(stderr, "write_pseudoref: %s, %s => %s, err %s: %d\n",
     -+		pseudoref, o, n, err->buf, res);
     -+	return res;
     -+}
     -+
     -+static int debug_delete_pseudoref(struct ref_store *ref_store,
     -+				  const char *pseudoref,
     -+				  const struct object_id *old_oid)
     -+{
     -+	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
     -+	int res = drefs->refs->be->delete_pseudoref(drefs->refs, pseudoref,
     -+						    old_oid);
     -+	char hex[100] = "null";
     -+	if (old_oid)
     -+		oid_to_hex_r(hex, old_oid);
     -+	fprintf(stderr, "delete_pseudoref: %s (%s): %d\n", pseudoref, hex, res);
     -+	return res;
     -+}
     -+
      +struct debug_ref_iterator {
      +	struct ref_iterator base;
      +	struct ref_iterator *iter;
     @@ refs/debug.c (new)
      +	debug_rename_ref,
      +	debug_copy_ref,
      +
     -+	debug_write_pseudoref,
     -+	debug_delete_pseudoref,
     -+
      +	debug_ref_iterator_begin,
      +	debug_read_raw_ref,
      +
     @@ refs/debug.c (new)
      +};
      
       ## refs/refs-internal.h ##
     -@@ refs/refs-internal.h: struct ref_store {
     +@@ refs/refs-internal.h: int parse_loose_ref_contents(const char *buf, struct object_id *oid,
       void base_ref_store_init(struct ref_store *refs,
       			 const struct ref_storage_be *be);
       
 17:  ef0dd45f07 = 18:  9e6cdbe204 vcxproj: adjust for the reftable changes
 18:  d4dc1deae5 = 19:  9cd73da381 git-prompt: prepare for reftable refs backend
 19:  5a85abf9c4 = 20:  a2e5b3082e Add reftable testing infrastructure
 20:  0ebf7beb95 = 21:  539fa0935f Add "test-tool dump-reftable" command.

-- 
gitgitgadget
