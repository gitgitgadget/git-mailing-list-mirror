Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28511C433F5
	for <git@archiver.kernel.org>; Tue,  1 Feb 2022 21:28:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232447AbiBAV2E (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Feb 2022 16:28:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiBAV2D (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Feb 2022 16:28:03 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A38C061714
        for <git@vger.kernel.org>; Tue,  1 Feb 2022 13:28:02 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id m11so37232213edi.13
        for <git@vger.kernel.org>; Tue, 01 Feb 2022 13:28:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=SvQNAXipToBUdUHwf65ZJ2jqAdFoVWvOseKKG4AZF60=;
        b=mquZzP5WUI5Sz+If71UUmZrt/4cJeiQoqu7sSB4hR+fkBwD41wJ7BG1C5FvyULahJ7
         6QldTF7N3+s6XylsCLJYr2xvQCTpNkYGJPQUqNQ14k+EfeTE578H/+33d9sl5J4N5Cys
         c93cjRTJ9UYINX4yB2Nc8bMK3bAUOK/hMqpdHnSgONEQ+6k5xUGfrMYtBfJ4rWESTGor
         AcVB9d6ecFYlBI4PiRnHwar8ZLRkUb9qTFiY8KD73oKomVWE6iq40PrC6COpcwqyyaTN
         gFeyFRe9/JJILL9VVPeKfCydbmdsaXBQGaMWOyXP4ZEQWFZZeIm9sYYScS3XME7fCIK7
         IujQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=SvQNAXipToBUdUHwf65ZJ2jqAdFoVWvOseKKG4AZF60=;
        b=J9HW1rtOMCCZLVM1+UAJgz9EVBq/8UUOXu+P1nTG1v1cmIvqH1L/mktiDkWVoy4+WF
         oqwP0dgSpNfnOO6xwyRiV1+FE58IzvRRFtJa1GzbJBh4bJwusyko8gX5b9WruddNnyHo
         4SLG/H5jNvMBui1PsMEIhpUIBlOwqqA+E2bo9doeh1uAmuK/39b8B/SaEyjAiNLhUAap
         AJcV9GDqsUUJDVhw6TClJ4dFludEGewC4adz9RfRGqnW3T2VND12uuGBBevGt0zo8SCD
         FtgDc9qnT6yKzCHX/pK+iterCvor4qUCIVwFRBDKp1wXBuBVglvEgwwbN5PYEEu7wNZ5
         aBTA==
X-Gm-Message-State: AOAM5312kjG0cNefOLTVYxMKxKKEOpxkpa8zNpL6XVjnuYPEdAp00qDV
        FK2o7bqrORcCop4YhkKMooCMQZnaHTm4rw==
X-Google-Smtp-Source: ABdhPJyhfPZmzE+FnKxYn4DG9sN9tcA1RUqojSxjcxrk4IbTEYtEirMgDv7GvoMQp4pBXbMw8/wyPA==
X-Received: by 2002:a05:6402:268d:: with SMTP id w13mr27367057edd.287.1643750881006;
        Tue, 01 Feb 2022 13:28:01 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id v3sm19155078edy.21.2022.02.01.13.28.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Feb 2022 13:28:00 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1nF0gx-004NFP-SK;
        Tue, 01 Feb 2022 22:27:59 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>,
        Jiang Xin <worldhello.net@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v9 0/5] unpack large blobs in stream
Date:   Tue, 01 Feb 2022 22:24:46 +0100
References: <20220108085419.79682-1-chiyutianyi@gmail.com>
 <20220120112114.47618-1-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20220120112114.47618-1-chiyutianyi@gmail.com>
Message-ID: <220201.86wnie8eg0.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Thu, Jan 20 2022, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> Changes since v8:
> * Rename "assert_no_loose ()" into "test_no_loose ()" in
>   "t5329-unpack-large-objects.sh". Remove "assert_no_pack ()" and use
>   "test_dir_is_empty" instead.
>
> * Revert changes to "create_tmpfile()" and error handling is now in
>   "start_loose_object_common()".
>
> * Remove "finalize_object_file_with_mtime()" which seems to be an overkill
>   for "write_loose_object()" now.=20
>
> * Remove the commit "object-file.c: remove the slash for directory_size()=
",
>   it can be in a separate patch if necessary.
>
> Han Xin (4):
>   unpack-objects: low memory footprint for get_data() in dry_run mode
>   object-file.c: refactor write_loose_object() to several steps
>   object-file.c: add "stream_loose_object()" to handle large object
>   unpack-objects: unpack_non_delta_entry() read data in a stream
>
> =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason (1):
>   object-file API: add a format_object_header() function

I sent
https://lore.kernel.org/git/cover-00.10-00000000000-20220201T144803Z-avarab=
@gmail.com/
today which suggests splitting out the 5/5 cleanup you'd integrated.

I then rebased these patches of yours on top of that, the result is
here:
https://github.com/avar/git/tree/han-xin-avar/unpack-loose-object-streaming=
-9

The range-diff to your version is below. There's a few unrelated
fixes/nits in it.

I think with/without basing this on top of my series above your patches
here look good with the nits pointed out in the diff below addressed
(and some don't need to be). I.e. the dependency on it is rather
trivial, and the two could be split up.

What do you think is a good way to proceed? I could just submit the
below as a proposed v10 if you'd like & agree...

1:  553a9377eb3 ! 1:  61fcfe7b840 unpack-objects: low memory footprint for =
get_data() in dry_run mode
    @@ Commit message
         unpack-objects: low memory footprint for get_data() in dry_run mode
=20=20=20=20=20
         As the name implies, "get_data(size)" will allocate and return a g=
iven
    -    size of memory. Allocating memory for a large blob object may caus=
e the
    +    amount of memory. Allocating memory for a large blob object may ca=
use the
         system to run out of memory. Before preparing to replace calling of
         "get_data()" to unpack large blob objects in latter commits, refac=
tor
         "get_data()" to reduce memory footprint for dry_run mode.
    @@ Commit message
=20=20=20=20=20
         Suggested-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void use(int bytes)
    @@ t/t5328-unpack-large-objects.sh (new)
     +
     +test_no_loose () {
     +	glob=3Ddest.git/objects/?? &&
    -+	echo "$glob" >expect &&
    -+	eval "echo $glob" >actual &&
    ++	echo $glob >expect &&
    ++	echo "$glob" >actual &&
     +	test_cmp expect actual
     +}
     +
-:  ----------- > 2:  c6b0437db03 object-file.c: do fsync() and close() bef=
ore post-write die()
2:  88c91affd61 ! 3:  77bcfe3da6f object-file.c: refactor write_loose_objec=
t() to several steps
    @@ Commit message
         When writing a large blob using "write_loose_object()", we have to=
 pass
         a buffer with the whole content of the blob, and this behavior will
         consume lots of memory and may cause OOM. We will introduce a stre=
am
    -    version function ("stream_loose_object()") in latter commit to res=
olve
    +    version function ("stream_loose_object()") in later commit to reso=
lve
         this issue.
=20=20=20=20=20
    -    Before introducing a stream vesion function for writing loose obje=
ct,
    -    do some refactoring on "write_loose_object()" to reuse code for bo=
th
    -    versions.
    +    Before introducing that streaming function, do some refactoring on
    +    "write_loose_object()" to reuse code for both versions.
=20=20=20=20=20
         Rewrite "write_loose_object()" as follows:
=20=20=20=20=20
    @@ Commit message
=20=20=20=20=20
          3. Compress data.
=20=20=20=20=20
    -     4. Move common steps for ending zlib stream into a new funciton
    +     4. Move common steps for ending zlib stream into a new function
             "end_loose_object_common()".
=20=20=20=20=20
          5. Close fd and finalize the object file.
    @@ Commit message
         Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
    +    Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmai=
l.com>
=20=20=20=20=20
      ## object-file.c ##
     @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const =
char *filename)
      	return fd;
      }
