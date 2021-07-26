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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A18DEC432BE
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 860C460F6D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234161AbhGZXEM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233959AbhGZXEH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:07 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FA4FC061764
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:34 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e2so12993315wrq.6
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cHVPqTEKi5EZQutPKgJ+igxNtsb8o1l3HyV1iLfo8Qc=;
        b=d4cfpqkzfr2YTktr9oELGXR87rJKxHqAo01LFTpidPj7SZS9oQK9w3/TgIBZojZy6w
         VDWTkNqFQ6WH2Z8L06imOaqcC2YZO5MJ8wL7gywc0BmPI2f/wCuBDSdKnSxoG2msmJLF
         XYA6dHRBQpQjebmIDq4XvA+2UZFHcn+GG8hjsUDHO5PiomRsCLTwXV7WkT3Y+KxQTF2n
         Yz7ETJn7g6AIn1ZXj+a8c33CvNV6AYYAKxXQ822I2Fk0tvTxDxbbnnwV/Ffj223taM1M
         +YwshLDSTRa2CK2U4tG575dr3U0RAozoF204O+Q5VcAoW1rrq3qTakbsPgAT9iNmtbsR
         w7XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cHVPqTEKi5EZQutPKgJ+igxNtsb8o1l3HyV1iLfo8Qc=;
        b=YXhcnUk94g28OHFMwkeafk10WSgV5BBSzFUvRf0LKM4nMQcGWGCA19RXyr+ASyLZsV
         i6KvR0pZCGKwkIEUJxdMNcLlO39xiMRQPat9wZQVulDoUgtz3FnlnkEPTsLQYPXfg2vx
         Y0plWcwIujatX0nWOn4sipPIa2VErqGsw+EgqwGnt5YG0QRBdJZ/UgClPxmhbCSDx2R6
         eL6yMkkov67v7+l66D/4M/AAGv4LKm2nLk7I8gVSOlEG6zJFt0+a0pB0a62RTZiO/1hg
         Jsa14lHyB1RvjODxXhxKyF2jPZvGSdAec4wHYCOmBSHGwsoCPvBKY+1rbwFT/fKzB88f
         50DA==
X-Gm-Message-State: AOAM531VmhgbPKS6soH4FMOvS/mGhgw5Dl4oYrFXCG98VSiFHMq6Q9Oq
        5JAyUZgZ+N5DlCJpR2GftS8tRILtqdVEuQ==
X-Google-Smtp-Source: ABdhPJx7S0enW+zd2Hgb7xNaZ+nkwQyiO84w2xHTQ1B+TcrILCKjOzfNqg81wFsbKM/kghzoiBNQkA==
X-Received: by 2002:adf:90c6:: with SMTP id i64mr21914464wri.168.1627343072638;
        Mon, 26 Jul 2021 16:44:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 03/11] refs/files: remove unused "extras/skip" in lock_ref_oid_basic()
Date:   Tue, 27 Jul 2021 01:44:19 +0200
Message-Id: <patch-03.11-7d76514b55-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
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
 refs/files-backend.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 326f022421..a59823d667 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -915,8 +915,6 @@ static int create_reflock(const char *path, void *cb)
 static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 					   const char *refname,
 					   const struct object_id *old_oid,
-					   const struct string_list *extras,
-					   const struct string_list *skip,
 					   unsigned int flags, int *type,
 					   struct strbuf *err)
 {
@@ -950,7 +948,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 			last_errno = errno;
 			if (!refs_verify_refname_available(
 					    &refs->base,
-					    refname, extras, skip, err))
+					    refname, NULL, NULL, err))
 				strbuf_addf(err, "there are still refs under '%s'",
 					    refname);
 			goto error_return;
@@ -963,7 +961,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
 		    !refs_verify_refname_available(&refs->base, refname,
-						   extras, skip, err))
+						   NULL, NULL, err))
 			strbuf_addf(err, "unable to resolve reference '%s': %s",
 				    refname, strerror(last_errno));
 
@@ -978,7 +976,7 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	 */
 	if (is_null_oid(&lock->old_oid) &&
 	    refs_verify_refname_available(refs->packed_ref_store, refname,
-					  extras, skip, err)) {
+					  NULL, NULL, err)) {
 		last_errno = ENOTDIR;
 		goto error_return;
 	}
@@ -1413,8 +1411,8 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 
 	logmoved = log;
 
-	lock = lock_ref_oid_basic(refs, newrefname, NULL, NULL, NULL,
-				  REF_NO_DEREF, NULL, &err);
+	lock = lock_ref_oid_basic(refs, newrefname, NULL, REF_NO_DEREF, NULL,
+				  &err);
 	if (!lock) {
 		if (copy)
 			error("unable to copy '%s' to '%s': %s", oldrefname, newrefname, err.buf);
@@ -1436,7 +1434,7 @@ static int files_copy_or_rename_ref(struct ref_store *ref_store,
 	goto out;
 
  rollback:
-	lock = lock_ref_oid_basic(refs, oldrefname, NULL, NULL, NULL,
+	lock = lock_ref_oid_basic(refs, oldrefname, NULL,
 				  REF_NO_DEREF, NULL, &err);
 	if (!lock) {
 		error("unable to lock %s for rollback: %s", oldrefname, err.buf);
@@ -1845,7 +1843,7 @@ static int files_create_symref(struct ref_store *ref_store,
 	int ret;
 
 	lock = lock_ref_oid_basic(refs, refname, NULL,
-				  NULL, NULL, REF_NO_DEREF, NULL,
+				  REF_NO_DEREF, NULL,
 				  &err);
 	if (!lock) {
 		error("%s", err.buf);
@@ -3064,7 +3062,7 @@ static int files_reflog_expire(struct ref_store *ref_store,
 	 * reference if --updateref was specified:
 	 */
 	lock = lock_ref_oid_basic(refs, refname, oid,
-				  NULL, NULL, REF_NO_DEREF,
+				  REF_NO_DEREF,
 				  &type, &err);
 	if (!lock) {
 		error("cannot lock ref '%s': %s", refname, err.buf);
-- 
2.32.0.956.g6b0c84ceda8

