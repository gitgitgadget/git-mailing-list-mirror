Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65E12C07E95
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A0FE613F5
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:22:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233060AbhGPOZi (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232775AbhGPOZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:25:34 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9346BC06175F
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:36 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id q18-20020a1ce9120000b02901f259f3a250so5969787wmc.2
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:22:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PQl6TN2MVirajVcHP0DURifMTcrDOOGxpQrM3C5sJ/I=;
        b=pGP5alXjaVneT2Y6n6k3qT8qD6IbFf3p2UWlEOd6AcUjXndrLHL/BtOtW3ZOMIKVj6
         +bjMUgG0j0mHWrLR1kzz+bwMUn0BOxdsyiP2OxiHafYncf2uTZfH0SWdKAQSn8ISg8H7
         bVE03Ds8ROKiIVQVLBuJjtJFmQjqu89FY2tQaVe0dJYnVFSoBf7/nl29iKQKa8jof5S/
         MaRaEBH8aIB1FgmjpczmGINT7q7DURgxuMlwIVsg1ISsrTo3SfXIUC2hAqm1XvLcEjlg
         yMwtTyaqn2zqUjrcHo8Ycjb25dKC7BfCL5flt5S/9cCou4s0zs99SKmizIaVzKiPO1k9
         58EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PQl6TN2MVirajVcHP0DURifMTcrDOOGxpQrM3C5sJ/I=;
        b=XXdnsWNwKbGEcwhBxLm9aaxhMkSDOm+jSIpU/xr3JaA41HUzHGF+KpQVzaPs4UxggK
         V7XmH7mzUbKd2PU6XdWC0+78OKF9cEpp53kFAR46Y9wftlk1ZIu6L9f8gV4YOyz9KKo9
         SjXGwb2RMa0hYIk91jQC2lc4QNAq5Tw6azEhjQPR0U8FAuMrsHmSw5HxtszZyBtdwoVS
         C/y5JTpvy70LHSkdw2fGYfsQSZDQX5KfwY8A3TlKPrhc6pUdwu6alpUMSRQwIvdmoFIq
         gi+f5zNjaQohDfMUxjQQzMJ76eSNcM6VXGZMa4svNFo4qXWA2XzPlpos7DhhyJ6LVbbM
         qXNQ==
X-Gm-Message-State: AOAM530zxfQLjzramKv9qA/tyYHMVR0emiOOKZixkQTESgGxe1v5e8bN
        uMmseH5sMaqwRRzocYjB5rRTRDUSBF4PWg==
X-Google-Smtp-Source: ABdhPJzZiXLpVil1vzo1BPI8yQNYbhOS0pzPi4Y1KVZw50sKZla706alDN0Tv5epOZgC2O6Ho6JJlw==
X-Received: by 2002:a05:600c:2255:: with SMTP id a21mr10931623wmm.90.1626445354866;
        Fri, 16 Jul 2021 07:22:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z7sm7463236wmp.34.2021.07.16.07.22.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:22:34 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v8 0/7] refs: cleanup errno sideband ref related functions
Date:   Fri, 16 Jul 2021 16:22:25 +0200
Message-Id: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
References: <cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v8 re-roll of v7 of this, covered in detail at:
https://lore.kernel.org/git/cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com/

This topic relies on the now-re-rolled and bigger dependency topic to
cleanup the use of the reflog API, which is 1/4 callers (and the
complex one) that need an API being simplified here, see
https://lore.kernel.org/git/cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com

Han-Wen Nienhuys (6):
  refs: remove EINVAL errno output from specification of read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn
  refs: add failure_errno to refs_read_raw_ref() signature
  refs: explicitly return failure_errno from parse_loose_ref_contents
  refs: make errno output explicit for refs_resolve_ref_unsafe

Ævar Arnfjörð Bjarmason (1):
  refs file backend: move raceproof_create_file() here

 cache.h               |  43 ---------
 object-file.c         |  68 --------------
 refs.c                |  69 +++++++++-----
 refs.h                |  11 +++
 refs/debug.c          |   4 +-
 refs/files-backend.c  | 207 +++++++++++++++++++++++++++++++++---------
 refs/packed-backend.c |  15 +--
 refs/refs-internal.h  |  32 ++++---
 8 files changed, 250 insertions(+), 199 deletions(-)

