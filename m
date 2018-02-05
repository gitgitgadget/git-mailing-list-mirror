Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 69BC81F404
	for <e@80x24.org>; Mon,  5 Feb 2018 23:55:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752009AbeBEXzf (ORCPT <rfc822;e@80x24.org>);
        Mon, 5 Feb 2018 18:55:35 -0500
Received: from mail-pg0-f48.google.com ([74.125.83.48]:45134 "EHLO
        mail-pg0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750903AbeBEXzc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Feb 2018 18:55:32 -0500
Received: by mail-pg0-f48.google.com with SMTP id m136so95520pga.12
        for <git@vger.kernel.org>; Mon, 05 Feb 2018 15:55:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=YFQNKNYnCtxhTC4DkzWXouFAFe8cO9upptrdtj+/xDg=;
        b=JH8hWDwiu10iIbpzsV91+bGFr2e1LLYL2Fq2leGS3bL2BwgOp0KMTuXjSGC7qx2QbV
         N6DUMTuXZvuMuWvEydmQKP2gAduUBALwfcQhYMRvpWBJLiRM754PAfPHdYEyUJDuLvLZ
         g21OE2eKAp4snriQhAImbtfLcdNpwXQcFm2ls8scFOHEioAaAK628UdbfzurFGzf5dFx
         lqJPQHSsh03f0EJPgWer5hbE+UMRo6kquO9W0Iqmxq8jV9cdJ0gdF/s+hxAvEhvXsEAs
         nP8xSx2fdfSCKf8yDwUkTjoUYqUF631m2b0r7KPULD9y1LU+mkmLRiaXU3oQDqU6JhU6
         Uz4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=YFQNKNYnCtxhTC4DkzWXouFAFe8cO9upptrdtj+/xDg=;
        b=QVQ1zUkf4k7YUoVwPpN9HdEvRtsm1GpQ7t9OUDwi5xyCSLh2NqmI9vIPg92a5Kix9+
         EcBWF0JL51reD/tuKUOio9vxcY4xJ2LzQJbPaCpo/d9VIdq7c6EZ+53WxFiCXQEFeV4o
         2LKKtxKXzY5m43HfuqXRRRljOl8gJKh7l3jJyDIy+RrANpAQ61zofaggd4Tr1eT5Ohr8
         hKuQEL0C2/07Ny9bhLWOyCUMNb7DvxWbYIFPo4x5HNQz4G1Bew3mhrAfEaUNOc+V8Awt
         ZHguhSIJV1yFrrqWkUr2Pt3PXQXlzxb1S29NfLuPysiQGs9w7LSz0XwPcDGFqk/Qd55y
         AzaQ==
X-Gm-Message-State: APf1xPBbNWfbWItadMkeY2+l7mdimRcMgC4JBwJ3I1VNt6Dug4omllT4
        Xp3GcYreLKhuzsKYDGEXecvZnxs3lPs=
X-Google-Smtp-Source: AH8x226R1X4XlSM8wZhBbqePHTByxqOXwS1UIkcY87fyQclSqB56cJt4ZvmDSm3KbQ5uC/E34qfJ0w==
X-Received: by 10.99.184.25 with SMTP id p25mr402079pge.96.1517874930718;
        Mon, 05 Feb 2018 15:55:30 -0800 (PST)
Received: from localhost ([2620:0:100e:422:2d12:5719:3437:fdb7])
        by smtp.gmail.com with ESMTPSA id p4sm15547932pgn.81.2018.02.05.15.55.29
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 05 Feb 2018 15:55:30 -0800 (PST)
From:   Stefan Beller <sbeller@google.com>
To:     git@vger.kernel.org
Cc:     Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 000/194] Moving global state into the repository object
Date:   Mon,  5 Feb 2018 15:51:54 -0800
Message-Id: <20180205235508.216277-1-sbeller@google.com>
X-Mailer: git-send-email 2.15.1.433.g936d1b9894.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This series moves a lot of global state into the repository struct.
It applies on top of 2512f15446149235156528dafbe75930c712b29e (2.16.0)
It can be found at https://github.com/stefanbeller/git/tree/object-store

Motivation for this series:
* Easier to reason about code when all state is stored in one place,
  for example for multithreading
