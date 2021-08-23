Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B198DC4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90A8B6103B
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:52:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236680AbhHWLxh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbhHWLxg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:53:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0308AC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:54 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v10so14649638wrd.4
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7frHMj7ZQNKZUojGQpTFCS2jrsb+DbLnocEiJ5eM3qo=;
        b=idsm0LJp6d6w3Fx1a8clP6q8DzxqPCjoFqYagfkq0FjfcBDJionB8c4Z6KwzngYmB0
         6q/AJNLP+LUU8AyEJ6Vi1FdWOHbJAbV9dwnLIn1naekI6dfmQT2zZgGvPS7Y/uJv2KVI
         6mdOD9YyvaUpgTs9rcQAQ041DUGeQrPorDBDT0KZpXumeNaUQR9BCUnNoM1Sb5boirpN
         rFZPT/iGhQCaIvjzsEYagdHsffnnQEmogEo016e+ub+VzELgZ7OYKACNci0CRt5ju54M
         I6iQj19Lg+Q3F9+ntza21oWmx/Ur/WwflAnAdLAZL0sL6OhRag2Ir8tEgumv12OSHTY1
         BJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7frHMj7ZQNKZUojGQpTFCS2jrsb+DbLnocEiJ5eM3qo=;
        b=HDBzJ6cxULNN2oC82uZPsmVR9zrVYwV+Wl8xL1QSFwwRgJlct4tGM1isUm208Ok4nr
         ZGBftiEghXsqDiq4Lp7mtu87mxecMiqxLEbdPzz++LPc0Y1olYIfO2cr6ZRyK8/N/KJt
         077Y+mGeZJ6H63Xp4vM+q6sdO1a8iAP/z0Su9O3Y/nv056KZi50bbVHCKEN5WLNJSzSS
         9I7KvUCJT8UVj/68kFNZAgqUtOoeeUhNjZdUM+dg+vll5oGDc1+jRjbh6Nb9D+ykn4ks
         VqFvg/ENsmivC+OmiKZcoZTLhHFGCEPtuPsNK1D7JUZhUCRjwafYxZRfEj3mOrfpM1xW
         yfEQ==
X-Gm-Message-State: AOAM530/gvtLoB2rZrlgx3l7K6dOOKZur69d10gtCEyBX3/nY1t3Fjch
        F21Fshh7tTZuIMRaPN5hMQYYqnqj5okgPeJu
X-Google-Smtp-Source: ABdhPJyvYmSN5ActesBYeyjBw2mCSNBsYWI7ayfGWlK7g/uu4XbReUpRgJn8vg4gBDJC/rk9KpXVrA==
X-Received: by 2002:adf:e5c7:: with SMTP id a7mr13172600wrn.312.1629719572343;
        Mon, 23 Aug 2021 04:52:52 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l2sm12350713wmi.1.2021.08.23.04.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:52:51 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 0/8] refs: cleanup errno sideband ref related functions
Date:   Mon, 23 Aug 2021 13:52:36 +0200
Message-Id: <cover-v10-0.8-00000000000-20210823T114712Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v10 re-roll of the v9, see
https://lore.kernel.org/git/cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com/
and more imporantly the real summary of what this is in v7 at
https://lore.kernel.org/git/cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com/

This topic builds on my just-re-rolled v5 removing of dead code +
fixing a gc race in the refs API, at:
https://lore.kernel.org/git/cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com/

The changes since v9 are:

 * Rebased on v5 of its "base" topic, see:
   https://lore.kernel.org/git/cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com/

 * Incorporate the test + fix Han-Wen submitted as
   https://lore.kernel.org/git/pull.1068.git.git.1629203489546.gitgitgadget@gmail.com/;
   that's here as 6/8.

   I fixed up the test code a bit, added a SYMLINKS prerequisite as
   suggested by Junio, used a "test_when_finished" instead of a "rm
   -rf" at the start, used test_cmp over "test", and other minor style
   changes. The actual BUG() fix is then squashed into 7/8.

 * Fixed issues in refs/debug.c, noted in
   https://lore.kernel.org/git/CAFQ2z_M0LNmZn2xW_GWdwZOCi20xc9t3EnMzMzHP8ZcmWrW9EA@mail.gmail.com/

