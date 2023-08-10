Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76034C04E69
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 16:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234754AbjHJQeR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 12:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234851AbjHJQeQ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 12:34:16 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7A3103
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:34:14 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id d9443c01a7336-1bb8caf7312so14133265ad.0
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 09:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691685254; x=1692290054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=rtwv+y490sYewDGCD1ZJMK6W+zd0fwnTJS9w5NfE17U=;
        b=lZHsizSMZQUtvGbmQ9536qfKbYflCy2p/heHAPsr0iww14lHM5Bt4VC4lNfBHFmPU9
         PCDdDhzRzIZlqlVgk5yEGR1aITJNM+wxejwJPpZ01IdvcDk1TOGk9YPPG+mbENTXXvy1
         +XHXlWzCjW/mEKQoWG9i/j5AiZyFaXjrbsd/zPgabvvJqNw3gFEVJiQFPty6tt8o/LDX
         4Orzk8M3aq/RnYRBf7TkoDCJuwIcNt0pRBJNSQLAm7pUGBg2l//wSTkbHIiRqKCmlgAs
         0omOtJXXKNs2z9XRwkzHRIgn3znV9KCPXooDYBXHsGhc6uz7Glwa0bF+a+PPam0+iw/f
         C7MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691685254; x=1692290054;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rtwv+y490sYewDGCD1ZJMK6W+zd0fwnTJS9w5NfE17U=;
        b=hKK8u0mcd88Tt0z/f9C1h8KBmnWpSKnl1FW4G/zA1/m2iQV8cdCu1T8DemFtIah6pR
         AIruumZzBL3UE8dNMVD/XIJEs4QjowrJp1bCk6dZq9WREzj07A9R1M0UWIon52cpuJKb
         MUAy6Oxs8bZlIKq4KZgppQOKXRTG8Bx0sxXScRxMevaA5dUYEbo5BYRmPhvKdd4yQbrG
         MNO/cm5ESF2iS79iXeG+Q5g5nqE9V0TQceY3dUJLcXWszEb3vNiuaQavmxAm1oAvT4jB
         gl/hs/6ZvhtTi/6Mv6nHbx4ETLoCU5/D9lg1/wiZi/ZBsSba9IO3uz+RUc3ZJRyHelYC
         wrtw==
X-Gm-Message-State: AOJu0Yy4Ws1UBe3iwc0mSNcr9WPeCsr4gTnbDUCWUVnH5bIORA+7xTu2
        wU/UoXGhVRuPSgQ/5O+joCJfYXnX3LU1z9XsP1Vpv/uUIDE/fAY83EVzv3FQsaPPSZ0czK1SKrR
        /xjD0VWOJXl3RBBhZggyvZSvlylGNnXipODzUpZDodmztAl+536DXYPHN+GZUWhtD9w==
X-Google-Smtp-Source: AGHT+IF+K3ZdmlYPHnQIGsmlsLlp4YibluLXFHe96V3ut74r1JyJARVUDoLakdk2L362tggacVUUBPkClujdQ3k=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a17:902:e884:b0:1bb:f329:e1cf with SMTP
 id w4-20020a170902e88400b001bbf329e1cfmr946132plg.3.1691685253992; Thu, 10
 Aug 2023 09:34:13 -0700 (PDT)
Date:   Thu, 10 Aug 2023 16:33:45 +0000
In-Reply-To: <20230627195251.1973421-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230627195251.1973421-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.640.ga95def55d0-goog
Message-ID: <20230810163346.274132-1-calvinwan@google.com>
Subject: [RFC PATCH v2 0/7] Introduce Git Standard Library
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        chooglen@google.com, jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter:
https://lore.kernel.org/git/20230627195251.1973421-1-calvinwan@google.com/

In the initial RFC, I had a patch that removed the trace2 dependency
from usage.c so that git-std-lib.a would not have dependencies outside
of git-std-lib.a files. Consequently this meant that tracing would not
be possible in git-std-lib.a files for other developers of Git, and it
is not a good idea for the libification effort to close the door on
tracing in certain files for future development (thanks Victoria for
pointing this out). That patch has been removed and instead I introduce
stubbed out versions of repository.[ch] and trace2.[ch] that are swapped
in during compilation time (I'm no Makefile expert so any advice on how
on I could do this better would be much appreciated). These stubbed out
files contain no implementations and therefore do not have any
additional dependencies, allowing git-std-lib.a to compile with only the
stubs as additional dependencies. This also has the added benefit of
removing `#ifdef GIT_STD_LIB` macros in C files for specific library
compilation rules. Libification shouldn't pollute C files with these
macros. The boundaries for git-std-lib.a have also been updated to
contain these stubbed out files.

