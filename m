Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE6FFC07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C77CE613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbhGPOQO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232808AbhGPOQO (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D7C5C06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:18 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id l7so12271971wrv.7
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WdJC7EeRpq7C+Ok+kw4DbH6UQ/QrI5HlWH0pSv8nJFc=;
        b=TGF30IDjUzGhw+OdZ8uL2RjORRJd7jSTOeVjMdoCvz5x7wTYaPnZxQ9pVzwY+P/ERm
         Faxgux6PPmjbBVLvXaqKdLTeOpE15tz2qB0swKuHBeMUFyqqm16knH4W6dLNQf5AT1cF
         FAiv0mIaFk6FKC+TjzhNdnB3GmoLXKbCNY8YzExeV16itmCfmUHn8TamDxXhYwhRLfwj
         EOO0s+AIESCVedVgNxOMTtWAZo8lGACg+zUaP5lj/xjFd3hVOOXlgTmQ2gzMDkJd8ad6
         fn5uxnNyJbcbPMB52VpA1bG+W33YlQYTmsu1lRcbXe5eFMKS+QcEwEY3ZeC8i5Gd6Y8q
         6xTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WdJC7EeRpq7C+Ok+kw4DbH6UQ/QrI5HlWH0pSv8nJFc=;
        b=n3GnAtUKuQzplWxXrZA0hSXzhusU7ED+FKKY12ZaE9V3jNZ7njatQOd1JKDjhVxxVQ
         /MtPsrwxAC7gy5mB27qfcQBkBJ22oApw181XqHQcxs0o8p2lRTTPE2RMcIX7+dq4xtl7
         AaV00Hc5X/c8v9PZHVpgIdJHB2PwW4iJvit8Qwn3u8W75GDnte+XiWZDbkMyx0W6yRoP
         qj/2Bc5VuyFCQkVwUPtz4CqQYfFM12NZBuDjOMiFCAUdVmOSn+Hyy5sqHCKo3A6bWYl4
         n9qoLivSGA94MRH9la5ls30igc9rY6OOr1I6k2Cb1NXS2kbrkIyUmCo/OdvFOE9o73aq
         Dj8w==
X-Gm-Message-State: AOAM531+VGleYljVpRa8fm4Kdc9pCm6Lu31FqiCRtnzfphyAHxXNfUDe
        cUNKA4oQRo7kpEoWHa/SmoVe/0SQHvI=
X-Google-Smtp-Source: ABdhPJwaUFdd/4jfliZQXdsZNZQrheBgXf1IbrPPlRrLTFbePO0UbFHCwu9po71RvHbJ6HqGUi71gg==
X-Received: by 2002:a5d:408a:: with SMTP id o10mr12318436wrp.272.1626444796453;
        Fri, 16 Jul 2021 07:13:16 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:16 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 00/11] fix "git reflog expire" race & get rid of EISDIR in refs API
Date:   Fri, 16 Jul 2021 16:12:56 +0200
Message-Id: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the much smaller one-patch v1:
https://lore.kernel.org/git/patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com/

As noted in the discussion there there's a potential loose end with
one of the 4 callers of lock_ref_oid_basic().

I'd forgotten that I fixed a bug in 2019 by removing the OID call to
that one caller[1]. It didn't get integrated for no particularly good
reason, had some "prep" series it depended on, it looked good to
reviewers, but I just forgot to pursue it after the prep patches
landed.

