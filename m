Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C172C7EE2A
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 17:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238322AbjFFRH3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 13:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233634AbjFFRH1 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 13:07:27 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0F7E18E
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 10:07:23 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-bb2202e0108so8018634276.1
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 10:07:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686071243; x=1688663243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xsOpOw0k043CsbqiDWg8Ug8pnSga0RQ2GNRc1bxzV7k=;
        b=g1ZDjAPDwNHLxCdoSSySiTBJGpLsXZFC9S4inFItzWX3fLyHbCPKwoHTaERuG8gr/J
         90JC9cAszlgDNGpavviaT12kWON51rkMeOUPb2xbS7ot4jYZyopjsiQjlfz940wQVP3M
         4yLFjdKq8wzp2+5/UMa6Xpr2w9GX8tqyYLImQjVv/XZj57Bi9OI8L60nMElMuNH3kq7Y
         RQea9C22SGU546+d5VrZULBbDIARd5HhiL3WhgOOTndrbwD9yJnOFEhbwUUhysc12XZo
         /UUxym91AlhNlgUqLrKdMIuxizLn1a5/yfwddAaCzCQ9ojcvuZ4dHZzYQzloAqqohVST
         P5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686071243; x=1688663243;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xsOpOw0k043CsbqiDWg8Ug8pnSga0RQ2GNRc1bxzV7k=;
        b=HqMg4F2Mxizgy4Eu8pvfjsQDaXPaan0T04cwp91k3AMTJRtuPjszvIiOOmzalxTqze
         hPwvMbwgKIAHsGpTlfcDhqBJsIu1ZF33wj7Aqu6ubAo0cJyva1WCUabAeOnHmpv7d3wm
         fcs5TXlTibV7XZ8vUbdnQ9HCMp228J4GC24lVNoi/tgn8dv7kKMRxYzhljDJfy+lLmmd
         kVa4WEfuc7jklKIexjv0DwrLkLkDX02javSp0ogoPfFRNDk8BScKRuAI2tUSd+vqvHqV
         plk2wxoIor3ol+9lTg8gMklAADZSkQwKWSoOUtrVw5CrbIXKN1YdSBDEfF23ZwHMxxct
         uNpw==
X-Gm-Message-State: AC+VfDyTYBPHFrOCI8uRVPCAiQHchUkKGIwK5K2m2lfV54Ils8XKH9Af
        HnQWzd7jgEVXxKbel3oPAcXYF0Wmo1qartecxaUwUZUQabCgcGZTeNkwByhXyCkmfB/Bocp8SZG
        6x0QGpCa6rlAtbQZuExbrTA5geu6nZg3Kf+XkHegT0fAn7m8UfRv8+2WvPcaVUyio8w==
X-Google-Smtp-Source: ACHHUZ4kD5pCXtFWtbI+gyorH58YjUT4tfZDV9NDQ18dG02SxRr+ix1FM+wuj7JqbEIeicoTfIgVeNP92urOZJ8=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a05:6902:1896:b0:b9d:d623:1960 with SMTP
 id cj22-20020a056902189600b00b9dd6231960mr1003947ybb.0.1686071243119; Tue, 06
 Jun 2023 10:07:23 -0700 (PDT)
Date:   Tue,  6 Jun 2023 17:07:11 +0000
In-Reply-To: <20230523192749.1270992-1-calvinwan@google.com>
Mime-Version: 1.0
References: <20230523192749.1270992-1-calvinwan@google.com>
X-Mailer: git-send-email 2.41.0.rc2.161.g9c6817b8e7-goog
Message-ID: <20230606170711.912972-1-calvinwan@google.com>
Subject: [PATCH v3 0/8] git-compat-util cleanups
From:   Calvin Wan <calvinwan@google.com>
To:     git@vger.kernel.org
Cc:     Calvin Wan <calvinwan@google.com>, phillip.wood123@gmail.com,
        jonathantanmy@google.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Changes since v2:
 - rebased on 2.41, en/header-split-cache-h-part-3, and cw/strbuf-cleanup
   (originally rebased onto seen which is why the range-diff is like that)
 - moved tolower_trans_tbl to kwset rather than sane-ctype
 - rewrote commit message headers to be shorter

