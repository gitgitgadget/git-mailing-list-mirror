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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71CDC4361B
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:01:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89F8A23B51
	for <git@archiver.kernel.org>; Wed,  9 Dec 2020 14:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgLIOBS (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Dec 2020 09:01:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728593AbgLIOBP (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Dec 2020 09:01:15 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53F7C061793
        for <git@vger.kernel.org>; Wed,  9 Dec 2020 06:00:34 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 3so1779280wmg.4
        for <git@vger.kernel.org>; Wed, 09 Dec 2020 06:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=J+zLgTwjrf6erBlb+sN9JE6DcOmNQswRezyiG7VFcMQ=;
        b=Ki4224py97OVyLNnpnyq15KBeYEuUlYsPydtIRp+9C6/L5+6pHkl0ibKfoLXi4EgKq
         LGN+nErbIBlwyShm9JdEglIRY2Hu6z5Sx35GVQDQ2lICyCnb6Bd8uZUr2GjCGoWO577L
         pssF6QsTzgf9HSoItloodA+axyHQR+mapvoSUSTJY0OCfAdL0TQSb19oB8BHhBVv2Ebh
         gKf1dVRuRT3O3tsMIjRoBWVUDHnQyZa0kW2HN/YSj6rxcfDYloXCkhrWJaI3fUShbY2I
         uTLP4Kx1j/lRO17K1tiQsC+8BiCDKkd81BZPQZo/AkexhSHuElXEjuJXo8dPt2xpwaeY
         LtCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=J+zLgTwjrf6erBlb+sN9JE6DcOmNQswRezyiG7VFcMQ=;
        b=mawq7NZx76ss+u8VQBkGZ7pmWKB8lig7GPx4Vid6xqSoU157YPG3eZBWuM5xU4/kXZ
         nhPygS0/MueaPKLJ023w+H1Z6PuroFYWLnLTjVsc4dWiwul+pVPnc+P7v/mNKYnb4iZt
         5hTvKX0DNfhwH8ZIIy70fNd17bhLq4oSCWlpKKiGbHinVeSzOF7K8i6xwQ1vugsEt0Gk
         pe6j/LG3SJfo+WeyqZTnpZDqcQNq6XNpDKpfgWHZXOuHSHb3st8Ko9rQs+rMfyZHPh9W
         HnPxd+NrW/k75i7EOlBhyQSNj9JmNDOu0ip4OLxY1TmVMxbxYmlNqQ1zSjyXh6qQgOq6
         N/+Q==
X-Gm-Message-State: AOAM532KqfczADc4cRz3/8Cgu7YRfIsmmKyZ/4pwHufMckBe/CdBAlmX
        tYHs1l4UvHkBUOYi7LGlYHfyerhRTyg=
X-Google-Smtp-Source: ABdhPJzdPaKWDE6MCY215bGv5vZ5uVq3SP0xhOX5OGJIBJm8C4owxDe7Ynp+/Z+7H2vikpDnwZbGoQ==
X-Received: by 2002:a1c:7f90:: with SMTP id a138mr3000927wmd.61.1607522431769;
        Wed, 09 Dec 2020 06:00:31 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id a13sm3682868wrt.96.2020.12.09.06.00.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Dec 2020 06:00:30 -0800 (PST)
Message-Id: <pull.847.v4.git.git.1607522429.gitgitgadget@gmail.com>
In-Reply-To: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
References: <pull.847.v3.git.git.1606419752.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 09 Dec 2020 14:00:14 +0000
Subject: [PATCH v4 00/15] reftable library
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

version 8 Dec 2020:

 * fixes for windows: add random suffix to table names
 * tagged unions for reftable_ref_record
 * some fixes by dscho
 * some tweaks in response to Felipe Contreras
 * switched to github.com/hanwen/reftable (which does not need CLA)

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
 refs/reftable-backend.c                       | 1435 +++++++++++++++++
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
 reftable/record.c                             | 1157 +++++++++++++
 reftable/record.h                             |  139 ++
 reftable/record_test.c                        |  398 +++++
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
 reftable/reftable-record.h                    |  100 ++
 reftable/reftable-stack.h                     |  120 ++
 reftable/reftable-tests.h                     |   22 +
 reftable/reftable-writer.h                    |  147 ++
 reftable/reftable.c                           |   98 ++
 reftable/reftable_test.c                      |  580 +++++++
 reftable/stack.c                              | 1260 +++++++++++++++
 reftable/stack.h                              |   41 +
 reftable/stack_test.c                         |  803 +++++++++
 reftable/system.h                             |   32 +
 reftable/test_framework.c                     |   23 +
 reftable/test_framework.h                     |   53 +
 reftable/tree.c                               |   63 +
 reftable/tree.h                               |   34 +
 reftable/tree_test.c                          |   61 +
 reftable/writer.c                             |  681 ++++++++
 reftable/writer.h                             |   50 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |    9 +-
 t/helper/test-reftable.c                      |   20 +
 t/helper/test-tool.c                          |    4 +-
 t/helper/test-tool.h                          |    2 +
 t/t0031-reftable.sh                           |  199 +++
 t/t0032-reftable-unittest.sh                  |   15 +
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1450-fsck.sh                               |    6 +
 t/t3210-pack-refs.sh                          |    6 +
 t/test-lib.sh                                 |    5 +
 82 files changed, 12112 insertions(+), 40 deletions(-)
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


base-commit: 3a0b884caba2752da0af626fb2de7d597c844e8b
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-847%2Fhanwen%2Flibreftable-v4
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-847/hanwen/libreftable-v4
Pull-Request: https://github.com/git/git/pull/847

Range-diff vs v3:

  1:  030998a732a <  -:  ----------- move sleep_millisec to git-compat-util.h
  2:  cf667653dff <  -:  ----------- init-db: set the_repository->hash_algo early on
  -:  ----------- >  1:  40ac041d0ef init-db: set the_repository->hash_algo early on
  3:  91c3ac2449e =  2:  cc0fe58bd33 reftable: add LICENSE
  4:  2aa30f536fb !  3:  798f680b800 reftable: add error related functionality
     @@ reftable/error.c (new)
      +		return "zlib failure";
      +	case REFTABLE_NAME_CONFLICT:
      +		return "file/directory conflict";
     ++	case REFTABLE_EMPTY_TABLE_ERROR:
     ++		return "wrote empty table";
      +	case REFTABLE_REFNAME_ERROR:
      +		return "invalid refname";
      +	case -1:
     @@ reftable/reftable-error.h (new)
      +#define REFTABLE_ERROR_H
      +
      +/*
     -+ Errors in reftable calls are signaled with negative integer return values. 0
     -+ means success.
     -+*/
     ++ * Errors in reftable calls are signaled with negative integer return values. 0
     ++ * means success.
     ++ */
      +enum reftable_error {
      +	/* Unexpected file system behavior */
      +	REFTABLE_IO_ERROR = -2,
      +
     -+	/* Format inconsistency on reading data
     -+	 */
     ++	/* Format inconsistency on reading data */
      +	REFTABLE_FORMAT_ERROR = -3,
      +
     -+	/* File does not exist. Returned from block_source_from_file(),  because
     -+	   it needs special handling in stack.
     -+	*/
     ++	/* File does not exist. Returned from block_source_from_file(), because
     ++	 * it needs special handling in stack.
     ++	 */
      +	REFTABLE_NOT_EXIST_ERROR = -4,
      +
      +	/* Trying to write out-of-date data. */
      +	REFTABLE_LOCK_ERROR = -5,
      +
      +	/* Misuse of the API:
     -+	   - on writing a record with NULL refname.
     -+	   - on writing a reftable_ref_record outside the table limits
     -+	   - on writing a ref or log record before the stack's next_update_index
     -+	   - on writing a log record with multiline message with
     -+	   exact_log_message unset
     -+	   - on reading a reftable_ref_record from log iterator, or vice versa.
     -+
     -+	  When a call misuses the API, the internal state of the library is kept
     -+	  unchanged.
     -+	*/
     ++	 *  - on writing a record with NULL refname.
     ++	 *  - on writing a reftable_ref_record outside the table limits
     ++	 *  - on writing a ref or log record before the stack's
     ++	 * next_update_inde*x
     ++	 *  - on writing a log record with multiline message with
     ++	 *  exact_log_message unset
     ++	 *  - on reading a reftable_ref_record from log iterator, or vice versa.
     ++	 *
     ++	 * When a call misuses the API, the internal state of the library is
     ++	 * kept unchanged.
     ++	 */
      +	REFTABLE_API_ERROR = -6,
      +
      +	/* Decompression error */
     @@ reftable/reftable-error.h (new)
      +	/* Dir/file conflict. */
      +	REFTABLE_NAME_CONFLICT = -9,
      +
     -+	/* Illegal ref name. */
     ++	/* Invalid ref name. */
      +	REFTABLE_REFNAME_ERROR = -10,
      +};
      +
  5:  987d1d186fd !  4:  2f55ff6d240 reftable: utility functions
     @@ Commit message
          This commit provides basic utility classes for the reftable library.
      
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
     +    Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
      
       ## Makefile ##
      @@ Makefile: TEST_BUILTINS_OBJS += test-read-cache.o
     @@ Makefile: cocciclean:
       	$(RM) $(TEST_PROGRAMS)
       	$(RM) $(FUZZ_PROGRAMS)
      
     + ## contrib/buildsystems/CMakeLists.txt ##
     +@@ contrib/buildsystems/CMakeLists.txt: parse_makefile_for_sources(libxdiff_SOURCES "XDIFF_OBJS")
     + list(TRANSFORM libxdiff_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
     + add_library(xdiff STATIC ${libxdiff_SOURCES})
     + 
     ++#reftable
     ++parse_makefile_for_sources(reftable_SOURCES "REFTABLE_OBJS")
     ++
     ++list(TRANSFORM reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
     ++add_library(reftable STATIC ${reftable_SOURCES})
     ++
     + if(WIN32)
     + 	if(NOT MSVC)#use windres when compiling with gcc and clang
     + 		add_custom_command(OUTPUT ${CMAKE_BINARY_DIR}/git.res
     +@@ contrib/buildsystems/CMakeLists.txt: endif()
     + #link all required libraries to common-main
     + add_library(common-main OBJECT ${CMAKE_SOURCE_DIR}/common-main.c)
     + 
     +-target_link_libraries(common-main libgit xdiff ${ZLIB_LIBRARIES})
     ++target_link_libraries(common-main libgit xdiff reftable ${ZLIB_LIBRARIES})
     + if(Intl_FOUND)
     + 	target_link_libraries(common-main ${Intl_LIBRARIES})
     + endif()
     +@@ contrib/buildsystems/CMakeLists.txt: if(BUILD_TESTING)
     + add_executable(test-fake-ssh ${CMAKE_SOURCE_DIR}/t/helper/test-fake-ssh.c)
     + target_link_libraries(test-fake-ssh common-main)
     + 
     ++#reftable-tests
     ++parse_makefile_for_sources(test-reftable_SOURCES "REFTABLE_TEST_OBJS")
     ++list(TRANSFORM test-reftable_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/")
     ++
     + #test-tool
     + parse_makefile_for_sources(test-tool_SOURCES "TEST_BUILTINS_OBJS")
     + 
     + list(TRANSFORM test-tool_SOURCES PREPEND "${CMAKE_SOURCE_DIR}/t/helper/")
     +-add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES})
     ++add_executable(test-tool ${CMAKE_SOURCE_DIR}/t/helper/test-tool.c ${test-tool_SOURCES} ${test-reftable_SOURCES})
     + target_link_libraries(test-tool common-main)
     + 
     + set_target_properties(test-fake-ssh test-tool
     +
       ## reftable/basics.c (new) ##
      @@
      +/*
     @@ reftable/basics.c (new)
      +	size_t lo = 0;
      +	size_t hi = sz;
      +
     -+	/* invariant: (hi == sz) || f(hi) == true
     -+	   (lo == 0 && f(0) == true) || fi(lo) == false
     ++	/* Invariants:
     ++	 *
     ++	 *  (hi == sz) || f(hi) == true
     ++	 *  (lo == 0 && f(0) == true) || fi(lo) == false
      +	 */
      +	while (hi - lo > 1) {
      +		size_t mid = lo + (hi - lo) / 2;
      +
     -+		int val = f(mid, args);
     -+		if (val) {
     ++		if (f(mid, args))
      +			hi = mid;
     -+		} else {
     ++		else
      +			lo = mid;
     -+		}
      +	}
      +
     -+	if (lo == 0) {
     -+		if (f(0, args)) {
     -+			return 0;
     -+		} else {
     -+			return 1;
     -+		}
     -+	}
     ++	if (lo)
     ++		return hi;
      +
     -+	return hi;
     ++	return f(0, args) ? 0 : 1;
      +}
      +
      +void free_names(char **a)
      +{
     -+	char **p = a;
     -+	if (p == NULL) {
     ++	char **p;
     ++	if (a == NULL) {
      +		return;
      +	}
     -+	while (*p) {
     ++	for (p = a; *p; p++) {
      +		reftable_free(*p);
     -+		p++;
      +	}
      +	reftable_free(a);
      +}
      +
      +int names_length(char **names)
      +{
     -+	int len = 0;
      +	char **p = names;
     -+	while (*p) {
     -+		p++;
     -+		len++;
     ++	for (; *p; p++) {
     ++		/* empty */
      +	}
     -+	return len;
     ++	return p - names;
      +}
      +
      +void parse_names(char *buf, int size, char ***namesp)
     @@ reftable/basics.c (new)
      +	char *end = buf + size;
      +	while (p < end) {
      +		char *next = strchr(p, '\n');
     -+		if (next != NULL) {
     ++		if (next && next < end) {
      +			*next = 0;
      +		} else {
      +			next = end;
     @@ reftable/basics.c (new)
      +			if (names_len == names_cap) {
      +				names_cap = 2 * names_cap + 1;
      +				names = reftable_realloc(
     -+					names, names_cap * sizeof(char *));
     ++					names, names_cap * sizeof(*names));
      +			}
      +			names[names_len++] = xstrdup(p);
      +		}
      +		p = next + 1;
      +	}
      +
     -+	if (names_len == names_cap) {
     -+		names_cap = 2 * names_cap + 1;
     -+		names = reftable_realloc(names, names_cap * sizeof(char *));
     -+	}
     -+
     ++	names = reftable_realloc(names, (names_len + 1) * sizeof(*names));
      +	names[names_len] = NULL;
      +	*namesp = names;
      +}
      +
      +int names_equal(char **a, char **b)
      +{
     -+	while (*a && *b) {
     -+		if (strcmp(*a, *b)) {
     ++	int i = 0;
     ++	for (; a[i] && b[i]; i++) {
     ++		if (strcmp(a[i], b[i])) {
      +			return 0;
      +		}
     -+
     -+		a++;
     -+		b++;
      +	}
      +
     -+	return *a == *b;
     ++	return a[i] == b[i];
      +}
      +
      +int common_prefix_size(struct strbuf *a, struct strbuf *b)
      +{
      +	int p = 0;
     -+	while (p < a->len && p < b->len) {
     -+		if (a->buf[p] != b->buf[p]) {
     ++	for (; p < a->len && p < b->len; p++) {
     ++		if (a->buf[p] != b->buf[p])
      +			break;
     -+		}
     -+		p++;
      +	}
      +
      +	return p;
     @@ reftable/basics.h (new)
      +void put_be16(uint8_t *out, uint16_t i);
      +
      +/*
     -+  find smallest index i in [0, sz) at which f(i) is true, assuming
     -+  that f is ascending. Return sz if f(i) is false for all indices.
     -+*/
     ++ * find smallest index i in [0, sz) at which f(i) is true, assuming
     ++ * that f is ascending. Return sz if f(i) is false for all indices.
     ++ *
     ++ * Contrary to bsearch(3), this returns something useful if the argument is not
     ++ * found.
     ++ */
      +int binsearch(size_t sz, int (*f)(size_t k, void *args), void *args);
      +
      +/*
     -+  Frees a NULL terminated array of malloced strings. The array itself is also
     -+  freed.
     ++ * Frees a NULL terminated array of malloced strings. The array itself is also
     ++ * freed.
      + */
      +void free_names(char **a);
      +
     -+/* parse a newline separated list of names. Empty names are discarded. */
     ++/* parse a newline separated list of names. `size` is the length of the buffer,
     ++ * without terminating '\0'. Empty names are discarded. */
      +void parse_names(char *buf, int size, char ***namesp);
      +
      +/* compares two NULL-terminated arrays of strings. */
     @@ reftable/basics_test.c (new)
      +	}
      +}
      +
     -+int basics_test_main(int argc, const char *argv[])
     ++static void test_names_length(void)
      +{
     -+	test_binsearch();
     -+	return 0;
     ++	char *a[] = { "a", "b", NULL };
     ++	EXPECT(names_length(a) == 2);
      +}
     -
     - ## reftable/compat.h (new) ##
     -@@
     -+/*
     -+Copyright 2020 Google LLC
     -+
     -+Use of this source code is governed by a BSD-style
     -+license that can be found in the LICENSE file or at
     -+https://developers.google.com/open-source/licenses/bsd
     -+*/
     -+
     -+#ifndef COMPAT_H
     -+#define COMPAT_H
      +
     -+#include "system.h"
     -+
     -+#ifdef REFTABLE_STANDALONE
     -+
     -+/* functions that git-core provides, for standalone compilation */
     -+#include <stdint.h>
     -+
     -+uint64_t get_be64(void *in);
     -+void put_be64(void *out, uint64_t i);
     -+
     -+void put_be32(void *out, uint32_t i);
     -+uint32_t get_be32(uint8_t *in);
     -+
     -+uint16_t get_be16(uint8_t *in);
     -+
     -+#define ARRAY_SIZE(a) sizeof((a)) / sizeof((a)[0])
     -+#define FREE_AND_NULL(x)          \
     -+	do {                      \
     -+		reftable_free(x); \
     -+		(x) = NULL;       \
     -+	} while (0)
     -+#define QSORT(arr, n, cmp) qsort(arr, n, sizeof(arr[0]), cmp)
     -+#define SWAP(a, b)                              \
     -+	{                                       \
     -+		char tmp[sizeof(a)];            \
     -+		assert(sizeof(a) == sizeof(b)); \
     -+		memcpy(&tmp[0], &a, sizeof(a)); \
     -+		memcpy(&a, &b, sizeof(a));      \
     -+		memcpy(&b, &tmp[0], sizeof(a)); \
     -+	}
     ++static void test_parse_names_normal(void)
     ++{
     ++	char in[] = "a\nb\n";
     ++	char **out = NULL;
     ++	parse_names(in, strlen(in), &out);
     ++	EXPECT(!strcmp(out[0], "a"));
     ++	EXPECT(!strcmp(out[1], "b"));
     ++	EXPECT(out[2] == NULL);
     ++	free_names(out);
     ++}
      +
     -+char *xstrdup(const char *s);
     ++static void test_parse_names_drop_empty(void)
     ++{
     ++	char in[] = "a\n\n";
     ++	char **out = NULL;
     ++	parse_names(in, strlen(in), &out);
     ++	EXPECT(!strcmp(out[0], "a"));
     ++	EXPECT(out[1] == NULL);
     ++	free_names(out);
     ++}
      +
     -+void sleep_millisec(int millisecs);
     ++static void test_common_prefix(void)
     ++{
     ++	struct strbuf s1 = STRBUF_INIT;
     ++	struct strbuf s2 = STRBUF_INIT;
     ++	strbuf_addstr(&s1, "abcdef");
     ++	strbuf_addstr(&s2, "abc");
     ++	EXPECT(common_prefix_size(&s1, &s2) == 3);
     ++	strbuf_release(&s1);
     ++	strbuf_release(&s2);
     ++}
      +
     -+#endif
     -+#endif
     ++int basics_test_main(int argc, const char *argv[])
     ++{
     ++	RUN_TEST(test_common_prefix);
     ++	RUN_TEST(test_parse_names_normal);
     ++	RUN_TEST(test_parse_names_drop_empty);
     ++	RUN_TEST(test_binsearch);
     ++	RUN_TEST(test_names_length);
     ++	return 0;
     ++}
      
       ## reftable/publicbasics.c (new) ##
      @@
     @@ reftable/reftable-malloc.h (new)
      +
      +#include <stddef.h>
      +
     -+/*
     -+  Overrides the functions to use for memory management.
     -+ */
     ++/* Overrides the functions to use for memory management. */
      +void reftable_set_alloc(void *(*malloc)(size_t),
      +			void *(*realloc)(void *, size_t), void (*free)(void *));
      +
     @@ reftable/test_framework.h (new)
      +		abort();                                                   \
      +	}
      +
     ++#define RUN_TEST(f)                          \
     ++	fprintf(stderr, "running %s\n", #f); \
     ++	fflush(stderr);                      \
     ++	f();
     ++
      +void set_test_hash(uint8_t *p, int i);
      +
      +/* Like strbuf_add, but suitable for passing to reftable_new_writer
     @@ t/t0032-reftable-unittest.sh (new)
      +. ./test-lib.sh
      +
      +test_expect_success 'unittests' '
     -+       test-tool reftable
     ++	TMPDIR=$(pwd) && export TMPDIR &&
     ++	test-tool reftable
      +'
      +
      +test_done
  6:  f71e82b995d !  5:  aaa817f8598 reftable: add blocksource, an abstraction for random access reads
     @@ reftable/reftable-blocksource.h (new)
      +};
      +
      +/* a contiguous segment of bytes. It keeps track of its generating block_source
     -+   so it can return itself into the pool.
     -+*/
     ++ * so it can return itself into the pool. */
      +struct reftable_block {
      +	uint8_t *data;
      +	int len;
  7:  bbe2ed71734 !  6:  e13afe31525 reftable: (de)serialization for the polymorphic record type.
     @@ reftable/record.c (new)
      +	return 0;
      +}
      +
     ++uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec)
     ++{
     ++	switch (rec->value_type) {
     ++	case REFTABLE_REF_VAL1:
     ++		return rec->value.val1;
     ++	case REFTABLE_REF_VAL2:
     ++		return rec->value.val2.value;
     ++	default:
     ++		return NULL;
     ++	}
     ++}
     ++
     ++uint8_t *reftable_ref_record_val2(struct reftable_ref_record *rec)
     ++{
     ++	switch (rec->value_type) {
     ++	case REFTABLE_REF_VAL2:
     ++		return rec->value.val2.target_value;
     ++	default:
     ++		return NULL;
     ++	}
     ++}
     ++
      +static int decode_string(struct strbuf *dest, struct string_view in)
      +{
      +	int start_len = in.len;
     @@ reftable/record.c (new)
      +	assert(hash_size > 0);
      +
      +	/* This is simple and correct, but we could probably reuse the hash
     -+	   fields. */
     ++	 * fields. */
      +	reftable_ref_record_release(ref);
      +	if (src->refname != NULL) {
      +		ref->refname = xstrdup(src->refname);
      +	}
     -+
     -+	if (src->target != NULL) {
     -+		ref->target = xstrdup(src->target);
     -+	}
     -+
     -+	if (src->target_value != NULL) {
     -+		ref->target_value = reftable_malloc(hash_size);
     -+		memcpy(ref->target_value, src->target_value, hash_size);
     -+	}
     -+
     -+	if (src->value != NULL) {
     -+		ref->value = reftable_malloc(hash_size);
     -+		memcpy(ref->value, src->value, hash_size);
     -+	}
      +	ref->update_index = src->update_index;
     ++	ref->value_type = src->value_type;
     ++	switch (src->value_type) {
     ++	case REFTABLE_REF_DELETION:
     ++		break;
     ++	case REFTABLE_REF_VAL1:
     ++		ref->value.val1 = reftable_malloc(hash_size);
     ++		memcpy(ref->value.val1, src->value.val1, hash_size);
     ++		break;
     ++	case REFTABLE_REF_VAL2:
     ++		ref->value.val2.value = reftable_malloc(hash_size);
     ++		memcpy(ref->value.val2.value, src->value.val2.value, hash_size);
     ++		ref->value.val2.target_value = reftable_malloc(hash_size);
     ++		memcpy(ref->value.val2.target_value,
     ++		       src->value.val2.target_value, hash_size);
     ++		break;
     ++	case REFTABLE_REF_SYMREF:
     ++		ref->value.symref = xstrdup(src->value.symref);
     ++		break;
     ++	}
      +}
      +
      +static char hexdigit(int c)
     @@ reftable/record.c (new)
      +void reftable_ref_record_print(struct reftable_ref_record *ref,
      +			       uint32_t hash_id)
      +{
     -+	char hex[SHA256_SIZE + 1] = { 0 };
     ++	char hex[2 * SHA256_SIZE + 1] = { 0 }; /* BUG */
      +	printf("ref{%s(%" PRIu64 ") ", ref->refname, ref->update_index);
     -+	if (ref->value != NULL) {
     -+		hex_format(hex, ref->value, hash_size(hash_id));
     -+		printf("%s", hex);
     -+	}
     -+	if (ref->target_value != NULL) {
     -+		hex_format(hex, ref->target_value, hash_size(hash_id));
     -+		printf(" (T %s)", hex);
     -+	}
     -+	if (ref->target != NULL) {
     -+		printf("=> %s", ref->target);
     ++	switch (ref->value_type) {
     ++	case REFTABLE_REF_SYMREF:
     ++		printf("=> %s", ref->value.symref);
     ++		break;
     ++	case REFTABLE_REF_VAL2:
     ++		hex_format(hex, ref->value.val2.value, hash_size(hash_id));
     ++		printf("val 2 %s", hex);
     ++		hex_format(hex, ref->value.val2.target_value,
     ++			   hash_size(hash_id));
     ++		printf("(T %s)", hex);
     ++		break;
     ++	case REFTABLE_REF_VAL1:
     ++		hex_format(hex, ref->value.val1, hash_size(hash_id));
     ++		printf("val 1 %s", hex);
     ++		break;
     ++	case REFTABLE_REF_DELETION:
     ++		printf("delete");
     ++		break;
      +	}
      +	printf("}\n");
      +}
     @@ reftable/record.c (new)
      +
      +void reftable_ref_record_release(struct reftable_ref_record *ref)
      +{
     ++	switch (ref->value_type) {
     ++	case REFTABLE_REF_SYMREF:
     ++		reftable_free(ref->value.symref);
     ++		break;
     ++	case REFTABLE_REF_VAL2:
     ++		reftable_free(ref->value.val2.target_value);
     ++		reftable_free(ref->value.val2.value);
     ++		break;
     ++	case REFTABLE_REF_VAL1:
     ++		reftable_free(ref->value.val1);
     ++		break;
     ++	case REFTABLE_REF_DELETION:
     ++		break;
     ++	default:
     ++		abort();
     ++	}
     ++
      +	reftable_free(ref->refname);
     -+	reftable_free(ref->target);
     -+	reftable_free(ref->target_value);
     -+	reftable_free(ref->value);
      +	memset(ref, 0, sizeof(struct reftable_ref_record));
      +}
      +
     @@ reftable/record.c (new)
      +{
      +	const struct reftable_ref_record *r =
      +		(const struct reftable_ref_record *)rec;
     -+	if (r->value != NULL) {
     -+		if (r->target_value != NULL) {
     -+			return 2;
     -+		} else {
     -+			return 1;
     -+		}
     -+	} else if (r->target != NULL)
     -+		return 3;
     -+	return 0;
     ++	return r->value_type;
      +}
      +
      +static int reftable_ref_record_encode(const void *rec, struct string_view s,
     @@ reftable/record.c (new)
      +		return -1;
      +	string_view_consume(&s, n);
      +
     -+	if (r->value != NULL) {
     -+		if (s.len < hash_size) {
     ++	switch (r->value_type) {
     ++	case REFTABLE_REF_SYMREF:
     ++		n = encode_string(r->value.symref, s);
     ++		if (n < 0) {
      +			return -1;
      +		}
     -+		memcpy(s.buf, r->value, hash_size);
     -+		string_view_consume(&s, hash_size);
     -+	}
     -+
     -+	if (r->target_value != NULL) {
     -+		if (s.len < hash_size) {
     ++		string_view_consume(&s, n);
     ++		break;
     ++	case REFTABLE_REF_VAL2:
     ++		if (s.len < 2 * hash_size) {
      +			return -1;
      +		}
     -+		memcpy(s.buf, r->target_value, hash_size);
     ++		memcpy(s.buf, r->value.val2.value, hash_size);
      +		string_view_consume(&s, hash_size);
     -+	}
     -+
     -+	if (r->target != NULL) {
     -+		int n = encode_string(r->target, s);
     -+		if (n < 0) {
     ++		memcpy(s.buf, r->value.val2.target_value, hash_size);
     ++		string_view_consume(&s, hash_size);
     ++		break;
     ++	case REFTABLE_REF_VAL1:
     ++		if (s.len < hash_size) {
      +			return -1;
      +		}
     -+		string_view_consume(&s, n);
     ++		memcpy(s.buf, r->value.val1, hash_size);
     ++		string_view_consume(&s, hash_size);
     ++		break;
     ++	case REFTABLE_REF_DELETION:
     ++		break;
     ++	default:
     ++		abort();
      +	}
      +
      +	return start.len - s.len;
     @@ reftable/record.c (new)
      +{
      +	struct reftable_ref_record *r = (struct reftable_ref_record *)rec;
      +	struct string_view start = in;
     -+	int seen_value = 0;
     -+	int seen_target_value = 0;
     -+	int seen_target = 0;
     -+
     -+	int n = get_var_int(&r->update_index, &in);
     ++	uint64_t update_index = 0;
     ++	int n = get_var_int(&update_index, &in);
      +	if (n < 0)
      +		return n;
     -+	assert(hash_size > 0);
     -+
      +	string_view_consume(&in, n);
      +
     ++	reftable_ref_record_release(r);
     ++
     ++	assert(hash_size > 0);
     ++
      +	r->refname = reftable_realloc(r->refname, key.len + 1);
      +	memcpy(r->refname, key.buf, key.len);
     ++	r->update_index = update_index;
      +	r->refname[key.len] = 0;
     -+
     ++	r->value_type = val_type;
      +	switch (val_type) {
     -+	case 1:
     -+	case 2:
     ++	case REFTABLE_REF_VAL1:
      +		if (in.len < hash_size) {
      +			return -1;
      +		}
      +
     -+		if (r->value == NULL) {
     -+			r->value = reftable_malloc(hash_size);
     -+		}
     -+		seen_value = 1;
     -+		memcpy(r->value, in.buf, hash_size);
     ++		r->value.val1 = reftable_malloc(hash_size);
     ++		memcpy(r->value.val1, in.buf, hash_size);
      +		string_view_consume(&in, hash_size);
     -+		if (val_type == 1) {
     -+			break;
     -+		}
     -+		if (r->target_value == NULL) {
     -+			r->target_value = reftable_malloc(hash_size);
     ++		break;
     ++
     ++	case REFTABLE_REF_VAL2:
     ++		if (in.len < 2 * hash_size) {
     ++			return -1;
      +		}
     -+		seen_target_value = 1;
     -+		memcpy(r->target_value, in.buf, hash_size);
     ++
     ++		r->value.val2.value = reftable_malloc(hash_size);
     ++		memcpy(r->value.val2.value, in.buf, hash_size);
     ++		string_view_consume(&in, hash_size);
     ++
     ++		r->value.val2.target_value = reftable_malloc(hash_size);
     ++		memcpy(r->value.val2.target_value, in.buf, hash_size);
      +		string_view_consume(&in, hash_size);
      +		break;
     -+	case 3: {
     ++
     ++	case REFTABLE_REF_SYMREF: {
      +		struct strbuf dest = STRBUF_INIT;
      +		int n = decode_string(&dest, in);
      +		if (n < 0) {
      +			return -1;
      +		}
      +		string_view_consume(&in, n);
     -+		seen_target = 1;
     -+		if (r->target != NULL) {
     -+			reftable_free(r->target);
     -+		}
     -+		r->target = dest.buf;
     ++		r->value.symref = dest.buf;
      +	} break;
      +
     -+	case 0:
     ++	case REFTABLE_REF_DELETION:
      +		break;
      +	default:
      +		abort();
      +		break;
      +	}
      +
     -+	if (!seen_target && r->target != NULL) {
     -+		FREE_AND_NULL(r->target);
     -+	}
     -+	if (!seen_target_value && r->target_value != NULL) {
     -+		FREE_AND_NULL(r->target_value);
     -+	}
     -+	if (!seen_value && r->value != NULL) {
     -+		FREE_AND_NULL(r->value);
     -+	}
     -+
      +	return start.len - in.len;
      +}
      +
     @@ reftable/record.c (new)
      +	return a == b;
      +}
      +
     -+static int str_equal(char *a, char *b)
     -+{
     -+	if (a != NULL && b != NULL)
     -+		return 0 == strcmp(a, b);
     -+
     -+	return a == b;
     -+}
     -+
      +int reftable_ref_record_equal(struct reftable_ref_record *a,
      +			      struct reftable_ref_record *b, int hash_size)
      +{
      +	assert(hash_size > 0);
     -+	return 0 == strcmp(a->refname, b->refname) &&
     -+	       a->update_index == b->update_index &&
     -+	       hash_equal(a->value, b->value, hash_size) &&
     -+	       hash_equal(a->target_value, b->target_value, hash_size) &&
     -+	       str_equal(a->target, b->target);
     ++	if (!(0 == strcmp(a->refname, b->refname) &&
     ++	      a->update_index == b->update_index &&
     ++	      a->value_type == b->value_type))
     ++		return 0;
     ++
     ++	switch (a->value_type) {
     ++	case REFTABLE_REF_SYMREF:
     ++		return !strcmp(a->value.symref, b->value.symref);
     ++	case REFTABLE_REF_VAL2:
     ++		return hash_equal(a->value.val2.value, b->value.val2.value,
     ++				  hash_size) &&
     ++		       hash_equal(a->value.val2.target_value,
     ++				  b->value.val2.target_value, hash_size);
     ++	case REFTABLE_REF_VAL1:
     ++		return hash_equal(a->value.val1, b->value.val1, hash_size);
     ++	case REFTABLE_REF_DELETION:
     ++		return 1;
     ++	default:
     ++		abort();
     ++	}
      +}
      +
      +int reftable_ref_record_compare_name(const void *a, const void *b)
     @@ reftable/record.c (new)
      +
      +int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref)
      +{
     -+	return ref->value == NULL && ref->target == NULL &&
     -+	       ref->target_value == NULL;
     ++	return ref->value_type == REFTABLE_REF_DELETION;
      +}
      +
      +int reftable_log_record_compare_key(const void *a, const void *b)
     @@ reftable/record.h (new)
      +#include "reftable-record.h"
      +
      +/*
     -+  A substring of existing string data. This structure takes no responsibility
     -+  for the lifetime of the data it points to.
     -+*/
     ++ * A substring of existing string data. This structure takes no responsibility
     ++ * for the lifetime of the data it points to.
     ++ */
      +struct string_view {
      +	uint8_t *buf;
      +	size_t len;
     @@ reftable/record.h (new)
      +struct reftable_record reftable_new_record(uint8_t typ);
      +
      +/* Encode `key` into `dest`. Sets `is_restart` to indicate a restart. Returns
     -+   number of bytes written. */
     ++ * number of bytes written. */
      +int reftable_encode_key(int *is_restart, struct string_view dest,
      +			struct strbuf prev_key, struct strbuf key,
      +			uint8_t extra);
     @@ reftable/record_test.c (new)
      +{
      +	int i = 0;
      +
     -+	for (i = 0; i <= 3; i++) {
     ++	for (i = REFTABLE_REF_DELETION; i < REFTABLE_NR_REF_VALUETYPES; i++) {
      +		struct reftable_ref_record in = { NULL };
     -+		struct reftable_ref_record out = {
     -+			.refname = xstrdup("old name"),
     -+			.value = reftable_calloc(SHA1_SIZE),
     -+			.target_value = reftable_calloc(SHA1_SIZE),
     -+			.target = xstrdup("old value"),
     -+		};
     ++		struct reftable_ref_record out = { NULL };
      +		struct reftable_record rec_out = { NULL };
      +		struct strbuf key = STRBUF_INIT;
      +		struct reftable_record rec = { NULL };
     @@ reftable/record_test.c (new)
      +
      +		int n, m;
      +
     ++		in.value_type = i;
      +		switch (i) {
     -+		case 0:
     ++		case REFTABLE_REF_DELETION:
      +			break;
     -+		case 1:
     -+			in.value = reftable_malloc(SHA1_SIZE);
     -+			set_hash(in.value, 1);
     ++		case REFTABLE_REF_VAL1:
     ++			in.value.val1 = reftable_malloc(SHA1_SIZE);
     ++			set_hash(in.value.val1, 1);
      +			break;
     -+		case 2:
     -+			in.value = reftable_malloc(SHA1_SIZE);
     -+			set_hash(in.value, 1);
     -+			in.target_value = reftable_malloc(SHA1_SIZE);
     -+			set_hash(in.target_value, 2);
     ++		case REFTABLE_REF_VAL2:
     ++			in.value.val2.value = reftable_malloc(SHA1_SIZE);
     ++			set_hash(in.value.val2.value, 1);
     ++			in.value.val2.target_value = reftable_malloc(SHA1_SIZE);
     ++			set_hash(in.value.val2.target_value, 2);
      +			break;
     -+		case 3:
     -+			in.target = xstrdup("target");
     ++		case REFTABLE_REF_SYMREF:
     ++			in.value.symref = xstrdup("target");
      +			break;
      +		}
      +		in.refname = xstrdup("refs/heads/master");
     @@ reftable/record_test.c (new)
      +		m = reftable_record_decode(&rec_out, key, i, dest, SHA1_SIZE);
      +		EXPECT(n == m);
      +
     -+		EXPECT((out.value != NULL) == (in.value != NULL));
     -+		EXPECT((out.target_value != NULL) == (in.target_value != NULL));
     -+		EXPECT((out.target != NULL) == (in.target != NULL));
     ++		EXPECT(reftable_ref_record_equal(&in, &out, SHA1_SIZE));
      +		reftable_record_release(&rec_out);
      +
      +		strbuf_release(&key);
     @@ reftable/record_test.c (new)
      +
      +int record_test_main(int argc, const char *argv[])
      +{
     -+	test_reftable_log_record_equal();
     -+	test_reftable_log_record_roundtrip();
     -+	test_reftable_ref_record_roundtrip();
     -+	test_varint_roundtrip();
     -+	test_key_roundtrip();
     -+	test_common_prefix();
     -+	test_reftable_obj_record_roundtrip();
     -+	test_reftable_index_record_roundtrip();
     -+	test_u24_roundtrip();
     ++	RUN_TEST(test_reftable_log_record_equal);
     ++	RUN_TEST(test_reftable_log_record_roundtrip);
     ++	RUN_TEST(test_reftable_ref_record_roundtrip);
     ++	RUN_TEST(test_varint_roundtrip);
     ++	RUN_TEST(test_key_roundtrip);
     ++	RUN_TEST(test_common_prefix);
     ++	RUN_TEST(test_reftable_obj_record_roundtrip);
     ++	RUN_TEST(test_reftable_index_record_roundtrip);
     ++	RUN_TEST(test_u24_roundtrip);
      +	return 0;
      +}
      
     @@ reftable/reftable-record.h (new)
      +#include <stdint.h>
      +
      +/*
     -+ Basic data types
     -+
     -+ Reftables store the state of each ref in struct reftable_ref_record, and they
     -+ store a sequence of reflog updates in struct reftable_log_record.
     -+*/
     ++ * Basic data types
     ++ *
     ++ * Reftables store the state of each ref in struct reftable_ref_record, and they
     ++ * store a sequence of reflog updates in struct reftable_log_record.
     ++ */
      +
      +/* reftable_ref_record holds a ref database entry target_value */
      +struct reftable_ref_record {
      +	char *refname; /* Name of the ref, malloced. */
      +	uint64_t update_index; /* Logical timestamp at which this value is
     -+				  written */
     -+	uint8_t *value; /* SHA1, or NULL. malloced. */
     -+	uint8_t *target_value; /* peeled annotated tag, or NULL. malloced. */
     -+	char *target; /* symref, or NULL. malloced. */
     ++				* written */
     ++
     ++	enum {
     ++		/* tombstone to hide deletions from earlier tables */
     ++		REFTABLE_REF_DELETION = 0x0,
     ++
     ++		/* a simple ref */
     ++		REFTABLE_REF_VAL1 = 0x1,
     ++		/* a tag, plus its peeled hash */
     ++		REFTABLE_REF_VAL2 = 0x2,
     ++
     ++		/* a symbolic reference */
     ++		REFTABLE_REF_SYMREF = 0x3,
     ++#define REFTABLE_NR_REF_VALUETYPES 4
     ++	} value_type;
     ++	union {
     ++		uint8_t *val1; /* malloced hash. */
     ++		struct {
     ++			uint8_t *value; /* first value, malloced hash  */
     ++			uint8_t *target_value; /* second value, malloced hash */
     ++		} val2;
     ++		char *symref; /* referent, malloced 0-terminated string */
     ++	} value;
      +};
      +
     ++/* Returns the first hash, or NULL if `rec` is not of type
     ++ * REFTABLE_REF_VAL1 or REFTABLE_REF_VAL2. */
     ++uint8_t *reftable_ref_record_val1(struct reftable_ref_record *rec);
     ++
     ++/* Returns the second hash, or NULL if `rec` is not of type
     ++ * REFTABLE_REF_VAL2. */
     ++uint8_t *reftable_ref_record_val2(struct reftable_ref_record *rec);
     ++
      +/* returns whether 'ref' represents a deletion */
      +int reftable_ref_record_is_deletion(const struct reftable_ref_record *ref);
      +
     -+/* prints a reftable_ref_record onto stdout */
     ++/* prints a reftable_ref_record onto stdout. Useful for debugging. */
      +void reftable_ref_record_print(struct reftable_ref_record *ref,
      +			       uint32_t hash_id);
      +
     -+/* frees and nulls all pointer values. */
     ++/* frees and nulls all pointer values inside `ref`. */
      +void reftable_ref_record_release(struct reftable_ref_record *ref);
      +
     -+/* returns whether two reftable_ref_records are the same */
     ++/* returns whether two reftable_ref_records are the same. Useful for testing. */
      +int reftable_ref_record_equal(struct reftable_ref_record *a,
      +			      struct reftable_ref_record *b, int hash_size);
      +
  8:  a358b052d56 !  7:  a48b9937642 reftable: reading/writing blocks
     @@ reftable/block.h (new)
      +#include "reftable-blocksource.h"
      +
      +/*
     -+  Writes reftable blocks. The block_writer is reused across blocks to minimize
     -+  allocation overhead.
     -+*/
     ++ * Writes reftable blocks. The block_writer is reused across blocks to minimize
     ++ * allocation overhead.
     ++ */
      +struct block_writer {
      +	uint8_t *buf;
      +	uint32_t block_size;
     @@ reftable/block.h (new)
      +};
      +
      +/*
     -+  initializes the blockwriter to write `typ` entries, using `buf` as temporary
     -+  storage. `buf` is not owned by the block_writer. */
     ++ * initializes the blockwriter to write `typ` entries, using `buf` as temporary
     ++ * storage. `buf` is not owned by the block_writer. */
      +void block_writer_init(struct block_writer *bw, uint8_t typ, uint8_t *buf,
      +		       uint32_t block_size, uint32_t header_off, int hash_size);
      +
     -+/*
     -+  returns the block type (eg. 'r' for ref records.
     -+*/
     ++/* returns the block type (eg. 'r' for ref records. */
      +uint8_t block_writer_type(struct block_writer *bw);
      +
      +/* appends the record, or -1 if it doesn't fit. */
     @@ reftable/block_test.c (new)
      +		memset(hash, i, sizeof(hash));
      +
      +		ref.refname = name;
     -+		ref.value = hash;
     ++		ref.value_type = REFTABLE_REF_VAL1;
     ++		ref.value.val1 = hash;
     ++
      +		names[i] = xstrdup(name);
      +		n = block_writer_add(&bw, &rec);
      +		ref.refname = NULL;
     -+		ref.value = NULL;
     ++		ref.value_type = REFTABLE_REF_DELETION;
      +		EXPECT(n == 0);
      +	}
      +
     @@ reftable/block_test.c (new)
      +
      +int block_test_main(int argc, const char *argv[])
      +{
     -+	test_block_read_write();
     ++	RUN_TEST(test_block_read_write);
      +	return 0;
      +}
      
  9:  24afac9c91a !  8:  6968dbc3828 reftable: a generic binary tree implementation
     @@ reftable/tree.h (new)
      +};
      +
      +/* looks for `key` in `rootp` using `compare` as comparison function. If insert
     -+   is set, insert the key if it's not found. Else, return NULL.
     -+*/
     ++ * is set, insert the key if it's not found. Else, return NULL.
     ++ */
      +struct tree_node *tree_search(void *key, struct tree_node **rootp,
      +			      int (*compare)(const void *, const void *),
      +			      int insert);
     @@ reftable/tree.h (new)
      +		void *arg);
      +
      +/*
     -+  deallocates the tree nodes recursively. Keys should be deallocated separately
     -+  by walking over the tree. */
     ++ * deallocates the tree nodes recursively. Keys should be deallocated separately
     ++ * by walking over the tree. */
      +void tree_free(struct tree_node *t);
      +
      +#endif
     @@ reftable/tree_test.c (new)
      +
      +int tree_test_main(int argc, const char *argv[])
      +{
     -+	test_tree();
     ++	RUN_TEST(test_tree);
      +	return 0;
      +}
      
 10:  5f0b7c55925 !  9:  ff5b424d12f reftable: write reftable files
     @@ reftable/reftable-writer.h (new)
      +
      +#include "reftable-record.h"
      +
     -+/*
     -+ Writing single reftables
     -+*/
     ++/* Writing single reftables */
      +
      +/* reftable_write_options sets options for writing a single reftable. */
      +struct reftable_write_options {
     @@ reftable/writer.c (new)
      +
      +	reftable_record_from_ref(&rec, &copy);
      +	copy.update_index -= w->min_update_index;
     ++
      +	err = writer_add_record(w, &rec);
      +	if (err < 0)
      +		return err;
      +
     -+	if (!w->opts.skip_index_objects && ref->value != NULL) {
     ++	if (!w->opts.skip_index_objects &&
     ++	    reftable_ref_record_val1(ref) != NULL) {
      +		struct strbuf h = STRBUF_INIT;
     -+		strbuf_add(&h, (char *)ref->value, hash_size(w->opts.hash_id));
     ++		strbuf_add(&h, (char *)reftable_ref_record_val1(ref),
     ++			   hash_size(w->opts.hash_id));
      +		writer_index_hash(w, &h);
      +		strbuf_release(&h);
      +	}
      +
     -+	if (!w->opts.skip_index_objects && ref->target_value != NULL) {
     ++	if (!w->opts.skip_index_objects &&
     ++	    reftable_ref_record_val2(ref) != NULL) {
      +		struct strbuf h = STRBUF_INIT;
     -+		strbuf_add(&h, ref->target_value, hash_size(w->opts.hash_id));
     ++		strbuf_add(&h, reftable_ref_record_val2(ref),
     ++			   hash_size(w->opts.hash_id));
      +		writer_index_hash(w, &h);
      +		strbuf_release(&h);
      +	}
     @@ reftable/writer.h (new)
      +	size_t index_cap;
      +
      +	/*
     -+	  tree for use with tsearch; used to populate the 'o' inverse OID
     -+	  map */
     ++	 * tree for use with tsearch; used to populate the 'o' inverse OID
     ++	 * map */
      +	struct tree_node *obj_index_tree;
      +
      +	struct reftable_stats stats;
 11:  9aa2caade8c ! 10:  3c2de7dcc65 reftable: read reftable files
     @@ reftable/iter.c (new)
      +			}
      +		}
      +
     -+		if ((ref->target_value != NULL &&
     -+		     !memcmp(fri->oid.buf, ref->target_value, fri->oid.len)) ||
     -+		    (ref->value != NULL &&
     -+		     !memcmp(fri->oid.buf, ref->value, fri->oid.len))) {
     ++		if (ref->value_type == REFTABLE_REF_VAL2 &&
     ++		    (!memcmp(fri->oid.buf, ref->value.val2.target_value,
     ++			     fri->oid.len) ||
     ++		     !memcmp(fri->oid.buf, ref->value.val2.value,
     ++			     fri->oid.len)))
     ++			return 0;
     ++
     ++		if (ref->value_type == REFTABLE_REF_VAL1 &&
     ++		    !memcmp(fri->oid.buf, ref->value.val1, fri->oid.len)) {
      +			return 0;
      +		}
      +	}
     @@ reftable/iter.c (new)
      +			}
      +			continue;
      +		}
     -+
     -+		if (!memcmp(it->oid.buf, ref->target_value, it->oid.len) ||
     -+		    !memcmp(it->oid.buf, ref->value, it->oid.len)) {
     ++		/* BUG */
     ++		if (!memcmp(it->oid.buf, ref->value.val2.target_value,
     ++			    it->oid.len) ||
     ++		    !memcmp(it->oid.buf, ref->value.val2.value, it->oid.len)) {
      +			return 0;
      +		}
      +	}
     @@ reftable/iter.h (new)
      +int iterator_next(struct reftable_iterator *it, struct reftable_record *rec);
      +
      +/* Returns true for a zeroed out iterator, such as the one returned from
     -+   iterator_destroy. */
     ++ * iterator_destroy. */
      +int iterator_is_null(struct reftable_iterator *it);
      +
      +/* iterator that produces only ref records that point to `oid` */
     @@ reftable/iter.h (new)
      +					  struct filtering_ref_iterator *);
      +
      +/* iterator that produces only ref records that point to `oid`,
     -+   but using the object index.
     ++ * but using the object index.
      + */
      +struct indexed_table_ref_iter {
      +	struct reftable_reader *r;
     @@ reftable/reftable-iterator.h (new)
      +#include "reftable-record.h"
      +
      +/* iterator is the generic interface for walking over data stored in a
     -+   reftable.
     -+*/
     ++ * reftable.
     ++ */
      +struct reftable_iterator {
      +	struct reftable_iterator_vtable *ops;
      +	void *iter_arg;
      +};
      +
      +/* reads the next reftable_ref_record. Returns < 0 for error, 0 for OK and > 0:
     -+   end of iteration.
     -+*/
     ++ * end of iteration.
     ++ */
      +int reftable_iterator_next_ref(struct reftable_iterator *it,
      +			       struct reftable_ref_record *ref);
      +
      +/* reads the next reftable_log_record. Returns < 0 for error, 0 for OK and > 0:
     -+   end of iteration.
     -+*/
     ++ * end of iteration.
     ++ */
      +int reftable_iterator_next_log(struct reftable_iterator *it,
      +			       struct reftable_log_record *log);
      +
     @@ reftable/reftable-reader.h (new)
      +#include "reftable-blocksource.h"
      +
      +/*
     -+ Reading single tables
     -+
     -+ The follow routines are for reading single files. For an application-level
     -+ interface, skip ahead to struct reftable_merged_table and struct
     -+ reftable_stack.
     -+*/
     ++ * Reading single tables
     ++ *
     ++ * The follow routines are for reading single files. For an application-level
     ++ * interface, skip ahead to struct reftable_merged_table and struct
     ++ * reftable_stack.
     ++ */
      +
      +/* The reader struct is a handle to an open reftable file. */
      +struct reftable_reader;
 12:  581a4200d64 ! 11:  03681b820d1 reftable: reftable file level tests
     @@ reftable/reftable_test.c (new)
      +		snprintf(name, sizeof(name), "refs/heads/branch%02d", i);
      +
      +		ref.refname = name;
     -+		ref.value = hash;
      +		ref.update_index = update_index;
     ++		ref.value_type = REFTABLE_REF_VAL1;
     ++		ref.value.val1 = hash;
      +		(*names)[i] = xstrdup(name);
      +
      +		n = reftable_writer_add_ref(w, &ref);
     @@ reftable/reftable_test.c (new)
      +		err = reftable_iterator_next_ref(&it, &ref);
      +		EXPECT_ERR(err);
      +		EXPECT(0 == strcmp(names[i], ref.refname));
     -+		EXPECT(i == ref.value[0]);
     ++		EXPECT(REFTABLE_REF_VAL1 == ref.value_type);
     ++		EXPECT(i == ref.value.val1[0]);
      +
      +		reftable_ref_record_release(&ref);
      +		reftable_iterator_destroy(&it);
     @@ reftable/reftable_test.c (new)
      +
      +		set_test_hash(hash1, i / 4);
      +		set_test_hash(hash2, 3 + i / 4);
     -+		ref.value = hash1;
     -+		ref.target_value = hash2;
     ++		ref.value_type = REFTABLE_REF_VAL2;
     ++		ref.value.val2.value = hash1;
     ++		ref.value.val2.target_value = hash2;
      +
      +		/* 80 bytes / entry, so 3 entries per block. Yields 17
      +		 */
     @@ reftable/reftable_test.c (new)
      +
      +int reftable_test_main(int argc, const char *argv[])
      +{
     -+	test_log_write_read();
     -+	test_table_read_write_seek_linear_sha256();
     -+	test_log_buffer_size();
     -+	test_table_write_small_table();
     -+	test_buffer();
     -+	test_table_read_api();
     -+	test_table_read_write_sequential();
     -+	test_table_read_write_seek_linear();
     -+	test_table_read_write_seek_index();
     -+	test_table_refs_for_no_index();
     -+	test_table_refs_for_obj_index();
     -+	test_table_empty();
     ++	RUN_TEST(test_log_write_read);
     ++	RUN_TEST(test_table_read_write_seek_linear_sha256);
     ++	RUN_TEST(test_log_buffer_size);
     ++	RUN_TEST(test_table_write_small_table);
     ++	RUN_TEST(test_buffer);
     ++	RUN_TEST(test_table_read_api);
     ++	RUN_TEST(test_table_read_write_sequential);
     ++	RUN_TEST(test_table_read_write_seek_linear);
     ++	RUN_TEST(test_table_read_write_seek_index);
     ++	RUN_TEST(test_table_refs_for_no_index);
     ++	RUN_TEST(test_table_refs_for_obj_index);
     ++	RUN_TEST(test_table_empty);
      +	return 0;
      +}
      
 13:  a26fb180add ! 12:  557183d3e3e reftable: rest of library
     @@ Makefile: REFTABLE_OBJS += reftable/error.o
      
       ## reftable/VERSION (new) ##
      @@
     -+b8ec0f74c74cb6752eb2033ad8e755a9c19aad15 C: add missing header
     ++9b4a54059db9a05c270c0a0587f245bc6868d576 C: use rand() rather than cobbled together random generator.
      
       ## reftable/dump.c (new) ##
      @@
     @@ reftable/merged_test.c (new)
      +	struct reftable_ref_record r1[] = { {
      +		.refname = "b",
      +		.update_index = 1,
     -+		.value = hash1,
     ++		.value_type = REFTABLE_REF_VAL1,
     ++		.value.val1 = hash1,
      +	} };
      +	struct reftable_ref_record r2[] = { {
      +		.refname = "a",
      +		.update_index = 2,
     ++		.value_type = REFTABLE_REF_DELETION,
      +	} };
      +
      +	struct reftable_ref_record *refs[] = { r1, r2 };
     @@ reftable/merged_test.c (new)
      +{
      +	uint8_t hash1[SHA1_SIZE] = { 1 };
      +	uint8_t hash2[SHA1_SIZE] = { 2 };
     -+	struct reftable_ref_record r1[] = { {
     -+						    .refname = "a",
     -+						    .update_index = 1,
     -+						    .value = hash1,
     -+					    },
     -+					    {
     -+						    .refname = "b",
     -+						    .update_index = 1,
     -+						    .value = hash1,
     -+					    },
     -+					    {
     -+						    .refname = "c",
     -+						    .update_index = 1,
     -+						    .value = hash1,
     -+					    } };
     ++	struct reftable_ref_record r1[] = {
     ++		{
     ++			.refname = "a",
     ++			.update_index = 1,
     ++			.value_type = REFTABLE_REF_VAL1,
     ++			.value.val1 = hash1,
     ++		},
     ++		{
     ++			.refname = "b",
     ++			.update_index = 1,
     ++			.value_type = REFTABLE_REF_VAL1,
     ++			.value.val1 = hash1,
     ++		},
     ++		{
     ++			.refname = "c",
     ++			.update_index = 1,
     ++			.value_type = REFTABLE_REF_VAL1,
     ++			.value.val1 = hash1,
     ++		}
     ++	};
      +	struct reftable_ref_record r2[] = { {
      +		.refname = "a",
      +		.update_index = 2,
     ++		.value_type = REFTABLE_REF_DELETION,
      +	} };
      +	struct reftable_ref_record r3[] = {
      +		{
      +			.refname = "c",
      +			.update_index = 3,
     -+			.value = hash2,
     ++			.value_type = REFTABLE_REF_VAL1,
     ++			.value.val1 = hash2,
      +		},
      +		{
      +			.refname = "d",
      +			.update_index = 3,
     -+			.value = hash1,
     ++			.value_type = REFTABLE_REF_VAL1,
     ++			.value.val1 = hash1,
      +		},
      +	};
      +
     @@ reftable/merged_test.c (new)
      +
      +int merged_test_main(int argc, const char *argv[])
      +{
     -+	test_merged_between();
     -+	test_pq();
     -+	test_merged();
     -+	test_default_write_opts();
     ++	RUN_TEST(test_merged_between);
     ++	RUN_TEST(test_pq);
     ++	RUN_TEST(test_merged);
     ++	RUN_TEST(test_default_write_opts);
      +	return 0;
      +}
      
     @@ reftable/refname_test.c (new)
      +		reftable_new_writer(&strbuf_add_void, &buf, &opts);
      +	struct reftable_ref_record rec = {
      +		.refname = "a/b",
     -+		.target = "destination", /* make sure it's not a symref. */
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = "destination", /* make sure it's not a symref.
     ++						*/
      +		.update_index = 1,
      +	};
      +	int err;
     @@ reftable/refname_test.c (new)
      +
      +int refname_test_main(int argc, const char *argv[])
      +{
     -+	test_conflict();
     ++	RUN_TEST(test_conflict);
      +	return 0;
      +}
      
     @@ reftable/reftable-generic.h (new)
      +#include "reftable-merged.h"
      +
      +/*
     -+ Provides a unified API for reading tables, either merged tables, or single
     -+ readers.
     -+*/
     ++ * Provides a unified API for reading tables, either merged tables, or single
     ++ * readers. */
      +struct reftable_table {
      +	struct reftable_table_vtable *ops;
      +	void *table_arg;
     @@ reftable/reftable-merged.h (new)
      +#include "reftable-iterator.h"
      +
      +/*
     -+ Merged tables
     -+
     -+ A ref database kept in a sequence of table files. The merged_table presents a
     -+ unified view to reading (seeking, iterating) a sequence of immutable tables.
     -+
     -+ The merged tables are on purpose kept disconnected from their actual storage
     -+ (eg. files on disk), because it is useful to merge tables aren't files. For
     -+ example, the per-workspace and global ref namespace can be implemented as a
     -+ merged table of two stacks of file-backed reftables.
     -+*/
     ++ * Merged tables
     ++ *
     ++ * A ref database kept in a sequence of table files. The merged_table presents a
     ++ * unified view to reading (seeking, iterating) a sequence of immutable tables.
     ++ *
     ++ * The merged tables are on purpose kept disconnected from their actual storage
     ++ * (eg. files on disk), because it is useful to merge tables aren't files. For
     ++ * example, the per-workspace and global ref namespace can be implemented as a
     ++ * merged table of two stacks of file-backed reftables.
     ++ */
      +
      +/* A merged table is implements seeking/iterating over a stack of tables. */
      +struct reftable_merged_table;
     @@ reftable/reftable-stack.h (new)
      +#include "reftable-writer.h"
      +
      +/*
     -+  The stack presents an interface to a mutable sequence of reftables.
     ++ * The stack presents an interface to a mutable sequence of reftables.
      +
     -+  A stack can be mutated by pushing a table to the top of the stack.
     ++ * A stack can be mutated by pushing a table to the top of the stack.
      +
     -+  The reftable_stack automatically compacts files on disk to ensure good
     -+  amortized performance.
     -+*/
     ++ * The reftable_stack automatically compacts files on disk to ensure good
     ++ * amortized performance.
     ++ *
     ++ * For windows and other platforms that cannot have open files as rename
     ++ * destinations, concurrent access from multiple processes needs the rand()
     ++ * random seed to be randomized.
     ++ */
      +struct reftable_stack;
      +
      +/* open a new reftable stack. The tables along with the table list will be
     -+   stored in 'dir'. Typically, this should be .git/reftables.
     -+*/
     ++ *  stored in 'dir'. Typically, this should be .git/reftables.
     ++ */
      +int reftable_new_stack(struct reftable_stack **dest, const char *dir,
      +		       struct reftable_write_options config);
      +
     @@ reftable/reftable-stack.h (new)
      +struct reftable_addition;
      +
      +/*
     -+  returns a new transaction to add reftables to the given stack. As a side
     -+  effect, the ref database is locked.
     -+*/
     ++ * returns a new transaction to add reftables to the given stack. As a side
     ++ * effect, the ref database is locked.
     ++ */
      +int reftable_stack_new_addition(struct reftable_addition **dest,
      +				struct reftable_stack *st);
      +
     @@ reftable/reftable-stack.h (new)
      +int reftable_addition_commit(struct reftable_addition *add);
      +
      +/* Release all non-committed data from the transaction, and deallocate the
     -+   transaction. Releases the lock if held. */
     ++ * transaction. Releases the lock if held. */
      +void reftable_addition_destroy(struct reftable_addition *add);
      +
      +/* add a new table to the stack. The write_table function must call
     -+   reftable_writer_set_limits, add refs and return an error value. */
     ++ * reftable_writer_set_limits, add refs and return an error value. */
      +int reftable_stack_add(struct reftable_stack *st,
      +		       int (*write_table)(struct reftable_writer *wr,
      +					  void *write_arg),
      +		       void *write_arg);
      +
      +/* returns the merged_table for seeking. This table is valid until the
     -+   next write or reload, and should not be closed or deleted.
     -+*/
     ++ * next write or reload, and should not be closed or deleted.
     ++ */
      +struct reftable_merged_table *
      +reftable_stack_merged_table(struct reftable_stack *st);
      +
     @@ reftable/reftable-stack.h (new)
      +/* heuristically compact unbalanced table stack. */
      +int reftable_stack_auto_compact(struct reftable_stack *st);
      +
     -+/* convenience function to read a single ref. Returns < 0 for error, 0
     -+   for success, and 1 if ref not found. */
     ++/* convenience function to read a single ref. Returns < 0 for error, 0 for
     ++ * success, and 1 if ref not found. */
      +int reftable_stack_read_ref(struct reftable_stack *st, const char *refname,
      +			    struct reftable_ref_record *ref);
      +
     -+/* convenience function to read a single log. Returns < 0 for error, 0
     -+   for success, and 1 if ref not found. */
     ++/* convenience function to read a single log. Returns < 0 for error, 0 for
     ++ * success, and 1 if ref not found. */
      +int reftable_stack_read_log(struct reftable_stack *st, const char *refname,
      +			    struct reftable_log_record *log);
      +
     @@ reftable/stack.c (new)
      +static void format_name(struct strbuf *dest, uint64_t min, uint64_t max)
      +{
      +	char buf[100];
     -+	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64, min, max);
     ++	uint32_t rnd = (uint32_t)rand();
     ++	snprintf(buf, sizeof(buf), "0x%012" PRIx64 "-0x%012" PRIx64 "-%08x",
     ++		 min, max, rnd);
      +	strbuf_reset(dest);
      +	strbuf_addstr(dest, buf);
      +}
     @@ reftable/stack.c (new)
      +	int lock_file_fd;
      +	struct strbuf lock_file_name;
      +	struct reftable_stack *stack;
     -+	char **names;
     ++
      +	char **new_tables;
      +	int new_tables_len;
      +	uint64_t next_update_index;
     @@ reftable/stack.c (new)
      +	struct strbuf nm = STRBUF_INIT;
      +	for (i = 0; i < add->new_tables_len; i++) {
      +		strbuf_reset(&nm);
     -+		strbuf_addstr(&nm, add->stack->list_file);
     ++		strbuf_addstr(&nm, add->stack->reftable_dir);
      +		strbuf_addstr(&nm, "/");
      +		strbuf_addstr(&nm, add->new_tables[i]);
      +		unlink(nm.buf);
     @@ reftable/stack.c (new)
      +		strbuf_release(&add->lock_file_name);
      +	}
      +
     -+	free_names(add->names);
     -+	add->names = NULL;
      +	strbuf_release(&nm);
      +}
      +
     @@ reftable/stack.c (new)
      +		goto done;
      +	}
      +
     -+	err = reftable_stack_reload(add->stack);
     ++	/* success, no more state to clean up. */
     ++	strbuf_release(&add->lock_file_name);
     ++	for (i = 0; i < add->new_tables_len; i++) {
     ++		reftable_free(add->new_tables[i]);
     ++	}
     ++	reftable_free(add->new_tables);
     ++	add->new_tables = NULL;
     ++	add->new_tables_len = 0;
      +
     ++	err = reftable_stack_reload(add->stack);
      +done:
      +	reftable_addition_close(add);
      +	return err;
     @@ reftable/stack.c (new)
      +	strbuf_addstr(&tab_file_name, "/");
      +	strbuf_addbuf(&tab_file_name, &next_name);
      +
     -+	/* TODO: should check destination out of paranoia */
     ++	/*
     ++	  On windows, this relies on rand() picking a unique destination name.
     ++	  Maybe we should do retry loop as well?
     ++	 */
      +	err = rename(temp_tab_file_name.buf, tab_file_name.buf);
      +	if (err < 0) {
      +		err = REFTABLE_IO_ERROR;
     @@ reftable/stack.c (new)
      +
      +	format_name(&next_name,
      +		    reftable_reader_min_update_index(st->readers[first]),
     -+		    reftable_reader_max_update_index(st->readers[first]));
     ++		    reftable_reader_max_update_index(st->readers[last]));
      +
      +	strbuf_reset(temp_tab);
      +	strbuf_addstr(temp_tab, st->reftable_dir);
     @@ reftable/stack.c (new)
      +		if (err < 0) {
      +			break;
      +		}
     ++
      +		if (first == 0 && reftable_ref_record_is_deletion(&ref)) {
      +			continue;
      +		}
     @@ reftable/stack.c (new)
      +	strbuf_addbuf(&new_table_path, &new_table_name);
      +
      +	if (!is_empty_table) {
     ++		/* retry? */
      +		err = rename(temp_tab_file_name.buf, new_table_path.buf);
      +		if (err < 0) {
      +			err = REFTABLE_IO_ERROR;
     @@ reftable/stack_test.c (new)
      +	strbuf_release(&path);
      +}
      +
     ++static char *get_tmp_template(const char *prefix)
     ++{
     ++	const char *tmp = getenv("TMPDIR");
     ++	static char template[1024];
     ++	snprintf(template, sizeof(template) - 1, "%s/%s.XXXXXX",
     ++		 tmp ? tmp : "/tmp", prefix);
     ++	return template;
     ++}
     ++
      +static void test_read_file(void)
      +{
     -+	char fn[256] = "/tmp/stack.test_read_file.XXXXXX";
     ++	char *fn = get_tmp_template(__FUNCTION__);
      +	int fd = mkstemp(fn);
      +	char out[1024] = "line1\n\nline2\nline3";
      +	int n, err;
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_add_one(void)
      +{
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
      +	struct reftable_ref_record ref = {
      +		.refname = "HEAD",
      +		.update_index = 1,
     -+		.target = "master",
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = "master",
      +	};
      +	struct reftable_ref_record dest = { NULL };
      +
     @@ reftable/stack_test.c (new)
      +
      +	err = reftable_stack_read_ref(st, ref.refname, &dest);
      +	EXPECT_ERR(err);
     -+	EXPECT(0 == strcmp("master", dest.target));
     ++	EXPECT(0 == strcmp("master", dest.value.symref));
      +
      +	reftable_ref_record_release(&dest);
      +	reftable_stack_destroy(st);
     @@ reftable/stack_test.c (new)
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st1 = NULL;
      +	struct reftable_stack *st2 = NULL;
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	int err;
      +	struct reftable_ref_record ref1 = {
      +		.refname = "HEAD",
      +		.update_index = 1,
     -+		.target = "master",
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = "master",
      +	};
      +	struct reftable_ref_record ref2 = {
      +		.refname = "branch2",
      +		.update_index = 2,
     -+		.target = "master",
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = "master",
      +	};
      +
      +	EXPECT(mkdtemp(dir));
      +
     ++	/* simulate multi-process access to the same stack
     ++	   by creating two stacks for the same directory.
     ++	 */
      +	err = reftable_new_stack(&st1, dir, cfg);
      +	EXPECT_ERR(err);
      +
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_transaction_api(void)
      +{
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     @@ reftable/stack_test.c (new)
      +	struct reftable_ref_record ref = {
      +		.refname = "HEAD",
      +		.update_index = 1,
     -+		.target = "master",
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = "master",
      +	};
      +	struct reftable_ref_record dest = { NULL };
      +
     @@ reftable/stack_test.c (new)
      +
      +	err = reftable_stack_read_ref(st, ref.refname, &dest);
      +	EXPECT_ERR(err);
     -+	EXPECT(0 == strcmp("master", dest.target));
     ++	EXPECT(REFTABLE_REF_SYMREF == dest.value_type);
     ++	EXPECT(0 == strcmp("master", dest.value.symref));
      +
      +	reftable_ref_record_release(&dest);
      +	reftable_stack_destroy(st);
     @@ reftable/stack_test.c (new)
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	int i;
      +	struct reftable_ref_record ref = {
      +		.refname = "a/b",
      +		.update_index = 1,
     -+		.target = "master",
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = "master",
      +	};
      +	char *additions[] = { "a", "a/b/c" };
      +
     @@ reftable/stack_test.c (new)
      +		struct reftable_ref_record ref = {
      +			.refname = additions[i],
      +			.update_index = 1,
     -+			.target = "master",
     ++			.value_type = REFTABLE_REF_SYMREF,
     ++			.value.symref = "master",
      +		};
      +
      +		err = reftable_stack_add(st, &write_test_ref, &ref);
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_update_index_check(void)
      +{
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
      +	struct reftable_ref_record ref1 = {
      +		.refname = "name1",
      +		.update_index = 1,
     -+		.target = "master",
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = "master",
      +	};
      +	struct reftable_ref_record ref2 = {
      +		.refname = "name2",
      +		.update_index = 1,
     -+		.target = "master",
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = "master",
      +	};
      +	EXPECT(mkdtemp(dir));
      +
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_lock_failure(void)
      +{
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err, i;
     @@ reftable/stack_test.c (new)
      +		.exact_log_message = 1,
      +	};
      +	struct reftable_stack *st = NULL;
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	struct reftable_ref_record refs[2] = { { NULL } };
      +	struct reftable_log_record logs[2] = { { NULL } };
      +	int N = ARRAY_SIZE(refs);
     @@ reftable/stack_test.c (new)
      +		char buf[256];
      +		snprintf(buf, sizeof(buf), "branch%02d", i);
      +		refs[i].refname = xstrdup(buf);
     -+		refs[i].value = reftable_malloc(SHA1_SIZE);
      +		refs[i].update_index = i + 1;
     -+		set_test_hash(refs[i].value, i);
     ++		refs[i].value_type = REFTABLE_REF_VAL1;
     ++		refs[i].value.val1 = reftable_malloc(SHA1_SIZE);
     ++		set_test_hash(refs[i].value.val1, i);
      +
      +		logs[i].refname = xstrdup(buf);
      +		logs[i].update_index = N + i + 1;
     @@ reftable/stack_test.c (new)
      +		0,
      +	};
      +	struct reftable_stack *st = NULL;
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +
      +	uint8_t h1[SHA1_SIZE] = { 0x01 }, h2[SHA1_SIZE] = { 0x02 };
      +
     @@ reftable/stack_test.c (new)
      +static void test_reftable_stack_tombstone(void)
      +{
      +	int i = 0;
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     @@ reftable/stack_test.c (new)
      +		refs[i].refname = xstrdup(buf);
      +		refs[i].update_index = i + 1;
      +		if (i % 2 == 0) {
     -+			refs[i].value = reftable_malloc(SHA1_SIZE);
     -+			set_test_hash(refs[i].value, i);
     ++			refs[i].value_type = REFTABLE_REF_VAL1;
     ++			refs[i].value.val1 = reftable_malloc(SHA1_SIZE);
     ++			set_test_hash(refs[i].value.val1, i);
      +		}
      +		logs[i].refname = xstrdup(buf);
      +		/* update_index is part of the key. */
     @@ reftable/stack_test.c (new)
      +
      +static void test_reftable_stack_hash_id(void)
      +{
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
      +
      +	struct reftable_ref_record ref = {
      +		.refname = "master",
     -+		.target = "target",
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = "target",
      +		.update_index = 1,
      +	};
      +	struct reftable_write_options cfg32 = { .hash_id = SHA256_ID };
     @@ reftable/stack_test.c (new)
      +	err = reftable_stack_read_ref(st_default, "master", &dest);
      +	EXPECT_ERR(err);
      +
     -+	EXPECT(!strcmp(dest.target, ref.target));
     ++	EXPECT(reftable_ref_record_equal(&ref, &dest, SHA1_SIZE));
      +	reftable_ref_record_release(&dest);
      +	reftable_stack_destroy(st);
      +	reftable_stack_destroy(st_default);
     @@ reftable/stack_test.c (new)
      +
      +static void test_sizes_to_segments_empty(void)
      +{
     -+	uint64_t sizes[0];
     -+
      +	int seglen = 0;
     -+	struct segment *segs =
     -+		sizes_to_segments(&seglen, sizes, ARRAY_SIZE(sizes));
     ++	struct segment *segs = sizes_to_segments(&seglen, NULL, 0);
      +	EXPECT(seglen == 0);
      +	reftable_free(segs);
      +}
     @@ reftable/stack_test.c (new)
      +
      +static void test_reflog_expire(void)
      +{
     -+	char dir[256] = "/tmp/stack.test_reflog_expire.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	struct reftable_log_record logs[20] = { { NULL } };
     @@ reftable/stack_test.c (new)
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
      +	int err;
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	struct reftable_stack *st2 = NULL;
      +
      +	EXPECT(mkdtemp(dir));
     @@ reftable/stack_test.c (new)
      +{
      +	struct reftable_write_options cfg = { 0 };
      +	struct reftable_stack *st = NULL;
     -+	char dir[256] = "/tmp/stack_test.XXXXXX";
     ++	char *dir = get_tmp_template(__FUNCTION__);
      +	int err, i;
      +	int N = 100;
      +	EXPECT(mkdtemp(dir));
     @@ reftable/stack_test.c (new)
      +		struct reftable_ref_record ref = {
      +			.refname = name,
      +			.update_index = reftable_stack_next_update_index(st),
     -+			.target = "master",
     ++			.value_type = REFTABLE_REF_SYMREF,
     ++			.value.symref = "master",
      +		};
      +		snprintf(name, sizeof(name), "branch%04d", i);
      +
     @@ reftable/stack_test.c (new)
      +
      +int stack_test_main(int argc, const char *argv[])
      +{
     -+	test_reftable_stack_uptodate();
     -+	test_reftable_stack_transaction_api();
     -+	test_reftable_stack_hash_id();
     -+	test_sizes_to_segments_all_equal();
     -+	test_reftable_stack_auto_compaction();
     -+	test_reftable_stack_validate_refname();
     -+	test_reftable_stack_update_index_check();
     -+	test_reftable_stack_lock_failure();
     -+	test_reftable_stack_log_normalize();
     -+	test_reftable_stack_tombstone();
     -+	test_reftable_stack_add_one();
     -+	test_empty_add();
     -+	test_reflog_expire();
     -+	test_suggest_compaction_segment();
     -+	test_suggest_compaction_segment_nothing();
     -+	test_sizes_to_segments();
     -+	test_sizes_to_segments_empty();
     -+	test_log2();
     -+	test_parse_names();
     -+	test_read_file();
     -+	test_names_equal();
     -+	test_reftable_stack_add();
     ++	RUN_TEST(test_reftable_stack_uptodate);
     ++	RUN_TEST(test_reftable_stack_transaction_api);
     ++	RUN_TEST(test_reftable_stack_hash_id);
     ++	RUN_TEST(test_sizes_to_segments_all_equal);
     ++	RUN_TEST(test_reftable_stack_auto_compaction);
     ++	RUN_TEST(test_reftable_stack_validate_refname);
     ++	RUN_TEST(test_reftable_stack_update_index_check);
     ++	RUN_TEST(test_reftable_stack_lock_failure);
     ++	RUN_TEST(test_reftable_stack_log_normalize);
     ++	RUN_TEST(test_reftable_stack_tombstone);
     ++	RUN_TEST(test_reftable_stack_add_one);
     ++	RUN_TEST(test_empty_add);
     ++	RUN_TEST(test_reflog_expire);
     ++	RUN_TEST(test_suggest_compaction_segment);
     ++	RUN_TEST(test_suggest_compaction_segment_nothing);
     ++	RUN_TEST(test_sizes_to_segments);
     ++	RUN_TEST(test_sizes_to_segments_empty);
     ++	RUN_TEST(test_log2);
     ++	RUN_TEST(test_parse_names);
     ++	RUN_TEST(test_read_file);
     ++	RUN_TEST(test_names_equal);
     ++	RUN_TEST(test_reftable_stack_add);
      +	return 0;
      +}
      
 14:  a590865a700 ! 13:  d57023d9f13 Reftable support for git-core
     @@ Commit message
          Helped-by: Johannes Schindelin <johannes.schindelin@gmx.de>
          Co-authored-by: Jeff King <peff@peff.net>
      
     + ## Documentation/config/extensions.txt ##
     +@@ Documentation/config/extensions.txt: extensions.objectFormat::
     + Note that this setting should only be set by linkgit:git-init[1] or
     + linkgit:git-clone[1].  Trying to change it after initialization will not
     + work and will produce hard-to-diagnose issues.
     +++
     ++extensions.refStorage::
     ++	Specify the ref storage mechanism to use.  The acceptable values are `files` and
     ++	`reftable`.  If not specified, `files` is assumed.  It is an error to specify
     ++	this key unless `core.repositoryFormatVersion` is 1.
     +++
     ++Note that this setting should only be set by linkgit:git-init[1] or
     ++linkgit:git-clone[1].  Trying to change it after initialization will not
     ++work and will produce hard-to-diagnose issues.
     +
       ## Documentation/technical/repository-version.txt ##
      @@ Documentation/technical/repository-version.txt: If set, by default "git config" reads from both "config" and
       multiple working directory mode, "config" file is shared while
     @@ refs/reftable-backend.c (new)
      +			continue;
      +
      +		ri->base.flags = 0;
     -+		if (ri->ref.value != NULL) {
     -+			hashcpy(ri->oid.hash, ri->ref.value);
     -+		} else if (ri->ref.target != NULL) {
     ++		switch (ri->ref.value_type) {
     ++		case REFTABLE_REF_VAL1:
     ++			hashcpy(ri->oid.hash, ri->ref.value.val1);
     ++			break;
     ++		case REFTABLE_REF_VAL2:
     ++			hashcpy(ri->oid.hash, ri->ref.value.val2.value);
     ++			break;
     ++		case REFTABLE_REF_SYMREF: {
      +			int out_flags = 0;
      +			const char *resolved = refs_resolve_ref_unsafe(
      +				ri->ref_store, ri->ref.refname,
     @@ refs/reftable-backend.c (new)
      +			    (ri->base.flags & REF_ISBROKEN)) {
      +				continue;
      +			}
     ++			break;
     ++		}
     ++		default:
     ++			abort();
      +		}
      +
      +		ri->base.oid = &ri->oid;
     @@ refs/reftable-backend.c (new)
      +{
      +	struct git_reftable_iterator *ri =
      +		(struct git_reftable_iterator *)ref_iterator;
     -+	if (ri->ref.target_value != NULL) {
     -+		hashcpy(peeled->hash, ri->ref.target_value);
     ++	if (ri->ref.value_type == REFTABLE_REF_VAL2) {
     ++		hashcpy(peeled->hash, ri->ref.value.val2.target_value);
      +		return 0;
      +	}
      +
     @@ refs/reftable-backend.c (new)
      +
      +			int peel_error = peel_object(&u->new_oid, &peeled);
      +			ref.refname = (char *)u->refname;
     -+
     -+			if (!is_null_oid(&u->new_oid)) {
     -+				ref.value = u->new_oid.hash;
     -+			}
      +			ref.update_index = ts;
     ++
      +			if (!peel_error) {
     -+				ref.target_value = peeled.hash;
     ++				ref.value_type = REFTABLE_REF_VAL2;
     ++				ref.value.val2.target_value = peeled.hash;
     ++				ref.value.val2.value = u->new_oid.hash;
     ++			} else if (!is_null_oid(&u->new_oid)) {
     ++				ref.value_type = REFTABLE_REF_VAL1;
     ++				ref.value.val1 = u->new_oid.hash;
      +			}
      +
      +			err = reftable_writer_add_ref(writer, &ref);
     @@ refs/reftable-backend.c (new)
      +	for (i = 0; i < arg->refnames->nr; i++) {
      +		struct reftable_ref_record ref = {
      +			.refname = (char *)arg->refnames->items[i].string,
     ++			.value_type = REFTABLE_REF_DELETION,
      +			.update_index = ts,
      +		};
      +		err = reftable_writer_add_ref(writer, &ref);
     @@ refs/reftable-backend.c (new)
      +
      +		if (reftable_stack_read_ref(arg->stack, log.refname,
      +					    &current) == 0) {
     -+			log.old_hash = current.value;
     ++			log.old_hash = reftable_ref_record_val1(&current);
      +		}
      +		err = reftable_writer_add_log(writer, &log);
      +		log.old_hash = NULL;
     @@ refs/reftable-backend.c (new)
      +
      +	struct reftable_ref_record ref = {
      +		.refname = (char *)create->refname,
     -+		.target = (char *)create->target,
     ++		.value_type = REFTABLE_REF_SYMREF,
     ++		.value.symref = (char *)create->target,
      +		.update_index = ts,
      +	};
      +	reftable_writer_set_limits(writer, ts, ts);
     @@ refs/reftable-backend.c (new)
      +		goto done;
      +	}
      +
     -+	free(ref.refname);
     -+	ref.refname = strdup(arg->newname);
      +	reftable_writer_set_limits(writer, ts, ts);
     -+	ref.update_index = ts;
      +
      +	{
     -+		struct reftable_ref_record todo[2] = { { NULL } };
     -+		todo[0].refname = (char *)arg->oldname;
     -+		todo[0].update_index = ts;
     -+		/* leave todo[0] empty */
     -+		todo[1] = ref;
     ++		struct reftable_ref_record todo[2] = {
     ++			{
     ++				.refname = (char *)arg->oldname,
     ++				.update_index = ts,
     ++				.value_type = REFTABLE_REF_DELETION,
     ++			},
     ++			ref,
     ++		};
      +		todo[1].update_index = ts;
     ++		free(todo[1].refname);
     ++		todo[1].refname = strdup(arg->newname);
      +
      +		err = reftable_writer_add_refs(writer, todo, 2);
      +		if (err < 0) {
     @@ refs/reftable-backend.c (new)
      +		}
      +	}
      +
     -+	if (ref.value != NULL) {
     ++	if (reftable_ref_record_val1(&ref)) {
     ++		uint8_t *val1 = reftable_ref_record_val1(&ref);
      +		struct reftable_log_record todo[2] = { { NULL } };
      +		fill_reftable_log_record(&todo[0]);
      +		fill_reftable_log_record(&todo[1]);
     @@ refs/reftable-backend.c (new)
      +		todo[0].refname = (char *)arg->oldname;
      +		todo[0].update_index = ts;
      +		todo[0].message = (char *)arg->logmsg;
     -+		todo[0].old_hash = ref.value;
     ++		todo[0].old_hash = val1;
      +		todo[0].new_hash = NULL;
      +
      +		todo[1].refname = (char *)arg->newname;
      +		todo[1].update_index = ts;
      +		todo[1].old_hash = NULL;
     -+		todo[1].new_hash = ref.value;
     ++		todo[1].new_hash = val1;
      +		todo[1].message = (char *)arg->logmsg;
      +
      +		err = reftable_writer_add_logs(writer, todo, 2);
     @@ refs/reftable-backend.c (new)
      +		err = -1;
      +		goto done;
      +	}
     -+	if (ref.target != NULL) {
     ++
     ++	if (ref.value_type == REFTABLE_REF_SYMREF) {
      +		strbuf_reset(referent);
     -+		strbuf_addstr(referent, ref.target);
     ++		strbuf_addstr(referent, ref.value.symref);
      +		*type |= REF_ISSYMREF;
     -+	} else if (ref.value != NULL) {
     -+		hashcpy(oid->hash, ref.value);
     ++	} else if (reftable_ref_record_val1(&ref) != NULL) {
     ++		hashcpy(oid->hash, reftable_ref_record_val1(&ref));
      +	} else {
      +		*type |= REF_ISBROKEN;
      +		errno = EINVAL;
 15:  57626bfe2d4 = 14:  9df5bc69f97 git-prompt: prepare for reftable refs backend
 16:  6229da992e4 ! 15:  4076ef5d20b Add "test-tool dump-reftable" command.
     @@ reftable/dump.c: static int dump_table(const char *tablename)
       
       	reftable_reader_free(r);
       	return 0;
     -@@ reftable/dump.c: static int dump_stack(const char *stackdir)
     +@@ reftable/dump.c: static int dump_table(const char *tablename)
     + static int compact_stack(const char *stackdir)
       {
       	struct reftable_stack *stack = NULL;
     - 	struct reftable_write_options cfg = {};
     +-	struct reftable_write_options cfg = {};
     ++	struct reftable_write_options cfg = { 0 };
     + 
     + 	int err = reftable_new_stack(&stack, stackdir, cfg);
     + 	if (err < 0)
     +@@ reftable/dump.c: static int compact_stack(const char *stackdir)
     + static int dump_stack(const char *stackdir)
     + {
     + 	struct reftable_stack *stack = NULL;
     +-	struct reftable_write_options cfg = {};
      -	struct reftable_iterator it = { 0 };
      -	struct reftable_ref_record ref = { 0 };
      -	struct reftable_log_record log = { 0 };
     ++	struct reftable_write_options cfg = { 0 };
      +	struct reftable_iterator it = { NULL };
      +	struct reftable_ref_record ref = { NULL };
      +	struct reftable_log_record log = { NULL };
     @@ reftable/dump.c: static int dump_stack(const char *stackdir)
       
       	reftable_stack_destroy(stack);
       	return 0;
     +@@ reftable/dump.c: static void print_help(void)
     + int reftable_dump_main(int argc, char *const *argv)
     + {
     + 	int err = 0;
     +-	int opt;
     + 	int opt_dump_table = 0;
     + 	int opt_dump_stack = 0;
     + 	int opt_compact = 0;
     +-	const char *arg = NULL;
     +-	while ((opt = getopt(argc, argv, "2chts")) != -1) {
     +-		switch (opt) {
     +-		case '2':
     +-			hash_id = 0x73323536;
     ++	const char *arg = NULL, *argv0 = argv[0];
     ++
     ++	for (; argc > 1; argv++, argc--)
     ++		if (*argv[1] != '-')
     + 			break;
     +-		case 't':
     ++		else if (!strcmp("-2", argv[1]))
     ++			hash_id = 0x73323536;
     ++		else if (!strcmp("-t", argv[1]))
     + 			opt_dump_table = 1;
     +-			break;
     +-		case 's':
     ++		else if (!strcmp("-s", argv[1]))
     + 			opt_dump_stack = 1;
     +-			break;
     +-		case 'c':
     ++		else if (!strcmp("-c", argv[1]))
     + 			opt_compact = 1;
     +-			break;
     +-		case '?':
     +-		case 'h':
     ++		else if (!strcmp("-?", argv[1]) || !strcmp("-h", argv[1])) {
     + 			print_help();
     + 			return 2;
     +-			break;
     + 		}
     +-	}
     + 
     +-	if (argv[optind] == NULL) {
     ++	if (argc != 2) {
     + 		fprintf(stderr, "need argument\n");
     + 		print_help();
     + 		return 2;
     + 	}
     + 
     +-	arg = argv[optind];
     ++	arg = argv[1];
     + 
     + 	if (opt_dump_table) {
     + 		err = dump_table(arg);
     +@@ reftable/dump.c: int reftable_dump_main(int argc, char *const *argv)
     + 	}
     + 
     + 	if (err < 0) {
     +-		fprintf(stderr, "%s: %s: %s\n", argv[0], arg,
     ++		fprintf(stderr, "%s: %s: %s\n", argv0, arg,
     + 			reftable_error_str(err));
     + 		return 1;
     + 	}
      
       ## t/helper/test-reftable.c ##
      @@ t/helper/test-reftable.c: int cmd__reftable(int argc, const char **argv)

-- 
gitgitgadget