That patch has been running in a large production for a long time, and
as far as I know still is. The version of it we end up with here is
the same in all the important ways, I just clean up the immediate
caller as well (and there's some prep patches for that).

There's still some loose ends left in builtin/reflog.c after that, but
it's not important for correctness. I've got a 7-patch series
post-this for that, hopefully I'll remember to submit it this time.

1. https://lore.kernel.org/git/875yxczbd6.fsf@evledraar.gmail.com/

Ævar Arnfjörð Bjarmason (11):
  refs/packet: add missing BUG() invocations to reflog callbacks
  refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
  refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
  refs/files: remove unused "skip" in lock_raw_ref() too
  refs/debug: re-indent argument list for "prepare"
  refs API: pass the "lock OID" to reflog "prepare"
  refs: make repo_dwim_log() accept a NULL oid
  refs/files: add a comment about refs_reflog_exists() call
  reflog expire: don't lock reflogs using previously seen OID
  refs/files: remove unused "oid" in lock_ref_oid_basic()
  refs/files: remove unused "errno == EISDIR" code

 builtin/reflog.c      |  17 +++---
 reflog-walk.c         |   3 +-
 refs.c                |   5 +-
 refs.h                |   4 +-
 refs/debug.c          |  10 ++--
 refs/files-backend.c  | 122 ++++++++++--------------------------------
 refs/packed-backend.c |   5 ++
 7 files changed, 54 insertions(+), 112 deletions(-)

Range-diff against v1:
 -:  ----------- >  1:  30bd7679a5c refs/packet: add missing BUG() invocations to reflog callbacks
 -:  ----------- >  2:  033c0cec33d refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
 -:  ----------- >  3:  94ffcd8cfda refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
 -:  ----------- >  4:  61f9e0fc864 refs/files: remove unused "skip" in lock_raw_ref() too
 -:  ----------- >  5:  95101c322b7 refs/debug: re-indent argument list for "prepare"
 -:  ----------- >  6:  e93465f4137 refs API: pass the "lock OID" to reflog "prepare"
 -:  ----------- >  7:  0fff2d32cfc refs: make repo_dwim_log() accept a NULL oid
 -:  ----------- >  8:  1e25b7c59c5 refs/files: add a comment about refs_reflog_exists() call
 -:  ----------- >  9:  60d6cf342fc reflog expire: don't lock reflogs using previously seen OID
 -:  ----------- > 10:  09dd8836437 refs/files: remove unused "oid" in lock_ref_oid_basic()
 1:  de0838fe996 ! 11:  96c3e5e9f79 refs file backend: remove dead "errno == EISDIR" code
    @@ Metadata
     Author: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## Commit message ##
    -    refs file backend: remove dead "errno == EISDIR" code
    +    refs/files: remove unused "errno == EISDIR" code
     
         When we lock a reference like "foo" we need to handle the case where
         "foo" exists, but is an empty directory. That's what this code added
    @@ Commit message
         remove_empty_directories() and continue.
     
         Since a1c1d8170d (refs_resolve_ref_unsafe: handle d/f conflicts for
    -    writes, 2017-10-06) we don't, because our our callstack will look
    -    something like:
    +    writes, 2017-10-06) we don't. E.g. in the case of
    +    files_copy_or_rename_ref() our callstack will look something like:
     
    -        files_copy_or_rename_ref() -> lock_ref_oid_basic() -> refs_resolve_ref_unsafe()
    +            [...] ->
    +            files_copy_or_rename_ref() ->
    +            lock_ref_oid_basic() ->
    +            refs_resolve_ref_unsafe()
     
    -    And then the refs_resolve_ref_unsafe() call here will in turn (in the
    -    code added in a1c1d8170d) do the equivalent of this (via a call to
    -    refs_read_raw_ref()):
    +    At that point the first (now only) refs_resolve_ref_unsafe() call in
    +    lock_ref_oid_basic() would do the equivalent of this in the resulting
    +    call to refs_read_raw_ref() in refs_resolve_ref_unsafe():
     
                 /* Via refs_read_raw_ref() */
                 fd = open(path, O_RDONLY);
    @@ Commit message
         We then proceed with the entire ref update and don't call
         remove_empty_directories() until we call commit_ref_update(). See
         5387c0d883 (commit_ref(): if there is an empty dir in the way, delete
    -    it, 2016-05-05) for the addition of that code.
    +    it, 2016-05-05) for the addition of that code, and
    +    a1c1d8170db (refs_resolve_ref_unsafe: handle d/f conflicts for writes,
    +    2017-10-06) for the commit that changed the original codepath added in
    +    bc7127ef0f to use this "EISDIR" handling.
    +
    +    Further historical commentary:
    +
    +    Before the two preceding commits the caller in files_reflog_expire()
    +    was the only one out of our 4 callers that would pass non-NULL as an
    +    oid. We would then set a (now gone) "resolve_flags" to
    +    "RESOLVE_REF_READING" and just before that "errno != EISDIR" check do:
    +
    +            if (resolve_flags & RESOLVE_REF_READING)
    +                    return NULL;
    +
    +    There may have been some case where this ended up mattering and we
    +    couldn't safely make this change before we removed the "oid"
    +    parameter, but I don't think there was, see [1] for some discussion on
    +    that.
    +
    +    In any case, now that we've removed the "oid" parameter in a preceding
    +    commit we can be sure that this code is redundant, so let's remove it.
    +
    +    1. http://lore.kernel.org/git/871r801yp6.fsf@evledraar.gmail.com
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
    - 					     refname, resolve_flags,
    - 					     &lock->old_oid, type);
    + 	struct strbuf ref_file = STRBUF_INIT;
    + 	struct ref_lock *lock;
    + 	int last_errno = 0;
    +-	int resolved;
    + 
    + 	files_assert_main_repository(refs, "lock_ref_oid_basic");
    + 	assert(err);
    +@@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    + 	CALLOC_ARRAY(lock, 1);
    + 
    + 	files_ref_path(refs, &ref_file, refname);
    +-	resolved = !!refs_resolve_ref_unsafe(&refs->base, refname,
    +-					     RESOLVE_REF_NO_RECURSE,
    +-					     &lock->old_oid, type);
     -	if (!resolved && errno == EISDIR) {
     -		/*
     -		 * we are trying to lock foo but we used to
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
     -			last_errno = errno;
     -			if (!refs_verify_refname_available(
     -					    &refs->base,
    --					    refname, extras, skip, err))
    +-					    refname, NULL, NULL, err))
     -				strbuf_addf(err, "there are still refs under '%s'",
     -					    refname);
     -			goto error_return;
     -		}
    --		resolved = !!refs_resolve_ref_unsafe(&refs->base,
    --						     refname, resolve_flags,
    +-		resolved = !!refs_resolve_ref_unsafe(&refs->base, refname,
    +-						     RESOLVE_REF_NO_RECURSE,
     -						     &lock->old_oid, type);
     -	}
    - 	if (!resolved) {
    +-	if (!resolved) {
    ++	if (!refs_resolve_ref_unsafe(&refs->base, refname,
    ++				     RESOLVE_REF_NO_RECURSE,
    ++				     &lock->old_oid, type)) {
      		last_errno = errno;
      		if (last_errno != ENOTDIR ||
    + 		    !refs_verify_refname_available(&refs->base, refname,
-- 
2.32.0.873.gb6f2f696497

