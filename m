Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11F44C001DF
	for <git@archiver.kernel.org>; Mon, 24 Jul 2023 08:59:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231371AbjGXI7k (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Jul 2023 04:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbjGXI7i (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Jul 2023 04:59:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 923E111F
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:36 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b7430bda8bso58231131fa.0
        for <git@vger.kernel.org>; Mon, 24 Jul 2023 01:59:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690189174; x=1690793974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aUYIWHiOUGL9HeE3mIamNrpHUC6VZuqKimPzZWkc/U=;
        b=avSvbJSY5QO0qzjXWXT05R+poBRh/4Cn1f7ojhj0WOJ3hXB+laHcRVuwgHXMKGMQvI
         F8Zv6TbL4pukJ/WrN2Gb20XZDSrDckWha8u/AQAjYVZ70OTyxmuIncSrWK1ONdn5m+Cm
         vB4/S3AgmMhFHvrjTLVitMQ3bH2D8ESs5ROM/L13dzpHtxv3ViDkEAPe898mBwcxOmjB
         cd2WIobud1CRQFiGoURF09uVme86ObIQltSlEA61G4x230wNF1l0D4hm66Wv3Ij7hMAg
         9L8OqT4D2fi0qqIGuLfruK3fZUrWID60O9g1H7+aXTvTcBeq+X9DqS7fXPmbX4191Wk7
         /R9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690189174; x=1690793974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aUYIWHiOUGL9HeE3mIamNrpHUC6VZuqKimPzZWkc/U=;
        b=THUzgs5cp2JUEWFnsVyqjfOnWF5PlaHRjz+GE2wodHj4SKvu2CcPhQOIbOjAmThc5P
         BhzAwMQtdkt6BBfokTja8jIeYoslWzE2YnD++aDbMhj1Gr4d3xGKst4uBmrjVXwQlwqP
         ZRm2dy494sN4AS5BvJhDnRNbQ0QlKixgEbok8Lcjm+y//wa39hBPqP2+j1V0yTAdcr2g
         wqsaYAK8TzKoSsa/2/nBoGB26tDzljkk+uvUIwv0iELnNkJo0xSChDM7Xhj09v37T52a
         ETYa9I5AF3kaosRATHKMXZDCZMovOiBSjaFzRFscBr4Ik0W0/pspOeZo0OyuZPRUiPrs
         JEOw==
X-Gm-Message-State: ABy/qLY5kJ5uJJTAYT0jzhuAaFf9f1fKIOMHnXKWEcD01BOVhsHEn7uP
        iQqdU4nDessMQprHBGZxktDxcSF9/vg=
X-Google-Smtp-Source: APBJJlGL5pmuDTuSMNFkvUo0eHIgpMnSLDS51A3IWkoTFp/VoPK6QnJ1gRBzbh3EYQlpJ0v1oBMxvA==
X-Received: by 2002:a2e:95cc:0:b0:2b6:df71:cff1 with SMTP id y12-20020a2e95cc000000b002b6df71cff1mr5869714ljh.52.1690189173777;
        Mon, 24 Jul 2023 01:59:33 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:11c4:4096:3d09:3950:f280:5ec1])
        by smtp.gmail.com with ESMTPSA id rv7-20020a17090710c700b00993a9a951fasm6506665ejb.11.2023.07.24.01.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Jul 2023 01:59:33 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v3 0/8] Repack objects into separate packfiles based on a filter
Date:   Mon, 24 Jul 2023 10:59:01 +0200
Message-ID: <20230724085909.3831831-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.384.ged66511823
In-Reply-To: <20230705060812.2865188-1-christian.couder@gmail.com>
References: <20230705060812.2865188-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

# Intro

Last year, John Cai sent 2 versions of a patch series to implement
`git repack --filter=<filter-spec>` and later I sent 4 versions of a
patch series trying to do it a bit differently:

  - https://lore.kernel.org/git/pull.1206.git.git.1643248180.gitgitgadget@gmail.com/
  - https://lore.kernel.org/git/20221012135114.294680-1-christian.couder@gmail.com/

In these patch series, the `--filter=<filter-spec>` removed the
filtered out objects altogether which was considered very dangerous
even though we implemented different safety checks in some of the
latter series.

In some discussions, it was mentioned that such a feature, or a
similar feature in `git gc`, or in a new standalone command (perhaps
called `git prune-filtered`), should put the filtered out objects into
a new packfile instead of deleting them.

Recently there were internal discussions at GitLab about either moving
blobs from inactive repos onto cheaper storage, or moving large blobs
onto cheaper storage. This lead us to rethink at repacking using a
filter, but moving the filtered out objects into a separate packfile
instead of deleting them.

