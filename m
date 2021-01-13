Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8247DC43381
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:12:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E9FC2242A
	for <git@archiver.kernel.org>; Thu, 14 Jan 2021 02:12:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730165AbhANCJ6 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jan 2021 21:09:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729297AbhAMWYv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jan 2021 17:24:51 -0500
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D86C061786
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:31 -0800 (PST)
Received: by mail-qk1-x72c.google.com with SMTP id n142so4461290qkn.2
        for <git@vger.kernel.org>; Wed, 13 Jan 2021 14:23:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=JOi+Tl6zopPswUfkEW6mTQtP2sCSWzbpH/RwxKYwLDc=;
        b=Pk3habSBHieJKcjcGut3cUMohSRQCX9HRieIjqdKOXyawbtFAkP2rg+KQeXcMuOHV9
         0U0fJEHzd8PVzHfdHIIv4W0OR0e9uz64xbi7YO2Ufgh49wvfs+g/lFazecgfIARp9Ojq
         q1yBH0sT71hMi0g2T+kAMxgZD6hk179C9WEc4zm/8Fu0ELD5lVuVe06Y1A09e5kd6OnR
         cKTbj5eRiYAcQIpxXvqazBXG/jWCqXaswn4amhfEIbWPHovTqkeVomOoUJC/43zfKQQy
         9ibVc1Z4RzDSNEHtpysc+X6kb07xeqKHO5wa5Eqotd6XeJvwzJMQwfPS7mkxFrvF4x6W
         7ZFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JOi+Tl6zopPswUfkEW6mTQtP2sCSWzbpH/RwxKYwLDc=;
        b=a1Pw6PRqXAvzmrQ2o8VTbekCgZ1vb8JWo60bNc6wsWJ8VTR/776n5lkD3u1ylwbCjJ
         6CYGKPOJQOVFXBg8Bq2/odpMFTfAVaBL4aVEb7yiGkPFy1849rqVYp6dPngtKQxADy7E
         3yXGInXxnvwC2mjuuUQd/gL6D2Hn70E80psreMhgolPAAxptihXPDlk2zkAWAK5Lrnq0
         smd2/m8nL4p/scy6i8Z04FYBLyDaZGP3jt6OaZd2/ExZu9FQgopP43yKNgP1wVKTMJrF
         r4kc/j9pK00UkuAIUvQDoAkQxngVF6GiVdKoeM33JdPJ5URc5eHeSU9Khz7gpMbZ4t88
         V1uw==
X-Gm-Message-State: AOAM530K/pEiIJMvCc3wGp1gMAK0AHhPU/qIPYV1QUXCPmMspUxqipOB
        i8YKa19Q/Th19uqBwa6HD+AkZLy1itWOMg==
X-Google-Smtp-Source: ABdhPJxB+y8E1r50WAdk8jfktM8Aq8OwDEFkN+q5CbjQOUwhk1wQ8DzDEhmqZR1xdmmzfgeMDRyaUQ==
X-Received: by 2002:a05:620a:2149:: with SMTP id m9mr4301164qkm.60.1610576609452;
        Wed, 13 Jan 2021 14:23:29 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:b172:2e4c:efe4:db53])
        by smtp.gmail.com with ESMTPSA id s30sm1876090qte.44.2021.01.13.14.23.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jan 2021 14:23:28 -0800 (PST)
Date:   Wed, 13 Jan 2021 17:23:25 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v2 00/20] pack-revindex: prepare for on-disk reverse index
Message-ID: <cover.1610576604.git.me@ttaylorr.com>
References: <cover.1610129796.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129796.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is a revision of the first of two series to prepare for and introduce an
on-disk alternative for storing the reverse index.

In this revision, I addressed feedback from Junio, Peff, and Stolee. A
range-diff is included below, but the main changes are:

  - Error messages are improved to include the pack and offset when applicable.
  - Variable names were made clearer (e.g., n -> index_pos).
  - Comments were added in pack-revindex.h to introduce relevant terminology,
    and which methods convert between what orderings.
  - int-sized lower- and upper-bounds were converted to be unsigned.

I believe that this revision should be ready for queueing. I'll send a v2 of the
corresponding latter series shortly.

Thanks in advance for your review.

