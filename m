Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F333DC433DB
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9C1722AAA
	for <git@archiver.kernel.org>; Mon, 25 Jan 2021 23:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732878AbhAYXiC (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 25 Jan 2021 18:38:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731266AbhAYXhy (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 18:37:54 -0500
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C3EFC061574
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:14 -0800 (PST)
Received: by mail-qk1-x735.google.com with SMTP id k193so14338591qke.6
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 15:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tWw2rilH60qQIiIRiRVUe4ix619HzBC9wru4TZ11kUo=;
        b=KZuWU7GrGZpjp90Yd87jW3IjDn5b+iiZAEtJhDiV2RULYSllz2z5HcSL/PogYrsjKR
         aIWb31L/TpRQ4Hve3CJhWlnCN77cPaX31ssNZYDl45kIVz9EAHwctUL/pBo1GvNrbf/X
         7701pqWUmUffA5UDTHMN0sh3SPpeljk80OOlwkVLRO0cng1fJWVDIESOZvMa8m06o5RD
         UxAV8CDAjXw5KBkz9gG/Xa/SSCjyGbpk//5KTBmj8T1JNCjef/+w6KmteWxEos+/agfN
         ZACpyqGZ2fmQ9raS/lk1HqUjxO08WQcvOJWLOFFe+9mrD7GCjDlRGvvn+xGVFRykVTJB
         s67A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tWw2rilH60qQIiIRiRVUe4ix619HzBC9wru4TZ11kUo=;
        b=N2myXnwRtCy8PNC9yvLKjtHTby9BD3qlqN5A//nPWWNcFVY6tBuU8B5bBHlYscFypu
         F1NjNVQQWUK4rLrHj07GD+zVkL0HjR2w82eOOqTU+WTkeD0qyyFdGJe7mHIiPS7uHSKJ
         jmpdYDWKhLOUYj8APuFgWgOXg+vTls0U62ZqTyryRQzKfwLzUmiTJPvLBDlqZqZTpR30
         FNP/Fg7lKb1w9SKNVYTmUs7huDOspxs0nuS0qm8TOrVKnLVz0WAI1+WEDFa/CW31kfsS
         hyPxyWQ7pRG8WLeoWyr7D6o4D3/Blr9KDw0xrx0hfaXSDdyt4gPNGjsCHjY/9Puxn1ag
         mD8A==
X-Gm-Message-State: AOAM531F5v4fASVHevkwTtMGmaHbuqTlZGp3+WV6Ueal5pw8wvelpQyk
        uUvlYi515LvasS+3e+2AJypxZd8q5Biiiw==
X-Google-Smtp-Source: ABdhPJzovgmfIrHzjjKOz6TXeLfq/8oVcXC7gocQOdxq1Kj1wlw7YoYglAfrR4I/lW6K97TIVYh9kg==
X-Received: by 2002:a37:6206:: with SMTP id w6mr3310233qkb.102.1611617832964;
        Mon, 25 Jan 2021 15:37:12 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id 193sm3240959qki.28.2021.01.25.15.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 15:37:12 -0800 (PST)
Date:   Mon, 25 Jan 2021 18:37:09 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     dstolee@microsoft.com, gitster@pobox.com, jrnieder@gmail.com,
        peff@peff.net
Subject: [PATCH v3 00/10] pack-revindex: introduce on-disk '.rev' format
Message-ID: <cover.1611617819.git.me@ttaylorr.com>
References: <cover.1610129989.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1610129989.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Here is a third reroll of my series to introduce an on-disk format for the
reverse index. Since the first series (to introduce a new API) has been merged
to 'next', this series has been rebased onto 'next', too.

This version is largely unchanged from the previous, with the following
exceptions:

  - Some commit messages and documentation have been clarified to address
    reviewer questions (including why we don't want to store offsets in the .rev
    file, and that all four-byte numbers are in network order, etc.).

  - A few more things are done on opening the revindex file, namely checking
    that the version/hash ID are known.

  - The idiom "load in memory" has been removed.

  - Other minor changes.

A range diff is below.

Thanks in advance for your review.

Taylor Blau (10):
  packfile: prepare for the existence of '*.rev' files
  pack-write.c: prepare to write 'pack-*.rev' files
  builtin/index-pack.c: allow stripping arbitrary extensions
  builtin/index-pack.c: write reverse indexes
  builtin/pack-objects.c: respect 'pack.writeReverseIndex'
  Documentation/config/pack.txt: advertise 'pack.writeReverseIndex'
  t: prepare for GIT_TEST_WRITE_REV_INDEX
  t: support GIT_TEST_WRITE_REV_INDEX
  pack-revindex: ensure that on-disk reverse indexes are given
    precedence
  t5325: check both on-disk and in-memory reverse index

 Documentation/config/pack.txt           |   7 ++
 Documentation/git-index-pack.txt        |  18 ++-
 Documentation/technical/pack-format.txt |  20 ++++
 builtin/index-pack.c                    |  69 +++++++++--
 builtin/pack-objects.c                  |   9 ++
 builtin/repack.c                        |   1 +
 ci/run-build-and-tests.sh               |   1 +
 object-store.h                          |   3 +
 pack-revindex.c                         | 148 ++++++++++++++++++++++--
 pack-revindex.h                         |  14 ++-
 pack-write.c                            | 120 ++++++++++++++++++-
 pack.h                                  |   4 +
 packfile.c                              |  13 ++-
 packfile.h                              |   1 +
 t/README                                |   3 +
 t/t5319-multi-pack-index.sh             |   5 +-
 t/t5325-reverse-index.sh                | 142 +++++++++++++++++++++++
 t/t5604-clone-reference.sh              |   2 +-
 t/t5702-protocol-v2.sh                  |  12 +-
 t/t6500-gc.sh                           |   6 +-
 t/t9300-fast-import.sh                  |   5 +-
 tmp-objdir.c                            |   6 +-
 22 files changed, 567 insertions(+), 42 deletions(-)
 create mode 100755 t/t5325-reverse-index.sh

Range-diff against v2:
21:  6742c15c84 !  1:  6f8b70ab27 packfile: prepare for the existence of '*.rev' files
    @@ Commit message
         is versioned, so we are free to pursue these in the future.) But, cold
         cache performance likely isn't interesting outside of one-off cases like
         asking for the size of an object directly. In real-world usage, Git is
    -    often performing many operations in the revindex,
    +    often performing many operations in the revindex (i.e., asking about
    +    many objects rather than a single one).

         The trade-off is worth it, since we will avoid the vast majority of the
         cost of generating the revindex that the extra pointer chase will look
    @@ Documentation/technical/pack-format.txt: Pack file entry: <+
     +
     +  - A 4-byte magic number '0x52494458' ('RIDX').
     +
    -+  - A 4-byte version identifier (= 1)
    ++  - A 4-byte version identifier (= 1).
     +
    -+  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256)
    ++  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
     +
    -+  - A table of index positions, sorted by their corresponding offsets in the
    -+    packfile.
    ++  - A table of index positions (one per packed object, num_objects in
    ++    total, each a 4-byte unsigned integer in network order), sorted by
    ++    their corresponding offsets in the packfile.
     +
     +  - A trailer, containing a:
     +
     +    checksum of the corresponding packfile, and
     +
     +    a checksum of all of the above.
    ++
    ++All 4-byte numbers are in network order.
     +
      == multi-pack-index (MIDX) files have the following format:

    @@ object-store.h: struct packed_git {
      		 multi_pack_index:1;
      	unsigned char hash[GIT_MAX_RAWSZ];
      	struct revindex_entry *revindex;
    -+	const void *revindex_data;
    -+	const void *revindex_map;
    ++	const uint32_t *revindex_data;
    ++	const uint32_t *revindex_map;
     +	size_t revindex_size;
      	/* something like ".git/objects/pack/xxxxx.pack" */
      	char pack_name[FLEX_ARRAY]; /* more */
    @@ pack-revindex.c: static void create_pack_revindex(struct packed_git *p)
      }

     -int load_pack_revindex(struct packed_git *p)
    -+static int load_pack_revindex_from_memory(struct packed_git *p)
    ++static int create_pack_revindex_in_memory(struct packed_git *p)
      {
     -	if (!p->revindex) {
     -		if (open_pack_index(p))
    @@ pack-revindex.c: static void create_pack_revindex(struct packed_git *p)
     +	return xstrfmt("%.*s.rev", (int)len, p->pack_name);
     +}
     +
    -+#define RIDX_MIN_SIZE (12 + (2 * the_hash_algo->rawsz))
    ++#define RIDX_HEADER_SIZE (12)
    ++#define RIDX_MIN_SIZE (RIDX_HEADER_SIZE + (2 * the_hash_algo->rawsz))
    ++
    ++struct revindex_header {
    ++	uint32_t signature;
    ++	uint32_t version;
    ++	uint32_t hash_id;
    ++};
     +
     +static int load_revindex_from_disk(char *revindex_name,
     +				   uint32_t num_objects,
    -+				   const void **data, size_t *len)
    ++				   const uint32_t **data_p, size_t *len_p)
     +{
     +	int fd, ret = 0;
     +	struct stat st;
    ++	void *data = NULL;
     +	size_t revindex_size;
    ++	struct revindex_header *hdr;
     +
     +	fd = git_open(revindex_name);
     +
    @@ pack-revindex.c: static void create_pack_revindex(struct packed_git *p)
     +		goto cleanup;
     +	}
     +
    -+	*len = revindex_size;
    -+	*data = xmmap(NULL, revindex_size, PROT_READ, MAP_PRIVATE, fd, 0);
    ++	data = xmmap(NULL, revindex_size, PROT_READ, MAP_PRIVATE, fd, 0);
    ++	hdr = data;
    ++
    ++	if (ntohl(hdr->signature) != RIDX_SIGNATURE) {
    ++		ret = error(_("reverse-index file %s has unknown signature"), revindex_name);
    ++		goto cleanup;
    ++	}
    ++	if (ntohl(hdr->version) != 1) {
    ++		ret = error(_("reverse-index file %s has unsupported version %"PRIu32),
    ++			    revindex_name, ntohl(hdr->version));
    ++		goto cleanup;
    ++	}
    ++	if (!(ntohl(hdr->hash_id) == 1 || ntohl(hdr->hash_id) == 2)) {
    ++		ret = error(_("reverse-index file %s has unsupported hash id %"PRIu32),
    ++			    revindex_name, ntohl(hdr->hash_id));
    ++		goto cleanup;
    ++	}
     +
     +cleanup:
    ++	if (ret) {
    ++		if (data)
    ++			munmap(data, revindex_size);
    ++	} else {
    ++		*len_p = revindex_size;
    ++		*data_p = (const uint32_t *)data;
    ++	}
    ++
     +	close(fd);
     +	return ret;
     +}
    @@ pack-revindex.c: static void create_pack_revindex(struct packed_git *p)
     +	if (ret)
     +		goto cleanup;
     +
    -+	p->revindex_data = (char *)p->revindex_map + 12;
    ++	p->revindex_data = (const uint32_t *)((const char *)p->revindex_map + RIDX_HEADER_SIZE);
     +
     +cleanup:
     +	free(revindex_name);
    @@ pack-revindex.c: static void create_pack_revindex(struct packed_git *p)
     +
     +	if (!load_pack_revindex_from_disk(p))
     +		return 0;
    -+	else if (!load_pack_revindex_from_memory(p))
    ++	else if (!create_pack_revindex_in_memory(p))
     +		return 0;
     +	return -1;
     +}
    @@ pack-revindex.c: int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_
     +	if (p->revindex)
     +		return p->revindex[pos].nr;
     +	else
    -+		return get_be32((char *)p->revindex_data + (pos * sizeof(uint32_t)));
    ++		return get_be32(p->revindex_data + pos);
      }

      off_t pack_pos_to_offset(struct packed_git *p, uint32_t pos)
    @@ pack-revindex.c: int offset_to_pack_pos(struct packed_git *p, off_t ofs, uint32_
      }

      ## pack-revindex.h ##
    -@@ pack-revindex.h: struct packed_git;
    +@@
    +  *   can be found
    +  */
    +
    ++#define RIDX_SIGNATURE 0x52494458 /* "RIDX" */
    ++#define RIDX_VERSION 1
    ++
    + struct packed_git;
    +
      /*
       * load_pack_revindex populates the revindex's internal data-structures for the
       * given pack, returning zero on success and a negative value otherwise.
     + *
    -+ * If a '.rev' file is present, it is checked for consistency, mmap'd, and
    -+ * pointers are assigned into it (instead of using the in-memory variant).
    ++ * If a '.rev' file is present it is mmap'd, and pointers are assigned into it
    ++ * (instead of using the in-memory variant).
       */
      int load_pack_revindex(struct packed_git *p);

    @@ packfile.h: uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);

      ## tmp-objdir.c ##
     @@ tmp-objdir.c: static int pack_copy_priority(const char *name)
    + 		return 1;
    + 	if (ends_with(name, ".pack"))
      		return 2;
    - 	if (ends_with(name, ".idx"))
    +-	if (ends_with(name, ".idx"))
    ++	if (ends_with(name, ".rev"))
      		return 3;
     -	return 4;
    -+	if (ends_with(name, ".rev"))
    ++	if (ends_with(name, ".idx"))
     +		return 4;
     +	return 5;
      }
