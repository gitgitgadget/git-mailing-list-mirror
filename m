Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D8F6C54E8D
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 312FA206F5
	for <git@archiver.kernel.org>; Mon, 11 May 2020 19:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KwEMFO4y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731486AbgEKTqf (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 15:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728283AbgEKTqe (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 May 2020 15:46:34 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71648C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:33 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id n5so5824842wmd.0
        for <git@vger.kernel.org>; Mon, 11 May 2020 12:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=iwWg4a0E7X3Yf8ZQj7CspUI1OjE2LfhsDcyJdfEmUyY=;
        b=KwEMFO4yA2izBP6TKN0QzI5qmdarPCHUI/7Lvwm0znS8HMFQhYfJAj91dAMoFOYN3v
         P/MOAnVUmsAx+WekgI40+/ZYknjIdMiJUjJfjRvohZPinu6xHJyWj+AhDGNi9OeRpPQO
         ofaUV4xRjIK1iIfHLhcn5M5LV7ZmxDLgHS63cwSnK+Xft60CfA0laAF0Mc/4nJ7grwoy
         LLCXm49YtAoxe1CjPdV5p6fprwgxfHMDWF7NfNu484IjtzLZLy72uQQ5MIeMAs5AAOC6
         zyI3BAqzz52iy1ZFkN3b7/EPYdgUpehmuOytGF76cuHxI2jp8SDWHqtETsWesFHq+SKR
         XbVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=iwWg4a0E7X3Yf8ZQj7CspUI1OjE2LfhsDcyJdfEmUyY=;
        b=OvGVT66crDUVxvSZj0xCW/5i3WWKUBM7Ls8dMpcnNbkvEg+HbUboCrWlnrWyJveplj
         eDRPuU3okrJAAukanT09yuz/UiAy8so1IIdbl5Yy8eq0VTsPmMlZf9C3eacyZFR8cOfJ
         V0KUjukMmO/QI8Jh9jmJ2kIEXmFWf/K2/cCuHF8TxtYyI/OoRZ8loUdnTHK8slbRglcM
         SecuyBoeRiUAFDd5PzwUCtdjw4vqFDwOdEEK9zKspphZkimH1ujQkjNh0WUYrdTehG0y
         YJbfGgy/IxNqxK4TSUW8B5dqvGmy8rFgokEG9YUjBP+LCI91tURgN28TNXZ8svDXNVDY
         uxCg==
X-Gm-Message-State: AGi0PuaUlv2bVPq08Pm664xfx1Xp2csuRAZw0xwC8XLI4MX/d4gN8ZWI
        yvQ66x4UAV9MRARu1b+0cuhEGDvR
X-Google-Smtp-Source: APiQypIDzmSVDRJvt90oIjdDcIVbzQkbOB9Y/VsgjViUVBiK083Iz6qrXmPC4dU9LZxph/BYA9SI2g==
X-Received: by 2002:a1c:59c3:: with SMTP id n186mr32232037wmb.24.1589226390348;
        Mon, 11 May 2020 12:46:30 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id g9sm10202761wru.7.2020.05.11.12.46.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 12:46:29 -0700 (PDT)
Message-Id: <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
In-Reply-To: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
From:   "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 11 May 2020 19:46:15 +0000
Subject: [PATCH v13 00/13] Reftable support git-core
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwenn@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This adds the reftable library, and hooks it up as a ref backend.

Includes testing support, to test: make -C t/ GIT_TEST_REFTABLE=1

Summary 19055 tests pass 2765 tests fail

Some issues:

 * many tests inspect .git/{logs,heads}/ directly.
 * worktrees broken. 
 * Rebase/cherry-pick still largely broken

v16

 * handle pseudo refs.
 * various bugfixes and fixes for mem leaks.

Han-Wen Nienhuys (11):
  refs.h: clarify reflog iteration order
  t: use update-ref and show-ref to reading/writing refs
  refs: document how ref_iterator_advance_fn should handle symrefs
  reftable: clarify how empty tables should be written
  reftable: define version 2 of the spec to accomodate SHA256
  Write pseudorefs through ref backends.
  Iterate over the "refs/" namespace in for_each_[raw]ref
  Add .gitattributes for the reftable/ directory
  Add reftable library
  Reftable support for git-core
  Add some reftable testing infrastructure

Johannes Schindelin (1):
  vcxproj: adjust for the reftable changes

Jonathan Nieder (1):
  reftable: file format documentation

 Documentation/Makefile                        |    1 +
 Documentation/technical/reftable.txt          | 1083 ++++++++++++++
 .../technical/repository-version.txt          |    7 +
 Makefile                                      |   27 +-
 builtin/clone.c                               |    3 +-
 builtin/init-db.c                             |   56 +-
 cache.h                                       |    6 +-
 config.mak.uname                              |    2 +-
 contrib/buildsystems/Generators/Vcxproj.pm    |   11 +-
 refs.c                                        |  148 +-
 refs.h                                        |   28 +-
 refs/files-backend.c                          |  164 ++-
 refs/packed-backend.c                         |   40 +-
 refs/refs-internal.h                          |   18 +
 refs/reftable-backend.c                       | 1218 ++++++++++++++++
 reftable/.gitattributes                       |    1 +
 reftable/LICENSE                              |   31 +
 reftable/README.md                            |   11 +
 reftable/VERSION                              |   14 +
 reftable/basics.c                             |  215 +++
 reftable/basics.h                             |   53 +
 reftable/block.c                              |  434 ++++++
 reftable/block.h                              |  129 ++
 reftable/constants.h                          |   21 +
 reftable/file.c                               |   99 ++
 reftable/iter.c                               |  240 ++++
 reftable/iter.h                               |   63 +
 reftable/merged.c                             |  325 +++++
 reftable/merged.h                             |   38 +
 reftable/pq.c                                 |  114 ++
 reftable/pq.h                                 |   34 +
 reftable/reader.c                             |  753 ++++++++++
 reftable/reader.h                             |   65 +
 reftable/record.c                             | 1141 +++++++++++++++
 reftable/record.h                             |  121 ++
 reftable/refname.c                            |  215 +++
 reftable/refname.h                            |   38 +
 reftable/reftable.c                           |   91 ++
 reftable/reftable.h                           |  564 ++++++++
 reftable/slice.c                              |  225 +++
 reftable/slice.h                              |   76 +
 reftable/stack.c                              | 1245 +++++++++++++++++
 reftable/stack.h                              |   48 +
 reftable/system.h                             |   54 +
 reftable/tree.c                               |   67 +
 reftable/tree.h                               |   34 +
 reftable/update.sh                            |   24 +
 reftable/writer.c                             |  665 +++++++++
 reftable/writer.h                             |   60 +
 reftable/zlib-compat.c                        |   92 ++
 repository.c                                  |    2 +
 repository.h                                  |    3 +
 setup.c                                       |   12 +-
 t/t0002-gitfile.sh                            |    2 +-
 t/t0031-reftable.sh                           |  120 ++
 t/t1400-update-ref.sh                         |   32 +-
 t/t1409-avoid-packing-refs.sh                 |    6 +
 t/t1506-rev-parse-diagnosis.sh                |    2 +-
 t/t3210-pack-refs.sh                          |    6 +
 t/t6050-replace.sh                            |    2 +-
 t/t9020-remote-svn.sh                         |    4 +-
 t/test-lib.sh                                 |    5 +
 62 files changed, 10201 insertions(+), 207 deletions(-)
 create mode 100644 Documentation/technical/reftable.txt
 create mode 100644 refs/reftable-backend.c
 create mode 100644 reftable/.gitattributes
 create mode 100644 reftable/LICENSE
 create mode 100644 reftable/README.md
 create mode 100644 reftable/VERSION
 create mode 100644 reftable/basics.c
 create mode 100644 reftable/basics.h
 create mode 100644 reftable/block.c
 create mode 100644 reftable/block.h
 create mode 100644 reftable/constants.h
 create mode 100644 reftable/file.c
 create mode 100644 reftable/iter.c
 create mode 100644 reftable/iter.h
 create mode 100644 reftable/merged.c
 create mode 100644 reftable/merged.h
 create mode 100644 reftable/pq.c
 create mode 100644 reftable/pq.h
 create mode 100644 reftable/reader.c
 create mode 100644 reftable/reader.h
 create mode 100644 reftable/record.c
 create mode 100644 reftable/record.h
 create mode 100644 reftable/refname.c
 create mode 100644 reftable/refname.h
 create mode 100644 reftable/reftable.c
 create mode 100644 reftable/reftable.h
 create mode 100644 reftable/slice.c
 create mode 100644 reftable/slice.h
 create mode 100644 reftable/stack.c
 create mode 100644 reftable/stack.h
 create mode 100644 reftable/system.h
 create mode 100644 reftable/tree.c
 create mode 100644 reftable/tree.h
 create mode 100755 reftable/update.sh
 create mode 100644 reftable/writer.c
 create mode 100644 reftable/writer.h
 create mode 100644 reftable/zlib-compat.c
 create mode 100755 t/t0031-reftable.sh


base-commit: b994622632154fc3b17fb40a38819ad954a5fb88
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-539%2Fhanwen%2Freftable-v13
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-539/hanwen/reftable-v13
Pull-Request: https://github.com/gitgitgadget/git/pull/539

Range-diff vs v12:

  1:  dfa5fd74f85 !  1:  8394c156eb4 refs.h: clarify reflog iteration order
     @@ refs.h: int delete_refs(const char *msg, struct string_list *refnames,
       int delete_reflog(const char *refname);
       
      -/* iterate over reflog entries */
     -+/* Iterate over reflog entries. */
     ++/* Callback to process a reflog entry found by the iteration functions (see
     ++ * below) */
       typedef int each_reflog_ent_fn(
       		struct object_id *old_oid, struct object_id *new_oid,
       		const char *committer, timestamp_t timestamp,
       		int tz, const char *msg, void *cb_data);
       
     -+/* Iterate in over reflog entries, oldest entry first. */
     ++/* Iterate in over reflog entries in the log for `refname`. */
     ++
     ++/* oldest entry first */
       int refs_for_each_reflog_ent(struct ref_store *refs, const char *refname,
       			     each_reflog_ent_fn fn, void *cb_data);
     ++
     ++/* youngest entry first */
       int refs_for_each_reflog_ent_reverse(struct ref_store *refs,
       				     const char *refname,
       				     each_reflog_ent_fn fn,
       				     void *cb_data);
      +
     -+/* Call a function for each reflog entry, oldest entry first. */
     ++/* Call a function for each reflog entry in the log for `refname`. */
     ++
     ++/* oldest entry first */
       int for_each_reflog_ent(const char *refname, each_reflog_ent_fn fn, void *cb_data);
     ++
     ++/* youngest entry first */
       int for_each_reflog_ent_reverse(const char *refname, each_reflog_ent_fn fn, void *cb_data);
       
     + /*
 11:  2abcbd1af99 =  2:  dbf45fe8753 t: use update-ref and show-ref to reading/writing refs
  3:  6553285043b =  3:  be083a85fb5 refs: document how ref_iterator_advance_fn should handle symrefs
  5:  06fcb49e903 !  4:  96fd9814a67 reftable: file format documentation
     @@ Documentation/technical/reftable.txt (new)
      +
      +Some repositories contain a lot of references (e.g. android at 866k,
      +rails at 31k). The existing packed-refs format takes up a lot of space
     -+(e.g. 62M), and does not scale with additional references. Lookup of a
     ++(e.g. 62M), and does not scale with additional references. Lookup of a
      +single reference requires linearly scanning the file.
      +
      +Atomic pushes modifying multiple references require copying the entire
      +packed-refs file, which can be a considerable amount of data moved
     -+(e.g. 62M in, 62M out) for even small transactions (2 refs modified).
     ++(e.g. 62M in, 62M out) for even small transactions (2 refs modified).
      +
      +Repositories with many loose references occupy a large number of disk
      +blocks from the local file system, as each reference is its own file
     @@ Documentation/technical/reftable.txt (new)
      +Performance
      +^^^^^^^^^^^
      +
     -+Space used, packed-refs vs. reftable:
     ++Space used, packed-refs vs. reftable:
      +
      +[cols=",>,>,>,>,>",options="header",]
      +|===============================================================
     @@ Documentation/technical/reftable.txt (new)
      +|reftable |hot | |20.2 usec |320.8 usec
      +|=========================================================
      +
     -+Space used for 149,932 log entries for 43,061 refs, reflog vs. reftable:
     ++Space used for 149,932 log entries for 43,061 refs, reflog vs. reftable:
      +
      +[cols=",>,>",options="header",]
      +|================================
     @@ Documentation/technical/reftable.txt (new)
      +index] to support fast lookup. Readers must be able to read both aligned
      +and non-aligned files.
      +
     -+Very small files (e.g. 1 only ref block) may omit `padding` and the ref
     ++Very small files (e.g. a single ref block) may omit `padding` and the ref
      +index to reduce total file size.
      +
      +Header
     @@ Documentation/technical/reftable.txt (new)
      +
      +The index may be organized into a multi-level index, where the 1st level
      +index block points to additional ref index blocks (2nd level), which may
     -+in turn point to either additional index blocks (e.g. 3rd level) or ref
     ++in turn point to either additional index blocks (e.g. 3rd level) or ref
      +blocks (leaf level). Disk reads required to access a ref go up with
      +higher index levels. Multi-level indexes may be required to ensure no
      +single index block exceeds the file format’s max block size of
     @@ Documentation/technical/reftable.txt (new)
      +
      +The first `position_delta` is the position from the start of the file.
      +Additional `position_delta` entries are sorted ascending and relative to
     -+the prior entry, e.g. a reader would perform:
     ++the prior entry, e.g. a reader would perform:
      +
      +....
      +pos = position_delta[0]
     @@ Documentation/technical/reftable.txt (new)
      +    uint32( CRC-32 of above )
      +....
      +
     -+If a section is missing (e.g. ref index) the corresponding position
     ++If a section is missing (e.g. ref index) the corresponding position
      +field (e.g. `ref_index_position`) will be 0.
      +
      +* `obj_position`: byte position for the first obj block.
     @@ Documentation/technical/reftable.txt (new)
      +Low overhead
      +^^^^^^^^^^^^
      +
     -+A reftable with very few references (e.g. git.git with 5 heads) is 269
     -+bytes for reftable, vs. 332 bytes for packed-refs. This supports
     ++A reftable with very few references (e.g. git.git with 5 heads) is 269
     ++bytes for reftable, vs. 332 bytes for packed-refs. This supports
      +reftable scaling down for transaction logs (below).
      +
      +Block size
     @@ Documentation/technical/reftable.txt (new)
      +repository is single-threaded for writers. Writers may have to busy-spin
      +(with backoff) around creating `tables.list.lock`, for up to an
      +acceptable wait period, aborting if the repository is too busy to
     -+mutate. Application servers wrapped around repositories (e.g. Gerrit
     ++mutate. Application servers wrapped around repositories (e.g. Gerrit
      +Code Review) can layer their own lock/wait queue to improve fairness to
      +writers.
      +
     @@ Documentation/technical/reftable.txt (new)
      +bzip packed-refs
      +^^^^^^^^^^^^^^^^
      +
     -+`bzip2` can significantly shrink a large packed-refs file (e.g. 62 MiB
     ++`bzip2` can significantly shrink a large packed-refs file (e.g. 62 MiB
      +compresses to 23 MiB, 37%). However the bzip format does not support
      +random access to a single reference. Readers must inflate and discard
      +while performing a linear scan.
     @@ Documentation/technical/reftable.txt (new)
      +interleaved between refs.
      +
      +Performance testing indicates reftable is faster for lookups (51%
     -+faster, 11.2 usec vs. 5.4 usec), although reftable produces a slightly
     ++faster, 11.2 usec vs. 5.4 usec), although reftable produces a slightly
      +larger file (+ ~3.2%, 28.3M vs 29.2M):
      +
      +[cols=">,>,>,>",options="header",]
     @@ Documentation/technical/reftable.txt (new)
      +The RefTree format adds additional load on the object database storage
      +layer (more loose objects, more objects in packs), and relies heavily on
      +the packer’s delta compression to save space. Namespaces which are flat
     -+(e.g. thousands of tags in refs/tags) initially create very large loose
     ++(e.g. thousands of tags in refs/tags) initially create very large loose
      +objects, and so RefTree does not address the problem of copying many
      +references to modify a handful.
      +
     @@ Documentation/technical/reftable.txt (new)
      +Longer hashes
      +^^^^^^^^^^^^^
      +
     -+Version will bump (e.g. 2) to indicate `value` uses a different object
     ++Version will bump (e.g. 2) to indicate `value` uses a different object
      +id length other than 20. The length could be stored in an expanded file
      +header, or hardcoded as part of the version.
  7:  6d9031372ce =  5:  7aa3f92fca0 reftable: clarify how empty tables should be written
  6:  093fa74a3d0 !  6:  1e3c8f2d3e8 reftable: define version 2 of the spec to accomodate SHA256
     @@ Metadata
       ## Commit message ##
          reftable: define version 2 of the spec to accomodate SHA256
      
     +    Version appends a hash ID to the file header, making it slightly larger.
     +
     +    This commit also changes "SHA-1" into "object ID" in many places.
     +
          Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
      
       ## Documentation/technical/reftable.txt ##
     +@@ Documentation/technical/reftable.txt: Objectives
     + 
     + * Near constant time lookup for any single reference, even when the
     + repository is cold and not in process or kernel cache.
     +-* Near constant time verification if a SHA-1 is referred to by at least
     ++* Near constant time verification if an object ID is referred to by at least
     + one reference (for allow-tip-sha1-in-want).
     + * Efficient lookup of an entire namespace, such as `refs/tags/`.
     + * Support atomic push with `O(size_of_update)` operations.
      @@ Documentation/technical/reftable.txt: and non-aligned files.
     - Very small files (e.g. 1 only ref block) may omit `padding` and the ref
     + Very small files (e.g. a single ref block) may omit `padding` and the ref
       index to reduce total file size.
       
      -Header
     @@ Documentation/technical/reftable.txt: used in a stack for link:#Update-transacti
      +
      +....
      +'REFT'
     -+uint8( version_number = 1 )
     ++uint8( version_number = 2 )
      +uint24( block_size )
      +uint64( min_update_index )
      +uint64( max_update_index )
     @@ Documentation/technical/reftable.txt: used in a stack for link:#Update-transacti
      +The header is identical to `version_number=1`, with the 4-byte hash ID
      +("sha1" for SHA1 and "s256" for SHA-256) append to the header.
      +
     ++For maximum backward compatibility, it is recommended to use version 1 when
     ++writing SHA1 reftables.
     ++
      +
       First ref block
       ^^^^^^^^^^^^^^^
       
     +@@ Documentation/technical/reftable.txt: The `value` follows. Its format is determined by `value_type`, one of
     + the following:
     + 
     + * `0x0`: deletion; no value data (see transactions, below)
     +-* `0x1`: one 20-byte object id; value of the ref
     +-* `0x2`: two 20-byte object ids; value of the ref, peeled target
     ++* `0x1`: one object id; value of the ref
     ++* `0x2`: two object ids; value of the ref, peeled target
     + * `0x3`: symbolic reference: `varint( target_len ) target`
     + 
     + Symbolic references use `0x3`, followed by the complete name of the
     +@@ Documentation/technical/reftable.txt: Obj block format
     + ^^^^^^^^^^^^^^^^
     + 
     + Object blocks are optional. Writers may choose to omit object blocks,
     +-especially if readers will not use the SHA-1 to ref mapping.
     ++especially if readers will not use the object ID to ref mapping.
     + 
     +-Object blocks use unique, abbreviated 2-20 byte SHA-1 keys, mapping to
     ++Object blocks use unique, abbreviated 2-32 byte object ID keys, mapping to
     + ref blocks containing references pointing to that object directly, or as
     + the peeled value of an annotated tag. Like ref blocks, object blocks use
     + the file’s standard block size. The abbrevation length is available in
     +@@ Documentation/technical/reftable.txt: the footer as `obj_id_len`.
     + To save space in small files, object blocks may be omitted if the ref
     + index is not present, as brute force search will only need to read a few
     + ref blocks. When missing, readers should brute force a linear search of
     +-all references to lookup by SHA-1.
     ++all references to lookup by object ID.
     + 
     + An object block is written as:
     + 
     +@@ Documentation/technical/reftable.txt: works the same as in reference blocks.
     + 
     + Because object identifiers are abbreviated by writers to the shortest
     + unique abbreviation within the reftable, obj key lengths are variable
     +-between 2 and 20 bytes. Readers must compare only for common prefix
     ++between 2 and 32 bytes. Readers must compare only for common prefix
     + match within an obj block or obj index.
     + 
     + obj record
     +@@ Documentation/technical/reftable.txt: for (j = 1; j < position_count; j++) {
     + ....
     + 
     + With a position in hand, a reader must linearly scan the ref block,
     +-starting from the first `ref_record`, testing each reference’s SHA-1s
     ++starting from the first `ref_record`, testing each reference’s object IDs
     + (for `value_type = 0x1` or `0x2`) for full equality. Faster searching by
     +-SHA-1 within a single ref block is not supported by the reftable format.
     ++object ID within a single ref block is not supported by the reftable format.
     + Smaller block sizes reduce the number of candidates this step must
     + consider.
     + 
     +@@ Documentation/technical/reftable.txt: reflogs must treat this as a deletion.
     + For `log_type = 0x1`, the `log_data` section follows
     + linkgit:git-update-ref[1] logging and includes:
     + 
     +-* two 20-byte SHA-1s (old id, new id)
     ++* two object IDs (old id, new id)
     + * varint string of committer’s name
     + * varint string of committer’s email
     + * varint time in seconds since epoch (Jan 1, 1970)
      @@ Documentation/technical/reftable.txt: Footer
       After the last block of the file, a file footer is written. It begins
       like the file header, but is extended with additional data.
     @@ Documentation/technical/reftable.txt: obj blocks.
       
       * 4-byte magic is correct
       * 1-byte version number is recognized
     +@@ Documentation/technical/reftable.txt: Lightweight refs dominate
     + ^^^^^^^^^^^^^^^^^^^^^^^^^
     + 
     + The reftable format assumes the vast majority of references are single
     +-SHA-1 valued with common prefixes, such as Gerrit Code Review’s
     ++object IDs valued with common prefixes, such as Gerrit Code Review’s
     + `refs/changes/` namespace, GitHub’s `refs/pulls/` namespace, or many
     + lightweight tags in the `refs/tags/` namespace.
     + 
     +-Annotated tags storing the peeled object cost an additional 20 bytes per
     ++Annotated tags storing the peeled object cost an additional object ID per
     + reference.
     + 
     + Low overhead
     +@@ Documentation/technical/reftable.txt: Scans and lookups dominate
     + 
     + Scanning all references and lookup by name (or namespace such as
     + `refs/heads/`) are the most common activities performed on repositories.
     +-SHA-1s are stored directly with references to optimize this use case.
     ++Object IDs are stored directly with references to optimize this use case.
     + 
     + Logs are infrequently read
     + ^^^^^^^^^^^^^^^^^^^^^^^^^^
      @@ Documentation/technical/reftable.txt: impossible.
       
       A common format that can be supported by all major Git implementations
     @@ Documentation/technical/reftable.txt: impossible.
      -Longer hashes
      -^^^^^^^^^^^^^
      -
     --Version will bump (e.g. 2) to indicate `value` uses a different object
     +-Version will bump (e.g. 2) to indicate `value` uses a different object
      -id length other than 20. The length could be stored in an expanded file
      -header, or hardcoded as part of the version.
  -:  ----------- >  7:  2c2f94ddc0e Write pseudorefs through ref backends.
  2:  340c5c415e1 =  8:  3becaaee66a Iterate over the "refs/" namespace in for_each_[raw]ref
  4:  7dc47c7756f =  9:  a6f77965f84 Add .gitattributes for the reftable/ directory
  8:  57d338c4983 ! 10:  8103703c358 Add reftable library
     @@ reftable/README.md (new)
      
       ## reftable/VERSION (new) ##
      @@
     -+commit 06dd91a8377b0f920d9835b9835d0d650f928dce
     ++commit e74c14b66b6c15f6526c485f2e45d3f2735d359d
      +Author: Han-Wen Nienhuys <hanwen@google.com>
     -+Date:   Wed May 6 21:27:32 2020 +0200
     -+
     -+    C: fix small memory leak in stack.c error path
     ++Date:   Mon May 11 21:02:55 2020 +0200
     ++
     ++    C: handle out-of-date reftable stacks
     ++    
     ++    * Make reftable_stack_reload() check out-of-dateness. This makes it very cheap,
     ++      allowing it to be called often. This is useful because Git calls itself often,
     ++      which effectively requires a reload.
     ++    
     ++    * In reftable_stack_add(), check the return value of stack_uptodate(), leading
     ++      to erroneously succeeding the transaction.
     ++    
     ++    * A test that exercises the above.
      
       ## reftable/basics.c (new) ##
      @@
     @@ reftable/block.c (new)
      +
      +int block_iter_next(struct block_iter *it, struct record rec)
      +{
     ++	struct slice in = {
     ++		.buf = it->br->block.data + it->next_off,
     ++		.len = it->br->block_len - it->next_off,
     ++	};
     ++	struct slice start = in;
     ++	struct slice key = { 0 };
     ++	byte extra = 0;
     ++	int n = 0;
     ++
      +	if (it->next_off >= it->br->block_len) {
      +		return 1;
      +	}
      +
     -+	{
     -+		struct slice in = {
     -+			.buf = it->br->block.data + it->next_off,
     -+			.len = it->br->block_len - it->next_off,
     -+		};
     -+		struct slice start = in;
     -+		struct slice key = { 0 };
     -+		byte extra;
     -+		int n = decode_key(&key, &extra, it->last_key, in);
     -+		if (n < 0) {
     -+			return -1;
     -+		}
     -+
     -+		slice_consume(&in, n);
     -+		n = record_decode(rec, key, extra, in, it->br->hash_size);
     -+		if (n < 0) {
     -+			return -1;
     -+		}
     -+		slice_consume(&in, n);
     ++	n = decode_key(&key, &extra, it->last_key, in);
     ++	if (n < 0) {
     ++		return -1;
     ++	}
      +
     -+		slice_copy(&it->last_key, key);
     -+		it->next_off += start.len - in.len;
     -+		slice_clear(&key);
     -+		return 0;
     ++	slice_consume(&in, n);
     ++	n = record_decode(rec, key, extra, in, it->br->hash_size);
     ++	if (n < 0) {
     ++		return -1;
      +	}
     ++	slice_consume(&in, n);
     ++
     ++	slice_copy(&it->last_key, key);
     ++	it->next_off += start.len - in.len;
     ++	slice_clear(&key);
     ++	return 0;
      +}
      +
      +int block_reader_first_key(struct block_reader *br, struct slice *key)
     @@ reftable/block.c (new)
      +		.key = want,
      +		.r = br,
      +	};
     ++	struct record rec = new_record(block_reader_type(br));
     ++	struct slice key = { 0 };
     ++	int err = 0;
     ++	struct block_iter next = { 0 };
      +
      +	int i = binsearch(br->restart_count, &restart_key_less, &args);
      +	if (args.error) {
     -+		return -1;
     ++		err = REFTABLE_FORMAT_ERROR;
     ++		goto exit;
      +	}
      +
      +	it->br = br;
     @@ reftable/block.c (new)
      +		it->next_off = br->header_off + 4;
      +	}
      +
     -+	{
     -+		struct record rec = new_record(block_reader_type(br));
     -+		struct slice key = { 0 };
     -+		int result = 0;
     -+		int err = 0;
     -+		struct block_iter next = { 0 };
     -+		while (true) {
     -+			block_iter_copy_from(&next, it);
     -+
     -+			err = block_iter_next(&next, rec);
     -+			if (err < 0) {
     -+				result = -1;
     -+				goto exit;
     -+			}
     -+
     -+			record_key(rec, &key);
     -+			if (err > 0 || slice_compare(key, want) >= 0) {
     -+				result = 0;
     -+				goto exit;
     -+			}
     -+
     -+			block_iter_copy_from(it, &next);
     ++	/* We're looking for the last entry less/equal than the wanted key, so
     ++	   we have to go one entry too far and then back up.
     ++	*/
     ++	while (true) {
     ++		block_iter_copy_from(&next, it);
     ++		err = block_iter_next(&next, rec);
     ++		if (err < 0) {
     ++			goto exit;
      +		}
      +
     -+	exit:
     -+		slice_clear(&key);
     -+		slice_clear(&next.last_key);
     -+		record_destroy(&rec);
     ++		record_key(rec, &key);
     ++		if (err > 0 || slice_compare(key, want) >= 0) {
     ++			err = 0;
     ++			goto exit;
     ++		}
      +
     -+		return result;
     ++		block_iter_copy_from(it, &next);
      +	}
     ++
     ++exit:
     ++	slice_clear(&key);
     ++	slice_clear(&next.last_key);
     ++	record_destroy(&rec);
     ++
     ++	return err;
      +}
      +
      +void block_writer_clear(struct block_writer *bw)
     @@ reftable/merged.c (new)
      +		if (err < 0) {
      +			return err;
      +		}
     -+		record_clear(top.rec);
     -+		reftable_free(record_yield(&top.rec));
     ++		record_destroy(&top.rec);
      +	}
      +
      +	record_copy_from(rec, entry.rec, hash_size(mi->hash_id));
     -+	record_clear(entry.rec);
     -+	reftable_free(record_yield(&entry.rec));
     ++	record_destroy(&entry.rec);
      +	slice_clear(&entry_key);
      +	return 0;
      +}
     @@ reftable/pq.c (new)
      +{
      +	int i = 0;
      +	for (i = 0; i < pq->len; i++) {
     -+		record_clear(pq->heap[i].rec);
     -+		reftable_free(record_yield(&pq->heap[i].rec));
     ++		record_destroy(&pq->heap[i].rec);
      +	}
      +	FREE_AND_NULL(pq->heap);
      +	pq->len = pq->cap = 0;
     @@ reftable/record.c (new)
      +		}
      +		slice_consume(&in, n);
      +		seen_target = true;
     ++		if (r->target != NULL) {
     ++			reftable_free(r->target);
     ++		}
      +		r->target = (char *)slice_as_string(&dest);
      +	} break;
      +
     @@ reftable/record.c (new)
      +	r->update_index = (~max) - ts;
      +
      +	if (val_type == 0) {
     ++		FREE_AND_NULL(r->old_hash);
     ++		FREE_AND_NULL(r->new_hash);
     ++		FREE_AND_NULL(r->message);
     ++		FREE_AND_NULL(r->email);
     ++		FREE_AND_NULL(r->name);
      +		return 0;
      +	}
      +
     @@ reftable/refname.c (new)
      +static int find_name(size_t k, void *arg)
      +{
      +	struct find_arg *f_arg = (struct find_arg *)arg;
     -+
      +	return strcmp(f_arg->names[k], f_arg->want) >= 0;
      +}
      +
     @@ reftable/refname.c (new)
      +
      +static void modification_clear(struct modification *mod)
      +{
     ++	/* don't delete the strings themselves; they're owned by ref records.
     ++	 */
      +	FREE_AND_NULL(mod->add);
      +	FREE_AND_NULL(mod->del);
      +	mod->add_len = 0;
     @@ reftable/refname.c (new)
      +			goto exit;
      +		}
      +	}
     -+
      +	err = reftable_table_seek_ref(mod->tab, &it, prefix);
      +	if (err) {
      +		goto exit;
     @@ reftable/reftable.h (new)
      +/* Commits the transaction, releasing the lock. */
      +int reftable_addition_commit(struct reftable_addition *add);
      +
     -+/* Release all non-committed data from the transaction; releases the lock if
     -+ * held. */
     -+void reftable_addition_close(struct reftable_addition *add);
     ++/* Release all non-committed data from the transaction, and deallocate the
     ++   transaction. Releases the lock if held. */
     ++void reftable_addition_destroy(struct reftable_addition *add);
      +
      +/* add a new table to the stack. The write_table function must call
      +   reftable_writer_set_limits, add refs and return an error value. */
     @@ reftable/reftable.h (new)
      +/* frees all resources associated with the stack. */
      +void reftable_stack_destroy(struct reftable_stack *st);
      +
     -+/* reloads the stack if necessary. */
     ++/* Reloads the stack if necessary. This is very cheap to run if the stack was up
     ++ * to date */
      +int reftable_stack_reload(struct reftable_stack *st);
      +
      +/* Policy for expiring reflog entries. */
     @@ reftable/stack.c (new)
      +	p->reftable_dir = xstrdup(dir);
      +	p->config = config;
      +
     -+	err = reftable_stack_reload(p);
     ++	err = reftable_stack_reload_maybe_reuse(p, true);
      +	if (err < 0) {
      +		reftable_stack_destroy(p);
      +	} else {
     @@ reftable/stack.c (new)
      +/* Close and free the stack */
      +void reftable_stack_destroy(struct reftable_stack *st)
      +{
     -+	if (st->merged == NULL) {
     -+		return;
     ++	if (st->merged != NULL) {
     ++		reftable_merged_table_close(st->merged);
     ++		reftable_merged_table_free(st->merged);
     ++		st->merged = NULL;
      +	}
     -+
     -+	reftable_merged_table_close(st->merged);
     -+	reftable_merged_table_free(st->merged);
     -+	st->merged = NULL;
     -+
      +	FREE_AND_NULL(st->list_file);
      +	FREE_AND_NULL(st->reftable_dir);
      +	reftable_free(st);
     @@ reftable/stack.c (new)
      +	return udiff;
      +}
      +
     -+static int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     -+					     bool reuse_open)
     ++int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     ++				      bool reuse_open)
      +{
      +	struct timeval deadline = { 0 };
      +	int err = gettimeofday(&deadline, NULL);
     @@ reftable/stack.c (new)
      +	return 0;
      +}
      +
     -+int reftable_stack_reload(struct reftable_stack *st)
     -+{
     -+	return reftable_stack_reload_maybe_reuse(st, true);
     -+}
     -+
      +/* -1 = error
      + 0 = up to date
      + 1 = changed. */
     @@ reftable/stack.c (new)
      +	return err;
      +}
      +
     ++int reftable_stack_reload(struct reftable_stack *st)
     ++{
     ++	int err = stack_uptodate(st);
     ++	if (err > 0) {
     ++		return reftable_stack_reload_maybe_reuse(st, true);
     ++	}
     ++	return err;
     ++}
     ++
      +int reftable_stack_add(struct reftable_stack *st,
      +		       int (*write)(struct reftable_writer *wr, void *arg),
      +		       void *arg)
     @@ reftable/stack.c (new)
      +	slice_clear(&nm);
      +}
      +
     ++void reftable_addition_destroy(struct reftable_addition *add)
     ++{
     ++	if (add == NULL) {
     ++		return;
     ++	}
     ++	reftable_addition_close(add);
     ++	reftable_free(add);
     ++}
     ++
      +int reftable_addition_commit(struct reftable_addition *add)
      +{
      +	struct slice table_list = { 0 };
     @@ reftable/stack.c (new)
      +				struct reftable_stack *st)
      +{
      +	int err = 0;
     -+	*dest = reftable_malloc(sizeof(**dest));
     ++	*dest = reftable_calloc(sizeof(**dest));
      +	err = reftable_stack_init_addition(*dest, st);
      +	if (err) {
      +		reftable_free(*dest);
     @@ reftable/stack.c (new)
      +	if (err < 0) {
      +		goto exit;
      +	}
     ++	if (err > 0) {
     ++		err = REFTABLE_LOCK_ERROR;
     ++		goto exit;
     ++	}
      +
      +	err = reftable_addition_add(&add, write_table, arg);
      +	if (err < 0) {
     @@ reftable/stack.c (new)
      +	slice_append_string(&tab_file_name, "/");
      +	slice_append(&tab_file_name, next_name);
      +
     ++	/* TODO: should check destination out of paranoia */
      +	err = rename(slice_as_string(&temp_tab_file_name),
      +		     slice_as_string(&tab_file_name));
      +	if (err < 0) {
     @@ reftable/stack.c (new)
      +	if (err < 0) {
      +		goto exit;
      +	}
     -+	reftable_writer_free(wr);
      +
      +	err = close(tab_fd);
      +	tab_fd = 0;
      +
      +exit:
     ++	reftable_writer_free(wr);
      +	if (tab_fd > 0) {
      +		close(tab_fd);
      +		tab_fd = 0;
     @@ reftable/stack.c (new)
      +
      +	err = validate_ref_record_addition(tab, refs, len);
      +
     ++exit:
      +	for (i = 0; i < len; i++) {
      +		reftable_ref_record_clear(&refs[i]);
      +	}
      +
     -+exit:
      +	free(refs);
      +	reftable_iterator_destroy(&it);
      +	reftable_reader_free(rd);
     @@ reftable/stack.h (new)
      +			struct reftable_log_expiry_config *config);
      +int fastlog2(uint64_t sz);
      +int stack_check_addition(struct reftable_stack *st, const char *new_tab_name);
     ++void reftable_addition_close(struct reftable_addition *add);
     ++int reftable_stack_reload_maybe_reuse(struct reftable_stack *st,
     ++				      bool reuse_open);
      +
      +struct segment {
      +	int start, end;
     @@ reftable/writer.c (new)
      +			writer_reinit_block_writer(w, BLOCK_TYPE_INDEX);
      +
      +			err = block_writer_add(w->block_writer, rec);
     -+			assert(err == 0);
     ++			if (err != 0) {
     ++				/* write into fresh block should always succeed
     ++				 */
     ++				abort();
     ++			}
      +		}
      +		for (i = 0; i < idx_len; i++) {
      +			slice_clear(&idx[i].last_key);
  9:  f3bb9410038 ! 11:  ace95b6cd88 Reftable support for git-core
     @@ refs/reftable-backend.c (new)
      +			break;
      +		}
      +
     ++		/*
     ++		   We could filter pseudo refs here explicitly, but HEAD is not
     ++		   a PSEUDOREF, but a PER_WORKTREE, b/c each worktree can have
     ++		   its own HEAD.
     ++		 */
      +		ri->base.refname = ri->ref.ref_name;
      +		if (ri->prefix != NULL &&
      +		    strncmp(ri->prefix, ri->ref.ref_name, strlen(ri->prefix))) {
     @@ refs/reftable-backend.c (new)
      +
      +static int reftable_transaction_prepare(struct ref_store *ref_store,
      +					struct ref_transaction *transaction,
     -+					struct strbuf *err)
     ++					struct strbuf *errbuf)
      +{
     -+	return 0;
     ++	/* XXX rewrite using the reftable transaction API. */
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	int err = refs->err;
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++	err = reftable_stack_reload(refs->stack);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++
     ++done:
     ++	return err;
      +}
      +
      +static int reftable_transaction_abort(struct ref_store *ref_store,
     @@ refs/reftable-backend.c (new)
      +	return reftable_transaction_commit(ref_store, transaction, err);
      +}
      +
     ++struct write_pseudoref_arg {
     ++	struct reftable_stack *stack;
     ++	const char *pseudoref;
     ++	const struct object_id *new_oid;
     ++	const struct object_id *old_oid;
     ++};
     ++
     ++static int write_pseudoref_table(struct reftable_writer *writer, void *argv)
     ++{
     ++	struct write_pseudoref_arg *arg = (struct write_pseudoref_arg *)argv;
     ++	uint64_t ts = reftable_stack_next_update_index(arg->stack);
     ++	int err = 0;
     ++	struct reftable_ref_record read_ref = { NULL };
     ++	struct reftable_ref_record write_ref = { NULL };
     ++
     ++	reftable_writer_set_limits(writer, ts, ts);
     ++	if (arg->old_oid) {
     ++		struct object_id read_oid;
     ++		err = reftable_stack_read_ref(arg->stack, arg->pseudoref,
     ++					      &read_ref);
     ++		if (err < 0)
     ++			goto done;
     ++
     ++		if ((err > 0) != is_null_oid(arg->old_oid)) {
     ++			err = REFTABLE_LOCK_ERROR;
     ++			goto done;
     ++		}
     ++
     ++		/* XXX If old_oid is set, and we have a symref? */
     ++
     ++		if (err == 0 && read_ref.value == NULL) {
     ++			err = REFTABLE_LOCK_ERROR;
     ++			goto done;
     ++		}
     ++
     ++		hashcpy(read_oid.hash, read_ref.value);
     ++		if (!oideq(arg->old_oid, &read_oid)) {
     ++			err = REFTABLE_LOCK_ERROR;
     ++			goto done;
     ++		}
     ++	}
     ++
     ++	write_ref.ref_name = (char *)arg->pseudoref;
     ++	write_ref.update_index = ts;
     ++	if (!is_null_oid(arg->new_oid))
     ++		write_ref.value = (uint8_t *)arg->new_oid->hash;
     ++
     ++	err = reftable_writer_add_ref(writer, &write_ref);
     ++done:
     ++	reftable_ref_record_clear(&read_ref);
     ++	return err;
     ++}
     ++
     ++static int reftable_write_pseudoref(struct ref_store *ref_store,
     ++				    const char *pseudoref,
     ++				    const struct object_id *oid,
     ++				    const struct object_id *old_oid,
     ++				    struct strbuf *errbuf)
     ++{
     ++	struct git_reftable_ref_store *refs =
     ++		(struct git_reftable_ref_store *)ref_store;
     ++	struct write_pseudoref_arg arg = {
     ++		.stack = refs->stack,
     ++		.pseudoref = pseudoref,
     ++		.new_oid = oid,
     ++	};
     ++	struct reftable_addition *add = NULL;
     ++	int err = refs->err;
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++
     ++	err = reftable_stack_reload(refs->stack);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++	err = reftable_stack_new_addition(&add, refs->stack);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++	if (old_oid) {
     ++		struct object_id actual_old_oid;
     ++
     ++		/* XXX this is cut & paste from files-backend - should factor
     ++		 * out? */
     ++		if (read_ref(pseudoref, &actual_old_oid)) {
     ++			if (!is_null_oid(old_oid)) {
     ++				strbuf_addf(errbuf,
     ++					    _("could not read ref '%s'"),
     ++					    pseudoref);
     ++				goto done;
     ++			}
     ++		} else if (is_null_oid(old_oid)) {
     ++			strbuf_addf(errbuf, _("ref '%s' already exists"),
     ++				    pseudoref);
     ++			goto done;
     ++		} else if (!oideq(&actual_old_oid, old_oid)) {
     ++			strbuf_addf(errbuf,
     ++				    _("unexpected object ID when writing '%s'"),
     ++				    pseudoref);
     ++			goto done;
     ++		}
     ++	}
     ++
     ++	err = reftable_addition_add(add, &write_pseudoref_table, &arg);
     ++	if (err < 0) {
     ++		strbuf_addf(errbuf, "reftable: pseudoref update failure: %s",
     ++			    reftable_error_str(err));
     ++	}
     ++
     ++	err = reftable_addition_commit(add);
     ++	if (err < 0) {
     ++		strbuf_addf(errbuf, "reftable: pseudoref commit failure: %s",
     ++			    reftable_error_str(err));
     ++	}
     ++
     ++done:
     ++	reftable_addition_destroy(add);
     ++	return err;
     ++}
     ++
     ++static int reftable_delete_pseudoref(struct ref_store *ref_store,
     ++				     const char *pseudoref,
     ++				     const struct object_id *old_oid)
     ++{
     ++	struct strbuf errbuf = STRBUF_INIT;
     ++	int ret = reftable_write_pseudoref(ref_store, pseudoref, &null_oid,
     ++					   old_oid, &errbuf);
     ++	/* XXX what to do with the error message? */
     ++	strbuf_release(&errbuf);
     ++	return ret;
     ++}
     ++
      +struct write_delete_refs_arg {
      +	struct reftable_stack *stack;
      +	struct string_list *refnames;
     @@ refs/reftable-backend.c (new)
      +		.logmsg = msg,
      +		.flags = flags,
      +	};
     -+	if (refs->err < 0) {
     -+		return refs->err;
     ++	int err = refs->err;
     ++	if (err < 0) {
     ++		goto done;
      +	}
     -+
     -+	return reftable_stack_add(refs->stack, &write_delete_refs_table, &arg);
     ++	err = reftable_stack_reload(refs->stack);
     ++	if (err) {
     ++		goto done;
     ++	}
     ++	err = reftable_stack_add(refs->stack, &write_delete_refs_table, &arg);
     ++done:
     ++	return err;
      +}
      +
      +static int reftable_pack_refs(struct ref_store *ref_store, unsigned int flags)
     @@ refs/reftable-backend.c (new)
      +					       .refname = refname,
      +					       .target = target,
      +					       .logmsg = logmsg };
     -+	if (refs->err < 0) {
     -+		return refs->err;
     ++	int err = refs->err;
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++	err = reftable_stack_reload(refs->stack);
     ++	if (err) {
     ++		goto done;
      +	}
     -+	return reftable_stack_add(refs->stack, &write_create_symref_table,
     -+				  &arg);
     ++	err = reftable_stack_add(refs->stack, &write_create_symref_table, &arg);
     ++done:
     ++	return err;
      +}
      +
      +struct write_rename_arg {
     @@ refs/reftable-backend.c (new)
      +		.newname = newrefname,
      +		.logmsg = logmsg,
      +	};
     -+	if (refs->err < 0) {
     -+		return refs->err;
     ++	int err = refs->err;
     ++	if (err < 0) {
     ++		goto done;
     ++	}
     ++	err = reftable_stack_reload(refs->stack);
     ++	if (err) {
     ++		goto done;
      +	}
      +
     -+	return reftable_stack_add(refs->stack, &write_rename_table, &arg);
     ++	err = reftable_stack_add(refs->stack, &write_rename_table, &arg);
     ++done:
     ++	return err;
      +}
      +
      +static int reftable_copy_ref(struct ref_store *ref_store,
     @@ refs/reftable-backend.c (new)
      +	reftable_rename_ref,
      +	reftable_copy_ref,
      +
     ++	reftable_write_pseudoref,
     ++	reftable_delete_pseudoref,
     ++
      +	reftable_ref_iterator_begin,
      +	reftable_read_raw_ref,
      +
     @@ t/t0031-reftable.sh (new)
      +	test_cmp expect actual
      +'
      +
     ++# cherry-pick uses a pseudo ref.
     ++test_expect_success 'pseudo refs' '
     ++	initialize &&
     ++	test_commit message1 file1 &&
     ++	test_commit message2 file2 &&
     ++	git branch source &&
     ++	git checkout HEAD^ &&
     ++	test_commit message3 file3 &&
     ++	git cherry-pick source &&
     ++	test -f file2
     ++'
      +
      +test_done
      +
 10:  94fcc6dca6a = 12:  b96f0712d44 vcxproj: adjust for the reftable changes
 12:  fe9407d10b1 = 13:  0e732d30b51 Add some reftable testing infrastructure

-- 
gitgitgadget
