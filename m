Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 088F21F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:14:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730714AbfDXPOy (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42290 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730639AbfDXPOy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id p20so20670187qtc.9
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GL6ULwmZKVMA5OmtyuKJyT1/0Xil5I1+Y6Be+Xs99Ww=;
        b=kTxEhRvUmZw/0vEqe1DYvQsxlpxwY50B3UxBcQc3trDtyJ/9Nx1YHLzkxe20s7Klr6
         VjV9S6VL0Qb2JVYbr2t4Bf/+DaP6sdyif/6GGXaw8T2i8EPAseq/SyvKuSddLqyHehG5
         j2+h2uX0IfJJMxySOyhoDrLNLzuwKvLOL+CcuT7+jIGZYxRutJQMH9VzrBXKKlfZcQyC
         UTcvAd844/6WSY0tC1SPNpLZnnkG6qHxpMLEDAsfpL9DvxjD/N+7t60n4qKGUod3Q3GI
         nOnWSWWlNGXT0GvGCYkJVekKPRBynx2RroIAQzhRf/mB+n1T0iz58RwS3HDCny+JqXvt
         xSKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GL6ULwmZKVMA5OmtyuKJyT1/0Xil5I1+Y6Be+Xs99Ww=;
        b=SG9Y8xsPhIwTRGsZkDj1GgWQ22upCwl768l7M7osybgQLC9UgyVJobbxAXAFXMpc2h
         XnCoBiCSjmK2UnJ3rFHHuQRdhoyNcECPDC3v+fLelyoq2lCOFNhyUVGd5c3/eJn0CJK4
         W2uQqiwg7CCVdciiYuqDMfJTWGMrhzdsLyzCXWZn55QoIOYpNIb3Xo2ak1Ku6v4FE2Os
         NW6ydnlr4bt5/VTsI+5/eIg3PIFCgqoYiPEWgSljKB5Ct17Vry4BggdA65NeDe3pAv2C
         RvdCTcFpk+GrN2/9B/bgUXbr8Rx5IoXsbUhr70mPLnYRh/PxOZBe/ZsbSKWu5IhfwCFl
         h6vw==
X-Gm-Message-State: APjAAAVWCaigVssKUM0Ev7gt40PerZMHnqIaDZF5kNLROyHmXwNkIAPL
        /i59UdbBycTqrCvQy0mA4kjZanue
X-Google-Smtp-Source: APXvYqwT5P5Xxr74zfavbC6RVuPOr/b41LMSTP63VGgfPgxwl+OP3vh2Li8SwYzO/ixMPT36SmoA2g==
X-Received: by 2002:aed:23ca:: with SMTP id k10mr810267qtc.224.1556118892181;
        Wed, 24 Apr 2019 08:14:52 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.50
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:51 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 08/11] midx: implement midx_repack()
Date:   Wed, 24 Apr 2019 11:14:25 -0400
Message-Id: <20190424151428.170316-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.21.0.1096.g1c91fdc207
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com>
References: <pull.92.v4.git.gitgitgadget@gmail.com>
 <20190424151428.170316-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

To repack with a non-zero batch-size, first sort all pack-files by
their modified time. Second, walk those pack-files from oldest
to newest, compute their expected size, and add the packs to a list
if they are smaller than the given batch-size. Stop when the total
expected size is at least the batch size.

If the batch size is zero, select all packs in the multi-pack-index.

Finally, collect the objects from the multi-pack-index that are in
the selected packs and send them to 'git pack-objects'. Write a new
multi-pack-index that includes the new pack.

Using a batch size of zero is very similar to a standard 'git repack'
command, except that we do not delete the old packs and instead rely
on the new multi-pack-index to prevent new processes from reading the
old packs. This does not disrupt other Git processes that are currently
reading the old packs based on the old multi-pack-index.

While first designing a 'git multi-pack-index repack' operation, I
started by collecting the batches based on the actual size of the
objects instead of the size of the pack-files. This allows repacking
a large pack-file that has very few referencd objects. However, this
came at a significant cost of parsing pack-files instead of simply
reading the multi-pack-index and getting the file information for
the pack-files. The "expected size" version provides similar
behavior, but could skip a pack-file if the average object size is
much larger than the actual size of the referenced objects, or
can create a large pack if the actual size of the referenced objects
is larger than the expected size.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 150 +++++++++++++++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh |  28 +++++++
 2 files changed, 177 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index 768a7dff73..01c6a05732 100644
--- a/midx.c
+++ b/midx.c
@@ -8,6 +8,7 @@
 #include "sha1-lookup.h"
 #include "midx.h"
 #include "progress.h"
+#include "run-command.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -1113,7 +1114,154 @@ int expire_midx_packs(const char *object_dir)
 	return result;
 }
 
