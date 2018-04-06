Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F0D3E1F404
	for <e@80x24.org>; Fri,  6 Apr 2018 23:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752170AbeDFXWK (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Apr 2018 19:22:10 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:45218 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751538AbeDFXWJ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Apr 2018 19:22:09 -0400
Received: by mail-pf0-f195.google.com with SMTP id l27so1785306pfk.12
        for <git@vger.kernel.org>; Fri, 06 Apr 2018 16:22:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=7iaeo75EkV0soC2mUlbAadoSMToRhSG59M1YuajQ6SE=;
        b=ChawWATYRThPrdGudIRanBCoPHcBiC0cTyErjzzM3jw1Z+fc01Qz5G3uwh+aSCjipe
         cZO8Gu/7AK4/+0Ye7Cu+VjhVBi2cI0tbZ4FCkULr963EhFBYSMge/vOU3FO8uti0y0gg
         DUxr6aU9gLHPEhoV5aXkg31R3ouVvFSSlO1HX/g7ndw43C17QYCmYQm2VBVgmwq1DG1b
         tq0GXMJkpLjE4vPAcrU/LLby44qQT5k1jonNXPUvIWhjeuN4djLtXcAoRvKNxO2/CyPF
         s+BnAm0Y04z23Z89hwlJUl8fdx9huFGshT2LshvBtPT2sOcSfHBgimWg5zYUmM+5oOJd
         Vsyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=7iaeo75EkV0soC2mUlbAadoSMToRhSG59M1YuajQ6SE=;
        b=QVOeY8A8jkkvRmVri9IaWHep6nUIfEuosmi3wbNi4jhDVLoIk+oURRdbzJXG1XhsgC
         UnFYEzgPDZqAcVYiOxORGLkARqiE6bQOD065MrrA+fN353QfAtrKTDGLVv+UKkxdzCBd
         +ICtwAaE7QmB9hus4Dy1TF2aLjHsAKTGpE548MSEqmqAhQ/lIot43CygDVOUb1V+oY88
         s36/MYbqFZXtUfac+R37S4ZCg8s4Ia3m+6Kt2jYrzxKvB6e6CmtjqOyuU3YpNnBgcEAi
         CJU08LtsB7EGF25JRlc8aWa3DIEgjaEIu1nhEIXAuHzMSrh2IuhM0hL1pSwgaO6+XNKe
         BdQw==
X-Gm-Message-State: AElRT7GSaAaQWmis+ZeuTFrjGm/zxYA+T1CvFkxeVG7VB7NzfM2TxwiH
        g4HqiJi9IIcGX/J+5Q+LrQJnyw==
X-Google-Smtp-Source: AIpwx48QFbMRFQ/Ho14sE2XeYTv3mp+tXQnLgf9hbkB2NS6bq1kQseNo17JS6cB2gge14l7JdVxNvA==
X-Received: by 10.99.174.67 with SMTP id e3mr18981767pgp.139.1523056928542;
        Fri, 06 Apr 2018 16:22:08 -0700 (PDT)
Received: from localhost ([2620:0:100e:422:ea58:fa52:fa77:9b41])
        by smtp.gmail.com with ESMTPSA id d199sm20979065pfd.95.2018.04.06.16.22.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Apr 2018 16:22:07 -0700 (PDT)
From:   Stefan Beller <sbeller@google.com>
To:     jonathantanmy@google.com
Cc:     git@vger.kernel.org, Stefan Beller <sbeller@google.com>
Subject: [PATCH 13/19] refs: store the main ref store inside the repository struct
Date:   Fri,  6 Apr 2018 16:21:30 -0700
Message-Id: <20180406232136.253950-14-sbeller@google.com>
X-Mailer: git-send-email 2.17.0.484.g0c8726318c-goog
In-Reply-To: <20180406232136.253950-1-sbeller@google.com>
References: <20180406232136.253950-1-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 refs.c       | 13 +++++--------
 refs.h       |  4 +---
 repository.h |  5 +++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/refs.c b/refs.c
index 0352cbdcc1..793b827e19 100644
--- a/refs.c
+++ b/refs.c
@@ -1608,9 +1608,6 @@ static struct ref_store_hash_entry *alloc_ref_store_hash_entry(
 	return entry;
 }
 
-/* A pointer to the ref_store for the main repository: */
-static struct ref_store *main_ref_store;
-
 /* A hashmap of ref_stores, stored by submodule name: */
 static struct hashmap submodule_ref_stores;
 
@@ -1652,13 +1649,13 @@ static struct ref_store *ref_store_init(const char *gitdir,
 	return refs;
 }
 
-struct ref_store *get_main_ref_store_the_repository(void)
+struct ref_store *get_main_ref_store(struct repository *r)
 {
-	if (main_ref_store)
-		return main_ref_store;
+	if (r->main_ref_store)
+		return r->main_ref_store;
 
-	main_ref_store = ref_store_init(get_git_dir(), REF_STORE_ALL_CAPS);
-	return main_ref_store;
+	r->main_ref_store = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
+	return r->main_ref_store;
 }
 
 /*
diff --git a/refs.h b/refs.h
index ab3d2bec2f..f5ab68c0ed 100644
--- a/refs.h
+++ b/refs.h
@@ -760,9 +760,7 @@ int reflog_expire(const char *refname, const struct object_id *oid,
 
 int ref_storage_backend_exists(const char *name);
 
-#define get_main_ref_store(r) \
-	get_main_ref_store_##r()
-struct ref_store *get_main_ref_store_the_repository(void);
+struct ref_store *get_main_ref_store(struct repository *r);
 /*
  * Return the ref_store instance for the specified submodule. For the
  * main repository, use submodule==NULL; such a call cannot fail. For
diff --git a/repository.h b/repository.h
index 09df94a472..2922d3a28b 100644
--- a/repository.h
+++ b/repository.h
@@ -26,6 +26,11 @@ struct repository {
 	 */
 	struct raw_object_store *objects;
 
+	/*
+	 * The store in which the refs are hold.
+	 */
+	struct ref_store *main_ref_store;
+
 	/*
 	 * Path to the repository's graft file.
 	 * Cannot be NULL after initialization.
-- 
2.17.0.484.g0c8726318c-goog

