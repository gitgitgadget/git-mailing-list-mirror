Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9D7F61F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934443AbeFYOfF (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:05 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:41920 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934325AbeFYOe6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:34:58 -0400
Received: by mail-qt0-f193.google.com with SMTP id y20-v6so12108234qto.8
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:34:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=XMp60e/gO6zifaiqgLGDR/xkHoqlvmw6JJ8ebP3Gsxk=;
        b=moDG6ykAA5YC8JFAEOKC8EmcnoIk6ipDP22Z/e0eZrsd46g/eaDfQP3nvbtHVh7+RL
         tzJQZevY8iDoEcPrAzewTy4yT6dTGmBZwDXf09PdDrSsFuWYlzucEMzh5aSZ1QFEg1+X
         JwncqlyU3IzzLjk+ff23krknHrKsQnzNqyhMqHVp1TXGK33TlBw3oHTtiX+LsLKXis4J
         WKhCrZPk0fYNvD3DmhLtydQH06cYg8JepUOs51fyYRz6DckxXu93VtxR4r++iGxs16T6
         hzLTLGb9gWe+gZnhWzwBI8s4sr0rFcMWj5ovOBv2zHK3G4JyOJDpYC9Zi8NUb89KNC33
         yBpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=XMp60e/gO6zifaiqgLGDR/xkHoqlvmw6JJ8ebP3Gsxk=;
        b=gCH9ZOlD8pd6IZdnKQyPRLj33QefCei+1kEp/vHVmsj41scF3h4/Qca4PSS1BrLW5I
         geuX8Uk46pkFkvs2ZBThuu7bR2mqWaVuU5D1JMTaDpfJqjFUNqdeKB64ez9xExBhSbOz
         +Id73O8dhV2XOjUN6ssSaxeLWcRyCFsPMr+3unYpIbjaYEA8kkozUhB/rilsibgaiekr
         kFEqFqGxq2P60fbIvCMD9TtA4RWRPJPEcizxYD6sNbdwjgr8p3lMqZfObMo/n6OSh1D1
         VNx6WdS33bNj7DMHGLRppc5rflTkajJLYK4WxRzkcaopCRXQCFdRKE0vQccGMYtfK678
         LoMw==
X-Gm-Message-State: APt69E1qqtWd9qUIRBilVq6DqfEEBmRoWAF+DqgqVL7qF3iTTnHNAH3d
        CrSmEo3wEqBCODXgTakqN6s6yzDM
X-Google-Smtp-Source: AAOMgpd9LNpYbdJf55Enek+LNCkd2yT6EAcFgjlnw7GHQx51NhPqsI6hppp6rafyezuDR52YS2y/wA==
X-Received: by 2002:a0c:b0ec:: with SMTP id p41-v6mr11113664qvc.42.1529937297282;
        Mon, 25 Jun 2018 07:34:57 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.34.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:34:56 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 05/24] midx: write header information to lockfile
Date:   Mon, 25 Jun 2018 10:34:15 -0400
Message-Id: <20180625143434.89044-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
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
 midx.c                      | 49 +++++++++++++++++++++++++++++++++++++
 t/t5319-multi-pack-index.sh |  3 ++-
 2 files changed, 51 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 32468db1a2..393d526881 100644
--- a/midx.c
+++ b/midx.c
@@ -1,7 +1,56 @@
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
+	struct hashfile *f;
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
index ec3ddbe79c..8622a7cdce 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -4,7 +4,8 @@ test_description='multi-pack-indexes'
 . ./test-lib.sh
 
 test_expect_success 'write midx with no packs' '
-	git multi-pack-index --object-dir=. write
+	git multi-pack-index --object-dir=. write &&
+	test_path_is_file pack/multi-pack-index
 '
 
 test_done
-- 
2.18.0.24.g1b579a2ee9

