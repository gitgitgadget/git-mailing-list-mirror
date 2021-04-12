Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E6D3C433ED
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6B54560238
	for <git@archiver.kernel.org>; Mon, 12 Apr 2021 21:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238208AbhDLVIj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 12 Apr 2021 17:08:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237036AbhDLVIj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Apr 2021 17:08:39 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86840C061574
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:20 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 12so7581912wmf.5
        for <git@vger.kernel.org>; Mon, 12 Apr 2021 14:08:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=5v1bAnVioll83L7ncjEdOWAaUDMHcZWQwVbfNUE+Oyk=;
        b=tydIXeI3fcUI/2nCdGM3C1vVQiyA88nXkQjA2dpo09x7ZiqgwqMJnSQUNenDWOxNTt
         mBMP3F3KTkOcmDTLyhgFLwe3JSl1D/LX08dq3HZVtB9iB7E+43TszAmxhCHmhOLRZtPy
         XKpZPe3cFikpzK4VpRRtjxJFnL08PvR0kyxOsa/H+fI1iTburJ+b3B6vQ6Kyt8Xsrmi2
         tNnhvQ96i4vjvLbeVufKu/AQm+WCkbGJ+NsdxIyEAMHFckI7UCZhvGlct6dqrz+luurt
         TtGDMSDYhgKJ4DYmkqLzY4oLHJp25iunJZynKfYkChw0uuxsTb7Qr4D6icRJUWOGlGM6
         tGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=5v1bAnVioll83L7ncjEdOWAaUDMHcZWQwVbfNUE+Oyk=;
        b=X7SGTJ+dRGeoTi5EgFxO6UR1iyvYiPmfBMmbB91zcrVa8rK2bxScsdxXZA6iaHjDkD
         ZrBgsJnnvOnqHS24bPVWB5fV/E/frPflmWIkovv+Z4/6At/NhY2gUHQL3adyumj4cwWq
         VseLSEfJW7a/6yNuMc0wD053v7hIIXfIj+THV0Bd/CT/jhSCSg2wAHisk8lr2wDnc6dw
         wY9GspmTMwgwEoDWISt2rC074MKVj48ox51ZmY01Q9oZsD9AQHs9orQHaOOR4OJi0xjp
         MhVhlDff9KyTu58ia+asGL7zS745uPM8b+GAak4iGlNYVvtdGStZN2KsZG9+2fyf5C0q
         6CkA==
X-Gm-Message-State: AOAM530B7U8TRJhw7uio1+BiemSqt2BJYQ9FaCU6UjH7mcp/CfOvqhGm
        cSzuEpQyv7SUS8zNg4PkKr0GqYj5QEk=
X-Google-Smtp-Source: ABdhPJy2ypbJGkVV5BXjLMHCdXZs1QqHVbKsN0i+iWiD5TggPSL0kU7k57zLIKJ1NnJJg5gFtQkmyA==
X-Received: by 2002:a1c:b342:: with SMTP id c63mr886258wmf.162.1618261699280;
        Mon, 12 Apr 2021 14:08:19 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id c2sm471775wmr.22.2021.04.12.14.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Apr 2021 14:08:18 -0700 (PDT)
Message-Id: <pull.906.v3.git.1618261697.gitgitgadget@gmail.com>
In-Reply-To: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
References: <pull.906.v2.git.1617241802.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 12 Apr 2021 21:07:51 +0000
Subject: [PATCH v3 00/26] Sparse Index: API protections
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     newren@gmail.com, gitster@pobox.com,
        Derrick Stolee <stolee@gmail.com>,
        Matheus Tavares Bernardino <matheus.bernardino@usp.br>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is the second patch series submission coming out of the sparse-index
RFC [1].

[1]
https://lore.kernel.org/git/pull.847.git.1611596533.gitgitgadget@gmail.com/

This is based on ds/sparse-index.

The point of this series is to insert protections for the consumers of the
in-memory index to avoid unintended behavior change when using a sparse
index versus a full one.

We mark certain regions of code as needing a full index, so we call
ensure_full_index() to expand a sparse index to a full one, if necessary.
These protections are inserted file-by-file in every loop over all cache
entries. Well, "most" loops, because some are going to be handled in the
very next series so I leave them out.

