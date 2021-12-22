Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1A2FC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:07:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238753AbhLVEHH (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbhLVEHH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:07:07 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4B17C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:06 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id a9so2057603wrr.8
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:07:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=uX3/0dtVyAqDTD+SddmaLvqnoRfHUS0i3/0A0SMPfQI=;
        b=j25t3cDSJRNsMLy1bDDa2Ld+eQNEXKGYeHWaxXLUFgxVlKuraxrFviwAs3UX9AU0tn
         OAaNy7z+AD4VnDoGyKotMnmIFt+SuYSoELv4g3US0UdQYRT9kT/oiOioJC/z45mGHDY4
         c/d97aAdPG/K7ghM37MHbpedIkLv1icab13jRxInes2OBa04WJDwDN/G7uGVDwNGUgEu
         QZZcrt6oKqMIkrAYGwtCdztzOv7ElBfRJabG7TDykw3ttskgOmp4XFRcw73UwYfMlqkE
         AIhtrEOiS1yK9zxRqQEckcEE3YdPMV9SEirCixwUmuop+xgDQm8dlvfYrImVW92ClH/p
         cCRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=uX3/0dtVyAqDTD+SddmaLvqnoRfHUS0i3/0A0SMPfQI=;
        b=ZAK3ntuUx6hb2uOlveirdZS5mZQ2vkfdTeCALfZyDUCoKR1KAuwUNswnmfI0c4bdXw
         1XU4JNt9rQnRyfKTPpjpZlS3MWvvX8gp6cIgnCXeG5rmlMwY4NcFCQGRJ1XCzJZz8Fd2
         i8z1jWLJOGzNFFtDz6/RYsVoe5uN/sD6qeqiQBcupts3Ra7RoGss4LZqfESK91nj/2tB
         2XzN2wyDxUpV+E0ZmyOM80QAqWwuDfTVHggAAHrLe8PTO3MKMZpUZ9Yx6PyD3tLUFYUG
         lxsiHDdYAFn5xkzJFSZ1l+N0dt4ZD6OGQshxnUatiyjS0esnKeezrxp6rcMXLLoYd1/H
         xisA==
X-Gm-Message-State: AOAM532whUUClWC4JqcDdLI/l9k+rxd0PwQBbnUmOHruVQMoptI1ATmw
        vrmlLsRlVUQHXlhBPJjqJ4JKpZjev8KueA==
X-Google-Smtp-Source: ABdhPJwHMVZA6WB6CTy9Gn1/an26k7FWi7+Os86sN8ugKqh8JJD4PAqSlSXbI/Z9lw8Y8Zk4zfcqQQ==
X-Received: by 2002:a05:6000:156b:: with SMTP id 11mr724273wrz.261.1640146024723;
        Tue, 21 Dec 2021 20:07:04 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z5sm710484wru.87.2021.12.21.20.07.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:07:04 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/9] reftable prep: have builtin/reflog.c handle "--verbose"
Date:   Wed, 22 Dec 2021 05:06:39 +0100
Message-Id: <cover-v3-0.9-00000000000-20211222T040557Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
References: <cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series refactors various small bits of builtin/reflog.c
(e.g. using a "struct string_list" now), and finally makes it handle
the "--verbose" output, instead of telling the files backend to emit
that same verbose output.

This means that when we start to integrate "reftable" the new backend
won't need to implement verbose reflog output, it will just work.

This v3 addresses comments Han-Wen had on the v2[1] in [2]. Those are
all addressed here.

I thought that eliminating the "goto" as he suggested might lead to
needlessly verbose code, but I think this new approach is much
better. We now have a "verbose" callback that's a wrapper around the
non-verbose version. For the common case of non-verbose we won't
execute any "verbose" code at all, which makes this code easier to
follow.

1. https://lore.kernel.org/git/cover-v2-0.9-00000000000-20211216T134028Z-avarab@gmail.com/
2. https://lore.kernel.org/git/CAFQ2z_McOfm545Xd8hF7YDgzyOjDmcGxpWZ6pQ-yaKAEWMMbgg@mail.gmail.com/

Ævar Arnfjörð Bjarmason (9):
  reflog delete: narrow scope of "cmd" passed to count_reflog_ent()
  reflog expire: narrow scope of "cb" in cmd_reflog_expire()
  reflog: change one->many worktree->refnames to use a string_list
  reflog expire: use "switch" over enum values
  reflog expire: refactor & use "tip_commit" only for UE_NORMAL
  reflog expire: don't use lookup_commit_reference_gently()
  reflog: reduce scope of "struct rev_info"
  refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN
  reflog + refs-backend: move "verbose" out of the backend

 builtin/reflog.c     | 223 +++++++++++++++++++++++++------------------
 refs.h               |   3 +-
 refs/files-backend.c |  44 ++++-----
 3 files changed, 150 insertions(+), 120 deletions(-)

