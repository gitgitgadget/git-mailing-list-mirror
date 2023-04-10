Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 372E4C77B61
	for <git@archiver.kernel.org>; Mon, 10 Apr 2023 22:53:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229914AbjDJWxq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Apr 2023 18:53:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbjDJWxj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Apr 2023 18:53:39 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C7AE1FF9
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:37 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id ch3so7303950ybb.4
        for <git@vger.kernel.org>; Mon, 10 Apr 2023 15:53:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112; t=1681167216; x=1683759216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B4FTR6K5zz6BX79OARH6llxCs8zdC5FF/Zl7jOYTtVQ=;
        b=EYIRmaDPlRuhwTiHZeY1XAcf4QBA2/Susvp/bN+LS5JDqrwUt+z092guKDBDKRllwJ
         RI9Af3fKtxm6r0KAD7GSx+6O7AnqYr4qmTKgqHgjvM9OvtIHGi3Rmrs6Uf+4CSpLS7ht
         ZheBjdiFRpyf1u938Ote25N5uitp3XeOirBDFwP1CU6cR2NfyBkS7iJtQsq8SBZLw2Ot
         eqfqy2zieXSskFDLhloPt6PRGYBtl0yiQ8DqA0mnT5aHN82ev7VPzZGkbtEdU/Lf0wU4
         9CJHDkYAtmccyES4rHeCHk+/vayDGEO/rJlv8fh+RJ47kAlUv8uwLLF2SWfRNV6QZBht
         +lCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681167216; x=1683759216;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B4FTR6K5zz6BX79OARH6llxCs8zdC5FF/Zl7jOYTtVQ=;
        b=l/+Qo1q1ROdisqc47X4Th3viLWFKMqVNmnW/uOOAR5yMvlGYel0OUE6VrfZviNlMz/
         SgDtgQzuXE+4OFYwl5lPIWLRZNQqvuwPNoxObM02VdaVpvq6bCdfPga/8414x+2blwjt
         qhl4Qu7ExdeR0EX6bPmY97CmNIi40j6W5FeD5iWcKks83wQISQ5ioYQZld6moovg7RxB
         uQVwAJWFL3y59/AJVXJWzlj2uuWbhPQeNmWVfE21Zurp5vY/Txs620Twp1B7ofgoaHYr
         C3O5CcNWU6Nmg2WVblgV4vshHcjmVfziYxSbOfW0jfGw4IZszDKfyqGdbOy5yZy5bnjO
         kgNA==
X-Gm-Message-State: AAQBX9cbxwFbrf9VQQkFQGDfAB7qACXzb8g4TiWyITn/Otwoa+afOqax
        c6K5vq3eNxYz2/G6TM7kk8MGeewK4dntQaAFYOWmXA==
X-Google-Smtp-Source: AKy350byeQKpc1nqH8UqrhWsYwAhhpTrp77OPStNK5kPP31T3F60zEr8fipaqifyd5ltcmnAyBzhiQ==
X-Received: by 2002:a25:348d:0:b0:b8e:411c:b85e with SMTP id b135-20020a25348d000000b00b8e411cb85emr8420291yba.23.1681167216044;
        Mon, 10 Apr 2023 15:53:36 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l5-20020a25bcc5000000b00b7767ca7484sm2132971ybm.33.2023.04.10.15.53.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Apr 2023 15:53:35 -0700 (PDT)
Date:   Mon, 10 Apr 2023 18:53:34 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 4/7] pack-revindex: introduce GIT_TEST_REV_INDEX_DIE_ON_DISK
Message-ID: <0f368e2347e10325d0c5a34939191994aa8899b9.1681166596.git.me@ttaylorr.com>
References: <cover.1681166596.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1681166596.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In ec8e7760ac (pack-revindex: ensure that on-disk reverse indexes are
given precedence, 2021-01-25), we introduced
GIT_TEST_REV_INDEX_DIE_IN_MEMORY to abort the process when Git generated
a reverse index from scratch.

ec8e7760ac was about ensuring that Git prefers a .rev file when
available over generating the same information in memory from scratch.

In a subsequent patch, we'll introduce `pack.readReverseIndex`, which
may be used to disable reading ".rev" files when available. In order to
ensure that those files are indeed being ignored, introduce an analogous
option to abort the process when Git reads a ".rev" file from disk.

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 pack-revindex.c | 3 +++
 pack-revindex.h | 1 +
 2 files changed, 4 insertions(+)

diff --git a/pack-revindex.c b/pack-revindex.c
index e3d69cc0f7..44e1b3fed9 100644
--- a/pack-revindex.c
+++ b/pack-revindex.c
@@ -205,6 +205,9 @@ static int load_revindex_from_disk(char *revindex_name,
 	size_t revindex_size;
 	struct revindex_header *hdr;
 
+	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_ON_DISK, 0))
+		die("dying as requested by '%s'", GIT_TEST_REV_INDEX_DIE_ON_DISK);
+
 	fd = git_open(revindex_name);
 
 	if (fd < 0) {
diff --git a/pack-revindex.h b/pack-revindex.h
index 3d1969ce8b..ef8afee88b 100644
--- a/pack-revindex.h
+++ b/pack-revindex.h
@@ -36,6 +36,7 @@
 
 #define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
 #define GIT_TEST_REV_INDEX_DIE_IN_MEMORY "GIT_TEST_REV_INDEX_DIE_IN_MEMORY"
+#define GIT_TEST_REV_INDEX_DIE_ON_DISK "GIT_TEST_REV_INDEX_DIE_ON_DISK"
 
 struct packed_git;
 struct multi_pack_index;
-- 
2.40.0.323.g9c80379958

