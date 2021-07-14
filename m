Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A606C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FB6F6101D
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238984AbhGNLqc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbhGNLqb (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:46:31 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614CCC06175F
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:39 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id m2so2863929wrq.2
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dd0SVYrYHAOEGBYFOy2wga7NYo2agZUaHBkEWajZIx4=;
        b=oqWZ/dQFxReOJTbrw0xw5fXd4maYkYEOoU8+64ZTK0Evv0VunrOjS/pL+kbNE3LeFc
         gJOkYyekEEfIPBJgNTKnnlfwzoOHjtA2dud6vsCnpsuUVAD4Y52JadrGNaIgsWQWvsXt
         cx+i90jyuwyEtmKi20ASPJ5E3ebAloK/e8Qyw78S8DcUSs00AmLyNbBAf9obY1w5v94i
         hS9gBEj0AQtC4a32iDHNIgodN884AR6ZhPcRCusgrvN3I1tlnYmpjUDNooW20lrxbnjv
         vHNxDishMg2iHu3XbSpMn6TkHeZBfWUy2aahiImeONzuIVWWcwAqY6pDKu28oWwPpwg5
         8BgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dd0SVYrYHAOEGBYFOy2wga7NYo2agZUaHBkEWajZIx4=;
        b=WM+GZGl1ZWG2Y8S+VkL/vzYNrCmH9YzJa/OvUHEWN6qT5Fv75ydpqSugnnt0TZ819l
         LZmFLjJpBrfH2ifD0lj45fayKkNX3n9FvsziLLmqYJWWfbUOgWW/UxC5q5gLfIxSvM6o
         q8hrI46WjetkRm1CsHido/wbRwVrTYDxP8xrW6HaAbjiPoHCoY471yTzlpPtthZ5Q6gZ
         tG7+nNdUlDHAqjBi8kcosLRRGBFpx583Dj7fhOkBZ6ZWmOQXrqc260Bb7MGiHqMm6htn
         a43vJfW2v8f95qcAzq22c3j+7e/zEkr8W1CJOpRRdONp0CA5OqtxTwassCGI+RiA2HWa
         9lmw==
X-Gm-Message-State: AOAM530jmplEaGyjxOmxodx3ptP8NdXHYJ8wOUhqw/mlXpDNPtRlLd3D
        3kyF68as4SAdBYWEdGKZ1TX0WaZiNModokUU
X-Google-Smtp-Source: ABdhPJwibgaAiowtDBoxcxhHa9Eh5e+59JfXJvjQxDy4i6UYS2xwHpQuyc0Gy1h6Tr9mxPQIUK1oxg==
X-Received: by 2002:a05:6000:136a:: with SMTP id q10mr12468964wrz.25.1626263017721;
        Wed, 14 Jul 2021 04:43:37 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a8sm2373626wrt.61.2021.07.14.04.43.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:43:37 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v7 0/6] refs: cleanup errno sideband ref related functions
Date:   Wed, 14 Jul 2021 13:43:28 +0200
Message-Id: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.851.g0fc62a9785
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Per the discussion & feedback on the "v6?" at [1] this is a version of
Han-Wen's patches which:

 A. Goes on top of my just-submitted one-patch
    https://lore.kernel.org/git/patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com
    being able to remove that code in lock_ref_oid_basic() makes
    things simpler, the BUG() I added to that branch in my "v6?" is
    gone.

    That change simplifies this series quite a bit, more than one
    patch in this one dealt with that now-removed codepath.

 B. Rebases this on top of that

 C. I ejected my long series of RFC-esque patches at the end.

    Per [2] it looks like Han-Wen is happy to have some version of my
    re-roll picked up, but I hardly think it's fair that I inflate
    other people's serieses with a bunch of fixes on top, I cause
    myself enough trouble with that as it is :)

    The value of those patches of mine on top is to assert that the
    changes in this series are correct.

    But I think to just get this in it's enough that that work exists
    and that we did the full errno conversion and could demonstrate
    that there weren't bugs as a result of it.

    For now in 04/06 here we leave the "For unmigrated legacy callers"
    assignment of "errno" in refs_resolve_ref_unsafe().

    I'll just submit that cleanup series on top of this once this
    lands.

1. http://lore.kernel.org/git/cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com
2. http://lore.kernel.org/git/CAFQ2z_P=9Suh0kO6E44hUOyNFOAKcmcUg_x6AQFP9jhHrBA6RQ@mail.gmail.com