22:  8648c87fa7 !  2:  5efc870742 pack-write.c: prepare to write 'pack-*.rev' files
    @@ Commit message
         from within 'write_rev_file()', which is called from
         'finish_tmp_packfile()'.

    +    Similar to the process by which the reverse index is computed in memory,
    +    these new paths also have to sort a list of objects by their offsets
    +    within a packfile. These new paths use a qsort() (as opposed to a radix
    +    sort), since our specialized radix sort requires a full revindex_entry
    +    struct per object, which is more memory than we need to allocate.
    +
    +    The qsort is obviously slower, but the theoretical slowdown would
    +    require a repository with a large amount of objects, likely implying
    +    that the time spent in, say, pack-objects during a repack would dominate
    +    the overall runtime.
    +
         Signed-off-by: Taylor Blau <me@ttaylorr.com>

      ## pack-write.c ##
    @@ pack-write.c: const char *write_idx_file(const char *index_name, struct pack_idx
     +	return 0;
     +}
     +
    -+#define RIDX_SIGNATURE 0x52494458 /* "RIDX" */
    -+#define RIDX_VERSION 1
    -+
     +static void write_rev_header(struct hashfile *f)
     +{
     +	uint32_t oid_version;
    @@ pack-write.c: void finish_tmp_packfile(struct strbuf *name_buffer,
     +
      	free((void *)idx_tmp_name);
      }
    +

      ## pack.h ##
     @@ pack.h: struct pack_idx_option {
    @@ pack.h: struct pack_idx_option {

      	uint32_t version;
      	uint32_t off32_limit;
    -@@ pack.h: off_t write_pack_header(struct hashfile *f, uint32_t);
    - void fixup_pack_header_footer(int, unsigned char *, const char *, uint32_t, unsigned char *, off_t);
    - char *index_pack_lockfile(int fd);
    +@@ pack.h: struct ref;
    +
    + void write_promisor_file(const char *promisor_name, struct ref **sought, int nr_sought);

     +const char *write_rev_file(const char *rev_name, struct pack_idx_entry **objects, uint32_t nr_objects, const unsigned char *hash, unsigned flags);
     +
 -:  ---------- >  3:  8a3e70454b builtin/index-pack.c: allow stripping arbitrary extensions
23:  5b18ada611 !  4:  a8ee59fccf builtin/index-pack.c: write reverse indexes
    @@ Documentation/git-index-pack.txt: git-index-pack - Build pack index file for an

      OPTIONS
     @@ Documentation/git-index-pack.txt: OPTIONS
    - 	file is constructed from the name of packed archive
    - 	file by replacing .pack with .idx (and the program
      	fails if the name of packed archive does not end
    --	with .pack).
    -+	with .pack). Incompatible with `--rev-index`.
    -+
    + 	with .pack).
    +
     +--[no-]rev-index::
     +	When this flag is provided, generate a reverse index
     +	(a `.rev` file) corresponding to the given pack. If
     +	`--verify` is given, ensure that the existing
     +	reverse index is correct. Takes precedence over
     +	`pack.writeReverseIndex`.
    -
    ++
      --stdin::
      	When this flag is provided, the pack is read from stdin
    + 	instead and a copy is then written to <pack-file>. If

      ## builtin/index-pack.c ##
     @@
    @@ builtin/index-pack.c

      struct object_entry {
      	struct pack_idx_entry idx;
    -@@ builtin/index-pack.c: static void fix_unresolved_deltas(struct hashfile *f)
    - 	free(sorted_by_pos);
    - }
    -
    --static const char *derive_filename(const char *pack_name, const char *suffix,
    --				   struct strbuf *buf)
    -+static const char *derive_filename(const char *pack_name, const char *strip,
    -+				   const char *suffix, struct strbuf *buf)
    - {
    - 	size_t len;
    --	if (!strip_suffix(pack_name, ".pack", &len))
    --		die(_("packfile name '%s' does not end with '.pack'"),
    --		    pack_name);
    -+	if (!strip_suffix(pack_name, strip, &len))
    -+		die(_("packfile name '%s' does not end with '%s'"),
    -+		    pack_name, strip);
    - 	strbuf_add(buf, pack_name, len);
    - 	strbuf_addch(buf, '.');
    - 	strbuf_addstr(buf, suffix);
    -@@ builtin/index-pack.c: static void write_special_file(const char *suffix, const char *msg,
    - 	int msg_len = strlen(msg);
    -
    - 	if (pack_name)
    --		filename = derive_filename(pack_name, suffix, &name_buf);
    -+		filename = derive_filename(pack_name, ".pack", suffix, &name_buf);
    - 	else
    - 		filename = odb_pack_name(&name_buf, hash, suffix);
    -
     @@ builtin/index-pack.c: static void write_special_file(const char *suffix, const char *msg,

      static void final(const char *final_pack_name, const char *curr_pack_name,
    @@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **argv, const char
      				usage(index_pack_usage);
      			continue;
     @@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **argv, const char *prefix)
    - 	if (from_stdin && hash_algo)
    - 		die(_("--object-format cannot be used with --stdin"));
      	if (!index_name && pack_name)
    --		index_name = derive_filename(pack_name, "idx", &index_name_buf);
    -+		index_name = derive_filename(pack_name, ".pack", "idx", &index_name_buf);
    -+
    + 		index_name = derive_filename(pack_name, "pack", "idx", &index_name_buf);
    +
     +	opts.flags &= ~(WRITE_REV | WRITE_REV_VERIFY);
     +	if (rev_index) {
     +		opts.flags |= verify ? WRITE_REV_VERIFY : WRITE_REV;
     +		if (index_name)
     +			rev_index_name = derive_filename(index_name,
    -+							 ".idx", "rev",
    ++							 "idx", "rev",
     +							 &rev_index_name_buf);
     +	}
    -
    ++
      	if (verify) {
      		if (!index_name)
    + 			die(_("--verify with no packfile name given"));
     @@ builtin/index-pack.c: int cmd_index_pack(int argc, const char **argv, const char *prefix)
      	for (i = 0; i < nr_objects; i++)
      		idx_objects[i] = &objects[i].idx;
24:  68bde3ea97 =  5:  5bebe05a16 builtin/pack-objects.c: respect 'pack.writeReverseIndex'
25:  38a253d0ce =  6:  7e29f2d3a0 Documentation/config/pack.txt: advertise 'pack.writeReverseIndex'
26:  12cdf2d67a =  7:  7cf16485cc t: prepare for GIT_TEST_WRITE_REV_INDEX
27:  6b647d9775 !  8:  02550a251d t: support GIT_TEST_WRITE_REV_INDEX
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const

      ## ci/run-build-and-tests.sh ##
     @@ ci/run-build-and-tests.sh: linux-gcc)
    - 	export GIT_TEST_COMMIT_GRAPH_CHANGED_PATHS=1
      	export GIT_TEST_MULTI_PACK_INDEX=1
      	export GIT_TEST_ADD_I_USE_BUILTIN=1
    + 	export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME=master
     +	export GIT_TEST_WRITE_REV_INDEX=1
      	make test
      	;;
    @@ pack-revindex.h
       *   can be found
       */

    ++
    + #define RIDX_SIGNATURE 0x52494458 /* "RIDX" */
    + #define RIDX_VERSION 1
    +
     +#define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
     +
      struct packed_git;
28:  48926ae182 !  9:  a66d2f9f7c pack-revindex: ensure that on-disk reverse indexes are given precedence
    @@ pack-revindex.c
      	off_t offset;
     @@ pack-revindex.c: static void create_pack_revindex(struct packed_git *p)

    - static int load_pack_revindex_from_memory(struct packed_git *p)
    + static int create_pack_revindex_in_memory(struct packed_git *p)
      {
     +	if (git_env_bool(GIT_TEST_REV_INDEX_DIE_IN_MEMORY, 0))
     +		die("dying as requested by '%s'",
    @@ pack-revindex.c: static void create_pack_revindex(struct packed_git *p)

      ## pack-revindex.h ##
     @@
    -  */
    + #define RIDX_VERSION 1

      #define GIT_TEST_WRITE_REV_INDEX "GIT_TEST_WRITE_REV_INDEX"
     +#define GIT_TEST_REV_INDEX_DIE_IN_MEMORY "GIT_TEST_REV_INDEX_DIE_IN_MEMORY"
 -:  ---------- > 10:  38c8afabf2 t5325: check both on-disk and in-memory reverse index
--
2.30.0.138.g6d7191ea01
