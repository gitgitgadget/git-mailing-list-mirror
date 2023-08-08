Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9724BC001DB
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 16:48:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233508AbjHHQsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 12:48:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbjHHQru (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 12:47:50 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF0EC46FF0
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 08:56:56 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4fe0d5f719dso9645929e87.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 08:56:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510182; x=1692114982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BeU3pJPGSD2R2o8UcqZXlwFeg8fkqRHkc1C2xubUkP4=;
        b=GiudZq5Gj72BIQMbPYL/c0p8iBHxHdJObaZX94eJfQBth154TfHD/IlQQgUxhzWcXG
         6/2LI2pBd2N0JEYB5d8yMJbC+/wtgu4rkgp0LN8byMwzdvY7I+uyNzMpEtpKseMcMa14
         r7P5IfuHctY/Znzuvuf9KSgfEW8xwdj0s03PUZLNvqCccdo5+zUTJE4cHJEIFkq3CVTz
         Zx+9X3J/kfyzNZtW/docqscjyHy34ZG+bi09+FE8ri8OseJLMXNIeByM+UrcbYY4Nv7Q
         JzWy/W26bBFXMckoJobDb1cmnJ3pVSpivZLCIuvmNg54+Ma5c6llLvZUBro2lgnvzGLB
         IgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510182; x=1692114982;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BeU3pJPGSD2R2o8UcqZXlwFeg8fkqRHkc1C2xubUkP4=;
        b=Ba75vfK99WBH+SWl0wO1cAuFHe4nnWBUPviB8ZEIOwSLX2F4yjkps+dwonXlhcjpKa
         rCEQ/Hk025MoJp8xxLTvLveMG+NoAKeK5/1JYezEy8B7qq+Hs7kNYGl8NnRgsF4gvyhq
         teF+glCApl7HiWhhkUKIwuXtR69XhcbsEVdfdbiR5vlsUvYKfGQREW1+6oxLyzPBOQxU
         SM6nYZ5m44bJVFPeh2jLgnn9WqFi4JEevIXwVmj7OyaRgztyjDQ1H+qBdkb+GXiQtzrY
         /EqYATfJ2QVpYB9W7Lj1F2UVo/JrNp2dwPeVN7JPpj0AyPRIvZxvGcTycd4HxJhEysuX
         Vc6A==
X-Gm-Message-State: AOJu0YwQSA4SlLIA/qnGrYxREDIydqx+37Z2ZqIW9eZtXm0Fe/kLSgtd
        EcHFahrifqtvi7L6KkH9TfLo2dliI3Q=
X-Google-Smtp-Source: AGHT+IHDajGqVR63HeWMB91aLbB2YN2SeF+rRcW7M4kRABJ6SgGBI4ZtvWtAQarqkC9fyeVfVqqWmA==
X-Received: by 2002:a05:6512:3685:b0:4fe:3a2f:681 with SMTP id d5-20020a056512368500b004fe3a2f0681mr6556664lfs.23.1691483188391;
        Tue, 08 Aug 2023 01:26:28 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:2420:9770:9200:db98:c1c8:97d0])
        by smtp.gmail.com with ESMTPSA id d17-20020a5d6dd1000000b003140fff4f75sm12845707wrz.17.2023.08.08.01.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 01:26:27 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v4 0/8] Repack objects into separate packfiles based on a filter
Date:   Tue,  8 Aug 2023 10:26:00 +0200
Message-ID: <20230808082608.582319-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.rc0.8.g76fac86b0e
In-Reply-To: <20230724085909.3831831-1-christian.couder@gmail.com>
References: <20230724085909.3831831-1-christian.couder@gmail.com>
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

# Changes since version 3

Thanks to Junio who reviewed both version 1, 2 and 3, and to Taylor
who reviewed version 1 and 3! The changes are the following:

- In patch 2/8, which introduces `test-tool find-pack`, a new
  `--check-count <n>` option has been added to check the number of
  packfiles an object is in. To keep things simple and extendable, the
  parse-options API is now used to parse arguments and options.

- Also in patch 2/8, a test script 't0080-find-pack.sh' has been
  introduced to test `test-tool find-pack`, as suggested by Taylor.

- In patch 4/8, which refactors code into a find_pack_prefix()
  function, this function has been changed to accept a `packdir` and a
  `packtmp` argument, instead of using the global variables with the
  same names, as suggested by Taylor.

