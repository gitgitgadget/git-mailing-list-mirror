Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54B17C4338F
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2BCFD60F6D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbhGZXEE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbhGZXED (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:03 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8505FC061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:31 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id f18-20020a05600c4e92b0290253c32620e7so334631wmq.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=SYJ/sKaULCKvnKa6OyHgHIOFRNsbzvglg1tDxMXE3IU=;
        b=EXuoDnKJtA60qEqk6HYrDVTSabspPz4UNc3E6m8qfCrQkoucOUXcpC4ovki+CX6VZ/
         Zd+ykIz4xPIU9q2bmVXmQySTVITOXcEvWT9SVWnJV7y45nCIfIxX3jc94oY6W3zyfCzj
         VyXwxOdIPG20sTmizhG11V5+OUc+w06SBWf71zCYxmlzbu7GPuxysO1OQxvlZ06ob/k+
         u4ypk+9yQgJWpb5FBf9r/puunlPAj7tuVPlqh76QVK8mWbF3pV54So9j7yldVmH+pz11
         IoS70+f+sioW3VfjDJR0djf/8OZjlQozcAZGrfu0YEj2HCXxDVTpAyLeTttFqluO98Ue
         IOjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=SYJ/sKaULCKvnKa6OyHgHIOFRNsbzvglg1tDxMXE3IU=;
        b=nVms7zsZRUX582wJv4Tqlw2PZFA8toQwJTSFTyBIu3jFCol64piMhSGSty6eZSUpFU
         Rgf9bMHJQ8/N56HnE/V0XZO45XdpmgvHVh4zLxekf+9JJFx1vajgjJvp8wZsbfsYErNy
         PTNKqxUjbfwQ33ZgVImipt1N/7LtwGkFpeAfnebTwJSqG6eZ+myXwqgADit1/6wCqqKP
         UkVGw9irc8d1FOmwO1Mbt8m+0tH1BzNq/7dlK/zJIIZeRl4AfQkftFx19Ylk7Yi/I6wV
         6RLce1PRMLPskG4O5OhYGDWPLFgDMP+T+SoI0D29+KBhwAqddYpWtigo8WU3pA6J/oZy
         NEwg==
X-Gm-Message-State: AOAM531uoYwTmUbqgZoxbUbim7M7BVJ7ckYXag4cF2fF5rZuiy1i579A
        1uq6Q1o/YKo1RbbQaw/gjs3qw5FA/UdZvA==
X-Google-Smtp-Source: ABdhPJyA7z/Xrip9t0n60xMF+AEOIeUEQoMqcw7V6d+/p/gjPCy/5Y739nK5FzybTX1LLWuqyDOWsA==
X-Received: by 2002:a05:600c:4f92:: with SMTP id n18mr1289625wmq.134.1627343069701;
        Mon, 26 Jul 2021 16:44:29 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:29 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 00/11] fix "git reflog expire" race & get rid of EISDIR in refs API
Date:   Tue, 27 Jul 2021 01:44:16 +0200
Message-Id: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This version hopefully addresses the weirdness of passing the
lock->old_oid as the "oid". We still do so, but the "refs API: pass
the "lock OID" to reflog "prepare"" and its change from s/const// is
gone, instead the relevant (and much smaller) part of that is squashed
into the "reflog expire: don't lock reflogs using previously seen OID"
change.

Ævar Arnfjörð Bjarmason (11):
  refs/packet: add missing BUG() invocations to reflog callbacks
  refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
  refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
  refs/files: remove unused "skip" in lock_raw_ref() too
  refs/debug: re-indent argument list for "prepare"
  refs: make repo_dwim_log() accept a NULL oid
  refs/files: add a comment about refs_reflog_exists() call
  reflog expire: don't lock reflogs using previously seen OID
  refs/files: remove unused "oid" in lock_ref_oid_basic()
  refs/files: remove unused "errno == EISDIR" code
  refs/files: remove unused "errno != ENOTDIR" condition

 builtin/reflog.c      |  13 ++---
 reflog-walk.c         |   3 +-
 refs.c                |   5 +-
 refs.h                |   2 +-
 refs/debug.c          |   4 +-
 refs/files-backend.c  | 130 ++++++++++++------------------------------
 refs/packed-backend.c |   5 ++
 7 files changed, 53 insertions(+), 109 deletions(-)

