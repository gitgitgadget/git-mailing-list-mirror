Return-Path: <SRS0=xG8z=6E=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE20C55184
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7A36F20782
	for <git@archiver.kernel.org>; Mon, 20 Apr 2020 21:15:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cWI4HQrI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727889AbgDTVPC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Apr 2020 17:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726067AbgDTVPA (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 20 Apr 2020 17:15:00 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EB35C061A0E
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:14:59 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k8so781355ejv.3
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 14:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Hi0OslaLt6DRCgguPvU7PARcagGtqIsMu+5Q4kWgSHo=;
        b=cWI4HQrI1DN3W/GWBIl2VbS1JondFcBZvaa1JJtfwSCLUj+KefGSNwrYbftpm0bOmV
         YLk3+VZ5D4vFEkEGju9usVDKIjPP1bsp7WgrrOHmj+Ndqtyb/FVmeH8btCRyUyq/W76q
         8ifmoG31w2CbvpqYATXVT+IAOtd3a890jIwvWrUfwGoVZ/lHPx3RIhAPdUFpHLIqOPA/
         We7OXvlRUulPXkgnBTQrXdzaeK2NCEtUbAR9PPgEZX1Pmjq3uYCad/m9Ags5vA6ekeDq
         RMCyjJLZWvRLCwilMFTwGTS0aZ7JqWc007jKJOEUucIEdLMoXvaOclGq//r5253I9zCp
         8MYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Hi0OslaLt6DRCgguPvU7PARcagGtqIsMu+5Q4kWgSHo=;
        b=s81ALhnk63HwOzXVwsz6J04DL/Mc3BIU4p/qtqhBlE4SHQNmIsRrcxm3qkCUD4MJxJ
         U6t/DnTn61q3/U2GTE6ztv+AAooqkD90K4oI3NkpOWQP3S89phKhcXC5JjR6y/VMMjAu
         0ALDgkFJa5OIx7se3gQlHlOWXb+DU+GoKL7Wyfm2lhMADK8Qou/YPR7qr6ohZ+W4CHeK
         k8T6S22kteDRQtoMyF+xwqhpCW5IMohfz1YjkJDcDWI8kNFC/wMDg/BjYvqAKtAc2Bd1
         2+8yMGeORGzunVm+/KQlKIklIHTpeKrTRgl1bTWEsPcst+Ju/t62eYPIACs7oNHBAXRl
         a1eQ==
X-Gm-Message-State: AGi0PuaIKEGKAoVUwYYkCyy0YIcQtUp8ZaefSAbxxLZeOP2LsFotXC8S
        Lir54SxSsy/w/0MW43xJBzMxuLKO
X-Google-Smtp-Source: APiQypLm+CqVDGOR9X8SSdGtSGS4w80KRVNYOo3YO42M4ABs/HlAerh4DRDK19nbCgiq8Pv0s3ZHWg==
X-Received: by 2002:a17:906:4bc9:: with SMTP id x9mr17532510ejv.27.1587417296875;
        Mon, 20 Apr 2020 14:14:56 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z17sm44189ejw.52.2020.04.20.14.14.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 14:14:56 -0700 (PDT)
Message-Id: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
References: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 20 Apr 2020 21:14:45 +0000
Subject: [PATCH v9 00/10] Reftable support git-core
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

Feedback wanted:

 * spots marked with XXX in the Git source code.
   
   
 * what is a good test strategy? Could we have a CI flavor where we flip the
   default to reftable, and see how it fares?
   
   

v9

 * Added spec as technical doc.
 * Use 4-byte hash ID as API. Storage format for SHA256 is still pending
   discussion.

v10 

 * Serialize 4 byte hash ID to the version-2 format

v11

 * use reftable_ namespace prefix.
 * transaction API to provide locking.
 * reorganized record.{h,c}. More doc in reftable.h
 * support log record deletion.
 * pluggable malloc/free

v12 

 * More doc in slice.h, block.h, reader.h, writer.h, basics.h
 * Folded in Dscho's patch for struct initialization
 * Add "refs/" as default prefix for for_each_[raw]ref
 * Fix nullptr deref in log record copying.
 * Copy over the iteration prefix; this fixes "warning: bad replace ref
   name: e"
 * Some unresolved issues with "git gc"; disabled that part of t0031 for
   now.

Han-Wen Nienhuys (9):
  refs.h: clarify reflog iteration order
  Iterate over the "refs/" namespace in for_each_[raw]ref
  create .git/refs in files-backend.c
  refs: document how ref_iterator_advance_fn should handle symrefs
  Add .gitattributes for the reftable/ directory
  reftable: define version 2 of the spec to accomodate SHA256
  reftable: clarify how empty tables should be written
  Add reftable library
  Reftable support for git-core

Jonathan Nieder (1):
  reftable: file format documentation

 Documentation/Makefile                        |    1 +
 Documentation/technical/reftable.txt          | 1080 ++++++++++++++++
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   26 +-
 builtin/clone.c                               |    5 +-
 builtin/init-db.c                             |   51 +-
 cache.h                                       |    4 +-
 refs.c                                        |   26 +-
 refs.h                                        |    7 +-
 refs/files-backend.c                          |    6 +
 refs/refs-internal.h                          |    6 +
 refs/reftable-backend.c                       | 1021 +++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    5 +
 reftable/basics.c                             |  189 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  425 +++++++
 reftable/block.h                              |  124 ++
 reftable/blocksource.h                        |   22 +
 reftable/bytes.c                              |    0
 reftable/config.h                             |    1 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |   97 ++
 reftable/file.c                               |   98 ++
 reftable/iter.c                               |  234 ++++
 reftable/iter.h                               |   60 +
 reftable/merged.c                             |  307 +++++
 reftable/merged.h                             |   34 +
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  754 +++++++++++
 reftable/reader.h                             |   68 +
 reftable/record.c                             | 1119 ++++++++++++++++
 reftable/record.h                             |  117 ++
 reftable/reftable.h                           |  523 ++++++++
 reftable/slice.c                              |  224 ++++
 reftable/slice.h                              |   76 ++
 reftable/stack.c                              | 1132 +++++++++++++++++
 reftable/stack.h                              |   42 +
 reftable/system.h                             |   53 +
 reftable/tree.c                               |   67 +
 reftable/tree.h                               |   34 +
 reftable/update.sh                            |   14 +
 reftable/writer.c                             |  661 ++++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 t/t0031-reftable.sh                           |   35 +
 52 files changed, 9155 insertions(+), 35 deletions(-)
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
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/bytes.c
 create mode 100644 reftable/config.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
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
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/system.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100755 t/t0031-reftable.sh


base-commit: 048abe1751e6727bfbacf7b80466d78e04631f94
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v9
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v9
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v8:

  1:  05634d26dd5 =  1:  b600d0bc6dd refs.h: clarify reflog iteration order
  -:  ----------- >  2:  89b68145e8f Iterate over the "refs/" namespace in for_each_[raw]ref
  2:  8d34e2c5c8b =  3:  91f1efe24ec create .git/refs in files-backend.c
  3:  d08f823844d =  4:  56f65a2a0d7 refs: document how ref_iterator_advance_fn should handle symrefs
  4:  ca95b3a371e =  5:  b432c1cc2ae Add .gitattributes for the reftable/ directory
  5:  dfc8b131294 =  6:  b1d94be691a reftable: file format documentation
  6:  45ab5361750 =  7:  3e418d27f67 reftable: define version 2 of the spec to accomodate SHA256
  7:  67ee5962e85 =  8:  6f62be4067b reftable: clarify how empty tables should be written
  8:  4f9bdd7312b !  9:  a30001ad1e8 Add reftable library
     @@ reftable/README.md (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+commit 920f7413f7a25f308d9a203f584873f6753192ec
     ++commit b68690acad769d59e80cbb4f79c442ece133e6bd
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Wed Apr 1 12:41:41 2020 +0200
     ++Date:   Mon Apr 20 21:33:11 2020 +0200
      +
     -+    C: remove stray debug printfs
     ++    C: fix search/replace error in dump.c
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/basics.c (new)
      +	out[1] = (uint8_t)((i)&0xff);
      +}
      +
     -+/*
     -+  find smallest index i in [0, sz) at which f(i) is true, assuming
     -+  that f is ascending. Return sz if f(i) is false for all indices.
     -+*/
      +int binsearch(int sz, int (*f)(int k, void *args), void *args)
      +{
      +	int lo = 0;
     @@ reftable/basics.c (new)
      +	return len;
      +}
      +
     -+/* parse a newline separated list of names. Empty names are discarded. */
      +void parse_names(char *buf, int size, char ***namesp)
      +{
      +	char **names = NULL;
     @@ reftable/basics.h (new)
      +#define true 1
      +#define false 0
      +
     ++/* Bigendian en/decoding of integers */
     ++
      +void put_be24(byte *out, uint32_t i);
      +uint32_t get_be24(byte *in);
      +void put_be16(uint8_t *out, uint16_t i);
      +
     ++/*
     ++  find smallest index i in [0, sz) at which f(i) is true, assuming
     ++  that f is ascending. Return sz if f(i) is false for all indices.
     ++*/
      +int binsearch(int sz, int (*f)(int k, void *args), void *args);
      +
     ++/*
     ++  Frees a NULL terminated array of malloced strings. The array itself is also
     ++  freed.
     ++ */
      +void free_names(char **a);
     ++
     ++/* parse a newline separated list of names. Empty names are discarded. */
      +void parse_names(char *buf, int size, char ***namesp);
     ++
     ++/* compares two NULL-terminated arrays of strings. */
      +int names_equal(char **a, char **b);
     ++
     ++/* returns the array size of a NULL-terminated array of strings. */
      +int names_length(char **names);
      +
     ++/* Allocation routines; they invoke the functions set through
     ++ * reftable_set_alloc() */
      +void *reftable_malloc(size_t sz);
      +void *reftable_realloc(void *p, size_t sz);
      +void reftable_free(void *p);
     @@ reftable/block.c (new)
      +	abort();
      +}
      +
     -+int block_writer_register_restart(struct reftable_block_writer *w, int n,
     -+				  bool restart, struct slice key);
     ++int block_writer_register_restart(struct block_writer *w, int n, bool restart,
     ++				  struct slice key);
      +
     -+void block_writer_init(struct reftable_block_writer *bw, byte typ, byte *buf,
     ++void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
      +		       uint32_t block_size, uint32_t header_off, int hash_size)
      +{
      +	bw->buf = buf;
     @@ reftable/block.c (new)
      +	bw->next = header_off + 4;
      +	bw->restart_interval = 16;
      +	bw->entries = 0;
     ++	bw->restart_len = 0;
     ++	bw->last_key.len = 0;
      +}
      +
     -+byte block_writer_type(struct reftable_block_writer *bw)
     ++byte block_writer_type(struct block_writer *bw)
      +{
      +	return bw->buf[bw->header_off];
      +}
      +
      +/* adds the record to the block. Returns -1 if it does not fit, 0 on
      +   success */
     -+int block_writer_add(struct reftable_block_writer *w, struct record rec)
     ++int block_writer_add(struct block_writer *w, struct record rec)
      +{
      +	struct slice empty = { 0 };
      +	struct slice last = w->entries % w->restart_interval == 0 ? empty :
     @@ reftable/block.c (new)
      +		goto err;
      +	}
      +
     -+	reftable_free(slice_yield(&key));
     ++	slice_clear(&key);
      +	return 0;
      +
      +err:
     -+	reftable_free(slice_yield(&key));
     ++	slice_clear(&key);
      +	return -1;
      +}
      +
     -+int block_writer_register_restart(struct reftable_block_writer *w, int n,
     -+				  bool restart, struct slice key)
     ++int block_writer_register_restart(struct block_writer *w, int n, bool restart,
     ++				  struct slice key)
      +{
      +	int rlen = w->restart_len;
      +	if (rlen >= MAX_RESTARTS) {
     @@ reftable/block.c (new)
      +	return 0;
      +}
      +
     -+int block_writer_finish(struct reftable_block_writer *w)
     ++int block_writer_finish(struct block_writer *w)
      +{
      +	int i = 0;
      +	for (i = 0; i < w->restart_len; i++) {
     @@ reftable/block.c (new)
      +			}
      +
      +			if (Z_OK != zresult) {
     -+				reftable_free(slice_yield(&compressed));
     ++				slice_clear(&compressed);
      +				return ZLIB_ERROR;
      +			}
      +
     @@ reftable/block.c (new)
      +	return w->next;
      +}
      +
     -+byte block_reader_type(struct reftable_block_reader *r)
     ++byte block_reader_type(struct block_reader *r)
      +{
      +	return r->block.data[r->header_off];
      +}
      +
     -+int block_reader_init(struct reftable_block_reader *br,
     -+		      struct reftable_block *block, uint32_t header_off,
     -+		      uint32_t table_block_size, int hash_size)
     ++int block_reader_init(struct block_reader *br, struct reftable_block *block,
     ++		      uint32_t header_off, uint32_t table_block_size,
     ++		      int hash_size)
      +{
      +	uint32_t full_block_size = table_block_size;
      +	byte typ = block->data[header_off];
     @@ reftable/block.c (new)
      +				    uncompressed.buf + block_header_skip,
      +				    &dst_len, block->data + block_header_skip,
      +				    &src_len)) {
     -+			reftable_free(slice_yield(&uncompressed));
     ++			slice_clear(&uncompressed);
      +			return ZLIB_ERROR;
      +		}
      +
     @@ reftable/block.c (new)
      +	return 0;
      +}
      +
     -+static uint32_t block_reader_restart_offset(struct reftable_block_reader *br,
     -+					    int i)
     ++static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
      +{
      +	return get_be24(br->restart_bytes + 3 * i);
      +}
      +
     -+void block_reader_start(struct reftable_block_reader *br,
     -+			struct reftable_block_iter *it)
     ++void block_reader_start(struct block_reader *br, struct block_iter *it)
      +{
      +	it->br = br;
      +	slice_resize(&it->last_key, 0);
     @@ reftable/block.c (new)
      +struct restart_find_args {
      +	int error;
      +	struct slice key;
     -+	struct reftable_block_reader *r;
     ++	struct block_reader *r;
      +};
      +
      +static int restart_key_less(int idx, void *args)
     @@ reftable/block.c (new)
      +
      +	{
      +		int result = slice_compare(a->key, rkey);
     -+		reftable_free(slice_yield(&rkey));
     ++		slice_clear(&rkey);
      +		return result;
      +	}
      +}
      +
     -+void block_iter_copy_from(struct reftable_block_iter *dest,
     -+			  struct reftable_block_iter *src)
     ++void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
      +{
      +	dest->br = src->br;
      +	dest->next_off = src->next_off;
     @@ reftable/block.c (new)
      +}
      +
      +/* return < 0 for error, 0 for OK, > 0 for EOF. */
     -+int block_iter_next(struct reftable_block_iter *it, struct record rec)
     ++int block_iter_next(struct block_iter *it, struct record rec)
      +{
      +	if (it->next_off >= it->br->block_len) {
      +		return 1;
     @@ reftable/block.c (new)
      +
      +		slice_copy(&it->last_key, key);
      +		it->next_off += start.len - in.len;
     -+		reftable_free(slice_yield(&key));
     ++		slice_clear(&key);
      +		return 0;
      +	}
      +}
      +
     -+int block_reader_first_key(struct reftable_block_reader *br, struct slice *key)
     ++int block_reader_first_key(struct block_reader *br, struct slice *key)
      +{
      +	struct slice empty = { 0 };
      +	int off = br->header_off + 4;
     @@ reftable/block.c (new)
      +	return 0;
      +}
      +
     -+int block_iter_seek(struct reftable_block_iter *it, struct slice want)
     ++int block_iter_seek(struct block_iter *it, struct slice want)
      +{
      +	return block_reader_seek(it->br, it, want);
      +}
      +
     -+void block_iter_close(struct reftable_block_iter *it)
     ++void block_iter_close(struct block_iter *it)
      +{
     -+	reftable_free(slice_yield(&it->last_key));
     ++	slice_clear(&it->last_key);
      +}
      +
     -+int block_reader_seek(struct reftable_block_reader *br,
     -+		      struct reftable_block_iter *it, struct slice want)
     ++int block_reader_seek(struct block_reader *br, struct block_iter *it,
     ++		      struct slice want)
      +{
      +	struct restart_find_args args = {
      +		.key = want,
     @@ reftable/block.c (new)
      +		struct slice key = { 0 };
      +		int result = 0;
      +		int err = 0;
     -+		struct reftable_block_iter next = { 0 };
     ++		struct block_iter next = { 0 };
      +		while (true) {
      +			block_iter_copy_from(&next, it);
      +
     @@ reftable/block.c (new)
      +		}
      +
      +	exit:
     -+		reftable_free(slice_yield(&key));
     -+		reftable_free(slice_yield(&next.last_key));
     -+		record_clear(rec);
     -+		reftable_free(record_yield(&rec));
     ++		slice_clear(&key);
     ++		slice_clear(&next.last_key);
     ++		record_destroy(&rec);
      +
      +		return result;
      +	}
      +}
      +
     -+void block_writer_reset(struct reftable_block_writer *bw)
     -+{
     -+	bw->restart_len = 0;
     -+	bw->last_key.len = 0;
     -+}
     -+
     -+void block_writer_clear(struct reftable_block_writer *bw)
     ++void block_writer_clear(struct block_writer *bw)
      +{
      +	FREE_AND_NULL(bw->restarts);
     -+	reftable_free(slice_yield(&bw->last_key));
     ++	slice_clear(&bw->last_key);
      +	/* the block is not owned. */
      +}
      
     @@ reftable/block.h (new)
      +#include "record.h"
      +#include "reftable.h"
      +
     -+struct reftable_block_writer {
     ++/*
     ++  Writes reftable blocks. The block_writer is reused across blocks to minimize
     ++  allocation overhead.
     ++*/
     ++struct block_writer {
      +	byte *buf;
      +	uint32_t block_size;
     ++
     ++	/* Offset ofof the global header. Nonzero in the first block only. */
      +	uint32_t header_off;
     ++
     ++	/* How often to restart keys. */
      +	int restart_interval;
      +	int hash_size;
      +
     ++	/* Offset of next byte to write. */
      +	uint32_t next;
      +	uint32_t *restarts;
      +	uint32_t restart_len;
      +	uint32_t restart_cap;
     ++
      +	struct slice last_key;
      +	int entries;
      +};
      +
     -+void block_writer_init(struct reftable_block_writer *bw, byte typ, byte *buf,
     ++/*
     ++  initializes the blockwriter to write `typ` entries, using `buf` as temporary
     ++  storage. `buf` is not owned by the block_writer. */
     ++void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
      +		       uint32_t block_size, uint32_t header_off, int hash_size);
     -+byte block_writer_type(struct reftable_block_writer *bw);
     -+int block_writer_add(struct reftable_block_writer *w, struct record rec);
     -+int block_writer_finish(struct reftable_block_writer *w);
     -+void block_writer_reset(struct reftable_block_writer *bw);
     -+void block_writer_clear(struct reftable_block_writer *bw);
      +
     -+struct reftable_block_reader {
     ++/*
     ++  returns the block type (eg. 'r' for ref records.
     ++*/
     ++byte block_writer_type(struct block_writer *bw);
     ++
     ++/* appends the record, or -1 if it doesn't fit. */
     ++int block_writer_add(struct block_writer *w, struct record rec);
     ++
     ++/* appends the key restarts, and compress the block if necessary. */
     ++int block_writer_finish(struct block_writer *w);
     ++
     ++/* clears out internally allocated block_writer members. */
     ++void block_writer_clear(struct block_writer *bw);
     ++
     ++/* Read a block. */
     ++struct block_reader {
     ++	/* offset of the block header; nonzero for the first block in a
     ++	 * reftable. */
      +	uint32_t header_off;
     ++
     ++	/* the memory block */
      +	struct reftable_block block;
      +	int hash_size;
      +
      +	/* size of the data, excluding restart data. */
      +	uint32_t block_len;
      +	byte *restart_bytes;
     -+	uint32_t full_block_size;
      +	uint16_t restart_count;
     ++
     ++	/* size of the data in the file. For log blocks, this is the compressed
     ++	 * size. */
     ++	uint32_t full_block_size;
      +};
      +
     -+struct reftable_block_iter {
     ++/* Iterate over entries in a block */
     ++struct block_iter {
     ++	/* offset within the block of the next entry to read. */
      +	uint32_t next_off;
     -+	struct reftable_block_reader *br;
     ++	struct block_reader *br;
     ++
     ++	/* key for last entry we read. */
      +	struct slice last_key;
      +};
      +
     -+int block_reader_init(struct reftable_block_reader *br,
     -+		      struct reftable_block *bl, uint32_t header_off,
     -+		      uint32_t table_block_size, int hash_size);
     -+void block_reader_start(struct reftable_block_reader *br,
     -+			struct reftable_block_iter *it);
     -+int block_reader_seek(struct reftable_block_reader *br,
     -+		      struct reftable_block_iter *it, struct slice want);
     -+byte block_reader_type(struct reftable_block_reader *r);
     -+int block_reader_first_key(struct reftable_block_reader *br, struct slice *key);
     -+
     -+void block_iter_copy_from(struct reftable_block_iter *dest,
     -+			  struct reftable_block_iter *src);
     -+int block_iter_next(struct reftable_block_iter *it, struct record rec);
     -+int block_iter_seek(struct reftable_block_iter *it, struct slice want);
     -+void block_iter_close(struct reftable_block_iter *it);
     ++/* initializes a block reader */
     ++int block_reader_init(struct block_reader *br, struct reftable_block *bl,
     ++		      uint32_t header_off, uint32_t table_block_size,
     ++		      int hash_size);
     ++
     ++/* Position `it` at start of the block */
     ++void block_reader_start(struct block_reader *br, struct block_iter *it);
     ++
     ++/* Position `it` to the `want` key in the block */
     ++int block_reader_seek(struct block_reader *br, struct block_iter *it,
     ++		      struct slice want);
     ++
     ++/* Returns the block type (eg. 'r' for refs) */
     ++byte block_reader_type(struct block_reader *r);
     ++
     ++/* Decodes the first key in the block */
     ++int block_reader_first_key(struct block_reader *br, struct slice *key);
     ++
     ++void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
     ++int block_iter_next(struct block_iter *it, struct record rec);
     ++
     ++/* Seek to `want` with in the block pointed to by `it` */
     ++int block_iter_seek(struct block_iter *it, struct slice want);
     ++
     ++/* deallocate memory for `it`. The block reader and its block is left intact. */
     ++void block_iter_close(struct block_iter *it);
      +
     ++/* size of file header, depending on format version */
      +int header_size(int version);
     ++
     ++/* size of file footer, depending on format version */
      +int footer_size(int version);
      +
      +#endif
     @@ reftable/iter.c (new)
      +{
      +	struct filtering_ref_iterator *fri =
      +		(struct filtering_ref_iterator *)iter_arg;
     -+	reftable_free(slice_yield(&fri->oid));
     ++	slice_clear(&fri->oid);
      +	reftable_iterator_destroy(&fri->it);
      +}
      +
     @@ reftable/iter.c (new)
      +	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
      +	block_iter_close(&it->cur);
      +	reader_return_block(it->r, &it->block_reader.block);
     -+	reftable_free(slice_yield(&it->oid));
     ++	slice_clear(&it->oid);
      +}
      +
      +static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
     @@ reftable/iter.h (new)
      +int iterator_next(struct reftable_iterator it, struct record rec);
      +bool iterator_is_null(struct reftable_iterator it);
      +
     ++/* iterator that produces only ref records that point to `oid` */
      +struct filtering_ref_iterator {
      +	bool double_check;
      +	struct reftable_reader *r;
     @@ reftable/iter.h (new)
      +void iterator_from_filtering_ref_iterator(struct reftable_iterator *,
      +					  struct filtering_ref_iterator *);
      +
     ++/* iterator that produces only ref records that point to `oid`,
     ++   but using the object index.
     ++ */
      +struct indexed_table_ref_iter {
      +	struct reftable_reader *r;
      +	struct slice oid;
     @@ reftable/iter.h (new)
      +	/* Points to the next offset to read. */
      +	int offset_idx;
      +	int offset_len;
     -+	struct reftable_block_reader block_reader;
     -+	struct reftable_block_iter cur;
     ++	struct block_reader block_reader;
     ++	struct block_iter cur;
      +	bool finished;
      +};
      +
     @@ reftable/merged.c (new)
      +
      +		if (err > 0) {
      +			reftable_iterator_destroy(&mi->stack[i]);
     -+			record_clear(rec);
     -+			reftable_free(record_yield(&rec));
     ++			record_destroy(&rec);
      +		} else {
      +			struct pq_entry e = {
      +				.rec = rec,
     @@ reftable/merged.c (new)
      +
      +		if (err > 0) {
      +			reftable_iterator_destroy(&mi->stack[idx]);
     -+			record_clear(rec);
     -+			reftable_free(record_yield(&rec));
     ++			record_destroy(&rec);
      +			return 0;
      +		}
      +
     @@ reftable/merged.c (new)
      +		return err;
      +	}
      +
     ++
     ++        /*
     ++          One can also use reftable as datacenter-local storage, where the ref
     ++          database is maintained in globally consistent database (eg.
     ++          CockroachDB or Spanner). In this scenario, replication delays together
     ++          with compaction may cause newer tables to contain older entries. In
     ++          such a deployment, the loop below must be changed to collect all
     ++          entries for the same key, and return new the newest one.
     ++        */
      +	record_key(entry.rec, &entry_key);
      +	while (!merged_iter_pqueue_is_empty(mi->pq)) {
      +		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
     @@ reftable/merged.c (new)
      +		record_key(top.rec, &k);
      +
      +		cmp = slice_compare(k, entry_key);
     -+		reftable_free(slice_yield(&k));
     ++		slice_clear(&k);
      +
      +		if (cmp > 0) {
      +			break;
     @@ reftable/merged.c (new)
      +	record_copy_from(rec, entry.rec, hash_size(mi->hash_id));
      +	record_clear(entry.rec);
      +	reftable_free(record_yield(&entry.rec));
     -+	reftable_free(slice_yield(&entry_key));
     ++	slice_clear(&entry_key);
      +	return 0;
      +}
      +
     @@ reftable/merged.c (new)
      +		return err;
      +	}
      +
     -+	merged.stack_len = n, err = merged_iter_init(&merged);
     ++	merged.stack_len = n;
     ++	err = merged_iter_init(&merged);
      +	if (err < 0) {
      +		merged_iter_close(&merged);
      +		return err;
     @@ reftable/pq.c (new)
      +
      +	cmp = slice_compare(ak, bk);
      +
     -+	reftable_free(slice_yield(&ak));
     -+	reftable_free(slice_yield(&bk));
     ++	slice_clear(&ak);
     ++	slice_clear(&bk);
      +
      +	if (cmp == 0) {
      +		return a.index > b.index;
     @@ reftable/reader.c (new)
      +	struct reftable_reader *r;
      +	byte typ;
      +	uint64_t block_off;
     -+	struct reftable_block_iter bi;
     ++	struct block_iter bi;
      +	bool finished;
      +};
      +
     @@ reftable/reader.c (new)
      +	return result;
      +}
      +
     -+int reader_init_block_reader(struct reftable_reader *r,
     -+			     struct reftable_block_reader *br,
     ++int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
      +			     uint64_t next_off, byte want_typ)
      +{
      +	int32_t guess_block_size = r->block_size ? r->block_size :
     @@ reftable/reader.c (new)
      +				 struct table_iter *src)
      +{
      +	uint64_t next_block_off = src->block_off + src->bi.br->full_block_size;
     -+	struct reftable_block_reader br = { 0 };
     ++	struct block_reader br = { 0 };
      +	int err = 0;
      +
      +	dest->r = src->r;
     @@ reftable/reader.c (new)
      +	}
      +
      +	{
     -+		struct reftable_block_reader *brp =
     -+			reftable_malloc(sizeof(struct reftable_block_reader));
     ++		struct block_reader *brp =
     ++			reftable_malloc(sizeof(struct block_reader));
      +		*brp = br;
      +
      +		dest->finished = false;
     @@ reftable/reader.c (new)
      +static int reader_table_iter_at(struct reftable_reader *r,
      +				struct table_iter *ti, uint64_t off, byte typ)
      +{
     -+	struct reftable_block_reader br = { 0 };
     -+	struct reftable_block_reader *brp = NULL;
     ++	struct block_reader br = { 0 };
     ++	struct block_reader *brp = NULL;
      +
      +	int err = reader_init_block_reader(r, &br, off, typ);
      +	if (err != 0) {
      +		return err;
      +	}
      +
     -+	brp = reftable_malloc(sizeof(struct reftable_block_reader));
     ++	brp = reftable_malloc(sizeof(struct block_reader));
      +	*brp = br;
      +	ti->r = r;
      +	ti->typ = block_reader_type(brp);
     @@ reftable/reader.c (new)
      +
      +exit:
      +	block_iter_close(&next.bi);
     -+	record_clear(rec);
     -+	reftable_free(record_yield(&rec));
     -+	reftable_free(slice_yield(&want_key));
     -+	reftable_free(slice_yield(&got_key));
     ++	record_destroy(&rec);
     ++	slice_clear(&want_key);
     ++	slice_clear(&got_key);
      +	return err;
      +}
      +
     @@ reftable/reader.h (new)
      +			       struct reftable_block *ret);
      +void block_source_close(struct reftable_block_source *source);
      +
     ++/* metadata for a block type */
      +struct reftable_reader_offsets {
      +	bool present;
      +	uint64_t offset;
      +	uint64_t index_offset;
      +};
      +
     ++/* The state for reading a reftable file. */
      +struct reftable_reader {
     ++	/* for convience, associate a name with the instance. */
      +	char *name;
      +	struct reftable_block_source source;
     -+	uint32_t hash_id;
      +
     -+	// Size of the file, excluding the footer.
     ++	/* Size of the file, excluding the footer. */
      +	uint64_t size;
     ++
     ++	/* 'sha1' for SHA1, 's256' for SHA-256 */
     ++	uint32_t hash_id;
     ++
      +	uint32_t block_size;
      +	uint64_t min_update_index;
      +	uint64_t max_update_index;
     ++	/* Length of the OID keys in the 'o' section */
      +	int object_id_len;
      +	int version;
      +
     @@ reftable/reader.h (new)
      +void reader_close(struct reftable_reader *r);
      +const char *reader_name(struct reftable_reader *r);
      +void reader_return_block(struct reftable_reader *r, struct reftable_block *p);
     -+int reader_init_block_reader(struct reftable_reader *r,
     -+			     struct reftable_block_reader *br,
     ++
     ++/* initialize a block reader to read from `r` */
     ++int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
      +			     uint64_t next_off, byte want_typ);
      +
      +#endif
     @@ reftable/record.c (new)
      +		(const struct reftable_log_record *)src_rec;
      +
      +	*dst = *src;
     -+	dst->ref_name = xstrdup(dst->ref_name);
     -+	dst->email = xstrdup(dst->email);
     -+	dst->name = xstrdup(dst->name);
     -+	dst->message = xstrdup(dst->message);
     ++	if (dst->ref_name != NULL) {
     ++		dst->ref_name = xstrdup(dst->ref_name);
     ++	}
     ++	if (dst->email != NULL) {
     ++		dst->email = xstrdup(dst->email);
     ++	}
     ++	if (dst->name != NULL) {
     ++		dst->name = xstrdup(dst->name);
     ++	}
     ++	if (dst->message != NULL) {
     ++		dst->message = xstrdup(dst->message);
     ++	}
     ++
      +	if (dst->new_hash != NULL) {
      +		dst->new_hash = reftable_malloc(hash_size);
      +		memcpy(dst->new_hash, src->new_hash, hash_size);
     @@ reftable/record.c (new)
      +	return start.len - in.len;
      +
      +error:
     -+	reftable_free(slice_yield(&dest));
     ++	slice_clear(&dest);
      +	return FORMAT_ERROR;
      +}
      +
     @@ reftable/record.c (new)
      +	return rec;
      +}
      +
     ++void *record_yield(struct record *rec)
     ++{
     ++	void *p = rec->data;
     ++	rec->data = NULL;
     ++	return p;
     ++}
     ++
     ++void record_destroy(struct record *rec)
     ++{
     ++	record_clear(*rec);
     ++	reftable_free(record_yield(rec));
     ++}
     ++
      +static byte index_record_type(void)
      +{
      +	return BLOCK_TYPE_INDEX;
     @@ reftable/record.c (new)
      +static void index_record_clear(void *rec)
      +{
      +	struct index_record *idx = (struct index_record *)rec;
     -+	reftable_free(slice_yield(&idx->last_key));
     ++	slice_clear(&idx->last_key);
      +}
      +
      +static byte index_record_val_type(const void *rec)
     @@ reftable/record.c (new)
      +	rec->ops = &reftable_log_record_vtable;
      +}
      +
     -+void *record_yield(struct record *rec)
     -+{
     -+	void *p = rec->data;
     -+	rec->data = NULL;
     -+	return p;
     -+}
     -+
      +struct reftable_ref_record *record_as_ref(struct record rec)
      +{
      +	assert(record_type(rec) == BLOCK_TYPE_REF);
      +	return (struct reftable_ref_record *)rec.data;
      +}
      +
     ++struct reftable_log_record *record_as_log(struct record rec)
     ++{
     ++	assert(record_type(rec) == BLOCK_TYPE_LOG);
     ++	return (struct reftable_log_record *)rec.data;
     ++}
     ++
      +static bool hash_equal(byte *a, byte *b, int hash_size)
      +{
      +	if (a != NULL && b != NULL) {
     @@ reftable/record.h (new)
      +	struct record_vtable *ops;
      +};
      +
     ++/* returns true for recognized block types. Block start with the block type. */
      +int is_block_type(byte typ);
      +
     ++/* creates a malloced record of the given type. Dispose with record_destroy */
      +struct record new_record(byte typ);
      +
      +extern struct record_vtable reftable_ref_record_vtable;
      +
     ++/* Encode `key` into `dest`. Sets `restart` to indicate a restart. Returns
     ++   number of bytes written. */
      +int encode_key(bool *restart, struct slice dest, struct slice prev_key,
      +	       struct slice key, byte extra);
     ++
     ++/* Decode into `key` and `extra` from `in` */
      +int decode_key(struct slice *key, byte *extra, struct slice last_key,
      +	       struct slice in);
      +
     @@ reftable/record.h (new)
      +int record_encode(struct record rec, struct slice dest, int hash_size);
      +int record_decode(struct record rec, struct slice key, byte extra,
      +		  struct slice src, int hash_size);
     ++
     ++/* zeroes out the embedded record */
      +void record_clear(struct record rec);
      +
      +/* clear out the record, yielding the record data that was encapsulated. */
      +void *record_yield(struct record *rec);
      +
     ++/* clear and deallocate embedded record, and zero `rec`. */
     ++void record_destroy(struct record *rec);
     ++
      +/* initialize generic records from concrete records. The generic record should
      + * be zeroed out. */
     -+
      +void record_from_obj(struct record *rec, struct obj_record *objrec);
      +void record_from_index(struct record *rec, struct index_record *idxrec);
      +void record_from_ref(struct record *rec, struct reftable_ref_record *refrec);
      +void record_from_log(struct record *rec, struct reftable_log_record *logrec);
      +struct reftable_ref_record *record_as_ref(struct record ref);
     ++struct reftable_log_record *record_as_log(struct record ref);
      +
      +/* for qsort. */
      +int reftable_ref_record_compare_name(const void *a, const void *b);
     @@ reftable/reftable.h (new)
      +/*
      +  returns a new transaction to add reftables to the given stack. As a side
      +  effect, the ref database is locked.
     -+*/ 
     -+int reftable_stack_new_addition(struct reftable_addition **dest, struct reftable_stack *st);
     ++*/
     ++int reftable_stack_new_addition(struct reftable_addition **dest,
     ++				struct reftable_stack *st);
      +
     -+/* Adds a reftable to transaction. */ 
     ++/* Adds a reftable to transaction. */
      +int reftable_addition_add(struct reftable_addition *add,
     -+                          int (*write_table)(struct reftable_writer *wr, void *arg),
     -+                          void *arg);
     ++			  int (*write_table)(struct reftable_writer *wr,
     ++					     void *arg),
     ++			  void *arg);
      +
      +/* Commits the transaction, releasing the lock. */
      +int reftable_addition_commit(struct reftable_addition *add);
      +
     -+/* Release all non-committed data from the transaction; releases the lock if held. */
     ++/* Release all non-committed data from the transaction; releases the lock if
     ++ * held. */
      +void reftable_addition_close(struct reftable_addition *add);
      +
      +/* add a new table to the stack. The write_table function must call
     @@ reftable/slice.c (new)
      +	return p;
      +}
      +
     ++void slice_clear(struct slice *s)
     ++{
     ++	reftable_free(slice_yield(s));
     ++}
     ++
      +void slice_copy(struct slice *dest, struct slice src)
      +{
      +	slice_resize(dest, src.len);
     @@ reftable/slice.h (new)
      +#include "basics.h"
      +#include "reftable.h"
      +
     ++/*
     ++  provides bounds-checked byte ranges.
     ++  To use, initialize as "slice x = {0};"
     ++ */
      +struct slice {
     -+	byte *buf;
      +	int len;
      +	int cap;
     ++	byte *buf;
      +};
      +
     -+void slice_set_string(struct slice *dest, const char *);
     -+void slice_append_string(struct slice *dest, const char *);
     ++void slice_set_string(struct slice *dest, const char *src);
     ++void slice_append_string(struct slice *dest, const char *src);
     ++/* Set length to 0, but retain buffer */
     ++void slice_clear(struct slice *slice);
     ++
     ++/* Return a malloced string for `src` */
      +char *slice_to_string(struct slice src);
     ++
     ++/* Ensure that `buf` is \0 terminated. */
      +const char *slice_as_string(struct slice *src);
     ++
     ++/* Compare slices */
      +bool slice_equal(struct slice a, struct slice b);
     ++
     ++/* Return `buf`, clearing out `s` */
      +byte *slice_yield(struct slice *s);
     ++
     ++/* Copy bytes */
      +void slice_copy(struct slice *dest, struct slice src);
     ++
     ++/* Advance `buf` by `n`, and decrease length. A copy of the slice
     ++   should be kept for deallocating the slice. */
      +void slice_consume(struct slice *s, int n);
     ++
     ++/* Set length of the slice to `l` */
      +void slice_resize(struct slice *s, int l);
     ++
     ++/* Signed comparison */
      +int slice_compare(struct slice a, struct slice b);
     -+int slice_write(struct slice *b, byte *data, int sz);
     -+int slice_write_void(void *b, byte *data, int sz);
     ++
     ++/* Append `data` to the `dest` slice.  */
     ++int slice_write(struct slice *dest, byte *data, int sz);
     ++
     ++/* Append `add` to `dest. */
      +void slice_append(struct slice *dest, struct slice add);
     ++
     ++/* Like slice_write, but suitable for passing to reftable_new_writer
     ++ */
     ++int slice_write_void(void *b, byte *data, int sz);
     ++
     ++/* Find the longest shared prefix size of `a` and `b` */
      +int common_prefix_size(struct slice a, struct slice b);
      +
      +struct reftable_block_source;
     ++
     ++/* Create an in-memory block source for reading reftables */
      +void block_source_from_slice(struct reftable_block_source *bs,
      +			     struct slice *buf);
      +
     @@ reftable/stack.c (new)
      +	slice_append_string(&list_file_name, "/reftables.list");
      +
      +	p->list_file = slice_to_string(list_file_name);
     -+	reftable_free(slice_yield(&list_file_name));
     ++	slice_clear(&list_file_name);
      +	p->reftable_dir = xstrdup(dir);
      +	p->config = config;
      +
     @@ reftable/stack.c (new)
      +		}
      +	}
      +exit:
     -+	reftable_free(slice_yield(&table_path));
     ++	slice_clear(&table_path);
      +	{
      +		int i = 0;
      +		for (i = 0; i < new_tables_len; i++) {
     @@ reftable/stack.c (new)
      +	}
      +	if (add->lock_file_name.len > 0) {
      +		unlink(slice_as_string(&add->lock_file_name));
     -+		reftable_free(slice_yield(&add->lock_file_name));
     ++		slice_clear(&add->lock_file_name);
      +	}
      +
      +	free_names(add->names);
     @@ reftable/stack.c (new)
      +	}
      +
      +	err = write(add->lock_file_fd, table_list.buf, table_list.len);
     -+	free(slice_yield(&table_list));
     ++	slice_clear(&table_list);
      +	if (err < 0) {
      +		err = IO_ERROR;
      +		goto exit;
     @@ reftable/stack.c (new)
      +		unlink(slice_as_string(&temp_tab_file_name));
      +	}
      +
     -+	reftable_free(slice_yield(&temp_tab_file_name));
     -+	reftable_free(slice_yield(&tab_file_name));
     -+	reftable_free(slice_yield(&next_name));
     ++	slice_clear(&temp_tab_file_name);
     ++	slice_clear(&tab_file_name);
     ++	slice_clear(&next_name);
      +	reftable_writer_free(wr);
      +	return err;
      +}
     @@ reftable/stack.c (new)
      +	}
      +	if (err != 0 && temp_tab->len > 0) {
      +		unlink(slice_as_string(temp_tab));
     -+		reftable_free(slice_yield(temp_tab));
     ++		slice_clear(temp_tab);
      +	}
     -+	reftable_free(slice_yield(&next_name));
     ++	slice_clear(&next_name);
      +	return err;
      +}
      +
     @@ reftable/stack.c (new)
      +	if (have_lock) {
      +		unlink(slice_as_string(&lock_file_name));
      +	}
     -+	reftable_free(slice_yield(&new_table_name));
     -+	reftable_free(slice_yield(&new_table_path));
     -+	reftable_free(slice_yield(&ref_list_contents));
     -+	reftable_free(slice_yield(&temp_tab_file_name));
     -+	reftable_free(slice_yield(&lock_file_name));
     ++	slice_clear(&new_table_name);
     ++	slice_clear(&new_table_path);
     ++	slice_clear(&ref_list_contents);
     ++	slice_clear(&temp_tab_file_name);
     ++	slice_clear(&lock_file_name);
      +	return err;
      +}
      +
     @@ reftable/tree.h (new)
      +#ifndef TREE_H
      +#define TREE_H
      +
     ++/* tree_node is a generic binary search tree. */
      +struct tree_node {
      +	void *key;
      +	struct tree_node *left, *right;
      +};
      +
     ++/* looks for `key` in `rootp` using `compare` as comparison function. If insert
     ++   is set, insert the key if it's not found. Else, return NULL.
     ++*/
      +struct tree_node *tree_search(void *key, struct tree_node **rootp,
      +			      int (*compare)(const void *, const void *),
      +			      int insert);
     ++
     ++/* performs an infix walk of the tree. */
      +void infix_walk(struct tree_node *t, void (*action)(void *arg, void *key),
      +		void *arg);
     ++
     ++/*
     ++  deallocates the tree nodes recursively. Keys should be deallocated separately
     ++  by walking over the tree. */
      +void tree_free(struct tree_node *t);
      +
      +#endif
     @@ reftable/writer.c (new)
      +
      +	result = 0;
      +exit:
     -+	reftable_free(slice_yield(&key));
     ++	slice_clear(&key);
      +	return result;
      +}
      +
     @@ reftable/writer.c (new)
      +			assert(err == 0);
      +		}
      +		for (i = 0; i < idx_len; i++) {
     -+			reftable_free(slice_yield(&idx[i].last_key));
     ++			slice_clear(&idx[i].last_key);
      +		}
      +		reftable_free(idx);
      +	}
     @@ reftable/writer.c (new)
      +	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
      +
      +	FREE_AND_NULL(entry->offsets);
     -+	reftable_free(slice_yield(&entry->hash));
     ++	slice_clear(&entry->hash);
      +	reftable_free(entry);
      +}
      +
     @@ reftable/writer.c (new)
      +{
      +	byte footer[72];
      +	byte *p = footer;
     -+
      +	int err = writer_finish_public_section(w);
     ++	int empty_table = w->next == 0;
      +	if (err != 0) {
      +		goto exit;
      +	}
     ++	w->pending_padding = 0;
     ++	if (empty_table) {
     ++		// Empty tables need a header anyway.
     ++		byte header[28];
     ++		int n = writer_write_header(w, header);
     ++		err = padded_write(w, header, n, 0);
     ++		if (err < 0) {
     ++			goto exit;
     ++		}
     ++	}
      +
      +	p += writer_write_header(w, footer);
      +	put_be64(p, w->stats.ref_stats.index_offset);
     @@ reftable/writer.c (new)
      +
      +	put_be32(p, crc32(0, footer, p - footer));
      +	p += 4;
     -+	w->pending_padding = 0;
      +
      +	err = padded_write(w, footer, footer_size(writer_version(w)), 0);
      +	if (err < 0) {
      +		goto exit;
      +	}
      +
     -+	if (w->stats.log_stats.entries + w->stats.ref_stats.entries == 0) {
     ++	if (empty_table) {
      +		err = EMPTY_TABLE_ERROR;
      +		goto exit;
      +	}
     @@ reftable/writer.c (new)
      +	/* free up memory. */
      +	block_writer_clear(&w->block_writer_data);
      +	writer_clear_index(w);
     -+	reftable_free(slice_yield(&w->last_key));
     ++	slice_clear(&w->last_key);
      +	return err;
      +}
      +
     @@ reftable/writer.c (new)
      +{
      +	int i = 0;
      +	for (i = 0; i < w->index_len; i++) {
     -+		reftable_free(slice_yield(&w->index[i].last_key));
     ++		slice_clear(&w->index[i].last_key);
      +	}
      +
      +	FREE_AND_NULL(w->index);
     @@ reftable/writer.c (new)
      +
      +	w->index_len++;
      +	w->next += padding + raw_bytes;
     -+	block_writer_reset(&w->block_writer_data);
      +	w->block_writer = NULL;
      +	return 0;
      +}
     @@ reftable/writer.h (new)
      +	int pending_padding;
      +	struct slice last_key;
      +
     ++	/* offset of next block to write. */
      +	uint64_t next;
      +	uint64_t min_update_index, max_update_index;
      +	struct reftable_write_options opts;
      +
     ++	/* memory buffer for writing */
      +	byte *block;
     -+	struct reftable_block_writer *block_writer;
     -+	struct reftable_block_writer block_writer_data;
     ++
     ++	/* writer for the current section. NULL or points to
     ++	 * block_writer_data */
     ++	struct block_writer *block_writer;
     ++
     ++	struct block_writer block_writer_data;
     ++
     ++	/* pending index records for the current section */
      +	struct index_record *index;
      +	int index_len;
      +	int index_cap;
      +
     -+	/* tree for use with tsearch */
     ++	/*
     ++	  tree for use with tsearch; used to populate the 'o' inverse OID
     ++	  map */
      +	struct tree_node *obj_index_tree;
      +
      +	struct reftable_stats stats;
      +};
      +
     ++/* finishes a block, and writes it to storage */
      +int writer_flush_block(struct reftable_writer *w);
     ++
     ++/* deallocates memory related to the index */
      +void writer_clear_index(struct reftable_writer *w);
     ++
     ++/* finishes writing a 'r' (refs) or 'g' (reflogs) section */
      +int writer_finish_public_section(struct reftable_writer *w);
      +
      +#endif
  9:  b29c4ecc1c4 ! 10:  ad72edbcfd4 Reftable support for git-core
     @@ Commit message
      
          TODO:
      
     -     * "git show-ref" shows "HEAD"
           * Resolve spots marked with XXX
           * Test strategy?
      
          Example use: see t/t0031-reftable.sh
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Co-authored-by: Jeff King <peff@peff.net>
      
       ## Documentation/technical/repository-version.txt ##
     @@ Makefile: $(XDIFF_LIB): $(XDIFF_OBJS)
       export DEFAULT_EDITOR DEFAULT_PAGER
       
       Documentation/GIT-EXCLUDED-PROGRAMS: FORCE
     +@@ Makefile: cocciclean:
     + clean: profile-clean coverage-clean cocciclean
     + 	$(RM) *.res
     + 	$(RM) $(OBJECTS)
     +-	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB)
     ++	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(VCSSVN_LIB) $(REFTABLE_LIB)
     + 	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) git$X
     + 	$(RM) $(TEST_PROGRAMS)
     + 	$(RM) $(FUZZ_PROGRAMS)
      
       ## builtin/clone.c ##
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     @@ refs/reftable-backend.c (new)
      +static void fill_reftable_log_record(struct reftable_log_record *log)
      +{
      +	const char *info = git_committer_info(0);
     -+	struct ident_split split = {};
     ++	struct ident_split split = { NULL };
      +	int result = split_ident_line(&split, info, strlen(info));
      +	int sign = 1;
      +	assert(0 == result);
     @@ refs/reftable-backend.c (new)
      +}
      +
      +static struct ref_store *git_reftable_ref_store_create(const char *path,
     -+						   unsigned int store_flags)
     ++						       unsigned int store_flags)
      +{
      +	struct git_reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
      +	struct ref_store *ref_store = (struct ref_store *)refs;
     @@ refs/reftable-backend.c (new)
      +	struct ref_store *ref_store;
      +	unsigned int flags;
      +	int err;
     -+	char *prefix;
     ++	const char *prefix;
      +};
      +
      +static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
      +{
     -+	struct git_reftable_iterator *ri = (struct git_reftable_iterator *)ref_iterator;
     ++	struct git_reftable_iterator *ri =
     ++		(struct git_reftable_iterator *)ref_iterator;
      +	while (ri->err == 0) {
      +		ri->err = reftable_iterator_next_ref(ri->iter, &ri->ref);
      +		if (ri->err) {
     @@ refs/reftable-backend.c (new)
      +static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
      +				      struct object_id *peeled)
      +{
     -+	struct git_reftable_iterator *ri = (struct git_reftable_iterator *)ref_iterator;
     ++	struct git_reftable_iterator *ri =
     ++		(struct git_reftable_iterator *)ref_iterator;
      +	if (ri->ref.target_value != NULL) {
      +		hashcpy(peeled->hash, ri->ref.target_value);
      +		return 0;
     @@ refs/reftable-backend.c (new)
      +
      +static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
      +{
     -+	struct git_reftable_iterator *ri = (struct git_reftable_iterator *)ref_iterator;
     ++	struct git_reftable_iterator *ri =
     ++		(struct git_reftable_iterator *)ref_iterator;
      +	reftable_ref_record_clear(&ri->ref);
      +	reftable_iterator_destroy(&ri->iter);
      +	return 0;
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
     ++        ri->prefix = prefix;
      +	ri->base.oid = &ri->oid;
      +	ri->flags = flags;
      +	ri->ref_store = ref_store;
     @@ refs/reftable-backend.c (new)
      +static int reftable_check_old_oid(struct ref_store *refs, const char *refname,
      +				  struct object_id *want_oid)
      +{
     -+	struct object_id out_oid = {};
     ++	struct object_id out_oid;
      +	int out_flags = 0;
      +	const char *resolved = refs_resolve_ref_unsafe(
      +		refs, refname, RESOLVE_REF_READING, &out_oid, &out_flags);
     @@ refs/reftable-backend.c (new)
      +		(struct git_reftable_ref_store *)transaction->ref_store;
      +	uint64_t ts = reftable_stack_next_update_index(refs->stack);
      +	int err = 0;
     -+	struct reftable_log_record *logs = calloc(transaction->nr, sizeof(*logs));
     ++	struct reftable_log_record *logs =
     ++		calloc(transaction->nr, sizeof(*logs));
      +	struct ref_update **sorted =
      +		malloc(transaction->nr * sizeof(struct ref_update *));
      +	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
     @@ refs/reftable-backend.c (new)
      +		log->message = u->msg;
      +
      +		if (u->flags & REF_HAVE_NEW) {
     -+			struct object_id out_oid = {};
     ++			struct object_id out_oid;
      +			int out_flags = 0;
      +			/* Memory owned by refs_resolve_ref_unsafe, no need to
      +			 * free(). */
      +			const char *resolved = refs_resolve_ref_unsafe(
      +				transaction->ref_store, u->refname, 0, &out_oid,
      +				&out_flags);
     -+			struct reftable_ref_record ref = {};
     ++			struct reftable_ref_record ref = { NULL };
      +			ref.ref_name =
      +				(char *)(resolved ? resolved : u->refname);
      +			log->ref_name = ref.ref_name;
     @@ refs/reftable-backend.c (new)
      +		return refs->err;
      +	}
      +
     -+	err = reftable_stack_add(refs->stack, &write_transaction_table, transaction);
     ++	err = reftable_stack_add(refs->stack, &write_transaction_table,
     ++				 transaction);
      +	if (err < 0) {
      +		strbuf_addf(errmsg, "reftable: transaction failure %s",
      +			    reftable_error_str(err));
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	for (int i = 0; i < arg->refnames->nr; i++) {
     -+		struct reftable_log_record log = {};
     -+		struct reftable_ref_record current = {};
     ++		struct reftable_log_record log = { NULL };
     ++		struct reftable_ref_record current = { NULL };
      +		fill_reftable_log_record(&log);
      +		log.message = xstrdup(arg->logmsg);
      +		log.new_hash = NULL;
     @@ refs/reftable-backend.c (new)
      +		log.update_index = ts;
      +		log.ref_name = (char *)arg->refnames->items[i].string;
      +
     -+		if (reftable_stack_read_ref(arg->stack, log.ref_name, &current) == 0) {
     ++		if (reftable_stack_read_ref(arg->stack, log.ref_name,
     ++					    &current) == 0) {
      +			log.old_hash = current.value;
      +		}
      +		err = reftable_writer_add_log(writer, &log);
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	{
     -+		struct reftable_log_record log = {};
     -+		struct object_id new_oid = {};
     -+		struct object_id old_oid = {};
     -+		struct reftable_ref_record current = {};
     -+		reftable_stack_read_ref(create->refs->stack, create->refname, &current);
     ++		struct reftable_log_record log = { NULL };
     ++		struct object_id new_oid;
     ++		struct object_id old_oid;
     ++		struct reftable_ref_record current = { NULL };
     ++		reftable_stack_read_ref(create->refs->stack, create->refname,
     ++					&current);
      +
      +		fill_reftable_log_record(&log);
      +		log.ref_name = current.ref_name;
     @@ refs/reftable-backend.c (new)
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
     -+	return reftable_stack_add(refs->stack, &write_create_symref_table, &arg);
     ++	return reftable_stack_add(refs->stack, &write_create_symref_table,
     ++				  &arg);
      +}
      +
      +struct write_rename_arg {
     @@ refs/reftable-backend.c (new)
      +{
      +	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
      +	uint64_t ts = reftable_stack_next_update_index(arg->stack);
     -+	struct reftable_ref_record ref = {};
     ++	struct reftable_ref_record ref = { NULL };
      +	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &ref);
      +
      +	if (err) {
     @@ refs/reftable-backend.c (new)
      +	ref.update_index = ts;
      +
      +	{
     -+		struct reftable_ref_record todo[2] = {};
     ++		struct reftable_ref_record todo[2] = { { NULL } };
      +		todo[0].ref_name = (char *)arg->oldname;
      +		todo[0].update_index = ts;
      +		/* leave todo[0] empty */
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	if (ref.value != NULL) {
     -+		struct reftable_log_record todo[2] = {};
     ++		struct reftable_log_record todo[2] = { { NULL } };
      +		fill_reftable_log_record(&todo[0]);
      +		fill_reftable_log_record(&todo[1]);
      +
     @@ refs/reftable-backend.c (new)
      +			return ITER_ERROR;
      +		}
      +
     ++                if (reftable_log_record_is_deletion(&ri->log)) {
     ++                        /* XXX - Why does the reftable_stack filter these? */
     ++                        continue;
     ++                }
      +		ri->base.refname = ri->log.ref_name;
      +		if (ri->last_name != NULL &&
      +		    !strcmp(ri->log.ref_name, ri->last_name)) {
     ++                        /* we want the refnames that we have reflogs for, so we
     ++                         * skip if we've already produced this name. This could
     ++                         * be faster by seeking directly to
     ++                         * reflog@update_index==0.
     ++                         */
      +			continue;
      +		}
      +
     @@ refs/reftable-backend.c (new)
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +
     -+	struct reftable_merged_table *mt = reftable_stack_merged_table(refs->stack);
     ++	struct reftable_merged_table *mt =
     ++		reftable_stack_merged_table(refs->stack);
      +	int err = reftable_merged_table_seek_log(mt, &ri->iter, "");
      +	if (err < 0) {
      +		free(ri);
     @@ refs/reftable-backend.c (new)
      +					  const char *refname,
      +					  each_reflog_ent_fn fn, void *cb_data)
      +{
     -+	struct reftable_iterator it = {};
     ++	struct reftable_iterator it = { NULL };
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +	struct reftable_merged_table *mt = NULL;
      +	int err = 0;
     -+	struct reftable_log_record log = {};
     ++	struct reftable_log_record log = { NULL };
      +
      +	if (refs->err < 0) {
      +		return refs->err;
     @@ refs/reftable-backend.c (new)
      +		}
      +
      +		{
     -+			struct object_id old_oid = {};
     -+			struct object_id new_oid = {};
     ++			struct object_id old_oid;
     ++			struct object_id new_oid;
      +			const char *full_committer = "";
      +
      +			hashcpy(old_oid.hash, log.old_hash);
     @@ refs/reftable-backend.c (new)
      +					  const char *refname,
      +					  each_reflog_ent_fn fn, void *cb_data)
      +{
     -+	struct reftable_iterator it = {};
     ++	struct reftable_iterator it = { NULL };
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +	struct reftable_merged_table *mt = NULL;
     @@ refs/reftable-backend.c (new)
      +	err = reftable_merged_table_seek_log(mt, &it, refname);
      +
      +	while (err == 0) {
     -+		struct reftable_log_record log = {};
     ++		struct reftable_log_record log = { NULL };
      +		err = reftable_iterator_next_log(it, &log);
      +		if (err != 0) {
      +			break;
     @@ refs/reftable-backend.c (new)
      +
      +	for (int i = len; i--;) {
      +		struct reftable_log_record *log = &logs[i];
     -+		struct object_id old_oid = {};
     -+		struct object_id new_oid = {};
     ++		struct object_id old_oid;
     ++		struct object_id new_oid;
      +		const char *full_committer = "";
      +
      +		hashcpy(old_oid.hash, log->old_hash);
     @@ refs/reftable-backend.c (new)
      +	struct reflog_expiry_arg arg = {
      +		.refs = refs,
      +	};
     -+	struct reftable_log_record log = {};
     -+	struct reftable_iterator it = {};
     ++	struct reftable_log_record log = { NULL };
     ++	struct reftable_iterator it = { NULL };
      +	int err = 0;
      +	if (refs->err < 0) {
      +		return refs->err;
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	while (1) {
     -+		struct object_id ooid = {};
     -+		struct object_id noid = {};
     ++		struct object_id ooid;
     ++		struct object_id noid;
      +
      +		int err = reftable_iterator_next_log(it, &log);
      +		if (err < 0) {
     @@ refs/reftable-backend.c (new)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     -+	struct reftable_ref_record ref = {};
     ++	struct reftable_ref_record ref = { NULL };
      +	int err = 0;
      +	if (refs->err < 0) {
      +		return refs->err;
     @@ t/t0031-reftable.sh (new)
      +
      +. ./test-lib.sh
      +
     ++# XXX - fix GC
      +test_expect_success 'basic operation of reftable storage' '
     -+	git init --ref-storage=reftable repo && (
     -+	cd repo &&
     -+	echo "hello" >world.txt &&
     -+	git add world.txt &&
     -+	git commit -m "first post" &&
     -+	test_write_lines HEAD refs/heads/master >expect &&
     ++	rm -rf .git &&
     ++	git init --ref-storage=reftable &&
     ++	mv .git/hooks .git/hooks-disabled &&
     ++	test_commit file &&
     ++	test_write_lines refs/heads/master refs/tags/file >expect &&
      +	git show-ref &&
      +	git show-ref | cut -f2 -d" " > actual &&
      +	test_cmp actual expect &&
      +	for count in $(test_seq 1 10)
      +	do
     -+		echo "hello" >>world.txt
     -+		git commit -m "number ${count}" world.txt ||
     -+		return 1
     ++		test_commit "number $count" file.t $count number-$count ||
     ++ 		return 1
      +	done &&
     ++(true || (test_pause &&
      +	git gc &&
     -+	nfiles=$(ls -1 .git/reftable | wc -l ) &&
     -+	test ${nfiles} = "2" &&
     -+	git reflog refs/heads/master >output &&
     ++	ls -1 .git/reftable >table-files &&
     ++	test_line_count = 2 table-files &&
     ++ 	git reflog refs/heads/master >output &&
      +	test_line_count = 11 output &&
      +	grep "commit (initial): first post" output &&
     -+	grep "commit: number 10" output )
     ++	grep "commit: number 10" output ))
      +'
      +
      +test_done

-- 
gitgitgadget
