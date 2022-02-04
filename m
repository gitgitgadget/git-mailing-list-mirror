Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3728FC433F5
	for <git@archiver.kernel.org>; Fri,  4 Feb 2022 14:07:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358899AbiBDOHX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Feb 2022 09:07:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235027AbiBDOHW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Feb 2022 09:07:22 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 239A1C061714
        for <git@vger.kernel.org>; Fri,  4 Feb 2022 06:07:22 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id j25so10856889wrb.2
        for <git@vger.kernel.org>; Fri, 04 Feb 2022 06:07:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xDhpZLFd66yZN/m3yDB9G0n3XF6uT3ECJa+GriV8qTs=;
        b=CqYbJHZfH3Qh9tnC8IUx+NAAed4ebDMDLg7RkbyOVlnYcA6M70sKcljxyTJyJkmmdi
         k2IxxxOshIyVU3qPG6fYyaA8dvd/TAmsExLmqo7SriJYKE2O2iHUx0peM8ibypfuL5SH
         U8SD82jMT4FqM3Z8wu6ehmheLXnHfSvy315wG+sD4Bdy6p3KGv6q9DOWAnUJYzWOT0Z2
         0Ua/8apj/+TRB4tyGZcoiJL9WMbZqOjWFa7WeDAbPlzgMWmtJyXrXL/mYp/t3h4aF/g+
         qQL5y04hhxen63zBcmYaazU8KXY5vZiTuCG8SBqewTkQij7FjLR9gFjBn1Ro5Ah22iYN
         acWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xDhpZLFd66yZN/m3yDB9G0n3XF6uT3ECJa+GriV8qTs=;
        b=PDrfzQIhJNB0VKkPsN8dutHNYGlO1cMa6QYS52dJ5O0ofdAnfUdpw1G+qsyjZTd4Nq
         5oPWjsgBJhoTmvkH+4PE4741ttbkgeGbDc42NT17GqSz1NvwxehIkHWB6LrgWgg2mJ6g
         qcXs5ZSVi6dlRAp2JD2RlWtYF2RY8ZAraK6CCGqPaUfYgVgETyw0yQu0j6o1+x4WD8aJ
         9HI5tAzNSX96FAYiQuQBlWT4W06r57VUV9HAs+eIndvasKByCGpCqm4Tz/BAZrldrFpe
         PgU94U5RVG30zzL4wtD/ElufVxTCYzXiunL3chXeGRy1WLoWmYA7Tx7MJwfwy7lgk+x/
         v7iw==
X-Gm-Message-State: AOAM531C5SqJB8OzyFHtT3OqRd3B3/DIDfVhuNoKdw3XPPaYGc0k6VXe
        oHjFqjBPikspssOig1s72/tr0TBSp8Ioxg==
X-Google-Smtp-Source: ABdhPJwrrd46lFtRUW1klvmSoaJ4sjGG5NHKabk1laRX+332T8E9DqxRbjGbPK0AW3IkD/1xOhMC7A==
X-Received: by 2002:a5d:64ac:: with SMTP id m12mr2604482wrp.361.1643983640175;
        Fri, 04 Feb 2022 06:07:20 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id u19sm618722wmm.0.2022.02.04.06.07.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Feb 2022 06:07:19 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Han Xin <chiyutianyi@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <stolee@gmail.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v10 0/6] unpack-objects: support streaming large objects to disk
Date:   Fri,  4 Feb 2022 15:07:06 +0100
Message-Id: <cover-v10-0.6-00000000000-20220204T135538Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.940.ge7a5b4b05f2
In-Reply-To: <20220120112114.47618-1-chiyutianyi@gmail.com>
References: <20220120112114.47618-1-chiyutianyi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a v10 re-roll of Han Xin's series[1] to stream large objects
to disk in "git unpack-objects". This v9 had integrated a proposed
cleanup patch of mine, which is now a part of its own series, which
this series now depends on: [2]. This v10 is sent with Han Xin's
approval[3].

