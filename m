Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1612AC433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:37:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353200AbiALMhQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:37:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240219AbiALMhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:37:13 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36020C06173F
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:37:13 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id e5so1503816wmq.1
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktMb5Te5hceRZIWVXxmNdV404voJzWzR/8UGMqOj59A=;
        b=MUPcQ9Fl3QZrgAdK7wk+/5PKysFvF/PFUe0U5xd/vOT27+PRqE37RSy/m7M87jKRkg
         iWuU+iBAaGMN3ZNz3zCWsM2XgZef9wB29RqkK6T1kXEtZG/yGxsJd3aQ/wQnGpcWoqto
         1yXUePw29rtJksycmKsrhP1iA72nYJv3WnoaldpAvRUWJwvLoqBvJuB4tdEYt1kDXz4K
         dI4RE75QJ2ixXGqKXnPazrMk/DWghgERClfIQJN74LX9JOI/NMDWlxNYsQTDb9yrFwF8
         inbAeZG1u/lCAVjm+lBAPTnONcKKClqo34l3Eo3KyqNTwl7LsdTSt4O+dbTCo73HnjvL
         lBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktMb5Te5hceRZIWVXxmNdV404voJzWzR/8UGMqOj59A=;
        b=pbWH53Y+bloPMMegsGgankJH9hcNL6RNduIEzonEI9FU6OcFFOkKxVo3Qa95Nf9+Ac
         0BJtFeIOr7Y5VIg6IoRlw5QrSaVc57Sj6PKZUxml3FwmrhTI+TwY8OgRGOupvZe9bIM0
         Mo8grvA3SytVXp7yrbSz8CDE6zSogxYayam+fdzyQCbs3MOBHeuSLELe1bemcE5z1fJ+
         fv5VlLlQ6MpaVvkpuNyQWdfGDnVpDFEhB63Z9AqeIEv5FZHpylNChNVFxCtcd/sPPq/U
         ChzyDDcTXJqcvU2F5InCiWUUrhfoHPjpl0NcoraX1Epzl7XjY8PVCdhy6SVTK1+m6V5/
         rpHw==
X-Gm-Message-State: AOAM530FtGRiInaADm6+WsA9B+CbWSYaQaQ+wrpXyaXZQNQUrlvKv18O
        oJru272IMKiElSKcE4bM6HteoE4Oax+SvA==
X-Google-Smtp-Source: ABdhPJx3bna4WCZlNryRQc1aY5WyezH6iPAzGhsEQcdOj+XUcXw9rlFbU1e9k1oTKznVvl/a1kWNQQ==
X-Received: by 2002:a7b:c007:: with SMTP id c7mr6698956wmb.27.1641991031342;
        Wed, 12 Jan 2022 04:37:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3sm2919137wma.12.2022.01.12.04.37.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:37:10 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] For v2.35.0: refs: ab/refs-errno-cleanup fixup + remove "failure_errno"
Date:   Wed, 12 Jan 2022 13:36:45 +0100
Message-Id: <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a follow-up to the recently landed ab/refs-errno-cleanup
topic, I missed a spot and left some meaningless use of "errno" in the
refs (file) backend.

Per the $subject I hope we can get this into v2.35.0. I submitted a
v1[1] and v2[2] of this around the holidays so I think it may have
fallen through the cracks.

1. https://lore.kernel.org/git/cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com/
2. https://lore.kernel.org/git/cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com/

Ævar Arnfjörð Bjarmason (3):
  refs API: use "failure_errno", not "errno"
  sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
  refs API: remove "failure_errno" from refs_resolve_ref_unsafe()

 refs.c                    | 53 +++++++++++++--------------------------
 refs.h                    |  7 +-----
 refs/files-backend.c      | 34 ++++++++-----------------
 remote.c                  |  3 +--
 sequencer.c               | 10 +++-----
 t/helper/test-ref-store.c |  3 +--
 worktree.c                | 11 +++-----
 7 files changed, 36 insertions(+), 85 deletions(-)

Range-diff against v2:
1:  161fcad1578 = 1:  a45268ac24b refs API: use "failure_errno", not "errno"
2:  12d453d3884 = 2:  8d8691a5e93 sequencer: don't use die_errno() on refs_resolve_ref_unsafe() failure
3:  614590b2d10 ! 3:  8f937d8f64a refs API: remove "failure_errno" from refs_resolve_ref_unsafe()
    @@ Commit message
         return value was NULL or not, i.e. if the ref could be resolved.
     
         There was one caller left in sequencer.c that used the
    -    "failure_errnO', but as of the preceding commit it doesn't use that
    -    "failure_errno" either.
    +    "failure_errno', but as of the preceding commit it uses a boilerplate
    +    "ignore_errno" instead.
     
         So let's remove this output parameter. Not only isn't it used now, but
    -    we'd like to slowly move the refs API to a more file-backend
    -    independent way of communicating error codes, having it use a
    -    "failure_errno" was only the first step in that direction. If this or
    -    any other function needs to communicate what specifically is wrong
    -    with the requested "refname" it'll be better to have the function set
    -    some output enum of well-defined error states than piggy-backend on
    -    "errno".
    +    it's unlikely that we'll want it again in the future. We'd like to
    +    slowly move the refs API to a more file-backend independent way of
    +    communicating error codes, having it use a "failure_errno" was only
    +    the first step in that direction. If this or any other function needs
    +    to communicate what specifically is wrong with the requested "refname"
    +    it'll be better to have the function set some output enum of
    +    well-defined error states than piggy-backend on "errno".
     
         Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
    @@ refs/files-backend.c: static int lock_ref_for_update(struct files_ref_store *ref
      						    "error reading reference",
     @@ refs/files-backend.c: static int files_reflog_expire(struct ref_store *ref_store,
      
    - 		if ((flags & EXPIRE_REFLOGS_UPDATE_REF) &&
    + 		if ((expire_flags & EXPIRE_REFLOGS_UPDATE_REF) &&
      		    !is_null_oid(&cb.last_kept_oid)) {
     -			int ignore_errno;
      			int type;
    @@ sequencer.c: void print_commit_summary(struct repository *r,
     
      ## t/helper/test-ref-store.c ##
     @@ t/helper/test-ref-store.c: static int cmd_resolve_ref(struct ref_store *refs, const char **argv)
    - 	int resolve_flags = arg_flags(*argv++, "resolve-flags");
    + 	int resolve_flags = arg_flags(*argv++, "resolve-flags", empty_flags);
      	int flags;
      	const char *ref;
     -	int ignore_errno;
    @@ worktree.c: static void add_head_info(struct worktree *wt)
      	if (!target)
      		return;
      
    -@@ worktree.c: const struct worktree *find_shared_symref(const char *symref,
    +@@ worktree.c: const struct worktree *find_shared_symref(struct worktree **worktrees,
      		const char *symref_target;
      		struct ref_store *refs;
      		int flags;
    @@ worktree.c: const struct worktree *find_shared_symref(const char *symref,
      
      		if (wt->is_bare)
      			continue;
    -@@ worktree.c: const struct worktree *find_shared_symref(const char *symref,
    +@@ worktree.c: const struct worktree *find_shared_symref(struct worktree **worktrees,
      
      		refs = get_worktree_ref_store(wt);
      		symref_target = refs_resolve_ref_unsafe(refs, symref, 0,
-- 
2.35.0.rc0.848.gb9d3879eb1d