- In patch 5/8, which introduces `--filter=<filter-spec>` option, a
  `struct list_objects_filter_option` and some related functions and
  macros are now used to handle these options, instead of a character
  string. This allows more than one `--filter=<filter-spec>` option to
  be passed, and a new test has been added to check that this works,
  as suggested by Taylor.

- In patch 5/8, some changes have been made to better handle kept
  packfiles and related tests have been added to check that this works
  well, as suggested by Taylor.

- In patch 5/8, a comment about the 'names' variable has been
  shortened a lot and improved a bit with additional useful
  information, as suggested by Taylor.

- Also in patch 5/8, tests have been improved and shortened by using
  the new `--check-count <n>` option of `test-tool find-pack`.

- Also in patch 5/8, the test that checks that `--filter=...` fails
  with `--write-bitmap-index` has been changed to use
  GIT_TEST_MULTI_PACK_INDEX_WRITE_BITMAP=0 which should fix a CI test
  that sets this variable to 1. This test has also been simplified by
  removing a useless call to `repack --filter=...` as suggested by
  Taylor.

- Also in patch 5/8, the commit message has been improved a bit and
  now only talks about the use case of moving some blobs that take up
  precious space to a cheaper storage, as suggested by Junio.

- In patch 6/8, which implements the `gc.repackFilter` config option,
  a line in the tests that was too long has been split over 2 lines,
  as suggested by Taylor.

- In patch 7/8, which implements the `--filter-to=<dir>` option, the
  documentation of that option talking about possible corruption has
  been clarified a bit, as suggested by Junio.

- Also in patch 7/8, tests have been improved and shortened by using
  the new `--check-count <n>` option of `test-tool find-pack`.

# Commit overview

* 1/8 pack-objects: allow `--filter` without `--stdout`

  This patch is the same as in v1, v2 and v3. To be able to later
  repack with a filter we need `git pack-objects` to write packfiles
  when it's filtering instead of just writing the pack without the
  filtered out objects to stdout.

* 2/8 t/helper: add 'find-pack' test-tool

  For testing `git repack --filter=...` that we are going to
  implement, it's useful to have a test helper that can tell which
  packfiles contain a specific object. Since v3 the new
  `--check-count <n>` option has been added, and tests have been added
  in a new 't0080-find-pack.sh' test script.

* 3/8 repack: refactor finishing pack-objects command

  No change in this patch compared to v2 and v3. This is a small
  refactoring creating a new useful function, so that `git repack
  --filter=...` will be able to reuse it.

* 4/8 repack: refactor finding pack prefix

  This is another small refactoring creating a small function that
  will be reused in the next patch. Since v3 the new function
  introduced in this patch has been changed to accept a `packdir` and
  a `packtmp` argument, instead of using the global variables with the
  same names.

* 5/8 repack: add `--filter=<filter-spec>` option

  This actually adds the `--filter=<filter-spec>` option. It uses one
  `git pack-objects` process with the `--filter` option. And then
  another `git pack-objects` process with the `--stdin-packs`
  option. A lot of changes have been made since v3:

    - The `list_objects_filter_option` struct and some related
      functions and macros are used to handle the new
      `--filter=<filter-spec>` option. A new test has been added to
      check that using multiple such options works.

    - Handling of kept packfiles has been improved and related tests
      have been added.

    - A comment about the 'names' variable has been shortened a lot
      and improved a bit.

    - Tests have been improved and shortened by using the new
      `--check-count <n>` option of `test-tool find-pack`.

    - The test that checks that `--filter=...` fails with
      `--write-bitmap-index` has been improved to pass a CI test and
      shortened.

    - The commit message has been improved a bit.

* 6/8 gc: add `gc.repackFilter` config option

  This is a gc config option so that `git gc` can also repack using a
  filter and put the filtered out objects into a separate
  packfile. Since v3, a line in the tests that was too long has been
  split over 2 lines.

* 7/8 repack: implement `--filter-to` for storing filtered out objects

  For some use cases, it's interesting to create the packfile that
  contains the filtered out objects into a separate location. This is
  similar to the `--expire-to` option for cruft packfiles. Since v3,
  documentation of that option talking about possible corruption has
  been clarified a bit, and tests have been improved and shortened by
  using the new `--check-count <n>` option of `test-tool find-pack`.

* 8/8 gc: add `gc.repackFilterTo` config option

  No change in this patch compared to v3. This allows specifying the
  location of the packfile that contains the filtered out objects when
  using `gc.repackFilter`.

# Range-diff since v3