This series focuses on cleaning up and reducing the scope of
git-compat-util.h by moving headers to their respective files and
separating out functionality from git-compat-util.h to a new file,
common.h. I go into more detail in patch 5 as to why I believe this
separation is useful. 

By the end of this series, git-compat-util.h includes common.h which
includes wrapper.h, and usage.h. Since virtually every file includes
git-compat-util.h and the large majority of files use functions defined
in common.h, wrapper.h, and usage.h, I believe it makes sense that those
are also automatically included with git-compat-util.h.

Calvin Wan (8):
  git-compat-util: move strbuf.c funcs to its header
  git-compat-util: move wrapper.c funcs to its header
  sane-ctype.h: create header for sane-ctype macros
  kwset: move translation table from ctype
  common.h: move non-compat specific macros and functions
  git-compat-util: move usage.c funcs to its header
  treewide: remove unnecessary includes for wrapper.h
  common: move alloc macros to common.h

 add-patch.c                        |   1 -
 alias.c                            |   1 -
 alloc.h                            |  75 ----
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
 common.h                           | 486 +++++++++++++++++++++
 compat/terminal.c                  |   1 -
 config.c                           |   2 -
 convert.c                          |   1 -
 copy.c                             |   1 -
 csum-file.c                        |   1 -
 ctype.c                            |  36 --
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
 git-compat-util.h                  | 664 +----------------------------
 gpg-interface.c                    |   1 -
 grep.c                             |   1 -
 help.c                             |   1 -
 http-backend.c                     |   2 -
 imap-send.c                        |   1 -
 kwset.c                            |  36 ++
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
 sane-ctype.h                       |  66 +++
 send-pack.c                        |   1 -
 sequencer.c                        |   2 -
 server-info.c                      |   2 -
 setup.c                            |   1 -
 shallow.c                          |   2 -
 sigchain.c                         |   1 -
 sparse-index.c                     |   1 -
 split-index.c                      |   1 -
 strbuf.c                           |   2 -
 strbuf.h                           |  32 ++
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
 usage.h                            |  60 +++
 userdiff.c                         |   1 -
 versioncmp.c                       |   1 +
 worktree.c                         |   2 -
 wrapper.c                          |   1 -
 wrapper.h                          | 111 +++++
 write-or-die.c                     |   1 -
 149 files changed, 799 insertions(+), 932 deletions(-)
 create mode 100644 common.h
 create mode 100644 sane-ctype.h
 create mode 100644 usage.h