Many callers use index_name_pos() to find a path by name. In these cases, we
can check if that position resolves to a sparse directory instance. In those
cases, we just expand to a full index and run the search again.

The last few patches deal with the name-hash hashtable for doing O(1)
lookups.

These protections don't do much right now, since the previous series created
the_repository->settings.command_requires_full_index to guard all index
reads and writes to ensure the in-memory copy is full for commands that have
not been tested with the sparse index yet.

However, after this series is complete, we now have a straight-forward plan
for making commands "sparse aware" one-by-one:

 1. Disable settings.command_requires_full_index to allow an in-memory
    sparse-index.
 2. Run versions of that command under a debugger, breaking on
    ensure_full_index().
 3. Examine the call stack to determine the context of that expansion, then
    implement the proper behavior in those locations.
 4. Add tests to ensure we are checking this logic in the presence of sparse
    directory entries.

I will admit that mostly it is the writing of the test cases that takes the
most time in the conversions I've done so far.


Updates in v3
=============

 * I updated based on Elijah's feedback.
 * One new patch splits out a change that Elijah (rightfully) pointed out
   did not belong with the patch it was originally in.

I gave it time to see if any other comments came in, but it looks like
review stabilized. I probably waited a bit longer than I should have.


Updates in v2
=============

 * Rebased onto v5 of ds/sparse-index
 * Updated the technical doc to describe how these protections are guards to
   keep behavior consistent between a sparse-index and a full index. Whether
   or not that behavior is "correct" can be interrogated later.
 * Calls to ensure_full_index() are marked with a TODO comment saying these
   calls should be audited later (with tests).
 * Fixed an incorrectly squashed commit message.
 * Dropped the diff-lib.c commit because it was erroneously included in v2.
 * Dropped the merge-ort.c commit because of conflicts with work in flight
   and a quick audit that it is not needed.
 * I reviewed the merge of this topic with mt/add-rm-in-sparse-checkout and
   found it equivalent to what I would have done.

Thanks, -Stolee

Derrick Stolee (26):
  sparse-index: API protection strategy
  *: remove 'const' qualifier for struct index_state
  read-cache: expand on query into sparse-directory entry
  cache: move ensure_full_index() to cache.h
  add: ensure full index
  checkout-index: ensure full index
  checkout: ensure full index
  commit: ensure full index
  difftool: ensure full index
  fsck: ensure full index
  grep: ensure full index
  ls-files: ensure full index
  merge-index: ensure full index
  rm: ensure full index
  stash: ensure full index
  update-index: ensure full index
  dir: ensure full index
  entry: ensure full index
  merge-recursive: ensure full index
  pathspec: ensure full index
  read-cache: ensure full index
  resolve-undo: ensure full index
  revision: ensure full index
  name-hash: don't add directories to name_hash
  sparse-index: expand_to_path()
  name-hash: use expand_to_path()

 Documentation/technical/sparse-index.txt | 37 +++++++++++-
 attr.c                                   | 14 ++---
 attr.h                                   |  4 +-
 builtin/add.c                            |  2 +
 builtin/checkout-index.c                 |  2 +
 builtin/checkout.c                       |  5 ++
 builtin/commit.c                         |  4 ++
 builtin/difftool.c                       |  3 +
 builtin/fsck.c                           |  2 +
 builtin/grep.c                           |  2 +
 builtin/ls-files.c                       | 14 +++--
 builtin/merge-index.c                    |  5 ++
 builtin/rm.c                             |  2 +
 builtin/stash.c                          |  2 +
 builtin/update-index.c                   |  2 +
 cache.h                                  |  7 ++-
 convert.c                                | 26 ++++-----
 convert.h                                | 20 +++----
 dir.c                                    | 14 +++--
 dir.h                                    |  8 +--
 entry.c                                  |  2 +
 merge-recursive.c                        |  4 +-
 name-hash.c                              | 11 +++-
 pathspec.c                               |  8 ++-
 pathspec.h                               |  6 +-
 read-cache.c                             | 35 ++++++++++--
 resolve-undo.c                           |  4 ++
 revision.c                               |  2 +
 sparse-index.c                           | 73 ++++++++++++++++++++++++
 sparse-index.h                           | 14 ++++-
 submodule.c                              |  6 +-
 submodule.h                              |  6 +-
 32 files changed, 273 insertions(+), 73 deletions(-)