Range-diff against v3:
 1:  737d2d8c3d =  1:  92fc3af072 refs/packet: add missing BUG() invocations to reflog callbacks
 2:  dfb9e34076 =  2:  67cd2331fb refs/files: remove unused REF_DELETING in lock_ref_oid_basic()
 3:  0f2262fec6 =  3:  7d76514b55 refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
 4:  7fb7ff9749 =  4:  852f86e666 refs/files: remove unused "skip" in lock_raw_ref() too
 5:  4e526c34aa =  5:  685b48328a refs/debug: re-indent argument list for "prepare"
 6:  295594fe8a <  -:  ---------- refs API: pass the "lock OID" to reflog "prepare"
 7:  e45ec439db =  6:  b75e7673d7 refs: make repo_dwim_log() accept a NULL oid
 8:  8ae8e5ac02 =  7:  7fe6c9bd92 refs/files: add a comment about refs_reflog_exists() call
 9:  1050743e27 !  8:  c9c2da3599 reflog expire: don't lock reflogs using previously seen OID
    @@ Commit message
         [3].
     
         I'm leaving behind now-unused code the refs API etc. that takes the
    -    now-NULL "oid" argument, and other code that can be simplified now
    +    now-NULL "unused_oid" argument, and other code that can be simplified now
         that we never have on OID in that context, that'll be cleaned up in
         subsequent commits, but for now let's narrowly focus on fixing the
         "git gc" issue. As the modified assert() shows we always pass a NULL
    @@ builtin/reflog.c: static int cmd_reflog_delete(int argc, const char **argv, cons
      					should_expire_reflog_ent,
      					reflog_expiry_cleanup,
     
    + ## refs.h ##
    +@@ refs.h: enum expire_reflog_flags {
    +  * expiration policy that is desired.
    +  *
    +  * reflog_expiry_prepare_fn -- Called once after the reference is
    +- *     locked.
    ++ *     locked. Called with the OID of the locked reference.
    +  *
    +  * reflog_expiry_should_prune_fn -- Called once for each entry in the
    +  *     existing reflog. It should return true iff that entry should be
    +
      ## refs/files-backend.c ##
    +@@ refs/files-backend.c: static int expire_reflog_ent(struct object_id *ooid, struct object_id *noid,
    + }
    + 
    + static int files_reflog_expire(struct ref_store *ref_store,
    +-			       const char *refname, const struct object_id *oid,
    ++			       const char *refname, const struct object_id *unused_oid,
    + 			       unsigned int flags,
    + 			       reflog_expiry_prepare_fn prepare_fn,
    + 			       reflog_expiry_should_prune_fn should_prune_fn,
    +@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
    + 	int status = 0;
    + 	int type;
    + 	struct strbuf err = STRBUF_INIT;
    ++	const struct object_id *oid;
    + 
    + 	memset(&cb, 0, sizeof(cb));
    + 	cb.flags = flags;
     @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
      	 * reference itself, plus we might need to update the
      	 * reference if --updateref was specified:
    @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store
      				  REF_NO_DEREF,
      				  &type, &err);
      	if (!lock) {
    +@@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
    + 		strbuf_release(&err);
    + 		return -1;
    + 	}
    ++	oid = &lock->old_oid;
    + 
    + 	/*
    + 	 * When refs are deleted, their reflog is deleted before the
     @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
      		}
      	}
      
    --	assert(oideq(&lock->old_oid, oid));
    -+	assert(!oid);
    - 	(*prepare_fn)(refname, &lock->old_oid, cb.policy_cb);
    ++	assert(!unused_oid);
    + 	(*prepare_fn)(refname, oid, cb.policy_cb);
      	refs_for_each_reflog_ent(ref_store, refname, expire_reflog_ent, &cb);
      	(*cleanup_fn)(cb.policy_cb);
10:  753c20f89b =  9:  b61c734cf5 refs/files: remove unused "oid" in lock_ref_oid_basic()
11:  8a71bbef97 = 10:  009abc9968 refs/files: remove unused "errno == EISDIR" code
12:  452253d597 = 11:  acb131cc1c refs/files: remove unused "errno != ENOTDIR" condition
-- 
2.32.0.956.g6b0c84ceda8

