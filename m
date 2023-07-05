Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7D9BEB64DD
	for <git@archiver.kernel.org>; Wed,  5 Jul 2023 06:08:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbjGEGIo (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 5 Jul 2023 02:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229700AbjGEGIh (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2023 02:08:37 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97757F3
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 23:08:34 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3fbca8935bfso50124135e9.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 23:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688537313; x=1691129313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hl/faSX7D95ofKdelHoPsXjjIcN6eCIHz5IGrhXg3Sg=;
        b=ZotULuhGSel9QjITtHjcCuN6kNl02PjN4B7CWS16XA1nF+aO60vCL/Eqm/KmKKleqS
         9kVNuIszbveO8x6qad4ixRe8lG79222RYltMx7rJLj89JlrOIldshCuaI1n2Zlp1RD+d
         Nhvt194n9cy9PI+T3GTporf6ebDOXWSShLZ7Dhrwmg4WmDMl6LhFK8r9OyTY2cF0CCWr
         0otXG5+1iaelV1LWJLZTODOgqx0pqZkLkeqSxnQMOofJTiINUr5msAQLV8kMnlcNiLcR
         u187/hVSUXTcd9dMmcsB1dLZ/383Isgm2FZkc5jSTVS6TTVW6NVJ4jkaXS8/+d+WYXJ0
         1hQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688537313; x=1691129313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hl/faSX7D95ofKdelHoPsXjjIcN6eCIHz5IGrhXg3Sg=;
        b=jK24dtI6yxegQwHwr/PNYjjNW8loH8LXxvBoIjl5by52yv8PphojlswELRx9RXN2RY
         Vs6jKSxOlz1zq4a7oSWyjEYxmAqajXExCOp70oBjuzA9+Hq1o+quW8NzhNFGWA1RlgtA
         rfUxULSEEimsQITxetHX/aDy4uK7QbdwFtx8F/GbXYyhUAzShDriu9vgKCNZXRuLt8s6
         Mm6SKMBzRzY4a1aLY2FXEBdJdEif8YzWKRPfF0HqH2/68AIlTpaPYnNeufF82IVfBlQy
         uqPxA8VCD9paX03NpTcdRtEHPuMId8DRETBb3r9hX9HIbuYtjrQRVtHbrdCtP3uGISav
         efTA==
X-Gm-Message-State: AC+VfDxokv6WXlbebVbd+y2MWsDeyeKjaXo8pm12MaQibIFGPGZ44aRP
        jRlf3mkbkrhxwjxmrM0OjhgY8zINEe8=
X-Google-Smtp-Source: ACHHUZ7yoYQeTBtdE3cc7DMObTiAWnF0V/fM4yakjn6Yem/k7Fzq6Tqtt52kH9+7QSesfSNES+VZgw==
X-Received: by 2002:a05:600c:364f:b0:3f9:b1e7:8a4b with SMTP id y15-20020a05600c364f00b003f9b1e78a4bmr12222455wmq.21.1688537312158;
        Tue, 04 Jul 2023 23:08:32 -0700 (PDT)
Received: from christian-Precision-5550.lan ([2001:861:3f04:7ca0:f6a2:3135:7895:378b])
        by smtp.gmail.com with ESMTPSA id k15-20020a7bc40f000000b003fbaf9abf2fsm1087762wmi.23.2023.07.04.23.08.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Jul 2023 23:08:31 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/8] Repack objects into separate packfiles based on a filter
Date:   Wed,  5 Jul 2023 08:08:04 +0200
Message-ID: <20230705060812.2865188-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.41.0.244.g8cb3faa74c
In-Reply-To: <20230614192541.1599256-1-christian.couder@gmail.com>
References: <20230614192541.1599256-1-christian.couder@gmail.com>
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

Also since this version 2 of this new series, commit messages, don't
mention uses cases like 2) or 3) above, as people have different
opinions on how it should be done. How it should be done could depend
a lot on the way promisor remotes are used, the software and hardware
setups used, etc, so it seems more difficult to "sell" this series by
talking about such use cases. As use case 1) seems simpler and more
appealing, it makes more sense to only talk about it in the commit
messages.

# Changes since version 1

Thanks to Junio and Taylor who reviewed version 1! The changes are the
following:

- I think that in the long run it might have been better for
  performance reasons to implement the `--filter=...` in `git repack`
  the way it was done in version 1.

  (It was done by first implementing `git pack-objects
  --print-filtered` to print objects omitted by a `--filter=...`
  option, then having `git repack --filter=...` launch such a command,
  read filtered out objects from it, and pipe them into a separate
  `git pack-objects` process that would put them into a separate
  packfile.)

  Anyway our list-objects-filter API is currently not well suited for
  that as it doesn't have a way to output the oids of the filtered out
  objects while the filtering is happening. So version 1 had to get
  them from an oid_set afterwards, which could use a lot of memory.

  As I don't want to have to work on improving the list-objects-filter
  API right now, I think it's better for now to just do as Taylor
  suggested, and as what the cruft code is already doing, which is to
  use the `--stdin-pack` option of `git pack-objects` and to pass it
  packfile names, some prefixed with '^', to let it compute what
  should be in the packfile(s) containing the filtered out objects and
  then to create that(/those) packfile(s).

  So patch 5/8 in version 2 which implements the
  `--filter=<filter-spec>` option in `git repack` is very different
  from patch 6/9 which implemented it in version 1.

- By doing it this way, this version gets rid of patch 2/9 in version
  1 which added the `--print-filtered` option to pack-objects.

- We also get rid of patch 4/9 in version 1 which refactored
  piping an oid to a command.

- On the other hand, we can refactor the code which finds the pack
  prefix into a new small function as this will be needed by the new
  code implementing `--filter=<filter-spec>`, so patch 4/8 in version
  2 is new.

- As suggested by Taylor, a small test has been added to verify that
  `--filter=blob:none` can work without `--stdout` in patch 1/8
  (previously 1/9).

- In patch 3/8 (previously 5/9) which refactors the code to finish a
  pack-objects command into a new function, the `is_local` bit is not
  computed inside the new function anymore as suggested by both Junio
  and Taylor.

- The commit messages of patch 5/8 (previously 6/9) and patch 7/8
  (previously 8/9) that implement the `--filter=<filter-spec>` and
  `--filter-to=<dir>` options respectively have been changed to not
  talk about use cases related to promisor remotes as explained
  towards the end of the "Use cases for the new feature" section
  above.

- Also in patch 5/8 (previously 6/9) that implements the
  `--filter=<filter-spec>`option, the documentation for this section
  has been improved, suggesting to use it on bare repos along with -a
  and -d to get the best possible filtering.

- And in patch 7/8 (previously 8/9) that implements the
  `--filter-to=<dir>` option, a new test has been added to check that
  `--filter=<filter-spec>` and `--filter-to=<dir>` work well with
  the `--max-pack-size=...` option as suggested by Taylor.

- Also in patch 7/8 (previously 8/9) we now check that
  `--filter=<filter-spec>` has been passed and error out if not, as it
  doesn't make sense to use `--filter-to=<dir>` without
  `--filter=<filter-spec>`. This was suggested by Taylor.

- To avoid small merge conflicts in the `git gc` doc, this series has
  been rebased onto 9748a68200 (The sixth batch, 2023-06-29).

# Commit overview

* 1/8 pack-objects: allow `--filter` without `--stdout`

  This patch is the same as the first patch in the previous series and
  in v1. To be able to later repack with a filter we need `git
  pack-objects` to write packfiles when it's filtering instead of just
  writing the pack without the filtered out objects to stdout.

* 2/8 t/helper: add 'find-pack' test-tool

  For testing `git repack --filter=...` that we are going to
  implement, it's useful to have a test helper that can tell which
  packfiles contain a specific object. No change in this patch
  compared to v1.

* 3/8 repack: refactor finishing pack-objects command

  This is a small refactoring creating a new useful function, so that
  `git repack --filter=...` will be able to reuse it. The change
  compared to v1 is that the `is_local` bit is not computed inside the
  new function anymore.

* 4/8 repack: refactor finding pack prefix

  This is a new patch with a small refactoring creating a small
  function that will be reused in the next patch.

* 5/8 repack: add `--filter=<filter-spec>` option

  This actually adds the `--filter=<filter-spec>` option. As explained
  above it works differently than in v1. It now uses one `git
  pack-objects` process with the `--filter` option. And then another
  `git pack-objects` process with the `--stdin-packs` option. Also the
  documentation of the new option has been improved compared to v1.

