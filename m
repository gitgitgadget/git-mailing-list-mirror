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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E12C6377B
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8F51861244
	for <git@archiver.kernel.org>; Tue, 20 Jul 2021 10:31:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237649AbhGTJtk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 20 Jul 2021 05:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237661AbhGTJqO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 20 Jul 2021 05:46:14 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F1DC0612FB
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:33 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id d12so25375858wre.13
        for <git@vger.kernel.org>; Tue, 20 Jul 2021 03:24:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=JGXV+68aFUcskTXeUCqz/dzjmM5gL9BbXpptl8bSzE8=;
        b=PSbeiWkWfJwYoZvJo0bIVV/uJra+SqckuhitF+uNq7bb7bwlUbMAiA52Z0RXJSptr9
         dMWeZ6CClyDbi6BZMnE/3A4QyH/qAjQWqqZeL8RubWBVrqpEc0LgYA4AH3j/AcN+2QYf
         KH/IWzGWqlVYioXj0oz562MkFBJiNiDfvimXT27WILARVumpV1vmBCip2Zy8lJK5cAMY
         NPPz7yETsAdSj75u3zw1+93vWwiZkFW5z7EZiq/UtWHOVhqnDxCcGPLaUEJhhH4SULaP
         08yoWXDUKdZZnmPoIhM9NIi59wCS3zYLRMLC4p1qKQ9jkQ8lkRR8keZVuPmCsLSPbaAl
         0/Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=JGXV+68aFUcskTXeUCqz/dzjmM5gL9BbXpptl8bSzE8=;
        b=Y5lYMugbt8m+/eJtXLnY40Bnjj0P09TPWKOCITCzbByBlINVxKpmN7J/YkNWRVojRF
         36Xusys3JbtVV0L/7kCVrHrX7VcfceN7+DnlNi6ZXpysR0zZpGfNfViq971XBrDEZQ6C
         PKDAmKbg+2j/uRndCAGScKuu/V4Z/jfeRElMnXY2bnIude50YNb8N5Y/tDR8NpmIJq3k
         PuBdnnTLvQtbdLjcjfaPE3T7j/9Rd3I7dfRUEu70HqcIxJLPIAvWE+REJhR035X72jwH
         7UINiApX0dYZbd6ZGT9nMJtcJ7OXX8UlP7J8eD7AkZrFBYt101iFE02b/F0MiSieIWCf
         iPqw==
X-Gm-Message-State: AOAM533DFskN1lvg3WKIs5nbvyjxzl8hJ3yamtdBwH/Pq+NjrWtjZFpl
        JX3VcVxzYWFzv2j+hX/TQ8jLBzds9m0RBA==
X-Google-Smtp-Source: ABdhPJw/Rr1J+Z99wg1+OH46hAFyDxjtv8sqhc/ZClVkRFWGeSmagv5RZB/uMUZfJbcr/t7epgRhuQ==
X-Received: by 2002:adf:9d88:: with SMTP id p8mr36282061wre.409.1626776672049;
        Tue, 20 Jul 2021 03:24:32 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l23sm9684536wme.22.2021.07.20.03.24.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Jul 2021 03:24:31 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 11/12] refs/files: remove unused "errno == EISDIR" code
Date:   Tue, 20 Jul 2021 12:24:16 +0200
Message-Id: <patch-11.12-8a71bbef972-20210720T102051Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.ge7a9d58bfcf
In-Reply-To: <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
References: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com> <cover-00.12-00000000000-20210720T102051Z-avarab@gmail.com>
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
index 8bbabc140b2..f83aa1063f4 100644
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
2.32.0.874.ge7a9d58bfcf