Range-diff against v7:
-:  ----------- > 1:  ce1ca2cf30f refs file backend: move raceproof_create_file() here
1:  4beba4443ab = 2:  2a69bbea821 refs: remove EINVAL errno output from specification of read_raw_ref_fn
2:  fd8e3561851 ! 3:  a3f80c6d2f7 refs/files-backend: stop setting errno from lock_ref_oid_basic
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
      	struct strbuf ref_file = STRBUF_INIT;
      	struct ref_lock *lock;
     -	int last_errno = 0;
    - 	int mustexist = (old_oid && !is_null_oid(old_oid));
    - 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
    - 	int resolved;
    + 
    + 	files_assert_main_repository(refs, "lock_ref_oid_basic");
    + 	assert(err);
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
    - 					     refname, resolve_flags,
    - 					     &lock->old_oid, type);
    --	if (!resolved) {
    + 	files_ref_path(refs, &ref_file, refname);
    + 	if (!refs_resolve_ref_unsafe(&refs->base, refname,
    + 				     RESOLVE_REF_NO_RECURSE,
    +-				     &lock->old_oid, type)) {
     -		last_errno = errno;
     -		if (last_errno != ENOTDIR ||
     -		    !refs_verify_refname_available(&refs->base, refname,
    --						   extras, skip, err))
    +-						   NULL, NULL, err))
     -			strbuf_addf(err, "unable to resolve reference '%s': %s",
     -				    refname, strerror(last_errno));
    -+	if (!resolved &&
    +-
    ++				     &lock->old_oid, type) &&
     +	    (errno != ENOTDIR ||
     +	     /* in case of D/F conflict, try to generate a better error
     +	      * message. If that fails, fall back to strerror(ENOTDIR).
     +	      */
    -+	     !refs_verify_refname_available(&refs->base, refname, extras,
    -+					    skip, err))) {
    ++	     !refs_verify_refname_available(&refs->base, refname, NULL,
    ++					    NULL, err))) {
     +		strbuf_addf(err, "unable to resolve reference '%s': %s",
     +			    refname, strerror(errno));
    - 
      		goto error_return;
      	}
    + 
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    + 	 */
      	if (is_null_oid(&lock->old_oid) &&
      	    refs_verify_refname_available(refs->packed_ref_store, refname,
    - 					  extras, skip, err)) {
    +-					  NULL, NULL, err)) {
     -		last_errno = ENOTDIR;
    ++					  NULL, NULL, err))
      		goto error_return;
    - 	}
    +-	}
      
      	lock->ref_name = xstrdup(refname);
      
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
      		unable_to_lock_message(ref_file.buf, errno, err);
      		goto error_return;
      	}
    - 
    - 	if (verify_lock(&refs->base, lock, old_oid, mustexist, err)) {
    --		last_errno = errno;
    - 		goto error_return;
    - 	}
    - 	goto out;
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
      
       out:
3:  913e72e9ffd = 4:  147058c8c3d refs: make errno output explicit for read_raw_ref_fn
4:  dd191768f66 = 5:  b42a7474f18 refs: add failure_errno to refs_read_raw_ref() signature
5:  77c53dc0d93 = 6:  93b770c8bea refs: explicitly return failure_errno from parse_loose_ref_contents
6:  5d4b1b4ddff ! 7:  cb32b5c0526 refs: make errno output explicit for refs_resolve_ref_unsafe
    @@ refs.h: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     
      ## refs/files-backend.c ##
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 	int mustexist = (old_oid && !is_null_oid(old_oid));
    - 	int resolve_flags = RESOLVE_REF_NO_RECURSE;
    - 	int resolved;
    + {
    + 	struct strbuf ref_file = STRBUF_INIT;
    + 	struct ref_lock *lock;
     +	int resolve_errno = 0;
      
      	files_assert_main_repository(refs, "lock_ref_oid_basic");
      	assert(err);
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 		resolve_flags |= RESOLVE_REF_ALLOW_BAD_NAME;
    + 	CALLOC_ARRAY(lock, 1);
      
      	files_ref_path(refs, &ref_file, refname);
    --	resolved = !!refs_resolve_ref_unsafe(&refs->base,
    --					     refname, resolve_flags,
    --					     &lock->old_oid, type);
    -+	resolved = !!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
    -+							resolve_flags,
    -+							&lock->old_oid, type,
    -+							&resolve_errno);
    - 	if (!resolved &&
    +-	if (!refs_resolve_ref_unsafe(&refs->base, refname,
    +-				     RESOLVE_REF_NO_RECURSE,
    +-				     &lock->old_oid, type) &&
     -	    (errno != ENOTDIR ||
    ++	if (!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
    ++						RESOLVE_REF_NO_RECURSE,
    ++						&lock->old_oid, type,
    ++						&resolve_errno) &&
     +	    (resolve_errno != ENOTDIR ||
      	     /* in case of D/F conflict, try to generate a better error
      	      * message. If that fails, fall back to strerror(ENOTDIR).
      	      */
    - 	     !refs_verify_refname_available(&refs->base, refname, extras,
    - 					    skip, err))) {
    + 	     !refs_verify_refname_available(&refs->base, refname, NULL,
    + 					    NULL, err))) {
      		strbuf_addf(err, "unable to resolve reference '%s': %s",
     -			    refname, strerror(errno));
    --
     +			    refname, strerror(resolve_errno));
      		goto error_return;
      	}
-- 
2.32.0.874.gfa1990a4f10

