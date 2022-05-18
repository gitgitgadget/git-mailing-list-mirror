Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8CAC433EF
	for <git@archiver.kernel.org>; Wed, 18 May 2022 23:10:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230415AbiERXKe (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 May 2022 19:10:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229528AbiERXKa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 May 2022 19:10:30 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BD425A7A4
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:10:29 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id 135so787629qkm.4
        for <git@vger.kernel.org>; Wed, 18 May 2022 16:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=izbQ+UXmypGVc0ImlHl/1BKoXlNII7fq6+sIC524fz4=;
        b=RFhHwSUQykDK73OQljot4IL2Qh5hQa2Ws8LNuEipm2S56tfDznyKdSedpHpajzjMGf
         bl0iQg+mlXHtZGB8CgV917fU3XlkqPFahoid0IjLeUhpjVF2ojqUA50hgZGRNkxh7Y9D
         GVfzLqWB6HPD2tKLRQhlh7FFDx/lWnXGS/drH6oBTC7nkdbZoz6GuYiaaEVomNeuagbT
         mqNF+it1PapJZnGasp2qLI8Gcw4B3PeBsADdT7t/Rf3fUjE0kv0zOHeyGbKXGtkSfJVr
         PXM6eDDWo4TTjofBsNx5JHBvYgDUCda+lvq2oTge1hp/6nBP9X7uaMDu/FlYG8G80SwP
         X/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=izbQ+UXmypGVc0ImlHl/1BKoXlNII7fq6+sIC524fz4=;
        b=3LA6MVN1L+89IUGvFBYv+4m8UIq8LK4R5+xJ5cuCBhaoHb70i0LifKmzr+Mq7t5wVB
         2/rERuZ167EwfCOnyj2r9b16c236UYzYij4f+qLNMePSUuqPF4s5dVvUA+l2w33FQ3ZN
         2HY8MYfjOcj6qpNksWeMa8A3j7ZKHNcNK+CmnSoz52f8ImxwvzPMktiVEq81Ls5mpuhd
         GunJRiujlvb2zk0ZebCNHfEQHtyDfId+nG4rSDewHTMlkpHrBf9COCTZC0Nrp6vyzmfp
         H9msk27pESihCVxIvJHfH0EHEMGqQCxuQZhR4DgbUc9g/VpqzG7LqTEuKY9ODoDuUFvr
         tKeA==
X-Gm-Message-State: AOAM532gVD6yHu2apm3Z4k2VJWI0an59Z9boDCdlQkD1ec0NYAMVnY07
        B7YRZJ2TTy3ofhYj2T9hGBu3uit8L4RJR070
X-Google-Smtp-Source: ABdhPJzloVbiCqxy6c6FZXTO34DAS1rlfnHP3vBb776pukB3EsRhXudHoAOiy6OHaxMITdh2ZYApUg==
X-Received: by 2002:a05:620a:675:b0:69f:e556:4593 with SMTP id a21-20020a05620a067500b0069fe5564593mr1356178qkh.360.1652915427984;
        Wed, 18 May 2022 16:10:27 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s201-20020a37a9d2000000b0069fc13ce1e8sm354188qke.25.2022.05.18.16.10.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 May 2022 16:10:27 -0700 (PDT)
Date:   Wed, 18 May 2022 19:10:26 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        jrnieder@gmail.com, larsxschneider@gmail.com, tytso@mit.edu
Subject: [PATCH v4 00/17] cruft packs
Message-ID: <cover.1652915424.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another reroll of my series to implement "cruft packs", which is based
on the v2.36 tree, and incorporates feedback from the discussion we had about
mixed-version GCs with cruft packs in [1].

The changes here are limited to:

  - a cautionary note in Documentation/technical/cruft-packs.txt
    describing the potential interaction between pruning GCs across pre-
    and post-cruft pack versions of Git, as discussed towards the bottom
    of [2]

  - updating the `finalize_hashfile()` calls for writing `.mtimes` files
    to indicate that they are `FSYNC_COMPONENT_PACK_METADATA`, since the
    original version of this series predates the fine-grained fsync
    configuration in 2.36.

As always, a range-diff is below. Thanks in advance for taking another
look!

[1]: https://lore.kernel.org/git/YiZI99yeijQe5Jaq@google.com/
[2]: https://lore.kernel.org/git/YkIm7lnQsUT0JnvS@nand.local/

Taylor Blau (17):
  Documentation/technical: add cruft-packs.txt
  pack-mtimes: support reading .mtimes files
  pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
  chunk-format.h: extract oid_version()
  pack-mtimes: support writing pack .mtimes files
  t/helper: add 'pack-mtimes' test-tool
  builtin/pack-objects.c: return from create_object_entry()
  builtin/pack-objects.c: --cruft without expiration
  reachable: add options to add_unseen_recent_objects_to_traversal
  reachable: report precise timestamps from objects in cruft packs
  builtin/pack-objects.c: --cruft with expiration
  builtin/repack.c: support generating a cruft pack
  builtin/repack.c: allow configuring cruft pack generation
  builtin/repack.c: use named flags for existing_packs
  builtin/repack.c: add cruft packs to MIDX during geometric repack
  builtin/gc.c: conditionally avoid pruning objects via loose
  sha1-file.c: don't freshen cruft packs

 Documentation/Makefile                  |   1 +
 Documentation/config/gc.txt             |  21 +-
 Documentation/config/repack.txt         |   9 +
 Documentation/git-gc.txt                |   5 +
 Documentation/git-pack-objects.txt      |  30 +
 Documentation/git-repack.txt            |  11 +
 Documentation/technical/cruft-packs.txt | 123 ++++
 Documentation/technical/pack-format.txt |  19 +
 Makefile                                |   2 +
 builtin/gc.c                            |  10 +-
 builtin/pack-objects.c                  | 304 +++++++++-
 builtin/repack.c                        | 181 +++++-
 bulk-checkin.c                          |   2 +-
 chunk-format.c                          |  12 +
 chunk-format.h                          |   3 +
 commit-graph.c                          |  18 +-
 midx.c                                  |  18 +-
 object-file.c                           |   4 +-
 object-store.h                          |   7 +-
 pack-mtimes.c                           | 126 ++++
 pack-mtimes.h                           |  15 +
 pack-objects.c                          |   6 +
 pack-objects.h                          |  25 +
 pack-write.c                            |  93 ++-
 pack.h                                  |   4 +
 packfile.c                              |  19 +-
 reachable.c                             |  58 +-
 reachable.h                             |   9 +-
 t/helper/test-pack-mtimes.c             |  56 ++
 t/helper/test-tool.c                    |   1 +
 t/helper/test-tool.h                    |   1 +
 t/t5329-pack-objects-cruft.sh           | 739 ++++++++++++++++++++++++
 32 files changed, 1831 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/technical/cruft-packs.txt
 create mode 100644 pack-mtimes.c
 create mode 100644 pack-mtimes.h
 create mode 100644 t/helper/test-pack-mtimes.c
 create mode 100755 t/t5329-pack-objects-cruft.sh

Range-diff against v3:
 1:  784ee7e0ee !  1:  f494ef7377 Documentation/technical: add cruft-packs.txt
    @@ Documentation/technical/cruft-packs.txt (new)
     +It is linkgit:git-gc[1] that is typically responsible for removing expired
     +unreachable objects.
     +
    ++== Caution for mixed-version environments
    ++
    ++Repositories that have cruft packs in them will continue to work with any older
    ++version of Git. Note, however, that previous versions of Git which do not
    ++understand the `.mtimes` file will use the cruft pack's mtime as the mtime for
    ++all of the objects in it. In other words, do not expect older (pre-cruft pack)
    ++versions of Git to interpret or even read the contents of the `.mtimes` file.
    ++
    ++Note that having mixed versions of Git GC-ing the same repository can lead to
    ++unreachable objects never being completely pruned. This can happen under the
    ++following circumstances:
    ++
    ++  - An older version of Git running GC explodes the contents of an existing
    ++    cruft pack loose, using the cruft pack's mtime.
    ++  - A newer version running GC collects those loose objects into a cruft pack,
    ++    where the .mtime file reflects the loose object's actual mtimes, but the
    ++    cruft pack mtime is "now".
    ++
    ++Repeating this process will lead to unreachable objects not getting pruned as a
    ++result of repeatedly resetting the objects' mtimes to the present time.
    ++
    ++If you are GC-ing repositories in a mixed version environment, consider omitting
    ++the `--cruft` option when using linkgit:git-repack[1] and linkgit:git-gc[1], and
    ++leaving the `gc.cruftPacks` configuration unset until all writers understand
    ++cruft packs.
    ++
     +== Alternatives
     +
     +Notable alternatives to this design include:
 2:  1ec754ad1b =  2:  8f9fd21be9 pack-mtimes: support reading .mtimes files
 3:  0f5d6d6492 =  3:  cdb21236e1 pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
 4:  135a07276b =  4:  1d775f9850 chunk-format.h: extract oid_version()
 5:  0600503856 !  5:  6172861bd9 pack-mtimes: support writing pack .mtimes files
    @@ pack-write.c: const char *write_rev_file_order(const char *rev_name,
     +	if (adjust_shared_perm(mtimes_name) < 0)
     +		die(_("failed to make %s readable"), mtimes_name);
     +
    -+	finalize_hashfile(f, NULL,
    ++	finalize_hashfile(f, NULL, FSYNC_COMPONENT_PACK_METADATA,
     +			  CSUM_HASH_IN_STREAM | CSUM_CLOSE | CSUM_FSYNC);
     +
     +	return mtimes_name;
 6:  4780c8437b =  6:  5f9a9a5b7b t/helper: add 'pack-mtimes' test-tool
 7:  33862a07c9 =  7:  b8a38fe2e4 builtin/pack-objects.c: return from create_object_entry()
 8:  22705e4887 !  8:  94fe03cc65 builtin/pack-objects.c: --cruft without expiration
    @@ builtin/pack-objects.c: static int option_parse_unpack_unreachable(const struct
     +	return 0;
     +}
     +
    - int cmd_pack_objects(int argc, const char **argv, const char *prefix)
    - {
    - 	int use_internal_rev_list = 0;
    + struct po_filter_data {
    + 	unsigned have_revs:1;
    + 	struct rev_info revs;
     @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const char *prefix)
      		OPT_CALLBACK_F(0, "unpack-unreachable", NULL, N_("time"),
      		  N_("unpack unreachable objects newer than <time>"),
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
     +		read_cruft_objects();
      	} else if (!use_internal_rev_list) {
      		read_object_list_from_stdin();
    - 	} else {
    + 	} else if (pfd.have_revs) {
     
      ## object-file.c ##
     @@ object-file.c: int has_loose_object_nonlocal(const struct object_id *oid)
    @@ object-store.h: int repo_has_object_file_with_flags(struct repository *r,
      
     +int has_loose_object(const struct object_id *);
     +
    - void assert_oid_type(const struct object_id *oid, enum object_type expect);
    - 
    - /*
    + /**
    +  * format_object_header() is a thin wrapper around s xsnprintf() that
    +  * writes the initial "<type> <obj-len>" part of the loose object
     
      ## t/t5329-pack-objects-cruft.sh (new) ##
     @@
 9:  cebb30b667 !  9:  da7273f41f reachable: add options to add_unseen_recent_objects_to_traversal
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/pack-objects.c ##
    -@@ builtin/pack-objects.c: static void get_object_list(int ac, const char **av)
    +@@ builtin/pack-objects.c: static void get_object_list(struct rev_info *revs, int ac, const char **av)
      	if (unpack_unreachable_expiration) {
    - 		revs.ignore_missing_links = 1;
    - 		if (add_unseen_recent_objects_to_traversal(&revs,
    + 		revs->ignore_missing_links = 1;
    + 		if (add_unseen_recent_objects_to_traversal(revs,
     -				unpack_unreachable_expiration))
     +				unpack_unreachable_expiration, NULL, 0))
      			die(_("unable to add recent objects"));
    - 		if (prepare_revision_walk(&revs))
    + 		if (prepare_revision_walk(revs))
      			die(_("revision walk setup failed"));
     
      ## reachable.c ##
10:  fa4de8859d = 10:  58fecd1747 reachable: report precise timestamps from objects in cruft packs
11:  92318f8700 = 11:  1740b8ef01 builtin/pack-objects.c: --cruft with expiration
12:  1e94b33cb4 ! 12:  5992a72cbf builtin/repack.c: support generating a cruft pack
    @@ builtin/repack.c
      static int pack_kept_objects = -1;
      static int write_bitmaps = -1;
      static int use_delta_islands;
    + static int run_update_server_info = 1;
      static char *packdir, *packtmp_name, *packtmp;
     +static char *cruft_expiration;
      
      static const char *const git_repack_usage[] = {
      	N_("git repack [<options>]"),
    -@@ builtin/repack.c: static int repack_config(const char *var, const char *value, void *cb)
    - 		use_delta_islands = git_config_bool(var, value);
    - 		return 0;
    - 	}
    -+
    - 	return git_default_config(var, value, cb);
    - }
    - 
     @@ builtin/repack.c: static void repack_promisor_objects(const struct pack_objects_args *args,
      		die(_("could not finish pack-objects to repack promisor objects"));
      }
13:  9cfcd123bd ! 13:  1b241f8f91 builtin/repack.c: allow configuring cruft pack generation
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/config/repack.txt ##
    -@@ Documentation/config/repack.txt: repack.writeBitmaps::
    - 	space and extra time spent on the initial repack.  This has
    - 	no effect if multiple packfiles are created.
    - 	Defaults to true on bare repos, false otherwise.
    +@@ Documentation/config/repack.txt: repack.updateServerInfo::
    + 	If set to false, linkgit:git-repack[1] will not run
    + 	linkgit:git-update-server-info[1]. Defaults to true. Can be overridden
    + 	when true by the `-n` option of linkgit:git-repack[1].
     +
     +repack.cruftWindow::
     +repack.cruftWindowMemory::
    @@ builtin/repack.c: static const char incremental_bitmap_conflict_error[] = N_(
      		delta_base_offset = git_config_bool(var, value);
      		return 0;
     @@ builtin/repack.c: static int repack_config(const char *var, const char *value, void *cb)
    + 		run_update_server_info = git_config_bool(var, value);
      		return 0;
      	}
    - 
     +	if (!strcmp(var, "repack.cruftwindow"))
     +		return git_config_string(&cruft_po_args->window, var, value);
     +	if (!strcmp(var, "repack.cruftwindowmemory"))
    @@ builtin/repack.c: static int repack_config(const char *var, const char *value, v
     +		return git_config_string(&cruft_po_args->depth, var, value);
     +	if (!strcmp(var, "repack.cruftthreads"))
     +		return git_config_string(&cruft_po_args->threads, var, value);
    -+
      	return git_default_config(var, value, cb);
      }
      
    @@ builtin/repack.c: static void remove_redundant_pack(const char *dir_name, const
      				 const struct pack_objects_args *args)
      {
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    + 	int keep_unreachable = 0;
      	struct string_list keep_pack_list = STRING_LIST_INIT_NODUP;
    - 	int no_update_server_info = 0;
      	struct pack_objects_args po_args = {NULL};
     +	struct pack_objects_args cruft_po_args = {NULL};
      	int geometric_factor = 0;
14:  1a58807df0 = 14:  ffae78852c builtin/repack.c: use named flags for existing_packs
15:  ed05cf536b = 15:  0743e373ba builtin/repack.c: add cruft packs to MIDX during geometric repack
16:  1d5f334138 = 16:  9f7e0acac6 builtin/gc.c: conditionally avoid pruning objects via loose
17:  f74b425872 = 17:  07fa9d4b47 sha1-file.c: don't freshen cruft packs
-- 
2.36.1.94.gb0d54bedca
