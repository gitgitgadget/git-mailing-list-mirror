Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B51FEC433EF
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 18:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344529AbhLVSMA (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 22 Dec 2021 13:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231340AbhLVSL6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Dec 2021 13:11:58 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B925DC061574
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:11:57 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id c66so2141370wma.5
        for <git@vger.kernel.org>; Wed, 22 Dec 2021 10:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=NLNhtxkS7saYPa+ywEVQBzDkS2rCVcTTPKK1xJSF998=;
        b=OmLS3/+JdVr+bQb+Kh+QJY2MyisfnDthOOw3+EIU7Odn+jejEtrNZAf6PMRH9Jxdxx
         ZichAZ/w8D+H7gs27KBptoCF1iL/gkyjPjtdcG/eIBW17MWatf2x9Lx/kOdF6ycglmlU
         0BYI6Cs++IHN5VShRXmT6wh8BbZgDHf7NvNJPDIqTCb6e++eyQdEkZ3hoVhnkE0EE5uQ
         22feDv5Uoa/4zV2Nw1NqFmtezkQyvm/G7Mph6cbODZtsyro+xYYEKbp1PPp7zOUhfGj+
         ARVsYpZEQpoFLhVhbwLw7IXHrFrCDYhr5kCTZzEqy4JCoxbdLP/SxHPz2H9WWibSqm5y
         m7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=NLNhtxkS7saYPa+ywEVQBzDkS2rCVcTTPKK1xJSF998=;
        b=TTFf/O3MlhZSZgUZdXh4ZfQdtXgQ5Bzw8a1Fp69Pmxp9hPJAbl7vGEhR2qfgwSn+1F
         9YyPHWfgEkainDipMGrxtJ4fbwj3N7uzWtLwsxO4OJnrwEITppx7Vi6Rth0kxpEu9VFy
         i0+ftwOydx4G4W0YMJdHHCKUP4c1/ijRJPCLL9E6Ns4ZFm+aw3FRsTb4yu1MexqoIifv
         xowLhuNoZzkOIYn0tbDJBMDrPSztXrq2u4Wjptg63eOFnJnPTxbFrxbmqxXDQz5zwwiZ
         ahqLrcwRSJo/2l4M+Z0evhtVRvncZk2PFYxLIvKKfdqY8ejPnTE3ETy088qL5ZnW+UEr
         22Jw==
X-Gm-Message-State: AOAM531EV1Kfrz+UltxTL1HdfXJ5oFzgrnKcXlH2BgWtjP9d09OAazjX
        1vLbLfwrW09QZ2QiGzrhykwQ00Ks+Bc=
X-Google-Smtp-Source: ABdhPJwjTqf5/sHEn6TCgxFgjx1olRbMvuOw05Sv9IVnqE9crU3yVA7w0npPug7dTL6V4lT9a7aClg==
X-Received: by 2002:a1c:1f93:: with SMTP id f141mr1749326wmf.56.1640196716192;
        Wed, 22 Dec 2021 10:11:56 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m1sm2316105wme.39.2021.12.22.10.11.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:11:55 -0800 (PST)
Message-Id: <bfebb5f08fed835cedfd5373ba98c6e38519f882.1640196714.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com>
References: <pull.1163.git.git.1640090038.gitgitgadget@gmail.com>
        <pull.1163.v2.git.git.1640196714.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 22 Dec 2021 18:11:52 +0000
Subject: [PATCH v2 1/3] refs: pass gitdir to packed_ref_store_create
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Han-Wen Nienhuys <hanwen@google.com>

This is consistent with the calling convention for ref backend creation, and
avoids storing ".git/packed-refs" (the name of a regular file) in a variable called
ref_store::gitdir.

Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
---
 refs/files-backend.c  | 5 ++---
 refs/packed-backend.c | 9 +++++----
 refs/packed-backend.h | 2 +-
 3 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/refs/files-backend.c b/refs/files-backend.c
index 90b671025a7..f1b66130dfb 100644
--- a/refs/files-backend.c
+++ b/refs/files-backend.c
@@ -93,9 +93,8 @@ static struct ref_store *files_ref_store_create(struct repository *repo,
 
 	get_common_dir_noenv(&sb, gitdir);
 	refs->gitcommondir = strbuf_detach(&sb, NULL);
-	strbuf_addf(&sb, "%s/packed-refs", refs->gitcommondir);
-	refs->packed_ref_store = packed_ref_store_create(repo, sb.buf, flags);
-	strbuf_release(&sb);
+	refs->packed_ref_store =
+		packed_ref_store_create(repo, refs->gitcommondir, flags);
 
 	chdir_notify_reparent("files-backend $GIT_DIR", &refs->base.gitdir);
 	chdir_notify_reparent("files-backend $GIT_COMMONDIR",
diff --git a/refs/packed-backend.c b/refs/packed-backend.c
index 67152c664e2..caa1957252a 100644
--- a/refs/packed-backend.c
+++ b/refs/packed-backend.c
@@ -194,20 +194,21 @@ static int release_snapshot(struct snapshot *snapshot)
 }
 
 struct ref_store *packed_ref_store_create(struct repository *repo,
-					  const char *path,
+					  const char *gitdir,
 					  unsigned int store_flags)
 {
 	struct packed_ref_store *refs = xcalloc(1, sizeof(*refs));
 	struct ref_store *ref_store = (struct ref_store *)refs;
+	struct strbuf sb = STRBUF_INIT;
 
 	base_ref_store_init(ref_store, &refs_be_packed);
 	ref_store->repo = repo;
-	ref_store->gitdir = xstrdup(path);
+	ref_store->gitdir = xstrdup(gitdir);
 	refs->store_flags = store_flags;
+	strbuf_addf(&sb, "%s/packed-refs", gitdir);
+	refs->path = strbuf_detach(&sb, NULL);
 
-	refs->path = xstrdup(path);
 	chdir_notify_reparent("packed-refs", &refs->path);
-
 	return ref_store;
 }
 
diff --git a/refs/packed-backend.h b/refs/packed-backend.h
index f61a73ec25b..9dd8a344c34 100644
--- a/refs/packed-backend.h
+++ b/refs/packed-backend.h
@@ -14,7 +14,7 @@ struct ref_transaction;
  */
 
 struct ref_store *packed_ref_store_create(struct repository *repo,
-					  const char *path,
+					  const char *gitdir,
 					  unsigned int store_flags);
 
 /*
-- 
gitgitgadget

