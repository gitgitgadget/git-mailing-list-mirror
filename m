Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A705C433EF
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36BC8610E5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240851AbhI1NEN (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:04:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240300AbhI1NEM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:04:12 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD08C061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:32 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id g16so57925751wrb.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=d991vA+PspIgQcxxtXdOVfpI/fcuX+rL8b1eJrqvfxA=;
        b=P4IvP61JwXycxiGpv9ZYiLJG1rxrNk4JLTW7cub326kt01X9t0JwAENUVaRnoWSFGZ
         339bdMFYlURF/1MFCT3GFFNPbd7TVXqF8x+nO1rihrabp2KrA/654CXrRO1kOUpGX4h2
         TMkwyMEe42aWs42E2oKBt0NpluE45AItfeTyq+IH45LbBLQvo7qEeO0cV0X20bKBLaoK
         fTl6RXr9xbXp15taySTEaIEKj3VBor7+ZZGfmdqkW0z//MqVQ+c47pGNgN+HqURtv9n1
         9nlJCkkeH8D4l2P8cwlcyiUGcp+w0qhW8VN9BKy3pTNIRpXLu99iH3TEZPqKgIUa/4GS
         /XMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=d991vA+PspIgQcxxtXdOVfpI/fcuX+rL8b1eJrqvfxA=;
        b=NpyNqYQ2s6HaehmRGwxxbMbsGCuBuLvCi9Qa1Ccsqd/dIj1o4YLBXGa9+poTJdnNBr
         +ZZwsJe3wD2L/Wf6shygNmeb1Mib03RonNiYxkuwH+aP+IHu0H8zWKfNXotrnkDCNEKj
         RR4kg5++/9rU+mxrkfclMlCRQLNity8ErEtu7nDCdbDmgn+n6djluk5rB3hSwKThuJ6V
         Ng6vG5VsxJ2OohzjOXAlPRZGBnYA63XarVHIy/yMY8pZYNl4aUt9Em/CSt23Fgk6t7fu
         RUWF3upozHSNRWL7Floujkd1JiJWV63fDuB5sMWH0VtMi7mg/d+5BbHDiljdQMI5gg78
         pLcA==
X-Gm-Message-State: AOAM531zF+r3pQSqMzSGneW+VMom6C0c3sxE6xJT3pjItMJLVlFqaLnn
        HrgOu1zQN8ZQWphiGBQFlPWdJubBNr9Grw==
X-Google-Smtp-Source: ABdhPJxnUYUmnymabPZLEiMod2pCj1CmVpDj1v/E9qiLdbvk1fTGmzr9uWQodgf3TmXf0oRpehTs6g==
X-Received: by 2002:a5d:4f02:: with SMTP id c2mr6556995wru.10.1632834150930;
        Tue, 28 Sep 2021 06:02:30 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5sm20180669wra.38.2021.09.28.06.02.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:02:30 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 2/5] refs/ref-cache.[ch]: remove unused remove_entry_from_dir()
Date:   Tue, 28 Sep 2021 15:02:21 +0200
Message-Id: <patch-2.5-001a1335ab4-20210928T130032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1340.ge9f77250f2b
In-Reply-To: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This function was missed in 9939b33d6a3 (packed-backend: rip out some
now-unused code, 2017-09-08), and has been orphaned since then. Let's
delete it.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/ref-cache.c | 35 -----------------------------------
 refs/ref-cache.h | 16 ----------------
 2 files changed, 51 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index 49d732f6db9..e0feebf628f 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -212,41 +212,6 @@ struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
 	return (entry->flag & REF_DIR) ? NULL : entry;
 }
 
-int remove_entry_from_dir(struct ref_dir *dir, const char *refname)
-{
-	int refname_len = strlen(refname);
-	int entry_index;
-	struct ref_entry *entry;
-	int is_dir = refname[refname_len - 1] == '/';
-	if (is_dir) {
-		/*
-		 * refname represents a reference directory.  Remove
-		 * the trailing slash; otherwise we will get the
-		 * directory *representing* refname rather than the
-		 * one *containing* it.
-		 */
-		char *dirname = xmemdupz(refname, refname_len - 1);
-		dir = find_containing_dir(dir, dirname, 0);
-		free(dirname);
-	} else {
-		dir = find_containing_dir(dir, refname, 0);
-	}
-	if (!dir)
-		return -1;
-	entry_index = search_ref_dir(dir, refname, refname_len);
-	if (entry_index == -1)
-		return -1;
-	entry = dir->entries[entry_index];
-
-	MOVE_ARRAY(&dir->entries[entry_index],
-		   &dir->entries[entry_index + 1], dir->nr - entry_index - 1);
-	dir->nr--;
-	if (dir->sorted > entry_index)
-		dir->sorted--;
-	free_ref_entry(entry);
-	return dir->nr;
-}
-
 int add_ref_entry(struct ref_dir *dir, struct ref_entry *ref)
 {
 	dir = find_containing_dir(dir, ref->name, 1);
diff --git a/refs/ref-cache.h b/refs/ref-cache.h
index 3bfb89d2b34..bd1ff578ea2 100644
--- a/refs/ref-cache.h
+++ b/refs/ref-cache.h
@@ -199,22 +199,6 @@ void free_ref_cache(struct ref_cache *cache);
  */
 void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
 
-/*
- * Remove the entry with the given name from dir, recursing into
- * subdirectories as necessary.  If refname is the name of a directory
- * (i.e., ends with '/'), then remove the directory and its contents.
- * If the removal was successful, return the number of entries
- * remaining in the directory entry that contained the deleted entry.
- * If the name was not found, return -1.  Please note that this
- * function only deletes the entry from the cache; it does not delete
- * it from the filesystem or ensure that other cache entries (which
- * might be symbolic references to the removed entry) are updated.
- * Nor does it remove any containing dir entries that might be made
- * empty by the removal.  dir must represent the top-level directory
- * and must already be complete.
- */
-int remove_entry_from_dir(struct ref_dir *dir, const char *refname);
-
 /*
  * Add a ref_entry to the ref_dir (unsorted), recursing into
  * subdirectories as necessary.  dir must represent the top-level
-- 
2.33.0.1340.ge9f77250f2b

