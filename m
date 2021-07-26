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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18DA9C4320A
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F2DEB60F5D
	for <git@archiver.kernel.org>; Mon, 26 Jul 2021 23:44:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234187AbhGZXET (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 26 Jul 2021 19:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234251AbhGZXEN (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 26 Jul 2021 19:04:13 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB41C061757
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:40 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id f18-20020a05600c4e92b0290253c32620e7so334850wmq.5
        for <git@vger.kernel.org>; Mon, 26 Jul 2021 16:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=y4sr9BQbSFmTjxhb3lc/2Y804+UZrUNMSPLVP1noSdk=;
        b=hBYveq8NBjHTYQWDmUptfXg+Usxz2xpFRR6Q6/OQBhrnPIl+xH8q8mhJ3M15rKDPrx
         EFECMtiohh68zERFVcjTL9/LhCvNQRJNe4N/jZedxqb8r17QkFtBq2PNneJBsofwAXNS
         jKU7ZN+bwrj60rFSCN1BdaA51Q0IImgKLthYBes0mvLoeovv/bQ79rsIwU3fUDIz4lBt
         E5VrR/DNA1ewyc7ylJ/2wkiKjXkSPFsHXHA2f0SCSv7wY6vy99QtrFcak3qq8lxBFRll
         OSax+3RBKfDxxOZmptzv+l5yg8cRkurD1KP6uNs+UVfe511/09QjW54XwC4P2WPttHmN
         PTPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y4sr9BQbSFmTjxhb3lc/2Y804+UZrUNMSPLVP1noSdk=;
        b=d5d37gbo4siBi4ZUnXJWoXK/ExeFVkJ1oA5ODJE6n/KvJYQu3ePi5HhKv6WmN3dAiA
         vrhSWQ4U187Z0FCdVcmK0OijCvWsM5zvVvNGkn/Of3YwLiFOUyy79xNFw3R0aR3ajX8V
         csNp4bGTVKxuk4BbVqMlezRfPxfgd7IxJ2aMDmqSOdfWxFCsa+7oTaORvGeqxKPaSHWU
         zMk0tFPzyA5FMG2df2yoZF3N3au3P4RmwHM3QhlUn/XGG2VWy6Vs47+Hu6Q4VOwQvb78
         i+CKUBr6hkhFjA8f1egvVSNQrNx+6oDIgh8d8H2Luu7arqklgm4CWgcxSXX+EWdhtwQd
         7//Q==
X-Gm-Message-State: AOAM531fwRBVQQkNhCH+u8F7m44PO1r/hpjfjA04/O3nvGTWpoVAsw9J
        icB36ka4848jGdObAtRuqgTF+kEU9TX6JQ==
X-Google-Smtp-Source: ABdhPJwQWu9CjkXSRGkWG4CABRzrrYOJIfZThf3bWF1l9TVWZos4m8+CUiJQUPahJaw/7Ri46kXx1Q==
X-Received: by 2002:a1c:730d:: with SMTP id d13mr1245341wmb.129.1627343079028;
        Mon, 26 Jul 2021 16:44:39 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id n18sm1214545wrt.89.2021.07.26.16.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Jul 2021 16:44:38 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 10/11] refs/files: remove unused "errno == EISDIR" code
Date:   Tue, 27 Jul 2021 01:44:26 +0200
Message-Id: <patch-10.11-009abc9968-20210726T234237Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.988.g1a6a4b2c5f
In-Reply-To: <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
References: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com> <cover-00.11-0000000000-20210726T234237Z-avarab@gmail.com>
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
writes, 2017-10-06) we don't. E.g. in the case of
files_copy_or_rename_ref() our callstack will look something like:

	[...] ->
	files_copy_or_rename_ref() ->
	lock_ref_oid_basic() ->
	refs_resolve_ref_unsafe()

At that point the first (now only) refs_resolve_ref_unsafe() call in
lock_ref_oid_basic() would do the equivalent of this in the resulting
call to refs_read_raw_ref() in refs_resolve_ref_unsafe():

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
it, 2016-05-05) for the addition of that code, and
a1c1d8170db (refs_resolve_ref_unsafe: handle d/f conflicts for writes,
2017-10-06) for the commit that changed the original codepath added in
bc7127ef0f to use this "EISDIR" handling.

Further historical commentary:

Before the two preceding commits the caller in files_reflog_expire()
was the only one out of our 4 callers that would pass non-NULL as an
oid. We would then set a (now gone) "resolve_flags" to
"RESOLVE_REF_READING" and just before that "errno != EISDIR" check do:

	if (resolve_flags & RESOLVE_REF_READING)
		return NULL;

There may have been some case where this ended up mattering and we
couldn't safely make this change before we removed the "oid"
parameter, but I don't think there was, see [1] for some discussion on
that.

In any case, now that we've removed the "oid" parameter in a preceding
commit we can be sure that this code is redundant, so let's remove it.

1. http://lore.kernel.org/git/871r801yp6.fsf@evledraar.gmail.com

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs/files-backend.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 98d9aa1601..28cd8853f5 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -883,7 +883,6 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	struct strbuf ref_file = STRBUF_INIT;
 	struct ref_lock *lock;
 	int last_errno = 0;
-	int resolved;
 
 	files_assert_main_repository(refs, "lock_ref_oid_basic");
 	assert(err);
@@ -891,30 +890,9 @@ static struct ref_lock *lock_ref_oid_basic(struct files_ref_store *refs,
 	CALLOC_ARRAY(lock, 1);
 
 	files_ref_path(refs, &ref_file, refname);
-	resolved = !!refs_resolve_ref_unsafe(&refs->base, refname,
-					     RESOLVE_REF_NO_RECURSE,
-					     &lock->old_oid, type);
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
-					    refname, NULL, NULL, err))
-				strbuf_addf(err, "there are still refs under '%s'",
-					    refname);
-			goto error_return;
-		}
-		resolved = !!refs_resolve_ref_unsafe(&refs->base, refname,
-						     RESOLVE_REF_NO_RECURSE,
-						     &lock->old_oid, type);
-	}
-	if (!resolved) {
+	if (!refs_resolve_ref_unsafe(&refs->base, refname,
+				     RESOLVE_REF_NO_RECURSE,
+				     &lock->old_oid, type)) {
 		last_errno = errno;
 		if (last_errno != ENOTDIR ||
 		    !refs_verify_refname_available(&refs->base, refname,
-- 
2.32.0.956.g6b0c84ceda8