Range-diff against v2:
  1:  08f55ec7b2 <   -:  ---------- diff-merges: implement [no-]hide option and log.diffMergesHide config
  2:  b9873596ec <   -:  ---------- diff-merges: implement log.diffMerges-m-imply-p config
  3:  56c961db8d <   -:  ---------- diff-merges: support list of values for --diff-merges
  4:  96f5dc2cfe <   -:  ---------- diff-merges: issue warning on lone '-m' option
  5:  0200086346 <   -:  ---------- diff-merges: improve --diff-merges documentation
  6:  f216b8d143 <   -:  ---------- test-lib: allow storing counts with test harnesses
  7:  78bb2515d6 <   -:  ---------- checkout/switch: disallow checking out same branch in multiple worktrees
  8:  f2111f451f <   -:  ---------- imap-send: note "auth_method", not "host" on auth method failure
  9:  f161e8fd64 <   -:  ---------- imap-send doc: the imap.sslVerify is used with imap.tunnel
 10:  ddfd0c2740 <   -:  ---------- imap-send: replace auto-probe libcurl with hard dependency
 11:  647ddc1bf8 <   -:  ---------- imap-send: make --curl no-optional
 12:  bbf79fd38d <   -:  ---------- imap-send: remove old --no-curl codepath
 13:  ded420f1d1 <   -:  ---------- imap-send: correctly report "host" when using "tunnel"
 14:  4bef181256 <   -:  ---------- pull: conflict hint pull.rebase suggestion should offer "merges" vs "true"
 15:  fe944b5c26 <   -:  ---------- run-command: add on_stderr_output_fn to run_processes_parallel_opts
 16:  079d6eec74 <   -:  ---------- submodule: rename strbuf variable
 17:  c306d4ce36 <   -:  ---------- submodule: move status parsing into function
 18:  7cce9de786 <   -:  ---------- submodule: refactor is_submodule_modified()
 19:  a8a6e3a99b <   -:  ---------- diff-lib: refactor out diff_change logic
 20:  ab60254a51 <   -:  ---------- diff-lib: parallelize run_diff_files for submodules
 21:  f8762b1cef <   -:  ---------- pack-bitmap.c: hide bitmap internals in `read_u8()`
 22:  82d838ac61 <   -:  ---------- pack-bitmap.c: hide bitmap internals in `read_be32()`
 23:  5abc4c1c89 <   -:  ---------- pack-bitmap.c: drop unnecessary 'inline's
 24:  0e2a13eb16 <   -:  ---------- pack-bitmap.c: factor out manual `map_pos` manipulation
 25:  e535db7c69 <   -:  ---------- pack-bitmap.c: use `bitmap_index_seek()` where possible
 26:  3acd24d42a <   -:  ---------- pack-bitmap.c: factor out `bitmap_index_seek_commit()`
 27:  1cf6fbc4f7 <   -:  ---------- SQUASH??? the test marked to expect failure passes from day one
 28:  3ff774e34f <   -:  ---------- fsmonitor: handle differences between Windows named pipe functions
 29:  fce46cf78e <   -:  ---------- diff-index: enable sparse index
 30:  f7cfd68b91 <   -:  ---------- usage: clarify --recurse-submodules as a boolean
 31:  2739b3473a <   -:  ---------- rebase -i: move unlink() calls
 32:  486312cec7 <   -:  ---------- rebase -i: remove patch file after conflict resolution
 33:  a2fbbcb270 <   -:  ---------- sequencer: factor out part of pick_commits()
 34:  193623fd97 <   -:  ---------- rebase --continue: refuse to commit after failed command
 35:  cfc27593ab <   -:  ---------- rebase: fix rewritten list for failed pick
 36:  bf1932c2f3 <   -:  ---------- rebase -i: fix adding failed command to the todo list
 37:  bd111141aa <   -:  ---------- cocci: add headings to and reword README
 38:  3bd0097cfc <   -:  ---------- cocci: codify authoring and reviewing practices
 39:  62a8a36709 <   -:  ---------- notes.c: cleanup 'strbuf_grow' call in 'append_edit'
 40:  39a609ec6c <   -:  ---------- notes.c: use designated initializers for clarity
 41:  e9a0a06d38 <   -:  ---------- t3321: add test cases about the notes stripspace behavior
 42:  3993a53a13 <   -:  ---------- notes.c: introduce '--separator=<paragraph-break>' option
 43:  ad3d1f8feb <   -:  ---------- notes.c: append separator instead of insert by pos
 44:  aa382bf677 <   -:  ---------- notes.c: introduce "--[no-]stripspace" option
 45:  8e9a6aa3f7 <   -:  ---------- sequencer: beautify subject of reverts of reverts
 46:  9d484b92ed <   -:  ---------- diff: fix interaction between the "-s" option and other options
 47:  fe90355361 <   -:  ---------- object: add object_array initializer helper function
 48:  47ff853f02 <   -:  ---------- pack-bitmap.c: extract `fill_in_bitmap()`
 49:  b0afdce5da <   -:  ---------- pack-bitmap.c: use commit boundary during bitmap traversal
 50:  6ba979b352 <   -:  ---------- t6429: remove switching aspects of fast-rebase
 51:  cd85a8aab3 <   -:  ---------- replay: introduce new builtin
 52:  ff6b4688a7 <   -:  ---------- replay: start using parse_options API
 53:  d1e55ff4ab <   -:  ---------- replay: die() instead of failing assert()
 54:  93461549f2 <   -:  ---------- replay: introduce pick_regular_commit()
 55:  1bf61baa21 <   -:  ---------- replay: don't simplify history
 56:  317ac15b14 <   -:  ---------- replay: add an important FIXME comment about gpg signing
 57:  a195c920d9 <   -:  ---------- replay: remove progress and info output
 58:  20e96266a5 <   -:  ---------- replay: remove HEAD related sanity check
 59:  acf68154a0 <   -:  ---------- replay: make it a minimal server side command
 60:  e02064abfc <   -:  ---------- replay: use standard revision ranges
 61:  33296b563c <   -:  ---------- replay: disallow revision specific options and pathspecs
 62:  e436c4e38f <   -:  ---------- replay: add --advance or 'cherry-pick' mode
 63:  657ce1ace6 <   -:  ---------- replay: add --contained to rebase contained branches
 64:  145695cc72 <   -:  ---------- replay: stop assuming replayed branches do not diverge
 65:  b37a7d7a8a <   -:  ---------- SQUASH???
 66:  ec664ab737 <   -:  ---------- cat-file: quote-format name in error when using -z
 67:  982ff2c961 <   -:  ---------- object tests: add test for unexpected objects in tags
 68:  d5afcaa611 <   -:  ---------- tag: don't misreport type of tagged objects in errors
 69:  cdc90612fd <   -:  ---------- tag: don't emit potentially incorrect "object is a X, not a Y"
 70:  b745672f8d <   -:  ---------- doc: trailer: fix grammar
 71:  354fc9157c <   -:  ---------- doc: trailer: swap verb order
 72:  267aea4472 <   -:  ---------- doc: trailer: drop "commit message part" phrasing
 73:  2d75fde295 <   -:  ---------- doc: trailer: examples: avoid the word "message" by itself
 74:  e2087e448a <   -:  ---------- doc: trailer: remove redundant phrasing
 75:  479d93ea37 <   -:  ---------- doc: trailer: use angle brackets for <token> and <value>
 76:  4361055f15 <   -:  ---------- doc: trailer.<token>.command: emphasize deprecation
 77:  4fc3593f55 <   -:  ---------- doc: trailer: mention 'key' in DESCRIPTION
 78:  05d3be026d <   -:  ---------- doc: trailer: add more examples in DESCRIPTION
 79:  d0ca92a7fe <   -:  ---------- strbuf: clarify API boundary
 80:  689ece6602 <   -:  ---------- abspath: move related functions to abspath
 81:  eaec86fb92 <   -:  ---------- credential-store: move related functions to credential-store file
 82:  d1272d1469 <   -:  ---------- object-name: move related functions to object-name
 83:  9a5bb4efa0 <   -:  ---------- path: move related function to path
 84:  88da41d9ff <   -:  ---------- strbuf: clarify dependency
 85:  6897be8f14 <   -:  ---------- strbuf: remove global variable
 86:  283174b214 <   -:  ---------- docs: clarify git-pack-refs --all will pack all refs
 87:  826ae79fca <   -:  ---------- pack-refs: teach --exclude option to exclude refs from being packed
 88:  4fe42f326e <   -:  ---------- pack-refs: teach pack-refs --include option
 89:  836ada9931 <   -:  ---------- refs.c: rename `ref_filter`
 90:  ccd9c98044 <   -:  ---------- ref-filter.h: provide `REF_FILTER_INIT`
 91:  25d2495e4a <   -:  ---------- ref-filter: clear reachable list pointers after freeing
 92:  b10cd5c909 <   -:  ---------- ref-filter: add `ref_filter_clear()`
 93:  d3e45e84fd <   -:  ---------- ref-filter.c: parameterize match functions over patterns
 94:  389f8c1827 <   -:  ---------- builtin/for-each-ref.c: add `--exclude` option
 95:  60ccf68ae5 <   -:  ---------- refs: plumb `exclude_patterns` argument throughout
 96:  c5950cfc7b <   -:  ---------- refs/packed-backend.c: refactor `find_reference_location()`
 97:  d2be75e8d2 <   -:  ---------- refs/packed-backend.c: implement jump lists to avoid excluded pattern(s)
 98:  9a66abb6ce <   -:  ---------- refs/packed-backend.c: add trace2 counters for jump list
 99:  54b1444a51 <   -:  ---------- revision.h: store hidden refs in a `strvec`
