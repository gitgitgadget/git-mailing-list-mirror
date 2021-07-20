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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E4F1C07E95
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 358F66101E
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:34:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236729AbhGTJxa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:53:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237751AbhGTJw5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:52:57 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9391EC061574
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:34 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id u5-20020a7bc0450000b02901480e40338bso1299777wmc.1
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:33:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iJZnmZCHahoyFAuZEUVO/s306nUaKYNSTmZKHCJfeUg=;
        b=WaFfrY/pAakU7bQLBVwaAvLdw4E2eZbXux3AiI99lTeR2e6cULxkqaH2SYc1OoCFFP
         ZS24zQ+DaLjAN8BgvaO92XSLjiV3+BAkLeDe+pG49K6D5QqRuPsLnNSua0MRi9tsHBNf
         arLijm74hSVCSqAf0fKJpJ+aNtQNNhyuUPPzdVUgo2BH32MsUsL+omlSlyNduYXmN5sZ
         xAllp/D4AA0iANbHc3E/M5u6+pkdjaoz+U189WnA+ZAGPSW01Yja2bwK9uUWUxwQD7zq
         1esziB3dtnPRDwcSk3VMt/9IFFmspp3+1Cmw7sVS2q/p7lrzzfzpzBSZGGYnuP2I+N1R
         xUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iJZnmZCHahoyFAuZEUVO/s306nUaKYNSTmZKHCJfeUg=;
        b=dGchph4R+zxTuaE5PnpVmvGnZCfCXdaPPWrq8rlIZF1mOD8mUdRNASbDtdzVarYUcZ
         aXiW2WAPOBPv/3YUW3PZ7n4uc637bdOr8NuRd7l8OmdmiIbP3JF42YJLEhqJ7zvtxjHD
         z/yONgDAiNLlICFAcdYjG1/nDmauQds5/lAfUAg2p6LOaDmZc0zrwgCHYQ3Fujw8Q4dQ
         yk3WB8i2gP1TSgcrTWoPATmSDuoMYjgfg9nodxcSaq+wi5sqQHGKEOz1GbTDLTVJl7cH
         8JItDvCRDz6GOLXdcqaui8BdyLnZzxzy/rx13oI9dyjsWZEM+V6boTIGf4wzWTJUXkJD
         3k3Q==
X-Gm-Message-State: AOAM5320LvJcNnmLxS4wduh6K47PFk2exzz5QAIKDpPUWS5P0D5RTYpv
        Cjnj0wYsfSntU+5qqHMW8HqJj42N2ukcTw==
X-Google-Smtp-Source: ABdhPJyQrhKq3KKd92XFLlFu38EHDmKDQaL3ThcHMe+k+IyUKrF9RqioVuF9Ws6uwjb8n9vRj4Yz4A==
X-Received: by 2002:a1c:7c17:: with SMTP id x23mr35963422wmc.43.1626777212889;
        Tue, 20 Jul 2021 03:33:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l14sm22179852wrs.22.2021.07.20.03.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:33:32 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v9 0/7] refs: cleanup errno sideband ref related functions
Date:   Tue, 20 Jul 2021 12:33:23 +0200
Message-Id: <cover-0.7-00000000000-20210720T102644Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
References: <cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

A v9 re-roll of the v8, see
https://lore.kernel.org/git/cover-0.7-00000000000-20210716T142032Z-avarab@gmail.com/
and more imporantly the real summary of what this is in v7 at
https://lore.kernel.org/git/cover-0.6-0000000000-20210714T114301Z-avarab@gmail.com/

As noted there this topic builds on my just-re-rolled v3 removing of
dead code + fixing a gc race in the refs API, at:
https://lore.kernel.org/git/cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com/

