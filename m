Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145ADC43460
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA8D561358
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 19:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245256AbhDLT0V (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 15:26:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237201AbhDLT0Q (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 15:26:16 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1BAC061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:25:56 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id f12so14122506wro.0
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 12:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=A+4OTyjkZ1UF9+I0OC8rkrXgQl0x21iucEyB1Zd+exo=;
        b=XENNYU3+q5cIf48LyGg64rYY1+tZbQm/i9GKgruQnd+4qigFa/Ww+N4iPNbthpbAjm
         die/T7lp1hf/6rIIXIyDBQZ5ioSlwhbrfc0mvcgWrgSBjTXCGN66wrnlTsxU4Rjb+auy
         pGn7SnlCS/o0HAyRvrGs6Rnd7/+6Km/P3cN8OeBPDHRU+c45qMQtgUvMYMYYFn0FuPEF
         pt8dVQdUc1jxvV5vhVoYgCvmHCr38cubrUpphyjXvoxAgv21bZJKFV8TKLHEMrx8wzix
         JZhYQEfbM/G/UBdmmybdKlnR+jF6neVRe9JAoxGyLESloEr/VjPmV1LdPj1KS6suEi5t
         HgNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=A+4OTyjkZ1UF9+I0OC8rkrXgQl0x21iucEyB1Zd+exo=;
        b=fPxpm1Iu1DoTXy7EaugFGdzL+SQvTZQMwE/nkWxLoMx49/QS59d1ZhoH60IwrF5DfG
         QG+05SLh6mOsplZfAMAQXXUvVJI7RNLkuI5OduaCCqyWVHgDHnolCJyq51p1kFqw8fYN
         6uREMjf6TiUO8atGkkp3jiqjIjKwBJc/1boUNciq/W/i2hrivn4Y1ophP3vARrnrn2Ex
         mQ53GaJeljZbqDkBeHF7rVi8IOmvstY1eMS2k1369Kbx2wzzgvq8LlITL5DmCBX0C1rY
         j7UdVRxw/CSbdzSOc2fl3rd8GHx/LiyPacmkFcugVk/eFa5VhPxIQr1z/ktbRVKIm7lx
         fDtA==
X-Gm-Message-State: AOAM5339VKDHVgJkzCQkEuUEVAVsZYITXYDC8gdj2ND+dXQIh/LxaHmL
        si4x4YuzmZqfXa2PS1pr9oCK4YNAvHw=
X-Google-Smtp-Source: ABdhPJy1LjeyPIZK7M2aCgu62EiP1kJoMJC+4YWu6gTQa8LqrdLSDgYPqjvsiDBw3urwEZRhtfO/3A==
X-Received: by 2002:a5d:6182:: with SMTP id j2mr6940166wru.317.1618255555148;
        Mon, 12 Apr 2021 12:25:55 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id r22sm287294wmh.11.2021.04.12.12.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 12:25:54 -0700 (PDT)
Message-Id: <pull.847.v6.git.git.1618255552.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
References: <pull.847.v5.git.git.1615580397.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 19:25:32 +0000
Subject: [PATCH v6 00/20] reftable library
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
        Derrick Stolee <stolee@gmail.com>,
        Han-Wen Nienhuys <hanwenn@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This splits the giant commit from
https://github.com/gitgitgadget/git/pull/539 into a series of smaller
commits, which build and have unittests.

version 12 Apr 2021:

 * handle cleanup for concurrent access on Windows
 * split up commits further

Based on github.com/hanwen/reftable at
c33a40ad23dd622d8c72139c41a2be1cfa063e5f Add random suffix to table names

Han-Wen Nienhuys (19):
  init-db: set the_repository->hash_algo early on
  reftable: add LICENSE
  reftable: add error related functionality
  reftable: utility functions
  reftable: add blocksource, an abstraction for random access reads
  reftable: (de)serialization for the polymorphic record type.
  reftable: reading/writing blocks
  reftable: a generic binary tree implementation
  reftable: write reftable files
  reftable: generic interface to tables
  reftable: read reftable files
  reftable: reftable file level tests
  reftable: add a heap-based priority queue for reftable records
  reftable: add merged table view
  reftable: implement refname validation
  reftable: implement stack, a mutable database of reftable files.
  reftable: add dump utility
  Reftable support for git-core
  Add "test-tool dump-reftable" command.

SZEDER Gábor (1):
  git-prompt: prepare for reftable refs backend

 Documentation/config/extensions.txt           |    9 +
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   48 +-
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
 refs/reftable-backend.c                       | 1451 +++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
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
 reftable/generic.h                            |   32 +
 reftable/iter.c                               |  197 +++
 reftable/iter.h                               |   67 +
 reftable/merged.c                             |  367 +++++
 reftable/merged.h                             |   35 +
 reftable/merged_test.c                        |  291 ++++
 reftable/pq.c                                 |  115 ++
 reftable/pq.h                                 |   32 +
 reftable/pq_test.c                            |   72 +
 reftable/publicbasics.c                       |   58 +
 reftable/reader.c                             |  773 +++++++++
 reftable/reader.h                             |   66 +
 reftable/record.c                             | 1203 ++++++++++++++
 reftable/record.h                             |  139 ++
 reftable/record_test.c                        |  405 +++++
 reftable/refname.c                            |  209 +++
 reftable/refname.h                            |   29 +
 reftable/refname_test.c                       |  102 ++
 reftable/reftable-blocksource.h               |   49 +
 reftable/reftable-error.h                     |   62 +
 reftable/reftable-generic.h                   |   41 +
 reftable/reftable-iterator.h                  |   39 +
 reftable/reftable-malloc.h                    |   18 +
 reftable/reftable-merged.h                    |   72 +
 reftable/reftable-reader.h                    |   98 ++
 reftable/reftable-record.h                    |  114 ++
 reftable/reftable-stack.h                     |  123 ++
 reftable/reftable-tests.h                     |   23 +
 reftable/reftable-writer.h                    |  147 ++
 reftable/reftable.c                           |  115 ++
 reftable/reftable_test.c                      |  583 +++++++
 reftable/stack.c                              | 1376 ++++++++++++++++
 reftable/stack.h                              |   41 +
 reftable/stack_test.c                         |  928 +++++++++++
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
 t/helper/test-reftable.c                      |   21 +
 t/helper/test-tool.c                          |    4 +-
 t/helper/test-tool.h                          |    2 +
 t/t0031-reftable.sh                           |  203 +++
 t/t0032-reftable-unittest.sh                  |   15 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    5 +
 83 files changed, 12509 insertions(+), 40 deletions(-)
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/LICENSE
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
 create mode 100644 reftable/generic.h
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/merged_test.c
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/pq_test.c
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


base-commit: 89b43f80a514aee58b662ad606e6352e03eaeee4
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-847%2Fhanwen%2Flibreftable-v6
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-847/hanwen/libreftable-v6
Pull-Request: https://github.com/git/git/pull/847

Range-diff vs v5:

  1:  e1d1d9f49807 =  1:  15b8306fbe4b init-db: set the_repository->hash_algo early on
  2:  502a66befabe =  2:  02bd1f40fa4e reftable: add LICENSE
  3:  1bd136f6a6df =  3:  bffa33c012ad reftable: add error related functionality
  4:  5bbbafb428e9 !  4:  df8003cb9a7d reftable: utility functions
     @@ Makefile: THIRD_PARTY_SOURCES += compat/regex/%
       EXTLIBS =
       
       GIT_USER_AGENT = git/$(GIT_VERSION)
     -@@ Makefile: XDIFF_OBJS += xdiff/xpatience.o
     - XDIFF_OBJS += xdiff/xprepare.o
     - XDIFF_OBJS += xdiff/xutils.o
     +@@ Makefile: XDIFF_OBJS += xdiff/xutils.o
     + .PHONY: xdiff-objs
     + xdiff-objs: $(XDIFF_OBJS)
       
      +REFTABLE_OBJS += reftable/basics.o
      +REFTABLE_OBJS += reftable/error.o
     @@ Makefile: XDIFF_OBJS += xdiff/xpatience.o
      +REFTABLE_TEST_OBJS += reftable/basics_test.o
      +
       TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
     - OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
     - 	$(XDIFF_OBJS) \
     - 	$(FUZZ_OBJS) \
     -+	$(REFTABLE_OBJS) \
     -+	$(REFTABLE_TEST_OBJS) \
     - 	common-main.o \
     - 	git.o
     ++
     + .PHONY: test-objs
     + test-objs: $(TEST_OBJS)
     + 
     +@@ Makefile: OBJECTS += $(PROGRAM_OBJS)
     + OBJECTS += $(TEST_OBJS)
     + OBJECTS += $(XDIFF_OBJS)
     + OBJECTS += $(FUZZ_OBJS)
     ++OBJECTS += $(REFTABLE_OBJS) $(REFTABLE_TEST_OBJS)
     ++
       ifndef NO_CURL
     + 	OBJECTS += http.o http-walker.o remote-curl.o
     + endif
      @@ Makefile: $(LIB_FILE): $(LIB_OBJS)
       $(XDIFF_LIB): $(XDIFF_OBJS)
       	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
  5:  e41fa780882d !  5:  6807af53e9a0 reftable: add blocksource, an abstraction for random access reads
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: XDIFF_OBJS += xdiff/xutils.o
     +@@ Makefile: xdiff-objs: $(XDIFF_OBJS)
       
       REFTABLE_OBJS += reftable/basics.o
       REFTABLE_OBJS += reftable/error.o
  6:  390eaca4fc8c =  6:  78a352c96f82 reftable: (de)serialization for the polymorphic record type.
  7:  b108525009d9 !  7:  9297b9c363f6 reftable: reading/writing blocks
     @@ Commit message
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: XDIFF_OBJS += xdiff/xutils.o
     +@@ Makefile: xdiff-objs: $(XDIFF_OBJS)
       
       REFTABLE_OBJS += reftable/basics.o
       REFTABLE_OBJS += reftable/error.o
  8:  b6eed7283aac !  8:  ceddefadd48c reftable: a generic binary tree implementation
     @@ Makefile: REFTABLE_OBJS += reftable/block.o
      +REFTABLE_TEST_OBJS += reftable/tree_test.o
       
       TEST_OBJS := $(patsubst %$X,%.o,$(TEST_PROGRAMS)) $(patsubst %,t/helper/%,$(TEST_BUILTINS_OBJS))
     - OBJECTS := $(LIB_OBJS) $(BUILTIN_OBJS) $(PROGRAM_OBJS) $(TEST_OBJS) \
     + 
      
       ## reftable/tree.c (new) ##
      @@
  9:  f2f005afca19 =  9:  1f635e6c86c5 reftable: write reftable files
  -:  ------------ > 10:  9c3fd77fbbac reftable: generic interface to tables
 10:  1f17d5edab52 ! 11:  8ba486f44a72 reftable: read reftable files
     @@ Makefile: REFTABLE_OBJS += reftable/basics.o
       REFTABLE_OBJS += reftable/publicbasics.o
      +REFTABLE_OBJS += reftable/reader.o
       REFTABLE_OBJS += reftable/record.o
     -+REFTABLE_OBJS += reftable/reftable.o
     + REFTABLE_OBJS += reftable/reftable.o
       REFTABLE_OBJS += reftable/tree.o
     - REFTABLE_OBJS += reftable/writer.o
     - REFTABLE_OBJS += reftable/zlib-compat.o
      
       ## reftable/iter.c (new) ##
      @@
     @@ reftable/iter.c (new)
      +#include "system.h"
      +
      +#include "block.h"
     ++#include "generic.h"
      +#include "constants.h"
      +#include "reader.h"
      +#include "reftable-error.h"
     @@ reftable/iter.c (new)
      +	return it->ops == NULL;
      +}
      +
     -+static int empty_iterator_next(void *arg, struct reftable_record *rec)
     -+{
     -+	return 1;
     -+}
     -+
     -+static void empty_iterator_close(void *arg)
     -+{
     -+}
     -+
     -+static struct reftable_iterator_vtable empty_vtable = {
     -+	.next = &empty_iterator_next,
     -+	.close = &empty_iterator_close,
     -+};
     -+
     -+void iterator_set_empty(struct reftable_iterator *it)
     -+{
     -+	assert(it->ops == NULL);
     -+	it->iter_arg = NULL;
     -+	it->ops = &empty_vtable;
     -+}
     -+
     -+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec)
     -+{
     -+	return it->ops->next(it->iter_arg, rec);
     -+}
     -+
     -+void reftable_iterator_destroy(struct reftable_iterator *it)
     -+{
     -+	if (it->ops == NULL) {
     -+		return;
     -+	}
     -+	it->ops->close(it->iter_arg);
     -+	it->ops = NULL;
     -+	FREE_AND_NULL(it->iter_arg);
     -+}
     -+
     -+int reftable_iterator_next_ref(struct reftable_iterator *it,
     -+			       struct reftable_ref_record *ref)
     -+{
     -+	struct reftable_record rec = { NULL };
     -+	reftable_record_from_ref(&rec, ref);
     -+	return iterator_next(it, &rec);
     -+}
     -+
     -+int reftable_iterator_next_log(struct reftable_iterator *it,
     -+			       struct reftable_log_record *log)
     -+{
     -+	struct reftable_record rec = { NULL };
     -+	reftable_record_from_log(&rec, log);
     -+	return iterator_next(it, &rec);
     -+}
     -+
      +static void filtering_ref_iterator_close(void *iter_arg)
      +{
      +	struct filtering_ref_iterator *fri =
     @@ reftable/iter.h (new)
      +#include "reftable-iterator.h"
      +#include "reftable-generic.h"
      +
     -+struct reftable_iterator_vtable {
     -+	int (*next)(void *iter_arg, struct reftable_record *rec);
     -+	void (*close)(void *iter_arg);
     -+};
     -+
     -+void iterator_set_empty(struct reftable_iterator *it);
     -+int iterator_next(struct reftable_iterator *it, struct reftable_record *rec);
     -+
      +/* Returns true for a zeroed out iterator, such as the one returned from
      + * iterator_destroy. */
      +int iterator_is_null(struct reftable_iterator *it);
     @@ reftable/reader.c (new)
      +#include "system.h"
      +#include "block.h"
      +#include "constants.h"
     ++#include "generic.h"
      +#include "iter.h"
      +#include "record.h"
      +#include "reftable-error.h"
     ++#include "reftable-generic.h"
      +#include "tree.h"
      +
      +uint64_t block_source_size(struct reftable_block_source *source)
     @@ reftable/reader.c (new)
      +uint64_t reftable_reader_min_update_index(struct reftable_reader *r)
      +{
      +	return r->min_update_index;
     ++}
     ++
     ++/* generic table interface. */
     ++
     ++static int reftable_reader_seek_void(void *tab, struct reftable_iterator *it,
     ++				     struct reftable_record *rec)
     ++{
     ++	return reader_seek((struct reftable_reader *)tab, it, rec);
     ++}
     ++
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
     ++static struct reftable_table_vtable reader_vtable = {
     ++	.seek_record = reftable_reader_seek_void,
     ++	.hash_id = reftable_reader_hash_id_void,
     ++	.min_update_index = reftable_reader_min_update_index_void,
     ++	.max_update_index = reftable_reader_max_update_index_void,
     ++};
     ++
     ++void reftable_table_from_reader(struct reftable_table *tab,
     ++				struct reftable_reader *reader)
     ++{
     ++	assert(tab->ops == NULL);
     ++	tab->ops = &reader_vtable;
     ++	tab->table_arg = reader;
      +}
      
       ## reftable/reader.h (new) ##
     @@ reftable/reader.h (new)
      +int reader_init_block_reader(struct reftable_reader *r, struct block_reader *br,
      +			     uint64_t next_off, uint8_t want_typ);
      +
     -+/* generic interface to reftables */
     -+struct reftable_table_vtable {
     -+	int (*seek_record)(void *tab, struct reftable_iterator *it,
     -+			   struct reftable_record *);
     -+	uint32_t (*hash_id)(void *tab);
     -+	uint64_t (*min_update_index)(void *tab);
     -+	uint64_t (*max_update_index)(void *tab);
     -+};
     -+
     -+#endif
     -
     - ## reftable/reftable-iterator.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef REFTABLE_ITERATOR_H
     -+#define REFTABLE_ITERATOR_H
     -+
     -+#include "reftable-record.h"
     -+
     -+/* iterator is the generic interface for walking over data stored in a
     -+ * reftable.
     -+ */
     -+struct reftable_iterator {
     -+	struct reftable_iterator_vtable *ops;
     -+	void *iter_arg;
     -+};
     -+
     -+/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
     -+ * end of iteration.
     -+ */
     -+int reftable_iterator_next_ref(struct reftable_iterator *it,
     -+			       struct reftable_ref_record *ref);
     -+
     -+/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
     -+ * end of iteration.
     -+ */
     -+int reftable_iterator_next_log(struct reftable_iterator *it,
     -+			       struct reftable_log_record *log);
     -+
     -+/* releases resources associated with an iterator. */
     -+void reftable_iterator_destroy(struct reftable_iterator *it);
     -+
      +#endif
      
       ## reftable/reftable-reader.h (new) ##
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
      +#ifndef REFTABLE_READER_H
     @@ reftable/reftable-reader.h (new)
      +/*
      + * Reading single tables
      + *
     -+ * The follow routines are for reading single files. For an application-level
     -+ * interface, skip ahead to struct reftable_merged_table and struct
     -+ * reftable_stack.
     ++ * The follow routines are for reading single files. For an
     ++ * application-level interface, skip ahead to struct
     ++ * reftable_merged_table and struct reftable_stack.
      + */
      +
      +/* The reader struct is a handle to an open reftable file. */
      +struct reftable_reader;
      +
     -+/* reftable_new_reader opens a reftable for reading. If successful, returns 0
     -+ * code and sets pp. The name is used for creating a stack. Typically, it is the
     -+ * basename of the file. The block source `src` is owned by the reader, and is
     -+ * closed on calling reftable_reader_destroy().
     ++/* Generic table. */
     ++struct reftable_table;
     ++
     ++/* reftable_new_reader opens a reftable for reading. If successful,
     ++ * returns 0 code and sets pp. The name is used for creating a
     ++ * stack. Typically, it is the basename of the file. The block source
     ++ * `src` is owned by the reader, and is closed on calling
     ++ * reftable_reader_destroy(). On error, the block source `src` is
     ++ * closed as well.
      + */
      +int reftable_new_reader(struct reftable_reader **pp,
      +			struct reftable_block_source *src, const char *name);
     @@ reftable/reftable-reader.h (new)
      +   if (err < 0) { ... }
      +   struct reftable_ref_record ref  = {0};
      +   while (1) {
     -+     err = reftable_iterator_next_ref(&it, &ref);
     -+     if (err > 0) {
     -+       break;
     -+     }
     -+     if (err < 0) {
     -+       ..error handling..
     -+     }
     -+     ..found..
     ++   err = reftable_iterator_next_ref(&it, &ref);
     ++   if (err > 0) {
     ++   break;
     ++   }
     ++   if (err < 0) {
     ++   ..error handling..
     ++   }
     ++   ..found..
      +   }
      +   reftable_iterator_destroy(&it);
      +   reftable_ref_record_release(&ref);
     -+ */
     ++*/
      +int reftable_reader_seek_ref(struct reftable_reader *r,
      +			     struct reftable_iterator *it, const char *name);
      +
     @@ reftable/reftable-reader.h (new)
      +
      +/* seek to logs for the given name, older than update_index. To seek to the
      +   start of the table, use name = "".
     -+ */
     ++*/
      +int reftable_reader_seek_log_at(struct reftable_reader *r,
      +				struct reftable_iterator *it, const char *name,
      +				uint64_t update_index);
     @@ reftable/reftable-reader.h (new)
      +/* return the min_update_index for a table */
      +uint64_t reftable_reader_min_update_index(struct reftable_reader *r);
      +
     ++/* creates a generic table from a file reader. */
     ++void reftable_table_from_reader(struct reftable_table *tab,
     ++				struct reftable_reader *reader);
     ++
      +#endif
 11:  c916629c562a ! 12:  9ade9303f08f reftable: reftable file level tests
     @@ reftable/reftable_test.c (new)
      +#include "record.h"
      +#include "test_framework.h"
      +#include "reftable-tests.h"
     -+#include "reftable-stack.h"
     ++#include "reftable-writer.h"
      +
      +static const int update_index = 5;
      +
  -:  ------------ > 13:  0a6119d910a3 reftable: add a heap-based priority queue for reftable records
  -:  ------------ > 14:  393fcecdae1e reftable: add merged table view
  -:  ------------ > 15:  3186b2b70f73 reftable: implement refname validation
 12:  28aa69f7bbcb ! 16:  b5492d5a13d7 reftable: rest of library
     @@ Metadata
      Author: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Commit message ##
     -    reftable: rest of library
     +    reftable: implement stack, a mutable database of reftable files.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Makefile ##
     -@@ Makefile: REFTABLE_OBJS += reftable/error.o
     - REFTABLE_OBJS += reftable/block.o
     - REFTABLE_OBJS += reftable/blocksource.o
     - REFTABLE_OBJS += reftable/iter.o
     -+REFTABLE_OBJS += reftable/merged.o
     -+REFTABLE_OBJS += reftable/pq.o
     - REFTABLE_OBJS += reftable/publicbasics.o
     - REFTABLE_OBJS += reftable/reader.o
     +@@ Makefile: REFTABLE_OBJS += reftable/reader.o
       REFTABLE_OBJS += reftable/record.o
     -+REFTABLE_OBJS += reftable/refname.o
     + REFTABLE_OBJS += reftable/refname.o
       REFTABLE_OBJS += reftable/reftable.o
      +REFTABLE_OBJS += reftable/stack.o
       REFTABLE_OBJS += reftable/tree.o
       REFTABLE_OBJS += reftable/writer.o
       REFTABLE_OBJS += reftable/zlib-compat.o
     -
     - ## reftable/VERSION (new) ##
     -@@
     -+a337d48d4d42d513d6baa33addc172f0e0e36288 C: use tagged union for reftable_log_record
     -
     - ## reftable/dump.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include <stddef.h>
     -+#include <stdio.h>
     -+#include <stdlib.h>
     -+#include <unistd.h>
     -+#include <string.h>
     -+
     -+#include "reftable.h"
     -+#include "reftable-tests.h"
     -+
     -+static uint32_t hash_id;
     -+
     -+static int dump_table(const char *tablename)
     -+{
     -+	struct reftable_block_source src = { 0 };
     -+	int err = reftable_block_source_from_file(&src, tablename);
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_log_record log = { 0 };
     -+	struct reftable_reader *r = NULL;
     -+
     -+	if (err < 0)
     -+		return err;
     -+
     -+	err = reftable_new_reader(&r, &src, tablename);
     -+	if (err < 0)
     -+		return err;
     -+
     -+	err = reftable_reader_seek_ref(r, &it, "");
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+
     -+	while (1) {
     -+		err = reftable_iterator_next_ref(&it, &ref);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		reftable_ref_record_print(&ref, hash_id);
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+	reftable_ref_record_clear(&ref);
     -+
     -+	err = reftable_reader_seek_log(r, &it, "");
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+	while (1) {
     -+		err = reftable_iterator_next_log(&it, &log);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		reftable_log_record_print(&log, hash_id);
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+	reftable_log_record_clear(&log);
     -+
     -+	reftable_reader_free(r);
     -+	return 0;
     -+}
     -+
     -+static int compact_stack(const char *stackdir)
     -+{
     -+	struct reftable_stack *stack = NULL;
     -+	struct reftable_write_options cfg = {};
     -+
     -+	int err = reftable_new_stack(&stack, stackdir, cfg);
     -+	if (err < 0)
     -+		goto done;
     -+
     -+	err = reftable_stack_compact_all(stack, NULL);
     -+	if (err < 0)
     -+		goto done;
     -+done:
     -+	if (stack != NULL) {
     -+		reftable_stack_destroy(stack);
     -+	}
     -+	return err;
     -+}
     -+
     -+static int dump_stack(const char *stackdir)
     -+{
     -+	struct reftable_stack *stack = NULL;
     -+	struct reftable_write_options cfg = {};
     -+	struct reftable_iterator it = { 0 };
     -+	struct reftable_ref_record ref = { 0 };
     -+	struct reftable_log_record log = { 0 };
     -+	struct reftable_merged_table *merged = NULL;
     -+
     -+	int err = reftable_new_stack(&stack, stackdir, cfg);
     -+	if (err < 0)
     -+		return err;
     -+
     -+	merged = reftable_stack_merged_table(stack);
     -+
     -+	err = reftable_merged_table_seek_ref(merged, &it, "");
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+
     -+	while (1) {
     -+		err = reftable_iterator_next_ref(&it, &ref);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		reftable_ref_record_print(&ref, hash_id);
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+	reftable_ref_record_clear(&ref);
     -+
     -+	err = reftable_merged_table_seek_log(merged, &it, "");
     -+	if (err < 0) {
     -+		return err;
     -+	}
     -+	while (1) {
     -+		err = reftable_iterator_next_log(&it, &log);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		reftable_log_record_print(&log, hash_id);
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+	reftable_log_record_clear(&log);
     -+
     -+	reftable_stack_destroy(stack);
     -+	return 0;
     -+}
     -+
     -+static void print_help(void)
     -+{
     -+	printf("usage: dump [-cst] arg\n\n"
     -+	       "options: \n"
     -+	       "  -c compact\n"
     -+	       "  -t dump table\n"
     -+	       "  -s dump stack\n"
     -+	       "  -h this help\n"
     -+	       "  -2 use SHA256\n"
     -+	       "\n");
     -+}
     -+
     -+int reftable_dump_main(int argc, char *const *argv)
     -+{
     -+	int err = 0;
     -+	int opt;
     -+	int opt_dump_table = 0;
     -+	int opt_dump_stack = 0;
     -+	int opt_compact = 0;
     -+	const char *arg = NULL;
     -+	while ((opt = getopt(argc, argv, "2chts")) != -1) {
     -+		switch (opt) {
     -+		case '2':
     -+			hash_id = 0x73323536;
     -+			break;
     -+		case 't':
     -+			opt_dump_table = 1;
     -+			break;
     -+		case 's':
     -+			opt_dump_stack = 1;
     -+			break;
     -+		case 'c':
     -+			opt_compact = 1;
     -+			break;
     -+		case '?':
     -+		case 'h':
     -+			print_help();
     -+			return 2;
     -+			break;
     -+		}
     -+	}
     -+
     -+	if (argv[optind] == NULL) {
     -+		fprintf(stderr, "need argument\n");
     -+		print_help();
     -+		return 2;
     -+	}
     -+
     -+	arg = argv[optind];
     -+
     -+	if (opt_dump_table) {
     -+		err = dump_table(arg);
     -+	} else if (opt_dump_stack) {
     -+		err = dump_stack(arg);
     -+	} else if (opt_compact) {
     -+		err = compact_stack(arg);
     -+	}
     -+
     -+	if (err < 0) {
     -+		fprintf(stderr, "%s: %s: %s\n", argv[0], arg,
     -+			reftable_error_str(err));
     -+		return 1;
     -+	}
     -+	return 0;
     -+}
     -
     - ## reftable/merged.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "merged.h"
     -+
     -+#include "constants.h"
     -+#include "iter.h"
     -+#include "pq.h"
     -+#include "reader.h"
     -+#include "record.h"
     -+#include "reftable-merged.h"
     -+#include "reftable-error.h"
     -+#include "system.h"
     -+
     -+static int merged_iter_init(struct merged_iter *mi)
     -+{
     -+	int i = 0;
     -+	for (i = 0; i < mi->stack_len; i++) {
     -+		struct reftable_record rec = reftable_new_record(mi->typ);
     -+		int err = iterator_next(&mi->stack[i], &rec);
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+
     -+		if (err > 0) {
     -+			reftable_iterator_destroy(&mi->stack[i]);
     -+			reftable_record_destroy(&rec);
     -+		} else {
     -+			struct pq_entry e = {
     -+				.rec = rec,
     -+				.index = i,
     -+			};
     -+			merged_iter_pqueue_add(&mi->pq, e);
     -+		}
     -+	}
     -+
     -+	return 0;
     -+}
     -+
     -+static void merged_iter_close(void *p)
     -+{
     -+	struct merged_iter *mi = (struct merged_iter *)p;
     -+	int i = 0;
     -+	merged_iter_pqueue_release(&mi->pq);
     -+	for (i = 0; i < mi->stack_len; i++) {
     -+		reftable_iterator_destroy(&mi->stack[i]);
     -+	}
     -+	reftable_free(mi->stack);
     -+}
     -+
     -+static int merged_iter_advance_nonnull_subiter(struct merged_iter *mi,
     -+					       size_t idx)
     -+{
     -+	struct reftable_record rec = reftable_new_record(mi->typ);
     -+	struct pq_entry e = {
     -+		.rec = rec,
     -+		.index = idx,
     -+	};
     -+	int err = iterator_next(&mi->stack[idx], &rec);
     -+	if (err < 0)
     -+		return err;
     -+
     -+	if (err > 0) {
     -+		reftable_iterator_destroy(&mi->stack[idx]);
     -+		reftable_record_destroy(&rec);
     -+		return 0;
     -+	}
     -+
     -+	merged_iter_pqueue_add(&mi->pq, e);
     -+	return 0;
     -+}
     -+
     -+static int merged_iter_advance_subiter(struct merged_iter *mi, size_t idx)
     -+{
     -+	if (iterator_is_null(&mi->stack[idx]))
     -+		return 0;
     -+	return merged_iter_advance_nonnull_subiter(mi, idx);
     -+}
     -+
     -+static int merged_iter_next_entry(struct merged_iter *mi,
     -+				  struct reftable_record *rec)
     -+{
     -+	struct strbuf entry_key = STRBUF_INIT;
     -+	struct pq_entry entry = { 0 };
     -+	int err = 0;
     -+
     -+	if (merged_iter_pqueue_is_empty(mi->pq))
     -+		return 1;
     -+
     -+	entry = merged_iter_pqueue_remove(&mi->pq);
     -+	err = merged_iter_advance_subiter(mi, entry.index);
     -+	if (err < 0)
     -+		return err;
     -+
     -+	/*
     -+	  One can also use reftable as datacenter-local storage, where the ref
     -+	  database is maintained in globally consistent database (eg.
     -+	  CockroachDB or Spanner). In this scenario, replication delays together
     -+	  with compaction may cause newer tables to contain older entries. In
     -+	  such a deployment, the loop below must be changed to collect all
     -+	  entries for the same key, and return new the newest one.
     -+	*/
     -+	reftable_record_key(&entry.rec, &entry_key);
     -+	while (!merged_iter_pqueue_is_empty(mi->pq)) {
     -+		struct pq_entry top = merged_iter_pqueue_top(mi->pq);
     -+		struct strbuf k = STRBUF_INIT;
     -+		int err = 0, cmp = 0;
     -+
     -+		reftable_record_key(&top.rec, &k);
     -+
     -+		cmp = strbuf_cmp(&k, &entry_key);
     -+		strbuf_release(&k);
     -+
     -+		if (cmp > 0) {
     -+			break;
     -+		}
     -+
     -+		merged_iter_pqueue_remove(&mi->pq);
     -+		err = merged_iter_advance_subiter(mi, top.index);
     -+		if (err < 0) {
     -+			return err;
     -+		}
     -+		reftable_record_destroy(&top.rec);
     -+	}
     -+
     -+	reftable_record_copy_from(rec, &entry.rec, hash_size(mi->hash_id));
     -+	reftable_record_destroy(&entry.rec);
     -+	strbuf_release(&entry_key);
     -+	return 0;
     -+}
     -+
     -+static int merged_iter_next(struct merged_iter *mi, struct reftable_record *rec)
     -+{
     -+	while (1) {
     -+		int err = merged_iter_next_entry(mi, rec);
     -+		if (err == 0 && mi->suppress_deletions &&
     -+		    reftable_record_is_deletion(rec)) {
     -+			continue;
     -+		}
     -+
     -+		return err;
     -+	}
     -+}
     -+
     -+static int merged_iter_next_void(void *p, struct reftable_record *rec)
     -+{
     -+	struct merged_iter *mi = (struct merged_iter *)p;
     -+	if (merged_iter_pqueue_is_empty(mi->pq))
     -+		return 1;
     -+
     -+	return merged_iter_next(mi, rec);
     -+}
     -+
     -+static struct reftable_iterator_vtable merged_iter_vtable = {
     -+	.next = &merged_iter_next_void,
     -+	.close = &merged_iter_close,
     -+};
     -+
     -+static void iterator_from_merged_iter(struct reftable_iterator *it,
     -+				      struct merged_iter *mi)
     -+{
     -+	assert(it->ops == NULL);
     -+	it->iter_arg = mi;
     -+	it->ops = &merged_iter_vtable;
     -+}
     -+
     -+int reftable_new_merged_table(struct reftable_merged_table **dest,
     -+			      struct reftable_table *stack, int n,
     -+			      uint32_t hash_id)
     -+{
     -+	struct reftable_merged_table *m = NULL;
     -+	uint64_t last_max = 0;
     -+	uint64_t first_min = 0;
     -+	int i = 0;
     -+	for (i = 0; i < n; i++) {
     -+		uint64_t min = reftable_table_min_update_index(&stack[i]);
     -+		uint64_t max = reftable_table_max_update_index(&stack[i]);
     -+
     -+		if (reftable_table_hash_id(&stack[i]) != hash_id) {
     -+			return REFTABLE_FORMAT_ERROR;
     -+		}
     -+		if (i == 0 || min < first_min) {
     -+			first_min = min;
     -+		}
     -+		if (i == 0 || max > last_max) {
     -+			last_max = max;
     -+		}
     -+	}
     -+
     -+	m = (struct reftable_merged_table *)reftable_calloc(
     -+		sizeof(struct reftable_merged_table));
     -+	m->stack = stack;
     -+	m->stack_len = n;
     -+	m->min = first_min;
     -+	m->max = last_max;
     -+	m->hash_id = hash_id;
     -+	*dest = m;
     -+	return 0;
     -+}
     -+
     -+/* clears the list of subtable, without affecting the readers themselves. */
     -+void merged_table_release(struct reftable_merged_table *mt)
     -+{
     -+	FREE_AND_NULL(mt->stack);
     -+	mt->stack_len = 0;
     -+}
     -+
     -+void reftable_merged_table_free(struct reftable_merged_table *mt)
     -+{
     -+	if (mt == NULL) {
     -+		return;
     -+	}
     -+	merged_table_release(mt);
     -+	reftable_free(mt);
     -+}
     -+
     -+uint64_t
     -+reftable_merged_table_max_update_index(struct reftable_merged_table *mt)
     -+{
     -+	return mt->max;
     -+}
     -+
     -+uint64_t
     -+reftable_merged_table_min_update_index(struct reftable_merged_table *mt)
     -+{
     -+	return mt->min;
     -+}
     -+
     -+static int reftable_table_seek_record(struct reftable_table *tab,
     -+				      struct reftable_iterator *it,
     -+				      struct reftable_record *rec)
     -+{
     -+	return tab->ops->seek_record(tab->table_arg, it, rec);
     -+}
     -+
     -+static int merged_table_seek_record(struct reftable_merged_table *mt,
     -+				    struct reftable_iterator *it,
     -+				    struct reftable_record *rec)
     -+{
     -+	struct reftable_iterator *iters = reftable_calloc(
     -+		sizeof(struct reftable_iterator) * mt->stack_len);
     -+	struct merged_iter merged = {
     -+		.stack = iters,
     -+		.typ = reftable_record_type(rec),
     -+		.hash_id = mt->hash_id,
     -+		.suppress_deletions = mt->suppress_deletions,
     -+	};
     -+	int n = 0;
     -+	int err = 0;
     -+	int i = 0;
     -+	for (i = 0; i < mt->stack_len && err == 0; i++) {
     -+		int e = reftable_table_seek_record(&mt->stack[i], &iters[n],
     -+						   rec);
     -+		if (e < 0) {
     -+			err = e;
     -+		}
     -+		if (e == 0) {
     -+			n++;
     -+		}
     -+	}
     -+	if (err < 0) {
     -+		int i = 0;
     -+		for (i = 0; i < n; i++) {
     -+			reftable_iterator_destroy(&iters[i]);
     -+		}
     -+		reftable_free(iters);
     -+		return err;
     -+	}
     -+
     -+	merged.stack_len = n;
     -+	err = merged_iter_init(&merged);
     -+	if (err < 0) {
     -+		merged_iter_close(&merged);
     -+		return err;
     -+	} else {
     -+		struct merged_iter *p =
     -+			reftable_malloc(sizeof(struct merged_iter));
     -+		*p = merged;
     -+		iterator_from_merged_iter(it, p);
     -+	}
     -+	return 0;
     -+}
     -+
     -+int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
     -+				   struct reftable_iterator *it,
     -+				   const char *name)
     -+{
     -+	struct reftable_ref_record ref = {
     -+		.refname = (char *)name,
     -+	};
     -+	struct reftable_record rec = { NULL };
     -+	reftable_record_from_ref(&rec, &ref);
     -+	return merged_table_seek_record(mt, it, &rec);
     -+}
     -+
     -+int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
     -+				      struct reftable_iterator *it,
     -+				      const char *name, uint64_t update_index)
     -+{
     -+	struct reftable_log_record log = {
     -+		.refname = (char *)name,
     -+		.update_index = update_index,
     -+	};
     -+	struct reftable_record rec = { NULL };
     -+	reftable_record_from_log(&rec, &log);
     -+	return merged_table_seek_record(mt, it, &rec);
     -+}
     -+
     -+int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
     -+				   struct reftable_iterator *it,
     -+				   const char *name)
     -+{
     -+	uint64_t max = ~((uint64_t)0);
     -+	return reftable_merged_table_seek_log_at(mt, it, name, max);
     -+}
     -+
     -+uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *mt)
     -+{
     -+	return mt->hash_id;
     -+}
     -+
     -+static int reftable_merged_table_seek_void(void *tab,
     -+					   struct reftable_iterator *it,
     -+					   struct reftable_record *rec)
     -+{
     -+	return merged_table_seek_record((struct reftable_merged_table *)tab, it,
     -+					rec);
     -+}
     -+
     -+static uint32_t reftable_merged_table_hash_id_void(void *tab)
     -+{
     -+	return reftable_merged_table_hash_id(
     -+		(struct reftable_merged_table *)tab);
     -+}
     -+
     -+static uint64_t reftable_merged_table_min_update_index_void(void *tab)
     -+{
     -+	return reftable_merged_table_min_update_index(
     -+		(struct reftable_merged_table *)tab);
     -+}
     -+
     -+static uint64_t reftable_merged_table_max_update_index_void(void *tab)
     -+{
     -+	return reftable_merged_table_max_update_index(
     -+		(struct reftable_merged_table *)tab);
     -+}
     -+
     -+static struct reftable_table_vtable merged_table_vtable = {
     -+	.seek_record = reftable_merged_table_seek_void,
     -+	.hash_id = reftable_merged_table_hash_id_void,
     -+	.min_update_index = reftable_merged_table_min_update_index_void,
     -+	.max_update_index = reftable_merged_table_max_update_index_void,
     -+};
     -+
     -+void reftable_table_from_merged_table(struct reftable_table *tab,
     -+				      struct reftable_merged_table *merged)
     -+{
     -+	assert(tab->ops == NULL);
     -+	tab->ops = &merged_table_vtable;
     -+	tab->table_arg = merged;
     -+}
     -
     - ## reftable/merged.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef MERGED_H
     -+#define MERGED_H
     -+
     -+#include "pq.h"
     -+
     -+struct reftable_merged_table {
     -+	struct reftable_table *stack;
     -+	size_t stack_len;
     -+	uint32_t hash_id;
     -+	int suppress_deletions;
     -+
     -+	uint64_t min;
     -+	uint64_t max;
     -+};
     -+
     -+struct merged_iter {
     -+	struct reftable_iterator *stack;
     -+	uint32_t hash_id;
     -+	size_t stack_len;
     -+	uint8_t typ;
     -+	int suppress_deletions;
     -+	struct merged_iter_pqueue pq;
     -+};
     -+
     -+void merged_table_release(struct reftable_merged_table *mt);
     -+
     -+#endif
     -
     - ## reftable/merged_test.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "merged.h"
     -+
     -+#include "system.h"
     -+
     -+#include "basics.h"
     -+#include "blocksource.h"
     -+#include "constants.h"
     -+#include "pq.h"
     -+#include "reader.h"
     -+#include "record.h"
     -+#include "test_framework.h"
     -+#include "reftable-merged.h"
     -+#include "reftable-tests.h"
     -+#include "reftable-generic.h"
     -+#include "reftable-stack.h"
     -+
     -+static void test_pq(void)
     -+{
     -+	char *names[54] = { NULL };
     -+	int N = ARRAY_SIZE(names) - 1;
     -+
     -+	struct merged_iter_pqueue pq = { NULL };
     -+	const char *last = NULL;
     -+
     -+	int i = 0;
     -+	for (i = 0; i < N; i++) {
     -+		char name[100];
     -+		snprintf(name, sizeof(name), "%02d", i);
     -+		names[i] = xstrdup(name);
     -+	}
     -+
     -+	i = 1;
     -+	do {
     -+		struct reftable_record rec =
     -+			reftable_new_record(BLOCK_TYPE_REF);
     -+		struct pq_entry e = { 0 };
     -+
     -+		reftable_record_as_ref(&rec)->refname = names[i];
     -+		e.rec = rec;
     -+		merged_iter_pqueue_add(&pq, e);
     -+		merged_iter_pqueue_check(pq);
     -+		i = (i * 7) % N;
     -+	} while (i != 1);
     -+
     -+	while (!merged_iter_pqueue_is_empty(pq)) {
     -+		struct pq_entry e = merged_iter_pqueue_remove(&pq);
     -+		struct reftable_ref_record *ref =
     -+			reftable_record_as_ref(&e.rec);
     -+
     -+		merged_iter_pqueue_check(pq);
     -+
     -+		if (last != NULL) {
     -+			assert(strcmp(last, ref->refname) < 0);
     -+		}
     -+		last = ref->refname;
     -+		ref->refname = NULL;
     -+		reftable_free(ref);
     -+	}
     -+
     -+	for (i = 0; i < N; i++) {
     -+		reftable_free(names[i]);
     -+	}
     -+
     -+	merged_iter_pqueue_release(&pq);
     -+}
     -+
     -+static void write_test_table(struct strbuf *buf,
     -+			     struct reftable_ref_record refs[], int n)
     -+{
     -+	int min = 0xffffffff;
     -+	int max = 0;
     -+	int i = 0;
     -+	int err;
     -+
     -+	struct reftable_write_options opts = {
     -+		.block_size = 256,
     -+	};
     -+	struct reftable_writer *w = NULL;
     -+	for (i = 0; i < n; i++) {
     -+		uint64_t ui = refs[i].update_index;
     -+		if (ui > max) {
     -+			max = ui;
     -+		}
     -+		if (ui < min) {
     -+			min = ui;
     -+		}
     -+	}
     -+
     -+	w = reftable_new_writer(&strbuf_add_void, buf, &opts);
     -+	reftable_writer_set_limits(w, min, max);
     -+
     -+	for (i = 0; i < n; i++) {
     -+		uint64_t before = refs[i].update_index;
     -+		int n = reftable_writer_add_ref(w, &refs[i]);
     -+		assert(n == 0);
     -+		assert(before == refs[i].update_index);
     -+	}
     -+
     -+	err = reftable_writer_close(w);
     -+	EXPECT_ERR(err);
     -+
     -+	reftable_writer_free(w);
     -+}
     -+
     -+static struct reftable_merged_table *
     -+merged_table_from_records(struct reftable_ref_record **refs,
     -+			  struct reftable_block_source **source,
     -+			  struct reftable_reader ***readers, int *sizes,
     -+			  struct strbuf *buf, int n)
     -+{
     -+	int i = 0;
     -+	struct reftable_merged_table *mt = NULL;
     -+	int err;
     -+	struct reftable_table *tabs =
     -+		reftable_calloc(n * sizeof(struct reftable_table));
     -+	*readers = reftable_calloc(n * sizeof(struct reftable_reader *));
     -+	*source = reftable_calloc(n * sizeof(**source));
     -+	for (i = 0; i < n; i++) {
     -+		write_test_table(&buf[i], refs[i], sizes[i]);
     -+		block_source_from_strbuf(&(*source)[i], &buf[i]);
     -+
     -+		err = reftable_new_reader(&(*readers)[i], &(*source)[i],
     -+					  "name");
     -+		EXPECT_ERR(err);
     -+		reftable_table_from_reader(&tabs[i], (*readers)[i]);
     -+	}
     -+
     -+	err = reftable_new_merged_table(&mt, tabs, n, SHA1_ID);
     -+	EXPECT_ERR(err);
     -+	return mt;
     -+}
     -+
     -+static void readers_destroy(struct reftable_reader **readers, size_t n)
     -+{
     -+	int i = 0;
     -+	for (; i < n; i++)
     -+		reftable_reader_free(readers[i]);
     -+	reftable_free(readers);
     -+}
     -+
     -+static void test_merged_between(void)
     -+{
     -+	uint8_t hash1[SHA1_SIZE] = { 1, 2, 3, 0 };
     -+
     -+	struct reftable_ref_record r1[] = { {
     -+		.refname = "b",
     -+		.update_index = 1,
     -+		.value_type = REFTABLE_REF_VAL1,
     -+		.value.val1 = hash1,
     -+	} };
     -+	struct reftable_ref_record r2[] = { {
     -+		.refname = "a",
     -+		.update_index = 2,
     -+		.value_type = REFTABLE_REF_DELETION,
     -+	} };
     -+
     -+	struct reftable_ref_record *refs[] = { r1, r2 };
     -+	int sizes[] = { 1, 1 };
     -+	struct strbuf bufs[2] = { STRBUF_INIT, STRBUF_INIT };
     -+	struct reftable_block_source *bs = NULL;
     -+	struct reftable_reader **readers = NULL;
     -+	struct reftable_merged_table *mt =
     -+		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 2);
     -+	int i;
     -+	struct reftable_ref_record ref = { NULL };
     -+	struct reftable_iterator it = { NULL };
     -+	int err = reftable_merged_table_seek_ref(mt, &it, "a");
     -+	EXPECT_ERR(err);
     -+
     -+	err = reftable_iterator_next_ref(&it, &ref);
     -+	EXPECT_ERR(err);
     -+	EXPECT(ref.update_index == 2);
     -+	reftable_ref_record_release(&ref);
     -+	reftable_iterator_destroy(&it);
     -+	readers_destroy(readers, 2);
     -+	reftable_merged_table_free(mt);
     -+	for (i = 0; i < ARRAY_SIZE(bufs); i++) {
     -+		strbuf_release(&bufs[i]);
     -+	}
     -+	reftable_free(bs);
     -+}
     -+
     -+static void test_merged(void)
     -+{
     -+	uint8_t hash1[SHA1_SIZE] = { 1 };
     -+	uint8_t hash2[SHA1_SIZE] = { 2 };
     -+	struct reftable_ref_record r1[] = {
     -+		{
     -+			.refname = "a",
     -+			.update_index = 1,
     -+			.value_type = REFTABLE_REF_VAL1,
     -+			.value.val1 = hash1,
     -+		},
     -+		{
     -+			.refname = "b",
     -+			.update_index = 1,
     -+			.value_type = REFTABLE_REF_VAL1,
     -+			.value.val1 = hash1,
     -+		},
     -+		{
     -+			.refname = "c",
     -+			.update_index = 1,
     -+			.value_type = REFTABLE_REF_VAL1,
     -+			.value.val1 = hash1,
     -+		}
     -+	};
     -+	struct reftable_ref_record r2[] = { {
     -+		.refname = "a",
     -+		.update_index = 2,
     -+		.value_type = REFTABLE_REF_DELETION,
     -+	} };
     -+	struct reftable_ref_record r3[] = {
     -+		{
     -+			.refname = "c",
     -+			.update_index = 3,
     -+			.value_type = REFTABLE_REF_VAL1,
     -+			.value.val1 = hash2,
     -+		},
     -+		{
     -+			.refname = "d",
     -+			.update_index = 3,
     -+			.value_type = REFTABLE_REF_VAL1,
     -+			.value.val1 = hash1,
     -+		},
     -+	};
     -+
     -+	struct reftable_ref_record want[] = {
     -+		r2[0],
     -+		r1[1],
     -+		r3[0],
     -+		r3[1],
     -+	};
     -+
     -+	struct reftable_ref_record *refs[] = { r1, r2, r3 };
     -+	int sizes[3] = { 3, 1, 2 };
     -+	struct strbuf bufs[3] = { STRBUF_INIT, STRBUF_INIT, STRBUF_INIT };
     -+	struct reftable_block_source *bs = NULL;
     -+	struct reftable_reader **readers = NULL;
     -+	struct reftable_merged_table *mt =
     -+		merged_table_from_records(refs, &bs, &readers, sizes, bufs, 3);
     -+
     -+	struct reftable_iterator it = { NULL };
     -+	int err = reftable_merged_table_seek_ref(mt, &it, "a");
     -+	struct reftable_ref_record *out = NULL;
     -+	size_t len = 0;
     -+	size_t cap = 0;
     -+	int i = 0;
     -+
     -+	EXPECT_ERR(err);
     -+	while (len < 100) { /* cap loops/recursion. */
     -+		struct reftable_ref_record ref = { NULL };
     -+		int err = reftable_iterator_next_ref(&it, &ref);
     -+		if (err > 0) {
     -+			break;
     -+		}
     -+		if (len == cap) {
     -+			cap = 2 * cap + 1;
     -+			out = reftable_realloc(
     -+				out, sizeof(struct reftable_ref_record) * cap);
     -+		}
     -+		out[len++] = ref;
     -+	}
     -+	reftable_iterator_destroy(&it);
     -+
     -+	assert(ARRAY_SIZE(want) == len);
     -+	for (i = 0; i < len; i++) {
     -+		assert(reftable_ref_record_equal(&want[i], &out[i], SHA1_SIZE));
     -+	}
     -+	for (i = 0; i < len; i++) {
     -+		reftable_ref_record_release(&out[i]);
     -+	}
     -+	reftable_free(out);
     -+
     -+	for (i = 0; i < 3; i++) {
     -+		strbuf_release(&bufs[i]);
     -+	}
     -+	readers_destroy(readers, 3);
     -+	reftable_merged_table_free(mt);
     -+	reftable_free(bs);
     -+}
     -+
     -+static void test_default_write_opts(void)
     -+{
     -+	struct reftable_write_options opts = { 0 };
     -+	struct strbuf buf = STRBUF_INIT;
     -+	struct reftable_writer *w =
     -+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
     -+
     -+	struct reftable_ref_record rec = {
     -+		.refname = "master",
     -+		.update_index = 1,
     -+	};
     -+	int err;
     -+	struct reftable_block_source source = { NULL };
     -+	struct reftable_table *tab = reftable_calloc(sizeof(*tab) * 1);
     -+	uint32_t hash_id;
     -+	struct reftable_reader *rd = NULL;
     -+	struct reftable_merged_table *merged = NULL;
     -+
     -+	reftable_writer_set_limits(w, 1, 1);
     -+
     -+	err = reftable_writer_add_ref(w, &rec);
     -+	EXPECT_ERR(err);
     -+
     -+	err = reftable_writer_close(w);
     -+	EXPECT_ERR(err);
     -+	reftable_writer_free(w);
     -+
     -+	block_source_from_strbuf(&source, &buf);
     -+
     -+	err = reftable_new_reader(&rd, &source, "filename");
     -+	EXPECT_ERR(err);
     -+
     -+	hash_id = reftable_reader_hash_id(rd);
     -+	assert(hash_id == SHA1_ID);
     -+
     -+	reftable_table_from_reader(&tab[0], rd);
     -+	err = reftable_new_merged_table(&merged, tab, 1, SHA1_ID);
     -+	EXPECT_ERR(err);
     -+
     -+	reftable_reader_free(rd);
     -+	reftable_merged_table_free(merged);
     -+	strbuf_release(&buf);
     -+}
     -+
     -+/* XXX test refs_for(oid) */
     -+
     -+int merged_test_main(int argc, const char *argv[])
     -+{
     -+	RUN_TEST(test_merged_between);
     -+	RUN_TEST(test_pq);
     -+	RUN_TEST(test_merged);
     -+	RUN_TEST(test_default_write_opts);
     -+	return 0;
     -+}
     -
     - ## reftable/pq.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "pq.h"
     -+
     -+#include "reftable-record.h"
     -+#include "system.h"
     -+#include "basics.h"
     -+
     -+static int pq_less(struct pq_entry a, struct pq_entry b)
     -+{
     -+	struct strbuf ak = STRBUF_INIT;
     -+	struct strbuf bk = STRBUF_INIT;
     -+	int cmp = 0;
     -+	reftable_record_key(&a.rec, &ak);
     -+	reftable_record_key(&b.rec, &bk);
     -+
     -+	cmp = strbuf_cmp(&ak, &bk);
     -+
     -+	strbuf_release(&ak);
     -+	strbuf_release(&bk);
     -+
     -+	if (cmp == 0)
     -+		return a.index > b.index;
     -+
     -+	return cmp < 0;
     -+}
     -+
     -+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq)
     -+{
     -+	return pq.heap[0];
     -+}
     -+
     -+int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq)
     -+{
     -+	return pq.len == 0;
     -+}
     -+
     -+void merged_iter_pqueue_check(struct merged_iter_pqueue pq)
     -+{
     -+	int i = 0;
     -+	for (i = 1; i < pq.len; i++) {
     -+		int parent = (i - 1) / 2;
     -+
     -+		assert(pq_less(pq.heap[parent], pq.heap[i]));
     -+	}
     -+}
     -+
     -+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq)
     -+{
     -+	int i = 0;
     -+	struct pq_entry e = pq->heap[0];
     -+	pq->heap[0] = pq->heap[pq->len - 1];
     -+	pq->len--;
     -+
     -+	i = 0;
     -+	while (i < pq->len) {
     -+		int min = i;
     -+		int j = 2 * i + 1;
     -+		int k = 2 * i + 2;
     -+		if (j < pq->len && pq_less(pq->heap[j], pq->heap[i])) {
     -+			min = j;
     -+		}
     -+		if (k < pq->len && pq_less(pq->heap[k], pq->heap[min])) {
     -+			min = k;
     -+		}
     -+
     -+		if (min == i) {
     -+			break;
     -+		}
     -+
     -+		SWAP(pq->heap[i], pq->heap[min]);
     -+		i = min;
     -+	}
     -+
     -+	return e;
     -+}
     -+
     -+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e)
     -+{
     -+	int i = 0;
     -+	if (pq->len == pq->cap) {
     -+		pq->cap = 2 * pq->cap + 1;
     -+		pq->heap = reftable_realloc(pq->heap,
     -+					    pq->cap * sizeof(struct pq_entry));
     -+	}
     -+
     -+	pq->heap[pq->len++] = e;
     -+	i = pq->len - 1;
     -+	while (i > 0) {
     -+		int j = (i - 1) / 2;
     -+		if (pq_less(pq->heap[j], pq->heap[i])) {
     -+			break;
     -+		}
     -+
     -+		SWAP(pq->heap[j], pq->heap[i]);
     -+
     -+		i = j;
     -+	}
     -+}
     -+
     -+void merged_iter_pqueue_release(struct merged_iter_pqueue *pq)
     -+{
     -+	int i = 0;
     -+	for (i = 0; i < pq->len; i++) {
     -+		reftable_record_destroy(&pq->heap[i].rec);
     -+	}
     -+	FREE_AND_NULL(pq->heap);
     -+	pq->len = pq->cap = 0;
     -+}
     -
     - ## reftable/pq.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef PQ_H
     -+#define PQ_H
     -+
     -+#include "record.h"
     -+
     -+struct pq_entry {
     -+	int index;
     -+	struct reftable_record rec;
     -+};
     -+
     -+struct merged_iter_pqueue {
     -+	struct pq_entry *heap;
     -+	size_t len;
     -+	size_t cap;
     -+};
     -+
     -+struct pq_entry merged_iter_pqueue_top(struct merged_iter_pqueue pq);
     -+int merged_iter_pqueue_is_empty(struct merged_iter_pqueue pq);
     -+void merged_iter_pqueue_check(struct merged_iter_pqueue pq);
     -+struct pq_entry merged_iter_pqueue_remove(struct merged_iter_pqueue *pq);
     -+void merged_iter_pqueue_add(struct merged_iter_pqueue *pq, struct pq_entry e);
     -+void merged_iter_pqueue_release(struct merged_iter_pqueue *pq);
     -+
     -+#endif
     -
     - ## reftable/refname.c (new) ##
     -@@
     -+/*
     -+  Copyright 2020 Google LLC
     -+
     -+  Use of this source code is governed by a BSD-style
     -+  license that can be found in the LICENSE file or at
     -+  https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "system.h"
     -+#include "reftable-error.h"
     -+#include "basics.h"
     -+#include "refname.h"
     -+#include "reftable-iterator.h"
     -+
     -+struct find_arg {
     -+	char **names;
     -+	const char *want;
     -+};
     -+
     -+static int find_name(size_t k, void *arg)
     -+{
     -+	struct find_arg *f_arg = (struct find_arg *)arg;
     -+	return strcmp(f_arg->names[k], f_arg->want) >= 0;
     -+}
     -+
     -+static int modification_has_ref(struct modification *mod, const char *name)
     -+{
     -+	struct reftable_ref_record ref = { NULL };
     -+	int err = 0;
     -+
     -+	if (mod->add_len > 0) {
     -+		struct find_arg arg = {
     -+			.names = mod->add,
     -+			.want = name,
     -+		};
     -+		int idx = binsearch(mod->add_len, find_name, &arg);
     -+		if (idx < mod->add_len && !strcmp(mod->add[idx], name)) {
     -+			return 0;
     -+		}
     -+	}
     -+
     -+	if (mod->del_len > 0) {
     -+		struct find_arg arg = {
     -+			.names = mod->del,
     -+			.want = name,
     -+		};
     -+		int idx = binsearch(mod->del_len, find_name, &arg);
     -+		if (idx < mod->del_len && !strcmp(mod->del[idx], name)) {
     -+			return 1;
     -+		}
     -+	}
     -+
     -+	err = reftable_table_read_ref(&mod->tab, name, &ref);
     -+	reftable_ref_record_release(&ref);
     -+	return err;
     -+}
     -+
     -+static void modification_release(struct modification *mod)
     -+{
     -+	/* don't delete the strings themselves; they're owned by ref records.
     -+	 */
     -+	FREE_AND_NULL(mod->add);
     -+	FREE_AND_NULL(mod->del);
     -+	mod->add_len = 0;
     -+	mod->del_len = 0;
     -+}
     -+
     -+static int modification_has_ref_with_prefix(struct modification *mod,
     -+					    const char *prefix)
     -+{
     -+	struct reftable_iterator it = { NULL };
     -+	struct reftable_ref_record ref = { NULL };
     -+	int err = 0;
     -+
     -+	if (mod->add_len > 0) {
     -+		struct find_arg arg = {
     -+			.names = mod->add,
     -+			.want = prefix,
     -+		};
     -+		int idx = binsearch(mod->add_len, find_name, &arg);
     -+		if (idx < mod->add_len &&
     -+		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
     -+			goto done;
     -+	}
     -+	err = reftable_table_seek_ref(&mod->tab, &it, prefix);
     -+	if (err)
     -+		goto done;
     -+
     -+	while (1) {
     -+		err = reftable_iterator_next_ref(&it, &ref);
     -+		if (err)
     -+			goto done;
     -+
     -+		if (mod->del_len > 0) {
     -+			struct find_arg arg = {
     -+				.names = mod->del,
     -+				.want = ref.refname,
     -+			};
     -+			int idx = binsearch(mod->del_len, find_name, &arg);
     -+			if (idx < mod->del_len &&
     -+			    !strcmp(ref.refname, mod->del[idx])) {
     -+				continue;
     -+			}
     -+		}
     -+
     -+		if (strncmp(ref.refname, prefix, strlen(prefix))) {
     -+			err = 1;
     -+			goto done;
     -+		}
     -+		err = 0;
     -+		goto done;
     -+	}
     -+
     -+done:
     -+	reftable_ref_record_release(&ref);
     -+	reftable_iterator_destroy(&it);
     -+	return err;
     -+}
     -+
     -+static int validate_refname(const char *name)
     -+{
     -+	while (1) {
     -+		char *next = strchr(name, '/');
     -+		if (!*name) {
     -+			return REFTABLE_REFNAME_ERROR;
     -+		}
     -+		if (!next) {
     -+			return 0;
     -+		}
     -+		if (next - name == 0 || (next - name == 1 && *name == '.') ||
     -+		    (next - name == 2 && name[0] == '.' && name[1] == '.'))
     -+			return REFTABLE_REFNAME_ERROR;
     -+		name = next + 1;
     -+	}
     -+	return 0;
     -+}
     -+
     -+int validate_ref_record_addition(struct reftable_table tab,
     -+				 struct reftable_ref_record *recs, size_t sz)
     -+{
     -+	struct modification mod = {
     -+		.tab = tab,
     -+		.add = reftable_calloc(sizeof(char *) * sz),
     -+		.del = reftable_calloc(sizeof(char *) * sz),
     -+	};
     -+	int i = 0;
     -+	int err = 0;
     -+	for (; i < sz; i++) {
     -+		if (reftable_ref_record_is_deletion(&recs[i])) {
     -+			mod.del[mod.del_len++] = recs[i].refname;
     -+		} else {
     -+			mod.add[mod.add_len++] = recs[i].refname;
     -+		}
     -+	}
     -+
     -+	err = modification_validate(&mod);
     -+	modification_release(&mod);
     -+	return err;
     -+}
     -+
     -+static void strbuf_trim_component(struct strbuf *sl)
     -+{
     -+	while (sl->len > 0) {
     -+		int is_slash = (sl->buf[sl->len - 1] == '/');
     -+		strbuf_setlen(sl, sl->len - 1);
     -+		if (is_slash)
     -+			break;
     -+	}
     -+}
     -+
     -+int modification_validate(struct modification *mod)
     -+{
     -+	struct strbuf slashed = STRBUF_INIT;
     -+	int err = 0;
     -+	int i = 0;
     -+	for (; i < mod->add_len; i++) {
     -+		err = validate_refname(mod->add[i]);
     -+		if (err)
     -+			goto done;
     -+		strbuf_reset(&slashed);
     -+		strbuf_addstr(&slashed, mod->add[i]);
     -+		strbuf_addstr(&slashed, "/");
     -+
     -+		err = modification_has_ref_with_prefix(mod, slashed.buf);
     -+		if (err == 0) {
     -+			err = REFTABLE_NAME_CONFLICT;
     -+			goto done;
     -+		}
     -+		if (err < 0)
     -+			goto done;
     -+
     -+		strbuf_reset(&slashed);
     -+		strbuf_addstr(&slashed, mod->add[i]);
     -+		while (slashed.len) {
     -+			strbuf_trim_component(&slashed);
     -+			err = modification_has_ref(mod, slashed.buf);
     -+			if (err == 0) {
     -+				err = REFTABLE_NAME_CONFLICT;
     -+				goto done;
     -+			}
     -+			if (err < 0)
     -+				goto done;
     -+		}
     -+	}
     -+	err = 0;
     -+done:
     -+	strbuf_release(&slashed);
     -+	return err;
     -+}
     -
     - ## reftable/refname.h (new) ##
     -@@
     -+/*
     -+  Copyright 2020 Google LLC
     -+
     -+  Use of this source code is governed by a BSD-style
     -+  license that can be found in the LICENSE file or at
     -+  https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+#ifndef REFNAME_H
     -+#define REFNAME_H
     -+
     -+#include "reftable-record.h"
     -+#include "reftable-generic.h"
     -+
     -+struct modification {
     -+	struct reftable_table tab;
     -+
     -+	char **add;
     -+	size_t add_len;
     -+
     -+	char **del;
     -+	size_t del_len;
     -+};
     -+
     -+int validate_ref_record_addition(struct reftable_table tab,
     -+				 struct reftable_ref_record *recs, size_t sz);
     -+
     -+int modification_validate(struct modification *mod);
     -+
     -+#endif
     -
     - ## reftable/refname_test.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "basics.h"
     -+#include "block.h"
     -+#include "blocksource.h"
     -+#include "constants.h"
     -+#include "reader.h"
     -+#include "record.h"
     -+#include "refname.h"
     -+#include "reftable-error.h"
     -+#include "reftable-writer.h"
     -+#include "system.h"
     -+
     -+#include "test_framework.h"
     -+#include "reftable-tests.h"
     -+
     -+struct testcase {
     -+	char *add;
     -+	char *del;
     -+	int error_code;
     -+};
     -+
     -+static void test_conflict(void)
     -+{
     -+	struct reftable_write_options opts = { 0 };
     -+	struct strbuf buf = STRBUF_INIT;
     -+	struct reftable_writer *w =
     -+		reftable_new_writer(&strbuf_add_void, &buf, &opts);
     -+	struct reftable_ref_record rec = {
     -+		.refname = "a/b",
     -+		.value_type = REFTABLE_REF_SYMREF,
     -+		.value.symref = "destination", /* make sure it's not a symref.
     -+						*/
     -+		.update_index = 1,
     -+	};
     -+	int err;
     -+	int i;
     -+	struct reftable_block_source source = { NULL };
     -+	struct reftable_reader *rd = NULL;
     -+	struct reftable_table tab = { NULL };
     -+	struct testcase cases[] = {
     -+		{ "a/b/c", NULL, REFTABLE_NAME_CONFLICT },
     -+		{ "b", NULL, 0 },
     -+		{ "a", NULL, REFTABLE_NAME_CONFLICT },
     -+		{ "a", "a/b", 0 },
     -+
     -+		{ "p/", NULL, REFTABLE_REFNAME_ERROR },
     -+		{ "p//q", NULL, REFTABLE_REFNAME_ERROR },
     -+		{ "p/./q", NULL, REFTABLE_REFNAME_ERROR },
     -+		{ "p/../q", NULL, REFTABLE_REFNAME_ERROR },
     -+
     -+		{ "a/b/c", "a/b", 0 },
     -+		{ NULL, "a//b", 0 },
     -+	};
     -+	reftable_writer_set_limits(w, 1, 1);
     -+
     -+	err = reftable_writer_add_ref(w, &rec);
     -+	EXPECT_ERR(err);
     -+
     -+	err = reftable_writer_close(w);
     -+	EXPECT_ERR(err);
     -+	reftable_writer_free(w);
     -+
     -+	block_source_from_strbuf(&source, &buf);
     -+	err = reftable_new_reader(&rd, &source, "filename");
     -+	EXPECT_ERR(err);
     -+
     -+	reftable_table_from_reader(&tab, rd);
     -+
     -+	for (i = 0; i < ARRAY_SIZE(cases); i++) {
     -+		struct modification mod = {
     -+			.tab = tab,
     -+		};
     -+
     -+		if (cases[i].add != NULL) {
     -+			mod.add = &cases[i].add;
     -+			mod.add_len = 1;
     -+		}
     -+		if (cases[i].del != NULL) {
     -+			mod.del = &cases[i].del;
     -+			mod.del_len = 1;
     -+		}
     -+
     -+		err = modification_validate(&mod);
     -+		EXPECT(err == cases[i].error_code);
     -+	}
     -+
     -+	reftable_reader_free(rd);
     -+	strbuf_release(&buf);
     -+}
     -+
     -+int refname_test_main(int argc, const char *argv[])
     -+{
     -+	RUN_TEST(test_conflict);
     -+	return 0;
     -+}
     -
     - ## reftable/reftable-generic.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef REFTABLE_GENERIC_H
     -+#define REFTABLE_GENERIC_H
     -+
     -+#include "reftable-iterator.h"
     -+#include "reftable-reader.h"
     -+#include "reftable-merged.h"
     -+
     -+/*
     -+ * Provides a unified API for reading tables, either merged tables, or single
     -+ * readers. */
     -+struct reftable_table {
     -+	struct reftable_table_vtable *ops;
     -+	void *table_arg;
     -+};
     -+
     -+int reftable_table_seek_ref(struct reftable_table *tab,
     -+			    struct reftable_iterator *it, const char *name);
     -+
     -+void reftable_table_from_reader(struct reftable_table *tab,
     -+				struct reftable_reader *reader);
     -+
     -+/* returns the hash ID from a generic reftable_table */
     -+uint32_t reftable_table_hash_id(struct reftable_table *tab);
     -+
     -+/* create a generic table from reftable_merged_table */
     -+void reftable_table_from_merged_table(struct reftable_table *tab,
     -+				      struct reftable_merged_table *table);
     -+
     -+/* returns the max update_index covered by this table. */
     -+uint64_t reftable_table_max_update_index(struct reftable_table *tab);
     -+
     -+/* returns the min update_index covered by this table. */
     -+uint64_t reftable_table_min_update_index(struct reftable_table *tab);
     -+
     -+/* convenience function to read a single ref. Returns < 0 for error, 0
     -+   for success, and 1 if ref not found. */
     -+int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     -+			    struct reftable_ref_record *ref);
     -+
     -+#endif
     -
     - ## reftable/reftable-merged.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef REFTABLE_MERGED_H
     -+#define REFTABLE_MERGED_H
     -+
     -+#include "reftable-iterator.h"
     -+
     -+/*
     -+ * Merged tables
     -+ *
     -+ * A ref database kept in a sequence of table files. The merged_table presents a
     -+ * unified view to reading (seeking, iterating) a sequence of immutable tables.
     -+ *
     -+ * The merged tables are on purpose kept disconnected from their actual storage
     -+ * (eg. files on disk), because it is useful to merge tables aren't files. For
     -+ * example, the per-workspace and global ref namespace can be implemented as a
     -+ * merged table of two stacks of file-backed reftables.
     -+ */
     -+
     -+/* A merged table is implements seeking/iterating over a stack of tables. */
     -+struct reftable_merged_table;
     -+
     -+/* A generic reftable; see below. */
     -+struct reftable_table;
     -+
     -+/* reftable_new_merged_table creates a new merged table. It takes ownership of
     -+   the stack array.
     -+*/
     -+int reftable_new_merged_table(struct reftable_merged_table **dest,
     -+			      struct reftable_table *stack, int n,
     -+			      uint32_t hash_id);
     -+
     -+/* returns an iterator positioned just before 'name' */
     -+int reftable_merged_table_seek_ref(struct reftable_merged_table *mt,
     -+				   struct reftable_iterator *it,
     -+				   const char *name);
     -+
     -+/* returns an iterator for log entry, at given update_index */
     -+int reftable_merged_table_seek_log_at(struct reftable_merged_table *mt,
     -+				      struct reftable_iterator *it,
     -+				      const char *name, uint64_t update_index);
     -+
     -+/* like reftable_merged_table_seek_log_at but look for the newest entry. */
     -+int reftable_merged_table_seek_log(struct reftable_merged_table *mt,
     -+				   struct reftable_iterator *it,
     -+				   const char *name);
     -+
     -+/* returns the max update_index covered by this merged table. */
     -+uint64_t
     -+reftable_merged_table_max_update_index(struct reftable_merged_table *mt);
     -+
     -+/* returns the min update_index covered by this merged table. */
     -+uint64_t
     -+reftable_merged_table_min_update_index(struct reftable_merged_table *mt);
     -+
     -+/* releases memory for the merged_table */
     -+void reftable_merged_table_free(struct reftable_merged_table *m);
     -+
     -+/* return the hash ID of the merged table. */
     -+uint32_t reftable_merged_table_hash_id(struct reftable_merged_table *m);
     -+
     -+#endif
     +@@ Makefile: REFTABLE_TEST_OBJS += reftable/pq_test.o
     + REFTABLE_TEST_OBJS += reftable/record_test.o
     + REFTABLE_TEST_OBJS += reftable/refname_test.o
     + REFTABLE_TEST_OBJS += reftable/reftable_test.o
     ++REFTABLE_TEST_OBJS += reftable/stack_test.o
     + REFTABLE_TEST_OBJS += reftable/test_framework.o
     + REFTABLE_TEST_OBJS += reftable/tree_test.o
     + 
      
       ## reftable/reftable-stack.h (new) ##
      @@
     @@ reftable/reftable-stack.h (new)
      +/* heuristically compact unbalanced table stack. */
      +int reftable_stack_auto_compact(struct reftable_stack *st);
      +
     ++/* delete stale .ref tables. */
     ++int reftable_stack_clean(struct reftable_stack *st);
     ++
      +/* convenience function to read a single ref. Returns < 0 for error, 0 for
      + * success, and 1 if ref not found. */
      +int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
     @@ reftable/reftable-stack.h (new)
      +
      +#endif
      
     - ## reftable/reftable.c (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#include "record.h"
     -+#include "reader.h"
     -+#include "reftable-iterator.h"
     -+#include "reftable-generic.h"
     -+
     -+static int reftable_reader_seek_void(void *tab, struct reftable_iterator *it,
     -+				     struct reftable_record *rec)
     -+{
     -+	return reader_seek((struct reftable_reader *)tab, it, rec);
     -+}
     -+
     -+static uint32_t reftable_reader_hash_id_void(void *tab)
     -+{
     -+	return reftable_reader_hash_id((struct reftable_reader *)tab);
     -+}
     -+
     -+static uint64_t reftable_reader_min_update_index_void(void *tab)
     -+{
     -+	return reftable_reader_min_update_index((struct reftable_reader *)tab);
     -+}
     -+
     -+static uint64_t reftable_reader_max_update_index_void(void *tab)
     -+{
     -+	return reftable_reader_max_update_index((struct reftable_reader *)tab);
     -+}
     -+
     -+static struct reftable_table_vtable reader_vtable = {
     -+	.seek_record = reftable_reader_seek_void,
     -+	.hash_id = reftable_reader_hash_id_void,
     -+	.min_update_index = reftable_reader_min_update_index_void,
     -+	.max_update_index = reftable_reader_max_update_index_void,
     -+};
     -+
     -+int reftable_table_seek_ref(struct reftable_table *tab,
     -+			    struct reftable_iterator *it, const char *name)
     -+{
     -+	struct reftable_ref_record ref = {
     -+		.refname = (char *)name,
     -+	};
     -+	struct reftable_record rec = { NULL };
     -+	reftable_record_from_ref(&rec, &ref);
     -+	return tab->ops->seek_record(tab->table_arg, it, &rec);
     -+}
     -+
     -+void reftable_table_from_reader(struct reftable_table *tab,
     -+				struct reftable_reader *reader)
     -+{
     -+	assert(tab->ops == NULL);
     -+	tab->ops = &reader_vtable;
     -+	tab->table_arg = reader;
     -+}
     -+
     -+int reftable_table_read_ref(struct reftable_table *tab, const char *name,
     -+			    struct reftable_ref_record *ref)
     -+{
     -+	struct reftable_iterator it = { NULL };
     -+	int err = reftable_table_seek_ref(tab, &it, name);
     -+	if (err)
     -+		goto done;
     -+
     -+	err = reftable_iterator_next_ref(&it, ref);
     -+	if (err)
     -+		goto done;
     -+
     -+	if (strcmp(ref->refname, name) ||
     -+	    reftable_ref_record_is_deletion(ref)) {
     -+		reftable_ref_record_release(ref);
     -+		err = 1;
     -+		goto done;
     -+	}
     -+
     -+done:
     -+	reftable_iterator_destroy(&it);
     -+	return err;
     -+}
     -+
     -+uint64_t reftable_table_max_update_index(struct reftable_table *tab)
     -+{
     -+	return tab->ops->max_update_index(tab->table_arg);
     -+}
     -+
     -+uint64_t reftable_table_min_update_index(struct reftable_table *tab)
     -+{
     -+	return tab->ops->min_update_index(tab->table_arg);
     -+}
     -+
     -+uint32_t reftable_table_hash_id(struct reftable_table *tab)
     -+{
     -+	return tab->ops->hash_id(tab->table_arg);
     -+}
     -
       ## reftable/stack.c (new) ##
      @@
      +/*
     @@ reftable/stack.c (new)
      +#include "refname.h"
      +#include "reftable-error.h"
      +#include "reftable-record.h"
     ++#include "reftable-merged.h"
      +#include "writer.h"
      +
      +static int stack_try_add(struct reftable_stack *st,
     @@ reftable/stack.c (new)
      +static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
      +					     int reuse_open);
      +
     ++static void stack_filename(struct strbuf *dest, struct reftable_stack *st,
     ++			   const char *name)
     ++{
     ++	strbuf_reset(dest);
     ++	strbuf_addstr(dest, st->reftable_dir);
     ++	strbuf_addstr(dest, "/");
     ++	strbuf_addstr(dest, name);
     ++}
     ++
      +static int reftable_fd_write(void *arg, const void *data, size_t sz)
      +{
      +	int *fdp = (int *)arg;
     @@ reftable/stack.c (new)
      +	return st->merged;
      +}
      +
     ++static int has_name(char **names, const char *name)
     ++{
     ++	while (*names) {
     ++		if (!strcmp(*names, name))
     ++			return 1;
     ++		names++;
     ++	}
     ++	return 0;
     ++}
     ++
      +/* Close and free the stack */
      +void reftable_stack_destroy(struct reftable_stack *st)
      +{
     ++	char **names = NULL;
     ++	int err = 0;
      +	if (st->merged != NULL) {
      +		reftable_merged_table_free(st->merged);
      +		st->merged = NULL;
      +	}
      +
     ++	err = read_lines(st->list_file, &names);
     ++	if (err < 0) {
     ++		FREE_AND_NULL(names);
     ++	}
     ++
      +	if (st->readers != NULL) {
      +		int i = 0;
     ++		struct strbuf filename = STRBUF_INIT;
      +		for (i = 0; i < st->readers_len; i++) {
     ++			const char *name = reader_name(st->readers[i]);
     ++			strbuf_reset(&filename);
     ++			if (names && !has_name(names, name)) {
     ++				stack_filename(&filename, st, name);
     ++			}
      +			reftable_reader_free(st->readers[i]);
     ++
     ++			if (filename.len) {
     ++				// On Windows, can only unlink after closing.
     ++				unlink(filename.buf);
     ++			}
      +		}
     ++		strbuf_release(&filename);
      +		st->readers_len = 0;
      +		FREE_AND_NULL(st->readers);
      +	}
      +	FREE_AND_NULL(st->list_file);
      +	FREE_AND_NULL(st->reftable_dir);
      +	reftable_free(st);
     ++	free_names(names);
      +}
      +
      +static struct reftable_reader **stack_copy_readers(struct reftable_stack *st,
     @@ reftable/stack.c (new)
      +		if (rd == NULL) {
      +			struct reftable_block_source src = { NULL };
      +			struct strbuf table_path = STRBUF_INIT;
     -+			strbuf_addstr(&table_path, st->reftable_dir);
     -+			strbuf_addstr(&table_path, "/");
     -+			strbuf_addstr(&table_path, name);
     ++			stack_filename(&table_path, st, name);
      +
      +			err = reftable_block_source_from_file(&src,
      +							      table_path.buf);
     @@ reftable/stack.c (new)
      +	st->merged = new_merged;
      +	for (i = 0; i < cur_len; i++) {
      +		if (cur[i] != NULL) {
     ++			const char *name = reader_name(cur[i]);
     ++			struct strbuf filename = STRBUF_INIT;
     ++			stack_filename(&filename, st, name);
     ++
      +			reader_close(cur[i]);
      +			reftable_reader_free(cur[i]);
     ++
     ++			// On Windows, can only unlink after closing.
     ++			unlink(filename.buf);
     ++
     ++			strbuf_release(&filename);
      +		}
      +	}
      +
     @@ reftable/stack.c (new)
      +	int i = 0;
      +	struct strbuf nm = STRBUF_INIT;
      +	for (i = 0; i < add->new_tables_len; i++) {
     -+		strbuf_reset(&nm);
     -+		strbuf_addstr(&nm, add->stack->reftable_dir);
     -+		strbuf_addstr(&nm, "/");
     -+		strbuf_addstr(&nm, add->new_tables[i]);
     ++		stack_filename(&nm, add->stack, add->new_tables[i]);
      +		unlink(nm.buf);
      +		reftable_free(add->new_tables[i]);
      +		add->new_tables[i] = NULL;
     @@ reftable/stack.c (new)
      +	strbuf_reset(&next_name);
      +	format_name(&next_name, add->next_update_index, add->next_update_index);
      +
     -+	strbuf_addstr(&temp_tab_file_name, add->stack->reftable_dir);
     -+	strbuf_addstr(&temp_tab_file_name, "/");
     -+	strbuf_addbuf(&temp_tab_file_name, &next_name);
     ++	stack_filename(&temp_tab_file_name, add->stack, next_name.buf);
      +	strbuf_addstr(&temp_tab_file_name, ".temp.XXXXXX");
      +
      +	tab_fd = mkstemp(temp_tab_file_name.buf);
     @@ reftable/stack.c (new)
      +	format_name(&next_name, wr->min_update_index, wr->max_update_index);
      +	strbuf_addstr(&next_name, ".ref");
      +
     -+	strbuf_addstr(&tab_file_name, add->stack->reftable_dir);
     -+	strbuf_addstr(&tab_file_name, "/");
     -+	strbuf_addbuf(&tab_file_name, &next_name);
     ++	stack_filename(&tab_file_name, add->stack, next_name.buf);
      +
      +	/*
      +	  On windows, this relies on rand() picking a unique destination name.
     @@ reftable/stack.c (new)
      +		    reftable_reader_min_update_index(st->readers[first]),
      +		    reftable_reader_max_update_index(st->readers[last]));
      +
     -+	strbuf_reset(temp_tab);
     -+	strbuf_addstr(temp_tab, st->reftable_dir);
     -+	strbuf_addstr(temp_tab, "/");
     -+	strbuf_addbuf(temp_tab, &next_name);
     ++	stack_filename(temp_tab, st, next_name.buf);
      +	strbuf_addstr(temp_tab, ".temp.XXXXXX");
      +
      +	tab_fd = mkstemp(temp_tab->buf);
     @@ reftable/stack.c (new)
      +		struct strbuf subtab_lock = STRBUF_INIT;
      +		int sublock_file_fd = -1;
      +
     -+		strbuf_addstr(&subtab_file_name, st->reftable_dir);
     -+		strbuf_addstr(&subtab_file_name, "/");
     -+		strbuf_addstr(&subtab_file_name, reader_name(st->readers[i]));
     ++		stack_filename(&subtab_file_name, st,
     ++			       reader_name(st->readers[i]));
      +
      +		strbuf_reset(&subtab_lock);
      +		strbuf_addbuf(&subtab_lock, &subtab_file_name);
     @@ reftable/stack.c (new)
      +		    st->readers[last]->max_update_index);
      +	strbuf_addstr(&new_table_name, ".ref");
      +
     -+	strbuf_reset(&new_table_path);
     -+	strbuf_addstr(&new_table_path, st->reftable_dir);
     -+	strbuf_addstr(&new_table_path, "/");
     -+	strbuf_addbuf(&new_table_path, &new_table_name);
     ++	stack_filename(&new_table_path, st, new_table_name.buf);
      +
      +	if (!is_empty_table) {
      +		/* retry? */
     @@ reftable/stack.c (new)
      +	reftable_iterator_destroy(&it);
      +	reftable_reader_free(rd);
      +	return err;
     ++}
     ++
     ++static int is_table_name(const char *s)
     ++{
     ++	const char *dot = strrchr(s, '.');
     ++	return dot != NULL && !strcmp(dot, ".ref");
     ++}
     ++
     ++static void remove_maybe_stale_table(struct reftable_stack *st, uint64_t max,
     ++				     const char *name)
     ++{
     ++	int err = 0;
     ++	uint64_t update_idx = 0;
     ++	struct reftable_block_source src = { NULL };
     ++	struct reftable_reader *rd = NULL;
     ++	struct strbuf table_path = STRBUF_INIT;
     ++	stack_filename(&table_path, st, name);
     ++
     ++	err = reftable_block_source_from_file(&src, table_path.buf);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	err = reftable_new_reader(&rd, &src, name);
     ++	if (err < 0)
     ++		goto done;
     ++
     ++	update_idx = reftable_reader_max_update_index(rd);
     ++	reftable_reader_free(rd);
     ++
     ++	if (update_idx <= max) {
     ++		unlink(table_path.buf);
     ++	}
     ++done:
     ++	strbuf_release(&table_path);
     ++}
     ++
     ++static int reftable_stack_clean_locked(struct reftable_stack *st)
     ++{
     ++	uint64_t max = reftable_merged_table_max_update_index(
     ++		reftable_stack_merged_table(st));
     ++	DIR *dir = opendir(st->reftable_dir);
     ++	struct dirent *d = NULL;
     ++	if (dir == NULL) {
     ++		return REFTABLE_IO_ERROR;
     ++	}
     ++
     ++	while ((d = readdir(dir)) != NULL) {
     ++		int i = 0;
     ++		int found = 0;
     ++		if (!is_table_name(d->d_name))
     ++			continue;
     ++
     ++		for (i = 0; !found && i < st->readers_len; i++) {
     ++			found = !strcmp(reader_name(st->readers[i]), d->d_name);
     ++		}
     ++		if (found)
     ++			continue;
     ++
     ++		remove_maybe_stale_table(st, max, d->d_name);
     ++	}
     ++
     ++	closedir(dir);
     ++	return 0;
     ++}
     ++
     ++int reftable_stack_clean(struct reftable_stack *st)
     ++{
     ++	struct reftable_addition *add = NULL;
     ++	int err = reftable_stack_new_addition(&add, st);
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++
     ++	err = reftable_stack_reload(st);
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++
     ++	err = reftable_stack_clean_locked(st);
     ++
     ++done:
     ++	reftable_addition_destroy(add);
     ++	return err;
      +}
      
       ## reftable/stack.h (new) ##
     @@ reftable/stack_test.c (new)
      +
      +#include "system.h"
      +
     ++#include "reftable-reader.h"
      +#include "merged.h"
      +#include "basics.h"
      +#include "constants.h"
     @@ reftable/stack_test.c (new)
      +	strbuf_release(&path);
      +}
      +
     ++static int count_dir_entries(const char *dirname)
     ++{
     ++	DIR *dir = opendir(dirname);
     ++	int len = 0;
     ++	struct dirent *d;
     ++	if (dir == NULL)
     ++		return 0;
     ++
     ++	while ((d = readdir(dir)) != NULL) {
     ++		if (!strcmp(d->d_name, "..") || !strcmp(d->d_name, "."))
     ++			continue;
     ++		len++;
     ++	}
     ++	closedir(dir);
     ++	return len;
     ++}
     ++
      +static char *get_tmp_template(const char *prefix)
      +{
      +	const char *tmp = getenv("TMPDIR");
     @@ reftable/stack_test.c (new)
      +	clear_dir(dir);
      +}
      +
     ++static void test_reftable_stack_compaction_concurrent(void)
     ++{
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st1 = NULL, *st2 = NULL;
     ++	char *dir = get_tmp_template(__FUNCTION__);
     ++	int err, i;
     ++	int N = 3;
     ++	EXPECT(mkdtemp(dir));
     ++
     ++	err = reftable_new_stack(&st1, dir, cfg);
     ++	EXPECT_ERR(err);
     ++
     ++	for (i = 0; i < N; i++) {
     ++		char name[100];
     ++		struct reftable_ref_record ref = {
     ++			.refname = name,
     ++			.update_index = reftable_stack_next_update_index(st1),
     ++			.value_type = REFTABLE_REF_SYMREF,
     ++			.value.symref = "master",
     ++		};
     ++		snprintf(name, sizeof(name), "branch%04d", i);
     ++
     ++		err = reftable_stack_add(st1, &write_test_ref, &ref);
     ++		EXPECT_ERR(err);
     ++	}
     ++
     ++	err = reftable_new_stack(&st2, dir, cfg);
     ++	EXPECT_ERR(err);
     ++
     ++	err = reftable_stack_compact_all(st1, NULL);
     ++	EXPECT_ERR(err);
     ++
     ++	reftable_stack_destroy(st1);
     ++	reftable_stack_destroy(st2);
     ++
     ++	EXPECT(count_dir_entries(dir) == 2);
     ++	clear_dir(dir);
     ++}
     ++
     ++static void unclean_stack_close(struct reftable_stack *st)
     ++{
     ++	// break abstraction boundary to simulate unclean shutdown.
     ++	int i = 0;
     ++	for (; i < st->readers_len; i++) {
     ++		reftable_reader_free(st->readers[i]);
     ++	}
     ++	st->readers_len = 0;
     ++	FREE_AND_NULL(st->readers);
     ++}
     ++
     ++static void test_reftable_stack_compaction_concurrent_clean(void)
     ++{
     ++	struct reftable_write_options cfg = { 0 };
     ++	struct reftable_stack *st1 = NULL, *st2 = NULL, *st3 = NULL;
     ++	char *dir = get_tmp_template(__FUNCTION__);
     ++	int err, i;
     ++	int N = 3;
     ++	EXPECT(mkdtemp(dir));
     ++
     ++	err = reftable_new_stack(&st1, dir, cfg);
     ++	EXPECT_ERR(err);
     ++
     ++	for (i = 0; i < N; i++) {
     ++		char name[100];
     ++		struct reftable_ref_record ref = {
     ++			.refname = name,
     ++			.update_index = reftable_stack_next_update_index(st1),
     ++			.value_type = REFTABLE_REF_SYMREF,
     ++			.value.symref = "master",
     ++		};
     ++		snprintf(name, sizeof(name), "branch%04d", i);
     ++
     ++		err = reftable_stack_add(st1, &write_test_ref, &ref);
     ++		EXPECT_ERR(err);
     ++	}
     ++
     ++	err = reftable_new_stack(&st2, dir, cfg);
     ++	EXPECT_ERR(err);
     ++
     ++	err = reftable_stack_compact_all(st1, NULL);
     ++	EXPECT_ERR(err);
     ++
     ++	unclean_stack_close(st1);
     ++	unclean_stack_close(st2);
     ++
     ++	err = reftable_new_stack(&st3, dir, cfg);
     ++	EXPECT_ERR(err);
     ++
     ++	err = reftable_stack_clean(st3);
     ++	EXPECT_ERR(err);
     ++	EXPECT(count_dir_entries(dir) == 2);
     ++
     ++	reftable_stack_destroy(st1);
     ++	reftable_stack_destroy(st2);
     ++	reftable_stack_destroy(st3);
     ++
     ++	clear_dir(dir);
     ++}
     ++
      +int stack_test_main(int argc, const char *argv[])
      +{
     ++	RUN_TEST(test_reftable_stack_compaction_concurrent_clean);
     ++	RUN_TEST(test_reftable_stack_compaction_concurrent);
      +	RUN_TEST(test_reftable_stack_uptodate);
      +	RUN_TEST(test_reftable_stack_transaction_api);
      +	RUN_TEST(test_reftable_stack_hash_id);
     @@ reftable/stack_test.c (new)
      
       ## t/helper/test-reftable.c ##
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)
     - {
     - 	basics_test_main(argc, argv);
     - 	block_test_main(argc, argv);
     -+	merged_test_main(argc, argv);
       	record_test_main(argc, argv);
     -+	refname_test_main(argc, argv);
     + 	refname_test_main(argc, argv);
       	reftable_test_main(argc, argv);
      +	stack_test_main(argc, argv);
       	tree_test_main(argc, argv);
  -:  ------------ > 17:  5db7c8ab7f23 reftable: add dump utility
 13:  bdb19af22cc7 ! 18:  2dc73bf2ec96 Reftable support for git-core
     @@ Makefile: LIB_OBJS += reflog-walk.o
       LIB_OBJS += refs/iterator.o
       LIB_OBJS += refs/packed-backend.o
       LIB_OBJS += refs/ref-cache.o
     -@@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
     - 
     - REFTABLE_TEST_OBJS += reftable/basics_test.o
     - REFTABLE_TEST_OBJS += reftable/block_test.o
     -+REFTABLE_TEST_OBJS += reftable/merged_test.o
     - REFTABLE_TEST_OBJS += reftable/record_test.o
     -+REFTABLE_TEST_OBJS += reftable/refname_test.o
     - REFTABLE_TEST_OBJS += reftable/reftable_test.o
     -+REFTABLE_TEST_OBJS += reftable/stack_test.o
     - REFTABLE_TEST_OBJS += reftable/test_framework.o
     - REFTABLE_TEST_OBJS += reftable/tree_test.o
     - 
      
       ## builtin/clone.c ##
      @@ builtin/clone.c: int cmd_clone(int argc, const char **argv, const char *prefix)
     @@ builtin/init-db.c: static int needs_work_tree_config(const char *git_dir, const
       
       	/* This forces creation of new config file */
      @@ builtin/init-db.c: static int create_default_files(const char *template_path,
     - 	is_bare_repository_cfg = init_is_bare_repository;
     + 	is_bare_repository_cfg = init_is_bare_repository || !work_tree;
       	if (init_shared_repository != -1)
       		set_shared_repository(init_shared_repository);
      +	the_repository->ref_storage_format = xstrdup(fmt->ref_storage);
     @@ refs/reftable-backend.c (new)
      +	err = reftable_stack_compact_all(refs->main_stack, NULL);
      +	if (err == 0 && refs->worktree_stack != NULL)
      +		err = reftable_stack_compact_all(refs->worktree_stack, NULL);
     ++	if (err == 0)
     ++		err = reftable_stack_clean(refs->main_stack);
     ++	if (err == 0 && refs->worktree_stack != NULL)
     ++		err = reftable_stack_clean(refs->worktree_stack);
     ++
      +	return err;
      +}
      +
 14:  0d9477941678 = 19:  b2fa6ea62c16 git-prompt: prepare for reftable refs backend
 15:  59f432522230 ! 20:  39e644b9436b Add "test-tool dump-reftable" command.
     @@ Makefile: REFTABLE_OBJS += reftable/zlib-compat.o
       REFTABLE_TEST_OBJS += reftable/block_test.o
      +REFTABLE_TEST_OBJS += reftable/dump.o
       REFTABLE_TEST_OBJS += reftable/merged_test.o
     + REFTABLE_TEST_OBJS += reftable/pq_test.o
       REFTABLE_TEST_OBJS += reftable/record_test.o
     - REFTABLE_TEST_OBJS += reftable/refname_test.o
      
       ## reftable/dump.c ##
      @@ reftable/dump.c: license that can be found in the LICENSE file or at

-- 
gitgitgadget
