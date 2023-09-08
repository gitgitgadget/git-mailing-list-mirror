Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9871FEE14D8
	for <git@archiver.kernel.org>; Fri,  8 Sep 2023 17:03:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245387AbjIHRDg (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Sep 2023 13:03:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245284AbjIHRDf (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Sep 2023 13:03:35 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AB51FEB
        for <git@vger.kernel.org>; Fri,  8 Sep 2023 10:03:26 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-59b5e70ce13so7890817b3.2
        for <git@vger.kernel.org>; Fri, 08 Sep 2023 10:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1694192604; x=1694797404; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ylos6z8uxR8tZkMg8xzejyVpsVZ19+ilGIU4/XNgl+k=;
        b=HUzRg+Y/jf7MRADBT8TzoGHsE86IvUcVszW8WeZ/UsJ5GkE6eLBTZaORIpFpHfxf5j
         qFwyAzU6hCB+Zp0LwQheY5INw07NkJ3E9xUw2r1Wwm/N+uY9QCaEccinl4s9qb6GBtbK
         VoSRpvFe+RhKVZ/PiqypXhnSoE4ue93nHldy8Zd1z+WyF8E7YxPv2Wg108Mthtb2M0VM
         HH6K5lacQOXO2xVeX8gc9WbY4hDTuyAP/BZ2jDUa54jQnSNiH5Sj5Y25C0aZSD6u4Jii
         r9yBFD/UXI1QWXALkOuFjs/0pEXSbydRcJ4Kptsg/4US2pP2tY8k5fWveSiPUyIVuZty
         Wfyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694192604; x=1694797404;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ylos6z8uxR8tZkMg8xzejyVpsVZ19+ilGIU4/XNgl+k=;
        b=CJC8W2mjbyKxlxnrkRCSA29p4mjIGD62eOr5wHLhavVHpTwitkQCxOdYETbyWJ287+
         OSWLIyas/F3rfcjxnj2EMmFlWxW/Dc9xBkTWSl4I4wioxsc61pLTOHvb0UvYE4IyC2Ls
         N4rCE+0LHN7yhXgf98NJlL+aDzX/chAYlFNNylTd/ipjPucm1jzqof84FeUGnJV0OWwF
         PN6I46faUZT1EfEhYXFZ1rRsHVpyh4LjhO/zB58H8vzVOXvuBKnufoiE/MReHxx7+Uwa
         W9KO/y5IbxIs9PkR8Kd7uQ9w/AnNPZW5Phh9obvNAH+KN/aJqEVBtw2zftMpElZfqt/m
         erEQ==
X-Gm-Message-State: AOJu0Ywio++wzdpImxAhKFBTHlxfqBu+kOf6rpwtbdor6OPSGbk2PI3h
        5jzcNCQDlRF+Toze3lavgLJ++eq9xBrDuBtJYnasAIyLD4TNIIl0UJLsLibTvCFp8DICHnxnE75
        IA+JLEIYm6GSD4l4s64/htMl/03/8dMOnCAPA7U2pcxhJiB85ztbT4TWcMpGkHlAYGQ==
X-Google-Smtp-Source: AGHT+IEGdb+SLhplflBSqEeuDn82Eit+0TjhpBHBvl7ZGSSTtZyxil1HBR+2cld/I7tLdlDZsZ05xpZcB6qrCn0=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a81:ac1d:0:b0:58c:b5a4:8e1f with SMTP id
 k29-20020a81ac1d000000b0058cb5a48e1fmr83122ywh.3.1694192604426; Fri, 08 Sep
 2023 10:03:24 -0700 (PDT)
Date:   Fri,  8 Sep 2023 17:03:12 +0000
In-Reply-To: <https://lore.kernel.org/git/20230810163346.274132-1-calvinwan@google.com/>
Mime-Version: 1.0
References: <https://lore.kernel.org/git/20230810163346.274132-1-calvinwan@google.com/>
X-Mailer: git-send-email 2.42.0.283.g2d96d420d3-goog
Message-ID: <20230908170313.1021375-1-calvinwan@google.com>
Subject: [PATCH v3 0/6] Introduce Git Standard Library
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, nasamuffin@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Original cover letter:
https://lore.kernel.org/git/20230627195251.1973421-1-calvinwan@google.com/

I have taken this series out of RFC since there weren't any significant
concerns with the overall concept and design of this series. This reroll
incorporates some smaller changes such as dropping the "push pager
dependency" patch in favor of stubbing it out. The main change this
reroll is cleaning up the Makefile rules and stubs, as suggested by
Phillip Wood (appreciate the help on this one)!

This series has been rebased onto 1fc548b2d6a: The sixth batch

Originally this series was built on other patches that have since been
merged, which is why the range-diff is shown removing many of them.

Calvin Wan (6):
  hex-ll: split out functionality from hex
  wrapper: remove dependency to Git-specific internal file
  config: correct bad boolean env value error message
  parse: create new library for parsing strings and env values
  git-std-lib: introduce git standard library
  git-std-lib: add test file to call git-std-lib.a functions

 Documentation/technical/git-std-lib.txt | 191 ++++++++++++++++++++
 Makefile                                |  41 ++++-
 attr.c                                  |   2 +-
 color.c                                 |   2 +-
 config.c                                | 173 +-----------------
 config.h                                |  14 +-
 entry.c                                 |   5 +
 entry.h                                 |   6 +
 git-compat-util.h                       |   7 +-
 hex-ll.c                                |  49 +++++
 hex-ll.h                                |  27 +++
 hex.c                                   |  47 -----
 hex.h                                   |  24 +--
 mailinfo.c                              |   2 +-
 pack-objects.c                          |   2 +-
 pack-revindex.c                         |   2 +-
 parse-options.c                         |   3 +-
 parse.c                                 | 182 +++++++++++++++++++
 parse.h                                 |  20 ++
 pathspec.c                              |   2 +-
 preload-index.c                         |   2 +-
 progress.c                              |   2 +-
 prompt.c                                |   2 +-
 rebase.c                                |   2 +-
 strbuf.c                                |   2 +-
 stubs/pager.c                           |   6 +
 stubs/pager.h                           |   6 +
 stubs/trace2.c                          |  27 +++
 symlinks.c                              |   2 +
 t/Makefile                              |   4 +
 t/helper/test-env-helper.c              |   2 +-
 t/stdlib-test.c                         | 231 ++++++++++++++++++++++++
 unpack-trees.c                          |   2 +-
 url.c                                   |   2 +-
 urlmatch.c                              |   2 +-
 wrapper.c                               |   9 +-
 wrapper.h                               |   5 -
 write-or-die.c                          |   2 +-
 38 files changed, 824 insertions(+), 287 deletions(-)
 create mode 100644 Documentation/technical/git-std-lib.txt
 create mode 100644 hex-ll.c
 create mode 100644 hex-ll.h
 create mode 100644 parse.c
 create mode 100644 parse.h
 create mode 100644 stubs/pager.c
 create mode 100644 stubs/pager.h
 create mode 100644 stubs/trace2.c
 create mode 100644 t/stdlib-test.c

Range-diff against v2:
 1:  121788f263 <  -:  ---------- strbuf: clarify API boundary
 2:  5e91404ecd <  -:  ---------- strbuf: clarify dependency
 3:  5c05f40181 <  -:  ---------- abspath: move related functions to abspath
 4:  e1addc77e5 <  -:  ---------- credential-store: move related functions to credential-store file
 5:  62e8c42f59 <  -:  ---------- object-name: move related functions to object-name
 6:  0abba57acb <  -:  ---------- path: move related function to path
 7:  d33267a390 <  -:  ---------- strbuf: remove global variable
 8:  665d2c2089 <  -:  ---------- init-db: document existing bug with core.bare in template config
 9:  68d0a8ff16 <  -:  ---------- init-db: remove unnecessary global variable
10:  8c8ec85507 <  -:  ---------- init-db, clone: change unnecessary global into passed parameter
11:  d555e2b365 <  -:  ---------- setup: adopt shared init-db & clone code
12:  689a7bc8aa <  -:  ---------- read-cache: move shared commit and ls-files code
13:  392f8e75b7 <  -:  ---------- add: modify add_files_to_cache() to avoid globals
14:  49ce237013 <  -:  ---------- read-cache: move shared add/checkout/commit code
15:  c5d8370d40 <  -:  ---------- statinfo: move stat_{data,validity} functions from cache/read-cache
16:  90a72b6f86 <  -:  ---------- run-command.h: move declarations for run-command.c from cache.h
17:  f27516c780 <  -:  ---------- name-hash.h: move declarations for name-hash.c from cache.h
18:  895c38a050 <  -:  ---------- sparse-index.h: move declarations for sparse-index.c from cache.h
19:  8678d4ad20 <  -:  ---------- preload-index.h: move declarations for preload-index.c from elsewhere
20:  4a463abaae <  -:  ---------- diff.h: move declaration for global in diff.c from cache.h
21:  3440e762c7 <  -:  ---------- merge.h: move declarations for merge.c from cache.h
22:  e70853e398 <  -:  ---------- repository.h: move declaration of the_index from cache.h
23:  ccd2014d73 <  -:  ---------- read-cache*.h: move declarations for read-cache.c functions from cache.h
24:  d3a482afa9 <  -:  ---------- cache.h: remove this no-longer-used header
25:  eaa087f446 <  -:  ---------- log-tree: replace include of revision.h with simple forward declaration
26:  5d2b0a9c75 <  -:  ---------- repository: remove unnecessary include of path.h
27:  250f83014e <  -:  ---------- diff.h: remove unnecessary include of oidset.h
28:  d0f9913958 <  -:  ---------- list-objects-filter-options.h: remove unneccessary include
29:  03a2b2a515 <  -:  ---------- builtin.h: remove unneccessary includes
30:  15edc22d00 <  -:  ---------- git-compat-util.h: remove unneccessary include of wildmatch.h
31:  e4e1bec8bd <  -:  ---------- merge-ll: rename from ll-merge
32:  9185495fd0 <  -:  ---------- khash: name the structs that khash declares
33:  15fb05e453 <  -:  ---------- object-store-ll.h: split this header out of object-store.h
34:  2608fe4b23 <  -:  ---------- hash-ll, hashmap: move oidhash() to hash-ll
35:  5e8dc5b574 <  -:  ---------- fsmonitor-ll.h: split this header out of fsmonitor.h
36:  37d32fc3fd <  -:  ---------- git-compat-util: move strbuf.c funcs to its header
37:  6ed19d5fe2 <  -:  ---------- git-compat-util: move wrapper.c funcs to its header
38:  555d1b8942 <  -:  ---------- sane-ctype.h: create header for sane-ctype macros
39:  72d591e282 <  -:  ---------- kwset: move translation table from ctype
40:  5d1dc2a118 <  -:  ---------- common.h: move non-compat specific macros and functions
41:  33e07e552e <  -:  ---------- git-compat-util: move usage.c funcs to its header
42:  417a8aa733 <  -:  ---------- treewide: remove unnecessary includes for wrapper.h
43:  65e35d00c1 <  -:  ---------- common: move alloc macros to common.h
44:  78634bc406 !  1:  2f99eb2ca4 hex-ll: split out functionality from hex
    @@ hex.h
     +#include "hex-ll.h"
      
      /*
    -  * Try to read a SHA1 in hexadecimal format from the 40 characters
    -@@ hex.h: int get_oid_hex(const char *hex, struct object_id *sha1);
    +  * Try to read a hash (specified by the_hash_algo) in hexadecimal
    +@@ hex.h: int get_oid_hex(const char *hex, struct object_id *oid);
      /* Like get_oid_hex, but for an arbitrary hash algorithm. */
      int get_oid_hex_algop(const char *hex, struct object_id *oid, const struct git_hash_algo *algop);
      
45:  21ec1d276e !  2:  7b2d123628 object: move function to object.c
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    object: move function to object.c
    +    wrapper: remove dependency to Git-specific internal file
     
    -    While remove_or_warn() is a simple ternary operator to call two other
    -    wrapper functions, it creates an unnecessary dependency to object.h in
    -    wrapper.c. Therefore move the function to object.[ch] where the concept
    -    of GITLINKs is first defined.
    +    In order for wrapper.c to be built independently as part of a smaller
    +    library, it cannot have dependencies to other Git specific
    +    internals. remove_or_warn() creates an unnecessary dependency to
    +    object.h in wrapper.c. Therefore move the function to entry.[ch] which
    +    performs changes on the worktree based on the Git-specific file modes in
    +    the index.
     
    - ## object.c ##
    -@@ object.c: void parsed_object_pool_clear(struct parsed_object_pool *o)
    - 	FREE_AND_NULL(o->object_state);
    - 	FREE_AND_NULL(o->shallow_stat);
    + ## entry.c ##
    +@@ entry.c: void unlink_entry(const struct cache_entry *ce, const char *super_prefix)
    + 		return;
    + 	schedule_dir_for_removal(ce->name, ce_namelen(ce));
      }
     +
     +int remove_or_warn(unsigned int mode, const char *file)
    @@ object.c: void parsed_object_pool_clear(struct parsed_object_pool *o)
     +	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
     +}
     
    - ## object.h ##
    -@@ object.h: void clear_object_flags(unsigned flags);
    -  */
    - void repo_clear_commit_marks(struct repository *r, unsigned int flags);
    + ## entry.h ##
    +@@ entry.h: int fstat_checkout_output(int fd, const struct checkout *state, struct stat *st)
    + void update_ce_after_write(const struct checkout *state, struct cache_entry *ce,
    + 			   struct stat *st);
      
     +/*
     + * Calls the correct function out of {unlink,rmdir}_or_warn based on
    @@ object.h: void clear_object_flags(unsigned flags);
     + */
     +int remove_or_warn(unsigned int mode, const char *path);
     +
    - #endif /* OBJECT_H */
    + #endif /* ENTRY_H */
     
      ## wrapper.c ##
     @@
