Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 01BEE1F85E
	for <e@80x24.org>; Thu, 12 Jul 2018 19:40:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbeGLTvO (ORCPT <rfc822;e@80x24.org>);
        Thu, 12 Jul 2018 15:51:14 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:35826 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732235AbeGLTvN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Jul 2018 15:51:13 -0400
Received: by mail-qt0-f194.google.com with SMTP id a5-v6so10633828qtp.2
        for <git@vger.kernel.org>; Thu, 12 Jul 2018 12:40:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y4f3gCMF9dj4ajE/lDxFvEAp3akbuwm6P6gvROLk8fQ=;
        b=dedb+J8TunwMBjwhTWAMmOlzw4JmygrhYkAe7jfMay0FHCpl3wb9VosI+sUTiCJk03
         Ri2IIUvjLK84FGKZvEp+cItc4seBckX9wkSPES2yM15lPJeontEV+OI8wP0kIgFOa9pg
         cBhzzLDZ24xX5ckMDSCOl5rJ2F0qog7lFHId+iLFSH1Yeos90PLnzcAHmg4mYCzbRrzY
         slxuIya63J8WA/H63TfCQRcdfqA1M22dJmYvk1eyPs2dfzfOKxOSoiYTgsrPUM4LPAG1
         urpk/paU+zqzaKxZeet+dmMfBkluztgilEAGJq4H4jrQLLlj4RLoZhISC2AB/hGK6Ii3
         6ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y4f3gCMF9dj4ajE/lDxFvEAp3akbuwm6P6gvROLk8fQ=;
        b=BMAdfuKmpvKGvwefQSV+jGbvq/ZgbAeUM7oXCqcfcUMBG/piiVX7pYdbXWRqfMH7fX
         Zk+8ruF4g7qRanJLKJYL9EusPKwoP1pXAI6Y1F716r3mWhMSzg+LYT9VWW7nrThGRzy0
         UlrWRqJ8685BG8GJzv1O9+mnazYTthKS5aQJjPFq3LcXnKRe68Y3/Y6RdsKPXpJdrKTc
         f2luYxUw7xsbBl6ca+SrZiWKUfrZdq11nwVkfRt9FUaWaftVmyr/Rb3qB+LrjtQeQMj0
         qppDeM3pPiBT0GUItpIxgECSpfE0WNgL0332riZUooV4hW8SlmSVuthC2nXw/lxkGRmU
         5+bw==
X-Gm-Message-State: AOUpUlHGtw9PHh19YxhauVRZaxxoiu03usW19m6n7Jww0zQ7ecLWYzHe
        WLrLR9CWYeju+oanZ10xZxRk0iSOTac=
X-Google-Smtp-Source: AAOMgpcMASaKrJAsbYV9noGu2wrmei7oO9ydD2Lio7TmraXrn9vOa9mpKrMK+etNywjRNmrpjD1I5Q==
X-Received: by 2002:ac8:3885:: with SMTP id f5-v6mr3213256qtc.337.1531424412823;
        Thu, 12 Jul 2018 12:40:12 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id j5-v6sm14247756qte.57.2018.07.12.12.40.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 12 Jul 2018 12:40:12 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org, dstolee@microsoft.com
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, sunshine@sunshineco.com, szeder.dev@gmail.com
Subject: [PATCH v4 05/23] midx: write header information to lockfile
Date:   Thu, 12 Jul 2018 15:39:22 -0400
Message-Id: <20180712193940.21065-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180712193940.21065-1-dstolee@microsoft.com>
References: <20180706005321.124643-1-dstolee@microsoft.com>
 <20180712193940.21065-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

As we begin writing the multi-pack-index format to disk, start with
the basics: the 12-byte header and the 20-byte checksum footer. Start
with these basics so we can add the rest of the format in small
increments.

As we implement the format, we will use a technique to check that our
computed offsets within the multi-pack-index file match what we are
actually writing. Each method that writes to the hashfile will return
the number of bytes written, and we will track that those values match
our expectations.

Currently, write_midx_header() returns 12, but is not checked. We will
check the return value in a later commit.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 50 +++++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh |  4 ++-
 2 files changed, 53 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 32468db1a2..f85f2d334d 100644
--- a/midx.c
+++ b/midx.c
@@ -1,7 +1,57 @@
 #include "cache.h"
+#include "csum-file.h"
+#include "lockfile.h"
 #include "midx.h"
 
+#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
+#define MIDX_VERSION 1
+#define MIDX_HASH_VERSION 1
+#define MIDX_HEADER_SIZE 12
+
+static char *get_midx_filename(const char *object_dir)
+{
+	return xstrfmt("%s/pack/multi-pack-index", object_dir);
+}
+
+static size_t write_midx_header(struct hashfile *f,
+				unsigned char num_chunks,
+				uint32_t num_packs)
+{
+	unsigned char byte_values[4];
+
+	hashwrite_be32(f, MIDX_SIGNATURE);
+	byte_values[0] = MIDX_VERSION;
+	byte_values[1] = MIDX_HASH_VERSION;
+	byte_values[2] = num_chunks;
+	byte_values[3] = 0; /* unused */
+	hashwrite(f, byte_values, sizeof(byte_values));
+	hashwrite_be32(f, num_packs);
+
+	return MIDX_HEADER_SIZE;
+}
+
 int write_midx_file(const char *object_dir)
 {
+	unsigned char num_chunks = 0;
+	char *midx_name;
+	struct hashfile *f = NULL;
+	struct lock_file lk;
+
+	midx_name = get_midx_filename(object_dir);
+	if (safe_create_leading_directories(midx_name)) {
+		UNLEAK(midx_name);
+		die_errno(_("unable to create leading directories of %s"),
+			  midx_name);
+	}
+
+	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
+	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
+	FREE_AND_NULL(midx_name);
+
+	write_midx_header(f, num_chunks, 0);
+
+	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	commit_lock_file(&lk);
+
 	return 0;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index ec3ddbe79c..50e80f8f2c 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -4,7 +4,9 @@ test_description='multi-pack-indexes'
 . ./test-lib.sh
 
 test_expect_success 'write midx with no packs' '
-	git multi-pack-index --object-dir=. write
+	test_when_finished rm -f pack/multi-pack-index &&
+	git multi-pack-index --object-dir=. write &&
+	test_path_is_file pack/multi-pack-index
 '
 
 test_done
-- 
2.18.0.118.gd4f65b8d14