Changes since v9:

 * Now based on [2]
 * Small grammar/typo fixes in commit messages
 * Replaced an echo/eval pattern in a test with a $(find ... | wc -l)
   comparison, which is a pattern we already use in another test for
   the same (or similar) assertion.
 * I added a new 2/6 to do an fsync() before an oideq() assertion. I
   don't think it matters in practice, but allows 3/6 to be smaller by
   having that code-now-utility-function share more logic among its two callers.
 * Changed inline comments in 3/6 to API docs where appropriate, the
   helper function now gets a "fd" per 2/6.
 * 4/6 could use the format_object_header() function in the base
   topic, and now does so (instead of that conversion coming later in
   v9).
 * A new 5/6 updates the core.bigFileThreshold documentation to
   account for 12 years of behavior changes we hadn't documented.
 * The updated 6/6 now links to those docs, and I removed a very
   detailed accounting of all in-tree uses of core.bigFileThreshold
   from the commit message. I think linking to the summary docs should
   suffice, and for anyone digging in the future 5/6 links to the more
   detailed summary in the old patch.

More generally I've been heavily involved in the review for the past
iterations, and I think barring any last minute nits in this v10 this
topic should be ready to advance. As the above summary shows we're
down to typo fixes, doc and test tweaks etc. at this point.

The core functionality being added here isn't changed in any
meaningful way, and has had a lot of careful review already.

1. https://lore.kernel.org/git/20220120112114.47618-1-chiyutianyi@gmail.com/
2. https://lore.kernel.org/git/cover-v2-00.11-00000000000-20220204T135005Z-avarab@gmail.com/
3. https://lore.kernel.org/git/CAO0brD2Pe0aKSiBphZS861gC=nZk+q2GtXDN4pPjAQnPdns3TA@mail.gmail.com/

Han Xin (4):
  unpack-objects: low memory footprint for get_data() in dry_run mode
  object-file.c: refactor write_loose_object() to several steps
  object-file.c: add "stream_loose_object()" to handle large object
  unpack-objects: use stream_loose_object() to unpack large objects

Ævar Arnfjörð Bjarmason (2):
  object-file.c: do fsync() and close() before post-write die()
  core doc: modernize core.bigFileThreshold documentation

 Documentation/config/core.txt   |  33 +++--
 builtin/unpack-objects.c        | 110 ++++++++++++++--
 object-file.c                   | 221 +++++++++++++++++++++++++++-----
 object-store.h                  |   8 ++
 t/t5328-unpack-large-objects.sh |  62 +++++++++
 5 files changed, 381 insertions(+), 53 deletions(-)
 create mode 100755 t/t5328-unpack-large-objects.sh

Range-diff against v9:
1:  553a9377eb3 ! 1:  e46eb75b98f unpack-objects: low memory footprint for get_data() in dry_run mode
    @@ Commit message
         unpack-objects: low memory footprint for get_data() in dry_run mode
     
         As the name implies, "get_data(size)" will allocate and return a given
    -    size of memory. Allocating memory for a large blob object may cause the
    +    amount of memory. Allocating memory for a large blob object may cause the
         system to run out of memory. Before preparing to replace calling of
         "get_data()" to unpack large blob objects in latter commits, refactor
         "get_data()" to reduce memory footprint for dry_run mode.
    @@ Commit message
         in dry_run mode, "get_data()" will release the allocated buffer and
         return NULL instead of returning garbage data.
     
    +    The "find [...]objects/?? -type f | wc -l" test idiom being used here
    +    is adapted from the same "find" use added to another test in
    +    d9545c7f465 (fast-import: implement unpack limit, 2016-04-25).
    +
         Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void use(int bytes)
    @@ t/t5328-unpack-large-objects.sh (new)
     +}
     +
     +test_no_loose () {
    -+	glob=dest.git/objects/?? &&
    -+	echo "$glob" >expect &&
    -+	eval "echo $glob" >actual &&
    -+	test_cmp expect actual
    ++	test $(find dest.git/objects/?? -type f | wc -l) = 0
     +}
     +
     +test_expect_success "create large objects (1.5 MB) and PACK" '