Taylor Blau (20):
  pack-revindex: introduce a new API
  write_reuse_object(): convert to new revindex API
  write_reused_pack_one(): convert to new revindex API
  write_reused_pack_verbatim(): convert to new revindex API
  check_object(): convert to new revindex API
  bitmap_position_packfile(): convert to new revindex API
  show_objects_for_type(): convert to new revindex API
  get_size_by_pos(): convert to new revindex API
  try_partial_reuse(): convert to new revindex API
  rebuild_existing_bitmaps(): convert to new revindex API
  get_delta_base_oid(): convert to new revindex API
  retry_bad_packed_offset(): convert to new revindex API
  packed_object_info(): convert to new revindex API
  unpack_entry(): convert to new revindex API
  for_each_object_in_pack(): convert to new revindex API
  builtin/gc.c: guess the size of the revindex
  pack-revindex: remove unused 'find_pack_revindex()'
  pack-revindex: remove unused 'find_revindex_position()'
  pack-revindex: hide the definition of 'revindex_entry'
  pack-revindex.c: avoid direct revindex access in
    'offset_to_pack_pos()'

 builtin/gc.c           |  2 +-
 builtin/pack-objects.c | 37 +++++++++++++++++---------
 pack-bitmap.c          | 44 +++++++++++++++----------------
 pack-revindex.c        | 51 ++++++++++++++++++++++-------------
 pack-revindex.h        | 60 +++++++++++++++++++++++++++++++++++++-----
 packfile.c             | 54 ++++++++++++++++++++++++-------------
 6 files changed, 168 insertions(+), 80 deletions(-)

