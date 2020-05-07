Return-Path: <SRS0=p769=6V=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE077C54E4B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:00:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0B342083B
	for <git@archiver.kernel.org>; Thu,  7 May 2020 10:00:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d2XslOuB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726356AbgEGJ7v (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 7 May 2020 05:59:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725834AbgEGJ7u (ORCPT
        <rfc822;git@vger.kernel.org>); Thu, 7 May 2020 05:59:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18751C061A10
        for <git@vger.kernel.org>; Thu,  7 May 2020 02:59:50 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id k12so5750434wmj.3
        for <git@vger.kernel.org>; Thu, 07 May 2020 02:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=WHbjMhfbLJuPMPX0fACICo2S7jIFyCIOphmk05xKrbE=;
        b=d2XslOuBXRlKXHl/B/s5DIYcL65wQuaXzs0ZjaiFhjR2aE5lho1wQbMKO3ESYZVm6m
         KEY8C4GbD3gHEje9gmlMyUtUh200vf/aVhWqi3eaZnTUgn1BPtWEulLE8ssQQ6A+5b5b
         UmHJX4TDG+PB9+r2SLDpTQcSwvJBsWlwSD0IpJ5yHqhgQLkdo42TCgfcB4KA6wSYuo7H
         alVvfVy2UUkxSHQSh4uO4TaFCPRVWl5Xjo7z/7zkbC+cWjwGcL8DfUSNHcVMKwtDDJLE
         rrqWOsnObXhpo5ZYqngr297FDeKEUjsaD+tkuN3AwrPKmH0nvxJ/g/RKH2POImjkFcXq
         pzng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=WHbjMhfbLJuPMPX0fACICo2S7jIFyCIOphmk05xKrbE=;
        b=qi/PLVswZDMLL5Y1g1zl07tyf7Bu0MwsR8PoEKVqIXCaXtOaE2pXLKrvGTulthK9Ua
         BGPlI12CBuPgxS5/VQB/f9EFc8qvVO+hEtTZjvsXtkTSGFgxQFKfd9oKYetpN/gdoi83
         Gk+n0MJC9F9ZodjI6VeC1rdPylWAFjczprtiVrHuqF0pUsPj5lKXwdIb3XfUsSa9Nx9A
         bA5BoR/KcW/lLqoLOaLubZ1ROmXIHe9SUwkOlsH8iDcscNr13CqNAtYo28dTcIvbKJjN
         +oRhLbUUTIY7tZgs71tuZHfSWWLmXsTH7GarvHtcF1YpjxI7dR1Jid5lF1sOMeWrowFx
         ANOg==
X-Gm-Message-State: AGi0PubCMDog50CUmL9qFVD5tIp0hD95ei7gZrwGladlKpYA+m1AXjm4
        8IBN+KlTDJ+zsrbhcwzKuyBZ/4+s
X-Google-Smtp-Source: APiQypKW3kc3gKw3JTA8paiWmUVOi3f1BjiRLe4ISuOfP/NOKjIG/mcqW8QHsIS1Qbr5TXslPGemdQ==
X-Received: by 2002:a1c:f312:: with SMTP id q18mr9266085wmq.175.1588845588088;
        Thu, 07 May 2020 02:59:48 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l15sm7022944wmi.48.2020.05.07.02.59.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 May 2020 02:59:47 -0700 (PDT)
Message-Id: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Thu, 07 May 2020 09:59:33 +0000
Subject: [PATCH v12 00/12] Reftable support git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the reftable library, and hooks it up as a ref backend.

Includes testing support, to test: make -C t/ GIT_TEST_REFTABLE=1

Summary 18964 tests pass 2871 tests fail

Some issues:

 * pseudorefs are broken
 * many tests inspect .git/{logs,heads}/ directly.

v15

 * fix static analysis error
 * plug some memory leaks

Han-Wen Nienhuys (10):
  refs.h: clarify reflog iteration order
  Iterate over the "refs/" namespace in for_each_[raw]ref
  refs: document how ref_iterator_advance_fn should handle symrefs
  Add .gitattributes for the reftable/ directory
  reftable: define version 2 of the spec to accomodate SHA256
  reftable: clarify how empty tables should be written
  Add reftable library
  Reftable support for git-core
  t: use update-ref and show-ref to reading/writing refs
  Add some reftable testing infrastructure

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

Jonathan Nieder (1):
  reftable: file format documentation

 Documentation/Makefile                        |    1 +
 Documentation/technical/reftable.txt          | 1080 +++++++++++++++
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   27 +-
 builtin/clone.c                               |    3 +-
 builtin/init-db.c                             |   56 +-
 cache.h                                       |    6 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 refs.c                                        |   33 +-
 refs.h                                        |    8 +-
 refs/refs-internal.h                          |    6 +
 refs/reftable-backend.c                       | 1045 ++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    5 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  435 ++++++
 reftable/block.h                              |  129 ++
 reftable/constants.h                          |   21 +
 reftable/file.c                               |   99 ++
 reftable/iter.c                               |  240 ++++
 reftable/iter.h                               |   63 +
 reftable/merged.c                             |  327 +++++
 reftable/merged.h                             |   38 +
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  753 ++++++++++
 reftable/reader.h                             |   65 +
 reftable/record.c                             | 1133 +++++++++++++++
 reftable/record.h                             |  121 ++
 reftable/refname.c                            |  215 +++
 reftable/refname.h                            |   38 +
 reftable/reftable.c                           |   91 ++
 reftable/reftable.h                           |  563 ++++++++
 reftable/slice.c                              |  225 +++
 reftable/slice.h                              |   76 +
 reftable/stack.c                              | 1230 +++++++++++++++++
 reftable/stack.h                              |   45 +
 reftable/system.h                             |   54 +
 reftable/tree.c                               |   67 +
 reftable/tree.h                               |   34 +
 reftable/update.sh                            |   24 +
 reftable/writer.c                             |  661 +++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 t/t0002-gitfile.sh                            |    2 +-
 t/t0031-reftable.sh                           |  109 ++
 t/t1400-update-ref.sh                         |   32 +-
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1506-rev-parse-diagnosis.sh                |    2 +-
 t/t3210-pack-refs.sh                          |    6 +
 t/t6050-replace.sh                            |    2 +-
 t/t9020-remote-svn.sh                         |    4 +-
 t/test-lib.sh                                 |    5 +
 60 files changed, 9777 insertions(+), 57 deletions(-)
 create mode 100644 Documentation/technical/reftable.txt
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/system.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100755 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100755 t/t0031-reftable.sh


base-commit: b34789c0b0d3b137f0bb516b417bd8d75e0cb306
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v12
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v12
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v11:

  1:  dfa5fd74f85 =  1:  dfa5fd74f85 refs.h: clarify reflog iteration order
  2:  340c5c415e1 =  2:  340c5c415e1 Iterate over the "refs/" namespace in for_each_[raw]ref
  3:  6553285043b =  3:  6553285043b refs: document how ref_iterator_advance_fn should handle symrefs
  4:  7dc47c7756f =  4:  7dc47c7756f Add .gitattributes for the reftable/ directory
  5:  06fcb49e903 =  5:  06fcb49e903 reftable: file format documentation
  6:  093fa74a3d0 =  6:  093fa74a3d0 reftable: define version 2 of the spec to accomodate SHA256
  7:  6d9031372ce =  7:  6d9031372ce reftable: clarify how empty tables should be written
  8:  6ee6c44752c !  8:  57d338c4983 Add reftable library
     @@ reftable/README.md (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+commit 3a486f79abcd17e88e3bca62f43188a7c8b80ff3
     ++commit 06dd91a8377b0f920d9835b9835d0d650f928dce
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Mon May 4 19:20:21 2020 +0200
     ++Date:   Wed May 6 21:27:32 2020 +0200
      +
     -+    C: include "cache.h" in git-core sleep_millisec()
     ++    C: fix small memory leak in stack.c error path
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/block.c (new)
      +
      +#include "system.h"
      +
     -+#include "blocksource.h"
      +#include "constants.h"
      +#include "record.h"
      +#include "reftable.h"
     @@ reftable/block.c (new)
      +		}
      +
      +		/* We're done with the input data. */
     -+		block_source_return_block(block->source, block);
     ++		reftable_block_done(block);
      +		block->data = uncompressed.buf;
      +		block->len = sz;
      +		block->source = malloc_block_source();
     @@ reftable/block.h (new)
      +/* size of file footer, depending on format version */
      +int footer_size(int version);
      +
     -+#endif
     -
     - ## reftable/blocksource.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef BLOCKSOURCE_H
     -+#define BLOCKSOURCE_H
     -+
     -+#include "reftable.h"
     -+
     -+uint64_t block_source_size(struct reftable_block_source source);
     -+int block_source_read_block(struct reftable_block_source source,
     -+			    struct reftable_block *dest, uint64_t off,
     -+			    uint32_t size);
     -+void block_source_return_block(struct reftable_block_source source,
     -+			       struct reftable_block *ret);
     -+void block_source_close(struct reftable_block_source source);
     ++/* returns a block to its source. */
     ++void reftable_block_done(struct reftable_block *ret);
      +
      +#endif
      
     @@ reftable/iter.c (new)
      +		if (fri->double_check) {
      +			struct reftable_iterator it = { 0 };
      +
     -+			err = reftable_reader_seek_ref(fri->r, &it,
     -+						       ref->ref_name);
     ++			err = reftable_table_seek_ref(fri->tab, &it,
     ++						      ref->ref_name);
      +			if (err == 0) {
      +				err = reftable_iterator_next_ref(it, ref);
      +			}
     @@ reftable/iter.c (new)
      +{
      +	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
      +	block_iter_close(&it->cur);
     -+	reader_return_block(it->r, &it->block_reader.block);
     ++	reftable_block_done(&it->block_reader.block);
      +	slice_clear(&it->oid);
      +}
      +
     @@ reftable/iter.c (new)
      +		return 1;
      +	}
      +
     -+	reader_return_block(it->r, &it->block_reader.block);
     ++	reftable_block_done(&it->block_reader.block);
      +
      +	{
      +		uint64_t off = it->offsets[it->offset_idx++];
     @@ reftable/iter.h (new)
      +/* iterator that produces only ref records that point to `oid` */
      +struct filtering_ref_iterator {
      +	bool double_check;
     -+	struct reftable_reader *r;
     ++	struct reftable_table tab;
      +	struct slice oid;
      +	struct reftable_iterator it;
      +};
     @@ reftable/reader.c (new)
      +#include "reader.h"
      +
      +#include "system.h"
     -+
      +#include "block.h"
      +#include "constants.h"
      +#include "iter.h"
     @@ reftable/reader.c (new)
      +	return result;
      +}
      +
     -+void block_source_return_block(struct reftable_block_source source,
     -+			       struct reftable_block *blockp)
     ++void reftable_block_done(struct reftable_block *blockp)
      +{
     -+	source.ops->return_block(source.arg, blockp);
     ++	struct reftable_block_source source = blockp->source;
     ++	if (blockp != NULL && source.ops != NULL)
     ++		source.ops->return_block(source.arg, blockp);
      +	blockp->data = NULL;
      +	blockp->len = 0;
      +	blockp->source.ops = NULL;
     @@ reftable/reader.c (new)
      +	return block_source_read_block(r->source, dest, off, sz);
      +}
      +
     -+void reader_return_block(struct reftable_reader *r, struct reftable_block *p)
     -+{
     -+	block_source_return_block(r->source, p);
     -+}
     -+
      +uint32_t reftable_reader_hash_id(struct reftable_reader *r)
      +{
      +	return r->hash_id;
     @@ reftable/reader.c (new)
      +
      +	err = parse_footer(r, footer.data, header.data);
      +exit:
     -+	block_source_return_block(r->source, &footer);
     -+	block_source_return_block(r->source, &header);
     ++	reftable_block_done(&footer);
     ++	reftable_block_done(&header);
      +	return err;
      +}
      +
     @@ reftable/reader.c (new)
      +	if (ti->bi.br == NULL) {
      +		return;
      +	}
     -+	reader_return_block(ti->r, &ti->bi.br->block);
     ++	reftable_block_done(&ti->bi.br->block);
      +	FREE_AND_NULL(ti->bi.br);
      +
      +	ti->bi.last_key.len = 0;
     @@ reftable/reader.c (new)
      +	}
      +
      +	if (want_typ != BLOCK_TYPE_ANY && block_typ != want_typ) {
     -+		reader_return_block(r, &block);
     ++		reftable_block_done(&block);
      +		return 1;
      +	}
      +
      +	if (block_size > guess_block_size) {
     -+		reader_return_block(r, &block);
     ++		reftable_block_done(&block);
      +		err = reader_get_block(r, &block, next_off, block_size);
      +		if (err < 0) {
      +			return err;
     @@ reftable/reader.c (new)
      +
      +static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
      +					      struct reftable_iterator *it,
     -+					      byte *oid, int oid_len)
     ++					      byte *oid)
      +{
      +	struct table_iter *ti = reftable_calloc(sizeof(struct table_iter));
      +	struct filtering_ref_iterator *filter = NULL;
     ++	int oid_len = hash_size(r->hash_id);
      +	int err = reader_start(r, ti, BLOCK_TYPE_REF, false);
      +	if (err < 0) {
      +		reftable_free(ti);
     @@ reftable/reader.c (new)
      +	filter = reftable_calloc(sizeof(struct filtering_ref_iterator));
      +	slice_resize(&filter->oid, oid_len);
      +	memcpy(filter->oid.buf, oid, oid_len);
     -+	filter->r = r;
     ++	reftable_table_from_reader(&filter->tab, r);
      +	filter->double_check = false;
      +	iterator_from_table_iter(&filter->it, ti);
      +
     @@ reftable/reader.c (new)
      +}
      +
      +int reftable_reader_refs_for(struct reftable_reader *r,
     -+			     struct reftable_iterator *it, byte *oid,
     -+			     int oid_len)
     ++			     struct reftable_iterator *it, byte *oid)
      +{
      +	if (r->obj_offsets.present) {
      +		return reftable_reader_refs_for_indexed(r, it, oid);
      +	}
     -+	return reftable_reader_refs_for_unindexed(r, it, oid, oid_len);
     ++	return reftable_reader_refs_for_unindexed(r, it, oid);
      +}
      +
      +uint64_t reftable_reader_max_update_index(struct reftable_reader *r)
     @@ reftable/reader.h (new)
      +int block_source_read_block(struct reftable_block_source source,
      +			    struct reftable_block *dest, uint64_t off,
      +			    uint32_t size);
     -+void block_source_return_block(struct reftable_block_source source,
     -+			       struct reftable_block *ret);
      +void block_source_close(struct reftable_block_source *source);
      +
      +/* metadata for a block type */
     @@ reftable/reader.h (new)
      +		struct record rec);
      +void reader_close(struct reftable_reader *r);
      +const char *reader_name(struct reftable_reader *r);
     -+void reader_return_block(struct reftable_reader *r, struct reftable_block *p);
      +
      +/* initialize a block reader to read from `r` */
      +int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
     @@ reftable/record.c (new)
      +	memcpy(dest->buf, rec->hash_prefix, rec->hash_prefix_len);
      +}
      +
     ++static void obj_record_clear(void *rec)
     ++{
     ++	struct obj_record *obj = (struct obj_record *)rec;
     ++	FREE_AND_NULL(obj->hash_prefix);
     ++	FREE_AND_NULL(obj->offsets);
     ++	memset(obj, 0, sizeof(struct obj_record));
     ++}
     ++
      +static void obj_record_copy_from(void *rec, const void *src_rec, int hash_size)
      +{
     -+	struct obj_record *ref = (struct obj_record *)rec;
     ++	struct obj_record *obj = (struct obj_record *)rec;
      +	const struct obj_record *src = (const struct obj_record *)src_rec;
      +
     -+	*ref = *src;
     -+	ref->hash_prefix = reftable_malloc(ref->hash_prefix_len);
     -+	memcpy(ref->hash_prefix, src->hash_prefix, ref->hash_prefix_len);
     ++	obj_record_clear(obj);
     ++	*obj = *src;
     ++	obj->hash_prefix = reftable_malloc(obj->hash_prefix_len);
     ++	memcpy(obj->hash_prefix, src->hash_prefix, obj->hash_prefix_len);
      +
      +	{
     -+		int olen = ref->offset_len * sizeof(uint64_t);
     -+		ref->offsets = reftable_malloc(olen);
     -+		memcpy(ref->offsets, src->offsets, olen);
     ++		int olen = obj->offset_len * sizeof(uint64_t);
     ++		obj->offsets = reftable_malloc(olen);
     ++		memcpy(obj->offsets, src->offsets, olen);
      +	}
      +}
      +
     -+static void obj_record_clear(void *rec)
     -+{
     -+	struct obj_record *ref = (struct obj_record *)rec;
     -+	FREE_AND_NULL(ref->hash_prefix);
     -+	FREE_AND_NULL(ref->offsets);
     -+	memset(ref, 0, sizeof(struct obj_record));
     -+}
     -+
      +static byte obj_record_val_type(const void *rec)
      +{
      +	struct obj_record *r = (struct obj_record *)rec;
     @@ reftable/record.c (new)
      +	const struct reftable_log_record *src =
      +		(const struct reftable_log_record *)src_rec;
      +
     ++	reftable_log_record_clear(dst);
      +	*dst = *src;
      +	if (dst->ref_name != NULL) {
      +		dst->ref_name = xstrdup(dst->ref_name);
     @@ reftable/refname.h (new)
      +#ifndef REFNAME_H
      +#define REFNAME_H
      +
     ++#include "reftable.h"
     ++
      +struct modification {
      +	struct reftable_table tab;
      +
     @@ reftable/refname.h (new)
      +
      +int modification_validate(struct modification *mod);
      +
     -+/* illegal name, or dir/file conflict */
     -+#define REFTABLE_REFNAME_ERROR -9
     -+
      +#endif
      
       ## reftable/reftable.c (new) ##
     @@ reftable/reftable.h (new)
      +/* closes and deallocates a reader. */
      +void reftable_reader_free(struct reftable_reader *);
      +
     -+/* return an iterator for the refs pointing to oid */
     ++/* return an iterator for the refs pointing to `oid`. */
      +int reftable_reader_refs_for(struct reftable_reader *r,
     -+			     struct reftable_iterator *it, uint8_t *oid,
     -+			     int oid_len);
     ++			     struct reftable_iterator *it, uint8_t *oid);
      +
      +/* return the max_update_index for a table */
      +uint64_t reftable_reader_max_update_index(struct reftable_reader *r);
     @@ reftable/stack.c (new)
      +		int i = 0;
      +		for (i = 0; i < new_tables_len; i++) {
      +			reader_close(new_tables[i]);
     ++			reftable_reader_free(new_tables[i]);
      +		}
      +	}
      +	reftable_free(new_tables);
  9:  d731e1669b7 !  9:  f3bb9410038 Reftable support for git-core
     @@ Commit message
      
          For background, see the previous commit introducing the library.
      
     -    TODO:
     +    This introduces the refs/reftable-backend.c containing reftable powered ref
     +    storage backend.
     +
     +    It can be activated by passing --ref-storage=reftable to "git init".
      
     -     * Resolve spots marked with XXX
     +    TODO:
      
     -     * Support worktrees (t0002-gitfile "linked repo" testcase)
     +    * Resolve spots marked with XXX
      
          Example use: see t/t0031-reftable.sh
      
 10:  513d585f0f8 = 10:  94fcc6dca6a vcxproj: adjust for the reftable changes
 12:  a7d1d2e721c = 11:  2abcbd1af99 t: use update-ref and show-ref to reading/writing refs
 11:  846fe29fa4b ! 12:  fe9407d10b1 Add some reftable testing infrastructure
     @@ Commit message
      
          * Add test_prerequisite REFTABLE. Skip t/t3210-pack-refs.sh for REFTABLE.
      
     +    Major test failures:
     +
     +     * t9903-bash-prompt - The bash mode reads .git/HEAD directly
     +     * t1400-update-ref.sh - Reads from .git/{refs,logs} directly
     +     * t1404-update-ref-errors.sh - Manipulates .git/refs/ directly
     +     * t1405 - inspecs .git/ directly.
     +     * t1450-fsck.sh - manipulates .git/ directly to create invalid state
     +     * Rebase, cherry-pick: pseudo refs aren't written through the refs backend.
     +
     +    Other tests by decreasing brokenness:
     +
     +    t1407-worktree-ref-store.sh              - 5 of 5
     +    t1413-reflog-detach.sh                   - 7 of 7
     +    t1415-worktree-refs.sh                   - 11 of 11
     +    t3908-stash-in-worktree.sh               - 2 of 2
     +    t4207-log-decoration-colors.sh           - 2 of 2
     +    t5515-fetch-merge-logic.sh               - 17 of 17
     +    t5900-repo-selection.sh                  - 8 of 8
     +    t6016-rev-list-graph-simplify-history.sh - 12 of 12
     +    t5573-pull-verify-signatures.sh          - 15 of 16
     +    t5612-clone-refspec.sh                   - 12 of 13
     +    t5514-fetch-multiple.sh                  - 11 of 12
     +    t6030-bisect-porcelain.sh                - 64 of 71
     +    t5533-push-cas.sh                        - 15 of 17
     +    t5539-fetch-http-shallow.sh              - 7 of 8
     +    t7413-submodule-is-active.sh             - 7 of 8
     +    t2400-worktree-add.sh                    - 59 of 69
     +    t0100-previous.sh                        - 5 of 6
     +    t7419-submodule-set-branch.sh            - 5 of 6
     +    t1404-update-ref-errors.sh               - 44 of 53
     +    t6003-rev-list-topo-order.sh             - 29 of 35
     +    t1409-avoid-packing-refs.sh              - 9 of 11
     +    t5541-http-push-smart.sh                 - 31 of 38
     +    t5407-post-rewrite-hook.sh               - 13 of 16
     +    t9903-bash-prompt.sh                     - 52 of 66
     +    t1414-reflog-walk.sh                     - 9 of 12
     +    t1507-rev-parse-upstream.sh              - 21 of 28
     +    t2404-worktree-config.sh                 - 9 of 12
     +    t1505-rev-parse-last.sh                  - 5 of 7
     +    t7510-signed-commit.sh                   - 16 of 23
     +    t2018-checkout-branch.sh                 - 15 of 22
     +    (..etc)
     +
     +
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## builtin/clone.c ##
     @@ refs.c: struct ref_store *get_submodule_ref_store(const char *submodule)
       	const char *id;
       
      
     + ## t/t1409-avoid-packing-refs.sh ##
     +@@ t/t1409-avoid-packing-refs.sh: test_description='avoid rewriting packed-refs unnecessarily'
     + 
     + . ./test-lib.sh
     + 
     ++if test_have_prereq REFTABLE
     ++then
     ++  skip_all='skipping pack-refs tests; incompatible with reftable'
     ++  test_done
     ++fi
     ++
     + # Add an identifying mark to the packed-refs file header line. This
     + # shouldn't upset readers, and it should be omitted if the file is
     + # ever rewritten.
     +
       ## t/t3210-pack-refs.sh ##
      @@ t/t3210-pack-refs.sh: semantic is still the same.
       '

-- 
gitgitgadget
