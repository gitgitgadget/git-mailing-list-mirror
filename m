Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4F13A1F858
	for <e@80x24.org>; Thu, 28 Jul 2016 16:02:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758956AbcG1QCq (ORCPT <rfc822;e@80x24.org>);
	Thu, 28 Jul 2016 12:02:46 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34347 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758920AbcG1QCo (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jul 2016 12:02:44 -0400
Received: by mail-wm0-f68.google.com with SMTP id q128so11844261wma.1
        for <git@vger.kernel.org>; Thu, 28 Jul 2016 09:02:43 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Q5BStFzbxjTbsxLvmpIv72R2yq0JPHPZ+fNjGNeoPYY=;
        b=hJc9GYCyDcWyjwGXOmt68lRAWnqHeauxvEXWhnAhRxbZ5eCuG7efZK5ZyMzN2CEXnB
         iH9aLgEl3P4Y0Sq8qBA0j5wQBeI6p4MxwjADQmkAAErvbI4TOBnMWIlvHnwtm0ArrokF
         750kxSn17E4+UZJWUnUbEZU+Vn+kCvVclrlGq4kNtBtw+x6tLT6teoq17LQA2l5zb4eH
         vfULAHEzq9AmeY2eo13xQC9c46Z+x4UY74N1BaXnsZFlJ19Xp4hE0kK1T7awPP+kzMzq
         MT3HKV6bCD410KoK+urSX+8KCl02wmGB7LrILbDpg4MiZtME3Z/PD4LmUC+UQ2c6L61o
         SFag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Q5BStFzbxjTbsxLvmpIv72R2yq0JPHPZ+fNjGNeoPYY=;
        b=KYoxjzg7jw4wL+NKMqrCCKqbq0AGj0+JgF9iOI3vf7A8EeNSxQNTvSbo4ctH9bYOx3
         9FAgHdpQlDFtlsvYPU5BdMC6fz8atWl7lts7AIqhV7KaSq2Lirj6qERacwnnOQTnXQMo
         SJmDVz5IdUPhl13mMdXuOAKIdM915PqWaUcRu8hwYFRKnjyGjQaJgfTQWbPK2WVO4/GZ
         9KC/aXAqp+Td4CBgyjcBbUWeSm+WXGtkZu1wpahmHF+9XhqKu/fXx1quetsO8+CXtQm2
         FIyupxTx7cRhCws1vEnXZyUfo5/3E3d5WlUGOaXgqFij+vN+4Lg0vnEfwR+k2FS8nlda
         6S2g==
X-Gm-Message-State: AEkoouvMYMjfl7uQ0hP737BhYI2X66edw8Et3kVq2y9AIjjJGatTQEQ7se/+8DiRBmnM4g==
X-Received: by 10.28.135.133 with SMTP id j127mr40784840wmd.9.1469721762524;
        Thu, 28 Jul 2016 09:02:42 -0700 (PDT)
Received: from localhost.localdomain (p54A20961.dip0.t-ipconnect.de. [84.162.9.97])
        by smtp.gmail.com with ESMTPSA id ka6sm12118232wjb.38.2016.07.28.09.02.40
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Jul 2016 09:02:41 -0700 (PDT)
From:	Robin Ruede <r.ruede@gmail.com>
To:	git@vger.kernel.org
Cc:	Robin Ruede <r.ruede@gmail.com>
Subject: [PATCH/RFC 0/7] Add possibility to clone specific subdirectories 
Date:	Thu, 28 Jul 2016 18:02:19 +0200
Message-Id: <20160728160226.24018-1-r.ruede@gmail.com>
X-Mailer: git-send-email 2.9.2.472.g105ab30
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

This patch series adds a `--sparse-prefix=` option to multiple commands,
allowing fetching repository contents from only a subdirectory of a remote.

This works along with sparse-checkout, and is especially useful for repositories
where a subdirectory has meaning when standing alone.

* Motivation (example use cases)

1. Git repositories used for managing large/binary files
  My university has a repository containing lecture slides etc.
  as pdfs, with a subdirectory for each lecture. The bandwith for getting the
  whole repository (even with --depth=1) is 4GiB with significant processing
  time, getting the complete history of a single lecture uses 25MiB and
  completes instantly.
2. package-manager-like repositories. Examples:
  a) Arch Linux package build files repository [1]
  b) Rust crates.io packages [2]
  c) TypeScript type definitions [3]