100:  fe10c7fe7a <   -:  ---------- refs/packed-backend.c: ignore complicated hidden refs rules
101:  3df995b8c5 <   -:  ---------- refs.h: let `for_each_namespaced_ref()` take excluded patterns
102:  c41619ccdc <   -:  ---------- builtin/receive-pack.c: avoid enumerating hidden references
103:  fb22f5bcea <   -:  ---------- upload-pack.c: avoid enumerating hidden refs where possible
104:  bd3fabf816 <   -:  ---------- ls-refs.c: avoid enumerating hidden refs where possible
105:  342e04e6fd <   -:  ---------- reachable.c: extract `obj_is_recent()`
106:  8b19941a02 <   -:  ---------- gc: introduce `gc.recentObjectsHook`
107:  955ee54d92 <   -:  ---------- init-db: document existing bug with core.bare in template config
108:  d404ac1027 <   -:  ---------- init-db: remove unnecessary global variable
109:  0a76a5fb02 <   -:  ---------- init-db, clone: change unnecessary global into passed parameter
110:  3f85c72fad <   -:  ---------- setup: adopt shared init-db & clone code
111:  4956a5ec86 <   -:  ---------- read-cache: move shared commit and ls-files code
112:  c862a92083 <   -:  ---------- add: modify add_files_to_cache() to avoid globals
113:  eb6220a10a <   -:  ---------- read-cache: move shared add/checkout/commit code
114:  b5ee0a2bf4 <   -:  ---------- statinfo: move stat_{data,validity} functions from cache/read-cache
115:  ccdfc96750 <   -:  ---------- run-command.h: move declarations for run-command.c from cache.h
116:  74eab62313 <   -:  ---------- name-hash.h: move declarations for name-hash.c from cache.h
117:  8ccc457fff <   -:  ---------- sparse-index.h: move declarations for sparse-index.c from cache.h
118:  e1f4132af8 <   -:  ---------- preload-index.h: move declarations for preload-index.c from elsewhere
119:  cea0ce693d <   -:  ---------- diff.h: move declaration for global in diff.c from cache.h
120:  e114585b13 <   -:  ---------- merge.h: move declarations for merge.c from cache.h
121:  dc45fab4e7 <   -:  ---------- repository.h: move declaration of the_index from cache.h
122:  433097258d <   -:  ---------- read-cache*.h: move declarations for read-cache.c functions from cache.h
123:  4275a22e16 <   -:  ---------- cache.h: remove this no-longer-used header
124:  e1fcb3a534 <   -:  ---------- log-tree: replace include of revision.h with simple forward declaration
125:  f6a61d3055 <   -:  ---------- repository: remove unnecessary include of path.h
126:  4666f5120d <   -:  ---------- diff.h: remove unnecessary include of oidset.h
127:  5e67baddca <   -:  ---------- list-objects-filter-options.h: remove unneccessary include
128:  64667610fc <   -:  ---------- builtin.h: remove unneccessary includes
129:  19c8e8012b <   -:  ---------- git-compat-util.h: remove unneccessary include of wildmatch.h
130:  50b5ecfaf0 <   -:  ---------- merge-ll: rename from ll-merge
131:  aaf326e1cd <   -:  ---------- khash: name the structs that khash declares
132:  52c6131caa <   -:  ---------- object-store-ll.h: split this header out of object-store.h
133:  25547a5791 <   -:  ---------- hash-ll, hashmap: move oidhash() to hash-ll
134:  d677f7e76a <   -:  ---------- fsmonitor-ll.h: split this header out of fsmonitor.h
135:  719515fdd0 <   -:  ---------- doc: tag: document `TAG_EDITMSG`
136:  669c11de85 <   -:  ---------- t/t7004-tag: add regression test for successful tag creation
137:  08c12ec1d0 <   -:  ---------- tag: keep the message file in case ref transaction fails
138:  2372aa4195 <   -:  ---------- credential/libsecret: store new attributes
139:  a40449bcd4 <   -:  ---------- fetch: drop unused DISPLAY_FORMAT_UNKNOWN enum value
140:  6bc7a37e79 <   -:  ---------- fetch: drop unneeded NULL-check for `remote_ref`
141:  d1adf85b0a <   -:  ---------- fetch: pass through `fetch_config` directly
142:  b779a25e05 <   -:  ---------- fetch: use `fetch_config` to store "fetch.prune" value
143:  2b472cfeac <   -:  ---------- fetch: use `fetch_config` to store "fetch.pruneTags" value
144:  ba28b2ca5d <   -:  ---------- fetch: use `fetch_config` to store "fetch.showForcedUpdates" value
145:  56e8bb4fb4 <   -:  ---------- fetch: use `fetch_config` to store "fetch.recurseSubmodules" value
146:  ac197cc094 <   -:  ---------- fetch: use `fetch_config` to store "fetch.parallel" value
147:  f7e063f326 <   -:  ---------- fetch: use `fetch_config` to store "submodule.fetchJobs" value
148:  b71f919dda <   -:  ---------- worktree add: include -B in usage docs
149:  1b28fbd218 <   -:  ---------- t2400: cleanup created worktree in test
150:  ed6db0e9ff <   -:  ---------- t2400: refactor "worktree add" opt exclusion tests
151:  9ccdace1e8 <   -:  ---------- t2400: add tests to verify --quiet
152:  7ab8918985 <   -:  ---------- worktree add: add --orphan flag
153:  35f0383ca6 <   -:  ---------- worktree add: introduce "try --orphan" hint
154:  128e5496b3 <   -:  ---------- worktree add: extend DWIM to infer --orphan
155:  926c40d04b <   -:  ---------- worktree add: emit warn when there is a bad HEAD
156:  48c5fbfb89 <   -:  ---------- diff-tree: integrate with sparse index
157:  cfa120947e <   -:  ---------- format-patch: free rev.message_id when exiting
158:  00bf685975 <   -:  ---------- show-ref doc: update for internal consistency
159:  0f45b5bc32 <   -:  ---------- show-branch doc: say <ref>, not <reference>
160:  21c9bac2c7 <   -:  ---------- ls-remote doc: remove redundant --tags example
161:  e959fa452f <   -:  ---------- ls-remote doc: show peeled tags in examples
162:  a5b076321a <   -:  ---------- ls-remote doc: explain what each example does
163:  51f9d2e563 <   -:  ---------- ls-remote doc: document the output format
164:  c6d26a9dda <   -:  ---------- format-patch: free elements of rev.ref_message_ids list
165:  2f68c99a3b <   -:  ---------- t0000-basic: modernize test format
166:  27990663f0 <   -:  ---------- t0030-stripspace: modernize test format
167:  3c2f5d26c0 <   -:  ---------- t3210-pack-refs: modernize test format
168:  58db6e450b <   -:  ---------- t1001-read-tree-m-2way: modernize test format
169:  a10bb2ded5 <   -:  ---------- t1002-read-tree-m-u-2way: modernize test format
170:  350c484239 <   -:  ---------- t1006-cat-file: modernize test format
171:  0a6cb5c42f <   -:  ---------- t3500-cherry: modernize test format
172:  0aa0266c4b <   -:  ---------- t3700-add: modernize test format
173:  a8fcc0ac89 <   -:  ---------- t3903-stash: modernize test format
174:  9cfcbcc095 <   -:  ---------- t4002-diff-basic: modernize test format
175:  9297229d15 <   -:  ---------- t4003-diff-rename-1: modernize test format
176:  93fc423e9a <   -:  ---------- t4004-diff-rename-symlink: modernize test format
177:  3da9be913a <   -:  ---------- t4202-log: modernize test format
178:  1afebc92ef <   -:  ---------- t4206-log-follow-harder-copies: modernize test format
179:  e478a52087 <   -:  ---------- t5300-pack-object: modernize test format
180:  cc0c1ad9ad <   -:  ---------- t5301-sliding-window: modernize test format
181:  aac864059f <   -:  ---------- t5303-pack-corruption-resilience: modernize test format
182:  a45bb750db <   -:  ---------- t5306-pack-nobase: modernize test format
183:  32942346aa <   -:  ---------- t6050-replace: modernize test format
184:  3b8724bce6 <   -:  ---------- t7101-reset-empty-subdirs: modernize test format
185:  a32a724b03 <   -:  ---------- t7110-reset-merge: modernize test format
186:  c970681f50 <   -:  ---------- t7111-reset-table: modernize test format
187:  10dae78533 <   -:  ---------- t7201-co: modernize test format
188:  a6171e1478 <   -:  ---------- t7508-status: modernize test format
189:  bd48dfad69 <   -:  ---------- t7600-merge: modernize test format
190:  3a3b98be91 <   -:  ---------- t7700-repack: modernize test format
191:  be1fce6dae <   -:  ---------- t9100-git-svn-basic: modernize test format
192:  7d7097bf59 <   -:  ---------- t9104-git-svn-follow-parent: modernize test format
193:  7dac6347c5 <   -:  ---------- t9200-git-cvsexportcommit: modernize test format
194:  447a3b7331 <   -:  ---------- t9400-git-cvsserver-server: modernize test format
195:  bc11bac329 <   -:  ---------- revisions.txt: use description list for special refs
196:  6ec5f46071 <   -:  ---------- revisions.txt: document more special refs
197:  1ef3c61b78 <   -:  ---------- completion: complete REVERT_HEAD and BISECT_HEAD
198:  b7dd54a2c7 <   -:  ---------- git-merge.txt: modernize word choice in "True merge" section
199:  4fa1edb988 <   -:  ---------- Documentation: document AUTO_MERGE
200:  982ff3a649 <   -:  ---------- completion: complete AUTO_MERGE
201:  3a5d53d3c0 <   -:  ---------- t4216: test wrong bloom filter version rejection
202:  5a91f9682b <   -:  ---------- commit-graph: fix murmur3, bump filter ver. to 2
203:  3d3906ce28 <   -:  ---------- ### match next
204:  9d9c164d7e <   -:  ---------- cherry-pick: refuse cherry-pick sequence if index is dirty
205:  d091928b02 <   -:  ---------- ls-files: aligin format atoms wtih ls-tree
206:  a2b7a28e6e !   1:  d352eae308 strbuf.h: move declarations for strbuf.c functions from git-compat-util.h
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    strbuf.h: move declarations for strbuf.c functions from git-compat-util.h
    +    git-compat-util: move strbuf.c funcs to its header
     
         While functions like starts_with() probably should not belong in the
         boundaries of the strbuf library, this commit focuses on first splitting
