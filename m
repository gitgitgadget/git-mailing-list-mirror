Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B000CE7A95
	for <git@archiver.kernel.org>; Mon, 25 Sep 2023 15:25:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbjIYPZq (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Sep 2023 11:25:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232836AbjIYPZp (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Sep 2023 11:25:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B69F109
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:37 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-4053cb57f02so54445965e9.1
        for <git@vger.kernel.org>; Mon, 25 Sep 2023 08:25:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695655535; x=1696260335; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VnKNU+mfsjxFaIaVwguus3bQPT1tubewOkk9Fh1aeBY=;
        b=GpuGugPy5/kSX3nBjr84ZoFKNAcN9xoGp0hzXClznlpOAErxQx9atvizg+sFZ0TpcT
         TT89r49mlyFQcUTs13DDRsfwiRhYcyIuSq/umyQs5QsFp47qw8VqjlCMiD3V/9n83q57
         sXYskcN+TFfd2+204++ODG+dPTKycgzYoQUrJ2aU8Fi3m0IgTFQXhWuMoo2KNRwiI56e
         46n/EhcZ8yN3R+j0Ga/YiZMGpumEwAV2KJSoktph8Rj5YZJYmaAHRM5/PwiFM+22gcyG
         CAV3kJF0+vzWhwCtyCG1m7SjboQrv4FLKIDlYWBxHI0YebSlkEKHmZEPLRfADBhiDiDk
         IeQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695655535; x=1696260335;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VnKNU+mfsjxFaIaVwguus3bQPT1tubewOkk9Fh1aeBY=;
        b=VmjBi0euKxbCrlTcNVti8UK/uL1qgLQ83Y21Dj1V8ojUSmFhV9LclVhzFn88CJAxhl
         uN2Y1oa3WxpL66TPfaIwFbei4IRvcyghyAm9H8/rKOb+925OeTYm9x9YYiHxidyqpbp+
         mE6k1bbzIJw3qhssLAQQVgbItmGNiRZcRrIX/I0BtzjVPBYDjzq4cyPyL36cN2sIToPO
         RqzZXxz+x9QzUqmAX/AuYrvoffT795mTyfzYSanAKiA2pgSBAPDv4JJEr8hJrmRVKdu/
         FaZkvt3DaJp/rW/BdgOzH6e3tN0zfzL8pQCBNgdrJ/zYGFwojuczHPUichYdLWl4geUd
         gXWQ==
X-Gm-Message-State: AOJu0YxjXABCywsncowgjgZonYVZhHiTR5NHoI5Hgo3vsxs4aBHz7MTs
        CfznHjndC+rd00YxhqiiF1Omk1dtQKQW1Q==
X-Google-Smtp-Source: AGHT+IHEiOlQkdY+6QH845doSCMj2pnweXwsrROWyVgS2teidxzDeV48Ed3F/OLRE3bia5tHuwcYTg==
X-Received: by 2002:a05:6000:185:b0:321:8d08:855e with SMTP id p5-20020a056000018500b003218d08855emr5781323wrx.24.1695655535112;
        Mon, 25 Sep 2023 08:25:35 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:105a:e25e:7421:a01e:ee4a:ba03])
        by smtp.gmail.com with ESMTPSA id f1-20020a17090624c100b009ae3e6c342asm6432045ejb.111.2023.09.25.08.25.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 08:25:33 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v7 0/9] Repack objects into separate packfiles based on a filter
Date:   Mon, 25 Sep 2023 17:25:08 +0200
Message-ID: <20230925152517.803579-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.279.g57b2ba444c
In-Reply-To: <20230911150618.129737-1-christian.couder@gmail.com>
References: <20230911150618.129737-1-christian.couder@gmail.com>
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

# Changes since version 6

Thanks to Junio who reviewed or commented on versions 1, 2, 3, 4 and
5, and to Taylor who reviewed or commented on version 1, 3, 4, 5 and
6!  Thanks also to Robert Coup who participated in the discussions
related to version 2 and Peff who participated in the discussions
related to version 4. There are only the following changes since
version 6:

- This series has been rebased on top of bcb6cae296 (The twelfth
  batch, 2023-09-22) to fix conflicts with a `builtin/repack.c`
  refactoring patch series called tb/repack-existing-packs-cleanup by
  Taylor Blau that recently graduated to 'master':

	https://lore.kernel.org/git/cover.1694632644.git.me@ttaylorr.com/
	https://lore.kernel.org/git/xmqqil81wqkx.fsf@gitster.g/

