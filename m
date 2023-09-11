Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AD32CA0EC6
	for <git@archiver.kernel.org>; Mon, 11 Sep 2023 21:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348963AbjIKVb6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Sep 2023 17:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241332AbjIKPGv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Sep 2023 11:06:51 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F5DCFA
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:45 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id 2adb3069b0e04-501bef6e0d3so7548025e87.1
        for <git@vger.kernel.org>; Mon, 11 Sep 2023 08:06:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694444803; x=1695049603; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DAAbqJY3mSngthZznOYBlM+SpVP9tPJygP+ot3wOBkE=;
        b=RT4UqSfFSZKh7QYNmsJ3DzViV++LF8VoRiyrBnG9IGOEfvVTqcC/hTLKHkSKAczJB4
         JHzOU7Me53kr2is1XTWM/MgWPJyF34v48zdXldqBdGui/oCul78GCvttnW4XaGJtVwz4
         SO0kb5lYWbF2mPNr3DegMekd1H8ObxEZd/lgwbfEOEZtAubIFJTzcW+OipVlxqipQmEE
         GVAf6j0ef85Z7ECS7uLY/ZFXbzUUI0oQYfP8fwInqzkVdPM/Gx2fHmlrF9/cffESIWjh
         slA7QDLwpOf4m/9flldlwwd86CA99KkQcFjS9wmY+ixe4N3CoHHb3eSOrDX4r4qgPe7/
         PdNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694444803; x=1695049603;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DAAbqJY3mSngthZznOYBlM+SpVP9tPJygP+ot3wOBkE=;
        b=KLjZgI09S6vXdn++vreWlAEvwTR0uNbYABkL1+YVfXWsc56inZRaKLxlyQSGIWnpLY
         rpfH4fEHwv0rLfQ8u0o6s2DLpvkQFj84OX9bSTCoPUxJ1EgXT/fuAcSi4vplga5RCyZv
         /awLI9nQ4WemKwv3+aYx0LWhjvq3Y1GFBrWCw/H/1creNJ3bPhWASpOLBLkpYWB39zTl
         a2U1d2m1F+paVkn6ROfHeVQNgdV9qdNRh1+7QzMm824xuzy4BiFokRnAAShUdoUo6s05
         X94NWB16aBNTWAMkXXOIfrIWiJ11erO3W2J45vR6DIjTbs3Msdmqbi312r1TQEB4odNv
         k+7w==
X-Gm-Message-State: AOJu0Yz9pqa/bNkl+QEZUurIGuqNtZtQVzMWTKhLaQ9PnnnuzSZ/+Z1C
        iaxkMhg4YT0c5kpO9KEON5D/WFD2pmM=
X-Google-Smtp-Source: AGHT+IHzGZSFosp/EwHXAw4LMJQqfaMU8U7LyobLCLwTJGNyf6hYH5QrOQoaHJE/W/X3GLBtHUXgnw==
X-Received: by 2002:ac2:5629:0:b0:4fb:8f79:631 with SMTP id b9-20020ac25629000000b004fb8f790631mr7971250lff.46.1694444802683;
        Mon, 11 Sep 2023 08:06:42 -0700 (PDT)
Received: from christian-Precision-5550.. ([2a04:cec0:1085:31e2:f2be:e47a:b382:4542])
        by smtp.gmail.com with ESMTPSA id f5-20020a170906138500b0099cb1a2cab0sm5485617ejc.28.2023.09.11.08.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 08:06:41 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Patrick Steinhardt <ps@pks.im>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v6 0/9] Repack objects into separate packfiles based on a filter
Date:   Mon, 11 Sep 2023 17:06:09 +0200
Message-ID: <20230911150618.129737-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.42.0.167.gd6ff314189
In-Reply-To: <20230812000011.1227371-1-christian.couder@gmail.com>
References: <20230812000011.1227371-1-christian.couder@gmail.com>
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

# Changes since version 5

Thanks to Junio who reviewed or commented on versions 1, 2, 3, 4 and
5, and to Taylor who reviewed or commented on version 1, 3, 4 and 5!
Thanks also to Robert Coup who participated in the discussions related
to version 2 and Peff who participated in the discussions related to
version 4. There is only the following code change since version 5:

- Patch 5/9 (pack-bitmap-write: rebuild using new bitmap when
  remapping) is new. It fixes a bitmap rebuilding issue that wasn't
  triggered previously but got triggered by this series and caused CI
  tests to fail. The patch is taken from a suggestion by Taylor in:

  https://lore.kernel.org/git/ZNwFlcS3SOS9h77N@nand.local/

  I checked that CI tests now passes in:

  https://github.com/chriscool/git/actions/runs/6122146278

  (There is a failure on 'win test (5)' with "failed: t7527.17
  directory changes to a file", but it looks like it's not related to
  the previous issue and also not related to to this series at all.)

Another change is that this series has been rebased on top of
94e83dcf5b (The seventh batch, 2023-09-07) to fix a few conflicts
related to changes in the geometry code, as can be seen in the
short range-diff below.

# Commit overview

(No changes in any of the patches compared to version 5, except that
patch 5/9 is new.)

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
  option.
  
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

# Range-diff since v5

 1:  bbcc368876 =  1:  da931b5082 pack-objects: allow `--filter` without `--stdout`
 2:  f1b80e5728 =  2:  10504b3699 t/helper: add 'find-pack' test-tool
 3:  ffecc73960 !  3:  ee12eb8ad7 repack: refactor finishing pack-objects command
    @@ builtin/repack.c: static int write_cruft_pack(const struct pack_objects_args *ar
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
        struct string_list existing_nonkept_packs = STRING_LIST_INIT_DUP;
        struct string_list existing_kept_packs = STRING_LIST_INIT_DUP;
    -   struct pack_geometry *geometry = NULL;
    +   struct pack_geometry geometry = { 0 };
     -  struct strbuf line = STRBUF_INIT;
        struct tempfile *refs_snapshot = NULL;
        int i, ext, ret;
 4:  6c2f381a88 =  4:  d197e0c370 repack: refactor finding pack prefix
 -:  ---------- >  5:  abeef5fbad pack-bitmap-write: rebuild using new bitmap when remapping
 5:  134700c2ce !  6:  31ca2579d3 repack: add `--filter=<filter-spec>` option
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     +          strvec_pushf(&cmd.args, "--filter=%s",
     +                       expand_list_objects_filter_spec(&po_args.filter_options));
     +
    -   if (geometry)
    +   if (geometry.split_factor)
                cmd.in = -1;
        else
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
        string_list_clear(&existing_nonkept_packs, 0);
        string_list_clear(&existing_kept_packs, 0);
    -   clear_pack_geometry(geometry);
    +   free_pack_geometry(&geometry);
     +  list_objects_filter_release(&po_args.filter_options);
      
        return ret;
 6:  d3365c7b48 =  7:  fa70ae85f2 gc: add `gc.repackFilter` config option
 7:  9a09382cd1 !  8:  e01ea3dd70 repack: implement `--filter-to` for storing filtered out objects
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     +  else if (filter_to)
     +          die(_("option '%s' can only be used along with '%s'"), "--filter-to", "--filter");
      
    -   if (geometry)
    +   if (geometry.split_factor)
                cmd.in = -1;
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
        }
 8:  a52e3a71db =  9:  d6ff314189 gc: add `gc.repackFilterTo` config option


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
 builtin/repack.c                       | 167 +++++++++++++++------
 pack-bitmap-write.c                    |   6 +-
 t/helper/test-find-pack.c              |  50 +++++++
 t/helper/test-tool.c                   |   1 +
 t/helper/test-tool.h                   |   1 +
 t/t0080-find-pack.sh                   |  82 ++++++++++
 t/t5317-pack-objects-filter-objects.sh |   8 +
 t/t6500-gc.sh                          |  24 +++
 t/t7700-repack.sh                      | 197 +++++++++++++++++++++++++
 15 files changed, 547 insertions(+), 51 deletions(-)
 create mode 100644 t/helper/test-find-pack.c
 create mode 100755 t/t0080-find-pack.sh

-- 
2.42.0.167.gd6ff314189