207:  b12fb0e2ff !   2:  fe4fd6f92a wrapper.h: move declarations for wrapper.c functions from git-compat-util.h
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    wrapper.h: move declarations for wrapper.c functions from git-compat-util.h
    +    git-compat-util: move wrapper.c funcs to its header
     
         Since the functions in wrapper.c are widely used across the codebase,
         include it by default in git-compat-util.h. A future patch will remove
208:  016f671836 !   3:  ec7ea12f7c sane-ctype.h: move sane-ctype macros from git-compat-util.h
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    sane-ctype.h: move sane-ctype macros from git-compat-util.h
    +    sane-ctype.h: create header for sane-ctype macros
     
         Splitting these macros from git-compat-util.h cleans up the file and
         allows future third-party sources to not use these overrides if they do
    @@ Commit message
     
      ## git-compat-util.h ##
     @@ git-compat-util.h: static inline size_t xsize_t(off_t len)
    - #define HOST_NAME_MAX 256
    - #endif
    + /* in ctype.c, for kwset users */
    + extern const unsigned char tolower_trans_tbl[256];
      
    --/* in ctype.c, for kwset users */
    --extern const unsigned char tolower_trans_tbl[256];
    --
     -/* Sane ctype - no locale, and works with signed chars */
     -#undef isascii
     -#undef isspace
    @@ sane-ctype.h (new)
     +#ifndef SANE_CTYPE_H
     +#define SANE_CTYPE_H
     +
    -+/* in ctype.c, for kwset users */
    -+extern const unsigned char tolower_trans_tbl[256];
    -+
     +/* Sane ctype - no locale, and works with signed chars */
     +#undef isascii
     +#undef isspace
  -:  ---------- >   4:  4f95b4121e kwset: move translation table from ctype
209:  244650e5c9 !   5:  36525e39d5 common.h: move non-compat specific macros and functions from git-compat-util.h
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    common.h: move non-compat specific macros and functions from git-compat-util.h
    +    common.h: move non-compat specific macros and functions
     
         git-compat-util.h has grown to a large and difficult to read file partly
         because its set of functionality is overloaded. Besides being a
210:  91a1253ee6 !   6:  21f0f31ff3 usage.h: move declarations for usage.c functions from git-compat-util.h
    @@ Metadata
     Author: Calvin Wan <calvinwan@google.com>
     
      ## Commit message ##
    -    usage.h: move declarations for usage.c functions from git-compat-util.h
    +    git-compat-util: move usage.c funcs to its header
     
      ## common.h ##
     @@
211:  c9850a7c18 =   7:  531db31c5c treewide: remove unnecessary includes for wrapper.h
212:  067b28ec09 !   8:  98694f7add common: move alloc macros to common.h
    @@ strbuf.c
     -#include "alloc.h"
      #include "gettext.h"
      #include "hex.h"
    - #include "path.h"
    + #include "strbuf.h"
     
      ## string-list.c ##
     @@
-- 
2.41.0.rc2.161.g9c6817b8e7-goog

