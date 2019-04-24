Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 611D41F453
	for <e@80x24.org>; Wed, 24 Apr 2019 15:15:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730687AbfDXPOx (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Apr 2019 11:14:53 -0400
Received: from mail-qk1-f196.google.com ([209.85.222.196]:39417 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730578AbfDXPOv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Apr 2019 11:14:51 -0400
Received: by mail-qk1-f196.google.com with SMTP id f125so6220978qke.6
        for <git@vger.kernel.org>; Wed, 24 Apr 2019 08:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=4jTy5aVKxvyn00jTuCVcNHfAC4aqPCtc8Po4P8/coac=;
        b=IptQ08mBAkuKYtEXwqAMFxAaCdU7FsKrf0n0lpOKqtBHRn/7hKt1EobbO1w8M3xZdD
         XVTjtCFm36/ejnANKHhrTfKzqX4eKujmk2W6/+Ehp/lnENaKSqlEHgXkUvmTVWK0fTSo
         /KoebdyarGVPMXTbTpSBiEhqANFt3CsVwlo15cXzR5egAuQ26xPwOpIxjxc0AZN7+zvQ
         xC/WxIbOL6k9dR3GoUy1bhEskIZgb5LmT61bIs/0GPfsMV01DuAMSNXVcIkyKCdyFwbT
         a8OL2uKH1kJSZ4Tp7SgewccmlrTVujMz3pHUL9FjH4z7W2mev65NfkdEMl+exz9owcwT
         JflQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4jTy5aVKxvyn00jTuCVcNHfAC4aqPCtc8Po4P8/coac=;
        b=mh75rOdsal6OvKCSTNJuuLd53cnkaqekeTqauo3BJV326YgnnWEWQOl5duFlt4zolB
         FDZSJBnX4lvYtjgkHYr8uydVgsWUl02zjPCQAWv0XujH+HGQXAGPs7JBLdPpXgRr9HrR
         c/QeCcRnUqVDMOFtZ6JRrGDHtSlZ3FtBitCcipMpq7xYk9hmLg8f7VmwybN0fD7erskm
         QG3BHVKSnPUs6j8/TYEKGvlD3KCBo4xnmNpH1sissy6T+oQcEoCZY9PTziayMjcafq+0
         4QxuP/LQGx8LJukEwkeYQz3RwjvcIgftpKw6ELC+gW1zEFDMqG1JVsGGHsCmTETb8+Mx
         rTzA==
X-Gm-Message-State: APjAAAUgdVHJF72GyQK3X3b4Ss26PfhtvU1QWY0gyRjEIjmSX4V0cLmh
        dw9gtevjaD6O6IZhcQ2griGjEmV5
X-Google-Smtp-Source: APXvYqxX14uhC6vdLWMetlkdtLUbAdbnEU1IzRRiVqPt111Ir1DeE6RZjFcrQOtP8DDtMV7Q5+70Bg==
X-Received: by 2002:ae9:e204:: with SMTP id c4mr14963728qkc.16.1556118889858;
        Wed, 24 Apr 2019 08:14:49 -0700 (PDT)
Received: from stolee-gitdev.corp.microsoft.com ([2001:4898:8010:2:9efc:3578:ef3e:58d5])
        by smtp.gmail.com with ESMTPSA id j129sm9671005qkd.51.2019.04.24.08.14.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 24 Apr 2019 08:14:49 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, avarab@gmail.com,
        gitster@pobox.com, Derrick Stolee <dstolee@microsoft.com>
Subject: [PATCH v5 06/11] multi-pack-index: implement 'expire' subcommand
Date:   Wed, 24 Apr 2019 11:14:23 -0400
Message-Id: <20190424151428.170316-7-dstolee@microsoft.com>
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

The 'git multi-pack-index expire' subcommand looks at the existing
mult-pack-index, counts the number of objects referenced in each
pack-file, deletes the pack-fils with no referenced objects, and
rewrites the multi-pack-index to no longer reference those packs.

Refactor the write_midx_file() method to call write_midx_internal()
which now takes an existing 'struct multi_pack_index' and a list
of pack-files to drop (as specified by the names of their pack-
indexes). As we write the new multi-pack-index, we drop those
file names from the list of known pack-files.

The expire_midx_packs() method removes the unreferenced pack-files
after carefully closing the packs to avoid open handles.

Test that a new pack-file that covers the contents of two other
pack-files leads to those pack-files being deleted during the
expire subcommand. Be sure to read the multi-pack-index to ensure
it no longer references those packs.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 midx.c                      | 120 +++++++++++++++++++++++++++++++++---
 t/t5319-multi-pack-index.sh |  20 ++++++
 2 files changed, 130 insertions(+), 10 deletions(-)

diff --git a/midx.c b/midx.c
index 95c39106b2..299e9b2e8f 100644
--- a/midx.c
+++ b/midx.c
@@ -33,6 +33,8 @@
 #define MIDX_CHUNK_LARGE_OFFSET_WIDTH (sizeof(uint64_t))
 #define MIDX_LARGE_OFFSET_NEEDED 0x80000000
 
+#define PACK_EXPIRED UINT_MAX
+
 static char *get_midx_filename(const char *object_dir)
 {
 	return xstrfmt("%s/pack/multi-pack-index", object_dir);
@@ -381,6 +383,7 @@ struct pack_info {
 	uint32_t orig_pack_int_id;
 	char *pack_name;
 	struct packed_git *p;
+	unsigned expired : 1;
 };
 
 static int pack_info_compare(const void *_a, const void *_b)
@@ -428,6 +431,7 @@ static void add_pack_to_midx(const char *full_path, size_t full_path_len,
 
 		packs->info[packs->nr].pack_name = xstrdup(file_name);
 		packs->info[packs->nr].orig_pack_int_id = packs->nr;
+		packs->info[packs->nr].expired = 0;
 		packs->nr++;
 	}
 }
@@ -587,13 +591,17 @@ static size_t write_midx_pack_names(struct hashfile *f,
 	size_t written = 0;
 
 	for (i = 0; i < num_packs; i++) {
-		size_t writelen = strlen(info[i].pack_name) + 1;
+		size_t writelen;
+
+		if (info[i].expired)
+			continue;
 
 		if (i && strcmp(info[i].pack_name, info[i - 1].pack_name) <= 0)
 			BUG("incorrect pack-file order: %s before %s",
 			    info[i - 1].pack_name,
 			    info[i].pack_name);
 
+		writelen = strlen(info[i].pack_name) + 1;
 		hashwrite(f, info[i].pack_name, writelen);
 		written += writelen;
 	}
@@ -675,6 +683,11 @@ static size_t write_midx_object_offsets(struct hashfile *f, int large_offset_nee
 	for (i = 0; i < nr_objects; i++) {
 		struct pack_midx_entry *obj = list++;
 
+		if (perm[obj->pack_int_id] == PACK_EXPIRED)
+			BUG("object %s is in an expired pack with int-id %d",
+			    oid_to_hex(&obj->oid),
+			    obj->pack_int_id);
+
 		hashwrite_be32(f, perm[obj->pack_int_id]);
 
 		if (large_offset_needed && obj->offset >> 31)
@@ -721,7 +734,8 @@ static size_t write_midx_large_offsets(struct hashfile *f, uint32_t nr_large_off
 	return written;
 }
 
-int write_midx_file(const char *object_dir)
+static int write_midx_internal(const char *object_dir, struct multi_pack_index *m,
+			       struct string_list *packs_to_drop)
 {
 	unsigned char cur_chunk, num_chunks = 0;
 	char *midx_name;
@@ -737,6 +751,8 @@ int write_midx_file(const char *object_dir)
 	struct pack_midx_entry *entries = NULL;
 	int large_offsets_needed = 0;
 	int pack_name_concat_len = 0;
+	int dropped_packs = 0;
+	int result = 0;
 
 	midx_name = get_midx_filename(object_dir);
 	if (safe_create_leading_directories(midx_name)) {
@@ -745,7 +761,10 @@ int write_midx_file(const char *object_dir)
 			  midx_name);
 	}
 
-	packs.m = load_multi_pack_index(object_dir, 1);
+	if (m)
+		packs.m = m;
+	else
+		packs.m = load_multi_pack_index(object_dir, 1);
 
 	packs.nr = 0;
 	packs.alloc = packs.m ? packs.m->num_packs : 16;
@@ -759,13 +778,14 @@ int write_midx_file(const char *object_dir)
 			packs.info[packs.nr].orig_pack_int_id = i;
 			packs.info[packs.nr].pack_name = xstrdup(packs.m->pack_names[i]);
 			packs.info[packs.nr].p = NULL;
+			packs.info[packs.nr].expired = 0;
 			packs.nr++;
 		}
 	}
 
 	for_each_file_in_pack_dir(object_dir, add_pack_to_midx, &packs);
 
-	if (packs.m && packs.nr == packs.m->num_packs)
+	if (packs.m && packs.nr == packs.m->num_packs && !packs_to_drop)
 		goto cleanup;
 
 	entries = get_sorted_entries(packs.m, packs.info, packs.nr, &nr_entries);
@@ -779,6 +799,34 @@ int write_midx_file(const char *object_dir)
 
 	QSORT(packs.info, packs.nr, pack_info_compare);
 
+	if (packs_to_drop && packs_to_drop->nr) {
+		int drop_index = 0;
+		int missing_drops = 0;
+
+		for (i = 0; i < packs.nr && drop_index < packs_to_drop->nr; i++) {
+			int cmp = strcmp(packs.info[i].pack_name,
+					 packs_to_drop->items[drop_index].string);
+
+			if (!cmp) {
+				drop_index++;
+				packs.info[i].expired = 1;
+			} else if (cmp > 0) {
+				error(_("did not see pack-file %s to drop"),
+				      packs_to_drop->items[drop_index].string);
+				drop_index++;
+				missing_drops++;
+				i--;
+			} else {
+				packs.info[i].expired = 0;
+			}
+		}
+
+		if (missing_drops) {
+			result = 1;
+			goto cleanup;
+		}
+	}
+
 	/*
 	 * pack_perm stores a permutation between pack-int-ids from the
 	 * previous multi-pack-index to the new one we are writing:
@@ -787,11 +835,18 @@ int write_midx_file(const char *object_dir)
 	 */
 	ALLOC_ARRAY(pack_perm, packs.nr);
 	for (i = 0; i < packs.nr; i++) {
-		pack_perm[packs.info[i].orig_pack_int_id] = i;
+		if (packs.info[i].expired) {
+			dropped_packs++;
+			pack_perm[packs.info[i].orig_pack_int_id] = PACK_EXPIRED;
+		} else {
+			pack_perm[packs.info[i].orig_pack_int_id] = i - dropped_packs;
+		}
 	}
 
-	for (i = 0; i < packs.nr; i++)
-		pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
+	for (i = 0; i < packs.nr; i++) {
+		if (!packs.info[i].expired)
+			pack_name_concat_len += strlen(packs.info[i].pack_name) + 1;
+	}
 
 	if (pack_name_concat_len % MIDX_CHUNK_ALIGNMENT)
 		pack_name_concat_len += MIDX_CHUNK_ALIGNMENT -
@@ -807,7 +862,7 @@ int write_midx_file(const char *object_dir)
 	cur_chunk = 0;
 	num_chunks = large_offsets_needed ? 5 : 4;
 
-	written = write_midx_header(f, num_chunks, packs.nr);
+	written = write_midx_header(f, num_chunks, packs.nr - dropped_packs);
 
 	chunk_ids[cur_chunk] = MIDX_CHUNKID_PACKNAMES;
 	chunk_offsets[cur_chunk] = written + (num_chunks + 1) * MIDX_CHUNKLOOKUP_WIDTH;
@@ -908,7 +963,12 @@ int write_midx_file(const char *object_dir)
 	free(entries);
 	free(pack_perm);
 	free(midx_name);
-	return 0;
+	return result;
+}
+
+int write_midx_file(const char *object_dir)
+{
+	return write_midx_internal(object_dir, NULL, NULL);
 }
 
 void clear_midx_file(struct repository *r)
@@ -1010,5 +1070,45 @@ int verify_midx_file(const char *object_dir)
 
 int expire_midx_packs(const char *object_dir)
 {
-	return 0;
+	uint32_t i, *count, result = 0;
+	struct string_list packs_to_drop = STRING_LIST_INIT_DUP;
+	struct multi_pack_index *m = load_multi_pack_index(object_dir, 1);
+
+	if (!m)
+		return 0;
+
+	count = xcalloc(m->num_packs, sizeof(uint32_t));
+	for (i = 0; i < m->num_objects; i++) {
+		int pack_int_id = nth_midxed_pack_int_id(m, i);
+		count[pack_int_id]++;
+	}
+
+	for (i = 0; i < m->num_packs; i++) {
+		char *pack_name;
+
+		if (count[i])
+			continue;
+
+		if (prepare_midx_pack(m, i))
+			continue;
+
+		if (m->packs[i]->pack_keep)
+			continue;
+
+		pack_name = xstrdup(m->packs[i]->pack_name);
+		close_pack(m->packs[i]);
+		FREE_AND_NULL(m->packs[i]);
+
+		string_list_insert(&packs_to_drop, m->pack_names[i]);
+		unlink_pack_path(pack_name, 0);
+		free(pack_name);
+	}
+
+	free(count);
+
+	if (packs_to_drop.nr)
+		result = write_midx_internal(object_dir, m, &packs_to_drop);
+
+	string_list_clear(&packs_to_drop, 0);
+	return result;
 }
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index a8528f7da0..65e85debec 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -397,4 +397,24 @@ test_expect_success 'expire does not remove any packs' '
 	)
 '
 
+test_expect_success 'expire removes unreferenced packs' '
+	(
+		cd dup &&
+		git pack-objects --revs .git/objects/pack/pack-combined <<-EOF &&
+		refs/heads/A
+		^refs/heads/C
+		EOF
+		git multi-pack-index write &&
+		ls .git/objects/pack | grep -v -e pack-[AB] >expect &&
+		git multi-pack-index expire &&
+		ls .git/objects/pack >actual &&
+		test_cmp expect actual &&
+		ls .git/objects/pack/ | grep idx >expect-idx &&
+		test-tool read-midx .git/objects | grep idx >actual-midx &&
+		test_cmp expect-idx actual-midx &&
+		git multi-pack-index verify &&
+		git fsck
+	)
+'
+
 test_done
-- 
2.21.0.1096.g1c91fdc207