46:  41dcf8107c =  3:  b37beb206a config: correct bad boolean env value error message
47:  3e800a41c4 !  4:  3a827cf45c parse: create new library for parsing strings and env values
    @@ Commit message
         config.c, there are other files that only need parsing functionality and
         not config functionality. By separating out string and environment value
         parsing from config, those files can instead be dependent on parse,
    -    which has a much smaller dependency chain than config.
    +    which has a much smaller dependency chain than config. This ultimately
    +    allows us to inclue parse.[ch] in an independent library since it
    +    doesn't have dependencies to Git-specific internals unlike in
    +    config.[ch].
     
         Move general string and env parsing functions from config.[ch] to
         parse.[ch].
    @@ config.c: static int git_parse_source(struct config_source *cs, config_fn_t fn,
     -	return 1;
     -}
     -
    - static int reader_config_name(struct config_reader *reader, const char **out);
    - static int reader_origin_type(struct config_reader *reader,
    - 			      enum config_origin_type *type);
    -@@ config.c: ssize_t git_config_ssize_t(const char *name, const char *value)
    + NORETURN
    + static void die_bad_number(const char *name, const char *value,
    + 			   const struct key_value_info *kvi)
    +@@ config.c: ssize_t git_config_ssize_t(const char *name, const char *value,
      	return ret;
      }
      
    @@ config.c: static enum fsync_component parse_fsync_components(const char *var, co
     -	return -1;
     -}
     -
    - int git_config_bool_or_int(const char *name, const char *value, int *is_bool)
    + int git_config_bool_or_int(const char *name, const char *value,
    + 			   const struct key_value_info *kvi, int *is_bool)
      {
    - 	int v = git_parse_maybe_bool_text(value);
     @@ config.c: void git_global_config(char **user_out, char **xdg_out)
      	*xdg_out = xdg_config;
      }
    @@ config.c: void git_global_config(char **user_out, char **xdg_out)
     
      ## config.h ##
     @@
    - 
      #include "hashmap.h"
      #include "string-list.h"
    + #include "repository.h"
     -
     +#include "parse.h"
      
