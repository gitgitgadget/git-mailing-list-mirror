Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 5D5151F461
	for <e@80x24.org>; Tue, 14 May 2019 18:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727542AbfENSsA (ORCPT <rfc822;e@80x24.org>);
        Tue, 14 May 2019 14:48:00 -0400
Received: from mail-yb1-f196.google.com ([209.85.219.196]:45978 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726201AbfENSr7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 May 2019 14:47:59 -0400
Received: by mail-yb1-f196.google.com with SMTP id v2so47798ybm.12
        for <git@vger.kernel.org>; Tue, 14 May 2019 11:47:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kkfZwyd2XPzl1/26kyJQWNg9v3n0OiXSvbErJd17AbQ=;
        b=r/ZsSucpnKtzOnqFKeVxPWSgdRsOLrdB2RPMcFff/1GZxLKPBi7PC+JieDmc/izHcS
         s0bS8pTjITCEkjVO+hqejTpjqjOHEl1ctvgyRZS6x3LlC7rjMqxltuir7RQ0edR2IGFd
         NnejOXVmUaZhMb9vxPApHzuzl+UFEwrrsjeZ/sXKL+UAX7HIcP87g7vSlqOUXKeryZia
         /mtGucvdgBfsPhjyey6Fc1HYCUJB/y7HEOrCNgQp6W+8vmQ6Hs4i2QGCN+ICneKreD2y
         1heUdA3UBLNGWiwtUSfo50gr+/livLwQQSG7FTqMZAczylpMG7f932yHEv32yNcRNOAJ
         ppuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kkfZwyd2XPzl1/26kyJQWNg9v3n0OiXSvbErJd17AbQ=;
        b=LGbo9Mnzi207uJllQep93O1WnI7+oXGue2Q3UU4pkYw2WvH/IyyGiC4OHnDLw34dHi
         MfDqxnOZnKDo6oaCv/qG2H1rJ4XaFZpPfpxdXb6kNySVzlQJOX0YOyzWrgFfEIBKjk1w
         DX1+9PR6um4xmqGYjZ4GssyjqHHNclgjAjxjR/hNLZ6vF1ylqi90yvot1IRQaptp4pGV
         gbe4y6xZ53pAPUp5q6t2NNW3zmheEP+hMkgN8P4L2X9xOz4BLWxbGy99CRmw7Dl3XdMe
         F9q0Xm3qg9/ETs3Tr82ILzdbpNAN3J8sUFDwv2xt4jksiya0q8b82PNB8aKJR6i2N9N+
         6zaA==
X-Gm-Message-State: APjAAAXyZ+PhRZHxKlA6xpqt6SbFxwT7HTajL+xZXavbGA2eGvw60HO/
        etEK3wcJ7m4omjffVAp3SpluD9EIZsM=
X-Google-Smtp-Source: APXvYqxI1XaxCHQGzaxur2atYceCwtAS7icmPrk8MukcYBVg9tDW5b1RgVPklqi+FHKdoG69WtcIGw==
X-Received: by 2002:a5b:ac9:: with SMTP id a9mr16866536ybr.160.1557859678319;
        Tue, 14 May 2019 11:47:58 -0700 (PDT)
Received: from linux.mshome.net ([98.122.173.75])
        by smtp.gmail.com with ESMTPSA id u17sm3438627ywu.94.2019.05.14.11.47.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 14 May 2019 11:47:56 -0700 (PDT)
From:   Derrick Stolee <stolee@gmail.com>
X-Google-Original-From: Derrick Stolee <dstolee@microsoft.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, gitster@pobox.com,
        avarab@gmail.com, dstolee@microsoft.com
Subject: [PATCH v6 00/11] Create 'expire' and 'repack' verbs for git-multi-pack-index
Date:   Tue, 14 May 2019 18:47:43 +0000
Message-Id: <20190514184754.3196-1-dstolee@microsoft.com>
X-Mailer: git-send-email 2.22.0.rc0
In-Reply-To: <20190424151428.170316-1-dstolee@microsoft.com>
References: <20190424151428.170316-1-dstolee@microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The multi-pack-index provides a fast way to find an object among a large list
of pack-files. It stores a single pack-reference for each object id, so
duplicate objects are ignored. Among a list of pack-files storing the same
object, the most-recently modified one is used.

Create new subcommands for the multi-pack-index builtin.

* 'git multi-pack-index expire': If we have a pack-file indexed by the
  multi-pack-index, but all objects in that pack are duplicated in
  more-recently modified packs, then delete that pack (and any others like it).
  Delete the reference to that pack in the multi-pack-index.

* 'git multi-pack-index repack --batch-size=<size>': Starting from the oldest
  pack-files covered by the multi-pack-index, find those whose "expected size"
  is below the batch size until we have a collection of packs whose expected
  sizes add up to the batch size. We compute the expected size by multiplying
  the number of referenced objects by the pack-size and dividing by the total
  number of objects in the pack. If the batch-size is zero, then select all
  packs. Create a new pack containing all objects that the multi-pack-index
  references to those packs.

This allows us to create a new pattern for repacking objects: run 'repack'.
After enough time has passed that all Git commands that started before the last
'repack' are finished, run 'expire' again. This approach has some advantages
over the existing "repack everything" model:

1. Incremental. We can repack a small batch of objects at a time, instead of
repacking all reachable objects. We can also limit ourselves to the objects
that do not appear in newer pack-files.

2. Highly Available. By adding a new pack-file (and not deleting the old
pack-files) we do not interrupt concurrent Git commands, and do not suffer
performance degradation. By expiring only pack-files that have no referenced
objects, we know that Git commands that are doing normal object lookups* will
not be interrupted.

* Note: if someone concurrently runs a Git command that uses get_all_packs(),
* then that command could try to read the pack-files and pack-indexes that we
* are deleting during an expire command. Such commands are usually related to
* object maintenance (i.e. fsck, gc, pack-objects) or are related to
* less-often-used features (i.e. fast-import, http-backend, server-info).

We **are using** this approach in VFS for Git to do background maintenance of
the "shared object cache" which is a Git alternate directory filled with
packfiles containing commits and trees. We currently download pack-files on an
hourly basis to keep up-to-date with the central server. The cache servers
supply packs on an hourly and daily basis, so most of the hourly packs become
useless after a new daily pack is downloaded. The 'expire' command would clear
out most of those packs, but many will still remain with fewer than 100 objects
remaining. The 'repack' command (with a batch size of 1-3gb, probably) can
condense the remaining packs in commands that run for 1-3 min at a time. Since
the daily packs range from 100-250mb, we will also combine and condense those
packs.

Updates in V6:

I rebased onto ds/midx-too-many-packs. Thanks, Junio for taking that
change first. There were several subtle things that needed to change to
put this change on top:

* We need a repository struct everywhere since we add pack-files to the
  packed_git list now.

* A FREE_AND_NULL() was dropped after closing a pack because the pack
  is still in the packed_git list after opening.

* I noticed some whitespace problems.

I also expect GMail to munge my added "From:" tags, so it will look
like the author is "stolee@gmail.com" instead of
"dstolee@microsoft.com". Sorry for the continued inconvenience here.

Thanks,
-Stolee

Derrick Stolee (11):
  repack: refactor pack deletion for future use
  Docs: rearrange subcommands for multi-pack-index
  multi-pack-index: prepare for 'expire' subcommand
  midx: simplify computation of pack name lengths
  midx: refactor permutation logic and pack sorting
  multi-pack-index: implement 'expire' subcommand
  multi-pack-index: prepare 'repack' subcommand
  midx: implement midx_repack()
  multi-pack-index: test expire while adding packs
  midx: add test that 'expire' respects .keep files
  t5319-multi-pack-index.sh: test batch size zero

 Documentation/git-multi-pack-index.txt |  32 +-
 builtin/multi-pack-index.c             |  14 +-
 builtin/repack.c                       |  14 +-
 midx.c                                 | 440 +++++++++++++++++++------
 midx.h                                 |   2 +
 packfile.c                             |  28 ++
 packfile.h                             |   7 +
 t/t5319-multi-pack-index.sh            | 184 +++++++++++
 8 files changed, 602 insertions(+), 119 deletions(-)

-- 
2.22.0.rc0

 1:  d8d7629fc0 !  1:  3b424f7c2a repack: refactor pack deletion for future use
    @@ -81,8 +81,8 @@
      --- a/packfile.h
      +++ b/packfile.h
     @@
    - extern void clear_delta_base_cache(void);
    - extern struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
    + void clear_delta_base_cache(void);
    + struct packed_git *add_packed_git(const char *path, size_t path_len, int local);
      
     +/*
     + * Unlink the .pack and associated extension files.
 2:  d8ed299705 =  2:  fe047db570 Docs: rearrange subcommands for multi-pack-index
 3:  166e03dd77 !  3:  b78967a052 multi-pack-index: prepare for 'expire' subcommand
    @@ -42,7 +42,7 @@
      --- a/builtin/multi-pack-index.c
      +++ b/builtin/multi-pack-index.c
     @@
    - #include "midx.h"
    + #include "trace2.h"
      
      static char const * const builtin_multi_pack_index_usage[] = {
     -	N_("git multi-pack-index [--object-dir=<dir>] (write|verify)"),
    @@ -53,9 +53,9 @@
     @@
      		return write_midx_file(opts.object_dir);
      	if (!strcmp(argv[0], "verify"))
    - 		return verify_midx_file(opts.object_dir);
    + 		return verify_midx_file(the_repository, opts.object_dir);
     +	if (!strcmp(argv[0], "expire"))
    -+		return expire_midx_packs(opts.object_dir);
    ++		return expire_midx_packs(the_repository, opts.object_dir);
      
      	die(_("unrecognized verb: %s"), argv[0]);
      }
    @@ -68,7 +68,7 @@
      	return verify_midx_error;
      }
     +
    -+int expire_midx_packs(const char *object_dir)
    ++int expire_midx_packs(struct repository *r, const char *object_dir)
     +{
     +	return 0;
     +}
    @@ -79,8 +79,8 @@
     @@
      int write_midx_file(const char *object_dir);
      void clear_midx_file(struct repository *r);
    - int verify_midx_file(const char *object_dir);
    -+int expire_midx_packs(const char *object_dir);
    + int verify_midx_file(struct repository *r, const char *object_dir);
    ++int expire_midx_packs(struct repository *r, const char *object_dir);
      
      void close_midx(struct multi_pack_index *m);
      
 4:  f82ccd0e16 =  4:  dec7f384ee midx: simplify computation of pack name lengths
 5:  a4ea2a0fe0 =  5:  989d49d0b2 midx: refactor permutation logic and pack sorting
 6:  28b99a74da !  6:  8213541052 multi-pack-index: implement 'expire' subcommand
    @@ -211,7 +211,7 @@
      void clear_midx_file(struct repository *r)
     @@
      
    - int expire_midx_packs(const char *object_dir)
    + int expire_midx_packs(struct repository *r, const char *object_dir)
      {
     -	return 0;
     +	uint32_t i, *count, result = 0;
    @@ -233,7 +233,7 @@
     +		if (count[i])
     +			continue;
     +
    -+		if (prepare_midx_pack(m, i))
    ++		if (prepare_midx_pack(r, m, i))
     +			continue;
     +
     +		if (m->packs[i]->pack_keep)
    @@ -241,7 +241,6 @@
     +
     +		pack_name = xstrdup(m->packs[i]->pack_name);
     +		close_pack(m->packs[i]);
    -+		FREE_AND_NULL(m->packs[i]);
     +
     +		string_list_insert(&packs_to_drop, m->pack_names[i]);
     +		unlink_pack_path(pack_name, 0);
 7:  b1f7b66948 !  7:  1776e36f19 multi-pack-index: prepare 'repack' subcommand
    @@ -65,7 +65,7 @@
      --- a/builtin/multi-pack-index.c
      +++ b/builtin/multi-pack-index.c
     @@
    - #include "midx.h"
    + #include "trace2.h"
      
      static char const * const builtin_multi_pack_index_usage[] = {
     -	N_("git multi-pack-index [--object-dir=<dir>] (write|verify|expire)"),
    @@ -89,11 +89,11 @@
      	};
      
     @@
    - 		return 1;
    - 	}
    + 
    + 	trace2_cmd_mode(argv[0]);
      
     +	if (!strcmp(argv[0], "repack"))
    -+		return midx_repack(opts.object_dir, (size_t)opts.batch_size);
    ++		return midx_repack(the_repository, opts.object_dir, (size_t)opts.batch_size);
     +	if (opts.batch_size)
     +		die(_("--batch-size option is only for 'repack' subcommand"));
     +
    @@ -102,7 +102,7 @@
      	if (!strcmp(argv[0], "verify"))
     @@
      	if (!strcmp(argv[0], "expire"))
    - 		return expire_midx_packs(opts.object_dir);
    + 		return expire_midx_packs(the_repository, opts.object_dir);
      
     -	die(_("unrecognized verb: %s"), argv[0]);
     +	die(_("unrecognized subcommand: %s"), argv[0]);
    @@ -116,7 +116,7 @@
      	return result;
      }
     +
    -+int midx_repack(const char *object_dir, size_t batch_size)
    ++int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
     +{
     +	return 0;
     +}
    @@ -126,9 +126,9 @@
      +++ b/midx.h
     @@
      void clear_midx_file(struct repository *r);
    - int verify_midx_file(const char *object_dir);
    - int expire_midx_packs(const char *object_dir);
    -+int midx_repack(const char *object_dir, size_t batch_size);
    + int verify_midx_file(struct repository *r, const char *object_dir);
    + int expire_midx_packs(struct repository *r, const char *object_dir);
    ++int midx_repack(struct repository *r, const char *object_dir, size_t batch_size);
      
      void close_midx(struct multi_pack_index *m);
      
 8:  6e962fd947 !  8:  ab77ce8afe midx: implement midx_repack()
    @@ -38,9 +38,9 @@
      --- a/midx.c
      +++ b/midx.c
     @@
    - #include "sha1-lookup.h"
      #include "midx.h"
      #include "progress.h"
    + #include "trace2.h"
     +#include "run-command.h"
      
      #define MIDX_SIGNATURE 0x4d494458 /* "MIDX" */
    @@ -49,7 +49,7 @@
      	return result;
      }
      
    --int midx_repack(const char *object_dir, size_t batch_size)
    +-int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
     +struct repack_info {
     +	timestamp_t mtime;
     +	uint32_t referenced_objects;
    @@ -81,7 +81,8 @@
     +	return m->num_packs < 2;
     +}
     +
    -+static int fill_included_packs_batch(struct multi_pack_index *m,
    ++static int fill_included_packs_batch(struct repository *r,
    ++				     struct multi_pack_index *m,
     +				     unsigned char *include_pack,
     +				     size_t batch_size)
     +{
    @@ -92,7 +93,7 @@
     +	for (i = 0; i < m->num_packs; i++) {
     +		pack_info[i].pack_int_id = i;
     +
    -+		if (prepare_midx_pack(m, i))
    ++		if (prepare_midx_pack(r, m, i))
     +			continue;
     +
     +		pack_info[i].mtime = m->packs[i]->mtime;
    @@ -135,9 +136,9 @@
     +		return 1;
     +
      	return 0;
    -+}	
    + }
     +
    -+int midx_repack(const char *object_dir, size_t batch_size)
    ++int midx_repack(struct repository *r, const char *object_dir, size_t batch_size)
     +{
     +	int result = 0;
     +	uint32_t i;
    @@ -152,7 +153,7 @@
     +	include_pack = xcalloc(m->num_packs, sizeof(unsigned char));
     +
     +	if (batch_size) {
    -+		if (fill_included_packs_batch(m, include_pack, batch_size))
    ++		if (fill_included_packs_batch(r, m, include_pack, batch_size))
     +			goto cleanup;
     +	} else if (fill_included_packs_all(m, include_pack))
     +		goto cleanup;
    @@ -200,7 +201,7 @@
     +		close_midx(m);
     +	free(include_pack);
     +	return result;
    - }
    ++}
     
      diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
      --- a/t/t5319-multi-pack-index.sh
 9:  321c8990f8 =  9:  80c7d2e581 multi-pack-index: test expire while adding packs
10:  f7e4e76bfe = 10:  8e243939ef midx: add test that 'expire' respects .keep files
11:  5da2603ed5 = 11:  3ed388f0a8 t5319-multi-pack-index.sh: test batch size zero
     