Range-diff against v2:
 1:  22c8119640c =  1:  7fac198f485 reflog delete: narrow scope of "cmd" passed to count_reflog_ent()
 2:  b8e84538427 =  2:  1ffc8ef8a8b reflog expire: narrow scope of "cb" in cmd_reflog_expire()
 3:  c0e190e46cf !  3:  ba7679e6fc0 reflog: change one->many worktree->refnames to use a string_list
    @@ Commit message
         free, as a result we need just one struct to keep track of this data,
         instead of two.
     
    +    The "DUP" -> "string_list_append_nodup(..., strbuf_detach(...))"
    +    pattern here is the same as that used in a recent memory leak fix in
    +    b202e51b154 (grep: fix a "path_list" memory leak, 2021-10-22).
    +
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/reflog.c ##
    @@ builtin/reflog.c: static void reflog_expiry_cleanup(void *cb_data)
     -	FLEX_ALLOC_STR(e, reflog, newref.buf);
     -	strbuf_release(&newref);
     +	strbuf_worktree_ref(worktree, &newref, ref);
    -+	string_list_append(&cb->reflogs, strbuf_detach(&newref, NULL));
    ++	string_list_append_nodup(&cb->reflogs, strbuf_detach(&newref, NULL));
      
     -	oidcpy(&e->oid, oid);
     -	ALLOC_GROW(cb->e, cb->nr + 1, cb->alloc);
    @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
      	if (do_all) {
     -		struct collect_reflog_cb collected;
     +		struct worktree_reflogs collected = {
    -+			.reflogs = STRING_LIST_INIT_NODUP,
    ++			.reflogs = STRING_LIST_INIT_DUP,
     +		};
     +		struct string_list_item *item;
      		struct worktree **worktrees, **p;
    @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
     -			free(e);
      		}
     -		free(collected.e);
    -+		collected.reflogs.strdup_strings = 1;
     +		string_list_clear(&collected.reflogs, 0);
      	}
      
 4:  e42fac1b518 !  4:  74447de0413 reflog expire: don't do negative comparison on enum values
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    reflog expire: don't do negative comparison on enum values
    +    reflog expire: use "switch" over enum values
     
         Change code added in 03cb91b18cc (reflog --expire-unreachable: special
    -    case entries in "HEAD" reflog, 2010-04-09) to not do positive instead
    -    of negative comparisons on enum values, i.e. not to assume that "x !=
    -    UE_ALWAYS" means "(x == UE_HEAD || x || UE_NORMAL)".
    +    case entries in "HEAD" reflog, 2010-04-09) to use a "switch" statement
    +    with an exhaustive list of "case" statements instead of doing numeric
    +    comparisons against the enum labels.
     
    -    That assumption is true now, but we'd introduce subtle bugs here if
    -    that were to change, now the compiler will notice and error out on
    -    such errors.
    +    Now we won't assume that "x != UE_ALWAYS" means "(x == UE_HEAD || x ||
    +    UE_NORMAL)". That assumption is true now, but we'd introduce subtle
    +    bugs here if that were to change, now the compiler will notice and
    +    error out on such errors.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 5:  39263cd00ae !  5:  896ae9f73eb reflog expire: refactor & use "tip_commit" only for UE_NORMAL
    @@ Commit message
     
         The code behaves the same way as before, but this makes the control
         flow clearer, and the shorter name allows us to fold a 4-line i/else
    -    int a one-line terany instead.
    +    into a one-line ternary instead.
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
 6:  c71aab5845e =  6:  cfa80e84c6d reflog expire: don't use lookup_commit_reference_gently()
 7:  2fb33ef2546 =  7:  b3a62b9b177 reflog: reduce scope of "struct rev_info"
 8:  f9fe6a2cfb0 =  8:  6748298a782 refs files-backend: assume cb->newlog if !EXPIRE_REFLOGS_DRY_RUN
 9:  28aa0aa6e30 !  9:  2fb9de8ae51 reflog + refs-backend: move "verbose" out of the backend
    @@ builtin/reflog.c: struct expire_reflog_policy_cb {
      	struct cmd_reflog_expire_cb cmd;
      	struct commit *tip_commit;
      	struct commit_list *tips;
    -+	unsigned int dry_run:1,
    -+		     verbose:1;
    ++	unsigned int dry_run:1;
      };
      
      struct worktree_reflogs {
     @@ builtin/reflog.c: static int should_expire_reflog_ent(struct object_id *ooid, struct object_id *no
    - 	struct commit *old_commit, *new_commit;
    - 
    - 	if (timestamp < cb->cmd.expire_total)
    --		return 1;
    -+		goto expire;
    - 
    - 	old_commit = new_commit = NULL;
    - 	if (cb->cmd.stalefix &&
    - 	    (!keep_entry(&old_commit, ooid) || !keep_entry(&new_commit, noid)))
    --		return 1;
    -+		goto expire;
    - 
    - 	if (timestamp < cb->cmd.expire_unreachable) {
    - 		switch (cb->unreachable_expire_kind) {
    - 		case UE_ALWAYS:
    --			return 1;
    -+			goto expire;
    - 		case UE_NORMAL:
    - 		case UE_HEAD:
    - 			if (unreachable(cb, old_commit, ooid) || unreachable(cb, new_commit, noid))
    --				return 1;
    -+				goto expire;
    - 			break;
    - 		}
    - 	}
    + 	return 0;
    + }
      
    - 	if (cb->cmd.recno && --(cb->cmd.recno) == 0)
    --		return 1;
    -+		goto expire;
    ++static int should_expire_reflog_ent_verbose(struct object_id *ooid,
    ++					    struct object_id *noid,
    ++					    const char *email,
    ++					    timestamp_t timestamp, int tz,
    ++					    const char *message, void *cb_data)
    ++{
    ++	struct expire_reflog_policy_cb *cb = cb_data;
    ++	int expire;
     +
    -+	if (cb->verbose)
    ++	expire = should_expire_reflog_ent(ooid, noid, email, timestamp, tz,
    ++					  message, cb);
    ++
    ++	if (!expire)
     +		printf("keep %s", message);
    - 
    - 	return 0;
    -+expire:
    -+	if (cb->dry_run)
    ++	else if (cb->dry_run)
     +		printf("would prune %s", message);
    -+	else if (cb->verbose)
    ++	else
     +		printf("prune %s", message);
    -+	return 1;
    - }
    - 
    ++
    ++	return expire;
    ++}
    ++
      static int push_tip_to_list(const char *refname, const struct object_id *oid,
    + 			    int flags, void *cb_data)
    + {
     @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
      	int i, status, do_all, all_worktrees = 1;
      	int explicit_expiry = 0;
      	unsigned int flags = 0;
     +	int verbose = 0;
    ++	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
      
      	default_reflog_expire_unreachable = now - 30 * 24 * 3600;
      	default_reflog_expire = now - 90 * 24 * 3600;
    @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
      		else if (!strcmp(arg, "--")) {
      			i++;
      			break;
    +@@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
    + 			break;
    + 	}
    + 
    ++	if (verbose)
    ++		should_prune_fn = should_expire_reflog_ent_verbose;
    ++
    + 	/*
    + 	 * We can trust the commits and objects reachable from refs
    + 	 * even in older repository.  We cannot trust what's reachable
     @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
      		revs.do_not_die_on_missing_tree = 1;
      		revs.ignore_missing = 1;
    @@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, cons
     +			struct expire_reflog_policy_cb cb = {
     +				.cmd = cmd,
     +				.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
    -+				.verbose = verbose,
     +			};
      
      			set_reflog_expiry_param(&cb.cmd, explicit_expiry, item->string);
      			status |= reflog_expire(item->string, flags,
    + 						reflog_expiry_prepare,
    +-						should_expire_reflog_ent,
    ++						should_prune_fn,
    + 						reflog_expiry_cleanup,
    + 						&cb);
    + 		}
    +@@ builtin/reflog.c: static int cmd_reflog_expire(int argc, const char **argv, const char *prefix)
    + 		set_reflog_expiry_param(&cb.cmd, explicit_expiry, ref);
    + 		status |= reflog_expire(ref, flags,
    + 					reflog_expiry_prepare,
    +-					should_expire_reflog_ent,
    ++					should_prune_fn,
    + 					reflog_expiry_cleanup,
    + 					&cb);
    + 		free(ref);
     @@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
      	struct cmd_reflog_expire_cb cmd = { 0 };
      	int i, status = 0;
      	unsigned int flags = 0;
     +	int verbose = 0;
    ++	reflog_expiry_should_prune_fn *should_prune_fn = should_expire_reflog_ent;
      
      	for (i = 1; i < argc; i++) {
      		const char *arg = argv[i];
    @@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, cons
      		else if (!strcmp(arg, "--")) {
      			i++;
      			break;
    +@@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
    + 			break;
    + 	}
    + 
    ++	if (verbose)
    ++		should_prune_fn = should_expire_reflog_ent_verbose;
    ++
    + 	if (argc - i < 1)
    + 		return error(_("no reflog specified to delete"));
    + 
     @@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
      		const char *spec = strstr(argv[i], "@{");
      		char *ep, *ref;
      		int recno;
     -		struct expire_reflog_policy_cb cb = { 0 };
     +		struct expire_reflog_policy_cb cb = {
    -+			.verbose = verbose,
     +			.dry_run = !!(flags & EXPIRE_REFLOGS_DRY_RUN),
     +		};
      
      		if (!spec) {
      			status |= error(_("not a reflog: %s"), argv[i]);
    +@@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, const char *prefix)
    + 		cb.cmd = cmd;
    + 		status |= reflog_expire(ref, flags,
    + 					reflog_expiry_prepare,
    +-					should_expire_reflog_ent,
    ++					should_prune_fn,
    + 					reflog_expiry_cleanup,
    + 					&cb);
    + 		free(ref);
     
      ## refs.h ##
     @@ refs.h: enum ref_type ref_type(const char *refname);
-- 
2.34.1.1146.gb52885e7c44