So here is a new patch series doing that while implementing the
`--filter=<filter-spec>` option in `git repack`.

# Use cases for the new feature

This could be useful for example for the following purposes:

  1) As a way for servers to save storage costs by for example moving
     large blobs, or all the blobs, or all the blobs in inactive
     repos, to separate storage (while still making them accessible
     using for example the alternates mechanism).

  2) As a way to use partial clone on a Git server to offload large
     blobs to, for example, an http server, while using multiple
     promisor remotes (to be able to access everything) on the client
     side. (In this case the packfile that contains the filtered out
     object can be manualy removed after checking that all the objects
     it contains are available through the promisor remote.)

  3) As a way for clients to reclaim some space when they cloned with
     a filter to save disk space but then fetched a lot of unwanted
     objects (for example when checking out old branches) and now want
     to remove these unwanted objects. (In this case they can first
     move the packfile that contains filtered out objects to a
     separate directory or storage, then check that everything works
     well, and then manually remove the packfile after some time.)

As the features and the code are quite different from those in the
previous series, I decided to start a new series instead of continuing
a previous one.

Also since version 2 of this new series, commit messages, don't
mention uses cases like 2) or 3) above, as people have different
opinions on how it should be done. How it should be done could depend
a lot on the way promisor remotes are used, the software and hardware
setups used, etc, so it seems more difficult to "sell" this series by
talking about such use cases. As use case 1) seems simpler and more
appealing, it makes more sense to only talk about it in the commit
messages.

# Changes since version 2

Thanks to Junio who reviewed both version 1 and 2, and to Taylor who
reviewed version 1! The changes are the following:

- In patch 5/8, which introduces `--filter=<filter-spec>` option, some
  explanations about how to find which new packfile contains the
  filtered out objects have been added to the commit message following
  Junio's comments.

- In patch 5/8, it was clarified in the commit message that `git
  pack-objects` is run twice in row (and not in parallel) to implement
  the new option according to Junio's comments.

- In patch 5/8 also, the documentaion of the new option says that
  `--no-write-bitmap-index` (or the ++ `repack.writebitmaps` config
  option set to `false`) should be used along with the option as
  otherwise writing bitmap index will fail. And a corresponding new
  test called '--filter fails with --write-bitmap-index' has been
  added to t/t7700-repack.sh. This should address Taylor's comments
  about v1 that were not addressed by v2.

- In patch 7/8, which implements the `--filter-to=<dir>` option, the
  commit message now recommends using Git alternates mechanism before
  this option is used to make sure the directory specified by the new
  option is accessible by the repo as it could otherwise corrupt the
  repo. It also says that in some cases it might not be necessary to
  use such a mechanism, which is why the feature doesn't check that
  directory specified is accessible. The documentation of the new
  option also loudly warns that the repo could be corrupted if the Git
  alternates mechanism, and has a new link to that mechanism's
  documentation. This is to address Junio's comments.

- In patch 8/8, which implements the `gc.repackFilterTo` config
  option, a similar loud warning has been added, and similar doc
  changes have been made, to the documentation of the new config
  option (which corresponds to the `--filter-to=<dir>` command line
  option).

# Commit overview

* 1/8 pack-objects: allow `--filter` without `--stdout`

  This patch is the same as in v1 and v2. To be able to later repack
  with a filter we need `git pack-objects` to write packfiles when
  it's filtering instead of just writing the pack without the filtered
  out objects to stdout.

* 2/8 t/helper: add 'find-pack' test-tool

  No change in this patch compared to v1 and v2. For testing `git
  repack --filter=...` that we are going to implement, it's useful to
  have a test helper that can tell which packfiles contain a specific
  object.

* 3/8 repack: refactor finishing pack-objects command

  No change in this patch compared to v2. This is a small refactoring
  creating a new useful function, so that `git repack --filter=...`
  will be able to reuse it.

* 4/8 repack: refactor finding pack prefix

  No change in this patch compared to v2. This is another small
  refactoring creating a small function that will be reused in the
  next patch.

* 5/8 repack: add `--filter=<filter-spec>` option

  This actually adds the `--filter=<filter-spec>` option. It uses one
  `git pack-objects` process with the `--filter` option. And then
  another `git pack-objects` process with the `--stdin-packs`
  option. Only the commit message, documentation and tests have been
  changed a bit since v2.

* 6/8 gc: add `gc.repackFilter` config option

  No change in this patch compared to v2 and v1. This is a gc config
  option so that `git gc` can also repack using a filter and put the
  filtered out objects into a separate packfile.