Han-Wen Nienhuys (6):
  refs: remove EINVAL errno output from specification of read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn
  refs: add failure_errno to refs_read_raw_ref() signature
  refs: explicitly return failure_errno from parse_loose_ref_contents
  refs: make errno output explicit for refs_resolve_ref_unsafe

 refs.c                | 69 ++++++++++++++++++++----------
 refs.h                | 11 +++++
 refs/debug.c          |  4 +-
 refs/files-backend.c  | 98 +++++++++++++++++++++++--------------------
 refs/packed-backend.c | 15 +++----
 refs/refs-internal.h  | 32 ++++++++------
 6 files changed, 141 insertions(+), 88 deletions(-)

Range-diff against v6:
 1:  57517368c3 =  1:  4beba4443a refs: remove EINVAL errno output from specification of read_raw_ref_fn
 2:  61cf761147 !  2:  fd8e356185 refs/files-backend: stop setting errno from lock_ref_oid_basic
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
      	int resolve_flags = RESOLVE_REF_NO_RECURSE;
      	int resolved;
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 		 * to remain.
    - 		 */
    - 		if (remove_empty_directories(&ref_file)) {
    --			last_errno = errno;
    - 			if (!refs_verify_refname_available(
    - 					    &refs->base,
    - 					    refname, extras, skip, err))
    -@@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 						     refname, resolve_flags,
    - 						     &lock->old_oid, type);
    - 	}
    + 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
    + 					     refname, resolve_flags,
    + 					     &lock->old_oid, type);
     -	if (!resolved) {
     -		last_errno = errno;
     -		if (last_errno != ENOTDIR ||
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
     -						   extras, skip, err))
     -			strbuf_addf(err, "unable to resolve reference '%s': %s",
     -				    refname, strerror(last_errno));
    --
     +	if (!resolved &&
     +	    (errno != ENOTDIR ||
     +	     /* in case of D/F conflict, try to generate a better error
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
     +					    skip, err))) {
     +		strbuf_addf(err, "unable to resolve reference '%s': %s",
     +			    refname, strerror(errno));
    + 
      		goto error_return;
      	}
    - 
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
      	if (is_null_oid(&lock->old_oid) &&
      	    refs_verify_refname_available(refs->packed_ref_store, refname,
 3:  a4e5f2d02f =  3:  913e72e9ff refs: make errno output explicit for read_raw_ref_fn
 4:  270cda29c3 =  4:  dd191768f6 refs: add failure_errno to refs_read_raw_ref() signature
 5:  f5197cdc0b =  5:  77c53dc0d9 refs: explicitly return failure_errno from parse_loose_ref_contents
 6:  96689e523f !  6:  5d4b1b4ddf refs: make errno output explicit for refs_resolve_ref_unsafe
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
     -	resolved = !!refs_resolve_ref_unsafe(&refs->base,
     -					     refname, resolve_flags,
     -					     &lock->old_oid, type);
    --	if (!resolved && errno == EISDIR) {
     +	resolved = !!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
     +							resolve_flags,
     +							&lock->old_oid, type,
     +							&resolve_errno);
    -+	if (!resolved && resolve_errno == EISDIR) {
    - 		/*
    - 		 * we are trying to lock foo but we used to
    - 		 * have foo/bar which now does not exist;
    -@@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 						     &lock->old_oid, type);
    - 	}
      	if (!resolved &&
     -	    (errno != ENOTDIR ||
     +	    (resolve_errno != ENOTDIR ||
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
      					    skip, err))) {
      		strbuf_addf(err, "unable to resolve reference '%s': %s",
     -			    refname, strerror(errno));
    +-
     +			    refname, strerror(resolve_errno));
      		goto error_return;
      	}
 7:  10a40c9244 <  -:  ---------- refs: make errno ignoring explicit in lock_ref_oid_basic()
 8:  ff38a3f193 <  -:  ---------- refs file-backend.c: stop setting "EBUSY" in verify_lock()
 9:  cdec272f06 <  -:  ---------- refs file-backend.c: deal with errno directly in verify_lock()
10:  bd0639945a <  -:  ---------- refs API: remove refs_read_ref_full() wrapper
11:  a359d1533b <  -:  ---------- refs API: make resolve_gitlink_ref() not set errno
12:  07d550015a <  -:  ---------- refs API: make refs_resolve_ref_unsafe() static
13:  73b7049151 <  -:  ---------- refs API: make refs_resolve_refdup() not set errno
14:  1e9de48d85 <  -:  ---------- refs API: make refs_ref_exists() not set errno
15:  446b50280b <  -:  ---------- refs API: make resolve_ref_unsafe() not set errno
16:  37c5b88d7d <  -:  ---------- refs API: make expand_ref() and repo_dwim_log() not set errno
17:  f914df0bb2 <  -:  ---------- refs API: don't leak "errno" in run_transaction_hook()
-- 
2.32.0.851.g0fc62a9785

