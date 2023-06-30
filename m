Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9672EEB64DA
	for <git@archiver.kernel.org>; Fri, 30 Jun 2023 20:22:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjF3UWo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 30 Jun 2023 16:22:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbjF3UWn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 30 Jun 2023 16:22:43 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DE8F2D69
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:22:41 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 41be03b00d2f7-53fa2d0c2ebso1710753a12.1
        for <git@vger.kernel.org>; Fri, 30 Jun 2023 13:22:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688156560; x=1690748560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QUoWgkNUkSXDxXht6aAY7YM9Eb7BStnibkeHMr07Z6Y=;
        b=WXytBfBCm+QnhrXLo0Llr4pK/StxWF63PiwM3QCYpj6mS2rq004mfiMOFkP1kWoZ+L
         fG39qkTWAWWnt6jrfRntodNNs4z2AjtlBAS15a9Zlz+1SK/g+sCtAjlmsrvClgv6K434
         1WJ3zhsiHpNj67OsGqV6z620sFe+OQvZwwaviDbQIffckwQJbHcO+nSh9c8GTNYyLM9R
         AyFV8Fny6Es769ALiMTlYIaN8mjJQ1YKQFTo4fGSBMQw8oO3YcnM6mybbfOmGrDbvoh4
         SZoNxHA/WyPOinjjhWtSgF6r958n+zV/qb8C3i0BSwdVS9NmYFDI6g5rnaZAo7+ElSzr
         7xtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688156560; x=1690748560;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QUoWgkNUkSXDxXht6aAY7YM9Eb7BStnibkeHMr07Z6Y=;
        b=NbH7Aor8kzfTwuT5GTj1bJsAig3bESU64fb4w6ACOPnK/G42ZPNALRUc/DyTFxMZl3
         KD+s/tS1YU7FiGzTOfdqTtHbUaEEaT24HXzafmeSQyq52U0jQG1gr9p7Qj3MOc2tO0iJ
         coX8gZdkziFUbEur+N75UYup2rd2KEghK7MtxPAlm+JjRTOh0oayIkRNP5edgJ5qmE2Y
         /YgtQhWGHhIsVHYtaCoEtQ8UN5R6G3hPUmUdqbnL8XV+S5y81TgkekWrD7HKmLfnObMr
         kj60ITqhTgwRoyipAn5TRzMYPjeGWBzA3weQpMPwLo1ocR6w0km6wB+E5o4Z40IdpV+J
         HIvA==
X-Gm-Message-State: ABy/qLbMHOph6lzV8mKchItHPD25X4vGuxIGl11C6VRygg2kdkT7g5AA
        MGMPMTH20EIISqtefQF4qw9VoYnstwWcAkvmlnqrHdsX1kbmieZJx1xPLbjQACLEO4tXdMRu6hb
        3lrO9HhFip6S2Ga3x1XW+9spUDthtMkOMDzXiqknyl70M8fYK7Ii1/slyFWay2yZSRg==
X-Google-Smtp-Source: APBJJlHiKfUIPu22IxJQr8R7vP4r9zOhcgh+AhI5zpLJu6tq8n5B6GIVoeRcH3O+MMZ46Fv5Nyjh0EEt/LkgCag=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a63:1520:0:b0:553:a9aa:965d with SMTP id
 v32-20020a631520000000b00553a9aa965dmr1313541pgl.2.1688156560394; Fri, 30 Jun
 2023 13:22:40 -0700 (PDT)
Date:   Fri, 30 Jun 2023 20:22:37 +0000
In-Reply-To: <20230606170711.912972-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230606170711.912972-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.255.g8b1d071c50-goog
Message-ID: <20230630202237.3069327-1-calvinwan@google.com>
Subject: [PATCH v4 0/6] git-compat-util cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v3:
 - Dropped patches 5 and 6 since removing the circular dependency in
   common.h turns out to be quite difficult
 - Patch 8 moves the alloc macros to git-compat-util.h rather than
   common.h since that does not exist anymore

Note for the maintainer:

I rebased this series onto both seen and next and they rebased cleanly.
As currently submitted, it is rebased onto next at (38632f3da).
Hopefully this series now doesn't cause any issues with other inflight
series.

