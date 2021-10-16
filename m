Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9260C433EF
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CC3BA61073
	for <git@archiver.kernel.org>; Sat, 16 Oct 2021 09:39:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244034AbhJPJmB (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 16 Oct 2021 05:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244016AbhJPJlw (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 16 Oct 2021 05:41:52 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE2DC061772
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:37 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 3-20020a1c0403000000b00322f53b9bbfso389487wme.3
        for <git@vger.kernel.org>; Sat, 16 Oct 2021 02:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CyzukmDVpOofAX86YVcnt8Tfs+rypSbqkBMzOHQ81QU=;
        b=eIliCLpMelFsoOYRS2hITf7Org/vJ0dtKF+5bcP1LHfCSlupN0jqaLTjf1b7QJlHMM
         skdiLUu+VkhLlZO+fO5spgdpI6pU7aUVQgBnFQQIgAUQT2/zBgC4l6jNUIaOrmxt6WSi
         5GEKijR+mn9o4woqNtPWYhUZMNK0cNTi9WB96lDVcsuS0MiTDFMLao0dtu2B5cx2REo0
         GYmkZPv3w0RzbGQUSBDVKCvz8Q8lwTWYWESubRRavYPJBpMSMee4ofIHMjSGZPrRUAdr
         4yeMPMYk//TiENw4A4UFZnt3vz9vh7JNNO6U6jpiRgOdLpAWqbSNWEU9tF8P8tRNttp3
         Sv1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CyzukmDVpOofAX86YVcnt8Tfs+rypSbqkBMzOHQ81QU=;
        b=GuFaMpBQtvP6QjwyYjGXhCnPVs5WNe68Z3Xuzf4lxKI/F+vMbBHnveGp7r1/+156XY
         0FEO08371zQTQAFFJw4Pj0vZcGtgGz4jIT0/p1uxiopd8xG/19x1Zm2pU7/7s7vQPRS7
         wWD5gsL+u2JHI4pelEeXwDWiV45SSZqcgvoQPBwiU/CySG0pjsCZV3iCUcuKka0RQ6Cv
         KwbfwYfrHufBqlMItX2zzLN+zBiKODeDD9doFzCGXV4Vj8AZ9iWB+AqqjLU1j3+m9aC2
         QZNRje6VYTsZyYNoIgy+B+r64o/i1N8NQzaWd0C/LSxn3kw/AUisi7S0/Jd9hDryYeI+
         Y1gw==
X-Gm-Message-State: AOAM532y5/KnJ4bnWySBI4CuwrnhCTrY7TnDv8ZUbyUr0B69qX6k7h6B
        3lyh1EG0ZNs6ZGm9qsWbqYYp53Iz9jqd4A==
X-Google-Smtp-Source: ABdhPJzFS1aZ5MBs6Zhd+l3tIhcEpMtmXjFEYR3loSirvfPI1Mfmlp6ZYgVHvfDFg0rMz0+N/BKxbw==
X-Received: by 2002:a1c:2b81:: with SMTP id r123mr8599012wmr.136.1634377176214;
        Sat, 16 Oct 2021 02:39:36 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id k22sm6993492wrd.59.2021.10.16.02.39.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 02:39:35 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 08/21] refs API: remove refs_read_ref_full() wrapper
Date:   Sat, 16 Oct 2021 11:39:14 +0200
Message-Id: <patch-v2-08.21-b2532614430-20211016T093845Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.1.1338.g20da966911a
In-Reply-To: <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20211013T235900Z-avarab@gmail.com> <cover-v2-00.21-00000000000-20211016T093845Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the refs_read_ref_full() wrapper in favor of migrating various
refs.c API users to the underlying refs_werrres_ref_unsafe() function.

A careful reading of these callers shows that the callers of this
function did not care about "errno", by moving away from the
refs_resolve_ref_unsafe() wrapper we can be sure that nothing relies
on it anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c               | 20 +++++++++-----------
 refs.h               |  2 --
 refs/files-backend.c | 36 ++++++++++++++++++++++--------------
 worktree.c           |  9 +++++----
 4 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/refs.c b/refs.c
index 44ddbb14f1d..80b85d244d2 100644
--- a/refs.c
+++ b/refs.c
@@ -290,20 +290,17 @@ struct ref_filter {
 	void *cb_data;
 };
 
-int refs_read_ref_full(struct ref_store *refs, const char *refname,
-		       int resolve_flags, struct object_id *oid, int *flags)
+int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid, int *flags)
 {
-	if (refs_resolve_ref_unsafe(refs, refname, resolve_flags, oid, flags))
+	int ignore_errno;
+	struct ref_store *refs = get_main_ref_store(the_repository);
+
+	if (refs_werrres_ref_unsafe(refs, refname, resolve_flags,
+				    oid, flags, &ignore_errno))
 		return 0;
 	return -1;
 }
 
-int read_ref_full(const char *refname, int resolve_flags, struct object_id *oid, int *flags)
-{
-	return refs_read_ref_full(get_main_ref_store(the_repository), refname,
-				  resolve_flags, oid, flags);
-}
-
 int read_ref(const char *refname, struct object_id *oid)
 {
 	return read_ref_full(refname, RESOLVE_REF_READING, oid, NULL);
@@ -1376,9 +1373,10 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
+	int ignore_errno;
 
-	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
-				&oid, &flag))
+	if (refs_werrres_ref_unsafe(refs, "HEAD", RESOLVE_REF_READING,
+				    &oid, &flag, &ignore_errno))
 		return fn("HEAD", &oid, flag, cb_data);
 
 	return 0;