* Easier to move to processing submodules in-process instead of
  calling a processes for the submodule handling.
  The last patch demonstrates this.

Usually when approaching large refactoring series, a lot of tedious review
work is involved and yet it is hard to be convinced the series did everything
right.

When reviewing this series in particular it is hard to be convinced if
any function that is converted to take the repository as an argument
is fully converted or if there are any hidden dependencies that are not
obvious from code review.

This is why this series tries to be reviewer friendly by utilizing
machine assistance as much as possible. There are 3 types of patches
in this series:

(A) <area>: add repository argument to <function_foo>
  This sort of patch is just adding the repository as an argument to that
  function. It assumes the given repository is `the_repository` and has
  a compile time check for that assertion using a preprocessor trick.
  As did a compile check after each commit of the series, I don't expect
  the review burden on these patches to be high. Review on these patches
  is mostly checking for formatting errors or if I sneak in malicious
  code -- if you're inclined to believe that.

(B) <area>: allow <function_foo> to handle arbitrary repositories
  This sort of patch is touching code inside the given function only,
  usually replacing all occurrences of `the_repository` by the argument
  `r`. Here the review is critical: Did I miss any function that relies
  on state of `the_repository` ?
  This series was developed by converting all functions of
  packfile/sha1-file/commit/etc using (A); after the demo patch
  was possible, all patches that did (A), but not (B) were deleted.
  Therefore I was confident at time of writing that patch that
  the conversion of a function which doesn't take a repository argument
  is okay.

(C) other patches, such as moving code around,
    demoing this series in the last patch

This approach was chosen as I think it is review friendly, despite the
huge number of patches.

A weakness of this approach is the buildup of a large series, which ignores
the ongoing development. Rebasing that series turned out to be ok, but merging
it with confidence is an issue.

This series was developed partially as a pair programming exercise with
Jonathan Nieder and Brandon Williams.

The idea with the #define trick to separate the two very separate issues
of touching a lot of code and reasoning about its correctness (hidden deps)
is mostly from Jonathan Tan.

Any suggestions welcome!

Thanks,
Stefan

Brandon Williams (4):
  sha1_file: allow add_to_alternates_file to handle arbitrary
    repositories
  commit: convert commit_graft_pos() to handle arbitrary repositories
  commit: convert register_commit_graft to handle arbitrary repositories
  commit: convert read_graft_file to handle arbitrary repositories

Jonathan Nieder (50):
  object-store: move packed_git and packed_git_mru to object store
  pack: move prepare_packed_git_run_once to object store
  pack: move approximate object count to object store
  pack: add repository argument to install_packed_git
  pack: add repository argument to prepare_packed_git_one
  pack: add repository argument to rearrange_packed_git
  pack: add repository argument to prepare_packed_git_mru
  pack: add repository argument to prepare_packed_git
  pack: add repository argument to reprepare_packed_git
  pack: add repository argument to sha1_file_name
  pack: add repository argument to map_sha1_file
  sha1_file: allow alt_odb_usable to handle arbitrary repositories
  pack: allow install_packed_git to handle arbitrary repositories
  pack: allow rearrange_packed_git to handle arbitrary repositories
  pack: allow prepare_packed_git_mru to handle arbitrary repositories
  pack: allow prepare_packed_git_one to handle arbitrary repositories
  pack: allow prepare_packed_git to handle arbitrary repositories
  pack: allow reprepare_packed_git to handle arbitrary repositories
  pack: allow sha1_file_name to handle arbitrary repositories
  pack: allow stat_sha1_file to handle arbitrary repositories
  pack: allow open_sha1_file to handle arbitrary repositories
  pack: allow map_sha1_file_1 to handle arbitrary repositories
  pack: allow map_sha1_file to handle arbitrary repositories
  pack: allow sha1_loose_object_info to handle arbitrary repositories
  sha1_file: add repository argument to sha1_object_info_extended
  object-store: move alternates API to new alternates.h
  object-store: move loose object functions to new loose-object.h
  pack: move struct pack_window and pack_entry to packfile.h
  object-store: move replace_objects back to object-store
  object-store: move lookup_replace_object to replace-object.h
  pack: add repository argument to packed_object_info
  pack: add repository argument to find_pack_entry
  object: add repository argument to lookup_object
  object: add repository argument to grow_object_hash
  object: add repository argument to lookup_commit_reference_gently
  object: add repository argument to lookup_commit
  object: move grafts to object parser
  object: add repository argument to commit_graft_pos
  object: add repository argument to register_commit_graft
  object: add repository argument to read_graft_file
  object: add repository argument to prepare_commit_graft
  object: add repository argument to lookup_commit_graft
  object: add repository argument to lookup_unknown_object
  Rename sha1_object_info.cocci to object_store.cocci
  alternates: add repository argument to add_to_alternates_memory
  object-store: move check_sha1_signature to object-store.h
  object-store: add repository argument to check_sha1_signature
  object-store: add repository argument to read_object
  object-store: add repository argument to read_sha1_file_extended
  object: move read_object_with_reference to object.h

