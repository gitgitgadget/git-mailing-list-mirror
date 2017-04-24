Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 07D311FE90
	for <e@80x24.org>; Mon, 24 Apr 2017 10:02:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1166958AbdDXKCN (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Apr 2017 06:02:13 -0400
Received: from mail-it0-f65.google.com ([209.85.214.65]:35029 "EHLO
        mail-it0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1168350AbdDXKCH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Apr 2017 06:02:07 -0400
Received: by mail-it0-f65.google.com with SMTP id e132so15863684ite.2
        for <git@vger.kernel.org>; Mon, 24 Apr 2017 03:02:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=iVT+Z05iGuG59J/aafatocfRdXhkelsWeFreKhvZXaM=;
        b=QJn7ttaGkv+lPH7UWztxVQy/Q0EmF/AX6lFmmMlaYimsGzx/2yVrEt0y70FOqRAu8o
         Rx3Ev6aDzvqt06W9kL/YMyZGh5PTHtQLUcXp/cLg4X4PRC3Wj+vnGOt0hCbmO4PreMPM
         AP+VNmKZmWKLx+VIQT6RVfgfK/z5zXRoj7dwRfExDfqnVazg2yG2Z2hZcc8GYAKSVzLY
         o0CM66uqCUUN8ik3ZyYuAxJcuBtNgUypLq6wpBU9Ae8hmGUIQWo/JOwlNCoy11y0AOw6
         7qq3SXSbwe+4YX68/7xxxapMGIxdcBJ2NsLgQ8X0LA3vmkQFokLSnM6ChTn/XwKKq01i
         COew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iVT+Z05iGuG59J/aafatocfRdXhkelsWeFreKhvZXaM=;
        b=mLjn5ojpfqv5d56mEIacJ4xujwJIKyCnkl8MarrZqswsTKbLLvRv73dVOFASIkvCYO
         yHK2YUX4JXBghKrbjDzK3K/Ii9O7KTZBD0HsMK1L1PxYQnF+yaSOSs7Ef24v4jQp/IFI
         05t38tQsepI9RwElm27d9LcIo4DW9VqxKbCeNYEVpWxo8jmSSJvLG4RgVHZf5Sd93a2k
         ity5v89SpEws0t9xvwfhN6D2I9GhtVZT5E6djp61J6SF4eD2mMtevGANdfFzXSNVDuYU
         CkT4aRnf6mlDqprgQ75N78hpbBCy/YGKAgsAVZ31gd1TYJ5LXJLa0wEZqwbzeJSXwFVk
         5zig==
X-Gm-Message-State: AN3rC/6qwt2EAtxyrnb2Ggmxt2TgFU7J0ZXjjskrfI854OBPwIdMjGb2
        upA7JcPJsRzBTw==
X-Received: by 10.99.114.6 with SMTP id n6mr9588395pgc.175.1493028120919;
        Mon, 24 Apr 2017 03:02:00 -0700 (PDT)
Received: from ash ([115.73.171.114])
        by smtp.gmail.com with ESMTPSA id b128sm3747025pfg.70.2017.04.24.03.01.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Apr 2017 03:02:00 -0700 (PDT)
Received: by ash (sSMTP sendmail emulation); Mon, 24 Apr 2017 17:01:55 +0700
From:   =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
        <pclouds@gmail.com>
Subject: [PATCH v5 4/6] refs: introduce get_worktree_ref_store()
Date:   Mon, 24 Apr 2017 17:01:22 +0700
Message-Id: <20170424100124.24637-5-pclouds@gmail.com>
X-Mailer: git-send-email 2.11.0.157.gd943d85
In-Reply-To: <20170424100124.24637-1-pclouds@gmail.com>
References: <20170404102123.25315-1-pclouds@gmail.com>
 <20170424100124.24637-1-pclouds@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
---
 refs.c | 30 ++++++++++++++++++++++++++++++
 refs.h |  2 ++
 2 files changed, 32 insertions(+)

diff --git a/refs.c b/refs.c
index 6e6f0ec5be..7972720256 100644
--- a/refs.c
+++ b/refs.c
@@ -10,6 +10,7 @@
 #include "object.h"
 #include "tag.h"
 #include "submodule.h"
+#include "worktree.h"
 
 /*
  * List of all available backends
@@ -1486,6 +1487,9 @@ static struct ref_store *main_ref_store;
 /* A hashmap of ref_stores, stored by submodule name: */
 static struct hashmap submodule_ref_stores;
 
+/* A hashmap of ref_stores, stored by worktree id: */
+static struct hashmap worktree_ref_stores;
+
 /*
  * Look up a ref store by name. If that ref_store hasn't been
  * registered yet, return NULL.
@@ -1586,6 +1590,32 @@ struct ref_store *get_submodule_ref_store(const char *submodule)
 	return refs;
 }
 
+struct ref_store *get_worktree_ref_store(const struct worktree *wt)
+{
+	struct ref_store *refs;
+	const char *id;
+
+	if (wt->is_current)
+		return get_main_ref_store();
+
+	id = wt->id ? wt->id : "/";
+	refs = lookup_ref_store_map(&worktree_ref_stores, id);
+	if (refs)
+		return refs;
+
+	if (wt->id)
+		refs = ref_store_init(git_common_path("worktrees/%s", wt->id),
+				      REF_STORE_ALL_CAPS);
+	else
+		refs = ref_store_init(get_git_common_dir(),
+				      REF_STORE_ALL_CAPS);
+
+	if (refs)
+		register_ref_store_map(&worktree_ref_stores, "worktree",
+				       refs, id);
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

