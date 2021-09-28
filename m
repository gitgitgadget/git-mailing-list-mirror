Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48252C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E8EF61139
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240892AbhI1NEX (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240883AbhI1NEU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:04:20 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB6CEC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:40 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 205-20020a1c01d6000000b0030cd17ffcf8so2186422wmb.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PUBiY6wHNk8UhslLrjZl1Gp7GQbGkGkrr1W6mpe6I4U=;
        b=Zzp5r9CoGb8Q45/YIFdcXFJMzT6GaCXBDVrV3qITpR7XZ9O/SU+A0Ut+9PngIGz39s
         JE3fciJSGGsD6Y8wq6pYi8F9msAPyKFoY5+jE16u1m3Psp0pQG1B71sP18bxSiyWc9h6
         VlHn/sQNaZjz0UQ4o0cb4IVJit8yF4019EnFN9MAr0E9TNqM1L1UZemOiWC5rbyiCc+R
         RLSKfXMKFLcsKeb+otBU24QwFuYf+x9J6EanYlmtAPrQMf/ut8Ewu5yMs0t7F4n08vvC
         qLncyXlxRV6BXSrn/W4bux/ymQ8oX6P1mlsN4ncRLomLD/nJe/Wib0gCNdQBspZO/A7+
         iK5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PUBiY6wHNk8UhslLrjZl1Gp7GQbGkGkrr1W6mpe6I4U=;
        b=QryuHS3HAnyEeDfeFqY7kdncLOeQLFo2MJEJ2KQ5Z5k3epFJHIHMQzfo8TAeuihNfb
         Z145mAPQVZDBDDF8NzJLXD4A8CLkeVGfgUX6zTuGI5QnHJTpWGbs3KlBGHf06lK840A8
         D7GHQqSq5OsVMpLSdFr4HqFEdMRcsEslxdPA8T/gDmnWiDDBkc9ypyhen00pnSU0GkJH
         QxMcf6iIf9c6gon2/5VHggNPPddwQDLN5+uo3V1KpfcIahrWkPMH4ifYiH3EpJsCwxsg
         nq64y8bY9d/MSk7J9mxBepZDFHnT52EQDgsl8UP1vLFQlq2SvZRL6X93PMbDoV5d8Nzk
         H4Iw==
X-Gm-Message-State: AOAM532yph5VQr0/BPSS61yJQQ+w4WzfOY2hwfK7kiwdQow5/vHglYqq
        +G8EDmS9yVjLedb0SpefAE6MH2aMk5tlLA==
X-Google-Smtp-Source: ABdhPJxTYg27fNF3XU/WfLH+IpaIq9+roZIUqRIARulQuQ0BWEGr0k62WR+hSZSJ9n30zhkPR7+RkQ==
X-Received: by 2002:a1c:c905:: with SMTP id f5mr4599335wmb.148.1632834156956;
        Tue, 28 Sep 2021 06:02:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5sm20180669wra.38.2021.09.28.06.02.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:02:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 5/5] refs/ref-cache.[ch]: remove "incomplete" from create_dir_entry()
Date:   Tue, 28 Sep 2021 15:02:24 +0200
Message-Id: <patch-5.5-1623819fb56-20210928T130032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1340.ge9f77250f2b
In-Reply-To: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the now-unused "incomplete" parameter from create_dir_entry(),
all its callers specify it as "1", so let's drop the "incomplete=0"
case. The last caller to use it was search_for_subdir(), but that code
was removed in the preceding commit.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 6 +++---
 refs/ref-cache.c     | 7 +++----
 refs/ref-cache.h     | 3 +--
 3 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 74c03858736..8fa328108ac 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -227,7 +227,7 @@ static void add_per_worktree_entries_to_dir(struct ref_dir *dir, const char *dir
 		pos = search_ref_dir(dir, prefix, prefix_len);
 		if (pos >= 0)
 			continue;
-		child_entry = create_dir_entry(dir->cache, prefix, prefix_len, 1);
+		child_entry = create_dir_entry(dir->cache, prefix, prefix_len);
 		add_entry_to_dir(dir, child_entry);
 	}
 }
@@ -278,7 +278,7 @@ static void loose_fill_ref_dir(struct ref_store *ref_store,
 			strbuf_addch(&refname, '/');
 			add_entry_to_dir(dir,
 					 create_dir_entry(dir->cache, refname.buf,
-							  refname.len, 1));
+							  refname.len));
 		} else {
 			if (!refs_resolve_ref_unsafe(&refs->base,
 						     refname.buf,
@@ -336,7 +336,7 @@ static struct ref_cache *get_loose_ref_cache(struct files_ref_store *refs)
 		 * lazily):
 		 */
 		add_entry_to_dir(get_ref_dir(refs->loose->root),
-				 create_dir_entry(refs->loose, "refs/", 5, 1));
+				 create_dir_entry(refs->loose, "refs/", 5));
 	}
 	return refs->loose;
 }
diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 73b338f5ff2..a5ad8a39fb4 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -49,7 +49,7 @@ struct ref_cache *create_ref_cache(struct ref_store *refs,
 
 	ret->ref_store = refs;
 	ret->fill_ref_dir = fill_ref_dir;
-	ret->root = create_dir_entry(ret, "", 0, 1);
+	ret->root = create_dir_entry(ret, "", 0);
 	return ret;
 }
 
@@ -86,14 +86,13 @@ static void clear_ref_dir(struct ref_dir *dir)
 }
 
 struct ref_entry *create_dir_entry(struct ref_cache *cache,
-				   const char *dirname, size_t len,
-				   int incomplete)
+				   const char *dirname, size_t len)
 {
 	struct ref_entry *direntry;
 
 	FLEX_ALLOC_MEM(direntry, name, dirname, len);
 	direntry->u.subdir.cache = cache;
-	direntry->flag = REF_DIR | (incomplete ? REF_INCOMPLETE : 0);
+	direntry->flag = REF_DIR | REF_INCOMPLETE;
 	return direntry;
 }
 
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 580d4038f62..5c042ae718c 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -169,8 +169,7 @@ struct ref_dir *get_ref_dir(struct ref_entry *entry);
  * "refs/heads/") or "" for the top-level directory.
  */
 struct ref_entry *create_dir_entry(struct ref_cache *cache,
-				   const char *dirname, size_t len,
-				   int incomplete);
+				   const char *dirname, size_t len);
 
 struct ref_entry *create_ref_entry(const char *refname,
 				   const struct object_id *oid, int flag);
-- 
2.33.0.1340.ge9f77250f2b