=20=20=20=20=20=20
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
    @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const c=
har *filenam
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
    @@ object-file.c: static int create_tmpfile(struct strbuf *tmp, const c=
har *filenam
     +	if (ret !=3D Z_OK)
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
    @@ object-file.c: static int write_loose_object(const struct object_id =
*oid, char *
     -	while (git_deflate(&stream, 0) =3D=3D Z_OK)
     -		; /* nothing */
     -	the_hash_algo->update_fn(&c, hdr, hdrlen);
    -+	/* Common steps for write_loose_object and stream_loose_object to
    -+	 * start writing loose oject:
    -+	 *
    -+	 *  - Create tmpfile for the loose object.
    -+	 *  - Setup zlib stream for compression.
    -+	 *  - Start to feed header to zlib stream.
    -+	 */
     +	fd =3D start_loose_object_common(&tmp_file, filename.buf, flags,
     +				       &stream, compressed, sizeof(compressed),
     +				       &c, hdr, hdrlen);
    @@ object-file.c: static int write_loose_object(const struct object_id =
*oid, char *
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
    +=20
      	if (!oideq(oid, &parano_oid))
      		die(_("confused by unstable object source data for %s"),
    - 		    oid_to_hex(oid));
3:  054a00ed21d ! 4:  71c10e734d1 object-file.c: add "stream_loose_object()=
" to handle large object
    @@ Commit message
=20=20=20=20=20
         Add a new function "stream_loose_object()", which is a stream vers=
ion of
         "write_loose_object()" but with a low memory footprint. We will us=
e this
    -    function to unpack large blob object in latter commit.
    +    function to unpack large blob object in later commit.
=20=20=20=20=20
         Another difference with "write_loose_object()" is that we have no =
chance
         to run "write_object_file_prepare()" to calculate the oid in advan=
ce.
         In "write_loose_object()", we know the oid and we can write the
         temporary file in the same directory as the final object, but for =
an
         object with an undetermined oid, we don't know the exact directory=
 for
    -    the object, so we have to save the temporary file in ".git/objects=
/"
    -    directory instead.
    +    the object.
    +
    +    Still, we need to save the temporary file we're preparing
    +    somewhere. We'll do that in the top-level ".git/objects/"
    +    directory (or whatever "GIT_OBJECT_DIRECTORY" is set to). Once we'=
ve
    +    streamed it we'll know the OID, and will move it to its canonical
    +    path.
=20=20=20=20=20
         "freshen_packed_object()" or "freshen_loose_object()" will be call=
ed
         inside "stream_loose_object()" after obtaining the "oid".
    @@ object-file.c: static int freshen_packed_object(const struct object_=
id *oid)
     +
     +	/* Since oid is not determined, save tmp file to odb path. */
     +	strbuf_addf(&filename, "%s/", get_object_directory());
    -+	hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX, type_name(OBJ_=
BLOB), len) + 1;
    ++	hdrlen =3D format_object_header(hdr, sizeof(hdr), OBJ_BLOB, len);
     +
     +	/* Common steps for write_loose_object and stream_loose_object to
     +	 * start writing loose oject:
    @@ object-file.c: static int freshen_packed_object(const struct object_=
id *oid)
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
    @@ object-file.c: static int freshen_packed_object(const struct object_=
id *oid)
     +}
     +
      int write_object_file_flags(const void *buf, unsigned long len,
    - 			    const char *type, struct object_id *oid,
    + 			    enum object_type type, struct object_id *oid,
      			    unsigned flags)
=20=20=20=20=20
      ## object-store.h ##
    @@ object-store.h: static inline int write_object_file(const void *buf,=
 unsigned lo
=20=20=20=20=20=20
     +int stream_loose_object(struct input_stream *in_stream, size_t len,
     +			struct object_id *oid);
    -+
    - int hash_object_file_literally(const void *buf, unsigned long len,
    - 			       const char *type, struct object_id *oid,
    - 			       unsigned flags);
    + int hash_write_object_file_literally(const void *buf, unsigned long l=
en,
    + 				     const char *type, struct object_id *oid,
    + 				     unsigned flags);
-:  ----------- > 5:  3c1d788d69d core doc: modernize core.bigFileThreshold=
 documentation
4:  6bcba6bce66 ! 6:  8b83f6d6b83 unpack-objects: unpack_non_delta_entry() =
read data in a stream
    @@ Metadata
     Author: Han Xin <hanxin.hx@alibaba-inc.com>
=20=20=20=20=20
      ## Commit message ##
    -    unpack-objects: unpack_non_delta_entry() read data in a stream
    +    unpack-objects: use stream_loose_object() to unpack large objects
=20=20=20=20=20
    -    We used to call "get_data()" in "unpack_non_delta_entry()" to read=
 the
    -    entire contents of a blob object, no matter how big it is. This
    -    implementation may consume all the memory and cause OOM.
    +    Make use of the stream_loose_object() function introduced in the
    +    preceding commit to unpack large objects. Before this we'd need to
    +    malloc() the size of the blob before unpacking it, which could cau=
se
    +    OOM with very large blobs.
=20=20=20=20=20
    -    By implementing a zstream version of input_stream interface, we ca=
n use
    -    a small fixed buffer for "unpack_non_delta_entry()". However, unpa=
ck
    -    non-delta objects from a stream instead of from an entrie buffer w=
ill
    -    have 10% performance penalty.
    +    We could use this new interface to unpack all blobs, but doing so
    +    would result in a performance penalty of around 10%, as the below
    +    "hyperfine" benchmark will show. We therefore limit this to files
    +    larger than "core.bigFileThreshold":
=20=20=20=20=20
             $ hyperfine \
               --setup \
    @@ Commit message
                         -c core.bigFileThreshold=3D16k unpack-objects
                         <small.pack' in 'HEAD~1'
=20=20=20=20=20
    -    Therefore, only unpack objects larger than the "core.bigFileThresh=
old"
    -    in zstream. Until now, the config variable has been used in the
    -    following cases, and our new case belongs to the packfile category.
    +    An earlier version of this patch introduced a new
    +    "core.bigFileStreamingThreshold" instead of re-using the existing
    +    "core.bigFileThreshold" variable[1]. As noted in a detailed overvi=
ew
    +    of its users in [2] using it has several different meanings.
=20=20=20=20=20
    -     * Archive:
    +    Still, we consider it good enough to simply re-use it. While it's
    +    possible that someone might want to e.g. consider objects "small" =
for
    +    the purposes of diffing but "big" for the purposes of writing them
    +    such use-cases are probably too obscure to worry about. We can alw=
ays
    +    split up "core.bigFileThreshold" in the future if there's a need f=
or
    +    that.
=20=20=20=20=20
    -       + archive.c: write_entry(): write large blob entries to archive=
 in
    -         stream.
    -
    -     * Loose objects:
    -
    -       + object-file.c: index_fd(): when hashing large files in worktr=
ee,
    -         read files in a stream, and create one packfile per large blo=
b if
    -         want to save files to git object store.
    -
    -       + object-file.c: read_loose_object(): when checking loose objec=
ts
    -         using "git-fsck", do not read full content of large loose obj=
ects.
    -
    -     * Packfile:
    -
    -       + fast-import.c: parse_and_store_blob(): streaming large blob f=
rom
    -         foreign source to packfile.
    -
    -       + index-pack.c: check_collison(): read and check large blob in =
stream.
    -
    -       + index-pack.c: unpack_entry_data(): do not return the entire
    -         contents of the big blob from packfile, but uses a fixed buf =
to
    -         perform some integrity checks on the object.
    -
    -       + pack-check.c: verify_packfile(): used by "git-fsck" and will =
call
    -         check_object_signature() to check large blob in pack with the
    -         streaming interface.
    -
    -       + pack-objects.c: get_object_details(): set "no_try_delta" for =
large
    -         blobs when counting objects.
    -
    -       + pack-objects.c: write_no_reuse_object(): streaming large blob=
 to
    -         pack.
    -
    -       + unpack-objects.c: unpack_non_delta_entry(): unpack large blob=
 in
    -         stream from packfile.
    -
    -     * Others:
    -
    -       + diff.c: diff_populate_filespec(): treat large blob file as bi=
nary.
    -
    -       + streaming.c: istream_source(): as a helper of "open_istream()=
" to
    -         select proper streaming interface to read large blob from pac=
kfile.
    +    1. https://lore.kernel.org/git/20211210103435.83656-1-chiyutianyi@=
gmail.com/
    +    2. https://lore.kernel.org/git/20220120112114.47618-5-chiyutianyi@=
gmail.com/
=20=20=20=20=20
         Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.co=
m>
         Helped-by: Derrick Stolee <stolee@gmail.com>
         Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
         Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
=20=20=20=20=20
    + ## Documentation/config/core.txt ##
    +@@ Documentation/config/core.txt: usage, at the slight expense of incr=
eased disk usage.
    + * Will be generally be streamed when written, which avoids excessive
    + memory usage, at the cost of some fixed overhead. Commands that make
    + use of this include linkgit:git-archive[1],
    +-linkgit:git-fast-import[1], linkgit:git-index-pack[1] and
    +-linkgit:git-fsck[1].
    ++linkgit:git-fast-import[1], linkgit:git-index-pack[1],
    ++linkgit:git-unpack-objects[1] and linkgit:git-fsck[1].
    +=20
    + core.excludesFile::
    + 	Specifies the pathname to the file that contains patterns to
    +
      ## builtin/unpack-objects.c ##
     @@ builtin/unpack-objects.c: static void added_object(unsigned nr, enu=
m object_type type,
      	}
5:  1bfaf89ee0b < -:  ----------- object-file API: add a format_object_head=
er() function
