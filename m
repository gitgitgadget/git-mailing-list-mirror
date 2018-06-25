Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,LOTS_OF_MONEY,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4FBE11F516
	for <e@80x24.org>; Mon, 25 Jun 2018 14:35:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934462AbeFYOfN (ORCPT <rfc822;e@80x24.org>);
        Mon, 25 Jun 2018 10:35:13 -0400
Received: from mail-qt0-f196.google.com ([209.85.216.196]:44891 "EHLO
        mail-qt0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934420AbeFYOfH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jun 2018 10:35:07 -0400
Received: by mail-qt0-f196.google.com with SMTP id 92-v6so7652872qta.11
        for <git@vger.kernel.org>; Mon, 25 Jun 2018 07:35:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=pIX+8KoGR2UOW94uQtNZKuNl5gnNPVHthndPAh5p1fw=;
        b=PAhqoW55TUwQ3R1rLuLqYqRtF5IJ1pvN01aQtW/qG6yyLP4hL1fuOM/iyXcBAqAo5e
         tiDN6VgqWR+4X1dmi+fJQh42D8BTw9ufY+p0cq2+V8+mQAzIS80UM0gRV85xWhAvofBl
         a3mgOsDSfWjFEI2XJAOoX8Hw01LkBAIj8TQZAKMjXpPf7CWL+Ub9kusHRKZn1bCVvb7I
         iFvIC+BD0IxwcicpO9qQ1tNPOKoDfCWXZ1qhIx/5Kq5r2bqOYuwQFmx/5iV5O0CYNBub
         czyFk7rkGNyLVZnHrCW/9T060fRJX63vkyqoDvWlkmPEEuN7+dbMQVmbPrID4YSE3vBQ
         0xaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=pIX+8KoGR2UOW94uQtNZKuNl5gnNPVHthndPAh5p1fw=;
        b=j6n4Fn6eCwtEcdJMguqu0HefQvRcEnI7H3Z63XIy/BOcPI3fq6nTMxWFcOBGlPt9FH
         cy2yZuW/wzEV6Yqpru33n2dABNOvzW9xYlkWGQaTGfOrltUWEUFFc8uV/28hgEntYvgh
         XHmRmGClk23winjkq7wVqPhhE4MfVKeUhpMqMepfSlWy7RkHxFWgQBChoFBm8DiB+Dt7
         mdUuMikSzD25UN9ggeTk9f86Xu0raz/EE77uNrakeBbaon4JO3dDay0L34IcwYbn8iEG
         UKvjnNDD3OR2IHzfNVEkBYmMGPZI0Vp6tLp+a018ggE1y8J0eu2M4JE8z55OY3Ox9gWr
         pmBQ==
X-Gm-Message-State: APt69E3gp3xD/FNUsVUS2zxSwD3XgEK0Moy/oxTW30X7JJ6xKqw2dD3T
        Unask5Yzit+540YTuA7/4H3rHlyz
X-Google-Smtp-Source: AAOMgpebvK/0hPLdfnv+XvmVSdrReESh+EsX1r6wBDZkVmXdXGuz5UOLTVFqQ2sU9BBEi0i85fkr6A==
X-Received: by 2002:a0c:ad29:: with SMTP id u38-v6mr11287410qvc.100.1529937306737;
        Mon, 25 Jun 2018 07:35:06 -0700 (PDT)
Received: from stolee-linux-2.corp.microsoft.com ([2001:4898:8010:0:eb4a:5dff:fe0f:730f])
        by smtp.gmail.com with ESMTPSA id w46-v6sm12821713qtw.55.2018.06.25.07.35.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 25 Jun 2018 07:35:05 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     sbeller@google.com, pclouds@gmail.com, avarab@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v2 09/24] multi-pack-index: read packfile list
Date:   Mon, 25 Jun 2018 10:34:19 -0400
Message-Id: <20180625143434.89044-10-dstolee@microsoft.com>
X-Mailer: git-send-email 2.18.0.24.g1b579a2ee9
In-Reply-To: <20180625143434.89044-1-dstolee@microsoft.com>
References: <20180607140338.32440-1-dstolee@microsoft.com>
 <20180625143434.89044-1-dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When constructing a multi-pack-index file for a given object directory,
read the files within the enclosed pack directory and find matches that
end with ".idx" and find the correct paired packfile using
add_packed_git().

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 45 ++++++++++++++++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh | 16 ++++++-------
 2 files changed, 52 insertions(+), 9 deletions(-)

diff --git a/midx.c b/midx.c
index 0977397d6a..e79ffb5576 100644
--- a/midx.c
+++ b/midx.c
@@ -1,6 +1,8 @@
 #include "cache.h"
 #include "csum-file.h"
