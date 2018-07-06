Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 76FBF1F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 00:53:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753870AbeGFAxm (ORCPT <rfc822;e@80x24.org>);
        Thu, 5 Jul 2018 20:53:42 -0400
Received: from mail-qt0-f193.google.com ([209.85.216.193]:42719 "EHLO
        mail-qt0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753442AbeGFAxh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 5 Jul 2018 20:53:37 -0400
Received: by mail-qt0-f193.google.com with SMTP id z8-v6so204266qto.9
        for <git@vger.kernel.org>; Thu, 05 Jul 2018 17:53:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=y5lvIM3ZzsPuv5mkG0vespzDPZRmc8rqdnB2xDQSYQw=;
        b=GXZH5WtrOfR4qDS9Ri1mecHTNH0vx83nkBnwLieRl+Gr5mEnlD4KsO9DVgd+CEjJus
         a872h7tb92W2DQSoQHIyZnyliA/gf4P5FTmr4+E67ZXMqFMbKWYskGFgaas66PKLaida
         T5+OylkSwhmFayDSbMEFGQa4OUMV23gvaHeksbxihJdhuLLX+Str7lFGdRDbRyo7xnTc
         Z2AYEuiCevbQYhPYkUuIufnTDUtWGG9tWruASgSUI4TCSVRmtDwKnYujCX2XrFHYldb0
         bNVdFTetbEZjIOPOKKANIHAPzDZKqvH27+2K/BaFuHHauTj4nlqwMK94G364LbNTtuXk
         ejUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=y5lvIM3ZzsPuv5mkG0vespzDPZRmc8rqdnB2xDQSYQw=;
        b=qS1dzjzSP5r0YRUZfqG8OMPmpCyjCFlia0AQ2jUAe7ixkxCFYpqPR0muh1S/sDDK1W
         wqk5cusBGc2o1iO2Z+XBMYoUdnRNBGuMt+MNwdDflfBXdBQ9KbqSM5yY34EyYbUgG5qT
         PWOsNVeUWCJwKe9DplxTkSlxQPCDCwPHUkelFcO5DzPoeNUCzvZnNDGVxtoIjvl0onb8
         5RuNJ/NOdcVscDQhkCrBWvd+O0OxSHeubv/0rScURekw+mPmztWU6jrlCRmlNs9g3Hwf
         QZsQ72IqJanZnonVPiQUkwm9tR2DjhiHvlgZ88XNw7eIlfJhH26RbGV5tLo3qNwcD5fV
         Df7g==
X-Gm-Message-State: APt69E0GMhsuFBbWnh6HMl5MQFtnOeqJoKKk9582ADtOV+KZpWmTgzbT
        A0XHDQiCzyP9utsZbC3h02M2QPCx
X-Google-Smtp-Source: AAOMgpcThmYHyacsCYVlNoS4RdluX7EuWGJuVroO1DHu8wWsbZwEfQclWIfi6DtBT/Zxgymhmz/Lww==
X-Received: by 2002:aed:3cc3:: with SMTP id e3-v6mr7551048qtf.356.1530838416129;
        Thu, 05 Jul 2018 17:53:36 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u25-v6sm4882791qku.3.2018.07.05.17.53.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Jul 2018 17:53:35 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, sbeller@google.com, pclouds@gmail.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v3 05/24] midx: write header information to lockfile
Date:   Thu,  5 Jul 2018 20:53:02 -0400
Message-Id: <20180706005321.124643-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.118.gd4f65b8d14
In-Reply-To: <20180706005321.124643-1-dstolee@microsoft.com>
References: <20180625143434.89044-1-dstolee@microsoft.com>
 <20180706005321.124643-1-dstolee@microsoft.com>
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
 t/t5319-multi-pack-index.sh |  3 ++-
 2 files changed, 52 insertions(+), 1 deletion(-)

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
2.18.0.118.gd4f65b8d14