Calvin Wan (6):
  git-compat-util: move strbuf.c funcs to its header
  git-compat-util: move wrapper.c funcs to its header
  sane-ctype.h: create header for sane-ctype macros
  kwset: move translation table from ctype
  treewide: remove unnecessary includes for wrapper.h
  common: move alloc macros to common.h

 add-patch.c                        |   1 -
 alias.c                            |   1 -
 alloc.h                            |  75 --------
 apply.c                            |   2 -
 archive-tar.c                      |   1 -
 archive.c                          |   1 -
 attr.c                             |   1 -
 builtin/am.c                       |   1 -
 builtin/bisect.c                   |   1 -
 builtin/blame.c                    |   1 -
 builtin/branch.c                   |   1 -
 builtin/bugreport.c                |   1 -
 builtin/cat-file.c                 |   1 -
 builtin/checkout--worker.c         |   1 -
 builtin/clone.c                    |   1 -
 builtin/config.c                   |   2 -
 builtin/credential-cache--daemon.c |   1 -
 builtin/credential-cache.c         |   1 -
 builtin/difftool.c                 |   1 -
 builtin/fast-import.c              |   1 -
 builtin/fetch-pack.c               |   1 -
 builtin/fmt-merge-msg.c            |   1 -
 builtin/fsmonitor--daemon.c        |   1 -
 builtin/gc.c                       |   1 -
 builtin/get-tar-commit-id.c        |   1 -
 builtin/grep.c                     |   1 -
 builtin/index-pack.c               |   2 -
 builtin/init-db.c                  |   1 -
 builtin/log.c                      |   1 -
 builtin/merge.c                    |   2 -
 builtin/mktree.c                   |   1 -
 builtin/mv.c                       |   1 -
 builtin/name-rev.c                 |   1 -
 builtin/pack-objects.c             |   2 -
 builtin/rebase.c                   |   1 -
 builtin/receive-pack.c             |   1 -
 builtin/repack.c                   |   1 -
 builtin/rerere.c                   |   1 -
 builtin/rev-parse.c                |   1 -
 builtin/revert.c                   |   1 -
 builtin/rm.c                       |   1 -
 builtin/submodule--helper.c        |   1 -
 builtin/symbolic-ref.c             |   1 +
 builtin/unpack-file.c              |   1 -
 builtin/unpack-objects.c           |   1 +
 builtin/worktree.c                 |   1 -
 bulk-checkin.c                     |   2 -
 cache-tree.c                       |   1 -
 chunk-format.c                     |   1 -
 combine-diff.c                     |   1 -
 commit-graph.c                     |   1 -
 commit-reach.c                     |   1 -
 compat/terminal.c                  |   1 -
 config.c                           |   2 -
 convert.c                          |   1 -
 copy.c                             |   1 -
 csum-file.c                        |   1 -
 ctype.c                            |  36 ----
 daemon.c                           |   2 -
 delta-islands.c                    |   1 -
 diff.c                             |   2 -
 diffcore-rename.c                  |   1 -
 dir-iterator.c                     |   1 -
 dir.c                              |   2 -
 editor.c                           |   1 -
 entry.c                            |   1 -
 environment.c                      |   1 -
 ewah/bitmap.c                      |   1 -
 ewah/ewah_bitmap.c                 |   1 -
 fetch-pack.c                       |   2 -
 fmt-merge-msg.c                    |   1 -
 fsck.c                             |   1 -
 git-compat-util.h                  | 284 ++++++++---------------------
 gpg-interface.c                    |   1 -
 grep.c                             |   1 -
 help.c                             |   1 -
 http-backend.c                     |   2 -
 imap-send.c                        |   1 -
 kwset.c                            |  36 ++++
 kwset.h                            |   2 +
 line-log.c                         |   1 -
 list-objects-filter-options.c      |   1 -
 list-objects-filter.c              |   1 -
 merge-ll.c                         |   1 -
 merge-recursive.c                  |   1 -
 midx.c                             |   1 -
 notes-merge.c                      |   1 -
 object-file.c                      |   2 -
 oid-array.c                        |   1 -
 oidtree.c                          |   1 -
 pack-bitmap-write.c                |   1 -
 pack-bitmap.c                      |   1 -
 pack-objects.c                     |   1 -
 pack-write.c                       |   1 -
 packfile.c                         |   2 -
 parallel-checkout.c                |   2 -
 path.c                             |   1 -
 pkt-line.c                         |   1 -
 pretty.c                           |   1 -
 prio-queue.c                       |   1 -
 quote.c                            |   1 -
 read-cache.c                       |   2 -
 rebase-interactive.c               |   1 -
 ref-filter.c                       |   1 -
 reflog-walk.c                      |   1 -
 refs.c                             |   2 -
 refspec.c                          |   1 -
 remote-curl.c                      |   1 -
 remote.c                           |   1 -
 rerere.c                           |   2 -
 revision.c                         |   1 -
 sane-ctype.h                       |  66 +++++++
 send-pack.c                        |   1 -
 sequencer.c                        |   2 -
 server-info.c                      |   2 -
 setup.c                            |   1 -
 shallow.c                          |   2 -
 sigchain.c                         |   1 -
 sparse-index.c                     |   1 -
 split-index.c                      |   1 -
 strbuf.c                           |   2 -
 strbuf.h                           |  32 ++++
 streaming.c                        |   1 -
 string-list.c                      |   1 -
 strvec.c                           |   1 -
 submodule-config.c                 |   1 -
 submodule.c                        |   1 -
 t/helper/test-delta.c              |   1 -
 t/helper/test-fsmonitor-client.c   |   1 -
 t/helper/test-reach.c              |   1 -
 t/helper/test-read-cache.c         |   1 -
 tag.c                              |   1 -
 tempfile.c                         |   1 -
 trace.c                            |   1 -
 trace2/tr2_tls.c                   |   1 -
 trailer.c                          |   1 -
 transport-helper.c                 |   1 -
 transport.c                        |   2 -
 tree-walk.c                        |   1 -
 upload-pack.c                      |   1 -
 usage.c                            |   1 -
 userdiff.c                         |   1 -
 versioncmp.c                       |   1 +
 worktree.c                         |   2 -
 wrapper.c                          |   1 -
 wrapper.h                          | 111 +++++++++++
 write-or-die.c                     |   1 -
 147 files changed, 327 insertions(+), 478 deletions(-)
 create mode 100644 sane-ctype.h