-:  ----------- > 2:  48bf9090058 object-file.c: do fsync() and close() before post-write die()
2:  88c91affd61 ! 3:  0e33d2a6e35 object-file.c: refactor write_loose_object() to several steps
    @@ Commit message
         When writing a large blob using "write_loose_object()", we have to pass
         a buffer with the whole content of the blob, and this behavior will
         consume lots of memory and may cause OOM. We will introduce a stream
    -    version function ("stream_loose_object()") in latter commit to resolve
    +    version function ("stream_loose_object()") in later commit to resolve
         this issue.
     
    -    Before introducing a stream vesion function for writing loose object,
    -    do some refactoring on "write_loose_object()" to reuse code for both
    -    versions.
    +    Before introducing that streaming function, do some refactoring on
    +    "write_loose_object()" to reuse code for both versions.
     
         Rewrite "write_loose_object()" as follows:
     
    @@ Commit message
     
          3. Compress data.
     
    -     4. Move common steps for ending zlib stream into a new funciton
    +     4. Move common steps for ending zlib stream into a new function
             "end_loose_object_common()".
     
          5. Close fd and finalize the object file.
    @@ Commit message
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
     
      ## object-file.c ##
     @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filename)
      	return fd;
      }
      
    ++/**
    ++ * Common steps for loose object writers to start writing loose
    ++ * objects:
    ++ *
    ++ * - Create tmpfile for the loose object.
    ++ * - Setup zlib stream for compression.
    ++ * - Start to feed header to zlib stream.
    ++ *
    ++ * Returns a "fd", which should later be provided to
    ++ * end_loose_object_common().
    ++ */
     +static int start_loose_object_common(struct strbuf *tmp_file,
     +				     const char *filename, unsigned flags,
     +				     git_zstream *stream,
    @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filenam
     +	return fd;
     +}
     +
    -+static void end_loose_object_common(int ret, git_hash_ctx *c,
    ++/**
    ++ * Common steps for loose object writers to end writing loose objects:
    ++ *
    ++ * - End the compression of zlib stream.
    ++ * - Get the calculated oid to "parano_oid".
    ++ * - fsync() and close() the "fd"
    ++ */
    ++static void end_loose_object_common(int fd, int ret, git_hash_ctx *c,
     +				    git_zstream *stream,
     +				    struct object_id *parano_oid,
     +				    const struct object_id *expected_oid,
    @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const char *filenam
     +	if (ret != Z_OK)
     +		die(_(die_msg2_fmt), ret, expected_oid);
     +	the_hash_algo->final_oid_fn(parano_oid, c);
    ++
    ++	/*
    ++	 * We already did a write_buffer() to the "fd", let's fsync()
    ++	 * and close().
    ++	 *
    ++	 * We might still die() on a subsequent sanity check, but
    ++	 * let's not add to that confusion by not flushing any
    ++	 * outstanding writes to disk first.
    ++	 */
    ++	close_loose_object(fd);
     +}
     +
      static int write_loose_object(const struct object_id *oid, char *hdr,
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     -	while (git_deflate(&stream, 0) == Z_OK)
     -		; /* nothing */
     -	the_hash_algo->update_fn(&c, hdr, hdrlen);
    -+	/* Common steps for write_loose_object and stream_loose_object to
    -+	 * start writing loose oject:
    -+	 *
    -+	 *  - Create tmpfile for the loose object.
    -+	 *  - Setup zlib stream for compression.
    -+	 *  - Start to feed header to zlib stream.
    -+	 */
     +	fd = start_loose_object_common(&tmp_file, filename.buf, flags,
     +				       &stream, compressed, sizeof(compressed),
     +				       &c, hdr, hdrlen);
    @@ object-file.c: static int write_loose_object(const struct object_id *oid, char *
     -		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
     -		    ret);
     -	the_hash_algo->final_oid_fn(&parano_oid, &c);
    -+	/* Common steps for write_loose_object and stream_loose_object to
    -+	 * end writing loose oject:
    -+	 *
    -+	 *  - End the compression of zlib stream.
    -+	 *  - Get the calculated oid to "parano_oid".
    -+	 */
    -+	end_loose_object_common(ret, &c, &stream, &parano_oid, oid,
    +-
    +-	/*
    +-	 * We already did a write_buffer() to the "fd", let's fsync()
    +-	 * and close().
    +-	 *
    +-	 * We might still die() on a subsequent sanity check, but
    +-	 * let's not add to that confusion by not flushing any
    +-	 * outstanding writes to disk first.
    +-	 */
    +-	close_loose_object(fd);
    ++	end_loose_object_common(fd, ret, &c, &stream, &parano_oid, oid,
     +				N_("unable to deflate new object %s (%d)"),
     +				N_("deflateEnd on object %s failed (%d)"));
    -+
    + 
      	if (!oideq(oid, &parano_oid))
      		die(_("confused by unstable object source data for %s"),
    - 		    oid_to_hex(oid));
3:  054a00ed21d ! 4:  9644df5c744 object-file.c: add "stream_loose_object()" to handle large object
    @@ Commit message
     
         Add a new function "stream_loose_object()", which is a stream version of
         "write_loose_object()" but with a low memory footprint. We will use this
    -    function to unpack large blob object in latter commit.
    +    function to unpack large blob object in later commit.
     
         Another difference with "write_loose_object()" is that we have no chance
         to run "write_object_file_prepare()" to calculate the oid in advance.
         In "write_loose_object()", we know the oid and we can write the
         temporary file in the same directory as the final object, but for an
         object with an undetermined oid, we don't know the exact directory for
    -    the object, so we have to save the temporary file in ".git/objects/"
    -    directory instead.
    +    the object.
    +
    +    Still, we need to save the temporary file we're preparing
    +    somewhere. We'll do that in the top-level ".git/objects/"
    +    directory (or whatever "GIT_OBJECT_DIRECTORY" is set to). Once we've
    +    streamed it we'll know the OID, and will move it to its canonical
    +    path.
     
         "freshen_packed_object()" or "freshen_loose_object()" will be called
         inside "stream_loose_object()" after obtaining the "oid".
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +
     +	/* Since oid is not determined, save tmp file to odb path. */
     +	strbuf_addf(&filename, "%s/", get_object_directory());
    -+	hdrlen = xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_BLOB), len) + 1;
    ++	hdrlen = format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
     +
     +	/* Common steps for write_loose_object and stream_loose_object to
     +	 * start writing loose oject:
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +	 *  - End the compression of zlib stream.
     +	 *  - Get the calculated oid.
     +	 */
    -+	end_loose_object_common(ret, &c, &stream, oid, NULL,
    ++	end_loose_object_common(fd, ret, &c, &stream, oid, NULL,
     +				N_("unable to stream deflate new object (%d)"),
     +				N_("deflateEnd on stream object failed (%d)"));
     +
    -+	close_loose_object(fd);
    -+
     +	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
     +		unlink_or_warn(tmp_file.buf);
     +		goto cleanup;
    @@ object-file.c: static int freshen_packed_object(const struct object_id *oid)
     +}
     +
      int write_object_file_flags(const void *buf, unsigned long len,
    - 			    const char *type, struct object_id *oid,
    + 			    enum object_type type, struct object_id *oid,
      			    unsigned flags)
     
      ## object-store.h ##
    @@ object-store.h: struct object_directory {
      	struct object_directory *, 1, fspathhash, fspatheq)
      
     @@ object-store.h: static inline int write_object_file(const void *buf, unsigned long len,
    - 	return write_object_file_flags(buf, len, type, oid, 0);
    - }
    - 
    + int write_object_file_literally(const void *buf, unsigned long len,
    + 				const char *type, struct object_id *oid,
    + 				unsigned flags);
     +int stream_loose_object(struct input_stream *in_stream, size_t len,
     +			struct object_id *oid);
    -+
    - int hash_object_file_literally(const void *buf, unsigned long len,
    - 			       const char *type, struct object_id *oid,
    - 			       unsigned flags);
    + 
    + /*
    +  * Add an object file to the in-memory object store, without writing it
-:  ----------- > 5:  4550f3a2745 core doc: modernize core.bigFileThreshold documentation
4:  6bcba6bce66 ! 6:  6a70e49a346 unpack-objects: unpack_non_delta_entry() read data in a stream
    @@ Metadata
     Author: Han Xin <hanxin.hx@alibaba-inc.com>
     
      ## Commit message ##
    -    unpack-objects: unpack_non_delta_entry() read data in a stream
    +    unpack-objects: use stream_loose_object() to unpack large objects
     
    -    We used to call "get_data()" in "unpack_non_delta_entry()" to read the
    -    entire contents of a blob object, no matter how big it is. This
    -    implementation may consume all the memory and cause OOM.
    +    Make use of the stream_loose_object() function introduced in the
    +    preceding commit to unpack large objects. Before this we'd need to
    +    malloc() the size of the blob before unpacking it, which could cause
    +    OOM with very large blobs.
     
    -    By implementing a zstream version of input_stream interface, we can use
    -    a small fixed buffer for "unpack_non_delta_entry()". However, unpack
    -    non-delta objects from a stream instead of from an entrie buffer will
    -    have 10% performance penalty.
    +    We could use this new interface to unpack all blobs, but doing so
    +    would result in a performance penalty of around 10%, as the below
    +    "hyperfine" benchmark will show. We therefore limit this to files
    +    larger than "core.bigFileThreshold":
     
             $ hyperfine \
               --setup \
    @@ Commit message
                         -c core.bigFileThreshold=16k unpack-objects
                         <small.pack' in 'HEAD~1'
     
    -    Therefore, only unpack objects larger than the "core.bigFileThreshold"
    -    in zstream. Until now, the config variable has been used in the
    -    following cases, and our new case belongs to the packfile category.
    +    An earlier version of this patch introduced a new
    +    "core.bigFileStreamingThreshold" instead of re-using the existing
    +    "core.bigFileThreshold" variable[1]. As noted in a detailed overview
    +    of its users in [2] using it has several different meanings.
     
    -     * Archive:
    +    Still, we consider it good enough to simply re-use it. While it's
    +    possible that someone might want to e.g. consider objects "small" for
    +    the purposes of diffing but "big" for the purposes of writing them
    +    such use-cases are probably too obscure to worry about. We can always
    +    split up "core.bigFileThreshold" in the future if there's a need for
    +    that.
     
    -       + archive.c: write_entry(): write large blob entries to archive in
    -         stream.
    -
    -     * Loose objects:
    -
    -       + object-file.c: index_fd(): when hashing large files in worktree,
    -         read files in a stream, and create one packfile per large blob if
    -         want to save files to git object store.
    -
    -       + object-file.c: read_loose_object(): when checking loose objects
    -         using "git-fsck", do not read full content of large loose objects.
    -
    -     * Packfile:
    -
    -       + fast-import.c: parse_and_store_blob(): streaming large blob from
    -         foreign source to packfile.
    -
    -       + index-pack.c: check_collison(): read and check large blob in stream.
    -
    -       + index-pack.c: unpack_entry_data(): do not return the entire
    -         contents of the big blob from packfile, but uses a fixed buf to
    -         perform some integrity checks on the object.
    -
    -       + pack-check.c: verify_packfile(): used by "git-fsck" and will call
    -         check_object_signature() to check large blob in pack with the
    -         streaming interface.
    -
    -       + pack-objects.c: get_object_details(): set "no_try_delta" for large
    -         blobs when counting objects.
    -
    -       + pack-objects.c: write_no_reuse_object(): streaming large blob to
    -         pack.
    -
    -       + unpack-objects.c: unpack_non_delta_entry(): unpack large blob in
    -         stream from packfile.
    -
    -     * Others:
    -
    -       + diff.c: diff_populate_filespec(): treat large blob file as binary.
    -
    -       + streaming.c: istream_source(): as a helper of "open_istream()" to
    -         select proper streaming interface to read large blob from packfile.
    +    1. https://lore.kernel.org/git/20211210103435.83656-1-chiyutianyi@gmail.com/
    +    2. https://lore.kernel.org/git/20220120112114.47618-5-chiyutianyi@gmail.com/
     
         Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
         Helped-by: Derrick Stolee <stolee@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
     
    + ## Documentation/config/core.txt ##
    +@@ Documentation/config/core.txt: usage, at the slight expense of increased disk usage.
    + * Will be generally be streamed when written, which avoids excessive
    + memory usage, at the cost of some fixed overhead. Commands that make
    + use of this include linkgit:git-archive[1],
    +-linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
    +-linkgit:git-fsck[1].
    ++linkgit:git-fast-import[1], linkgit:git-index-pack[1],
    ++linkgit:git-unpack-objects[1] and linkgit:git-fsck[1].
    + 
    + core.excludesFile::
    + 	Specifies the pathname to the file that contains patterns to
    +
      ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enum object_type type,
      	}
5:  1bfaf89ee0b < -:  ----------- object-file API: add a format_object_header() function
-- 
2.35.1.940.ge7a5b4b05f2

