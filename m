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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BF75C12002
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 66FB6613E8
	for <git@archiver.kernel.org>; Fri, 16 Jul 2021 14:13:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240562AbhGPOQe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Jul 2021 10:16:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240459AbhGPOQY (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Jul 2021 10:16:24 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3199C0613DC
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:27 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id l6so5971020wmq.0
        for <git@vger.kernel.org>; Fri, 16 Jul 2021 07:13:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=cqO+qBRoNA+WC46tZBm3MxJFpnM20dKP2YQI5gBuOII=;
        b=SpL0UU3A7TkqKoQAmLL22pZgZK+WTT9N5hgwA2mrqgzx9Y3G+SiTDoXcF3sWPgqWxF
         Pc3p0vNCjj+7W0i65sbBEuhPNbzVX0zoz8JS4sa+404wn3PIiS78rqlveL+p6Z6cO9eP
         ziRi3FXg+H/QV7fUcOXi1ZmEbr4Zlt/5sGNQpHaNNhbnNVyFAqPpMamr7M0DYZMFhJCY
         viON7GGt7jQdYcwHF3qnwxVzR4m8G5ydwC/ATOkDmkQqWATS3ho6GXEYTWo2TNwhIUTM
         Xoprza4rLQmdazKtX0dtpqnAtnT22oyB8R0xhURS8UtBAlnJBI5pmFh8JPITv0EvyJlj
         66Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=cqO+qBRoNA+WC46tZBm3MxJFpnM20dKP2YQI5gBuOII=;
        b=Zb1vV0jXFTSu8GwhYImUr0NT3INsIJrY0LkSFcgQlkUaJGdw/xm8yqHtJQmpWt81kL
         KkCznJUPnoKTzADZrX0NjOwHY0RT2j7IcTt1k08Z85c74a9N/8QNGP1TZ5LVPYET4hiM
         O45pOBcf2k6K0E9VOQZCifdzo44UEhvAw5jgG1bTmPzR4I75JyX3Kc45n+oVozRJo3YS
         u9uB8pDo7qqWh73zFlgb7aHQXSpxamGJKhTtCMy/loOv62QgQiS/7lfLOj8HEfc88Ot0
         cE5VFmX5EL29dBV+Kx72LEmybS/bd5N1QUIlRHw9nIhY/388sNC+JUfzBu0jKlPKEaKj
         dZBg==
X-Gm-Message-State: AOAM530fn4YM/W+MR1NnJi0uqbeUCcSHwv8RnP+zQMAgyO1x3qonEc7y
        zq3Jq0DK8HWHjkkSy1qIDIKyUbWwxx6rDQ==
X-Google-Smtp-Source: ABdhPJz/FwXic6GMoNnmyO2qRBpkODFReRW0aU9vMlhm4dewQehdr4KhJeoOam9eTbAefFrNPv5Qug==
X-Received: by 2002:a1c:3c42:: with SMTP id j63mr10798736wma.35.1626444806024;
        Fri, 16 Jul 2021 07:13:26 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id a9sm10101363wrv.37.2021.07.16.07.13.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 07:13:25 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 11/11] refs/files: remove unused "errno == EISDIR" code
Date:   Fri, 16 Jul 2021 16:13:07 +0200
Message-Id: <patch-11.11-96c3e5e9f79-20210716T140631Z-avarab@gmail.com>
X-Mailer: git-send-email 2.32.0.874.gfa1990a4f10
In-Reply-To: <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
References: <patch-1.1-de0838fe99-20210714T111351Z-avarab@gmail.com> <cover-00.11-00000000000-20210716T140631Z-avarab@gmail.com>
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
index 3e7598cc86c..bd99bc570de 100644
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
2.32.0.873.gb6f2f696497