Han-Wen Nienhuys (7):
  refs: remove EINVAL errno output from specification of read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn
  refs: add failure_errno to refs_read_raw_ref() signature
  branch tests: test for errno propagating on failing read
  refs: explicitly return failure_errno from parse_loose_ref_contents
  refs: make errno output explicit for refs_resolve_ref_unsafe

Ævar Arnfjörð Bjarmason (1):
  refs file backend: move raceproof_create_file() here

 cache.h               |  43 ---------
 object-file.c         |  68 ---------------
 refs.c                |  69 ++++++++++-----
 refs.h                |  11 +++
 refs/debug.c          |   7 +-
 refs/files-backend.c  | 196 +++++++++++++++++++++++++++++++++---------
 refs/packed-backend.c |  15 ++--
 refs/refs-internal.h  |  32 ++++---
 t/t3200-branch.sh     |  21 +++++
 9 files changed, 266 insertions(+), 196 deletions(-)

Range-diff against v9:
1:  b7063c5af89 = 1:  f06b054e861 refs file backend: move raceproof_create_file() here
2:  5a63b64f53f = 2:  ba0f5f5fb0a refs: remove EINVAL errno output from specification of read_raw_ref_fn
3:  0dd8a4c1209 ! 3:  2c4c30e8e06 refs/files-backend: stop setting errno from lock_ref_oid_basic
    @@ refs/files-backend.c: static int create_reflock(const char *path, void *cb)
     - * On failure errno is set to something meaningful.
       */
      static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 					   const char *refname,
    + 					   const char *refname, int *type,
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
      {
      	struct strbuf ref_file = STRBUF_INIT;
4:  c54fb99714a ! 4:  05f3a346e3b refs: make errno output explicit for read_raw_ref_fn
    @@ refs/debug.c: debug_ref_iterator_begin(struct ref_store *ref_store, const char *
      {
      	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      	int res = 0;
    -@@ refs/debug.c: static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 
      	oidcpy(oid, null_oid());
    - 	errno = 0;
    +-	errno = 0;
      	res = drefs->refs->be->read_raw_ref(drefs->refs, refname, oid, referent,
     -					    type);
     +					    type, failure_errno);
      
      	if (res == 0) {
      		trace_printf_key(&trace_refs, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
    +@@ refs/debug.c: static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
    + 	} else {
    + 		trace_printf_key(&trace_refs,
    + 				 "read_raw_ref: %s: %d (errno %d)\n", refname,
    +-				 res, errno);
    ++				 res, *failure_errno);
    + 	}
    + 	return res;
    + }
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
5:  18825efce7d = 5:  fa9260f25fa refs: add failure_errno to refs_read_raw_ref() signature
-:  ----------- > 6:  6dae8b643ad branch tests: test for errno propagating on failing read
6:  57e3f246f4f ! 7:  18bf4a0e97c refs: explicitly return failure_errno from parse_loose_ref_contents
    @@ refs/files-backend.c: static int files_read_raw_ref(struct ref_store *ref_store,
      	strbuf_reset(&sb_contents);
      	if (strbuf_read(&sb_contents, fd, 256) < 0) {
     -		int save_errno = errno;
    ++		myerr = errno;
      		close(fd);
     -		errno = save_errno;
      		goto out;
    @@ refs/refs-internal.h: struct ref_store {
      
      /*
       * Fill in the generic part of refs and add it to our collection of
    +
    + ## t/t3200-branch.sh ##
    +@@ t/t3200-branch.sh: test_expect_success SYMLINKS 'git branch -m with symlinked .git/refs' '
    + 	) &&
    + 	git --git-dir subdir/.git/ branch rename-src &&
    + 	git rev-parse rename-src >expect &&
    ++	# Tests a BUG() assertion in files_read_raw_ref()
    + 	git --git-dir subdir/.git/ branch -m rename-src rename-dest &&
    + 	git rev-parse rename-dest >actual &&
    + 	test_cmp expect actual &&
7:  4b5e168b978 = 8:  7d94a32af83 refs: make errno output explicit for refs_resolve_ref_unsafe
-- 
2.33.0.662.g438caf9576d