* 7/8 repack: implement `--filter-to` for storing filtered out objects

  For some use cases, it's interesting to create the packfile that
  contains the filtered out objects into a separate location. This is
  similar to the `--expire-to` option for cruft packfiles. Only the
  commit message and the documentation have changed since version
  2. They now explain and discuss the risks of using this option
  without making sure the specified directory is not accessible by the
  repo.

* 8/8 gc: add `gc.repackFilterTo` config option

  This allows specifying the location of the packfile that contains
  the filtered out objects when using `gc.repackFilter`. As with the
  previous commit, since v2, the doc now explain and discuss the risks
  of using this option without making sure the specified directory is
  not accessible by the repo.

# Range-diff since v2

1:  0bd1ad3071 = 1:  4d75a1d7c3 pack-objects: allow `--filter` without `--stdout`
2:  e49cd723c7 = 2:  fdf9b6e8cc t/helper: add 'find-pack' test-tool
3:  3f87772ea6 = 3:  e7cfdebc78 repack: refactor finishing pack-objects command
4:  9997efaf33 = 4:  9c51063795 repack: refactor finding pack prefix
5:  da27ecb91b ! 5:  a90e8045c3 repack: add `--filter=<filter-spec>` option
    @@ Commit message
         This new option puts the objects specified by `<filter-spec>` into a
         separate packfile.
     
    -    This could be useful if, for example, some large blobs take a lot of
    +    This could be useful if, for example, some large blobs take up a lot of
         precious space on fast storage while they are rarely accessed. It could
         make sense to move them into a separate cheaper, though slower, storage.
     
         In other use cases it might make sense to put all the blobs into
         separate storage.
     
    -    This is done by running two `git pack-objects` commands. The first one
    -    is run with `--filter=<filter-spec>`, using the specified filter. It
    -    packs objects while omitting the objects specified by the filter.
    -    Then another `git pack-objects` command is launched using
    +    It's possible to find which new packfile contains the filtered out
    +    objects using one of the following:
    +
    +      - `git verify-pack -v ...`,
    +      - `test-tool find-pack ...`, which a previous commit added,
    +      - `--filter-to=<dir>`, which a following commit will add to specify
    +        where the pack containing the filtered out objects will be.
    +
    +    This feature is implemented by running `git pack-objects` twice in a
    +    row. The first command is run with `--filter=<filter-spec>`, using the
    +    specified filter. It packs objects while omitting the objects specified
    +    by the filter. Then another `git pack-objects` command is launched using
         `--stdin-packs`. We pass it all the previously existing packs into its
         stdin, so that it will pack all the objects in the previously existing
         packs. But we also pass into its stdin, the pack created by the previous
    @@ Documentation/git-repack.txt: depth is 4095.
     +  that objects used in the working directory are not filtered
     +  out. So for the split to fully work, it's best to perform it
     +  in a bare repo and to use the `-a` and `-d` options along with
    -+  this option.  See linkgit:git-rev-list[1] for valid
    -+  `<filter-spec>` forms.
    ++  this option.  Also `--no-write-bitmap-index` (or the
    ++  `repack.writebitmaps` config option set to `false`) should be
    ++  used otherwise writing bitmap index will fail, as it supposes
    ++  a single packfile containing all the objects. See
    ++  linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
     +
      -b::
      --write-bitmap-index::
    @@ t/t7700-repack.sh: test_expect_success 'auto-bitmaps do not complain if unavaila
     +  blob_pack2=$(test-tool -C bare.git find-pack HEAD:file2) &&
     +  test "$blob_pack2" = "$blob_pack"
     +'
    ++
    ++test_expect_success '--filter fails with --write-bitmap-index' '
    ++  test_must_fail git -C bare.git repack -a -d --write-bitmap-index \
    ++          --filter=blob:none &&
    ++
    ++  git -C bare.git repack -a -d --no-write-bitmap-index \
    ++          --filter=blob:none
    ++'
     +
      objdir=.git/objects
      midx=$objdir/pack/multi-pack-index
