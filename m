Return-Path: <SRS0=Jtyc=AD=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2FD8C433E1
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F7A52073E
	for <git@archiver.kernel.org>; Mon, 22 Jun 2020 21:55:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lPKxpa0t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbgFVVzk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Jun 2020 17:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730753AbgFVVz2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Jun 2020 17:55:28 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46827C061796
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:27 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id c3so18277832wru.12
        for <git@vger.kernel.org>; Mon, 22 Jun 2020 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=oY31mkBDuaruxD9jmacWoJI40vg7SI3ULj/u9r9SwT4=;
        b=lPKxpa0t8DBvjdg/E6Qxt8zcO9FW9yprqRk96c4GhmGdsBDoPaO4QXYwgQMC42usB6
         cNMzA810g0DsuIcqP/eqzwKfCsrn80tX35RO0VwqQTAVbg6KtQXh8sMYYNlJ00/Xx2uY
         TPw8b+n2GZ4j2FSm2ufIG58sjBqW/iMq8/PMTidD3wpq7iuf/w2a0r811ihjw/es/ZtI
         qliN39/JGUh7aktsJIw60ONzLvzYJIEXjxHOa3GFu2iyCc3SFhCYRiUVloMtzhuWbnDA
         cRz3hywKEXspoP/nTURry3/B9sXVHqJ0bwt6vo/DkngdkBoMDDts2IlYi9WuA/Vhdahf
         e6wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=oY31mkBDuaruxD9jmacWoJI40vg7SI3ULj/u9r9SwT4=;
        b=HeA8Sh9kobTSKFrPNlvycU0AO83JANXjlt2T98ZwrsAvytGOiTaSUjxMi0qhUuQkPi
         lwsERFpvWo8ekN1deFTSq3kqqT4m2eaaJ3meNMvJzG9Ksqhc5LRzIqXvVdJ3oXvD1yH4
         dJiyu4V7LEEv2YM2X8mfjBT2rLmxfRS/cASIC6z+KCPGP9MdOmxvSTg4XbTj9ODFRQj4
         xqS5mdH+crbjloKk6mli1ABHE34+6RWz9S4BeZNyJDDkEujxGi3E65BOWZROHUkT0UvH
         JuxEwVBEw1IaAkCaq3vXpHfcovsazwZJaiTfX94uOlB73RIEwA/uYU0reyUSheZPe1Rv
         YSeg==
X-Gm-Message-State: AOAM533pujsDm+PHOf7zo35UFfm/zgCHtwMaEmND16GQY0Bbn6o9eNZ4
        Az+OZSY3BhcTCEXqwO6Uk5iS7SPE
X-Google-Smtp-Source: ABdhPJxz02Dp59Kwm1mIE9jGcX5hpbGNpsNwg+NKgugt4ro+38+y+tHaCVH3Tw6zbCkhilUV4IqkTA==
X-Received: by 2002:adf:f311:: with SMTP id i17mr6537036wro.237.1592862922941;
        Mon, 22 Jun 2020 14:55:22 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id d13sm8461425wrq.89.2020.06.22.14.55.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 14:55:22 -0700 (PDT)
Message-Id: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
References: <pull.539.v17.git.1592335242.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 22 Jun 2020 21:55:01 +0000
Subject: [PATCH v18 00/19] Reftable support git-core
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the reftable library, and hooks it up as a ref backend. Based on
hn/refs-cleanup.

Includes testing support, to test: make -C t/ GIT_TEST_REFTABLE=1

Summary 21561 tests pass 899 tests fail

Some issues:

 * many tests inspect .git/{logs,heads}/ directly.
 * worktrees broken. 

v21

 * reftable/ is now fully imported from upstream.
 * reftable/ uses strbuf
 * fix of the HEAD file.
 * check for reload on every read

Han-Wen Nienhuys (17):
  lib-t6000.sh: write tag using git-update-ref
  checkout: add '\n' to reflog message
  Write pseudorefs through ref backends.
  Make refs_ref_exists public
  Treat BISECT_HEAD as a pseudo ref
  Treat CHERRY_PICK_HEAD as a pseudo ref
  Treat REVERT_HEAD as a pseudo ref
  Move REF_LOG_ONLY to refs-internal.h
  Iterate over the "refs/" namespace in for_each_[raw]ref
  Add .gitattributes for the reftable/ directory
  Add reftable library
  Add standalone build infrastructure for reftable
  Reftable support for git-core
  Hookup unittests for the reftable library.
  Add GIT_DEBUG_REFS debugging mechanism
  Add reftable testing infrastructure
  Add "test-tool dump-reftable" command.

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

SZEDER Gábor (1):
  git-prompt: prepare for reftable refs backend

 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   47 +-
 builtin/bisect--helper.c                      |    3 +-
 builtin/checkout.c                            |    5 +-
 builtin/clone.c                               |    3 +-
 builtin/commit.c                              |   34 +-
 builtin/init-db.c                             |   56 +-
 builtin/merge.c                               |    2 +-
 cache.h                                       |    6 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 contrib/completion/git-prompt.sh              |    7 +-
 git-bisect.sh                                 |    4 +-
 path.c                                        |    2 -
 path.h                                        |    9 +-
 refs.c                                        |  157 +-
 refs.h                                        |   16 +
 refs/debug.c                                  |  411 +++++
 refs/files-backend.c                          |  121 +-
 refs/packed-backend.c                         |   21 +-
 refs/refs-internal.h                          |   32 +
 refs/reftable-backend.c                       | 1335 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/BUILD                                |  203 +++
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   33 +
 reftable/VERSION                              |    1 +
 reftable/WORKSPACE                            |   14 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  432 ++++++
 reftable/block.h                              |  129 ++
 reftable/block_test.c                         |  157 ++
 reftable/compat.c                             |   98 ++
 reftable/compat.h                             |   48 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |  212 +++
 reftable/file.c                               |   95 ++
 reftable/iter.c                               |  242 +++
 reftable/iter.h                               |   72 +
 reftable/merged.c                             |  321 ++++
 reftable/merged.h                             |   39 +
 reftable/merged_test.c                        |  273 ++++
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  744 +++++++++
 reftable/reader.h                             |   65 +
 reftable/record.c                             | 1126 ++++++++++++++
 reftable/record.h                             |  143 ++
 reftable/record_test.c                        |  410 +++++
 reftable/refname.c                            |  209 +++
 reftable/refname.h                            |   38 +
 reftable/refname_test.c                       |   99 ++
 reftable/reftable-tests.h                     |   22 +
 reftable/reftable.c                           |   90 ++
 reftable/reftable.h                           |  571 +++++++
 reftable/reftable_test.c                      |  631 ++++++++
 reftable/stack.c                              | 1209 +++++++++++++++
 reftable/stack.h                              |   48 +
 reftable/stack_test.c                         |  787 ++++++++++
 reftable/strbuf.c                             |  206 +++
 reftable/strbuf.h                             |   88 ++
 reftable/strbuf_test.c                        |   39 +
 reftable/system.h                             |   53 +
 reftable/test_framework.c                     |   69 +
 reftable/test_framework.h                     |   64 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/tree_test.c                          |   62 +
 reftable/update.sh                            |   19 +
 reftable/writer.c                             |  662 ++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 reftable/zlib.BUILD                           |   36 +
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 sequencer.c                                   |   56 +-
 setup.c                                       |   12 +-
 t/helper/test-reftable.c                      |   20 +
 t/helper/test-tool.c                          |    2 +
 t/helper/test-tool.h                          |    2 +
 t/lib-t6000.sh                                |    5 +-
 t/t0031-reftable.sh                           |  160 ++
 t/t0033-debug-refs.sh                         |   18 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    5 +
 wt-status.c                                   |    6 +-
 89 files changed, 12977 insertions(+), 201 deletions(-)
 create mode 100644 refs/debug.c
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/BUILD
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/WORKSPACE
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/compat.c
 create mode 100644 reftable/compat.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/reftable_test.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/strbuf.c
 create mode 100644 reftable/strbuf.h
 create mode 100644 reftable/strbuf_test.c
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100755 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100644 reftable/zlib.BUILD
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0031-reftable.sh
 create mode 100755 t/t0033-debug-refs.sh


