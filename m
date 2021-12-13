Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8D68C433F5
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 08:05:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232700AbhLMIFk (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 03:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232681AbhLMIFj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 03:05:39 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43FC8C06173F
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 00:05:39 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id v1so49627163edx.2
        for <git@vger.kernel.org>; Mon, 13 Dec 2021 00:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=meifT4sX13HfPzMQXzW/BAJ1y5v8toh0WRe0kP8Vnx4=;
        b=KoiuJJHOc5awzVc52xRA7ApkWbIlR+EmXKKTFJx1lITj3GEMh9652kUxCHV/2eBNej
         YoucqdnCs9O6MmQLyUsakZ3rbGbMDtHiR3qErgMl58J7EgRXBZ20xCisU4avShaqFEjg
         K2EMI+g3j9sE/fnxvejk/tv4GKgqmhAn0n1eDnLZRTX8JrWpO7EYWzfBMYHuX+yPStNP
         qyufRTM9KuuV/ezC7CgGPHaX1JWL9g5W6VVyfIowO5eS21G16FWgWxlH7Gft4bqcPFSk
         90MWcgcBqxRQpdX2qqJYhCiatsREyCP1PeQsODz8xl9bGECBOptE3/TRMcVfR2KHAwLx
         QDWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=meifT4sX13HfPzMQXzW/BAJ1y5v8toh0WRe0kP8Vnx4=;
        b=TcRh9KNYPcJpQY4YIJFyktNTMFzFOfux97ecttn4FY2IpyG7oEOMJVdjY4oNCIhCIl
         vz4QZP6fwQ5HdeIQf+z2hf0Oyzx5m3kfrE0E6LOm1ywlH65dRCe+wrypRusiUO6ajUx/
         he8J1fp3+sN3j4sJlQgSSt7ApNzhfnjFEiu5DIaRpnjLQVbdbIwOg2+qIK09vjLypFZu
         QR25G5xq8pYfTb5445S+Wrtn7KgjdPdx+WlJbjAlaGzgsf9Ndk8wH2hTvmh/miYKA4Uz
         YX3kQWovOoHSHE4A6w876df9dAdu+VB9NME9h2+JEgDxwYXLfL53hwMtlAqTyYIdC7n6
         d+LA==
X-Gm-Message-State: AOAM533F6w3ZMrck82/WRzU+DRU6Ld5uj554+cv4Bl2YBxX0TjX9Bixd
        4q7CTrT/2QCPS+3qr2HwJbU=
X-Google-Smtp-Source: ABdhPJxe16gNwpQBZaxMgC3C+Ljz9gdsSAqCXtGdCehBq9/OUw8UoJuv9V/lUiXhl3IxV7ICGH7rJA==
X-Received: by 2002:a17:907:7805:: with SMTP id la5mr41986518ejc.188.1639382737609;
        Mon, 13 Dec 2021 00:05:37 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id m25sm5798806edj.80.2021.12.13.00.05.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 00:05:37 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mwgL2-000l8s-BL;
        Mon, 13 Dec 2021 09:05:36 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v5 2/6] object-file.c: handle undetermined oid in
 write_loose_object()
Date:   Mon, 13 Dec 2021 08:32:58 +0100
References: <20211203093530.93589-1-chiyutianyi@gmail.com>
 <20211210103435.83656-3-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211210103435.83656-3-chiyutianyi@gmail.com>
