Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 40DDBC433E0
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 03C7564F80
	for <git@archiver.kernel.org>; Fri, 12 Mar 2021 20:20:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234714AbhCLUUN (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 15:20:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234679AbhCLUUB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 15:20:01 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E6CC061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:00 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id o16so2458280wrn.0
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 12:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=vYQ012b40GFa9lD7qUdmQxRY7ea9nyl0PBSDvy+THo4=;
        b=jvGj3PWpM87wVQjmystZrVua+el6wnL76ZYjgZQtmi6H7PTESF5Shm249pEY6H1GrP
         e+l8MqofPuIhqi/Jlc3CJ4TXUMpCf0ra0kdM9BkfCR55WtSyfgaalh4hvGEFSrPQQU3S
         eDXpDZnVX9UO8JxlO0EgGIT2qndlW15NxoA2HaO9yyvDRio4LcBqj0XEhpyxYhMeqwuP
         zYayHYPmhjXooHe2jqV2Cot8cIvWM2y5M9MsmYmctmbrT7DOP5s77t1LvV6pCPvyJC9x
         wgaTT8d/mEKsp4pwl3BQNGecdYg519RiKp/isyBtGoluto7211UUQcJfRHDXiUBvmM9r
         HxtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=vYQ012b40GFa9lD7qUdmQxRY7ea9nyl0PBSDvy+THo4=;
        b=GN3KE1hqBEe4OswzMoU7YPI9oaco2enWcuXHZ7sfruFQcu6I2+1wWBNNfN5gbpnX2Q
         F3sjROyFi42sgNJfNL4QXm3Dxkj2miStXg7YRRPSs94sxOBsq7pXktfKN6Ot2kBDxHan
         JuOr+vN85taLXwciF2lmh0rJufKhW4aCygmtcFpblXup8RHoZHgW4RI+kxX6XDLObsEV
         mgtpE1Ok2NWqP1sjYipXukhrfzc0M3NEARrh2uWCReNhNWcKyr5dgfe5GsDIvkC3+AND
         PG/Q+DTKrIKqJa9xVM8dBSDz19VWhu/qUQ6uRIA1CNonQC1IbudIeoUJaiCklVoOqbqy
         PKug==
X-Gm-Message-State: AOAM531g7HM+TuePIxAxflgqzUnigpDFQ8HN9NzE1ADsfpCFBMtmltZv
        ADXC9z4f/pRyKD52nlC7t1cnyKwOMxs=
X-Google-Smtp-Source: ABdhPJwYac6+5EySY4kflVnRSa1Rr1ZQYdwu66WC3HzzNOYXsNBAHp4xTT//KEDre7y2IVF/9mnIWQ==
X-Received: by 2002:a5d:47ab:: with SMTP id 11mr15815718wrb.153.1615580399103;
        Fri, 12 Mar 2021 12:19:59 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g5sm9035549wrq.30.2021.03.12.12.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Mar 2021 12:19:58 -0800 (PST)
Message-Id: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
References: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 12 Mar 2021 20:19:41 +0000
Subject: [PATCH v5 00/15] reftable library
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>, Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jonathan Tan <jonathantanmy@google.com>,
        Josh Steadmon <steadmon@google.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Patrick Steinhardt <ps@pks.im>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Felipe Contreras <felipe.contreras@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This splits the giant commit from
https://github.com/gitgitgadget/git/pull/539 into a series of smaller
commits, which build and have unittests.

The final commit should also be split up, but I want to wait until we have
consensus that the bottom commits look good.

version 12 Mar 2021:

 * tagged unions for reftable_log_record
 * some fixups by jun

Based on github.com/hanwen/reftable at
c33a40ad23dd622d8c72139c41a2be1cfa063e5f Add random suffix to table names

Han-Wen Nienhuys (14):
  init-db: set the_repository->hash_algo early on
  reftable: add LICENSE
  reftable: add error related functionality
  reftable: utility functions
  reftable: add blocksource, an abstraction for random access reads
  reftable: (de)serialization for the polymorphic record type.
  reftable: reading/writing blocks
  reftable: a generic binary tree implementation
  reftable: write reftable files
  reftable: read reftable files
  reftable: reftable file level tests
  reftable: rest of library
  Reftable support for git-core
  Add "test-tool dump-reftable" command.

SZEDER Gábor (1):
  git-prompt: prepare for reftable refs backend

 Documentation/config/extensions.txt           |    9 +
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   46 +-
 builtin/clone.c                               |    5 +-
 builtin/init-db.c                             |   76 +-
 builtin/worktree.c                            |   27 +-
 cache.h                                       |    8 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/CMakeLists.txt           |   14 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 contrib/completion/git-prompt.sh              |    7 +-
 refs.c                                        |   27 +-
 refs.h                                        |    3 +
 refs/refs-internal.h                          |    1 +
 refs/reftable-backend.c                       | 1446 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/VERSION                              |    1 +
 reftable/basics.c                             |  128 ++
 reftable/basics.h                             |   60 +
 reftable/basics_test.c                        |   98 ++
 reftable/block.c                              |  440 +++++
 reftable/block.h                              |  127 ++
 reftable/block_test.c                         |  121 ++
 reftable/blocksource.c                        |  148 ++
 reftable/blocksource.h                        |   22 +
 reftable/constants.h                          |   21 +
 reftable/dump.c                               |  213 +++
 reftable/error.c                              |   41 +
 reftable/iter.c                               |  248 +++
 reftable/iter.h                               |   75 +
 reftable/merged.c                             |  366 +++++
 reftable/merged.h                             |   35 +
 reftable/merged_test.c                        |  343 ++++
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   32 +
 reftable/publicbasics.c                       |   58 +
 reftable/reader.c                             |  733 +++++++++
 reftable/reader.h                             |   75 +
 reftable/record.c                             | 1203 ++++++++++++++
 reftable/record.h                             |  139 ++
 reftable/record_test.c                        |  405 +++++
 reftable/refname.c                            |  209 +++
 reftable/refname.h                            |   29 +
 reftable/refname_test.c                       |  102 ++
 reftable/reftable-blocksource.h               |   49 +
 reftable/reftable-error.h                     |   62 +
 reftable/reftable-generic.h                   |   48 +
 reftable/reftable-iterator.h                  |   37 +
 reftable/reftable-malloc.h                    |   18 +
 reftable/reftable-merged.h                    |   68 +
 reftable/reftable-reader.h                    |   89 +
 reftable/reftable-record.h                    |  114 ++
 reftable/reftable-stack.h                     |  120 ++
 reftable/reftable-tests.h                     |   22 +
 reftable/reftable-writer.h                    |  147 ++
 reftable/reftable.c                           |   98 ++
 reftable/reftable_test.c                      |  583 +++++++
 reftable/stack.c                              | 1260 ++++++++++++++
 reftable/stack.h                              |   41 +
 reftable/stack_test.c                         |  809 +++++++++
 reftable/system.h                             |   32 +
 reftable/test_framework.c                     |   23 +
 reftable/test_framework.h                     |   53 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/tree_test.c                          |   61 +
 reftable/writer.c                             |  691 ++++++++
 reftable/writer.h                             |   50 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |    9 +-
 t/helper/test-reftable.c                      |   20 +
 t/helper/test-tool.c                          |    4 +-
 t/helper/test-tool.h                          |    2 +
 t/t0031-reftable.sh                           |  203 +++
 t/t0032-reftable-unittest.sh                  |   15 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    5 +
 82 files changed, 12213 insertions(+), 40 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/basics_test.c
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/block_test.c
 create mode 100644 reftable/blocksource.c
 create mode 100644 reftable/blocksource.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/dump.c
 create mode 100644 reftable/error.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/publicbasics.c
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/record_test.c
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/refname_test.c
 create mode 100644 reftable/reftable-blocksource.h
 create mode 100644 reftable/reftable-error.h
 create mode 100644 reftable/reftable-generic.h
 create mode 100644 reftable/reftable-iterator.h
 create mode 100644 reftable/reftable-malloc.h
 create mode 100644 reftable/reftable-merged.h
 create mode 100644 reftable/reftable-reader.h
 create mode 100644 reftable/reftable-record.h
 create mode 100644 reftable/reftable-stack.h
 create mode 100644 reftable/reftable-tests.h
 create mode 100644 reftable/reftable-writer.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/reftable_test.c
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/stack_test.c
 create mode 100644 reftable/system.h
 create mode 100644 reftable/test_framework.c
 create mode 100644 reftable/test_framework.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100644 reftable/tree_test.c
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100644 t/helper/test-reftable.c
 create mode 100755 t/t0031-reftable.sh
 create mode 100755 t/t0032-reftable-unittest.sh


base-commit: 13d7ab6b5d7929825b626f050b62a11241ea4945
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-847%2Fhanwen%2Flibreftable-v5
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-847/hanwen/libreftable-v5
Pull-Request: https://github.com/git/git/pull/847

Range-diff vs v4:

  1:  40ac041d0efe !  1:  e1d1d9f49807 init-db: set the_repository->hash_algo early on
     @@ builtin/init-db.c: int init_db(const char *git_dir, const char *real_git_dir,
      +	repo_set_hash_algo(the_repository, repo_fmt.hash_algo);
      +
       	reinit = create_default_files(template_dir, original_git_dir,
     - 				      initial_branch, &repo_fmt);
     - 	if (reinit && initial_branch)
     + 				      initial_branch, &repo_fmt,
     + 				      flags & INIT_DB_QUIET);
  2:  cc0fe58bd333 =  2:  502a66befabe reftable: add LICENSE
  3:  798f680b800b =  3:  1bd136f6a6df reftable: add error related functionality
  4:  2f55ff6d2406 !  4:  5bbbafb428e9 reftable: utility functions
     @@ t/helper/test-reftable.c (new)
      
       ## t/helper/test-tool.c ##
      @@ t/helper/test-tool.c: static struct test_cmd cmds[] = {
     - 	{ "path-utils", cmd__path_utils },
     + 	{ "pcre2-config", cmd__pcre2_config },
       	{ "pkt-line", cmd__pkt_line },
       	{ "prio-queue", cmd__prio_queue },
      -	{ "proc-receive", cmd__proc_receive},
  5:  aaa817f8598b =  5:  e41fa780882d reftable: add blocksource, an abstraction for random access reads
  6:  e13afe315258 !  6:  390eaca4fc8c reftable: (de)serialization for the polymorphic record type.
     @@ reftable/record.c (new)
      +{
      +	char hex[SHA256_SIZE + 1] = { 0 };
      +
     -+	printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n", log->refname,
     -+	       log->update_index, log->name, log->email, log->time,
     -+	       log->tz_offset);
     -+	hex_format(hex, log->old_hash, hash_size(hash_id));
     -+	printf("%s => ", hex);
     -+	hex_format(hex, log->new_hash, hash_size(hash_id));
     -+	printf("%s\n\n%s\n}\n", hex, log->message);
     ++	switch (log->value_type) {
     ++	case REFTABLE_LOG_DELETION:
     ++		printf("log{%s(%" PRIu64 ") delete", log->refname,
     ++		       log->update_index);
     ++		break;
     ++	case REFTABLE_LOG_UPDATE:
     ++		printf("log{%s(%" PRIu64 ") %s <%s> %" PRIu64 " %04d\n",
     ++		       log->refname, log->update_index, log->update.name,
     ++		       log->update.email, log->update.time,
     ++		       log->update.tz_offset);
     ++		hex_format(hex, log->update.old_hash, hash_size(hash_id));
     ++		printf("%s => ", hex);
     ++		hex_format(hex, log->update.new_hash, hash_size(hash_id));
     ++		printf("%s\n\n%s\n}\n", hex, log->update.message);
     ++		break;
     ++	}
      +}
      +
      +static void reftable_log_record_key(const void *r, struct strbuf *dest)
     @@ reftable/record.c (new)
      +	if (dst->refname != NULL) {
      +		dst->refname = xstrdup(dst->refname);
      +	}
     -+	if (dst->email != NULL) {
     -+		dst->email = xstrdup(dst->email);
     -+	}
     -+	if (dst->name != NULL) {
     -+		dst->name = xstrdup(dst->name);
     -+	}
     -+	if (dst->message != NULL) {
     -+		dst->message = xstrdup(dst->message);
     -+	}
     ++	switch (dst->value_type) {
     ++	case REFTABLE_LOG_DELETION:
     ++		break;
     ++	case REFTABLE_LOG_UPDATE:
     ++		if (dst->update.email != NULL) {
     ++			dst->update.email = xstrdup(dst->update.email);
     ++		}
     ++		if (dst->update.name != NULL) {
     ++			dst->update.name = xstrdup(dst->update.name);
     ++		}
     ++		if (dst->update.message != NULL) {
     ++			dst->update.message = xstrdup(dst->update.message);
     ++		}
      +
     -+	if (dst->new_hash != NULL) {
     -+		dst->new_hash = reftable_malloc(hash_size);
     -+		memcpy(dst->new_hash, src->new_hash, hash_size);
     -+	}
     -+	if (dst->old_hash != NULL) {
     -+		dst->old_hash = reftable_malloc(hash_size);
     -+		memcpy(dst->old_hash, src->old_hash, hash_size);
     ++		if (dst->update.new_hash != NULL) {
     ++			dst->update.new_hash = reftable_malloc(hash_size);
     ++			memcpy(dst->update.new_hash, src->update.new_hash,
     ++			       hash_size);
     ++		}
     ++		if (dst->update.old_hash != NULL) {
     ++			dst->update.old_hash = reftable_malloc(hash_size);
     ++			memcpy(dst->update.old_hash, src->update.old_hash,
     ++			       hash_size);
     ++		}
     ++		break;
      +	}
      +}
      +
     @@ reftable/record.c (new)
      +void reftable_log_record_release(struct reftable_log_record *r)
      +{
      +	reftable_free(r->refname);
     -+	reftable_free(r->new_hash);
     -+	reftable_free(r->old_hash);
     -+	reftable_free(r->name);
     -+	reftable_free(r->email);
     -+	reftable_free(r->message);
     ++	switch (r->value_type) {
     ++	case REFTABLE_LOG_DELETION:
     ++		break;
     ++	case REFTABLE_LOG_UPDATE:
     ++		reftable_free(r->update.new_hash);
     ++		reftable_free(r->update.old_hash);
     ++		reftable_free(r->update.name);
     ++		reftable_free(r->update.email);
     ++		reftable_free(r->update.message);
     ++		break;
     ++	}
      +	memset(r, 0, sizeof(struct reftable_log_record));
      +}
      +
     @@ reftable/record.c (new)
      +	struct reftable_log_record *r = (struct reftable_log_record *)rec;
      +	struct string_view start = s;
      +	int n = 0;
     -+	uint8_t *oldh = r->old_hash;
     -+	uint8_t *newh = r->new_hash;
     ++	uint8_t *oldh = NULL;
     ++	uint8_t *newh = NULL;
      +	if (reftable_log_record_is_deletion(r))
      +		return 0;
      +
     ++	oldh = r->update.old_hash;
     ++	newh = r->update.new_hash;
      +	if (oldh == NULL) {
      +		oldh = zero;
      +	}
     @@ reftable/record.c (new)
      +	memcpy(s.buf + hash_size, newh, hash_size);
      +	string_view_consume(&s, 2 * hash_size);
      +
     -+	n = encode_string(r->name ? r->name : "", s);
     ++	n = encode_string(r->update.name ? r->update.name : "", s);
      +	if (n < 0)
      +		return -1;
      +	string_view_consume(&s, n);
      +
     -+	n = encode_string(r->email ? r->email : "", s);
     ++	n = encode_string(r->update.email ? r->update.email : "", s);
      +	if (n < 0)
      +		return -1;
      +	string_view_consume(&s, n);
      +
     -+	n = put_var_int(&s, r->time);
     ++	n = put_var_int(&s, r->update.time);
      +	if (n < 0)
      +		return -1;
      +	string_view_consume(&s, n);
     @@ reftable/record.c (new)
      +	if (s.len < 2)
      +		return -1;
      +
     -+	put_be16(s.buf, r->tz_offset);
     ++	put_be16(s.buf, r->update.tz_offset);
      +	string_view_consume(&s, 2);
      +
     -+	n = encode_string(r->message ? r->message : "", s);
     ++	n = encode_string(r->update.message ? r->update.message : "", s);
      +	if (n < 0)
      +		return -1;
      +	string_view_consume(&s, n);
     @@ reftable/record.c (new)
      +
      +	r->update_index = (~max) - ts;
      +
     -+	if (val_type == 0) {
     -+		FREE_AND_NULL(r->old_hash);
     -+		FREE_AND_NULL(r->new_hash);
     -+		FREE_AND_NULL(r->message);
     -+		FREE_AND_NULL(r->email);
     -+		FREE_AND_NULL(r->name);
     -+		return 0;
     ++	if (val_type != r->value_type) {
     ++		switch (r->value_type) {
     ++		case REFTABLE_LOG_UPDATE:
     ++			FREE_AND_NULL(r->update.old_hash);
     ++			FREE_AND_NULL(r->update.new_hash);
     ++			FREE_AND_NULL(r->update.message);
     ++			FREE_AND_NULL(r->update.email);
     ++			FREE_AND_NULL(r->update.name);
     ++			break;
     ++		case REFTABLE_LOG_DELETION:
     ++			break;
     ++		}
      +	}
      +
     ++	r->value_type = val_type;
     ++	if (val_type == REFTABLE_LOG_DELETION)
     ++		return 0;
     ++
      +	if (in.len < 2 * hash_size)
      +		return REFTABLE_FORMAT_ERROR;
      +
     -+	r->old_hash = reftable_realloc(r->old_hash, hash_size);
     -+	r->new_hash = reftable_realloc(r->new_hash, hash_size);
     ++	r->update.old_hash = reftable_realloc(r->update.old_hash, hash_size);
     ++	r->update.new_hash = reftable_realloc(r->update.new_hash, hash_size);
      +
     -+	memcpy(r->old_hash, in.buf, hash_size);
     -+	memcpy(r->new_hash, in.buf + hash_size, hash_size);
     ++	memcpy(r->update.old_hash, in.buf, hash_size);
     ++	memcpy(r->update.new_hash, in.buf + hash_size, hash_size);
      +
      +	string_view_consume(&in, 2 * hash_size);
      +
     @@ reftable/record.c (new)
      +		goto done;
      +	string_view_consume(&in, n);
      +
     -+	r->name = reftable_realloc(r->name, dest.len + 1);
     -+	memcpy(r->name, dest.buf, dest.len);
     -+	r->name[dest.len] = 0;
     ++	r->update.name = reftable_realloc(r->update.name, dest.len + 1);
     ++	memcpy(r->update.name, dest.buf, dest.len);
     ++	r->update.name[dest.len] = 0;
      +
      +	strbuf_reset(&dest);
      +	n = decode_string(&dest, in);
     @@ reftable/record.c (new)
      +		goto done;
      +	string_view_consume(&in, n);
      +
     -+	r->email = reftable_realloc(r->email, dest.len + 1);
     -+	memcpy(r->email, dest.buf, dest.len);
     -+	r->email[dest.len] = 0;
     ++	r->update.email = reftable_realloc(r->update.email, dest.len + 1);
     ++	memcpy(r->update.email, dest.buf, dest.len);
     ++	r->update.email[dest.len] = 0;
      +
      +	ts = 0;
      +	n = get_var_int(&ts, &in);
      +	if (n < 0)
      +		goto done;
      +	string_view_consume(&in, n);
     -+	r->time = ts;
     ++	r->update.time = ts;
      +	if (in.len < 2)
      +		goto done;
      +
     -+	r->tz_offset = get_be16(in.buf);
     ++	r->update.tz_offset = get_be16(in.buf);
      +	string_view_consume(&in, 2);
      +
      +	strbuf_reset(&dest);
     @@ reftable/record.c (new)
      +		goto done;
      +	string_view_consume(&in, n);
      +
     -+	r->message = reftable_realloc(r->message, dest.len + 1);
     -+	memcpy(r->message, dest.buf, dest.len);
     -+	r->message[dest.len] = 0;
     ++	r->update.message = reftable_realloc(r->update.message, dest.len + 1);
     ++	memcpy(r->update.message, dest.buf, dest.len);
     ++	r->update.message[dest.len] = 0;
      +
      +	strbuf_release(&dest);
      +	return start.len - in.len;
     @@ reftable/record.c (new)
      +int reftable_log_record_equal(struct reftable_log_record *a,
      +			      struct reftable_log_record *b, int hash_size)
      +{
     -+	return null_streq(a->name, b->name) && null_streq(a->email, b->email) &&
     -+	       null_streq(a->message, b->message) &&
     -+	       zero_hash_eq(a->old_hash, b->old_hash, hash_size) &&
     -+	       zero_hash_eq(a->new_hash, b->new_hash, hash_size) &&
     -+	       a->time == b->time && a->tz_offset == b->tz_offset &&
     -+	       a->update_index == b->update_index;
     ++	if (!(null_streq(a->refname, b->refname) &&
     ++	      a->update_index == b->update_index &&
     ++	      a->value_type == b->value_type))
     ++		return 0;
     ++
     ++	switch (a->value_type) {
     ++	case REFTABLE_LOG_DELETION:
     ++		return 1;
     ++	case REFTABLE_LOG_UPDATE:
     ++		return null_streq(a->update.name, b->update.name) &&
     ++		       a->update.time == b->update.time &&
     ++		       a->update.tz_offset == b->update.tz_offset &&
     ++		       null_streq(a->update.email, b->update.email) &&
     ++		       null_streq(a->update.message, b->update.message) &&
     ++		       zero_hash_eq(a->update.old_hash, b->update.old_hash,
     ++				    hash_size) &&
     ++		       zero_hash_eq(a->update.new_hash, b->update.new_hash,
     ++				    hash_size);
     ++	}
     ++
     ++	abort();
      +}
      +
      +static int reftable_log_record_is_deletion_void(const void *p)
     @@ reftable/record.c (new)
      +
      +int reftable_log_record_is_deletion(const struct reftable_log_record *log)
      +{
     -+	return (log->new_hash == NULL && log->old_hash == NULL &&
     -+		log->name == NULL && log->email == NULL &&
     -+		log->message == NULL && log->time == 0 && log->tz_offset == 0 &&
     -+		log->message == NULL);
     ++	return (log->value_type == REFTABLE_LOG_DELETION);
      +}
      +
      +void string_view_consume(struct string_view *s, int n)
     @@ reftable/record.h (new)
       ## reftable/record_test.c (new) ##
      @@
      +/*
     -+Copyright 2020 Google LLC
     ++  Copyright 2020 Google LLC
      +
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     ++  Use of this source code is governed by a BSD-style
     ++  license that can be found in the LICENSE file or at
     ++  https://developers.google.com/open-source/licenses/bsd
      +*/
      +
      +#include "record.h"
     @@ reftable/record_test.c (new)
      +	struct reftable_log_record in[2] = {
      +		{
      +			.refname = xstrdup("refs/heads/master"),
     -+			.old_hash = reftable_malloc(SHA1_SIZE),
     -+			.new_hash = reftable_malloc(SHA1_SIZE),
     -+			.name = xstrdup("han-wen"),
     -+			.email = xstrdup("hanwen@google.com"),
     -+			.message = xstrdup("test"),
      +			.update_index = 42,
     -+			.time = 1577123507,
     -+			.tz_offset = 100,
     ++			.value_type = REFTABLE_LOG_UPDATE,
     ++			.update = {
     ++				.old_hash = reftable_malloc(SHA1_SIZE),
     ++				.new_hash = reftable_malloc(SHA1_SIZE),
     ++				.name = xstrdup("han-wen"),
     ++				.email = xstrdup("hanwen@google.com"),
     ++				.message = xstrdup("test"),
     ++				.time = 1577123507,
     ++				.tz_offset = 100,
     ++			}
      +		},
      +		{
      +			.refname = xstrdup("refs/heads/master"),
      +			.update_index = 22,
     ++			.value_type = REFTABLE_LOG_DELETION,
      +		}
      +	};
     -+	set_test_hash(in[0].new_hash, 1);
     -+	set_test_hash(in[0].old_hash, 2);
     ++	set_test_hash(in[0].update.new_hash, 1);
     ++	set_test_hash(in[0].update.old_hash, 2);
      +	for (int i = 0; i < ARRAY_SIZE(in); i++) {
      +		struct reftable_record rec = { NULL };
      +		struct strbuf key = STRBUF_INIT;
     @@ reftable/record_test.c (new)
      +		/* populate out, to check for leaks. */
      +		struct reftable_log_record out = {
      +			.refname = xstrdup("old name"),
     -+			.new_hash = reftable_calloc(SHA1_SIZE),
     -+			.old_hash = reftable_calloc(SHA1_SIZE),
     -+			.name = xstrdup("old name"),
     -+			.email = xstrdup("old@email"),
     -+			.message = xstrdup("old message"),
     ++			.value_type = REFTABLE_LOG_UPDATE,
     ++			.update = {
     ++				.new_hash = reftable_calloc(SHA1_SIZE),
     ++				.old_hash = reftable_calloc(SHA1_SIZE),
     ++				.name = xstrdup("old name"),
     ++				.email = xstrdup("old@email"),
     ++				.message = xstrdup("old message"),
     ++			},
      +		};
      +		struct reftable_record rec_out = { NULL };
      +		int n, m, valtype;
     @@ reftable/reftable-record.h (new)
      +	char *refname;
      +	uint64_t update_index; /* logical timestamp of a transactional update.
      +				*/
     -+	uint8_t *new_hash;
     -+	uint8_t *old_hash;
     -+	char *name;
     -+	char *email;
     -+	uint64_t time;
     -+	int16_t tz_offset;
     -+	char *message;
     ++
     ++	enum {
     ++		/* tombstone to hide deletions from earlier tables */
     ++		REFTABLE_LOG_DELETION = 0x0,
     ++
     ++		/* a simple update */
     ++		REFTABLE_LOG_UPDATE = 0x1,
     ++#define REFTABLE_NR_LOG_VALUETYPES 2
     ++	} value_type;
     ++
     ++	union {
     ++		struct {
     ++			uint8_t *new_hash;
     ++			uint8_t *old_hash;
     ++			char *name;
     ++			char *email;
     ++			uint64_t time;
     ++			int16_t tz_offset;
     ++			char *message;
     ++		} update;
     ++	};
      +};
      +
      +/* returns whether 'ref' represents the deletion of a log record. */
  7:  a48b9937642e =  7:  b108525009d9 reftable: reading/writing blocks
  8:  6968dbc3828f =  8:  b6eed7283aac reftable: a generic binary tree implementation
  9:  ff5b424d12fb !  9:  f2f005afca19 reftable: write reftable files
     @@ reftable/writer.c (new)
      +	return err;
      +}
      +
     -+int reftable_writer_add_log(struct reftable_writer *w,
     -+			    struct reftable_log_record *log)
     ++static int reftable_writer_add_log_verbatim(struct reftable_writer *w,
     ++					    struct reftable_log_record *log)
      +{
      +	struct reftable_record rec = { NULL };
     -+	char *input_log_message = log->message;
     -+	struct strbuf cleaned_message = STRBUF_INIT;
     -+	int err;
     -+	if (log->refname == NULL)
     -+		return REFTABLE_API_ERROR;
     -+
      +	if (w->block_writer != NULL &&
      +	    block_writer_type(w->block_writer) == BLOCK_TYPE_REF) {
      +		int err = writer_finish_public_section(w);
     @@ reftable/writer.c (new)
      +			return err;
      +	}
      +
     -+	if (!w->opts.exact_log_message && log->message != NULL) {
     -+		strbuf_addstr(&cleaned_message, log->message);
     ++	w->next -= w->pending_padding;
     ++	w->pending_padding = 0;
     ++
     ++	reftable_record_from_log(&rec, log);
     ++	return writer_add_record(w, &rec);
     ++}
     ++
     ++int reftable_writer_add_log(struct reftable_writer *w,
     ++			    struct reftable_log_record *log)
     ++{
     ++	char *input_log_message = NULL;
     ++	struct strbuf cleaned_message = STRBUF_INIT;
     ++	int err = 0;
     ++
     ++	if (log->value_type == REFTABLE_LOG_DELETION)
     ++		return reftable_writer_add_log_verbatim(w, log);
     ++
     ++	if (log->refname == NULL)
     ++		return REFTABLE_API_ERROR;
     ++
     ++	input_log_message = log->update.message;
     ++	if (!w->opts.exact_log_message && log->update.message != NULL) {
     ++		strbuf_addstr(&cleaned_message, log->update.message);
      +		while (cleaned_message.len &&
      +		       cleaned_message.buf[cleaned_message.len - 1] == '\n')
      +			strbuf_setlen(&cleaned_message,
     @@ reftable/writer.c (new)
      +			goto done;
      +		}
      +		strbuf_addstr(&cleaned_message, "\n");
     -+		log->message = cleaned_message.buf;
     ++		log->update.message = cleaned_message.buf;
      +	}
      +
     -+	w->next -= w->pending_padding;
     -+	w->pending_padding = 0;
     -+
     -+	reftable_record_from_log(&rec, log);
     -+	err = writer_add_record(w, &rec);
     -+
     ++	err = reftable_writer_add_log_verbatim(w, log);
     ++	log->update.message = input_log_message;
      +done:
     -+	log->message = input_log_message;
      +	strbuf_release(&cleaned_message);
      +	return err;
      +}
 10:  3c2de7dcc65c = 10:  1f17d5edab52 reftable: read reftable files
 11:  03681b820d13 ! 11:  c916629c562a reftable: reftable file level tests
     @@ reftable/reftable_test.c (new)
      +		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
      +
      +		log.refname = name;
     -+		log.new_hash = hash;
      +		log.update_index = update_index;
     -+		log.message = "message";
     ++		log.value_type = REFTABLE_LOG_UPDATE;
     ++		log.update.new_hash = hash;
     ++		log.update.message = "message";
      +
      +		n = reftable_writer_add_log(w, &log);
      +		EXPECT(n == 0);
     @@ reftable/reftable_test.c (new)
      +		.block_size = 4096,
      +	};
      +	int err;
     -+	struct reftable_log_record log = {
     -+		.refname = "refs/heads/master",
     -+		.name = "Han-Wen Nienhuys",
     -+		.email = "hanwen@google.com",
     -+		.tz_offset = 100,
     -+		.time = 0x5e430672,
     -+		.update_index = 0xa,
     -+		.message = "commit: 9\n",
     -+	};
     ++	struct reftable_log_record log = { .refname = "refs/heads/master",
     ++					   .update_index = 0xa,
     ++					   .value_type = REFTABLE_LOG_UPDATE,
     ++					   .update = {
     ++						   .name = "Han-Wen Nienhuys",
     ++						   .email = "hanwen@google.com",
     ++						   .tz_offset = 100,
     ++						   .time = 0x5e430672,
     ++						   .message = "commit: 9\n",
     ++					   } };
      +	struct reftable_writer *w =
      +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +
     @@ reftable/reftable_test.c (new)
      +		hash1[i] = (uint8_t)(rand() % 256);
      +		hash2[i] = (uint8_t)(rand() % 256);
      +	}
     -+	log.old_hash = hash1;
     -+	log.new_hash = hash2;
     ++	log.update.old_hash = hash1;
     ++	log.update.new_hash = hash2;
      +	reftable_writer_set_limits(w, update_index, update_index);
      +	err = reftable_writer_add_log(w, &log);
      +	EXPECT_ERR(err);
     @@ reftable/reftable_test.c (new)
      +
      +		log.refname = names[i];
      +		log.update_index = i;
     -+		log.old_hash = hash1;
     -+		log.new_hash = hash2;
     ++		log.value_type = REFTABLE_LOG_UPDATE;
     ++		log.update.old_hash = hash1;
     ++		log.update.new_hash = hash2;
      +
      +		err = reftable_writer_add_log(w, &log);
      +		EXPECT_ERR(err);
 12:  557183d3e3e2 ! 12:  28aa69f7bbcb reftable: rest of library
     @@ Makefile: REFTABLE_OBJS += reftable/error.o
      
       ## reftable/VERSION (new) ##
      @@
     -+9b4a54059db9a05c270c0a0587f245bc6868d576 C: use rand() rather than cobbled together random generator.
     ++a337d48d4d42d513d6baa33addc172f0e0e36288 C: use tagged union for reftable_log_record
      
       ## reftable/dump.c (new) ##
      @@
     @@ reftable/stack.c (new)
      +			continue;
      +		}
      +
     -+		if (config != NULL && config->time > 0 &&
     -+		    log.time < config->time) {
     ++		if (config != NULL && config->min_update_index > 0 &&
     ++		    log.update_index < config->min_update_index) {
      +			continue;
      +		}
      +
     -+		if (config != NULL && config->min_update_index > 0 &&
     -+		    log.update_index < config->min_update_index) {
     ++		if (config != NULL && config->time > 0 &&
     ++		    log.update.time < config->time) {
      +			continue;
      +		}
      +
     @@ reftable/stack_test.c (new)
      +
      +		logs[i].refname = xstrdup(buf);
      +		logs[i].update_index = N + i + 1;
     -+		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
     -+		logs[i].email = xstrdup("identity@invalid");
     -+		set_test_hash(logs[i].new_hash, i);
     ++		logs[i].value_type = REFTABLE_LOG_UPDATE;
     ++
     ++		logs[i].update.new_hash = reftable_malloc(SHA1_SIZE);
     ++		logs[i].update.email = xstrdup("identity@invalid");
     ++		set_test_hash(logs[i].update.new_hash, i);
      +	}
      +
      +	for (i = 0; i < N; i++) {
     @@ reftable/stack_test.c (new)
      +
      +	uint8_t h1[SHA1_SIZE] = { 0x01 }, h2[SHA1_SIZE] = { 0x02 };
      +
     -+	struct reftable_log_record input = {
     -+		.refname = "branch",
     -+		.update_index = 1,
     -+		.new_hash = h1,
     -+		.old_hash = h2,
     -+	};
     ++	struct reftable_log_record input = { .refname = "branch",
     ++					     .update_index = 1,
     ++					     .value_type = REFTABLE_LOG_UPDATE,
     ++					     .update = {
     ++						     .new_hash = h1,
     ++						     .old_hash = h2,
     ++					     } };
      +	struct reftable_log_record dest = {
      +		.update_index = 0,
      +	};
     @@ reftable/stack_test.c (new)
      +	err = reftable_new_stack(&st, dir, cfg);
      +	EXPECT_ERR(err);
      +
     -+	input.message = "one\ntwo";
     ++	input.update.message = "one\ntwo";
      +	err = reftable_stack_add(st, &write_test_log, &arg);
      +	EXPECT(err == REFTABLE_API_ERROR);
      +
     -+	input.message = "one";
     ++	input.update.message = "one";
      +	err = reftable_stack_add(st, &write_test_log, &arg);
      +	EXPECT_ERR(err);
      +
      +	err = reftable_stack_read_log(st, input.refname, &dest);
      +	EXPECT_ERR(err);
     -+	EXPECT(0 == strcmp(dest.message, "one\n"));
     ++	EXPECT(0 == strcmp(dest.update.message, "one\n"));
      +
     -+	input.message = "two\n";
     ++	input.update.message = "two\n";
      +	arg.update_index = 2;
      +	err = reftable_stack_add(st, &write_test_log, &arg);
      +	EXPECT_ERR(err);
      +	err = reftable_stack_read_log(st, input.refname, &dest);
      +	EXPECT_ERR(err);
     -+	EXPECT(0 == strcmp(dest.message, "two\n"));
     ++	EXPECT(0 == strcmp(dest.update.message, "two\n"));
      +
      +	/* cleanup */
      +	reftable_stack_destroy(st);
     @@ reftable/stack_test.c (new)
      +			refs[i].value.val1 = reftable_malloc(SHA1_SIZE);
      +			set_test_hash(refs[i].value.val1, i);
      +		}
     ++
      +		logs[i].refname = xstrdup(buf);
      +		/* update_index is part of the key. */
      +		logs[i].update_index = 42;
      +		if (i % 2 == 0) {
     -+			logs[i].new_hash = reftable_malloc(SHA1_SIZE);
     -+			set_test_hash(logs[i].new_hash, i);
     -+			logs[i].email = xstrdup("identity@invalid");
     ++			logs[i].value_type = REFTABLE_LOG_UPDATE;
     ++			logs[i].update.new_hash = reftable_malloc(SHA1_SIZE);
     ++			set_test_hash(logs[i].update.new_hash, i);
     ++			logs[i].update.email = xstrdup("identity@invalid");
      +		}
      +	}
      +	for (i = 0; i < N; i++) {
     @@ reftable/stack_test.c (new)
      +
      +		logs[i].refname = xstrdup(buf);
      +		logs[i].update_index = i;
     -+		logs[i].time = i;
     -+		logs[i].new_hash = reftable_malloc(SHA1_SIZE);
     -+		logs[i].email = xstrdup("identity@invalid");
     -+		set_test_hash(logs[i].new_hash, i);
     ++		logs[i].value_type = REFTABLE_LOG_UPDATE;
     ++		logs[i].update.time = i;
     ++		logs[i].update.new_hash = reftable_malloc(SHA1_SIZE);
     ++		logs[i].update.email = xstrdup("identity@invalid");
     ++		set_test_hash(logs[i].update.new_hash, i);
      +	}
      +
      +	for (i = 1; i <= N; i++) {
 13:  d57023d9f13d ! 13:  bdb19af22cc7 Reftable support for git-core
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
          Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
     +    Helped-by: Junio Hamano <gitster@pobox.com>
          Co-authored-by: Jeff King <peff@peff.net>
      
       ## Documentation/config/extensions.txt ##
     @@ builtin/init-db.c: int cmd_init_db(int argc, const char **argv, const char *pref
      
       ## builtin/worktree.c ##
      @@
     - #include "submodule.h"
       #include "utf8.h"
       #include "worktree.h"
     + #include "quote.h"
      +#include "../refs/refs-internal.h"
       
       static const char * const worktree_usage[] = {
     @@ refs/reftable-backend.c (new)
      +
      +static void clear_reftable_log_record(struct reftable_log_record *log)
      +{
     -+	log->old_hash = NULL;
     -+	log->new_hash = NULL;
     -+	log->message = NULL;
      +	log->refname = NULL;
     ++	switch (log->value_type) {
     ++	case REFTABLE_LOG_UPDATE:
     ++		log->update.old_hash = NULL;
     ++		log->update.new_hash = NULL;
     ++		log->update.message = NULL;
     ++		break;
     ++	case REFTABLE_LOG_DELETION:
     ++		break;
     ++	}
      +	reftable_log_record_release(log);
      +}
      +
     @@ refs/reftable-backend.c (new)
      +	assert(0 == result);
      +
      +	reftable_log_record_release(log);
     -+	log->name =
     ++	log->value_type = REFTABLE_LOG_UPDATE;
     ++	log->update.name =
      +		xstrndup(split.name_begin, split.name_end - split.name_begin);
     -+	log->email =
     ++	log->update.email =
      +		xstrndup(split.mail_begin, split.mail_end - split.mail_begin);
     -+	log->time = atol(split.date_begin);
     ++	log->update.time = atol(split.date_begin);
      +	if (*split.tz_begin == '-') {
      +		sign = -1;
      +		split.tz_begin++;
     @@ refs/reftable-backend.c (new)
      +		split.tz_begin++;
      +	}
      +
     -+	log->tz_offset = sign * atoi(split.tz_begin);
     ++	log->update.tz_offset = sign * atoi(split.tz_begin);
      +}
      +
      +static int has_suffix(struct strbuf *b, const char *suffix)
     @@ refs/reftable-backend.c (new)
      +		struct ref_update *u = sorted[i];
      +		struct reftable_log_record *log = &logs[i];
      +		fill_reftable_log_record(log);
     -+		log->refname = (char *)u->refname;
     -+		log->old_hash = u->old_oid.hash;
     -+		log->new_hash = u->new_oid.hash;
      +		log->update_index = ts;
     -+		log->message = u->msg;
     ++		log->value_type = REFTABLE_LOG_UPDATE;
     ++		log->refname = (char *)u->refname;
     ++		log->update.old_hash = u->old_oid.hash;
     ++		log->update.new_hash = u->new_oid.hash;
     ++		log->update.message = u->msg;
      +
      +		if (u->flags & REF_LOG_ONLY) {
      +			continue;
     @@ refs/reftable-backend.c (new)
      +		};
      +		struct reftable_ref_record current = { NULL };
      +		fill_reftable_log_record(&log);
     -+		log.message = xstrdup(arg->logmsg);
     -+		log.new_hash = NULL;
     -+		log.old_hash = NULL;
      +		log.update_index = ts;
      +		log.refname = (char *)arg->refnames->items[i].string;
      +
     ++		log.update.message = xstrdup(arg->logmsg);
     ++		log.update.new_hash = NULL;
     ++		log.update.old_hash = NULL;
      +		if (reftable_stack_read_ref(arg->stack, log.refname,
      +					    &current) == 0) {
     -+			log.old_hash = reftable_ref_record_val1(&current);
     ++			log.update.old_hash =
     ++				reftable_ref_record_val1(&current);
      +		}
      +		err = reftable_writer_add_log(writer, &log);
     -+		log.old_hash = NULL;
     ++		log.update.old_hash = NULL;
      +		reftable_ref_record_release(&current);
      +
      +		clear_reftable_log_record(&log);
     @@ refs/reftable-backend.c (new)
      +
      +		fill_reftable_log_record(&log);
      +		log.refname = (char *)create->refname;
     -+		log.message = (char *)create->logmsg;
      +		log.update_index = ts;
     ++		log.update.message = (char *)create->logmsg;
      +		if (refs_resolve_ref_unsafe(
      +			    (struct ref_store *)create->refs, create->refname,
      +			    RESOLVE_REF_READING, &old_oid, NULL) != NULL) {
     -+			log.old_hash = old_oid.hash;
     ++			log.update.old_hash = old_oid.hash;
      +		}
      +
      +		if (refs_resolve_ref_unsafe((struct ref_store *)create->refs,
      +					    create->target, RESOLVE_REF_READING,
      +					    &new_oid, NULL) != NULL) {
     -+			log.new_hash = new_oid.hash;
     ++			log.update.new_hash = new_oid.hash;
      +		}
      +
     -+		if (log.old_hash != NULL || log.new_hash != NULL) {
     ++		if (log.update.old_hash != NULL ||
     ++		    log.update.new_hash != NULL) {
      +			err = reftable_writer_add_log(writer, &log);
      +		}
      +		log.refname = NULL;
     -+		log.message = NULL;
     -+		log.old_hash = NULL;
     -+		log.new_hash = NULL;
     ++		log.update.message = NULL;
     ++		log.update.old_hash = NULL;
     ++		log.update.new_hash = NULL;
      +		clear_reftable_log_record(&log);
      +	}
      +	return err;
     @@ refs/reftable-backend.c (new)
      +
      +		todo[0].refname = (char *)arg->oldname;
      +		todo[0].update_index = ts;
     -+		todo[0].message = (char *)arg->logmsg;
     -+		todo[0].old_hash = val1;
     -+		todo[0].new_hash = NULL;
     ++		todo[0].update.message = (char *)arg->logmsg;
     ++		todo[0].update.old_hash = val1;
     ++		todo[0].update.new_hash = NULL;
      +
      +		todo[1].refname = (char *)arg->newname;
      +		todo[1].update_index = ts;
     -+		todo[1].old_hash = NULL;
     -+		todo[1].new_hash = val1;
     -+		todo[1].message = (char *)arg->logmsg;
     ++		todo[1].update.old_hash = NULL;
     ++		todo[1].update.new_hash = val1;
     ++		todo[1].update.message = (char *)arg->logmsg;
      +
      +		err = reftable_writer_add_logs(writer, todo, 2);
      +
     @@ refs/reftable-backend.c (new)
      +
      +		free(ri->last_name);
      +		ri->last_name = xstrdup(ri->log.refname);
     -+		hashcpy(ri->oid.hash, ri->log.new_hash);
     ++		hashcpy(ri->oid.hash, ri->log.update.new_hash);
      +		return ITER_OK;
      +	}
      +}
     @@ refs/reftable-backend.c (new)
      +static struct ref_iterator *
      +git_reftable_reflog_iterator_begin(struct ref_store *ref_store)
      +{
     -+	struct git_reftable_reflog_ref_iterator *ri = xcalloc(sizeof(*ri), 1);
     ++	struct git_reftable_reflog_ref_iterator *ri = xcalloc(1, sizeof(*ri));
      +	struct git_reftable_ref_store *refs =
      +		(struct git_reftable_ref_store *)ref_store;
      +
     @@ refs/reftable-backend.c (new)
      +			break;
      +		}
      +
     -+		hashcpy(old_oid.hash, log.old_hash);
     -+		hashcpy(new_oid.hash, log.new_hash);
     ++		hashcpy(old_oid.hash, log.update.old_hash);
     ++		hashcpy(new_oid.hash, log.update.new_hash);
      +
     -+		full_committer = fmt_ident(log.name, log.email,
     ++		full_committer = fmt_ident(log.update.name, log.update.email,
      +					   WANT_COMMITTER_IDENT,
      +					   /*date*/ NULL, IDENT_NO_DATE);
     -+		err = fn(&old_oid, &new_oid, full_committer, log.time,
     -+			 log.tz_offset, log.message, cb_data);
     ++		err = fn(&old_oid, &new_oid, full_committer, log.update.time,
     ++			 log.update.tz_offset, log.update.message, cb_data);
      +		if (err)
      +			break;
      +	}
     @@ refs/reftable-backend.c (new)
      +		struct object_id new_oid;
      +		const char *full_committer = "";
      +
     -+		hashcpy(old_oid.hash, log->old_hash);
     -+		hashcpy(new_oid.hash, log->new_hash);
     ++		hashcpy(old_oid.hash, log->update.old_hash);
     ++		hashcpy(new_oid.hash, log->update.new_hash);
      +
     -+		full_committer = fmt_ident(log->name, log->email,
     ++		full_committer = fmt_ident(log->update.name, log->update.email,
      +					   WANT_COMMITTER_IDENT, NULL,
      +					   IDENT_NO_DATE);
     -+		err = fn(&old_oid, &new_oid, full_committer, log->time,
     -+			 log->tz_offset, log->message, cb_data);
     ++		err = fn(&old_oid, &new_oid, full_committer, log->update.time,
     ++			 log->update.tz_offset, log->update.message, cb_data);
      +		if (err) {
      +			break;
      +		}
     @@ refs/reftable-backend.c (new)
      +		if (err > 0 || strcmp(log.refname, refname)) {
      +			break;
      +		}
     -+		hashcpy(ooid.hash, log.old_hash);
     -+		hashcpy(noid.hash, log.new_hash);
     ++		hashcpy(ooid.hash, log.update.old_hash);
     ++		hashcpy(noid.hash, log.update.new_hash);
      +
     -+		if (should_prune_fn(&ooid, &noid, log.email,
     -+				    (timestamp_t)log.time, log.tz_offset,
     -+				    log.message, policy_cb_data)) {
     ++		if (should_prune_fn(&ooid, &noid, log.update.email,
     ++				    (timestamp_t)log.update.time,
     ++				    log.update.tz_offset, log.update.message,
     ++				    policy_cb_data)) {
      +			add_log_tombstone(&arg, refname, log.update_index);
      +		}
      +	}
     @@ t/t0031-reftable.sh (new)
      +
      +INVALID_SHA1=aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa
      +
     ++git_init () {
     ++	git init -b primary "$@"
     ++}
     ++
      +initialize ()  {
      +	rm -rf .git &&
     -+	git init --ref-storage=reftable &&
     ++	git_init --ref-storage=reftable &&
      +	mv .git/hooks .git/hooks-disabled
      +}
      +
      +test_expect_success 'SHA256 support, env' '
      +	rm -rf .git &&
      +	GIT_DEFAULT_HASH=sha256 && export GIT_DEFAULT_HASH &&
     -+	git init --ref-storage=reftable &&
     ++	git_init --ref-storage=reftable &&
      +	mv .git/hooks .git/hooks-disabled &&
      +	test_commit file
      +'
      +
      +test_expect_success 'SHA256 support, option' '
      +	rm -rf .git &&
     -+	git init --ref-storage=reftable --object-format=sha256 &&
     ++	git_init --ref-storage=reftable --object-format=sha256 &&
      +	mv .git/hooks .git/hooks-disabled &&
      +	test_commit file
      +'
     @@ t/t0031-reftable.sh (new)
      +	initialize &&
      +	test_commit file &&
      +	SHA=$(git show-ref -s --verify HEAD) &&
     -+	test_write_lines "$SHA refs/heads/master" "$SHA refs/tags/file" >expect &&
     -+	git show-ref > actual &&
     ++	test_write_lines "$SHA refs/heads/primary" "$SHA refs/tags/file" >expect &&
     ++	git show-ref >actual &&
      +	! git update-ref -d refs/tags/file $INVALID_SHA1 &&
      +	test_cmp expect actual &&
      +	git update-ref -d refs/tags/file $SHA  &&
     -+	test_write_lines "$SHA refs/heads/master" >expect &&
     -+	git show-ref > actual &&
     ++	test_write_lines "$SHA refs/heads/primary" >expect &&
     ++	git show-ref >actual &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t0031-reftable.sh (new)
      +test_expect_success 'basic operation of reftable storage: commit, show-ref' '
      +	initialize &&
      +	test_commit file &&
     -+	test_write_lines refs/heads/master refs/tags/file >expect &&
     ++	test_write_lines refs/heads/primary refs/tags/file >expect &&
      +	git show-ref &&
     -+	git show-ref | cut -f2 -d" " > actual &&
     ++	git show-ref | cut -f2 -d" " >actual &&
      +	test_cmp actual expect
      +'
      +
     @@ t/t0031-reftable.sh (new)
      +	git pack-refs &&
      +	ls -1 .git/reftable >table-files &&
      +	test_line_count = 2 table-files &&
     -+	git reflog refs/heads/master >output &&
     ++	git reflog refs/heads/primary >output &&
      +	test_line_count = 10 output &&
      +	grep "commit (initial): number 1" output &&
      +	grep "commit: number 10" output &&
      +	git gc &&
     -+	git reflog refs/heads/master >output &&
     ++	git reflog refs/heads/primary >output &&
      +	test_line_count = 0 output
      +'
      +
     @@ t/t0031-reftable.sh (new)
      +	test_commit file2 &&
      +	git checkout -b branch2 &&
      +	git switch - &&
     -+	git rev-parse --symbolic-full-name HEAD > actual &&
     -+	echo refs/heads/branch1 > expect &&
     ++	git rev-parse --symbolic-full-name HEAD >actual &&
     ++	echo refs/heads/branch1 >expect &&
      +	test_cmp actual expect
      +'
      +
     @@ t/t0031-reftable.sh (new)
      +	test_commit file &&
      +	git tag -m "annotated tag" test_tag HEAD &&
      +	{
     -+		print_ref "refs/heads/master" &&
     ++		print_ref "refs/heads/primary" &&
      +		print_ref "refs/tags/file" &&
      +		print_ref "refs/tags/test_tag" &&
      +		print_ref "refs/tags/test_tag^{}"
     @@ t/t0031-reftable.sh (new)
      +test_expect_success 'show-ref works on fresh repo' '
      +	initialize &&
      +	rm -rf .git &&
     -+	git init --ref-storage=reftable &&
     ++	git_init --ref-storage=reftable &&
      +	>expect &&
     -+	! git show-ref > actual &&
     ++	! git show-ref >actual &&
      +	test_cmp expect actual
      +'
      +
      +test_expect_success 'checkout unborn branch' '
      +	initialize &&
     -+	git checkout -b master
     ++	git checkout -b primary
      +'
      +
      +
      +test_expect_success 'dir/file conflict' '
      +	initialize &&
      +	test_commit file &&
     -+	! git branch master/forbidden
     ++	! git branch primary/forbidden
      +'
      +
      +
      +test_expect_success 'do not clobber existing repo' '
      +	rm -rf .git &&
     -+	git init --ref-storage=files &&
     -+	cat .git/HEAD > expect &&
     ++	git_init --ref-storage=files &&
     ++	cat .git/HEAD >expect &&
      +	test_commit file &&
     -+	(git init --ref-storage=reftable || true) &&
     -+	cat .git/HEAD > actual &&
     ++	(git_init --ref-storage=reftable || true) &&
     ++	cat .git/HEAD >actual &&
      +	test_cmp expect actual
      +'
      +
     @@ t/t0031-reftable.sh (new)
      +'
      +
      +test_expect_success 'worktrees' '
     -+	git init --ref-storage=reftable start &&
     ++	git_init --ref-storage=reftable start &&
      +	(cd start && test_commit file1 && git checkout -b branch1 &&
      +	git checkout -b branch2 &&
      +	git worktree add  ../wt
     @@ t/t0031-reftable.sh (new)
      +	initialize &&
      +	test_commit file1 &&
      +	mkdir existing_empty &&
     -+	git worktree add --detach existing_empty master
     ++	git worktree add --detach existing_empty primary
      +'
      +
      +test_expect_success 'FETCH_HEAD' '
      +	initialize &&
      +	test_commit one &&
     -+	(git init sub && cd sub && test_commit two) &&
     ++	(git_init sub && cd sub && test_commit two) &&
      +	git --git-dir sub/.git rev-parse HEAD >expect &&
      +	git fetch sub &&
      +	git checkout FETCH_HEAD &&
     @@ t/t1450-fsck.sh: test_description='git fsck random collection of tests
       	git config i18n.commitencoding ISO-8859-1 &&
      
       ## t/t3210-pack-refs.sh ##
     -@@ t/t3210-pack-refs.sh: semantic is still the same.
     - '
     +@@ t/t3210-pack-refs.sh: export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
     + 
       . ./test-lib.sh
       
      +if test_have_prereq REFTABLE
 14:  9df5bc69f971 = 14:  0d9477941678 git-prompt: prepare for reftable refs backend
 15:  4076ef5d20b4 = 15:  59f432522230 Add "test-tool dump-reftable" command.

-- 
gitgitgadget