- Patch 6/9 (repack: add `--filter=<filter-spec>` option) has been
  reworked to apply on top of the above mentioned patch series.
  Taylor even posted the fixup patch to apply to this series so that
  it works well on top of his series:
  
    https://lore.kernel.org/git/ZQNKkn0YYLUyN5Ih@nand.local/

I checked that CI tests passes in:

https://github.com/chriscool/git/actions/runs/6300816764

All jobs seem to have succeeded.

# Commit overview

(No changes in any of the patches compared to version 5, except on
patch 6/9.)

* 1/9 pack-objects: allow `--filter` without `--stdout`

  To be able to later repack with a filter we need `git pack-objects`
  to write packfiles when it's filtering instead of just writing the
  pack without the filtered out objects to stdout.

* 2/9 t/helper: add 'find-pack' test-tool

  For testing `git repack --filter=...` that we are going to
  implement, it's useful to have a test helper that can tell which
  packfiles contain a specific object.

* 3/9 repack: refactor finishing pack-objects command

  This is a small refactoring creating a new useful function, so that
  `git repack --filter=...` will be able to reuse it.

* 4/9 repack: refactor finding pack prefix

  This is another small refactoring creating a small function that
  will be reused in the next patch.

* 5/9 pack-bitmap-write: rebuild using new bitmap when remapping

  This patch is new in version 6. It fixes an issue when bitmaps are
  rebuilt that was revealed by this series, and caused a CI test to
  fail.

* 6/9 repack: add `--filter=<filter-spec>` option

  This actually adds the `--filter=<filter-spec>` option. It uses one
  `git pack-objects` process with the `--filter` option. And then
  another `git pack-objects` process with the `--stdin-packs`
  option. This is the only patch changed in version 7.
  
* 7/9 gc: add `gc.repackFilter` config option

  This is a gc config option so that `git gc` can also repack using a
  filter and put the filtered out objects into a separate packfile.

* 8/9 repack: implement `--filter-to` for storing filtered out objects

  For some use cases, it's interesting to create the packfile that
  contains the filtered out objects into a separate location. This is
  similar to the `--expire-to` option for cruft packfiles.

* 9/9 gc: add `gc.repackFilterTo` config option

  This allows specifying the location of the packfile that contains
  the filtered out objects when using `gc.repackFilter`.

