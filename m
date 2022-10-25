Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB02C04A95
	for <git@archiver.kernel.org>; Tue, 25 Oct 2022 12:29:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiJYM3b (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 25 Oct 2022 08:29:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229756AbiJYM3a (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 25 Oct 2022 08:29:30 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00A5910077
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:29:26 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id z14so7016726wrn.7
        for <git@vger.kernel.org>; Tue, 25 Oct 2022 05:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zJLes9djk6a8mRbhB4SBA1GvGpGw6f4zecHaEX3xtD4=;
        b=KQNFoeIB658jS0sAU+h/2gVtRl3UEhhDD70jjK09frgj9UZOanLsHOhqvJUTGgpclc
         ueNCXS7LjLFBi0WlAsXtxWgTvbyR7BZ0xTfIMCxDb4BMT960Nus0M8yOrrhvf0UlJ/Fo
         E+waBES6v29rlOlqizjem8pRoehQO7axKg4kzmjizxJjrqJIOFai2g3oEFJC+p50MrXk
         vzl8xF3byXcVP5wvyfOQrlrfnupGr9PU5ZpLiYvFkaJWpe5rK43GpXlmOU3L7FW8Cm4I
         LoV+E6uzBtbXlYuMQAGA7GzRljE1HfJLHtrY/BUhOab8YhDkf0uy+tmPovJJjDD2URzd
         D43A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJLes9djk6a8mRbhB4SBA1GvGpGw6f4zecHaEX3xtD4=;
        b=mRaRZWFIVX+JlcarGxO2jYbirW0/ddrTco6+eGcJyedkIA9reEAIaYcBgCtMbc9w7s
         egfI8VMpyt6TZYcVFr3Ywzt5gb4uDZZUkhv5n8VUAIerg90XfvqfYvPxiFi/tlZFTc2n
         LCDiMNgW+ZXfn2e3KYpZSw8+YfCrnTj0B72T68arqXhnIBXGrIKJkUGTXkuclFJkDqWr
         6cZk8Yd1Gp4njZ1ncdiREZItGucai6s4qsK2pSQbWq3RzKaxcMZC1qD7U8fQxp9UMBpm
         NogSPeYCBofyZCQHyGOT7uxYokyS50GPGNzqoUqWD3C9gAdyJh4jtKnSdo945EPGjCNK
         rF+w==
X-Gm-Message-State: ACrzQf1hPZ0XvieMzPYmmIjLWfqRnQYjlgSHY7Zd7gPOpzillOwaaH4N
        ca0Mh5zxMzn3dnXJjkyFSiGLzjvsJjs=
X-Google-Smtp-Source: AMsMyM4eWKeWxqd6SPAa9omaJn1kYqS+kJYYS4BBBk2wawGd3eTgbB3T5TXmeqkjPC07pVRSvG9WFA==
X-Received: by 2002:a05:6000:1109:b0:236:5d1f:5198 with SMTP id z9-20020a056000110900b002365d1f5198mr11628492wrw.22.1666700964788;
        Tue, 25 Oct 2022 05:29:24 -0700 (PDT)
Received: from Precision-5550.lan (ber13-h01-176-133-175-75.dsl.sta.abo.bbox.fr. [176.133.175.75])
        by smtp.gmail.com with ESMTPSA id e17-20020adffc51000000b00236860e7e9esm686975wrs.98.2022.10.25.05.29.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 05:29:24 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, John Cai <johncai86@gmail.com>,
        Jonathan Tan <jonathantanmy@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Derrick Stolee <stolee@gmail.com>,
        Christian Couder <christian.couder@gmail.com>
Subject: [PATCH v2 0/2] Implement filtering repacks
Date:   Tue, 25 Oct 2022 14:28:54 +0200
Message-Id: <20221025122856.20204-1-christian.couder@gmail.com>
X-Mailer: git-send-email 2.38.1.145.g80cce38e46.dirty
In-Reply-To: <20221012135114.294680-1-christian.couder@gmail.com>
References: <20221012135114.294680-1-christian.couder@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Earlier this year, John Cai sent 2 versions of a patch series to
implement `git repack --filter=<filter-spec>`:

https://lore.kernel.org/git/pull.1206.git.git.1643248180.gitgitgadget@gmail.com/

We tried to "sell" it as a way to use partial clone on a Git server to
offload large blobs to, for example, an http server, while using
multiple promisor remotes on the client side.

Even though it is still our end goal, it seems a bit far fetched for
now and unnecessary as `git repack --filter=<filter-spec>` could be
useful on the client side too.

For example one might want to clone with a filter to avoid too many
space to be taken by some large blobs, and one might realize after
some time that a number of the large blobs have still be downloaded
because some old branches referencing them were checked out. In this
case a filtering repack could remove some of those large blobs.

Some of the comments on the patch series that John sent were related
to the possible data loss and repo corruption that a filtering repack
could cause. It's indeed true that it could be very dangerous, so the
first version of this patch series asked the user to confirm the
command, either by answering 'Y' on the command line or by passing
`--force`.

In the discussion with Junio following that first version though, it
appeared that asking for such confirmation might not be necessary, so
the differences in this v2 compared to the v1 are:

  - the patch 3/3 that introduced the `--force` option has been
    removed,
    
  - the test that checked that the command couldn't be launched
    without a terminal and without --force has been removed,

  - the code that checked if the command was launched from a terminal
    and that asked for confirmation on the command line has been
    removed,

  - the documentation of --filter has been improved to make it clearer
    that objects created locally which haven't been pushed could be
    deleted.

So there are only 2 patches now in this v2 series:

  - Patch 1/2 is a preparatory patch.

  - Patch 2/2 introduces the `--filter=<filter-spec>` option.

In the discussion with Junio following the first version, Junio
suggested adding `--filter=<filter-spec>` to `git gc` and I am still
Ok with doing it, either later in a followup patch or in a v3. I
haven't done it yet, as I think it's better for performance reasons if
anyway the filtering is done underneath by `git repack` (even if for
example the --filter option is undocumented in `git repack`), and I'd
like the approach in this v2 series to be reviewed first.

Thanks to Junio for discussing the v1, to John Cai, who worked
on the previous versions, to Jonathan Nieder, Jonathan Tan and Taylor
Blau, who discussed this with me at the Git Merge and Contributor
Summit, and to Stolee, Taylor, Robert Coup and Junio who discussed the
versions John sent.

Not sure it's very useful as it's quite big, but here is the
range-diff compared to v1:

1:  0ac7ebf48c = 1:  d1c65ff1f5 pack-objects: allow --filter without --stdout
2:  144356a97e ! 2:  ac21b4ec8f repack: add --filter=<filter-spec> option
    @@ Commit message
     
         This command could be dangerous to use though, as it might remove
         local objects that haven't been pushed which would lose data and
    -    corrupt the repo. On a server this command could also corrupt a
    +    corrupt the repo. On a server, this command could also corrupt a
         repo unless ALL the removed objects aren't already available in
         another remote that clients can access.
     
    -    To avoid as much as possible data to be lost and repos to be
    -    corrupted, let's warn users and ask them to confirm that they
    -    really want to use this command.
    -
    -    If no terminal is used, let's just die() for now. A follow-up
    -    commit will introduce a --force option that will allow using
    -    this option when no terminal is available.
    -
    -    It will be easier to test that --filter is working correctly
    -    in the follow-up commit that adds --force, so let's just test
    -    that we die() if no terminal is used for now.
    -
         Signed-off-by: John Cai <johncai86@gmail.com>
         Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
     
    @@ Documentation/git-repack.txt: depth is 4095.
     +--filter=<filter-spec>::
     +  Omits certain objects (usually blobs) from the resulting
     +  packfile. WARNING: this could easily corrupt the current repo
    -+  and lose data if ANY of the omitted objects hasn't been
    -+  already pushed to a remote. See linkgit:git-rev-list[1] for
    -+  valid `<filter-spec>` forms.
    ++  and lose data if ANY of the omitted objects hasn't been already
    ++  pushed to a remote. Be very careful about objects that might
    ++  have been created locally! See linkgit:git-rev-list[1] for valid
    ++  `<filter-spec>` forms.
     +
      -b::
      --write-bitmap-index::
        Write a reachability bitmap index as part of the repack. This
     
      ## builtin/repack.c ##
    -@@
    - #include "pack.h"
    - #include "pack-bitmap.h"
    - #include "refs.h"
    -+#include "prompt.h"
    - 
    - #define ALL_INTO_ONE 1
    - #define LOOSEN_UNREACHABLE 2
     @@ builtin/repack.c: struct pack_objects_args {
        const char *depth;
        const char *threads;
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
                OPT_BOOL(0, "pack-kept-objects", &pack_kept_objects,
                                N_("repack objects in packs marked with .keep")),
                OPT_STRING_LIST(0, "keep-pack", &keep_pack_list, N_("name"),
    -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    -                   die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-k");
    -   }
    - 
    -+  if (po_args.filter) {
    -+          const char *yesno;
    -+
    -+          if (!isatty(STDIN_FILENO))
    -+                  die (_("Repacking with a filter is not allowed "
    -+                         "yet unless a terminal is used!"));
    -+
    -+          /*
    -+           * TRANSLATORS: Make sure to include [y] and [N] in your translation.
    -+           * The program will only accept English input at this point.
    -+           */
    -+          yesno = git_prompt(_("Repacking with a filter will lose data and corrupt the repo\n"
    -+                               "if ANY of the filtered out object hasn't been already pushed!\n"
    -+                               "Repack with a filter anyway [y/N]? "), PROMPT_ECHO);
    -+          if (tolower(*yesno) != 'y')
    -+                  exit(1);
    -+  }
    -+
    -   if (write_bitmaps < 0) {
    -           if (!write_midx &&
    -               (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
                if (line.len != the_hash_algo->hexsz)
                        die(_("repack: Expecting full hex object ID lines only from pack-objects."));
    @@ t/t7700-repack.sh: test_expect_success 'auto-bitmaps do not complain if unavaila
        test_must_be_empty actual
      '
      
    -+test_expect_success 'repacking with a filter is not allowed' '
    -+  test_must_fail git repack -a -d --filter=blob:none 2>actual &&
    -+  test_i18ngrep "Repacking with a filter is not allowed" actual
    ++test_expect_success 'repacking with a filter works' '
    ++  test_when_finished "rm -rf server client" &&
    ++  test_create_repo server &&
    ++  git -C server config uploadpack.allowFilter true &&
    ++  git -C server config uploadpack.allowAnySHA1InWant true &&
    ++  test_commit -C server 1 &&
    ++  git clone --bare --no-local server client &&
    ++  git -C client config remote.origin.promisor true &&
    ++  git -C client rev-list --objects --all --missing=print >objects &&
    ++  test $(grep "^?" objects | wc -l) = 0 &&
    ++  git -C client -c repack.writebitmaps=false repack -a -d --filter=blob:none &&
    ++  git -C client rev-list --objects --all --missing=print >objects &&
    ++  test $(grep "^?" objects | wc -l) = 1
     +'
     +
      objdir=.git/objects
3:  a23e19796e < -:  ---------- repack: introduce --force to force filtering

Christian Couder (2):
  pack-objects: allow --filter without --stdout
  repack: add --filter=<filter-spec> option

 Documentation/git-repack.txt |  8 ++++++++
 builtin/pack-objects.c       |  6 +-----
 builtin/repack.c             | 22 +++++++++++++++-------
 t/t7700-repack.sh            | 15 +++++++++++++++
 4 files changed, 39 insertions(+), 12 deletions(-)

-- 
2.38.1.145.g80cce38e46.dirty

