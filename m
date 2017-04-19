Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B116C1FA26
	for <e@80x24.org>; Wed, 19 Apr 2017 11:02:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1762461AbdDSLCC (ORCPT <rfc822;e@80x24.org>);
        Wed, 19 Apr 2017 07:02:02 -0400
Received: from mail-pg0-f65.google.com ([74.125.83.65]:33133 "EHLO
        mail-pg0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762438AbdDSLCA (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 Apr 2017 07:02:00 -0400
Received: by mail-pg0-f65.google.com with SMTP id 63so3593590pgh.0
        for <git@vger.kernel.org>; Wed, 19 Apr 2017 04:02:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VymVSrJYLo5mBnkWfkwOnOfHLn6uGRRTgdf+8QAXCs=;
        b=Cm/xPsSuQwQleK3O8RiRsO7bXViAV6nP6Ta9TDF1w2yFQQsVhVNU408S7kw4s1GCWY
         D1/tSxBcZk4MQ6Doe6wDWhPGj717F7jEaxFY6XwzxTLY2U1VsZXAKYupgzbamIieGWZ3
         f1BKZ603MIQa510slYwUGsdQW9z2/QXL+3IOek2UHUqdkXYpCqXwimGBH762LscI15pC
         jNYThvn2CCkeufAy+7T8Dq8deH3Gw0TETrhICsGKER9HswB2ttWfeBQyHMPI8JltDU3M
         SXtvsMpPJLBDGXesPEGWDJmyZM/ngNsGLWjBfn3psCU6mMInxndaGXwsN1bOpjWi5x74
         6lew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4VymVSrJYLo5mBnkWfkwOnOfHLn6uGRRTgdf+8QAXCs=;
        b=hCRpAeJXmDLNtimVkkpkmFPBvdP+y4EBnj7dLoBN9Ys/0ZWnoh3cxeh7rhJbLz33vG
         bDw+1wE7FCBAP4Dd4gi9ffT3su53jGSUzShK5u5CcwDDG0HXzWfS8SpsN2pJxXLvpy1u
         gbK1F5qx3ZyygKCAIrvDVqd1QUg3lru1lYiZRPLl8pvmkx0XUZC3p3Q18IayoJ/e4i3p
         sb0OrQK9UpcOgNEWdid3AvT2etUCymSzNJcDmlRGFIm2B4XcRGS/YJOPwGem/3V4pF+l
         guso8tI98DxkeQ7eKjuDMB3NzeE76urzrVfDz3Z6Z/2m9icawyaWT3hSL7pAUs8ofcVH
         oMig==
X-Gm-Message-State: AN3rC/4yaxXkUJ4Vrr/NI/X4rTaaKFV7cV0WPx3UEQAonYss8pzSiGRY
        p4dVcYCINEojEQ==
X-Received: by 10.98.19.12 with SMTP id b12mr2527698pfj.21.1492599719662;
        Wed, 19 Apr 2017 04:01:59 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id z21sm3973704pfk.95.2017.04.19.04.01.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 19 Apr 2017 04:01:58 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Wed, 19 Apr 2017 18:01:53 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Stefan Beller <sbeller@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 00/12] Fix git-gc losing objects in multi worktree
Date:   Wed, 19 Apr 2017 18:01:33 +0700
Message-Id: <20170419110145.5086-1-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2 [1] is relatively small. It still needs
nd/worktree-kill-parse-ref of course.

[1] http://public-inbox.org/git/20170318101153.6901-1-pclouds@gmail.com/

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentation/technical/api-ref-iteration.txt
index 37379d8337..c9e9a60dbd 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -32,11 +32,8 @@ Iteration functions
 
 * `for_each_glob_ref_in()` the previous and `for_each_ref_in()` combined.
 
-* `head_ref_submodule()`, `for_each_ref_submodule()`,
-  `for_each_ref_in_submodule()`, `for_each_tag_ref_submodule()`,
-  `for_each_branch_ref_submodule()`, `for_each_remote_ref_submodule()`
-  do the same as the functions described above but for a specified
-  submodule.
+* Use `refs_` API for accessing submodules. The submodule ref store could
+  be obtained with `get_submodule_ref_store().
 
 * `for_each_rawref()` can be used to learn about broken ref and symref.
 
diff --git a/refs.c b/refs.c
index c39058adce..23e3607674 100644
--- a/refs.c
+++ b/refs.c
@@ -1208,11 +1208,6 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
-int head_ref_submodule(const char *submodule, each_ref_fn fn, void *cb_data)
-{
-	return refs_head_ref(get_submodule_ref_store(submodule), fn, cb_data);
-}
-
 int head_ref(each_ref_fn fn, void *cb_data)
 {
 	return refs_head_ref(get_main_ref_store(), fn, cb_data);
diff --git a/revision.c b/revision.c
index dc32e99c54..79ce8a007f 100644
--- a/revision.c
+++ b/revision.c
@@ -1336,7 +1336,7 @@ void add_index_objects_to_pending(struct rev_info *revs, unsigned int flags)
 	worktrees = get_worktrees(0);
 	for (p = worktrees; *p; p++) {
 		struct worktree *wt = *p;
-		struct index_state istate = {0};
+		struct index_state istate = { NULL };
 
 		if (wt->is_current)
 			continue; /* current index already taken care of */

Nguyễn Thái Ngọc Duy (12):
  revision.h: new flag in struct rev_info wrt. worktree-related refs
  revision.c: refactor add_index_objects_to_pending()
  revision.c: --indexed-objects add objects from all worktrees
  refs.c: refactor get_submodule_ref_store(), share common free block
  refs: move submodule slash stripping code to get_submodule_ref_store
  refs: add refs_head_ref()
  revision.c: use refs_for_each*() instead of for_each_*_submodule()
  refs: remove dead for_each_*_submodule()
  revision.c: --all adds HEAD from all worktrees
  files-backend: make reflog iterator go through per-worktree reflog
  revision.c: --reflog add HEAD reflog from all worktrees
  rev-list: expose and document --single-worktree

 Documentation/rev-list-options.txt            |   8 ++
 Documentation/technical/api-ref-iteration.txt |   7 +-
 reachable.c                                   |   1 +
 refs.c                                        | 105 ++++++++++-----------
 refs.h                                        |  12 +--
 refs/files-backend.c                          |  46 ++++++---
 revision.c                                    | 130 +++++++++++++++++++++-----
 revision.h                                    |   1 +
 submodule.c                                   |   2 +
 t/t1407-worktree-ref-store.sh                 |  30 ++++++
 t/t5304-prune.sh                              |  37 ++++++++
 11 files changed, 274 insertions(+), 105 deletions(-)

-- 
2.11.0.157.gd943d85

