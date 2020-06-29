Return-Path: <SRS0=sGv9=AK=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49958C433DF
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 08F8220720
	for <git@archiver.kernel.org>; Mon, 29 Jun 2020 21:14:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X2SPUGBQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390316AbgF2VOo (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:14:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729920AbgF2S5F (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Jun 2020 14:57:05 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6DBCC031C44
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:04 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id l2so15650544wmf.0
        for <git@vger.kernel.org>; Mon, 29 Jun 2020 11:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=yzlqn2f9Y9OerCysTSYckNNTPO3INzl55xJELwqSCWY=;
        b=X2SPUGBQTzIFaoDKvUijITXIrrhrSzLVoQgyeaaYSSiY8MAIZg4Y0a/FhBlyYR2rJf
         KdMLYad9iq1T09Hntx2m3OVdyREk8OjVaQb2p8fP8wBFZgp2JwUl+XbVq0+y8kho7Q2S
         QZ/h6G/KmHAYkyfEjOVQCqggOHihgmULKYGo0WrksBAo+y6X+ljJuSxHdsdAQ0ZGgZgm
         G8BqJjfPU4L2luCEgKjm+tdDEoeomye4iHu6XIMx8+wGZnJgKi6byaqyZwI3uuUeCRFs
         pdTmCWFnB+1mTeB30MeRJmC3zfmCB101hKt9ONgoAFYOVDmVihJNDG/7KeyfzudZbtNP
         rcSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=yzlqn2f9Y9OerCysTSYckNNTPO3INzl55xJELwqSCWY=;
        b=PFMjL5yOB3jlaAvvCylZSjkCUCAaAIubN4IPnrlw6PWRcyM8FKpyAMY/A2Q3vmgtm5
         b7tyIw1Ox94d/NtGQ28hcQmZc+K4GPaSwg7XiY92OoakIuHyIhMQ2pq7lTtxv87QdbXQ
         Q2GFiAh/1SvUqxVKYn+QfxDbl8J6eyqtqHqGGyzhlRdshTInjD4klQXNRVmyWCskk86u
         jJb+Ux/YjvSel8OxW7biV1ej1PpNirM4VxlkI825ACsUqhJSMNqz5TyzYsl1BCVABVzO
         Aw5bt200UyFxVGB7wdvmdwtn436RsIh3k5YLhj8BHN4f7APgVRhuBRC5eHtIrbK3FSSG
         nuzg==
X-Gm-Message-State: AOAM533KWcMDhA5MyRJ+IQHjhMelUZ1hZ7aq70z5tOVvKqVwQq6eO7MN
        Mwc8V8syT09Hlz0Hy8vKPeMslPjVgAI=
X-Google-Smtp-Source: ABdhPJxVOZJXt9B0+7OFJoXxrpjpjnXMRW6vz9Ftbwhhn9uE52lGmoRvtiES1QTBDXilcHyCUJvoNw==
X-Received: by 2002:a05:600c:28d:: with SMTP id 13mr17697655wmk.30.1593457020511;
        Mon, 29 Jun 2020 11:57:00 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i19sm793382wrb.56.2020.06.29.11.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2020 11:56:59 -0700 (PDT)
Message-Id: <pull.539.v19.git.1593457018.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
References: <pull.539.v18.git.1592862920.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 29 Jun 2020 18:56:38 +0000
Subject: [PATCH v19 00/20] Reftable support git-core
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

This adds the reftable library, and hooks it up as a ref backend. 

Includes testing support, to test: make -C t/ GIT_TEST_REFTABLE=1

Summary 21852 tests pass 556 tests fail

v22

 * worktree support

Han-Wen Nienhuys (18):
  lib-t6000.sh: write tag using git-update-ref
  t3432: use git-reflog to inspect the reflog for HEAD
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
 builtin/clone.c                               |    4 +-
 builtin/commit.c                              |   34 +-
 builtin/init-db.c                             |   54 +-
 builtin/merge.c                               |    2 +-
 builtin/worktree.c                            |   31 +-
 cache.h                                       |    8 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 contrib/completion/git-prompt.sh              |    7 +-
 git-bisect.sh                                 |    4 +-
 path.c                                        |    2 -
 path.h                                        |    9 +-
 refs.c                                        |  157 +-
 refs.h                                        |   16 +
 refs/debug.c                                  |  416 +++++
 refs/files-backend.c                          |  121 +-
 refs/packed-backend.c                         |   21 +-
 refs/refs-internal.h                          |   32 +
 refs/reftable-backend.c                       | 1497 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/BUILD                                |  203 +++
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   33 +
 reftable/VERSION                              |    1 +
 reftable/WORKSPACE                            |   14 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  432 +++++
 reftable/block.h                              |  129 ++
 reftable/block_test.c                         |  157 ++
 reftable/compat.c                             |   98 ++
 reftable/compat.h                             |   48 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |  212 +++
 reftable/file.c                               |   95 ++
 reftable/iter.c                               |  242 +++
 reftable/iter.h                               |   72 +
 reftable/merged.c                             |  317 ++++
 reftable/merged.h                             |   43 +
 reftable/merged_test.c                        |  286 ++++
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  744 ++++++++
 reftable/reader.h                             |   65 +
 reftable/record.c                             | 1126 +++++++++++++
 reftable/record.h                             |  143 ++
 reftable/record_test.c                        |  410 +++++
 reftable/refname.c                            |  209 +++
 reftable/refname.h                            |   38 +
 reftable/refname_test.c                       |   99 ++
 reftable/reftable-tests.h                     |   22 +
 reftable/reftable.c                           |  154 ++
 reftable/reftable.h                           |  585 +++++++
 reftable/reftable_test.c                      |  632 +++++++
 reftable/stack.c                              | 1225 ++++++++++++++
 reftable/stack.h                              |   50 +
 reftable/stack_test.c                         |  787 +++++++++
 reftable/strbuf.c                             |  206 +++
 reftable/strbuf.h                             |   88 +
 reftable/strbuf_test.c                        |   39 +
 reftable/system.h                             |   53 +
 reftable/test_framework.c                     |   69 +
 reftable/test_framework.h                     |   64 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/tree_test.c                          |   62 +
 reftable/update.sh                            |   19 +
 reftable/writer.c                             |  663 ++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 +
 reftable/zlib.BUILD                           |   36 +
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 sequencer.c                                   |   56 +-
 setup.c                                       |   12 +-
 t/helper/test-reftable.c                      |   20 +
 t/helper/test-tool.c                          |    2 +
 t/helper/test-tool.h                          |    2 +
 t/lib-t6000.sh                                |    5 +-
 t/t0031-reftable.sh                           |  178 ++
 t/t0033-debug-refs.sh                         |   18 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/t3432-rebase-fast-forward.sh                |    7 +-
 t/test-lib.sh                                 |    5 +
 wt-status.c                                   |    6 +-
 91 files changed, 13304 insertions(+), 209 deletions(-)
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


base-commit: b9a2d1a0207fb9ded3fa524f54db3bc322a12cc4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v19
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v19
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v18:

  1:  b968b795af =  1:  596c316da4 lib-t6000.sh: write tag using git-update-ref
  -:  ---------- >  2:  277da0cf7e t3432: use git-reflog to inspect the reflog for HEAD
  2:  5210225977 =  3:  125695ce92 checkout: add '\n' to reflog message
  3:  15c9dd66e1 =  4:  5715681b3f Write pseudorefs through ref backends.
  4:  a5bce2e3fe =  5:  c8cf2d2ce1 Make refs_ref_exists public
  5:  a29d898907 =  6:  e36b29de79 Treat BISECT_HEAD as a pseudo ref
  6:  11a690d2b8 =  7:  1676df9851 Treat CHERRY_PICK_HEAD as a pseudo ref
  7:  4e52ec0dbc =  8:  0a5f97ea34 Treat REVERT_HEAD as a pseudo ref
  8:  37e350af15 =  9:  9463ed9093 Move REF_LOG_ONLY to refs-internal.h
  9:  468f00eaf6 = 10:  a116aebe11 Iterate over the "refs/" namespace in for_each_[raw]ref
 10:  21febeaa81 = 11:  e4545658ed Add .gitattributes for the reftable/ directory
 11:  3c84f43cfa ! 12:  169f6c7f54 Add reftable library
     @@ reftable/LICENSE (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+d7472cbd1afe6bf3da53e94971b1cc79ce183fa8 Remove outdated bits of the README file
     ++994cc2f626ff626ff04be5240413775f832110fb C: formatting tweaks
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/basics.c (new)
      +void parse_names(char *buf, int size, char ***namesp)
      +{
      +	char **names = NULL;
     -+	int names_cap = 0;
     -+	int names_len = 0;
     ++	size_t names_cap = 0;
     ++	size_t names_len = 0;
      +
      +	char *p = buf;
      +	char *end = buf + size;
     @@ reftable/block_test.c (new)
      +		snprintf(name, sizeof(name), "branch%02d", i);
      +		memset(hash, i, sizeof(hash));
      +
     -+		ref.ref_name = name;
     ++		ref.refname = name;
      +		ref.value = hash;
      +		names[i] = xstrdup(name);
      +		n = block_writer_add(&bw, &rec);
     -+		ref.ref_name = NULL;
     ++		ref.refname = NULL;
      +		ref.value = NULL;
      +		assert(n == 0);
      +	}
     @@ reftable/block_test.c (new)
      +		if (r > 0) {
      +			break;
      +		}
     -+		assert_streq(names[j], ref.ref_name);
     ++		assert_streq(names[j], ref.refname);
      +		j++;
      +	}
      +
     @@ reftable/block_test.c (new)
      +		n = block_iter_next(&it, &rec);
      +		assert(n == 0);
      +
     -+		assert_streq(names[i], ref.ref_name);
     ++		assert_streq(names[i], ref.refname);
      +
      +		want.len--;
      +		n = block_reader_seek(&br, &it, &want);
     @@ reftable/block_test.c (new)
      +
      +		n = block_iter_next(&it, &rec);
      +		assert(n == 0);
     -+		assert_streq(names[10 * (i / 10)], ref.ref_name);
     ++		assert_streq(names[10 * (i / 10)], ref.refname);
      +
      +		block_iter_close(&it);
      +	}
     @@ reftable/iter.c (new)
      +			struct reftable_iterator it = { 0 };
      +
      +			err = reftable_table_seek_ref(&fri->tab, &it,
     -+						      ref->ref_name);
     ++						      ref->refname);
      +			if (err == 0) {
      +				err = reftable_iterator_next_ref(&it, ref);
      +			}
     @@ reftable/merged.c (new)
      +}
      +
      +int reftable_new_merged_table(struct reftable_merged_table **dest,
     -+			      struct reftable_reader **stack, int n,
     ++			      struct reftable_table *stack, int n,
      +			      uint32_t hash_id)
      +{
      +	struct reftable_merged_table *m = NULL;
     @@ reftable/merged.c (new)
      +	uint64_t first_min = 0;
      +	int i = 0;
      +	for (i = 0; i < n; i++) {
     -+		struct reftable_reader *r = stack[i];
     -+		if (r->hash_id != hash_id) {
     ++		uint64_t min = reftable_table_min_update_index(&stack[i]);
     ++		uint64_t max = reftable_table_max_update_index(&stack[i]);
     ++
     ++		if (reftable_table_hash_id(&stack[i]) != hash_id) {
      +			return REFTABLE_FORMAT_ERROR;
      +		}
     -+		if (i > 0 && last_max >= reftable_reader_min_update_index(r)) {
     -+			return REFTABLE_FORMAT_ERROR;
     ++		if (i == 0 || min < first_min) {
     ++			first_min = min;
      +		}
     -+		if (i == 0) {
     -+			first_min = reftable_reader_min_update_index(r);
     ++		if (i == 0 || max > last_max) {
     ++			last_max = max;
      +		}
     -+
     -+		last_max = reftable_reader_max_update_index(r);
      +	}
      +
      +	m = (struct reftable_merged_table *)reftable_calloc(
     @@ reftable/merged.c (new)
      +	return 0;
      +}
      +
     -+void reftable_merged_table_close(struct reftable_merged_table *mt)
     -+{
     -+	int i = 0;
     -+	for (i = 0; i < mt->stack_len; i++) {
     -+		reftable_reader_free(mt->stack[i]);
     -+	}
     -+	FREE_AND_NULL(mt->stack);
     -+	mt->stack_len = 0;
     -+}
     -+
      +/* clears the list of subtable, without affecting the readers themselves. */
      +void merged_table_clear(struct reftable_merged_table *mt)
      +{
     @@ reftable/merged.c (new)
      +	int err = 0;
      +	int i = 0;
      +	for (i = 0; i < mt->stack_len && err == 0; i++) {
     -+		int e = reader_seek(mt->stack[i], &iters[n], rec);
     ++		int e = reftable_table_seek_record(&mt->stack[i], &iters[n],
     ++						   rec);
      +		if (e < 0) {
      +			err = e;
      +		}
     @@ reftable/merged.c (new)
      +				   const char *name)
      +{
      +	struct reftable_ref_record ref = {
     -+		.ref_name = (char *)name,
     ++		.refname = (char *)name,
      +	};
      +	struct reftable_record rec = { 0 };
      +	reftable_record_from_ref(&rec, &ref);
     @@ reftable/merged.c (new)
      +				      const char *name, uint64_t update_index)
      +{
      +	struct reftable_log_record log = {
     -+		.ref_name = (char *)name,
     ++		.refname = (char *)name,
      +		.update_index = update_index,
      +	};
      +	struct reftable_record rec = { 0 };
     @@ reftable/merged.c (new)
      +{
      +	uint64_t max = ~((uint64_t)0);
      +	return reftable_merged_table_seek_log_at(mt, it, name, max);
     ++}
     ++
     ++uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
     ++{
     ++	return mt->hash_id;
      +}
      
       ## reftable/merged.h (new) ##
     @@ reftable/merged.h (new)
      +#include "reftable.h"
      +
      +struct reftable_merged_table {
     -+	struct reftable_reader **stack;
     -+	int stack_len;
     ++	struct reftable_table *stack;
     ++	size_t stack_len;
      +	uint32_t hash_id;
      +	bool suppress_deletions;
      +
     @@ reftable/merged.h (new)
      +struct merged_iter {
      +	struct reftable_iterator *stack;
      +	uint32_t hash_id;
     -+	int stack_len;
     ++	size_t stack_len;
      +	uint8_t typ;
      +	bool suppress_deletions;
      +	struct merged_iter_pqueue pq;
     @@ reftable/merged.h (new)
      +			     struct reftable_iterator *it,
      +			     struct reftable_record *rec);
      +
     ++int reftable_table_seek_record(struct reftable_table *tab,
     ++			       struct reftable_iterator *it,
     ++			       struct reftable_record *rec);
     ++
      +#endif
      
       ## reftable/merged_test.c (new) ##
     @@ reftable/merged_test.c (new)
      +			reftable_new_record(BLOCK_TYPE_REF);
      +		struct pq_entry e = { 0 };
      +
     -+		reftable_record_as_ref(&rec)->ref_name = names[i];
     ++		reftable_record_as_ref(&rec)->refname = names[i];
      +		e.rec = rec;
      +		merged_iter_pqueue_add(&pq, e);
      +		merged_iter_pqueue_check(pq);
     @@ reftable/merged_test.c (new)
      +		merged_iter_pqueue_check(pq);
      +
      +		if (last != NULL) {
     -+			assert(strcmp(last, ref->ref_name) < 0);
     ++			assert(strcmp(last, ref->refname) < 0);
      +		}
     -+		last = ref->ref_name;
     -+		ref->ref_name = NULL;
     ++		last = ref->refname;
     ++		ref->refname = NULL;
      +		reftable_free(ref);
      +	}
      +
     @@ reftable/merged_test.c (new)
      +
      +static struct reftable_merged_table *
      +merged_table_from_records(struct reftable_ref_record **refs,
     -+			  struct reftable_block_source **source, int *sizes,
     ++			  struct reftable_block_source **source,
     ++			  struct reftable_reader ***readers, int *sizes,
      +			  struct strbuf *buf, int n)
      +{
     -+	struct reftable_reader **rd = reftable_calloc(n * sizeof(*rd));
      +	int i = 0;
      +	struct reftable_merged_table *mt = NULL;
      +	int err;
     ++	struct reftable_table *tabs =
     ++		reftable_calloc(n * sizeof(struct reftable_table));
     ++	*readers = reftable_calloc(n * sizeof(struct reftable_reader *));
      +	*source = reftable_calloc(n * sizeof(**source));
      +	for (i = 0; i < n; i++) {
      +		write_test_table(&buf[i], refs[i], sizes[i]);
      +		block_source_from_strbuf(&(*source)[i], &buf[i]);
      +
     -+		err = reftable_new_reader(&rd[i], &(*source)[i], "name");
     ++		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
     ++					  "name");
      +		assert_err(err);
     ++		reftable_table_from_reader(&tabs[i], (*readers)[i]);
      +	}
      +
     -+	err = reftable_new_merged_table(&mt, rd, n, SHA1_ID);
     ++	err = reftable_new_merged_table(&mt, tabs, n, SHA1_ID);
      +	assert_err(err);
      +	return mt;
      +}
      +
     ++static void readers_destroy(struct reftable_reader **readers, size_t n)
     ++{
     ++	int i = 0;
     ++	for (; i < n; i++)
     ++		reftable_reader_free(readers[i]);
     ++	reftable_free(readers);
     ++}
     ++
      +static void test_merged_between(void)
      +{
      +	uint8_t hash1[SHA1_SIZE] = { 1, 2, 3, 0 };
      +
      +	struct reftable_ref_record r1[] = { {
     -+		.ref_name = "b",
     ++		.refname = "b",
      +		.update_index = 1,
      +		.value = hash1,
      +	} };
      +	struct reftable_ref_record r2[] = { {
     -+		.ref_name = "a",
     ++		.refname = "a",
      +		.update_index = 2,
      +	} };
      +
     @@ reftable/merged_test.c (new)
      +	int sizes[] = { 1, 1 };
      +	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
      +	struct reftable_block_source *bs = NULL;
     ++	struct reftable_reader **readers = NULL;
      +	struct reftable_merged_table *mt =
     -+		merged_table_from_records(refs, &bs, sizes, bufs, 2);
     ++		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
      +	int i;
      +	struct reftable_ref_record ref = { 0 };
      +	struct reftable_iterator it = { 0 };
     @@ reftable/merged_test.c (new)
      +	assert_err(err);
      +	assert(ref.update_index == 2);
      +	reftable_ref_record_clear(&ref);
     -+
      +	reftable_iterator_destroy(&it);
     -+	reftable_merged_table_close(mt);
     ++	readers_destroy(readers, 2);
      +	reftable_merged_table_free(mt);
      +	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
      +		strbuf_release(&bufs[i]);
     @@ reftable/merged_test.c (new)
      +	uint8_t hash1[SHA1_SIZE] = { 1 };
      +	uint8_t hash2[SHA1_SIZE] = { 2 };
      +	struct reftable_ref_record r1[] = { {
     -+						    .ref_name = "a",
     ++						    .refname = "a",
      +						    .update_index = 1,
      +						    .value = hash1,
      +					    },
      +					    {
     -+						    .ref_name = "b",
     ++						    .refname = "b",
      +						    .update_index = 1,
      +						    .value = hash1,
      +					    },
      +					    {
     -+						    .ref_name = "c",
     ++						    .refname = "c",
      +						    .update_index = 1,
      +						    .value = hash1,
      +					    } };
      +	struct reftable_ref_record r2[] = { {
     -+		.ref_name = "a",
     ++		.refname = "a",
      +		.update_index = 2,
      +	} };
      +	struct reftable_ref_record r3[] = {
      +		{
     -+			.ref_name = "c",
     ++			.refname = "c",
      +			.update_index = 3,
      +			.value = hash2,
      +		},
      +		{
     -+			.ref_name = "d",
     ++			.refname = "d",
      +			.update_index = 3,
      +			.value = hash1,
      +		},
     @@ reftable/merged_test.c (new)
      +	int sizes[3] = { 3, 1, 2 };
      +	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
      +	struct reftable_block_source *bs = NULL;
     -+
     ++	struct reftable_reader **readers = NULL;
      +	struct reftable_merged_table *mt =
     -+		merged_table_from_records(refs, &bs, sizes, bufs, 3);
     ++		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
      +
      +	struct reftable_iterator it = { 0 };
      +	int err = reftable_merged_table_seek_ref(mt, &it, "a");
      +	struct reftable_ref_record *out = NULL;
     -+	int len = 0;
     -+	int cap = 0;
     ++	size_t len = 0;
     ++	size_t cap = 0;
      +	int i = 0;
      +
      +	assert_err(err);
     @@ reftable/merged_test.c (new)
      +	for (i = 0; i < 3; i++) {
      +		strbuf_release(&bufs[i]);
      +	}
     -+	reftable_merged_table_close(mt);
     ++	readers_destroy(readers, 3);
      +	reftable_merged_table_free(mt);
      +	reftable_free(bs);
      +}
     @@ reftable/pq.h (new)
      +
      +struct merged_iter_pqueue {
      +	struct pq_entry *heap;
     -+	int len;
     -+	int cap;
     ++	size_t len;
     ++	size_t cap;
      +};
      +
      +struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
     @@ reftable/reader.c (new)
      +			     uint64_t next_off, uint8_t want_typ)
      +{
      +	int32_t guess_block_size = r->block_size ? r->block_size :
     -+						   DEFAULT_BLOCK_SIZE;
     ++							 DEFAULT_BLOCK_SIZE;
      +	struct reftable_block block = { 0 };
      +	uint8_t block_typ = 0;
      +	int err = 0;
     @@ reftable/reader.c (new)
      +			     struct reftable_iterator *it, const char *name)
      +{
      +	struct reftable_ref_record ref = {
     -+		.ref_name = (char *)name,
     ++		.refname = (char *)name,
      +	};
      +	struct reftable_record rec = { 0 };
      +	reftable_record_from_ref(&rec, &ref);
     @@ reftable/reader.c (new)
      +				uint64_t update_index)
      +{
      +	struct reftable_log_record log = {
     -+		.ref_name = (char *)name,
     ++		.refname = (char *)name,
      +		.update_index = update_index,
      +	};
      +	struct reftable_record rec = { 0 };
     @@ reftable/record.c (new)
      +	const struct reftable_ref_record *rec =
      +		(const struct reftable_ref_record *)r;
      +	strbuf_reset(dest);
     -+	strbuf_addstr(dest, rec->ref_name);
     ++	strbuf_addstr(dest, rec->refname);
      +}
      +
      +static void reftable_ref_record_copy_from(void *rec, const void *src_rec,
     @@ reftable/record.c (new)
      +	/* This is simple and correct, but we could probably reuse the hash
      +	   fields. */
      +	reftable_ref_record_clear(ref);
     -+	if (src->ref_name != NULL) {
     -+		ref->ref_name = xstrdup(src->ref_name);
     ++	if (src->refname != NULL) {
     ++		ref->refname = xstrdup(src->refname);
      +	}
      +
      +	if (src->target != NULL) {
     @@ reftable/record.c (new)
      +			       uint32_t hash_id)
      +{
      +	char hex[SHA256_SIZE + 1] = { 0 };
     -+	printf("ref{%s(%" PRIu64 ") ", ref->ref_name, ref->update_index);
     ++	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
      +	if (ref->value != NULL) {
      +		hex_format(hex, ref->value, hash_size(hash_id));
      +		printf("%s", hex);
     @@ reftable/record.c (new)
      +
      +void reftable_ref_record_clear(struct reftable_ref_record *ref)
      +{
     -+	reftable_free(ref->ref_name);
     ++	reftable_free(ref->refname);
      +	reftable_free(ref->target);
      +	reftable_free(ref->target_value);
      +	reftable_free(ref->value);
     @@ reftable/record.c (new)
      +
      +	string_view_consume(&in, n);
      +
     -+	r->ref_name = reftable_realloc(r->ref_name, key.len + 1);
     -+	memcpy(r->ref_name, key.buf, key.len);
     -+	r->ref_name[key.len] = 0;
     ++	r->refname = reftable_realloc(r->refname, key.len + 1);
     ++	memcpy(r->refname, key.buf, key.len);
     ++	r->refname[key.len] = 0;
      +
      +	switch (val_type) {
      +	case 1:
     @@ reftable/record.c (new)
      +{
      +	char hex[SHA256_SIZE + 1] = { 0 };
      +
     -+	printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n", log->ref_name,
     ++	printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n", log->refname,
      +	       log->update_index, log->name, log->email, log->time,
      +	       log->tz_offset);
      +	hex_format(hex, log->old_hash, hash_size(hash_id));
     @@ reftable/record.c (new)
      +{
      +	const struct reftable_log_record *rec =
      +		(const struct reftable_log_record *)r;
     -+	int len = strlen(rec->ref_name);
     ++	int len = strlen(rec->refname);
      +	uint8_t i64[8];
      +	uint64_t ts = 0;
      +	strbuf_reset(dest);
     -+	strbuf_add(dest, (uint8_t *)rec->ref_name, len + 1);
     ++	strbuf_add(dest, (uint8_t *)rec->refname, len + 1);
      +
      +	ts = (~ts) - rec->update_index;
      +	put_be64(&i64[0], ts);
     @@ reftable/record.c (new)
      +
      +	reftable_log_record_clear(dst);
      +	*dst = *src;
     -+	if (dst->ref_name != NULL) {
     -+		dst->ref_name = xstrdup(dst->ref_name);
     ++	if (dst->refname != NULL) {
     ++		dst->refname = xstrdup(dst->refname);
      +	}
      +	if (dst->email != NULL) {
      +		dst->email = xstrdup(dst->email);
     @@ reftable/record.c (new)
      +
      +void reftable_log_record_clear(struct reftable_log_record *r)
      +{
     -+	reftable_free(r->ref_name);
     ++	reftable_free(r->refname);
      +	reftable_free(r->new_hash);
      +	reftable_free(r->old_hash);
      +	reftable_free(r->name);
     @@ reftable/record.c (new)
      +	if (key.len <= 9 || key.buf[key.len - 9] != 0)
      +		return REFTABLE_FORMAT_ERROR;
      +
     -+	r->ref_name = reftable_realloc(r->ref_name, key.len - 8);
     -+	memcpy(r->ref_name, key.buf, key.len - 8);
     ++	r->refname = reftable_realloc(r->refname, key.len - 8);
     ++	memcpy(r->refname, key.buf, key.len - 8);
      +	ts = get_be64(key.buf + key.len - 8);
      +
      +	r->update_index = (~max) - ts;
     @@ reftable/record.c (new)
      +			       struct reftable_ref_record *b, int hash_size)
      +{
      +	assert(hash_size > 0);
     -+	return 0 == strcmp(a->ref_name, b->ref_name) &&
     ++	return 0 == strcmp(a->refname, b->refname) &&
      +	       a->update_index == b->update_index &&
      +	       hash_equal(a->value, b->value, hash_size) &&
      +	       hash_equal(a->target_value, b->target_value, hash_size) &&
     @@ reftable/record.c (new)
      +
      +int reftable_ref_record_compare_name(const void *a, const void *b)
      +{
     -+	return strcmp(((struct reftable_ref_record *)a)->ref_name,
     -+		      ((struct reftable_ref_record *)b)->ref_name);
     ++	return strcmp(((struct reftable_ref_record *)a)->refname,
     ++		      ((struct reftable_ref_record *)b)->refname);
      +}
      +
      +bool reftable_ref_record_is_deletion(const struct reftable_ref_record *ref)
     @@ reftable/record.c (new)
      +	struct reftable_log_record *la = (struct reftable_log_record *)a;
      +	struct reftable_log_record *lb = (struct reftable_log_record *)b;
      +
     -+	int cmp = strcmp(la->ref_name, lb->ref_name);
     ++	int cmp = strcmp(la->refname, lb->refname);
      +	if (cmp)
      +		return cmp;
      +	if (la->update_index > lb->update_index)
     @@ reftable/record.h (new)
      +*/
      +struct string_view {
      +	uint8_t *buf;
     -+	int len;
     ++	size_t len;
      +};
      +
      +/* Advance `s.buf` by `n`, and decrease length. */
     @@ reftable/record_test.c (new)
      +	for (i = 0; i <= 3; i++) {
      +		struct reftable_ref_record in = { 0 };
      +		struct reftable_ref_record out = {
     -+			.ref_name = xstrdup("old name"),
     ++			.refname = xstrdup("old name"),
      +			.value = reftable_calloc(SHA1_SIZE),
      +			.target_value = reftable_calloc(SHA1_SIZE),
      +			.target = xstrdup("old value"),
     @@ reftable/record_test.c (new)
      +			in.target = xstrdup("target");
      +			break;
      +		}
     -+		in.ref_name = xstrdup("refs/heads/master");
     ++		in.refname = xstrdup("refs/heads/master");
      +
      +		reftable_record_from_ref(&rec, &in);
      +		test_copy(&rec);
     @@ reftable/record_test.c (new)
      +{
      +	struct reftable_log_record in[2] = {
      +		{
     -+			.ref_name = xstrdup("refs/heads/master"),
     ++			.refname = xstrdup("refs/heads/master"),
      +			.update_index = 42,
      +		},
      +		{
     -+			.ref_name = xstrdup("refs/heads/master"),
     ++			.refname = xstrdup("refs/heads/master"),
      +			.update_index = 22,
      +		}
      +	};
     @@ reftable/record_test.c (new)
      +{
      +	struct reftable_log_record in[2] = {
      +		{
     -+			.ref_name = xstrdup("refs/heads/master"),
     ++			.refname = xstrdup("refs/heads/master"),
      +			.old_hash = reftable_malloc(SHA1_SIZE),
      +			.new_hash = reftable_malloc(SHA1_SIZE),
      +			.name = xstrdup("han-wen"),
     @@ reftable/record_test.c (new)
      +			.tz_offset = 100,
      +		},
      +		{
     -+			.ref_name = xstrdup("refs/heads/master"),
     ++			.refname = xstrdup("refs/heads/master"),
      +			.update_index = 22,
      +		}
      +	};
     @@ reftable/record_test.c (new)
      +		};
      +		/* populate out, to check for leaks. */
      +		struct reftable_log_record out = {
     -+			.ref_name = xstrdup("old name"),
     ++			.refname = xstrdup("old name"),
      +			.new_hash = reftable_calloc(SHA1_SIZE),
      +			.old_hash = reftable_calloc(SHA1_SIZE),
      +			.name = xstrdup("old name"),
     @@ reftable/refname.c (new)
      +		if (mod->del_len > 0) {
      +			struct find_arg arg = {
      +				.names = mod->del,
     -+				.want = ref.ref_name,
     ++				.want = ref.refname,
      +			};
      +			int idx = binsearch(mod->del_len, find_name, &arg);
      +			if (idx < mod->del_len &&
     -+			    !strcmp(ref.ref_name, mod->del[idx])) {
     ++			    !strcmp(ref.refname, mod->del[idx])) {
      +				continue;
      +			}
      +		}
      +
     -+		if (strncmp(ref.ref_name, prefix, strlen(prefix))) {
     ++		if (strncmp(ref.refname, prefix, strlen(prefix))) {
      +			err = 1;
      +			goto done;
      +		}
     @@ reftable/refname.c (new)
      +	return err;
      +}
      +
     -+int validate_ref_name(const char *name)
     ++int validate_refname(const char *name)
      +{
      +	while (true) {
      +		char *next = strchr(name, '/');
     @@ reftable/refname.c (new)
      +	int err = 0;
      +	for (; i < sz; i++) {
      +		if (reftable_ref_record_is_deletion(&recs[i])) {
     -+			mod.del[mod.del_len++] = recs[i].ref_name;
     ++			mod.del[mod.del_len++] = recs[i].refname;
      +		} else {
     -+			mod.add[mod.add_len++] = recs[i].ref_name;
     ++			mod.add[mod.add_len++] = recs[i].refname;
      +		}
      +	}
      +
     @@ reftable/refname.c (new)
      +	int err = 0;
      +	int i = 0;
      +	for (; i < mod->add_len; i++) {
     -+		err = validate_ref_name(mod->add[i]);
     ++		err = validate_refname(mod->add[i]);
      +		if (err)
      +			goto done;
      +		strbuf_reset(&slashed);
     @@ reftable/refname.h (new)
      +				     const char *prefix);
      +
      +// 0 = OK.
     -+int validate_ref_name(const char *name);
     ++int validate_refname(const char *name);
      +
      +int validate_ref_record_addition(struct reftable_table tab,
      +				 struct reftable_ref_record *recs, size_t sz);
     @@ reftable/refname_test.c (new)
      +	struct reftable_writer *w =
      +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +	struct reftable_ref_record rec = {
     -+		.ref_name = "a/b",
     ++		.refname = "a/b",
      +		.target = "destination", /* make sure it's not a symref. */
      +		.update_index = 1,
      +	};
     @@ reftable/reftable.c (new)
      +#include "merged.h"
      +
      +struct reftable_table_vtable {
     -+	int (*seek)(void *tab, struct reftable_iterator *it,
     -+		    struct reftable_record *);
     ++	int (*seek_record)(void *tab, struct reftable_iterator *it,
     ++			   struct reftable_record *);
     ++	uint32_t (*hash_id)(void *tab);
     ++	uint64_t (*min_update_index)(void *tab);
     ++	uint64_t (*max_update_index)(void *tab);
      +};
      +
      +static int reftable_reader_seek_void(void *tab, struct reftable_iterator *it,
     @@ reftable/reftable.c (new)
      +	return reader_seek((struct reftable_reader *)tab, it, rec);
      +}
      +
     ++static uint32_t reftable_reader_hash_id_void(void *tab)
     ++{
     ++	return reftable_reader_hash_id((struct reftable_reader *)tab);
     ++}
     ++
     ++static uint64_t reftable_reader_min_update_index_void(void *tab)
     ++{
     ++	return reftable_reader_min_update_index((struct reftable_reader *)tab);
     ++}
     ++
     ++static uint64_t reftable_reader_max_update_index_void(void *tab)
     ++{
     ++	return reftable_reader_max_update_index((struct reftable_reader *)tab);
     ++}
     ++
      +static struct reftable_table_vtable reader_vtable = {
     -+	.seek = reftable_reader_seek_void,
     ++	.seek_record = reftable_reader_seek_void,
     ++	.hash_id = reftable_reader_hash_id_void,
     ++	.min_update_index = reftable_reader_min_update_index_void,
     ++	.max_update_index = reftable_reader_max_update_index_void,
      +};
      +
      +static int reftable_merged_table_seek_void(void *tab,
     @@ reftable/reftable.c (new)
      +					rec);
      +}
      +
     ++static uint32_t reftable_merged_table_hash_id_void(void *tab)
     ++{
     ++	return reftable_merged_table_hash_id(
     ++		(struct reftable_merged_table *)tab);
     ++}
     ++
     ++static uint64_t reftable_merged_table_min_update_index_void(void *tab)
     ++{
     ++	return reftable_merged_table_min_update_index(
     ++		(struct reftable_merged_table *)tab);
     ++}
     ++
     ++static uint64_t reftable_merged_table_max_update_index_void(void *tab)
     ++{
     ++	return reftable_merged_table_max_update_index(
     ++		(struct reftable_merged_table *)tab);
     ++}
     ++
      +static struct reftable_table_vtable merged_table_vtable = {
     -+	.seek = reftable_merged_table_seek_void,
     ++	.seek_record = reftable_merged_table_seek_void,
     ++	.hash_id = reftable_merged_table_hash_id_void,
     ++	.min_update_index = reftable_merged_table_min_update_index_void,
     ++	.max_update_index = reftable_merged_table_max_update_index_void,
      +};
      +
      +int reftable_table_seek_ref(struct reftable_table *tab,
      +			    struct reftable_iterator *it, const char *name)
      +{
      +	struct reftable_ref_record ref = {
     -+		.ref_name = (char *)name,
     ++		.refname = (char *)name,
      +	};
      +	struct reftable_record rec = { 0 };
      +	reftable_record_from_ref(&rec, &ref);
     -+	return tab->ops->seek(tab->table_arg, it, &rec);
     ++	return tab->ops->seek_record(tab->table_arg, it, &rec);
      +}
      +
      +void reftable_table_from_reader(struct reftable_table *tab,
     @@ reftable/reftable.c (new)
      +	if (err)
      +		goto done;
      +
     -+	if (strcmp(ref->ref_name, name) ||
     ++	if (strcmp(ref->refname, name) ||
      +	    reftable_ref_record_is_deletion(ref)) {
      +		reftable_ref_record_clear(ref);
      +		err = 1;
     @@ reftable/reftable.c (new)
      +done:
      +	reftable_iterator_destroy(&it);
      +	return err;
     ++}
     ++
     ++int reftable_table_seek_record(struct reftable_table *tab,
     ++			       struct reftable_iterator *it,
     ++			       struct reftable_record *rec)
     ++{
     ++	return tab->ops->seek_record(tab->table_arg, it, rec);
     ++}
     ++
     ++uint64_t reftable_table_max_update_index(struct reftable_table *tab)
     ++{
     ++	return tab->ops->max_update_index(tab->table_arg);
     ++}
     ++
     ++uint64_t reftable_table_min_update_index(struct reftable_table *tab)
     ++{
     ++	return tab->ops->min_update_index(tab->table_arg);
     ++}
     ++
     ++uint32_t reftable_table_hash_id(struct reftable_table *tab)
     ++{
     ++	return tab->ops->hash_id(tab->table_arg);
      +}
      
       ## reftable/reftable.h (new) ##
     @@ reftable/reftable.h (new)
      +
      +/* reftable_ref_record holds a ref database entry target_value */
      +struct reftable_ref_record {
     -+	char *ref_name; /* Name of the ref, malloced. */
     ++	char *refname; /* Name of the ref, malloced. */
      +	uint64_t update_index; /* Logical timestamp at which this value is
      +				  written */
      +	uint8_t *value; /* SHA1, or NULL. malloced. */
     @@ reftable/reftable.h (new)
      +
      +/* reftable_log_record holds a reflog entry */
      +struct reftable_log_record {
     -+	char *ref_name;
     ++	char *refname;
      +	uint64_t update_index; /* logical timestamp of a transactional update.
      +				*/
      +	uint8_t *new_hash;
     @@ reftable/reftable.h (new)
      +	REFTABLE_LOCK_ERROR = -5,
      +
      +	/* Misuse of the API:
     -+	   - on writing a record with NULL ref_name.
     ++	   - on writing a record with NULL refname.
      +	   - on writing a reftable_ref_record outside the table limits
      +	   - on writing a ref or log record before the stack's next_update_index
      +	   - on writing a log record with multiline message with
     @@ reftable/reftable.h (new)
      +/* A merged table is implements seeking/iterating over a stack of tables. */
      +struct reftable_merged_table;
      +
     ++/* A generic reftable; see below. */
     ++struct reftable_table;
     ++
      +/* reftable_new_merged_table creates a new merged table. It takes ownership of
      +   the stack array.
      +*/
      +int reftable_new_merged_table(struct reftable_merged_table **dest,
     -+			      struct reftable_reader **stack, int n,
     ++			      struct reftable_table *stack, int n,
      +			      uint32_t hash_id);
      +
      +/* returns an iterator positioned just before 'name' */
     @@ reftable/reftable.h (new)
      +uint64_t
      +reftable_merged_table_min_update_index(struct reftable_merged_table *mt);
      +
     -+/* closes readers for the merged tables */
     -+void reftable_merged_table_close(struct reftable_merged_table *mt);
     -+
      +/* releases memory for the merged_table */
      +void reftable_merged_table_free(struct reftable_merged_table *m);
      +
     ++/* return the hash ID of the merged table. */
     ++uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *m);
     ++
      +/****************************************************************
      + Generic tables
      +
     @@ reftable/reftable.h (new)
      +
      +void reftable_table_from_reader(struct reftable_table *tab,
      +				struct reftable_reader *reader);
     ++
     ++/* returns the hash ID from a generic reftable_table */
     ++uint32_t reftable_table_hash_id(struct reftable_table *tab);
     ++
     ++/* create a generic table from reftable_merged_table */
      +void reftable_table_from_merged_table(struct reftable_table *tab,
      +				      struct reftable_merged_table *table);
      +
     ++/* returns the max update_index covered by this table. */
     ++uint64_t reftable_table_max_update_index(struct reftable_table *tab);
     ++
     ++/* returns the min update_index covered by this table. */
     ++uint64_t reftable_table_min_update_index(struct reftable_table *tab);
     ++
      +/* convenience function to read a single ref. Returns < 0 for error, 0
      +   for success, and 1 if ref not found. */
      +int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     @@ reftable/reftable_test.c (new)
      +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +
      +	struct reftable_ref_record rec = {
     -+		.ref_name = "master",
     ++		.refname = "master",
      +		.update_index = 1,
      +	};
      +	int err;
      +	struct reftable_block_source source = { 0 };
     -+	struct reftable_reader **readers = malloc(sizeof(*readers) * 1);
     ++	struct reftable_reader **readers =
     ++		reftable_calloc(sizeof(*readers) * 1);
     ++	struct reftable_table *tab = reftable_calloc(sizeof(*tab) * 1);
      +	uint32_t hash_id;
      +	struct reftable_reader *rd = NULL;
      +	struct reftable_merged_table *merged = NULL;
     @@ reftable/reftable_test.c (new)
      +	hash_id = reftable_reader_hash_id(rd);
      +	assert(hash_id == SHA1_ID);
      +
     -+	readers[0] = rd;
     -+
     -+	err = reftable_new_merged_table(&merged, readers, 1, SHA1_ID);
     ++	reftable_table_from_reader(&tab[0], rd);
     ++	err = reftable_new_merged_table(&merged, tab, 1, SHA1_ID);
      +	assert_err(err);
      +
     -+	reftable_merged_table_close(merged);
     ++	reader_close(rd);
      +	reftable_merged_table_free(merged);
      +	strbuf_release(&buf);
      +}
     @@ reftable/reftable_test.c (new)
      +
      +		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
      +
     -+		ref.ref_name = name;
     ++		ref.refname = name;
      +		ref.value = hash;
      +		ref.update_index = update_index;
      +		(*names)[i] = xstrdup(name);
     @@ reftable/reftable_test.c (new)
      +
      +		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
      +
     -+		log.ref_name = name;
     ++		log.refname = name;
      +		log.new_hash = hash;
      +		log.update_index = update_index;
      +		log.message = "message";
     @@ reftable/reftable_test.c (new)
      +	};
      +	int err;
      +	struct reftable_log_record log = {
     -+		.ref_name = "refs/heads/master",
     ++		.refname = "refs/heads/master",
      +		.name = "Han-Wen Nienhuys",
      +		.email = "hanwen@google.com",
      +		.tz_offset = 100,
     @@ reftable/reftable_test.c (new)
      +		snprintf(name, sizeof(name), "b%02d%0*d", i, 130, 7);
      +		names[i] = xstrdup(name);
      +		puts(name);
     -+		ref.ref_name = name;
     ++		ref.refname = name;
      +		ref.update_index = i;
      +
      +		err = reftable_writer_add_ref(w, &ref);
     @@ reftable/reftable_test.c (new)
      +		set_test_hash(hash1, i);
      +		set_test_hash(hash2, i + 1);
      +
     -+		log.ref_name = names[i];
     ++		log.refname = names[i];
      +		log.update_index = i;
      +		log.old_hash = hash1;
      +		log.new_hash = hash2;
     @@ reftable/reftable_test.c (new)
      +		}
      +
      +		assert_err(err);
     -+		assert_streq(names[i], log.ref_name);
     ++		assert_streq(names[i], log.refname);
      +		assert(i == log.update_index);
      +		i++;
      +		reftable_log_record_clear(&log);
     @@ reftable/reftable_test.c (new)
      +		if (r > 0) {
      +			break;
      +		}
     -+		assert(0 == strcmp(names[j], ref.ref_name));
     ++		assert(0 == strcmp(names[j], ref.refname));
      +		assert(update_index == ref.update_index);
      +
      +		j++;
     @@ reftable/reftable_test.c (new)
      +		assert_err(err);
      +		err = reftable_iterator_next_ref(&it, &ref);
      +		assert_err(err);
     -+		assert(0 == strcmp(names[i], ref.ref_name));
     ++		assert(0 == strcmp(names[i], ref.refname));
      +		assert(i == ref.value[0]);
      +
      +		reftable_ref_record_clear(&ref);
     @@ reftable/reftable_test.c (new)
      +		/* Put the variable part in the start */
      +		snprintf(name, sizeof(name), "br%02d%s", i, fill);
      +		name[40] = 0;
     -+		ref.ref_name = name;
     ++		ref.refname = name;
      +
      +		set_test_hash(hash1, i / 4);
      +		set_test_hash(hash2, 3 + i / 4);
     @@ reftable/reftable_test.c (new)
      +		}
      +
      +		assert(j < want_names_len);
     -+		assert(0 == strcmp(ref.ref_name, want_names[j]));
     ++		assert(0 == strcmp(ref.refname, want_names[j]));
      +		j++;
      +		reftable_ref_record_clear(&ref);
      +	}
     @@ reftable/stack.c (new)
      +void reftable_stack_destroy(struct reftable_stack *st)
      +{
      +	if (st->merged != NULL) {
     -+		reftable_merged_table_close(st->merged);
      +		reftable_merged_table_free(st->merged);
      +		st->merged = NULL;
      +	}
     ++
     ++	if (st->readers != NULL) {
     ++		int i = 0;
     ++		for (i = 0; i < st->readers_len; i++) {
     ++			reftable_reader_free(st->readers[i]);
     ++		}
     ++		st->readers_len = 0;
     ++		FREE_AND_NULL(st->readers);
     ++	}
      +	FREE_AND_NULL(st->list_file);
      +	FREE_AND_NULL(st->reftable_dir);
      +	reftable_free(st);
     @@ reftable/stack.c (new)
      +		reftable_calloc(sizeof(struct reftable_reader *) * cur_len);
      +	int i = 0;
      +	for (i = 0; i < cur_len; i++) {
     -+		cur[i] = st->merged->stack[i];
     ++		cur[i] = st->readers[i];
      +	}
      +	return cur;
      +}
     @@ reftable/stack.c (new)
      +	struct reftable_reader **cur = stack_copy_readers(st, cur_len);
      +	int err = 0;
      +	int names_len = names_length(names);
     -+	struct reftable_reader **new_tables =
     -+		reftable_malloc(sizeof(struct reftable_reader *) * names_len);
     -+	int new_tables_len = 0;
     ++	struct reftable_reader **new_readers =
     ++		reftable_calloc(sizeof(struct reftable_reader *) * names_len);
     ++	struct reftable_table *new_tables =
     ++		reftable_calloc(sizeof(struct reftable_table) * names_len);
     ++	int new_readers_len = 0;
      +	struct reftable_merged_table *new_merged = NULL;
      +	int i;
      +
     @@ reftable/stack.c (new)
      +				goto done;
      +		}
      +
     -+		new_tables[new_tables_len++] = rd;
     ++		new_readers[new_readers_len] = rd;
     ++		reftable_table_from_reader(&new_tables[new_readers_len], rd);
     ++		new_readers_len++;
      +	}
      +
      +	/* success! */
     -+	err = reftable_new_merged_table(&new_merged, new_tables, new_tables_len,
     -+					st->config.hash_id);
     ++	err = reftable_new_merged_table(&new_merged, new_tables,
     ++					new_readers_len, st->config.hash_id);
      +	if (err < 0)
      +		goto done;
      +
      +	new_tables = NULL;
     -+	new_tables_len = 0;
     ++	st->readers_len = new_readers_len;
      +	if (st->merged != NULL) {
      +		merged_table_clear(st->merged);
      +		reftable_merged_table_free(st->merged);
      +	}
     ++	if (st->readers != NULL) {
     ++		reftable_free(st->readers);
     ++	}
     ++	st->readers = new_readers;
     ++	new_readers = NULL;
     ++	new_readers_len = 0;
     ++
      +	new_merged->suppress_deletions = true;
      +	st->merged = new_merged;
     -+
      +	for (i = 0; i < cur_len; i++) {
      +		if (cur[i] != NULL) {
      +			reader_close(cur[i]);
     @@ reftable/stack.c (new)
      +	}
      +
      +done:
     -+	for (i = 0; i < new_tables_len; i++) {
     -+		reader_close(new_tables[i]);
     -+		reftable_reader_free(new_tables[i]);
     ++	for (i = 0; i < new_readers_len; i++) {
     ++		reader_close(new_readers[i]);
     ++		reftable_reader_free(new_readers[i]);
      +	}
     ++	reftable_free(new_readers);
      +	reftable_free(new_tables);
      +	reftable_free(cur);
      +	return err;
     @@ reftable/stack.c (new)
      +	if (err < 0)
      +		return err;
      +
     -+	for (i = 0; i < st->merged->stack_len; i++) {
     ++	for (i = 0; i < st->readers_len; i++) {
      +		if (names[i] == NULL) {
      +			err = 1;
      +			goto done;
      +		}
      +
     -+		if (strcmp(st->merged->stack[i]->name, names[i])) {
     ++		if (strcmp(st->readers[i]->name, names[i])) {
      +			err = 1;
      +			goto done;
      +		}
     @@ reftable/stack.c (new)
      +		goto done;
      +
      +	for (i = 0; i < add->stack->merged->stack_len; i++) {
     -+		strbuf_addstr(&table_list, add->stack->merged->stack[i]->name);
     ++		strbuf_addstr(&table_list, add->stack->readers[i]->name);
      +		strbuf_addstr(&table_list, "\n");
      +	}
      +	for (i = 0; i < add->new_tables_len; i++) {
     @@ reftable/stack.c (new)
      +{
      +	int sz = st->merged->stack_len;
      +	if (sz > 0)
     -+		return reftable_reader_max_update_index(
     -+			       st->merged->stack[sz - 1]) +
     ++		return reftable_reader_max_update_index(st->readers[sz - 1]) +
      +		       1;
      +	return 1;
      +}
     @@ reftable/stack.c (new)
      +	int err = 0;
      +
      +	format_name(&next_name,
     -+		    reftable_reader_min_update_index(st->merged->stack[first]),
     -+		    reftable_reader_max_update_index(st->merged->stack[first]));
     ++		    reftable_reader_min_update_index(st->readers[first]),
     ++		    reftable_reader_max_update_index(st->readers[first]));
      +
      +	strbuf_reset(temp_tab);
      +	strbuf_addstr(temp_tab, st->reftable_dir);
     @@ reftable/stack.c (new)
      +			struct reftable_log_expiry_config *config)
      +{
      +	int subtabs_len = last - first + 1;
     -+	struct reftable_reader **subtabs = reftable_calloc(
     -+		sizeof(struct reftable_reader *) * (last - first + 1));
     ++	struct reftable_table *subtabs = reftable_calloc(
     ++		sizeof(struct reftable_table) * (last - first + 1));
      +	struct reftable_merged_table *mt = NULL;
      +	int err = 0;
      +	struct reftable_iterator it = { 0 };
     @@ reftable/stack.c (new)
      +
      +	int i = 0, j = 0;
      +	for (i = first, j = 0; i <= last; i++) {
     -+		struct reftable_reader *t = st->merged->stack[i];
     -+		subtabs[j++] = t;
     ++		struct reftable_reader *t = st->readers[i];
     ++		reftable_table_from_reader(&subtabs[j++], t);
      +		st->stats.bytes += t->size;
      +	}
     -+	reftable_writer_set_limits(wr,
     -+				   st->merged->stack[first]->min_update_index,
     -+				   st->merged->stack[last]->max_update_index);
     ++	reftable_writer_set_limits(wr, st->readers[first]->min_update_index,
     ++				   st->readers[last]->max_update_index);
      +
      +	err = reftable_new_merged_table(&mt, subtabs, subtabs_len,
      +					st->config.hash_id);
     @@ reftable/stack.c (new)
      +
      +		strbuf_addstr(&subtab_file_name, st->reftable_dir);
      +		strbuf_addstr(&subtab_file_name, "/");
     -+		strbuf_addstr(&subtab_file_name,
     -+			      reader_name(st->merged->stack[i]));
     ++		strbuf_addstr(&subtab_file_name, reader_name(st->readers[i]));
      +
      +		strbuf_reset(&subtab_lock);
      +		strbuf_addbuf(&subtab_lock, &subtab_file_name);
     @@ reftable/stack.c (new)
      +	}
      +	have_lock = true;
      +
     -+	format_name(&new_table_name, st->merged->stack[first]->min_update_index,
     -+		    st->merged->stack[last]->max_update_index);
     ++	format_name(&new_table_name, st->readers[first]->min_update_index,
     ++		    st->readers[last]->max_update_index);
      +	strbuf_addstr(&new_table_name, ".ref");
      +
      +	strbuf_reset(&new_table_path);
     @@ reftable/stack.c (new)
      +	}
      +
      +	for (i = 0; i < first; i++) {
     -+		strbuf_addstr(&ref_list_contents, st->merged->stack[i]->name);
     ++		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
      +		strbuf_addstr(&ref_list_contents, "\n");
      +	}
      +	if (!is_empty_table) {
     @@ reftable/stack.c (new)
      +		strbuf_addstr(&ref_list_contents, "\n");
      +	}
      +	for (i = last + 1; i < st->merged->stack_len; i++) {
     -+		strbuf_addstr(&ref_list_contents, st->merged->stack[i]->name);
     ++		strbuf_addstr(&ref_list_contents, st->readers[i]->name);
      +		strbuf_addstr(&ref_list_contents, "\n");
      +	}
      +
     @@ reftable/stack.c (new)
      +	int overhead = header_size(version) - 1;
      +	int i = 0;
      +	for (i = 0; i < st->merged->stack_len; i++) {
     -+		sizes[i] = st->merged->stack[i]->size - overhead;
     ++		sizes[i] = st->readers[i]->size - overhead;
      +	}
      +	return sizes;
      +}
     @@ reftable/stack.c (new)
      +	if (err)
      +		goto done;
      +
     -+	if (strcmp(log->ref_name, refname) ||
     ++	if (strcmp(log->refname, refname) ||
      +	    reftable_log_record_is_deletion(log)) {
      +		err = 1;
      +		goto done;
     @@ reftable/stack.h (new)
      +
      +	struct reftable_write_options config;
      +
     ++	struct reftable_reader **readers;
     ++	size_t readers_len;
      +	struct reftable_merged_table *merged;
      +	struct reftable_compaction_stats stats;
      +};
     @@ reftable/stack_test.c (new)
      +	struct reftable_stack *st = NULL;
      +	int err;
      +	struct reftable_ref_record ref = {
     -+		.ref_name = "HEAD",
     ++		.refname = "HEAD",
      +		.update_index = 1,
      +		.target = "master",
      +	};
     @@ reftable/stack_test.c (new)
      +	err = reftable_stack_add(st, &write_test_ref, &ref);
      +	assert_err(err);
      +
     -+	err = reftable_stack_read_ref(st, ref.ref_name, &dest);
     ++	err = reftable_stack_read_ref(st, ref.refname, &dest);
      +	assert_err(err);
      +	assert(0 == strcmp("master", dest.target));
      +
     @@ reftable/stack_test.c (new)
      +	char dir[256] = "/tmp/stack_test.XXXXXX";
      +	int err;
      +	struct reftable_ref_record ref1 = {
     -+		.ref_name = "HEAD",
     ++		.refname = "HEAD",
      +		.update_index = 1,
      +		.target = "master",
      +	};
      +	struct reftable_ref_record ref2 = {
     -+		.ref_name = "branch2",
     ++		.refname = "branch2",
      +		.update_index = 2,
      +		.target = "master",
      +	};
     @@ reftable/stack_test.c (new)
      +	struct reftable_addition *add = NULL;
      +
      +	struct reftable_ref_record ref = {
     -+		.ref_name = "HEAD",
     ++		.refname = "HEAD",
      +		.update_index = 1,
      +		.target = "master",
      +	};
     @@ reftable/stack_test.c (new)
      +
      +	reftable_addition_destroy(add);
      +
     -+	err = reftable_stack_read_ref(st, ref.ref_name, &dest);
     ++	err = reftable_stack_read_ref(st, ref.refname, &dest);
      +	assert_err(err);
      +	assert(0 == strcmp("master", dest.target));
      +
     @@ reftable/stack_test.c (new)
      +	char dir[256] = "/tmp/stack_test.XXXXXX";
      +	int i;
      +	struct reftable_ref_record ref = {
     -+		.ref_name = "a/b",
     ++		.refname = "a/b",
      +		.update_index = 1,
      +		.target = "master",
      +	};
     @@ reftable/stack_test.c (new)
      +
      +	for (i = 0; i < ARRAY_SIZE(additions); i++) {
      +		struct reftable_ref_record ref = {
     -+			.ref_name = additions[i],
     ++			.refname = additions[i],
      +			.update_index = 1,
      +			.target = "master",
      +		};
     @@ reftable/stack_test.c (new)
      +	struct reftable_stack *st = NULL;
      +	int err;
      +	struct reftable_ref_record ref1 = {
     -+		.ref_name = "name1",
     ++		.refname = "name1",
      +		.update_index = 1,
      +		.target = "master",
      +	};
      +	struct reftable_ref_record ref2 = {
     -+		.ref_name = "name2",
     ++		.refname = "name2",
      +		.update_index = 1,
      +		.target = "master",
      +	};
     @@ reftable/stack_test.c (new)
      +	for (i = 0; i < N; i++) {
      +		char buf[256];
      +		snprintf(buf, sizeof(buf), "branch%02d", i);
     -+		refs[i].ref_name = xstrdup(buf);
     ++		refs[i].refname = xstrdup(buf);
      +		refs[i].value = reftable_malloc(SHA1_SIZE);
      +		refs[i].update_index = i + 1;
      +		set_test_hash(refs[i].value, i);
      +
     -+		logs[i].ref_name = xstrdup(buf);
     ++		logs[i].refname = xstrdup(buf);
      +		logs[i].update_index = N + i + 1;
      +		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
      +		logs[i].email = xstrdup("identity@invalid");
     @@ reftable/stack_test.c (new)
      +
      +	for (i = 0; i < N; i++) {
      +		struct reftable_ref_record dest = { 0 };
     -+		int err = reftable_stack_read_ref(st, refs[i].ref_name, &dest);
     ++		int err = reftable_stack_read_ref(st, refs[i].refname, &dest);
      +		assert_err(err);
      +		assert(reftable_ref_record_equal(&dest, refs + i, SHA1_SIZE));
      +		reftable_ref_record_clear(&dest);
     @@ reftable/stack_test.c (new)
      +
      +	for (i = 0; i < N; i++) {
      +		struct reftable_log_record dest = { 0 };
     -+		int err = reftable_stack_read_log(st, refs[i].ref_name, &dest);
     ++		int err = reftable_stack_read_log(st, refs[i].refname, &dest);
      +		assert_err(err);
      +		assert(reftable_log_record_equal(&dest, logs + i, SHA1_SIZE));
      +		reftable_log_record_clear(&dest);
     @@ reftable/stack_test.c (new)
      +	uint8_t h1[SHA1_SIZE] = { 0x01 }, h2[SHA1_SIZE] = { 0x02 };
      +
      +	struct reftable_log_record input = {
     -+		.ref_name = "branch",
     ++		.refname = "branch",
      +		.update_index = 1,
      +		.new_hash = h1,
      +		.old_hash = h2,
     @@ reftable/stack_test.c (new)
      +	err = reftable_stack_add(st, &write_test_log, &arg);
      +	assert_err(err);
      +
     -+	err = reftable_stack_read_log(st, input.ref_name, &dest);
     ++	err = reftable_stack_read_log(st, input.refname, &dest);
      +	assert_err(err);
      +	assert(0 == strcmp(dest.message, "one\n"));
      +
     @@ reftable/stack_test.c (new)
      +	arg.update_index = 2;
      +	err = reftable_stack_add(st, &write_test_log, &arg);
      +	assert_err(err);
     -+	err = reftable_stack_read_log(st, input.ref_name, &dest);
     ++	err = reftable_stack_read_log(st, input.refname, &dest);
      +	assert_err(err);
      +	assert(0 == strcmp(dest.message, "two\n"));
      +
     @@ reftable/stack_test.c (new)
      +
      +	for (i = 0; i < N; i++) {
      +		const char *buf = "branch";
     -+		refs[i].ref_name = xstrdup(buf);
     ++		refs[i].refname = xstrdup(buf);
      +		refs[i].update_index = i + 1;
      +		if (i % 2 == 0) {
      +			refs[i].value = reftable_malloc(SHA1_SIZE);
      +			set_test_hash(refs[i].value, i);
      +		}
     -+		logs[i].ref_name = xstrdup(buf);
     ++		logs[i].refname = xstrdup(buf);
      +		/* update_index is part of the key. */
      +		logs[i].update_index = 42;
      +		if (i % 2 == 0) {
     @@ reftable/stack_test.c (new)
      +	int err;
      +
      +	struct reftable_ref_record ref = {
     -+		.ref_name = "master",
     ++		.refname = "master",
      +		.target = "target",
      +		.update_index = 1,
      +	};
     @@ reftable/stack_test.c (new)
      +		char buf[256];
      +		snprintf(buf, sizeof(buf), "branch%02d", i);
      +
     -+		logs[i].ref_name = xstrdup(buf);
     ++		logs[i].refname = xstrdup(buf);
      +		logs[i].update_index = i;
      +		logs[i].time = i;
      +		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
     @@ reftable/stack_test.c (new)
      +	err = reftable_stack_compact_all(st, &expiry);
      +	assert_err(err);
      +
     -+	err = reftable_stack_read_log(st, logs[9].ref_name, &log);
     ++	err = reftable_stack_read_log(st, logs[9].refname, &log);
      +	assert(err == 1);
      +
     -+	err = reftable_stack_read_log(st, logs[11].ref_name, &log);
     ++	err = reftable_stack_read_log(st, logs[11].refname, &log);
      +	assert_err(err);
      +
      +	expiry.min_update_index = 15;
      +	err = reftable_stack_compact_all(st, &expiry);
      +	assert_err(err);
      +
     -+	err = reftable_stack_read_log(st, logs[14].ref_name, &log);
     ++	err = reftable_stack_read_log(st, logs[14].refname, &log);
      +	assert(err == 1);
      +
     -+	err = reftable_stack_read_log(st, logs[16].ref_name, &log);
     ++	err = reftable_stack_read_log(st, logs[16].refname, &log);
      +	assert_err(err);
      +
      +	/* cleanup */
     @@ reftable/stack_test.c (new)
      +	for (i = 0; i < N; i++) {
      +		char name[100];
      +		struct reftable_ref_record ref = {
     -+			.ref_name = name,
     ++			.refname = name,
      +			.update_index = reftable_stack_next_update_index(st),
      +			.target = "master",
      +		};
     @@ reftable/strbuf.h (new)
      +  x = STRBUF_INIT;"
      + */
      +struct strbuf {
     -+	int len;
     -+	int cap;
     ++	size_t len;
     ++	size_t cap;
      +	char *buf;
      +
      +	/* Used to enforce initialization with STRBUF_INIT */
     @@ reftable/writer.c (new)
      +struct obj_index_tree_node {
      +	struct strbuf hash;
      +	uint64_t *offsets;
     -+	int offset_len;
     -+	int offset_cap;
     ++	size_t offset_len;
     ++	size_t offset_cap;
      +};
     ++
      +#define OBJ_INDEX_TREE_NODE_INIT    \
      +	{                           \
      +		.hash = STRBUF_INIT \
     @@ reftable/writer.c (new)
      +	struct reftable_ref_record copy = *ref;
      +	int err = 0;
      +
     -+	if (ref->ref_name == NULL)
     ++	if (ref->refname == NULL)
      +		return REFTABLE_API_ERROR;
      +	if (ref->update_index < w->min_update_index ||
      +	    ref->update_index > w->max_update_index)
     @@ reftable/writer.c (new)
      +	char *input_log_message = log->message;
      +	struct strbuf cleaned_message = STRBUF_INIT;
      +	int err;
     -+	if (log->ref_name == NULL)
     ++	if (log->refname == NULL)
      +		return REFTABLE_API_ERROR;
      +
      +	if (w->block_writer != NULL &&
     @@ reftable/writer.h (new)
      +
      +	/* pending index records for the current section */
      +	struct reftable_index_record *index;
     -+	int index_len;
     -+	int index_cap;
     ++	size_t index_len;
     ++	size_t index_cap;
      +
      +	/*
      +	  tree for use with tsearch; used to populate the 'o' inverse OID
 12:  c92b8d12ec = 13:  d155240b16 Add standalone build infrastructure for reftable
 13:  479fe884e9 ! 14:  073bff7279 Reftable support for git-core
     @@ Commit message
      
          For background, see the previous commit introducing the library.
      
     -    This introduces the refs/reftable-backend.c containing reftable powered ref
     -    storage backend.
     +    This introduces the file refs/reftable-backend.c containing a reftable-powered
     +    ref storage backend.
      
     -    It can be activated by passing --ref-storage=reftable to "git init".
     +    It can be activated by passing --ref-storage=reftable to "git init", or setting
     +    GIT_TEST_REFTABLE in the environment.
      
          Example use: see t/t0031-reftable.sh
      
     @@ Makefile: cocciclean:
      
       ## builtin/clone.c ##
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     - 		}
       	}
       
     --	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, INIT_DB_QUIET);
     -+	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN,
     + 	init_db(git_dir, real_git_dir, option_template, GIT_HASH_UNKNOWN, NULL,
     +-		INIT_DB_QUIET);
      +		default_ref_storage(), INIT_DB_QUIET);
       
       	if (real_git_dir)
       		git_dir = real_git_dir;
     +@@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     + 		 * Now that we know what algorithm the remote side is using,
     + 		 * let's set ours to the same thing.
     + 		 */
     +-		initialize_repository_version(hash_algo);
     ++		initialize_repository_version(hash_algo, default_ref_storage());
     + 		repo_set_hash_algo(the_repository, hash_algo);
     + 
     + 		mapped_refs = wanted_peer_refs(refs, &remote->fetch);
      
       ## builtin/init-db.c ##
      @@ builtin/init-db.c: static int needs_work_tree_config(const char *git_dir, const char *work_tree)
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	 * We need to create a "refs" dir in any case so that older
       	 * versions of git can tell that this is a repository.
      @@ builtin/init-db.c: static int create_default_files(const char *template_path,
     - 	 * Create the default symlink from ".git/HEAD" to the "master"
     - 	 * branch, if it does not exist yet.
     + 	 * Point the HEAD symref to the initial branch with if HEAD does
     + 	 * not yet exist.
       	 */
      -	path = git_path_buf(&buf, "HEAD");
      -	reinit = (!access(path, R_OK)
      -		  || readlink(path, junk, sizeof(junk)-1) != -1);
       	if (!reinit) {
     - 		if (create_symref("HEAD", "refs/heads/master", NULL) < 0)
     - 			exit(1);
     + 		char *ref;
     + 
     +@@ builtin/init-db.c: static int create_default_files(const char *template_path,
     + 		free(ref);
       	}
       
      -	initialize_repository_version(fmt->hash_algo);
     @@ builtin/init-db.c: static int create_default_files(const char *template_path,
       	/* Check filemode trustability */
       	path = git_path_buf(&buf, "config");
      @@ builtin/init-db.c: static void validate_hash_algorithm(struct repository_format *repo_fmt, int hash
     - }
       
       int init_db(const char *git_dir, const char *real_git_dir,
     --	    const char *template_dir, int hash, unsigned int flags)
     -+	    const char *template_dir, int hash, const char *ref_storage_format,
     -+	    unsigned int flags)
     + 	    const char *template_dir, int hash, const char *initial_branch,
     +-	    unsigned int flags)
     ++	    const char *ref_storage_format, unsigned int flags)
       {
       	int reinit;
       	int exist_ok = flags & INIT_DB_EXIST_OK;
     @@ builtin/init-db.c: static const char *const init_db_usage[] = {
       	const char *work_tree;
       	const char *template_dir = NULL;
      @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *prefix)
     - 	const char *object_format = NULL;
     + 	const char *initial_branch = NULL;
       	int hash_algo = GIT_HASH_UNKNOWN;
       	const struct option init_db_options[] = {
      -		OPT_STRING(0, "template", &template_dir, N_("template-directory"),
     @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
      +			   N_("the ref storage format to use")),
       		OPT_STRING(0, "separate-git-dir", &real_git_dir, N_("gitdir"),
       			   N_("separate git dir from working tree")),
     - 		OPT_STRING(0, "object-format", &object_format, N_("hash"),
     + 		OPT_STRING('b', "initial-branch", &initial_branch, N_("name"),
      @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *prefix)
       	}
       
     @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
       	UNLEAK(work_tree);
       
       	flags |= INIT_DB_EXIST_OK;
     --	return init_db(git_dir, real_git_dir, template_dir, hash_algo, flags);
     -+	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
     -+		       ref_storage_format, flags);
     + 	return init_db(git_dir, real_git_dir, template_dir, hash_algo,
     +-		       initial_branch, flags);
     ++		       initial_branch, ref_storage_format, flags);
       }
      
     + ## builtin/worktree.c ##
     +@@
     + #include "submodule.h"
     + #include "utf8.h"
     + #include "worktree.h"
     ++#include "../refs/refs-internal.h"
     + 
     + static const char * const worktree_usage[] = {
     + 	N_("git worktree add [<options>] <path> [<commit-ish>]"),
     +@@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
     + 	 * worktree.
     + 	 */
     + 	strbuf_reset(&sb);
     +-	strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
     +-	write_file(sb.buf, "%s", oid_to_hex(&null_oid));
     +-	strbuf_reset(&sb);
     ++	if (get_main_ref_store(the_repository)->be == &refs_be_reftable) {
     ++		/* XXX this is cut & paste from reftable_init_db. */
     ++		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
     ++		write_file(sb.buf, "%s", "ref: refs/heads/.invalid\n");
     ++		strbuf_reset(&sb);
     ++
     ++		strbuf_addf(&sb, "%s/refs", sb_repo.buf);
     ++		safe_create_dir(sb.buf, 1);
     ++		strbuf_reset(&sb);
     ++
     ++		strbuf_addf(&sb, "%s/refs/heads", sb_repo.buf);
     ++		write_file(sb.buf, "this repository uses the reftable format");
     ++		strbuf_reset(&sb);
     ++
     ++		strbuf_addf(&sb, "%s/reftable", sb_repo.buf);
     ++		safe_create_dir(sb.buf, 1);
     ++		strbuf_reset(&sb);
     ++	} else {
     ++		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
     ++		write_file(sb.buf, "%s", oid_to_hex(&null_oid));
     ++		strbuf_reset(&sb);
     ++	}
     ++
     + 	strbuf_addf(&sb, "%s/commondir", sb_repo.buf);
     + 	write_file(sb.buf, "../..");
     + 
     +
       ## cache.h ##
      @@ cache.h: int path_inside_repo(const char *prefix, const char *path);
     + #define INIT_DB_EXIST_OK 0x0002
       
       int init_db(const char *git_dir, const char *real_git_dir,
     - 	    const char *template_dir, int hash_algo,
     --	    unsigned int flags);
     +-	    const char *template_dir, int hash_algo,
     +-	    const char *initial_branch, unsigned int flags);
      -void initialize_repository_version(int hash_algo);
     ++	    const char *template_dir, int hash_algo, const char *initial_branch,
      +	    const char *ref_storage_format, unsigned int flags);
      +void initialize_repository_version(int hash_algo,
      +				   const char *ref_storage_format);
     @@ cache.h: struct repository_format {
      
       ## refs.c ##
      @@
     - #include "argv-array.h"
       #include "repository.h"
     + #include "sigchain.h"
       
      +const char *default_ref_storage(void)
      +{
     @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
      -	r->refs_private = ref_store_init(r->gitdir, REF_STORE_ALL_CAPS);
      +	r->refs_private = ref_store_init(r->gitdir,
      +					 r->ref_storage_format ?
     -+						 r->ref_storage_format :
     -+						 default_ref_storage(),
     ++						       r->ref_storage_format :
     ++						       default_ref_storage(),
      +					 REF_STORE_ALL_CAPS);
       	return r->refs_private;
       }
     @@ refs/refs-internal.h: struct ref_storage_be {
       ## refs/reftable-backend.c (new) ##
      @@
      +#include "../cache.h"
     ++#include "../chdir-notify.h"
      +#include "../config.h"
     -+#include "../refs.h"
     -+#include "refs-internal.h"
      +#include "../iterator.h"
      +#include "../lockfile.h"
     -+#include "../chdir-notify.h"
     -+
     ++#include "../refs.h"
      +#include "../reftable/reftable.h"
     ++#include "../worktree.h"
     ++#include "refs-internal.h"
      +
      +extern struct ref_storage_be refs_be_reftable;
      +
     @@ refs/reftable-backend.c (new)
      +
      +	int err;
      +	char *repo_dir;
     ++
      +	char *reftable_dir;
     -+	struct reftable_stack *stack;
     ++	char *worktree_reftable_dir;
     ++
     ++	struct reftable_stack *main_stack;
     ++	struct reftable_stack *worktree_stack;
      +};
      +
     -+static int reftable_read_raw_ref(struct ref_store *ref_store,
     -+				 const char *refname, struct object_id *oid,
     -+				 struct strbuf *referent, unsigned int *type);
     ++static struct reftable_stack *stack_for(struct git_reftable_ref_store *store,
     ++					const char *refname)
     ++{
     ++	if (store->worktree_stack == NULL)
     ++		return store->main_stack;
     ++
     ++	switch (ref_type(refname)) {
     ++	case REF_TYPE_PER_WORKTREE:
     ++	case REF_TYPE_PSEUDOREF:
     ++	case REF_TYPE_OTHER_PSEUDOREF:
     ++		return store->worktree_stack;
     ++	default:
     ++	case REF_TYPE_MAIN_PSEUDOREF:
     ++	case REF_TYPE_NORMAL:
     ++		return store->main_stack;
     ++	}
     ++}
     ++
     ++static int git_reftable_read_raw_ref(struct ref_store *ref_store,
     ++				     const char *refname, struct object_id *oid,
     ++				     struct strbuf *referent,
     ++				     unsigned int *type);
      +
      +static void clear_reftable_log_record(struct reftable_log_record *log)
      +{
      +	log->old_hash = NULL;
      +	log->new_hash = NULL;
      +	log->message = NULL;
     -+	log->ref_name = NULL;
     ++	log->refname = NULL;
      +	reftable_log_record_clear(log);
      +}
      +
     @@ refs/reftable-backend.c (new)
      +	log->tz_offset = sign * atoi(split.tz_begin);
      +}
      +
     ++static int has_suffix(struct strbuf *b, const char *suffix)
     ++{
     ++	size_t len = strlen(suffix);
     ++
     ++	if (len > b->len) {
     ++		return 0;
     ++	}
     ++
     ++	return 0 == strncmp(b->buf + b->len - len, suffix, len);
     ++}
     ++
     ++static int trim_component(struct strbuf *b)
     ++{
     ++	char *last;
     ++	last = strrchr(b->buf, '/');
     ++	if (!last)
     ++		return -1;
     ++	strbuf_setlen(b, last - b->buf);
     ++	return 0;
     ++}
     ++
     ++static int is_worktree(struct strbuf *b)
     ++{
     ++	if (trim_component(b) < 0) {
     ++		return 0;
     ++	}
     ++	if (!has_suffix(b, "/worktrees")) {
     ++		return 0;
     ++	}
     ++	trim_component(b);
     ++	return 1;
     ++}
     ++
      +static struct ref_store *git_reftable_ref_store_create(const char *path,
      +						       unsigned int store_flags)
      +{
     @@ refs/reftable-backend.c (new)
      +		.hash_id = the_hash_algo->format_id,
      +	};
      +	struct strbuf sb = STRBUF_INIT;
     ++	const char *gitdir = path;
     ++	struct strbuf wt_buf = STRBUF_INIT;
     ++	int wt = 0;
     ++
     ++	strbuf_addstr(&wt_buf, path);
     ++
     ++	/* this is clumsy, but the official worktree functions (eg.
     ++	 * get_worktrees()) function will try to initialize a ref storage
     ++	 * backend, leading to infinite recursion.  */
     ++	wt = is_worktree(&wt_buf);
     ++	if (wt) {
     ++		gitdir = wt_buf.buf;
     ++	}
      +
      +	base_ref_store_init(ref_store, &refs_be_reftable);
      +	refs->store_flags = store_flags;
     -+	refs->repo_dir = xstrdup(path);
     -+	strbuf_addf(&sb, "%s/reftable", path);
     ++	refs->repo_dir = xstrdup(gitdir);
     ++	strbuf_addf(&sb, "%s/reftable", gitdir);
      +	refs->reftable_dir = xstrdup(sb.buf);
      +	strbuf_reset(&sb);
      +
     -+	refs->err = reftable_new_stack(&refs->stack, refs->reftable_dir, cfg);
     ++	refs->err =
     ++		reftable_new_stack(&refs->main_stack, refs->reftable_dir, cfg);
      +	assert(refs->err != REFTABLE_API_ERROR);
     ++
     ++	if (refs->err == 0 && wt) {
     ++		strbuf_addf(&sb, "%s/reftable", path);
     ++		refs->worktree_reftable_dir = xstrdup(sb.buf);
     ++
     ++		refs->err = reftable_new_stack(&refs->worktree_stack,
     ++					       refs->worktree_reftable_dir,
     ++					       cfg);
     ++		assert(refs->err != REFTABLE_API_ERROR);
     ++	}
     ++
      +	strbuf_release(&sb);
     ++	strbuf_release(&wt_buf);
      +	return ref_store;
      +}
      +
     -+static int reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
     ++static int git_reftable_init_db(struct ref_store *ref_store, struct strbuf *err)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +	struct strbuf sb = STRBUF_INIT;
      +
      +	safe_create_dir(refs->reftable_dir, 1);
     ++	assert(refs->worktree_reftable_dir == NULL);
      +
      +	strbuf_addf(&sb, "%s/HEAD", refs->repo_dir);
      +	write_file(sb.buf, "ref: refs/heads/.invalid");
     @@ refs/reftable-backend.c (new)
      +	struct reftable_ref_record ref;
      +	struct object_id oid;
      +	struct ref_store *ref_store;
     ++
     ++	/* In case we must iterate over 2 stacks, this is non-null. */
     ++	struct reftable_merged_table *merged;
      +	unsigned int flags;
      +	int err;
      +	const char *prefix;
     @@ refs/reftable-backend.c (new)
      +		   a PSEUDOREF, but a PER_WORKTREE, b/c each worktree can have
      +		   its own HEAD.
      +		 */
     -+		ri->base.refname = ri->ref.ref_name;
     ++		ri->base.refname = ri->ref.refname;
      +		if (ri->prefix != NULL &&
     -+		    strncmp(ri->prefix, ri->ref.ref_name, strlen(ri->prefix))) {
     ++		    strncmp(ri->prefix, ri->ref.refname, strlen(ri->prefix))) {
      +			ri->err = 1;
      +			break;
      +		}
     @@ refs/reftable-backend.c (new)
      +		} else if (ri->ref.target != NULL) {
      +			int out_flags = 0;
      +			const char *resolved = refs_resolve_ref_unsafe(
     -+				ri->ref_store, ri->ref.ref_name,
     ++				ri->ref_store, ri->ref.refname,
      +				RESOLVE_REF_READING, &ri->oid, &out_flags);
      +			ri->base.flags = out_flags;
      +			if (resolved == NULL &&
     @@ refs/reftable-backend.c (new)
      +		(struct git_reftable_iterator *)ref_iterator;
      +	reftable_ref_record_clear(&ri->ref);
      +	reftable_iterator_destroy(&ri->iter);
     ++	if (ri->merged) {
     ++		reftable_merged_table_free(ri->merged);
     ++	}
      +	return 0;
      +}
      +
     @@ refs/reftable-backend.c (new)
      +};
      +
      +static struct ref_iterator *
     -+reftable_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
     -+			    unsigned int flags)
     ++git_reftable_ref_iterator_begin(struct ref_store *ref_store, const char *prefix,
     ++				unsigned int flags)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +	struct git_reftable_iterator *ri = xcalloc(1, sizeof(*ri));
     -+	struct reftable_merged_table *mt = NULL;
      +
      +	if (refs->err < 0) {
      +		ri->err = refs->err;
     -+	} else {
     -+		mt = reftable_stack_merged_table(refs->stack);
     ++	} else if (refs->worktree_stack == NULL) {
     ++		struct reftable_merged_table *mt =
     ++			reftable_stack_merged_table(refs->main_stack);
      +		ri->err = reftable_merged_table_seek_ref(mt, &ri->iter, prefix);
     ++	} else {
     ++		struct reftable_merged_table *mt1 =
     ++			reftable_stack_merged_table(refs->main_stack);
     ++		struct reftable_merged_table *mt2 =
     ++			reftable_stack_merged_table(refs->worktree_stack);
     ++		struct reftable_table *tabs =
     ++			xcalloc(2, sizeof(struct reftable_table));
     ++		reftable_table_from_merged_table(&tabs[0], mt1);
     ++		reftable_table_from_merged_table(&tabs[1], mt2);
     ++		ri->err = reftable_new_merged_table(&ri->merged, tabs, 2,
     ++						    the_hash_algo->format_id);
     ++		if (ri->err == 0)
     ++			ri->err = reftable_merged_table_seek_ref(
     ++				ri->merged, &ri->iter, prefix);
      +	}
      +
      +	base_ref_iterator_init(&ri->base, &reftable_ref_iterator_vtable, 1);
     @@ refs/reftable-backend.c (new)
      +		struct ref_update *update = transaction->updates[i];
      +		struct object_id old_oid;
      +
     -+		err = reftable_read_raw_ref(ref_store, update->refname,
     -+					    &old_oid, &referent,
     -+					    /* mutate input, like
     -+					       files-backend.c */
     -+					    &update->type);
     ++		err = git_reftable_read_raw_ref(ref_store, update->refname,
     ++						&old_oid, &referent,
     ++						/* mutate input, like
     ++						   files-backend.c */
     ++						&update->type);
      +		if (err < 0 && errno == ENOENT &&
      +		    is_null_oid(&update->old_oid)) {
      +			err = 0;
     @@ refs/reftable-backend.c (new)
      +	return err;
      +}
      +
     -+static int reftable_transaction_prepare(struct ref_store *ref_store,
     -+					struct ref_transaction *transaction,
     -+					struct strbuf *errbuf)
     ++static int git_reftable_transaction_prepare(struct ref_store *ref_store,
     ++					    struct ref_transaction *transaction,
     ++					    struct strbuf *errbuf)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +	struct reftable_addition *add = NULL;
     ++	struct reftable_stack *stack =
     ++		transaction->nr ?
     ++			      stack_for(refs, transaction->updates[0]->refname) :
     ++			      refs->main_stack;
      +	int err = refs->err;
      +	if (err < 0) {
      +		goto done;
      +	}
      +
     -+	err = reftable_stack_reload(refs->stack);
     ++	err = reftable_stack_reload(stack);
      +	if (err) {
      +		goto done;
      +	}
      +
     -+	err = reftable_stack_new_addition(&add, refs->stack);
     ++	err = reftable_stack_new_addition(&add, stack);
      +	if (err) {
      +		goto done;
      +	}
     @@ refs/reftable-backend.c (new)
      +	return err;
      +}
      +
     -+static int reftable_transaction_abort(struct ref_store *ref_store,
     -+				      struct ref_transaction *transaction,
     -+				      struct strbuf *err)
     ++static int git_reftable_transaction_abort(struct ref_store *ref_store,
     ++					  struct ref_transaction *transaction,
     ++					  struct strbuf *err)
      +{
      +	struct reftable_addition *add =
      +		(struct reftable_addition *)transaction->backend_data;
     @@ refs/reftable-backend.c (new)
      +	struct ref_transaction *transaction = (struct ref_transaction *)arg;
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)transaction->ref_store;
     -+	uint64_t ts = reftable_stack_next_update_index(refs->stack);
     ++	struct reftable_stack *stack =
     ++		stack_for(refs, transaction->updates[0]->refname);
     ++	uint64_t ts = reftable_stack_next_update_index(stack);
      +	int err = 0;
      +	int i = 0;
      +	struct reftable_log_record *logs =
     @@ refs/reftable-backend.c (new)
      +		struct ref_update *u = sorted[i];
      +		struct reftable_log_record *log = &logs[i];
      +		fill_reftable_log_record(log);
     -+		log->ref_name = (char *)u->refname;
     ++		log->refname = (char *)u->refname;
      +		log->old_hash = u->old_oid.hash;
      +		log->new_hash = u->new_oid.hash;
      +		log->update_index = ts;
     @@ refs/reftable-backend.c (new)
      +			struct object_id peeled;
      +
      +			int peel_error = peel_object(&u->new_oid, &peeled);
     -+			ref.ref_name = (char *)u->refname;
     ++			ref.refname = (char *)u->refname;
      +
      +			if (!is_null_oid(&u->new_oid)) {
      +				ref.value = u->new_oid.hash;
     @@ refs/reftable-backend.c (new)
      +	return err;
      +}
      +
     -+static int reftable_transaction_finish(struct ref_store *ref_store,
     -+				       struct ref_transaction *transaction,
     -+				       struct strbuf *errmsg)
     ++static int git_reftable_transaction_finish(struct ref_store *ref_store,
     ++					   struct ref_transaction *transaction,
     ++					   struct strbuf *errmsg)
      +{
      +	struct reftable_addition *add =
      +		(struct reftable_addition *)transaction->backend_data;
     @@ refs/reftable-backend.c (new)
      +			}
      +		}
      +	}
     -+
     -+	err = reftable_addition_add(add, &write_transaction_table, transaction);
     -+	if (err < 0) {
     -+		goto done;
     ++	if (transaction->nr) {
     ++		err = reftable_addition_add(add, &write_transaction_table,
     ++					    transaction);
     ++		if (err < 0) {
     ++			goto done;
     ++		}
      +	}
      +
      +	err = reftable_addition_commit(add);
     @@ refs/reftable-backend.c (new)
      +}
      +
      +static int
     -+reftable_transaction_initial_commit(struct ref_store *ref_store,
     -+				    struct ref_transaction *transaction,
     -+				    struct strbuf *errmsg)
     ++git_reftable_transaction_initial_commit(struct ref_store *ref_store,
     ++					struct ref_transaction *transaction,
     ++					struct strbuf *errmsg)
      +{
     -+	int err = reftable_transaction_prepare(ref_store, transaction, errmsg);
     ++	int err = git_reftable_transaction_prepare(ref_store, transaction,
     ++						   errmsg);
      +	if (err)
      +		return err;
      +
     -+	return reftable_transaction_finish(ref_store, transaction, errmsg);
     ++	return git_reftable_transaction_finish(ref_store, transaction, errmsg);
      +}
      +
      +struct write_pseudoref_arg {
     @@ refs/reftable-backend.c (new)
      +		}
      +	}
      +
     -+	write_ref.ref_name = (char *)arg->pseudoref;
     ++	write_ref.refname = (char *)arg->pseudoref;
      +	write_ref.update_index = ts;
      +	if (!is_null_oid(arg->new_oid))
      +		write_ref.value = (uint8_t *)arg->new_oid->hash;
     @@ refs/reftable-backend.c (new)
      +	return err;
      +}
      +
     -+static int reftable_write_pseudoref(struct ref_store *ref_store,
     -+				    const char *pseudoref,
     -+				    const struct object_id *oid,
     -+				    const struct object_id *old_oid,
     -+				    struct strbuf *errbuf)
     ++static int git_reftable_write_pseudoref(struct ref_store *ref_store,
     ++					const char *pseudoref,
     ++					const struct object_id *oid,
     ++					const struct object_id *old_oid,
     ++					struct strbuf *errbuf)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, pseudoref);
      +	struct write_pseudoref_arg arg = {
     -+		.stack = refs->stack,
     ++		.stack = stack,
      +		.pseudoref = pseudoref,
      +		.new_oid = oid,
      +	};
     @@ refs/reftable-backend.c (new)
      +		goto done;
      +	}
      +
     -+	err = reftable_stack_reload(refs->stack);
     ++	err = reftable_stack_reload(stack);
      +	if (err) {
      +		goto done;
      +	}
     -+	err = reftable_stack_new_addition(&add, refs->stack);
     ++	err = reftable_stack_new_addition(&add, stack);
      +	if (err) {
      +		goto done;
      +	}
     @@ refs/reftable-backend.c (new)
      +				     const struct object_id *old_oid)
      +{
      +	struct strbuf errbuf = STRBUF_INIT;
     -+	int ret = reftable_write_pseudoref(ref_store, pseudoref, &null_oid,
     -+					   old_oid, &errbuf);
     ++	int ret = git_reftable_write_pseudoref(ref_store, pseudoref, &null_oid,
     ++					       old_oid, &errbuf);
      +	/* XXX what to do with the error message? */
      +	strbuf_release(&errbuf);
      +	return ret;
     @@ refs/reftable-backend.c (new)
      +	reftable_writer_set_limits(writer, ts, ts);
      +	for (i = 0; i < arg->refnames->nr; i++) {
      +		struct reftable_ref_record ref = {
     -+			.ref_name = (char *)arg->refnames->items[i].string,
     ++			.refname = (char *)arg->refnames->items[i].string,
      +			.update_index = ts,
      +		};
      +		err = reftable_writer_add_ref(writer, &ref);
     @@ refs/reftable-backend.c (new)
      +		log.new_hash = NULL;
      +		log.old_hash = NULL;
      +		log.update_index = ts;
     -+		log.ref_name = (char *)arg->refnames->items[i].string;
     ++		log.refname = (char *)arg->refnames->items[i].string;
      +
     -+		if (reftable_stack_read_ref(arg->stack, log.ref_name,
     ++		if (reftable_stack_read_ref(arg->stack, log.refname,
      +					    &current) == 0) {
      +			log.old_hash = current.value;
      +		}
     @@ refs/reftable-backend.c (new)
      +	return 0;
      +}
      +
     -+static int reftable_delete_refs(struct ref_store *ref_store, const char *msg,
     -+				struct string_list *refnames,
     -+				unsigned int flags)
     ++static int git_reftable_delete_refs(struct ref_store *ref_store,
     ++				    const char *msg,
     ++				    struct string_list *refnames,
     ++				    unsigned int flags)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack =
     ++		stack_for(refs, refnames->items[0].string);
      +	struct write_delete_refs_arg arg = {
     -+		.stack = refs->stack,
     ++		.stack = stack,
      +		.refnames = refnames,
      +		.logmsg = msg,
      +		.flags = flags,
     @@ refs/reftable-backend.c (new)
      +	}
      +
      +	string_list_sort(refnames);
     -+	err = reftable_stack_reload(refs->stack);
     ++	err = reftable_stack_reload(stack);
      +	if (err) {
      +		goto done;
      +	}
     -+	err = reftable_stack_add(refs->stack, &write_delete_refs_table, &arg);
     ++	err = reftable_stack_add(stack, &write_delete_refs_table, &arg);
      +done:
      +	assert(err != REFTABLE_API_ERROR);
      +	return err;
      +}
      +
     -+static int reftable_pack_refs(struct ref_store *ref_store, unsigned int flags)
     ++static int git_reftable_pack_refs(struct ref_store *ref_store,
     ++				  unsigned int flags)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     -+	if (refs->err < 0) {
     -+		return refs->err;
     ++	int err = refs->err;
     ++	if (err < 0) {
     ++		return err;
      +	}
     -+	return reftable_stack_compact_all(refs->stack, NULL);
     ++	err = reftable_stack_compact_all(refs->main_stack, NULL);
     ++	if (err == 0 && refs->worktree_stack != NULL)
     ++		err = reftable_stack_compact_all(refs->worktree_stack, NULL);
     ++	return err;
      +}
      +
      +struct write_create_symref_arg {
      +	struct git_reftable_ref_store *refs;
     ++	struct reftable_stack *stack;
      +	const char *refname;
      +	const char *target;
      +	const char *logmsg;
     @@ refs/reftable-backend.c (new)
      +{
      +	struct write_create_symref_arg *create =
      +		(struct write_create_symref_arg *)arg;
     -+	uint64_t ts = reftable_stack_next_update_index(create->refs->stack);
     ++	uint64_t ts = reftable_stack_next_update_index(create->stack);
      +	int err = 0;
      +
      +	struct reftable_ref_record ref = {
     -+		.ref_name = (char *)create->refname,
     ++		.refname = (char *)create->refname,
      +		.target = (char *)create->target,
      +		.update_index = ts,
      +	};
     @@ refs/reftable-backend.c (new)
      +		struct object_id old_oid;
      +
      +		fill_reftable_log_record(&log);
     -+		log.ref_name = (char *)create->refname;
     ++		log.refname = (char *)create->refname;
      +		log.message = (char *)create->logmsg;
      +		log.update_index = ts;
      +		if (refs_resolve_ref_unsafe(
     @@ refs/reftable-backend.c (new)
      +		if (log.old_hash != NULL || log.new_hash != NULL) {
      +			err = reftable_writer_add_log(writer, &log);
      +		}
     -+		log.ref_name = NULL;
     ++		log.refname = NULL;
      +		log.message = NULL;
      +		log.old_hash = NULL;
      +		log.new_hash = NULL;
     @@ refs/reftable-backend.c (new)
      +	return err;
      +}
      +
     -+static int reftable_create_symref(struct ref_store *ref_store,
     -+				  const char *refname, const char *target,
     -+				  const char *logmsg)
     ++static int git_reftable_create_symref(struct ref_store *ref_store,
     ++				      const char *refname, const char *target,
     ++				      const char *logmsg)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, refname);
      +	struct write_create_symref_arg arg = { .refs = refs,
     ++					       .stack = stack,
      +					       .refname = refname,
      +					       .target = target,
      +					       .logmsg = logmsg };
     @@ refs/reftable-backend.c (new)
      +	if (err < 0) {
      +		goto done;
      +	}
     -+	err = reftable_stack_reload(refs->stack);
     ++	err = reftable_stack_reload(stack);
      +	if (err) {
      +		goto done;
      +	}
     -+	err = reftable_stack_add(refs->stack, &write_create_symref_table, &arg);
     ++	err = reftable_stack_add(stack, &write_create_symref_table, &arg);
      +done:
      +	assert(err != REFTABLE_API_ERROR);
      +	return err;
     @@ refs/reftable-backend.c (new)
      +		goto done;
      +	}
      +
     -+	free(ref.ref_name);
     -+	ref.ref_name = strdup(arg->newname);
     ++	free(ref.refname);
     ++	ref.refname = strdup(arg->newname);
      +	reftable_writer_set_limits(writer, ts, ts);
      +	ref.update_index = ts;
      +
      +	{
      +		struct reftable_ref_record todo[2] = { { NULL } };
     -+		todo[0].ref_name = (char *)arg->oldname;
     ++		todo[0].refname = (char *)arg->oldname;
      +		todo[0].update_index = ts;
      +		/* leave todo[0] empty */
      +		todo[1] = ref;
     @@ refs/reftable-backend.c (new)
      +		fill_reftable_log_record(&todo[0]);
      +		fill_reftable_log_record(&todo[1]);
      +
     -+		todo[0].ref_name = (char *)arg->oldname;
     ++		todo[0].refname = (char *)arg->oldname;
      +		todo[0].update_index = ts;
      +		todo[0].message = (char *)arg->logmsg;
      +		todo[0].old_hash = ref.value;
      +		todo[0].new_hash = NULL;
      +
     -+		todo[1].ref_name = (char *)arg->newname;
     ++		todo[1].refname = (char *)arg->newname;
      +		todo[1].update_index = ts;
      +		todo[1].old_hash = NULL;
      +		todo[1].new_hash = ref.value;
     @@ refs/reftable-backend.c (new)
      +	return err;
      +}
      +
     -+static int reftable_rename_ref(struct ref_store *ref_store,
     -+			       const char *oldrefname, const char *newrefname,
     -+			       const char *logmsg)
     ++static int git_reftable_rename_ref(struct ref_store *ref_store,
     ++				   const char *oldrefname,
     ++				   const char *newrefname, const char *logmsg)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, newrefname);
      +	struct write_rename_arg arg = {
     -+		.stack = refs->stack,
     ++		.stack = stack,
      +		.oldname = oldrefname,
      +		.newname = newrefname,
      +		.logmsg = logmsg,
     @@ refs/reftable-backend.c (new)
      +	if (err < 0) {
      +		goto done;
      +	}
     -+	err = reftable_stack_reload(refs->stack);
     ++	err = reftable_stack_reload(stack);
      +	if (err) {
      +		goto done;
      +	}
      +
     -+	err = reftable_stack_add(refs->stack, &write_rename_table, &arg);
     ++	err = reftable_stack_add(stack, &write_rename_table, &arg);
      +done:
      +	assert(err != REFTABLE_API_ERROR);
      +	return err;
      +}
      +
     -+static int reftable_copy_ref(struct ref_store *ref_store,
     -+			     const char *oldrefname, const char *newrefname,
     -+			     const char *logmsg)
     ++static int git_reftable_copy_ref(struct ref_store *ref_store,
     ++				 const char *oldrefname, const char *newrefname,
     ++				 const char *logmsg)
      +{
      +	BUG("reftable reference store does not support copying references");
      +}
      +
     -+struct reftable_reflog_ref_iterator {
     ++struct git_reftable_reflog_ref_iterator {
      +	struct ref_iterator base;
      +	struct reftable_iterator iter;
      +	struct reftable_log_record log;
      +	struct object_id oid;
     ++
     ++	/* Used when iterating over worktree & main */
     ++	struct reftable_merged_table *merged;
      +	char *last_name;
      +};
      +
      +static int
     -+reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator)
     ++git_reftable_reflog_ref_iterator_advance(struct ref_iterator *ref_iterator)
      +{
     -+	struct reftable_reflog_ref_iterator *ri =
     -+		(struct reftable_reflog_ref_iterator *)ref_iterator;
     ++	struct git_reftable_reflog_ref_iterator *ri =
     ++		(struct git_reftable_reflog_ref_iterator *)ref_iterator;
      +
      +	while (1) {
      +		int err = reftable_iterator_next_log(&ri->iter, &ri->log);
     @@ refs/reftable-backend.c (new)
      +			return ITER_ERROR;
      +		}
      +
     -+		ri->base.refname = ri->log.ref_name;
     ++		ri->base.refname = ri->log.refname;
      +		if (ri->last_name != NULL &&
     -+		    !strcmp(ri->log.ref_name, ri->last_name)) {
     ++		    !strcmp(ri->log.refname, ri->last_name)) {
      +			/* we want the refnames that we have reflogs for, so we
      +			 * skip if we've already produced this name. This could
      +			 * be faster by seeking directly to
     @@ refs/reftable-backend.c (new)
      +		}
      +
      +		free(ri->last_name);
     -+		ri->last_name = xstrdup(ri->log.ref_name);
     ++		ri->last_name = xstrdup(ri->log.refname);
      +		hashcpy(ri->oid.hash, ri->log.new_hash);
      +		return ITER_OK;
      +	}
      +}
      +
     -+static int reftable_reflog_ref_iterator_peel(struct ref_iterator *ref_iterator,
     -+					     struct object_id *peeled)
     ++static int
     ++git_reftable_reflog_ref_iterator_peel(struct ref_iterator *ref_iterator,
     ++				      struct object_id *peeled)
      +{
      +	BUG("not supported.");
      +	return -1;
      +}
      +
     -+static int reftable_reflog_ref_iterator_abort(struct ref_iterator *ref_iterator)
     ++static int
     ++git_reftable_reflog_ref_iterator_abort(struct ref_iterator *ref_iterator)
      +{
     -+	struct reftable_reflog_ref_iterator *ri =
     -+		(struct reftable_reflog_ref_iterator *)ref_iterator;
     ++	struct git_reftable_reflog_ref_iterator *ri =
     ++		(struct git_reftable_reflog_ref_iterator *)ref_iterator;
      +	reftable_log_record_clear(&ri->log);
      +	reftable_iterator_destroy(&ri->iter);
     ++	if (ri->merged)
     ++		reftable_merged_table_free(ri->merged);
      +	return 0;
      +}
      +
     -+static struct ref_iterator_vtable reftable_reflog_ref_iterator_vtable = {
     -+	reftable_reflog_ref_iterator_advance, reftable_reflog_ref_iterator_peel,
     -+	reftable_reflog_ref_iterator_abort
     ++static struct ref_iterator_vtable git_reftable_reflog_ref_iterator_vtable = {
     ++	git_reftable_reflog_ref_iterator_advance,
     ++	git_reftable_reflog_ref_iterator_peel,
     ++	git_reftable_reflog_ref_iterator_abort
      +};
      +
      +static struct ref_iterator *
     -+reftable_reflog_iterator_begin(struct ref_store *ref_store)
     ++git_reftable_reflog_iterator_begin(struct ref_store *ref_store)
      +{
     -+	struct reftable_reflog_ref_iterator *ri = xcalloc(sizeof(*ri), 1);
     ++	struct git_reftable_reflog_ref_iterator *ri = xcalloc(sizeof(*ri), 1);
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +
     -+	struct reftable_merged_table *mt =
     -+		reftable_stack_merged_table(refs->stack);
     -+	int err = reftable_merged_table_seek_log(mt, &ri->iter, "");
     -+	if (err < 0) {
     -+		free(ri);
     -+		return NULL;
     ++	if (refs->worktree_stack == NULL) {
     ++		struct reftable_stack *stack = refs->main_stack;
     ++		struct reftable_merged_table *mt =
     ++			reftable_stack_merged_table(stack);
     ++		int err = reftable_merged_table_seek_log(mt, &ri->iter, "");
     ++		if (err < 0) {
     ++			free(ri);
     ++			/* XXX is this allowed? */
     ++			return NULL;
     ++		}
     ++	} else {
     ++		struct reftable_merged_table *mt1 =
     ++			reftable_stack_merged_table(refs->main_stack);
     ++		struct reftable_merged_table *mt2 =
     ++			reftable_stack_merged_table(refs->worktree_stack);
     ++		struct reftable_table *tabs =
     ++			xcalloc(2, sizeof(struct reftable_table));
     ++		int err = 0;
     ++		reftable_table_from_merged_table(&tabs[0], mt1);
     ++		reftable_table_from_merged_table(&tabs[1], mt2);
     ++		err = reftable_new_merged_table(&ri->merged, tabs, 2,
     ++						the_hash_algo->format_id);
     ++		if (err < 0) {
     ++			free(tabs);
     ++			/* XXX see above */
     ++			return NULL;
     ++		}
     ++		err = reftable_merged_table_seek_ref(ri->merged, &ri->iter, "");
     ++		if (err < 0) {
     ++			return NULL;
     ++		}
      +	}
     -+
     -+	base_ref_iterator_init(&ri->base, &reftable_reflog_ref_iterator_vtable,
     -+			       1);
     ++	base_ref_iterator_init(&ri->base,
     ++			       &git_reftable_reflog_ref_iterator_vtable, 1);
      +	ri->base.oid = &ri->oid;
      +
      +	return (struct ref_iterator *)ri;
      +}
      +
     -+static int
     -+reftable_for_each_reflog_ent_newest_first(struct ref_store *ref_store,
     -+					  const char *refname,
     -+					  each_reflog_ent_fn fn, void *cb_data)
     ++static int git_reftable_for_each_reflog_ent_newest_first(
     ++	struct ref_store *ref_store, const char *refname, each_reflog_ent_fn fn,
     ++	void *cb_data)
      +{
      +	struct reftable_iterator it = { NULL };
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, refname);
      +	struct reftable_merged_table *mt = NULL;
      +	int err = 0;
      +	struct reftable_log_record log = { NULL };
     @@ refs/reftable-backend.c (new)
      +		return refs->err;
      +	}
      +
     -+	mt = reftable_stack_merged_table(refs->stack);
     ++	mt = reftable_stack_merged_table(stack);
      +	err = reftable_merged_table_seek_log(mt, &it, refname);
      +	while (err == 0) {
      +		struct object_id old_oid;
     @@ refs/reftable-backend.c (new)
      +			break;
      +		}
      +
     -+		if (strcmp(log.ref_name, refname)) {
     ++		if (strcmp(log.refname, refname)) {
      +			break;
      +		}
      +
     @@ refs/reftable-backend.c (new)
      +	return err;
      +}
      +
     -+static int
     -+reftable_for_each_reflog_ent_oldest_first(struct ref_store *ref_store,
     -+					  const char *refname,
     -+					  each_reflog_ent_fn fn, void *cb_data)
     ++static int git_reftable_for_each_reflog_ent_oldest_first(
     ++	struct ref_store *ref_store, const char *refname, each_reflog_ent_fn fn,
     ++	void *cb_data)
      +{
      +	struct reftable_iterator it = { NULL };
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, refname);
      +	struct reftable_merged_table *mt = NULL;
      +	struct reftable_log_record *logs = NULL;
      +	int cap = 0;
     @@ refs/reftable-backend.c (new)
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
     -+	mt = reftable_stack_merged_table(refs->stack);
     ++	mt = reftable_stack_merged_table(stack);
      +	err = reftable_merged_table_seek_log(mt, &it, refname);
      +
      +	while (err == 0) {
     @@ refs/reftable-backend.c (new)
      +			break;
      +		}
      +
     -+		if (strcmp(log.ref_name, refname)) {
     ++		if (strcmp(log.refname, refname)) {
      +			break;
      +		}
      +
     @@ refs/reftable-backend.c (new)
      +	return err;
      +}
      +
     -+static int reftable_reflog_exists(struct ref_store *ref_store,
     -+				  const char *refname)
     ++static int git_reftable_reflog_exists(struct ref_store *ref_store,
     ++				      const char *refname)
      +{
      +	/* always exists. */
      +	return 1;
      +}
      +
     -+static int reftable_create_reflog(struct ref_store *ref_store,
     -+				  const char *refname, int force_create,
     -+				  struct strbuf *err)
     ++static int git_reftable_create_reflog(struct ref_store *ref_store,
     ++				      const char *refname, int force_create,
     ++				      struct strbuf *err)
      +{
      +	return 0;
      +}
      +
     -+static int reftable_delete_reflog(struct ref_store *ref_store,
     -+				  const char *refname)
     ++static int git_reftable_delete_reflog(struct ref_store *ref_store,
     ++				      const char *refname)
      +{
      +	return 0;
      +}
      +
      +struct reflog_expiry_arg {
      +	struct git_reftable_ref_store *refs;
     ++	struct reftable_stack *stack;
      +	struct reftable_log_record *tombstones;
      +	int len;
      +	int cap;
     @@ refs/reftable-backend.c (new)
      +			      const char *refname, uint64_t ts)
      +{
      +	struct reftable_log_record tombstone = {
     -+		.ref_name = xstrdup(refname),
     ++		.refname = xstrdup(refname),
      +		.update_index = ts,
      +	};
      +	if (arg->len == arg->cap) {
     @@ refs/reftable-backend.c (new)
      +static int write_reflog_expiry_table(struct reftable_writer *writer, void *argv)
      +{
      +	struct reflog_expiry_arg *arg = (struct reflog_expiry_arg *)argv;
     -+	uint64_t ts = reftable_stack_next_update_index(arg->refs->stack);
     ++	uint64_t ts = reftable_stack_next_update_index(arg->stack);
      +	int i = 0;
      +	reftable_writer_set_limits(writer, ts, ts);
      +	for (i = 0; i < arg->len; i++) {
     @@ refs/reftable-backend.c (new)
      +	return 0;
      +}
      +
     -+static int reftable_reflog_expire(struct ref_store *ref_store,
     -+				  const char *refname,
     -+				  const struct object_id *oid,
     -+				  unsigned int flags,
     -+				  reflog_expiry_prepare_fn prepare_fn,
     -+				  reflog_expiry_should_prune_fn should_prune_fn,
     -+				  reflog_expiry_cleanup_fn cleanup_fn,
     -+				  void *policy_cb_data)
     ++static int
     ++git_reftable_reflog_expire(struct ref_store *ref_store, const char *refname,
     ++			   const struct object_id *oid, unsigned int flags,
     ++			   reflog_expiry_prepare_fn prepare_fn,
     ++			   reflog_expiry_should_prune_fn should_prune_fn,
     ++			   reflog_expiry_cleanup_fn cleanup_fn,
     ++			   void *policy_cb_data)
      +{
      +	/*
      +	  For log expiry, we write tombstones in place of the expired entries,
     @@ refs/reftable-backend.c (new)
      +	  stack, and expiring entries paradoxically takes extra memory.
      +
      +	  This memory is only reclaimed when some operation issues a
     -+	  reftable_pack_refs(), which will compact the entire stack and get rid
     -+	  of deletion entries.
     ++	  git_reftable_pack_refs(), which will compact the entire stack and get
     ++	  rid of deletion entries.
      +
      +	  It would be better if the refs backend supported an API that sets a
      +	  criterion for all refs, passing the criterion to pack_refs().
      +	*/
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, refname);
      +	struct reftable_merged_table *mt = NULL;
      +	struct reflog_expiry_arg arg = {
     ++		.stack = stack,
      +		.refs = refs,
      +	};
      +	struct reftable_log_record log = { NULL };
     @@ refs/reftable-backend.c (new)
      +	if (refs->err < 0) {
      +		return refs->err;
      +	}
     -+	err = reftable_stack_reload(refs->stack);
     ++	err = reftable_stack_reload(stack);
      +	if (err) {
      +		goto done;
      +	}
      +
     -+	mt = reftable_stack_merged_table(refs->stack);
     ++	mt = reftable_stack_merged_table(stack);
      +	err = reftable_merged_table_seek_log(mt, &it, refname);
      +	if (err < 0) {
      +		goto done;
     @@ refs/reftable-backend.c (new)
      +			goto done;
      +		}
      +
     -+		if (err > 0 || strcmp(log.ref_name, refname)) {
     ++		if (err > 0 || strcmp(log.refname, refname)) {
      +			break;
      +		}
      +		hashcpy(ooid.hash, log.old_hash);
     @@ refs/reftable-backend.c (new)
      +			add_log_tombstone(&arg, refname, log.update_index);
      +		}
      +	}
     -+	err = reftable_stack_add(refs->stack, &write_reflog_expiry_table, &arg);
     ++	err = reftable_stack_add(stack, &write_reflog_expiry_table, &arg);
      +
      +done:
      +	assert(err != REFTABLE_API_ERROR);
     @@ refs/reftable-backend.c (new)
      +	return err;
      +}
      +
     -+static int reftable_read_raw_ref(struct ref_store *ref_store,
     -+				 const char *refname, struct object_id *oid,
     -+				 struct strbuf *referent, unsigned int *type)
     ++static int git_reftable_read_raw_ref(struct ref_store *ref_store,
     ++				     const char *refname, struct object_id *oid,
     ++				     struct strbuf *referent,
     ++				     unsigned int *type)
      +{
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
     ++	struct reftable_stack *stack = stack_for(refs, refname);
     ++
      +	struct reftable_ref_record ref = { NULL };
      +	int err = 0;
      +	if (refs->err < 0) {
     @@ refs/reftable-backend.c (new)
      +	/* This is usually not needed, but Git doesn't signal to ref backend if
      +	   a subprocess updated the ref DB.  So we always check.
      +	*/
     -+	err = reftable_stack_reload(refs->stack);
     ++	err = reftable_stack_reload(stack);
      +	if (err) {
      +		goto done;
      +	}
      +
     -+	err = reftable_stack_read_ref(refs->stack, refname, &ref);
     ++	err = reftable_stack_read_ref(stack, refname, &ref);
      +	if (err > 0) {
      +		errno = ENOENT;
      +		err = -1;
     @@ refs/reftable-backend.c (new)
      +	&refs_be_files,
      +	"reftable",
      +	git_reftable_ref_store_create,
     -+	reftable_init_db,
     -+	reftable_transaction_prepare,
     -+	reftable_transaction_finish,
     -+	reftable_transaction_abort,
     -+	reftable_transaction_initial_commit,
     -+
     -+	reftable_pack_refs,
     -+	reftable_create_symref,
     -+	reftable_delete_refs,
     -+	reftable_rename_ref,
     -+	reftable_copy_ref,
     -+
     -+	reftable_write_pseudoref,
     ++	git_reftable_init_db,
     ++	git_reftable_transaction_prepare,
     ++	git_reftable_transaction_finish,
     ++	git_reftable_transaction_abort,
     ++	git_reftable_transaction_initial_commit,
     ++
     ++	git_reftable_pack_refs,
     ++	git_reftable_create_symref,
     ++	git_reftable_delete_refs,
     ++	git_reftable_rename_ref,
     ++	git_reftable_copy_ref,
     ++
     ++	git_reftable_write_pseudoref,
      +	reftable_delete_pseudoref,
      +
     -+	reftable_ref_iterator_begin,
     -+	reftable_read_raw_ref,
     ++	git_reftable_ref_iterator_begin,
     ++	git_reftable_read_raw_ref,
      +
     -+	reftable_reflog_iterator_begin,
     -+	reftable_for_each_reflog_ent_oldest_first,
     -+	reftable_for_each_reflog_ent_newest_first,
     -+	reftable_reflog_exists,
     -+	reftable_create_reflog,
     -+	reftable_delete_reflog,
     -+	reftable_reflog_expire,
     ++	git_reftable_reflog_iterator_begin,
     ++	git_reftable_for_each_reflog_ent_oldest_first,
     ++	git_reftable_for_each_reflog_ent_newest_first,
     ++	git_reftable_reflog_exists,
     ++	git_reftable_create_reflog,
     ++	git_reftable_delete_reflog,
     ++	git_reftable_reflog_expire,
      +};
      
       ## reftable/update.sh ##
     @@ t/t0031-reftable.sh (new)
      +	test -f file2
      +'
      +
     ++test_expect_success 'worktrees' '
     ++	git init --ref-storage=reftable start &&
     ++	(cd start && test_commit file1 && git checkout -b branch1 &&
     ++	git checkout -b branch2 &&
     ++	git worktree add  ../wt
     ++	) &&
     ++	cd wt &&
     ++	git checkout branch1 &&
     ++	git branch
     ++'
     ++
     ++test_expect_success 'worktrees 2' '
     ++	initialize &&
     ++	test_commit file1 &&
     ++	mkdir existing_empty &&
     ++	git worktree add --detach existing_empty master
     ++'
     ++
      +test_done
      +
 14:  eafd8eeefc = 15:  04c86e7395 Hookup unittests for the reftable library.
 15:  46af142f33 ! 16:  c751265705 Add GIT_DEBUG_REFS debugging mechanism
     @@ Makefile: LIB_OBJS += rebase.o
       LIB_OBJS += refs/reftable-backend.o
       LIB_OBJS += refs/iterator.o
      
     + ## builtin/worktree.c ##
     +@@ builtin/worktree.c: static int add_worktree(const char *path, const char *refname,
     + 	 * worktree.
     + 	 */
     + 	strbuf_reset(&sb);
     +-	if (get_main_ref_store(the_repository)->be == &refs_be_reftable) {
     ++
     ++	/* XXX: check GIT_TEST_REFTABLE because GIT_DEBUG_REFS obscures the
     ++	 * instance type. */
     ++	if (get_main_ref_store(the_repository)->be == &refs_be_reftable ||
     ++	    getenv("GIT_TEST_REFTABLE") != NULL) {
     + 		/* XXX this is cut & paste from reftable_init_db. */
     + 		strbuf_addf(&sb, "%s/HEAD", sb_repo.buf);
     + 		write_file(sb.buf, "%s", "ref: refs/heads/.invalid\n");
     +
       ## refs.c ##
      @@ refs.c: struct ref_store *get_main_ref_store(struct repository *r)
     - 						 r->ref_storage_format :
     - 						 default_ref_storage(),
     + 						       r->ref_storage_format :
     + 						       default_ref_storage(),
       					 REF_STORE_ALL_CAPS);
      +	if (getenv("GIT_DEBUG_REFS")) {
     -+		r->refs_private = debug_wrap(r->refs_private);
     ++		r->refs_private = debug_wrap(r->gitdir, r->refs_private);
      +	}
       	return r->refs_private;
       }
     @@ refs/debug.c (new)
      +};
      +
      +extern struct ref_storage_be refs_be_debug;
     -+struct ref_store *debug_wrap(struct ref_store *store);
     ++struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store);
      +
     -+struct ref_store *debug_wrap(struct ref_store *store)
     ++struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store)
      +{
      +	struct debug_ref_store *res = malloc(sizeof(struct debug_ref_store));
     ++	fprintf(stderr, "ref_store for %s\n", gitdir);
      +	res->refs = store;
      +	base_ref_store_init((struct ref_store *)res, &refs_be_debug);
      +	return (struct ref_store *)res;
     @@ refs/debug.c (new)
      +	struct debug_ref_iterator *diter =
      +		(struct debug_ref_iterator *)ref_iterator;
      +	int res = diter->iter->vtable->advance(diter->iter);
     -+	fprintf(stderr, "iterator_advance: %s: %d\n", diter->iter->refname,
     -+		res);
     ++	if (res)
     ++		fprintf(stderr, "iterator_advance: %d\n", res);
     ++	else
     ++		fprintf(stderr, "iterator_advance before: %s\n",
     ++			diter->iter->refname);
     ++
      +	diter->base.ordered = diter->iter->ordered;
      +	diter->base.refname = diter->iter->refname;
      +	diter->base.oid = diter->iter->oid;
     @@ refs/refs-internal.h: struct ref_store {
      + * Print out ref operations as they occur. Useful for debugging alternate ref
      + * backends.
      + */
     -+struct ref_store *debug_wrap(struct ref_store *store);
     ++struct ref_store *debug_wrap(const char *gitdir, struct ref_store *store);
      +
       #endif /* REFS_REFS_INTERNAL_H */
      
 16:  5211c64310 = 17:  ef0dd45f07 vcxproj: adjust for the reftable changes
 17:  9724854088 = 18:  d4dc1deae5 git-prompt: prepare for reftable refs backend
 18:  ece1fa1f62 = 19:  5a85abf9c4 Add reftable testing infrastructure
 19:  991abf9e1b = 20:  0ebf7beb95 Add "test-tool dump-reftable" command.

-- 
gitgitgadget