(Sorry, but the range-diff doesn't show changes in patches 2/8 and 5/8
as there has been a lot of changes in them. Instead it shows that the
old commit has been removed and a new one added.)

1:  4d75a1d7c3 = 1:  4d75a1d7c3 pack-objects: allow `--filter` without `--stdout`
2:  fdf9b6e8cc < -:  ---------- t/helper: add 'find-pack' test-tool
-:  ---------- > 2:  0bf9f53158 t/helper: add 'find-pack' test-tool
3:  e7cfdebc78 = 3:  54060d775e repack: refactor finishing pack-objects command
4:  9c51063795 ! 4:  948ea541ae repack: refactor finding pack prefix
    @@ builtin/repack.c: static int write_cruft_pack(const struct pack_objects_args *ar
        return finish_pack_objects_cmd(&cmd, names, local);
      }
      
    -+static const char *find_pack_prefix(void)
    ++static const char *find_pack_prefix(char *packdir, char *packtmp)
     +{
     +  const char *pack_prefix;
     +  if (!skip_prefix(packtmp, packdir, &pack_prefix))
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     -                      packtmp, packdir);
     -          if (*pack_prefix == '/')
     -                  pack_prefix++;
    -+          const char *pack_prefix = find_pack_prefix();
    ++          const char *pack_prefix = find_pack_prefix(packdir, packtmp);
      
                if (!cruft_po_args.window)
                        cruft_po_args.window = po_args.window;