+#include "dir.h"
 #include "lockfile.h"
+#include "packfile.h"
 #include "object-store.h"
 #include "midx.h"
 
@@ -107,12 +109,40 @@ static size_t write_midx_header(struct hashfile *f,
 	return MIDX_HEADER_SIZE;
 }
 
+struct pack_list
+{
+	struct packed_git **list;
+	uint32_t nr;
+	uint32_t alloc;
+};
+
+static void add_pack_to_midx(const char *full_path, size_t full_path_len,
+			     const char *file_name, void *data)
+{
+	struct pack_list *packs = (struct pack_list *)data;
+
+	if (ends_with(file_name, ".idx")) {
+		ALLOC_GROW(packs->list, packs->nr + 1, packs->alloc);
+
+		packs->list[packs->nr] = add_packed_git(full_path,
+							 full_path_len,
+							 0);
+		if (!packs->list[packs->nr])
+			warning(_("failed to add packfile '%s'"),
+				full_path);
+		else
+			packs->nr++;
+	}
+}
+
 int write_midx_file(const char *object_dir)
 {
 	unsigned char num_chunks = 0;
 	char *midx_name;
+	uint32_t i;
 	struct hashfile *f;
 	struct lock_file lk;
+	struct pack_list packs;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -121,14 +151,27 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
+	packs.nr = 0;
+	packs.alloc = 16;
+	packs.list = NULL;
+	ALLOC_ARRAY(packs.list, packs.alloc);
+
+	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
+
 	hold_lock_file_for_update(&lk, midx_name, LOCK_DIE_ON_ERROR);
 	f = hashfd(lk.tempfile->fd, lk.tempfile->filename.buf);
 	FREE_AND_NULL(midx_name);
 
-	write_midx_header(f, num_chunks, 0);
+	write_midx_header(f, num_chunks, packs.nr);
 
 	finalize_hashfile(f, NULL, CSUM_FSYNC | CSUM_HASH_IN_STREAM);
 	commit_lock_file(&lk);
 
+	for (i = 0; i < packs.nr; i++) {
+		close_pack(packs.list[i]);
+		FREE_AND_NULL(packs.list[i]);
+	}
+
+	FREE_AND_NULL(packs.list);
 	return 0;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index d533fd0dbc..4d4d6ca0a6 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -4,8 +4,9 @@ test_description='multi-pack-indexes'
 . ./test-lib.sh
 
 midx_read_expect() {
+	NUM_PACKS=$1
 	cat >expect <<- EOF
-	header: 4d494458 1 0 0
+	header: 4d494458 1 0 $NUM_PACKS
 	object_dir: .
 	EOF
 	test-tool read-midx . >actual &&
@@ -15,8 +16,7 @@ midx_read_expect() {
 test_expect_success 'write midx with no packs' '
 	test_when_finished rm pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	test_path_is_file pack/multi-pack-index &&
-	midx_read_expect
+	midx_read_expect 0
 '
 
 test_expect_success 'create objects' '
@@ -47,13 +47,13 @@ test_expect_success 'write midx with one v1 pack' '
 	pack=$(git pack-objects --index-version=1 pack/test <obj-list) &&
 	test_when_finished rm pack/test-$pack.pack pack/test-$pack.idx pack/multi-pack-index &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 1
 '
 
 test_expect_success 'write midx with one v2 pack' '
 	git pack-objects --index-version=2,0x40 pack/test <obj-list &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 1
 '
 
 test_expect_success 'Add more objects' '
@@ -83,7 +83,7 @@ test_expect_success 'Add more objects' '
 test_expect_success 'write midx with two packs' '
 	git pack-objects --index-version=1 pack/test-2 <obj-list2 &&
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 2
 '
 
 test_expect_success 'Add more packs' '
@@ -106,7 +106,7 @@ test_expect_success 'Add more packs' '
 		git ls-tree $tree | sed -e "s/.* \\([0-9a-f]*\\)	.*/\\1/"
 		} >obj-list &&
 		git update-ref HEAD $commit &&
-		git pack-objects --index-version=2 test-pack <obj-list &&
+		git pack-objects --index-version=2 pack/test-pack <obj-list &&
 		i=$(expr $i + 1) || return 1 &&
 		j=$(expr $j + 1) || return 1
 	done
@@ -114,7 +114,7 @@ test_expect_success 'Add more packs' '
 
 test_expect_success 'write midx with twelve packs' '
 	git multi-pack-index --object-dir=. write &&
-	midx_read_expect
+	midx_read_expect 12
 '
 
 test_done
-- 
2.18.0.24.g1b579a2ee9

