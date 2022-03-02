Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03F61C433EF
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 00:58:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238817AbiCBA6o (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Mar 2022 19:58:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231641AbiCBA6n (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Mar 2022 19:58:43 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB9F3CA51
        for <git@vger.kernel.org>; Tue,  1 Mar 2022 16:58:00 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id q8so165146iod.2
        for <git@vger.kernel.org>; Tue, 01 Mar 2022 16:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BDUjYZW/OldBvsGdf5BrAs35NInY60qMdLUMCRlsPjM=;
        b=OEt4quqM4ydYs/Jdthx128RCvhwKlk2ipvxICZ7uLGPm5SALXgd7nUSBe+HAhGpTSL
         ToEBI6yBncdxE50A8lsmVBDk5zNp5n6d9SDNIRmr4krBrUD937qwCPEYkZtCIGOh0VCR
         76Fpox/QUxjnw5j2/TP/ym90p82ZnciHHZJPAriGkHVoNUAF31RTQhXjPXn59XdBSi94
         UwENKbsvJ8ekKWcEsRimnoGBealOY7VEHxYYVjMKPwGzwP4G9IoCXKjMEFfrSX/O95N0
         Fi+hXp8hzyFTIY0t5OEST1GsTkK56byRxr5tlamY/lNFf/8Ra0KJbdjXgWLcjnuFluF8
         DZiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BDUjYZW/OldBvsGdf5BrAs35NInY60qMdLUMCRlsPjM=;
        b=ulEAtOlTpax/2tdPfOiqohObKBDWbbMGvkXIDjyLPjbFLgZlntFPdzRx10/rgbo2OD
         /LRLKlQGmgAKv7RP2J34QTQlq+mpVf02Z6V5P9PZJdkmBO9ysOQZFXIMPFk481mwzMxF
         8uFGTINgSmqrK0tNZ1o94DigVEyQ1xzyKqYQvJqsSmWjHu/RoN1Nq94wHCNTUj2qBq7t
         ycGRYRKmWhA3L3sHtbjLgQwYpDUNCq1MPrPY0QYWtfMq1wpXif135+15gxi8qcTNSHUu
         mJ2jdqt/qfpoTiMlbakYbhfrz1jnOHsD1XxR7oud02TuHDko3zv2v0s7iguurFp17c7E
         PhdQ==
X-Gm-Message-State: AOAM531dlEMyyZYcTs/l84NHTpMVPLD+23afFgamfwfF125P9waPpBha
        0WuxEqq0rTUP8aj7JWPkq/LFMcZVPAm9rZPM
X-Google-Smtp-Source: ABdhPJwxX/pmOugp85IJ9c/Onrrj7qBRjBDALrtLwON5rFArdfHHP5ABIBpwJBep63Jl5Ug7foTxYw==
X-Received: by 2002:a6b:e901:0:b0:640:7bf8:f61d with SMTP id u1-20020a6be901000000b006407bf8f61dmr21022021iof.112.1646182678964;
        Tue, 01 Mar 2022 16:57:58 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id c9-20020a92b749000000b002c22c39554fsm7982772ilm.31.2022.03.01.16.57.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 16:57:58 -0800 (PST)
Date:   Tue, 1 Mar 2022 19:57:57 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     tytso@mit.edu, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com
Subject: [PATCH v2 00/17] cruft packs
Message-ID: <cover.1646182671.git.me@ttaylorr.com>
References: <cover.1638224692.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1638224692.git.me@ttaylorr.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Here is a reroll of my series to implement "cruft packs", a pack which
stores accumulated unreachable objects, along with a new ".mtimes" file
which tracks each object's last known modification time.

This was on the list towards the end of 2021[1], and I have been
accumulating small changes to it locally for a couple of months now.
Major changes since last time include:

  - Clearer documentation and commit message(s) to better illustrate how
    the feature works and is supposed to be used.

  - Some minor documentation updates to pack-format.txt, which make some
    ambiguous details more explicit.

  - Minor code movement / tweaks to make things easier to read, ensure
    that functions aren't introduced in patches before they are used /
    etc.

  - Moved the new test script to t5328 (instead of t5327, which happens
    to be taken up by a new MIDX bitmap-related test), and purged it of
    all "rm -fr .git/logs" (replacing them with "git reflog --expire
    --all --expire=all" instead).

  - A new test which fixes a bug where loose objects which have copies
    that appear in a cruft pack would not get accumulated when doing a
    `--geometric` repack.

For convenience, a range-diff is below. Thanks in advance for taking
another look!

[1]: https://lore.kernel.org/git/cover.1638224692.git.me@ttaylorr.com/

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
 Documentation/technical/cruft-packs.txt |  97 ++++
 Documentation/technical/pack-format.txt |  19 +
 Makefile                                |   2 +
 builtin/gc.c                            |  10 +-
 builtin/pack-objects.c                  | 304 +++++++++-
 builtin/repack.c                        | 183 +++++-
 bulk-checkin.c                          |   2 +-
 chunk-format.c                          |  12 +
 chunk-format.h                          |   3 +
 commit-graph.c                          |  18 +-
 midx.c                                  |  18 +-
 object-file.c                           |   4 +-
 object-store.h                          |   7 +-
 pack-mtimes.c                           | 129 +++++
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
 t/t5328-pack-objects-cruft.sh           | 739 ++++++++++++++++++++++++
 32 files changed, 1810 insertions(+), 101 deletions(-)
 create mode 100644 Documentation/technical/cruft-packs.txt
 create mode 100644 pack-mtimes.c
 create mode 100644 pack-mtimes.h
 create mode 100644 t/helper/test-pack-mtimes.c
 create mode 100755 t/t5328-pack-objects-cruft.sh

Range-diff against v1:
 1:  a9f7c738e0 !  1:  784ee7e0ee Documentation/technical: add cruft-packs.txt
    @@ Documentation/technical/cruft-packs.txt (new)
     @@
     += Cruft packs
     +
    -+Cruft packs offer an alternative to Git's traditional mechanism of removing
    -+unreachable objects. This document provides an overview of Git's pruning
    -+mechanism, and how cruft packs can be used instead to accomplish the same.
    ++The cruft packs feature offer an alternative to Git's traditional mechanism of
    ++removing unreachable objects. This document provides an overview of Git's
    ++pruning mechanism, and how a cruft pack can be used instead to accomplish the
    ++same.
     +
     +== Background
     +
    @@ Documentation/technical/cruft-packs.txt (new)
     +
     +== Cruft packs
     +
    -+Cruft packs are designed to eliminate the need for storing unreachable objects
    -+in a loose state by including the per-object mtimes in a separate file alongside
    -+a single pack containing all loose objects.
    ++A cruft pack eliminates the need for storing unreachable objects in a loose
    ++state by including the per-object mtimes in a separate file alongside a single
    ++pack containing all loose objects.
     +
     +A cruft pack is written by `git repack --cruft` when generating a new pack.
     +linkgit:git-pack-objects[1]'s `--cruft` option. Note that `git repack --cruft`
    @@ Documentation/technical/cruft-packs.txt (new)
     +Notable alternatives to this design include:
     +
     +  - The location of the per-object mtime data, and
    -+  - Whether cruft packs should be incremental or not.
    ++  - Storing unreachable objects in multiple cruft packs.
     +
     +On the location of mtime data, a new auxiliary file tied to the pack was chosen
     +to avoid complicating the `.idx` format. If the `.idx` format were ever to gain
     +support for optional chunks of data, it may make sense to consolidate the
     +`.mtimes` format into the `.idx` itself.
     +
    -+Incremental cruft packs (i.e., where each time a repository is repacked a new
    -+cruft pack is generated containing only the unreachable objects introduced since
    -+the last time a cruft pack was written) are significantly more complicated to
    -+construct, and so aren't pursued here. The obvious drawback to the current
    -+implementation is that the entire cruft pack must be re-written from scratch.
    ++Storing unreachable objects among multiple cruft packs (e.g., creating a new
    ++cruft pack during each repacking operation including only unreachable objects
    ++which aren't already stored in an earlier cruft pack) is significantly more
    ++complicated to construct, and so aren't pursued here. The obvious drawback to
    ++the current implementation is that the entire cruft pack must be re-written from
    ++scratch.
 2:  7d4ae7bd3e !  2:  101b34660c pack-mtimes: support reading .mtimes files
    @@ Documentation/technical/pack-format.txt: Pack file entry: <+
     +
     +  - A 4-byte hash function identifier (= 1 for SHA-1, 2 for SHA-256).
     +
    -+  - A table of mtimes (one per packed object, num_objects in total, each
    -+    a 4-byte unsigned integer in network order), in the same order as
    -+    objects appear in the index file (e.g., the first entry in the mtime
    -+    table corresponds to the object with the lowest lexically-sorted
    -+    oid). The mtimes count standard epoch seconds.
    ++  - A table of 4-byte unsigned integers in network order. The ith
    ++    value is the modification time (mtime) of the ith object in the
    ++    corresponding pack by lexicographic (index) order. The mtimes
    ++    count standard epoch seconds.
     +
    -+  - A trailer, containing a:
    -+
    -+    checksum of the corresponding packfile, and
    -+
    -+    a checksum of all of the above.
    ++  - A trailer, containing a checksum of the corresponding packfile,
    ++    and a checksum of all of the above (each having length according
    ++    to the specified hash function).
     +
     +All 4-byte numbers are in network order.
     +
    @@ pack-mtimes.c (new)
     +	return xstrfmt("%.*s.mtimes", (int)len, p->pack_name);
     +}
     +
    -+int pack_has_mtimes(struct packed_git *p)
    -+{
    -+	struct stat st;
    -+	char *fname = pack_mtimes_filename(p);
    -+
    -+	if (stat(fname, &st) < 0) {
    -+		if (errno == ENOENT)
    -+			return 0;
    -+		die_errno(_("could not stat %s"), fname);
    -+	}
    -+
    -+	free(fname);
    -+	return 1;
    -+}
    -+
     +#define MTIMES_HEADER_SIZE (12)
     +#define MTIMES_MIN_SIZE (MTIMES_HEADER_SIZE + (2 * the_hash_algo->rawsz))
     +
    @@ pack-mtimes.c (new)
     +	struct stat st;
     +	void *data = NULL;
     +	size_t mtimes_size;
    ++	struct mtimes_header header;
     +	uint32_t *hdr;
     +
     +	fd = git_open(mtimes_file);
    @@ pack-mtimes.c (new)
     +
     +	data = hdr = xmmap(NULL, mtimes_size, PROT_READ, MAP_PRIVATE, fd, 0);
     +
    -+	if (ntohl(*hdr) != MTIMES_SIGNATURE) {
    ++	header.signature = ntohl(hdr[0]);
    ++	header.version = ntohl(hdr[1]);
    ++	header.hash_id = ntohl(hdr[2]);
    ++
    ++	if (header.signature != MTIMES_SIGNATURE) {
     +		ret = error(_("mtimes file %s has unknown signature"), mtimes_file);
     +		goto cleanup;
     +	}
     +
    -+	if (ntohl(*++hdr) != 1) {
    ++	if (header.version != 1) {
     +		ret = error(_("mtimes file %s has unsupported version %"PRIu32),
    -+			    mtimes_file, ntohl(*hdr));
    ++			    mtimes_file, header.version);
     +		goto cleanup;
     +	}
    -+	hdr++;
    -+	if (!(ntohl(*hdr) == 1 || ntohl(*hdr) == 2)) {
    ++
    ++	if (!(header.hash_id == 1 || header.hash_id == 2)) {
     +		ret = error(_("mtimes file %s has unsupported hash id %"PRIu32),
    -+			    mtimes_file, ntohl(*hdr));
    ++			    mtimes_file, header.hash_id);
     +		goto cleanup;
     +	}
     +
    @@ pack-mtimes.h (new)
     +
     +struct packed_git;
     +
    -+int pack_has_mtimes(struct packed_git *p);
     +int load_pack_mtimes(struct packed_git *p);
     +
     +uint32_t nth_packed_mtime(struct packed_git *p, uint32_t pos);
    @@ pack-mtimes.h (new)
     +#endif
     
      ## packfile.c ##
    -@@ packfile.c: void close_pack_revindex(struct packed_git *p) {
    +@@ packfile.c: static void close_pack_revindex(struct packed_git *p)
      	p->revindex_data = NULL;
      }
      
    -+void close_pack_mtimes(struct packed_git *p) {
    ++static void close_pack_mtimes(struct packed_git *p)
    ++{
     +	if (!p->mtimes_map)
     +		return;
     +
    @@ packfile.c: static void prepare_pack(const char *full_name, size_t full_name_len
      		string_list_append(data->garbage, full_name);
      	else
      		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
    -
    - ## packfile.h ##
    -@@ packfile.h: uint32_t get_pack_fanout(struct packed_git *p, uint32_t value);
    - unsigned char *use_pack(struct packed_git *, struct pack_window **, off_t, unsigned long *);
    - void close_pack_windows(struct packed_git *);
    - void close_pack_revindex(struct packed_git *);
    -+void close_pack_mtimes(struct packed_git *p);
    - void close_pack(struct packed_git *);
    - void close_object_store(struct raw_object_store *o);
    - void unuse_pack(struct pack_window **);
 3:  7f4612e859 =  3:  a94d7dfeb3 pack-write: pass 'struct packing_data' to 'stage_tmp_packfiles'
 4:  ea245b7216 =  4:  1e0ed363ae chunk-format.h: extract oid_version()
 5:  deece9eb70 !  5:  5236490688 pack-mtimes: support writing pack .mtimes files
    @@ pack-objects.h: struct packing_data {
      	unsigned int *tree_depth;
      	unsigned char *layer;
     +
    -+	/* cruft packs */
    ++	/*
    ++	 * Used when writing cruft packs.
    ++	 *
    ++	 * Object mtimes are stored in pack order when writing, but
    ++	 * written out in lexicographic (index) order.
    ++	 */
     +	uint32_t *cruft_mtime;
      };
      
    @@ pack-write.c: const char *write_rev_file_order(const char *rev_name,
     +	hashwrite_be32(f, oid_version(the_hash_algo));
     +}
     +
    ++/*
    ++ * Writes the object mtimes of "objects" for use in a .mtimes file.
    ++ * Note that objects must be in lexicographic (index) order, which is
    ++ * the expected ordering of these values in the .mtimes file.
    ++ */
     +static void write_mtimes_objects(struct hashfile *f,
     +				 struct packing_data *to_pack,
     +				 struct pack_idx_entry **objects,
    @@ pack-write.c: const char *write_rev_file_order(const char *rev_name,
     +	write_mtimes_objects(f, to_pack, objects, nr_objects);
     +	write_mtimes_trailer(f, hash);
     +
    -+	if (mtimes_name && adjust_shared_perm(mtimes_name) < 0)
    ++	if (adjust_shared_perm(mtimes_name) < 0)
     +		die(_("failed to make %s readable"), mtimes_name);
     +
     +	finalize_hashfile(f, NULL,
    @@ pack-write.c: void stage_tmp_packfiles(struct strbuf *name_buffer,
     +		mtimes_tmp_name = write_mtimes_file(NULL, to_pack, written_list,
     +						    nr_written,
     +						    hash);
    -+		if (adjust_shared_perm(mtimes_tmp_name))
    -+			die_errno("unable to make temporary mtimes file readable");
     +	}
     +
      	rename_tmp_packfile(name_buffer, pack_tmp_name, "pack");
 6:  e0a7b3b310 !  6:  78313bc441 t/helper: add 'pack-mtimes' test-tool
    @@ t/helper/test-pack-mtimes.c (new)
     +#include "packfile.h"
     +#include "pack-mtimes.h"
     +
    -+static int dump_mtimes(struct packed_git *p)
    ++static void dump_mtimes(struct packed_git *p)
     +{
     +	uint32_t i;
     +	if (load_pack_mtimes(p) < 0)
    @@ t/helper/test-pack-mtimes.c (new)
     +		printf("%s %"PRIu32"\n",
     +		       oid_to_hex(&oid), nth_packed_mtime(p, i));
     +	}
    -+
    -+	return 0;
     +}
     +
     +static const char *pack_mtimes_usage = "\n"
    @@ t/helper/test-pack-mtimes.c (new)
     +
     +	strbuf_release(&buf);
     +
    -+	return p ? dump_mtimes(p) : 1;
    ++	if (!p)
    ++		die("could not find pack '%s'", argv[1]);
    ++
    ++	dump_mtimes(p);
    ++
    ++	return 0;
     +}
     
      ## t/helper/test-tool.c ##
 7:  5710933127 =  7:  142098668d builtin/pack-objects.c: return from create_object_entry()
 8:  66165917a4 !  8:  2517a6be3d builtin/pack-objects.c: --cruft without expiration
    @@ Commit message
             which packs are about to be removed.
     
           - All packs which are going to be removed (we'll call these the
    -        redundant ones) are marked as kept in-core, as well as any packs
    -        that `pack-objects` found but the caller did not specify.
    +        redundant ones) are marked as kept in-core.
     
    -        These packs are presumed to have entered the repository between
    -        the caller collecting packs and invoking `pack-objects`. Since we
    -        do not want to include objects in these packs (because we don't know
    -        which of their objects are or aren't reachable), these are also
    -        marked as kept in-core.
    +        Any packs the caller did not mention (but are known to the
    +        `pack-objects` process) are also marked as kept in-core. Packs not
    +        mentioned by the caller are assumed to be unknown to them, i.e.,
    +        they entered the repository after the caller decided which packs
    +        should be kept and which should be discarded.
    +
    +        Since we do not want to include objects in these "unknown" packs
    +        (because we don't know which of their objects are or aren't
    +        reachable), these are also marked as kept in-core.
     
           - Then, we enumerate all objects in the repository, and add them to
             our packing list if they do not appear in an in-core kept pack.
    @@ Documentation/git-pack-objects.txt: SYNOPSIS
      	[--local] [--incremental] [--window=<n>] [--depth=<n>]
      	[--revs [--unpacked | --all]] [--keep-pack=<pack-name>]
     +	[--cruft] [--cruft-expiration=<time>]
    - 	[--stdout [--filter=<filter-spec>] | base-name]
    - 	[--shallow] [--keep-true-parents] [--[no-]sparse] < object-list
    + 	[--stdout [--filter=<filter-spec>] | <base-name>]
    + 	[--shallow] [--keep-true-parents] [--[no-]sparse] < <object-list>
      
     @@ Documentation/git-pack-objects.txt: base-name::
      Incompatible with `--revs`, or options that imply `--revs` (such as
    @@ Documentation/git-pack-objects.txt: base-name::
      
     +--cruft::
     +	Packs unreachable objects into a separate "cruft" pack, denoted
    -+	by the existence of a `.mtimes` file. Pack names provided over
    -+	stdin indicate which packs will remain after a `git repack`.
    -+	Pack names prefixed with a `-` indicate those which will be
    -+	removed. The contents of the cruft pack are all objects not
    -+	contained in the surviving packs specified by `--keep-pack`)
    -+	which have not exceeded the grace period (see
    ++	by the existence of a `.mtimes` file. Typically used by `git
    ++	repack --cruft`. Callers provide a list of pack names and
    ++	indicate which packs will remain in the repository, along with
    ++	which packs will be deleted (indicated by the `-` prefix). The
    ++	contents of the cruft pack are all objects not contained in the
    ++	surviving packs which have not exceeded the grace period (see
     +	`--cruft-expiration` below), or which have exceeded the grace
     +	period, but are reachable from an other object which hasn't.
     ++
    ++When the input lists a pack containing all reachable objects (and lists
    ++all other packs as pending deletion), the corresponding cruft pack will
    ++contain all unreachable objects (with mtime newer than the
    ++`--cruft-expiration`) along with any unreachable objects whose mtime is
    ++older than the `--cruft-expiration`, but are reachable from an
    ++unreachable object whose mtime is newer than the `--cruft-expiration`).
    +++
     +Incompatible with `--unpack-unreachable`, `--keep-unreachable`,
     +`--pack-loose-unreachable`, `--stdin-packs`, as well as any other
     +options which imply `--revs`. Also incompatible with `--max-pack-size`;
    @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
      	string_list_clear(&exclude_packs, 0);
      }
      
    -+static int add_cruft_object_entry(const struct object_id *oid, enum object_type type,
    -+				  struct packed_git *pack, off_t offset,
    -+				  const char *name, uint32_t mtime)
    ++static void add_cruft_object_entry(const struct object_id *oid, enum object_type type,
    ++				   struct packed_git *pack, off_t offset,
    ++				   const char *name, uint32_t mtime)
     +{
     +	struct object_entry *entry;
     +
    @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
     +	if (entry) {
     +		if (name) {
     +			entry->hash = pack_name_hash(name);
    -+			entry->no_try_delta = name && no_try_delta(name);
    ++			entry->no_try_delta = no_try_delta(name);
     +		}
     +	} else {
     +		if (!want_object_in_pack(oid, 0, &pack, &offset))
    -+			return 0;
    ++			return;
     +		if (!pack && type == OBJ_BLOB && !has_loose_object(oid)) {
     +			/*
     +			 * If a traversed tree has a missing blob then we want
    @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
     +			 * limited to "ensure non-tip blobs which don't exist in
     +			 * packs do exist via loose objects". Confused?
     +			 */
    -+			return 0;
    ++			return;
     +		}
     +
     +		entry = create_object_entry(oid, type, pack_name_hash(name),
    @@ builtin/pack-objects.c: static void read_packs_list_from_stdin(void)
     +
     +	if (mtime > oe_cruft_mtime(&to_pack, entry))
     +		oe_set_cruft_mtime(&to_pack, entry, mtime);
    -+	return 1;
    ++	return;
     +}
     +
     +static void mark_pack_kept_in_core(struct string_list *packs, unsigned keep)
    @@ builtin/pack-objects.c: int cmd_pack_objects(int argc, const char **argv, const
      		read_packs_list_from_stdin();
      		if (rev_list_unpacked)
      			add_unreachable_loose_objects();
    --	} else if (!use_internal_rev_list)
    -+	} else if (cruft)
    ++	} else if (cruft) {
     +		read_cruft_objects();
    -+	else if (!use_internal_rev_list)
    + 	} else if (!use_internal_rev_list) {
      		read_object_list_from_stdin();
    - 	else {
    - 		get_object_list(rp.nr, rp.v);
    + 	} else {
     
      ## object-file.c ##
     @@ object-file.c: int has_loose_object_nonlocal(const struct object_id *oid)
    @@ object-store.h: int repo_has_object_file_with_flags(struct repository *r,
      
      /*
     
    - ## t/t5327-pack-objects-cruft.sh (new) ##
    + ## t/t5328-pack-objects-cruft.sh (new) ##
     @@
     +#!/bin/sh
     +
    @@ t/t5327-pack-objects-cruft.sh (new)
     +
     +			git reset --hard reachable &&
     +			git tag -d cruft &&
    -+			rm -fr .git/logs &&
    ++			git reflog expire --all --expire=all &&
     +
     +			# remove the unreachable tree, but leave the commit
    -+			# which has it as its root tree in-tact
    ++			# which has it as its root tree intact
     +			rm -fr "$objdir/$(test_oid_to_path "$tree")" &&
     +
     +			git repack -Ad &&
    @@ t/t5327-pack-objects-cruft.sh (new)
     +
     +			git reset --hard reachable &&
     +			git tag -d cruft &&
    -+			rm -fr .git/logs &&
    ++			git reflog expire --all --expire=all &&
     +
     +			# remove the unreachable blob, but leave the commit (and
    -+			# the root tree of that commit) in-tact
    ++			# the root tree of that commit) intact
     +			rm -fr "$objdir/$(test_oid_to_path "$blob")" &&
     +
     +			git repack -Ad &&
 9:  02f7fce788 =  9:  6f0e84273f reachable: add options to add_unseen_recent_objects_to_traversal
10:  52e9ac5710 = 10:  a8bde361f9 reachable: report precise timestamps from objects in cruft packs
11:  37fda94785 ! 11:  d68ce28132 builtin/pack-objects.c: --cruft with expiration
    @@ Commit message
         Signed-off-by: Taylor Blau <me@ttaylorr.com>
     
      ## builtin/pack-objects.c ##
    -@@ builtin/pack-objects.c: static int add_cruft_object_entry(const struct object_id *oid, enum object_type
    - 	return 1;
    +@@ builtin/pack-objects.c: static void add_cruft_object_entry(const struct object_id *oid, enum object_type
    + 	return;
      }
      
     +static void show_cruft_object(struct object *obj, const char *name, void *data)
    @@ builtin/pack-objects.c: static void read_cruft_objects(void)
      		enumerate_cruft_objects();
      
     
    - ## t/t5327-pack-objects-cruft.sh ##
    -@@ t/t5327-pack-objects-cruft.sh: basic_cruft_pack_tests () {
    + ## t/t5328-pack-objects-cruft.sh ##
    +@@ t/t5328-pack-objects-cruft.sh: basic_cruft_pack_tests () {
      }
      
      basic_cruft_pack_tests never
12:  a05675ab83 ! 12:  e5317cd472 builtin/repack.c: support generating a cruft pack
    @@ builtin/repack.c: static int write_midx_included_packs(struct string_list *inclu
      {
      	struct child_process cmd = CHILD_PROCESS_INIT;
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    - 	int show_progress = isatty(2);
    + 	int show_progress;
      
      	/* variables to be filled by option parsing */
     -	int pack_everything = 0;
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      				   LOOSEN_UNREACHABLE | ALL_INTO_ONE),
     +		OPT_BIT(0, "cruft", &pack_everything,
     +				N_("same as -a, pack unreachable cruft objects separately"),
    -+				   PACK_CRUFT | ALL_INTO_ONE),
    ++				   PACK_CRUFT),
     +		OPT_STRING(0, "cruft-expiration", &cruft_expiration, N_("approxidate"),
     +				N_("with -C, expire objects older than this")),
      		OPT_BOOL('d', NULL, &delete_redundant,
      				N_("remove redundant packs, and run git-prune-packed")),
      		OPT_BOOL('f', NULL, &po_args.no_reuse_delta,
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    - 	if (keep_unreachable &&
      	    (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE)))
    - 		die(_("--keep-unreachable and -A are incompatible"));
    -+	if (pack_everything & PACK_CRUFT && delete_redundant) {
    + 		die(_("options '%s' and '%s' cannot be used together"), "--keep-unreachable", "-A");
    + 
    ++	if (pack_everything & PACK_CRUFT) {
    ++		pack_everything |= ALL_INTO_ONE;
    ++
     +		if (unpack_unreachable || (pack_everything & LOOSEN_UNREACHABLE))
    -+			die(_("--cruft and -A are incompatible"));
    ++			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-A");
     +		if (keep_unreachable)
    -+			die(_("--cruft and -k are incompatible"));
    -+		if (!(pack_everything & ALL_INTO_ONE))
    -+			die(_("--cruft must be combined with all-into-one"));
    ++			die(_("options '%s' and '%s' cannot be used together"), "--cruft", "-k");
     +	}
    - 
    ++
      	if (write_bitmaps < 0) {
      		if (!write_midx &&
    + 		    (!(pack_everything & ALL_INTO_ONE) || !is_bare_repository()))
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
      	if (pack_everything & ALL_INTO_ONE) {
      		repack_promisor_objects(&po_args, &names);
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      			for_each_string_list_item(item, &names) {
      				strvec_pushf(&cmd.args, "--keep-pack=%s-%s.pack",
      					     packtmp_name, item->string);
    -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    - 		return ret;
    - 
    - 	if (geometry) {
    -+		struct packed_git *p;
    - 		FILE *in = xfdopen(cmd.in, "w");
    - 		/*
    - 		 * The resulting pack should contain all objects in packs that
    -@@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
    - 			fprintf(in, "%s\n", pack_basename(geometry->pack[i]));
    - 		for (i = geometry->split; i < geometry->pack_nr; i++)
    - 			fprintf(in, "^%s\n", pack_basename(geometry->pack[i]));
    -+
    -+		for (p = get_all_packs(the_repository); p; p = p->next) {
    -+			if (!p->is_cruft)
    -+				continue;
    -+			fprintf(in, "^%s\n", pack_basename(p));
    -+		}
    - 		fclose(in);
    - 	}
    - 
     @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix)
      	if (!names.nr && !po_args.quiet)
      		printf_ln(_("Nothing new to pack."));
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      		item->util = (void *)(uintptr_t)populate_pack_exts(item->string);
      	}
     
    - ## t/t5327-pack-objects-cruft.sh ##
    -@@ t/t5327-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned' '
    + ## t/t5328-pack-objects-cruft.sh ##
    +@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned' '
      	)
      '
      
    @@ t/t5327-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned'
     +		git branch -D other &&
     +		git tag -d unreachable &&
     +		# objects are not cruft if they are contained in the reflogs
    -+		rm -fr .git/logs &&
    ++		git reflog expire --all --expire=all &&
     +
     +		git rev-list --objects --all --no-object-names >reachable.raw &&
     +		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
    @@ t/t5327-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned'
     +		git checkout main &&
     +		git branch -D other &&
     +		git tag -d cruft &&
    -+		rm -fr .git/logs &&
    ++		git reflog expire --all --expire=all &&
     +
     +		git repack --cruft -d &&
     +
    @@ t/t5327-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned'
     +		git checkout main &&
     +		git branch -D other &&
     +		git tag -d cruft &&
    -+		rm -fr .git/logs &&
    ++		git reflog expire --all --expire=all &&
     +
     +		git repack --cruft &&
     +
    @@ t/t5327-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned'
     +		test_cmp before after
     +	)
     +'
    ++
    ++test_expect_success 'repack --geometric collects once-cruft objects' '
    ++	git init repo &&
    ++	test_when_finished "rm -fr repo" &&
    ++	(
    ++		cd repo &&
    ++
    ++		test_commit reachable &&
    ++		git repack -Ad &&
    ++		git branch -M main &&
    ++
    ++		git checkout --orphan other &&
    ++		git rm -rf . &&
    ++		test_commit --no-tag cruft &&
    ++		cruft="$(git rev-parse HEAD)" &&
    ++
    ++		git checkout main &&
    ++		git branch -D other &&
    ++		git reflog expire --all --expire=all &&
    ++
    ++		# Pack the objects created in the previous step into a cruft
    ++		# pack. Intentionally leave loose copies of those objects
    ++		# around so we can pick them up in a subsequent --geometric
    ++		# reapack.
    ++		git repack --cruft &&
    ++
    ++		# Now make those objects reachable, and ensure that they are
    ++		# packed into the new pack created via a --geometric repack.
    ++		git update-ref refs/heads/other $cruft &&
    ++
    ++		# Without this object, the set of unpacked objects is exactly
    ++		# the set of objects already in the cruft pack. Tweak that set
    ++		# to ensure we do not overwrite the cruft pack entirely.
    ++		test_commit reachable2 &&
    ++
    ++		find $packdir -name "pack-*.idx" | sort >before &&
    ++		git repack --geometric=2 -d &&
    ++		find $packdir -name "pack-*.idx" | sort >after &&
    ++
    ++		{
    ++			git rev-list --objects --no-object-names $cruft &&
    ++			git rev-list --objects --no-object-names reachable..reachable2
    ++		} >want.raw &&
    ++		sort want.raw >want &&
    ++
    ++		pack=$(comm -13 before after) &&
    ++		git show-index <$pack >objects.raw &&
    ++
    ++		cut -d" " -f2 objects.raw | sort >got &&
    ++
    ++		test_cmp want got
    ++	)
    ++'
    ++
     +test_expect_success 'cruft repack with no reachable objects' '
     +	git init repo &&
     +	test_when_finished "rm -fr repo" &&
    @@ t/t5327-pack-objects-cruft.sh: test_expect_success 'expired objects are pruned'
     +
     +		git for-each-ref --format="delete %(refname)" >in &&
     +		git update-ref --stdin <in &&
    -+		rm -fr .git/logs &&
    ++		git reflog expire --all --expire=all &&
     +		rm -fr .git/index &&
     +
     +		git repack --cruft -d &&
13:  0d2dfaa062 ! 13:  b548dbbf80 builtin/repack.c: allow configuring cruft pack generation
    @@ builtin/repack.c: int cmd_repack(int argc, const char **argv, const char *prefix
      				       &existing_kept_packs);
      		if (ret)
     
    - ## t/t5327-pack-objects-cruft.sh ##
    -@@ t/t5327-pack-objects-cruft.sh: test_expect_success 'cruft repack ignores pack.packSizeLimit' '
    + ## t/t5328-pack-objects-cruft.sh ##
    +@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'cruft repack ignores pack.packSizeLimit' '
      	)
      '
      
14:  fd50c39657 = 14:  e6eee7f15c builtin/repack.c: use named flags for existing_packs
15:  b2937ceda7 ! 15:  b09dbc9fe5 builtin/repack.c: add cruft packs to MIDX during geometric repack
    @@ builtin/repack.c: static void midx_included_packs(struct string_list *include,
      		for_each_string_list_item(item, existing_nonkept_packs) {
      			if ((uintptr_t)item->util & DELETE_PACK)
     
    - ## t/t5327-pack-objects-cruft.sh ##
    -@@ t/t5327-pack-objects-cruft.sh: test_expect_success 'cruft --local drops unreachable objects' '
    + ## t/t5328-pack-objects-cruft.sh ##
    +@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'cruft --local drops unreachable objects' '
      	)
      '
      
    @@ t/t5327-pack-objects-cruft.sh: test_expect_success 'cruft --local drops unreacha
     +
     +		git reset --hard $unreachable^ &&
     +		git tag -d cruft &&
    -+		rm -fr .git/logs &&
    ++		git reflog expire --all --expire=all &&
     +
     +		git repack --cruft -d &&
     +
16:  394de0199f ! 16:  7a21ae1494 builtin/gc.c: conditionally avoid pruning objects via loose
    @@ builtin/gc.c: int cmd_gc(int argc, const char **argv, const char *prefix)
      			if (quiet)
      				strvec_push(&prune, "--no-progress");
     
    - ## t/t5327-pack-objects-cruft.sh ##
    -@@ t/t5327-pack-objects-cruft.sh: test_expect_success 'loose objects mtimes upsert others' '
    + ## t/t5328-pack-objects-cruft.sh ##
    +@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'loose objects mtimes upsert others' '
      	)
      '
      
    @@ t/t5327-pack-objects-cruft.sh: test_expect_success 'loose objects mtimes upsert
     +		git branch -D other &&
     +		git tag -d unreachable &&
     +		# objects are not cruft if they are contained in the reflogs
    -+		rm -fr .git/logs &&
    ++		git reflog expire --all --expire=all &&
     +
     +		git rev-list --objects --all --no-object-names >reachable.raw &&
     +		git cat-file --batch-all-objects --batch-check="%(objectname)" >objects &&
17:  99aace8e16 ! 17:  b729b80963 sha1-file.c: don't freshen cruft packs
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
      		return 1;
      	if (!freshen_file(e.p->pack_name))
     
    - ## t/t5327-pack-objects-cruft.sh ##
    -@@ t/t5327-pack-objects-cruft.sh: test_expect_success 'MIDX bitmaps tolerate reachable cruft objects' '
    + ## t/t5328-pack-objects-cruft.sh ##
    +@@ t/t5328-pack-objects-cruft.sh: test_expect_success 'MIDX bitmaps tolerate reachable cruft objects' '
      	)
      '
      
-- 
2.35.1.73.gccc5557600