diff --git a/refs.h b/refs.h
index c8afde6bb50..3938f99c902 100644
--- a/refs.h
+++ b/refs.h
@@ -89,8 +89,6 @@ char *refs_resolve_refdup(struct ref_store *refs,
 char *resolve_refdup(const char *refname, int resolve_flags,
 		     struct object_id *oid, int *flags);
 
-int refs_read_ref_full(struct ref_store *refs, const char *refname,
-		       int resolve_flags, struct object_id *oid, int *flags);
 int read_ref_full(const char *refname, int resolve_flags,
 		  struct object_id *oid, int *flags);
 int read_ref(const char *refname, struct object_id *oid);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 16e78326381..482d04de03a 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1006,6 +1006,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 {
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
+	int ignore_errno;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -1032,9 +1033,8 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		goto error_return;
 	}
 
-	if (refs_read_ref_full(&refs->base, lock->ref_name,
-			       0,
-			       &lock->old_oid, NULL))
+	if (!refs_werrres_ref_unsafe(&refs->base, lock->ref_name, 0,
+				     &lock->old_oid, NULL, &ignore_errno))
 		oidclr(&lock->old_oid);
 	goto out;
 
@@ -1397,6 +1397,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	struct strbuf tmp_renamed_log = STRBUF_INIT;
 	int log, ret;
 	struct strbuf err = STRBUF_INIT;
+	int ignore_errno;
 
 	files_reflog_path(refs, &sb_oldref, oldrefname);
 	files_reflog_path(refs, &sb_newref, newrefname);
@@ -1454,9 +1455,9 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
-	if (!copy && !refs_read_ref_full(&refs->base, newrefname,
-				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				NULL, NULL) &&
+	if (!copy && refs_werrres_ref_unsafe(&refs->base, newrefname,
+					     RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+					     NULL, NULL, &ignore_errno) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
 			    NULL, REF_NO_DEREF)) {
 		if (errno == EISDIR) {
@@ -1868,9 +1869,12 @@ static void update_symref_reflog(struct files_ref_store *refs,
 {
 	struct strbuf err = STRBUF_INIT;
 	struct object_id new_oid;
+	int ignore_errno;
+
 	if (logmsg &&
-	    !refs_read_ref_full(&refs->base, target,
-				RESOLVE_REF_READING, &new_oid, NULL) &&
+	    refs_werrres_ref_unsafe(&refs->base, target,
+				    RESOLVE_REF_READING, &new_oid, NULL,
+				    &ignore_errno) &&
 	    files_log_ref_write(refs, refname, &lock->old_oid,
 				&new_oid, logmsg, 0, &err)) {
 		error("%s", err.buf);
@@ -2144,6 +2148,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		(struct files_reflog_iterator *)ref_iterator;
 	struct dir_iterator *diter = iter->dir_iterator;
 	int ok;
+	int ignore_errno;
 
 	while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
 		int flags;
@@ -2155,9 +2160,10 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (ends_with(diter->basename, ".lock"))
 			continue;
 
-		if (refs_read_ref_full(iter->ref_store,
-				       diter->relative_path, 0,
-				       &iter->oid, &flags)) {
+		if (!refs_werrres_ref_unsafe(iter->ref_store,
+					     diter->relative_path, 0,
+					     &iter->oid, &flags,
+					     &ignore_errno)) {
 			error("bad ref for %s", diter->path.buf);
 			continue;
 		}
@@ -2501,9 +2507,11 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * the transaction, so we have to read it here
 			 * to record and possibly check old_oid:
 			 */
-			if (refs_read_ref_full(&refs->base,
-					       referent.buf, 0,
-					       &lock->old_oid, NULL)) {
+			int ignore_errno;
+			if (!refs_werrres_ref_unsafe(&refs->base,
+						     referent.buf, 0,
+						     &lock->old_oid, NULL,
+						     &ignore_errno)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
diff --git a/worktree.c b/worktree.c
index 092a4f92ad2..cfffcdb62b3 100644
--- a/worktree.c
+++ b/worktree.c
@@ -563,16 +563,17 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
 		struct worktree *wt = *p;
 		struct object_id oid;
 		int flag;
+		int ignore_errno;
 
 		if (wt->is_current)
 			continue;
 
 		strbuf_reset(&refname);
 		strbuf_worktree_ref(wt, &refname, "HEAD");
-		if (!refs_read_ref_full(get_main_ref_store(the_repository),
-					refname.buf,
-					RESOLVE_REF_READING,
-					&oid, &flag))
+		if (refs_werrres_ref_unsafe(get_main_ref_store(the_repository),
+					    refname.buf,
+					    RESOLVE_REF_READING,
+					    &oid, &flag, &ignore_errno))
 			ret = fn(refname.buf, &oid, flag, cb_data);
 		if (ret)
 			break;
-- 
2.33.1.1338.g20da966911a

