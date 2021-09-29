Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0DE2C433EF
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6718613C8
	for <git@archiver.kernel.org>; Wed, 29 Sep 2021 01:55:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243608AbhI2B4W (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Sep 2021 21:56:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbhI2B4V (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 28 Sep 2021 21:56:21 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FF7C06161C
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:54:40 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id b6so1184357ilv.0
        for <git@vger.kernel.org>; Tue, 28 Sep 2021 18:54:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oBE/5MQADp8ULQ+7CrCEmr6sChXJQXgq9SPRfEDfCtM=;
        b=pTpj1EyZ/roQoxQNge5BIMZpJcoZ4qJN3q7qUVaw1RWVnPWJHULuhewWE2pMNA9+XT
         RcLK8e66iRnwjh77x7ThM+iEDB2bbmefwblAZUvgvBVMP6yI7N9yQqqB6ambPVlYSkM7
         08onjir5PdERXWL6hfWcaXZ3tbqw6PJmiLoRLIrTBspzX9+VhqUQF+YKkB49r9JCdenv
         2UF8NF4gC9jorHkQWFS5Yn/K4d9qnNoZ9Eql+mezKd01Gfe5pG4zj6dmM1q2Rd5ZNvGY
         kO2MP+EPE2YSi+pDPjCAuhxPDS3M008FNw7g0UeFasxTSNFxDQhC7axL1paR2sWQNQWh
         7L0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBE/5MQADp8ULQ+7CrCEmr6sChXJQXgq9SPRfEDfCtM=;
        b=Ew8qnpvkyVhrAivnqUdYKKI8/RuJykNot0pPoulMvZxyRvgKcxvRzEdhSTIyyzJeiC
         88QyJ4hHhk2cadA+yuVCKOHVhfeYObKDm8TZpEz+Uj8oZVSEO6M/zq3ScyukgzolULNE
         LCbOkJQlH+w+vpx1Byg/EY2wKf0ejYd/il9Pw90ywgaxc0nKzVBmqyFOxSQnriLXT3Vf
         duWYXLFvbwjQHv0PQVwq57EAAnulylnGpeWwAzBnYZ5NYinMT5B6qvBhfyblfpnWKicn
         I6L3QMOohcx/rU2ONP21o1QY06eQFCty82i71hSabRodO7lcFz/blmpDcOPkst1nFoIk
         8FfA==
X-Gm-Message-State: AOAM530Enzt8btm0RW9ASoYBdSRXdZawgPN+ZoIHaLNxCMie5N8wb+AD
        35nualvQi6KeKoEEvjCJ8fiCy8g7lOeCvg==
X-Google-Smtp-Source: ABdhPJxuhalTpCaA9SVCWt/UF/3ie7nraPPFVuNPrU1oo3MJbVB9NaRXsM+ZKvPd/WyQFlAacxZERQ==
X-Received: by 2002:a05:6e02:1402:: with SMTP id n2mr475385ilo.160.1632880479480;
        Tue, 28 Sep 2021 18:54:39 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id k4sm489003ilc.10.2021.09.28.18.54.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Sep 2021 18:54:38 -0700 (PDT)
Date:   Tue, 28 Sep 2021 21:54:37 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, avarab@gmail.com, gitster@pobox.com,
        jonathantanmy@google.com, steadmon@google.com
Subject: [PATCH v3 0/9] repack: introduce `--write-midx`
Message-ID: <cover.1632880469.git.me@ttaylorr.com>
References: <cover.1631730270.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1631730270.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is another small reroll of my series to implement the final component of
multi-pack reachability bitamps, which is to be able to write them from `git
repack`.

This version incorporates feedback from Jonathan Tan and others at Google who
graciously provided review. A range-diff is included below, but the major
changes are:

  - A comment to explain the relationship between 'ctx->m' and 'ctx->to_include'
    in midx.c:add_pack_to_midx().

  - A comment to explain the meaning of write_midx_file_only().

  - Clean-up of stray hunks, a missing strbuf_release().

  - Replacing the name `existing_packs` with `existing_nonkept_packs` to
    emphasize the relationship between it and the similarly-named
    `existing_kept_packs`.

Instead of depending on tb/multi-pack-bitmaps, this series now depends on the
tip of master.

Taylor Blau (9):
  midx: expose `write_midx_file_only()` publicly
  builtin/multi-pack-index.c: support `--stdin-packs` mode
  midx: preliminary support for `--refs-snapshot`
  builtin/repack.c: keep track of existing packs unconditionally
  builtin/repack.c: rename variables that deal with non-kept packs
  builtin/repack.c: extract showing progress to a variable
  builtin/repack.c: support writing a MIDX while repacking
  builtin/repack.c: make largest pack preferred
  builtin/repack.c: pass `--refs-snapshot` when writing bitmaps

 Documentation/git-multi-pack-index.txt |  19 ++
 Documentation/git-repack.txt           |  18 +-
 builtin/multi-pack-index.c             |  36 +++-
 builtin/repack.c                       | 279 ++++++++++++++++++++++---
 midx.c                                 | 110 ++++++++--
 midx.h                                 |  15 +-
 pack-bitmap.c                          |   2 +-
 pack-bitmap.h                          |   1 +
 t/helper/test-read-midx.c              |  25 ++-
 t/lib-midx.sh                          |   8 +
 t/t5319-multi-pack-index.sh            |  15 ++
 t/t5326-multi-pack-bitmaps.sh          |  82 ++++++++
 t/t7700-repack.sh                      |  96 +++++++++
 t/t7703-repack-geometric.sh            |  24 ++-
 14 files changed, 674 insertions(+), 56 deletions(-)
 create mode 100644 t/lib-midx.sh

Range-diff against v2:
 1:  03c1b2c4d3 !  1:  b7c72d0bf5 midx: expose `write_midx_file_only()` publicly
    @@ midx.c: struct write_midx_context {
      
      static void add_pack_to_midx(const char *full_path, size_t full_path_len,
     @@ midx.c: static void add_pack_to_midx(const char *full_path, size_t full_path_len,
    + 
    + 	if (ends_with(file_name, ".idx")) {
      		display_progress(ctx->progress, ++ctx->pack_paths_checked);
    ++		/*
    ++		 * Note that at most one of ctx->m and ctx->to_include are set,
    ++		 * so we are testing midx_contains_pack() and
    ++		 * string_list_has_string() independently (guarded by the
    ++		 * appropriate NULL checks).
    ++		 *
    ++		 * We could support passing to_include while reusing an existing
    ++		 * MIDX, but don't currently since the reuse process drags
    ++		 * forward all packs from an existing MIDX (without checking
    ++		 * whether or not they appear in the to_include list).
    ++		 *
    ++		 * If we added support for that, these next two conditional
    ++		 * should be performed independently (likely checking
    ++		 * to_include before the existing MIDX).
    ++		 */
      		if (ctx->m && midx_contains_pack(ctx->m, file_name))
      			return;
     +		else if (ctx->to_include &&
    @@ midx.c: static int write_midx_internal(const char *object_dir,
      		struct bitmap_index *bitmap_git;
      		int bitmap_exists;
      		int want_bitmap = flags & MIDX_WRITE_BITMAP;
    -@@ midx.c: static int write_midx_internal(const char *object_dir,
    - 
    - 	QSORT(ctx.info, ctx.nr, pack_info_compare);
    - 
    --	if (packs_to_drop && packs_to_drop->nr) {
    -+	if (ctx.m && packs_to_drop && packs_to_drop->nr) {
    - 		int drop_index = 0;
    - 		int missing_drops = 0;
    - 
     @@ midx.c: int write_midx_file(const char *object_dir,
      		    const char *preferred_pack_name,
      		    unsigned flags)
    @@ midx.h: int midx_contains_pack(struct multi_pack_index *m, const char *idx_or_pa
      int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
      
      int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
    ++/*
    ++ * Variant of write_midx_file which writes a MIDX containing only the packs
    ++ * specified in packs_to_include.
    ++ */
     +int write_midx_file_only(const char *object_dir,
     +			 struct string_list *packs_to_include,
     +			 const char *preferred_pack_name,
 2:  59556e5545 =  2:  986ef14f2a builtin/multi-pack-index.c: support `--stdin-packs` mode
 3:  42f1ae9ede !  3:  4e3769a4f3 midx: preliminary support for `--refs-snapshot`
    @@ Commit message
         commit in the MIDX reaches something that isn't.
     
         This can happen when a multi-pack index contains some pack which refers
    -    to loose objects (which by definition aren't included in the multi-pack
    -    index).
    +    to loose objects (e.g., if a pack was pushed after starting the repack
    +    but before generating the MIDX which depends on an object which is
    +    stored as loose in the repository, and by definition isn't included in
    +    the multi-pack index).
     
         By taking a snapshot of the references before we start repacking, we can
         close that race window. In the above scenario (where we have a packed
    @@ midx.c: static void bitmap_show_commit(struct commit *commit, void *_data)
     +	}
     +
     +	fclose(f);
    ++	strbuf_release(&buf);
     +	return 0;
     +}
     +
    @@ midx.h: int fill_midx_entry(struct repository *r, const struct object_id *oid, s
      int prepare_multi_pack_index_one(struct repository *r, const char *object_dir, int local);
      
     -int write_midx_file(const char *object_dir, const char *preferred_pack_name, unsigned flags);
    + /*
    +  * Variant of write_midx_file which writes a MIDX containing only the packs
    +  * specified in packs_to_include.
    +  */
     +int write_midx_file(const char *object_dir,
     +		    const char *preferred_pack_name,
     +		    const char *refs_snapshot,
 4:  c0d045a9de !  4:  1b3dd331ca builtin/repack.c: keep track of existing packs unconditionally
    @@ Commit message
     
      ## builtin/repack.c ##
     @@ builtin/repack.c: static void remove_pack_on_signal(int signo)
    -  * have a corresponding .keep file. These packs are not to
    -  * be kept if we are going to pack everything into one file.
    + }
    + 
    + /*
    +- * Adds all packs hex strings to the fname list, which do not
    +- * have a corresponding .keep file. These packs are not to
    +- * be kept if we are going to pack everything into one file.
    ++ * Adds all packs hex strings to either fname_list or fname_kept_list
    ++ * based on whether each pack has a corresponding .keep file or not.
    ++ * Packs without a .keep file are not to be kept if we are going to
    ++ * pack everything into one file.
       */
     -static void get_non_kept_pack_filenames(struct string_list *fname_list,
     -					const struct string_list *extra_keep)
 -:  ---------- >  5:  15831a201a builtin/repack.c: rename variables that deal with non-kept packs
 5:  09de03de47 =  6:  1a40161baf builtin/repack.c: extract showing progress to a variable
 6:  83dfdb8b12 !  7:  6854f0751d builtin/repack.c: support writing a MIDX while repacking
    @@ Commit message
         check we can make consistently when (1) telling the MIDX which packs we
         want to exclude, and (2) actually unlinking the redundant packs.
     
    +    There is also a tiny change to short-circuit the body of
    +    write_midx_included_packs() when no packs remain in the case of an empty
    +    repository. The MIDX code does not handle this, so avoid trying to
    +    generate a MIDX covering zero packs in the first place.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## Documentation/git-repack.txt ##
    @@ builtin/repack.c: static void clear_pack_geometry(struct pack_geometry *geometry
      }
      
     +static void midx_included_packs(struct string_list *include,
    -+				struct string_list *existing_packs,
    ++				struct string_list *existing_nonkept_packs,
     +				struct string_list *existing_kept_packs,
     +				struct string_list *names,
     +				struct pack_geometry *geometry)
    @@ builtin/repack.c: static void clear_pack_geometry(struct pack_geometry *geometry
     +			string_list_insert(include, strbuf_detach(&buf, NULL));
     +		}
     +	} else {
    -+		for_each_string_list_item(item, existing_packs) {
    ++		for_each_string_list_item(item, existing_nonkept_packs) {
     +			if (item->util)
     +				continue;
     +			string_list_insert(include, xstrfmt("%s.idx", item->string));
    @@ builtin/repack.c: static void clear_pack_geometry(struct pack_geometry *geometry
     +	FILE *in;
     +	int ret;
     +
    ++	if (!include->nr)
    ++		return 0;
    ++
     +	cmd.in = -1;
     +	cmd.git_cmd = 1;
     +
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     +	if (delete_redundant && pack_everything & ALL_INTO_ONE) {
     +		const int hexsz = the_hash_algo->hexsz;
     +		string_list_sort(&names);
    -+		for_each_string_list_item(item, &existing_packs) {
    ++		for_each_string_list_item(item, &existing_nonkept_packs) {
     +			char *sha1;
     +			size_t len = strlen(item->string);
     +			if (len < hexsz)
     +				continue;
     +			sha1 = item->string + len - hexsz;
    ++			/*
    ++			 * Mark this pack for deletion, which ensures that this
    ++			 * pack won't be included in a MIDX (if `--write-midx`
    ++			 * was given) and that we will actually delete this pack
    ++			 * (if `-d` was given).
    ++			 */
     +			item->util = (void*)(intptr_t)!string_list_has_string(&names, sha1);
     +		}
     +	}
     +
     +	if (write_midx) {
     +		struct string_list include = STRING_LIST_INIT_NODUP;
    -+		midx_included_packs(&include, &existing_packs,
    ++		midx_included_packs(&include, &existing_nonkept_packs,
     +				    &existing_kept_packs, &names, geometry);
     +
     +		ret = write_midx_included_packs(&include,
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     -		if (pack_everything & ALL_INTO_ONE) {
     -			const int hexsz = the_hash_algo->hexsz;
     -			string_list_sort(&names);
    --			for_each_string_list_item(item, &existing_packs) {
    +-			for_each_string_list_item(item, &existing_nonkept_packs) {
     -				char *sha1;
     -				size_t len = strlen(item->string);
     -				if (len < hexsz)
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
     -				if (!string_list_has_string(&names, sha1))
     -					remove_redundant_pack(packdir, item->string);
     -			}
    -+		for_each_string_list_item(item, &existing_packs) {
    ++		for_each_string_list_item(item, &existing_nonkept_packs) {
     +			if (!item->util)
     +				continue;
     +			remove_redundant_pack(packdir, item->string);
    @@ t/t7700-repack.sh: test_expect_success 'auto-bitmaps do not complain if unavaila
     +'
     +
      test_done
    +
    + ## t/t7703-repack-geometric.sh ##
    +@@ t/t7703-repack-geometric.sh: test_expect_success '--geometric with no packs' '
    + 	(
    + 		cd geometric &&
    + 
    +-		git repack --geometric 2 >out &&
    ++		git repack --write-midx --geometric 2 >out &&
    + 		test_i18ngrep "Nothing new to pack" out
    + 	)
    + '
 7:  68bc49d8ae !  8:  3596c76daf builtin/repack.c: make largest pack preferred
    @@ builtin/repack.c: static int write_midx_included_packs(struct string_list *inclu
      	if (ret)
      		return ret;
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    - 		midx_included_packs(&include, &existing_packs,
    + 		midx_included_packs(&include, &existing_nonkept_packs,
      				    &existing_kept_packs, &names, geometry);
      
     -		ret = write_midx_included_packs(&include,
 8:  eb24b308ec !  9:  d99f075321 builtin/repack.c: pass `--refs-snapshot` when writing bitmaps
    @@ builtin/repack.c: static void clear_pack_geometry(struct pack_geometry *geometry
     +}
     +
      static void midx_included_packs(struct string_list *include,
    - 				struct string_list *existing_packs,
    + 				struct string_list *existing_nonkept_packs,
      				struct string_list *existing_kept_packs,
     @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
      
-- 
2.33.0.96.g73915697e6
