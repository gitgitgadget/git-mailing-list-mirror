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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7663C07E9A
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:17:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C191A613B2
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 11:17:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238774AbhGNLUV (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 07:20:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239141AbhGNLUU (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 07:20:20 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622F9C061760
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:17:29 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a13so2711359wrf.10
        for <git@vger.kernel.org>; Wed, 14 Jul 2021 04:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSBrVe7iiLozGuZ3F5/PbK5Fxn+OmQ0YsO36xLXy6qk=;
        b=SjTRRR1D+Y9aSkdvIOOnav93EmxCMZoeMoh6NPVpFy+QmTrOzsIM4ffhX0ovFK7c8e
         08DgNq34b7TTIoyxfL9pwxVPcbtt0xXbyUfoX6WqkleDZquc2XH2fGO/KmjlYHmgFy59
         U0B5UlW4zixLI16IModVudY4Z1ejVz12u+FiJfcfZqhYP461p2vJoUM2alEjgCxZ2eMo
         HwTpxS6aXIV0paZZzPaIvpemUI7UIA2nriRRSy663h1X0zkJTX46H+AbsjJpjsfId1uT
         EBY3sWuSmeNLvO5ayq/IUUJy2fNuMaeKufBbUWeok+dijResNumKo3Cp62cz8rnWtqgE
         leJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mSBrVe7iiLozGuZ3F5/PbK5Fxn+OmQ0YsO36xLXy6qk=;
        b=qy5Hz4v1x117Vyb3NENtLpcHlkfMM0G55WIOqCKwubD22b0eQq3QrkVOY2VxVkOZJG
         Sic1T8dD5TquOwmPlhpMH9rFXo9egeWje3xiVkv3myYsis7w+57vqAKMCCWROwGA72kk
         GYmReDzL68TPVdwvkRyYaY801o5Vxj4RmPt2s3vA3hD4j3AdIlk2Ntptuvkd49FlJSum
         EwbrA381mlrpw/rF5Jx7urNp9sKbeXZSvsMOt/NMl7VM01kU94FV84RVjD73dgbernp5
         cazESp6WPn3DIa/KLVuuJyCMzZ/q8owYJyPUHrKlQ0hc5ppwiFqJDwnMcMFiDd9DgHfT
         FHbA==
X-Gm-Message-State: AOAM532V8ZtJWpgxmOBZhnzh8xmjd12kcH88LcEebyHhHAGJpUUTXs7I
        ZnrIuO6kJrWb3bXlTXFj/WctABFVGxhRQo7k
X-Google-Smtp-Source: ABdhPJxawaIU9ZJ7PPKveALo46ib87JPa+71MX0NdzEwU6Xue3A20W09GE02dUSVV2eTiTS97n0otg==
X-Received: by 2002:a5d:47a7:: with SMTP id 7mr12405846wrb.150.1626261447763;
        Wed, 14 Jul 2021 04:17:27 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id s4sm2017269wmh.41.2021.07.14.04.17.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jul 2021 04:17:27 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH] refs file backend: remove dead "errno == EISDIR" code
Date:   Wed, 14 Jul 2021 13:17:14 +0200
Message-Id: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.851.g0fc62a9785
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When we lock a reference like "foo" we need to handle the case where
"foo" exists, but is an empty directory. That's what this code added
in bc7127ef0f (ref locking: allow 'foo' when 'foo/bar' used to exist
but not anymore., 2006-09-30) seems like it should be dealing with.

Except it doesn't, and we never take this branch. The reason is that
when bc7127ef0f was written this looked like:

	ref = resolve_ref([...]);
	if (!ref && errno == EISDIR) {
	[...]

And in resolve_ref() we had this code:

	fd = open(path, O_RDONLY);
	if (fd < 0)
		return NULL;

I.e. we would attempt to read "foo" with open(), which would fail with
EISDIR and we'd return NULL. We'd then take this branch, call
remove_empty_directories() and continue.

Since a1c1d8170d (refs_resolve_ref_unsafe: handle d/f conflicts for
writes, 2017-10-06) we don't, because our our callstack will look
something like:

    files_copy_or_rename_ref() -> lock_ref_oid_basic() -> refs_resolve_ref_unsafe()

And then the refs_resolve_ref_unsafe() call here will in turn (in the
code added in a1c1d8170d) do the equivalent of this (via a call to
refs_read_raw_ref()):

	/* Via refs_read_raw_ref() */
	fd = open(path, O_RDONLY);
	if (fd < 0)
		/* get errno == EISDIR */
	/* later, in refs_resolve_ref_unsafe() */
	if ([...] && errno != EISDIR)
		return NULL;
	[...]
	/* returns the refs/heads/foo to the caller, even though it's a directory */
	return refname;

I.e. even though we got an "errno == EISDIR" we won't take this
branch, since in cases of EISDIR "resolved" is always
non-NULL. I.e. we pretend at this point as though everything's OK and
there is no "foo" directory.

We then proceed with the entire ref update and don't call
remove_empty_directories() until we call commit_ref_update(). See
5387c0d883 (commit_ref(): if there is an empty dir in the way, delete
it, 2016-05-05) for the addition of that code.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---

While working on a re-roll of the review/helping out Han-Wen with the
refs backend at [1] I discovered that this codepath in
lock_ref_oid_basic() has been unused for some time. In that series I
added a BUG() to it[2], but it's even better to remove it entirely.

I'll submit any proposed re-roll of [1] on top of this, I thought it
was better to review this isolated and more easily understood change
on its own.

1. https://lore.kernel.org/git/cover-00.17-00000000000-20210711T162803Z-avarab@gmail.com
2. https://lore.kernel.org/git/patch-07.17-10a40c9244e-20210711T162803Z-avarab@gmail.com/

 refs/files-backend.c | 20 --------------------
 1 file changed, 20 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 677b7e4cdd..7e4963fd07 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -941,26 +941,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	resolved = !!refs_resolve_ref_unsafe(&refs->base,
 					     refname, resolve_flags,
 					     &lock->old_oid, type);
-	if (!resolved && errno == EISDIR) {
-		/*
-		 * we are trying to lock foo but we used to
-		 * have foo/bar which now does not exist;
-		 * it is normal for the empty directory 'foo'
-		 * to remain.
-		 */
-		if (remove_empty_directories(&ref_file)) {
-			last_errno = errno;
-			if (!refs_verify_refname_available(
-					    &refs->base,
-					    refname, extras, skip, err))
-				strbuf_addf(err, "there are still refs under '%s'",
-					    refname);
-			goto error_return;
-		}
-		resolved = !!refs_resolve_ref_unsafe(&refs->base,
-						     refname, resolve_flags,
-						     &lock->old_oid, type);
-	}
 	if (!resolved) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
-- 
2.32.0.851.g0fc62a9785