Range-diff against v1:
 1:  fa6b830908 <  -:  ---------- pack-revindex: introduce a new API
 -:  ---------- >  1:  e1aa89244a pack-revindex: introduce a new API
 2:  00668523e1 !  2:  0fca7d5812 write_reuse_object(): convert to new revindex API
    @@ builtin/pack-objects.c: static off_t write_reuse_object(struct hashfile *f, stru
     -	revidx = find_pack_revindex(p, offset);
     -	datalen = revidx[1].offset - offset;
     +	if (offset_to_pack_pos(p, offset, &pos) < 0)
    -+		die(_("write_reuse_object: could not locate %s"),
    -+		    oid_to_hex(&entry->idx.oid));
    ++		die(_("write_reuse_object: could not locate %s, expected at "
    ++		      "offset %"PRIuMAX" in pack %s"),
    ++		    oid_to_hex(&entry->idx.oid), (uintmax_t)offset,
    ++		    p->pack_name);
     +	datalen = pack_pos_to_offset(p, pos + 1) - offset;
      	if (!pack_to_stdout && p->index_version > 1 &&
     -	    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
 3:  81ab11e18c !  3:  7676822a54 write_reused_pack_one(): convert to new revindex API
    @@ builtin/pack-objects.c: static void write_reused_pack_one(size_t pos, struct has
      			struct object_id base_oid;
      
     +			if (offset_to_pack_pos(reuse_packfile, base_offset, &base_pos) < 0)
    -+				die(_("expected object at offset %"PRIuMAX),
    -+				    (uintmax_t)base_offset);
    ++				die(_("expected object at offset %"PRIuMAX" "
    ++				      "in pack %s"),
    ++				    (uintmax_t)base_offset,
    ++				    reuse_packfile->pack_name);
     +
      			nth_packed_object_id(&base_oid, reuse_packfile,
     -					     reuse_packfile->revindex[base_pos].nr);
 4:  14b35d01a0 =  4:  dd7133fdb7 write_reused_pack_verbatim(): convert to new revindex API
 5:  c47e77a30e =  5:  8e93ca3886 check_object(): convert to new revindex API
 6:  3b170663dd =  6:  084bbf2145 bitmap_position_packfile(): convert to new revindex API
 7:  bc67bb462a !  7:  68794e9484 show_objects_for_type(): convert to new revindex API
    @@ pack-bitmap.c: static void show_objects_for_type(
      			struct object_id oid;
     -			struct revindex_entry *entry;
     -			uint32_t hash = 0;
    -+			uint32_t hash = 0, n;
    ++			uint32_t hash = 0, index_pos;
     +			off_t ofs;
      
      			if ((word >> offset) == 0)
    @@ pack-bitmap.c: static void show_objects_for_type(
      
     -			entry = &bitmap_git->pack->revindex[pos + offset];
     -			nth_packed_object_id(&oid, bitmap_git->pack, entry->nr);
    -+			n = pack_pos_to_index(bitmap_git->pack, pos + offset);
    ++			index_pos = pack_pos_to_index(bitmap_git->pack, pos + offset);
     +			ofs = pack_pos_to_offset(bitmap_git->pack, pos + offset);
    -+			nth_packed_object_id(&oid, bitmap_git->pack, n);
    ++			nth_packed_object_id(&oid, bitmap_git->pack, index_pos);
      
      			if (bitmap_git->hashes)
     -				hash = get_be32(bitmap_git->hashes + entry->nr);
    -+				hash = get_be32(bitmap_git->hashes + n);
    ++				hash = get_be32(bitmap_git->hashes + index_pos);
      
     -			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, entry->offset);
     +			show_reach(&oid, object_type, 0, hash, bitmap_git->pack, ofs);
 8:  541fe679f3 =  8:  31ac6f5703 get_size_by_pos(): convert to new revindex API
 9:  54f4ad329f !  9:  acd80069a2 try_partial_reuse(): convert to new revindex API
    @@ Commit message
         'pack_pos_to_offset()' instead (the caller here does not care about the
         index position of the object at position 'pos').
     
    -    Somewhat confusingly, the subsequent call to unpack_object_header()
    -    takes a pointer to &offset and then updates it with a new value. But,
    -    try_partial_reuse() cares about the offset of both the base's header and
    -    contents. The existing code made a copy of the offset field, and only
    -    addresses and manipulates one of them.
    -
    -    Instead, store the return of pack_pos_to_offset twice: once in header
    -    and another in offset. Header will be left untouched, but offset will be
    -    addressed and modified by unpack_object_header().
    +    Note that we cannot just use the existing "offset" variable to store the
    +    value we get from pack_pos_to_offset(). It is incremented by
    +    unpack_object_header(), but we later need the original value. Since
    +    we'll no longer have revindex->offset to read it from, we'll store that
    +    in a separate variable ("header" since it points to the entry's header
    +    bytes).
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
10:  97eaa7b2d6 = 10:  569acdca7f rebuild_existing_bitmaps(): convert to new revindex API
11:  e00c434ab2 = 11:  9881637724 get_delta_base_oid(): convert to new revindex API
12:  aae01d7029 = 12:  df8bb571a5 retry_bad_packed_offset(): convert to new revindex API
13:  eab7ab1f35 ! 13:  41b2e00947 packed_object_info(): convert to new revindex API
    @@ packfile.c: int packed_object_info(struct repository *r, struct packed_git *p,
     -		*oi->disk_sizep = revidx[1].offset - obj_offset;
     +		uint32_t pos;
     +		if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
    ++			error("could not find object at offset %"PRIuMAX" "
    ++			      "in pack %s", (uintmax_t)obj_offset, p->pack_name);
     +			type = OBJ_BAD;
     +			goto out;
     +		}
14:  13c49ed40c ! 14:  8ad49d231f unpack_entry(): convert to new revindex API
    @@ Commit message
         Remove direct manipulation of the 'struct revindex_entry' type as well
         as calls to the deprecated API in 'packfile.c:unpack_entry()'. Usual
         clean-up is performed (replacing '->nr' with calls to
    -    'pack_pos_to_index()' and so on). Add an additional check to make
    -    sure that 'obj_offset()' points at a valid object.
    +    'pack_pos_to_index()' and so on).
    +
    +    Add an additional check to make sure that 'obj_offset()' points at a
    +    valid object. In the case this check is violated, we cannot call
    +    'mark_bad_packed_object()' because we don't know the OID. At the top of
    +    the call stack is do_oid_object_info_extended() (via
    +    packed_object_info()), which does mark the object.
     
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
    @@ packfile.c: void *unpack_entry(struct repository *r, struct packed_git *p, off_t
     -			struct revindex_entry *revidx = find_pack_revindex(p, obj_offset);
     -			off_t len = revidx[1].offset - obj_offset;
     -			if (check_pack_crc(p, &w_curs, obj_offset, len, revidx->nr)) {
    -+			uint32_t pos, nr;
    ++			uint32_t pack_pos, index_pos;
     +			off_t len;
     +
    -+			if (offset_to_pack_pos(p, obj_offset, &pos) < 0) {
    ++			if (offset_to_pack_pos(p, obj_offset, &pack_pos) < 0) {
    ++				error("could not find object at offset %"PRIuMAX" in pack %s",
    ++				      (uintmax_t)obj_offset, p->pack_name);
     +				data = NULL;
     +				goto out;
     +			}
     +
    -+			len = pack_pos_to_offset(p, pos + 1) - obj_offset;
    -+			nr = pack_pos_to_index(p, pos);
    -+			if (check_pack_crc(p, &w_curs, obj_offset, len, nr)) {
    ++			len = pack_pos_to_offset(p, pack_pos + 1) - obj_offset;
    ++			index_pos = pack_pos_to_index(p, pack_pos);
    ++			if (check_pack_crc(p, &w_curs, obj_offset, len, index_pos)) {
      				struct object_id oid;
     -				nth_packed_object_id(&oid, p, revidx->nr);
    -+				nth_packed_object_id(&oid, p, nr);
    ++				nth_packed_object_id(&oid, p, index_pos);
      				error("bad packed object CRC for %s",
      				      oid_to_hex(&oid));
      				mark_bad_packed_object(p, oid.hash);
15:  a3249986f9 = 15:  e757476351 for_each_object_in_pack(): convert to new revindex API
16:  7c17db7a7d = 16:  a500311e33 builtin/gc.c: guess the size of the revindex
17:  c4c88bcc3d ! 17:  67d14da04a pack-revindex: remove unused 'find_pack_revindex()'
    @@ pack-revindex.h: struct revindex_entry {
      
     -struct revindex_entry *find_pack_revindex(struct packed_git *p, off_t ofs);
     -
    - int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);
    - uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
    - off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos);
    + /*
    +  * offset_to_pack_pos converts an object offset to a pack position. This
    +  * function returns zero on success, and a negative number otherwise. The
18:  d60411d524 ! 18:  3b5c92be68 pack-revindex: remove unused 'find_revindex_position()'
    @@ Commit message
         until _after_ 'load_pack_revindex()' (which loads the index as a
         side-effect) has been called.
     
    +    Another small fix that is included is converting the upper- and
    +    lower-bounds to be unsigned's instead of ints. This dates back to
    +    92e5c77c37 (revindex: export new APIs, 2013-10-24)--ironically, the last
    +    time we introduced new APIs here--but this unifies the types.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## pack-revindex.c ##
    @@ pack-revindex.c: int load_pack_revindex(struct packed_git *p)
     -int find_revindex_position(struct packed_git *p, off_t ofs)
     +int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
      {
    - 	int lo = 0;
    +-	int lo = 0;
     -	int hi = p->num_objects + 1;
     -	const struct revindex_entry *revindex = p->revindex;
    -+	int hi;
    ++	unsigned lo, hi;
     +	const struct revindex_entry *revindex;
     +
     +	if (load_pack_revindex(p) < 0)
     +		return -1;
     +
    ++	lo = 0;
     +	hi = p->num_objects + 1;
     +	revindex = p->revindex;
      
    @@ pack-revindex.c: int find_revindex_position(struct packed_git *p, off_t ofs)
     -
     -	ret = find_revindex_position(p, ofs);
     -	if (ret < 0)
    --		return -1;
    +-		return ret;
     -	*pos = ret;
     -	return 0;
     -}
    @@ pack-revindex.c: int find_revindex_position(struct packed_git *p, off_t ofs)
     
      ## pack-revindex.h ##
     @@ pack-revindex.h: struct revindex_entry {
    - };
    - 
    +  * given pack, returning zero on success and a negative value otherwise.
    +  */
      int load_pack_revindex(struct packed_git *p);
     -int find_revindex_position(struct packed_git *p, off_t ofs);
      
    - int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);
    - uint32_t pack_pos_to_index(struct packed_git *p, uint32_t pos);
    + /*
    +  * offset_to_pack_pos converts an object offset to a pack position. This
19:  7c0e4acc84 ! 19:  cabafce4a1 pack-revindex: hide the definition of 'revindex_entry'
    @@ pack-revindex.h
     -	unsigned int nr;
     -};
     -
    - int load_pack_revindex(struct packed_git *p);
    - 
    - int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos);
    + /*
    +  * load_pack_revindex populates the revindex's internal data-structures for the
    +  * given pack, returning zero on success and a negative value otherwise.
20:  eada1ffcfa ! 20:  8400ff6c96 pack-revindex.c: avoid direct revindex access in 'offset_to_pack_pos()'
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## pack-revindex.c ##
    -@@ pack-revindex.c: int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
    +@@ pack-revindex.c: int load_pack_revindex(struct packed_git *p)
    + int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_t *pos)
      {
    - 	int lo = 0;
    - 	int hi;
    + 	unsigned lo, hi;
     -	const struct revindex_entry *revindex;
      
      	if (load_pack_revindex(p) < 0)
      		return -1;
      
    + 	lo = 0;
      	hi = p->num_objects + 1;
     -	revindex = p->revindex;
      
-- 
2.30.0.138.g6d7191ea01
