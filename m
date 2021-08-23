Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65FE8C4338F
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD8F61374
	for <git@archiver.kernel.org>; Mon, 23 Aug 2021 11:36:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbhHWLhI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Aug 2021 07:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236467AbhHWLhE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Aug 2021 07:37:04 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFD4CC061575
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:21 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d26so5473191wrc.0
        for <git@vger.kernel.org>; Mon, 23 Aug 2021 04:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3VmN9U+E+gBxRctGKAtlVszevCwliafyE9Oyg3Us6sg=;
        b=lrPmPcsAgiqvrifZ2dBVP9FDHpuRqtP0eKbcDqK4+5BOXn7JLepLj8YmJL399ZpGWy
         uZsGhc68O2fdwbZrH+5YNRBhb0R2ffwN14Lq1Z0ZEBZ6ms+vGNUCHVJaQIp4zaPhDrks
         Bg8M2lcjGm3Zc/9CBHsMh4LIndTCFAO8nUqlyzdqQS06Iii4A0XLhWq7HOwb58v9XQ8/
         gK2fq7MqIoV3hHlr1dN5ANstniVolWJJ+4T3BCKVM4byJOEM3W63+f34gPPfTqgde7eH
         nAyC6UbgZvNmZ5YUt0ndhCAnuLobsyAlCZbAvYucoogD4eTiF6LPjETvoGD8bvPoWOg5
         XvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3VmN9U+E+gBxRctGKAtlVszevCwliafyE9Oyg3Us6sg=;
        b=Pa5jj8sF427odFJ8jgNgMwhnVH5+Jsl7zOeealiqVuZ5QVf0jK/bv+R58pKYoLlCMd
         WLNCcgVJYgSAqg0aJUCf4KvYxpsT19MjAP+K5OLanT+fSgDFLw4/HWQuWynM/gBtda5a
         t58FsT+/7ZL717HxwCm190qJPoWSZ9wiWalb661BgOxzofB5H5eadyTX8aP55weCrg76
         xReNQ1k7HuGTlPaSR8RUxR2JnsvXNza4xn0fUUHoXuHxvnoBxJ7cJ/o3hF/q/WD9A19U
         5DIR0fvlrvA8L3RhPQgJhlNSxKFwwNfYRpjeF5XsCKXCdMVX7GbkDECQsk7HJVbr3d5w
         DQXQ==
X-Gm-Message-State: AOAM531KBl95iMYDsNMLvpuOZ6qVSb1xYDcLcYcBEhDd2sJR3NeKbwWJ
        otOghx8gflpHx0MdWj2JAwvVHMhaQNna6+kV
X-Google-Smtp-Source: ABdhPJy9FQvvHDzveip6TmS5mBD0lyCVNqHPtPVGTwIbBZw0jeTYxCIqysECNvYn96TaHNSvircf6Q==
X-Received: by 2002:adf:e901:: with SMTP id f1mr13108449wrm.13.1629718580217;
        Mon, 23 Aug 2021 04:36:20 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g35sm20555313wmp.9.2021.08.23.04.36.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Aug 2021 04:36:19 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 04/13] refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
Date:   Mon, 23 Aug 2021 13:36:05 +0200
Message-Id: <patch-v5-04.13-3e538eb3008-20210823T113115Z-avarab@gmail.com>
X-Mailer: git-send-email 2.33.0.662.g438caf9576d
In-Reply-To: <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
References: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com> <cover-v5-00.13-00000000000-20210823T113115Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The lock_ref_oid_basic() function has gradually been replaced by use
of the file transaction API, there are only 4 remaining callers of
it.

None of those callers pass non-NULL "extras" and "skip" parameters,
the last such caller went away in 92b1551b1d4 (refs: resolve symbolic
refs first, 2016-04-25), so let's remove the parameters.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 22 +++++++---------------
 1 file changed, 7 insertions(+), 15 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index e73458e2571..69f7f54e03b 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -915,8 +915,6 @@ static int create_reflock(const char *path, void *cb)
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const char *refname,
 					   const struct object_id *old_oid,
-					   const struct string_list *extras,
-					   const struct string_list *skip,
 					   int *type, struct strbuf *err)
 {
 	struct strbuf ref_file = STRBUF_INIT;
@@ -949,7 +947,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 			last_errno = errno;
 			if (!refs_verify_refname_available(
 					    &refs->base,
-					    refname, extras, skip, err))
+					    refname, NULL, NULL, err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    refname);
 			goto error_return;
@@ -962,7 +960,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
 		    !refs_verify_refname_available(&refs->base, refname,
-						   extras, skip, err))
+						   NULL, NULL, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    refname, strerror(last_errno));
 
@@ -977,7 +975,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	 */
 	if (is_null_oid(&lock->old_oid) &&
 	    refs_verify_refname_available(refs->packed_ref_store, refname,
-					  extras, skip, err)) {
+					  NULL, NULL, err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1412,9 +1410,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-
-	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, NULL,
-				  NULL, &err);
+	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1436,8 +1432,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	goto out;
 
  rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, NULL,
-				  NULL, &err);
+	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
 		strbuf_release(&err);
@@ -1844,9 +1839,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	struct ref_lock *lock;
 	int ret;
 
-	lock = lock_ref_oid_basic(refs, refname, NULL,
-				  NULL, NULL, NULL,
-				  &err);
+	lock = lock_ref_oid_basic(refs, refname, NULL, NULL, &err);
 	if (!lock) {
 		error("%s", err.buf);
 		strbuf_release(&err);
@@ -3063,8 +3056,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference itself, plus we might need to update the
 	 * reference if --updateref was specified:
 	 */
-	lock = lock_ref_oid_basic(refs, refname, oid,
-				  NULL, NULL, &type, &err);
+	lock = lock_ref_oid_basic(refs, refname, oid, &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
 		strbuf_release(&err);
-- 
2.33.0.662.g438caf9576d