Stefan Beller (140):
  repository: introduce object store field
  object-store: move alt_odb_list and alt_odb_tail to object store
  sha1_file: add repository argument to alt_odb_usable
  sha1_file: add repository argument to link_alt_odb_entry
  sha1_file: add repository argument to read_info_alternates
  sha1_file: add repository argument to link_alt_odb_entries
  sha1_file: add repository argument to stat_sha1_file
  sha1_file: add repository argument to open_sha1_file
  sha1_file: add repository argument to map_sha1_file_1
  sha1_file: add repository argument to sha1_loose_object_info
  object-store: add repository argument to prepare_alt_odb
  object-store: add repository argument to foreach_alt_odb
  object-store: allow prepare_alt_odb to handle arbitrary repositories
  object-store: allow foreach_alt_odb to handle arbitrary repositories
  replace_object.c: rename to use dash in file name
  replace-object: move replace_object to object store
  object-store: move object access functions to object-store.h
  replace-object: add repository argument to do_lookup_replace_object
  replace-object: move replace objects prepared flag to object store
  replace-object: check_replace_refs is safe in multi repo environment
  refs: add repository argument to for_each_replace_ref
  refs: add repository argument to get_main_ref_store
  replace-object: add repository argument to register_replace_object
  replace-object: add repository argument to register_replace_ref
  replace-object: add repository argument to replace_object_pos
  replace-object: allow replace_object_pos to handle arbitrary
    repositories
  replace-object: allow register_replace_object to handle arbitrary
    repositories
  replace-object: add repository argument to prepare_replace_object
  refs: store the main ref store inside the repository struct
  refs: allow for_each_replace_ref to handle arbitrary repositories
  replace-object: allow prepare_replace_object to handle arbitrary
    repositories
  replace_object: allow do_lookup_replace_object to handle arbitrary
    repositories
  replace-object: add repository argument to lookup_replace_object
  repository: allow lookup_replace_object to handle arbitrary
    repositories
  object-store: add repository argument to sha1_object_info
  pack: add repository argument to retry_bad_packed_offset
  pack: add repository argument to packed_to_object_type
  packfile: add repository argument to read_object
  packfile: add repository argument to unpack_entry
  packfile: add repository argument to cache_or_unpack_entry
  pack: allow find_pack_entry to handle arbitrary repositories
  object-store: allow sha1_object_info to handle arbitrary repositories
  fetch, push: do not use submodule as alternate in has_commits check
  push: add test showing bad interaction of replace refs and submodules
  replace_object: allow register_replace_ref to handle arbitrary
    repositories
  cache.h: migrate the definition of object_id to object.h
  repository: introduce object parser field
  object: add repository argument to parse_object
  object: add repository argument to create_object
  blob: add repository argument to lookup_blob
  tree: add repository argument to lookup_tree
  tag: add repository argument to lookup_tag
  tag: add repository argument to parse_tag_buffer
  tag: add repository argument to deref_tag
  object: add repository argument to lookup_commit_reference
  commit: add repository argument to parse_commit_buffer
  object: allow grow_object_hash to handle arbitrary repositories
  object: allow create_object to handle arbitrary repositories
  object: allow lookup_object to handle arbitrary repositories
  object: allow lookup_unknown_object to handle arbitrary repositories
  object: add repository argument to parse_object_buffer
  repository: keep track of all open repositories
  alternates: add repository argument to add_to_alternates_file
  object-store: add repository argument to read_sha1_file
  packfile: add repository argument to has_packed_and_bad
  packfile: allow has_packed_and_bad to handle arbitrary repositories
  streaming: add repository argument to open_istream_fn
  streaming: add repository argument to open_istream
  streaming: add repository argument to istream_source
  streaming: allow istream_source to handle arbitrary repositories
  sha1_file: allow read_object to handle arbitrary repositories
  object-store.h: allow read_sha1_file{_extended} to handle arbitrary
    repositories
  streaming: allow open_istream_incore to handle arbitrary repositories
  streaming: allow open_istream_pack_non_delta to handle arbitrary
    repositories
  streaming: allow open_istream_loose to handle arbitrary repositories
  streaming: allow open_istream to handle arbitrary repositories
  alternates: convert add_to_alternates_memory to handle arbitrary repos
  object: add repository argument to object_as_type
  alloc: add repository argument to alloc_blob_node
  alloc: add repository argument to alloc_tree_node
  alloc: add repository argument to alloc_commit_node
  alloc: add repository argument to alloc_tag_node
  alloc: add repository argument to alloc_object_node
  alloc: add repository argument to alloc_report
  alloc: add repository argument to alloc_commit_index
  alloc: allow arbitrary repositories for alloc functions
  object: allow object_as_type to handle arbitrary repositories
  commit: allow lookup_commit to handle arbitrary repositories
  object: add repository argument to parse_commit_gently
  commit: add repository argument to parse_commit
  commit: add repository argument to set_commit_buffer
  commit: add repository argument to get_cached_commit_buffer
  commit: add repository argument to unuse_commit_buffer
  commit: add repository argument to free_commit_buffer
  commit: allow commit buffer functions to handle arbitrary repositories
  tree: allow lookup_tree to handle arbitrary repositories
  cache: convert get_graft_file to handle arbitrary repositories
  shallow: add repository argument to set_alternate_shallow_file
  shallow: add repository argument to register_shallow
  shallow: add repository argument to check_shallow_file_for_update
  shallow: add repository argument to is_repository_shallow
  migrate cached path to use the_repository
  shallow: migrate shallow information into the object parser
  commit: allow prepare_commit_graft to handle arbitrary repositories
  commit: allow lookup_commit_graft to handle arbitrary repositories
  commit: allow arbitrary repository argument for parse_commit_buffer
  commit: allow parse_commit_gently to handle arbitrary repository
  commit: add repository argument to get_merge_bases_many_0
  commit: add repository argument to merge_bases_many
  commit: add repository argument to paint_down_to_common
  commit: allow parse_commit to handle arbitrary repositories
  commit: allow paint_down_to_common to handle arbitrary repositories
  commit: allow merge_bases_many to handle arbitrary repositories
  commit: add repository argument to remove_redundant
  commit: allow remove_redundant to handle arbitrary repositories
  commit: allow get_merge_bases_many_0 to handle arbitrary repositories
  commit: add repository argument to get_merge_bases
  commit: allow get_merge_bases to handle arbitrary repositories
  blob: allow lookup_blob to handle arbitrary repositories
  tag: allow lookup_tag to handle arbitrary repositories
  tag: allow parse_tag_buffer to handle arbitrary repositories
  object: allow parse_object_buffer to handle arbitrary repositories
  objects: allow check_sha1_signature to handle arbitrary repositories
  object: allow parse_object to handle arbitrary repositories
  tag: allow deref_tag to handle arbitrary repositories
  commit: allow lookup_commit_reference_gently to handle arbitrary
    repositories
  commit: allow lookup_commit_reference to handle arbitrary repositories
  commit: add repository argument to get_commit_buffer
  commit: add repository argument to logmsg_reencode
  pretty: add repository argument to format_commit_message
  commit: allow get_commit_buffer to handle arbitrary repositories
  pretty: allow logmsg_reencode to handle arbitrary repositories
  commit: add repository argument to in_merge_bases_many
  commit: add repository argument to in_merge_bases
  commit: allow in_merge_bases_many to handle arbitrary repositories
  commit: allow in_merge_bases to handle arbitrary repositories
  pretty: allow format_commit_message to handle arbitrary repositories
  submodule: add repository argument to print_submodule_summary
  submodule: Reorder open_submodule function
  submodule: use submodule repos for object lookup

 Makefile                                   |   2 +-
 alloc.c                                    |  48 +++--
 alternates.h                               |  68 +++++++
 apply.c                                    |   8 +-
 archive-tar.c                              |   6 +-
 archive-zip.c                              |   8 +-
 archive.c                                  |   9 +-
 bisect.c                                   |   6 +-
 blame.c                                    |  40 ++--
 blob.c                                     |  10 +-
 blob.h                                     |   2 +-
 branch.c                                   |  16 +-
 builtin/am.c                               |  14 +-
 builtin/blame.c                            |   9 +-
 builtin/branch.c                           |  11 +-
 builtin/cat-file.c                         |  28 ++-
 builtin/checkout.c                         |  12 +-
 builtin/clone.c                            |  14 +-
 builtin/commit-tree.c                      |   5 +-
 builtin/commit.c                           |  63 +++---
 builtin/count-objects.c                    |  12 +-
 builtin/describe.c                         |  19 +-
 builtin/diff-tree.c                        |   9 +-
 builtin/diff.c                             |   7 +-
 builtin/difftool.c                         |   5 +-
 builtin/fast-export.c                      |  30 +--
 builtin/fetch.c                            |  21 +-
 builtin/fmt-merge-msg.c                    |  19 +-
 builtin/fsck.c                             |  44 ++--
 builtin/gc.c                               |   8 +-
 builtin/grep.c                             |  10 +-
 builtin/hash-object.c                      |   1 +
 builtin/index-pack.c                       |  26 ++-
 builtin/log.c                              |  26 ++-
 builtin/ls-files.c                         |   2 +-
 builtin/ls-tree.c                          |   4 +-
 builtin/merge-base.c                       |  11 +-
 builtin/merge-tree.c                       |  12 +-
 builtin/merge.c                            |  41 ++--
 builtin/mktag.c                            |  10 +-
 builtin/mktree.c                           |   4 +-
 builtin/name-rev.c                         |  15 +-
 builtin/notes.c                            |  16 +-
 builtin/pack-objects.c                     |  66 +++---
 builtin/pack-redundant.c                   |   8 +-
 builtin/pack-refs.c                        |   3 +-
 builtin/prune-packed.c                     |   1 +
 builtin/prune.c                            |   8 +-
 builtin/pull.c                             |  19 +-
 builtin/receive-pack.c                     |  14 +-
 builtin/reflog.c                           |  21 +-
 builtin/remote.c                           |   1 +
 builtin/replace.c                          |  24 ++-
 builtin/reset.c                            |  11 +-
 builtin/rev-list.c                         |   7 +-
 builtin/rev-parse.c                        |  11 +-
 builtin/shortlog.c                         |   5 +-
 builtin/show-branch.c                      |   9 +-
 builtin/show-ref.c                         |   1 +
 builtin/submodule--helper.c                |   5 +-
 builtin/tag.c                              |  12 +-
 builtin/unpack-file.c                      |   4 +-
 builtin/unpack-objects.c                   |  15 +-
 builtin/verify-commit.c                    |   7 +-
 bulk-checkin.c                             |   3 +-
 bundle.c                                   |   9 +-
 cache-tree.c                               |   4 +-
 cache.h                                    | 315 ++---------------------------
 combine-diff.c                             |   5 +-
 commit.c                                   | 241 ++++++++++++----------
 commit.h                                   |  49 +++--
 config.c                                   |   2 +-
 contrib/coccinelle/cached_path.cocci       |  44 ++++
 contrib/coccinelle/object_parser.cocci     | 125 ++++++++++++
 contrib/coccinelle/object_store.cocci      |  74 +++++++
 contrib/coccinelle/packed_git.cocci        |  15 ++
 contrib/coccinelle/submodule_reading.cocci |  34 ++++
 convert.c                                  |   1 +
 diff.c                                     |   8 +-
 diffcore-rename.c                          |   1 +
 dir.c                                      |   4 +-
 entry.c                                    |   5 +-
 environment.c                              |  10 +-
 fast-import.c                              |  45 +++--
 fetch-pack.c                               |  47 +++--
 fsck.c                                     |  20 +-
 git.c                                      |   2 +-
 grep.c                                     |   5 +-
 http-backend.c                             |  12 +-
 http-push.c                                |  24 ++-
 http-walker.c                              |   5 +-
 http.c                                     |  10 +-
 line-log.c                                 |   2 +-
 list-objects-filter.c                      |   2 +-
 list-objects.c                             |   4 +-
 log-tree.c                                 |  18 +-
 loose-object.h                             |  91 +++++++++
 mailmap.c                                  |   4 +-
 match-trees.c                              |   6 +-
 merge-blobs.c                              |   8 +-
 merge-recursive.c                          |  30 +--
 mru.h                                      |   1 +
 notes-cache.c                              |   9 +-
 notes-merge.c                              |  15 +-
 notes-utils.c                              |   6 +-
 notes.c                                    |  12 +-
 object-store.h                             | 183 +++++++++++++++++
 object.c                                   | 106 +++++-----
 object.h                                   |  82 +++++++-
 pack-bitmap-write.c                        |   7 +-
 pack-bitmap.c                              |   6 +-
 pack-check.c                               |   6 +-
 pack-revindex.c                            |   1 +
 pack.h                                     |   1 +
 packfile.c                                 | 149 ++++++++------
 packfile.h                                 |  41 +++-
 parse-options-cb.c                         |   2 +-
 path.c                                     |  18 +-
 path.h                                     |  40 +++-
 pretty.c                                   |  24 ++-
 pretty.h                                   |   2 +-
 reachable.c                                |  12 +-
 read-cache.c                               |   7 +-
 ref-filter.c                               |  15 +-
 reflog-walk.c                              |   3 +-
 refs.c                                     |  87 ++++----
 refs.h                                     |   4 +-
 refs/files-backend.c                       |   2 +-
 remote-testsvn.c                           |   6 +-
 remote.c                                   |  27 ++-
 replace_object.c => replace-object.c       |  70 +++----
 replace-object.h                           |  34 ++++
 repository.c                               |  84 ++++++--
 repository.h                               |  33 ++-
 rerere.c                                   |  12 +-
 revision.c                                 |  48 ++---
 send-pack.c                                |   7 +-
 sequencer.c                                |  93 +++++----
 server-info.c                              |  12 +-
 sha1_file.c                                | 236 +++++++++++----------
 sha1_name.c                                |  75 ++++---
 shallow.c                                  | 113 ++++++-----
 streaming.c                                |  33 +--
 streaming.h                                |   2 +-
 submodule-config.c                         |   3 +-
 submodule.c                                | 100 +++++----
 t/helper/test-example-decorate.c           |   6 +-
 t/helper/test-ref-store.c                  |   6 +-
 t/helper/test-revision-walking.c           |   2 +-
 t/t5531-deep-submodule-push.sh             |  16 ++
 tag.c                                      |  36 ++--
 tag.h                                      |   7 +-
 tmp-objdir.c                               |   4 +-
 transport.c                                |   5 +-
 tree-walk.c                                |   5 +-
 tree.c                                     |  24 ++-
 tree.h                                     |   2 +-
 upload-pack.c                              |  25 ++-
 walker.c                                   |  17 +-
 wt-status.c                                |  10 +-
 xdiff-interface.c                          |   4 +-
 161 files changed, 2669 insertions(+), 1596 deletions(-)
 create mode 100644 alternates.h
 create mode 100644 contrib/coccinelle/cached_path.cocci
 create mode 100644 contrib/coccinelle/object_parser.cocci
 create mode 100644 contrib/coccinelle/object_store.cocci
 create mode 100644 contrib/coccinelle/packed_git.cocci
 create mode 100644 contrib/coccinelle/submodule_reading.cocci
 create mode 100644 loose-object.h
 create mode 100644 object-store.h
 rename replace_object.c => replace-object.c (55%)
 create mode 100644 replace-object.h

-- 
2.15.1.433.g936d1b9894.dirty

