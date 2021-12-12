Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21C20C433FE
	for <git@archiver.kernel.org>; Sun, 12 Dec 2021 19:54:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbhLLTyY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Dec 2021 14:54:24 -0500
Received: from mail-wr1-f44.google.com ([209.85.221.44]:43671 "EHLO
        mail-wr1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbhLLTyX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Dec 2021 14:54:23 -0500
Received: by mail-wr1-f44.google.com with SMTP id v11so23771786wrw.10
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 11:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qhaYRhJZTACOiihVePthHF9jvWxTZRfxx3ZJEd09pNE=;
        b=SxW1LmC7WPza0rGmIuKdThHnftcZ6Xf/oUqQjGAm+Y534d//bCxcaLQmtDYlrgUhac
         m88Civ4RA/d6M1axXPN0wQ+NQVpq353uDXQq4OdV3T+t0P7nMBo/0L1mQneWwN7zgvix
         no4X+MQb9asRMd0DUPcPe8T32msMw38mIV/Fg6KM5/UAOdYd0yHDnAZZJevEyLcwWAPM
         jeWbw3LRX/9UEquAzIIsbLxPwUBuoJOR7+IVdxC6ik6DfxYvJAtRFRW8fjGU53DfD7+W
         yadVv2RcUDaUAa1yi0d44Qck8BAw2kX+NnQYl1ZlUV3tsKwb2nGxgb4r3sMQLEMmdUL1
         V7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qhaYRhJZTACOiihVePthHF9jvWxTZRfxx3ZJEd09pNE=;
        b=o8/veVfWyN2ghG8jOmiH8/hbUZd6OzxcDXSMuSMo0jagO5FNcx6PN5LymdJRj1llNJ
         CLw82JJl7MeniR8JtGNGlBEvRG61pU6ANzz4gWDVb2OvJWPFIc/NFUr03e/wcnD9ldlq
         IMTyVzlWlgLd5LpxN0DLmDMIgWMIb8JND76OfqNRCCKD46JqSDE3M6wF6aKT+/Sl5fhr
         zhYex5++76U7MtvxOIMTBP9Cz48AvaWRmnnYlADbhSp1AuLxleLgNECKLpzCSKU/UCMf
         z0MpZKfDsONus6Pyz0TMKrq1tjfYXq/HWSgs7dRaWj1eEhbsDvVpT8eoreHfxqA4hDAg
         EmDg==
X-Gm-Message-State: AOAM530gt+RIulxPUXMpf1AIkUP3TZxs0QeTlEr9UyS20a0kogKSWE5s
        sM/brG3tGxInp7Xw9BKGKFc/nxuPa3c45A==
X-Google-Smtp-Source: ABdhPJzVq1JZiT9zs98rq04uNAyl3EOP7dHQHy4RgdklRYt+/BARdpsIHUtWB0hSGT6HRfL2aVXwQQ==
X-Received: by 2002:a5d:480c:: with SMTP id l12mr27883918wrq.518.1639338802522;
        Sun, 12 Dec 2021 11:53:22 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id g198sm5494323wme.23.2021.12.12.11.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Dec 2021 11:53:22 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han-Wen Nienhuys <hanwen@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/3] refs API: use "failure_errno", not "errno"
Date:   Sun, 12 Dec 2021 20:53:11 +0100
Message-Id: <patch-v2-1.3-161fcad1578-20211212T195108Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.929.ge922d848c7a
In-Reply-To: <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
References: <cover-0.3-00000000000-20211209T045735Z-avarab@gmail.com> <cover-v2-0.3-00000000000-20211212T195108Z-avarab@gmail.com>
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
index 4338875d86b..6cc845c7ac2 100644
--- a/refs.c
+++ b/refs.c
@@ -1721,8 +1721,6 @@ const char *refs_resolve_ref_unsafe(struct ref_store *refs,
 		if (refs_read_raw_ref(refs, refname, oid, &sb_refname,
 				      &read_flags, failure_errno)) {
 			*flags |= read_flags;
-			if (errno)
-				*failure_errno = errno;
 
 			/* In reading mode, refs must eventually resolve */
 			if (resolve_flags & RESOLVE_REF_READING)
diff --git a/refs/files-backend.c b/refs/files-backend.c
index 237a2afb5d7..fd34d344c30 100644
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
2.34.1.929.ge922d848c7a