5:  a90e8045c3 < -:  ---------- repack: add `--filter=<filter-spec>` option
-:  ---------- > 5:  0635425289 repack: add `--filter=<filter-spec>` option
6:  335b7f614d ! 6:  bf8be2c812 gc: add `gc.repackFilter` config option
    @@ t/t6500-gc.sh: test_expect_success 'one of gc.reflogExpire{Unreachable,}=never d
     +  git -C bare.git -c gc.cruftPacks=false gc &&
     +  test_stdout_line_count = 1 ls bare.git/objects/pack/*.pack &&
     +
    -+  GIT_TRACE=$(pwd)/trace.out git -C bare.git -c gc.repackFilter=blob:none -c repack.writeBitmaps=false -c gc.cruftPacks=false gc &&
    ++  GIT_TRACE=$(pwd)/trace.out git -C bare.git -c gc.repackFilter=blob:none \
    ++          -c repack.writeBitmaps=false -c gc.cruftPacks=false gc &&
     +  test_stdout_line_count = 2 ls bare.git/objects/pack/*.pack &&
     +  grep -E "^trace: (built-in|exec|run_command): git repack .* --filter=blob:none ?.*" trace.out
     +'
7:  b1be7f60b7 ! 7:  abe7526222 repack: implement `--filter-to` for storing filtered out objects
    @@ Commit message
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    -    repack: add test with --max-pack-size
    -
      ## Documentation/git-repack.txt ##
     @@ Documentation/git-repack.txt: depth is 4095.
        a single packfile containing all the objects. See
    @@ Documentation/git-repack.txt: depth is 4095.
     +  used for putting the pack on a separate object directory that
     +  is accessed through the Git alternates mechanism. **WARNING:**
     +  If the packfile containing the filtered out objects is not
    -+  accessible, the repo could be considered corrupt by Git as it
    -+  migh not be able to access the objects in that packfile. See
    -+  the `objects` and `objects/info/alternates` sections of
    ++  accessible, the repo can become corrupt as it might not be
    ++  possible to access the objects in that packfile. See the
    ++  `objects` and `objects/info/alternates` sections of
     +  linkgit:gitrepository-layout[5].
     +
      -b::
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
        };
      
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    -           strvec_push(&cmd.args, "--incremental");
    -   }
    - 
    -+  if (filter_to && !po_args.filter)
    +   if (po_args.filter_options.choice)
    +           strvec_pushf(&cmd.args, "--filter=%s",
    +                        expand_list_objects_filter_spec(&po_args.filter_options));
    ++  else if (filter_to)
     +          die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
    -+
    + 
        if (geometry)
                cmd.in = -1;
    -   else
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
        }
      
    -   if (po_args.filter) {
    +   if (po_args.filter_options.choice) {
     +          if (!filter_to)
     +                  filter_to = packtmp;
     +
                ret = write_filtered_pack(&po_args,
     -                                    packtmp,
     +                                    filter_to,
    -                                     find_pack_prefix(),
    +                                     find_pack_prefix(packdir, packtmp),
    +                                     &keep_pack_list,
                                          &names,
    -                                     &existing_nonkept_packs,
     
      ## t/t7700-repack.sh ##
    -@@ t/t7700-repack.sh: test_expect_success '--filter fails with --write-bitmap-index' '
    -           --filter=blob:none
    +@@ t/t7700-repack.sh: test_expect_success '--filter works with --pack-kept-objects and .keep packs' '
    +   )
      '
      
     +test_expect_success '--filter-to stores filtered out objects' '
    @@ t/t7700-repack.sh: test_expect_success '--filter fails with --write-bitmap-index
     +  test_stdout_line_count = 1 ls bare.git/objects/pack/pack-*.pack &&
     +  test_stdout_line_count = 1 ls filtered.git/objects/pack/pack-*.pack &&
     +
    -+  commit_pack=$(test-tool -C bare.git find-pack HEAD) &&
    -+  test -n "$commit_pack" &&
    -+  blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
    -+  test -z "$blob_pack" &&
    ++  commit_pack=$(test-tool -C bare.git find-pack -c 1 HEAD) &&
    ++  blob_pack=$(test-tool -C bare.git find-pack -c 0 HEAD:file1) &&
     +  blob_hash=$(git -C bare.git rev-parse HEAD:file1) &&
     +  test -n "$blob_hash" &&
    -+  blob_pack=$(test-tool -C filtered.git find-pack $blob_hash) &&
    -+  test -n "$blob_pack" &&
    ++  blob_pack=$(test-tool -C filtered.git find-pack -c 1 $blob_hash) &&
     +
     +  echo $(pwd)/filtered.git/objects >bare.git/objects/info/alternates &&
    -+  blob_pack=$(test-tool -C bare.git find-pack HEAD:file1) &&
    -+  test -n "$blob_pack" &&
    ++  blob_pack=$(test-tool -C bare.git find-pack -c 1 HEAD:file1) &&
     +  blob_content=$(git -C bare.git show $blob_hash) &&
     +  test "$blob_content" = "content1"
     +'
    @@ t/t7700-repack.sh: test_expect_success '--filter fails with --write-bitmap-index
     +          # Check that the 3 blobs are in different packfiles in filtered.git
     +          test_stdout_line_count = 3 ls ../filtered.git/objects/pack/pack-*.pack &&
     +          test_stdout_line_count = 1 ls objects/pack/pack-*.pack &&
    -+          foo_pack=$(test-tool find-pack HEAD:foo) &&
    -+          bar_pack=$(test-tool find-pack HEAD:bar) &&
    -+          base_pack=$(test-tool find-pack HEAD:base.t) &&
    ++          foo_pack=$(test-tool find-pack -c 1 HEAD:foo) &&
    ++          bar_pack=$(test-tool find-pack -c 1 HEAD:bar) &&
    ++          base_pack=$(test-tool find-pack -c 1 HEAD:base.t) &&
     +          test "$foo_pack" != "$bar_pack" &&
     +          test "$foo_pack" != "$base_pack" &&
     +          test "$bar_pack" != "$base_pack" &&
8:  ed66511823 = 8:  ccdc858f73 gc: add `gc.repackFilterTo` config option


Christian Couder (8):
  pack-objects: allow `--filter` without `--stdout`
  t/helper: add 'find-pack' test-tool
  repack: refactor finishing pack-objects command
  repack: refactor finding pack prefix
  repack: add `--filter=<filter-spec>` option
  gc: add `gc.repackFilter` config option
  repack: implement `--filter-to` for storing filtered out objects
  gc: add `gc.repackFilterTo` config option

 Documentation/config/gc.txt            |  16 ++
 Documentation/git-pack-objects.txt     |   4 +-
 Documentation/git-repack.txt           |  23 +++
 Makefile                               |   1 +
 builtin/gc.c                           |  10 ++
 builtin/pack-objects.c                 |   8 +-
 builtin/repack.c                       | 169 +++++++++++++++------
 t/helper/test-find-pack.c              |  50 +++++++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/t0080-find-pack.sh                   |  82 +++++++++++
 t/t5317-pack-objects-filter-objects.sh |   8 +
 t/t6500-gc.sh                          |  24 +++
 t/t7700-repack.sh                      | 196 +++++++++++++++++++++++++
 14 files changed, 543 insertions(+), 50 deletions(-)
 create mode 100644 t/helper/test-find-pack.c
 create mode 100755 t/t0080-find-pack.sh

-- 
2.42.0.rc0.8.g76fac86b0e

