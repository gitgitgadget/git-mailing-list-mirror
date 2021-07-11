Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB541C11F66
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E18161182
	for <git@archiver.kernel.org>; Sun, 11 Jul 2021 16:30:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232768AbhGKQdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 11 Jul 2021 12:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbhGKQdn (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 11 Jul 2021 12:33:43 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE161C061788
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:55 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id k31-20020a05600c1c9fb029021727d66d33so8256521wms.0
        for <git@vger.kernel.org>; Sun, 11 Jul 2021 09:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PqWzZgLjH6vj+2q3SCxhBeG56Hl1Jm7qgAN8iW9Zc0A=;
        b=kJAHqxCnQLCbOZul52KC1d8q16/LDT8ly/Ddjnytaitb04PoHUtWedDm2MUqgB9/0+
         cteP57OY6UIfopAFZ7wG1hmtSIWzDNZl6p97961WxaWTTUIEwj15vV42S3/yIp3iTwxZ
         FhH8139hSOPw95BEmg3DA9c/XQnspZJZtLl718CR1A/maNj5+kHTBXd8vnJxh2p8f7WD
         LHuMaLR3E2UrsFkvwVSvckLGl8nbyHz2ao+zk295TH3mAiFORXPhiT7EawKDUofWMvhn
         gUioh6VHoiOP/diHwiXfg/vkNgKk8ODahKrSuHDZNwfF/CY6PfRXLI9Hbyv+rP6AKSr0
         FBjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PqWzZgLjH6vj+2q3SCxhBeG56Hl1Jm7qgAN8iW9Zc0A=;
        b=XnZAIiI+Ta/YgTgVAQMelrA0xhoHD2/kan42tFn/Xe9z1LfOaAHXSNexNW8t8+OXoT
         PUM8bmNOwFgAVe9N9/yO7boLBffKo+3IPXJPN58GCFRHPuHEtkNm8iMymISG69dSoU1c
         htTQ1GGqwWGFBBdVUaWT9KDBECgEIyFZBUW7i1UYynZ4oWfi9AjnAaULL2mi8skzxXbZ
         rqoLTyudjEY9IZx8KwlIE3+itxXNA3ttHFd+vME3hTLFeAtZ7/ONpdCJgjYJRfC3ZM4t
         YqMpDE0pkGjmW6nN0Ho2CnPO05V8DA/aYnNrwmwC/JSI5nZ6StqLYhWsgbtaFihvQr75
         Cdqw==
X-Gm-Message-State: AOAM531iuXub4YQmsS4f7cGyM0ei4V/h4n0NBTJUgGZaNqsS+piRo6pg
        KLl8IjmX9PcE9s/73Fjg47w8nqxpQa95NA==
X-Google-Smtp-Source: ABdhPJyTzwxUxingg2k8WIhU8WgtwcHzOQ/VTZDjejDWZ8UZaxEHL0VXY0M3t8kW0/HXdTnpN3xTZA==
X-Received: by 2002:a7b:c84d:: with SMTP id c13mr10235452wml.30.1626021054108;
        Sun, 11 Jul 2021 09:30:54 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w3sm678091wrt.55.2021.07.11.09.30.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 11 Jul 2021 09:30:53 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v6? 10/17] refs API: remove refs_read_ref_full() wrapper
Date:   Sun, 11 Jul 2021 18:30:34 +0200
Message-Id: <patch-10.17-bd0639945a4-20210711T162803Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0-dev
In-Reply-To: <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
References: <pull.1012.v5.git.git.1625684869.gitgitgadget@gmail.com> <cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Remove the refs_read_ref_full() wrapper in favor of migrating various
refs.c API users to the underlying
refs_resolve_ref_unsafe_with_errno() function. A careful reading of
these callers shows that the callers of this function did not care
about "errno", by moving away from the refs_resolve_ref_unsafe()
wrapper we can be sure that nothing relies on it anymore.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c               | 22 ++++++++++------------
 refs.h               |  2 --
 refs/files-backend.c | 30 +++++++++++++++++++-----------
 worktree.c           |  9 +++++----
 4 files changed, 34 insertions(+), 29 deletions(-)

