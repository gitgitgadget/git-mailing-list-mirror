Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1EF3DC433F5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EC2EA610E5
	for <git@archiver.kernel.org>; Tue, 28 Sep 2021 13:02:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240880AbhI1NET (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240849AbhI1NEQ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 09:04:16 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F53CC061575
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:37 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id g16so57926183wrb.3
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 06:02:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CGlcVyfbhAtRmwEpn3mSxi+SfDsetOVK2Lfe45MZEIM=;
        b=jLtVRuC/3LKlSUtc/P5kYs5s/AuDc9KSyBzcpTglkL1lK31iP6qWcsKywYAc0IXb9+
         o9+sUlAg0duRcjvaHor8xUkqrDIDCETREJ+FreSJHQbwYgkKcmcqjw90jsLbjj7ce1uK
         zKkOslYEDOvj0lH5yG30lLSIUUQ1gOzIcsqsPaMyxfidFcnX9ouOkF/eZiSw/A4Fdl5+
         m0zachailGrMLNmTChHvdx0vqC3Sq2W8m8BUf55DMsHsjDksUvFiTcFtFoM2oSQ7BAJO
         BNzK+EvWFExAmgkUY2Bfm3sHPFURjl7n5klZfAC7wwLKv+M1C/k8HeOQ+CMPxz8DtpD+
         d1mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CGlcVyfbhAtRmwEpn3mSxi+SfDsetOVK2Lfe45MZEIM=;
        b=aVMILKpKVJWPlivUtm8tYGdXyZyCPWF6mSPSzh2XM/AsnRiDV70sGr9RKy4dvec2sX
         4DzdPzp+uQ9NB82SU7DYIpUfOcJnF5PNK5im6ue2maf5hohKTAk49nKlErQN9AciXyjI
         zAljkn0X2ZCibXeAYz5dNr+0gokNYH8zAbz5sNvrU3gQZjZvJyGnpcfNCGgm2yYIgKB2
         dmWdNJ+fUs9qc1VHpn79hURYjJrrVl7gi5x+9k5N2VdEggZcLord0m8GpSsfhn88cfdZ
         n/JmoHbKVwK/psUuRpdpkgYlqTl96twmIpy2sfTELjzQuDwKlzoFbymnFy8sRDdqyIqu
         74dQ==
X-Gm-Message-State: AOAM530nGLICn32xi/wTbYaBvsIXJWEFs6k8wnOkTaD3fnzaOD674ucb
        IX2JVe/uuGrf76kcyoQ6s9+jJspfClPyFg==
X-Google-Smtp-Source: ABdhPJyO78akzL+yWrhl6/SO3SRlOb5qI6lSUjT4sPaDMygVJc159atU3ytpHcNZ4mR6XFUaMpcELA==
X-Received: by 2002:a5d:6b89:: with SMTP id n9mr2456678wrx.372.1632834154853;
        Tue, 28 Sep 2021 06:02:34 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d5sm20180669wra.38.2021.09.28.06.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 06:02:33 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 4/5] refs/ref-cache.c: remove "mkdir" parameter from find_containing_dir()
Date:   Tue, 28 Sep 2021 15:02:23 +0200
Message-Id: <patch-4.5-a6f9c19f658-20210928T130032Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.1340.ge9f77250f2b
In-Reply-To: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
References: <cover-0.5-00000000000-20210928T130032Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the "mkdir" parameter from the find_containing_dir() function,
the add_ref_entry() function removed in the preceding commit was its
last user.

Since "mkdir" is always "0" we can also remove the parameter from
search_for_subdir(), which in turn means that we can delete most of
that function.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/ref-cache.c | 36 ++++++++++++------------------------
 1 file changed, 12 insertions(+), 24 deletions(-)

diff --git a/refs/ref-cache.c b/refs/ref-cache.c
index a28883768c9..73b338f5ff2 100644
--- a/refs/ref-cache.c
+++ b/refs/ref-cache.c
@@ -144,30 +144,19 @@ int search_ref_dir(struct ref_dir *dir, const char *refname, size_t len)
 /*
  * Search for a directory entry directly within dir (without
  * recursing).  Sort dir if necessary.  subdirname must be a directory
- * name (i.e., end in '/').  If mkdir is set, then create the
- * directory if it is missing; otherwise, return NULL if the desired
+ * name (i.e., end in '/'). Returns NULL if the desired
  * directory cannot be found.  dir must already be complete.
  */
 static struct ref_dir *search_for_subdir(struct ref_dir *dir,
-					 const char *subdirname, size_t len,
-					 int mkdir)
+					 const char *subdirname, size_t len)
 {
 	int entry_index = search_ref_dir(dir, subdirname, len);
 	struct ref_entry *entry;
-	if (entry_index == -1) {
-		if (!mkdir)
-			return NULL;
-		/*
-		 * Since dir is complete, the absence of a subdir
-		 * means that the subdir really doesn't exist;
-		 * therefore, create an empty record for it but mark
-		 * the record complete.
-		 */
-		entry = create_dir_entry(dir->cache, subdirname, len, 0);
-		add_entry_to_dir(dir, entry);
-	} else {
-		entry = dir->entries[entry_index];
-	}
+
+	if (entry_index == -1)
+		return NULL;
+
+	entry = dir->entries[entry_index];
 	return get_ref_dir(entry);
 }
 
@@ -176,18 +165,17 @@ static struct ref_dir *search_for_subdir(struct ref_dir *dir,
  * tree that should hold refname. If refname is a directory name
  * (i.e., it ends in '/'), then return that ref_dir itself. dir must
  * represent the top-level directory and must already be complete.
- * Sort ref_dirs and recurse into subdirectories as necessary. If
- * mkdir is set, then create any missing directories; otherwise,
+ * Sort ref_dirs and recurse into subdirectories as necessary. Will
  * return NULL if the desired directory cannot be found.
  */
 static struct ref_dir *find_containing_dir(struct ref_dir *dir,
-					   const char *refname, int mkdir)
+					   const char *refname)
 {
 	const char *slash;
 	for (slash = strchr(refname, '/'); slash; slash = strchr(slash + 1, '/')) {
 		size_t dirnamelen = slash - refname + 1;
 		struct ref_dir *subdir;
-		subdir = search_for_subdir(dir, refname, dirnamelen, mkdir);
+		subdir = search_for_subdir(dir, refname, dirnamelen);
 		if (!subdir) {
 			dir = NULL;
 			break;
@@ -202,7 +190,7 @@ struct ref_entry *find_ref_entry(struct ref_dir *dir, const char *refname)
 {
 	int entry_index;
 	struct ref_entry *entry;
-	dir = find_containing_dir(dir, refname, 0);
+	dir = find_containing_dir(dir, refname);
 	if (!dir)
 		return NULL;
 	entry_index = search_ref_dir(dir, refname, strlen(refname));
@@ -478,7 +466,7 @@ struct ref_iterator *cache_ref_iterator_begin(struct ref_cache *cache,
 
 	dir = get_ref_dir(cache->root);
 	if (prefix && *prefix)
-		dir = find_containing_dir(dir, prefix, 0);
+		dir = find_containing_dir(dir, prefix);
 	if (!dir)
 		/* There's nothing to iterate over. */
 		return empty_ref_iterator_begin();
-- 
2.33.0.1340.ge9f77250f2b