Message-ID: <211213.86bl1l9bfz.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Fri, Dec 10 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> When streaming a large blob object to "write_loose_object()", we have no
> chance to run "write_object_file_prepare()" to calculate the oid in
> advance. So we need to handle undetermined oid in function
> "write_loose_object()".
>
> In the original implementation, we know the oid and we can write the
> temporary file in the same directory as the final object, but for an
> object with an undetermined oid, we don't know the exact directory for
> the object, so we have to save the temporary file in ".git/objects/"
> directory instead.
>
> The promise that "oid" is constant in "write_loose_object()" has been
> removed because it will be filled after reading all stream data.
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  object-file.c | 48 +++++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 39 insertions(+), 9 deletions(-)
>
> diff --git a/object-file.c b/object-file.c
> index 06375a90d6..41099b137f 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1860,11 +1860,11 @@ static int create_tmpfile(struct strbuf *tmp, con=
st char *filename)
>  	return fd;
>  }
>=20=20
> -static int write_loose_object(const struct object_id *oid, char *hdr,
> +static int write_loose_object(struct object_id *oid, char *hdr,
>  			      int hdrlen, const void *buf, unsigned long len,
>  			      time_t mtime, unsigned flags)
>  {
> -	int fd, ret;
> +	int fd, ret, err =3D 0;
>  	unsigned char compressed[4096];
>  	git_zstream stream;
>  	git_hash_ctx c;
> @@ -1872,16 +1872,21 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
>  	static struct strbuf tmp_file =3D STRBUF_INIT;
>  	static struct strbuf filename =3D STRBUF_INIT;
>=20=20
> -	loose_object_path(the_repository, &filename, oid);
> +	if (flags & HASH_STREAM)
> +		/* When oid is not determined, save tmp file to odb path. */
> +		strbuf_addf(&filename, "%s/", get_object_directory());
> +	else
> +		loose_object_path(the_repository, &filename, oid);
>=20=20
>  	fd =3D create_tmpfile(&tmp_file, filename.buf);
>  	if (fd < 0) {
>  		if (flags & HASH_SILENT)
> -			return -1;
> +			err =3D -1;
>  		else if (errno =3D=3D EACCES)
> -			return error(_("insufficient permission for adding an object to repos=
itory database %s"), get_object_directory());
> +			err =3D error(_("insufficient permission for adding an object to repo=
sitory database %s"), get_object_directory());
>  		else
> -			return error_errno(_("unable to create temporary file"));
> +			err =3D error_errno(_("unable to create temporary file"));
> +		goto cleanup;
>  	}
>=20=20
>  	/* Set it up */
> @@ -1923,12 +1928,34 @@ static int write_loose_object(const struct object=
_id *oid, char *hdr,
>  		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
>  		    ret);
>  	the_hash_algo->final_oid_fn(&parano_oid, &c);
> -	if (!oideq(oid, &parano_oid))
> +	if (!(flags & HASH_STREAM) && !oideq(oid, &parano_oid))
>  		die(_("confused by unstable object source data for %s"),
>  		    oid_to_hex(oid));

Here we don't have a meaningful "const" OID anymore, but still if we die
we use the "oid".=20

>  	close_loose_object(fd);
>=20=20
> +	if (flags & HASH_STREAM) {
> +		int dirlen;
> +
> +		oidcpy((struct object_id *)oid, &parano_oid);

This cast isn't needed anymore now that you stripped the "const" off,
but more on that later...

> +		loose_object_path(the_repository, &filename, oid);
> +
> +		/* We finally know the object path, and create the missing dir. */
> +		dirlen =3D directory_size(filename.buf);
> +		if (dirlen) {
> +			struct strbuf dir =3D STRBUF_INIT;
> +			strbuf_add(&dir, filename.buf, dirlen - 1);
> +			if (mkdir(dir.buf, 0777) && errno !=3D EEXIST)
> +				err =3D -1;
> +			else if (adjust_shared_perm(dir.buf))
> +				err =3D -1;
> +			else
> +				strbuf_release(&dir);
> +			if (err < 0)
> +				goto cleanup;

Can't we use one of the existing utility functions for this? Testing
locally I could replace this with:
=09
	diff --git a/object-file.c b/object-file.c
	index 7c93db11b2d..05e1fae893d 100644
	--- a/object-file.c
	+++ b/object-file.c
	@@ -1952,14 +1952,11 @@ static int write_loose_object(struct object_id *oi=
d, char *hdr,
	 		if (dirlen) {
	 			struct strbuf dir =3D STRBUF_INIT;
	 			strbuf_add(&dir, filename.buf, dirlen - 1);
	-			if (mkdir(dir.buf, 0777) && errno !=3D EEXIST)
	+=09=09=09
	+			if (mkdir_in_gitdir(dir.buf) < 0) {
	 				err =3D -1;
	-			else if (adjust_shared_perm(dir.buf))
	-				err =3D -1;
	-			else
	-				strbuf_release(&dir);
	-			if (err < 0)
	 				goto cleanup;
	+			}
	 		}
	 	}

And your tests still pass. Maybe they have a blind spot, or maybe we can
just use the existing function.
=09=20
> +		}
> +	}
> +
>  	if (mtime) {
>  		struct utimbuf utb;
>  		utb.actime =3D mtime;
> @@ -1938,7 +1965,10 @@ static int write_loose_object(const struct object_=
id *oid, char *hdr,
>  			warning_errno(_("failed utime() on %s"), tmp_file.buf);
>  	}
>=20=20
> -	return finalize_object_file(tmp_file.buf, filename.buf);
> +	err =3D finalize_object_file(tmp_file.buf, filename.buf);
> +cleanup:
> +	strbuf_release(&filename);
> +	return err;
>  }

Reading this series is an odd mixture of of things that would really be
much easier to understand if they were combined, e.g. 1/6 adding APIs
that aren't used by anything, but then adding one codepath (also
unused), that we then use later. Could just add it at the same time as
the use and the patch would be easier to read....

...and then this, which *is* something that could be split up into an
earlier cleanup step, i.e. the strbuf leak here exists before this
series, fixing it is good, but splitting that up into its own patch
would make this diff smaller & the actual behavior changes easier to
reason about.

>  static int freshen_loose_object(const struct object_id *oid)
> @@ -2015,7 +2045,7 @@ int force_object_loose(const struct object_id *oid,=
 time_t mtime)
>  	if (!buf)
>  		return error(_("cannot read object for %s"), oid_to_hex(oid));
>  	hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type),=
 (uintmax_t)len) + 1;
> -	ret =3D write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
> +	ret =3D write_loose_object((struct object_id*) oid, hdr, hdrlen, buf, l=
en, mtime, 0);
>  	free(buf);
>=20=20
>  	return ret;

 ...on the "more on that later", here we're casting the "oid" from const
 for a function that's never going to be involved in the streaming
 codepath.

I know I suggested the HASH_STREAM flag, but what I was really going for
was "let's share more of the code?", looking at this v5 (which is
already much better than v4) I think a better approach is to split up
write_loose_object().

I.e. it already calls close_loose_object() and finalize_object_file() to
do some of its work, but around that we have:

 1. Figuring out a path for the (temp) object file
 2. Creating the tempfile
 3. Setting up zlib
 4. Once zlib is set up inspect its state, die with a message
    about oid_to_hex(oid) if we failed
 5. Optionally, do HASH_STREAM stuff
    Maybe force a loose object if "mtime".

I think if that's split up so that each of those is its own little
function what's now write_loose_object() can call those in sequence, and
a new stream_loose_object() can just do #1 differentl, followed by the
same #2 and #4, but do #4 differently etc.

You'll still be able to re-use the write_object_file_prepare()
etc. logic.

As an example your 5/6 copy/pastes the xsnprintf() formatting of the
object header. It's just one line, but it's also code that's very
central to git, so I think instead of just copy/pasting it a prep step
of factoring it out would make sense, and that would be a prep cleanup
that would help later readability. E.g.:
=09
	diff --git a/object-file.c b/object-file.c
	index eac67f6f5f9..a7dcbd929e9 100644
	--- a/object-file.c
	+++ b/object-file.c
	@@ -1009,6 +1009,13 @@ void *xmmap(void *start, size_t length,
	 	return ret;
	 }
=09=20
	+static int generate_object_header(char *buf, int bufsz, const char *type_=
name,
	+				  unsigned long size)
	+{
	+	return xsnprintf(buf, bufsz, "%s %"PRIuMAX , type_name,
	+			 (uintmax_t)size) + 1;
	+}
	+
	 /*
	  * With an in-core object data in "map", rehash it to make sure the
	  * object name actually matches "oid" to detect object corruption.
	@@ -1037,7 +1044,7 @@ int check_object_signature(struct repository *r, con=
st struct object_id *oid,
	 		return -1;
=09=20
	 	/* Generate the header */
	-	hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(obj_typ=
e), (uintmax_t)size) + 1;
	+	hdrlen =3D generate_object_header(hdr, sizeof(hdr), type_name(obj_type),=
 size);
=09=20
	 	/* Sha1.. */
	 	r->hash_algo->init_fn(&c);
	@@ -1737,7 +1744,7 @@ static void write_object_file_prepare(const struct g=
it_hash_algo *algo,
	 	git_hash_ctx c;
=09=20
	 	/* Generate the header */
	-	*hdrlen =3D xsnprintf(hdr, *hdrlen, "%s %"PRIuMAX , type, (uintmax_t)len=
)+1;
	+	*hdrlen =3D generate_object_header(hdr, *hdrlen, type, len);
=09=20
	 	/* Sha1.. */
	 	algo->init_fn(&c);
	@@ -2009,7 +2016,7 @@ int force_object_loose(const struct object_id *oid, =
time_t mtime)
	 	buf =3D read_object(the_repository, oid, &type, &len);
	 	if (!buf)
	 		return error(_("cannot read object for %s"), oid_to_hex(oid));
	-	hdrlen =3D xsnprintf(hdr, sizeof(hdr), "%s %"PRIuMAX , type_name(type), =
(uintmax_t)len) + 1;
	+	hdrlen =3D generate_object_header(hdr, sizeof(hdr), type_name(type), len=
);
	 	ret =3D write_loose_object(oid, hdr, hdrlen, buf, len, mtime, 0);
	 	free(buf);

Then in your change on top you just call that generate_object_header(),
or better yet your amended write_object_file_flags() can just call a
similarly amended write_object_file_prepare() directly.