# Range-diff since v6

 1:  da931b5082 =  1:  eec0c09731 pack-objects: allow `--filter` without `--stdout`
 2:  10504b3699 =  2:  19c8b8a4b9 t/helper: add 'find-pack' test-tool
 3:  ee12eb8ad7 !  3:  aaaf40bd5d repack: refactor finishing pack-objects command
    @@ builtin/repack.c: static void remove_redundant_bitmaps(struct string_list *inclu
                            const char *destination,
                            const char *pack_prefix,
     @@ builtin/repack.c: static int write_cruft_pack(const struct pack_objects_args *args,
    -                       struct string_list *existing_kept_packs)
    +                       struct existing_packs *existing)
      {
        struct child_process cmd = CHILD_PROCESS_INIT;
     -  struct strbuf line = STRBUF_INIT;
    @@ builtin/repack.c: static int write_cruft_pack(const struct pack_objects_args *ar
      
      int cmd_repack(int argc, const char **argv, const char *prefix)
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    -   struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
    -   struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
    +   struct string_list names = STRING_LIST_INIT_DUP;
    +   struct existing_packs existing = EXISTING_PACKS_INIT;
        struct pack_geometry geometry = { 0 };
     -  struct strbuf line = STRBUF_INIT;
        struct tempfile *refs_snapshot = NULL;
 4:  d197e0c370 =  4:  1eb6bc3f7e repack: refactor finding pack prefix
 5:  abeef5fbad =  5:  b9159e1803 pack-bitmap-write: rebuild using new bitmap when remapping
 6:  31ca2579d3 !  6:  f2f5bb54d3 repack: add `--filter=<filter-spec>` option
    @@ Commit message
         As the interactions with kept packs are a bit tricky, a few related
         tests are added.
     
    +    Helped-by: Taylor Blau <me@ttaylorr.com>
         Signed-off-by: John Cai <johncai86@gmail.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ builtin/repack.c: static int finish_pack_objects_cmd(struct child_process *cmd,
     +static int write_filtered_pack(const struct pack_objects_args *args,
     +                         const char *destination,
     +                         const char *pack_prefix,
    -+                         struct string_list *keep_pack_list,
    -+                         struct string_list *names,
    -+                         struct string_list *existing_packs,
    -+                         struct string_list *existing_kept_packs)
    ++                         struct existing_packs *existing,
    ++                         struct string_list *names)
     +{
     +  struct child_process cmd = CHILD_PROCESS_INIT;
     +  struct string_list_item *item;
     +  FILE *in;
    -+  int ret, i;
    ++  int ret;
     +  const char *caret;
     +  const char *scratch;
     +  int local = skip_prefix(destination, packdir, &scratch);
    @@ builtin/repack.c: static int finish_pack_objects_cmd(struct child_process *cmd,
     +
     +  if (!pack_kept_objects)
     +          strvec_push(&cmd.args, "--honor-pack-keep");
    -+  for (i = 0; i < keep_pack_list->nr; i++)
    -+          strvec_pushf(&cmd.args, "--keep-pack=%s",
    -+                       keep_pack_list->items[i].string);
    ++  for_each_string_list_item(item, &existing->kept_packs)
    ++          strvec_pushf(&cmd.args, "--keep-pack=%s", item->string);
     +
     +  cmd.in = -1;
     +
    @@ builtin/repack.c: static int finish_pack_objects_cmd(struct child_process *cmd,
     +  in = xfdopen(cmd.in, "w");
     +  for_each_string_list_item(item, names)
     +          fprintf(in, "^%s-%s.pack\n", pack_prefix, item->string);
    -+  for_each_string_list_item(item, existing_packs)
    ++  for_each_string_list_item(item, &existing->non_kept_packs)
    ++          fprintf(in, "%s.pack\n", item->string);
    ++  for_each_string_list_item(item, &existing->cruft_packs)
     +          fprintf(in, "%s.pack\n", item->string);
     +  caret = pack_kept_objects ? "" : "^";
    -+  for_each_string_list_item(item, existing_kept_packs)
    ++  for_each_string_list_item(item, &existing->kept_packs)
     +          fprintf(in, "%s%s.pack\n", caret, item->string);
     +  fclose(in);
     +
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     +          ret = write_filtered_pack(&po_args,
     +                                    packtmp,
     +                                    find_pack_prefix(packdir, packtmp),
    -+                                    &keep_pack_list,
    -+                                    &names,
    -+                                    &existing_nonkept_packs,
    -+                                    &existing_kept_packs);
    ++                                    &existing,
    ++                                    &names);
     +          if (ret)
     +                  goto cleanup;
     +  }
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      
        close_object_store(the_repository->objects);
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    -   string_list_clear(&existing_nonkept_packs, 0);
    -   string_list_clear(&existing_kept_packs, 0);
    +   string_list_clear(&names, 1);
    +   existing_packs_release(&existing);
        free_pack_geometry(&geometry);
     +  list_objects_filter_release(&po_args.filter_options);
      
 7:  fa70ae85f2 =  7:  7ea0307628 gc: add `gc.repackFilter` config option
 8:  e01ea3dd70 !  8:  698647815b repack: implement `--filter-to` for storing filtered out objects
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     -                                    packtmp,
     +                                    filter_to,
                                          find_pack_prefix(packdir, packtmp),
    -                                     &keep_pack_list,
    -                                     &names,
    +                                     &existing,
    +                                     &names);
     
      ## t/t7700-repack.sh ##
     @@ t/t7700-repack.sh: test_expect_success '--filter works with --pack-kept-objects and .keep packs' '
 9:  d6ff314189 =  9:  57b2ba444c gc: add `gc.repackFilterTo` config option


Christian Couder (9):
  pack-objects: allow `--filter` without `--stdout`
  t/helper: add 'find-pack' test-tool
  repack: refactor finishing pack-objects command
  repack: refactor finding pack prefix
  pack-bitmap-write: rebuild using new bitmap when remapping
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
 builtin/repack.c                       | 164 ++++++++++++++------
 pack-bitmap-write.c                    |   6 +-
 t/helper/test-find-pack.c              |  50 +++++++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/t0080-find-pack.sh                   |  82 ++++++++++
 t/t5317-pack-objects-filter-objects.sh |   8 +
 t/t6500-gc.sh                          |  24 +++
 t/t7700-repack.sh                      | 197 +++++++++++++++++++++++++
 15 files changed, 544 insertions(+), 51 deletions(-)
 create mode 100644 t/helper/test-find-pack.c
 create mode 100755 t/t0080-find-pack.sh

-- 
2.42.0.279.g57b2ba444c