6:  49e4a184b4 = 6:  335b7f614d gc: add `gc.repackFilter` config option
7:  243c93aad3 ! 7:  b1be7f60b7 repack: implement `--filter-to` for storing filtered out objects
    @@ Commit message
         It would be nice if this new different pack could be created in a
         different directory than the regular pack. This would make it possible
         to move large blobs into a pack on a different kind of storage, for
    -    example cheaper storage. Even in a different directory this pack can be
    -    accessible if, for example, the Git alternates mechanism is used to
    -    point to it.
    +    example cheaper storage.
    +
    +    Even in a different directory, this pack can be accessible if, for
    +    example, the Git alternates mechanism is used to point to it. In fact
    +    not using the Git alternates mechanism can corrupt a repo as the
    +    generated pack containing the filtered objects might not be accessible
    +    from the repo any more. So setting up the Git alternates mechanism
    +    should be done before using this feature if the user wants the repo to
    +    be fully usable while this feature is used.
    +
    +    In some cases, like when a repo has just been cloned or when there is no
    +    other activity in the repo, it's Ok to setup the Git alternates
    +    mechanism afterwards though. It's also Ok to just inspect the generated
    +    packfile containing the filtered objects and then just move it into the
    +    '.git/objects/pack/' directory manually. That's why it's not necessary
    +    for this command to check that the Git alternates mechanism has been
    +    already setup.
     
         While at it, as an example to show that `--filter` and `--filter-to`
         work well with other options, let's also add a test to check that these
    @@ Commit message
     
      ## Documentation/git-repack.txt ##
     @@ Documentation/git-repack.txt: depth is 4095.
    -   this option.  See linkgit:git-rev-list[1] for valid
    -   `<filter-spec>` forms.
    +   a single packfile containing all the objects. See
    +   linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
      
     +--filter-to=<dir>::
     +  Write the pack containing filtered out objects to the
    -+  directory `<dir>`. This can be used for putting the pack on a
    -+  separate object directory that is accessed through the Git
    -+  alternates mechanism. Only useful with `--filter`.
    ++  directory `<dir>`. Only useful with `--filter`. This can be
    ++  used for putting the pack on a separate object directory that
    ++  is accessed through the Git alternates mechanism. **WARNING:**
    ++  If the packfile containing the filtered out objects is not
    ++  accessible, the repo could be considered corrupt by Git as it
    ++  migh not be able to access the objects in that packfile. See
    ++  the `objects` and `objects/info/alternates` sections of
    ++  linkgit:gitrepository-layout[5].
     +
      -b::
      --write-bitmap-index::
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
                                          &existing_nonkept_packs,
     
      ## t/t7700-repack.sh ##
    -@@ t/t7700-repack.sh: test_expect_success 'repacking with a filter works' '
    -   test "$blob_pack2" = "$blob_pack"
    +@@ t/t7700-repack.sh: test_expect_success '--filter fails with --write-bitmap-index' '
    +           --filter=blob:none
      '
      
     +test_expect_success '--filter-to stores filtered out objects' '
8:  8cb3faa74c ! 8:  ed66511823 gc: add `gc.repackFilterTo` config option
    @@ Documentation/config/gc.txt: gc.repackFilter::
     +gc.repackFilterTo::
     +  When repacking and using a filter, see `gc.repackFilter`, the
     +  specified location will be used to create the packfile
    -+  containing the filtered out objects.  See the
    -+  `--filter-to=<dir>` option of linkgit:git-repack[1].
    ++  containing the filtered out objects. **WARNING:** The
    ++  specified location should be accessible, using for example the
    ++  Git alternates mechanism, otherwise the repo could be
    ++  considered corrupt by Git as it migh not be able to access the
    ++  objects in that packfile. See the `--filter-to=<dir>` option
    ++  of linkgit:git-repack[1] and the `objects/info/alternates`
    ++  section of linkgit:gitrepository-layout[5].
     +
      gc.rerereResolved::
        Records of conflicted merge you resolved earlier are


Christian Couder (8):
  pack-objects: allow `--filter` without `--stdout`
  t/helper: add 'find-pack' test-tool
  repack: refactor finishing pack-objects command
  repack: refactor finding pack prefix
  repack: add `--filter=<filter-spec>` option
  gc: add `gc.repackFilter` config option
  repack: implement `--filter-to` for storing filtered out objects
  gc: add `gc.repackFilterTo` config option

 Documentation/config/gc.txt            |  16 +++
 Documentation/git-pack-objects.txt     |   4 +-
 Documentation/git-repack.txt           |  23 ++++
 Makefile                               |   1 +
 builtin/gc.c                           |  10 ++
 builtin/pack-objects.c                 |   8 +-
 builtin/repack.c                       | 162 ++++++++++++++++++-------
 t/helper/test-find-pack.c              |  35 ++++++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/t5317-pack-objects-filter-objects.sh |   8 ++
 t/t6500-gc.sh                          |  23 ++++
 t/t7700-repack.sh                      |  90 ++++++++++++++
 13 files changed, 332 insertions(+), 50 deletions(-)
 create mode 100644 t/helper/test-find-pack.c

-- 
2.41.0.384.ged66511823