base-commit: c9e40ae8ec41c5566e5849a87c969fa81ef49fcd
Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-906%2Fderrickstolee%2Fsparse-index%2Fprotections-v3
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-906/derrickstolee/sparse-index/protections-v3
Pull-Request: https://github.com/gitgitgadget/git/pull/906

Range-diff vs v2:

  1:  7484e085e342 =  1:  4731f610ba6e sparse-index: API protection strategy
  2:  098b2c9ef352 =  2:  d3a92538edb6 *: remove 'const' qualifier for struct index_state
  3:  737d27e18d64 =  3:  f4b77aa18b93 read-cache: expand on query into sparse-directory entry
  4:  db5c100f3e2b =  4:  da17774a53c5 cache: move ensure_full_index() to cache.h
  5:  4a5fc2eb5a9f =  5:  b59c9f482828 add: ensure full index
  6:  11c38f7277c5 =  6:  0082855b5961 checkout-index: ensure full index
  7:  fd04adbb3f79 =  7:  e2ac527143ff checkout: ensure full index
  8:  65704f39edc9 =  8:  1a3b51fd3c4b commit: ensure full index
  9:  739f3fe9edf2 =  9:  8c61d40dfe01 difftool: ensure full index
 10:  779a86ad1ec4 = 10:  45b603379422 fsck: ensure full index
 11:  8c0d377054fa = 11:  97124e9fdc7f grep: ensure full index
 12:  beaa1467cabb = 12:  b00e214515e8 ls-files: ensure full index
 13:  73684141fcff = 13:  6497f2ce225b merge-index: ensure full index
 14:  6ea81a49c6b5 = 14:  175f3bc6b336 rm: ensure full index
 15:  49ca5ed05c8d = 15:  daa77e84e0e2 stash: ensure full index
 16:  9c4bb187c15d = 16:  8c5336964d9b update-index: ensure full index
 17:  fae4c078c3ef = 17:  08a62c23c8f7 dir: ensure full index
 18:  2b9180ee77d3 = 18:  825ebceee508 entry: ensure full index
 19:  1e3f6085a405 = 19:  3673db517235 merge-recursive: ensure full index
 20:  e62a597a9725 = 20:  4d3f6de29a63 pathspec: ensure full index
 21:  ebfffdbdd6ad = 21:  bda9cab15966 read-cache: ensure full index
 22:  495b07a87973 = 22:  38f295a41ec1 resolve-undo: ensure full index
 23:  3144114d1a75 = 23:  f928e104f0d3 revision: ensure full index
  -:  ------------ > 24:  5fd83dcf2747 name-hash: don't add directories to name_hash
 24:  d52c72b4a7b9 ! 25:  335fec3676a0 sparse-index: expand_to_path()
     @@ sparse-index.c: void ensure_full_index(struct index_state *istate)
      +				      path_mutable.len, icase)) {
      +			/*
      +			 * We found a parent directory in the name-hash
     -+			 * hashtable, which means that this entry could
     -+			 * exist within a sparse-directory entry. Expand
     -+			 * accordingly.
     ++			 * hashtable, because only sparse directory entries
     ++			 * have a trailing '/' character.  Since "path" wasn't
     ++			 * in the index, perhaps it exists within this
     ++			 * sparse-directory.  Expand accordingly.
      +			 */
      +			ensure_full_index(istate);
      +			break;
 25:  7e2d3fae9a2a ! 26:  1f3af8a886e5 name-hash: use expand_to_path()
     @@ name-hash.c
       
       struct dir_entry {
       	struct hashmap_entry ent;
     -@@ name-hash.c: static void hash_index_entry(struct index_state *istate, struct cache_entry *ce)
     - 	if (ce->ce_flags & CE_HASHED)
     - 		return;
     - 	ce->ce_flags |= CE_HASHED;
     -+
     -+	if (S_ISSPARSEDIR(ce->ce_mode)) {
     -+		add_dir_entry(istate, ce);
     -+		return;
     -+	}
     -+
     - 	hashmap_entry_init(&ce->ent, memihash(ce->name, ce_namelen(ce)));
     - 	hashmap_add(&istate->name_hash, &ce->ent);
     - 
      @@ name-hash.c: int index_dir_exists(struct index_state *istate, const char *name, int namelen)
       	struct dir_entry *dir;
       

-- 
gitgitgadget
