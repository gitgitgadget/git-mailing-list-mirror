Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A51E8C433F5
	for <git@archiver.kernel.org>; Wed, 12 Jan 2022 12:37:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240219AbiALMhU (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Jan 2022 07:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353192AbiALMhN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Jan 2022 07:37:13 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88598C061748
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:37:13 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id l12-20020a7bc34c000000b003467c58cbdfso3369689wmj.2
        for <git@vger.kernel.org>; Wed, 12 Jan 2022 04:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+FUjQMgBV9PmXmN07z6HmR1g+5nmIvekvvXTUUve1qE=;
        b=Ywkd8KQHgyDpZPZ1HWDYLmFV0XzMcOU3YzzTAYn7GZSLjQodVQPmEsXwGVMMn0GUn7
         nYlTfdzFMO6EcyPCTcyxJ6LsnFHozsTuQEZxvkGAWirnbpZTCyUldX6dGnWP0lUIDAUF
         iC+O90rBvFLP4mouPrK1X3YZqQgVjzj61X5L/rpyTFXjYw8Zpr8DjUp5AUIMEMr1M9A5
         9p5R9FuLvGA41dN6c/FKeYqvymHhNvxsv5CC0CttP1PtTO+lFBaOcWNiA5c7RDvxxanp
         OU64KJgcGpJJslcjGVlD2m6KG9fSPDUu7ByvOX7IMf81LfFlgNxwfhHTDQCaAjbo3pdP
         W2nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+FUjQMgBV9PmXmN07z6HmR1g+5nmIvekvvXTUUve1qE=;
        b=sJOfYbKT/jMkfcbvQoKfG6IeJbL7nZAy0XJbAjocBxlRFz0Q/nAcKpP0AkB70NIYdt
         DDYQ6i8myVpWfiQuQAu3bwyQCWboW+WZ6+QVYKCO2QXrvECECXpCdVfROh4CcTFD1L2G
         h+omzoblYNUfWqnwRnBOsnE4YzTBcFMh+a51+mI5E4ZMmfKuHM+CLSVMwYr8Lmgj9Pq3
         8HQwsvDS1CVcQrq9kdwD480DoFxXHQcdik9m02bUb1pUPc+InXw21QdaWxUQR15aVo4l
         2bIH2ppGWdy4HIjeVc75v3CNhaFNWmzDlRP7LMwEe209sMIhblosRtYquR+6M3OOeZHJ
         D83w==
X-Gm-Message-State: AOAM532UH+863BGVgyqlIiI3f/D3A8dY8wvXaQWSdsrvvUda2nP0Nq/K
        VgEsB8mKr+d5CEJRAtBE9JQNCbKFuNsWnw==
X-Google-Smtp-Source: ABdhPJwQH2ILeHz5mTNlAUlKqtwVzYS82rLTYCxxj/2abWd9O4MtWn4s7h86d0JjVnqThkq/qxntIA==
X-Received: by 2002:a05:600c:1991:: with SMTP id t17mr6585569wmq.25.1641991031911;
        Wed, 12 Jan 2022 04:37:11 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3sm2919137wma.12.2022.01.12.04.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 04:37:11 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 1/3] refs API: use "failure_errno", not "errno"
Date:   Wed, 12 Jan 2022 13:36:46 +0100
Message-Id: <patch-v3-1.3-a45268ac24b-20220112T123117Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.0.rc0.848.gb9d3879eb1d
In-Reply-To: <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
References: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com> <cover-v3-0.3-00000000000-20220112T123117Z-avarab@gmail.com>
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
index bd2546ae230..addb26293b4 100644
--- a/refs.c
+++ b/refs.c
@@ -1722,8 +1722,6 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
 				      &read_flags, failure_errno)) {
 			*flags |= read_flags;
-			if (errno)
-				*failure_errno = errno;
 
 			/* In reading mode, refs must eventually resolve */
 			if (resolve_flags & RESOLVE_REF_READING)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index b529fdf237e..43a3b882d7c 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -382,7 +382,6 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 	if (lstat(path, &st) < 0) {
 		int ignore_errno;
 		myerr = errno;
-		errno = 0;
 		if (myerr != ENOENT)
 			goto out;
 		if (refs_read_raw_ref(refs->packed_ref_store, refname, oid,
@@ -399,7 +398,6 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 		strbuf_reset(&sb_contents);
 		if (strbuf_readlink(&sb_contents, path, st.st_size) < 0) {
 			myerr = errno;
-			errno = 0;
 			if (myerr == ENOENT || myerr == EINVAL)
 				/* inconsistent with lstat; retry */
 				goto stat_ref;
@@ -469,6 +467,7 @@ static int files_read_raw_ref(struct ref_store *ref_store, const char *refname,
 
 	strbuf_release(&sb_path);
 	strbuf_release(&sb_contents);
+	errno = 0;
 	return ret;
 }
 
-- 
2.35.0.rc0.848.gb9d3879eb1d

