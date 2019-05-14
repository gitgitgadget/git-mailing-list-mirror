Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9BB341F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbfENSsO (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:14 -0400
Received: from mail-yb1-f194.google.com ([209.85.219.194]:34881 "EHLO
        mail-yb1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727588AbfENSsI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:48:08 -0400
Received: by mail-yb1-f194.google.com with SMTP id k202so47928ybk.2
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:48:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bi1gxvreZD1UTXAfaDQsqcM/4QEp40JUTb7ZDMhd0UA=;
        b=XhRxY/zdDfv5cuhxgZ4NRoVBO7u7tKwwnG4o1JnxnqNMhqo5MJRMYOoxTVyBpjVbAW
         yt4ovoVi8zXMKEH1OOc93esO6FE/WvVS6okSPuZaf1ipbcpdHoWLbztDoXQQ1vzPSfPy
         G+qXC8Pd+Vq+Af3C3Zbwl7/KhvaScGRnQzhn8M5wp3OVySrX7GthgrZZcSubNhkqWe5f
         k3W2vW9VP4DoMhVmryoS3myJsm5AHTnjXKkFpWP5yeVFMHfofxzs2maE0+ZxTw7MaPQI
         hHlJTamk+i0pecLE7//LNZnwxWaodXIu9RmK2WzPY2/2L0XklqDAqJRfMTLOxf2pmEHR
         LtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bi1gxvreZD1UTXAfaDQsqcM/4QEp40JUTb7ZDMhd0UA=;
        b=OBZJcymdUbUIb7tGsQE6Vvv4eWEgvKRdJILPESbAB9fLsc127aagjt8Us3iifeT1lu
         n/sIaHNY8Js1cqJTguzbHq4tmfLfpS1MvzoZqiyxkT98G2oBUQObCtDKPsOAIg/Lzr19
         ZTF+VtvbrhPgjiD+Un4PQ3oBo5hr24eoFZZq0e7J1r2GeItHSK1lI7eoqsZNdWm9ptVN
         mwhuYmcQ5jO/qN2ulaWkWjEqEsOe1kZPjzZhdSpZqtOPHOZxeHmvMKeqDci+x6Dc+dsA
         YKvyl1qhSIXykZ3huELxpNCsQd2gCv4QbOBXYSvYOapZYkTJA9hxZpXTLpPUjwxlTtqP
         +aLw==
X-Gm-Message-State: APjAAAUp0PjM/6ZTFnhigqQc7ZruLtkEAAKWwmqdbNBC/i5M4tCaeK1v
        z+35jTSVfO9BFaj78j1+/0BTrzgMOgk=
X-Google-Smtp-Source: APXvYqzEBIrWmbItE7WtSJGWpZGoLlu2SZJoTtzDRHWzO+thbRWjxCee0Y1FfwTNLDcl6DbYsTQbSA==
X-Received: by 2002:a25:5456:: with SMTP id i83mr17582941ybb.301.1557859687436;
        Tue, 14 May 2019 11:48:07 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.48.06
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:48:06 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 08/11] midx: implement midx_repack()
Date:   Tue, 14 May 2019 18:47:51 +0000
Message-Id: <20190514184754.3196-9-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190514184754.3196-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
 <20190514184754.3196-1-dstolee@microsoft.com>
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
 midx.c                      | 151 +++++++++++++++++++++++++++++++++++-
 t/t5319-multi-pack-index.sh |  28 +++++++
 2 files changed, 178 insertions(+), 1 deletion(-)

diff --git a/midx.c b/midx.c
index fbed8a8adb..d649644420 100644
--- a/midx.c
+++ b/midx.c
@@ -9,6 +9,7 @@
 #include "midx.h"
 #include "progress.h"
 #include "trace2.h"
+#include "run-command.h"
 
 #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
 #define MIDX_VERSION 1
@@ -1227,7 +1228,155 @@ int expire_midx_packs(struct repository *r, const char *object_dir)
 	return result;
 }
 
-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
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
+static int fill_included_packs_batch(struct repository *r,
+				     struct multi_pack_index *m,
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
+		if (prepare_midx_pack(r, m, i))
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
 }
+
+int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
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
+		if (fill_included_packs_batch(r, m, include_pack, batch_size))
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
+}
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index 133d5b7068..6e47e5d0b2 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -450,4 +450,32 @@ test_expect_success 'repack with minimum size does not alter existing packs' '
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
2.22.0.rc0

