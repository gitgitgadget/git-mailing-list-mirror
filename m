Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2A4EC433EF
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 22:52:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhLQWwn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 17:52:43 -0500
Received: from mout.web.de ([212.227.17.11]:52229 "EHLO mout.web.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229741AbhLQWwn (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 17:52:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de;
        s=dbaedf251592; t=1639781543;
        bh=Uzzf5hB55J2ZottiRWz8ibW0iXcXTrlt8UomOQfidK8=;
        h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
        b=r+WewtmzV9a+6Ps3N2FM9ibKaq+SQL800GuRJZ1TTK9PVoFQzKS+5PIjjg4xK02AL
         97H664aKWRGDNHsIAoZu0waTMxxtF4GxWkpa7c9R5ypBlXyZG9HLurRTx4WMbAEEkV
         rwRfJ+3YyWFkxhvU2TwZ8XtFo4vSF3nDGwCXbhmE=
X-UI-Sender-Class: c548c8c5-30a9-4db5-a2e7-cb6cb037b8f9
Received: from [192.168.178.29] ([79.203.22.121]) by smtp.web.de (mrweb105
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1MS17h-1n5LRc00Ud-00TFMm; Fri, 17
 Dec 2021 23:52:23 +0100
Message-ID: <e959e4f1-7500-5f6b-5bd2-2f060287eeff@web.de>
Date:   Fri, 17 Dec 2021 23:52:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.0
Subject: Re: [PATCH v6 4/6] object-file.c: make "write_object_file_flags()" to
 support read in stream
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee <stolee@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211210103435.83656-1-chiyutianyi@gmail.com>
 <20211217112629.12334-5-chiyutianyi@gmail.com>
From:   =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
In-Reply-To: <20211217112629.12334-5-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:ZbBPnMabaQ+2Tp4xwI8vhnH1CVucYnyhPQAqbCHEmeOadZfz4M6
 1/NDQnJKgg/ieA+nTb6uYMbNjH2HP4vhNpLaAcs3IO/T95itvoDGF20+MU6WccBu5XiQhev
 MyCUpVCC9F5h3lyRoMeoVL+IID7AYJtSf0/nar9Lduv8EZDPc3q+PG3lfa2cLnyN95uSeii
 19Ph9MuLmrtbM0UND45Sg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XILhazuc9bQ=:avJQ2aA/MHi3hmZZie9IeP
 f29D8tS/gZyhx08U43y0NnEX/M5U+H+Ta1ED0VP0DB+DG9Vy+2/Dc0Zr3g1G5RM+AdWUYs4YE
 2x+usu3CX903/YCWRCjBl0WvzfkJWFe/vDTIB2nntFRzJHNNxdB/dsI1UyrRshfEjhMPNuL0u
 E6vqEM1fdzVPPg4SR/ZweJ4iayjhx3YmMyhKQY8bW5EWRKbTHxhMRbo7Rt9NGbZgSyGUtVhc8
 XruwY3/ZIajDHfuEEY9ikFNA1lavXQc684WdBL2lhuZD6vodXaKc00XhnvNMmRBGRbquAeobd
 0omGQxa75Mpvn/F2Z+LYnxeuuRYMoE2jdG2IRkSaNEMfn1ZW0dRUAEtiETdv8JqwKj8HzzGif
 Fk3uNkw/N2fJHdAaXTyyil/GFJjb38bjDviHU9EspH13A7RLQeLWUwK1G/4toalWa5DnfEQz4
 wqTGPsICnO3Dy+t1E9uvgdrXG1RJ4zyfQyWqc0MRpA/Gsi9SuQWhmSsXDz9tL2ClK5+7d/Yro
 R7wtXtv7UIAhdyBfDQkiAZRalLqJkZ1WCtK7vhtuHFj3KPzUFejPUHODR2x/WC9XS819esF0o
 VXcU+nfl55DYKMxviD2MljmCKjNRstu8Mg+HLbtE8eeHr3VoTU8/VD6EdSCs3FJGNVesEW86B
 GiDBsaMyqCLsLFUmwnq2qaYDvi4QupMUUXpjHdl1Z/5V0LHmaGAhm5rjmOmYKRx2GALvX5Fn1
 lKIlyYGmfysMZseL02k04daE4PWf5IKm6uEpBQS6cbeYzt4I7p+qKpXuN87SzHa5nPZ9gLoF/
 mCnfQSfroyEmnmEaQjXYSgOSIA6X6W1nRKO21t4elq6J7wproauChls8tyvnIjrkgU0bl0YHM
 D1cvyjSgv3Uil7Caio4I54t9kNX/JYbhu0jOm3L/PRcQmhIgZrh0KbDGewP0ybtunGfkarsqU
 7UkTSLxzy4Y0bxlsBOaDP68aNPWEOL+n4DU0SXA9ze9X3XS9XWJpGx6FSKMXm+EcC/YyK6TrF
 gTdruT8LI6LcEHGmaW3g0NEQN47pVL8SmL3U/oS+iseenn5mnY3j8dGOxxhDhYnOtbczMwy1t
 CdF4vsbI3rRrfw=
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Am 17.12.21 um 12:26 schrieb Han Xin:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> entire contents of a blob object, no matter how big it is. This
> implementation may consume all the memory and cause OOM.
>
> This can be improved by feeding data to "stream_loose_object()" in a
> stream. The input stream is implemented as an interface.
>
> When streaming a large blob object to "write_loose_object()", we have no
> chance to run "write_object_file_prepare()" to calculate the oid in
> advance. So we need to handle undetermined oid in a new function called
> "stream_loose_object()".
>
> In "write_loose_object()", we know the oid and we can write the
> temporary file in the same directory as the final object, but for an
> object with an undetermined oid, we don't know the exact directory for
> the object, so we have to save the temporary file in ".git/objects/"
> directory instead.
>
> We will reuse "write_object_file_flags()" in "unpack_non_delta_entry()" =
to
> read the entire data contents in stream, so a new flag "HASH_STREAM" is
> added. When read in stream, we needn't prepare the "oid" before
> "write_loose_object()", only generate the header.
> "freshen_packed_object()" or "freshen_loose_object()" will be called
> inside "stream_loose_object()" after obtaining the "oid".
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  cache.h        |  1 +
>  object-file.c  | 92 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  object-store.h |  5 +++
>  3 files changed, 98 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index cfba463aa9..6d68fd10a3 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -898,6 +898,7 @@ int ie_modified(struct index_state *, const struct c=
ache_entry *, struct stat *,
>  #define HASH_FORMAT_CHECK 2
>  #define HASH_RENORMALIZE  4
>  #define HASH_SILENT 8
> +#define HASH_STREAM 16
>  int index_fd(struct index_state *istate, struct object_id *oid, int fd,=
 struct stat *st, enum object_type type, const char *path, unsigned flags)=
;
>  int index_path(struct index_state *istate, struct object_id *oid, const=
 char *path, struct stat *st, unsigned flags);
>
> diff --git a/object-file.c b/object-file.c
> index dd29e5372e..2ef1d4fb00 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1994,6 +1994,88 @@ static int freshen_packed_object(const struct obj=
ect_id *oid)
>  	return 1;
>  }
>
> +static int stream_loose_object(struct object_id *oid, char *hdr, int hd=
rlen,
> +			       const struct input_stream *in_stream,
> +			       unsigned long len, time_t mtime, unsigned flags)
> +{
> +	int fd, ret, err =3D 0, flush =3D 0;
> +	unsigned char compressed[4096];
> +	git_zstream stream;
> +	git_hash_ctx c;
> +	struct object_id parano_oid;
> +	static struct strbuf tmp_file =3D STRBUF_INIT;
> +	static struct strbuf filename =3D STRBUF_INIT;

Note these static strbufs.

> +	int dirlen;
> +
> +	/* When oid is not determined, save tmp file to odb path. */
> +	strbuf_addf(&filename, "%s/", get_object_directory());
> +
> +	fd =3D create_tmpfile(&tmp_file, filename.buf, flags);
> +	if (fd < 0) {
> +		err =3D -1;
> +		goto cleanup;
> +	}
> +
> +	/* Set it up and write header */
> +	setup_stream_and_header(&stream, compressed, sizeof(compressed),
> +				&c, hdr, hdrlen);
> +
> +	/* Then the data itself.. */
> +	do {
> +		unsigned char *in0 =3D stream.next_in;
> +		if (!stream.avail_in) {
> +			const void *in =3D in_stream->read(in_stream, &stream.avail_in);
> +			stream.next_in =3D (void *)in;
> +			in0 =3D (unsigned char *)in;
> +			/* All data has been read. */
> +			if (len + hdrlen =3D=3D stream.total_in + stream.avail_in)
> +				flush =3D Z_FINISH;
> +		}
> +		ret =3D git_deflate(&stream, flush);
> +		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
> +		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
> +			die(_("unable to write loose object file"));
> +		stream.next_out =3D compressed;
> +		stream.avail_out =3D sizeof(compressed);
> +	} while (ret =3D=3D Z_OK || ret =3D=3D Z_BUF_ERROR);
> +
> +	if (ret !=3D Z_STREAM_END)
> +		die(_("unable to deflate new object streamingly (%d)"), ret);
> +	ret =3D git_deflate_end_gently(&stream);
> +	if (ret !=3D Z_OK)
> +		die(_("deflateEnd on object streamingly failed (%d)"), ret);
> +	the_hash_algo->final_oid_fn(&parano_oid, &c);
> +
> +	close_loose_object(fd);
> +
> +	oidcpy(oid, &parano_oid);
> +
> +	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
> +		unlink_or_warn(tmp_file.buf);
> +		goto cleanup;
> +	}
> +
> +	loose_object_path(the_repository, &filename, oid);
> +
> +	/* We finally know the object path, and create the missing dir. */
> +	dirlen =3D directory_size(filename.buf);
> +	if (dirlen) {
> +		struct strbuf dir =3D STRBUF_INIT;
> +		strbuf_add(&dir, filename.buf, dirlen - 1);
> +
> +		if (mkdir_in_gitdir(dir.buf) < 0) {
> +			err =3D -1;
> +			goto cleanup;
> +		}
> +	}
> +
> +	err =3D finalize_object_file_with_mtime(tmp_file.buf, filename.buf, mt=
ime, flags);
> +cleanup:
> +	strbuf_release(&tmp_file);
> +	strbuf_release(&filename);

The static strbufs are released here.  That combination is strange --
why keep the variable values between calls by making them static, but
throw away the allocated buffers instead of reusing them?

Given that this function is only used for huge objects I think making
the strbufs non-static and releasing them is the best choice here.

> +	return err;
> +}
> +
>  int write_object_file_flags(const void *buf, unsigned long len,
>  			    const char *type, struct object_id *oid,
>  			    unsigned flags)
> @@ -2001,6 +2083,16 @@ int write_object_file_flags(const void *buf, unsi=
gned long len,
>  	char hdr[MAX_HEADER_LEN];
>  	int hdrlen =3D sizeof(hdr);
>
> +	/* When streaming a large blob object (marked as HASH_STREAM),
> +	 * we have no chance to run "write_object_file_prepare()" to
> +	 * calculate the "oid" in advance.  Call "stream_loose_object()"
> +	 * to write loose object in stream.
> +	 */
> +	if (flags & HASH_STREAM) {
> +		hdrlen =3D generate_object_header(hdr, hdrlen, type, len);
> +		return stream_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
> +	}

So stream_loose_object() is called by passing the flag HASH_STREAM to
write_object_file_flags() and passing a struct input_stream via its
buf pointer.  That's ... unconventional.  Certainly scary.  Why not
export stream_loose_object() and call it directly?  Demo patch below.

> +
>  	/* Normally if we have it in the pack then we do not bother writing
>  	 * it out into .git/objects/??/?{38} file.
>  	 */
> diff --git a/object-store.h b/object-store.h
> index 952efb6a4b..4040e2c40a 100644
> --- a/object-store.h
> +++ b/object-store.h
> @@ -34,6 +34,11 @@ struct object_directory {
>  	char *path;
>  };
>
> +struct input_stream {
> +	const void *(*read)(const struct input_stream *, unsigned long *len);
> +	void *data;
> +};
> +
>  KHASH_INIT(odb_path_map, const char * /* key: odb_path */,
>  	struct object_directory *, 1, fspathhash, fspatheq)
>


diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
index 42e1033d85..07d186bd20 100644
=2D-- a/builtin/unpack-objects.c
+++ b/builtin/unpack-objects.c
@@ -375,10 +375,8 @@ static void write_stream_blob(unsigned nr, unsigned l=
ong size)
 	data.zstream =3D &zstream;
 	git_inflate_init(&zstream);

-	if (write_object_file_flags(&in_stream, size,
-				    type_name(OBJ_BLOB),
-				    &obj_list[nr].oid,
-				    HASH_STREAM))
+	if (stream_loose_object(&in_stream, size, type_name(OBJ_BLOB), 0, 0,
+				&obj_list[nr].oid))
 		die(_("failed to write object in stream"));

 	if (zstream.total_out !=3D size || data.status !=3D Z_STREAM_END)
diff --git a/object-file.c b/object-file.c
index 2ef1d4fb00..0a6b65ab26 100644
=2D-- a/object-file.c
+++ b/object-file.c
@@ -1994,9 +1994,9 @@ static int freshen_packed_object(const struct object=
_id *oid)
 	return 1;
 }

-static int stream_loose_object(struct object_id *oid, char *hdr, int hdrl=
en,
-			       const struct input_stream *in_stream,
-			       unsigned long len, time_t mtime, unsigned flags)
+int stream_loose_object(struct input_stream *in_stream, unsigned long len=
,
+			const char *type, time_t mtime, unsigned flags,
+			struct object_id *oid)
 {
 	int fd, ret, err =3D 0, flush =3D 0;
 	unsigned char compressed[4096];
@@ -2006,6 +2006,10 @@ static int stream_loose_object(struct object_id *oi=
d, char *hdr, int hdrlen,
 	static struct strbuf tmp_file =3D STRBUF_INIT;
 	static struct strbuf filename =3D STRBUF_INIT;
 	int dirlen;
+	char hdr[MAX_HEADER_LEN];
+	int hdrlen =3D sizeof(hdr);
+
+	hdrlen =3D generate_object_header(hdr, hdrlen, type, len);

 	/* When oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", get_object_directory());
@@ -2083,16 +2087,6 @@ int write_object_file_flags(const void *buf, unsign=
ed long len,
 	char hdr[MAX_HEADER_LEN];
 	int hdrlen =3D sizeof(hdr);

-	/* When streaming a large blob object (marked as HASH_STREAM),
-	 * we have no chance to run "write_object_file_prepare()" to
-	 * calculate the "oid" in advance.  Call "stream_loose_object()"
-	 * to write loose object in stream.
-	 */
-	if (flags & HASH_STREAM) {
-		hdrlen =3D generate_object_header(hdr, hdrlen, type, len);
-		return stream_loose_object(oid, hdr, hdrlen, buf, len, 0, flags);
-	}
-
 	/* Normally if we have it in the pack then we do not bother writing
 	 * it out into .git/objects/??/?{38} file.
 	 */
diff --git a/object-store.h b/object-store.h
index 4040e2c40a..786b6435b1 100644
=2D-- a/object-store.h
+++ b/object-store.h
@@ -237,6 +237,10 @@ static inline int write_object_file(const void *buf, =
unsigned long len,
 	return write_object_file_flags(buf, len, type, oid, 0);
 }

+int stream_loose_object(struct input_stream *in_stream, unsigned long len=
,
+			const char *type, time_t mtime, unsigned flags,
+			struct object_id *oid);
+
 int hash_object_file_literally(const void *buf, unsigned long len,
 			       const char *type, struct object_id *oid,
 			       unsigned flags);

