Return-Path: <SRS0=RItT=5R=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_ABUSE_SURBL,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0EDC2D0E7
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 07FBF2080C
	for <git@archiver.kernel.org>; Wed,  1 Apr 2020 11:29:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vfpb7ERc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732387AbgDAL3K (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 1 Apr 2020 07:29:10 -0400
Received: from mail-ed1-f68.google.com ([209.85.208.68]:40965 "EHLO
        mail-ed1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732331AbgDAL3J (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 1 Apr 2020 07:29:09 -0400
Received: by mail-ed1-f68.google.com with SMTP id v1so29162200edq.8
        for <git@vger.kernel.org>; Wed, 01 Apr 2020 04:29:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=c1sd0sKooYyzFmsyWLp1YhIgIFmd63OsnhPoFRocaTw=;
        b=Vfpb7ERc/E5d+xY1tocTWZ3u6yekujruyzS/Eu+zhDI8JCe/z6ExeCPyw0V5sQeuCu
         x76yVsc3Vw1ulRSMnMBzsOCwryhXnTO11DGRETIC2CbZW5B52y+oVl8BZf1455Q3yEu/
         yTOkRdLmVO9RDN2drE06b5jbS5bPfg3J63iZMB9v0y9QzdBTu3PJbEnUJ9C7X1/ATCtw
         nxkVDyXLNeR0B8OM3e0wEeTLwtg9D9M+na6XcsopDh0Q9eqqZ2E2hjO5HWk5OagUhHwi
         1GL4U86iXeO/FQ6OVtZqFVFG7Q9in2VpbPl0QviNEWcdf19qFIVSBuSGMGkFoCsH0f7W
         Ii0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=c1sd0sKooYyzFmsyWLp1YhIgIFmd63OsnhPoFRocaTw=;
        b=UGV1qkIfiWPKE5C5kqZlL4q4taiRE49sNgM1ulsnLdJI850p2CZBYuc21cIA/59op1
         HYLEe5Xhgew59GbzIQZ6F9+Q2zBHZOwBpt0fj/1ZqUAZpAv10Dn6CM+YxcLx5GpTA3dN
         MvRgxI86hmep6kKfvENY7ImuKwi0spnwg1//TkTkj8B4MMFQC6feiaKE4TrkOiegfTUb
         7KtG0hAHMWkbh1mPlfiKCgplGI8VRpll2KZ1TMb8iDcvN0fFohbVmPcCqzK3xPrO2FIK
         LHR6B2qmZEtWGp+Ych9lLWqENAr4O6xpR2JmcUvozYgw32jANaTs8z7Ib+ByV6FCXguc
         SA4w==
X-Gm-Message-State: ANhLgQ0TuS1+glOo9n9js8GV94U7PxGtHOz1pZMwumVMaHXolgj4HZdV
        CFjoDgCsr8yOfUbUurjvCLfzilja
X-Google-Smtp-Source: ADFU+vvTiXfLOHfzvK5v4j2MwwLcjsCCteVasnT5w8k/KFWToJiYXQJJKoVUcjG59PQbMHt1EcAOFQ==
X-Received: by 2002:a50:d4c2:: with SMTP id e2mr20832913edj.136.1585740540732;
        Wed, 01 Apr 2020 04:29:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id z16sm377788edm.52.2020.04.01.04.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 04:28:59 -0700 (PDT)
Message-Id: <pull.539.v8.git.1585740538.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
References: <pull.539.v7.git.1582706986.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 01 Apr 2020 11:28:49 +0000
Subject: [PATCH v8 0/9] Reftable support git-core
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
   
   

v8

 * propagate errors to git.
 * discard empty tables in the stack. 
 * one very basic test (t0031.sh)

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

Han-Wen Nienhuys (8):
  refs.h: clarify reflog iteration order
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
 Makefile                                      |   24 +-
 builtin/clone.c                               |    5 +-
 builtin/init-db.c                             |   51 +-
 cache.h                                       |    4 +-
 refs.c                                        |   20 +-
 refs.h                                        |    7 +-
 refs/files-backend.c                          |    6 +
 refs/refs-internal.h                          |    6 +
 refs/reftable-backend.c                       | 1002 +++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |    5 +
 reftable/basics.c                             |  194 +++
 reftable/basics.h                             |   35 +
 reftable/block.c                              |  433 +++++++
 reftable/block.h                              |   76 ++
 reftable/blocksource.h                        |   22 +
 reftable/bytes.c                              |    0
 reftable/config.h                             |    1 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |   97 ++
 reftable/file.c                               |   98 ++
 reftable/iter.c                               |  234 ++++
 reftable/iter.h                               |   56 +
 reftable/merged.c                             |  299 +++++
 reftable/merged.h                             |   34 +
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  756 +++++++++++
 reftable/reader.h                             |   60 +
 reftable/record.c                             | 1098 ++++++++++++++++
 reftable/record.h                             |  106 ++
 reftable/reftable.h                           |  520 ++++++++
 reftable/slice.c                              |  219 ++++
 reftable/slice.h                              |   42 +
 reftable/stack.c                              | 1132 +++++++++++++++++
 reftable/stack.h                              |   42 +
 reftable/system.h                             |   53 +
 reftable/tree.c                               |   67 +
 reftable/tree.h                               |   24 +
 reftable/update.sh                            |   14 +
 reftable/writer.c                             |  653 ++++++++++
 reftable/writer.h                             |   45 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 t/t0031-reftable.sh                           |   35 +
 52 files changed, 8954 insertions(+), 31 deletions(-)
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


base-commit: 9fadedd637b312089337d73c3ed8447e9f0aa775
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v8
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v8
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v7:

  1:  b1e44bc431e =  1:  05634d26dd5 refs.h: clarify reflog iteration order
  2:  b68488a095e =  2:  8d34e2c5c8b create .git/refs in files-backend.c
  3:  da538ef7421 =  3:  d08f823844d refs: document how ref_iterator_advance_fn should handle symrefs
  -:  ----------- >  4:  ca95b3a371e Add .gitattributes for the reftable/ directory
  4:  aae26814983 =  5:  dfc8b131294 reftable: file format documentation
  -:  ----------- >  6:  45ab5361750 reftable: define version 2 of the spec to accomodate SHA256
  -:  ----------- >  7:  67ee5962e85 reftable: clarify how empty tables should be written
  5:  30ed43a4fdb !  8:  4f9bdd7312b Add reftable library
     @@ -5,21 +5,21 @@
          Reftable is a format for storing the ref database. Its rationale and
          specification is in the preceding commit.
      
     -    Further context and motivation can be found in background reading:
     +    This imports the upstream library as one big commit. For understanding
     +    the code, it is suggested to read the code in the following order:
      
     -    * Original discussion on JGit-dev:  https://www.eclipse.org/lists/jgit-dev/msg03389.html
     +    * The specification under Documentation/technical/reftable.txt
      
     -    * First design discussion on git@vger: https://public-inbox.org/git/CAJo=hJtTp2eA3z9wW9cHo-nA7kK40vVThqh6inXpbCcqfdMP9g@mail.gmail.com/
     +    * reftable.h - the public API
      
     -    * Last design discussion on git@vger: https://public-inbox.org/git/CAJo=hJsZcAM9sipdVr7TMD-FD2V2W6_pvMQ791EGCDsDkQ033w@mail.gmail.com/
     +    * block.{c,h} - reading and writing blocks.
      
     -    * First attempt at implementation: https://public-inbox.org/git/CAP8UFD0PPZSjBnxCA7ez91vBuatcHKQ+JUWvTD1iHcXzPBjPBg@mail.gmail.com/
     +    * writer.{c,h} - writing a complete reftable file.
      
     -    * libgit2 support issue: https://github.com/libgit2/libgit2/issues
     +    * merged.{c,h} and pq.{c,h} - reading a stack of reftables
      
     -    * GitLab support issue: https://gitlab.com/gitlab-org/git/issues/6
     -
     -    * go-git support issue: https://github.com/src-d/go-git/issues/1059
     +    * stack.{c,h} - writing and compacting stacks of reftable on the
     +    filesystem.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     @@ -82,11 +82,11 @@
       --- /dev/null
       +++ b/reftable/VERSION
      @@
     -+commit ccce3b3eb763e79b23a3b4677d65ecceb4155ba3
     ++commit 920f7413f7a25f308d9a203f584873f6753192ec
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Tue Feb 25 20:42:29 2020 +0100
     ++Date:   Wed Apr 1 12:41:41 2020 +0200
      +
     -+    C: rephrase the hash ID API in terms of a uint32_t
     ++    C: remove stray debug printfs
      
       diff --git a/reftable/basics.c b/reftable/basics.c
       new file mode 100644
     @@ -165,10 +165,10 @@
      +		return;
      +	}
      +	while (*p) {
     -+		free(*p);
     ++		reftable_free(*p);
      +		p++;
      +	}
     -+	free(a);
     ++	reftable_free(a);
      +}
      +
      +int names_length(char **names)
     @@ -201,8 +201,8 @@
      +		if (p < next) {
      +			if (names_len == names_cap) {
      +				names_cap = 2 * names_cap + 1;
     -+				names = realloc(names,
     -+						names_cap * sizeof(char *));
     ++				names = reftable_realloc(
     ++					names, names_cap * sizeof(char *));
      +			}
      +			names[names_len++] = xstrdup(p);
      +		}
     @@ -211,7 +211,7 @@
      +
      +	if (names_len == names_cap) {
      +		names_cap = 2 * names_cap + 1;
     -+		names = realloc(names, names_cap * sizeof(char *));
     ++		names = reftable_realloc(names, names_cap * sizeof(char *));
      +	}
      +
      +	names[names_len] = NULL;
     @@ -232,7 +232,7 @@
      +	return *a == *b;
      +}
      +
     -+const char *error_str(int err)
     ++const char *reftable_error_str(int err)
      +{
      +	switch (err) {
      +	case IO_ERROR:
     @@ -252,6 +252,40 @@
      +	default:
      +		return "unknown error code";
      +	}
     ++}
     ++
     ++void *(*reftable_malloc_ptr)(size_t sz) = &malloc;
     ++void *(*reftable_realloc_ptr)(void *, size_t) = &realloc;
     ++void (*reftable_free_ptr)(void *) = &free;
     ++
     ++void *reftable_malloc(size_t sz)
     ++{
     ++	return (*reftable_malloc_ptr)(sz);
     ++}
     ++
     ++void *reftable_realloc(void *p, size_t sz)
     ++{
     ++	return (*reftable_realloc_ptr)(p, sz);
     ++}
     ++
     ++void reftable_free(void *p)
     ++{
     ++	reftable_free_ptr(p);
     ++}
     ++
     ++void *reftable_calloc(size_t sz)
     ++{
     ++	void *p = reftable_malloc(sz);
     ++	memset(p, 0, sz);
     ++	return p;
     ++}
     ++
     ++void reftable_set_alloc(void *(*malloc)(size_t),
     ++			void *(*realloc)(void *, size_t), void (*free)(void *))
     ++{
     ++	reftable_malloc_ptr = malloc;
     ++	reftable_realloc_ptr = realloc;
     ++	reftable_free_ptr = free;
      +}
      
       diff --git a/reftable/basics.h b/reftable/basics.h
     @@ -288,6 +322,11 @@
      +int names_equal(char **a, char **b);
      +int names_length(char **names);
      +
     ++void *reftable_malloc(size_t sz);
     ++void *reftable_realloc(void *p, size_t sz);
     ++void reftable_free(void *p);
     ++void *reftable_calloc(size_t sz);
     ++
      +#endif
      
       diff --git a/reftable/block.c b/reftable/block.c
     @@ -313,10 +352,32 @@
      +#include "reftable.h"
      +#include "zlib.h"
      +
     -+int block_writer_register_restart(struct block_writer *w, int n, bool restart,
     -+				  struct slice key);
     ++int header_size(int version)
     ++{
     ++	switch (version) {
     ++	case 1:
     ++		return 24;
     ++	case 2:
     ++		return 28;
     ++	}
     ++	abort();
     ++}
     ++
     ++int footer_size(int version)
     ++{
     ++	switch (version) {
     ++	case 1:
     ++		return 68;
     ++	case 2:
     ++		return 72;
     ++	}
     ++	abort();
     ++}
     ++
     ++int block_writer_register_restart(struct reftable_block_writer *w, int n,
     ++				  bool restart, struct slice key);
      +
     -+void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
     ++void block_writer_init(struct reftable_block_writer *bw, byte typ, byte *buf,
      +		       uint32_t block_size, uint32_t header_off, int hash_size)
      +{
      +	bw->buf = buf;
     @@ -329,14 +390,14 @@
      +	bw->entries = 0;
      +}
      +
     -+byte block_writer_type(struct block_writer *bw)
     ++byte block_writer_type(struct reftable_block_writer *bw)
      +{
      +	return bw->buf[bw->header_off];
      +}
      +
      +/* adds the record to the block. Returns -1 if it does not fit, 0 on
      +   success */
     -+int block_writer_add(struct block_writer *w, struct record rec)
     ++int block_writer_add(struct reftable_block_writer *w, struct record rec)
      +{
      +	struct slice empty = { 0 };
      +	struct slice last = w->entries % w->restart_interval == 0 ? empty :
     @@ -357,32 +418,29 @@
      +	if (n < 0) {
      +		goto err;
      +	}
     -+	out.buf += n;
     -+	out.len -= n;
     ++	slice_consume(&out, n);
      +
      +	n = record_encode(rec, out, w->hash_size);
      +	if (n < 0) {
      +		goto err;
      +	}
     -+
     -+	out.buf += n;
     -+	out.len -= n;
     ++	slice_consume(&out, n);
      +
      +	if (block_writer_register_restart(w, start.len - out.len, restart,
      +					  key) < 0) {
      +		goto err;
      +	}
      +
     -+	free(slice_yield(&key));
     ++	reftable_free(slice_yield(&key));
      +	return 0;
      +
      +err:
     -+	free(slice_yield(&key));
     ++	reftable_free(slice_yield(&key));
      +	return -1;
      +}
      +
     -+int block_writer_register_restart(struct block_writer *w, int n, bool restart,
     -+				  struct slice key)
     ++int block_writer_register_restart(struct reftable_block_writer *w, int n,
     ++				  bool restart, struct slice key)
      +{
      +	int rlen = w->restart_len;
      +	if (rlen >= MAX_RESTARTS) {
     @@ -398,7 +456,7 @@
      +	if (restart) {
      +		if (w->restart_len == w->restart_cap) {
      +			w->restart_cap = w->restart_cap * 2 + 1;
     -+			w->restarts = realloc(
     ++			w->restarts = reftable_realloc(
      +				w->restarts, sizeof(uint32_t) * w->restart_cap);
      +		}
      +
     @@ -411,7 +469,7 @@
      +	return 0;
      +}
      +
     -+int block_writer_finish(struct block_writer *w)
     ++int block_writer_finish(struct reftable_block_writer *w)
      +{
      +	int i = 0;
      +	for (i = 0; i < w->restart_len; i++) {
     @@ -442,7 +500,7 @@
      +			}
      +
      +			if (Z_OK != zresult) {
     -+				free(slice_yield(&compressed));
     ++				reftable_free(slice_yield(&compressed));
      +				return ZLIB_ERROR;
      +			}
      +
     @@ -455,14 +513,14 @@
      +	return w->next;
      +}
      +
     -+byte block_reader_type(struct block_reader *r)
     ++byte block_reader_type(struct reftable_block_reader *r)
      +{
      +	return r->block.data[r->header_off];
      +}
      +
     -+int block_reader_init(struct block_reader *br, struct block *block,
     -+		      uint32_t header_off, uint32_t table_block_size,
     -+		      int hash_size)
     ++int block_reader_init(struct reftable_block_reader *br,
     ++		      struct reftable_block *block, uint32_t header_off,
     ++		      uint32_t table_block_size, int hash_size)
      +{
      +	uint32_t full_block_size = table_block_size;
      +	byte typ = block->data[header_off];
     @@ -485,7 +543,7 @@
      +				    uncompressed.buf + block_header_skip,
      +				    &dst_len, block->data + block_header_skip,
      +				    &src_len)) {
     -+			free(slice_yield(&uncompressed));
     ++			reftable_free(slice_yield(&uncompressed));
      +			return ZLIB_ERROR;
      +		}
      +
     @@ -526,12 +584,14 @@
      +	return 0;
      +}
      +
     -+static uint32_t block_reader_restart_offset(struct block_reader *br, int i)
     ++static uint32_t block_reader_restart_offset(struct reftable_block_reader *br,
     ++					    int i)
      +{
      +	return get_be24(br->restart_bytes + 3 * i);
      +}
      +
     -+void block_reader_start(struct block_reader *br, struct block_iter *it)
     ++void block_reader_start(struct reftable_block_reader *br,
     ++			struct reftable_block_iter *it)
      +{
      +	it->br = br;
      +	slice_resize(&it->last_key, 0);
     @@ -541,7 +601,7 @@
      +struct restart_find_args {
      +	int error;
      +	struct slice key;
     -+	struct block_reader *r;
     ++	struct reftable_block_reader *r;
      +};
      +
      +static int restart_key_less(int idx, void *args)
     @@ -566,12 +626,13 @@
      +
      +	{
      +		int result = slice_compare(a->key, rkey);
     -+		free(slice_yield(&rkey));
     ++		reftable_free(slice_yield(&rkey));
      +		return result;
      +	}
      +}
      +
     -+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src)
     ++void block_iter_copy_from(struct reftable_block_iter *dest,
     ++			  struct reftable_block_iter *src)
      +{
      +	dest->br = src->br;
      +	dest->next_off = src->next_off;
     @@ -579,7 +640,7 @@
      +}
      +
      +/* return < 0 for error, 0 for OK, > 0 for EOF. */
     -+int block_iter_next(struct block_iter *it, struct record rec)
     ++int block_iter_next(struct reftable_block_iter *it, struct record rec)
      +{
      +	if (it->next_off >= it->br->block_len) {
      +		return 1;
     @@ -598,23 +659,21 @@
      +			return -1;
      +		}
      +
     -+		in.buf += n;
     -+		in.len -= n;
     ++		slice_consume(&in, n);
      +		n = record_decode(rec, key, extra, in, it->br->hash_size);
      +		if (n < 0) {
      +			return -1;
      +		}
     -+		in.buf += n;
     -+		in.len -= n;
     ++		slice_consume(&in, n);
      +
      +		slice_copy(&it->last_key, key);
      +		it->next_off += start.len - in.len;
     -+		free(slice_yield(&key));
     ++		reftable_free(slice_yield(&key));
      +		return 0;
      +	}
      +}
      +
     -+int block_reader_first_key(struct block_reader *br, struct slice *key)
     ++int block_reader_first_key(struct reftable_block_reader *br, struct slice *key)
      +{
      +	struct slice empty = { 0 };
      +	int off = br->header_off + 4;
     @@ -631,18 +690,18 @@
      +	return 0;
      +}
      +
     -+int block_iter_seek(struct block_iter *it, struct slice want)
     ++int block_iter_seek(struct reftable_block_iter *it, struct slice want)
      +{
      +	return block_reader_seek(it->br, it, want);
      +}
      +
     -+void block_iter_close(struct block_iter *it)
     ++void block_iter_close(struct reftable_block_iter *it)
      +{
     -+	free(slice_yield(&it->last_key));
     ++	reftable_free(slice_yield(&it->last_key));
      +}
      +
     -+int block_reader_seek(struct block_reader *br, struct block_iter *it,
     -+		      struct slice want)
     ++int block_reader_seek(struct reftable_block_reader *br,
     ++		      struct reftable_block_iter *it, struct slice want)
      +{
      +	struct restart_find_args args = {
      +		.key = want,
     @@ -667,7 +726,7 @@
      +		struct slice key = { 0 };
      +		int result = 0;
      +		int err = 0;
     -+		struct block_iter next = { 0 };
     ++		struct reftable_block_iter next = { 0 };
      +		while (true) {
      +			block_iter_copy_from(&next, it);
      +
     @@ -687,25 +746,25 @@
      +		}
      +
      +	exit:
     -+		free(slice_yield(&key));
     -+		free(slice_yield(&next.last_key));
     ++		reftable_free(slice_yield(&key));
     ++		reftable_free(slice_yield(&next.last_key));
      +		record_clear(rec);
     -+		free(record_yield(&rec));
     ++		reftable_free(record_yield(&rec));
      +
      +		return result;
      +	}
      +}
      +
     -+void block_writer_reset(struct block_writer *bw)
     ++void block_writer_reset(struct reftable_block_writer *bw)
      +{
      +	bw->restart_len = 0;
      +	bw->last_key.len = 0;
      +}
      +
     -+void block_writer_clear(struct block_writer *bw)
     ++void block_writer_clear(struct reftable_block_writer *bw)
      +{
      +	FREE_AND_NULL(bw->restarts);
     -+	free(slice_yield(&bw->last_key));
     ++	reftable_free(slice_yield(&bw->last_key));
      +	/* the block is not owned. */
      +}
      
     @@ -729,7 +788,7 @@
      +#include "record.h"
      +#include "reftable.h"
      +
     -+struct block_writer {
     ++struct reftable_block_writer {
      +	byte *buf;
      +	uint32_t block_size;
      +	uint32_t header_off;
     @@ -744,17 +803,17 @@
      +	int entries;
      +};
      +
     -+void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
     ++void block_writer_init(struct reftable_block_writer *bw, byte typ, byte *buf,
      +		       uint32_t block_size, uint32_t header_off, int hash_size);
     -+byte block_writer_type(struct block_writer *bw);
     -+int block_writer_add(struct block_writer *w, struct record rec);
     -+int block_writer_finish(struct block_writer *w);
     -+void block_writer_reset(struct block_writer *bw);
     -+void block_writer_clear(struct block_writer *bw);
     ++byte block_writer_type(struct reftable_block_writer *bw);
     ++int block_writer_add(struct reftable_block_writer *w, struct record rec);
     ++int block_writer_finish(struct reftable_block_writer *w);
     ++void block_writer_reset(struct reftable_block_writer *bw);
     ++void block_writer_clear(struct reftable_block_writer *bw);
      +
     -+struct block_reader {
     ++struct reftable_block_reader {
      +	uint32_t header_off;
     -+	struct block block;
     ++	struct reftable_block block;
      +	int hash_size;
      +
      +	/* size of the data, excluding restart data. */
     @@ -764,25 +823,30 @@
      +	uint16_t restart_count;
      +};
      +
     -+struct block_iter {
     ++struct reftable_block_iter {
      +	uint32_t next_off;
     -+	struct block_reader *br;
     ++	struct reftable_block_reader *br;
      +	struct slice last_key;
      +};
      +
     -+int block_reader_init(struct block_reader *br, struct block *bl,
     -+		      uint32_t header_off, uint32_t table_block_size,
     -+		      int hash_size);
     -+void block_reader_start(struct block_reader *br, struct block_iter *it);
     -+int block_reader_seek(struct block_reader *br, struct block_iter *it,
     -+		      struct slice want);
     -+byte block_reader_type(struct block_reader *r);
     -+int block_reader_first_key(struct block_reader *br, struct slice *key);
     -+
     -+void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
     -+int block_iter_next(struct block_iter *it, struct record rec);
     -+int block_iter_seek(struct block_iter *it, struct slice want);
     -+void block_iter_close(struct block_iter *it);
     ++int block_reader_init(struct reftable_block_reader *br,
     ++		      struct reftable_block *bl, uint32_t header_off,
     ++		      uint32_t table_block_size, int hash_size);
     ++void block_reader_start(struct reftable_block_reader *br,
     ++			struct reftable_block_iter *it);
     ++int block_reader_seek(struct reftable_block_reader *br,
     ++		      struct reftable_block_iter *it, struct slice want);
     ++byte block_reader_type(struct reftable_block_reader *r);
     ++int block_reader_first_key(struct reftable_block_reader *br, struct slice *key);
     ++
     ++void block_iter_copy_from(struct reftable_block_iter *dest,
     ++			  struct reftable_block_iter *src);
     ++int block_iter_next(struct reftable_block_iter *it, struct record rec);
     ++int block_iter_seek(struct reftable_block_iter *it, struct slice want);
     ++void block_iter_close(struct reftable_block_iter *it);
     ++
     ++int header_size(int version);
     ++int footer_size(int version);
      +
      +#endif
      
     @@ -804,11 +868,13 @@
      +
      +#include "reftable.h"
      +
     -+uint64_t block_source_size(struct block_source source);
     -+int block_source_read_block(struct block_source source, struct block *dest,
     -+			    uint64_t off, uint32_t size);
     -+void block_source_return_block(struct block_source source, struct block *ret);
     -+void block_source_close(struct block_source source);
     ++uint64_t block_source_size(struct reftable_block_source source);
     ++int block_source_read_block(struct reftable_block_source source,
     ++			    struct reftable_block *dest, uint64_t off,
     ++			    uint32_t size);
     ++void block_source_return_block(struct reftable_block_source source,
     ++			       struct reftable_block *ret);
     ++void block_source_close(struct reftable_block_source source);
      +
      +#endif
      
     @@ -838,10 +904,6 @@
      +#ifndef CONSTANTS_H
      +#define CONSTANTS_H
      +
     -+#define VERSION 1
     -+#define HEADER_SIZE 24
     -+#define FOOTER_SIZE 68
     -+
      +#define BLOCK_TYPE_LOG 'g'
      +#define BLOCK_TYPE_INDEX 'i'
      +#define BLOCK_TYPE_REF 'r'
     @@ -987,10 +1049,10 @@
      +	return ((struct file_block_source *)b)->size;
      +}
      +
     -+static void file_return_block(void *b, struct block *dest)
     ++static void file_return_block(void *b, struct reftable_block *dest)
      +{
      +	memset(dest->data, 0xff, dest->len);
     -+	free(dest->data);
     ++	reftable_free(dest->data);
      +}
      +
      +static void file_close(void *b)
     @@ -1001,15 +1063,15 @@
      +		((struct file_block_source *)b)->fd = 0;
      +	}
      +
     -+	free(b);
     ++	reftable_free(b);
      +}
      +
     -+static int file_read_block(void *v, struct block *dest, uint64_t off,
     ++static int file_read_block(void *v, struct reftable_block *dest, uint64_t off,
      +			   uint32_t size)
      +{
      +	struct file_block_source *b = (struct file_block_source *)v;
      +	assert(off + size <= b->size);
     -+	dest->data = malloc(size);
     ++	dest->data = reftable_malloc(size);
      +	if (pread(b->fd, dest->data, size, off) != size) {
      +		return -1;
      +	}
     @@ -1017,14 +1079,15 @@
      +	return size;
      +}
      +
     -+struct block_source_vtable file_vtable = {
     ++struct reftable_block_source_vtable file_vtable = {
      +	.size = &file_size,
      +	.read_block = &file_read_block,
      +	.return_block = &file_return_block,
      +	.close = &file_close,
      +};
      +
     -+int block_source_from_file(struct block_source *bs, const char *name)
     ++int reftable_block_source_from_file(struct reftable_block_source *bs,
     ++				    const char *name)
      +{
      +	struct stat st = { 0 };
      +	int err = 0;
     @@ -1043,7 +1106,7 @@
      +
      +	{
      +		struct file_block_source *p =
     -+			calloc(sizeof(struct file_block_source), 1);
     ++			reftable_calloc(sizeof(struct file_block_source));
      +		p->size = st.st_size;
      +		p->fd = fd;
      +
     @@ -1053,7 +1116,7 @@
      +	return 0;
      +}
      +
     -+int fd_writer(void *arg, byte *data, int sz)
     ++int reftable_fd_write(void *arg, byte *data, int sz)
      +{
      +	int *fdp = (int *)arg;
      +	return write(*fdp, data, sz);
     @@ -1081,7 +1144,7 @@
      +#include "reader.h"
      +#include "reftable.h"
      +
     -+bool iterator_is_null(struct iterator it)
     ++bool iterator_is_null(struct reftable_iterator it)
      +{
      +	return it.ops == NULL;
      +}
     @@ -1095,23 +1158,23 @@
      +{
      +}
      +
     -+struct iterator_vtable empty_vtable = {
     ++struct reftable_iterator_vtable empty_vtable = {
      +	.next = &empty_iterator_next,
      +	.close = &empty_iterator_close,
      +};
      +
     -+void iterator_set_empty(struct iterator *it)
     ++void iterator_set_empty(struct reftable_iterator *it)
      +{
      +	it->iter_arg = NULL;
      +	it->ops = &empty_vtable;
      +}
      +
     -+int iterator_next(struct iterator it, struct record rec)
     ++int iterator_next(struct reftable_iterator it, struct record rec)
      +{
      +	return it.ops->next(it.iter_arg, rec);
      +}
      +
     -+void iterator_destroy(struct iterator *it)
     ++void reftable_iterator_destroy(struct reftable_iterator *it)
      +{
      +	if (it->ops == NULL) {
      +		return;
     @@ -1121,14 +1184,16 @@
      +	FREE_AND_NULL(it->iter_arg);
      +}
      +
     -+int iterator_next_ref(struct iterator it, struct ref_record *ref)
     ++int reftable_iterator_next_ref(struct reftable_iterator it,
     ++			       struct reftable_ref_record *ref)
      +{
      +	struct record rec = { 0 };
      +	record_from_ref(&rec, ref);
      +	return iterator_next(it, rec);
      +}
      +
     -+int iterator_next_log(struct iterator it, struct log_record *log)
     ++int reftable_iterator_next_log(struct reftable_iterator it,
     ++			       struct reftable_log_record *log)
      +{
      +	struct record rec = { 0 };
      +	record_from_log(&rec, log);
     @@ -1139,31 +1204,33 @@
      +{
      +	struct filtering_ref_iterator *fri =
      +		(struct filtering_ref_iterator *)iter_arg;
     -+	free(slice_yield(&fri->oid));
     -+	iterator_destroy(&fri->it);
     ++	reftable_free(slice_yield(&fri->oid));
     ++	reftable_iterator_destroy(&fri->it);
      +}
      +
      +static int filtering_ref_iterator_next(void *iter_arg, struct record rec)
      +{
      +	struct filtering_ref_iterator *fri =
      +		(struct filtering_ref_iterator *)iter_arg;
     -+	struct ref_record *ref = (struct ref_record *)rec.data;
     ++	struct reftable_ref_record *ref =
     ++		(struct reftable_ref_record *)rec.data;
      +
      +	while (true) {
     -+		int err = iterator_next_ref(fri->it, ref);
     ++		int err = reftable_iterator_next_ref(fri->it, ref);
      +		if (err != 0) {
      +			return err;
      +		}
      +
      +		if (fri->double_check) {
     -+			struct iterator it = { 0 };
     ++			struct reftable_iterator it = { 0 };
      +
     -+			int err = reader_seek_ref(fri->r, &it, ref->ref_name);
     ++			int err = reftable_reader_seek_ref(fri->r, &it,
     ++							   ref->ref_name);
      +			if (err == 0) {
     -+				err = iterator_next_ref(it, ref);
     ++				err = reftable_iterator_next_ref(it, ref);
      +			}
      +
     -+			iterator_destroy(&it);
     ++			reftable_iterator_destroy(&it);
      +
      +			if (err < 0) {
      +				return err;
     @@ -1183,12 +1250,12 @@
      +	}
      +}
      +
     -+struct iterator_vtable filtering_ref_iterator_vtable = {
     ++struct reftable_iterator_vtable filtering_ref_iterator_vtable = {
      +	.next = &filtering_ref_iterator_next,
      +	.close = &filtering_ref_iterator_close,
      +};
      +
     -+void iterator_from_filtering_ref_iterator(struct iterator *it,
     ++void iterator_from_filtering_ref_iterator(struct reftable_iterator *it,
      +					  struct filtering_ref_iterator *fri)
      +{
      +	it->iter_arg = fri;
     @@ -1200,7 +1267,7 @@
      +	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
      +	block_iter_close(&it->cur);
      +	reader_return_block(it->r, &it->block_reader.block);
     -+	free(slice_yield(&it->oid));
     ++	reftable_free(slice_yield(&it->oid));
      +}
      +
      +static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
     @@ -1231,7 +1298,8 @@
      +static int indexed_table_ref_iter_next(void *p, struct record rec)
      +{
      +	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
     -+	struct ref_record *ref = (struct ref_record *)rec.data;
     ++	struct reftable_ref_record *ref =
     ++		(struct reftable_ref_record *)rec.data;
      +
      +	while (true) {
      +		int err = block_iter_next(&it->cur, rec);
     @@ -1259,11 +1327,11 @@
      +}
      +
      +int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
     -+			       struct reader *r, byte *oid, int oid_len,
     -+			       uint64_t *offsets, int offset_len)
     ++			       struct reftable_reader *r, byte *oid,
     ++			       int oid_len, uint64_t *offsets, int offset_len)
      +{
      +	struct indexed_table_ref_iter *itr =
     -+		calloc(sizeof(struct indexed_table_ref_iter), 1);
     ++		reftable_calloc(sizeof(struct indexed_table_ref_iter));
      +	int err = 0;
      +
      +	itr->r = r;
     @@ -1275,19 +1343,19 @@
      +
      +	err = indexed_table_ref_iter_next_block(itr);
      +	if (err < 0) {
     -+		free(itr);
     ++		reftable_free(itr);
      +	} else {
      +		*dest = itr;
      +	}
      +	return err;
      +}
      +
     -+struct iterator_vtable indexed_table_ref_iter_vtable = {
     ++struct reftable_iterator_vtable indexed_table_ref_iter_vtable = {
      +	.next = &indexed_table_ref_iter_next,
      +	.close = &indexed_table_ref_iter_close,
      +};
      +
     -+void iterator_from_indexed_table_ref_iter(struct iterator *it,
     ++void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
      +					  struct indexed_table_ref_iter *itr)
      +{
      +	it->iter_arg = itr;
     @@ -1314,27 +1382,27 @@
      +#include "record.h"
      +#include "slice.h"
      +
     -+struct iterator_vtable {
     ++struct reftable_iterator_vtable {
      +	int (*next)(void *iter_arg, struct record rec);
      +	void (*close)(void *iter_arg);
      +};
      +
     -+void iterator_set_empty(struct iterator *it);
     -+int iterator_next(struct iterator it, struct record rec);
     -+bool iterator_is_null(struct iterator it);
     ++void iterator_set_empty(struct reftable_iterator *it);
     ++int iterator_next(struct reftable_iterator it, struct record rec);
     ++bool iterator_is_null(struct reftable_iterator it);
      +
      +struct filtering_ref_iterator {
      +	bool double_check;
     -+	struct reader *r;
     ++	struct reftable_reader *r;
      +	struct slice oid;
     -+	struct iterator it;
     ++	struct reftable_iterator it;
      +};
      +
     -+void iterator_from_filtering_ref_iterator(struct iterator *,
     ++void iterator_from_filtering_ref_iterator(struct reftable_iterator *,
      +					  struct filtering_ref_iterator *);
      +
      +struct indexed_table_ref_iter {
     -+	struct reader *r;
     ++	struct reftable_reader *r;
      +	struct slice oid;
      +
      +	/* mutable */
     @@ -1343,16 +1411,16 @@
      +	/* Points to the next offset to read. */
      +	int offset_idx;
      +	int offset_len;
     -+	struct block_reader block_reader;
     -+	struct block_iter cur;
     ++	struct reftable_block_reader block_reader;
     ++	struct reftable_block_iter cur;
      +	bool finished;
      +};
      +
     -+void iterator_from_indexed_table_ref_iter(struct iterator *it,
     ++void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
      +					  struct indexed_table_ref_iter *itr);
      +int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
     -+			       struct reader *r, byte *oid, int oid_len,
     -+			       uint64_t *offsets, int offset_len);
     ++			       struct reftable_reader *r, byte *oid,
     ++			       int oid_len, uint64_t *offsets, int offset_len);
      +
      +#endif
      
     @@ -1389,9 +1457,9 @@
      +		}
      +
      +		if (err > 0) {
     -+			iterator_destroy(&mi->stack[i]);
     ++			reftable_iterator_destroy(&mi->stack[i]);
      +			record_clear(rec);
     -+			free(record_yield(&rec));
     ++			reftable_free(record_yield(&rec));
      +		} else {
      +			struct pq_entry e = {
      +				.rec = rec,
     @@ -1410,9 +1478,9 @@
      +	int i = 0;
      +	merged_iter_pqueue_clear(&mi->pq);
      +	for (i = 0; i < mi->stack_len; i++) {
     -+		iterator_destroy(&mi->stack[i]);
     ++		reftable_iterator_destroy(&mi->stack[i]);
      +	}
     -+	free(mi->stack);
     ++	reftable_free(mi->stack);
      +}
      +
      +static int merged_iter_advance_subiter(struct merged_iter *mi, int idx)
     @@ -1433,9 +1501,9 @@
      +		}
      +
      +		if (err > 0) {
     -+			iterator_destroy(&mi->stack[idx]);
     ++			reftable_iterator_destroy(&mi->stack[idx]);
      +			record_clear(rec);
     -+			free(record_yield(&rec));
     ++			reftable_free(record_yield(&rec));
      +			return 0;
      +		}
      +
     @@ -1462,7 +1530,7 @@
      +		record_key(top.rec, &k);
      +
      +		cmp = slice_compare(k, entry_key);
     -+		free(slice_yield(&k));
     ++		reftable_free(slice_yield(&k));
      +
      +		if (cmp > 0) {
      +			break;
     @@ -1474,13 +1542,13 @@
      +			return err;
      +		}
      +		record_clear(top.rec);
     -+		free(record_yield(&top.rec));
     ++		reftable_free(record_yield(&top.rec));
      +	}
      +
      +	record_copy_from(rec, entry.rec, hash_size(mi->hash_id));
      +	record_clear(entry.rec);
     -+	free(record_yield(&entry.rec));
     -+	free(slice_yield(&entry_key));
     ++	reftable_free(record_yield(&entry.rec));
     ++	reftable_free(slice_yield(&entry_key));
      +	return 0;
      +}
      +
     @@ -1494,41 +1562,42 @@
      +	return merged_iter_next(mi, rec);
      +}
      +
     -+struct iterator_vtable merged_iter_vtable = {
     ++struct reftable_iterator_vtable merged_iter_vtable = {
      +	.next = &merged_iter_next_void,
      +	.close = &merged_iter_close,
      +};
      +
     -+static void iterator_from_merged_iter(struct iterator *it,
     ++static void iterator_from_merged_iter(struct reftable_iterator *it,
      +				      struct merged_iter *mi)
      +{
      +	it->iter_arg = mi;
      +	it->ops = &merged_iter_vtable;
      +}
      +
     -+int new_merged_table(struct merged_table **dest, struct reader **stack, int n,
     -+		     uint32_t hash_id)
     ++int reftable_new_merged_table(struct reftable_merged_table **dest,
     ++			      struct reftable_reader **stack, int n,
     ++			      uint32_t hash_id)
      +{
      +	uint64_t last_max = 0;
      +	uint64_t first_min = 0;
      +	int i = 0;
      +	for (i = 0; i < n; i++) {
     -+		struct reader *r = stack[i];
     ++		struct reftable_reader *r = stack[i];
      +		if (r->hash_id != hash_id) {
      +			return FORMAT_ERROR;
      +		}
     -+		if (i > 0 && last_max >= reader_min_update_index(r)) {
     ++		if (i > 0 && last_max >= reftable_reader_min_update_index(r)) {
      +			return FORMAT_ERROR;
      +		}
      +		if (i == 0) {
     -+			first_min = reader_min_update_index(r);
     ++			first_min = reftable_reader_min_update_index(r);
      +		}
      +
     -+		last_max = reader_max_update_index(r);
     ++		last_max = reftable_reader_max_update_index(r);
      +	}
      +
      +	{
     -+		struct merged_table m = {
     ++		struct reftable_merged_table m = {
      +			.stack = stack,
      +			.stack_len = n,
      +			.min = first_min,
     @@ -1536,52 +1605,56 @@
      +			.hash_id = hash_id,
      +		};
      +
     -+		*dest = calloc(sizeof(struct merged_table), 1);
     ++		*dest = reftable_calloc(sizeof(struct reftable_merged_table));
      +		**dest = m;
      +	}
      +	return 0;
      +}
      +
     -+void merged_table_close(struct merged_table *mt)
     ++void reftable_merged_table_close(struct reftable_merged_table *mt)
      +{
      +	int i = 0;
      +	for (i = 0; i < mt->stack_len; i++) {
     -+		reader_free(mt->stack[i]);
     ++		reftable_reader_free(mt->stack[i]);
      +	}
      +	FREE_AND_NULL(mt->stack);
      +	mt->stack_len = 0;
      +}
      +
      +/* clears the list of subtable, without affecting the readers themselves. */
     -+void merged_table_clear(struct merged_table *mt)
     ++void merged_table_clear(struct reftable_merged_table *mt)
      +{
      +	FREE_AND_NULL(mt->stack);
      +	mt->stack_len = 0;
      +}
      +
     -+void merged_table_free(struct merged_table *mt)
     ++void reftable_merged_table_free(struct reftable_merged_table *mt)
      +{
      +	if (mt == NULL) {
      +		return;
      +	}
      +	merged_table_clear(mt);
     -+	free(mt);
     ++	reftable_free(mt);
      +}
      +
     -+uint64_t merged_max_update_index(struct merged_table *mt)
     ++uint64_t
     ++reftable_merged_table_max_update_index(struct reftable_merged_table *mt)
      +{
      +	return mt->max;
      +}
      +
     -+uint64_t merged_min_update_index(struct merged_table *mt)
     ++uint64_t
     ++reftable_merged_table_min_update_index(struct reftable_merged_table *mt)
      +{
      +	return mt->min;
      +}
      +
     -+static int merged_table_seek_record(struct merged_table *mt,
     -+				    struct iterator *it, struct record rec)
     ++static int merged_table_seek_record(struct reftable_merged_table *mt,
     ++				    struct reftable_iterator *it,
     ++				    struct record rec)
      +{
     -+	struct iterator *iters = calloc(sizeof(struct iterator), mt->stack_len);
     ++	struct reftable_iterator *iters = reftable_calloc(
     ++		sizeof(struct reftable_iterator) * mt->stack_len);
      +	struct merged_iter merged = {
      +		.stack = iters,
      +		.typ = record_type(rec),
     @@ -1602,9 +1675,9 @@
      +	if (err < 0) {
      +		int i = 0;
      +		for (i = 0; i < n; i++) {
     -+			iterator_destroy(&iters[i]);
     ++			reftable_iterator_destroy(&iters[i]);
      +		}
     -+		free(iters);
     ++		reftable_free(iters);
      +		return err;
      +	}
      +
     @@ -1615,17 +1688,19 @@
      +	}
      +
      +	{
     -+		struct merged_iter *p = malloc(sizeof(struct merged_iter));
     ++		struct merged_iter *p =
     ++			reftable_malloc(sizeof(struct merged_iter));
      +		*p = merged;
      +		iterator_from_merged_iter(it, p);
      +	}
      +	return 0;
      +}
      +
     -+int merged_table_seek_ref(struct merged_table *mt, struct iterator *it,
     -+			  const char *name)
     ++int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
     ++				   struct reftable_iterator *it,
     ++				   const char *name)
      +{
     -+	struct ref_record ref = {
     ++	struct reftable_ref_record ref = {
      +		.ref_name = (char *)name,
      +	};
      +	struct record rec = { 0 };
     @@ -1633,10 +1708,11 @@
      +	return merged_table_seek_record(mt, it, rec);
      +}
      +
     -+int merged_table_seek_log_at(struct merged_table *mt, struct iterator *it,
     -+			     const char *name, uint64_t update_index)
     ++int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
     ++				      struct reftable_iterator *it,
     ++				      const char *name, uint64_t update_index)
      +{
     -+	struct log_record log = {
     ++	struct reftable_log_record log = {
      +		.ref_name = (char *)name,
      +		.update_index = update_index,
      +	};
     @@ -1645,11 +1721,12 @@
      +	return merged_table_seek_record(mt, it, rec);
      +}
      +
     -+int merged_table_seek_log(struct merged_table *mt, struct iterator *it,
     -+			  const char *name)
     ++int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
     ++				   struct reftable_iterator *it,
     ++				   const char *name)
      +{
      +	uint64_t max = ~((uint64_t)0);
     -+	return merged_table_seek_log_at(mt, it, name, max);
     ++	return reftable_merged_table_seek_log_at(mt, it, name, max);
      +}
      
       diff --git a/reftable/merged.h b/reftable/merged.h
     @@ -1671,8 +1748,8 @@
      +#include "pq.h"
      +#include "reftable.h"
      +
     -+struct merged_table {
     -+	struct reader **stack;
     ++struct reftable_merged_table {
     ++	struct reftable_reader **stack;
      +	int stack_len;
      +	uint32_t hash_id;
      +
     @@ -1681,14 +1758,14 @@
      +};
      +
      +struct merged_iter {
     -+	struct iterator *stack;
     ++	struct reftable_iterator *stack;
      +	uint32_t hash_id;
      +	int stack_len;
      +	byte typ;
      +	struct merged_iter_pqueue pq;
     -+} merged_iter;
     ++};
      +
     -+void merged_table_clear(struct merged_table *mt);
     ++void merged_table_clear(struct reftable_merged_table *mt);
      +
      +#endif
      
     @@ -1719,8 +1796,8 @@
      +
      +	cmp = slice_compare(ak, bk);
      +
     -+	free(slice_yield(&ak));
     -+	free(slice_yield(&bk));
     ++	reftable_free(slice_yield(&ak));
     ++	reftable_free(slice_yield(&bk));
      +
      +	if (cmp == 0) {
      +		return a.index > b.index;
     @@ -1784,7 +1861,8 @@
      +	int i = 0;
      +	if (pq->len == pq->cap) {
      +		pq->cap = 2 * pq->cap + 1;
     -+		pq->heap = realloc(pq->heap, pq->cap * sizeof(struct pq_entry));
     ++		pq->heap = reftable_realloc(pq->heap,
     ++					    pq->cap * sizeof(struct pq_entry));
      +	}
      +
      +	pq->heap[pq->len++] = e;
     @@ -1806,7 +1884,7 @@
      +	int i = 0;
      +	for (i = 0; i < pq->len; i++) {
      +		record_clear(pq->heap[i].rec);
     -+		free(record_yield(&pq->heap[i].rec));
     ++		reftable_free(record_yield(&pq->heap[i].rec));
      +	}
      +	FREE_AND_NULL(pq->heap);
      +	pq->len = pq->cap = 0;
     @@ -1876,20 +1954,22 @@
      +#include "reftable.h"
      +#include "tree.h"
      +
     -+uint64_t block_source_size(struct block_source source)
     ++uint64_t block_source_size(struct reftable_block_source source)
      +{
      +	return source.ops->size(source.arg);
      +}
      +
     -+int block_source_read_block(struct block_source source, struct block *dest,
     -+			    uint64_t off, uint32_t size)
     ++int block_source_read_block(struct reftable_block_source source,
     ++			    struct reftable_block *dest, uint64_t off,
     ++			    uint32_t size)
      +{
      +	int result = source.ops->read_block(source.arg, dest, off, size);
      +	dest->source = source;
      +	return result;
      +}
      +
     -+void block_source_return_block(struct block_source source, struct block *blockp)
     ++void block_source_return_block(struct reftable_block_source source,
     ++			       struct reftable_block *blockp)
      +{
      +	source.ops->return_block(source.arg, blockp);
      +	blockp->data = NULL;
     @@ -1898,7 +1978,7 @@
      +	blockp->source.arg = NULL;
      +}
      +
     -+void block_source_close(struct block_source *source)
     ++void block_source_close(struct reftable_block_source *source)
      +{
      +	if (source->ops == NULL) {
      +		return;
     @@ -1908,7 +1988,8 @@
      +	source->ops = NULL;
      +}
      +
     -+static struct reader_offsets *reader_offsets_for(struct reader *r, byte typ)
     ++static struct reftable_reader_offsets *
     ++reader_offsets_for(struct reftable_reader *r, byte typ)
      +{
      +	switch (typ) {
      +	case BLOCK_TYPE_REF:
     @@ -1921,7 +2002,8 @@
      +	abort();
      +}
      +
     -+static int reader_get_block(struct reader *r, struct block *dest, uint64_t off,
     ++static int reader_get_block(struct reftable_reader *r,
     ++			    struct reftable_block *dest, uint64_t off,
      +			    uint32_t sz)
      +{
      +	if (off >= r->size) {
     @@ -1935,22 +2017,22 @@
      +	return block_source_read_block(r->source, dest, off, sz);
      +}
      +
     -+void reader_return_block(struct reader *r, struct block *p)
     ++void reader_return_block(struct reftable_reader *r, struct reftable_block *p)
      +{
      +	block_source_return_block(r->source, p);
      +}
      +
     -+uint32_t reader_hash_id(struct reader *r)
     ++uint32_t reftable_reader_hash_id(struct reftable_reader *r)
      +{
      +	return r->hash_id;
      +}
      +
     -+const char *reader_name(struct reader *r)
     ++const char *reader_name(struct reftable_reader *r)
      +{
      +	return r->name;
      +}
      +
     -+static int parse_footer(struct reader *r, byte *footer, byte *header)
     ++static int parse_footer(struct reftable_reader *r, byte *footer, byte *header)
      +{
      +	byte *f = footer;
      +	int err = 0;
     @@ -1960,25 +2042,12 @@
      +	}
      +	f += 4;
      +
     -+	if (memcmp(footer, header, HEADER_SIZE)) {
     ++	if (memcmp(footer, header, header_size(r->version))) {
      +		err = FORMAT_ERROR;
      +		goto exit;
      +	}
      +
     -+	r->hash_id = SHA1_ID;
     -+	{
     -+		byte version = *f++;
     -+		if (version == 2) {
     -+			/* DO NOT SUBMIT.  Not yet in the standard. */
     -+			r->hash_id = SHA256_ID;
     -+			version = 1;
     -+		}
     -+		if (version != 1) {
     -+			err = FORMAT_ERROR;
     -+			goto exit;
     -+		}
     -+	}
     -+
     ++	f++;
      +	r->block_size = get_be24(f);
      +
      +	f += 3;
     @@ -1987,6 +2056,22 @@
      +	r->max_update_index = get_be64(f);
      +	f += 8;
      +
     ++	if (r->version == 1) {
     ++		r->hash_id = SHA1_ID;
     ++	} else {
     ++		r->hash_id = get_be32(f);
     ++		switch (r->hash_id) {
     ++		case SHA1_ID:
     ++			break;
     ++		case SHA256_ID:
     ++			break;
     ++		default:
     ++			err = FORMAT_ERROR;
     ++			goto exit;
     ++		}
     ++		f += 4;
     ++	}
     ++
      +	r->ref_offsets.index_offset = get_be64(f);
      +	f += 8;
      +
     @@ -2014,7 +2099,7 @@
      +	}
      +
      +	{
     -+		byte first_block_typ = header[HEADER_SIZE];
     ++		byte first_block_typ = header[header_size(r->version)];
      +		r->ref_offsets.present = (first_block_typ == BLOCK_TYPE_REF);
      +		r->ref_offsets.offset = 0;
      +		r->log_offsets.present = (first_block_typ == BLOCK_TYPE_LOG ||
     @@ -2026,27 +2111,40 @@
      +	return err;
      +}
      +
     -+int init_reader(struct reader *r, struct block_source source, const char *name)
     ++int init_reader(struct reftable_reader *r, struct reftable_block_source source,
     ++		const char *name)
      +{
     -+	struct block footer = { 0 };
     -+	struct block header = { 0 };
     ++	struct reftable_block footer = { 0 };
     ++	struct reftable_block header = { 0 };
      +	int err = 0;
      +
     -+	memset(r, 0, sizeof(struct reader));
     -+	r->size = block_source_size(source) - FOOTER_SIZE;
     -+	r->source = source;
     -+	r->name = xstrdup(name);
     -+	r->hash_id = 0;
     ++	memset(r, 0, sizeof(struct reftable_reader));
      +
     -+	err = block_source_read_block(source, &footer, r->size, FOOTER_SIZE);
     -+	if (err != FOOTER_SIZE) {
     ++	/* Need +1 to read type of first block. */
     ++	err = block_source_read_block(source, &header, 0, header_size(2) + 1);
     ++	if (err != header_size(2) + 1) {
      +		err = IO_ERROR;
      +		goto exit;
      +	}
      +
     -+	/* Need +1 to read type of first block. */
     -+	err = reader_get_block(r, &header, 0, HEADER_SIZE + 1);
     -+	if (err != HEADER_SIZE + 1) {
     ++	if (memcmp(header.data, "REFT", 4)) {
     ++		err = FORMAT_ERROR;
     ++		goto exit;
     ++	}
     ++	r->version = header.data[4];
     ++	if (r->version != 1 && r->version != 2) {
     ++		err = FORMAT_ERROR;
     ++		goto exit;
     ++	}
     ++
     ++	r->size = block_source_size(source) - footer_size(r->version);
     ++	r->source = source;
     ++	r->name = xstrdup(name);
     ++	r->hash_id = 0;
     ++
     ++	err = block_source_read_block(source, &footer, r->size,
     ++				      footer_size(r->version));
     ++	if (err != footer_size(r->version)) {
      +		err = IO_ERROR;
      +		goto exit;
      +	}
     @@ -2059,10 +2157,10 @@
      +}
      +
      +struct table_iter {
     -+	struct reader *r;
     ++	struct reftable_reader *r;
      +	byte typ;
      +	uint64_t block_off;
     -+	struct block_iter bi;
     ++	struct reftable_block_iter bi;
      +	bool finished;
      +};
      +
     @@ -2080,7 +2178,7 @@
      +{
      +	int res = block_iter_next(&ti->bi, rec);
      +	if (res == 0 && record_type(rec) == BLOCK_TYPE_REF) {
     -+		((struct ref_record *)rec.data)->update_index +=
     ++		((struct reftable_ref_record *)rec.data)->update_index +=
      +			ti->r->min_update_index;
      +	}
      +
     @@ -2099,12 +2197,13 @@
      +	ti->bi.next_off = 0;
      +}
      +
     -+static int32_t extract_block_size(byte *data, byte *typ, uint64_t off)
     ++static int32_t extract_block_size(byte *data, byte *typ, uint64_t off,
     ++				  int version)
      +{
      +	int32_t result = 0;
      +
      +	if (off == 0) {
     -+		data += 24;
     ++		data += header_size(version);
      +	}
      +
      +	*typ = data[0];
     @@ -2114,15 +2213,16 @@
      +	return result;
      +}
      +
     -+int reader_init_block_reader(struct reader *r, struct block_reader *br,
     ++int reader_init_block_reader(struct reftable_reader *r,
     ++			     struct reftable_block_reader *br,
      +			     uint64_t next_off, byte want_typ)
      +{
      +	int32_t guess_block_size = r->block_size ? r->block_size :
      +						   DEFAULT_BLOCK_SIZE;
     -+	struct block block = { 0 };
     ++	struct reftable_block block = { 0 };
      +	byte block_typ = 0;
      +	int err = 0;
     -+	uint32_t header_off = next_off ? 0 : HEADER_SIZE;
     ++	uint32_t header_off = next_off ? 0 : header_size(r->version);
      +	int32_t block_size = 0;
      +
      +	if (next_off >= r->size) {
     @@ -2134,7 +2234,8 @@
      +		return err;
      +	}
      +
     -+	block_size = extract_block_size(block.data, &block_typ, next_off);
     ++	block_size = extract_block_size(block.data, &block_typ, next_off,
     ++					r->version);
      +	if (block_size < 0) {
      +		return block_size;
      +	}
     @@ -2160,7 +2261,7 @@
      +				 struct table_iter *src)
      +{
      +	uint64_t next_block_off = src->block_off + src->bi.br->full_block_size;
     -+	struct block_reader br = { 0 };
     ++	struct reftable_block_reader br = { 0 };
      +	int err = 0;
      +
      +	dest->r = src->r;
     @@ -2177,7 +2278,8 @@
      +	}
      +
      +	{
     -+		struct block_reader *brp = malloc(sizeof(struct block_reader));
     ++		struct reftable_block_reader *brp =
     ++			reftable_malloc(sizeof(struct reftable_block_reader));
      +		*brp = br;
      +
      +		dest->finished = false;
     @@ -2229,29 +2331,30 @@
      +	block_iter_close(&ti->bi);
      +}
      +
     -+struct iterator_vtable table_iter_vtable = {
     ++struct reftable_iterator_vtable table_iter_vtable = {
      +	.next = &table_iter_next_void,
      +	.close = &table_iter_close,
      +};
      +
     -+static void iterator_from_table_iter(struct iterator *it, struct table_iter *ti)
     ++static void iterator_from_table_iter(struct reftable_iterator *it,
     ++				     struct table_iter *ti)
      +{
      +	it->iter_arg = ti;
      +	it->ops = &table_iter_vtable;
      +}
      +
     -+static int reader_table_iter_at(struct reader *r, struct table_iter *ti,
     -+				uint64_t off, byte typ)
     ++static int reader_table_iter_at(struct reftable_reader *r,
     ++				struct table_iter *ti, uint64_t off, byte typ)
      +{
     -+	struct block_reader br = { 0 };
     -+	struct block_reader *brp = NULL;
     ++	struct reftable_block_reader br = { 0 };
     ++	struct reftable_block_reader *brp = NULL;
      +
      +	int err = reader_init_block_reader(r, &br, off, typ);
      +	if (err != 0) {
      +		return err;
      +	}
      +
     -+	brp = malloc(sizeof(struct block_reader));
     ++	brp = reftable_malloc(sizeof(struct reftable_block_reader));
      +	*brp = br;
      +	ti->r = r;
      +	ti->typ = block_reader_type(brp);
     @@ -2260,10 +2363,10 @@
      +	return 0;
      +}
      +
     -+static int reader_start(struct reader *r, struct table_iter *ti, byte typ,
     -+			bool index)
     ++static int reader_start(struct reftable_reader *r, struct table_iter *ti,
     ++			byte typ, bool index)
      +{
     -+	struct reader_offsets *offs = reader_offsets_for(r, typ);
     ++	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
      +	uint64_t off = offs->offset;
      +	if (index) {
      +		off = offs->index_offset;
     @@ -2276,7 +2379,7 @@
      +	return reader_table_iter_at(r, ti, off, typ);
      +}
      +
     -+static int reader_seek_linear(struct reader *r, struct table_iter *ti,
     ++static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
      +			      struct record want)
      +{
      +	struct record rec = new_record(record_type(want));
     @@ -2321,14 +2424,14 @@
      +exit:
      +	block_iter_close(&next.bi);
      +	record_clear(rec);
     -+	free(record_yield(&rec));
     -+	free(slice_yield(&want_key));
     -+	free(slice_yield(&got_key));
     ++	reftable_free(record_yield(&rec));
     ++	reftable_free(slice_yield(&want_key));
     ++	reftable_free(slice_yield(&got_key));
      +	return err;
      +}
      +
     -+static int reader_seek_indexed(struct reader *r, struct iterator *it,
     -+			       struct record rec)
     ++static int reader_seek_indexed(struct reftable_reader *r,
     ++			       struct reftable_iterator *it, struct record rec)
      +{
      +	struct index_record want_index = { 0 };
      +	struct record want_index_rec = { 0 };
     @@ -2380,7 +2483,7 @@
      +
      +	if (err == 0) {
      +		struct table_iter *malloced =
     -+			calloc(sizeof(struct table_iter), 1);
     ++			reftable_calloc(sizeof(struct table_iter));
      +		table_iter_copy_from(malloced, &next);
      +		iterator_from_table_iter(it, malloced);
      +	}
     @@ -2392,10 +2495,11 @@
      +	return err;
      +}
      +
     -+static int reader_seek_internal(struct reader *r, struct iterator *it,
     -+				struct record rec)
     ++static int reader_seek_internal(struct reftable_reader *r,
     ++				struct reftable_iterator *it, struct record rec)
      +{
     -+	struct reader_offsets *offs = reader_offsets_for(r, record_type(rec));
     ++	struct reftable_reader_offsets *offs =
     ++		reader_offsets_for(r, record_type(rec));
      +	uint64_t idx = offs->index_offset;
      +	struct table_iter ti = { 0 };
      +	int err = 0;
     @@ -2413,7 +2517,8 @@
      +	}
      +
      +	{
     -+		struct table_iter *p = malloc(sizeof(struct table_iter));
     ++		struct table_iter *p =
     ++			reftable_malloc(sizeof(struct table_iter));
      +		*p = ti;
      +		iterator_from_table_iter(it, p);
      +	}
     @@ -2421,11 +2526,12 @@
      +	return 0;
      +}
      +
     -+int reader_seek(struct reader *r, struct iterator *it, struct record rec)
     ++int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
     ++		struct record rec)
      +{
      +	byte typ = record_type(rec);
      +
     -+	struct reader_offsets *offs = reader_offsets_for(r, typ);
     ++	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
      +	if (!offs->present) {
      +		iterator_set_empty(it);
      +		return 0;
     @@ -2434,9 +2540,10 @@
      +	return reader_seek_internal(r, it, rec);
      +}
      +
     -+int reader_seek_ref(struct reader *r, struct iterator *it, const char *name)
     ++int reftable_reader_seek_ref(struct reftable_reader *r,
     ++			     struct reftable_iterator *it, const char *name)
      +{
     -+	struct ref_record ref = {
     ++	struct reftable_ref_record ref = {
      +		.ref_name = (char *)name,
      +	};
      +	struct record rec = { 0 };
     @@ -2444,10 +2551,11 @@
      +	return reader_seek(r, it, rec);
      +}
      +
     -+int reader_seek_log_at(struct reader *r, struct iterator *it, const char *name,
     -+		       uint64_t update_index)
     ++int reftable_reader_seek_log_at(struct reftable_reader *r,
     ++				struct reftable_iterator *it, const char *name,
     ++				uint64_t update_index)
      +{
     -+	struct log_record log = {
     ++	struct reftable_log_record log = {
      +		.ref_name = (char *)name,
      +		.update_index = update_index,
      +	};
     @@ -2456,45 +2564,49 @@
      +	return reader_seek(r, it, rec);
      +}
      +
     -+int reader_seek_log(struct reader *r, struct iterator *it, const char *name)
     ++int reftable_reader_seek_log(struct reftable_reader *r,
     ++			     struct reftable_iterator *it, const char *name)
      +{
      +	uint64_t max = ~((uint64_t)0);
     -+	return reader_seek_log_at(r, it, name, max);
     ++	return reftable_reader_seek_log_at(r, it, name, max);
      +}
      +
     -+void reader_close(struct reader *r)
     ++void reader_close(struct reftable_reader *r)
      +{
      +	block_source_close(&r->source);
      +	FREE_AND_NULL(r->name);
      +}
      +
     -+int new_reader(struct reader **p, struct block_source src, char const *name)
     ++int reftable_new_reader(struct reftable_reader **p,
     ++			struct reftable_block_source src, char const *name)
      +{
     -+	struct reader *rd = calloc(sizeof(struct reader), 1);
     ++	struct reftable_reader *rd =
     ++		reftable_calloc(sizeof(struct reftable_reader));
      +	int err = init_reader(rd, src, name);
      +	if (err == 0) {
      +		*p = rd;
      +	} else {
     -+		free(rd);
     ++		reftable_free(rd);
      +	}
      +	return err;
      +}
      +
     -+void reader_free(struct reader *r)
     ++void reftable_reader_free(struct reftable_reader *r)
      +{
      +	reader_close(r);
     -+	free(r);
     ++	reftable_free(r);
      +}
      +
     -+static int reader_refs_for_indexed(struct reader *r, struct iterator *it,
     -+				   byte *oid)
     ++static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
     ++					    struct reftable_iterator *it,
     ++					    byte *oid)
      +{
      +	struct obj_record want = {
      +		.hash_prefix = oid,
      +		.hash_prefix_len = r->object_id_len,
      +	};
      +	struct record want_rec = { 0 };
     -+	struct iterator oit = { 0 };
     ++	struct reftable_iterator oit = { 0 };
      +	struct obj_record got = { 0 };
      +	struct record got_rec = { 0 };
      +	int err = 0;
     @@ -2508,7 +2620,7 @@
      +
      +	record_from_obj(&got_rec, &got);
      +	err = iterator_next(oit, got_rec);
     -+	iterator_destroy(&oit);
     ++	reftable_iterator_destroy(&oit);
      +	if (err < 0) {
      +		return err;
      +	}
     @@ -2537,18 +2649,19 @@
      +	return 0;
      +}
      +
     -+static int reader_refs_for_unindexed(struct reader *r, struct iterator *it,
     -+				     byte *oid, int oid_len)
     ++static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
     ++					      struct reftable_iterator *it,
     ++					      byte *oid, int oid_len)
      +{
     -+	struct table_iter *ti = calloc(sizeof(struct table_iter), 1);
     ++	struct table_iter *ti = reftable_calloc(sizeof(struct table_iter));
      +	struct filtering_ref_iterator *filter = NULL;
      +	int err = reader_start(r, ti, BLOCK_TYPE_REF, false);
      +	if (err < 0) {
     -+		free(ti);
     ++		reftable_free(ti);
      +		return err;
      +	}
      +
     -+	filter = calloc(sizeof(struct filtering_ref_iterator), 1);
     ++	filter = reftable_calloc(sizeof(struct filtering_ref_iterator));
      +	slice_resize(&filter->oid, oid_len);
      +	memcpy(filter->oid.buf, oid, oid_len);
      +	filter->r = r;
     @@ -2559,21 +2672,22 @@
      +	return 0;
      +}
      +
     -+int reader_refs_for(struct reader *r, struct iterator *it, byte *oid,
     -+		    int oid_len)
     ++int reftable_reader_refs_for(struct reftable_reader *r,
     ++			     struct reftable_iterator *it, byte *oid,
     ++			     int oid_len)
      +{
      +	if (r->obj_offsets.present) {
     -+		return reader_refs_for_indexed(r, it, oid);
     ++		return reftable_reader_refs_for_indexed(r, it, oid);
      +	}
     -+	return reader_refs_for_unindexed(r, it, oid, oid_len);
     ++	return reftable_reader_refs_for_unindexed(r, it, oid, oid_len);
      +}
      +
     -+uint64_t reader_max_update_index(struct reader *r)
     ++uint64_t reftable_reader_max_update_index(struct reftable_reader *r)
      +{
      +	return r->max_update_index;
      +}
      +
     -+uint64_t reader_min_update_index(struct reader *r)
     ++uint64_t reftable_reader_min_update_index(struct reftable_reader *r)
      +{
      +	return r->min_update_index;
      +}
     @@ -2598,40 +2712,48 @@
      +#include "record.h"
      +#include "reftable.h"
      +
     -+uint64_t block_source_size(struct block_source source);
     ++uint64_t block_source_size(struct reftable_block_source source);
      +
     -+int block_source_read_block(struct block_source source, struct block *dest,
     -+			    uint64_t off, uint32_t size);
     -+void block_source_return_block(struct block_source source, struct block *ret);
     -+void block_source_close(struct block_source *source);
     ++int block_source_read_block(struct reftable_block_source source,
     ++			    struct reftable_block *dest, uint64_t off,
     ++			    uint32_t size);
     ++void block_source_return_block(struct reftable_block_source source,
     ++			       struct reftable_block *ret);
     ++void block_source_close(struct reftable_block_source *source);
      +
     -+struct reader_offsets {
     ++struct reftable_reader_offsets {
      +	bool present;
      +	uint64_t offset;
      +	uint64_t index_offset;
      +};
      +
     -+struct reader {
     ++struct reftable_reader {
      +	char *name;
     -+	struct block_source source;
     ++	struct reftable_block_source source;
      +	uint32_t hash_id;
     ++
     ++	// Size of the file, excluding the footer.
      +	uint64_t size;
      +	uint32_t block_size;
      +	uint64_t min_update_index;
      +	uint64_t max_update_index;
      +	int object_id_len;
     ++	int version;
      +
     -+	struct reader_offsets ref_offsets;
     -+	struct reader_offsets obj_offsets;
     -+	struct reader_offsets log_offsets;
     ++	struct reftable_reader_offsets ref_offsets;
     ++	struct reftable_reader_offsets obj_offsets;
     ++	struct reftable_reader_offsets log_offsets;
      +};
      +
     -+int init_reader(struct reader *r, struct block_source source, const char *name);
     -+int reader_seek(struct reader *r, struct iterator *it, struct record rec);
     -+void reader_close(struct reader *r);
     -+const char *reader_name(struct reader *r);
     -+void reader_return_block(struct reader *r, struct block *p);
     -+int reader_init_block_reader(struct reader *r, struct block_reader *br,
     ++int init_reader(struct reftable_reader *r, struct reftable_block_source source,
     ++		const char *name);
     ++int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
     ++		struct record rec);
     ++void reader_close(struct reftable_reader *r);
     ++const char *reader_name(struct reftable_reader *r);
     ++void reader_return_block(struct reftable_reader *r, struct reftable_block *p);
     ++int reader_init_block_reader(struct reftable_reader *r,
     ++			     struct reftable_block_reader *br,
      +			     uint64_t next_off, byte want_typ);
      +
      +#endif
     @@ -2649,6 +2771,8 @@
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     ++/* record.c - methods for different types of records. */
     ++
      +#include "record.h"
      +
      +#include "system.h"
     @@ -2656,18 +2780,6 @@
      +#include "constants.h"
      +#include "reftable.h"
      +
     -+int is_block_type(byte typ)
     -+{
     -+	switch (typ) {
     -+	case BLOCK_TYPE_REF:
     -+	case BLOCK_TYPE_LOG:
     -+	case BLOCK_TYPE_OBJ:
     -+	case BLOCK_TYPE_INDEX:
     -+		return true;
     -+	}
     -+	return false;
     -+}
     -+
      +int get_var_int(uint64_t *dest, struct slice in)
      +{
      +	int ptr = 0;
     @@ -2716,17 +2828,16 @@
      +	}
      +}
      +
     -+int common_prefix_size(struct slice a, struct slice b)
     ++int is_block_type(byte typ)
      +{
     -+	int p = 0;
     -+	while (p < a.len && p < b.len) {
     -+		if (a.buf[p] != b.buf[p]) {
     -+			break;
     -+		}
     -+		p++;
     ++	switch (typ) {
     ++	case BLOCK_TYPE_REF:
     ++	case BLOCK_TYPE_LOG:
     ++	case BLOCK_TYPE_OBJ:
     ++	case BLOCK_TYPE_INDEX:
     ++		return true;
      +	}
     -+
     -+	return p;
     ++	return false;
      +}
      +
      +static int decode_string(struct slice *dest, struct slice in)
     @@ -2737,8 +2848,7 @@
      +	if (n <= 0) {
      +		return -1;
      +	}
     -+	in.buf += n;
     -+	in.len -= n;
     ++	slice_consume(&in, n);
      +	if (in.len < tsize) {
      +		return -1;
      +	}
     @@ -2746,12 +2856,29 @@
      +	slice_resize(dest, tsize + 1);
      +	dest->buf[tsize] = 0;
      +	memcpy(dest->buf, in.buf, tsize);
     -+	in.buf += tsize;
     -+	in.len -= tsize;
     ++	slice_consume(&in, tsize);
      +
      +	return start_len - in.len;
      +}
      +
     ++static int encode_string(char *str, struct slice s)
     ++{
     ++	struct slice start = s;
     ++	int l = strlen(str);
     ++	int n = put_var_int(s, l);
     ++	if (n < 0) {
     ++		return -1;
     ++	}
     ++	slice_consume(&s, n);
     ++	if (s.len < l) {
     ++		return -1;
     ++	}
     ++	memcpy(s.buf, str, l);
     ++	slice_consume(&s, l);
     ++
     ++	return start.len - s.len;
     ++}
     ++
      +int encode_key(bool *restart, struct slice dest, struct slice prev_key,
      +	       struct slice key, byte extra)
      +{
     @@ -2762,8 +2889,7 @@
      +	if (n < 0) {
      +		return -1;
      +	}
     -+	dest.buf += n;
     -+	dest.len -= n;
     ++	slice_consume(&dest, n);
      +
      +	*restart = (prefix_len == 0);
      +
     @@ -2771,39 +2897,77 @@
      +	if (n < 0) {
      +		return -1;
      +	}
     -+	dest.buf += n;
     -+	dest.len -= n;
     ++	slice_consume(&dest, n);
      +
      +	if (dest.len < suffix_len) {
      +		return -1;
      +	}
      +	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
     -+	dest.buf += suffix_len;
     -+	dest.len -= suffix_len;
     ++	slice_consume(&dest, suffix_len);
      +
      +	return start.len - dest.len;
      +}
      +
     -+static byte ref_record_type(void)
     ++int decode_key(struct slice *key, byte *extra, struct slice last_key,
     ++	       struct slice in)
     ++{
     ++	int start_len = in.len;
     ++	uint64_t prefix_len = 0;
     ++	uint64_t suffix_len = 0;
     ++	int n = get_var_int(&prefix_len, in);
     ++	if (n < 0) {
     ++		return -1;
     ++	}
     ++	slice_consume(&in, n);
     ++
     ++	if (prefix_len > last_key.len) {
     ++		return -1;
     ++	}
     ++
     ++	n = get_var_int(&suffix_len, in);
     ++	if (n <= 0) {
     ++		return -1;
     ++	}
     ++	slice_consume(&in, n);
     ++
     ++	*extra = (byte)(suffix_len & 0x7);
     ++	suffix_len >>= 3;
     ++
     ++	if (in.len < suffix_len) {
     ++		return -1;
     ++	}
     ++
     ++	slice_resize(key, suffix_len + prefix_len);
     ++	memcpy(key->buf, last_key.buf, prefix_len);
     ++
     ++	memcpy(key->buf + prefix_len, in.buf, suffix_len);
     ++	slice_consume(&in, suffix_len);
     ++
     ++	return start_len - in.len;
     ++}
     ++
     ++static byte reftable_ref_record_type(void)
      +{
      +	return BLOCK_TYPE_REF;
      +}
      +
     -+static void ref_record_key(const void *r, struct slice *dest)
     ++static void reftable_ref_record_key(const void *r, struct slice *dest)
      +{
     -+	const struct ref_record *rec = (const struct ref_record *)r;
     ++	const struct reftable_ref_record *rec =
     ++		(const struct reftable_ref_record *)r;
      +	slice_set_string(dest, rec->ref_name);
      +}
      +
     -+static void ref_record_copy_from(void *rec, const void *src_rec, int hash_size)
     ++static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
     ++					  int hash_size)
      +{
     -+	struct ref_record *ref = (struct ref_record *)rec;
     -+	struct ref_record *src = (struct ref_record *)src_rec;
     ++	struct reftable_ref_record *ref = (struct reftable_ref_record *)rec;
     ++	struct reftable_ref_record *src = (struct reftable_ref_record *)src_rec;
      +	assert(hash_size > 0);
      +
      +	/* This is simple and correct, but we could probably reuse the hash
      +	   fields. */
     -+	ref_record_clear(ref);
     ++	reftable_ref_record_clear(ref);
      +	if (src->ref_name != NULL) {
      +		ref->ref_name = xstrdup(src->ref_name);
      +	}
     @@ -2813,12 +2977,12 @@
      +	}
      +
      +	if (src->target_value != NULL) {
     -+		ref->target_value = malloc(hash_size);
     ++		ref->target_value = reftable_malloc(hash_size);
      +		memcpy(ref->target_value, src->target_value, hash_size);
      +	}
      +
      +	if (src->value != NULL) {
     -+		ref->value = malloc(hash_size);
     ++		ref->value = reftable_malloc(hash_size);
      +		memcpy(ref->value, src->value, hash_size);
      +	}
      +	ref->update_index = src->update_index;
     @@ -2845,7 +3009,7 @@
      +	}
      +}
      +
     -+void ref_record_print(struct ref_record *ref, int hash_size)
     ++void reftable_ref_record_print(struct reftable_ref_record *ref, int hash_size)
      +{
      +	char hex[SHA256_SIZE + 1] = { 0 };
      +
     @@ -2864,23 +3028,24 @@
      +	printf("}\n");
      +}
      +
     -+static void ref_record_clear_void(void *rec)
     ++static void reftable_ref_record_clear_void(void *rec)
      +{
     -+	ref_record_clear((struct ref_record *)rec);
     ++	reftable_ref_record_clear((struct reftable_ref_record *)rec);
      +}
      +
     -+void ref_record_clear(struct ref_record *ref)
     ++void reftable_ref_record_clear(struct reftable_ref_record *ref)
      +{
     -+	free(ref->ref_name);
     -+	free(ref->target);
     -+	free(ref->target_value);
     -+	free(ref->value);
     -+	memset(ref, 0, sizeof(struct ref_record));
     ++	reftable_free(ref->ref_name);
     ++	reftable_free(ref->target);
     ++	reftable_free(ref->target_value);
     ++	reftable_free(ref->value);
     ++	memset(ref, 0, sizeof(struct reftable_ref_record));
      +}
      +
     -+static byte ref_record_val_type(const void *rec)
     ++static byte reftable_ref_record_val_type(const void *rec)
      +{
     -+	const struct ref_record *r = (const struct ref_record *)rec;
     ++	const struct reftable_ref_record *r =
     ++		(const struct reftable_ref_record *)rec;
      +	if (r->value != NULL) {
      +		if (r->target_value != NULL) {
      +			return 2;
     @@ -2893,45 +3058,25 @@
      +	return 0;
      +}
      +
     -+static int encode_string(char *str, struct slice s)
     -+{
     -+	struct slice start = s;
     -+	int l = strlen(str);
     -+	int n = put_var_int(s, l);
     -+	if (n < 0) {
     -+		return -1;
     -+	}
     -+	s.buf += n;
     -+	s.len -= n;
     -+	if (s.len < l) {
     -+		return -1;
     -+	}
     -+	memcpy(s.buf, str, l);
     -+	s.buf += l;
     -+	s.len -= l;
     -+
     -+	return start.len - s.len;
     -+}
     -+
     -+static int ref_record_encode(const void *rec, struct slice s, int hash_size)
     ++static int reftable_ref_record_encode(const void *rec, struct slice s,
     ++				      int hash_size)
      +{
     -+	const struct ref_record *r = (const struct ref_record *)rec;
     ++	const struct reftable_ref_record *r =
     ++		(const struct reftable_ref_record *)rec;
      +	struct slice start = s;
      +	int n = put_var_int(s, r->update_index);
      +	assert(hash_size > 0);
      +	if (n < 0) {
      +		return -1;
      +	}
     -+	s.buf += n;
     -+	s.len -= n;
     ++	slice_consume(&s, n);
      +
      +	if (r->value != NULL) {
      +		if (s.len < hash_size) {
      +			return -1;
      +		}
      +		memcpy(s.buf, r->value, hash_size);
     -+		s.buf += hash_size;
     -+		s.len -= hash_size;
     ++		slice_consume(&s, hash_size);
      +	}
      +
      +	if (r->target_value != NULL) {
     @@ -2939,8 +3084,7 @@
      +			return -1;
      +		}
      +		memcpy(s.buf, r->target_value, hash_size);
     -+		s.buf += hash_size;
     -+		s.len -= hash_size;
     ++		slice_consume(&s, hash_size);
      +	}
      +
      +	if (r->target != NULL) {
     @@ -2948,17 +3092,17 @@
      +		if (n < 0) {
      +			return -1;
      +		}
     -+		s.buf += n;
     -+		s.len -= n;
     ++		slice_consume(&s, n);
      +	}
      +
      +	return start.len - s.len;
      +}
      +
     -+static int ref_record_decode(void *rec, struct slice key, byte val_type,
     -+			     struct slice in, int hash_size)
     ++static int reftable_ref_record_decode(void *rec, struct slice key,
     ++				      byte val_type, struct slice in,
     ++				      int hash_size)
      +{
     -+	struct ref_record *r = (struct ref_record *)rec;
     ++	struct reftable_ref_record *r = (struct reftable_ref_record *)rec;
      +	struct slice start = in;
      +	bool seen_value = false;
      +	bool seen_target_value = false;
     @@ -2970,10 +3114,9 @@
      +	}
      +	assert(hash_size > 0);
      +
     -+	in.buf += n;
     -+	in.len -= n;
     ++	slice_consume(&in, n);
      +
     -+	r->ref_name = realloc(r->ref_name, key.len + 1);
     ++	r->ref_name = reftable_realloc(r->ref_name, key.len + 1);
      +	memcpy(r->ref_name, key.buf, key.len);
      +	r->ref_name[key.len] = 0;
      +
     @@ -2985,22 +3128,20 @@
      +		}
      +
      +		if (r->value == NULL) {
     -+			r->value = malloc(hash_size);
     ++			r->value = reftable_malloc(hash_size);
      +		}
      +		seen_value = true;
      +		memcpy(r->value, in.buf, hash_size);
     -+		in.buf += hash_size;
     -+		in.len -= hash_size;
     ++		slice_consume(&in, hash_size);
      +		if (val_type == 1) {
      +			break;
      +		}
      +		if (r->target_value == NULL) {
     -+			r->target_value = malloc(hash_size);
     ++			r->target_value = reftable_malloc(hash_size);
      +		}
      +		seen_target_value = true;
      +		memcpy(r->target_value, in.buf, hash_size);
     -+		in.buf += hash_size;
     -+		in.len -= hash_size;
     ++		slice_consume(&in, hash_size);
      +		break;
      +	case 3: {
      +		struct slice dest = { 0 };
     @@ -3008,8 +3149,7 @@
      +		if (n < 0) {
      +			return -1;
      +		}
     -+		in.buf += n;
     -+		in.len -= n;
     ++		slice_consume(&in, n);
      +		seen_target = true;
      +		r->target = (char *)slice_as_string(&dest);
      +	} break;
     @@ -3034,55 +3174,14 @@
      +	return start.len - in.len;
      +}
      +
     -+int decode_key(struct slice *key, byte *extra, struct slice last_key,
     -+	       struct slice in)
     -+{
     -+	int start_len = in.len;
     -+	uint64_t prefix_len = 0;
     -+	uint64_t suffix_len = 0;
     -+	int n = get_var_int(&prefix_len, in);
     -+	if (n < 0) {
     -+		return -1;
     -+	}
     -+	in.buf += n;
     -+	in.len -= n;
     -+
     -+	if (prefix_len > last_key.len) {
     -+		return -1;
     -+	}
     -+
     -+	n = get_var_int(&suffix_len, in);
     -+	if (n <= 0) {
     -+		return -1;
     -+	}
     -+	in.buf += n;
     -+	in.len -= n;
     -+
     -+	*extra = (byte)(suffix_len & 0x7);
     -+	suffix_len >>= 3;
     -+
     -+	if (in.len < suffix_len) {
     -+		return -1;
     -+	}
     -+
     -+	slice_resize(key, suffix_len + prefix_len);
     -+	memcpy(key->buf, last_key.buf, prefix_len);
     -+
     -+	memcpy(key->buf + prefix_len, in.buf, suffix_len);
     -+	in.buf += suffix_len;
     -+	in.len -= suffix_len;
     -+
     -+	return start_len - in.len;
     -+}
     -+
     -+struct record_vtable ref_record_vtable = {
     -+	.key = &ref_record_key,
     -+	.type = &ref_record_type,
     -+	.copy_from = &ref_record_copy_from,
     -+	.val_type = &ref_record_val_type,
     -+	.encode = &ref_record_encode,
     -+	.decode = &ref_record_decode,
     -+	.clear = &ref_record_clear_void,
     ++struct record_vtable reftable_ref_record_vtable = {
     ++	.key = &reftable_ref_record_key,
     ++	.type = &reftable_ref_record_type,
     ++	.copy_from = &reftable_ref_record_copy_from,
     ++	.val_type = &reftable_ref_record_val_type,
     ++	.encode = &reftable_ref_record_encode,
     ++	.decode = &reftable_ref_record_decode,
     ++	.clear = &reftable_ref_record_clear_void,
      +};
      +
      +static byte obj_record_type(void)
     @@ -3103,12 +3202,12 @@
      +	const struct obj_record *src = (const struct obj_record *)src_rec;
      +
      +	*ref = *src;
     -+	ref->hash_prefix = malloc(ref->hash_prefix_len);
     ++	ref->hash_prefix = reftable_malloc(ref->hash_prefix_len);
      +	memcpy(ref->hash_prefix, src->hash_prefix, ref->hash_prefix_len);
      +
      +	{
      +		int olen = ref->offset_len * sizeof(uint64_t);
     -+		ref->offsets = malloc(olen);
     ++		ref->offsets = reftable_malloc(olen);
      +		memcpy(ref->offsets, src->offsets, olen);
      +	}
      +}
     @@ -3140,8 +3239,7 @@
      +		if (n < 0) {
      +			return -1;
      +		}
     -+		s.buf += n;
     -+		s.len -= n;
     ++		slice_consume(&s, n);
      +	}
      +	if (r->offset_len == 0) {
      +		return start.len - s.len;
     @@ -3150,8 +3248,7 @@
      +	if (n < 0) {
      +		return -1;
      +	}
     -+	s.buf += n;
     -+	s.len -= n;
     ++	slice_consume(&s, n);
      +
      +	{
      +		uint64_t last = r->offsets[0];
     @@ -3161,8 +3258,7 @@
      +			if (n < 0) {
      +				return -1;
      +			}
     -+			s.buf += n;
     -+			s.len -= n;
     ++			slice_consume(&s, n);
      +			last = r->offsets[i];
      +		}
      +	}
     @@ -3176,7 +3272,7 @@
      +	struct obj_record *r = (struct obj_record *)rec;
      +	uint64_t count = val_type;
      +	int n = 0;
     -+	r->hash_prefix = malloc(key.len);
     ++	r->hash_prefix = reftable_malloc(key.len);
      +	memcpy(r->hash_prefix, key.buf, key.len);
      +	r->hash_prefix_len = key.len;
      +
     @@ -3186,8 +3282,7 @@
      +			return n;
      +		}
      +
     -+		in.buf += n;
     -+		in.len -= n;
     ++		slice_consume(&in, n);
      +	}
      +
      +	r->offsets = NULL;
     @@ -3196,16 +3291,14 @@
      +		return start.len - in.len;
      +	}
      +
     -+	r->offsets = malloc(count * sizeof(uint64_t));
     ++	r->offsets = reftable_malloc(count * sizeof(uint64_t));
      +	r->offset_len = count;
      +
      +	n = get_var_int(&r->offsets[0], in);
      +	if (n < 0) {
      +		return n;
      +	}
     -+
     -+	in.buf += n;
     -+	in.len -= n;
     ++	slice_consume(&in, n);
      +
      +	{
      +		uint64_t last = r->offsets[0];
     @@ -3216,9 +3309,7 @@
      +			if (n < 0) {
      +				return n;
      +			}
     -+
     -+			in.buf += n;
     -+			in.len -= n;
     ++			slice_consume(&in, n);
      +
      +			last = r->offsets[j] = (delta + last);
      +			j++;
     @@ -3237,7 +3328,7 @@
      +	.clear = &obj_record_clear,
      +};
      +
     -+void log_record_print(struct log_record *log, int hash_size)
     ++void reftable_log_record_print(struct reftable_log_record *log, int hash_size)
      +{
      +	char hex[SHA256_SIZE + 1] = { 0 };
      +
     @@ -3250,14 +3341,15 @@
      +	printf("%s\n\n%s\n}\n", hex, log->message);
      +}
      +
     -+static byte log_record_type(void)
     ++static byte reftable_log_record_type(void)
      +{
      +	return BLOCK_TYPE_LOG;
      +}
      +
     -+static void log_record_key(const void *r, struct slice *dest)
     ++static void reftable_log_record_key(const void *r, struct slice *dest)
      +{
     -+	const struct log_record *rec = (const struct log_record *)r;
     ++	const struct reftable_log_record *rec =
     ++		(const struct reftable_log_record *)r;
      +	int len = strlen(rec->ref_name);
      +	uint64_t ts = 0;
      +	slice_resize(dest, len + 9);
     @@ -3266,10 +3358,12 @@
      +	put_be64(dest->buf + 1 + len, ts);
      +}
      +
     -+static void log_record_copy_from(void *rec, const void *src_rec, int hash_size)
     ++static void reftable_log_record_copy_from(void *rec, const void *src_rec,
     ++					  int hash_size)
      +{
     -+	struct log_record *dst = (struct log_record *)rec;
     -+	const struct log_record *src = (const struct log_record *)src_rec;
     ++	struct reftable_log_record *dst = (struct reftable_log_record *)rec;
     ++	const struct reftable_log_record *src =
     ++		(const struct reftable_log_record *)src_rec;
      +
      +	*dst = *src;
      +	dst->ref_name = xstrdup(dst->ref_name);
     @@ -3277,46 +3371,54 @@
      +	dst->name = xstrdup(dst->name);
      +	dst->message = xstrdup(dst->message);
      +	if (dst->new_hash != NULL) {
     -+		dst->new_hash = malloc(hash_size);
     ++		dst->new_hash = reftable_malloc(hash_size);
      +		memcpy(dst->new_hash, src->new_hash, hash_size);
      +	}
      +	if (dst->old_hash != NULL) {
     -+		dst->old_hash = malloc(hash_size);
     ++		dst->old_hash = reftable_malloc(hash_size);
      +		memcpy(dst->old_hash, src->old_hash, hash_size);
      +	}
      +}
      +
     -+static void log_record_clear_void(void *rec)
     ++static void reftable_log_record_clear_void(void *rec)
      +{
     -+	struct log_record *r = (struct log_record *)rec;
     -+	log_record_clear(r);
     ++	struct reftable_log_record *r = (struct reftable_log_record *)rec;
     ++	reftable_log_record_clear(r);
      +}
      +
     -+void log_record_clear(struct log_record *r)
     ++void reftable_log_record_clear(struct reftable_log_record *r)
      +{
     -+	free(r->ref_name);
     -+	free(r->new_hash);
     -+	free(r->old_hash);
     -+	free(r->name);
     -+	free(r->email);
     -+	free(r->message);
     -+	memset(r, 0, sizeof(struct log_record));
     ++	reftable_free(r->ref_name);
     ++	reftable_free(r->new_hash);
     ++	reftable_free(r->old_hash);
     ++	reftable_free(r->name);
     ++	reftable_free(r->email);
     ++	reftable_free(r->message);
     ++	memset(r, 0, sizeof(struct reftable_log_record));
      +}
      +
     -+static byte log_record_val_type(const void *rec)
     ++static byte reftable_log_record_val_type(const void *rec)
      +{
     -+	return 1;
     ++	const struct reftable_log_record *log =
     ++		(const struct reftable_log_record *)rec;
     ++
     ++	return reftable_log_record_is_deletion(log) ? 0 : 1;
      +}
      +
      +static byte zero[SHA256_SIZE] = { 0 };
      +
     -+static int log_record_encode(const void *rec, struct slice s, int hash_size)
     ++static int reftable_log_record_encode(const void *rec, struct slice s,
     ++				      int hash_size)
      +{
     -+	struct log_record *r = (struct log_record *)rec;
     ++	struct reftable_log_record *r = (struct reftable_log_record *)rec;
      +	struct slice start = s;
      +	int n = 0;
      +	byte *oldh = r->old_hash;
      +	byte *newh = r->new_hash;
     ++	if (reftable_log_record_is_deletion(r)) {
     ++		return 0;
     ++	}
     ++
      +	if (oldh == NULL) {
      +		oldh = zero;
      +	}
     @@ -3330,53 +3432,48 @@
      +
      +	memcpy(s.buf, oldh, hash_size);
      +	memcpy(s.buf + hash_size, newh, hash_size);
     -+	s.buf += 2 * hash_size;
     -+	s.len -= 2 * hash_size;
     ++	slice_consume(&s, 2 * hash_size);
      +
      +	n = encode_string(r->name ? r->name : "", s);
      +	if (n < 0) {
      +		return -1;
      +	}
     -+	s.len -= n;
     -+	s.buf += n;
     ++	slice_consume(&s, n);
      +
      +	n = encode_string(r->email ? r->email : "", s);
      +	if (n < 0) {
      +		return -1;
      +	}
     -+	s.len -= n;
     -+	s.buf += n;
     ++	slice_consume(&s, n);
      +
      +	n = put_var_int(s, r->time);
      +	if (n < 0) {
      +		return -1;
      +	}
     -+	s.buf += n;
     -+	s.len -= n;
     ++	slice_consume(&s, n);
      +
      +	if (s.len < 2) {
      +		return -1;
      +	}
      +
      +	put_be16(s.buf, r->tz_offset);
     -+	s.buf += 2;
     -+	s.len -= 2;
     ++	slice_consume(&s, 2);
      +
      +	n = encode_string(r->message ? r->message : "", s);
      +	if (n < 0) {
      +		return -1;
      +	}
     -+	s.len -= n;
     -+	s.buf += n;
     ++	slice_consume(&s, n);
      +
      +	return start.len - s.len;
      +}
      +
     -+static int log_record_decode(void *rec, struct slice key, byte val_type,
     -+			     struct slice in, int hash_size)
     ++static int reftable_log_record_decode(void *rec, struct slice key,
     ++				      byte val_type, struct slice in,
     ++				      int hash_size)
      +{
      +	struct slice start = in;
     -+	struct log_record *r = (struct log_record *)rec;
     ++	struct reftable_log_record *r = (struct reftable_log_record *)rec;
      +	uint64_t max = 0;
      +	uint64_t ts = 0;
      +	struct slice dest = { 0 };
     @@ -3386,33 +3483,35 @@
      +		return FORMAT_ERROR;
      +	}
      +
     -+	r->ref_name = realloc(r->ref_name, key.len - 8);
     ++	r->ref_name = reftable_realloc(r->ref_name, key.len - 8);
      +	memcpy(r->ref_name, key.buf, key.len - 8);
      +	ts = get_be64(key.buf + key.len - 8);
      +
      +	r->update_index = (~max) - ts;
      +
     ++	if (val_type == 0) {
     ++		return 0;
     ++	}
     ++
      +	if (in.len < 2 * hash_size) {
      +		return FORMAT_ERROR;
      +	}
      +
     -+	r->old_hash = realloc(r->old_hash, hash_size);
     -+	r->new_hash = realloc(r->new_hash, hash_size);
     ++	r->old_hash = reftable_realloc(r->old_hash, hash_size);
     ++	r->new_hash = reftable_realloc(r->new_hash, hash_size);
      +
      +	memcpy(r->old_hash, in.buf, hash_size);
      +	memcpy(r->new_hash, in.buf + hash_size, hash_size);
      +
     -+	in.buf += 2 * hash_size;
     -+	in.len -= 2 * hash_size;
     ++	slice_consume(&in, 2 * hash_size);
      +
      +	n = decode_string(&dest, in);
      +	if (n < 0) {
      +		goto error;
      +	}
     -+	in.len -= n;
     -+	in.buf += n;
     ++	slice_consume(&in, n);
      +
     -+	r->name = realloc(r->name, dest.len + 1);
     ++	r->name = reftable_realloc(r->name, dest.len + 1);
      +	memcpy(r->name, dest.buf, dest.len);
      +	r->name[dest.len] = 0;
      +
     @@ -3421,10 +3520,9 @@
      +	if (n < 0) {
      +		goto error;
      +	}
     -+	in.len -= n;
     -+	in.buf += n;
     ++	slice_consume(&in, n);
      +
     -+	r->email = realloc(r->email, dest.len + 1);
     ++	r->email = reftable_realloc(r->email, dest.len + 1);
      +	memcpy(r->email, dest.buf, dest.len);
      +	r->email[dest.len] = 0;
      +
     @@ -3433,33 +3531,30 @@
      +	if (n < 0) {
      +		goto error;
      +	}
     -+	in.len -= n;
     -+	in.buf += n;
     ++	slice_consume(&in, n);
      +	r->time = ts;
      +	if (in.len < 2) {
      +		goto error;
      +	}
      +
      +	r->tz_offset = get_be16(in.buf);
     -+	in.buf += 2;
     -+	in.len -= 2;
     ++	slice_consume(&in, 2);
      +
      +	slice_resize(&dest, 0);
      +	n = decode_string(&dest, in);
      +	if (n < 0) {
      +		goto error;
      +	}
     -+	in.len -= n;
     -+	in.buf += n;
     ++	slice_consume(&in, n);
      +
     -+	r->message = realloc(r->message, dest.len + 1);
     ++	r->message = reftable_realloc(r->message, dest.len + 1);
      +	memcpy(r->message, dest.buf, dest.len);
      +	r->message[dest.len] = 0;
      +
      +	return start.len - in.len;
      +
      +error:
     -+	free(slice_yield(&dest));
     ++	reftable_free(slice_yield(&dest));
      +	return FORMAT_ERROR;
      +}
      +
     @@ -3486,7 +3581,8 @@
      +	return !memcmp(a, b, sz);
      +}
      +
     -+bool log_record_equal(struct log_record *a, struct log_record *b, int hash_size)
     ++bool reftable_log_record_equal(struct reftable_log_record *a,
     ++			       struct reftable_log_record *b, int hash_size)
      +{
      +	return null_streq(a->name, b->name) && null_streq(a->email, b->email) &&
      +	       null_streq(a->message, b->message) &&
     @@ -3496,14 +3592,14 @@
      +	       a->update_index == b->update_index;
      +}
      +
     -+struct record_vtable log_record_vtable = {
     -+	.key = &log_record_key,
     -+	.type = &log_record_type,
     -+	.copy_from = &log_record_copy_from,
     -+	.val_type = &log_record_val_type,
     -+	.encode = &log_record_encode,
     -+	.decode = &log_record_decode,
     -+	.clear = &log_record_clear_void,
     ++struct record_vtable reftable_log_record_vtable = {
     ++	.key = &reftable_log_record_key,
     ++	.type = &reftable_log_record_type,
     ++	.copy_from = &reftable_log_record_copy_from,
     ++	.val_type = &reftable_log_record_val_type,
     ++	.encode = &reftable_log_record_encode,
     ++	.decode = &reftable_log_record_decode,
     ++	.clear = &reftable_log_record_clear_void,
      +};
      +
      +struct record new_record(byte typ)
     @@ -3511,23 +3607,27 @@
      +	struct record rec;
      +	switch (typ) {
      +	case BLOCK_TYPE_REF: {
     -+		struct ref_record *r = calloc(1, sizeof(struct ref_record));
     ++		struct reftable_ref_record *r =
     ++			reftable_calloc(sizeof(struct reftable_ref_record));
      +		record_from_ref(&rec, r);
      +		return rec;
      +	}
      +
      +	case BLOCK_TYPE_OBJ: {
     -+		struct obj_record *r = calloc(1, sizeof(struct obj_record));
     ++		struct obj_record *r =
     ++			reftable_calloc(sizeof(struct obj_record));
      +		record_from_obj(&rec, r);
      +		return rec;
      +	}
      +	case BLOCK_TYPE_LOG: {
     -+		struct log_record *r = calloc(1, sizeof(struct log_record));
     ++		struct reftable_log_record *r =
     ++			reftable_calloc(sizeof(struct reftable_log_record));
      +		record_from_log(&rec, r);
      +		return rec;
      +	}
      +	case BLOCK_TYPE_INDEX: {
     -+		struct index_record *r = calloc(1, sizeof(struct index_record));
     ++		struct index_record *r =
     ++			reftable_calloc(sizeof(struct index_record));
      +		record_from_index(&rec, r);
      +		return rec;
      +	}
     @@ -3560,7 +3660,7 @@
      +static void index_record_clear(void *rec)
      +{
      +	struct index_record *idx = (struct index_record *)rec;
     -+	free(slice_yield(&idx->last_key));
     ++	reftable_free(slice_yield(&idx->last_key));
      +}
      +
      +static byte index_record_val_type(const void *rec)
     @@ -3578,8 +3678,7 @@
      +		return n;
      +	}
      +
     -+	out.buf += n;
     -+	out.len -= n;
     ++	slice_consume(&out, n);
      +
      +	return start.len - out.len;
      +}
     @@ -3598,8 +3697,7 @@
      +		return n;
      +	}
      +
     -+	in.buf += n;
     -+	in.len -= n;
     ++	slice_consume(&in, n);
      +	return start.len - in.len;
      +}
      +
     @@ -3651,10 +3749,10 @@
      +	return rec.ops->clear(rec.data);
      +}
      +
     -+void record_from_ref(struct record *rec, struct ref_record *ref_rec)
     ++void record_from_ref(struct record *rec, struct reftable_ref_record *ref_rec)
      +{
      +	rec->data = ref_rec;
     -+	rec->ops = &ref_record_vtable;
     ++	rec->ops = &reftable_ref_record_vtable;
      +}
      +
      +void record_from_obj(struct record *rec, struct obj_record *obj_rec)
     @@ -3669,10 +3767,10 @@
      +	rec->ops = &index_record_vtable;
      +}
      +
     -+void record_from_log(struct record *rec, struct log_record *log_rec)
     ++void record_from_log(struct record *rec, struct reftable_log_record *log_rec)
      +{
      +	rec->data = log_rec;
     -+	rec->ops = &log_record_vtable;
     ++	rec->ops = &reftable_log_record_vtable;
      +}
      +
      +void *record_yield(struct record *rec)
     @@ -3682,10 +3780,10 @@
      +	return p;
      +}
      +
     -+struct ref_record *record_as_ref(struct record rec)
     ++struct reftable_ref_record *record_as_ref(struct record rec)
      +{
      +	assert(record_type(rec) == BLOCK_TYPE_REF);
     -+	return (struct ref_record *)rec.data;
     ++	return (struct reftable_ref_record *)rec.data;
      +}
      +
      +static bool hash_equal(byte *a, byte *b, int hash_size)
     @@ -3706,7 +3804,8 @@
      +	return a == b;
      +}
      +
     -+bool ref_record_equal(struct ref_record *a, struct ref_record *b, int hash_size)
     ++bool reftable_ref_record_equal(struct reftable_ref_record *a,
     ++			       struct reftable_ref_record *b, int hash_size)
      +{
      +	assert(hash_size > 0);
      +	return 0 == strcmp(a->ref_name, b->ref_name) &&
     @@ -3716,22 +3815,22 @@
      +	       str_equal(a->target, b->target);
      +}
      +
     -+int ref_record_compare_name(const void *a, const void *b)
     ++int reftable_ref_record_compare_name(const void *a, const void *b)
      +{
     -+	return strcmp(((struct ref_record *)a)->ref_name,
     -+		      ((struct ref_record *)b)->ref_name);
     ++	return strcmp(((struct reftable_ref_record *)a)->ref_name,
     ++		      ((struct reftable_ref_record *)b)->ref_name);
      +}
      +
     -+bool ref_record_is_deletion(const struct ref_record *ref)
     ++bool reftable_ref_record_is_deletion(const struct reftable_ref_record *ref)
      +{
      +	return ref->value == NULL && ref->target == NULL &&
      +	       ref->target_value == NULL;
      +}
      +
     -+int log_record_compare_key(const void *a, const void *b)
     ++int reftable_log_record_compare_key(const void *a, const void *b)
      +{
     -+	struct log_record *la = (struct log_record *)a;
     -+	struct log_record *lb = (struct log_record *)b;
     ++	struct reftable_log_record *la = (struct reftable_log_record *)a;
     ++	struct reftable_log_record *lb = (struct reftable_log_record *)b;
      +
      +	int cmp = strcmp(la->ref_name, lb->ref_name);
      +	if (cmp) {
     @@ -3743,10 +3842,12 @@
      +	return (la->update_index < lb->update_index) ? 1 : 0;
      +}
      +
     -+bool log_record_is_deletion(const struct log_record *log)
     ++bool reftable_log_record_is_deletion(const struct reftable_log_record *log)
      +{
     -+	/* XXX */
     -+	return false;
     ++	return (log->new_hash == NULL && log->old_hash == NULL &&
     ++		log->name == NULL && log->email == NULL &&
     ++		log->message == NULL && log->time == 0 && log->tz_offset == 0 &&
     ++		log->message == NULL);
      +}
      +
      +int hash_size(uint32_t id)
     @@ -3780,14 +3881,33 @@
      +#include "reftable.h"
      +#include "slice.h"
      +
     ++/* utilities for de/encoding varints */
     ++
     ++int get_var_int(uint64_t *dest, struct slice in);
     ++int put_var_int(struct slice dest, uint64_t val);
     ++
     ++/* Methods for records. */
      +struct record_vtable {
     ++	/* encode the key of to a byte slice. */
      +	void (*key)(const void *rec, struct slice *dest);
     ++
     ++	/* The record type of ('r' for ref). */
      +	byte (*type)(void);
     -+	void (*copy_from)(void *rec, const void *src, int hash_size);
     ++
     ++	void (*copy_from)(void *dest, const void *src, int hash_size);
     ++
     ++	/* a value of [0..7], indicating record subvariants (eg. ref vs. symref
     ++	 * vs ref deletion) */
      +	byte (*val_type)(const void *rec);
     ++
     ++	/* encodes rec into dest, returning how much space was used. */
      +	int (*encode)(const void *rec, struct slice dest, int hash_size);
     ++
     ++	/* decode data from `src` into the record. */
      +	int (*decode)(void *rec, struct slice key, byte extra, struct slice src,
      +		      int hash_size);
     ++
     ++	/* deallocate and null the record. */
      +	void (*clear)(void *rec);
      +};
      +
     @@ -3797,32 +3917,34 @@
      +	struct record_vtable *ops;
      +};
      +
     -+int get_var_int(uint64_t *dest, struct slice in);
     -+int put_var_int(struct slice dest, uint64_t val);
     -+int common_prefix_size(struct slice a, struct slice b);
     -+
      +int is_block_type(byte typ);
     ++
      +struct record new_record(byte typ);
      +
     -+extern struct record_vtable ref_record_vtable;
     ++extern struct record_vtable reftable_ref_record_vtable;
      +
      +int encode_key(bool *restart, struct slice dest, struct slice prev_key,
      +	       struct slice key, byte extra);
      +int decode_key(struct slice *key, byte *extra, struct slice last_key,
      +	       struct slice in);
      +
     ++/* index_record are used internally to speed up lookups. */
      +struct index_record {
     -+	uint64_t offset;
     -+	struct slice last_key;
     ++	uint64_t offset; /* Offset of block */
     ++	struct slice last_key; /* Last key of the block. */
      +};
      +
     ++/* obj_record stores an object ID => ref mapping. */
      +struct obj_record {
     -+	byte *hash_prefix;
     -+	int hash_prefix_len;
     -+	uint64_t *offsets;
     ++	byte *hash_prefix; /* leading bytes of the object ID */
     ++	int hash_prefix_len; /* number of leading bytes. Constant
     ++			      * across a single table. */
     ++	uint64_t *offsets; /* a vector of file offsets. */
      +	int offset_len;
      +};
      +
     ++/* see struct record_vtable */
     ++
      +void record_key(struct record rec, struct slice *dest);
      +byte record_type(struct record rec);
      +void record_copy_from(struct record rec, struct record src, int hash_size);
     @@ -3831,18 +3953,24 @@
      +int record_decode(struct record rec, struct slice key, byte extra,
      +		  struct slice src, int hash_size);
      +void record_clear(struct record rec);
     ++
     ++/* clear out the record, yielding the record data that was encapsulated. */
      +void *record_yield(struct record *rec);
     ++
     ++/* initialize generic records from concrete records. The generic record should
     ++ * be zeroed out. */
     ++
      +void record_from_obj(struct record *rec, struct obj_record *objrec);
      +void record_from_index(struct record *rec, struct index_record *idxrec);
     -+void record_from_ref(struct record *rec, struct ref_record *refrec);
     -+void record_from_log(struct record *rec, struct log_record *logrec);
     -+struct ref_record *record_as_ref(struct record ref);
     ++void record_from_ref(struct record *rec, struct reftable_ref_record *refrec);
     ++void record_from_log(struct record *rec, struct reftable_log_record *logrec);
     ++struct reftable_ref_record *record_as_ref(struct record ref);
      +
      +/* for qsort. */
     -+int ref_record_compare_name(const void *a, const void *b);
     ++int reftable_ref_record_compare_name(const void *a, const void *b);
      +
      +/* for qsort. */
     -+int log_record_compare_key(const void *a, const void *b);
     ++int reftable_log_record_compare_key(const void *a, const void *b);
      +
      +#endif
      
     @@ -3863,65 +3991,20 @@
      +#define REFTABLE_H
      +
      +#include <stdint.h>
     ++#include <stddef.h>
      +
     -+/* block_source is a generic wrapper for a seekable readable file.
     -+   It is generally passed around by value.
     -+ */
     -+struct block_source {
     -+	struct block_source_vtable *ops;
     -+	void *arg;
     -+};
     ++void reftable_set_alloc(void *(*malloc)(size_t),
     ++			void *(*realloc)(void *, size_t), void (*free)(void *));
      +
     -+/* a contiguous segment of bytes. It keeps track of its generating block_source
     -+   so it can return itself into the pool.
     -+*/
     -+struct block {
     -+	uint8_t *data;
     -+	int len;
     -+	struct block_source source;
     -+};
     ++/****************************************************************
     ++ Basic data types
      +
     -+/* block_source_vtable are the operations that make up block_source */
     -+struct block_source_vtable {
     -+	/* returns the size of a block source */
     -+	uint64_t (*size)(void *source);
     ++ Reftables store the state of each ref in struct reftable_ref_record, and they
     ++ store a sequence of reflog updates in struct reftable_log_record.
     ++ ****************************************************************/
      +
     -+	/* reads a segment from the block source. It is an error to read
     -+	   beyond the end of the block */
     -+	int (*read_block)(void *source, struct block *dest, uint64_t off,
     -+			  uint32_t size);
     -+	/* mark the block as read; may return the data back to malloc */
     -+	void (*return_block)(void *source, struct block *blockp);
     -+
     -+	/* release all resources associated with the block source */
     -+	void (*close)(void *source);
     -+};
     -+
     -+/* opens a file on the file system as a block_source */
     -+int block_source_from_file(struct block_source *block_src, const char *name);
     -+
     -+/* write_options sets options for writing a single reftable. */
     -+struct write_options {
     -+	/* boolean: do not pad out blocks to block size. */
     -+	int unpadded;
     -+
     -+	/* the blocksize. Should be less than 2^24. */
     -+	uint32_t block_size;
     -+
     -+	/* boolean: do not generate a SHA1 => ref index. */
     -+	int skip_index_objects;
     -+
     -+	/* how often to write complete keys in each block. */
     -+	int restart_interval;
     -+
     -+	/* 4-byte identifier ("sha1", "s256") of the hash.
     -+	 * Defaults to SHA1 if unset
     -+	 */
     -+	uint32_t hash_id;
     -+};
     -+
     -+/* ref_record holds a ref database entry target_value */
     -+struct ref_record {
     ++/* reftable_ref_record holds a ref database entry target_value */
     ++struct reftable_ref_record {
      +	char *ref_name; /* Name of the ref, malloced. */
      +	uint64_t update_index; /* Logical timestamp at which this value is
      +				  written */
     @@ -3931,21 +4014,23 @@
      +};
      +
      +/* returns whether 'ref' represents a deletion */
     -+int ref_record_is_deletion(const struct ref_record *ref);
     ++int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
      +
     -+/* prints a ref_record onto stdout */
     -+void ref_record_print(struct ref_record *ref, int hash_size);
     ++/* prints a reftable_ref_record onto stdout */
     ++void reftable_ref_record_print(struct reftable_ref_record *ref, int hash_size);
      +
      +/* frees and nulls all pointer values. */
     -+void ref_record_clear(struct ref_record *ref);
     ++void reftable_ref_record_clear(struct reftable_ref_record *ref);
      +
     -+/* returns whether two ref_records are the same */
     -+int ref_record_equal(struct ref_record *a, struct ref_record *b, int hash_size);
     ++/* returns whether two reftable_ref_records are the same */
     ++int reftable_ref_record_equal(struct reftable_ref_record *a,
     ++			      struct reftable_ref_record *b, int hash_size);
      +
     -+/* log_record holds a reflog entry */
     -+struct log_record {
     ++/* reftable_log_record holds a reflog entry */
     ++struct reftable_log_record {
      +	char *ref_name;
     -+	uint64_t update_index;
     ++	uint64_t update_index; /* logical timestamp of a transactional update.
     ++				*/
      +	uint8_t *new_hash;
      +	uint8_t *old_hash;
      +	char *name;
     @@ -3956,39 +4041,88 @@
      +};
      +
      +/* returns whether 'ref' represents the deletion of a log record. */
     -+int log_record_is_deletion(const struct log_record *log);
     ++int reftable_log_record_is_deletion(const struct reftable_log_record *log);
      +
      +/* frees and nulls all pointer values. */
     -+void log_record_clear(struct log_record *log);
     ++void reftable_log_record_clear(struct reftable_log_record *log);
      +
      +/* returns whether two records are equal. */
     -+int log_record_equal(struct log_record *a, struct log_record *b, int hash_size);
     ++int reftable_log_record_equal(struct reftable_log_record *a,
     ++			      struct reftable_log_record *b, int hash_size);
      +
     -+void log_record_print(struct log_record *log, int hash_size);
     ++/* dumps a reftable_log_record on stdout, for debugging/testing. */
     ++void reftable_log_record_print(struct reftable_log_record *log, int hash_size);
      +
     -+/* iterator is the generic interface for walking over data stored in a
     -+   reftable. It is generally passed around by value.
     -+*/
     -+struct iterator {
     -+	struct iterator_vtable *ops;
     -+	void *iter_arg;
     ++/****************************************************************
     ++ Error handling
     ++
     ++ Error are signaled with negative integer return values. 0 means success.
     ++ ****************************************************************/
     ++
     ++/* different types of errors */
     ++enum reftable_error {
     ++	/* Unexpected file system behavior */
     ++	IO_ERROR = -2,
     ++
     ++	/* Format inconsistency on reading data
     ++	 */
     ++	FORMAT_ERROR = -3,
     ++
     ++	/* File does not exist. Returned from block_source_from_file(),  because
     ++	   it needs special handling in stack.
     ++	*/
     ++	NOT_EXIST_ERROR = -4,
     ++
     ++	/* Trying to write out-of-date data. */
     ++	LOCK_ERROR = -5,
     ++
     ++	/* Misuse of the API:
     ++	   - on writing a record with NULL ref_name.
     ++	   - on writing a reftable_ref_record outside the table limits
     ++	   - on writing a ref or log record before the stack's next_update_index
     ++	   - on reading a reftable_ref_record from log iterator, or vice versa.
     ++	*/
     ++	API_ERROR = -6,
     ++
     ++	/* Decompression error */
     ++	ZLIB_ERROR = -7,
     ++
     ++	/* Wrote a table without blocks. */
     ++	EMPTY_TABLE_ERROR = -8,
      +};
      +
     -+/* reads the next ref_record. Returns < 0 for error, 0 for OK and > 0:
     -+   end of iteration.
     -+*/
     -+int iterator_next_ref(struct iterator it, struct ref_record *ref);
     ++/* convert the numeric error code to a string. The string should not be
     ++ * deallocated. */
     ++const char *reftable_error_str(int err);
      +
     -+/* reads the next log_record. Returns < 0 for error, 0 for OK and > 0:
     -+   end of iteration.
     -+*/
     -+int iterator_next_log(struct iterator it, struct log_record *log);
     ++/****************************************************************
     ++ Writing
      +
     -+/* releases resources associated with an iterator. */
     -+void iterator_destroy(struct iterator *it);
     ++ Writing single reftables
     ++ ****************************************************************/
     ++
     ++/* reftable_write_options sets options for writing a single reftable. */
     ++struct reftable_write_options {
     ++	/* boolean: do not pad out blocks to block size. */
     ++	int unpadded;
     ++
     ++	/* the blocksize. Should be less than 2^24. */
     ++	uint32_t block_size;
      +
     -+/* block_stats holds statistics for a single block type */
     -+struct block_stats {
     ++	/* boolean: do not generate a SHA1 => ref index. */
     ++	int skip_index_objects;
     ++
     ++	/* how often to write complete keys in each block. */
     ++	int restart_interval;
     ++
     ++	/* 4-byte identifier ("sha1", "s256") of the hash.
     ++	 * Defaults to SHA1 if unset
     ++	 */
     ++	uint32_t hash_id;
     ++};
     ++
     ++/* reftable_block_stats holds statistics for a single block type */
     ++struct reftable_block_stats {
      +	/* total number of entries written */
      +	int entries;
      +	/* total number of key restarts */
     @@ -4008,119 +4142,175 @@
      +};
      +
      +/* stats holds overall statistics for a single reftable */
     -+struct stats {
     ++struct reftable_stats {
      +	/* total number of blocks written. */
      +	int blocks;
      +	/* stats for ref data */
     -+	struct block_stats ref_stats;
     ++	struct reftable_block_stats ref_stats;
      +	/* stats for the SHA1 to ref map. */
     -+	struct block_stats obj_stats;
     ++	struct reftable_block_stats obj_stats;
      +	/* stats for index blocks */
     -+	struct block_stats idx_stats;
     ++	struct reftable_block_stats idx_stats;
      +	/* stats for log blocks */
     -+	struct block_stats log_stats;
     ++	struct reftable_block_stats log_stats;
      +
      +	/* disambiguation length of shortened object IDs. */
      +	int object_id_len;
      +};
      +
     -+/* different types of errors */
     -+
     -+/* Unexpected file system behavior */
     -+#define IO_ERROR -2
     -+
     -+/* Format inconsistency on reading data
     -+ */
     -+#define FORMAT_ERROR -3
     -+
     -+/* File does not exist. Returned from block_source_from_file(),  because it
     -+   needs special handling in stack.
     -+*/
     -+#define NOT_EXIST_ERROR -4
     -+
     -+/* Trying to write out-of-date data. */
     -+#define LOCK_ERROR -5
     -+
     -+/* Misuse of the API:
     -+   - on writing a record with NULL ref_name.
     -+   - on writing a ref_record outside the table limits
     -+   - on writing a ref or log record before the stack's next_update_index
     -+   - on reading a ref_record from log iterator, or vice versa.
     -+ */
     -+#define API_ERROR -6
     -+
     -+/* Decompression error */
     -+#define ZLIB_ERROR -7
     -+
     -+/* Wrote a table without blocks. */
     -+#define EMPTY_TABLE_ERROR -8
     -+
     -+const char *error_str(int err);
     -+
     -+/* new_writer creates a new writer */
     -+struct writer *new_writer(int (*writer_func)(void *, uint8_t *, int),
     -+			  void *writer_arg, struct write_options *opts);
     ++/* reftable_new_writer creates a new writer */
     ++struct reftable_writer *
     ++reftable_new_writer(int (*writer_func)(void *, uint8_t *, int),
     ++		    void *writer_arg, struct reftable_write_options *opts);
      +
      +/* write to a file descriptor. fdp should be an int* pointing to the fd. */
     -+int fd_writer(void *fdp, uint8_t *data, int size);
     ++int reftable_fd_write(void *fdp, uint8_t *data, int size);
      +
      +/* Set the range of update indices for the records we will add.  When
      +   writing a table into a stack, the min should be at least
     -+   stack_next_update_index(), or API_ERROR is returned.
     ++   reftable_stack_next_update_index(), or API_ERROR is returned.
     ++
     ++   For transactional updates, typically min==max. When converting an existing
     ++   ref database into a single reftable, this would be a range of update-index
     ++   timestamps.
      + */
     -+void writer_set_limits(struct writer *w, uint64_t min, uint64_t max);
     ++void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
     ++				uint64_t max);
      +
     -+/* adds a ref_record. Must be called in ascending
     ++/* adds a reftable_ref_record. Must be called in ascending
      +   order. The update_index must be within the limits set by
     -+   writer_set_limits(), or API_ERROR is returned.
     ++   reftable_writer_set_limits(), or API_ERROR is returned.
     ++
     ++   It is an error to write a ref record after a log record.
      + */
     -+int writer_add_ref(struct writer *w, struct ref_record *ref);
     ++int reftable_writer_add_ref(struct reftable_writer *w,
     ++			    struct reftable_ref_record *ref);
      +
      +/* Convenience function to add multiple refs. Will sort the refs by
      +   name before adding. */
     -+int writer_add_refs(struct writer *w, struct ref_record *refs, int n);
     ++int reftable_writer_add_refs(struct reftable_writer *w,
     ++			     struct reftable_ref_record *refs, int n);
      +
     -+/* adds a log_record. Must be called in ascending order (with more
     ++/* adds a reftable_log_record. Must be called in ascending order (with more
      +   recent log entries first.)
      + */
     -+int writer_add_log(struct writer *w, struct log_record *log);
     ++int reftable_writer_add_log(struct reftable_writer *w,
     ++			    struct reftable_log_record *log);
      +
      +/* Convenience function to add multiple logs. Will sort the records by
      +   key before adding. */
     -+int writer_add_logs(struct writer *w, struct log_record *logs, int n);
     ++int reftable_writer_add_logs(struct reftable_writer *w,
     ++			     struct reftable_log_record *logs, int n);
     ++
     ++/* reftable_writer_close finalizes the reftable. The writer is retained so
     ++ * statistics can be inspected. */
     ++int reftable_writer_close(struct reftable_writer *w);
     ++
     ++/* writer_stats returns the statistics on the reftable being written.
     ++
     ++   This struct becomes invalid when the writer is freed.
     ++ */
     ++const struct reftable_stats *writer_stats(struct reftable_writer *w);
     ++
     ++/* reftable_writer_free deallocates memory for the writer */
     ++void reftable_writer_free(struct reftable_writer *w);
     ++
     ++/****************************************************************
     ++ * ITERATING
     ++ ****************************************************************/
      +
     -+/* writer_close finalizes the reftable. The writer is retained so statistics can
     -+ * be inspected. */
     -+int writer_close(struct writer *w);
     ++/* iterator is the generic interface for walking over data stored in a
     ++   reftable. It is generally passed around by value.
     ++*/
     ++struct reftable_iterator {
     ++	struct reftable_iterator_vtable *ops;
     ++	void *iter_arg;
     ++};
      +
     -+/* writer_stats returns the statistics on the reftable being written. */
     -+struct stats *writer_stats(struct writer *w);
     ++/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
     ++   end of iteration.
     ++*/
     ++int reftable_iterator_next_ref(struct reftable_iterator it,
     ++			       struct reftable_ref_record *ref);
      +
     -+/* writer_free deallocates memory for the writer */
     -+void writer_free(struct writer *w);
     ++/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
     ++   end of iteration.
     ++*/
     ++int reftable_iterator_next_log(struct reftable_iterator it,
     ++			       struct reftable_log_record *log);
      +
     -+struct reader;
     ++/* releases resources associated with an iterator. */
     ++void reftable_iterator_destroy(struct reftable_iterator *it);
     ++
     ++/****************************************************************
     ++ Reading single tables
      +
     -+/* new_reader opens a reftable for reading. If successful, returns 0
     ++ The follow routines are for reading single files. For an application-level
     ++ interface, skip ahead to struct reftable_merged_table and struct
     ++ reftable_stack.
     ++ ****************************************************************/
     ++
     ++/* block_source is a generic wrapper for a seekable readable file.
     ++   It is generally passed around by value.
     ++ */
     ++struct reftable_block_source {
     ++	struct reftable_block_source_vtable *ops;
     ++	void *arg;
     ++};
     ++
     ++/* a contiguous segment of bytes. It keeps track of its generating block_source
     ++   so it can return itself into the pool.
     ++*/
     ++struct reftable_block {
     ++	uint8_t *data;
     ++	int len;
     ++	struct reftable_block_source source;
     ++};
     ++
     ++/* block_source_vtable are the operations that make up block_source */
     ++struct reftable_block_source_vtable {
     ++	/* returns the size of a block source */
     ++	uint64_t (*size)(void *source);
     ++
     ++	/* reads a segment from the block source. It is an error to read
     ++	   beyond the end of the block */
     ++	int (*read_block)(void *source, struct reftable_block *dest,
     ++			  uint64_t off, uint32_t size);
     ++	/* mark the block as read; may return the data back to malloc */
     ++	void (*return_block)(void *source, struct reftable_block *blockp);
     ++
     ++	/* release all resources associated with the block source */
     ++	void (*close)(void *source);
     ++};
     ++
     ++/* opens a file on the file system as a block_source */
     ++int reftable_block_source_from_file(struct reftable_block_source *block_src,
     ++				    const char *name);
     ++
     ++/* The reader struct is a handle to an open reftable file. */
     ++struct reftable_reader;
     ++
     ++/* reftable_new_reader opens a reftable for reading. If successful, returns 0
      + * code and sets pp.  The name is used for creating a
      + * stack. Typically, it is the basename of the file.
      + */
     -+int new_reader(struct reader **pp, struct block_source, const char *name);
     ++int reftable_new_reader(struct reftable_reader **pp,
     ++			struct reftable_block_source, const char *name);
      +
     -+/* reader_seek_ref returns an iterator where 'name' would be inserted in the
     -+   table.
     ++/* reftable_reader_seek_ref returns an iterator where 'name' would be inserted
     ++   in the table.  To seek to the start of the table, use name = "".
      +
      +   example:
      +
     -+   struct reader *r = NULL;
     -+   int err = new_reader(&r, src, "filename");
     ++   struct reftable_reader *r = NULL;
     ++   int err = reftable_new_reader(&r, src, "filename");
      +   if (err < 0) { ... }
     -+   struct iterator it  = {0};
     -+   err = reader_seek_ref(r, &it, "refs/heads/master");
     ++   struct reftable_iterator it  = {0};
     ++   err = reftable_reader_seek_ref(r, &it, "refs/heads/master");
      +   if (err < 0) { ... }
     -+   struct ref_record ref  = {0};
     ++   struct reftable_ref_record ref  = {0};
      +   while (1) {
     -+     err = iterator_next_ref(it, &ref);
     ++     err = reftable_iterator_next_ref(it, &ref);
      +     if (err > 0) {
      +       break;
      +     }
     @@ -4129,103 +4319,149 @@
      +     }
      +     ..found..
      +   }
     -+   iterator_destroy(&it);
     -+   ref_record_clear(&ref);
     ++   reftable_iterator_destroy(&it);
     ++   reftable_ref_record_clear(&ref);
      + */
     -+int reader_seek_ref(struct reader *r, struct iterator *it, const char *name);
     ++int reftable_reader_seek_ref(struct reftable_reader *r,
     ++			     struct reftable_iterator *it, const char *name);
      +
      +/* returns the hash ID used in this table. */
     -+uint32_t reader_hash_id(struct reader *r);
     ++uint32_t reftable_reader_hash_id(struct reftable_reader *r);
      +
     -+/* seek to logs for the given name, older than update_index. */
     -+int reader_seek_log_at(struct reader *r, struct iterator *it, const char *name,
     -+		       uint64_t update_index);
     ++/* seek to logs for the given name, older than update_index. To seek to the
     ++   start of the table, use name = "".
     ++ */
     ++int reftable_reader_seek_log_at(struct reftable_reader *r,
     ++				struct reftable_iterator *it, const char *name,
     ++				uint64_t update_index);
      +
      +/* seek to newest log entry for given name. */
     -+int reader_seek_log(struct reader *r, struct iterator *it, const char *name);
     ++int reftable_reader_seek_log(struct reftable_reader *r,
     ++			     struct reftable_iterator *it, const char *name);
      +
      +/* closes and deallocates a reader. */
     -+void reader_free(struct reader *);
     ++void reftable_reader_free(struct reftable_reader *);
      +
      +/* return an iterator for the refs pointing to oid */
     -+int reader_refs_for(struct reader *r, struct iterator *it, uint8_t *oid,
     -+		    int oid_len);
     ++int reftable_reader_refs_for(struct reftable_reader *r,
     ++			     struct reftable_iterator *it, uint8_t *oid,
     ++			     int oid_len);
      +
      +/* return the max_update_index for a table */
     -+uint64_t reader_max_update_index(struct reader *r);
     ++uint64_t reftable_reader_max_update_index(struct reftable_reader *r);
      +
      +/* return the min_update_index for a table */
     -+uint64_t reader_min_update_index(struct reader *r);
     ++uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
     ++
     ++/****************************************************************
     ++ Merged tables
      +
     -+/* a merged table is implements seeking/iterating over a stack of tables. */
     -+struct merged_table;
     ++ A ref database kept in a sequence of table files. The merged_table presents a
     ++ unified view to reading (seeking, iterating) a sequence of immutable tables.
     ++ ****************************************************************/
      +
     -+/* new_merged_table creates a new merged table. It takes ownership of the stack
     -+   array.
     ++/* A merged table is implements seeking/iterating over a stack of tables. */
     ++struct reftable_merged_table;
     ++
     ++/* reftable_new_merged_table creates a new merged table. It takes ownership of
     ++   the stack array.
      +*/
     -+int new_merged_table(struct merged_table **dest, struct reader **stack, int n,
     -+		     uint32_t hash_id);
     ++int reftable_new_merged_table(struct reftable_merged_table **dest,
     ++			      struct reftable_reader **stack, int n,
     ++			      uint32_t hash_id);
      +
      +/* returns the hash id used in this merged table. */
     -+uint32_t merged_hash_id(struct merged_table *mt);
     ++uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt);
      +
      +/* returns an iterator positioned just before 'name' */
     -+int merged_table_seek_ref(struct merged_table *mt, struct iterator *it,
     -+			  const char *name);
     ++int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
     ++				   struct reftable_iterator *it,
     ++				   const char *name);
      +
      +/* returns an iterator for log entry, at given update_index */
     -+int merged_table_seek_log_at(struct merged_table *mt, struct iterator *it,
     -+			     const char *name, uint64_t update_index);
     ++int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
     ++				      struct reftable_iterator *it,
     ++				      const char *name, uint64_t update_index);
      +
     -+/* like merged_table_seek_log_at but look for the newest entry. */
     -+int merged_table_seek_log(struct merged_table *mt, struct iterator *it,
     -+			  const char *name);
     ++/* like reftable_merged_table_seek_log_at but look for the newest entry. */
     ++int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
     ++				   struct reftable_iterator *it,
     ++				   const char *name);
      +
      +/* returns the max update_index covered by this merged table. */
     -+uint64_t merged_max_update_index(struct merged_table *mt);
     ++uint64_t
     ++reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
      +
      +/* returns the min update_index covered by this merged table. */
     -+uint64_t merged_min_update_index(struct merged_table *mt);
     ++uint64_t
     ++reftable_merged_table_min_update_index(struct reftable_merged_table *mt);
      +
      +/* closes readers for the merged tables */
     -+void merged_table_close(struct merged_table *mt);
     ++void reftable_merged_table_close(struct reftable_merged_table *mt);
      +
      +/* releases memory for the merged_table */
     -+void merged_table_free(struct merged_table *m);
     ++void reftable_merged_table_free(struct reftable_merged_table *m);
     ++
     ++/****************************************************************
     ++ Mutable ref database
     ++
     ++ The stack presents an interface to a mutable sequence of reftables.
     ++ ****************************************************************/
      +
      +/* a stack is a stack of reftables, which can be mutated by pushing a table to
      + * the top of the stack */
     -+struct stack;
     ++struct reftable_stack;
      +
     -+/* open a new reftable stack. The tables will be stored in 'dir', while the list
     -+   of tables is in 'list_file'. Typically, this should be .git/reftables and
     -+   .git/refs respectively.
     ++/* open a new reftable stack. The tables along with the table list will be
     ++   stored in 'dir'. Typically, this should be .git/reftables.
      +*/
     -+int new_stack(struct stack **dest, const char *dir, const char *list_file,
     -+	      struct write_options config);
     ++int reftable_new_stack(struct reftable_stack **dest, const char *dir,
     ++		       struct reftable_write_options config);
      +
      +/* returns the update_index at which a next table should be written. */
     -+uint64_t stack_next_update_index(struct stack *st);
     ++uint64_t reftable_stack_next_update_index(struct reftable_stack *st);
     ++
     ++/* holds a transaction to add tables at the top of a stack. */
     ++struct reftable_addition;
     ++
     ++/*
     ++  returns a new transaction to add reftables to the given stack. As a side
     ++  effect, the ref database is locked.
     ++*/ 
     ++int reftable_stack_new_addition(struct reftable_addition **dest, struct reftable_stack *st);
     ++
     ++/* Adds a reftable to transaction. */ 
     ++int reftable_addition_add(struct reftable_addition *add,
     ++                          int (*write_table)(struct reftable_writer *wr, void *arg),
     ++                          void *arg);
     ++
     ++/* Commits the transaction, releasing the lock. */
     ++int reftable_addition_commit(struct reftable_addition *add);
     ++
     ++/* Release all non-committed data from the transaction; releases the lock if held. */
     ++void reftable_addition_close(struct reftable_addition *add);
      +
      +/* add a new table to the stack. The write_table function must call
     -+   writer_set_limits, add refs and return an error value. */
     -+int stack_add(struct stack *st,
     -+	      int (*write_table)(struct writer *wr, void *write_arg),
     -+	      void *write_arg);
     ++   reftable_writer_set_limits, add refs and return an error value. */
     ++int reftable_stack_add(struct reftable_stack *st,
     ++		       int (*write_table)(struct reftable_writer *wr,
     ++					  void *write_arg),
     ++		       void *write_arg);
      +
      +/* returns the merged_table for seeking. This table is valid until the
      +   next write or reload, and should not be closed or deleted.
      +*/
     -+struct merged_table *stack_merged_table(struct stack *st);
     ++struct reftable_merged_table *
     ++reftable_stack_merged_table(struct reftable_stack *st);
      +
      +/* frees all resources associated with the stack. */
     -+void stack_destroy(struct stack *st);
     ++void reftable_stack_destroy(struct reftable_stack *st);
      +
      +/* reloads the stack if necessary. */
     -+int stack_reload(struct stack *st);
     ++int reftable_stack_reload(struct reftable_stack *st);
      +
      +/* Policy for expiring reflog entries. */
     -+struct log_expiry_config {
     ++struct reftable_log_expiry_config {
      +	/* Drop entries older than this timestamp */
      +	uint64_t time;
      +
     @@ -4235,29 +4471,32 @@
      +
      +/* compacts all reftables into a giant table. Expire reflog entries if config is
      + * non-NULL */
     -+int stack_compact_all(struct stack *st, struct log_expiry_config *config);
     ++int reftable_stack_compact_all(struct reftable_stack *st,
     ++			       struct reftable_log_expiry_config *config);
      +
      +/* heuristically compact unbalanced table stack. */
     -+int stack_auto_compact(struct stack *st);
     ++int reftable_stack_auto_compact(struct reftable_stack *st);
      +
      +/* convenience function to read a single ref. Returns < 0 for error, 0
      +   for success, and 1 if ref not found. */
     -+int stack_read_ref(struct stack *st, const char *refname,
     -+		   struct ref_record *ref);
     ++int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
     ++			    struct reftable_ref_record *ref);
      +
      +/* convenience function to read a single log. Returns < 0 for error, 0
      +   for success, and 1 if ref not found. */
     -+int stack_read_log(struct stack *st, const char *refname,
     -+		   struct log_record *log);
     ++int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
     ++			    struct reftable_log_record *log);
      +
      +/* statistics on past compactions. */
     -+struct compaction_stats {
     -+	uint64_t bytes;
     -+	int attempts;
     -+	int failures;
     ++struct reftable_compaction_stats {
     ++	uint64_t bytes; /* total number of bytes written */
     ++	int attempts; /* how often we tried to compact */
     ++	int failures; /* failures happen on concurrent updates */
      +};
      +
     -+struct compaction_stats *stack_compaction_stats(struct stack *st);
     ++/* return statistics for compaction up till now. */
     ++struct reftable_compaction_stats *
     ++reftable_stack_compaction_stats(struct reftable_stack *st);
      +
      +#endif
      
     @@ -4304,7 +4543,7 @@
      +			c = l;
      +		}
      +		s->cap = c;
     -+		s->buf = realloc(s->buf, s->cap);
     ++		s->buf = reftable_realloc(s->buf, s->cap);
      +	}
      +	s->len = l;
      +}
     @@ -4325,6 +4564,12 @@
      +	memcpy(s->buf + end, a.buf, a.len);
      +}
      +
     ++void slice_consume(struct slice *s, int n)
     ++{
     ++	s->buf += n;
     ++	s->len -= n;
     ++}
     ++
      +byte *slice_yield(struct slice *s)
      +{
      +	byte *p = s->buf;
     @@ -4394,7 +4639,7 @@
      +		if (newcap < b->len + sz) {
      +			newcap = (b->len + sz);
      +		}
     -+		b->buf = realloc(b->buf, newcap);
     ++		b->buf = reftable_realloc(b->buf, newcap);
      +		b->cap = newcap;
      +	}
      +
     @@ -4413,57 +4658,71 @@
      +	return ((struct slice *)b)->len;
      +}
      +
     -+static void slice_return_block(void *b, struct block *dest)
     ++static void slice_return_block(void *b, struct reftable_block *dest)
      +{
      +	memset(dest->data, 0xff, dest->len);
     -+	free(dest->data);
     ++	reftable_free(dest->data);
      +}
      +
      +static void slice_close(void *b)
      +{
      +}
      +
     -+static int slice_read_block(void *v, struct block *dest, uint64_t off,
     ++static int slice_read_block(void *v, struct reftable_block *dest, uint64_t off,
      +			    uint32_t size)
      +{
      +	struct slice *b = (struct slice *)v;
      +	assert(off + size <= b->len);
     -+	dest->data = calloc(size, 1);
     ++	dest->data = reftable_calloc(size);
      +	memcpy(dest->data, b->buf + off, size);
      +	dest->len = size;
      +	return size;
      +}
      +
     -+struct block_source_vtable slice_vtable = {
     ++struct reftable_block_source_vtable slice_vtable = {
      +	.size = &slice_size,
      +	.read_block = &slice_read_block,
      +	.return_block = &slice_return_block,
      +	.close = &slice_close,
      +};
      +
     -+void block_source_from_slice(struct block_source *bs, struct slice *buf)
     ++void block_source_from_slice(struct reftable_block_source *bs,
     ++			     struct slice *buf)
      +{
      +	bs->ops = &slice_vtable;
      +	bs->arg = buf;
      +}
      +
     -+static void malloc_return_block(void *b, struct block *dest)
     ++static void malloc_return_block(void *b, struct reftable_block *dest)
      +{
      +	memset(dest->data, 0xff, dest->len);
     -+	free(dest->data);
     ++	reftable_free(dest->data);
      +}
      +
     -+struct block_source_vtable malloc_vtable = {
     ++struct reftable_block_source_vtable malloc_vtable = {
      +	.return_block = &malloc_return_block,
      +};
      +
     -+struct block_source malloc_block_source_instance = {
     ++struct reftable_block_source malloc_block_source_instance = {
      +	.ops = &malloc_vtable,
      +};
      +
     -+struct block_source malloc_block_source(void)
     ++struct reftable_block_source malloc_block_source(void)
      +{
      +	return malloc_block_source_instance;
     ++}
     ++
     ++int common_prefix_size(struct slice a, struct slice b)
     ++{
     ++	int p = 0;
     ++	while (p < a.len && p < b.len) {
     ++		if (a.buf[p] != b.buf[p]) {
     ++			break;
     ++		}
     ++		p++;
     ++	}
     ++
     ++	return p;
      +}
      
       diff --git a/reftable/slice.h b/reftable/slice.h
     @@ -4498,16 +4757,19 @@
      +bool slice_equal(struct slice a, struct slice b);
      +byte *slice_yield(struct slice *s);
      +void slice_copy(struct slice *dest, struct slice src);
     ++void slice_consume(struct slice *s, int n);
      +void slice_resize(struct slice *s, int l);
      +int slice_compare(struct slice a, struct slice b);
      +int slice_write(struct slice *b, byte *data, int sz);
      +int slice_write_void(void *b, byte *data, int sz);
      +void slice_append(struct slice *dest, struct slice add);
     ++int common_prefix_size(struct slice a, struct slice b);
      +
     -+struct block_source;
     -+void block_source_from_slice(struct block_source *bs, struct slice *buf);
     ++struct reftable_block_source;
     ++void block_source_from_slice(struct reftable_block_source *bs,
     ++			     struct slice *buf);
      +
     -+struct block_source malloc_block_source(void);
     ++struct reftable_block_source malloc_block_source(void);
      +
      +#endif
      
     @@ -4532,19 +4794,26 @@
      +#include "reftable.h"
      +#include "writer.h"
      +
     -+int new_stack(struct stack **dest, const char *dir, const char *list_file,
     -+	      struct write_options config)
     ++int reftable_new_stack(struct reftable_stack **dest, const char *dir,
     ++		       struct reftable_write_options config)
      +{
     -+	struct stack *p = calloc(sizeof(struct stack), 1);
     ++	struct reftable_stack *p =
     ++		reftable_calloc(sizeof(struct reftable_stack));
     ++	struct slice list_file_name = {};
      +	int err = 0;
      +	*dest = NULL;
     -+	p->list_file = xstrdup(list_file);
     ++
     ++	slice_set_string(&list_file_name, dir);
     ++	slice_append_string(&list_file_name, "/reftables.list");
     ++
     ++	p->list_file = slice_to_string(list_file_name);
     ++	reftable_free(slice_yield(&list_file_name));
      +	p->reftable_dir = xstrdup(dir);
      +	p->config = config;
      +
     -+	err = stack_reload(p);
     ++	err = reftable_stack_reload(p);
      +	if (err < 0) {
     -+		stack_destroy(p);
     ++		reftable_stack_destroy(p);
      +	} else {
      +		*dest = p;
      +	}
     @@ -4571,7 +4840,7 @@
      +		goto exit;
      +	}
      +
     -+	buf = malloc(size + 1);
     ++	buf = reftable_malloc(size + 1);
      +	if (fread(buf, 1, size, f) != size) {
      +		err = IO_ERROR;
      +		goto exit;
     @@ -4580,7 +4849,7 @@
      +
      +	parse_names(buf, size, namesp);
      +exit:
     -+	free(buf);
     ++	reftable_free(buf);
      +	return err;
      +}
      +
     @@ -4590,7 +4859,7 @@
      +	int err = 0;
      +	if (f == NULL) {
      +		if (errno == ENOENT) {
     -+			*namesp = calloc(sizeof(char *), 1);
     ++			*namesp = reftable_calloc(sizeof(char *));
      +			return 0;
      +		}
      +
     @@ -4601,30 +4870,33 @@
      +	return err;
      +}
      +
     -+struct merged_table *stack_merged_table(struct stack *st)
     ++struct reftable_merged_table *
     ++reftable_stack_merged_table(struct reftable_stack *st)
      +{
      +	return st->merged;
      +}
      +
      +/* Close and free the stack */
     -+void stack_destroy(struct stack *st)
     ++void reftable_stack_destroy(struct reftable_stack *st)
      +{
      +	if (st->merged == NULL) {
      +		return;
      +	}
      +
     -+	merged_table_close(st->merged);
     -+	merged_table_free(st->merged);
     ++	reftable_merged_table_close(st->merged);
     ++	reftable_merged_table_free(st->merged);
      +	st->merged = NULL;
      +
      +	FREE_AND_NULL(st->list_file);
      +	FREE_AND_NULL(st->reftable_dir);
     -+	free(st);
     ++	reftable_free(st);
      +}
      +
     -+static struct reader **stack_copy_readers(struct stack *st, int cur_len)
     ++static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
     ++						   int cur_len)
      +{
     -+	struct reader **cur = calloc(sizeof(struct reader *), cur_len);
     ++	struct reftable_reader **cur =
     ++		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
      +	int i = 0;
      +	for (i = 0; i < cur_len; i++) {
      +		cur[i] = st->merged->stack[i];
     @@ -4632,21 +4904,22 @@
      +	return cur;
      +}
      +
     -+static int stack_reload_once(struct stack *st, char **names, bool reuse_open)
     ++static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
     ++				      bool reuse_open)
      +{
      +	int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
     -+	struct reader **cur = stack_copy_readers(st, cur_len);
     ++	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
      +	int err = 0;
      +	int names_len = names_length(names);
     -+	struct reader **new_tables =
     -+		malloc(sizeof(struct reader *) * names_len);
     ++	struct reftable_reader **new_tables =
     ++		reftable_malloc(sizeof(struct reftable_reader *) * names_len);
      +	int new_tables_len = 0;
     -+	struct merged_table *new_merged = NULL;
     ++	struct reftable_merged_table *new_merged = NULL;
      +
      +	struct slice table_path = { 0 };
      +
      +	while (*names) {
     -+		struct reader *rd = NULL;
     ++		struct reftable_reader *rd = NULL;
      +		char *name = *names++;
      +
      +		/* this is linear; we assume compaction keeps the number of
     @@ -4661,18 +4934,18 @@
      +		}
      +
      +		if (rd == NULL) {
     -+			struct block_source src = { 0 };
     ++			struct reftable_block_source src = { 0 };
      +			slice_set_string(&table_path, st->reftable_dir);
      +			slice_append_string(&table_path, "/");
      +			slice_append_string(&table_path, name);
      +
     -+			err = block_source_from_file(
     ++			err = reftable_block_source_from_file(
      +				&src, slice_as_string(&table_path));
      +			if (err < 0) {
      +				goto exit;
      +			}
      +
     -+			err = new_reader(&rd, src, name);
     ++			err = reftable_new_reader(&rd, src, name);
      +			if (err < 0) {
      +				goto exit;
      +			}
     @@ -4682,8 +4955,8 @@
      +	}
      +
      +	/* success! */
     -+	err = new_merged_table(&new_merged, new_tables, new_tables_len,
     -+			       st->config.hash_id);
     ++	err = reftable_new_merged_table(&new_merged, new_tables, new_tables_len,
     ++					st->config.hash_id);
      +	if (err < 0) {
      +		goto exit;
      +	}
     @@ -4692,7 +4965,7 @@
      +	new_tables_len = 0;
      +	if (st->merged != NULL) {
      +		merged_table_clear(st->merged);
     -+		merged_table_free(st->merged);
     ++		reftable_merged_table_free(st->merged);
      +	}
      +	st->merged = new_merged;
      +
     @@ -4701,20 +4974,20 @@
      +		for (i = 0; i < cur_len; i++) {
      +			if (cur[i] != NULL) {
      +				reader_close(cur[i]);
     -+				reader_free(cur[i]);
     ++				reftable_reader_free(cur[i]);
      +			}
      +		}
      +	}
      +exit:
     -+	free(slice_yield(&table_path));
     ++	reftable_free(slice_yield(&table_path));
      +	{
      +		int i = 0;
      +		for (i = 0; i < new_tables_len; i++) {
      +			reader_close(new_tables[i]);
      +		}
      +	}
     -+	free(new_tables);
     -+	free(cur);
     ++	reftable_free(new_tables);
     ++	reftable_free(cur);
      +	return err;
      +}
      +
     @@ -4731,7 +5004,8 @@
      +	return udiff;
      +}
      +
     -+static int stack_reload_maybe_reuse(struct stack *st, bool reuse_open)
     ++static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     ++					     bool reuse_open)
      +{
      +	struct timeval deadline = { 0 };
      +	int err = gettimeofday(&deadline, NULL);
     @@ -4763,7 +5037,7 @@
      +			free_names(names);
      +			return err;
      +		}
     -+		err = stack_reload_once(st, names, reuse_open);
     ++		err = reftable_stack_reload_once(st, names, reuse_open);
      +		if (err == 0) {
      +			free_names(names);
      +			break;
     @@ -4794,15 +5068,15 @@
      +	return 0;
      +}
      +
     -+int stack_reload(struct stack *st)
     ++int reftable_stack_reload(struct reftable_stack *st)
      +{
     -+	return stack_reload_maybe_reuse(st, true);
     ++	return reftable_stack_reload_maybe_reuse(st, true);
      +}
      +
      +/* -1 = error
      + 0 = up to date
      + 1 = changed. */
     -+static int stack_uptodate(struct stack *st)
     ++static int stack_uptodate(struct reftable_stack *st)
      +{
      +	char **names = NULL;
      +	int err = read_lines(st->list_file, &names);
     @@ -4833,18 +5107,19 @@
      +	return err;
      +}
      +
     -+int stack_add(struct stack *st, int (*write)(struct writer *wr, void *arg),
     -+	      void *arg)
     ++int reftable_stack_add(struct reftable_stack *st,
     ++		       int (*write)(struct reftable_writer *wr, void *arg),
     ++		       void *arg)
      +{
      +	int err = stack_try_add(st, write, arg);
      +	if (err < 0) {
      +		if (err == LOCK_ERROR) {
     -+			err = stack_reload(st);
     ++			err = reftable_stack_reload(st);
      +		}
      +		return err;
      +	}
      +
     -+	return stack_auto_compact(st);
     ++	return reftable_stack_auto_compact(st);
      +}
      +
      +static void format_name(struct slice *dest, uint64_t min, uint64_t max)
     @@ -4854,34 +5129,35 @@
      +	slice_set_string(dest, buf);
      +}
      +
     -+int stack_try_add(struct stack *st,
     -+		  int (*write_table)(struct writer *wr, void *arg), void *arg)
     ++struct reftable_addition {
     ++	int lock_file_fd;
     ++	struct slice lock_file_name;
     ++	struct reftable_stack *stack;
     ++	char **names;
     ++	char **new_tables;
     ++	int new_tables_len;
     ++	uint64_t next_update_index;
     ++};
     ++
     ++static int reftable_stack_init_addition(struct reftable_addition *add,
     ++					struct reftable_stack *st)
      +{
     -+	struct slice lock_name = { 0 };
     -+	struct slice temp_tab_name = { 0 };
     -+	struct slice tab_name = { 0 };
     -+	struct slice next_name = { 0 };
     -+	struct slice table_list = { 0 };
     -+	struct writer *wr = NULL;
      +	int err = 0;
     -+	int tab_fd = 0;
     -+	int lock_fd = 0;
     -+	uint64_t next_update_index = 0;
     ++	add->stack = st;
      +
     -+	slice_set_string(&lock_name, st->list_file);
     -+	slice_append_string(&lock_name, ".lock");
     ++	slice_set_string(&add->lock_file_name, st->list_file);
     ++	slice_append_string(&add->lock_file_name, ".lock");
      +
     -+	lock_fd = open(slice_as_string(&lock_name), O_EXCL | O_CREAT | O_WRONLY,
     -+		       0644);
     -+	if (lock_fd < 0) {
     ++	add->lock_file_fd = open(slice_as_string(&add->lock_file_name),
     ++				 O_EXCL | O_CREAT | O_WRONLY, 0644);
     ++	if (add->lock_file_fd < 0) {
      +		if (errno == EEXIST) {
      +			err = LOCK_ERROR;
     -+			goto exit;
     ++		} else {
     ++			err = IO_ERROR;
      +		}
     -+		err = IO_ERROR;
      +		goto exit;
      +	}
     -+
      +	err = stack_uptodate(st);
      +	if (err < 0) {
      +		goto exit;
     @@ -4892,29 +5168,160 @@
      +		goto exit;
      +	}
      +
     -+	next_update_index = stack_next_update_index(st);
     ++	add->next_update_index = reftable_stack_next_update_index(st);
     ++exit:
     ++	if (err) {
     ++		reftable_addition_close(add);
     ++	}
     ++	return err;
     ++}
     ++
     ++void reftable_addition_close(struct reftable_addition *add)
     ++{
     ++	int i = 0;
     ++	struct slice nm = {};
     ++	for (i = 0; i < add->new_tables_len; i++) {
     ++		slice_set_string(&nm, add->stack->list_file);
     ++		slice_append_string(&nm, "/");
     ++		slice_append_string(&nm, add->new_tables[i]);
     ++		unlink(slice_as_string(&nm));
     ++
     ++		reftable_free(add->new_tables[i]);
     ++		add->new_tables[i] = NULL;
     ++	}
     ++	reftable_free(add->new_tables);
     ++	add->new_tables = NULL;
     ++	add->new_tables_len = 0;
     ++
     ++	if (add->lock_file_fd > 0) {
     ++		close(add->lock_file_fd);
     ++		add->lock_file_fd = 0;
     ++	}
     ++	if (add->lock_file_name.len > 0) {
     ++		unlink(slice_as_string(&add->lock_file_name));
     ++		reftable_free(slice_yield(&add->lock_file_name));
     ++	}
     ++
     ++	free_names(add->names);
     ++	add->names = NULL;
     ++}
     ++
     ++int reftable_addition_commit(struct reftable_addition *add)
     ++{
     ++	struct slice table_list = { 0 };
     ++	int i = 0;
     ++	int err = 0;
     ++	if (add->new_tables_len == 0) {
     ++		goto exit;
     ++	}
     ++
     ++	for (i = 0; i < add->stack->merged->stack_len; i++) {
     ++		slice_append_string(&table_list,
     ++				    add->stack->merged->stack[i]->name);
     ++		slice_append_string(&table_list, "\n");
     ++	}
     ++	for (i = 0; i < add->new_tables_len; i++) {
     ++		slice_append_string(&table_list, add->new_tables[i]);
     ++		slice_append_string(&table_list, "\n");
     ++	}
     ++
     ++	err = write(add->lock_file_fd, table_list.buf, table_list.len);
     ++	free(slice_yield(&table_list));
     ++	if (err < 0) {
     ++		err = IO_ERROR;
     ++		goto exit;
     ++	}
     ++
     ++	err = close(add->lock_file_fd);
     ++	add->lock_file_fd = 0;
     ++	if (err < 0) {
     ++		err = IO_ERROR;
     ++		goto exit;
     ++	}
     ++
     ++	err = rename(slice_as_string(&add->lock_file_name),
     ++		     add->stack->list_file);
     ++	if (err < 0) {
     ++		err = IO_ERROR;
     ++		goto exit;
     ++	}
     ++
     ++	err = reftable_stack_reload(add->stack);
     ++
     ++exit:
     ++	reftable_addition_close(add);
     ++	return err;
     ++}
     ++
     ++int reftable_stack_new_addition(struct reftable_addition **dest,
     ++				struct reftable_stack *st)
     ++{
     ++	int err = 0;
     ++	*dest = reftable_malloc(sizeof(**dest));
     ++	err = reftable_stack_init_addition(*dest, st);
     ++	if (err) {
     ++		reftable_free(*dest);
     ++		*dest = NULL;
     ++	}
     ++	return err;
     ++}
     ++
     ++int stack_try_add(struct reftable_stack *st,
     ++		  int (*write_table)(struct reftable_writer *wr, void *arg),
     ++		  void *arg)
     ++{
     ++	struct reftable_addition add = { 0 };
     ++	int err = reftable_stack_init_addition(&add, st);
     ++	if (err < 0) {
     ++		goto exit;
     ++	}
     ++
     ++	err = reftable_addition_add(&add, write_table, arg);
     ++	if (err < 0) {
     ++		goto exit;
     ++	}
     ++
     ++	err = reftable_addition_commit(&add);
     ++exit:
     ++	reftable_addition_close(&add);
     ++	return err;
     ++}
     ++
     ++int reftable_addition_add(struct reftable_addition *add,
     ++			  int (*write_table)(struct reftable_writer *wr,
     ++					     void *arg),
     ++			  void *arg)
     ++{
     ++	struct slice temp_tab_file_name = { 0 };
     ++	struct slice tab_file_name = { 0 };
     ++	struct slice next_name = { 0 };
     ++	struct reftable_writer *wr = NULL;
     ++	int err = 0;
     ++	int tab_fd = 0;
     ++	uint64_t next_update_index = 0;
      +
      +	slice_resize(&next_name, 0);
      +	format_name(&next_name, next_update_index, next_update_index);
      +
     -+	slice_set_string(&temp_tab_name, st->reftable_dir);
     -+	slice_append_string(&temp_tab_name, "/");
     -+	slice_append(&temp_tab_name, next_name);
     -+	slice_append_string(&temp_tab_name, ".temp.XXXXXX");
     ++	slice_set_string(&temp_tab_file_name, add->stack->reftable_dir);
     ++	slice_append_string(&temp_tab_file_name, "/");
     ++	slice_append(&temp_tab_file_name, next_name);
     ++	slice_append_string(&temp_tab_file_name, ".temp.XXXXXX");
      +
     -+	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_name));
     ++	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_file_name));
      +	if (tab_fd < 0) {
      +		err = IO_ERROR;
      +		goto exit;
      +	}
      +
     -+	wr = new_writer(fd_writer, &tab_fd, &st->config);
     ++	wr = reftable_new_writer(reftable_fd_write, &tab_fd,
     ++				 &add->stack->config);
      +	err = write_table(wr, arg);
      +	if (err < 0) {
      +		goto exit;
      +	}
      +
     -+	err = writer_close(wr);
     ++	err = reftable_writer_close(wr);
      +	if (err == EMPTY_TABLE_ERROR) {
      +		err = 0;
      +		goto exit;
     @@ -4935,98 +5342,64 @@
      +		goto exit;
      +	}
      +
     -+	{
     -+		int i = 0;
     -+		for (i = 0; i < st->merged->stack_len; i++) {
     -+			slice_append_string(&table_list,
     -+					    st->merged->stack[i]->name);
     -+			slice_append_string(&table_list, "\n");
     -+		}
     -+	}
     -+
      +	format_name(&next_name, wr->min_update_index, wr->max_update_index);
      +	slice_append_string(&next_name, ".ref");
     -+	slice_append(&table_list, next_name);
     -+	slice_append_string(&table_list, "\n");
      +
     -+	slice_set_string(&tab_name, st->reftable_dir);
     -+	slice_append_string(&tab_name, "/");
     -+	slice_append(&tab_name, next_name);
     ++	slice_set_string(&tab_file_name, add->stack->reftable_dir);
     ++	slice_append_string(&tab_file_name, "/");
     ++	slice_append(&tab_file_name, next_name);
      +
     -+	err = rename(slice_as_string(&temp_tab_name),
     -+		     slice_as_string(&tab_name));
     ++	err = rename(slice_as_string(&temp_tab_file_name),
     ++		     slice_as_string(&tab_file_name));
      +	if (err < 0) {
      +		err = IO_ERROR;
      +		goto exit;
      +	}
     -+	free(slice_yield(&temp_tab_name));
      +
     -+	err = write(lock_fd, table_list.buf, table_list.len);
     -+	if (err < 0) {
     -+		err = IO_ERROR;
     -+		goto exit;
     -+	}
     -+	err = close(lock_fd);
     -+	lock_fd = 0;
     -+	if (err < 0) {
     -+		unlink(slice_as_string(&tab_name));
     -+		err = IO_ERROR;
     -+		goto exit;
     -+	}
     -+
     -+	err = rename(slice_as_string(&lock_name), st->list_file);
     -+	if (err < 0) {
     -+		unlink(slice_as_string(&tab_name));
     -+		err = IO_ERROR;
     -+		goto exit;
     -+	}
     -+
     -+	err = stack_reload(st);
     ++	add->new_tables = reftable_realloc(add->new_tables,
     ++					   sizeof(*add->new_tables) *
     ++						   (add->new_tables_len + 1));
     ++	add->new_tables[add->new_tables_len] = slice_to_string(next_name);
     ++	add->new_tables_len++;
      +exit:
      +	if (tab_fd > 0) {
      +		close(tab_fd);
      +		tab_fd = 0;
      +	}
     -+	if (temp_tab_name.len > 0) {
     -+		unlink(slice_as_string(&temp_tab_name));
     -+	}
     -+	unlink(slice_as_string(&lock_name));
     -+
     -+	if (lock_fd > 0) {
     -+		close(lock_fd);
     -+		lock_fd = 0;
     ++	if (temp_tab_file_name.len > 0) {
     ++		unlink(slice_as_string(&temp_tab_file_name));
      +	}
      +
     -+	free(slice_yield(&lock_name));
     -+	free(slice_yield(&temp_tab_name));
     -+	free(slice_yield(&tab_name));
     -+	free(slice_yield(&next_name));
     -+	free(slice_yield(&table_list));
     -+	writer_free(wr);
     ++	reftable_free(slice_yield(&temp_tab_file_name));
     ++	reftable_free(slice_yield(&tab_file_name));
     ++	reftable_free(slice_yield(&next_name));
     ++	reftable_writer_free(wr);
      +	return err;
      +}
      +
     -+uint64_t stack_next_update_index(struct stack *st)
     ++uint64_t reftable_stack_next_update_index(struct reftable_stack *st)
      +{
      +	int sz = st->merged->stack_len;
      +	if (sz > 0) {
     -+		return reader_max_update_index(st->merged->stack[sz - 1]) + 1;
     ++		return reftable_reader_max_update_index(
     ++			       st->merged->stack[sz - 1]) +
     ++		       1;
      +	}
      +	return 1;
      +}
      +
     -+static int stack_compact_locked(struct stack *st, int first, int last,
     ++static int stack_compact_locked(struct reftable_stack *st, int first, int last,
      +				struct slice *temp_tab,
     -+				struct log_expiry_config *config)
     ++				struct reftable_log_expiry_config *config)
      +{
      +	struct slice next_name = { 0 };
      +	int tab_fd = -1;
     -+	struct writer *wr = NULL;
     ++	struct reftable_writer *wr = NULL;
      +	int err = 0;
      +
      +	format_name(&next_name,
     -+		    reader_min_update_index(st->merged->stack[first]),
     -+		    reader_max_update_index(st->merged->stack[first]));
     ++		    reftable_reader_min_update_index(st->merged->stack[first]),
     ++		    reftable_reader_max_update_index(st->merged->stack[first]));
      +
      +	slice_set_string(temp_tab, st->reftable_dir);
      +	slice_append_string(temp_tab, "/");
     @@ -5034,17 +5407,17 @@
      +	slice_append_string(temp_tab, ".temp.XXXXXX");
      +
      +	tab_fd = mkstemp((char *)slice_as_string(temp_tab));
     -+	wr = new_writer(fd_writer, &tab_fd, &st->config);
     ++	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
      +
      +	err = stack_write_compact(st, wr, first, last, config);
      +	if (err < 0) {
      +		goto exit;
      +	}
     -+	err = writer_close(wr);
     ++	err = reftable_writer_close(wr);
      +	if (err < 0) {
      +		goto exit;
      +	}
     -+	writer_free(wr);
     ++	reftable_writer_free(wr);
      +
      +	err = close(tab_fd);
      +	tab_fd = 0;
     @@ -5056,46 +5429,49 @@
      +	}
      +	if (err != 0 && temp_tab->len > 0) {
      +		unlink(slice_as_string(temp_tab));
     -+		free(slice_yield(temp_tab));
     ++		reftable_free(slice_yield(temp_tab));
      +	}
     -+	free(slice_yield(&next_name));
     ++	reftable_free(slice_yield(&next_name));
      +	return err;
      +}
      +
     -+int stack_write_compact(struct stack *st, struct writer *wr, int first,
     -+			int last, struct log_expiry_config *config)
     ++int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
     ++			int first, int last,
     ++			struct reftable_log_expiry_config *config)
      +{
      +	int subtabs_len = last - first + 1;
     -+	struct reader **subtabs =
     -+		calloc(sizeof(struct reader *), last - first + 1);
     -+	struct merged_table *mt = NULL;
     ++	struct reftable_reader **subtabs = reftable_calloc(
     ++		sizeof(struct reftable_reader *) * (last - first + 1));
     ++	struct reftable_merged_table *mt = NULL;
      +	int err = 0;
     -+	struct iterator it = { 0 };
     -+	struct ref_record ref = { 0 };
     -+	struct log_record log = { 0 };
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_ref_record ref = { 0 };
     ++	struct reftable_log_record log = { 0 };
      +
      +	int i = 0, j = 0;
      +	for (i = first, j = 0; i <= last; i++) {
     -+		struct reader *t = st->merged->stack[i];
     ++		struct reftable_reader *t = st->merged->stack[i];
      +		subtabs[j++] = t;
      +		st->stats.bytes += t->size;
      +	}
     -+	writer_set_limits(wr, st->merged->stack[first]->min_update_index,
     -+			  st->merged->stack[last]->max_update_index);
     ++	reftable_writer_set_limits(wr,
     ++				   st->merged->stack[first]->min_update_index,
     ++				   st->merged->stack[last]->max_update_index);
      +
     -+	err = new_merged_table(&mt, subtabs, subtabs_len, st->config.hash_id);
     ++	err = reftable_new_merged_table(&mt, subtabs, subtabs_len,
     ++					st->config.hash_id);
      +	if (err < 0) {
     -+		free(subtabs);
     ++		reftable_free(subtabs);
      +		goto exit;
      +	}
      +
     -+	err = merged_table_seek_ref(mt, &it, "");
     ++	err = reftable_merged_table_seek_ref(mt, &it, "");
      +	if (err < 0) {
      +		goto exit;
      +	}
      +
      +	while (true) {
     -+		err = iterator_next_ref(it, &ref);
     ++		err = reftable_iterator_next_ref(it, &ref);
      +		if (err > 0) {
      +			err = 0;
      +			break;
     @@ -5103,23 +5479,23 @@
      +		if (err < 0) {
      +			break;
      +		}
     -+		if (first == 0 && ref_record_is_deletion(&ref)) {
     ++		if (first == 0 && reftable_ref_record_is_deletion(&ref)) {
      +			continue;
      +		}
      +
     -+		err = writer_add_ref(wr, &ref);
     ++		err = reftable_writer_add_ref(wr, &ref);
      +		if (err < 0) {
      +			break;
      +		}
      +	}
      +
     -+	err = merged_table_seek_log(mt, &it, "");
     ++	err = reftable_merged_table_seek_log(mt, &it, "");
      +	if (err < 0) {
      +		goto exit;
      +	}
      +
      +	while (true) {
     -+		err = iterator_next_log(it, &log);
     ++		err = reftable_iterator_next_log(it, &log);
      +		if (err > 0) {
      +			err = 0;
      +			break;
     @@ -5127,7 +5503,7 @@
      +		if (err < 0) {
      +			break;
      +		}
     -+		if (first == 0 && log_record_is_deletion(&log)) {
     ++		if (first == 0 && reftable_log_record_is_deletion(&log)) {
      +			continue;
      +		}
      +
     @@ -5143,28 +5519,28 @@
      +			continue;
      +		}
      +
     -+		err = writer_add_log(wr, &log);
     ++		err = reftable_writer_add_log(wr, &log);
      +		if (err < 0) {
      +			break;
      +		}
      +	}
      +
      +exit:
     -+	iterator_destroy(&it);
     ++	reftable_iterator_destroy(&it);
      +	if (mt != NULL) {
      +		merged_table_clear(mt);
     -+		merged_table_free(mt);
     ++		reftable_merged_table_free(mt);
      +	}
     -+	ref_record_clear(&ref);
     ++	reftable_ref_record_clear(&ref);
      +
      +	return err;
      +}
      +
      +/* <  0: error. 0 == OK, > 0 attempt failed; could retry. */
     -+static int stack_compact_range(struct stack *st, int first, int last,
     -+			       struct log_expiry_config *expiry)
     ++static int stack_compact_range(struct reftable_stack *st, int first, int last,
     ++			       struct reftable_log_expiry_config *expiry)
      +{
     -+	struct slice temp_tab_name = { 0 };
     ++	struct slice temp_tab_file_name = { 0 };
      +	struct slice new_table_name = { 0 };
      +	struct slice lock_file_name = { 0 };
      +	struct slice ref_list_contents = { 0 };
     @@ -5173,8 +5549,10 @@
      +	bool have_lock = false;
      +	int lock_file_fd = 0;
      +	int compact_count = last - first + 1;
     -+	char **delete_on_success = calloc(sizeof(char *), compact_count + 1);
     -+	char **subtable_locks = calloc(sizeof(char *), compact_count + 1);
     ++	char **delete_on_success =
     ++		reftable_calloc(sizeof(char *) * (compact_count + 1));
     ++	char **subtable_locks =
     ++		reftable_calloc(sizeof(char *) * (compact_count + 1));
      +	int i = 0;
      +	int j = 0;
      +	bool is_empty_table = false;
     @@ -5206,14 +5584,14 @@
      +	}
      +
      +	for (i = first, j = 0; i <= last; i++) {
     -+		struct slice subtab_name = { 0 };
     ++		struct slice subtab_file_name = { 0 };
      +		struct slice subtab_lock = { 0 };
     -+		slice_set_string(&subtab_name, st->reftable_dir);
     -+		slice_append_string(&subtab_name, "/");
     -+		slice_append_string(&subtab_name,
     ++		slice_set_string(&subtab_file_name, st->reftable_dir);
     ++		slice_append_string(&subtab_file_name, "/");
     ++		slice_append_string(&subtab_file_name,
      +				    reader_name(st->merged->stack[i]));
      +
     -+		slice_copy(&subtab_lock, subtab_name);
     ++		slice_copy(&subtab_lock, subtab_file_name);
      +		slice_append_string(&subtab_lock, ".lock");
      +
      +		{
     @@ -5231,7 +5609,8 @@
      +		}
      +
      +		subtable_locks[j] = (char *)slice_as_string(&subtab_lock);
     -+		delete_on_success[j] = (char *)slice_as_string(&subtab_name);
     ++		delete_on_success[j] =
     ++			(char *)slice_as_string(&subtab_file_name);
      +		j++;
      +
      +		if (err != 0) {
     @@ -5245,7 +5624,8 @@
      +	}
      +	have_lock = false;
      +
     -+	err = stack_compact_locked(st, first, last, &temp_tab_name, expiry);
     ++	err = stack_compact_locked(st, first, last, &temp_tab_file_name,
     ++				   expiry);
      +	/* Compaction + tombstones can create an empty table out of non-empty
      +	 * tables. */
      +	is_empty_table = (err == EMPTY_TABLE_ERROR);
     @@ -5278,7 +5658,7 @@
      +	slice_append(&new_table_path, new_table_name);
      +
      +	if (!is_empty_table) {
     -+		err = rename(slice_as_string(&temp_tab_name),
     ++		err = rename(slice_as_string(&temp_tab_file_name),
      +			     slice_as_string(&new_table_path));
      +		if (err < 0) {
      +			goto exit;
     @@ -5329,7 +5709,7 @@
      +		}
      +	}
      +
     -+	err = stack_reload_maybe_reuse(st, first < last);
     ++	err = reftable_stack_reload_maybe_reuse(st, first < last);
      +exit:
      +	free_names(delete_on_success);
      +	{
     @@ -5347,21 +5727,23 @@
      +	if (have_lock) {
      +		unlink(slice_as_string(&lock_file_name));
      +	}
     -+	free(slice_yield(&new_table_name));
     -+	free(slice_yield(&new_table_path));
     -+	free(slice_yield(&ref_list_contents));
     -+	free(slice_yield(&temp_tab_name));
     -+	free(slice_yield(&lock_file_name));
     ++	reftable_free(slice_yield(&new_table_name));
     ++	reftable_free(slice_yield(&new_table_path));
     ++	reftable_free(slice_yield(&ref_list_contents));
     ++	reftable_free(slice_yield(&temp_tab_file_name));
     ++	reftable_free(slice_yield(&lock_file_name));
      +	return err;
      +}
      +
     -+int stack_compact_all(struct stack *st, struct log_expiry_config *config)
     ++int reftable_stack_compact_all(struct reftable_stack *st,
     ++			       struct reftable_log_expiry_config *config)
      +{
      +	return stack_compact_range(st, 0, st->merged->stack_len - 1, config);
      +}
      +
     -+static int stack_compact_range_stats(struct stack *st, int first, int last,
     -+				     struct log_expiry_config *config)
     ++static int stack_compact_range_stats(struct reftable_stack *st, int first,
     ++				     int last,
     ++				     struct reftable_log_expiry_config *config)
      +{
      +	int err = stack_compact_range(st, first, last, config);
      +	if (err > 0) {
     @@ -5387,7 +5769,7 @@
      +
      +struct segment *sizes_to_segments(int *seglen, uint64_t *sizes, int n)
      +{
     -+	struct segment *segs = calloc(sizeof(struct segment), n);
     ++	struct segment *segs = reftable_calloc(sizeof(struct segment) * n);
      +	int next = 0;
      +	struct segment cur = { 0 };
      +	int i = 0;
     @@ -5406,8 +5788,9 @@
      +		cur.end = i + 1;
      +		cur.bytes += sizes[i];
      +	}
     -+
     -+	segs[next++] = cur;
     ++	if (next > 0) {
     ++		segs[next++] = cur;
     ++	}
      +	*seglen = next;
      +	return segs;
      +}
     @@ -5440,13 +5823,14 @@
      +		min_seg.bytes += sizes[prev];
      +	}
      +
     -+	free(segs);
     ++	reftable_free(segs);
      +	return min_seg;
      +}
      +
     -+static uint64_t *stack_table_sizes_for_compaction(struct stack *st)
     ++static uint64_t *stack_table_sizes_for_compaction(struct reftable_stack *st)
      +{
     -+	uint64_t *sizes = calloc(sizeof(uint64_t), st->merged->stack_len);
     ++	uint64_t *sizes =
     ++		reftable_calloc(sizeof(uint64_t) * st->merged->stack_len);
      +	int i = 0;
      +	for (i = 0; i < st->merged->stack_len; i++) {
      +		/* overhead is 24 + 68 = 92. */
     @@ -5455,12 +5839,12 @@
      +	return sizes;
      +}
      +
     -+int stack_auto_compact(struct stack *st)
     ++int reftable_stack_auto_compact(struct reftable_stack *st)
      +{
      +	uint64_t *sizes = stack_table_sizes_for_compaction(st);
      +	struct segment seg =
      +		suggest_compaction_segment(sizes, st->merged->stack_len);
     -+	free(sizes);
     ++	reftable_free(sizes);
      +	if (segment_size(&seg) > 0) {
      +		return stack_compact_range_stats(st, seg.start, seg.end - 1,
      +						 NULL);
     @@ -5469,58 +5853,61 @@
      +	return 0;
      +}
      +
     -+struct compaction_stats *stack_compaction_stats(struct stack *st)
     ++struct reftable_compaction_stats *
     ++reftable_stack_compaction_stats(struct reftable_stack *st)
      +{
      +	return &st->stats;
      +}
      +
     -+int stack_read_ref(struct stack *st, const char *refname,
     -+		   struct ref_record *ref)
     ++int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
     ++			    struct reftable_ref_record *ref)
      +{
     -+	struct iterator it = { 0 };
     -+	struct merged_table *mt = stack_merged_table(st);
     -+	int err = merged_table_seek_ref(mt, &it, refname);
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
     ++	int err = reftable_merged_table_seek_ref(mt, &it, refname);
      +	if (err) {
      +		goto exit;
      +	}
      +
     -+	err = iterator_next_ref(it, ref);
     ++	err = reftable_iterator_next_ref(it, ref);
      +	if (err) {
      +		goto exit;
      +	}
      +
     -+	if (strcmp(ref->ref_name, refname) || ref_record_is_deletion(ref)) {
     ++	if (strcmp(ref->ref_name, refname) ||
     ++	    reftable_ref_record_is_deletion(ref)) {
      +		err = 1;
      +		goto exit;
      +	}
      +
      +exit:
     -+	iterator_destroy(&it);
     ++	reftable_iterator_destroy(&it);
      +	return err;
      +}
      +
     -+int stack_read_log(struct stack *st, const char *refname,
     -+		   struct log_record *log)
     ++int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
     ++			    struct reftable_log_record *log)
      +{
     -+	struct iterator it = { 0 };
     -+	struct merged_table *mt = stack_merged_table(st);
     -+	int err = merged_table_seek_log(mt, &it, refname);
     ++	struct reftable_iterator it = { 0 };
     ++	struct reftable_merged_table *mt = reftable_stack_merged_table(st);
     ++	int err = reftable_merged_table_seek_log(mt, &it, refname);
      +	if (err) {
      +		goto exit;
      +	}
      +
     -+	err = iterator_next_log(it, log);
     ++	err = reftable_iterator_next_log(it, log);
      +	if (err) {
      +		goto exit;
      +	}
      +
     -+	if (strcmp(log->ref_name, refname) || log_record_is_deletion(log)) {
     ++	if (strcmp(log->ref_name, refname) ||
     ++	    reftable_log_record_is_deletion(log)) {
      +		err = 1;
      +		goto exit;
      +	}
      +
      +exit:
     -+	iterator_destroy(&it);
     ++	reftable_iterator_destroy(&it);
      +	return err;
      +}
      
     @@ -5542,21 +5929,23 @@
      +
      +#include "reftable.h"
      +
     -+struct stack {
     ++struct reftable_stack {
      +	char *list_file;
      +	char *reftable_dir;
      +
     -+	struct write_options config;
     ++	struct reftable_write_options config;
      +
     -+	struct merged_table *merged;
     -+	struct compaction_stats stats;
     ++	struct reftable_merged_table *merged;
     ++	struct reftable_compaction_stats stats;
      +};
      +
      +int read_lines(const char *filename, char ***lines);
     -+int stack_try_add(struct stack *st,
     -+		  int (*write_table)(struct writer *wr, void *arg), void *arg);
     -+int stack_write_compact(struct stack *st, struct writer *wr, int first,
     -+			int last, struct log_expiry_config *config);
     ++int stack_try_add(struct reftable_stack *st,
     ++		  int (*write_table)(struct reftable_writer *wr, void *arg),
     ++		  void *arg);
     ++int stack_write_compact(struct reftable_stack *st, struct reftable_writer *wr,
     ++			int first, int last,
     ++			struct reftable_log_expiry_config *config);
      +int fastlog2(uint64_t sz);
      +
      +struct segment {
     @@ -5644,6 +6033,7 @@
      +
      +#include "tree.h"
      +
     ++#include "basics.h"
      +#include "system.h"
      +
      +struct tree_node *tree_search(void *key, struct tree_node **rootp,
     @@ -5655,7 +6045,7 @@
      +			return NULL;
      +		} else {
      +			struct tree_node *n =
     -+				calloc(sizeof(struct tree_node), 1);
     ++				reftable_calloc(sizeof(struct tree_node));
      +			n->key = key;
      +			*rootp = n;
      +			return *rootp;
     @@ -5698,7 +6088,7 @@
      +	if (t->right != NULL) {
      +		tree_free(t->right);
      +	}
     -+	free(t);
     ++	reftable_free(t);
      +}
      
       diff --git a/reftable/tree.h b/reftable/tree.h
     @@ -5743,6 +6133,7 @@
      +((cd reftable-repo && git fetch origin && git checkout origin/master ) ||
      +git clone https://github.com/google/reftable reftable-repo) && \
      +cp reftable-repo/c/*.[ch] reftable/ && \
     ++cp reftable-repo/c/include/*.[ch] reftable/ && \
      +cp reftable-repo/LICENSE reftable/ &&
      +git --git-dir reftable-repo/.git show --no-patch origin/master \
      +> reftable/VERSION && \
     @@ -5773,7 +6164,8 @@
      +#include "reftable.h"
      +#include "tree.h"
      +
     -+static struct block_stats *writer_block_stats(struct writer *w, byte typ)
     ++static struct reftable_block_stats *
     ++writer_reftable_block_stats(struct reftable_writer *w, byte typ)
      +{
      +	switch (typ) {
      +	case 'r':
     @@ -5791,18 +6183,19 @@
      +
      +/* write data, queuing the padding for the next write. Returns negative for
      + * error. */
     -+static int padded_write(struct writer *w, byte *data, size_t len, int padding)
     ++static int padded_write(struct reftable_writer *w, byte *data, size_t len,
     ++			int padding)
      +{
      +	int n = 0;
      +	if (w->pending_padding > 0) {
     -+		byte *zeroed = calloc(w->pending_padding, 1);
     ++		byte *zeroed = reftable_calloc(w->pending_padding);
      +		int n = w->write(w->write_arg, zeroed, w->pending_padding);
      +		if (n < 0) {
      +			return n;
      +		}
      +
      +		w->pending_padding = 0;
     -+		free(zeroed);
     ++		reftable_free(zeroed);
      +	}
      +
      +	w->pending_padding = padding;
     @@ -5814,7 +6207,7 @@
      +	return 0;
      +}
      +
     -+static void options_set_defaults(struct write_options *opts)
     ++static void options_set_defaults(struct reftable_write_options *opts)
      +{
      +	if (opts->restart_interval == 0) {
      +		opts->restart_interval = 16;
     @@ -5828,25 +6221,31 @@
      +	}
      +}
      +
     -+static int writer_write_header(struct writer *w, byte *dest)
     ++static int writer_version(struct reftable_writer *w)
     ++{
     ++	return (w->opts.hash_id == 0 || w->opts.hash_id == SHA1_ID) ? 1 : 2;
     ++}
     ++
     ++static int writer_write_header(struct reftable_writer *w, byte *dest)
      +{
      +	memcpy((char *)dest, "REFT", 4);
      +
     -+	/* DO NOT SUBMIT.  This has not been encoded in the standard yet. */
     -+	dest[4] = (hash_size(w->opts.hash_id) == SHA1_SIZE) ? 1 : 2; /* version
     -+								      */
     ++	dest[4] = writer_version(w);
      +
      +	put_be24(dest + 5, w->opts.block_size);
      +	put_be64(dest + 8, w->min_update_index);
      +	put_be64(dest + 16, w->max_update_index);
     -+	return 24;
     ++	if (writer_version(w) == 2) {
     ++		put_be32(dest + 24, w->opts.hash_id);
     ++	}
     ++	return header_size(writer_version(w));
      +}
      +
     -+static void writer_reinit_block_writer(struct writer *w, byte typ)
     ++static void writer_reinit_block_writer(struct reftable_writer *w, byte typ)
      +{
      +	int block_start = 0;
      +	if (w->next == 0) {
     -+		block_start = HEADER_SIZE;
     ++		block_start = header_size(writer_version(w));
      +	}
      +
      +	block_writer_init(&w->block_writer_data, typ, w->block,
     @@ -5856,16 +6255,18 @@
      +	w->block_writer->restart_interval = w->opts.restart_interval;
      +}
      +
     -+struct writer *new_writer(int (*writer_func)(void *, byte *, int),
     -+			  void *writer_arg, struct write_options *opts)
     ++struct reftable_writer *
     ++reftable_new_writer(int (*writer_func)(void *, byte *, int), void *writer_arg,
     ++		    struct reftable_write_options *opts)
      +{
     -+	struct writer *wp = calloc(sizeof(struct writer), 1);
     ++	struct reftable_writer *wp =
     ++		reftable_calloc(sizeof(struct reftable_writer));
      +	options_set_defaults(opts);
      +	if (opts->block_size >= (1 << 24)) {
      +		/* TODO - error return? */
      +		abort();
      +	}
     -+	wp->block = calloc(opts->block_size, 1);
     ++	wp->block = reftable_calloc(opts->block_size);
      +	wp->write = writer_func;
      +	wp->write_arg = writer_arg;
      +	wp->opts = *opts;
     @@ -5874,16 +6275,17 @@
      +	return wp;
      +}
      +
     -+void writer_set_limits(struct writer *w, uint64_t min, uint64_t max)
     ++void reftable_writer_set_limits(struct reftable_writer *w, uint64_t min,
     ++				uint64_t max)
      +{
      +	w->min_update_index = min;
      +	w->max_update_index = max;
      +}
      +
     -+void writer_free(struct writer *w)
     ++void reftable_writer_free(struct reftable_writer *w)
      +{
     -+	free(w->block);
     -+	free(w);
     ++	reftable_free(w->block);
     ++	reftable_free(w);
      +}
      +
      +struct obj_index_tree_node {
     @@ -5899,7 +6301,7 @@
      +			     ((const struct obj_index_tree_node *)b)->hash);
      +}
      +
     -+static void writer_index_hash(struct writer *w, struct slice hash)
     ++static void writer_index_hash(struct reftable_writer *w, struct slice hash)
      +{
      +	uint64_t off = w->next;
      +
     @@ -5909,7 +6311,7 @@
      +					     &obj_index_tree_node_compare, 0);
      +	struct obj_index_tree_node *key = NULL;
      +	if (node == NULL) {
     -+		key = calloc(sizeof(struct obj_index_tree_node), 1);
     ++		key = reftable_calloc(sizeof(struct obj_index_tree_node));
      +		slice_copy(&key->hash, hash);
      +		tree_search((void *)key, &w->obj_index_tree,
      +			    &obj_index_tree_node_compare, 1);
     @@ -5923,14 +6325,14 @@
      +
      +	if (key->offset_len == key->offset_cap) {
      +		key->offset_cap = 2 * key->offset_cap + 1;
     -+		key->offsets = realloc(key->offsets,
     -+				       sizeof(uint64_t) * key->offset_cap);
     ++		key->offsets = reftable_realloc(
     ++			key->offsets, sizeof(uint64_t) * key->offset_cap);
      +	}
      +
      +	key->offsets[key->offset_len++] = off;
      +}
      +
     -+static int writer_add_record(struct writer *w, struct record rec)
     ++static int writer_add_record(struct reftable_writer *w, struct record rec)
      +{
      +	int result = -1;
      +	struct slice key = { 0 };
     @@ -5967,14 +6369,15 @@
      +
      +	result = 0;
      +exit:
     -+	free(slice_yield(&key));
     ++	reftable_free(slice_yield(&key));
      +	return result;
      +}
      +
     -+int writer_add_ref(struct writer *w, struct ref_record *ref)
     ++int reftable_writer_add_ref(struct reftable_writer *w,
     ++			    struct reftable_ref_record *ref)
      +{
      +	struct record rec = { 0 };
     -+	struct ref_record copy = *ref;
     ++	struct reftable_ref_record copy = *ref;
      +	int err = 0;
      +
      +	if (ref->ref_name == NULL) {
     @@ -6010,18 +6413,20 @@
      +	return 0;
      +}
      +
     -+int writer_add_refs(struct writer *w, struct ref_record *refs, int n)
     ++int reftable_writer_add_refs(struct reftable_writer *w,
     ++			     struct reftable_ref_record *refs, int n)
      +{
      +	int err = 0;
      +	int i = 0;
     -+	QSORT(refs, n, ref_record_compare_name);
     ++	QSORT(refs, n, reftable_ref_record_compare_name);
      +	for (i = 0; err == 0 && i < n; i++) {
     -+		err = writer_add_ref(w, &refs[i]);
     ++		err = reftable_writer_add_ref(w, &refs[i]);
      +	}
      +	return err;
      +}
      +
     -+int writer_add_log(struct writer *w, struct log_record *log)
     ++int reftable_writer_add_log(struct reftable_writer *w,
     ++			    struct reftable_log_record *log)
      +{
      +	if (log->ref_name == NULL) {
      +		return API_ERROR;
     @@ -6047,18 +6452,19 @@
      +	}
      +}
      +
     -+int writer_add_logs(struct writer *w, struct log_record *logs, int n)
     ++int reftable_writer_add_logs(struct reftable_writer *w,
     ++			     struct reftable_log_record *logs, int n)
      +{
      +	int err = 0;
      +	int i = 0;
     -+	QSORT(logs, n, log_record_compare_key);
     ++	QSORT(logs, n, reftable_log_record_compare_key);
      +	for (i = 0; err == 0 && i < n; i++) {
     -+		err = writer_add_log(w, &logs[i]);
     ++		err = reftable_writer_add_log(w, &logs[i]);
      +	}
      +	return err;
      +}
      +
     -+static int writer_finish_section(struct writer *w)
     ++static int writer_finish_section(struct reftable_writer *w)
      +{
      +	byte typ = block_writer_type(w->block_writer);
      +	uint64_t index_start = 0;
     @@ -6105,9 +6511,9 @@
      +			assert(err == 0);
      +		}
      +		for (i = 0; i < idx_len; i++) {
     -+			free(slice_yield(&idx[i].last_key));
     ++			reftable_free(slice_yield(&idx[i].last_key));
      +		}
     -+		free(idx);
     ++		reftable_free(idx);
      +	}
      +
      +	writer_clear_index(w);
     @@ -6118,7 +6524,8 @@
      +	}
      +
      +	{
     -+		struct block_stats *bstats = writer_block_stats(w, typ);
     ++		struct reftable_block_stats *bstats =
     ++			writer_reftable_block_stats(w, typ);
      +		bstats->index_blocks =
      +			w->stats.idx_stats.blocks - before_blocks;
      +		bstats->index_offset = index_start;
     @@ -6150,7 +6557,7 @@
      +}
      +
      +struct write_record_arg {
     -+	struct writer *w;
     ++	struct reftable_writer *w;
      +	int err;
      +};
      +
     @@ -6199,11 +6606,11 @@
      +	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
      +
      +	FREE_AND_NULL(entry->offsets);
     -+	free(slice_yield(&entry->hash));
     -+	free(entry);
     ++	reftable_free(slice_yield(&entry->hash));
     ++	reftable_free(entry);
      +}
      +
     -+static int writer_dump_object_index(struct writer *w)
     ++static int writer_dump_object_index(struct reftable_writer *w)
      +{
      +	struct write_record_arg closure = { .w = w };
      +	struct common_prefix_arg common = { 0 };
     @@ -6224,7 +6631,7 @@
      +	return writer_finish_section(w);
      +}
      +
     -+int writer_finish_public_section(struct writer *w)
     ++int writer_finish_public_section(struct reftable_writer *w)
      +{
      +	byte typ = 0;
      +	int err = 0;
     @@ -6256,9 +6663,9 @@
      +	return 0;
      +}
      +
     -+int writer_close(struct writer *w)
     ++int reftable_writer_close(struct reftable_writer *w)
      +{
     -+	byte footer[68];
     ++	byte footer[72];
      +	byte *p = footer;
      +
      +	int err = writer_finish_public_section(w);
     @@ -6266,8 +6673,7 @@
      +		goto exit;
      +	}
      +
     -+	writer_write_header(w, footer);
     -+	p += 24;
     ++	p += writer_write_header(w, footer);
      +	put_be64(p, w->stats.ref_stats.index_offset);
      +	p += 8;
      +	put_be64(p, (w->stats.obj_stats.offset) << 5 | w->stats.object_id_len);
     @@ -6284,7 +6690,7 @@
      +	p += 4;
      +	w->pending_padding = 0;
      +
     -+	err = padded_write(w, footer, sizeof(footer), 0);
     ++	err = padded_write(w, footer, footer_size(writer_version(w)), 0);
      +	if (err < 0) {
      +		goto exit;
      +	}
     @@ -6298,15 +6704,15 @@
      +	/* free up memory. */
      +	block_writer_clear(&w->block_writer_data);
      +	writer_clear_index(w);
     -+	free(slice_yield(&w->last_key));
     ++	reftable_free(slice_yield(&w->last_key));
      +	return err;
      +}
      +
     -+void writer_clear_index(struct writer *w)
     ++void writer_clear_index(struct reftable_writer *w)
      +{
      +	int i = 0;
      +	for (i = 0; i < w->index_len; i++) {
     -+		free(slice_yield(&w->index[i].last_key));
     ++		reftable_free(slice_yield(&w->index[i].last_key));
      +	}
      +
      +	FREE_AND_NULL(w->index);
     @@ -6316,10 +6722,11 @@
      +
      +const int debug = 0;
      +
     -+static int writer_flush_nonempty_block(struct writer *w)
     ++static int writer_flush_nonempty_block(struct reftable_writer *w)
      +{
      +	byte typ = block_writer_type(w->block_writer);
     -+	struct block_stats *bstats = writer_block_stats(w, typ);
     ++	struct reftable_block_stats *bstats =
     ++		writer_reftable_block_stats(w, typ);
      +	uint64_t block_typ_off = (bstats->blocks == 0) ? w->next : 0;
      +	int raw_bytes = block_writer_finish(w->block_writer);
      +	int padding = 0;
     @@ -6358,8 +6765,8 @@
      +
      +	if (w->index_cap == w->index_len) {
      +		w->index_cap = 2 * w->index_cap + 1;
     -+		w->index = realloc(w->index,
     -+				   sizeof(struct index_record) * w->index_cap);
     ++		w->index = reftable_realloc(
     ++			w->index, sizeof(struct index_record) * w->index_cap);
      +	}
      +
      +	{
     @@ -6377,7 +6784,7 @@
      +	return 0;
      +}
      +
     -+int writer_flush_block(struct writer *w)
     ++int writer_flush_block(struct reftable_writer *w)
      +{
      +	if (w->block_writer == NULL) {
      +		return 0;
     @@ -6388,7 +6795,7 @@
      +	return writer_flush_nonempty_block(w);
      +}
      +
     -+struct stats *writer_stats(struct writer *w)
     ++const struct reftable_stats *writer_stats(struct reftable_writer *w)
      +{
      +	return &w->stats;
      +}
     @@ -6415,7 +6822,7 @@
      +#include "slice.h"
      +#include "tree.h"
      +
     -+struct writer {
     ++struct reftable_writer {
      +	int (*write)(void *, byte *, int);
      +	void *write_arg;
      +	int pending_padding;
     @@ -6423,11 +6830,11 @@
      +
      +	uint64_t next;
      +	uint64_t min_update_index, max_update_index;
     -+	struct write_options opts;
     ++	struct reftable_write_options opts;
      +
      +	byte *block;
     -+	struct block_writer *block_writer;
     -+	struct block_writer block_writer_data;
     ++	struct reftable_block_writer *block_writer;
     ++	struct reftable_block_writer block_writer_data;
      +	struct index_record *index;
      +	int index_len;
      +	int index_cap;
     @@ -6435,12 +6842,12 @@
      +	/* tree for use with tsearch */
      +	struct tree_node *obj_index_tree;
      +
     -+	struct stats stats;
     ++	struct reftable_stats stats;
      +};
      +
     -+int writer_flush_block(struct writer *w);
     -+void writer_clear_index(struct writer *w);
     -+int writer_finish_public_section(struct writer *w);
     ++int writer_flush_block(struct reftable_writer *w);
     ++void writer_clear_index(struct reftable_writer *w);
     ++int writer_finish_public_section(struct reftable_writer *w);
      +
      +#endif
      
  6:  a622d8066c7 !  9:  b29c4ecc1c4 Reftable support for git-core
     @@ -6,6 +6,7 @@
      
          TODO:
      
     +     * "git show-ref" shows "HEAD"
           * Resolve spots marked with XXX
           * Test strategy?
      
     @@ -104,8 +105,9 @@ $^
       		}
       	}
       
     --	init_db(git_dir, real_git_dir, option_template, INIT_DB_QUIET);
     +-	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
      +	init_db(git_dir, real_git_dir, option_template,
     ++                GIT_HASH_UNKNOWN,
      +		DEFAULT_REF_STORAGE, /* XXX */
      +		INIT_DB_QUIET);
       
     @@ -116,20 +118,28 @@ $^
       --- a/builtin/init-db.c
       +++ b/builtin/init-db.c
      @@
     + 	return 1;
       }
       
     - static int create_default_files(const char *template_path,
     --				const char *original_git_dir)
     -+				const char *original_git_dir,
     -+				const char *ref_storage_format, int flags)
     +-void initialize_repository_version(int hash_algo)
     ++void initialize_repository_version(int hash_algo, const char *ref_storage_format)
       {
     - 	struct stat st1;
     - 	struct strbuf buf = STRBUF_INIT;
     + 	char repo_version_string[10];
     + 	int repo_version = GIT_REPO_VERSION;
     +@@
     + 		die(_("The hash algorithm %s is not supported in this build."), hash_algos[hash_algo].name);
     + #endif
     + 
     +-	if (hash_algo != GIT_HASH_SHA1)
     ++	if (hash_algo != GIT_HASH_SHA1 || !strcmp(ref_storage_format, "reftable"))
     + 		repo_version = GIT_REPO_VERSION_READ;
     + 
     + 	/* This forces creation of new config file */
      @@
       	is_bare_repository_cfg = init_is_bare_repository;
       	if (init_shared_repository != -1)
       		set_shared_repository(init_shared_repository);
     -+	the_repository->ref_storage_format = xstrdup(ref_storage_format);
     ++	the_repository->ref_storage_format = xstrdup(fmt->ref_storage);
       
       	/*
       	 * We would have created the above under user's umask -- under
     @@ -166,35 +176,28 @@ $^
      +		 */
       	}
       
     - 	/* This forces creation of new config file */
     --	xsnprintf(repo_version_string, sizeof(repo_version_string),
     --		  "%d", GIT_REPO_VERSION);
     -+	xsnprintf(repo_version_string, sizeof(repo_version_string), "%d",
     -+		  !strcmp(ref_storage_format, "reftable") ?
     -+			  GIT_REPO_VERSION_READ :
     -+			  GIT_REPO_VERSION);
     - 	git_config_set("core.repositoryformatversion", repo_version_string);
     +-	initialize_repository_version(fmt->hash_algo);
     ++	initialize_repository_version(fmt->hash_algo, fmt->ref_storage);
       
       	/* Check filemode trustability */
     + 	path = git_path_buf(&buf, "config");
      @@
       }
       
       int init_db(const char *git_dir, const char *real_git_dir,
     --	    const char *template_dir, unsigned int flags)
     -+	    const char *template_dir, const char *ref_storage_format,
     -+	    unsigned int flags)
     +-	    const char *template_dir, int hash, unsigned int flags)
     ++	    const char *template_dir, int hash, const char *ref_storage_format,
     ++            unsigned int flags)
       {
       	int reinit;
       	int exist_ok = flags & INIT_DB_EXIST_OK;
      @@
     + 	 * is an attempt to reinitialize new repository with an old tool.
       	 */
     - 	check_repository_format();
     - 
     --	reinit = create_default_files(template_dir, original_git_dir);
     -+	reinit = create_default_files(template_dir, original_git_dir,
     -+				      ref_storage_format, flags);
     + 	check_repository_format(&repo_fmt);
     ++        repo_fmt.ref_storage = xstrdup(ref_storage_format);
       
     - 	create_object_directory();
     + 	validate_hash_algorithm(&repo_fmt, hash);
       
      @@
       		git_config_set("receive.denyNonFastforwards", "true");
     @@ -213,7 +216,9 @@ $^
       	const char *real_git_dir = NULL;
       	const char *work_tree;
       	const char *template_dir = NULL;
     - 	unsigned int flags = 0;
     +@@
     + 	const char *object_format = NULL;
     + 	int hash_algo = GIT_HASH_UNKNOWN;
       	const struct option init_db_options[] = {
      -		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
      -				N_("directory from which templates will be used")),
     @@ -235,7 +240,7 @@ $^
      +			   N_("the ref storage format to use")),
       		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
       			   N_("separate git dir from working tree")),
     - 		OPT_END()
     + 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
      @@
       	}
       
     @@ -245,21 +250,21 @@ $^
       	UNLEAK(work_tree);
       
       	flags |= INIT_DB_EXIST_OK;
     --	return init_db(git_dir, real_git_dir, template_dir, flags);
     -+	return init_db(git_dir, real_git_dir, template_dir, ref_storage_format,
     -+		       flags);
     +-	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
     ++	return init_db(git_dir, real_git_dir, template_dir, hash_algo, ref_storage_format, flags);
       }
      
       diff --git a/cache.h b/cache.h
       --- a/cache.h
       +++ b/cache.h
      @@
     - #define INIT_DB_EXIST_OK 0x0002
       
       int init_db(const char *git_dir, const char *real_git_dir,
     --	    const char *template_dir, unsigned int flags);
     -+	    const char *template_dir, const char *ref_storage_format,
     -+	    unsigned int flags);
     + 	    const char *template_dir, int hash_algo,
     ++            const char *ref_storage_format,
     + 	    unsigned int flags);
     +-void initialize_repository_version(int hash_algo);
     ++void initialize_repository_version(int hash_algo, const char *ref_storage_format);
       
       void sanitize_stdfds(void);
       int daemonize(void);
     @@ -350,7 +355,6 @@ $^
       struct string_list_item;
       struct worktree;
       
     -+/* XXX where should this be? */
      +#define DEFAULT_REF_STORAGE "files"
      +
       /*
     @@ -386,26 +390,25 @@ $^
      +
      +extern struct ref_storage_be refs_be_reftable;
      +
     -+struct reftable_ref_store {
     ++struct git_reftable_ref_store {
      +	struct ref_store base;
      +	unsigned int store_flags;
      +
      +	int err;
      +	char *reftable_dir;
     -+	char *table_list_file;
     -+	struct stack *stack;
     ++	struct reftable_stack *stack;
      +};
      +
     -+static void clear_log_record(struct log_record *log)
     ++static void clear_reftable_log_record(struct reftable_log_record *log)
      +{
      +	log->old_hash = NULL;
      +	log->new_hash = NULL;
      +	log->message = NULL;
      +	log->ref_name = NULL;
     -+	log_record_clear(log);
     ++	reftable_log_record_clear(log);
      +}
      +
     -+static void fill_log_record(struct log_record *log)
     ++static void fill_reftable_log_record(struct reftable_log_record *log)
      +{
      +	const char *info = git_committer_info(0);
      +	struct ident_split split = {};
     @@ -413,7 +416,7 @@ $^
      +	int sign = 1;
      +	assert(0 == result);
      +
     -+	log_record_clear(log);
     ++	reftable_log_record_clear(log);
      +	log->name =
      +		xstrndup(split.name_begin, split.name_end - split.name_begin);
      +	log->email =
     @@ -431,12 +434,12 @@ $^
      +	log->tz_offset = sign * atoi(split.tz_begin);
      +}
      +
     -+static struct ref_store *reftable_ref_store_create(const char *path,
     ++static struct ref_store *git_reftable_ref_store_create(const char *path,
      +						   unsigned int store_flags)
      +{
     -+	struct reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
     ++	struct git_reftable_ref_store *refs = xcalloc(1, sizeof(*refs));
      +	struct ref_store *ref_store = (struct ref_store *)refs;
     -+	struct write_options cfg = {
     ++	struct reftable_write_options cfg = {
      +		.block_size = 4096,
      +		.hash_id = the_hash_algo->format_id,
      +	};
     @@ -449,10 +452,6 @@ $^
      +	refs->reftable_dir = xstrdup(sb.buf);
      +	strbuf_reset(&sb);
      +
     -+	strbuf_addf(&sb, "%s/reftable/tables.list", path);
     -+	refs->table_list_file = xstrdup(sb.buf);
     -+	strbuf_reset(&sb);
     -+
      +	strbuf_addf(&sb, "%s/refs", path);
      +	safe_create_dir(sb.buf, 1);
      +	strbuf_reset(&sb);
     @@ -464,31 +463,23 @@ $^
      +	strbuf_addf(&sb, "%s/refs/heads", path);
      +	write_file(sb.buf, "this repository uses the reftable format");
      +
     -+	refs->err = new_stack(&refs->stack, refs->reftable_dir,
     -+			      refs->table_list_file, cfg);
     ++	refs->err = reftable_new_stack(&refs->stack, refs->reftable_dir, cfg);
      +	strbuf_release(&sb);
      +	return ref_store;
      +}
      +
      +static int reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
      +{
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     -+	FILE *file;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
      +	safe_create_dir(refs->reftable_dir, 1);
     -+
     -+	file = fopen(refs->table_list_file, "a");
     -+	if (file == NULL) {
     -+		return -1;
     -+	}
     -+	fclose(file);
      +	return 0;
      +}
      +
     -+struct reftable_iterator {
     ++struct git_reftable_iterator {
      +	struct ref_iterator base;
     -+	struct iterator iter;
     -+	struct ref_record ref;
     ++	struct reftable_iterator iter;
     ++	struct reftable_ref_record ref;
      +	struct object_id oid;
      +	struct ref_store *ref_store;
      +	unsigned int flags;
     @@ -498,9 +489,9 @@ $^
      +
      +static int reftable_ref_iterator_advance(struct ref_iterator *ref_iterator)
      +{
     -+	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
     ++	struct git_reftable_iterator *ri = (struct git_reftable_iterator *)ref_iterator;
      +	while (ri->err == 0) {
     -+		ri->err = iterator_next_ref(ri->iter, &ri->ref);
     ++		ri->err = reftable_iterator_next_ref(ri->iter, &ri->ref);
      +		if (ri->err) {
      +			break;
      +		}
     @@ -554,7 +545,7 @@ $^
      +static int reftable_ref_iterator_peel(struct ref_iterator *ref_iterator,
      +				      struct object_id *peeled)
      +{
     -+	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
     ++	struct git_reftable_iterator *ri = (struct git_reftable_iterator *)ref_iterator;
      +	if (ri->ref.target_value != NULL) {
      +		hashcpy(peeled->hash, ri->ref.target_value);
      +		return 0;
     @@ -565,9 +556,9 @@ $^
      +
      +static int reftable_ref_iterator_abort(struct ref_iterator *ref_iterator)
      +{
     -+	struct reftable_iterator *ri = (struct reftable_iterator *)ref_iterator;
     -+	ref_record_clear(&ri->ref);
     -+	iterator_destroy(&ri->iter);
     ++	struct git_reftable_iterator *ri = (struct git_reftable_iterator *)ref_iterator;
     ++	reftable_ref_record_clear(&ri->ref);
     ++	reftable_iterator_destroy(&ri->iter);
      +	return 0;
      +}
      +
     @@ -580,16 +571,16 @@ $^
      +reftable_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
      +			    unsigned int flags)
      +{
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     -+	struct reftable_iterator *ri = xcalloc(1, sizeof(*ri));
     -+	struct merged_table *mt = NULL;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	struct git_reftable_iterator *ri = xcalloc(1, sizeof(*ri));
     ++	struct reftable_merged_table *mt = NULL;
      +
      +	if (refs->err < 0) {
      +		ri->err = refs->err;
      +	} else {
     -+		mt = stack_merged_table(refs->stack);
     -+		ri->err = merged_table_seek_ref(mt, &ri->iter, prefix);
     ++		mt = reftable_stack_merged_table(refs->stack);
     ++		ri->err = reftable_merged_table_seek_ref(mt, &ri->iter, prefix);
      +	}
      +
      +	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
     @@ -610,8 +601,8 @@ $^
      +				      struct ref_transaction *transaction,
      +				      struct strbuf *err)
      +{
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
      +	(void)refs;
      +	return 0;
      +}
     @@ -640,19 +631,19 @@ $^
      +		      ((struct ref_update *)b)->refname);
      +}
      +
     -+static int write_transaction_table(struct writer *writer, void *arg)
     ++static int write_transaction_table(struct reftable_writer *writer, void *arg)
      +{
      +	struct ref_transaction *transaction = (struct ref_transaction *)arg;
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)transaction->ref_store;
     -+	uint64_t ts = stack_next_update_index(refs->stack);
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)transaction->ref_store;
     ++	uint64_t ts = reftable_stack_next_update_index(refs->stack);
      +	int err = 0;
     -+	struct log_record *logs = calloc(transaction->nr, sizeof(*logs));
     ++	struct reftable_log_record *logs = calloc(transaction->nr, sizeof(*logs));
      +	struct ref_update **sorted =
      +		malloc(transaction->nr * sizeof(struct ref_update *));
      +	COPY_ARRAY(sorted, transaction->updates, transaction->nr);
      +	QSORT(sorted, transaction->nr, ref_update_cmp);
     -+	writer_set_limits(writer, ts, ts);
     ++	reftable_writer_set_limits(writer, ts, ts);
      +
      +	for (int i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = sorted[i];
     @@ -667,8 +658,8 @@ $^
      +
      +	for (int i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = sorted[i];
     -+		struct log_record *log = &logs[i];
     -+		fill_log_record(log);
     ++		struct reftable_log_record *log = &logs[i];
     ++		fill_reftable_log_record(log);
      +		log->ref_name = (char *)u->refname;
      +		log->old_hash = u->old_oid.hash;
      +		log->new_hash = u->new_oid.hash;
     @@ -683,13 +674,13 @@ $^
      +			const char *resolved = refs_resolve_ref_unsafe(
      +				transaction->ref_store, u->refname, 0, &out_oid,
      +				&out_flags);
     -+			struct ref_record ref = {};
     ++			struct reftable_ref_record ref = {};
      +			ref.ref_name =
      +				(char *)(resolved ? resolved : u->refname);
      +			log->ref_name = ref.ref_name;
      +			ref.value = u->new_oid.hash;
      +			ref.update_index = ts;
     -+			err = writer_add_ref(writer, &ref);
     ++			err = reftable_writer_add_ref(writer, &ref);
      +			if (err < 0) {
      +				goto exit;
      +			}
     @@ -697,8 +688,8 @@ $^
      +	}
      +
      +	for (int i = 0; i < transaction->nr; i++) {
     -+		err = writer_add_log(writer, &logs[i]);
     -+		clear_log_record(&logs[i]);
     ++		err = reftable_writer_add_log(writer, &logs[i]);
     ++		clear_reftable_log_record(&logs[i]);
      +		if (err < 0) {
      +			goto exit;
      +		}
     @@ -714,17 +705,17 @@ $^
      +				       struct ref_transaction *transaction,
      +				       struct strbuf *errmsg)
      +{
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
      +	int err = 0;
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
      +
     -+	err = stack_add(refs->stack, &write_transaction_table, transaction);
     ++	err = reftable_stack_add(refs->stack, &write_transaction_table, transaction);
      +	if (err < 0) {
      +		strbuf_addf(errmsg, "reftable: transaction failure %s",
     -+			    error_str(err));
     ++			    reftable_error_str(err));
      +		return -1;
      +	}
      +
     @@ -739,49 +730,49 @@ $^
      +}
      +
      +struct write_delete_refs_arg {
     -+	struct stack *stack;
     ++	struct reftable_stack *stack;
      +	struct string_list *refnames;
      +	const char *logmsg;
      +	unsigned int flags;
      +};
      +
     -+static int write_delete_refs_table(struct writer *writer, void *argv)
     ++static int write_delete_refs_table(struct reftable_writer *writer, void *argv)
      +{
      +	struct write_delete_refs_arg *arg =
      +		(struct write_delete_refs_arg *)argv;
     -+	uint64_t ts = stack_next_update_index(arg->stack);
     ++	uint64_t ts = reftable_stack_next_update_index(arg->stack);
      +	int err = 0;
      +
     -+	writer_set_limits(writer, ts, ts);
     ++	reftable_writer_set_limits(writer, ts, ts);
      +	for (int i = 0; i < arg->refnames->nr; i++) {
     -+		struct ref_record ref = {
     ++		struct reftable_ref_record ref = {
      +			.ref_name = (char *)arg->refnames->items[i].string,
      +			.update_index = ts,
      +		};
     -+		err = writer_add_ref(writer, &ref);
     ++		err = reftable_writer_add_ref(writer, &ref);
      +		if (err < 0) {
      +			return err;
      +		}
      +	}
      +
      +	for (int i = 0; i < arg->refnames->nr; i++) {
     -+		struct log_record log = {};
     -+		struct ref_record current = {};
     -+		fill_log_record(&log);
     ++		struct reftable_log_record log = {};
     ++		struct reftable_ref_record current = {};
     ++		fill_reftable_log_record(&log);
      +		log.message = xstrdup(arg->logmsg);
      +		log.new_hash = NULL;
      +		log.old_hash = NULL;
      +		log.update_index = ts;
      +		log.ref_name = (char *)arg->refnames->items[i].string;
      +
     -+		if (stack_read_ref(arg->stack, log.ref_name, &current) == 0) {
     ++		if (reftable_stack_read_ref(arg->stack, log.ref_name, &current) == 0) {
      +			log.old_hash = current.value;
      +		}
     -+		err = writer_add_log(writer, &log);
     ++		err = reftable_writer_add_log(writer, &log);
      +		log.old_hash = NULL;
     -+		ref_record_clear(&current);
     ++		reftable_ref_record_clear(&current);
      +
     -+		clear_log_record(&log);
     ++		clear_reftable_log_record(&log);
      +		if (err < 0) {
      +			return err;
      +		}
     @@ -793,8 +784,8 @@ $^
      +				struct string_list *refnames,
      +				unsigned int flags)
      +{
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
      +	struct write_delete_refs_arg arg = {
      +		.stack = refs->stack,
      +		.refnames = refnames,
     @@ -805,52 +796,52 @@ $^
      +		return refs->err;
      +	}
      +
     -+	return stack_add(refs->stack, &write_delete_refs_table, &arg);
     ++	return reftable_stack_add(refs->stack, &write_delete_refs_table, &arg);
      +}
      +
      +static int reftable_pack_refs(struct ref_store *ref_store, unsigned int flags)
      +{
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
     -+	return stack_compact_all(refs->stack, NULL);
     ++	return reftable_stack_compact_all(refs->stack, NULL);
      +}
      +
      +struct write_create_symref_arg {
     -+	struct reftable_ref_store *refs;
     ++	struct git_reftable_ref_store *refs;
      +	const char *refname;
      +	const char *target;
      +	const char *logmsg;
      +};
      +
     -+static int write_create_symref_table(struct writer *writer, void *arg)
     ++static int write_create_symref_table(struct reftable_writer *writer, void *arg)
      +{
      +	struct write_create_symref_arg *create =
      +		(struct write_create_symref_arg *)arg;
     -+	uint64_t ts = stack_next_update_index(create->refs->stack);
     ++	uint64_t ts = reftable_stack_next_update_index(create->refs->stack);
      +	int err = 0;
      +
     -+	struct ref_record ref = {
     ++	struct reftable_ref_record ref = {
      +		.ref_name = (char *)create->refname,
      +		.target = (char *)create->target,
      +		.update_index = ts,
      +	};
     -+	writer_set_limits(writer, ts, ts);
     -+	err = writer_add_ref(writer, &ref);
     ++	reftable_writer_set_limits(writer, ts, ts);
     ++	err = reftable_writer_add_ref(writer, &ref);
      +	if (err < 0) {
      +		return err;
      +	}
      +
      +	{
     -+		struct log_record log = {};
     ++		struct reftable_log_record log = {};
      +		struct object_id new_oid = {};
      +		struct object_id old_oid = {};
     -+		struct ref_record current = {};
     -+		stack_read_ref(create->refs->stack, create->refname, &current);
     ++		struct reftable_ref_record current = {};
     ++		reftable_stack_read_ref(create->refs->stack, create->refname, &current);
      +
     -+		fill_log_record(&log);
     ++		fill_reftable_log_record(&log);
      +		log.ref_name = current.ref_name;
      +		if (refs_resolve_ref_unsafe(
      +			    (struct ref_store *)create->refs, create->refname,
     @@ -865,12 +856,12 @@ $^
      +		}
      +
      +		if (log.old_hash != NULL || log.new_hash != NULL) {
     -+			writer_add_log(writer, &log);
     ++			reftable_writer_add_log(writer, &log);
      +		}
      +		log.ref_name = NULL;
      +		log.old_hash = NULL;
      +		log.new_hash = NULL;
     -+		clear_log_record(&log);
     ++		clear_reftable_log_record(&log);
      +	}
      +	return 0;
      +}
     @@ -879,8 +870,8 @@ $^
      +				  const char *refname, const char *target,
      +				  const char *logmsg)
      +{
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
      +	struct write_create_symref_arg arg = { .refs = refs,
      +					       .refname = refname,
      +					       .target = target,
     @@ -888,55 +879,55 @@ $^
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
     -+	return stack_add(refs->stack, &write_create_symref_table, &arg);
     ++	return reftable_stack_add(refs->stack, &write_create_symref_table, &arg);
      +}
      +
      +struct write_rename_arg {
     -+	struct stack *stack;
     ++	struct reftable_stack *stack;
      +	const char *oldname;
      +	const char *newname;
      +	const char *logmsg;
      +};
      +
     -+static int write_rename_table(struct writer *writer, void *argv)
     ++static int write_rename_table(struct reftable_writer *writer, void *argv)
      +{
      +	struct write_rename_arg *arg = (struct write_rename_arg *)argv;
     -+	uint64_t ts = stack_next_update_index(arg->stack);
     -+	struct ref_record ref = {};
     -+	int err = stack_read_ref(arg->stack, arg->oldname, &ref);
     ++	uint64_t ts = reftable_stack_next_update_index(arg->stack);
     ++	struct reftable_ref_record ref = {};
     ++	int err = reftable_stack_read_ref(arg->stack, arg->oldname, &ref);
      +
      +	if (err) {
      +		goto exit;
      +	}
      +
      +	/* XXX do ref renames overwrite the target? */
     -+	if (stack_read_ref(arg->stack, arg->newname, &ref) == 0) {
     ++	if (reftable_stack_read_ref(arg->stack, arg->newname, &ref) == 0) {
      +		goto exit;
      +	}
      +
      +	free(ref.ref_name);
      +	ref.ref_name = strdup(arg->newname);
     -+	writer_set_limits(writer, ts, ts);
     ++	reftable_writer_set_limits(writer, ts, ts);
      +	ref.update_index = ts;
      +
      +	{
     -+		struct ref_record todo[2] = {};
     ++		struct reftable_ref_record todo[2] = {};
      +		todo[0].ref_name = (char *)arg->oldname;
      +		todo[0].update_index = ts;
      +		/* leave todo[0] empty */
      +		todo[1] = ref;
      +		todo[1].update_index = ts;
      +
     -+		err = writer_add_refs(writer, todo, 2);
     ++		err = reftable_writer_add_refs(writer, todo, 2);
      +		if (err < 0) {
      +			goto exit;
      +		}
      +	}
      +
      +	if (ref.value != NULL) {
     -+		struct log_record todo[2] = {};
     -+		fill_log_record(&todo[0]);
     -+		fill_log_record(&todo[1]);
     ++		struct reftable_log_record todo[2] = {};
     ++		fill_reftable_log_record(&todo[0]);
     ++		fill_reftable_log_record(&todo[1]);
      +
      +		todo[0].ref_name = (char *)arg->oldname;
      +		todo[0].update_index = ts;
     @@ -950,10 +941,10 @@ $^
      +		todo[1].new_hash = ref.value;
      +		todo[1].message = (char *)arg->logmsg;
      +
     -+		err = writer_add_logs(writer, todo, 2);
     ++		err = reftable_writer_add_logs(writer, todo, 2);
      +
     -+		clear_log_record(&todo[0]);
     -+		clear_log_record(&todo[1]);
     ++		clear_reftable_log_record(&todo[0]);
     ++		clear_reftable_log_record(&todo[1]);
      +
      +		if (err < 0) {
      +			goto exit;
     @@ -964,7 +955,7 @@ $^
      +	}
      +
      +exit:
     -+	ref_record_clear(&ref);
     ++	reftable_ref_record_clear(&ref);
      +	return err;
      +}
      +
     @@ -972,8 +963,8 @@ $^
      +			       const char *oldrefname, const char *newrefname,
      +			       const char *logmsg)
      +{
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
      +	struct write_rename_arg arg = {
      +		.stack = refs->stack,
      +		.oldname = oldrefname,
     @@ -984,7 +975,7 @@ $^
      +		return refs->err;
      +	}
      +
     -+	return stack_add(refs->stack, &write_rename_table, &arg);
     ++	return reftable_stack_add(refs->stack, &write_rename_table, &arg);
      +}
      +
      +static int reftable_copy_ref(struct ref_store *ref_store,
     @@ -996,8 +987,8 @@ $^
      +
      +struct reftable_reflog_ref_iterator {
      +	struct ref_iterator base;
     -+	struct iterator iter;
     -+	struct log_record log;
     ++	struct reftable_iterator iter;
     ++	struct reftable_log_record log;
      +	struct object_id oid;
      +	char *last_name;
      +};
     @@ -1009,7 +1000,7 @@ $^
      +		(struct reftable_reflog_ref_iterator *)ref_iterator;
      +
      +	while (1) {
     -+		int err = iterator_next_log(ri->iter, &ri->log);
     ++		int err = reftable_iterator_next_log(ri->iter, &ri->log);
      +		if (err > 0) {
      +			return ITER_DONE;
      +		}
     @@ -1041,8 +1032,8 @@ $^
      +{
      +	struct reftable_reflog_ref_iterator *ri =
      +		(struct reftable_reflog_ref_iterator *)ref_iterator;
     -+	log_record_clear(&ri->log);
     -+	iterator_destroy(&ri->iter);
     ++	reftable_log_record_clear(&ri->log);
     ++	reftable_iterator_destroy(&ri->iter);
      +	return 0;
      +}
      +
     @@ -1055,11 +1046,11 @@ $^
      +reftable_reflog_iterator_begin(struct ref_store *ref_store)
      +{
      +	struct reftable_reflog_ref_iterator *ri = xcalloc(sizeof(*ri), 1);
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
      +
     -+	struct merged_table *mt = stack_merged_table(refs->stack);
     -+	int err = merged_table_seek_log(mt, &ri->iter, "");
     ++	struct reftable_merged_table *mt = reftable_stack_merged_table(refs->stack);
     ++	int err = reftable_merged_table_seek_log(mt, &ri->iter, "");
      +	if (err < 0) {
      +		free(ri);
      +		return NULL;
     @@ -1077,21 +1068,21 @@ $^
      +					  const char *refname,
      +					  each_reflog_ent_fn fn, void *cb_data)
      +{
     -+	struct iterator it = {};
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     -+	struct merged_table *mt = NULL;
     ++	struct reftable_iterator it = {};
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_merged_table *mt = NULL;
      +	int err = 0;
     -+	struct log_record log = {};
     ++	struct reftable_log_record log = {};
      +
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
      +
     -+	mt = stack_merged_table(refs->stack);
     -+	err = merged_table_seek_log(mt, &it, refname);
     ++	mt = reftable_stack_merged_table(refs->stack);
     ++	err = reftable_merged_table_seek_log(mt, &it, refname);
      +	while (err == 0) {
     -+		err = iterator_next_log(it, &log);
     ++		err = reftable_iterator_next_log(it, &log);
      +		if (err != 0) {
      +			break;
      +		}
     @@ -1120,8 +1111,8 @@ $^
      +		}
      +	}
      +
     -+	log_record_clear(&log);
     -+	iterator_destroy(&it);
     ++	reftable_log_record_clear(&log);
     ++	reftable_iterator_destroy(&it);
      +	if (err > 0) {
      +		err = 0;
      +	}
     @@ -1133,11 +1124,11 @@ $^
      +					  const char *refname,
      +					  each_reflog_ent_fn fn, void *cb_data)
      +{
     -+	struct iterator it = {};
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     -+	struct merged_table *mt = NULL;
     -+	struct log_record *logs = NULL;
     ++	struct reftable_iterator it = {};
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_merged_table *mt = NULL;
     ++	struct reftable_log_record *logs = NULL;
      +	int cap = 0;
      +	int len = 0;
      +	int err = 0;
     @@ -1145,12 +1136,12 @@ $^
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
     -+	mt = stack_merged_table(refs->stack);
     -+	err = merged_table_seek_log(mt, &it, refname);
     ++	mt = reftable_stack_merged_table(refs->stack);
     ++	err = reftable_merged_table_seek_log(mt, &it, refname);
      +
      +	while (err == 0) {
     -+		struct log_record log = {};
     -+		err = iterator_next_log(it, &log);
     ++		struct reftable_log_record log = {};
     ++		err = reftable_iterator_next_log(it, &log);
      +		if (err != 0) {
      +			break;
      +		}
     @@ -1168,7 +1159,7 @@ $^
      +	}
      +
      +	for (int i = len; i--;) {
     -+		struct log_record *log = &logs[i];
     ++		struct reftable_log_record *log = &logs[i];
      +		struct object_id old_oid = {};
      +		struct object_id new_oid = {};
      +		const char *full_committer = "";
     @@ -1187,11 +1178,11 @@ $^
      +	}
      +
      +	for (int i = 0; i < len; i++) {
     -+		log_record_clear(&logs[i]);
     ++		reftable_log_record_clear(&logs[i]);
      +	}
      +	free(logs);
      +
     -+	iterator_destroy(&it);
     ++	reftable_iterator_destroy(&it);
      +	if (err > 0) {
      +		err = 0;
      +	}
     @@ -1219,8 +1210,8 @@ $^
      +}
      +
      +struct reflog_expiry_arg {
     -+	struct reftable_ref_store *refs;
     -+	struct log_record *tombstones;
     ++	struct git_reftable_ref_store *refs;
     ++	struct reftable_log_record *tombstones;
      +	int len;
      +	int cap;
      +};
     @@ -1229,7 +1220,7 @@ $^
      +{
      +	int i = 0;
      +	for (; i < arg->len; i++) {
     -+		log_record_clear(&arg->tombstones[i]);
     ++		reftable_log_record_clear(&arg->tombstones[i]);
      +	}
      +
      +	FREE_AND_NULL(arg->tombstones);
     @@ -1238,7 +1229,7 @@ $^
      +static void add_log_tombstone(struct reflog_expiry_arg *arg,
      +			      const char *refname, uint64_t ts)
      +{
     -+	struct log_record tombstone = {
     ++	struct reftable_log_record tombstone = {
      +		.ref_name = xstrdup(refname),
      +		.update_index = ts,
      +	};
     @@ -1250,14 +1241,14 @@ $^
      +	arg->tombstones[arg->len++] = tombstone;
      +}
      +
     -+static int write_reflog_expiry_table(struct writer *writer, void *argv)
     ++static int write_reflog_expiry_table(struct reftable_writer *writer, void *argv)
      +{
      +	struct reflog_expiry_arg *arg = (struct reflog_expiry_arg *)argv;
     -+	uint64_t ts = stack_next_update_index(arg->refs->stack);
     ++	uint64_t ts = reftable_stack_next_update_index(arg->refs->stack);
      +	int i = 0;
     -+	writer_set_limits(writer, ts, ts);
     ++	reftable_writer_set_limits(writer, ts, ts);
      +	for (i = 0; i < arg->len; i++) {
     -+		int err = writer_add_log(writer, &arg->tombstones[i]);
     ++		int err = reftable_writer_add_log(writer, &arg->tombstones[i]);
      +		if (err) {
      +			return err;
      +		}
     @@ -1286,21 +1277,21 @@ $^
      +	  It would be better if the refs backend supported an API that sets a
      +	  criterion for all refs, passing the criterion to pack_refs().
      +	*/
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     -+	struct merged_table *mt = NULL;
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_merged_table *mt = NULL;
      +	struct reflog_expiry_arg arg = {
      +		.refs = refs,
      +	};
     -+	struct log_record log = {};
     -+	struct iterator it = {};
     ++	struct reftable_log_record log = {};
     ++	struct reftable_iterator it = {};
      +	int err = 0;
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
      +
     -+	mt = stack_merged_table(refs->stack);
     -+	err = merged_table_seek_log(mt, &it, refname);
     ++	mt = reftable_stack_merged_table(refs->stack);
     ++	err = reftable_merged_table_seek_log(mt, &it, refname);
      +	if (err < 0) {
      +		return err;
      +	}
     @@ -1309,7 +1300,7 @@ $^
      +		struct object_id ooid = {};
      +		struct object_id noid = {};
      +
     -+		int err = iterator_next_log(it, &log);
     ++		int err = reftable_iterator_next_log(it, &log);
      +		if (err < 0) {
      +			return err;
      +		}
     @@ -1326,9 +1317,9 @@ $^
      +			add_log_tombstone(&arg, refname, log.update_index);
      +		}
      +	}
     -+	log_record_clear(&log);
     -+	iterator_destroy(&it);
     -+	err = stack_add(refs->stack, &write_reflog_expiry_table, &arg);
     ++	reftable_log_record_clear(&log);
     ++	reftable_iterator_destroy(&it);
     ++	err = reftable_stack_add(refs->stack, &write_reflog_expiry_table, &arg);
      +	clear_log_tombstones(&arg);
      +	return err;
      +}
     @@ -1337,15 +1328,15 @@ $^
      +				 const char *refname, struct object_id *oid,
      +				 struct strbuf *referent, unsigned int *type)
      +{
     -+	struct reftable_ref_store *refs =
     -+		(struct reftable_ref_store *)ref_store;
     -+	struct ref_record ref = {};
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_ref_record ref = {};
      +	int err = 0;
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
      +
     -+	err = stack_read_ref(refs->stack, refname, &ref);
     ++	err = reftable_stack_read_ref(refs->stack, refname, &ref);
      +	if (err) {
      +		goto exit;
      +	}
     @@ -1358,14 +1349,14 @@ $^
      +		hashcpy(oid->hash, ref.value);
      +	}
      +exit:
     -+	ref_record_clear(&ref);
     ++	reftable_ref_record_clear(&ref);
      +	return err;
      +}
      +
      +struct ref_storage_be refs_be_reftable = {
      +	&refs_be_files,
      +	"reftable",
     -+	reftable_ref_store_create,
     ++	git_reftable_ref_store_create,
      +	reftable_init_db,
      +	reftable_transaction_prepare,
      +	reftable_transaction_finish,
     @@ -1471,24 +1462,28 @@ $^
      +. ./test-lib.sh
      +
      +test_expect_success 'basic operation of reftable storage' '
     -+        git init --ref-storage=reftable repo &&
     -+        cd repo &&
     -+        echo "hello" > world.txt &&
     -+        git add world.txt &&
     -+        git commit -m "first post" &&
     -+        printf "HEAD\nrefs/heads/master\n" > want &&
     -+        git show-ref | cut -f2 -d" " > got &&
     -+        test_cmp got want &&
     -+        for count in $(test_seq 1 10); do
     -+                echo "hello" >> world.txt
     -+                git commit -m "number ${count}" world.txt
     -+        done &&
     -+        git gc &&
     -+        nfiles=$(ls -1 .git/reftable | wc -l | tr -d "[ \t]" ) &&
     -+        test "${nfiles}" = "2" &&
     -+        git reflog refs/heads/master > output &&
     -+        grep "commit (initial): first post" output &&
     -+        grep "commit: number 10" output
     ++	git init --ref-storage=reftable repo && (
     ++	cd repo &&
     ++	echo "hello" >world.txt &&
     ++	git add world.txt &&
     ++	git commit -m "first post" &&
     ++	test_write_lines HEAD refs/heads/master >expect &&
     ++	git show-ref &&
     ++	git show-ref | cut -f2 -d" " > actual &&
     ++	test_cmp actual expect &&
     ++	for count in $(test_seq 1 10)
     ++	do
     ++		echo "hello" >>world.txt
     ++		git commit -m "number ${count}" world.txt ||
     ++		return 1
     ++	done &&
     ++	git gc &&
     ++	nfiles=$(ls -1 .git/reftable | wc -l ) &&
     ++	test ${nfiles} = "2" &&
     ++	git reflog refs/heads/master >output &&
     ++	test_line_count = 11 output &&
     ++	grep "commit (initial): first post" output &&
     ++	grep "commit: number 10" output )
      +'
      +
      +test_done

-- 
gitgitgadget
