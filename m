Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id D90641F403
	for <e@80x24.org>; Thu,  7 Jun 2018 14:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S932854AbeFGODx (ORCPT <rfc822;e@80x24.org>);
        Thu, 7 Jun 2018 10:03:53 -0400
Received: from mail-qt0-f194.google.com ([209.85.216.194]:43331 "EHLO
        mail-qt0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932838AbeFGODt (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 7 Jun 2018 10:03:49 -0400
Received: by mail-qt0-f194.google.com with SMTP id y89-v6so9922424qtd.10
        for <git@vger.kernel.org>; Thu, 07 Jun 2018 07:03:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OonMk2nL/xwyzD28ffj8EPSroJJkBtXOfRJYfif5kAU=;
        b=CXAjGPbwNmOoZUuPM8vW63rIswhpYlhM7LpB8Cbx2zky1o7S67VN/nF3Esk9Yh4ZvS
         zhaCQ76BNFQxexnNQGktvKE9I8nymAjc9ZOaDiO+MudZvoKpqlTNEj43A27Xc0CcWdCt
         UD7WqSp9GPoVWPMQwdWjMY1+cxjY6dGMuhAD1rIw8HFerSJv8H2eGm9WYlynXpRkQIfW
         WxT4OFlnvFmDKHVp0Gltp2qqwk5oiL94RZwtCIOHOU9jEaa61/ZCGsetOvfORqGUY+EP
         8e0DRnBxUG9O/9mo9MCy5+yC+2A0D7AvtjX1PXj3+rkwTEIbTvOan6VWK4fALiFme/mQ
         AxkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OonMk2nL/xwyzD28ffj8EPSroJJkBtXOfRJYfif5kAU=;
        b=rjAubZwg0K8Zah6b4DBva8z//0ZFPH/SDIvFZFOz3NdchT8bkVhZ2uBqwfntj58Gnv
         5h/sSyGr3ZVQeVr2BNBclWUnDBzSRBDzqd5uwhpjpvX/NuvMVkf0xCxoqeYKKaKHJCUM
         YUD63KIUuCUIQWF2RlA0/F0Sg/Wldfo0KLQqCiItHfaPQzTH8FsnNigSNsMvqay/6j40
         dFFVwANVUhdIMhvEH9L0BBEQBHjUxLxdlDwme1G2Hc8VqC1E7SRfwddXK5GJSrFk7g5S
         sDdN+Qsyr3tTDGR9P4BAnE/ha9E+fa4YgmNDxcV+SbOiB8Pb5QFx6dyKu136E6KhQovV
         FoRg==
X-Gm-Message-State: APt69E0RHZb9SkT4TzhXmVJtY5Ku4BAPFOAy5T+CEMqplQBX0glt1Q8a
        4lvUE4wLKagX5XLsIvuQ7EKIk2i9
X-Google-Smtp-Source: ADUXVKJ/Px4nY3sFGajbV92Cz6jHngNqwRXvNXnlcDb/8+pIoBnP2yQvPl8wQHmoPVRQ2h8znX7jgA==
X-Received: by 2002:a0c:ae0a:: with SMTP id y10-v6mr1756228qvc.157.1528380228655;
        Thu, 07 Jun 2018 07:03:48 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id u74-v6sm12532763qku.55.2018.06.07.07.03.47
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Jun 2018 07:03:48 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, dstolee@microsoft.com, avarab@gmail.com,
        jrnieder@gmail.com, jonathantanmy@google.com, mfick@codeaurora.org
Subject: [PATCH 05/23] midx: write header information to lockfile
Date:   Thu,  7 Jun 2018 10:03:20 -0400
Message-Id: <20180607140338.32440-6-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.rc1
In-Reply-To: <20180607140338.32440-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
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
 midx.c          | 53 +++++++++++++++++++++++++++++++++++++++++++++++++
 t/t5319-midx.sh |  5 +++--
 2 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/midx.c b/midx.c
index 616af66b13..3e55422a21 100644
--- a/midx.c
+++ b/midx.c
@@ -1,9 +1,62 @@
 #include "git-compat-util.h"
 #include "cache.h"
 #include "dir.h"
+#include "csum-file.h"
+#include "lockfile.h"
 #include "midx.h"
 
+#define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
+#define MIDX_VERSION 1
+#define MIDX_HASH_VERSION 1 /* SHA-1 */
+#define MIDX_HEADER_SIZE 12
+
+static char *get_midx_filename(const char *object_dir)
+{
+	struct strbuf midx_name = STRBUF_INIT;
+	strbuf_addstr(&midx_name, object_dir);
+	strbuf_addstr(&midx_name, "/pack/multi-pack-index");
+	return strbuf_detach(&midx_name, NULL);
+}
+
+static size_t write_midx_header(struct hashfile *f,
+				unsigned char num_chunks,
+				uint32_t num_packs)
+{
+	char byte_values[4];
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
+	uint32_t num_packs = 0;
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
+	write_midx_header(f, num_chunks, num_packs);
+
+	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
+	commit_lock_file(&lk);
+
 	return 0;
 }
diff --git a/t/t5319-midx.sh b/t/t5319-midx.sh
index a590137af7..80f9389837 100755
--- a/t/t5319-midx.sh
+++ b/t/t5319-midx.sh
@@ -3,8 +3,9 @@
 test_description='multi-pack-indexes'
 . ./test-lib.sh
 
-test_expect_success 'write midx with no pakcs' '
-	git midx --object-dir=. write
+test_expect_success 'write midx with no packs' '
+	git midx --object-dir=. write &&
+	test_path_is_file pack/multi-pack-index
 '
 
 test_done
-- 
2.18.0.rc1

