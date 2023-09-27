Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068F9E82CCB
	for <git@archiver.kernel.org>; Wed, 27 Sep 2023 19:50:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjI0TuD (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Sep 2023 15:50:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI0TuC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Sep 2023 15:50:02 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C3CCC
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:50:00 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id ca18e2360f4ac-79fca042ec0so241770139f.3
        for <git@vger.kernel.org>; Wed, 27 Sep 2023 12:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695844200; x=1696449000; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=svlxWXzzI9S4TwVhKZV6aW9sDXymI1+CL4yPy+SxiRk=;
        b=aNPDKXDVWAmcDlRU0dgOR5r4V/sEPMD3WQN8WUjD3hIgYIpDvTJvbfDysCPaEr+2/k
         b5ncGIv4eHtoIlAalC2gEnZl75ShxYUnPEPIv4Nq4l94g/4Xdx7pEDh0MgkTktxkR4dd
         jUrZoEv4srK/JsxcVQt0MGnTYsQivQUrYienf0Q0ZcnTfHFjpkD7mqrjdbUDWgASNMI1
         RrWh/IyoixoXR2e1zcHOktsdKTvZo7YVKexSAmnlr+OKrqQol1hTgMnq/+e9kxVDIupb
         +W/sjwLfWQd28kXcaDZ8enEEUta80UsynltWBw3LHY6W/CGy9UuFLu+0znRI9pgn8oIG
         XzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695844200; x=1696449000;
        h=mime-version:user-agent:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=svlxWXzzI9S4TwVhKZV6aW9sDXymI1+CL4yPy+SxiRk=;
        b=HAe33rYUi7BmlGtUxLnoS3BBl6w0jftfNTN9dG0FEw45dZ74UdsFgq0gNaMWTD3cY4
         4edhFb4EQAb1nw+le1g9Z4wPj4fkHIdRdyetdztIn8F4QXJOG2yMCQ0F3r5YuIAm4olx
         YZl2vbheLEVd/tNfQuzroD75yOGjpNOSmkvozjcqA7x3afr6TCkhLogDRhRMkTc8S6gy
         V+asRPqkJ785Ffh9Fau0oVpCqvEmzngVzGoQC1QLnO15Q6L4x1sThXFSMOzZR/pN7Dwy
         sm5HOmuWQ5I9AQ7IUAdwvsthsq1leiKfeD8hi1oIkO6/suvfapwqzg+5gi83ZJSJtf2i
         FdXg==
X-Gm-Message-State: AOJu0YyWLdgvEEpDnMJlDTxDgRBrL3ljvWOms1/CUZbCOB9t/iYu7Oz0
        WU8fj8GYeLwv05+m0AhbntXGj7UjNhA=
X-Google-Smtp-Source: AGHT+IEpYrc6t8k/Pc+4NFQ2nLp4DC+LF2q3WWeQ3uW6Q1ot77NUgivqK1ZtVezIraP75yqmsbcv1g==
X-Received: by 2002:a5d:8050:0:b0:799:2163:418a with SMTP id b16-20020a5d8050000000b007992163418amr3691211ior.13.1695844199933;
        Wed, 27 Sep 2023 12:49:59 -0700 (PDT)
Received: from gmail.froward.int.ebiederm.org.gmail.com (ip68-227-168-167.om.om.cox.net. [68.227.168.167])
        by smtp.gmail.com with ESMTPSA id j21-20020a02a695000000b00430209d0efesm4180568jam.59.2023.09.27.12.49.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 12:49:59 -0700 (PDT)
From:   "Eric W. Biederman" <ebiederm@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     <git@vger.kernel.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>
Subject: [PATCH 00/30] Initial support for multiple hash functions
Date:   Wed, 27 Sep 2023 14:49:57 -0500
Message-ID: <87jzsbjt0a.fsf@gmail.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


I have been going over and over this patchset trying to figure
out if it is ready to be merged.  I don't know of any deficiencies
so it is at a point it could benefit from a set of eyes that
are not mine.

I had planned to wait a little bit longer but there are some on-going
conversations that could benefit from people seeing what it means for a
repository to support two hash functions at the same time.


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
      object-file-convert: Stubs for converting from one object format to another
      oid-array: Teach oid-array to handle multiple kinds of oids
      object-names: Support input of oids in any supported hash
      repository: add a compatibility hash algorithm
      loose: Compatibilty short name support
      object-file: Update the loose object map when writing loose objects
      object-file: Add a compat_oid_in parameter to write_object_file_flags
      commit: Convert mergetag before computing the signature of a commit
      commit: Export add_header_signature to support handling signatures on tags
      tag: sign both hashes
      object: Factor out parse_mode out of fast-import and tree-walk into in object.h
      object-file-convert: Don't leak when converting tag objects
      object-file-convert: Convert commits that embed signed tags
      object-file: Update object_info_extended to reencode objects
      rev-parse: Add an --output-object-format parameter
      builtin/cat-file:  Let the oid determine the output algorithm
      tree-walk: init_tree_desc take an oid to get the hash algorithm
      object-file: Handle compat objects in check_object_signature
      builtin/ls-tree: Let the oid determine the output algorithm
      test-lib: Compute the compatibility hash so tests may use it
      t1006: Rename sha1 to oid
      t1006: Test oid compatibility with cat-file
      t1016-compatObjectFormat: Add tests to verify the conversion between objects

brian m. carlson (7):
      loose: add a mapping between SHA-1 and SHA-256 for loose objects
      commit: write commits for both hashes
      cache: add a function to read an OID of a specific algorithm
      object-file-convert: add a function to convert trees between algorithms
      object-file-convert: convert tag objects when writing
      object-file-convert: convert commit objects when writing
      repository: Implement extensions.compatObjectFormat

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
 commit.c                            | 219 ++++++++++++++++-----
 commit.h                            |   1 +
 delta-islands.c                     |   2 +-
 diff-lib.c                          |   2 +-
 fsck.c                              |   6 +-
 hash-ll.h                           |   1 +
 hash.h                              |   9 +-
 http-push.c                         |   2 +-
 list-objects.c                      |   2 +-
 loose.c                             | 258 ++++++++++++++++++++++++
 loose.h                             |  22 +++
 match-trees.c                       |   4 +-
 merge-ort.c                         |  11 +-
 merge-recursive.c                   |   2 +-
 merge.c                             |   3 +-
 object-file-convert.c               | 277 ++++++++++++++++++++++++++
 object-file-convert.h               |  24 +++
 object-file.c                       | 212 ++++++++++++++++++--
 object-name.c                       |  49 +++--
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
 t/t1016-compatObjectFormat.sh       | 280 ++++++++++++++++++++++++++
 t/t1016/gpg                         |   2 +
 t/test-lib-functions.sh             |  17 +-
 tree-walk.c                         |  58 +++---
 tree-walk.h                         |   7 +-
 tree.c                              |   2 +-
 walker.c                            |   2 +-
 62 files changed, 1843 insertions(+), 349 deletions(-)

Eric