-int midx_repack(const char *object_dir, size_t batch_size)
+struct repack_info {
+	timestamp_t mtime;
+	uint32_t referenced_objects;
+	uint32_t pack_int_id;
+};
+
+static int compare_by_mtime(const void *a_, const void *b_)
 {
+	const struct repack_info *a, *b;
+
+	a = (const struct repack_info *)a_;
+	b = (const struct repack_info *)b_;
+
+	if (a->mtime < b->mtime)
+		return -1;
+	if (a->mtime > b->mtime)
+		return 1;
+	return 0;
+}
+
+static int fill_included_packs_all(struct multi_pack_index *m,
+				   unsigned char *include_pack)
+{
+	uint32_t i;
+
+	for (i = 0; i < m->num_packs; i++)
+		include_pack[i] = 1;
+
+	return m->num_packs < 2;
+}
+
+static int fill_included_packs_batch(struct multi_pack_index *m,
+				     unsigned char *include_pack,
+				     size_t batch_size)
+{
+	uint32_t i, packs_to_repack;
+	size_t total_size;
+	struct repack_info *pack_info = xcalloc(m->num_packs, sizeof(struct repack_info));
+
+	for (i = 0; i < m->num_packs; i++) {
+		pack_info[i].pack_int_id = i;
+
+		if (prepare_midx_pack(m, i))
+			continue;
+
+		pack_info[i].mtime = m->packs[i]->mtime;
+	}
+
+	for (i = 0; batch_size && i < m->num_objects; i++) {
+		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+		pack_info[pack_int_id].referenced_objects++;
+	}
+
+	QSORT(pack_info, m->num_packs, compare_by_mtime);
+
+	total_size = 0;
+	packs_to_repack = 0;
+	for (i = 0; total_size < batch_size && i < m->num_packs; i++) {
+		int pack_int_id = pack_info[i].pack_int_id;
+		struct packed_git *p = m->packs[pack_int_id];
+		size_t expected_size;
+
+		if (!p)
+			continue;
+		if (open_pack_index(p) || !p->num_objects)
+			continue;
+
+		expected_size = (size_t)(p->pack_size
+					 * pack_info[i].referenced_objects);
+		expected_size /= p->num_objects;
+
+		if (expected_size >= batch_size)
+			continue;
+
+		packs_to_repack++;
+		total_size += expected_size;
+		include_pack[pack_int_id] = 1;
+	}
+
+	free(pack_info);
+
+	if (total_size < batch_size || packs_to_repack < 2)
+		return 1;
+
 	return 0;
+}	
+
+int midx_repack(const char *object_dir, size_t batch_size)
+{
+	int result = 0;
+	uint32_t i;
+	unsigned char *include_pack;
+	struct child_process cmd = CHILD_PROCESS_INIT;
+	struct strbuf base_name = STRBUF_INIT;
+	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+
+	if (!m)
+		return 0;
+
+	include_pack = xcalloc(m->num_packs, sizeof(unsigned char));
+
+	if (batch_size) {
+		if (fill_included_packs_batch(m, include_pack, batch_size))
+			goto cleanup;
+	} else if (fill_included_packs_all(m, include_pack))
+		goto cleanup;
+
+	argv_array_push(&cmd.args, "pack-objects");
+
+	strbuf_addstr(&base_name, object_dir);
+	strbuf_addstr(&base_name, "/pack/pack");
+	argv_array_push(&cmd.args, base_name.buf);
+	strbuf_release(&base_name);
+
+	cmd.git_cmd = 1;
+	cmd.in = cmd.out = -1;
+
+	if (start_command(&cmd)) {
+		error(_("could not start pack-objects"));
+		result = 1;
+		goto cleanup;
+	}
+
+	for (i = 0; i < m->num_objects; i++) {
+		struct object_id oid;
+		uint32_t pack_int_id = nth_midxed_pack_int_id(m, i);
+
+		if (!include_pack[pack_int_id])
+			continue;
+
+		nth_midxed_object_oid(&oid, m, i);
+		xwrite(cmd.in, oid_to_hex(&oid), the_hash_algo->hexsz);
+		xwrite(cmd.in, "\n", 1);
+	}
+	close(cmd.in);
+
+	if (finish_command(&cmd)) {
+		error(_("could not finish pack-objects"));
+		result = 1;
+		goto cleanup;
+	}
+
+	result = write_midx_internal(object_dir, m, NULL);
+	m = NULL;
+
+cleanup:
+	if (m)
+		close_midx(m);
+	free(include_pack);
+	return result;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 26ae8b3f62..d6c1353514 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -435,4 +435,32 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
 	)
 '
 
+test_expect_success 'repack creates a new pack' '
+	(
+		cd dup &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 5 idx-list &&
+		THIRD_SMALLEST_SIZE=$(ls -l .git/objects/pack/*pack | awk "{print \$5;}" | sort -n | head -n 3 | tail -n 1) &&
+		BATCH_SIZE=$(($THIRD_SMALLEST_SIZE + 1)) &&
+		git multi-pack-index repack --batch-size=$BATCH_SIZE &&
+		ls .git/objects/pack/*idx >idx-list &&
+		test_line_count = 6 idx-list &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 6 midx-list
+	)
+'
+
+test_expect_success 'expire removes repacked packs' '
+	(
+		cd dup &&
+		ls -al .git/objects/pack/*pack &&
+		ls -S .git/objects/pack/*pack | head -n 4 >expect &&
+		git multi-pack-index expire &&
+		ls -S .git/objects/pack/*pack >actual &&
+		test_cmp expect actual &&
+		test-tool read-midx .git/objects | grep idx >midx-list &&
+		test_line_count = 4 midx-list
+	)
+'
+
 test_done
-- 
2.21.0.1096.g1c91fdc207