I have also made some additional changes to the Makefile to piggy back
off of our existing build rules for .c/.o targets and their
dependencies. As I learn more about Makefiles, I am continuing to look
for ways to improve these rules. Eventually I would like to be able to
have a set of rules that future libraries can emulate and is scalable
in the sense of not creating additional toil for developers that are not
interested in libification.

Calvin Wan (7):
  hex-ll: split out functionality from hex
  object: move function to object.c
  config: correct bad boolean env value error message
  parse: create new library for parsing strings and env values
  date: push pager.h dependency up
  git-std-lib: introduce git standard library
  git-std-lib: add test file to call git-std-lib.a functions

 Documentation/technical/git-std-lib.txt | 186 ++++++++++++++++++
 Makefile                                |  64 ++++++-
 attr.c                                  |   2 +-
 builtin/blame.c                         |   2 +-
 builtin/log.c                           |   2 +-
 color.c                                 |   2 +-
 config.c                                | 173 +----------------
 config.h                                |  14 +-
 date.c                                  |   5 +-
 date.h                                  |   2 +-
 git-compat-util.h                       |   7 +-
 hex-ll.c                                |  49 +++++
 hex-ll.h                                |  27 +++
 hex.c                                   |  47 -----
 hex.h                                   |  24 +--
 mailinfo.c                              |   2 +-
 object.c                                |   5 +
 object.h                                |   6 +
 pack-objects.c                          |   2 +-
 pack-revindex.c                         |   2 +-
 parse-options.c                         |   3 +-
 parse.c                                 | 182 ++++++++++++++++++
 parse.h                                 |  20 ++
 pathspec.c                              |   2 +-
 preload-index.c                         |   2 +-
 progress.c                              |   2 +-
 prompt.c                                |   2 +-
 rebase.c                                |   2 +-
 ref-filter.c                            |   3 +-
 revision.c                              |   3 +-
 strbuf.c                                |   2 +-
 stubs/repository.c                      |   4 +
 stubs/repository.h                      |   8 +
 stubs/trace2.c                          |  22 +++
 stubs/trace2.h                          |  69 +++++++
 symlinks.c                              |   2 +
 t/Makefile                              |   4 +
 t/helper/test-date.c                    |   3 +-
 t/helper/test-env-helper.c              |   2 +-
 t/stdlib-test.c                         | 239 ++++++++++++++++++++++++
 unpack-trees.c                          |   2 +-
 url.c                                   |   2 +-
 urlmatch.c                              |   2 +-
 wrapper.c                               |   8 +-
 wrapper.h                               |   5 -
 write-or-die.c                          |   2 +-
 46 files changed, 925 insertions(+), 295 deletions(-)
 create mode 100644 Documentation/technical/git-std-lib.txt
 create mode 100644 hex-ll.c
 create mode 100644 hex-ll.h
 create mode 100644 parse.c
 create mode 100644 parse.h
 create mode 100644 stubs/repository.c
 create mode 100644 stubs/repository.h
 create mode 100644 stubs/trace2.c
 create mode 100644 stubs/trace2.h
 create mode 100644 t/stdlib-test.c

Range-diff against v1:
1:  f7abe7a239 < -:  ---------- trace2: log fsync stats in trace2 rather than wrapper
2:  c302ae0052 = 1:  78634bc406 hex-ll: split out functionality from hex
3:  74e8e35ae2 ! 2:  21ec1d276e object: move function to object.c
    @@ wrapper.c
      #include "config.h"
      #include "gettext.h"
     -#include "object.h"
    + #include "repository.h"
      #include "strbuf.h"
    - 
    - static intmax_t count_fsync_writeout_only;
    + #include "trace2.h"
     @@ wrapper.c: int rmdir_or_warn(const char *file)
      	return warn_if_unremovable("rmdir", file, rmdir(file));
      }
4:  419c702633 = 3:  41dcf8107c config: correct bad boolean env value error message
5:  a325002438 ! 4:  3e800a41c4 parse: create new library for parsing strings and env values
    @@ wrapper.c
     -#include "config.h"
     +#include "parse.h"
      #include "gettext.h"
    + #include "repository.h"
      #include "strbuf.h"
    - 
     
      ## write-or-die.c ##
     @@