base-commit: 4d328a12d95bbea4e742463974ca03e49933bf7e
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v18
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v18
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v17:

  1:  8304c3d6379 =  1:  b968b795af9 lib-t6000.sh: write tag using git-update-ref
  2:  4012d801e3c =  2:  52102259773 checkout: add '\n' to reflog message
  3:  95a6a1d968e =  3:  15c9dd66e17 Write pseudorefs through ref backends.
  4:  1f8865f4b3e =  4:  a5bce2e3fe6 Make refs_ref_exists public
  5:  7f376a76d84 =  5:  a29d898907a Treat BISECT_HEAD as a pseudo ref
  6:  959c69b5ee4 =  6:  11a690d2b8e Treat CHERRY_PICK_HEAD as a pseudo ref
  7:  3f18475d0d3 =  7:  4e52ec0dbc1 Treat REVERT_HEAD as a pseudo ref
  8:  4981e5395c6 =  8:  37e350af159 Move REF_LOG_ONLY to refs-internal.h
  9:  f452c48ae44 =  9:  468f00eaf67 Iterate over the "refs/" namespace in for_each_[raw]ref
 10:  1fa68d5d34f = 10:  21febeaa81f Add .gitattributes for the reftable/ directory
 11:  86646c834c2 ! 11:  3c84f43cfa0 Add reftable library
     @@ Metadata
       ## Commit message ##
          Add reftable library
      
     -    Reftable is a format for storing the ref database. Its rationale and
     -    specification is in the preceding commit.
     +    Reftable is a format for storing the ref database. The rationale and format
     +    layout is detailed in commit 35e6c47404 ("reftable: file format documentation",
     +    2020-05-20).
      
     -    This imports the upstream library as one big commit. For understanding
     -    the code, it is suggested to read the code in the following order:
     +    This commits imports a fully functioning library for reading and writing
     +    reftables, along with unittests.
     +
     +    It is suggested to read the code in the following order:
      
          * The specification under Documentation/technical/reftable.txt
      
     @@ Commit message
      
          * block.{c,h} - reading and writing blocks.
      
     +    * reader.{c,h} - reading a complete reftable file.
     +
          * writer.{c,h} - writing a complete reftable file.
      
          * merged.{c,h} and pq.{c,h} - reading a stack of reftables
     @@ reftable/LICENSE (new)
      +(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
      +OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
      
     - ## reftable/README.md (new) ##
     -@@
     -+
     -+The source code in this directory comes from https://github.com/google/reftable.
     -+
     -+The VERSION file keeps track of the current version of the reftable library.
     -+
     -+To update the library, do:
     -+
     -+   sh reftable/update.sh
     -+
     -+Bugfixes should be accompanied by a test and applied to upstream project at
     -+https://github.com/google/reftable.
     -
       ## reftable/VERSION (new) ##
      @@
     -+2c91c4b305dcbf6500c0806bb1a7fbcfc668510c C: include system.h in compat.h
     ++d7472cbd1afe6bf3da53e94971b1cc79ce183fa8 Remove outdated bits of the README file
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/basics.c (new)
      +
      +#include "system.h"
      +
     -+void put_be24(byte *out, uint32_t i)
     ++void put_be24(uint8_t *out, uint32_t i)
      +{
     -+	out[0] = (byte)((i >> 16) & 0xff);
     -+	out[1] = (byte)((i >> 8) & 0xff);
     -+	out[2] = (byte)(i & 0xff);
     ++	out[0] = (uint8_t)((i >> 16) & 0xff);
     ++	out[1] = (uint8_t)((i >> 8) & 0xff);
     ++	out[2] = (uint8_t)(i & 0xff);
      +}
      +
     -+uint32_t get_be24(byte *in)
     ++uint32_t get_be24(uint8_t *in)
      +{
      +	return (uint32_t)(in[0]) << 16 | (uint32_t)(in[1]) << 8 |
      +	       (uint32_t)(in[2]);
     @@ reftable/basics.h (new)
      +
      +/* Bigendian en/decoding of integers */
      +
     -+void put_be24(byte *out, uint32_t i);
     -+uint32_t get_be24(byte *in);
     ++void put_be24(uint8_t *out, uint32_t i);
     ++uint32_t get_be24(uint8_t *in);
      +void put_be16(uint8_t *out, uint16_t i);
      +
      +/*
     @@ reftable/block.c (new)
      +}
      +
      +int block_writer_register_restart(struct block_writer *w, int n, bool restart,
     -+				  struct slice *key);
     ++				  struct strbuf *key);
      +
     -+void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
     ++void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
      +		       uint32_t block_size, uint32_t header_off, int hash_size)
      +{
      +	bw->buf = buf;
     @@ reftable/block.c (new)
      +	bw->entries = 0;
      +	bw->restart_len = 0;
      +	bw->last_key.len = 0;
     -+	bw->last_key.canary = SLICE_CANARY;
      +}
      +
     -+byte block_writer_type(struct block_writer *bw)
     ++uint8_t block_writer_type(struct block_writer *bw)
      +{
      +	return bw->buf[bw->header_off];
      +}
     @@ reftable/block.c (new)
      +   success */
      +int block_writer_add(struct block_writer *w, struct reftable_record *rec)
      +{
     -+	struct slice empty = SLICE_INIT;
     -+	struct slice last = w->entries % w->restart_interval == 0 ? empty :
     -+								    w->last_key;
     -+	struct slice out = {
     ++	struct strbuf empty = STRBUF_INIT;
     ++	struct strbuf last =
     ++		w->entries % w->restart_interval == 0 ? empty : w->last_key;
     ++	struct string_view out = {
      +		.buf = w->buf + w->next,
      +		.len = w->block_size - w->next,
     -+		.canary = SLICE_CANARY,
      +	};
      +
     -+	struct slice start = out;
     ++	struct string_view start = out;
      +
      +	bool restart = false;
     -+	struct slice key = SLICE_INIT;
     ++	struct strbuf key = STRBUF_INIT;
      +	int n = 0;
      +
      +	reftable_record_key(rec, &key);
     @@ reftable/block.c (new)
      +				reftable_record_val_type(rec));
      +	if (n < 0)
      +		goto done;
     -+	slice_consume(&out, n);
     ++	string_view_consume(&out, n);
      +
      +	n = reftable_record_encode(rec, out, w->hash_size);
      +	if (n < 0)
      +		goto done;
     -+	slice_consume(&out, n);
     ++	string_view_consume(&out, n);
      +
      +	if (block_writer_register_restart(w, start.len - out.len, restart,
      +					  &key) < 0)
      +		goto done;
      +
     -+	slice_release(&key);
     ++	strbuf_release(&key);
      +	return 0;
      +
      +done:
     -+	slice_release(&key);
     ++	strbuf_release(&key);
      +	return -1;
      +}
      +
      +int block_writer_register_restart(struct block_writer *w, int n, bool restart,
     -+				  struct slice *key)
     ++				  struct strbuf *key)
      +{
      +	int rlen = w->restart_len;
      +	if (rlen >= MAX_RESTARTS) {
     @@ reftable/block.c (new)
      +
      +	w->next += n;
      +
     -+	slice_reset(&w->last_key);
     -+	slice_addbuf(&w->last_key, key);
     ++	strbuf_reset(&w->last_key);
     ++	strbuf_addbuf(&w->last_key, key);
      +	w->entries++;
      +	return 0;
      +}
     @@ reftable/block.c (new)
      +
      +	if (block_writer_type(w) == BLOCK_TYPE_LOG) {
      +		int block_header_skip = 4 + w->header_off;
     -+		byte *compressed = NULL;
     ++		uint8_t *compressed = NULL;
      +		int zresult = 0;
      +		uLongf src_len = w->next - block_header_skip;
      +		size_t dest_cap = src_len;
     @@ reftable/block.c (new)
      +	return w->next;
      +}
      +
     -+byte block_reader_type(struct block_reader *r)
     ++uint8_t block_reader_type(struct block_reader *r)
      +{
      +	return r->block.data[r->header_off];
      +}
     @@ reftable/block.c (new)
      +		      int hash_size)
      +{
      +	uint32_t full_block_size = table_block_size;
     -+	byte typ = block->data[header_off];
     ++	uint8_t typ = block->data[header_off];
      +	uint32_t sz = get_be24(block->data + header_off + 1);
      +
      +	uint16_t restart_count = 0;
      +	uint32_t restart_start = 0;
     -+	byte *restart_bytes = NULL;
     ++	uint8_t *restart_bytes = NULL;
      +
      +	if (!reftable_is_block_type(typ))
      +		return REFTABLE_FORMAT_ERROR;
     @@ reftable/block.c (new)
      +		uLongf src_len = block->len - block_header_skip;
      +		/* Log blocks specify the *uncompressed* size in their header.
      +		 */
     -+		byte *uncompressed = reftable_malloc(sz);
     ++		uint8_t *uncompressed = reftable_malloc(sz);
      +
      +		/* Copy over the block header verbatim. It's not compressed. */
      +		memcpy(uncompressed, block->data, block_header_skip);
     @@ reftable/block.c (new)
      +void block_reader_start(struct block_reader *br, struct block_iter *it)
      +{
      +	it->br = br;
     -+	slice_reset(&it->last_key);
     ++	strbuf_reset(&it->last_key);
      +	it->next_off = br->header_off + 4;
      +}
      +
      +struct restart_find_args {
      +	int error;
     -+	struct slice key;
     ++	struct strbuf key;
      +	struct block_reader *r;
      +};
      +
     @@ reftable/block.c (new)
      +{
      +	struct restart_find_args *a = (struct restart_find_args *)args;
      +	uint32_t off = block_reader_restart_offset(a->r, idx);
     -+	struct slice in = {
     ++	struct string_view in = {
      +		.buf = a->r->block.data + off,
      +		.len = a->r->block_len - off,
     -+		.canary = SLICE_CANARY,
      +	};
      +
      +	/* the restart key is verbatim in the block, so this could avoid the
      +	   alloc for decoding the key */
     -+	struct slice rkey = SLICE_INIT;
     -+	struct slice last_key = SLICE_INIT;
     -+	byte unused_extra;
     ++	struct strbuf rkey = STRBUF_INIT;
     ++	struct strbuf last_key = STRBUF_INIT;
     ++	uint8_t unused_extra;
      +	int n = reftable_decode_key(&rkey, &unused_extra, last_key, in);
      +	int result;
      +	if (n < 0) {
     @@ reftable/block.c (new)
      +		return -1;
      +	}
      +
     -+	result = slice_cmp(&a->key, &rkey);
     -+	slice_release(&rkey);
     ++	result = strbuf_cmp(&a->key, &rkey);
     ++	strbuf_release(&rkey);
      +	return result;
      +}
      +
     @@ reftable/block.c (new)
      +{
      +	dest->br = src->br;
      +	dest->next_off = src->next_off;
     -+	slice_reset(&dest->last_key);
     -+	slice_addbuf(&dest->last_key, &src->last_key);
     ++	strbuf_reset(&dest->last_key);
     ++	strbuf_addbuf(&dest->last_key, &src->last_key);
      +}
      +
      +int block_iter_next(struct block_iter *it, struct reftable_record *rec)
      +{
     -+	struct slice in = {
     ++	struct string_view in = {
      +		.buf = it->br->block.data + it->next_off,
      +		.len = it->br->block_len - it->next_off,
     -+		.canary = SLICE_CANARY,
      +	};
     -+	struct slice start = in;
     -+	struct slice key = SLICE_INIT;
     -+	byte extra = 0;
     ++	struct string_view start = in;
     ++	struct strbuf key = STRBUF_INIT;
     ++	uint8_t extra = 0;
      +	int n = 0;
      +
      +	if (it->next_off >= it->br->block_len)
     @@ reftable/block.c (new)
      +	if (n < 0)
      +		return -1;
      +
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +	n = reftable_record_decode(rec, key, extra, in, it->br->hash_size);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +
     -+	slice_reset(&it->last_key);
     -+	slice_addbuf(&it->last_key, &key);
     ++	strbuf_reset(&it->last_key);
     ++	strbuf_addbuf(&it->last_key, &key);
      +	it->next_off += start.len - in.len;
     -+	slice_release(&key);
     ++	strbuf_release(&key);
      +	return 0;
      +}
      +
     -+int block_reader_first_key(struct block_reader *br, struct slice *key)
     ++int block_reader_first_key(struct block_reader *br, struct strbuf *key)
      +{
     -+	struct slice empty = SLICE_INIT;
     ++	struct strbuf empty = STRBUF_INIT;
      +	int off = br->header_off + 4;
     -+	struct slice in = {
     ++	struct string_view in = {
      +		.buf = br->block.data + off,
      +		.len = br->block_len - off,
     -+		.canary = SLICE_CANARY,
      +	};
      +
     -+	byte extra = 0;
     ++	uint8_t extra = 0;
      +	int n = reftable_decode_key(key, &extra, empty, in);
      +	if (n < 0)
      +		return n;
     @@ reftable/block.c (new)
      +	return 0;
      +}
      +
     -+int block_iter_seek(struct block_iter *it, struct slice *want)
     ++int block_iter_seek(struct block_iter *it, struct strbuf *want)
      +{
      +	return block_reader_seek(it->br, it, want);
      +}
      +
      +void block_iter_close(struct block_iter *it)
      +{
     -+	slice_release(&it->last_key);
     ++	strbuf_release(&it->last_key);
      +}
      +
      +int block_reader_seek(struct block_reader *br, struct block_iter *it,
     -+		      struct slice *want)
     ++		      struct strbuf *want)
      +{
      +	struct restart_find_args args = {
      +		.key = *want,
      +		.r = br,
      +	};
      +	struct reftable_record rec = reftable_new_record(block_reader_type(br));
     -+	struct slice key = SLICE_INIT;
     ++	struct strbuf key = STRBUF_INIT;
      +	int err = 0;
      +	struct block_iter next = {
     -+		.last_key = SLICE_INIT,
     ++		.last_key = STRBUF_INIT,
      +	};
      +
      +	int i = binsearch(br->restart_count, &restart_key_less, &args);
     @@ reftable/block.c (new)
      +			goto done;
      +
      +		reftable_record_key(&rec, &key);
     -+		if (err > 0 || slice_cmp(&key, want) >= 0) {
     ++		if (err > 0 || strbuf_cmp(&key, want) >= 0) {
      +			err = 0;
      +			goto done;
      +		}
     @@ reftable/block.c (new)
      +	}
      +
      +done:
     -+	slice_release(&key);
     -+	slice_release(&next.last_key);
     ++	strbuf_release(&key);
     ++	strbuf_release(&next.last_key);
      +	reftable_record_destroy(&rec);
      +
      +	return err;
     @@ reftable/block.c (new)
      +void block_writer_clear(struct block_writer *bw)
      +{
      +	FREE_AND_NULL(bw->restarts);
     -+	slice_release(&bw->last_key);
     ++	strbuf_release(&bw->last_key);
      +	/* the block is not owned. */
      +}
      
     @@ reftable/block.h (new)
      +  allocation overhead.
      +*/
      +struct block_writer {
     -+	byte *buf;
     ++	uint8_t *buf;
      +	uint32_t block_size;
      +
      +	/* Offset ofof the global header. Nonzero in the first block only. */
     @@ reftable/block.h (new)
      +	int restart_interval;
      +	int hash_size;
      +
     -+	/* Offset of next byte to write. */
     ++	/* Offset of next uint8_t to write. */
      +	uint32_t next;
      +	uint32_t *restarts;
      +	uint32_t restart_len;
      +	uint32_t restart_cap;
      +
     -+	struct slice last_key;
     ++	struct strbuf last_key;
      +	int entries;
      +};
      +
      +/*
      +  initializes the blockwriter to write `typ` entries, using `buf` as temporary
      +  storage. `buf` is not owned by the block_writer. */
     -+void block_writer_init(struct block_writer *bw, byte typ, byte *buf,
     ++void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
      +		       uint32_t block_size, uint32_t header_off, int hash_size);
      +
      +/*
      +  returns the block type (eg. 'r' for ref records.
      +*/
     -+byte block_writer_type(struct block_writer *bw);
     ++uint8_t block_writer_type(struct block_writer *bw);
      +
      +/* appends the record, or -1 if it doesn't fit. */
      +int block_writer_add(struct block_writer *w, struct reftable_record *rec);
     @@ reftable/block.h (new)
      +
      +	/* size of the data, excluding restart data. */
      +	uint32_t block_len;
     -+	byte *restart_bytes;
     ++	uint8_t *restart_bytes;
      +	uint16_t restart_count;
      +
      +	/* size of the data in the file. For log blocks, this is the compressed
     @@ reftable/block.h (new)
      +	struct block_reader *br;
      +
      +	/* key for last entry we read. */
     -+	struct slice last_key;
     ++	struct strbuf last_key;
      +};
      +
      +/* initializes a block reader. */
     @@ reftable/block.h (new)
      +
      +/* Position `it` to the `want` key in the block */
      +int block_reader_seek(struct block_reader *br, struct block_iter *it,
     -+		      struct slice *want);
     ++		      struct strbuf *want);
      +
      +/* Returns the block type (eg. 'r' for refs) */
     -+byte block_reader_type(struct block_reader *r);
     ++uint8_t block_reader_type(struct block_reader *r);
      +
      +/* Decodes the first key in the block */
     -+int block_reader_first_key(struct block_reader *br, struct slice *key);
     ++int block_reader_first_key(struct block_reader *br, struct strbuf *key);
      +
      +void block_iter_copy_from(struct block_iter *dest, struct block_iter *src);
      +
     @@ reftable/block.h (new)
      +int block_iter_next(struct block_iter *it, struct reftable_record *rec);
      +
      +/* Seek to `want` with in the block pointed to by `it` */
     -+int block_iter_seek(struct block_iter *it, struct slice *want);
     ++int block_iter_seek(struct block_iter *it, struct strbuf *want);
      +
      +/* deallocate memory for `it`. The block reader and its block is left intact. */
      +void block_iter_close(struct block_iter *it);
     @@ reftable/block_test.c (new)
      +	const int block_size = 1024;
      +	struct reftable_block block = { 0 };
      +	struct block_writer bw = {
     -+		.last_key = SLICE_INIT,
     ++		.last_key = STRBUF_INIT,
      +	};
      +	struct reftable_ref_record ref = { 0 };
      +	struct reftable_record rec = { 0 };
      +	int i = 0;
      +	int n;
      +	struct block_reader br = { 0 };
     -+	struct block_iter it = { .last_key = SLICE_INIT };
     ++	struct block_iter it = { .last_key = STRBUF_INIT };
      +	int j = 0;
     -+	struct slice want = SLICE_INIT;
     ++	struct strbuf want = STRBUF_INIT;
      +
      +	block.data = reftable_calloc(block_size);
      +	block.len = block_size;
     @@ reftable/block_test.c (new)
      +
      +	for (i = 0; i < N; i++) {
      +		char name[100];
     -+		byte hash[SHA1_SIZE];
     ++		uint8_t hash[SHA1_SIZE];
      +		snprintf(name, sizeof(name), "branch%02d", i);
      +		memset(hash, i, sizeof(hash));
      +
     @@ reftable/block_test.c (new)
      +	block_iter_close(&it);
      +
      +	for (i = 0; i < N; i++) {
     -+		struct block_iter it = { .last_key = SLICE_INIT };
     -+		slice_reset(&want);
     -+		slice_addstr(&want, names[i]);
     ++		struct block_iter it = { .last_key = STRBUF_INIT };
     ++		strbuf_reset(&want);
     ++		strbuf_addstr(&want, names[i]);
      +
      +		n = block_reader_seek(&br, &it, &want);
      +		assert(n == 0);
     @@ reftable/block_test.c (new)
      +
      +	reftable_record_clear(&rec);
      +	reftable_block_done(&br.block);
     -+	slice_release(&want);
     ++	strbuf_release(&want);
      +	for (i = 0; i < N; i++) {
      +		reftable_free(names[i]);
      +	}
     @@ reftable/compat.c (new)
      +#include "system.h"
      +#include "basics.h"
      +
     -+#ifndef REFTABLE_IN_GITCORE
     ++#ifdef REFTABLE_STANDALONE
      +
      +#include <dirent.h>
      +
      +void put_be32(void *p, uint32_t i)
      +{
     -+	byte *out = (byte *)p;
     ++	uint8_t *out = (uint8_t *)p;
      +
      +	out[0] = (uint8_t)((i >> 24) & 0xff);
      +	out[1] = (uint8_t)((i >> 16) & 0xff);
     @@ reftable/compat.c (new)
      +
      +void put_be64(void *p, uint64_t v)
      +{
     -+	byte *out = (byte *)p;
     ++	uint8_t *out = (uint8_t *)p;
      +	int i = sizeof(uint64_t);
      +	while (i--) {
      +		out[i] = (uint8_t)(v & 0xff);
     @@ reftable/compat.c (new)
      +	}
      +}
      +
     -+uint64_t get_be64(uint8_t *out)
     ++uint64_t get_be64(void *out)
      +{
     ++	uint8_t *bytes = (uint8_t *)out;
      +	uint64_t v = 0;
      +	int i = 0;
      +	for (i = 0; i < sizeof(uint64_t); i++) {
     -+		v = (v << 8) | (uint8_t)(out[i] & 0xff);
     ++		v = (v << 8) | (uint8_t)(bytes[i] & 0xff);
      +	}
      +	return v;
      +}
     @@ reftable/compat.h (new)
      +
      +#include "system.h"
      +
     -+#ifndef REFTABLE_IN_GITCORE
     ++#ifdef REFTABLE_STANDALONE
      +
      +/* functions that git-core provides, for standalone compilation */
      +#include <stdint.h>
      +
     -+uint64_t get_be64(uint8_t *in);
     ++uint64_t get_be64(void *in);
      +void put_be64(void *out, uint64_t i);
      +
      +void put_be32(void *out, uint32_t i);
     @@ reftable/file.c (new)
      +	return 0;
      +}
      +
     -+int reftable_fd_write(void *arg, byte *data, size_t sz)
     ++int reftable_fd_write(void *arg, const void *data, size_t sz)
      +{
      +	int *fdp = (int *)arg;
      +	return write(*fdp, data, sz);
     @@ reftable/iter.c (new)
      +{
      +	struct filtering_ref_iterator *fri =
      +		(struct filtering_ref_iterator *)iter_arg;
     -+	slice_release(&fri->oid);
     ++	strbuf_release(&fri->oid);
      +	reftable_iterator_destroy(&fri->it);
      +}
      +
     @@ reftable/iter.c (new)
      +	struct indexed_table_ref_iter *it = (struct indexed_table_ref_iter *)p;
      +	block_iter_close(&it->cur);
      +	reftable_block_done(&it->block_reader.block);
     -+	slice_release(&it->oid);
     ++	strbuf_release(&it->oid);
      +}
      +
      +static int indexed_table_ref_iter_next_block(struct indexed_table_ref_iter *it)
     @@ reftable/iter.c (new)
      +}
      +
      +int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
     -+			       struct reftable_reader *r, byte *oid,
     ++			       struct reftable_reader *r, uint8_t *oid,
      +			       int oid_len, uint64_t *offsets, int offset_len)
      +{
      +	struct indexed_table_ref_iter empty = INDEXED_TABLE_REF_ITER_INIT;
     @@ reftable/iter.c (new)
      +
      +	*itr = empty;
      +	itr->r = r;
     -+	slice_add(&itr->oid, oid, oid_len);
     ++	strbuf_add(&itr->oid, oid, oid_len);
      +
      +	itr->offsets = offsets;
      +	itr->offset_len = offset_len;
     @@ reftable/iter.h (new)
      +
      +#include "block.h"
      +#include "record.h"
     -+#include "slice.h"
     ++#include "strbuf.h"
      +
      +struct reftable_iterator_vtable {
      +	int (*next)(void *iter_arg, struct reftable_record *rec);
     @@ reftable/iter.h (new)
      +struct filtering_ref_iterator {
      +	bool double_check;
      +	struct reftable_table tab;
     -+	struct slice oid;
     ++	struct strbuf oid;
      +	struct reftable_iterator it;
      +};
      +#define FILTERING_REF_ITERATOR_INIT \
      +	{                           \
     -+		.oid = SLICE_INIT   \
     ++		.oid = STRBUF_INIT  \
      +	}
      +
      +void iterator_from_filtering_ref_iterator(struct reftable_iterator *,
     @@ reftable/iter.h (new)
      + */
      +struct indexed_table_ref_iter {
      +	struct reftable_reader *r;
     -+	struct slice oid;
     ++	struct strbuf oid;
      +
      +	/* mutable */
      +	uint64_t *offsets;
     @@ reftable/iter.h (new)
      +	bool finished;
      +};
      +
     -+#define INDEXED_TABLE_REF_ITER_INIT                                   \
     -+	{                                                             \
     -+		.cur = { .last_key = SLICE_INIT }, .oid = SLICE_INIT, \
     ++#define INDEXED_TABLE_REF_ITER_INIT                                     \
     ++	{                                                               \
     ++		.cur = { .last_key = STRBUF_INIT }, .oid = STRBUF_INIT, \
      +	}
      +
      +void iterator_from_indexed_table_ref_iter(struct reftable_iterator *it,
      +					  struct indexed_table_ref_iter *itr);
      +int new_indexed_table_ref_iter(struct indexed_table_ref_iter **dest,
     -+			       struct reftable_reader *r, byte *oid,
     ++			       struct reftable_reader *r, uint8_t *oid,
      +			       int oid_len, uint64_t *offsets, int offset_len);
      +
      +#endif
     @@ reftable/merged.c (new)
      +#include "iter.h"
      +#include "pq.h"
      +#include "reader.h"
     ++#include "record.h"
      +
      +static int merged_iter_init(struct merged_iter *mi)
      +{
     @@ reftable/merged.c (new)
      +static int merged_iter_next_entry(struct merged_iter *mi,
      +				  struct reftable_record *rec)
      +{
     -+	struct slice entry_key = SLICE_INIT;
     ++	struct strbuf entry_key = STRBUF_INIT;
      +	struct pq_entry entry = { 0 };
      +	int err = 0;
      +
     @@ reftable/merged.c (new)
      +	reftable_record_key(&entry.rec, &entry_key);
      +	while (!merged_iter_pqueue_is_empty(mi->pq)) {
      +		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
     -+		struct slice k = SLICE_INIT;
     ++		struct strbuf k = STRBUF_INIT;
      +		int err = 0, cmp = 0;
      +
      +		reftable_record_key(&top.rec, &k);
      +
     -+		cmp = slice_cmp(&k, &entry_key);
     -+		slice_release(&k);
     ++		cmp = strbuf_cmp(&k, &entry_key);
     ++		strbuf_release(&k);
      +
      +		if (cmp > 0) {
      +			break;
     @@ reftable/merged.c (new)
      +
      +	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
      +	reftable_record_destroy(&entry.rec);
     -+	slice_release(&entry_key);
     ++	strbuf_release(&entry_key);
      +	return 0;
      +}
      +
     @@ reftable/merged.h (new)
      +	struct reftable_iterator *stack;
      +	uint32_t hash_id;
      +	int stack_len;
     -+	byte typ;
     ++	uint8_t typ;
      +	bool suppress_deletions;
      +	struct merged_iter_pqueue pq;
      +};
     @@ reftable/merged_test.c (new)
      +	merged_iter_pqueue_clear(&pq);
      +}
      +
     -+static void write_test_table(struct slice *buf,
     ++static void write_test_table(struct strbuf *buf,
      +			     struct reftable_ref_record refs[], int n)
      +{
      +	int min = 0xffffffff;
     @@ reftable/merged_test.c (new)
      +		}
      +	}
      +
     -+	w = reftable_new_writer(&slice_add_void, buf, &opts);
     ++	w = reftable_new_writer(&strbuf_add_void, buf, &opts);
      +	reftable_writer_set_limits(w, min, max);
      +
      +	for (i = 0; i < n; i++) {
     @@ reftable/merged_test.c (new)
      +static struct reftable_merged_table *
      +merged_table_from_records(struct reftable_ref_record **refs,
      +			  struct reftable_block_source **source, int *sizes,
     -+			  struct slice *buf, int n)
     ++			  struct strbuf *buf, int n)
      +{
      +	struct reftable_reader **rd = reftable_calloc(n * sizeof(*rd));
      +	int i = 0;
     @@ reftable/merged_test.c (new)
      +	*source = reftable_calloc(n * sizeof(**source));
      +	for (i = 0; i < n; i++) {
      +		write_test_table(&buf[i], refs[i], sizes[i]);
     -+		block_source_from_slice(&(*source)[i], &buf[i]);
     ++		block_source_from_strbuf(&(*source)[i], &buf[i]);
      +
      +		err = reftable_new_reader(&rd[i], &(*source)[i], "name");
      +		assert_err(err);
     @@ reftable/merged_test.c (new)
      +
      +static void test_merged_between(void)
      +{
     -+	byte hash1[SHA1_SIZE] = { 1, 2, 3, 0 };
     ++	uint8_t hash1[SHA1_SIZE] = { 1, 2, 3, 0 };
      +
      +	struct reftable_ref_record r1[] = { {
      +		.ref_name = "b",
     @@ reftable/merged_test.c (new)
      +
      +	struct reftable_ref_record *refs[] = { r1, r2 };
      +	int sizes[] = { 1, 1 };
     -+	struct slice bufs[2] = { SLICE_INIT, SLICE_INIT };
     ++	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
      +	struct reftable_block_source *bs = NULL;
      +	struct reftable_merged_table *mt =
      +		merged_table_from_records(refs, &bs, sizes, bufs, 2);
     @@ reftable/merged_test.c (new)
      +	reftable_merged_table_close(mt);
      +	reftable_merged_table_free(mt);
      +	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
     -+		slice_release(&bufs[i]);
     ++		strbuf_release(&bufs[i]);
      +	}
      +	reftable_free(bs);
      +}
      +
      +static void test_merged(void)
      +{
     -+	byte hash1[SHA1_SIZE] = { 1 };
     -+	byte hash2[SHA1_SIZE] = { 2 };
     ++	uint8_t hash1[SHA1_SIZE] = { 1 };
     ++	uint8_t hash2[SHA1_SIZE] = { 2 };
      +	struct reftable_ref_record r1[] = { {
      +						    .ref_name = "a",
      +						    .update_index = 1,
     @@ reftable/merged_test.c (new)
      +
      +	struct reftable_ref_record *refs[] = { r1, r2, r3 };
      +	int sizes[3] = { 3, 1, 2 };
     -+	struct slice bufs[3] = { SLICE_INIT, SLICE_INIT, SLICE_INIT };
     ++	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
      +	struct reftable_block_source *bs = NULL;
      +
      +	struct reftable_merged_table *mt =
     @@ reftable/merged_test.c (new)
      +	reftable_free(out);
      +
      +	for (i = 0; i < 3; i++) {
     -+		slice_release(&bufs[i]);
     ++		strbuf_release(&bufs[i]);
      +	}
      +	reftable_merged_table_close(mt);
      +	reftable_merged_table_free(mt);
     @@ reftable/pq.c (new)
      +
      +#include "pq.h"
      +
     ++#include "reftable.h"
      +#include "system.h"
     ++#include "basics.h"
      +
      +int pq_less(struct pq_entry a, struct pq_entry b)
      +{
     -+	struct slice ak = SLICE_INIT;
     -+	struct slice bk = SLICE_INIT;
     ++	struct strbuf ak = STRBUF_INIT;
     ++	struct strbuf bk = STRBUF_INIT;
      +	int cmp = 0;
      +	reftable_record_key(&a.rec, &ak);
      +	reftable_record_key(&b.rec, &bk);
      +
     -+	cmp = slice_cmp(&ak, &bk);
     ++	cmp = strbuf_cmp(&ak, &bk);
      +
     -+	slice_release(&ak);
     -+	slice_release(&bk);
     ++	strbuf_release(&ak);
     ++	strbuf_release(&bk);
      +
      +	if (cmp == 0)
      +		return a.index > b.index;
     @@ reftable/reader.c (new)
      +}
      +
      +static struct reftable_reader_offsets *
     -+reader_offsets_for(struct reftable_reader *r, byte typ)
     ++reader_offsets_for(struct reftable_reader *r, uint8_t typ)
      +{
      +	switch (typ) {
      +	case BLOCK_TYPE_REF:
     @@ reftable/reader.c (new)
      +	return r->name;
      +}
      +
     -+static int parse_footer(struct reftable_reader *r, byte *footer, byte *header)
     ++static int parse_footer(struct reftable_reader *r, uint8_t *footer,
     ++			uint8_t *header)
      +{
     -+	byte *f = footer;
     -+	byte first_block_typ;
     ++	uint8_t *f = footer;
     ++	uint8_t first_block_typ;
      +	int err = 0;
      +	uint32_t computed_crc;
      +	uint32_t file_crc;
     @@ reftable/reader.c (new)
      +
      +struct table_iter {
      +	struct reftable_reader *r;
     -+	byte typ;
     ++	uint8_t typ;
      +	uint64_t block_off;
      +	struct block_iter bi;
      +	bool finished;
      +};
     -+#define TABLE_ITER_INIT                         \
     -+	{                                       \
     -+		.bi = {.last_key = SLICE_INIT } \
     ++#define TABLE_ITER_INIT                          \
     ++	{                                        \
     ++		.bi = {.last_key = STRBUF_INIT } \
      +	}
      +
      +static void table_iter_copy_from(struct table_iter *dest,
     @@ reftable/reader.c (new)
      +	ti->bi.next_off = 0;
      +}
      +
     -+static int32_t extract_block_size(byte *data, byte *typ, uint64_t off,
     ++static int32_t extract_block_size(uint8_t *data, uint8_t *typ, uint64_t off,
      +				  int version)
      +{
      +	int32_t result = 0;
     @@ reftable/reader.c (new)
      +}
      +
      +int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
     -+			     uint64_t next_off, byte want_typ)
     ++			     uint64_t next_off, uint8_t want_typ)
      +{
      +	int32_t guess_block_size = r->block_size ? r->block_size :
      +						   DEFAULT_BLOCK_SIZE;
      +	struct reftable_block block = { 0 };
     -+	byte block_typ = 0;
     ++	uint8_t block_typ = 0;
      +	int err = 0;
      +	uint32_t header_off = next_off ? 0 : header_size(r->version);
      +	int32_t block_size = 0;
     @@ reftable/reader.c (new)
      +}
      +
      +static int reader_table_iter_at(struct reftable_reader *r,
     -+				struct table_iter *ti, uint64_t off, byte typ)
     ++				struct table_iter *ti, uint64_t off,
     ++				uint8_t typ)
      +{
      +	struct block_reader br = { 0 };
      +	struct block_reader *brp = NULL;
     @@ reftable/reader.c (new)
      +}
      +
      +static int reader_start(struct reftable_reader *r, struct table_iter *ti,
     -+			byte typ, bool index)
     ++			uint8_t typ, bool index)
      +{
      +	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
      +	uint64_t off = offs->offset;
     @@ reftable/reader.c (new)
      +{
      +	struct reftable_record rec =
      +		reftable_new_record(reftable_record_type(want));
     -+	struct slice want_key = SLICE_INIT;
     -+	struct slice got_key = SLICE_INIT;
     ++	struct strbuf want_key = STRBUF_INIT;
     ++	struct strbuf got_key = STRBUF_INIT;
      +	struct table_iter next = TABLE_ITER_INIT;
      +	int err = -1;
      +
     @@ reftable/reader.c (new)
      +		if (err < 0)
      +			goto done;
      +
     -+		if (slice_cmp(&got_key, &want_key) > 0) {
     ++		if (strbuf_cmp(&got_key, &want_key) > 0) {
      +			table_iter_block_done(&next);
      +			break;
      +		}
     @@ reftable/reader.c (new)
      +done:
      +	block_iter_close(&next.bi);
      +	reftable_record_destroy(&rec);
     -+	slice_release(&want_key);
     -+	slice_release(&got_key);
     ++	strbuf_release(&want_key);
     ++	strbuf_release(&got_key);
      +	return err;
      +}
      +
     @@ reftable/reader.c (new)
      +			       struct reftable_iterator *it,
      +			       struct reftable_record *rec)
      +{
     -+	struct reftable_index_record want_index = { .last_key = SLICE_INIT };
     ++	struct reftable_index_record want_index = { .last_key = STRBUF_INIT };
      +	struct reftable_record want_index_rec = { 0 };
     -+	struct reftable_index_record index_result = { .last_key = SLICE_INIT };
     ++	struct reftable_index_record index_result = { .last_key = STRBUF_INIT };
      +	struct reftable_record index_result_rec = { 0 };
      +	struct table_iter index_iter = TABLE_ITER_INIT;
      +	struct table_iter next = TABLE_ITER_INIT;
     @@ reftable/reader.c (new)
      +int reader_seek(struct reftable_reader *r, struct reftable_iterator *it,
      +		struct reftable_record *rec)
      +{
     -+	byte typ = reftable_record_type(rec);
     ++	uint8_t typ = reftable_record_type(rec);
      +
      +	struct reftable_reader_offsets *offs = reader_offsets_for(r, typ);
      +	if (!offs->present) {
     @@ reftable/reader.c (new)
      +
      +static int reftable_reader_refs_for_indexed(struct reftable_reader *r,
      +					    struct reftable_iterator *it,
     -+					    byte *oid)
     ++					    uint8_t *oid)
      +{
      +	struct reftable_obj_record want = {
      +		.hash_prefix = oid,
     @@ reftable/reader.c (new)
      +
      +static int reftable_reader_refs_for_unindexed(struct reftable_reader *r,
      +					      struct reftable_iterator *it,
     -+					      byte *oid)
     ++					      uint8_t *oid)
      +{
      +	struct table_iter ti_empty = TABLE_ITER_INIT;
      +	struct table_iter *ti = reftable_calloc(sizeof(struct table_iter));
     @@ reftable/reader.c (new)
      +	filter = reftable_malloc(sizeof(struct filtering_ref_iterator));
      +	*filter = empty;
      +
     -+	slice_add(&filter->oid, oid, oid_len);
     ++	strbuf_add(&filter->oid, oid, oid_len);
      +	reftable_table_from_reader(&filter->tab, r);
      +	filter->double_check = false;
      +	iterator_from_table_iter(&filter->it, ti);
     @@ reftable/reader.c (new)
      +}
      +
      +int reftable_reader_refs_for(struct reftable_reader *r,
     -+			     struct reftable_iterator *it, byte *oid)
     ++			     struct reftable_iterator *it, uint8_t *oid)
      +{
      +	if (r->obj_offsets.present)
      +		return reftable_reader_refs_for_indexed(r, it, oid);
     @@ reftable/reader.h (new)
      +
      +/* initialize a block reader to read from `r` */
      +int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
     -+			     uint64_t next_off, byte want_typ);
     ++			     uint64_t next_off, uint8_t want_typ);
      +
      +#endif
      
     @@ reftable/record.c (new)
      +#include "record.h"
      +
      +#include "system.h"
     -+
      +#include "constants.h"
      +#include "reftable.h"
     ++#include "basics.h"
      +
     -+int get_var_int(uint64_t *dest, struct slice *in)
     ++int get_var_int(uint64_t *dest, struct string_view *in)
      +{
      +	int ptr = 0;
      +	uint64_t val;
     @@ reftable/record.c (new)
      +	return ptr + 1;
      +}
      +
     -+int put_var_int(struct slice *dest, uint64_t val)
     ++int put_var_int(struct string_view *dest, uint64_t val)
      +{
     -+	byte buf[10] = { 0 };
     ++	uint8_t buf[10] = { 0 };
      +	int i = 9;
      +	int n = 0;
     -+	buf[i] = (byte)(val & 0x7f);
     ++	buf[i] = (uint8_t)(val & 0x7f);
      +	i--;
      +	while (true) {
      +		val >>= 7;
     @@ reftable/record.c (new)
      +			break;
      +		}
      +		val--;
     -+		buf[i] = 0x80 | (byte)(val & 0x7f);
     ++		buf[i] = 0x80 | (uint8_t)(val & 0x7f);
      +		i--;
      +	}
      +
     @@ reftable/record.c (new)
      +	return n;
      +}
      +
     -+int reftable_is_block_type(byte typ)
     ++int reftable_is_block_type(uint8_t typ)
      +{
      +	switch (typ) {
      +	case BLOCK_TYPE_REF:
     @@ reftable/record.c (new)
      +	return false;
      +}
      +
     -+static int decode_string(struct slice *dest, struct slice in)
     ++static int decode_string(struct strbuf *dest, struct string_view in)
      +{
      +	int start_len = in.len;
      +	uint64_t tsize = 0;
      +	int n = get_var_int(&tsize, &in);
      +	if (n <= 0)
      +		return -1;
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +	if (in.len < tsize)
      +		return -1;
      +
     -+	slice_reset(dest);
     -+	slice_add(dest, in.buf, tsize);
     -+	slice_consume(&in, tsize);
     ++	strbuf_reset(dest);
     ++	strbuf_add(dest, in.buf, tsize);
     ++	string_view_consume(&in, tsize);
      +
      +	return start_len - in.len;
      +}
      +
     -+static int encode_string(char *str, struct slice s)
     ++static int encode_string(char *str, struct string_view s)
      +{
     -+	struct slice start = s;
     ++	struct string_view start = s;
      +	int l = strlen(str);
      +	int n = put_var_int(&s, l);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&s, n);
     ++	string_view_consume(&s, n);
      +	if (s.len < l)
      +		return -1;
      +	memcpy(s.buf, str, l);
     -+	slice_consume(&s, l);
     ++	string_view_consume(&s, l);
      +
      +	return start.len - s.len;
      +}
      +
     -+int reftable_encode_key(bool *restart, struct slice dest, struct slice prev_key,
     -+			struct slice key, byte extra)
     ++int reftable_encode_key(bool *restart, struct string_view dest,
     ++			struct strbuf prev_key, struct strbuf key,
     ++			uint8_t extra)
      +{
     -+	struct slice start = dest;
     ++	struct string_view start = dest;
      +	int prefix_len = common_prefix_size(&prev_key, &key);
      +	uint64_t suffix_len = key.len - prefix_len;
      +	int n = put_var_int(&dest, (uint64_t)prefix_len);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&dest, n);
     ++	string_view_consume(&dest, n);
      +
      +	*restart = (prefix_len == 0);
      +
      +	n = put_var_int(&dest, suffix_len << 3 | (uint64_t)extra);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&dest, n);
     ++	string_view_consume(&dest, n);
      +
      +	if (dest.len < suffix_len)
      +		return -1;
      +	memcpy(dest.buf, key.buf + prefix_len, suffix_len);
     -+	slice_consume(&dest, suffix_len);
     ++	string_view_consume(&dest, suffix_len);
      +
      +	return start.len - dest.len;
      +}
      +
     -+int reftable_decode_key(struct slice *key, byte *extra, struct slice last_key,
     -+			struct slice in)
     ++int reftable_decode_key(struct strbuf *key, uint8_t *extra,
     ++			struct strbuf last_key, struct string_view in)
      +{
      +	int start_len = in.len;
      +	uint64_t prefix_len = 0;
     @@ reftable/record.c (new)
      +	int n = get_var_int(&prefix_len, &in);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +
      +	if (prefix_len > last_key.len)
      +		return -1;
     @@ reftable/record.c (new)
      +	n = get_var_int(&suffix_len, &in);
      +	if (n <= 0)
      +		return -1;
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +
     -+	*extra = (byte)(suffix_len & 0x7);
     ++	*extra = (uint8_t)(suffix_len & 0x7);
      +	suffix_len >>= 3;
      +
      +	if (in.len < suffix_len)
      +		return -1;
      +
     -+	slice_reset(key);
     -+	slice_add(key, last_key.buf, prefix_len);
     -+	slice_add(key, in.buf, suffix_len);
     -+	slice_consume(&in, suffix_len);
     ++	strbuf_reset(key);
     ++	strbuf_add(key, last_key.buf, prefix_len);
     ++	strbuf_add(key, in.buf, suffix_len);
     ++	string_view_consume(&in, suffix_len);
      +
      +	return start_len - in.len;
      +}
      +
     -+static void reftable_ref_record_key(const void *r, struct slice *dest)
     ++static void reftable_ref_record_key(const void *r, struct strbuf *dest)
      +{
      +	const struct reftable_ref_record *rec =
      +		(const struct reftable_ref_record *)r;
     -+	slice_reset(dest);
     -+	slice_addstr(dest, rec->ref_name);
     ++	strbuf_reset(dest);
     ++	strbuf_addstr(dest, rec->ref_name);
      +}
      +
      +static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
     @@ reftable/record.c (new)
      +	return 'a' + (c - 10);
      +}
      +
     -+static void hex_format(char *dest, byte *src, int hash_size)
     ++static void hex_format(char *dest, uint8_t *src, int hash_size)
      +{
      +	assert(hash_size > 0);
      +	if (src != NULL) {
     @@ reftable/record.c (new)
      +	memset(ref, 0, sizeof(struct reftable_ref_record));
      +}
      +
     -+static byte reftable_ref_record_val_type(const void *rec)
     ++static uint8_t reftable_ref_record_val_type(const void *rec)
      +{
      +	const struct reftable_ref_record *r =
      +		(const struct reftable_ref_record *)rec;
     @@ reftable/record.c (new)
      +	return 0;
      +}
      +
     -+static int reftable_ref_record_encode(const void *rec, struct slice s,
     ++static int reftable_ref_record_encode(const void *rec, struct string_view s,
      +				      int hash_size)
      +{
      +	const struct reftable_ref_record *r =
      +		(const struct reftable_ref_record *)rec;
     -+	struct slice start = s;
     ++	struct string_view start = s;
      +	int n = put_var_int(&s, r->update_index);
      +	assert(hash_size > 0);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&s, n);
     ++	string_view_consume(&s, n);
      +
      +	if (r->value != NULL) {
      +		if (s.len < hash_size) {
      +			return -1;
      +		}
      +		memcpy(s.buf, r->value, hash_size);
     -+		slice_consume(&s, hash_size);
     ++		string_view_consume(&s, hash_size);
      +	}
      +
      +	if (r->target_value != NULL) {
     @@ reftable/record.c (new)
      +			return -1;
      +		}
      +		memcpy(s.buf, r->target_value, hash_size);
     -+		slice_consume(&s, hash_size);
     ++		string_view_consume(&s, hash_size);
      +	}
      +
      +	if (r->target != NULL) {
     @@ reftable/record.c (new)
      +		if (n < 0) {
      +			return -1;
      +		}
     -+		slice_consume(&s, n);
     ++		string_view_consume(&s, n);
      +	}
      +
      +	return start.len - s.len;
      +}
      +
     -+static int reftable_ref_record_decode(void *rec, struct slice key,
     -+				      byte val_type, struct slice in,
     ++static int reftable_ref_record_decode(void *rec, struct strbuf key,
     ++				      uint8_t val_type, struct string_view in,
      +				      int hash_size)
      +{
      +	struct reftable_ref_record *r = (struct reftable_ref_record *)rec;
     -+	struct slice start = in;
     ++	struct string_view start = in;
      +	bool seen_value = false;
      +	bool seen_target_value = false;
      +	bool seen_target = false;
     @@ reftable/record.c (new)
      +		return n;
      +	assert(hash_size > 0);
      +
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +
      +	r->ref_name = reftable_realloc(r->ref_name, key.len + 1);
      +	memcpy(r->ref_name, key.buf, key.len);
     @@ reftable/record.c (new)
      +		}
      +		seen_value = true;
      +		memcpy(r->value, in.buf, hash_size);
     -+		slice_consume(&in, hash_size);
     ++		string_view_consume(&in, hash_size);
      +		if (val_type == 1) {
      +			break;
      +		}
     @@ reftable/record.c (new)
      +		}
      +		seen_target_value = true;
      +		memcpy(r->target_value, in.buf, hash_size);
     -+		slice_consume(&in, hash_size);
     ++		string_view_consume(&in, hash_size);
      +		break;
      +	case 3: {
     -+		struct slice dest = SLICE_INIT;
     ++		struct strbuf dest = STRBUF_INIT;
      +		int n = decode_string(&dest, in);
      +		if (n < 0) {
      +			return -1;
      +		}
     -+		slice_consume(&in, n);
     ++		string_view_consume(&in, n);
      +		seen_target = true;
      +		if (r->target != NULL) {
      +			reftable_free(r->target);
      +		}
     -+		r->target = (char *)slice_as_string(&dest);
     ++		r->target = dest.buf;
      +	} break;
      +
      +	case 0:
     @@ reftable/record.c (new)
      +	.is_deletion = &reftable_ref_record_is_deletion_void,
      +};
      +
     -+static void reftable_obj_record_key(const void *r, struct slice *dest)
     ++static void reftable_obj_record_key(const void *r, struct strbuf *dest)
      +{
      +	const struct reftable_obj_record *rec =
      +		(const struct reftable_obj_record *)r;
     -+	slice_reset(dest);
     -+	slice_add(dest, rec->hash_prefix, rec->hash_prefix_len);
     ++	strbuf_reset(dest);
     ++	strbuf_add(dest, rec->hash_prefix, rec->hash_prefix_len);
      +}
      +
      +static void reftable_obj_record_clear(void *rec)
     @@ reftable/record.c (new)
      +	memcpy(obj->offsets, src->offsets, olen);
      +}
      +
     -+static byte reftable_obj_record_val_type(const void *rec)
     ++static uint8_t reftable_obj_record_val_type(const void *rec)
      +{
      +	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
      +	if (r->offset_len > 0 && r->offset_len < 8)
     @@ reftable/record.c (new)
      +	return 0;
      +}
      +
     -+static int reftable_obj_record_encode(const void *rec, struct slice s,
     ++static int reftable_obj_record_encode(const void *rec, struct string_view s,
      +				      int hash_size)
      +{
      +	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
     -+	struct slice start = s;
     ++	struct string_view start = s;
      +	int i = 0;
      +	int n = 0;
      +	uint64_t last = 0;
     @@ reftable/record.c (new)
      +		if (n < 0) {
      +			return -1;
      +		}
     -+		slice_consume(&s, n);
     ++		string_view_consume(&s, n);
      +	}
      +	if (r->offset_len == 0)
      +		return start.len - s.len;
      +	n = put_var_int(&s, r->offsets[0]);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&s, n);
     ++	string_view_consume(&s, n);
      +
      +	last = r->offsets[0];
      +	for (i = 1; i < r->offset_len; i++) {
     @@ reftable/record.c (new)
      +		if (n < 0) {
      +			return -1;
      +		}
     -+		slice_consume(&s, n);
     ++		string_view_consume(&s, n);
      +		last = r->offsets[i];
      +	}
      +	return start.len - s.len;
      +}
      +
     -+static int reftable_obj_record_decode(void *rec, struct slice key,
     -+				      byte val_type, struct slice in,
     ++static int reftable_obj_record_decode(void *rec, struct strbuf key,
     ++				      uint8_t val_type, struct string_view in,
      +				      int hash_size)
      +{
     -+	struct slice start = in;
     ++	struct string_view start = in;
      +	struct reftable_obj_record *r = (struct reftable_obj_record *)rec;
      +	uint64_t count = val_type;
      +	int n = 0;
     @@ reftable/record.c (new)
      +			return n;
      +		}
      +
     -+		slice_consume(&in, n);
     ++		string_view_consume(&in, n);
      +	}
      +
      +	r->offsets = NULL;
     @@ reftable/record.c (new)
      +	n = get_var_int(&r->offsets[0], &in);
      +	if (n < 0)
      +		return n;
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +
      +	last = r->offsets[0];
      +	j = 1;
     @@ reftable/record.c (new)
      +		if (n < 0) {
      +			return n;
      +		}
     -+		slice_consume(&in, n);
     ++		string_view_consume(&in, n);
      +
      +		last = r->offsets[j] = (delta + last);
      +		j++;
     @@ reftable/record.c (new)
      +	printf("%s\n\n%s\n}\n", hex, log->message);
      +}
      +
     -+static void reftable_log_record_key(const void *r, struct slice *dest)
     ++static void reftable_log_record_key(const void *r, struct strbuf *dest)
      +{
      +	const struct reftable_log_record *rec =
      +		(const struct reftable_log_record *)r;
      +	int len = strlen(rec->ref_name);
     -+	byte i64[8];
     ++	uint8_t i64[8];
      +	uint64_t ts = 0;
     -+	slice_reset(dest);
     -+	slice_add(dest, (byte *)rec->ref_name, len + 1);
     ++	strbuf_reset(dest);
     ++	strbuf_add(dest, (uint8_t *)rec->ref_name, len + 1);
      +
      +	ts = (~ts) - rec->update_index;
      +	put_be64(&i64[0], ts);
     -+	slice_add(dest, i64, sizeof(i64));
     ++	strbuf_add(dest, i64, sizeof(i64));
      +}
      +
      +static void reftable_log_record_copy_from(void *rec, const void *src_rec,
     @@ reftable/record.c (new)
      +	memset(r, 0, sizeof(struct reftable_log_record));
      +}
      +
     -+static byte reftable_log_record_val_type(const void *rec)
     ++static uint8_t reftable_log_record_val_type(const void *rec)
      +{
      +	const struct reftable_log_record *log =
      +		(const struct reftable_log_record *)rec;
     @@ reftable/record.c (new)
      +	return reftable_log_record_is_deletion(log) ? 0 : 1;
      +}
      +
     -+static byte zero[SHA256_SIZE] = { 0 };
     ++static uint8_t zero[SHA256_SIZE] = { 0 };
      +
     -+static int reftable_log_record_encode(const void *rec, struct slice s,
     ++static int reftable_log_record_encode(const void *rec, struct string_view s,
      +				      int hash_size)
      +{
      +	struct reftable_log_record *r = (struct reftable_log_record *)rec;
     -+	struct slice start = s;
     ++	struct string_view start = s;
      +	int n = 0;
     -+	byte *oldh = r->old_hash;
     -+	byte *newh = r->new_hash;
     ++	uint8_t *oldh = r->old_hash;
     ++	uint8_t *newh = r->new_hash;
      +	if (reftable_log_record_is_deletion(r))
      +		return 0;
      +
     @@ reftable/record.c (new)
      +
      +	memcpy(s.buf, oldh, hash_size);
      +	memcpy(s.buf + hash_size, newh, hash_size);
     -+	slice_consume(&s, 2 * hash_size);
     ++	string_view_consume(&s, 2 * hash_size);
      +
      +	n = encode_string(r->name ? r->name : "", s);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&s, n);
     ++	string_view_consume(&s, n);
      +
      +	n = encode_string(r->email ? r->email : "", s);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&s, n);
     ++	string_view_consume(&s, n);
      +
      +	n = put_var_int(&s, r->time);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&s, n);
     ++	string_view_consume(&s, n);
      +
      +	if (s.len < 2)
      +		return -1;
      +
      +	put_be16(s.buf, r->tz_offset);
     -+	slice_consume(&s, 2);
     ++	string_view_consume(&s, 2);
      +
      +	n = encode_string(r->message ? r->message : "", s);
      +	if (n < 0)
      +		return -1;
     -+	slice_consume(&s, n);
     ++	string_view_consume(&s, n);
      +
      +	return start.len - s.len;
      +}
      +
     -+static int reftable_log_record_decode(void *rec, struct slice key,
     -+				      byte val_type, struct slice in,
     ++static int reftable_log_record_decode(void *rec, struct strbuf key,
     ++				      uint8_t val_type, struct string_view in,
      +				      int hash_size)
      +{
     -+	struct slice start = in;
     ++	struct string_view start = in;
      +	struct reftable_log_record *r = (struct reftable_log_record *)rec;
      +	uint64_t max = 0;
      +	uint64_t ts = 0;
     -+	struct slice dest = SLICE_INIT;
     ++	struct strbuf dest = STRBUF_INIT;
      +	int n;
      +
      +	if (key.len <= 9 || key.buf[key.len - 9] != 0)
     @@ reftable/record.c (new)
      +	memcpy(r->old_hash, in.buf, hash_size);
      +	memcpy(r->new_hash, in.buf + hash_size, hash_size);
      +
     -+	slice_consume(&in, 2 * hash_size);
     ++	string_view_consume(&in, 2 * hash_size);
      +
      +	n = decode_string(&dest, in);
      +	if (n < 0)
      +		goto done;
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +
      +	r->name = reftable_realloc(r->name, dest.len + 1);
      +	memcpy(r->name, dest.buf, dest.len);
      +	r->name[dest.len] = 0;
      +
     -+	slice_reset(&dest);
     ++	strbuf_reset(&dest);
      +	n = decode_string(&dest, in);
      +	if (n < 0)
      +		goto done;
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +
      +	r->email = reftable_realloc(r->email, dest.len + 1);
      +	memcpy(r->email, dest.buf, dest.len);
     @@ reftable/record.c (new)
      +	n = get_var_int(&ts, &in);
      +	if (n < 0)
      +		goto done;
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +	r->time = ts;
      +	if (in.len < 2)
      +		goto done;
      +
      +	r->tz_offset = get_be16(in.buf);
     -+	slice_consume(&in, 2);
     ++	string_view_consume(&in, 2);
      +
     -+	slice_reset(&dest);
     ++	strbuf_reset(&dest);
      +	n = decode_string(&dest, in);
      +	if (n < 0)
      +		goto done;
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +
      +	r->message = reftable_realloc(r->message, dest.len + 1);
      +	memcpy(r->message, dest.buf, dest.len);
      +	r->message[dest.len] = 0;
      +
     -+	slice_release(&dest);
     ++	strbuf_release(&dest);
      +	return start.len - in.len;
      +
      +done:
     -+	slice_release(&dest);
     ++	strbuf_release(&dest);
      +	return REFTABLE_FORMAT_ERROR;
      +}
      +
     @@ reftable/record.c (new)
      +	return 0 == strcmp(a, b);
      +}
      +
     -+static bool zero_hash_eq(byte *a, byte *b, int sz)
     ++static bool zero_hash_eq(uint8_t *a, uint8_t *b, int sz)
      +{
      +	if (a == NULL)
      +		a = zero;
     @@ reftable/record.c (new)
      +	.is_deletion = &reftable_log_record_is_deletion_void,
      +};
      +
     -+struct reftable_record reftable_new_record(byte typ)
     ++struct reftable_record reftable_new_record(uint8_t typ)
      +{
      +	struct reftable_record rec = { NULL };
      +	switch (typ) {
     @@ reftable/record.c (new)
      +		return rec;
      +	}
      +	case BLOCK_TYPE_INDEX: {
     -+		struct reftable_index_record empty = { .last_key = SLICE_INIT };
     ++		struct reftable_index_record empty = { .last_key =
     ++							       STRBUF_INIT };
      +		struct reftable_index_record *r =
      +			reftable_calloc(sizeof(struct reftable_index_record));
      +		*r = empty;
     @@ reftable/record.c (new)
      +	reftable_free(reftable_record_yield(rec));
      +}
      +
     -+static void reftable_index_record_key(const void *r, struct slice *dest)
     ++static void reftable_index_record_key(const void *r, struct strbuf *dest)
      +{
      +	struct reftable_index_record *rec = (struct reftable_index_record *)r;
     -+	slice_reset(dest);
     -+	slice_addbuf(dest, &rec->last_key);
     ++	strbuf_reset(dest);
     ++	strbuf_addbuf(dest, &rec->last_key);
      +}
      +
      +static void reftable_index_record_copy_from(void *rec, const void *src_rec,
     @@ reftable/record.c (new)
      +	struct reftable_index_record *src =
      +		(struct reftable_index_record *)src_rec;
      +
     -+	slice_reset(&dst->last_key);
     -+	slice_addbuf(&dst->last_key, &src->last_key);
     ++	strbuf_reset(&dst->last_key);
     ++	strbuf_addbuf(&dst->last_key, &src->last_key);
      +	dst->offset = src->offset;
      +}
      +
      +static void reftable_index_record_clear(void *rec)
      +{
      +	struct reftable_index_record *idx = (struct reftable_index_record *)rec;
     -+	slice_release(&idx->last_key);
     ++	strbuf_release(&idx->last_key);
      +}
      +
     -+static byte reftable_index_record_val_type(const void *rec)
     ++static uint8_t reftable_index_record_val_type(const void *rec)
      +{
      +	return 0;
      +}
      +
     -+static int reftable_index_record_encode(const void *rec, struct slice out,
     ++static int reftable_index_record_encode(const void *rec, struct string_view out,
      +					int hash_size)
      +{
      +	const struct reftable_index_record *r =
      +		(const struct reftable_index_record *)rec;
     -+	struct slice start = out;
     ++	struct string_view start = out;
      +
      +	int n = put_var_int(&out, r->offset);
      +	if (n < 0)
      +		return n;
      +
     -+	slice_consume(&out, n);
     ++	string_view_consume(&out, n);
      +
      +	return start.len - out.len;
      +}
      +
     -+static int reftable_index_record_decode(void *rec, struct slice key,
     -+					byte val_type, struct slice in,
     ++static int reftable_index_record_decode(void *rec, struct strbuf key,
     ++					uint8_t val_type, struct string_view in,
      +					int hash_size)
      +{
     -+	struct slice start = in;
     ++	struct string_view start = in;
      +	struct reftable_index_record *r = (struct reftable_index_record *)rec;
      +	int n = 0;
      +
     -+	slice_reset(&r->last_key);
     -+	slice_addbuf(&r->last_key, &key);
     ++	strbuf_reset(&r->last_key);
     ++	strbuf_addbuf(&r->last_key, &key);
      +
      +	n = get_var_int(&r->offset, &in);
      +	if (n < 0)
      +		return n;
      +
     -+	slice_consume(&in, n);
     ++	string_view_consume(&in, n);
      +	return start.len - in.len;
      +}
      +
     @@ reftable/record.c (new)
      +	.is_deletion = &not_a_deletion,
      +};
      +
     -+void reftable_record_key(struct reftable_record *rec, struct slice *dest)
     ++void reftable_record_key(struct reftable_record *rec, struct strbuf *dest)
      +{
      +	rec->ops->key(rec->data, dest);
      +}
      +
     -+byte reftable_record_type(struct reftable_record *rec)
     ++uint8_t reftable_record_type(struct reftable_record *rec)
      +{
      +	return rec->ops->type;
      +}
      +
     -+int reftable_record_encode(struct reftable_record *rec, struct slice dest,
     ++int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
      +			   int hash_size)
      +{
      +	return rec->ops->encode(rec->data, dest, hash_size);
     @@ reftable/record.c (new)
      +	rec->ops->copy_from(rec->data, src->data, hash_size);
      +}
      +
     -+byte reftable_record_val_type(struct reftable_record *rec)
     ++uint8_t reftable_record_val_type(struct reftable_record *rec)
      +{
      +	return rec->ops->val_type(rec->data);
      +}
      +
     -+int reftable_record_decode(struct reftable_record *rec, struct slice key,
     -+			   byte extra, struct slice src, int hash_size)
     ++int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
     ++			   uint8_t extra, struct string_view src, int hash_size)
      +{
      +	return rec->ops->decode(rec->data, key, extra, src, hash_size);
      +}
     @@ reftable/record.c (new)
      +	return (struct reftable_log_record *)rec->data;
      +}
      +
     -+static bool hash_equal(byte *a, byte *b, int hash_size)
     ++static bool hash_equal(uint8_t *a, uint8_t *b, int hash_size)
      +{
      +	if (a != NULL && b != NULL)
      +		return !memcmp(a, b, hash_size);
     @@ reftable/record.c (new)
      +		return SHA256_SIZE;
      +	}
      +	abort();
     ++}
     ++
     ++void string_view_consume(struct string_view *s, int n)
     ++{
     ++	s->buf += n;
     ++	s->len -= n;
      +}
      
       ## reftable/record.h (new) ##
     @@ reftable/record.h (new)
      +#define RECORD_H
      +
      +#include "reftable.h"
     -+#include "slice.h"
     ++#include "strbuf.h"
     ++#include "system.h"
     ++
     ++/*
     ++  A substring of existing string data. This structure takes no responsibility
     ++  for the lifetime of the data it points to.
     ++*/
     ++struct string_view {
     ++	uint8_t *buf;
     ++	int len;
     ++};
     ++
     ++/* Advance `s.buf` by `n`, and decrease length. */
     ++void string_view_consume(struct string_view *s, int n);
      +
      +/* utilities for de/encoding varints */
      +
     -+int get_var_int(uint64_t *dest, struct slice *in);
     -+int put_var_int(struct slice *dest, uint64_t val);
     ++int get_var_int(uint64_t *dest, struct string_view *in);
     ++int put_var_int(struct string_view *dest, uint64_t val);
      +
      +/* Methods for records. */
      +struct reftable_record_vtable {
     -+	/* encode the key of to a byte slice. */
     -+	void (*key)(const void *rec, struct slice *dest);
     ++	/* encode the key of to a uint8_t strbuf. */
     ++	void (*key)(const void *rec, struct strbuf *dest);
      +
      +	/* The record type of ('r' for ref). */
     -+	byte type;
     ++	uint8_t type;
      +
      +	void (*copy_from)(void *dest, const void *src, int hash_size);
      +
      +	/* a value of [0..7], indicating record subvariants (eg. ref vs. symref
      +	 * vs ref deletion) */
     -+	byte (*val_type)(const void *rec);
     ++	uint8_t (*val_type)(const void *rec);
      +
      +	/* encodes rec into dest, returning how much space was used. */
     -+	int (*encode)(const void *rec, struct slice dest, int hash_size);
     ++	int (*encode)(const void *rec, struct string_view dest, int hash_size);
      +
      +	/* decode data from `src` into the record. */
     -+	int (*decode)(void *rec, struct slice key, byte extra, struct slice src,
     -+		      int hash_size);
     ++	int (*decode)(void *rec, struct strbuf key, uint8_t extra,
     ++		      struct string_view src, int hash_size);
      +
      +	/* deallocate and null the record. */
      +	void (*clear)(void *rec);
     @@ reftable/record.h (new)
      +};
      +
      +/* returns true for recognized block types. Block start with the block type. */
     -+int reftable_is_block_type(byte typ);
     ++int reftable_is_block_type(uint8_t typ);
      +
      +/* creates a malloced record of the given type. Dispose with record_destroy */
     -+struct reftable_record reftable_new_record(byte typ);
     ++struct reftable_record reftable_new_record(uint8_t typ);
      +
      +extern struct reftable_record_vtable reftable_ref_record_vtable;
      +
      +/* Encode `key` into `dest`. Sets `restart` to indicate a restart. Returns
      +   number of bytes written. */
     -+int reftable_encode_key(bool *restart, struct slice dest, struct slice prev_key,
     -+			struct slice key, byte extra);
     ++int reftable_encode_key(bool *restart, struct string_view dest,
     ++			struct strbuf prev_key, struct strbuf key,
     ++			uint8_t extra);
      +
      +/* Decode into `key` and `extra` from `in` */
     -+int reftable_decode_key(struct slice *key, byte *extra, struct slice last_key,
     -+			struct slice in);
     ++int reftable_decode_key(struct strbuf *key, uint8_t *extra,
     ++			struct strbuf last_key, struct string_view in);
      +
      +/* reftable_index_record are used internally to speed up lookups. */
      +struct reftable_index_record {
      +	uint64_t offset; /* Offset of block */
     -+	struct slice last_key; /* Last key of the block. */
     ++	struct strbuf last_key; /* Last key of the block. */
      +};
      +
      +/* reftable_obj_record stores an object ID => ref mapping. */
      +struct reftable_obj_record {
     -+	byte *hash_prefix; /* leading bytes of the object ID */
     ++	uint8_t *hash_prefix; /* leading bytes of the object ID */
      +	int hash_prefix_len; /* number of leading bytes. Constant
      +			      * across a single table. */
      +	uint64_t *offsets; /* a vector of file offsets. */
     @@ reftable/record.h (new)
      +
      +/* see struct record_vtable */
      +
     -+void reftable_record_key(struct reftable_record *rec, struct slice *dest);
     -+byte reftable_record_type(struct reftable_record *rec);
     ++void reftable_record_key(struct reftable_record *rec, struct strbuf *dest);
     ++uint8_t reftable_record_type(struct reftable_record *rec);
      +void reftable_record_copy_from(struct reftable_record *rec,
      +			       struct reftable_record *src, int hash_size);
     -+byte reftable_record_val_type(struct reftable_record *rec);
     -+int reftable_record_encode(struct reftable_record *rec, struct slice dest,
     ++uint8_t reftable_record_val_type(struct reftable_record *rec);
     ++int reftable_record_encode(struct reftable_record *rec, struct string_view dest,
     ++			   int hash_size);
     ++int reftable_record_decode(struct reftable_record *rec, struct strbuf key,
     ++			   uint8_t extra, struct string_view src,
      +			   int hash_size);
     -+int reftable_record_decode(struct reftable_record *rec, struct slice key,
     -+			   byte extra, struct slice src, int hash_size);
      +bool reftable_record_is_deletion(struct reftable_record *rec);
      +
      +/* zeroes out the embedded record */
     @@ reftable/record_test.c (new)
      +			      ((uint64_t)1 << 63) + ((uint64_t)1 << 63) - 1 };
      +	int i = 0;
      +	for (i = 0; i < ARRAY_SIZE(inputs); i++) {
     -+		byte dest[10];
     -+
     -+		struct slice out = { .buf = dest, .len = 10, .cap = 10 };
     ++		uint8_t dest[10];
      +
     ++		struct string_view out = {
     ++			.buf = dest,
     ++			.len = sizeof(dest),
     ++		};
      +		uint64_t in = inputs[i];
      +		int n = put_var_int(&out, in);
      +		uint64_t got = 0;
     @@ reftable/record_test.c (new)
      +
      +	int i = 0;
      +	for (i = 0; i < ARRAY_SIZE(cases); i++) {
     -+		struct slice a = SLICE_INIT;
     -+		struct slice b = SLICE_INIT;
     -+		slice_addstr(&a, cases[i].a);
     -+		slice_addstr(&b, cases[i].b);
     ++		struct strbuf a = STRBUF_INIT;
     ++		struct strbuf b = STRBUF_INIT;
     ++		strbuf_addstr(&a, cases[i].a);
     ++		strbuf_addstr(&b, cases[i].b);
      +		assert(common_prefix_size(&a, &b) == cases[i].want);
      +
     -+		slice_release(&a);
     -+		slice_release(&b);
     ++		strbuf_release(&a);
     ++		strbuf_release(&b);
      +	}
      +}
      +
     -+static void set_hash(byte *h, int j)
     ++static void set_hash(uint8_t *h, int j)
      +{
      +	int i = 0;
      +	for (i = 0; i < hash_size(SHA1_ID); i++) {
     @@ reftable/record_test.c (new)
      +			.target = xstrdup("old value"),
      +		};
      +		struct reftable_record rec_out = { 0 };
     -+		struct slice key = SLICE_INIT;
     ++		struct strbuf key = STRBUF_INIT;
      +		struct reftable_record rec = { 0 };
     -+		struct slice dest = SLICE_INIT;
     ++		uint8_t buffer[1024] = { 0 };
     ++		struct string_view dest = {
     ++			.buf = buffer,
     ++			.len = sizeof(buffer),
     ++		};
     ++
      +		int n, m;
      +
      +		switch (i) {
     @@ reftable/record_test.c (new)
      +		assert(reftable_record_val_type(&rec) == i);
      +
      +		reftable_record_key(&rec, &key);
     -+		slice_grow(&dest, 1024);
     -+		slice_setlen(&dest, 1024);
      +		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
      +		assert(n > 0);
      +
     @@ reftable/record_test.c (new)
      +		assert((out.target != NULL) == (in.target != NULL));
      +		reftable_record_clear(&rec_out);
      +
     -+		slice_release(&key);
     -+		slice_release(&dest);
     ++		strbuf_release(&key);
      +		reftable_ref_record_clear(&in);
      +	}
      +}
     @@ reftable/record_test.c (new)
      +	set_test_hash(in[0].old_hash, 2);
      +	for (int i = 0; i < ARRAY_SIZE(in); i++) {
      +		struct reftable_record rec = { 0 };
     -+		struct slice key = SLICE_INIT;
     -+		struct slice dest = SLICE_INIT;
     ++		struct strbuf key = STRBUF_INIT;
     ++		uint8_t buffer[1024] = { 0 };
     ++		struct string_view dest = {
     ++			.buf = buffer,
     ++			.len = sizeof(buffer),
     ++		};
      +		/* populate out, to check for leaks. */
      +		struct reftable_log_record out = {
      +			.ref_name = xstrdup("old name"),
     @@ reftable/record_test.c (new)
      +
      +		reftable_record_key(&rec, &key);
      +
     -+		slice_grow(&dest, 1024);
     -+		slice_setlen(&dest, 1024);
     -+
      +		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
      +		assert(n >= 0);
      +		reftable_record_from_log(&rec_out, &out);
     @@ reftable/record_test.c (new)
      +
      +		assert(reftable_log_record_equal(&in[i], &out, SHA1_SIZE));
      +		reftable_log_record_clear(&in[i]);
     -+		slice_release(&key);
     -+		slice_release(&dest);
     ++		strbuf_release(&key);
      +		reftable_record_clear(&rec_out);
      +	}
      +}
     @@ reftable/record_test.c (new)
      +static void test_u24_roundtrip(void)
      +{
      +	uint32_t in = 0x112233;
     -+	byte dest[3];
     ++	uint8_t dest[3];
      +	uint32_t out;
      +	put_be24(dest, in);
      +	out = get_be24(dest);
     @@ reftable/record_test.c (new)
      +
      +static void test_key_roundtrip(void)
      +{
     -+	struct slice dest = SLICE_INIT;
     -+	struct slice last_key = SLICE_INIT;
     -+	struct slice key = SLICE_INIT;
     -+	struct slice roundtrip = SLICE_INIT;
     ++	uint8_t buffer[1024] = { 0 };
     ++	struct string_view dest = {
     ++		.buf = buffer,
     ++		.len = sizeof(buffer),
     ++	};
     ++	struct strbuf last_key = STRBUF_INIT;
     ++	struct strbuf key = STRBUF_INIT;
     ++	struct strbuf roundtrip = STRBUF_INIT;
      +	bool restart;
     -+	byte extra;
     ++	uint8_t extra;
      +	int n, m;
     -+	byte rt_extra;
     ++	uint8_t rt_extra;
      +
     -+	slice_grow(&dest, 1024);
     -+	slice_setlen(&dest, 1024);
     -+	slice_addstr(&last_key, "refs/heads/master");
     -+	slice_addstr(&key, "refs/tags/bla");
     ++	strbuf_addstr(&last_key, "refs/heads/master");
     ++	strbuf_addstr(&key, "refs/tags/bla");
      +	extra = 6;
      +	n = reftable_encode_key(&restart, dest, last_key, key, extra);
      +	assert(!restart);
     @@ reftable/record_test.c (new)
      +
      +	m = reftable_decode_key(&roundtrip, &rt_extra, last_key, dest);
      +	assert(n == m);
     -+	assert(0 == slice_cmp(&key, &roundtrip));
     ++	assert(0 == strbuf_cmp(&key, &roundtrip));
      +	assert(rt_extra == extra);
      +
     -+	slice_release(&last_key);
     -+	slice_release(&key);
     -+	slice_release(&dest);
     -+	slice_release(&roundtrip);
     ++	strbuf_release(&last_key);
     ++	strbuf_release(&key);
     ++	strbuf_release(&roundtrip);
      +}
      +
      +static void test_reftable_obj_record_roundtrip(void)
      +{
     -+	byte testHash1[SHA1_SIZE] = { 1, 2, 3, 4, 0 };
     ++	uint8_t testHash1[SHA1_SIZE] = { 1, 2, 3, 4, 0 };
      +	uint64_t till9[] = { 1, 2, 3, 4, 500, 600, 700, 800, 9000 };
      +	struct reftable_obj_record recs[3] = { {
      +						       .hash_prefix = testHash1,
     @@ reftable/record_test.c (new)
      +	int i = 0;
      +	for (i = 0; i < ARRAY_SIZE(recs); i++) {
      +		struct reftable_obj_record in = recs[i];
     -+		struct slice dest = SLICE_INIT;
     ++		uint8_t buffer[1024] = { 0 };
     ++		struct string_view dest = {
     ++			.buf = buffer,
     ++			.len = sizeof(buffer),
     ++		};
      +		struct reftable_record rec = { 0 };
     -+		struct slice key = SLICE_INIT;
     ++		struct strbuf key = STRBUF_INIT;
      +		struct reftable_obj_record out = { 0 };
      +		struct reftable_record rec_out = { 0 };
      +		int n, m;
     -+		byte extra;
     ++		uint8_t extra;
      +
      +		reftable_record_from_obj(&rec, &in);
      +		test_copy(&rec);
      +		reftable_record_key(&rec, &key);
     -+		slice_grow(&dest, 1024);
     -+		slice_setlen(&dest, 1024);
      +		n = reftable_record_encode(&rec, dest, SHA1_SIZE);
      +		assert(n > 0);
      +		extra = reftable_record_val_type(&rec);
     @@ reftable/record_test.c (new)
      +			       in.hash_prefix_len));
      +		assert(0 == memcmp(in.offsets, out.offsets,
      +				   sizeof(uint64_t) * in.offset_len));
     -+		slice_release(&key);
     -+		slice_release(&dest);
     ++		strbuf_release(&key);
      +		reftable_record_clear(&rec_out);
      +	}
      +}
     @@ reftable/record_test.c (new)
      +{
      +	struct reftable_index_record in = {
      +		.offset = 42,
     -+		.last_key = SLICE_INIT,
     ++		.last_key = STRBUF_INIT,
     ++	};
     ++	uint8_t buffer[1024] = { 0 };
     ++	struct string_view dest = {
     ++		.buf = buffer,
     ++		.len = sizeof(buffer),
      +	};
     -+	struct slice dest = SLICE_INIT;
     -+	struct slice key = SLICE_INIT;
     ++	struct strbuf key = STRBUF_INIT;
      +	struct reftable_record rec = { 0 };
     -+	struct reftable_index_record out = { .last_key = SLICE_INIT };
     ++	struct reftable_index_record out = { .last_key = STRBUF_INIT };
      +	struct reftable_record out_rec = { NULL };
      +	int n, m;
     -+	byte extra;
     ++	uint8_t extra;
      +
     -+	slice_addstr(&in.last_key, "refs/heads/master");
     ++	strbuf_addstr(&in.last_key, "refs/heads/master");
      +	reftable_record_from_index(&rec, &in);
      +	reftable_record_key(&rec, &key);
      +	test_copy(&rec);
      +
     -+	assert(0 == slice_cmp(&key, &in.last_key));
     -+	slice_grow(&dest, 1024);
     -+	slice_setlen(&dest, 1024);
     ++	assert(0 == strbuf_cmp(&key, &in.last_key));
      +	n = reftable_record_encode(&rec, dest, SHA1_SIZE);
      +	assert(n > 0);
      +
     @@ reftable/record_test.c (new)
      +	assert(in.offset == out.offset);
      +
      +	reftable_record_clear(&out_rec);
     -+	slice_release(&key);
     -+	slice_release(&in.last_key);
     -+	slice_release(&dest);
     ++	strbuf_release(&key);
     ++	strbuf_release(&in.last_key);
      +}
      +
      +int record_test_main(int argc, const char *argv[])
     @@ reftable/refname.c (new)
      +#include "reftable.h"
      +#include "basics.h"
      +#include "refname.h"
     -+#include "slice.h"
     ++#include "strbuf.h"
      +
      +struct find_arg {
      +	char **names;
     @@ reftable/refname.c (new)
      +	return err;
      +}
      +
     -+static void slice_trim_component(struct slice *sl)
     ++static void strbuf_trim_component(struct strbuf *sl)
      +{
      +	while (sl->len > 0) {
      +		bool is_slash = (sl->buf[sl->len - 1] == '/');
     -+		slice_setlen(sl, sl->len - 1);
     ++		strbuf_setlen(sl, sl->len - 1);
      +		if (is_slash)
      +			break;
      +	}
     @@ reftable/refname.c (new)
      +
      +int modification_validate(struct modification *mod)
      +{
     -+	struct slice slashed = SLICE_INIT;
     ++	struct strbuf slashed = STRBUF_INIT;
      +	int err = 0;
      +	int i = 0;
      +	for (; i < mod->add_len; i++) {
      +		err = validate_ref_name(mod->add[i]);
      +		if (err)
      +			goto done;
     -+		slice_reset(&slashed);
     -+		slice_addstr(&slashed, mod->add[i]);
     -+		slice_addstr(&slashed, "/");
     ++		strbuf_reset(&slashed);
     ++		strbuf_addstr(&slashed, mod->add[i]);
     ++		strbuf_addstr(&slashed, "/");
      +
     -+		err = modification_has_ref_with_prefix(
     -+			mod, slice_as_string(&slashed));
     ++		err = modification_has_ref_with_prefix(mod, slashed.buf);
      +		if (err == 0) {
      +			err = REFTABLE_NAME_CONFLICT;
      +			goto done;
     @@ reftable/refname.c (new)
      +		if (err < 0)
      +			goto done;
      +
     -+		slice_reset(&slashed);
     -+		slice_addstr(&slashed, mod->add[i]);
     ++		strbuf_reset(&slashed);
     ++		strbuf_addstr(&slashed, mod->add[i]);
      +		while (slashed.len) {
     -+			slice_trim_component(&slashed);
     -+			err = modification_has_ref(mod,
     -+						   slice_as_string(&slashed));
     ++			strbuf_trim_component(&slashed);
     ++			err = modification_has_ref(mod, slashed.buf);
      +			if (err == 0) {
      +				err = REFTABLE_NAME_CONFLICT;
      +				goto done;
     @@ reftable/refname.c (new)
      +	}
      +	err = 0;
      +done:
     -+	slice_release(&slashed);
     ++	strbuf_release(&slashed);
      +	return err;
      +}
      
     @@ reftable/refname_test.c (new)
      +static void test_conflict(void)
      +{
      +	struct reftable_write_options opts = { 0 };
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_writer *w =
     -+		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +	struct reftable_ref_record rec = {
      +		.ref_name = "a/b",
      +		.target = "destination", /* make sure it's not a symref. */
     @@ reftable/refname_test.c (new)
      +	assert_err(err);
      +	reftable_writer_free(w);
      +
     -+	block_source_from_slice(&source, &buf);
     ++	block_source_from_strbuf(&source, &buf);
      +	err = reftable_new_reader(&rd, &source, "filename");
      +	assert_err(err);
      +
     @@ reftable/refname_test.c (new)
      +	}
      +
      +	reftable_reader_free(rd);
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +}
      +
      +int refname_test_main(int argc, const char *argv[])
     @@ reftable/reftable-tests.h (new)
      +int record_test_main(int argc, const char **argv);
      +int refname_test_main(int argc, const char **argv);
      +int reftable_test_main(int argc, const char **argv);
     -+int slice_test_main(int argc, const char **argv);
     ++int strbuf_test_main(int argc, const char **argv);
      +int stack_test_main(int argc, const char **argv);
      +int tree_test_main(int argc, const char **argv);
      +int reftable_dump_main(int argc, char *const *argv);
     @@ reftable/reftable.h (new)
      +
      +/* reftable_new_writer creates a new writer */
      +struct reftable_writer *
     -+reftable_new_writer(int (*writer_func)(void *, uint8_t *, size_t),
     ++reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
      +		    void *writer_arg, struct reftable_write_options *opts);
      +
      +/* write to a file descriptor. fdp should be an int* pointing to the fd. */
     -+int reftable_fd_write(void *fdp, uint8_t *data, size_t size);
     ++int reftable_fd_write(void *fdp, const void *data, size_t size);
      +
      +/* Set the range of update indices for the records we will add.  When
      +   writing a table into a stack, the min should be at least
     @@ reftable/reftable_test.c (new)
      +
      +static void test_buffer(void)
      +{
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_block_source source = { NULL };
      +	struct reftable_block out = { 0 };
      +	int n;
     -+	byte in[] = "hello";
     -+	slice_add(&buf, in, sizeof(in));
     -+	block_source_from_slice(&source, &buf);
     ++	uint8_t in[] = "hello";
     ++	strbuf_add(&buf, in, sizeof(in));
     ++	block_source_from_strbuf(&source, &buf);
      +	assert(block_source_size(&source) == 6);
      +	n = block_source_read_block(&source, &out, 0, sizeof(in));
      +	assert(n == sizeof(in));
     @@ reftable/reftable_test.c (new)
      +
      +	reftable_block_done(&out);
      +	block_source_close(&source);
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +}
      +
      +static void test_default_write_opts(void)
      +{
      +	struct reftable_write_options opts = { 0 };
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_writer *w =
     -+		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +
      +	struct reftable_ref_record rec = {
      +		.ref_name = "master",
     @@ reftable/reftable_test.c (new)
      +	assert_err(err);
      +	reftable_writer_free(w);
      +
     -+	block_source_from_slice(&source, &buf);
     ++	block_source_from_strbuf(&source, &buf);
      +
      +	err = reftable_new_reader(&rd, &source, "filename");
      +	assert_err(err);
     @@ reftable/reftable_test.c (new)
      +
      +	reftable_merged_table_close(merged);
      +	reftable_merged_table_free(merged);
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +}
      +
     -+static void write_table(char ***names, struct slice *buf, int N, int block_size,
     -+			uint32_t hash_id)
     ++static void write_table(char ***names, struct strbuf *buf, int N,
     ++			int block_size, uint32_t hash_id)
      +{
      +	struct reftable_write_options opts = {
      +		.block_size = block_size,
      +		.hash_id = hash_id,
      +	};
      +	struct reftable_writer *w =
     -+		reftable_new_writer(&slice_add_void, buf, &opts);
     ++		reftable_new_writer(&strbuf_add_void, buf, &opts);
      +	struct reftable_ref_record ref = { 0 };
      +	int i = 0, n;
      +	struct reftable_log_record log = { 0 };
     @@ reftable/reftable_test.c (new)
      +	*names = reftable_calloc(sizeof(char *) * (N + 1));
      +	reftable_writer_set_limits(w, update_index, update_index);
      +	for (i = 0; i < N; i++) {
     -+		byte hash[SHA256_SIZE] = { 0 };
     ++		uint8_t hash[SHA256_SIZE] = { 0 };
      +		char name[100];
      +		int n;
      +
     @@ reftable/reftable_test.c (new)
      +	}
      +
      +	for (i = 0; i < N; i++) {
     -+		byte hash[SHA256_SIZE] = { 0 };
     ++		uint8_t hash[SHA256_SIZE] = { 0 };
      +		char name[100];
      +		int n;
      +
     @@ reftable/reftable_test.c (new)
      +
      +static void test_log_buffer_size(void)
      +{
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_write_options opts = {
      +		.block_size = 4096,
      +	};
     @@ reftable/reftable_test.c (new)
      +		.message = "commit: 9\n",
      +	};
      +	struct reftable_writer *w =
     -+		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +
      +	/* This tests buffer extension for log compression. Must use a random
      +	   hash, to ensure that the compressed part is larger than the original.
      +	*/
     -+	byte hash1[SHA1_SIZE], hash2[SHA1_SIZE];
     ++	uint8_t hash1[SHA1_SIZE], hash2[SHA1_SIZE];
      +	for (int i = 0; i < SHA1_SIZE; i++) {
     -+		hash1[i] = (byte)(rand() % 256);
     -+		hash2[i] = (byte)(rand() % 256);
     ++		hash1[i] = (uint8_t)(rand() % 256);
     ++		hash2[i] = (uint8_t)(rand() % 256);
      +	}
      +	log.old_hash = hash1;
      +	log.new_hash = hash2;
     @@ reftable/reftable_test.c (new)
      +	err = reftable_writer_close(w);
      +	assert_err(err);
      +	reftable_writer_free(w);
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +}
      +
      +static void test_log_write_read(void)
     @@ reftable/reftable_test.c (new)
      +	struct reftable_iterator it = { 0 };
      +	struct reftable_reader rd = { 0 };
      +	struct reftable_block_source source = { 0 };
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_writer *w =
     -+		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +	const struct reftable_stats *stats = NULL;
      +	reftable_writer_set_limits(w, 0, N);
      +	for (i = 0; i < N; i++) {
     @@ reftable/reftable_test.c (new)
      +		assert_err(err);
      +	}
      +	for (i = 0; i < N; i++) {
     -+		byte hash1[SHA1_SIZE], hash2[SHA1_SIZE];
     ++		uint8_t hash1[SHA1_SIZE], hash2[SHA1_SIZE];
      +		struct reftable_log_record log = { 0 };
      +		set_test_hash(hash1, i);
      +		set_test_hash(hash2, i + 1);
     @@ reftable/reftable_test.c (new)
      +	reftable_writer_free(w);
      +	w = NULL;
      +
     -+	block_source_from_slice(&source, &buf);
     ++	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.log");
      +	assert_err(err);
     @@ reftable/reftable_test.c (new)
      +	reftable_iterator_destroy(&it);
      +
      +	/* cleanup. */
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +	free_names(names);
      +	reader_close(&rd);
      +}
     @@ reftable/reftable_test.c (new)
      +static void test_table_read_write_sequential(void)
      +{
      +	char **names;
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	int N = 50;
      +	struct reftable_iterator it = { 0 };
      +	struct reftable_block_source source = { 0 };
     @@ reftable/reftable_test.c (new)
      +
      +	write_table(&names, &buf, N, 256, SHA1_ID);
      +
     -+	block_source_from_slice(&source, &buf);
     ++	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.ref");
      +	assert_err(err);
     @@ reftable/reftable_test.c (new)
      +	}
      +	assert(j == N);
      +	reftable_iterator_destroy(&it);
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +	free_names(names);
      +
      +	reader_close(&rd);
     @@ reftable/reftable_test.c (new)
      +static void test_table_write_small_table(void)
      +{
      +	char **names;
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	int N = 1;
      +	write_table(&names, &buf, N, 4096, SHA1_ID);
      +	assert(buf.len < 200);
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +	free_names(names);
      +}
      +
      +static void test_table_read_api(void)
      +{
      +	char **names;
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	int N = 50;
      +	struct reftable_reader rd = { 0 };
      +	struct reftable_block_source source = { 0 };
     @@ reftable/reftable_test.c (new)
      +
      +	write_table(&names, &buf, N, 256, SHA1_ID);
      +
     -+	block_source_from_slice(&source, &buf);
     ++	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.ref");
      +	assert_err(err);
     @@ reftable/reftable_test.c (new)
      +	err = reftable_iterator_next_log(&it, &log);
      +	assert(err == REFTABLE_API_ERROR);
      +
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +	for (i = 0; i < N; i++) {
      +		reftable_free(names[i]);
      +	}
      +	reftable_iterator_destroy(&it);
      +	reftable_free(names);
      +	reader_close(&rd);
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +}
      +
      +static void test_table_read_write_seek(bool index, int hash_id)
      +{
      +	char **names;
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	int N = 50;
      +	struct reftable_reader rd = { 0 };
      +	struct reftable_block_source source = { 0 };
     @@ reftable/reftable_test.c (new)
      +	int i = 0;
      +
      +	struct reftable_iterator it = { 0 };
     -+	struct slice pastLast = SLICE_INIT;
     ++	struct strbuf pastLast = STRBUF_INIT;
      +	struct reftable_ref_record ref = { 0 };
      +
      +	write_table(&names, &buf, N, 256, hash_id);
      +
     -+	block_source_from_slice(&source, &buf);
     ++	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.ref");
      +	assert_err(err);
     @@ reftable/reftable_test.c (new)
      +		reftable_iterator_destroy(&it);
      +	}
      +
     -+	slice_addstr(&pastLast, names[N - 1]);
     -+	slice_addstr(&pastLast, "/");
     ++	strbuf_addstr(&pastLast, names[N - 1]);
     ++	strbuf_addstr(&pastLast, "/");
      +
     -+	err = reftable_reader_seek_ref(&rd, &it, slice_as_string(&pastLast));
     ++	err = reftable_reader_seek_ref(&rd, &it, pastLast.buf);
      +	if (err == 0) {
      +		struct reftable_ref_record ref = { 0 };
      +		int err = reftable_iterator_next_ref(&it, &ref);
     @@ reftable/reftable_test.c (new)
      +		assert(err > 0);
      +	}
      +
     -+	slice_release(&pastLast);
     ++	strbuf_release(&pastLast);
      +	reftable_iterator_destroy(&it);
      +
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +	for (i = 0; i < N; i++) {
      +		reftable_free(names[i]);
      +	}
     @@ reftable/reftable_test.c (new)
      +	int N = 50;
      +	char **want_names = reftable_calloc(sizeof(char *) * (N + 1));
      +	int want_names_len = 0;
     -+	byte want_hash[SHA1_SIZE];
     ++	uint8_t want_hash[SHA1_SIZE];
      +
      +	struct reftable_write_options opts = {
      +		.block_size = 256,
     @@ reftable/reftable_test.c (new)
      +	struct reftable_reader rd;
      +	struct reftable_block_source source = { 0 };
      +
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_writer *w =
     -+		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +
      +	struct reftable_iterator it = { 0 };
      +	int j;
     @@ reftable/reftable_test.c (new)
      +	set_test_hash(want_hash, 4);
      +
      +	for (i = 0; i < N; i++) {
     -+		byte hash[SHA1_SIZE];
     ++		uint8_t hash[SHA1_SIZE];
      +		char fill[51] = { 0 };
      +		char name[100];
     -+		byte hash1[SHA1_SIZE];
     -+		byte hash2[SHA1_SIZE];
     ++		uint8_t hash1[SHA1_SIZE];
     ++		uint8_t hash2[SHA1_SIZE];
      +		struct reftable_ref_record ref = { 0 };
      +
      +		memset(hash, i, sizeof(hash));
     @@ reftable/reftable_test.c (new)
      +	reftable_writer_free(w);
      +	w = NULL;
      +
     -+	block_source_from_slice(&source, &buf);
     ++	block_source_from_strbuf(&source, &buf);
      +
      +	err = init_reader(&rd, &source, "file.ref");
      +	assert_err(err);
     @@ reftable/reftable_test.c (new)
      +	}
      +	assert(j == want_names_len);
      +
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +	free_names(want_names);
      +	reftable_iterator_destroy(&it);
      +	reader_close(&rd);
     @@ reftable/reftable_test.c (new)
      +static void test_table_empty(void)
      +{
      +	struct reftable_write_options opts = { 0 };
     -+	struct slice buf = SLICE_INIT;
     ++	struct strbuf buf = STRBUF_INIT;
      +	struct reftable_writer *w =
     -+		reftable_new_writer(&slice_add_void, &buf, &opts);
     ++		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +	struct reftable_block_source source = { 0 };
      +	struct reftable_reader *rd = NULL;
      +	struct reftable_ref_record rec = { 0 };
     @@ reftable/reftable_test.c (new)
      +
      +	assert(buf.len == header_size(1) + footer_size(1));
      +
     -+	block_source_from_slice(&source, &buf);
     ++	block_source_from_strbuf(&source, &buf);
      +
      +	err = reftable_new_reader(&rd, &source, "filename");
      +	assert_err(err);
     @@ reftable/reftable_test.c (new)
      +
      +	reftable_iterator_destroy(&it);
      +	reftable_reader_free(rd);
     -+	slice_release(&buf);
     ++	strbuf_release(&buf);
      +}
      +
      +int reftable_test_main(int argc, const char *argv[])
     @@ reftable/reftable_test.c (new)
      +	return test_main(argc, argv);
      +}
      
     - ## reftable/slice.c (new) ##
     + ## reftable/stack.c (new) ##
      @@
      +/*
      +Copyright 2020 Google LLC
     @@ reftable/slice.c (new)
      +https://developers.google.com/open-source/licenses/bsd
      +*/
      +
     -+#include "slice.h"
     ++#include "stack.h"
      +
      +#include "system.h"
     -+
     ++#include "merged.h"
     ++#include "reader.h"
     ++#include "refname.h"
      +#include "reftable.h"
     ++#include "writer.h"
      +
     -+struct slice reftable_empty_slice = SLICE_INIT;
     -+
     -+void slice_init(struct slice *s)
     -+{
     -+	struct slice empty = SLICE_INIT;
     -+	*s = empty;
     -+}
     -+
     -+void slice_grow(struct slice *s, size_t extra)
     ++int reftable_new_stack(struct reftable_stack **dest, const char *dir,
     ++		       struct reftable_write_options config)
      +{
     -+	size_t newcap = s->len + extra + 1;
     -+	if (newcap > s->cap) {
     -+		s->buf = reftable_realloc(s->buf, newcap);
     -+		s->cap = newcap;
     -+	}
     -+}
     ++	struct reftable_stack *p =
     ++		reftable_calloc(sizeof(struct reftable_stack));
     ++	struct strbuf list_file_name = STRBUF_INIT;
     ++	int err = 0;
      +
     -+static void slice_resize(struct slice *s, int l)
     -+{
     -+	int zl = l + 1; /* one byte for 0 termination. */
     -+	assert(s->canary == SLICE_CANARY);
     -+	if (s->cap < zl) {
     -+		int c = s->cap * 2;
     -+		if (c < zl) {
     -+			c = zl;
     -+		}
     -+		s->cap = c;
     -+		s->buf = reftable_realloc(s->buf, s->cap);
     ++	if (config.hash_id == 0) {
     ++		config.hash_id = SHA1_ID;
      +	}
     -+	s->len = l;
     -+	s->buf[l] = 0;
     -+}
     -+
     -+void slice_setlen(struct slice *s, size_t l)
     -+{
     -+	assert(s->cap >= l + 1);
     -+	s->len = l;
     -+	s->buf[l] = 0;
     -+}
      +
     -+void slice_reset(struct slice *s)
     -+{
     -+	slice_resize(s, 0);
     -+}
     ++	*dest = NULL;
      +
     -+void slice_addstr(struct slice *d, const char *s)
     -+{
     -+	int l1 = d->len;
     -+	int l2 = strlen(s);
     -+	assert(d->canary == SLICE_CANARY);
     ++	strbuf_reset(&list_file_name);
     ++	strbuf_addstr(&list_file_name, dir);
     ++	strbuf_addstr(&list_file_name, "/tables.list");
      +
     -+	slice_resize(d, l2 + l1);
     -+	memcpy(d->buf + l1, s, l2);
     -+}
     ++	p->list_file = strbuf_detach(&list_file_name, NULL);
     ++	p->reftable_dir = xstrdup(dir);
     ++	p->config = config;
      +
     -+void slice_addbuf(struct slice *s, struct slice *a)
     -+{
     -+	int end = s->len;
     -+	assert(s->canary == SLICE_CANARY);
     -+	slice_resize(s, s->len + a->len);
     -+	memcpy(s->buf + end, a->buf, a->len);
     ++	err = reftable_stack_reload_maybe_reuse(p, true);
     ++	if (err < 0) {
     ++		reftable_stack_destroy(p);
     ++	} else {
     ++		*dest = p;
     ++	}
     ++	return err;
      +}
      +
     -+void slice_consume(struct slice *s, int n)
     ++static int fd_read_lines(int fd, char ***namesp)
      +{
     -+	assert(s->canary == SLICE_CANARY);
     -+	s->buf += n;
     -+	s->len -= n;
     -+}
     ++	off_t size = lseek(fd, 0, SEEK_END);
     ++	char *buf = NULL;
     ++	int err = 0;
     ++	if (size < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++	err = lseek(fd, 0, SEEK_SET);
     ++	if (err < 0) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
      +
     -+char *slice_detach(struct slice *s)
     -+{
     -+	char *p = NULL;
     -+	slice_as_string(s);
     -+	p = (char *)s->buf;
     -+	s->buf = NULL;
     -+	s->cap = 0;
     -+	s->len = 0;
     -+	return p;
     -+}
     ++	buf = reftable_malloc(size + 1);
     ++	if (read(fd, buf, size) != size) {
     ++		err = REFTABLE_IO_ERROR;
     ++		goto done;
     ++	}
     ++	buf[size] = 0;
      +
     -+void slice_release(struct slice *s)
     -+{
     -+	byte *ptr = s->buf;
     -+	assert(s->canary == SLICE_CANARY);
     -+	s->buf = NULL;
     -+	s->cap = 0;
     -+	s->len = 0;
     -+	reftable_free(ptr);
     -+}
     ++	parse_names(buf, size, namesp);
      +
     -+/* return the underlying data as char*. len is left unchanged, but
     -+   a \0 is added at the end. */
     -+const char *slice_as_string(struct slice *s)
     -+{
     -+	return (const char *)s->buf;
     ++done:
     ++	reftable_free(buf);
     ++	return err;
      +}
      +
     -+int slice_cmp(const struct slice *a, const struct slice *b)
     ++int read_lines(const char *filename, char ***namesp)
      +{
     -+	int min = a->len < b->len ? a->len : b->len;
     -+	int res = memcmp(a->buf, b->buf, min);
     -+	assert(a->canary == SLICE_CANARY);
     -+	assert(b->canary == SLICE_CANARY);
     -+	if (res != 0)
     -+		return res;
     -+	if (a->len < b->len)
     -+		return -1;
     -+	else if (a->len > b->len)
     -+		return 1;
     -+	else
     -+		return 0;
     -+}
     ++	int fd = open(filename, O_RDONLY, 0644);
     ++	int err = 0;
     ++	if (fd < 0) {
     ++		if (errno == ENOENT) {
     ++			*namesp = reftable_calloc(sizeof(char *));
     ++			return 0;
     ++		}
      +
     -+int slice_add(struct slice *b, const byte *data, size_t sz)
     -+{
     -+	assert(b->canary == SLICE_CANARY);
     -+	slice_grow(b, sz);
     -+	memcpy(b->buf + b->len, data, sz);
     -+	b->len += sz;
     -+	b->buf[b->len] = 0;
     -+	return sz;
     ++		return REFTABLE_IO_ERROR;
     ++	}
     ++	err = fd_read_lines(fd, namesp);
     ++	close(fd);
     ++	return err;
      +}
      +
     -+int slice_add_void(void *b, byte *data, size_t sz)
     ++struct reftable_merged_table *
     ++reftable_stack_merged_table(struct reftable_stack *st)
      +{
     -+	return slice_add((struct slice *)b, data, sz);
     ++	return st->merged;
      +}
      +
     -+static uint64_t slice_size(void *b)
     ++/* Close and free the stack */
     ++void reftable_stack_destroy(struct reftable_stack *st)
      +{
     -+	return ((struct slice *)b)->len;
     ++	if (st->merged != NULL) {
     ++		reftable_merged_table_close(st->merged);
     ++		reftable_merged_table_free(st->merged);
     ++		st->merged = NULL;
     ++	}
     ++	FREE_AND_NULL(st->list_file);
     ++	FREE_AND_NULL(st->reftable_dir);
     ++	reftable_free(st);
      +}
      +
     -+static void slice_return_block(void *b, struct reftable_block *dest)
     ++static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
     ++						   int cur_len)
      +{
     -+	memset(dest->data, 0xff, dest->len);
     -+	reftable_free(dest->data);
     ++	struct reftable_reader **cur =
     ++		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
     ++	int i = 0;
     ++	for (i = 0; i < cur_len; i++) {
     ++		cur[i] = st->merged->stack[i];
     ++	}
     ++	return cur;
      +}
      +
     -+static void slice_close(void *b)
     ++static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
     ++				      bool reuse_open)
      +{
     -+}
     ++	int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
     ++	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
     ++	int err = 0;
     ++	int names_len = names_length(names);
     ++	struct reftable_reader **new_tables =
     ++		reftable_malloc(sizeof(struct reftable_reader *) * names_len);
     ++	int new_tables_len = 0;
     ++	struct reftable_merged_table *new_merged = NULL;
     ++	int i;
      +
     -+static int slice_read_block(void *v, struct reftable_block *dest, uint64_t off,
     -+			    uint32_t size)
     -+{
     -+	struct slice *b = (struct slice *)v;
     -+	assert(off + size <= b->len);
     -+	dest->data = reftable_calloc(size);
     -+	memcpy(dest->data, b->buf + off, size);
     -+	dest->len = size;
     -+	return size;
     -+}
     ++	while (*names) {
     ++		struct reftable_reader *rd = NULL;
     ++		char *name = *names++;
      +
     -+struct reftable_block_source_vtable slice_vtable = {
     -+	.size = &slice_size,
     -+	.read_block = &slice_read_block,
     -+	.return_block = &slice_return_block,
     -+	.close = &slice_close,
     -+};
     ++		/* this is linear; we assume compaction keeps the number of
     ++		   tables under control so this is not quadratic. */
     ++		int j = 0;
     ++		for (j = 0; reuse_open && j < cur_len; j++) {
     ++			if (cur[j] != NULL && 0 == strcmp(cur[j]->name, name)) {
     ++				rd = cur[j];
     ++				cur[j] = NULL;
     ++				break;
     ++			}
     ++		}
      +
     -+void block_source_from_slice(struct reftable_block_source *bs,
     -+			     struct slice *buf)
     -+{
     -+	assert(bs->ops == NULL);
     -+	bs->ops = &slice_vtable;
     -+	bs->arg = buf;
     -+}
     ++		if (rd == NULL) {
     ++			struct reftable_block_source src = { 0 };
     ++			struct strbuf table_path = STRBUF_INIT;
     ++			strbuf_addstr(&table_path, st->reftable_dir);
     ++			strbuf_addstr(&table_path, "/");
     ++			strbuf_addstr(&table_path, name);
      +
     -+static void malloc_return_block(void *b, struct reftable_block *dest)
     -+{
     -+	memset(dest->data, 0xff, dest->len);
     -+	reftable_free(dest->data);
     -+}
     ++			err = reftable_block_source_from_file(&src,
     ++							      table_path.buf);
     ++			strbuf_release(&table_path);
      +
     -+struct reftable_block_source_vtable malloc_vtable = {
     -+	.return_block = &malloc_return_block,
     -+};
     ++			if (err < 0)
     ++				goto done;
      +
     -+struct reftable_block_source malloc_block_source_instance = {
     -+	.ops = &malloc_vtable,
     -+};
     ++			err = reftable_new_reader(&rd, &src, name);
     ++			if (err < 0)
     ++				goto done;
     ++		}
      +
     -+struct reftable_block_source malloc_block_source(void)
     -+{
     -+	return malloc_block_source_instance;
     -+}
     -+
     -+int common_prefix_size(struct slice *a, struct slice *b)
     -+{
     -+	int p = 0;
     -+	assert(a->canary == SLICE_CANARY);
     -+	assert(b->canary == SLICE_CANARY);
     -+	while (p < a->len && p < b->len) {
     -+		if (a->buf[p] != b->buf[p]) {
     -+			break;
     -+		}
     -+		p++;
     -+	}
     -+
     -+	return p;
     -+}
     -
     - ## reftable/slice.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef SLICE_H
     -+#define SLICE_H
     -+
     -+#include "basics.h"
     -+#include "reftable.h"
     -+
     -+/*
     -+  Provides a bounds-checked, growable byte ranges. To use, initialize as "slice
     -+  x = SLICE_INIT;"
     -+ */
     -+struct slice {
     -+	int len;
     -+	int cap;
     -+	byte *buf;
     -+
     -+	/* Used to enforce initialization with SLICE_INIT */
     -+	byte canary;
     -+};
     -+#define SLICE_CANARY 0x42
     -+#define SLICE_INIT                       \
     -+	{                                \
     -+		0, 0, NULL, SLICE_CANARY \
     -+	}
     -+extern struct slice reftable_empty_slice;
     -+
     -+void slice_addstr(struct slice *dest, const char *src);
     -+
     -+/* Deallocate and clear slice */
     -+void slice_release(struct slice *slice);
     -+
     -+/* Set slice to 0 length, but retain buffer. */
     -+void slice_reset(struct slice *slice);
     -+
     -+/* Initializes a slice. Accepts a slice with random garbage. */
     -+void slice_init(struct slice *slice);
     -+
     -+/* Ensure that `buf` is \0 terminated. */
     -+const char *slice_as_string(struct slice *src);
     -+
     -+/* Return `buf`, clearing out `s` */
     -+char *slice_detach(struct slice *s);
     -+
     -+/* Set length of the slace to `l`, but don't reallocated. */
     -+void slice_setlen(struct slice *s, size_t l);
     -+
     -+/* Ensure `l` bytes beyond current length are available */
     -+void slice_grow(struct slice *s, size_t l);
     -+
     -+/* Signed comparison */
     -+int slice_cmp(const struct slice *a, const struct slice *b);
     -+
     -+/* Append `data` to the `dest` slice.  */
     -+int slice_add(struct slice *dest, const byte *data, size_t sz);
     -+
     -+/* Append `add` to `dest. */
     -+void slice_addbuf(struct slice *dest, struct slice *add);
     -+
     -+/* Like slice_add, but suitable for passing to reftable_new_writer
     -+ */
     -+int slice_add_void(void *b, byte *data, size_t sz);
     -+
     -+/* Find the longest shared prefix size of `a` and `b` */
     -+int common_prefix_size(struct slice *a, struct slice *b);
     -+
     -+struct reftable_block_source;
     -+
     -+/* Create an in-memory block source for reading reftables */
     -+void block_source_from_slice(struct reftable_block_source *bs,
     -+			     struct slice *buf);
     -+
     -+struct reftable_block_source malloc_block_source(void);
     -+
     -+/* Advance `buf` by `n`, and decrease length. A copy of the slice
     -+   should be kept for deallocating the slice. */
     -+void slice_consume(struct slice *s, int n);
     -+
     -+#endif
     -
     - ## reftable/slice_test.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "slice.h"
     -+
     -+#include "system.h"
     -+
     -+#include "basics.h"
     -+#include "record.h"
     -+#include "reftable.h"
     -+#include "test_framework.h"
     -+#include "reftable-tests.h"
     -+
     -+static void test_slice(void)
     -+{
     -+	struct slice s = SLICE_INIT;
     -+	struct slice t = SLICE_INIT;
     -+
     -+	slice_addstr(&s, "abc");
     -+	assert(0 == strcmp("abc", slice_as_string(&s)));
     -+
     -+	slice_addstr(&t, "pqr");
     -+	slice_addbuf(&s, &t);
     -+	assert(0 == strcmp("abcpqr", slice_as_string(&s)));
     -+
     -+	slice_release(&s);
     -+	slice_release(&t);
     -+}
     -+
     -+int slice_test_main(int argc, const char *argv[])
     -+{
     -+	add_test_case("test_slice", &test_slice);
     -+	return test_main(argc, argv);
     -+}
     -
     - ## reftable/stack.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "stack.h"
     -+
     -+#include "system.h"
     -+#include "merged.h"
     -+#include "reader.h"
     -+#include "refname.h"
     -+#include "reftable.h"
     -+#include "writer.h"
     -+
     -+int reftable_new_stack(struct reftable_stack **dest, const char *dir,
     -+		       struct reftable_write_options config)
     -+{
     -+	struct reftable_stack *p =
     -+		reftable_calloc(sizeof(struct reftable_stack));
     -+	struct slice list_file_name = SLICE_INIT;
     -+	int err = 0;
     -+
     -+	if (config.hash_id == 0) {
     -+		config.hash_id = SHA1_ID;
     -+	}
     -+
     -+	*dest = NULL;
     -+
     -+	slice_reset(&list_file_name);
     -+	slice_addstr(&list_file_name, dir);
     -+	slice_addstr(&list_file_name, "/tables.list");
     -+
     -+	p->list_file = slice_detach(&list_file_name);
     -+	p->reftable_dir = xstrdup(dir);
     -+	p->config = config;
     -+
     -+	err = reftable_stack_reload_maybe_reuse(p, true);
     -+	if (err < 0) {
     -+		reftable_stack_destroy(p);
     -+	} else {
     -+		*dest = p;
     -+	}
     -+	return err;
     -+}
     -+
     -+static int fd_read_lines(int fd, char ***namesp)
     -+{
     -+	off_t size = lseek(fd, 0, SEEK_END);
     -+	char *buf = NULL;
     -+	int err = 0;
     -+	if (size < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		goto done;
     -+	}
     -+	err = lseek(fd, 0, SEEK_SET);
     -+	if (err < 0) {
     -+		err = REFTABLE_IO_ERROR;
     -+		goto done;
     -+	}
     -+
     -+	buf = reftable_malloc(size + 1);
     -+	if (read(fd, buf, size) != size) {
     -+		err = REFTABLE_IO_ERROR;
     -+		goto done;
     -+	}
     -+	buf[size] = 0;
     -+
     -+	parse_names(buf, size, namesp);
     -+
     -+done:
     -+	reftable_free(buf);
     -+	return err;
     -+}
     -+
     -+int read_lines(const char *filename, char ***namesp)
     -+{
     -+	int fd = open(filename, O_RDONLY, 0644);
     -+	int err = 0;
     -+	if (fd < 0) {
     -+		if (errno == ENOENT) {
     -+			*namesp = reftable_calloc(sizeof(char *));
     -+			return 0;
     -+		}
     -+
     -+		return REFTABLE_IO_ERROR;
     -+	}
     -+	err = fd_read_lines(fd, namesp);
     -+	close(fd);
     -+	return err;
     -+}
     -+
     -+struct reftable_merged_table *
     -+reftable_stack_merged_table(struct reftable_stack *st)
     -+{
     -+	return st->merged;
     -+}
     -+
     -+/* Close and free the stack */
     -+void reftable_stack_destroy(struct reftable_stack *st)
     -+{
     -+	if (st->merged != NULL) {
     -+		reftable_merged_table_close(st->merged);
     -+		reftable_merged_table_free(st->merged);
     -+		st->merged = NULL;
     -+	}
     -+	FREE_AND_NULL(st->list_file);
     -+	FREE_AND_NULL(st->reftable_dir);
     -+	reftable_free(st);
     -+}
     -+
     -+static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
     -+						   int cur_len)
     -+{
     -+	struct reftable_reader **cur =
     -+		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
     -+	int i = 0;
     -+	for (i = 0; i < cur_len; i++) {
     -+		cur[i] = st->merged->stack[i];
     -+	}
     -+	return cur;
     -+}
     -+
     -+static int reftable_stack_reload_once(struct reftable_stack *st, char **names,
     -+				      bool reuse_open)
     -+{
     -+	int cur_len = st->merged == NULL ? 0 : st->merged->stack_len;
     -+	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
     -+	int err = 0;
     -+	int names_len = names_length(names);
     -+	struct reftable_reader **new_tables =
     -+		reftable_malloc(sizeof(struct reftable_reader *) * names_len);
     -+	int new_tables_len = 0;
     -+	struct reftable_merged_table *new_merged = NULL;
     -+	int i;
     -+
     -+	while (*names) {
     -+		struct reftable_reader *rd = NULL;
     -+		char *name = *names++;
     -+
     -+		/* this is linear; we assume compaction keeps the number of
     -+		   tables under control so this is not quadratic. */
     -+		int j = 0;
     -+		for (j = 0; reuse_open && j < cur_len; j++) {
     -+			if (cur[j] != NULL && 0 == strcmp(cur[j]->name, name)) {
     -+				rd = cur[j];
     -+				cur[j] = NULL;
     -+				break;
     -+			}
     -+		}
     -+
     -+		if (rd == NULL) {
     -+			struct reftable_block_source src = { 0 };
     -+			struct slice table_path = SLICE_INIT;
     -+			slice_addstr(&table_path, st->reftable_dir);
     -+			slice_addstr(&table_path, "/");
     -+			slice_addstr(&table_path, name);
     -+
     -+			err = reftable_block_source_from_file(
     -+				&src, slice_as_string(&table_path));
     -+			slice_release(&table_path);
     -+
     -+			if (err < 0)
     -+				goto done;
     -+
     -+			err = reftable_new_reader(&rd, &src, name);
     -+			if (err < 0)
     -+				goto done;
     -+		}
     -+
     -+		new_tables[new_tables_len++] = rd;
     -+	}
     ++		new_tables[new_tables_len++] = rd;
     ++	}
      +
      +	/* success! */
      +	err = reftable_new_merged_table(&new_merged, new_tables, new_tables_len,
     @@ reftable/stack.c (new)
      +	return 0;
      +}
      +
     -+static void format_name(struct slice *dest, uint64_t min, uint64_t max)
     ++static void format_name(struct strbuf *dest, uint64_t min, uint64_t max)
      +{
      +	char buf[100];
      +	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64, min, max);
     -+	slice_reset(dest);
     -+	slice_addstr(dest, buf);
     ++	strbuf_reset(dest);
     ++	strbuf_addstr(dest, buf);
      +}
      +
      +struct reftable_addition {
      +	int lock_file_fd;
     -+	struct slice lock_file_name;
     ++	struct strbuf lock_file_name;
      +	struct reftable_stack *stack;
      +	char **names;
      +	char **new_tables;
     @@ reftable/stack.c (new)
      +	uint64_t next_update_index;
      +};
      +
     -+#define REFTABLE_ADDITION_INIT               \
     -+	{                                    \
     -+		.lock_file_name = SLICE_INIT \
     ++#define REFTABLE_ADDITION_INIT                \
     ++	{                                     \
     ++		.lock_file_name = STRBUF_INIT \
      +	}
      +
      +static int reftable_stack_init_addition(struct reftable_addition *add,
     @@ reftable/stack.c (new)
      +	int err = 0;
      +	add->stack = st;
      +
     -+	slice_reset(&add->lock_file_name);
     -+	slice_addstr(&add->lock_file_name, st->list_file);
     -+	slice_addstr(&add->lock_file_name, ".lock");
     ++	strbuf_reset(&add->lock_file_name);
     ++	strbuf_addstr(&add->lock_file_name, st->list_file);
     ++	strbuf_addstr(&add->lock_file_name, ".lock");
      +
     -+	add->lock_file_fd = open(slice_as_string(&add->lock_file_name),
     ++	add->lock_file_fd = open(add->lock_file_name.buf,
      +				 O_EXCL | O_CREAT | O_WRONLY, 0644);
      +	if (add->lock_file_fd < 0) {
      +		if (errno == EEXIST) {
     @@ reftable/stack.c (new)
      +void reftable_addition_close(struct reftable_addition *add)
      +{
      +	int i = 0;
     -+	struct slice nm = SLICE_INIT;
     ++	struct strbuf nm = STRBUF_INIT;
      +	for (i = 0; i < add->new_tables_len; i++) {
     -+		slice_reset(&nm);
     -+		slice_addstr(&nm, add->stack->list_file);
     -+		slice_addstr(&nm, "/");
     -+		slice_addstr(&nm, add->new_tables[i]);
     -+		unlink(slice_as_string(&nm));
     ++		strbuf_reset(&nm);
     ++		strbuf_addstr(&nm, add->stack->list_file);
     ++		strbuf_addstr(&nm, "/");
     ++		strbuf_addstr(&nm, add->new_tables[i]);
     ++		unlink(nm.buf);
      +		reftable_free(add->new_tables[i]);
      +		add->new_tables[i] = NULL;
      +	}
     @@ reftable/stack.c (new)
      +		add->lock_file_fd = 0;
      +	}
      +	if (add->lock_file_name.len > 0) {
     -+		unlink(slice_as_string(&add->lock_file_name));
     -+		slice_release(&add->lock_file_name);
     ++		unlink(add->lock_file_name.buf);
     ++		strbuf_release(&add->lock_file_name);
      +	}
      +
      +	free_names(add->names);
      +	add->names = NULL;
     -+	slice_release(&nm);
     ++	strbuf_release(&nm);
      +}
      +
      +void reftable_addition_destroy(struct reftable_addition *add)
     @@ reftable/stack.c (new)
      +
      +int reftable_addition_commit(struct reftable_addition *add)
      +{
     -+	struct slice table_list = SLICE_INIT;
     ++	struct strbuf table_list = STRBUF_INIT;
      +	int i = 0;
      +	int err = 0;
      +	if (add->new_tables_len == 0)
      +		goto done;
      +
      +	for (i = 0; i < add->stack->merged->stack_len; i++) {
     -+		slice_addstr(&table_list, add->stack->merged->stack[i]->name);
     -+		slice_addstr(&table_list, "\n");
     ++		strbuf_addstr(&table_list, add->stack->merged->stack[i]->name);
     ++		strbuf_addstr(&table_list, "\n");
      +	}
      +	for (i = 0; i < add->new_tables_len; i++) {
     -+		slice_addstr(&table_list, add->new_tables[i]);
     -+		slice_addstr(&table_list, "\n");
     ++		strbuf_addstr(&table_list, add->new_tables[i]);
     ++		strbuf_addstr(&table_list, "\n");
      +	}
      +
      +	err = write(add->lock_file_fd, table_list.buf, table_list.len);
     -+	slice_release(&table_list);
     ++	strbuf_release(&table_list);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
      +		goto done;
     @@ reftable/stack.c (new)
      +		goto done;
      +	}
      +
     -+	err = rename(slice_as_string(&add->lock_file_name),
     -+		     add->stack->list_file);
     ++	err = rename(add->lock_file_name.buf, add->stack->list_file);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
      +		goto done;
     @@ reftable/stack.c (new)
      +					     void *arg),
      +			  void *arg)
      +{
     -+	struct slice temp_tab_file_name = SLICE_INIT;
     -+	struct slice tab_file_name = SLICE_INIT;
     -+	struct slice next_name = SLICE_INIT;
     ++	struct strbuf temp_tab_file_name = STRBUF_INIT;
     ++	struct strbuf tab_file_name = STRBUF_INIT;
     ++	struct strbuf next_name = STRBUF_INIT;
      +	struct reftable_writer *wr = NULL;
      +	int err = 0;
      +	int tab_fd = 0;
      +
     -+	slice_reset(&next_name);
     ++	strbuf_reset(&next_name);
      +	format_name(&next_name, add->next_update_index, add->next_update_index);
      +
     -+	slice_addstr(&temp_tab_file_name, add->stack->reftable_dir);
     -+	slice_addstr(&temp_tab_file_name, "/");
     -+	slice_addbuf(&temp_tab_file_name, &next_name);
     -+	slice_addstr(&temp_tab_file_name, ".temp.XXXXXX");
     ++	strbuf_addstr(&temp_tab_file_name, add->stack->reftable_dir);
     ++	strbuf_addstr(&temp_tab_file_name, "/");
     ++	strbuf_addbuf(&temp_tab_file_name, &next_name);
     ++	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
      +
     -+	tab_fd = mkstemp((char *)slice_as_string(&temp_tab_file_name));
     ++	tab_fd = mkstemp(temp_tab_file_name.buf);
      +	if (tab_fd < 0) {
      +		err = REFTABLE_IO_ERROR;
      +		goto done;
     @@ reftable/stack.c (new)
      +		goto done;
      +	}
      +
     -+	err = stack_check_addition(add->stack,
     -+				   slice_as_string(&temp_tab_file_name));
     ++	err = stack_check_addition(add->stack, temp_tab_file_name.buf);
      +	if (err < 0)
      +		goto done;
      +
     @@ reftable/stack.c (new)
      +	}
      +
      +	format_name(&next_name, wr->min_update_index, wr->max_update_index);
     -+	slice_addstr(&next_name, ".ref");
     ++	strbuf_addstr(&next_name, ".ref");
      +
     -+	slice_addstr(&tab_file_name, add->stack->reftable_dir);
     -+	slice_addstr(&tab_file_name, "/");
     -+	slice_addbuf(&tab_file_name, &next_name);
     ++	strbuf_addstr(&tab_file_name, add->stack->reftable_dir);
     ++	strbuf_addstr(&tab_file_name, "/");
     ++	strbuf_addbuf(&tab_file_name, &next_name);
      +
      +	/* TODO: should check destination out of paranoia */
     -+	err = rename(slice_as_string(&temp_tab_file_name),
     -+		     slice_as_string(&tab_file_name));
     ++	err = rename(temp_tab_file_name.buf, tab_file_name.buf);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
      +		goto done;
     @@ reftable/stack.c (new)
      +	add->new_tables = reftable_realloc(add->new_tables,
      +					   sizeof(*add->new_tables) *
      +						   (add->new_tables_len + 1));
     -+	add->new_tables[add->new_tables_len] = slice_detach(&next_name);
     ++	add->new_tables[add->new_tables_len] = strbuf_detach(&next_name, NULL);
      +	add->new_tables_len++;
      +done:
      +	if (tab_fd > 0) {
     @@ reftable/stack.c (new)
      +		tab_fd = 0;
      +	}
      +	if (temp_tab_file_name.len > 0) {
     -+		unlink(slice_as_string(&temp_tab_file_name));
     ++		unlink(temp_tab_file_name.buf);
      +	}
      +
     -+	slice_release(&temp_tab_file_name);
     -+	slice_release(&tab_file_name);
     -+	slice_release(&next_name);
     ++	strbuf_release(&temp_tab_file_name);
     ++	strbuf_release(&tab_file_name);
     ++	strbuf_release(&next_name);
      +	reftable_writer_free(wr);
      +	return err;
      +}
     @@ reftable/stack.c (new)
      +}
      +
      +static int stack_compact_locked(struct reftable_stack *st, int first, int last,
     -+				struct slice *temp_tab,
     ++				struct strbuf *temp_tab,
      +				struct reftable_log_expiry_config *config)
      +{
     -+	struct slice next_name = SLICE_INIT;
     ++	struct strbuf next_name = STRBUF_INIT;
      +	int tab_fd = -1;
      +	struct reftable_writer *wr = NULL;
      +	int err = 0;
     @@ reftable/stack.c (new)
      +		    reftable_reader_min_update_index(st->merged->stack[first]),
      +		    reftable_reader_max_update_index(st->merged->stack[first]));
      +
     -+	slice_reset(temp_tab);
     -+	slice_addstr(temp_tab, st->reftable_dir);
     -+	slice_addstr(temp_tab, "/");
     -+	slice_addbuf(temp_tab, &next_name);
     -+	slice_addstr(temp_tab, ".temp.XXXXXX");
     ++	strbuf_reset(temp_tab);
     ++	strbuf_addstr(temp_tab, st->reftable_dir);
     ++	strbuf_addstr(temp_tab, "/");
     ++	strbuf_addbuf(temp_tab, &next_name);
     ++	strbuf_addstr(temp_tab, ".temp.XXXXXX");
      +
     -+	tab_fd = mkstemp((char *)slice_as_string(temp_tab));
     ++	tab_fd = mkstemp(temp_tab->buf);
      +	wr = reftable_new_writer(reftable_fd_write, &tab_fd, &st->config);
      +
      +	err = stack_write_compact(st, wr, first, last, config);
     @@ reftable/stack.c (new)
      +		tab_fd = 0;
      +	}
      +	if (err != 0 && temp_tab->len > 0) {
     -+		unlink(slice_as_string(temp_tab));
     -+		slice_release(temp_tab);
     ++		unlink(temp_tab->buf);
     ++		strbuf_release(temp_tab);
      +	}
     -+	slice_release(&next_name);
     ++	strbuf_release(&next_name);
      +	return err;
      +}
      +
     @@ reftable/stack.c (new)
      +static int stack_compact_range(struct reftable_stack *st, int first, int last,
      +			       struct reftable_log_expiry_config *expiry)
      +{
     -+	struct slice temp_tab_file_name = SLICE_INIT;
     -+	struct slice new_table_name = SLICE_INIT;
     -+	struct slice lock_file_name = SLICE_INIT;
     -+	struct slice ref_list_contents = SLICE_INIT;
     -+	struct slice new_table_path = SLICE_INIT;
     ++	struct strbuf temp_tab_file_name = STRBUF_INIT;
     ++	struct strbuf new_table_name = STRBUF_INIT;
     ++	struct strbuf lock_file_name = STRBUF_INIT;
     ++	struct strbuf ref_list_contents = STRBUF_INIT;
     ++	struct strbuf new_table_path = STRBUF_INIT;
      +	int err = 0;
      +	bool have_lock = false;
      +	int lock_file_fd = 0;
     @@ reftable/stack.c (new)
      +
      +	st->stats.attempts++;
      +
     -+	slice_reset(&lock_file_name);
     -+	slice_addstr(&lock_file_name, st->list_file);
     -+	slice_addstr(&lock_file_name, ".lock");
     ++	strbuf_reset(&lock_file_name);
     ++	strbuf_addstr(&lock_file_name, st->list_file);
     ++	strbuf_addstr(&lock_file_name, ".lock");
      +
     -+	lock_file_fd = open(slice_as_string(&lock_file_name),
     -+			    O_EXCL | O_CREAT | O_WRONLY, 0644);
     ++	lock_file_fd =
     ++		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0644);
      +	if (lock_file_fd < 0) {
      +		if (errno == EEXIST) {
      +			err = 1;
     @@ reftable/stack.c (new)
      +		goto done;
      +
      +	for (i = first, j = 0; i <= last; i++) {
     -+		struct slice subtab_file_name = SLICE_INIT;
     -+		struct slice subtab_lock = SLICE_INIT;
     ++		struct strbuf subtab_file_name = STRBUF_INIT;
     ++		struct strbuf subtab_lock = STRBUF_INIT;
      +		int sublock_file_fd = -1;
      +
     -+		slice_addstr(&subtab_file_name, st->reftable_dir);
     -+		slice_addstr(&subtab_file_name, "/");
     -+		slice_addstr(&subtab_file_name,
     -+			     reader_name(st->merged->stack[i]));
     ++		strbuf_addstr(&subtab_file_name, st->reftable_dir);
     ++		strbuf_addstr(&subtab_file_name, "/");
     ++		strbuf_addstr(&subtab_file_name,
     ++			      reader_name(st->merged->stack[i]));
      +
     -+		slice_reset(&subtab_lock);
     -+		slice_addbuf(&subtab_lock, &subtab_file_name);
     -+		slice_addstr(&subtab_lock, ".lock");
     ++		strbuf_reset(&subtab_lock);
     ++		strbuf_addbuf(&subtab_lock, &subtab_file_name);
     ++		strbuf_addstr(&subtab_lock, ".lock");
      +
     -+		sublock_file_fd = open(slice_as_string(&subtab_lock),
     ++		sublock_file_fd = open(subtab_lock.buf,
      +				       O_EXCL | O_CREAT | O_WRONLY, 0644);
      +		if (sublock_file_fd > 0) {
      +			close(sublock_file_fd);
     @@ reftable/stack.c (new)
      +			}
      +		}
      +
     -+		subtable_locks[j] = (char *)slice_as_string(&subtab_lock);
     -+		delete_on_success[j] =
     -+			(char *)slice_as_string(&subtab_file_name);
     ++		subtable_locks[j] = subtab_lock.buf;
     ++		delete_on_success[j] = subtab_file_name.buf;
      +		j++;
      +
      +		if (err != 0)
      +			goto done;
      +	}
      +
     -+	err = unlink(slice_as_string(&lock_file_name));
     ++	err = unlink(lock_file_name.buf);
      +	if (err < 0)
      +		goto done;
      +	have_lock = false;
     @@ reftable/stack.c (new)
      +	if (err < 0)
      +		goto done;
      +
     -+	lock_file_fd = open(slice_as_string(&lock_file_name),
     -+			    O_EXCL | O_CREAT | O_WRONLY, 0644);
     ++	lock_file_fd =
     ++		open(lock_file_name.buf, O_EXCL | O_CREAT | O_WRONLY, 0644);
      +	if (lock_file_fd < 0) {
      +		if (errno == EEXIST) {
      +			err = 1;
     @@ reftable/stack.c (new)
      +
      +	format_name(&new_table_name, st->merged->stack[first]->min_update_index,
      +		    st->merged->stack[last]->max_update_index);
     -+	slice_addstr(&new_table_name, ".ref");
     ++	strbuf_addstr(&new_table_name, ".ref");
      +
     -+	slice_reset(&new_table_path);
     -+	slice_addstr(&new_table_path, st->reftable_dir);
     -+	slice_addstr(&new_table_path, "/");
     -+	slice_addbuf(&new_table_path, &new_table_name);
     ++	strbuf_reset(&new_table_path);
     ++	strbuf_addstr(&new_table_path, st->reftable_dir);
     ++	strbuf_addstr(&new_table_path, "/");
     ++	strbuf_addbuf(&new_table_path, &new_table_name);
      +
      +	if (!is_empty_table) {
     -+		err = rename(slice_as_string(&temp_tab_file_name),
     -+			     slice_as_string(&new_table_path));
     ++		err = rename(temp_tab_file_name.buf, new_table_path.buf);
      +		if (err < 0) {
      +			err = REFTABLE_IO_ERROR;
      +			goto done;
     @@ reftable/stack.c (new)
      +	}
      +
      +	for (i = 0; i < first; i++) {
     -+		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
     -+		slice_addstr(&ref_list_contents, "\n");
     ++		strbuf_addstr(&ref_list_contents, st->merged->stack[i]->name);
     ++		strbuf_addstr(&ref_list_contents, "\n");
      +	}
      +	if (!is_empty_table) {
     -+		slice_addbuf(&ref_list_contents, &new_table_name);
     -+		slice_addstr(&ref_list_contents, "\n");
     ++		strbuf_addbuf(&ref_list_contents, &new_table_name);
     ++		strbuf_addstr(&ref_list_contents, "\n");
      +	}
      +	for (i = last + 1; i < st->merged->stack_len; i++) {
     -+		slice_addstr(&ref_list_contents, st->merged->stack[i]->name);
     -+		slice_addstr(&ref_list_contents, "\n");
     ++		strbuf_addstr(&ref_list_contents, st->merged->stack[i]->name);
     ++		strbuf_addstr(&ref_list_contents, "\n");
      +	}
      +
      +	err = write(lock_file_fd, ref_list_contents.buf, ref_list_contents.len);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		unlink(slice_as_string(&new_table_path));
     ++		unlink(new_table_path.buf);
      +		goto done;
      +	}
      +	err = close(lock_file_fd);
      +	lock_file_fd = 0;
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		unlink(slice_as_string(&new_table_path));
     ++		unlink(new_table_path.buf);
      +		goto done;
      +	}
      +
     -+	err = rename(slice_as_string(&lock_file_name), st->list_file);
     ++	err = rename(lock_file_name.buf, st->list_file);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     -+		unlink(slice_as_string(&new_table_path));
     ++		unlink(new_table_path.buf);
      +		goto done;
      +	}
      +	have_lock = false;
     @@ reftable/stack.c (new)
      +
      +	listp = delete_on_success;
      +	while (*listp) {
     -+		if (strcmp(*listp, slice_as_string(&new_table_path))) {
     ++		if (strcmp(*listp, new_table_path.buf)) {
      +			unlink(*listp);
      +		}
      +		listp++;
     @@ reftable/stack.c (new)
      +		lock_file_fd = 0;
      +	}
      +	if (have_lock) {
     -+		unlink(slice_as_string(&lock_file_name));
     ++		unlink(lock_file_name.buf);
      +	}
     -+	slice_release(&new_table_name);
     -+	slice_release(&new_table_path);
     -+	slice_release(&ref_list_contents);
     -+	slice_release(&temp_tab_file_name);
     -+	slice_release(&lock_file_name);
     ++	strbuf_release(&new_table_name);
     ++	strbuf_release(&new_table_path);
     ++	strbuf_release(&ref_list_contents);
     ++	strbuf_release(&temp_tab_file_name);
     ++	strbuf_release(&lock_file_name);
      +	return err;
      +}
      +
     @@ reftable/stack_test.c (new)
      +	struct reftable_stack *st = NULL;
      +	char dir[256] = "/tmp/stack_test.XXXXXX";
      +
     -+	byte h1[SHA1_SIZE] = { 0x01 }, h2[SHA1_SIZE] = { 0x02 };
     ++	uint8_t h1[SHA1_SIZE] = { 0x01 }, h2[SHA1_SIZE] = { 0x02 };
      +
      +	struct reftable_log_record input = {
      +		.ref_name = "branch",
     @@ reftable/stack_test.c (new)
      +	add_test_case("test_names_equal", &test_names_equal);
      +	add_test_case("test_reftable_stack_add", &test_reftable_stack_add);
      +	return test_main(argc, argv);
     ++}
     +
     + ## reftable/strbuf.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "strbuf.h"
     ++
     ++#include "system.h"
     ++#include "reftable.h"
     ++#include "basics.h"
     ++
     ++#ifdef REFTABLE_STANDALONE
     ++
     ++void strbuf_init(struct strbuf *s, size_t alloc)
     ++{
     ++	struct strbuf empty = STRBUF_INIT;
     ++	*s = empty;
     ++}
     ++
     ++void strbuf_grow(struct strbuf *s, size_t extra)
     ++{
     ++	size_t newcap = s->len + extra + 1;
     ++	if (newcap > s->cap) {
     ++		s->buf = reftable_realloc(s->buf, newcap);
     ++		s->cap = newcap;
     ++	}
     ++}
     ++
     ++static void strbuf_resize(struct strbuf *s, int l)
     ++{
     ++	int zl = l + 1; /* one uint8_t for 0 termination. */
     ++	assert(s->canary == STRBUF_CANARY);
     ++	if (s->cap < zl) {
     ++		int c = s->cap * 2;
     ++		if (c < zl) {
     ++			c = zl;
     ++		}
     ++		s->cap = c;
     ++		s->buf = reftable_realloc(s->buf, s->cap);
     ++	}
     ++	s->len = l;
     ++	s->buf[l] = 0;
     ++}
     ++
     ++void strbuf_setlen(struct strbuf *s, size_t l)
     ++{
     ++	assert(s->cap >= l + 1);
     ++	s->len = l;
     ++	s->buf[l] = 0;
     ++}
     ++
     ++void strbuf_reset(struct strbuf *s)
     ++{
     ++	strbuf_resize(s, 0);
     ++}
     ++
     ++void strbuf_addstr(struct strbuf *d, const char *s)
     ++{
     ++	int l1 = d->len;
     ++	int l2 = strlen(s);
     ++	assert(d->canary == STRBUF_CANARY);
     ++
     ++	strbuf_resize(d, l2 + l1);
     ++	memcpy(d->buf + l1, s, l2);
     ++}
     ++
     ++void strbuf_addbuf(struct strbuf *s, struct strbuf *a)
     ++{
     ++	int end = s->len;
     ++	assert(s->canary == STRBUF_CANARY);
     ++	strbuf_resize(s, s->len + a->len);
     ++	memcpy(s->buf + end, a->buf, a->len);
     ++}
     ++
     ++char *strbuf_detach(struct strbuf *s, size_t *sz)
     ++{
     ++	char *p = NULL;
     ++	p = (char *)s->buf;
     ++	if (sz)
     ++		*sz = s->len;
     ++	s->buf = NULL;
     ++	s->cap = 0;
     ++	s->len = 0;
     ++	return p;
     ++}
     ++
     ++void strbuf_release(struct strbuf *s)
     ++{
     ++	assert(s->canary == STRBUF_CANARY);
     ++	s->cap = 0;
     ++	s->len = 0;
     ++	reftable_free(s->buf);
     ++	s->buf = NULL;
     ++}
     ++
     ++int strbuf_cmp(const struct strbuf *a, const struct strbuf *b)
     ++{
     ++	int min = a->len < b->len ? a->len : b->len;
     ++	int res = memcmp(a->buf, b->buf, min);
     ++	assert(a->canary == STRBUF_CANARY);
     ++	assert(b->canary == STRBUF_CANARY);
     ++	if (res != 0)
     ++		return res;
     ++	if (a->len < b->len)
     ++		return -1;
     ++	else if (a->len > b->len)
     ++		return 1;
     ++	else
     ++		return 0;
     ++}
     ++
     ++int strbuf_add(struct strbuf *b, const void *data, size_t sz)
     ++{
     ++	assert(b->canary == STRBUF_CANARY);
     ++	strbuf_grow(b, sz);
     ++	memcpy(b->buf + b->len, data, sz);
     ++	b->len += sz;
     ++	b->buf[b->len] = 0;
     ++	return sz;
     ++}
     ++
     ++#endif
     ++
     ++static uint64_t strbuf_size(void *b)
     ++{
     ++	return ((struct strbuf *)b)->len;
     ++}
     ++
     ++int strbuf_add_void(void *b, const void *data, size_t sz)
     ++{
     ++	strbuf_add((struct strbuf *)b, data, sz);
     ++	return sz;
     ++}
     ++
     ++static void strbuf_return_block(void *b, struct reftable_block *dest)
     ++{
     ++	memset(dest->data, 0xff, dest->len);
     ++	reftable_free(dest->data);
     ++}
     ++
     ++static void strbuf_close(void *b)
     ++{
     ++}
     ++
     ++static int strbuf_read_block(void *v, struct reftable_block *dest, uint64_t off,
     ++			     uint32_t size)
     ++{
     ++	struct strbuf *b = (struct strbuf *)v;
     ++	assert(off + size <= b->len);
     ++	dest->data = reftable_calloc(size);
     ++	memcpy(dest->data, b->buf + off, size);
     ++	dest->len = size;
     ++	return size;
     ++}
     ++
     ++struct reftable_block_source_vtable strbuf_vtable = {
     ++	.size = &strbuf_size,
     ++	.read_block = &strbuf_read_block,
     ++	.return_block = &strbuf_return_block,
     ++	.close = &strbuf_close,
     ++};
     ++
     ++void block_source_from_strbuf(struct reftable_block_source *bs,
     ++			      struct strbuf *buf)
     ++{
     ++	assert(bs->ops == NULL);
     ++	bs->ops = &strbuf_vtable;
     ++	bs->arg = buf;
     ++}
     ++
     ++static void malloc_return_block(void *b, struct reftable_block *dest)
     ++{
     ++	memset(dest->data, 0xff, dest->len);
     ++	reftable_free(dest->data);
     ++}
     ++
     ++struct reftable_block_source_vtable malloc_vtable = {
     ++	.return_block = &malloc_return_block,
     ++};
     ++
     ++struct reftable_block_source malloc_block_source_instance = {
     ++	.ops = &malloc_vtable,
     ++};
     ++
     ++struct reftable_block_source malloc_block_source(void)
     ++{
     ++	return malloc_block_source_instance;
     ++}
     ++
     ++int common_prefix_size(struct strbuf *a, struct strbuf *b)
     ++{
     ++	int p = 0;
     ++	while (p < a->len && p < b->len) {
     ++		if (a->buf[p] != b->buf[p]) {
     ++			break;
     ++		}
     ++		p++;
     ++	}
     ++
     ++	return p;
     ++}
     ++
     ++struct strbuf reftable_empty_strbuf = STRBUF_INIT;
     +
     + ## reftable/strbuf.h (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#ifndef SLICE_H
     ++#define SLICE_H
     ++
     ++#ifdef REFTABLE_STANDALONE
     ++
     ++#include "basics.h"
     ++#include "reftable.h"
     ++
     ++/*
     ++  Provides a bounds-checked, growable byte ranges. To use, initialize as "strbuf
     ++  x = STRBUF_INIT;"
     ++ */
     ++struct strbuf {
     ++	int len;
     ++	int cap;
     ++	char *buf;
     ++
     ++	/* Used to enforce initialization with STRBUF_INIT */
     ++	uint8_t canary;
     ++};
     ++#define STRBUF_CANARY 0x42
     ++#define STRBUF_INIT                       \
     ++	{                                 \
     ++		0, 0, NULL, STRBUF_CANARY \
     ++	}
     ++
     ++void strbuf_addstr(struct strbuf *dest, const char *src);
     ++
     ++/* Deallocate and clear strbuf */
     ++void strbuf_release(struct strbuf *strbuf);
     ++
     ++/* Set strbuf to 0 length, but retain buffer. */
     ++void strbuf_reset(struct strbuf *strbuf);
     ++
     ++/* Initializes a strbuf. Accepts a strbuf with random garbage. */
     ++void strbuf_init(struct strbuf *strbuf, size_t alloc);
     ++
     ++/* Return `buf`, clearing out `s`. Optionally return len (not cap) in `sz`.  */
     ++char *strbuf_detach(struct strbuf *s, size_t *sz);
     ++
     ++/* Set length of the slace to `l`, but don't reallocated. */
     ++void strbuf_setlen(struct strbuf *s, size_t l);
     ++
     ++/* Ensure `l` bytes beyond current length are available */
     ++void strbuf_grow(struct strbuf *s, size_t l);
     ++
     ++/* Signed comparison */
     ++int strbuf_cmp(const struct strbuf *a, const struct strbuf *b);
     ++
     ++/* Append `data` to the `dest` strbuf.  */
     ++int strbuf_add(struct strbuf *dest, const void *data, size_t sz);
     ++
     ++/* Append `add` to `dest. */
     ++void strbuf_addbuf(struct strbuf *dest, struct strbuf *add);
     ++
     ++#else
     ++
     ++#include "../git-compat-util.h"
     ++#include "../strbuf.h"
     ++
     ++#endif
     ++
     ++extern struct strbuf reftable_empty_strbuf;
     ++
     ++/* Like strbuf_add, but suitable for passing to reftable_new_writer
     ++ */
     ++int strbuf_add_void(void *b, const void *data, size_t sz);
     ++
     ++/* Find the longest shared prefix size of `a` and `b` */
     ++int common_prefix_size(struct strbuf *a, struct strbuf *b);
     ++
     ++struct reftable_block_source;
     ++
     ++/* Create an in-memory block source for reading reftables */
     ++void block_source_from_strbuf(struct reftable_block_source *bs,
     ++			      struct strbuf *buf);
     ++
     ++struct reftable_block_source malloc_block_source(void);
     ++
     ++#endif
     +
     + ## reftable/strbuf_test.c (new) ##
     +@@
     ++/*
     ++Copyright 2020 Google LLC
     ++
     ++Use of this source code is governed by a BSD-style
     ++license that can be found in the LICENSE file or at
     ++https://developers.google.com/open-source/licenses/bsd
     ++*/
     ++
     ++#include "strbuf.h"
     ++
     ++#include "system.h"
     ++
     ++#include "basics.h"
     ++#include "record.h"
     ++#include "reftable.h"
     ++#include "test_framework.h"
     ++#include "reftable-tests.h"
     ++
     ++static void test_strbuf(void)
     ++{
     ++	struct strbuf s = STRBUF_INIT;
     ++	struct strbuf t = STRBUF_INIT;
     ++
     ++	strbuf_addstr(&s, "abc");
     ++	assert(0 == strcmp("abc", s.buf));
     ++
     ++	strbuf_addstr(&t, "pqr");
     ++	strbuf_addbuf(&s, &t);
     ++	assert(0 == strcmp("abcpqr", s.buf));
     ++
     ++	strbuf_release(&s);
     ++	strbuf_release(&t);
     ++}
     ++
     ++int strbuf_test_main(int argc, const char *argv[])
     ++{
     ++	add_test_case("test_strbuf", &test_strbuf);
     ++	return test_main(argc, argv);
      +}
      
       ## reftable/system.h (new) ##
     @@ reftable/system.h (new)
      +#ifndef SYSTEM_H
      +#define SYSTEM_H
      +
     -+#if 1 /* REFTABLE_IN_GITCORE */
     -+#define REFTABLE_IN_GITCORE
     ++#ifndef REFTABLE_STANDALONE
      +
      +#include "git-compat-util.h"
      +#include "cache.h"
     @@ reftable/system.h (new)
      +
      +#include "compat.h"
      +
     -+#endif /* REFTABLE_IN_GITCORE */
     ++#endif /* REFTABLE_STANDALONE */
      +
      +void reftable_clear_dir(const char *dirname);
      +
     @@ reftable/system.h (new)
      +#define SHA1_SIZE 20
      +#define SHA256_SIZE 32
      +
     -+typedef uint8_t byte;
      +typedef int bool;
      +
      +/* This is uncompress2, which is only available in zlib as of 2017.
     @@ reftable/test_framework.c (new)
      +	return 0;
      +}
      +
     -+void set_test_hash(byte *p, int i)
     ++void set_test_hash(uint8_t *p, int i)
      +{
     -+	memset(p, (byte)i, hash_size(SHA1_ID));
     ++	memset(p, (uint8_t)i, hash_size(SHA1_ID));
      +}
      
       ## reftable/test_framework.h (new) ##
     @@ reftable/test_framework.h (new)
      +struct test_case *add_test_case(const char *name, void (*testfunc)(void));
      +int test_main(int argc, const char *argv[]);
      +
     -+void set_test_hash(byte *p, int i);
     ++void set_test_hash(uint8_t *p, int i);
      +
      +#endif
      
     @@ reftable/writer.c (new)
      +#include "tree.h"
      +
      +static struct reftable_block_stats *
     -+writer_reftable_block_stats(struct reftable_writer *w, byte typ)
     ++writer_reftable_block_stats(struct reftable_writer *w, uint8_t typ)
      +{
      +	switch (typ) {
      +	case 'r':
     @@ reftable/writer.c (new)
      +
      +/* write data, queuing the padding for the next write. Returns negative for
      + * error. */
     -+static int padded_write(struct reftable_writer *w, byte *data, size_t len,
     ++static int padded_write(struct reftable_writer *w, uint8_t *data, size_t len,
      +			int padding)
      +{
      +	int n = 0;
      +	if (w->pending_padding > 0) {
     -+		byte *zeroed = reftable_calloc(w->pending_padding);
     ++		uint8_t *zeroed = reftable_calloc(w->pending_padding);
      +		int n = w->write(w->write_arg, zeroed, w->pending_padding);
      +		if (n < 0)
      +			return n;
     @@ reftable/writer.c (new)
      +	return (w->opts.hash_id == 0 || w->opts.hash_id == SHA1_ID) ? 1 : 2;
      +}
      +
     -+static int writer_write_header(struct reftable_writer *w, byte *dest)
     ++static int writer_write_header(struct reftable_writer *w, uint8_t *dest)
      +{
      +	memcpy((char *)dest, "REFT", 4);
      +
     @@ reftable/writer.c (new)
      +	return header_size(writer_version(w));
      +}
      +
     -+static void writer_reinit_block_writer(struct reftable_writer *w, byte typ)
     ++static void writer_reinit_block_writer(struct reftable_writer *w, uint8_t typ)
      +{
      +	int block_start = 0;
      +	if (w->next == 0) {
      +		block_start = header_size(writer_version(w));
      +	}
      +
     -+	slice_release(&w->last_key);
     ++	strbuf_release(&w->last_key);
      +	block_writer_init(&w->block_writer_data, typ, w->block,
      +			  w->opts.block_size, block_start,
      +			  hash_size(w->opts.hash_id));
     @@ reftable/writer.c (new)
      +}
      +
      +struct reftable_writer *
     -+reftable_new_writer(int (*writer_func)(void *, byte *, size_t),
     ++reftable_new_writer(int (*writer_func)(void *, const void *, size_t),
      +		    void *writer_arg, struct reftable_write_options *opts)
      +{
      +	struct reftable_writer *wp =
      +		reftable_calloc(sizeof(struct reftable_writer));
     -+	slice_init(&wp->block_writer_data.last_key);
     ++	strbuf_init(&wp->block_writer_data.last_key, 0);
      +	options_set_defaults(opts);
      +	if (opts->block_size >= (1 << 24)) {
      +		/* TODO - error return? */
      +		abort();
      +	}
     -+	wp->last_key = reftable_empty_slice;
     ++	wp->last_key = reftable_empty_strbuf;
      +	wp->block = reftable_calloc(opts->block_size);
      +	wp->write = writer_func;
      +	wp->write_arg = writer_arg;
     @@ reftable/writer.c (new)
      +}
      +
      +struct obj_index_tree_node {
     -+	struct slice hash;
     ++	struct strbuf hash;
      +	uint64_t *offsets;
      +	int offset_len;
      +	int offset_cap;
      +};
     -+#define OBJ_INDEX_TREE_NODE_INIT   \
     -+	{                          \
     -+		.hash = SLICE_INIT \
     ++#define OBJ_INDEX_TREE_NODE_INIT    \
     ++	{                           \
     ++		.hash = STRBUF_INIT \
      +	}
      +
      +static int obj_index_tree_node_compare(const void *a, const void *b)
      +{
     -+	return slice_cmp(&((const struct obj_index_tree_node *)a)->hash,
     -+			 &((const struct obj_index_tree_node *)b)->hash);
     ++	return strbuf_cmp(&((const struct obj_index_tree_node *)a)->hash,
     ++			  &((const struct obj_index_tree_node *)b)->hash);
      +}
      +
     -+static void writer_index_hash(struct reftable_writer *w, struct slice *hash)
     ++static void writer_index_hash(struct reftable_writer *w, struct strbuf *hash)
      +{
      +	uint64_t off = w->next;
      +
     @@ reftable/writer.c (new)
      +		key = reftable_malloc(sizeof(struct obj_index_tree_node));
      +		*key = empty;
      +
     -+		slice_reset(&key->hash);
     -+		slice_addbuf(&key->hash, hash);
     ++		strbuf_reset(&key->hash);
     ++		strbuf_addbuf(&key->hash, hash);
      +		tree_search((void *)key, &w->obj_index_tree,
      +			    &obj_index_tree_node_compare, 1);
      +	} else {
     @@ reftable/writer.c (new)
      +			     struct reftable_record *rec)
      +{
      +	int result = -1;
     -+	struct slice key = SLICE_INIT;
     ++	struct strbuf key = STRBUF_INIT;
      +	int err = 0;
      +	reftable_record_key(rec, &key);
     -+	if (slice_cmp(&w->last_key, &key) >= 0)
     ++	if (strbuf_cmp(&w->last_key, &key) >= 0)
      +		goto done;
      +
     -+	slice_reset(&w->last_key);
     -+	slice_addbuf(&w->last_key, &key);
     ++	strbuf_reset(&w->last_key);
     ++	strbuf_addbuf(&w->last_key, &key);
      +	if (w->block_writer == NULL) {
      +		writer_reinit_block_writer(w, reftable_record_type(rec));
      +	}
     @@ reftable/writer.c (new)
      +
      +	result = 0;
      +done:
     -+	slice_release(&key);
     ++	strbuf_release(&key);
      +	return result;
      +}
      +
     @@ reftable/writer.c (new)
      +		return err;
      +
      +	if (!w->opts.skip_index_objects && ref->value != NULL) {
     -+		struct slice h = SLICE_INIT;
     -+		slice_add(&h, ref->value, hash_size(w->opts.hash_id));
     ++		struct strbuf h = STRBUF_INIT;
     ++		strbuf_add(&h, (char *)ref->value, hash_size(w->opts.hash_id));
      +		writer_index_hash(w, &h);
     -+		slice_release(&h);
     ++		strbuf_release(&h);
      +	}
      +
      +	if (!w->opts.skip_index_objects && ref->target_value != NULL) {
     -+		struct slice h = SLICE_INIT;
     -+		slice_add(&h, ref->target_value, hash_size(w->opts.hash_id));
     ++		struct strbuf h = STRBUF_INIT;
     ++		strbuf_add(&h, ref->target_value, hash_size(w->opts.hash_id));
      +		writer_index_hash(w, &h);
      +	}
      +	return 0;
     @@ reftable/writer.c (new)
      +{
      +	struct reftable_record rec = { 0 };
      +	char *input_log_message = log->message;
     -+	struct slice cleaned_message = SLICE_INIT;
     ++	struct strbuf cleaned_message = STRBUF_INIT;
      +	int err;
      +	if (log->ref_name == NULL)
      +		return REFTABLE_API_ERROR;
     @@ reftable/writer.c (new)
      +	}
      +
      +	if (!w->opts.exact_log_message && log->message != NULL) {
     -+		slice_addstr(&cleaned_message, log->message);
     ++		strbuf_addstr(&cleaned_message, log->message);
      +		while (cleaned_message.len &&
      +		       cleaned_message.buf[cleaned_message.len - 1] == '\n')
     -+			slice_setlen(&cleaned_message, cleaned_message.len - 1);
     -+		if (strchr(slice_as_string(&cleaned_message), '\n')) {
     ++			strbuf_setlen(&cleaned_message,
     ++				      cleaned_message.len - 1);
     ++		if (strchr(cleaned_message.buf, '\n')) {
      +			// multiple lines not allowed.
      +			err = REFTABLE_API_ERROR;
      +			goto done;
      +		}
     -+		slice_addstr(&cleaned_message, "\n");
     -+		log->message = (char *)slice_as_string(&cleaned_message);
     ++		strbuf_addstr(&cleaned_message, "\n");
     ++		log->message = cleaned_message.buf;
      +	}
      +
      +	w->next -= w->pending_padding;
     @@ reftable/writer.c (new)
      +
      +done:
      +	log->message = input_log_message;
     -+	slice_release(&cleaned_message);
     ++	strbuf_release(&cleaned_message);
      +	return err;
      +}
      +
     @@ reftable/writer.c (new)
      +
      +static int writer_finish_section(struct reftable_writer *w)
      +{
     -+	byte typ = block_writer_type(w->block_writer);
     ++	uint8_t typ = block_writer_type(w->block_writer);
      +	uint64_t index_start = 0;
      +	int max_level = 0;
      +	int threshold = w->opts.unpadded ? 1 : 3;
     @@ reftable/writer.c (new)
      +			}
      +		}
      +		for (i = 0; i < idx_len; i++) {
     -+			slice_release(&idx[i].last_key);
     ++			strbuf_release(&idx[i].last_key);
      +		}
      +		reftable_free(idx);
      +	}
     @@ reftable/writer.c (new)
      +}
      +
      +struct common_prefix_arg {
     -+	struct slice *last;
     ++	struct strbuf *last;
      +	int max;
      +};
      +
     @@ reftable/writer.c (new)
      +	struct write_record_arg *arg = (struct write_record_arg *)void_arg;
      +	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
      +	struct reftable_obj_record obj_rec = {
     -+		.hash_prefix = entry->hash.buf,
     ++		.hash_prefix = (uint8_t *)entry->hash.buf,
      +		.hash_prefix_len = arg->w->stats.object_id_len,
      +		.offsets = entry->offsets,
      +		.offset_len = entry->offset_len,
     @@ reftable/writer.c (new)
      +	struct obj_index_tree_node *entry = (struct obj_index_tree_node *)key;
      +
      +	FREE_AND_NULL(entry->offsets);
     -+	slice_release(&entry->hash);
     ++	strbuf_release(&entry->hash);
      +	reftable_free(entry);
      +}
      +
     @@ reftable/writer.c (new)
      +
      +int writer_finish_public_section(struct reftable_writer *w)
      +{
     -+	byte typ = 0;
     ++	uint8_t typ = 0;
      +	int err = 0;
      +
      +	if (w->block_writer == NULL)
     @@ reftable/writer.c (new)
      +
      +int reftable_writer_close(struct reftable_writer *w)
      +{
     -+	byte footer[72];
     -+	byte *p = footer;
     ++	uint8_t footer[72];
     ++	uint8_t *p = footer;
      +	int err = writer_finish_public_section(w);
      +	int empty_table = w->next == 0;
      +	if (err != 0)
     @@ reftable/writer.c (new)
      +	w->pending_padding = 0;
      +	if (empty_table) {
      +		/* Empty tables need a header anyway. */
     -+		byte header[28];
     ++		uint8_t header[28];
      +		int n = writer_write_header(w, header);
      +		err = padded_write(w, header, n, 0);
      +		if (err < 0)
     @@ reftable/writer.c (new)
      +	/* free up memory. */
      +	block_writer_clear(&w->block_writer_data);
      +	writer_clear_index(w);
     -+	slice_release(&w->last_key);
     ++	strbuf_release(&w->last_key);
      +	return err;
      +}
      +
     @@ reftable/writer.c (new)
      +{
      +	int i = 0;
      +	for (i = 0; i < w->index_len; i++) {
     -+		slice_release(&w->index[i].last_key);
     ++		strbuf_release(&w->index[i].last_key);
      +	}
      +
      +	FREE_AND_NULL(w->index);
     @@ reftable/writer.c (new)
      +
      +static int writer_flush_nonempty_block(struct reftable_writer *w)
      +{
     -+	byte typ = block_writer_type(w->block_writer);
     ++	uint8_t typ = block_writer_type(w->block_writer);
      +	struct reftable_block_stats *bstats =
      +		writer_reftable_block_stats(w, typ);
      +	uint64_t block_typ_off = (bstats->blocks == 0) ? w->next : 0;
      +	int raw_bytes = block_writer_finish(w->block_writer);
      +	int padding = 0;
      +	int err = 0;
     -+	struct reftable_index_record ir = { .last_key = SLICE_INIT };
     ++	struct reftable_index_record ir = { .last_key = STRBUF_INIT };
      +	if (raw_bytes < 0)
      +		return raw_bytes;
      +
     @@ reftable/writer.c (new)
      +	}
      +
      +	ir.offset = w->next;
     -+	slice_reset(&ir.last_key);
     -+	slice_addbuf(&ir.last_key, &w->block_writer->last_key);
     ++	strbuf_reset(&ir.last_key);
     ++	strbuf_addbuf(&ir.last_key, &w->block_writer->last_key);
      +	w->index[w->index_len] = ir;
      +
      +	w->index_len++;
     @@ reftable/writer.h (new)
      +#include "basics.h"
      +#include "block.h"
      +#include "reftable.h"
     -+#include "slice.h"
     ++#include "strbuf.h"
      +#include "tree.h"
      +
      +struct reftable_writer {
     -+	int (*write)(void *, byte *, size_t);
     ++	int (*write)(void *, const void *, size_t);
      +	void *write_arg;
      +	int pending_padding;
     -+	struct slice last_key;
     ++	struct strbuf last_key;
      +
      +	/* offset of next block to write. */
      +	uint64_t next;
     @@ reftable/writer.h (new)
      +	struct reftable_write_options opts;
      +
      +	/* memory buffer for writing */
     -+	byte *block;
     ++	uint8_t *block;
      +
      +	/* writer for the current section. NULL or points to
      +	 * block_writer_data */
  -:  ----------- > 12:  c92b8d12ec6 Add standalone build infrastructure for reftable
 12:  e1b01927454 ! 13:  479fe884e98 Reftable support for git-core
     @@ Commit message
      
          It can be activated by passing --ref-storage=reftable to "git init".
      
     -    TODO:
     -
     -    * Fix worktree commands
     -
     -    * Spots marked XXX
     -
          Example use: see t/t0031-reftable.sh
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     @@ Makefile: VCSSVN_OBJS += vcs-svn/sliding_window.o
      +REFTABLE_OBJS += reftable/record.o
      +REFTABLE_OBJS += reftable/refname.o
      +REFTABLE_OBJS += reftable/reftable.o
     -+REFTABLE_OBJS += reftable/slice.o
     ++REFTABLE_OBJS += reftable/strbuf.o
      +REFTABLE_OBJS += reftable/stack.o
      +REFTABLE_OBJS += reftable/tree.o
      +REFTABLE_OBJS += reftable/writer.o
     @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
       
      -	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
      +	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
     -+		DEFAULT_REF_STORAGE, INIT_DB_QUIET);
     ++		default_ref_storage(), INIT_DB_QUIET);
       
       	if (real_git_dir)
       		git_dir = real_git_dir;
     @@ cache.h: int path_inside_repo(const char *prefix, const char *path);
       void sanitize_stdfds(void);
       int daemonize(void);
      @@ cache.h: struct repository_format {
     - 	int is_bare;
       	int hash_algo;
     + 	int has_extensions;
       	char *work_tree;
      +	char *ref_storage;
       	struct string_list unknown_extensions;
     @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
      +	r->refs_private = ref_store_init(r->gitdir,
      +					 r->ref_storage_format ?
      +						 r->ref_storage_format :
     -+						 DEFAULT_REF_STORAGE,
     ++						 default_ref_storage(),
      +					 REF_STORE_ALL_CAPS);
       	return r->refs_private;
       }
     @@ refs.c: struct ref_store *get_submodule_ref_store(const char *submodule)
       
       	/* assume that add_submodule_odb() has been called */
      -	refs = ref_store_init(submodule_sb.buf,
     -+	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
     ++	refs = ref_store_init(submodule_sb.buf, default_ref_storage(),
       			      REF_STORE_READ | REF_STORE_ODB);
       	register_ref_store_map(&submodule_ref_stores, "submodule",
       			       refs, submodule);
     @@ refs.c: struct ref_store *get_submodule_ref_store(const char *submodule)
       
       struct ref_store *get_worktree_ref_store(const struct worktree *wt)
       {
     -+	const char *format = DEFAULT_REF_STORAGE; /* XXX */
     ++	const char *format = default_ref_storage();
       	struct ref_store *refs;
       	const char *id;
       
     @@ refs/reftable-backend.c (new)
      +	safe_create_dir(refs->reftable_dir, 1);
      +
      +	strbuf_addf(&sb, "%s/HEAD", refs->repo_dir);
     -+	write_file(sb.buf, "ref: refs/.invalid");
     ++	write_file(sb.buf, "ref: refs/heads/.invalid");
      +	strbuf_reset(&sb);
      +
      +	strbuf_addf(&sb, "%s/refs", refs->repo_dir);
     @@ refs/reftable-backend.c (new)
      +		return refs->err;
      +	}
      +
     ++	/* This is usually not needed, but Git doesn't signal to ref backend if
     ++	   a subprocess updated the ref DB.  So we always check.
     ++	*/
     ++	err = reftable_stack_reload(refs->stack);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++
      +	err = reftable_stack_read_ref(refs->stack, refname, &ref);
      +	if (err > 0) {
      +		errno = ENOENT;
     @@ refs/reftable-backend.c (new)
      +	reftable_reflog_expire,
      +};
      
     + ## reftable/update.sh ##
     +@@ reftable/update.sh: cp reftable-repo/LICENSE reftable/
     + git --git-dir reftable-repo/.git show --no-patch --format=oneline HEAD \
     +   > reftable/VERSION
     + 
     +-mv reftable/system.h reftable/system.h~
     +-sed 's|if REFTABLE_IN_GITCORE|if 1 /* REFTABLE_IN_GITCORE */|'  < reftable/system.h~ > reftable/system.h
     +-
     + git add reftable/*.[ch] reftable/LICENSE reftable/VERSION
     +
       ## repository.c ##
      @@ repository.c: int repo_init(struct repository *repo,
       	if (worktree)
     @@ t/t0031-reftable.sh (new)
      +	for count in $(test_seq 1 10)
      +	do
      +		test_commit "number $count" file.t $count number-$count ||
     -+	        return 1
     ++		return 1
      +	done &&
      +	git pack-refs &&
      +	ls -1 .git/reftable >table-files &&
     @@ t/t0031-reftable.sh (new)
      +	git branch source &&
      +	git checkout HEAD^ &&
      +	test_commit message3 file3 &&
     -+ 	git rebase source &&
     ++	git rebase source &&
      +	test -f file2
      +'
      +
 13:  0359fe416fa ! 14:  eafd8eeefcc Hookup unittests for the reftable library.
     @@ Makefile: REFTABLE_OBJS += reftable/tree.o
      +REFTABLE_TEST_OBJS += reftable/record_test.o
      +REFTABLE_TEST_OBJS += reftable/refname_test.o
      +REFTABLE_TEST_OBJS += reftable/reftable_test.o
     -+REFTABLE_TEST_OBJS += reftable/slice_test.o
     ++REFTABLE_TEST_OBJS += reftable/strbuf_test.o
      +REFTABLE_TEST_OBJS += reftable/stack_test.o
      +REFTABLE_TEST_OBJS += reftable/tree_test.o
      +REFTABLE_TEST_OBJS += reftable/test_framework.o
     @@ t/helper/test-reftable.c (new)
      +	record_test_main(argc, argv);
      +	refname_test_main(argc, argv);
      +	reftable_test_main(argc, argv);
     -+	slice_test_main(argc, argv);
     ++	strbuf_test_main(argc, argv);
      +	stack_test_main(argc, argv);
      +	tree_test_main(argc, argv);
      +	return 0;
 14:  88640ea13f9 ! 15:  46af142f33b Add GIT_DEBUG_REFS debugging mechanism
     @@ Makefile: LIB_OBJS += rebase.o
       ## refs.c ##
      @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
       						 r->ref_storage_format :
     - 						 DEFAULT_REF_STORAGE,
     + 						 default_ref_storage(),
       					 REF_STORE_ALL_CAPS);
      +	if (getenv("GIT_DEBUG_REFS")) {
      +		r->refs_private = debug_wrap(r->refs_private);
     @@ refs/debug.c (new)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)refs;
      +	int res = drefs->refs->be->init_db(drefs->refs, err);
     ++	fprintf(stderr, "init_db: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	transaction->ref_store = drefs->refs;
      +	res = drefs->refs->be->transaction_prepare(drefs->refs, transaction,
      +						   err);
     ++	fprintf(stderr, "transaction_prepare: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	type &= 0xf; /* see refs.h REF_* */
      +	flags &= REF_HAVE_NEW | REF_HAVE_OLD | REF_NO_DEREF |
      +		 REF_FORCE_CREATE_REFLOG | REF_LOG_ONLY;
     -+	printf("%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname, o, n,
     -+	       flags, type, msg);
     ++	fprintf(stderr, "%d: %s %s -> %s (F=0x%x, T=0x%x) \"%s\"\n", i, refname,
     ++		o, n, flags, type, msg);
      +}
      +
      +static void print_transaction(struct ref_transaction *transaction)
      +{
     -+	printf("transaction {\n");
     ++	fprintf(stderr, "transaction {\n");
      +	for (int i = 0; i < transaction->nr; i++) {
      +		struct ref_update *u = transaction->updates[i];
      +		print_update(i, u->refname, &u->old_oid, &u->new_oid, u->flags,
      +			     u->type, u->msg);
      +	}
     -+	printf("}\n");
     ++	fprintf(stderr, "}\n");
      +}
      +
      +static int debug_transaction_finish(struct ref_store *refs,
     @@ refs/debug.c (new)
      +	res = drefs->refs->be->transaction_finish(drefs->refs, transaction,
      +						  err);
      +	print_transaction(transaction);
     -+	printf("finish: %d\n", res);
     ++	fprintf(stderr, "finish: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->pack_refs(drefs->refs, flags);
     ++	fprintf(stderr, "pack_refs: %d\n", res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->create_symref(drefs->refs, ref_name, target,
      +						 logmsg);
     -+	printf("create_symref: %s -> %s \"%s\": %d\n", ref_name, target, logmsg,
     -+	       res);
     ++	fprintf(stderr, "create_symref: %s -> %s \"%s\": %d\n", ref_name,
     ++		target, logmsg, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->rename_ref(drefs->refs, oldref, newref,
      +					      logmsg);
     -+	printf("rename_ref: %s -> %s \"%s\": %d\n", oldref, newref, logmsg,
     -+	       res);
     ++	fprintf(stderr, "rename_ref: %s -> %s \"%s\": %d\n", oldref, newref,
     ++		logmsg, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res =
      +		drefs->refs->be->copy_ref(drefs->refs, oldref, newref, logmsg);
     -+	printf("copy_ref: %s -> %s \"%s\": %d\n", oldref, newref, logmsg, res);
     ++	fprintf(stderr, "copy_ref: %s -> %s \"%s\": %d\n", oldref, newref,
     ++		logmsg, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +		oid_to_hex_r(o, oid);
      +	if (old_oid)
      +		oid_to_hex_r(n, old_oid);
     -+	printf("write_pseudoref: %s, %s => %s, err %s: %d\n", pseudoref, o, n,
     -+	       err->buf, res);
     ++	fprintf(stderr, "write_pseudoref: %s, %s => %s, err %s: %d\n",
     ++		pseudoref, o, n, err->buf, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	char hex[100] = "null";
      +	if (old_oid)
      +		oid_to_hex_r(hex, old_oid);
     -+	printf("delete_pseudoref: %s (%s): %d\n", pseudoref, hex, res);
     ++	fprintf(stderr, "delete_pseudoref: %s (%s): %d\n", pseudoref, hex, res);
      +	return res;
      +}
      +
     ++struct debug_ref_iterator {
     ++	struct ref_iterator base;
     ++	struct ref_iterator *iter;
     ++};
     ++
     ++static int debug_ref_iterator_advance(struct ref_iterator *ref_iterator)
     ++{
     ++	struct debug_ref_iterator *diter =
     ++		(struct debug_ref_iterator *)ref_iterator;
     ++	int res = diter->iter->vtable->advance(diter->iter);
     ++	fprintf(stderr, "iterator_advance: %s: %d\n", diter->iter->refname,
     ++		res);
     ++	diter->base.ordered = diter->iter->ordered;
     ++	diter->base.refname = diter->iter->refname;
     ++	diter->base.oid = diter->iter->oid;
     ++	diter->base.flags = diter->iter->flags;
     ++	return res;
     ++}
     ++static int debug_ref_iterator_peel(struct ref_iterator *ref_iterator,
     ++				   struct object_id *peeled)
     ++{
     ++	struct debug_ref_iterator *diter =
     ++		(struct debug_ref_iterator *)ref_iterator;
     ++	int res = diter->iter->vtable->peel(diter->iter, peeled);
     ++	fprintf(stderr, "iterator_peel: %s: %d\n", diter->iter->refname, res);
     ++	return res;
     ++}
     ++
     ++static int debug_ref_iterator_abort(struct ref_iterator *ref_iterator)
     ++{
     ++	struct debug_ref_iterator *diter =
     ++		(struct debug_ref_iterator *)ref_iterator;
     ++	int res = diter->iter->vtable->abort(diter->iter);
     ++	fprintf(stderr, "iterator_abort: %d\n", res);
     ++	return res;
     ++}
     ++
     ++static struct ref_iterator_vtable debug_ref_iterator_vtable = {
     ++	debug_ref_iterator_advance, debug_ref_iterator_peel,
     ++	debug_ref_iterator_abort
     ++};
     ++
      +static struct ref_iterator *
      +debug_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
      +			 unsigned int flags)
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	struct ref_iterator *res =
      +		drefs->refs->be->iterator_begin(drefs->refs, prefix, flags);
     -+	return res;
     ++	struct debug_ref_iterator *diter = xcalloc(1, sizeof(*diter));
     ++	base_ref_iterator_init(&diter->base, &debug_ref_iterator_vtable, 1);
     ++	diter->iter = res;
     ++	fprintf(stderr, "ref_iterator_begin: %s (0x%x)\n", prefix, flags);
     ++	return &diter->base;
      +}
      +
      +static int debug_read_raw_ref(struct ref_store *ref_store, const char *refname,
     @@ refs/debug.c (new)
      +					    type);
      +
      +	if (res == 0) {
     -+		printf("read_raw_ref: %s: %s (=> %s) type %x: %d\n", refname,
     -+		       oid_to_hex(oid), referent->buf, *type, res);
     ++		fprintf(stderr, "read_raw_ref: %s: %s (=> %s) type %x: %d\n",
     ++			refname, oid_to_hex(oid), referent->buf, *type, res);
      +	} else {
     -+		printf("read_raw_ref: %s err %d\n", refname, res);
     ++		fprintf(stderr, "read_raw_ref: %s err %d\n", refname, res);
      +	}
      +	return res;
      +}
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	struct ref_iterator *res =
      +		drefs->refs->be->reflog_iterator_begin(drefs->refs);
     -+	printf("for_each_reflog_iterator_begin\n");
     ++	fprintf(stderr, "for_each_reflog_iterator_begin\n");
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +
      +	ret = dbg->fn(old_oid, new_oid, committer, timestamp, tz, msg,
      +		      dbg->cb_data);
     -+	printf("reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
     -+	       dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
     ++	fprintf(stderr, "reflog_ent %s (ret %d): %s -> %s, %s %ld \"%s\"\n",
     ++		dbg->refname, ret, o, n, committer, (long int)timestamp, msg);
      +	return ret;
      +}
      +
     @@ refs/debug.c (new)
      +
      +	int res = drefs->refs->be->for_each_reflog_ent(
      +		drefs->refs, refname, &debug_print_reflog_ent, &dbg);
     -+	printf("for_each_reflog: %s: %d\n", refname, res);
     ++	fprintf(stderr, "for_each_reflog: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	};
      +	int res = drefs->refs->be->for_each_reflog_ent_reverse(
      +		drefs->refs, refname, &debug_print_reflog_ent, &dbg);
     -+	printf("for_each_reflog_reverse: %s: %d\n", refname, res);
     ++	fprintf(stderr, "for_each_reflog_reverse: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->reflog_exists(drefs->refs, refname);
     -+	printf("reflog_exists: %s: %d\n", refname, res);
     ++	fprintf(stderr, "reflog_exists: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->create_reflog(drefs->refs, refname,
      +						 force_create, err);
     ++	fprintf(stderr, "create_reflog: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +{
      +	struct debug_ref_store *drefs = (struct debug_ref_store *)ref_store;
      +	int res = drefs->refs->be->delete_reflog(drefs->refs, refname);
     ++	fprintf(stderr, "delete_reflog: %s: %d\n", refname, res);
      +	return res;
      +}
      +
     @@ refs/debug.c (new)
      +						 flags, prepare_fn,
      +						 should_prune_fn, cleanup_fn,
      +						 policy_cb_data);
     ++	fprintf(stderr, "reflog_expire: %s: %d\n", refname, res);
      +	return res;
      +}
      +
 15:  1c0cc646084 = 16:  5211c643104 vcxproj: adjust for the reftable changes
  -:  ----------- > 17:  9724854088c git-prompt: prepare for reftable refs backend
 16:  4f24b5f73de ! 18:  ece1fa1f625 Add reftable testing infrastructure
     @@ Commit message
          * Skip some tests that are incompatible:
      
            * t3210-pack-refs.sh - does not apply
     -      * t9903-bash-prompt - The bash mode reads .git/HEAD directly
            * t1450-fsck.sh - manipulates .git/ directly to create invalid state
      
          Major test failures:
     @@ Commit message
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
     - ## builtin/clone.c ##
     -@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 	}
     - 
     - 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
     --		DEFAULT_REF_STORAGE, INIT_DB_QUIET);
     -+		default_ref_storage(), INIT_DB_QUIET);
     - 
     - 	if (real_git_dir)
     - 		git_dir = real_git_dir;
     -
     - ## refs.c ##
     -@@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
     - 	r->refs_private = ref_store_init(r->gitdir,
     - 					 r->ref_storage_format ?
     - 						 r->ref_storage_format :
     --						 DEFAULT_REF_STORAGE,
     -+						 default_ref_storage(),
     - 					 REF_STORE_ALL_CAPS);
     - 	if (getenv("GIT_DEBUG_REFS")) {
     - 		r->refs_private = debug_wrap(r->refs_private);
     -@@ refs.c: struct ref_store *get_submodule_ref_store(const char *submodule)
     - 		goto done;
     - 
     - 	/* assume that add_submodule_odb() has been called */
     --	refs = ref_store_init(submodule_sb.buf, DEFAULT_REF_STORAGE, /* XXX */
     -+	refs = ref_store_init(submodule_sb.buf, default_ref_storage(),
     - 			      REF_STORE_READ | REF_STORE_ODB);
     - 	register_ref_store_map(&submodule_ref_stores, "submodule",
     - 			       refs, submodule);
     -@@ refs.c: struct ref_store *get_submodule_ref_store(const char *submodule)
     - 
     - struct ref_store *get_worktree_ref_store(const struct worktree *wt)
     - {
     --	const char *format = DEFAULT_REF_STORAGE; /* XXX */
     -+	const char *format = default_ref_storage();
     - 	struct ref_store *refs;
     - 	const char *id;
     - 
     -
       ## t/t1409-avoid-packing-refs.sh ##
      @@ t/t1409-avoid-packing-refs.sh: test_description='avoid rewriting packed-refs unnecessarily'
       
     @@ t/t3210-pack-refs.sh: semantic is still the same.
       	git config core.logallrefupdates true
       '
      
     - ## t/t9903-bash-prompt.sh ##
     -@@ t/t9903-bash-prompt.sh: test_description='test git-specific bash prompt functions'
     - 
     - . ./lib-bash.sh
     - 
     -+if test_have_prereq REFTABLE
     -+then
     -+  skip_all='skipping tests; incompatible with reftable'
     -+  test_done
     -+fi
     -+
     - . "$GIT_BUILD_DIR/contrib/completion/git-prompt.sh"
     - 
     - actual="$TRASH_DIRECTORY/actual"
     -
       ## t/test-lib.sh ##
      @@ t/test-lib.sh: parisc* | hppa*)
       	;;
 17:  ad5658ffc51 = 19:  991abf9e1b2 Add "test-tool dump-reftable" command.

-- 
gitgitgadget
