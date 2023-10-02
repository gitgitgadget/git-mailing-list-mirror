Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09D07E784A6
	for <git@archiver.kernel.org>; Mon,  2 Oct 2023 02:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232985AbjJBCjQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 1 Oct 2023 22:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjJBCjP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 1 Oct 2023 22:39:15 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0040A7
        for <git@vger.kernel.org>; Sun,  1 Oct 2023 19:39:12 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-3513fa06bafso39463555ab.3
        for <git@vger.kernel.org>; Sun, 01 Oct 2023 19:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696214352; x=1696819152; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=649d8Sx26pILFGRzTWPv2uXsA7MIjeUiGnP32hcc+Rg=;
        b=CiDdkWxZEqXv9md1rKtwKfwXrq4uMr2jJ/2b3ZD6vt7dGZ4VGNUc3D7MHd5c3jh7N7
         +7pd61iOE5rqzGlSnrbX3/OnJUZgcZjtMnPW4m9N3ut7xlAZ08QL1YepPKdiB+r9yr9j
         cnFPcj5sYBziwHF6Afn6Ji8a4PL7jhiNz5GquSSC6/6rdXDEmU/2sCQy0mZ56N7yOdo6
         17oUjU2z1VlAi7+DR36jGKcdO3t9uEIA1uurPLlWHpV6MWX2Yr4hdWcKc1FptggNPKCr
         3Z0ft8GFKSBf4o2RkWQxgt2hhlSRxr12w10muf8S5OdHelqlKGgulm2/6LSNFFvrDY8z
         0Y+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696214352; x=1696819152;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=649d8Sx26pILFGRzTWPv2uXsA7MIjeUiGnP32hcc+Rg=;
        b=KRRFP8JCNaKjq1SJRXQtwgODiVnlU0dNAJ0oAq64ckpDTmMMjAT3Gz1hpX6yG38rr3
         xijKPQNbZoIW0odBQkLHpIWmlUCLJKG5V1+C29XD/2B1YtMm2i0RIEjJuPZ/6JKykncs
         Bnyvo1Os9pC6cSrkRUuCxAkXQBSaE6wDUChqoslZuCrk6gJLZcZMdDU1uFvk1x3JAe8P
         QfgcrEGQzGs1UH+Jq1slJwoVla81q/3pe2FEIzE5i0iyvJ6r/eH2p7y+ZuDu0fsFcmJO
         KpV8HJLhkh4UY4Yod+JkDkhqo54Jcm6FTjB/R8VSaoXx7SYWwxgMxnpsiaoYflJVHvmE
         ++8g==
X-Gm-Message-State: AOJu0YxqE6Mr2WxALsOcuSvDDvNZivDZGcuDiiERVE48IeFirfGsEFTb
        m4q+S9ixvXYH5Ai5fx60zgk=
X-Google-Smtp-Source: AGHT+IHH17QuU3FDaJOiUZGNs4jfStB4c7Zhbdvv05c+wKaUiE3Q5+VY7ecfjz1XVcxMTpjfF3v5XA==
X-Received: by 2002:a05:6e02:1c8e:b0:351:4b68:ec3a with SMTP id w14-20020a056e021c8e00b003514b68ec3amr11353523ill.9.1696214351937;
        Sun, 01 Oct 2023 19:39:11 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id x22-20020a029716000000b0042b2e90ed06sm6935292jai.23.2023.10.01.19.39.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 19:39:11 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Eric Sunshine <sunshine@sunshineco.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>