diff --git a/refs.c b/refs.c
index 1dacb5fe27b..91320f092fb 100644
--- a/refs.c
+++ b/refs.c
@@ -294,20 +294,17 @@ struct ref_filter {
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
+	if (refs_resolve_ref_unsafe_with_errno(refs, refname, resolve_flags,
+					       oid, flags, &ignore_errno))
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
@@ -1398,9 +1395,10 @@ int refs_head_ref(struct ref_store *refs, each_ref_fn fn, void *cb_data)
 {
 	struct object_id oid;
 	int flag;
-
-	if (!refs_read_ref_full(refs, "HEAD", RESOLVE_REF_READING,
-				&oid, &flag))
+	int ignore_errno;
+	
+	if (refs_resolve_ref_unsafe_with_errno(refs, "HEAD", RESOLVE_REF_READING,
+					       &oid, &flag, &ignore_errno))
 		return fn("HEAD", &oid, flag, cb_data);
 
 	return 0;
diff --git a/refs.h b/refs.h
index 344a3c51a8c..d80184dd8e0 100644
--- a/refs.h
+++ b/refs.h
@@ -88,8 +88,6 @@ char *refs_resolve_refdup(struct ref_store *refs,
 char *resolve_refdup(const char *refname, int resolve_flags,
 		     struct object_id *oid, int *flags);
 
-int refs_read_ref_full(struct ref_store *refs, const char *refname,
-		       int resolve_flags, struct object_id *oid, int *flags);
 int read_ref_full(const char *refname, int resolve_flags,
 		  struct object_id *oid, int *flags);
 int read_ref(const char *refname, struct object_id *oid);
diff --git a/refs/files-backend.c b/refs/files-backend.c
index e3d27001b86..b3bc2f57387 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -1342,6 +1342,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	struct strbuf tmp_renamed_log = STRBUF_INIT;
 	int log, ret;
 	struct strbuf err = STRBUF_INIT;
+	int ignore_errno;
 
 	files_reflog_path(refs, &sb_oldref, oldrefname);
 	files_reflog_path(refs, &sb_newref, newrefname);
@@ -1399,9 +1400,9 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	 * the safety anyway; we want to delete the reference whatever
 	 * its current value.
 	 */
-	if (!copy && !refs_read_ref_full(&refs->base, newrefname,
-				RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
-				NULL, NULL) &&
+	if (!copy && refs_resolve_ref_unsafe_with_errno(&refs->base, newrefname,
+							RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
+							NULL, NULL, &ignore_errno) &&
 	    refs_delete_ref(&refs->base, NULL, newrefname,
 			    NULL, REF_NO_DEREF)) {
 		if (errno == EISDIR) {
@@ -1815,9 +1816,12 @@ static void update_symref_reflog(struct files_ref_store *refs,
 {
 	struct strbuf err = STRBUF_INIT;
 	struct object_id new_oid;
+	int ignore_errno;
+
 	if (logmsg &&
-	    !refs_read_ref_full(&refs->base, target,
-				RESOLVE_REF_READING, &new_oid, NULL) &&
+	    refs_resolve_ref_unsafe_with_errno(&refs->base, target,
+					       RESOLVE_REF_READING, &new_oid, NULL,
+					       &ignore_errno) &&
 	    files_log_ref_write(refs, refname, &lock->old_oid,
 				&new_oid, logmsg, 0, &err)) {
 		error("%s", err.buf);
@@ -2093,6 +2097,7 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		(struct files_reflog_iterator *)ref_iterator;
 	struct dir_iterator *diter = iter->dir_iterator;
 	int ok;
+	int ignore_errno;
 
 	while ((ok = dir_iterator_advance(diter)) == ITER_OK) {
 		int flags;
@@ -2104,9 +2109,10 @@ static int files_reflog_iterator_advance(struct ref_iterator *ref_iterator)
 		if (ends_with(diter->basename, ".lock"))
 			continue;
 
-		if (refs_read_ref_full(iter->ref_store,
-				       diter->relative_path, 0,
-				       &iter->oid, &flags)) {
+		if (!refs_resolve_ref_unsafe_with_errno(iter->ref_store,
+							diter->relative_path, 0,
+							&iter->oid, &flags,
+							&ignore_errno)) {
 			error("bad ref for %s", diter->path.buf);
 			continue;
 		}
@@ -2450,9 +2456,11 @@ static int lock_ref_for_update(struct files_ref_store *refs,
 			 * the transaction, so we have to read it here
 			 * to record and possibly check old_oid:
 			 */
-			if (refs_read_ref_full(&refs->base,
-					       referent.buf, 0,
-					       &lock->old_oid, NULL)) {
+			int ignore_errno;
+			if (!refs_resolve_ref_unsafe_with_errno(&refs->base,
+								referent.buf, 0,
+								&lock->old_oid, NULL,
+								&ignore_errno)) {
 				if (update->flags & REF_HAVE_OLD) {
 					strbuf_addf(err, "cannot lock ref '%s': "
 						    "error reading reference",
diff --git a/worktree.c b/worktree.c
index 237517baee6..1dcdb481d61 100644
--- a/worktree.c
+++ b/worktree.c
@@ -562,16 +562,17 @@ int other_head_refs(each_ref_fn fn, void *cb_data)
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
+		if (refs_resolve_ref_unsafe_with_errno(get_main_ref_store(the_repository),
+						       refname.buf,
+						       RESOLVE_REF_READING,
+						       &oid, &flag, &ignore_errno))
 			ret = fn(refname.buf, &oid, flag, cb_data);
 		if (ret)
 			break;
-- 
2.32.0-dev

