Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8836BC433ED
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:31:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5162061042
	for <git@archiver.kernel.org>; Fri, 23 Apr 2021 15:31:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231591AbhDWPc1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 23 Apr 2021 11:32:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbhDWPc0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 23 Apr 2021 11:32:26 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEE7EC061574
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:31:49 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o21-20020a1c4d150000b029012e52898006so1467496wmh.0
        for <git@vger.kernel.org>; Fri, 23 Apr 2021 08:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=BaZnimPkczXBVq6N45hEWx2xifFvSl48Pyf4dZ07eok=;
        b=VjKKvB9gvMQlDUCpRmGlNC9/iGl77zWKRPbchWGWThSGicjAqzw6Fp70FG4Lg8mnJA
         i3AHxzCUmzP1hEJ4aIOiYdPcUs4TGH9+GixKyYH1KIiuGCf16+0TjDZbocHkQAkxfpga
         9Rtb/OViM671cuZxKNwR8EPyc7sBgdgqCP6ohwSHzCwFwLWjTP5DPVAaMPb60Jvtql7A
         vFaCejmzAaF6Nhr0yMhUiNKM/NurhX1E/badaW7b9UnjWQoexKOioXgJGwqfDO/0dVyL
         OzXZ7CSqRCEbJtdWgcS0LGwx7FLufExL/dlP4gPtw1PLInXPkUTdb3aZEiAlTELg4wrc
         ggoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=BaZnimPkczXBVq6N45hEWx2xifFvSl48Pyf4dZ07eok=;
        b=OocEM4LeTioVXZ0mxfiCRr/+bIuKWp15PzAsXCZ6fZnqZoFjCiZ1z0oHmOU9/TW5uu
         ooxtmyGv4m2rF9+Iva+mpsKZ6qXvAb5rqC2KpEHwMJQ6Jh2hXhk7oMOiq/b/wnitZE1v
         khE1gRap3/7sj51ssxsY0M88wQmS1iHHF2AbKbhK0nYawb054sbl7C3an1wPaZabwmpy
         6SW2/sERf8+yA1ox6W1ETtzpKPNABFjasJRuIEcattxe4kDwLABzAy9pG7fCia2L7HHV
         2GsZgsif1B7mQDNmAKvgCDA7v+ZONNwT9KHodtmj7QpTsrTK5bFQ0C7Ykfv4mkm2vp/R
         mdMw==
X-Gm-Message-State: AOAM531XkLkJVZ++F3b5mKHcTeHQmMH/WtcFXTEUeUW+pF9ihE9VP+hB
        6fCSRverdxlF8nmm/nDu4n8/LotGWQ0=
X-Google-Smtp-Source: ABdhPJzfjKBW/6+mg9Ax9DzQE6pnN1yqByGU+LW06DmWpnFQbCOLCNWlRDJ5hDrh4gCbWplonhB5RQ==
X-Received: by 2002:a1c:23d0:: with SMTP id j199mr6279481wmj.74.1619191908703;
        Fri, 23 Apr 2021 08:31:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f7sm9834513wrp.48.2021.04.23.08.31.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Apr 2021 08:31:48 -0700 (PDT)
Message-Id: <pull.1011.v2.git.git.1619191907.gitgitgadget@gmail.com>
In-Reply-To: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
References: <pull.1011.git.git.1619173446857.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 23 Apr 2021 15:31:44 +0000
Subject: [PATCH v2 0/3] refs: cleanup errno sideband ref related functions.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

v2:

 * peff's feedback. For now, leave refs.c alone; instead cleanups in
   files-backend and the ref backend API.

Han-Wen Nienhuys (3):
  refs: remove EINVAL specification from the errno sideband in
    read_raw_ref_fn
  refs/files-backend: stop setting errno from lock_ref_oid_basic
  refs: make errno output explicit for read_raw_ref_fn

 refs.c                |  7 +++++--
 refs/debug.c          |  4 ++--
 refs/files-backend.c  | 26 +++++++++-----------------
 refs/packed-backend.c |  5 +++--
 refs/refs-internal.h  | 14 ++++++++------
 5 files changed, 27 insertions(+), 29 deletions(-)


base-commit: 311531c9de557d25ac087c1637818bd2aad6eb3a
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1011%2Fhanwen%2Feinval-sideband-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1011/hanwen/einval-sideband-v2
Pull-Request: https://github.com/git/git/pull/1011

Range-diff vs v1:

 1:  ed080f6a9c40 ! 1:  7e8181e77d40 refs: remove EINVAL specification from the errno sideband in read_raw_ref_fn
     @@ Commit message
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## refs.c ##
     -@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     - 	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
     - 		if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
     - 		    !refname_is_safe(refname)) {
     --			errno = EINVAL;
     - 			return NULL;
     - 		}
     - 
     -@@ refs.c: const char *refs_resolve_ref_unsafe(struct ref_store *refs,
     - 		if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
     - 			if (!(resolve_flags & RESOLVE_REF_ALLOW_BAD_NAME) ||
     - 			    !refname_is_safe(refname)) {
     --				errno = EINVAL;
     - 				return NULL;
     - 			}
     - 
     -
       ## refs/refs-internal.h ##
      @@ refs/refs-internal.h: typedef int reflog_expire_fn(struct ref_store *ref_store,
        * properly-formatted or even safe reference name. NEITHER INPUT NOR
 -:  ------------ > 2:  db5da7d7fb51 refs/files-backend: stop setting errno from lock_ref_oid_basic
 -:  ------------ > 3:  7fbc1c754f43 refs: make errno output explicit for read_raw_ref_fn

-- 
gitgitgadget