3. Excluding a specific directory containing e.g. large binary assets
  Not currently possible with this patch set, but could be added
  (see problem 2 below).
4. Getting the history of a single file
5. Other uses
  As a non kernel developer, I wanted to quickly search through
  the code of only the btrfs filesystem using the git tools, but I do not have
  a local clone of the complete repository. Using `--depth=100` in combination
  with `--sparse-prefix=/fs/btrfs` allows me to have little bandwidth usage
  while still retaining some history.
6. This is trivial in SVN, and searching on the internet, there are multiple
questions about this feature [4-7]

* Examples usage:

Getting the source of the btrfs filesystem with a bit of history:

    $ git clone git@server:linux --depth=100 # shallow, not sparse
    Receiving objects: 100% (814945/814945), 438.55 MiB | 35.21 MiB/s, done.
    ...
    $ git clone git@server:linux --depth=100 --sparse-prefix=/fs/btrfs # sparse and shallow
    Receiving objects: 100% (503747/503747), 121.45 MiB | 59.75 MiB/s, done.
    ...
    $ cd linux && ls ./
    fs
    $ ls fs/
    btrfs
    $ git log --oneline
    (repo behaves the same as a full clone with sparse-checkout /fs/btrfs)



* Open problems:

1. Currently all trees are still included. It would be possible to
include only the trees relevant to the sparse files, which would significantly
reduce the pack sizes for repositories containing a lot of small files changing
often. For example package managers using git. Not sure in how many places all
trees are presumed present.

2. This patch set implements it as a simple single prefix check command line
option.
Using the exclude_list format (same as in sparse-checkout) might be useful.
The server needs to check these patterns for all files in history, so I'm not
sure if allowing multiple/complex patterns is a good idea.

3. This patch set assumes the sparse-prefix and sparse-checkout does not change.
running clone and fetch both need to have the --sparse-prefix= option, otherwise
complete packs will be fetched. Not sure what the best way to store the
information is, possibly create a new file `.git/sparse` similar to
`.git/shallow` containing the path(s).

3. Bitmap indices cannot be used, because they do not contain the paths of the
objects. So for creating packs, the whole DAG has to be walked.

4. Fsck complains about missing blobs. Should be fairly easy to fix.

5. Tests and documentation is missing.

[1]: https://git.archlinux.org/svntogit/packages.git/
[2]: https://github.com/rust-lang/crates.io-index
[3]: https://github.com/DefinitelyTyped/DefinitelyTyped
[4]: https://stackoverflow.com/questions/600079/is-there-any-way-to-clone-a-git-repositorys-sub-directory-only
[5]: https://stackoverflow.com/questions/11834386/cloning-only-a-subdirectory-with-git
[6]: https://askubuntu.com/questions/460885/how-to-clone-git-repository-only-some-directories
[7]: https://coderwall.com/p/o2fasg/how-to-download-a-project-subdirectory-from-github

Robin Ruede (7):
  list-objects: add sparse-prefix option to rev_info
  pack-objects: add sparse-prefix
  Skip checking integrity of files ignored by sparse
  fetch-pack: add sparse prefix to smart protocol
  fetch: add sparse-prefix option
  clone: add sparse-prefix option
  remote-curl: add sparse prefix

 builtin/clone.c        | 27 ++++++++++++++++++++++++---
 builtin/fetch-pack.c   |  6 ++++++
 builtin/fetch.c        | 19 ++++++++++++++-----
 builtin/pack-objects.c | 11 +++++++++++
 cache-tree.c           |  3 ++-
 connected.c            |  7 ++++++-
 fetch-pack.c           |  4 ++++
 fetch-pack.h           |  1 +
 list-objects.c         |  4 +++-
 remote-curl.c          | 17 ++++++++++++++++-
 revision.c             |  4 ++++
 revision.h             |  1 +
 transport.c            |  4 ++++
 transport.h            |  4 ++++
 upload-pack.c          | 15 ++++++++++++++-
 15 files changed, 114 insertions(+), 13 deletions(-)

-- 
2.9.1.283.g3ca5b4c.dirty