The changes in this v8 are merely to re-roll on top of that. There was
a stray comment that didn't apply anymore with its new 12th patch. I
also removed the "in case of D/F conflict..." comment the 3rd patch
previously added, with the changes in the base topic I think this
codepath has become easily understood enough to not need an new
comment anymore (the initial version was more complex, see
https://lore.kernel.org/git/95025080c16f535599826ed4f013845d712b0e8d.1625684869.git.gitgitgadget@gmail.com/).

Han-Wen Nienhuys (6):
  refs: remove EINVAL errno output from specification of read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn
  refs: add failure_errno to refs_read_raw_ref() signature
  refs: explicitly return failure_errno from parse_loose_ref_contents
  refs: make errno output explicit for refs_resolve_ref_unsafe

Ævar Arnfjörð Bjarmason (1):
  refs file backend: move raceproof_create_file() here

 cache.h               |  43 ----------
 object-file.c         |  68 ---------------
 refs.c                |  69 ++++++++++-----
 refs.h                |  11 +++
 refs/debug.c          |   4 +-
 refs/files-backend.c  | 195 +++++++++++++++++++++++++++++++++---------
 refs/packed-backend.c |  15 ++--
 refs/refs-internal.h  |  32 ++++---
 8 files changed, 243 insertions(+), 194 deletions(-)

Range-diff against v8:
1:  ce1ca2cf30f = 1:  b7063c5af89 refs file backend: move raceproof_create_file() here
2:  2a69bbea821 = 2:  5a63b64f53f refs: remove EINVAL errno output from specification of read_raw_ref_fn
3:  a3f80c6d2f7 ! 3:  0dd8a4c1209 refs/files-backend: stop setting errno from lock_ref_oid_basic
    @@ Commit message
         refs_reflog_exists() (which calls a function in a vtable that is not
         documented to use and/or preserve errno)
     
    -    In the case of the "errno != ENOTDIR" case that originates in 5b2d8d6f218
    -    (lock_ref_sha1_basic(): improve diagnostics for ref D/F conflicts,
    -    2015-05-11), there the "last_errno" was saved away to return it from
    -    lock_ref_oid_basic(), now that we're no longer doing that we can skip
    -    that entirely and use "errno" directly. A follow-up change will
    -    extract the specific errno we want earlier in this function.
    -
         Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
      	files_assert_main_repository(refs, "lock_ref_oid_basic");
      	assert(err);
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
    - 	files_ref_path(refs, &ref_file, refname);
      	if (!refs_resolve_ref_unsafe(&refs->base, refname,
      				     RESOLVE_REF_NO_RECURSE,
    --				     &lock->old_oid, type)) {
    + 				     &lock->old_oid, type)) {
     -		last_errno = errno;
    --		if (last_errno != ENOTDIR ||
    --		    !refs_verify_refname_available(&refs->base, refname,
    --						   NULL, NULL, err))
    --			strbuf_addf(err, "unable to resolve reference '%s': %s",
    + 		if (!refs_verify_refname_available(&refs->base, refname,
    + 						   NULL, NULL, err))
    + 			strbuf_addf(err, "unable to resolve reference '%s': %s",
     -				    refname, strerror(last_errno));
    --
    -+				     &lock->old_oid, type) &&
    -+	    (errno != ENOTDIR ||
    -+	     /* in case of D/F conflict, try to generate a better error
    -+	      * message. If that fails, fall back to strerror(ENOTDIR).
    -+	      */
    -+	     !refs_verify_refname_available(&refs->base, refname, NULL,
    -+					    NULL, err))) {
    -+		strbuf_addf(err, "unable to resolve reference '%s': %s",
    -+			    refname, strerror(errno));
    ++				    refname, strerror(errno));
    + 
      		goto error_return;
      	}
    - 
     @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
      	 */
      	if (is_null_oid(&lock->old_oid) &&
4:  147058c8c3d = 4:  c54fb99714a refs: make errno output explicit for read_raw_ref_fn
5:  b42a7474f18 = 5:  18825efce7d refs: add failure_errno to refs_read_raw_ref() signature
6:  93b770c8bea = 6:  57e3f246f4f refs: explicitly return failure_errno from parse_loose_ref_contents
7:  cb32b5c0526 ! 7:  4b5e168b978 refs: make errno output explicit for refs_resolve_ref_unsafe
    @@ refs/files-backend.c: static struct ref_lock *lock_ref_oid_basic(struct files_re
      	files_ref_path(refs, &ref_file, refname);
     -	if (!refs_resolve_ref_unsafe(&refs->base, refname,
     -				     RESOLVE_REF_NO_RECURSE,
    --				     &lock->old_oid, type) &&
    --	    (errno != ENOTDIR ||
    +-				     &lock->old_oid, type)) {
     +	if (!refs_resolve_ref_unsafe_with_errno(&refs->base, refname,
     +						RESOLVE_REF_NO_RECURSE,
     +						&lock->old_oid, type,
    -+						&resolve_errno) &&
    -+	    (resolve_errno != ENOTDIR ||
    - 	     /* in case of D/F conflict, try to generate a better error
    - 	      * message. If that fails, fall back to strerror(ENOTDIR).
    - 	      */
    - 	     !refs_verify_refname_available(&refs->base, refname, NULL,
    - 					    NULL, err))) {
    - 		strbuf_addf(err, "unable to resolve reference '%s': %s",
    --			    refname, strerror(errno));
    -+			    refname, strerror(resolve_errno));
    ++						&resolve_errno)) {
    + 		if (!refs_verify_refname_available(&refs->base, refname,
    + 						   NULL, NULL, err))
    + 			strbuf_addf(err, "unable to resolve reference '%s': %s",
    +-				    refname, strerror(errno));
    ++				    refname, strerror(resolve_errno));
    + 
      		goto error_return;
      	}
    - 
-- 
2.32.0.874.ge7a9d58bfcf