* 6/8 gc: add `gc.repackFilter` config option

  This is a gc config option so that `git gc` can also repack using a
  filter and put the filtered out objects into a separate packfile. No
  changes compared to v1.

* 7/8 repack: implement `--filter-to` for storing filtered out objects

  For some use cases, it's interesting to create the packfile that
  contains the filtered out objects into a separate location. This is
  similar to the `--expire-to` option for cruft packfiles. Since
  version 1 we now check that `--filter=<filter-spec>` has been passed
  as using `--filter-to` without it doesn't make sense. Also a new
  test has been added to check that these options work well with
  `--max-pack-size=...`.

* 8/8 gc: add `gc.repackFilterTo` config option

  This allows specifying the location of the packfile that contains
  the filtered out objects when using `gc.repackFilter`. No change
  since v1.

# Range-diff

 1:  f4e1cc24d2 !  1:  0bd1ad3071 pack-objects: allow `--filter` without `--stdout`
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
      
        if (stdin_packs && use_internal_rev_list)
                die(_("cannot use internal rev list with --stdin-packs"));
    +
    + ## t/t5317-pack-objects-filter-objects.sh ##
    +@@ t/t5317-pack-objects-filter-objects.sh: test_expect_success 'verify blob:none packfile has no blobs' '
    +   ! grep blob verify_result
    + '
    + 
    ++test_expect_success 'verify blob:none packfile without --stdout' '
    ++  git -C r1 pack-objects --revs --filter=blob:none mypackname >packhash <<-EOF &&
    ++  HEAD
    ++  EOF
    ++  git -C r1 verify-pack -v "mypackname-$(cat packhash).pack" >verify_result &&
    ++  ! grep blob verify_result
    ++'
    ++
    + test_expect_success 'verify normal and blob:none packfiles have same commits/trees' '
    +   git -C r1 verify-pack -v ../all.pack >verify_result &&
    +   grep -E "commit|tree" verify_result |
 2:  8cf3db088e <  -:  ---------- pack-objects: add `--print-filtered` to print omitted objects
 3:  2f3b16281c =  2:  e49cd723c7 t/helper: add 'find-pack' test-tool
 4:  0021a5e3bb <  -:  ---------- repack: refactor piping an oid to a command
 5:  dce5087cc3 !  3:  3f87772ea6 repack: refactor finishing pack-objects command
    @@ builtin/repack.c: static void remove_redundant_bitmaps(struct string_list *inclu
      
     +static int finish_pack_objects_cmd(struct child_process *cmd,
     +                             struct string_list *names,
    -+                             const char *destination)
    ++                             int local)
     +{
    -+  int local = 1;
     +  FILE *out;
     +  struct strbuf line = STRBUF_INIT;
     +
    -+  if (destination) {
    -+          const char *scratch;
    -+          local = skip_prefix(destination, packdir, &scratch);
    -+  }
    -+
     +  out = xfdopen(cmd->out, "r");
     +  while (strbuf_getline_lf(&line, out) != EOF) {
     +          struct string_list_item *item;
    @@ builtin/repack.c: static int write_cruft_pack(const struct pack_objects_args *ar
     -  FILE *in, *out;
     +  FILE *in;
        int ret;
    --  const char *scratch;
    --  int local = skip_prefix(destination, packdir, &scratch);
    - 
    -   prepare_pack_objects(&cmd, args, destination);
    - 
    +   const char *scratch;
    +   int local = skip_prefix(destination, packdir, &scratch);
     @@ builtin/repack.c: static int write_cruft_pack(const struct pack_objects_args *args,
                fprintf(in, "%s.pack\n", item->string);
        fclose(in);
    @@ builtin/repack.c: static int write_cruft_pack(const struct pack_objects_args *ar
     -  strbuf_release(&line);
     -
     -  return finish_command(&cmd);
    -+  return finish_pack_objects_cmd(&cmd, names, destination);
    ++  return finish_pack_objects_cmd(&cmd, names, local);
      }
      
      int cmd_repack(int argc, const char **argv, const char *prefix)
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     -  strbuf_release(&line);
     -  fclose(out);
     -  ret = finish_command(&cmd);
    -+  ret = finish_pack_objects_cmd(&cmd, &names, NULL);
    ++  ret = finish_pack_objects_cmd(&cmd, &names, 1);
        if (ret)
                goto cleanup;
      
 6:  fedde52ca1 <  -:  ---------- repack: add `--filter=<filter-spec>` option
 -:  ---------- >  4:  9997efaf33 repack: refactor finding pack prefix
 -:  ---------- >  5:  da27ecb91b repack: add `--filter=<filter-spec>` option
 7:  6ebd274334 !  6:  49e4a184b4 gc: add `gc.repackFilter` config option
    @@ Commit message
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
      ## Documentation/config/gc.txt ##
    -@@ Documentation/config/gc.txt: or rebase occurring.  Since these changes are not part of the current
    - project most users will want to expire them sooner, which is why the
    - default is more aggressive than `gc.reflogExpire`.
    +@@ Documentation/config/gc.txt: Multiple hooks are supported, but all must exit successfully, else the
    + operation (either generating a cruft pack or unpacking unreachable
    + objects) will be halted.
      
     +gc.repackFilter::
     +  When repacking, use the specified filter to move certain
 8:  5d68501b1f !  7:  243c93aad3 repack: implement `--filter-to` for storing filtered out objects
    @@ Commit message
         accessible if, for example, the Git alternates mechanism is used to
         point to it.
     
    -    If users want to remove a pack that contains filtered out objects after
    -    checking that they are all already on a promisor remote, creating the
    -    pack in a different directory makes it easier to do so.
    +    While at it, as an example to show that `--filter` and `--filter-to`
    +    work well with other options, let's also add a test to check that these
    +    options work well with `--max-pack-size`.
     
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    +    repack: add test with --max-pack-size
    +
      ## Documentation/git-repack.txt ##
     @@ Documentation/git-repack.txt: depth is 4095.
    -   resulting packfile and put them into a separate packfile. See
    -   linkgit:git-rev-list[1] for valid `<filter-spec>` forms.
    +   this option.  See linkgit:git-rev-list[1] for valid
    +   `<filter-spec>` forms.
      
     +--filter-to=<dir>::
     +  Write the pack containing filtered out objects to the
    @@ Documentation/git-repack.txt: depth is 4095.
        Write a reachability bitmap index as part of the repack. This
     
      ## builtin/repack.c ##
    -@@ builtin/repack.c: static void prepare_pack_filtered_cmd(struct child_process *cmd,
    - }
    - 
    - static void finish_pack_filtered_cmd(struct child_process *cmd,
    --                               struct string_list *names)
    -+                               struct string_list *names,
    -+                               const char *destination)
    - {
    -   if (cmd->in == -1) {
    -           /* No packed objects; cmd was never started */
    -@@ builtin/repack.c: static void finish_pack_filtered_cmd(struct child_process *cmd,
    - 
    -   close(cmd->in);
    - 
    --  if (finish_pack_objects_cmd(cmd, names, NULL, NULL))
    -+  if (finish_pack_objects_cmd(cmd, names, destination, NULL))
    -           die(_("could not finish pack-objects to pack filtered objects"));
    - }
    - 
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    +   int write_midx = 0;
        const char *cruft_expiration = NULL;
        const char *expire_to = NULL;
    -   struct child_process pack_filtered_cmd = CHILD_PROCESS_INIT;
     +  const char *filter_to = NULL;
      
        struct option builtin_repack_options[] = {
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
                strvec_push(&cmd.args, "--incremental");
        }
      
    --  if (po_args.filter)
    --          prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, packtmp);
    -+  if (po_args.filter) {
    -+          if (!filter_to)
    -+                  filter_to = packtmp;
    -+          prepare_pack_filtered_cmd(&pack_filtered_cmd, &po_args, filter_to);
    -+  }
    - 
    ++  if (filter_to && !po_args.filter)
    ++          die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
    ++
        if (geometry)
                cmd.in = -1;
    +   else
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
        }
      
    -   if (po_args.filter)
    --          finish_pack_filtered_cmd(&pack_filtered_cmd, &names);
    -+          finish_pack_filtered_cmd(&pack_filtered_cmd, &names, filter_to);
    - 
    -   string_list_sort(&names);
    - 
    +   if (po_args.filter) {
    ++          if (!filter_to)
    ++                  filter_to = packtmp;
    ++
    +           ret = write_filtered_pack(&po_args,
    +-                                    packtmp,
    ++                                    filter_to,
    +                                     find_pack_prefix(),
    +                                     &names,
    +                                     &existing_nonkept_packs,
     
      ## t/t7700-repack.sh ##
     @@ t/t7700-repack.sh: test_expect_success 'repacking with a filter works' '
    @@ t/t7700-repack.sh: test_expect_success 'repacking with a filter works' '
     +  blob_content=$(git -C bare.git show $blob_hash) &&
     +  test "$blob_content" = "content1"
     +'
    ++
    ++test_expect_success '--filter works with --max-pack-size' '
    ++  rm -rf filtered.git &&
    ++  git init --bare filtered.git &&
    ++  git init max-pack-size &&
    ++  (
    ++          cd max-pack-size &&
    ++          test_commit base &&
    ++          # two blobs which exceed the maximum pack size
    ++          test-tool genrandom foo 1048576 >foo &&
    ++          git hash-object -w foo &&
    ++          test-tool genrandom bar 1048576 >bar &&
    ++          git hash-object -w bar &&
    ++          git add foo bar &&
    ++          git commit -m "adding foo and bar"
    ++  ) &&
    ++  git clone --no-local --bare max-pack-size max-pack-size.git &&
    ++  (
    ++          cd max-pack-size.git &&
    ++          git -c repack.writebitmaps=false repack -a -d --filter=blob:none \
    ++                  --max-pack-size=1M \
    ++                  --filter-to=../filtered.git/objects/pack/pack &&
    ++          echo $(cd .. && pwd)/filtered.git/objects >objects/info/alternates &&
    ++
    ++          # Check that the 3 blobs are in different packfiles in filtered.git
    ++          test_stdout_line_count = 3 ls ../filtered.git/objects/pack/pack-*.pack &&
    ++          test_stdout_line_count = 1 ls objects/pack/pack-*.pack &&
    ++          foo_pack=$(test-tool find-pack HEAD:foo) &&
    ++          bar_pack=$(test-tool find-pack HEAD:bar) &&
    ++          base_pack=$(test-tool find-pack HEAD:base.t) &&
    ++          test "$foo_pack" != "$bar_pack" &&
    ++          test "$foo_pack" != "$base_pack" &&
    ++          test "$bar_pack" != "$base_pack" &&
    ++          for pack in "$foo_pack" "$bar_pack" "$base_pack"
    ++          do
    ++                  case "$foo_pack" in */filtered.git/objects/pack/*) true ;; *) return 1 ;; esac
    ++          done
    ++  )
    ++'
     +
      objdir=.git/objects
      midx=$objdir/pack/multi-pack-index
 9:  ae45d9845e =  8:  8cb3faa74c gc: add `gc.repackFilterTo` config option


Christian Couder (8):
  pack-objects: allow `--filter` without `--stdout`
  t/helper: add 'find-pack' test-tool
  repack: refactor finishing pack-objects command
  repack: refactor finding pack prefix
  repack: add `--filter=<filter-spec>` option
  gc: add `gc.repackFilter` config option
  repack: implement `--filter-to` for storing filtered out objects
  gc: add `gc.repackFilterTo` config option

 Documentation/config/gc.txt            |  11 ++
 Documentation/git-pack-objects.txt     |   4 +-
 Documentation/git-repack.txt           |  15 +++
 Makefile                               |   1 +
 builtin/gc.c                           |  10 ++
 builtin/pack-objects.c                 |   8 +-
 builtin/repack.c                       | 162 ++++++++++++++++++-------
 t/helper/test-find-pack.c              |  35 ++++++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/t5317-pack-objects-filter-objects.sh |   8 ++
 t/t6500-gc.sh                          |  23 ++++
 t/t7700-repack.sh                      |  82 +++++++++++++
 13 files changed, 311 insertions(+), 50 deletions(-)
 create mode 100644 t/helper/test-find-pack.c

-- 
2.41.0.244.g8cb3faa74c