6:  475190310a < -:  ---------- pager: remove pager_in_use()
-:  ---------- > 5:  7a4a088bc3 date: push pager.h dependency up
7:  d7f4d4a137 ! 6:  c9002734d0 git-std-lib: introduce git standard library
    @@ Documentation/technical/git-std-lib.txt (new)
     +easily included in git-std-lib.a, which as a root dependency means that
     +higher level libraries do not have to worry about compatibility files in
     +compat/. The rest of the functions defined in git-compat-util.h are
    -+implemented in top level files and, in this patch set, are hidden behind
    ++implemented in top level files and are hidden behind
     +an #ifdef if their implementation is not in git-std-lib.a.
     +
     +Rationale summary
    @@ Documentation/technical/git-std-lib.txt (new)
     + - low-level git/* files with functions defined in git-compat-util.h
     +   (ctype.c)
     + - compat/*
    ++ - stubbed out dependencies in stubs/ (stubs/repository.c, stubs/trace2.c)
     +
     +There are other files that might fit this definition, but that does not
     +mean it should belong in git-std-lib.a. Those files should start as
     +their own separate library since any file added to git-std-lib.a loses
     +its flexibility of being easily swappable.
     +
    ++Wrapper.c and usage.c have dependencies on repository and trace2 that are
    ++possible to remove at the cost of sacrificing the ability for standard Git
    ++to be able to trace functions in those files and other files in git-std-lib.a.
    ++In order for git-std-lib.a to compile with those dependencies, stubbed out
    ++versions of those files are implemented and swapped in during compilation time.
    ++
     +Files inside of Git Standard Library
     +================
     +
    @@ Documentation/technical/git-std-lib.txt (new)
     +usage.c
     +utf8.c
     +wrapper.c
    ++stubs/repository.c
    ++stubs/trace2.c
     +relevant compat/ files
     +
     +Pitfalls
     +================
     +
    -+In patch 7, I use #ifdef GIT_STD_LIB to both stub out code and hide
    -+certain function headers. As other parts of Git are libified, if we
    -+have to use more ifdefs for each different library, then the codebase
    -+will become uglier and harder to understand. 
    -+
     +There are a small amount of files under compat/* that have dependencies
     +not inside of git-std-lib.a. While those functions are not called on
     +Linux, other OSes might call those problematic functions. I don't see
    @@ Documentation/technical/git-std-lib.txt (new)
      \ No newline at end of file
     
      ## Makefile ##
    +@@ Makefile: FUZZ_PROGRAMS =
    + GIT_OBJS =
    + LIB_OBJS =
    + SCALAR_OBJS =
    ++STUB_OBJS =
    + OBJECTS =
    + OTHER_PROGRAMS =
    + PROGRAM_OBJS =
    +@@ Makefile: COCCI_SOURCES = $(filter-out $(THIRD_PARTY_SOURCES),$(FOUND_C_SOURCES))
    + 
    + LIB_H = $(FOUND_H_SOURCES)
    + 
    ++ifndef GIT_STD_LIB
    + LIB_OBJS += abspath.o
    + LIB_OBJS += add-interactive.o
    + LIB_OBJS += add-patch.o
    +@@ Makefile: LIB_OBJS += write-or-die.o
    + LIB_OBJS += ws.o
    + LIB_OBJS += wt-status.o
    + LIB_OBJS += xdiff-interface.o
    ++else ifdef GIT_STD_LIB
    ++LIB_OBJS += abspath.o
    ++LIB_OBJS += ctype.o
    ++LIB_OBJS += date.o
    ++LIB_OBJS += hex-ll.o
    ++LIB_OBJS += parse.o
    ++LIB_OBJS += strbuf.o
    ++LIB_OBJS += usage.o
    ++LIB_OBJS += utf8.o
    ++LIB_OBJS += wrapper.o
    ++
    ++ifdef STUB_REPOSITORY
    ++STUB_OBJS += stubs/repository.o
    ++endif
    ++
    ++ifdef STUB_TRACE2
    ++STUB_OBJS += stubs/trace2.o
    ++endif
    ++
    ++LIB_OBJS += $(STUB_OBJS)
    ++endif
    + 
    + BUILTIN_OBJS += builtin/add.o
    + BUILTIN_OBJS += builtin/am.o
     @@ Makefile: ifdef FSMONITOR_OS_SETTINGS
      	COMPAT_OBJS += compat/fsmonitor/fsm-path-utils-$(FSMONITOR_OS_SETTINGS).o
      endif
    @@ Makefile: $(FUZZ_PROGRAMS): all
     +### Libified Git rules
     +
     +# git-std-lib
    -+# `make git-std-lib GIT_STD_LIB=YesPlease`
    ++# `make git-std-lib GIT_STD_LIB=YesPlease STUB_REPOSITORY=YesPlease STUB_TRACE2=YesPlease`
     +STD_LIB = git-std-lib.a
     +
    -+GIT_STD_LIB_OBJS += abspath.o
    -+GIT_STD_LIB_OBJS += ctype.o
    -+GIT_STD_LIB_OBJS += date.o
    -+GIT_STD_LIB_OBJS += hex-ll.o
    -+GIT_STD_LIB_OBJS += parse.o
    -+GIT_STD_LIB_OBJS += strbuf.o
    -+GIT_STD_LIB_OBJS += usage.o
    -+GIT_STD_LIB_OBJS += utf8.o
    -+GIT_STD_LIB_OBJS += wrapper.o
    -+
    -+$(STD_LIB): $(GIT_STD_LIB_OBJS) $(COMPAT_OBJS)
    ++$(STD_LIB): $(LIB_OBJS) $(COMPAT_OBJS) $(STUB_OBJS)
     +	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
     +
    -+git-std-lib: $(STD_LIB)
    ++TEMP_HEADERS = temp_headers/
    ++
    ++git-std-lib:
    ++# Move headers to temporary folder and replace them with stubbed headers.
    ++# After building, move headers and stubbed headers back.
    ++ifneq ($(STUB_OBJS),)
    ++	mkdir -p $(TEMP_HEADERS); \
    ++	for d in $(STUB_OBJS); do \
    ++		BASE=$${d%.*}; \
    ++		mv $${BASE##*/}.h $(TEMP_HEADERS)$${BASE##*/}.h; \
    ++		mv $${BASE}.h $${BASE##*/}.h; \
    ++	done; \
    ++	$(MAKE) $(STD_LIB); \
    ++	for d in $(STUB_OBJS); do \
    ++		BASE=$${d%.*}; \
    ++		mv $${BASE##*/}.h $${BASE}.h; \
    ++		mv $(TEMP_HEADERS)$${BASE##*/}.h $${BASE##*/}.h; \
    ++	done; \
    ++	rm -rf temp_headers
    ++else
    ++	$(MAKE) $(STD_LIB)
    ++endif
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: static inline int noop_core_config(const char *var UNUSED,
    @@ git-compat-util.h: int git_access(const char *path, int mode);
      /*
       * You can mark a stack variable with UNLEAK(var) to avoid it being
     
    + ## stubs/repository.c (new) ##
    +@@
    ++#include "git-compat-util.h"
    ++#include "repository.h"
    ++
    ++struct repository *the_repository;
    +
    + ## stubs/repository.h (new) ##
    +@@
    ++#ifndef REPOSITORY_H
    ++#define REPOSITORY_H
    ++
    ++struct repository { int stub; };
    ++
    ++extern struct repository *the_repository;
    ++
    ++#endif /* REPOSITORY_H */
    +
    + ## stubs/trace2.c (new) ##
    +@@
    ++#include "git-compat-util.h"
    ++#include "trace2.h"
    ++
    ++void trace2_region_enter_fl(const char *file, int line, const char *category,
    ++			    const char *label, const struct repository *repo, ...) { }
    ++void trace2_region_leave_fl(const char *file, int line, const char *category,
    ++			    const char *label, const struct repository *repo, ...) { }
    ++void trace2_data_string_fl(const char *file, int line, const char *category,
    ++			   const struct repository *repo, const char *key,
    ++			   const char *value) { }
    ++void trace2_cmd_ancestry_fl(const char *file, int line, const char **parent_names) { }
    ++void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
    ++			    va_list ap) { }
    ++void trace2_cmd_name_fl(const char *file, int line, const char *name) { }
    ++void trace2_thread_start_fl(const char *file, int line,
    ++			    const char *thread_base_name) { }
    ++void trace2_thread_exit_fl(const char *file, int line) { }
    ++void trace2_data_intmax_fl(const char *file, int line, const char *category,
    ++			   const struct repository *repo, const char *key,
    ++			   intmax_t value) { }
    ++int trace2_is_enabled(void) { return 0; }
    ++void trace2_collect_process_info(enum trace2_process_info_reason reason) { }
    +
    + ## stubs/trace2.h (new) ##
    +@@
    ++#ifndef TRACE2_H
    ++#define TRACE2_H
    ++
    ++struct child_process { int stub; };
    ++struct repository;
    ++struct json_writer { int stub; };
    ++
    ++void trace2_region_enter_fl(const char *file, int line, const char *category,
    ++			    const char *label, const struct repository *repo, ...);
    ++
    ++#define trace2_region_enter(category, label, repo) \
    ++	trace2_region_enter_fl(__FILE__, __LINE__, (category), (label), (repo))
    ++
    ++void trace2_region_leave_fl(const char *file, int line, const char *category,
    ++			    const char *label, const struct repository *repo, ...);
    ++
    ++#define trace2_region_leave(category, label, repo) \
    ++	trace2_region_leave_fl(__FILE__, __LINE__, (category), (label), (repo))
    ++
    ++void trace2_data_string_fl(const char *file, int line, const char *category,
    ++			   const struct repository *repo, const char *key,
    ++			   const char *value);
    ++
    ++#define trace2_data_string(category, repo, key, value)                       \
    ++	trace2_data_string_fl(__FILE__, __LINE__, (category), (repo), (key), \
    ++			      (value))
    ++
    ++void trace2_cmd_ancestry_fl(const char *file, int line, const char **parent_names);
    ++
    ++#define trace2_cmd_ancestry(v) trace2_cmd_ancestry_fl(__FILE__, __LINE__, (v))
    ++
    ++void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
    ++			    va_list ap);
    ++
    ++#define trace2_cmd_error_va(fmt, ap) \
    ++	trace2_cmd_error_va_fl(__FILE__, __LINE__, (fmt), (ap))
    ++
    ++
    ++void trace2_cmd_name_fl(const char *file, int line, const char *name);
    ++
    ++#define trace2_cmd_name(v) trace2_cmd_name_fl(__FILE__, __LINE__, (v))
    ++
    ++void trace2_thread_start_fl(const char *file, int line,
    ++			    const char *thread_base_name);
    ++
    ++#define trace2_thread_start(thread_base_name) \
    ++	trace2_thread_start_fl(__FILE__, __LINE__, (thread_base_name))
    ++
    ++void trace2_thread_exit_fl(const char *file, int line);
    ++
    ++#define trace2_thread_exit() trace2_thread_exit_fl(__FILE__, __LINE__)
    ++
    ++void trace2_data_intmax_fl(const char *file, int line, const char *category,
    ++			   const struct repository *repo, const char *key,
    ++			   intmax_t value);
    ++
    ++#define trace2_data_intmax(category, repo, key, value)                       \
    ++	trace2_data_intmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
    ++			      (value))
    ++
    ++enum trace2_process_info_reason {
    ++	TRACE2_PROCESS_INFO_STARTUP,
    ++	TRACE2_PROCESS_INFO_EXIT,
    ++};
    ++int trace2_is_enabled(void);
    ++void trace2_collect_process_info(enum trace2_process_info_reason reason);
    ++
    ++#endif /* TRACE2_H */
    ++
    +
      ## symlinks.c ##
     @@ symlinks.c: void invalidate_lstat_cache(void)
      	reset_lstat_cache(&default_cache);
    @@ symlinks.c: int lstat_cache_aware_rmdir(const char *path)
      	return ret;
      }
     +#endif
    -
    - ## usage.c ##
    -@@
    -  */
    - #include "git-compat-util.h"
    - #include "gettext.h"
    -+
    -+#ifdef GIT_STD_LIB
    -+#undef trace2_cmd_name
    -+#undef trace2_cmd_error_va
    -+#define trace2_cmd_name(x) 
    -+#define trace2_cmd_error_va(x, y)
    -+#else
    - #include "trace2.h"
    -+#endif
    - 
    - static void vreportf(const char *prefix, const char *err, va_list params)
    - {
8:  cb96e67774 ! 7:  0bead8f980 git-std-lib: add test file to call git-std-lib.a functions
    @@ t/stdlib-test.c (new)
     +	strbuf_splice(sb, 0, 1, "foo", 3);
     +	strbuf_insert(sb, 0, "foo", 3);
     +	// strbuf_vinsertf() called by strbuf_insertf
    -+	strbuf_insertf(sb, 0, "%s", "foo"); 
    ++	strbuf_insertf(sb, 0, "%s", "foo");
     +	strbuf_remove(sb, 0, 1);
     +	strbuf_add(sb, "foo", 3);
     +	strbuf_addbuf(sb, sb2);
    @@ t/stdlib-test.c (new)
     +	unlink(path);
     +	read_in_full(fd, &sb, 1);
     +	write_in_full(fd, &sb, 1);
    -+	pread_in_full(fd, &sb, 1, 0);	
    ++	pread_in_full(fd, &sb, 1, 0);
     +}
     +
     +int main() {
    @@ t/stdlib-test.c (new)
     +	fprintf(stderr, "all git-std-lib functions finished calling\n");
     +	return 0;
     +}
    - \ No newline at end of file
-- 
2.41.0.640.ga95def55d0-goog