Subject: [PATCH v2 00/30] initial support for multiple hash functions
References: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
Date:   Sun, 01 Oct 2023 21:39:09 -0500
In-Reply-To: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org> (Eric
        W. Biederman's message of "Wed, 27 Sep 2023 14:49:57 -0500")
Message-ID: <878r8l929e.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


This addresses all of the known test failures from v1 of this set of
changes.  In particular I have reworked commit_tree_extended which
was flagged by smatch, -Werror=array-bounds, and the leak detector.

One functional bug was fixed in repo_for_each_abbrev where it was
mistakenly displaying too many ambiguous oids.

I am posting this so that people review and testing of this patchset
won't be distracted by the known and fixed issues.



A key part of the hash function transition plan is a way that a single
git repository can inter-operate with git repositories whose storage
hash function is SHA-1 and git repositories whose storage hash function
is SHA-256.

This interoperability can defined in terms of two repositories one whose
storage hash function is SHA-1 and another whose storage hash function
is SHA-256.  Those two repositories receive exactly the same objects,
but they store them in different but equivalent ways.

For a repository that has one storage hash function to inter-operate
with a repository that has a different storage hash function requires
the first repository to be able produce it's objects as if they were
stored in the second hash function.

This series of changes focuses on implementing the pieces that allow
a repository that uses one storage hash function to produce the objects
that would have been stored with a second storage hash function.

The final patch in this series is the addition of a test that creates
two repositories one that uses SHA-1 as it's storage hash function
and the other that uses SHA-256 as it's storage hash function.
Identical operations are performed on the two repositories, and their
compatibility objects are compared to verify they are the same.
AKA the SHA-1 repository on the fly generates the objects store in
the SHA-256 repository, and the SHA-256 repository on the fly generates
the objects that are stored in the SHA-1 repository.

There are two fundamental technologies for enabling this.
- The ability to convert a stored object into the object the
  other repository would have stored.
- The ability to remember a mapping between SHA-1 and SHA-256 oids
  of equivalent objects.

With such technologies it is very easy to implement user facing changes.
To avoid locking git into poor decisions by accident I have done my best
to minimize the user facing changes, while still building the internal
infrastructure that is needed for interoperability.

All of this work is inspired by earlier work on interoperability by
"brian m. carlson" and some of the key pieces of code are still his.

To get to the point where I can test if a SHA-1 and a SHA-256 repository
can on the fly generate each other, I have made some small user-facing
changes.

git rev-parse now supports --output-object-format as a way to query
the internal mapping tables between oids and report the equivalent
oid of the other format.

git cat-file when given a oid that does not match the repositories
storage format will now attempt to find the oids equivalent object that
is stored in the repository and if found dynamically generate the object
that would have been stored in a repository with a different storage
hash function and display the object.

An additional file loose-object-index will be stored in ".git/objects/".

An additional option "extensions.compatObjectFormat" is implemented,
that generates and stores mappings between the oids of objects stored in
the repository and oids of the equivalent objects that would be stored
in a repository show storage format was extensions.compatObjectFormat.

Eric W. Biederman (23):
      object-file-convert: stubs for converting from one object format to another
      oid-array: teach oid-array to handle multiple kinds of oids
      object-names: support input of oids in any supported hash
      repository: add a compatibility hash algorithm
      loose: compatibilty short name support
      object-file: update the loose object map when writing loose objects
      object-file: add a compat_oid_in parameter to write_object_file_flags
      commit: convert mergetag before computing the signature of a commit
      commit: export add_header_signature to support handling signatures on tags
      tag: sign both hashes
      object: factor out parse_mode out of fast-import and tree-walk into in object.h
      object-file-convert: don't leak when converting tag objects
      object-file-convert: convert commits that embed signed tags
      object-file: update object_info_extended to reencode objects
      rev-parse: add an --output-object-format parameter
      builtin/cat-file: let the oid determine the output algorithm
      tree-walk: init_tree_desc take an oid to get the hash algorithm
      object-file: handle compat objects in check_object_signature
      builtin/ls-tree: let the oid determine the output algorithm
      test-lib: compute the compatibility hash so tests may use it
      t1006: rename sha1 to oid
      t1006: test oid compatibility with cat-file
      t1016-compatObjectFormat: add tests to verify the conversion between objects

brian m. carlson (7):
      loose: add a mapping between SHA-1 and SHA-256 for loose objects
      commit: write commits for both hashes
      cache: add a function to read an OID of a specific algorithm
      object-file-convert: add a function to convert trees between algorithms
      object-file-convert: convert tag objects when writing
      object-file-convert: convert commit objects when writing
      repository: implement extensions.compatObjectFormat

 Documentation/config/extensions.txt |  12 ++
 Documentation/git-rev-parse.txt     |  12 ++
 Makefile                            |   3 +
 archive.c                           |   3 +-
 builtin/am.c                        |   6 +-
 builtin/cat-file.c                  |  12 +-
 builtin/checkout.c                  |   8 +-
 builtin/clone.c                     |   2 +-
 builtin/commit.c                    |   2 +-
 builtin/fast-import.c               |  18 +-
 builtin/grep.c                      |   8 +-
 builtin/ls-tree.c                   |   5 +-
 builtin/merge.c                     |   3 +-
 builtin/pack-objects.c              |   6 +-
 builtin/read-tree.c                 |   2 +-
 builtin/rev-parse.c                 |  25 ++-
 builtin/stash.c                     |   5 +-
 builtin/tag.c                       |  45 ++++-
 cache-tree.c                        |   4 +-
 commit.c                            | 221 ++++++++++++++++-----
 commit.h                            |   1 +
 delta-islands.c                     |   2 +-
 diff-lib.c                          |   2 +-
 fsck.c                              |   6 +-
 hash-ll.h                           |   1 +
 hash.h                              |   9 +-
 http-push.c                         |   2 +-
 list-objects.c                      |   2 +-
 loose.c                             | 259 ++++++++++++++++++++++++
 loose.h                             |  22 +++
 match-trees.c                       |   4 +-
 merge-ort.c                         |  11 +-
 merge-recursive.c                   |   2 +-
 merge.c                             |   3 +-
 object-file-convert.c               | 277 ++++++++++++++++++++++++++
 object-file-convert.h               |  24 +++
 object-file.c                       | 212 ++++++++++++++++++--
 object-name.c                       |  46 +++--
 object-name.h                       |   3 +-
 object-store-ll.h                   |   7 +-
 object.c                            |   2 +
 object.h                            |  18 ++
 oid-array.c                         |  12 +-
 pack-bitmap-write.c                 |   2 +-
 packfile.c                          |   3 +-
 reflog.c                            |   2 +-
 repository.c                        |  14 ++
 repository.h                        |   4 +
 revision.c                          |   4 +-
 setup.c                             |  22 +++
 setup.h                             |   1 +
 t/helper/test-delete-gpgsig.c       |  62 ++++++
 t/helper/test-tool.c                |   1 +
 t/helper/test-tool.h                |   1 +
 t/t1006-cat-file.sh                 | 379 +++++++++++++++++++++---------------
 t/t1016-compatObjectFormat.sh       | 281 ++++++++++++++++++++++++++
 t/t1016/gpg                         |   2 +
 t/test-lib-functions.sh             |  17 +-
 tree-walk.c                         |  58 +++---
 tree-walk.h                         |   7 +-
 tree.c                              |   2 +-
 walker.c                            |   2 +-
 62 files changed, 1844 insertions(+), 349 deletions(-)

Eric