48:  7a4a088bc3 <  -:  ---------- date: push pager.h dependency up
49:  c9002734d0 !  5:  b0e8739ced git-std-lib: introduce git standard library
    @@ Documentation/technical/git-std-lib.txt (new)
     +Rationale behind Git Standard Library
     +================
     +
    -+The rationale behind Git Standard Library essentially is the result of
    -+two observations within the Git codebase: every file includes
    -+git-compat-util.h which defines functions in a couple of different
    -+files, and wrapper.c + usage.c have difficult-to-separate circular
    -+dependencies with each other and other files.
    ++The rationale behind what's in and what's not in the Git Standard
    ++Library essentially is the result of two observations within the Git
    ++codebase: every file includes git-compat-util.h which defines functions
    ++in a couple of different files, and wrapper.c + usage.c have
    ++difficult-to-separate circular dependencies with each other and other
    ++files.
     +
     +Ubiquity of git-compat-util.h and circular dependencies
     +========
    @@ Documentation/technical/git-std-lib.txt (new)
     + - low-level git/* files with functions defined in git-compat-util.h
     +   (ctype.c)
     + - compat/*
    -+ - stubbed out dependencies in stubs/ (stubs/repository.c, stubs/trace2.c)
    ++ - stubbed out dependencies in stubs/ (stubs/pager.c, stubs/trace2.c)
     +
     +There are other files that might fit this definition, but that does not
     +mean it should belong in git-std-lib.a. Those files should start as
     +their own separate library since any file added to git-std-lib.a loses
     +its flexibility of being easily swappable.
     +
    -+Wrapper.c and usage.c have dependencies on repository and trace2 that are
    ++Wrapper.c and usage.c have dependencies on pager and trace2 that are
     +possible to remove at the cost of sacrificing the ability for standard Git
     +to be able to trace functions in those files and other files in git-std-lib.a.
     +In order for git-std-lib.a to compile with those dependencies, stubbed out
    @@ Documentation/technical/git-std-lib.txt (new)
     +usage.c
     +utf8.c
     +wrapper.c
    -+stubs/repository.c
    -+stubs/trace2.c
     +relevant compat/ files
     +
    ++When these files are compiled together with the following files (or
    ++user-provided files that provide the same functions), they form a
    ++complete library:
    ++stubs/pager.c
    ++stubs/trace2.c
    ++
     +Pitfalls
     +================
     +
    @@ Makefile: LIB_OBJS += write-or-die.o
     +LIB_OBJS += utf8.o
     +LIB_OBJS += wrapper.o
     +
    -+ifdef STUB_REPOSITORY
    -+STUB_OBJS += stubs/repository.o
    -+endif
    -+
     +ifdef STUB_TRACE2
     +STUB_OBJS += stubs/trace2.o
     +endif
     +
    ++ifdef STUB_PAGER
    ++STUB_OBJS += stubs/pager.o
    ++endif
    ++
     +LIB_OBJS += $(STUB_OBJS)
     +endif
      
    @@ Makefile: ifdef FSMONITOR_OS_SETTINGS
      NO_TCLTK = NoThanks
      endif
     @@ Makefile: clean: profile-clean coverage-clean cocciclean
    - 	$(RM) po/git.pot po/git-core.pot
      	$(RM) git.res
      	$(RM) $(OBJECTS)
    + 	$(RM) headless-git.o
     -	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB)
     +	$(RM) $(LIB_FILE) $(XDIFF_LIB) $(REFTABLE_LIB) $(REFTABLE_TEST_LIB) $(STD_LIB_FILE)
      	$(RM) $(ALL_PROGRAMS) $(SCRIPT_LIB) $(BUILT_INS) $(OTHER_PROGRAMS)
    @@ Makefile: $(FUZZ_PROGRAMS): all
     +### Libified Git rules
     +
     +# git-std-lib
    -+# `make git-std-lib GIT_STD_LIB=YesPlease STUB_REPOSITORY=YesPlease STUB_TRACE2=YesPlease`
    ++# `make git-std-lib GIT_STD_LIB=YesPlease STUB_TRACE2=YesPlease STUB_PAGER=YesPlease`
     +STD_LIB = git-std-lib.a
     +
     +$(STD_LIB): $(LIB_OBJS) $(COMPAT_OBJS) $(STUB_OBJS)
     +	$(QUIET_AR)$(RM) $@ && $(AR) $(ARFLAGS) $@ $^
    -+
    -+TEMP_HEADERS = temp_headers/
    -+
    -+git-std-lib:
    -+# Move headers to temporary folder and replace them with stubbed headers.
    -+# After building, move headers and stubbed headers back.
    -+ifneq ($(STUB_OBJS),)
    -+	mkdir -p $(TEMP_HEADERS); \
    -+	for d in $(STUB_OBJS); do \
    -+		BASE=$${d%.*}; \
    -+		mv $${BASE##*/}.h $(TEMP_HEADERS)$${BASE##*/}.h; \
    -+		mv $${BASE}.h $${BASE##*/}.h; \
    -+	done; \
    -+	$(MAKE) $(STD_LIB); \
    -+	for d in $(STUB_OBJS); do \
    -+		BASE=$${d%.*}; \
    -+		mv $${BASE##*/}.h $${BASE}.h; \
    -+		mv $(TEMP_HEADERS)$${BASE##*/}.h $${BASE##*/}.h; \
    -+	done; \
    -+	rm -rf temp_headers
    -+else
    -+	$(MAKE) $(STD_LIB)
    -+endif
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: static inline int noop_core_config(const char *var UNUSED,
    @@ git-compat-util.h: const char *inet_ntop(int af, const void *src, char *dst, siz
      #endif
     +#endif
      
    - /*
    -  * Limit size of IO chunks, because huge chunks only cause pain.  OS X
    -@@ git-compat-util.h: int git_access(const char *path, int mode);
    - # endif
    - #endif
    + static inline size_t st_add(size_t a, size_t b)
    + {
    +@@ git-compat-util.h: static inline int is_missing_file_error(int errno_)
    + 	return (errno_ == ENOENT || errno_ == ENOTDIR);
    + }
      
     +#ifndef GIT_STD_LIB
      int cmd_main(int, const char **);
    @@ git-compat-util.h: int git_access(const char *path, int mode);
      /*
       * You can mark a stack variable with UNLEAK(var) to avoid it being
     
    - ## stubs/repository.c (new) ##
    + ## stubs/pager.c (new) ##
     @@
    -+#include "git-compat-util.h"
    -+#include "repository.h"
    ++#include "pager.h"
     +
    -+struct repository *the_repository;
    ++int pager_in_use(void)
    ++{
    ++	return 0;
    ++}
     
    - ## stubs/repository.h (new) ##
    + ## stubs/pager.h (new) ##
     @@
    -+#ifndef REPOSITORY_H
    -+#define REPOSITORY_H
    ++#ifndef PAGER_H
    ++#define PAGER_H
     +
    -+struct repository { int stub; };
    ++int pager_in_use(void);
     +
    -+extern struct repository *the_repository;
    -+
    -+#endif /* REPOSITORY_H */
    ++#endif /* PAGER_H */
     
      ## stubs/trace2.c (new) ##
     @@
     +#include "git-compat-util.h"
     +#include "trace2.h"
     +
    ++struct child_process { int stub; };
    ++struct repository { int stub; };
    ++struct json_writer { int stub; };
    ++
     +void trace2_region_enter_fl(const char *file, int line, const char *category,
     +			    const char *label, const struct repository *repo, ...) { }
     +void trace2_region_leave_fl(const char *file, int line, const char *category,
    @@ stubs/trace2.c (new)
     +			   const struct repository *repo, const char *key,
     +			   intmax_t value) { }
     +int trace2_is_enabled(void) { return 0; }
    ++void trace2_counter_add(enum trace2_counter_id cid, uint64_t value) { }
     +void trace2_collect_process_info(enum trace2_process_info_reason reason) { }
     
    - ## stubs/trace2.h (new) ##
    -@@
    -+#ifndef TRACE2_H
    -+#define TRACE2_H
    -+
    -+struct child_process { int stub; };
    -+struct repository;
    -+struct json_writer { int stub; };
    -+
    -+void trace2_region_enter_fl(const char *file, int line, const char *category,
    -+			    const char *label, const struct repository *repo, ...);
    -+
    -+#define trace2_region_enter(category, label, repo) \
    -+	trace2_region_enter_fl(__FILE__, __LINE__, (category), (label), (repo))
    -+
    -+void trace2_region_leave_fl(const char *file, int line, const char *category,
    -+			    const char *label, const struct repository *repo, ...);
    -+
    -+#define trace2_region_leave(category, label, repo) \
    -+	trace2_region_leave_fl(__FILE__, __LINE__, (category), (label), (repo))
    -+
    -+void trace2_data_string_fl(const char *file, int line, const char *category,
    -+			   const struct repository *repo, const char *key,
    -+			   const char *value);
    -+
    -+#define trace2_data_string(category, repo, key, value)                       \
    -+	trace2_data_string_fl(__FILE__, __LINE__, (category), (repo), (key), \
    -+			      (value))
    -+
    -+void trace2_cmd_ancestry_fl(const char *file, int line, const char **parent_names);
    -+
    -+#define trace2_cmd_ancestry(v) trace2_cmd_ancestry_fl(__FILE__, __LINE__, (v))
    -+
    -+void trace2_cmd_error_va_fl(const char *file, int line, const char *fmt,
    -+			    va_list ap);
    -+
    -+#define trace2_cmd_error_va(fmt, ap) \
    -+	trace2_cmd_error_va_fl(__FILE__, __LINE__, (fmt), (ap))
    -+
    -+
    -+void trace2_cmd_name_fl(const char *file, int line, const char *name);
    -+
    -+#define trace2_cmd_name(v) trace2_cmd_name_fl(__FILE__, __LINE__, (v))
    -+
    -+void trace2_thread_start_fl(const char *file, int line,
    -+			    const char *thread_base_name);
    -+
    -+#define trace2_thread_start(thread_base_name) \
    -+	trace2_thread_start_fl(__FILE__, __LINE__, (thread_base_name))
    -+
    -+void trace2_thread_exit_fl(const char *file, int line);
    -+
    -+#define trace2_thread_exit() trace2_thread_exit_fl(__FILE__, __LINE__)
    -+
    -+void trace2_data_intmax_fl(const char *file, int line, const char *category,
    -+			   const struct repository *repo, const char *key,
    -+			   intmax_t value);
    -+
    -+#define trace2_data_intmax(category, repo, key, value)                       \
    -+	trace2_data_intmax_fl(__FILE__, __LINE__, (category), (repo), (key), \
    -+			      (value))
    -+
    -+enum trace2_process_info_reason {
    -+	TRACE2_PROCESS_INFO_STARTUP,
    -+	TRACE2_PROCESS_INFO_EXIT,
    -+};
    -+int trace2_is_enabled(void);
    -+void trace2_collect_process_info(enum trace2_process_info_reason reason);
    -+
    -+#endif /* TRACE2_H */
    -+
    -
      ## symlinks.c ##
     @@ symlinks.c: void invalidate_lstat_cache(void)
      	reset_lstat_cache(&default_cache);
    @@ symlinks.c: int lstat_cache_aware_rmdir(const char *path)
      	return ret;
      }
     +#endif
    +
    + ## wrapper.c ##
    +@@
    + #include "abspath.h"
    + #include "parse.h"
    + #include "gettext.h"
    +-#include "repository.h"
    + #include "strbuf.h"
    + #include "trace2.h"
    + 
50:  0bead8f980 !  6:  ab5dac5232 git-std-lib: add test file to call git-std-lib.a functions
    @@ t/stdlib-test.c (new)
     +	struct strbuf sb3 = STRBUF_INIT;
     +	struct string_list list = STRING_LIST_INIT_NODUP;
     +	char *buf = "foo";
    -+	struct strbuf_expand_dict_entry dict[] = {
    -+		{ "foo", NULL, },
    -+		{ "bar", NULL, },
    -+	};
     +	int fd = open("/dev/null", O_RDONLY);
     +
     +	fprintf(stderr, "calling strbuf functions\n");
    @@ t/stdlib-test.c (new)
     +	strbuf_add_commented_lines(sb, "foo", 3, '#');
     +	strbuf_commented_addf(sb, '#', "%s", "foo");
     +	// strbuf_vaddf() called by strbuf_addf()
    -+	strbuf_expand(sb, "%s", strbuf_expand_literal_cb, NULL);
    -+	strbuf_expand(sb, "%s", strbuf_expand_dict_cb, &dict);
    -+	// strbuf_expand_literal_cb() called by strbuf_expand()
    -+	// strbuf_expand_dict_cb() called by strbuf_expand()
     +	strbuf_addbuf_percentquote(sb, &sb3);
     +	strbuf_add_percentencode(sb, "foo", STRBUF_ENCODE_SLASH);
     +	strbuf_fread(sb, 0, stdin);
-- 
2.42.0.283.g2d96d420d3-goog

