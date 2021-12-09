Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0489C433F5
	for <git@archiver.kernel.org>; Thu,  9 Dec 2021 05:02:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbhLIFGH (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 9 Dec 2021 00:06:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhLIFGG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Dec 2021 00:06:06 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E992C061746
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 21:02:33 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o29so3280454wms.2
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 21:02:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tZYhGEt+AJ8HAc6PMropnN6+V4rpcSc0cz6oFWeUIiw=;
        b=V8vIhdxGoFR3vZkBFnXPEWfaK1c6gnrsEp0MHs2u+WWc5VoZXvXvbtSLiPcVh1EP+5
         mcZLp2Q94gQ37EdGiOrfs7zgxPkx5WlYPK6aEd+Fg7aOpHq4dWp5sHkuszq73atkMLn1
         FE23vprgz0xbI2RfMzNLt93Om/xoQQVKY5mtaJvIdO2SE4SkXTnceVvIvsml8epiFBEa
         Rsygvju9kgo5XrFvPv4+U/kln4/HmmgPG8yymhrUSsldJUhx3Xtif7z+8L3b3u7dgEEC
         DAALDeggZte6gBvdnX/vq079b49seB259bhf+GBwPhnFNhjLocZBH0Kn31G/7ilFPmVI
         cwyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tZYhGEt+AJ8HAc6PMropnN6+V4rpcSc0cz6oFWeUIiw=;
        b=56pKt38MsEP8hf3npBotnYk/IUuafCJ3A6ex/UYFo2x/xXRrmjTJNT9gYZviKw9ued
         UnnJB2J+nHTi8TV4L4KfPzcm6Sqcgcbva1OkK8Nu+SHjpzuneS7I4uV7W+UbtV8F8NQ2
         3DaHmRvaiQ+O24Vu5UE7h4PyeDSjS3sU305CiQJiXZv+GUp3XjevfNwK8nQbo2qrCJWp
         tyDW8HJPbqTtrKLtjRJpEJ+XalPp0gFnFQFuCHZSGXX1TczJQ7EzpBs40BhruSkAfBed
         MQYsLxS24pUJ4ZGg3tEYleIC1OhfzXa7Mo4ySQ7ZaAh3EavMVGmZMig+/ZrG/xLaCuxU
         u1HA==
X-Gm-Message-State: AOAM5317coFm/9B/imtdfe7grK6/gk5CoHRmwh6BaOjrcD6hCcT5vFng
        PfqNnziNPGazowWzuxMIX73rzGJyqADqyw==
X-Google-Smtp-Source: ABdhPJxFn5P38azaNHgq2LG31YVWa1WbLBFnAEq4NqwDpHkJst/5ZDPHv+MxI3ME/8m3hZXxHd9lYg==
X-Received: by 2002:a1c:7e41:: with SMTP id z62mr4379516wmc.62.1639026151845;
        Wed, 08 Dec 2021 21:02:31 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id w22sm4270394wmi.27.2021.12.08.21.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 21:02:31 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/3] refs API: use "failure_errno", not "errno"
Date:   Thu,  9 Dec 2021 06:02:26 +0100
Message-Id: <patch-1.3-b983d3b6033-20211209T045735Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.930.g218b4aae189
In-Reply-To: <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com>
References: <xmqqo85q2a42.fsf@gitster.g> <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a logic error in refs_resolve_ref_unsafe() introduced in a recent
series of mine to abstract the refs API away from errno. See
96f6623ada0 (Merge branch 'ab/refs-errno-cleanup', 2021-11-29)for that
series.

In that series introduction of "failure_errno" to
refs_resolve_ref_unsafe came in ef18119dec8 (refs API: add a version
of refs_resolve_ref_unsafe() with "errno", 2021-10-16). There we'd set
"errno = 0" immediately before refs_read_raw_ref(), and then set
"failure_errno" to "errno" if errno was non-zero afterwards.

Then in the next commit 8b72fea7e91 (refs API: make
refs_read_raw_ref() not set errno, 2021-10-16) we started expecting
"refs_read_raw_ref()" to set "failure_errno". It would do that if
refs_read_raw_ref() failed, but it wouldn't be the same errno.

So we might set the "errno" here to any arbitrary bad value, and end
up e.g. returning NULL when we meant to return the refname from
refs_resolve_ref_unsafe(), or the other way around. Instrumenting this
code will reveal cases where refs_read_raw_ref() will fail, and
"errno" and "failure_errno" will be set to different values.

In practice I haven't found a case where this scary bug changed
anything in practice. The reason for that is that we'll not care about
the actual value of "errno" here per-se, but only whether:

 1. We have an errno
 2. If it's one of ENOENT, EISDIR or ENOTDIR. See the adjacent code
    added in a1c1d8170db (refs_resolve_ref_unsafe: handle d/f
    conflicts for writes, 2017-10-06)

I.e. if we clobber "failure_errno" with "errno", but it happened to be
one of those three, and we'll clobber it with another one of the three
we were OK.

Perhaps there are cases where the difference ended up mattering, but I
haven't found them. Instrumenting the test suite to fail if "errno"
and "failure_errno" are different shows a lot of failures, checking if
they're different *and* one is but not the other is outside that list
of three "errno" values yields no failures.

But let's fix the obvious bug. We should just stop paying attention to
"errno" in refs_resolve_ref_unsafe(). In addition let's change the
partial resetting of "errno" in files_read_raw_ref() to happen just
before the "return", to ensure that any such bug will be more easily
spotted in the future.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 refs.c               | 2 --
 refs/files-backend.c | 3 +--
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/refs.c b/refs.c
index 996ac271641..533cf5a2b2e 100644
--- a/refs.c
+++ b/refs.c
@@ -1714,8 +1714,6 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
 				      &read_flags, failure_errno)) {
 			*flags |= read_flags;
-			if (errno)
-				*failure_errno = errno;
 
 			/* In reading mode, refs must eventually resolve */
 			if (resolve_flags & RESOLVE_REF_READING)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 4b14f30d48f..85e195a2573 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -387,7 +387,6 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	if (lstat(path, &st) < 0) {
 		int ignore_errno;
 		myerr = errno;
-		errno = 0;
 		if (myerr != ENOENT)
 			goto out;
 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
@@ -404,7 +403,6 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		strbuf_reset(&sb_contents);
 		if (strbuf_readlink(&sb_contents, path, st.st_size) < 0) {
 			myerr = errno;
-			errno = 0;
 			if (myerr == ENOENT || myerr == EINVAL)
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
@@ -474,6 +472,7 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
+	errno = 0;
 	return ret;
 }
 
-- 
2.34.1.930.g218b4aae189

