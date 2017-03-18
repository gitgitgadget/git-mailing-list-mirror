Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id EDD5B20323
	for <e@80x24.org>; Sat, 18 Mar 2017 11:10:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751438AbdCRLK0 (ORCPT <rfc822;e@80x24.org>);
        Sat, 18 Mar 2017 07:10:26 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:36630 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750990AbdCRLKZ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2017 07:10:25 -0400
Received: by mail-pf0-f193.google.com with SMTP id r137so7580849pfr.3
        for <git@vger.kernel.org>; Sat, 18 Mar 2017 04:08:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s3+dO7OAZBujhjV1IO7FtKdEWJKbUW4Ru9C9AQ+p9n4=;
        b=DtzBZJW75sgqYargxIslvLOwl2wchm2ch6Mkjb+HnI7YX9FNU6e2f+et2Yjvg1IrqB
         sfb9V/WNgzpjGCWyq4vA+JfElQtuZRWpDqtZdXMiGLuNhADgIxMkKaX5eIWp6anATLM5
         4+abWaJATlnwHzMEOv+UGnk38RrMSYa8/UfdU+gksKzR6SkXTc5jsoFEu51rERTHZt0A
         Rskv8XZtrg7ubnM9SVr05dE4jaREoDctWWjLpVlpD/QF2HunMrUf3AW6KegYYX4p6+JN
         /nVCs1YFKvypcGRXnWR70w6jBItwC54a4ElHN7LCIw8gZsb4SSiuqj7kuMYnIIahpxGF
         F8wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s3+dO7OAZBujhjV1IO7FtKdEWJKbUW4Ru9C9AQ+p9n4=;
        b=r9DCFwTa5eCkTYDOPvTSUCjyk4C6H+j0XbcumoVuCwIb1jJr+xMe8qKaw9HsLDJo+J
         tOCL3IKqW34spskow3l/JIR6BDY7Cp1ICUDGwm9YPSOYyx9IUxBkr/azot+U6NJoQKSM
         fd/DloKdGgaxk4nHs/M0dQyXfbjNoXNgKBzoOWOHfc2x22sa1W9a/Ie0EsOuPvrknxm6
         z95npai2wIiMgbM0z+2LXmoB91kd//X/jR+Qk02hQIQQd0z4mrzVYpl5CFQc6sWxRABX
         9Xfa0z6MvkYhPNHws93jUqCYsAGscOsmZvCTo9E7G/xDIAuGJCBSDv/hkeOTom7Fr3Yy
         rm+w==
X-Gm-Message-State: AFeK/H3JPu9O2llOzq2D9bB9GJpA+DQpU7h2iSP3h/G0KiIEwTr6uOr0fyN0Fi3g27MGxw==
X-Received: by 10.84.233.200 with SMTP id m8mr25845509pln.92.1489831349424;
        Sat, 18 Mar 2017 03:02:29 -0700 (PDT)
Received: from ash ([115.72.187.186])
        by smtp.gmail.com with ESMTPSA id c1sm21730440pfk.112.2017.03.18.03.02.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 18 Mar 2017 03:02:28 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Sat, 18 Mar 2017 17:02:24 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <sbeller@google.com>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v3 2/4] refs: introduce get_worktree_ref_store()
Date:   Sat, 18 Mar 2017 17:02:04 +0700
Message-Id: <20170318100206.5980-3-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170318100206.5980-1-pclouds@gmail.com>
References: <20170216120302.5302-1-pclouds@gmail.com>
 <20170318100206.5980-1-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

files-backend at this point is still aware of the per-repo/worktree
separation in refs, so it can handle a linked worktree.

Some refs operations are known not working when current files-backend is
used in a linked worktree (e.g. reflog). Tests will be written when
refs_* functions start to be called with worktree backend to verify that
they work as expected.

Note: accessing a worktree of a submodule remains unaddressed. Perhaps
after get_worktrees() can access submodule (or rather a new function
get_submodule_worktrees(), that lists worktrees of a submodule), we can
update this function to work with submodules as well.
---
 refs.c | 32 ++++++++++++++++++++++++++++++++
 refs.h |  2 ++
 2 files changed, 34 insertions(+)

diff --git a/refs.c b/refs.c
index 77a39f8b17..6695140cfe 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,7 @@
 #include "object.h"
 #include "tag.h"
 #include "submodule.h"
+#include "worktree.h"
 
 /*
  * List of all available backends
@@ -1593,6 +1594,37 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	return refs;
 }
 
+struct ref_store *get_worktree_ref_store(const struct worktree *wt)
+{
+	struct ref_store *refs;
+	unsigned int refs_all_capabilities =
+		REF_STORE_READ | REF_STORE_WRITE |
+		REF_STORE_ODB | REF_STORE_MAIN;
+
+	if (wt->is_current)
+		return get_main_ref_store();
+
+	/*
+	 * We share the same hash map with submodules for
+	 * now. submodule paths are always relative (to topdir) while
+	 * worktree paths are always absolute. No chance of conflict.
+	 */
+	refs = lookup_submodule_ref_store(wt->path);
+	if (refs)
+		return refs;
+
+	if (wt->id)
+		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
+				      refs_all_capabilities);
+	else
+		refs = ref_store_init(get_git_common_dir(),
+				      refs_all_capabilities);
+
+	if (refs)
+		register_submodule_ref_store(refs, wt->path);
+	return refs;
+}
+
 void base_ref_store_init(struct ref_store *refs,
 			 const struct ref_storage_be *be)
 {
diff --git a/refs.h b/refs.h
index 49e97d7d5f..6df69a2adb 100644
--- a/refs.h
+++ b/refs.h
@@ -5,6 +5,7 @@ struct object_id;
 struct ref_store;
 struct strbuf;
 struct string_list;
+struct worktree;
 
 /*
  * Resolve a reference, recursively following symbolic refererences.
@@ -655,5 +656,6 @@ struct ref_store *get_main_ref_store(void);
  * submodule==NULL.
  */
 struct ref_store *get_submodule_ref_store(const char *submodule);
+struct ref_store *get_worktree_ref_store(const struct worktree *wt);
 
 #endif /* REFS_H */
-- 
2.11.0.157.gd943d85