Range-diff against v3:
 1:  03efb2c4b3 <  -:  ---------- init-db: document existing bug with core.bare in template config
 2:  020191c84e <  -:  ---------- init-db: remove unnecessary global variable
 3:  4f2631b200 <  -:  ---------- init-db, clone: change unnecessary global into passed parameter
 4:  40e8349c97 <  -:  ---------- setup: adopt shared init-db & clone code
 5:  8ce842e5e4 <  -:  ---------- read-cache: move shared commit and ls-files code
 6:  9a435193b6 <  -:  ---------- add: modify add_files_to_cache() to avoid globals
 7:  f9fb1ec0c5 <  -:  ---------- read-cache: move shared add/checkout/commit code
 8:  193ccad5dd <  -:  ---------- statinfo: move stat_{data,validity} functions from cache/read-cache
 9:  8fb86883ed <  -:  ---------- run-command.h: move declarations for run-command.c from cache.h
10:  5e579aeeb5 <  -:  ---------- name-hash.h: move declarations for name-hash.c from cache.h
11:  5c0c5257a6 <  -:  ---------- sparse-index.h: move declarations for sparse-index.c from cache.h
12:  230b0e9968 <  -:  ---------- preload-index.h: move declarations for preload-index.c from elsewhere
13:  66327b7465 <  -:  ---------- diff.h: move declaration for global in diff.c from cache.h
14:  61830c7bfa <  -:  ---------- merge.h: move declarations for merge.c from cache.h
15:  0979c990b1 <  -:  ---------- repository.h: move declaration of the_index from cache.h
16:  eb2fac9a86 <  -:  ---------- read-cache*.h: move declarations for read-cache.c functions from cache.h
17:  0cda8f7c94 <  -:  ---------- cache.h: remove this no-longer-used header
18:  82ce975a19 <  -:  ---------- log-tree: replace include of revision.h with simple forward declaration
19:  75334a2bc0 <  -:  ---------- repository: remove unnecessary include of path.h
20:  940ebf92de <  -:  ---------- diff.h: remove unnecessary include of oidset.h
21:  fc12c810dc <  -:  ---------- list-objects-filter-options.h: remove unneccessary include
22:  8985e07940 <  -:  ---------- builtin.h: remove unneccessary includes
23:  af118e7cf0 <  -:  ---------- git-compat-util.h: remove unneccessary include of wildmatch.h
24:  7e33c8f9b1 <  -:  ---------- merge-ll: rename from ll-merge
25:  5e96b1b130 <  -:  ---------- khash: name the structs that khash declares
26:  2d6aa61e78 <  -:  ---------- object-store-ll.h: split this header out of object-store.h
27:  f6927dd57c <  -:  ---------- hash-ll, hashmap: move oidhash() to hash-ll
28:  482d3c671e <  -:  ---------- fsmonitor-ll.h: split this header out of fsmonitor.h
29:  aa680f395a <  -:  ---------- strbuf: clarify API boundary
30:  44b977d1b0 <  -:  ---------- abspath: move related functions to abspath
31:  99852416e8 <  -:  ---------- credential-store: move related functions to credential-store file
32:  09aef95f30 <  -:  ---------- object-name: move related functions to object-name
33:  36048bca4c <  -:  ---------- path: move related function to path
34:  02a02faf12 <  -:  ---------- strbuf: clarify dependency
35:  63a933ff2f <  -:  ---------- strbuf: remove global variable
36:  d352eae308 =  1:  144284a8f1 git-compat-util: move strbuf.c funcs to its header
37:  fe4fd6f92a =  2:  39913c44e8 git-compat-util: move wrapper.c funcs to its header
38:  ec7ea12f7c =  3:  c495762940 sane-ctype.h: create header for sane-ctype macros
39:  4f95b4121e =  4:  2750d35e6d kwset: move translation table from ctype
40:  36525e39d5 <  -:  ---------- common.h: move non-compat specific macros and functions
41:  21f0f31ff3 <  -:  ---------- git-compat-util: move usage.c funcs to its header
42:  531db31c5c !  5:  b5fb55d235 treewide: remove unnecessary includes for wrapper.h
    @@ gpg-interface.c
     -#include "wrapper.h"
      #include "environment.h"
      
    - static int git_gpg_config(const char *, const char *, void *);
    + static int git_gpg_config(const char *, const char *,
     
      ## grep.c ##
     @@
43:  98694f7add !  6:  140d98111f common: move alloc macros to common.h
    @@ Commit message
         common: move alloc macros to common.h
     
         alloc_nr, ALLOC_GROW, and ALLOC_GROW_BY are commonly used macros for
    -    dynamic array allocation. Moving these macros to common.h focuses
    -    alloc.[ch] to allocation for Git objects and additionally allows us to
    -    remove inclusions to alloc.h from files that solely used the above
    -    macros.
    +    dynamic array allocation. Moving these macros to git-compat-util.h with
    +    the other alloc macros focuses alloc.[ch] to allocation for Git objects
    +    and additionally allows us to remove inclusions to alloc.h from files
    +    that solely used the above macros.
     
      ## add-patch.c ##
     @@
    @@ commit-reach.c
      #include "commit-graph.h"
      #include "decorate.h"
     
    - ## common.h ##
    -@@ common.h: static inline int cast_size_t_to_int(size_t a)
    -  */
    - #define FREE_AND_NULL(p) do { free(p); (p) = NULL; } while (0)
    - 
    -+#define alloc_nr(x) (((x)+16)*3/2)
    -+
    -+/**
    -+ * Dynamically growing an array using realloc() is error prone and boring.
    -+ *
    -+ * Define your array with:
    -+ *
    -+ * - a pointer (`item`) that points at the array, initialized to `NULL`
    -+ *   (although please name the variable based on its contents, not on its
    -+ *   type);
    -+ *
    -+ * - an integer variable (`alloc`) that keeps track of how big the current
    -+ *   allocation is, initialized to `0`;
    -+ *
    -+ * - another integer variable (`nr`) to keep track of how many elements the
    -+ *   array currently has, initialized to `0`.
    -+ *
    -+ * Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
    -+ * alloc)`.  This ensures that the array can hold at least `n` elements by
    -+ * calling `realloc(3)` and adjusting `alloc` variable.
    -+ *
    -+ * ------------
    -+ * sometype *item;
    -+ * size_t nr;
    -+ * size_t alloc
    -+ *
    -+ * for (i = 0; i < nr; i++)
    -+ * 	if (we like item[i] already)
    -+ * 		return;
    -+ *
    -+ * // we did not like any existing one, so add one
    -+ * ALLOC_GROW(item, nr + 1, alloc);
    -+ * item[nr++] = value you like;
    -+ * ------------
    -+ *
    -+ * You are responsible for updating the `nr` variable.
    -+ *
    -+ * If you need to specify the number of elements to allocate explicitly
    -+ * then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
    -+ *
    -+ * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
    -+ * added niceties.
    -+ *
    -+ * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
    -+ */
    -+#define ALLOC_GROW(x, nr, alloc) \
    -+	do { \
    -+		if ((nr) > alloc) { \
    -+			if (alloc_nr(alloc) < (nr)) \
    -+				alloc = (nr); \
    -+			else \
    -+				alloc = alloc_nr(alloc); \
    -+			REALLOC_ARRAY(x, alloc); \
    -+		} \
    -+	} while (0)
    -+
    -+/*
    -+ * Similar to ALLOC_GROW but handles updating of the nr value and
    -+ * zeroing the bytes of the newly-grown array elements.
    -+ *
    -+ * DO NOT USE any expression with side-effect for any of the
    -+ * arguments.
    -+ */
    -+#define ALLOC_GROW_BY(x, nr, increase, alloc) \
    -+	do { \
    -+		if (increase) { \
    -+			size_t new_nr = nr + (increase); \
    -+			if (new_nr < nr) \
    -+				BUG("negative growth in ALLOC_GROW_BY"); \
    -+			ALLOC_GROW(x, new_nr, alloc); \
    -+			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
    -+			nr = new_nr; \
    -+		} \
    -+	} while (0)
    -+
    - #define ALLOC_ARRAY(x, alloc) (x) = xmalloc(st_mult(sizeof(*(x)), (alloc)))
    - #define CALLOC_ARRAY(x, alloc) (x) = xcalloc((alloc), sizeof(*(x)))
    - #define REALLOC_ARRAY(x, alloc) (x) = xrealloc((x), st_mult(sizeof(*(x)), (alloc)))
    -
      ## config.c ##
     @@
      #include "git-compat-util.h"
    @@ fsck.c
      #include "dir.h"
      #include "hex.h"
     
    + ## git-compat-util.h ##
    +@@ git-compat-util.h: static inline void move_array(void *dst, const void *src, size_t n, size_t size)
    + #define FLEXPTR_ALLOC_STR(x, ptrname, str) \
    + 	FLEXPTR_ALLOC_MEM((x), ptrname, (str), strlen(str))
    + 
    ++#define alloc_nr(x) (((x)+16)*3/2)
    ++
    ++/**
    ++ * Dynamically growing an array using realloc() is error prone and boring.
    ++ *
    ++ * Define your array with:
    ++ *
    ++ * - a pointer (`item`) that points at the array, initialized to `NULL`
    ++ *   (although please name the variable based on its contents, not on its
    ++ *   type);
    ++ *
    ++ * - an integer variable (`alloc`) that keeps track of how big the current
    ++ *   allocation is, initialized to `0`;
    ++ *
    ++ * - another integer variable (`nr`) to keep track of how many elements the
    ++ *   array currently has, initialized to `0`.
    ++ *
    ++ * Then before adding `n`th element to the item, call `ALLOC_GROW(item, n,
    ++ * alloc)`.  This ensures that the array can hold at least `n` elements by
    ++ * calling `realloc(3)` and adjusting `alloc` variable.
    ++ *
    ++ * ------------
    ++ * sometype *item;
    ++ * size_t nr;
    ++ * size_t alloc
    ++ *
    ++ * for (i = 0; i < nr; i++)
    ++ * 	if (we like item[i] already)
    ++ * 		return;
    ++ *
    ++ * // we did not like any existing one, so add one
    ++ * ALLOC_GROW(item, nr + 1, alloc);
    ++ * item[nr++] = value you like;
    ++ * ------------
    ++ *
    ++ * You are responsible for updating the `nr` variable.
    ++ *
    ++ * If you need to specify the number of elements to allocate explicitly
    ++ * then use the macro `REALLOC_ARRAY(item, alloc)` instead of `ALLOC_GROW`.
    ++ *
    ++ * Consider using ALLOC_GROW_BY instead of ALLOC_GROW as it has some
    ++ * added niceties.
    ++ *
    ++ * DO NOT USE any expression with side-effect for 'x', 'nr', or 'alloc'.
    ++ */
    ++#define ALLOC_GROW(x, nr, alloc) \
    ++	do { \
    ++		if ((nr) > alloc) { \
    ++			if (alloc_nr(alloc) < (nr)) \
    ++				alloc = (nr); \
    ++			else \
    ++				alloc = alloc_nr(alloc); \
    ++			REALLOC_ARRAY(x, alloc); \
    ++		} \
    ++	} while (0)
    ++
    ++/*
    ++ * Similar to ALLOC_GROW but handles updating of the nr value and
    ++ * zeroing the bytes of the newly-grown array elements.
    ++ *
    ++ * DO NOT USE any expression with side-effect for any of the
    ++ * arguments.
    ++ */
    ++#define ALLOC_GROW_BY(x, nr, increase, alloc) \
    ++	do { \
    ++		if (increase) { \
    ++			size_t new_nr = nr + (increase); \
    ++			if (new_nr < nr) \
    ++				BUG("negative growth in ALLOC_GROW_BY"); \
    ++			ALLOC_GROW(x, new_nr, alloc); \
    ++			memset((x) + nr, 0, sizeof(*(x)) * (increase)); \
    ++			nr = new_nr; \
    ++		} \
    ++	} while (0)
    ++
    + static inline char *xstrdup_or_null(const char *str)
    + {
    + 	return str ? xstrdup(str) : NULL;
    +
      ## help.c ##
     @@
      #include "git-compat-util.h"
-- 
2.41.0.255.g8b1d071c50-goog

