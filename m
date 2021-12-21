Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCB7AC433F5
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 15:15:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236121AbhLUPPF (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 10:15:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238988AbhLUPPE (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 10:15:04 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA9DBC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 07:15:03 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id w16so24934498edc.11
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 07:15:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=ptZ6R1x5MzCh3PmJS/25Grpxvnv38XSx2mxdaratNkY=;
        b=dUOZ5ienV+AMSEj1Mbx9TxftXhT5hgdcb0ig0BvkRHKydTZ9xtqFOJGfbxXrcGIzpF
         y6mX6i9yRflrCJ18zUpgzFpiex4pzTsYDmmJ+0hVfmoGir6f/5EpM7VYTxgtTP7asLVa
         A0PdMGTcmf28cFi9d39yCUQ4j6GRDknRPfgOFysO3ewM+6vy8N5N4SciHx2AeTP/jiPx
         hQUEHYu6moAMi3Q5biEhJIwxmPkA69nFdQRliwF18QkU8zaauQoBAJYvhvYn0hbVHEXg
         vBijOrBQSjSfxuCqBNuRPI5C9Z/LNTSoxQQoRJBhTdh0EFwBhgilR1HNdgGXOfvA2L3G
         zGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=ptZ6R1x5MzCh3PmJS/25Grpxvnv38XSx2mxdaratNkY=;
        b=SuJTpGsyWc2DQYYYYOEsTyV+DxfqwcPt6nmG9q18c7TPlTl89vcOmcRYg3gHKIiH29
         3jT0LeJX5XpWcupjtdtQuBarAfR2DHpwo9adaPUbpXi/hnAUrYlDPhlm6P8FKkCXEtqh
         AT2Fff+k8TrstZ2QsquNylE48/zYHNaUIYEy6Y7Pp19sWtdoYdlMOGuFN78POrZQ8gkb
         V0GqztNzC+hPBlc5hVi8vH8wY8x3sIbMtBDXvQoNoh/9Xs3XgXLmiGYaLp+xPB3Gmfyf
         W9eETEjNu/JxhSRv5XTnNaJgl37r5ejpiUqEBZCNI4RlQkTb3V1FKks/j4j/0Bpil/n9
         27pw==
X-Gm-Message-State: AOAM532hO501Qf0ia2p25nRBFry2RXrflSOd8fMvQBWZG9Qu9z6fEczz
        mZOy44PIrKHJxwoB4MsAlB4=
X-Google-Smtp-Source: ABdhPJxQHqyaxPFj2y8zHpc15u0V820grsOvgpsyJN+1xjJhF6ys0EhFzX2UwCUG7xJolS3nxMKJig==
X-Received: by 2002:a17:906:7e07:: with SMTP id e7mr2975420ejr.461.1640099702065;
        Tue, 21 Dec 2021 07:15:02 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id w10sm4452414edt.16.2021.12.21.07.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:15:01 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzgqy-000mOF-Ln;
        Tue, 21 Dec 2021 16:15:00 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v7 5/5] unpack-objects: unpack_non_delta_entry() read
 data in a stream
Date:   Tue, 21 Dec 2021 16:06:37 +0100
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20211221115201.12120-6-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211221115201.12120-6-chiyutianyi@gmail.com>
Message-ID: <211221.86pmpqq9aj.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
>
> We used to call "get_data()" in "unpack_non_delta_entry()" to read the
> entire contents of a blob object, no matter how big it is. This
> implementation may consume all the memory and cause OOM.
>
> By implementing a zstream version of input_stream interface, we can use
> a small fixed buffer for "unpack_non_delta_entry()".
>
> However, unpack non-delta objects from a stream instead of from an
> entrie buffer will have 10% performance penalty. Therefore, only unpack
> object larger than the "core.BigFileStreamingThreshold" in zstream. See
> the following benchmarks:
>
>     hyperfine \
>       --setup \
>       'if ! test -d scalar.git; then git clone --bare https://github.com/=
microsoft/scalar.git; cp scalar.git/objects/pack/*.pack small.pack; fi' \
>       --prepare 'rm -rf dest.git && git init --bare dest.git'
>
>     Summary
>       './git -C dest.git -c core.bigfilethreshold=3D512m unpack-objects <=
small.pack' in 'origin/master'
>         1.01 =C2=B1 0.04 times faster than './git -C dest.git -c core.big=
filethreshold=3D512m unpack-objects <small.pack' in 'HEAD~1'
>         1.01 =C2=B1 0.04 times faster than './git -C dest.git -c core.big=
filethreshold=3D512m unpack-objects <small.pack' in 'HEAD~0'
>         1.03 =C2=B1 0.10 times faster than './git -C dest.git -c core.big=
filethreshold=3D16k unpack-objects <small.pack' in 'origin/master'
>         1.02 =C2=B1 0.07 times faster than './git -C dest.git -c core.big=
filethreshold=3D16k unpack-objects <small.pack' in 'HEAD~0'
>         1.10 =C2=B1 0.04 times faster than './git -C dest.git -c core.big=
filethreshold=3D16k unpack-objects <small.pack' in 'HEAD~1'
>
> Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
> Helped-by: Derrick Stolee <stolee@gmail.com>
> Helped-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
> Signed-off-by: Han Xin <hanxin.hx@alibaba-inc.com>
> ---
>  Documentation/config/core.txt       | 11 +++++
>  builtin/unpack-objects.c            | 73 ++++++++++++++++++++++++++++-
>  cache.h                             |  1 +
>  config.c                            |  5 ++
>  environment.c                       |  1 +
>  t/t5590-unpack-non-delta-objects.sh | 36 +++++++++++++-
>  6 files changed, 125 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/config/core.txt b/Documentation/config/core.txt
> index c04f62a54a..601b7a2418 100644
> --- a/Documentation/config/core.txt
> +++ b/Documentation/config/core.txt
> @@ -424,6 +424,17 @@ be delta compressed, but larger binary media files w=
on't be.
>  +
>  Common unit suffixes of 'k', 'm', or 'g' are supported.
>=20=20
> +core.bigFileStreamingThreshold::
> +	Files larger than this will be streamed out to a temporary
> +	object file while being hashed, which will when be renamed
> +	in-place to a loose object, particularly if the
> +	`core.bigFileThreshold' setting dictates that they're always
> +	written out as loose objects.
> ++
> +Default is 128 MiB on all platforms.
> ++
> +Common unit suffixes of 'k', 'm', or 'g' are supported.
> +
>  core.excludesFile::
>  	Specifies the pathname to the file that contains patterns to
>  	describe paths that are not meant to be tracked, in addition
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 9104eb48da..72d8616e00 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -331,11 +331,82 @@ static void added_object(unsigned nr, enum object_t=
ype type,
>  	}
>  }
>=20=20
> +struct input_zstream_data {
> +	git_zstream *zstream;
> +	unsigned char buf[8192];
> +	int status;
> +};
> +
> +static const void *feed_input_zstream(struct input_stream *in_stream,
> +				      unsigned long *readlen)
> +{
> +	struct input_zstream_data *data =3D in_stream->data;
> +	git_zstream *zstream =3D data->zstream;
> +	void *in =3D fill(1);
> +
> +	if (!len || data->status =3D=3D Z_STREAM_END) {
> +		*readlen =3D 0;
> +		return NULL;
> +	}
> +
> +	zstream->next_out =3D data->buf;
> +	zstream->avail_out =3D sizeof(data->buf);
> +	zstream->next_in =3D in;
> +	zstream->avail_in =3D len;
> +
> +	data->status =3D git_inflate(zstream, 0);
> +	use(len - zstream->avail_in);
> +	*readlen =3D sizeof(data->buf) - zstream->avail_out;
> +
> +	return data->buf;
> +}
> +
> +static void write_stream_blob(unsigned nr, size_t size)
> +{
> +	git_zstream zstream;
> +	struct input_zstream_data data;
> +	struct input_stream in_stream =3D {
> +		.read =3D feed_input_zstream,
> +		.data =3D &data,
> +	};
> +
> +	memset(&zstream, 0, sizeof(zstream));
> +	memset(&data, 0, sizeof(data));

nit/style: both of these memset can be replaced by "{ 0 }", e.g. "git_zstre=
am zstream =3D { 0 }".

> +	data.zstream =3D &zstream;
> +	git_inflate_init(&zstream);
> +
> +	if (write_stream_object_file(&in_stream, size, OBJ_BLOB, 0, 0,
> +				     &obj_list[nr].oid))

So at the end of this series we never pass in anything but blob here,
mtime is always 0 etc. So there was no reason to create a factored out
finalize_object_file_with_mtime() earlier in the series.

Well, I don't mind the finalize_object_file_with_mtime() exiting, but
let's not pretend this is more generalized than it is. We're unlikely to
ever want to do this for non-blobs.

This on top of this series (and my local WIP fixups as I'm reviewing
this, so it won't cleanly apply, but the idea should be clear) makes
this simpler:
=09
	diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
	index 2f8d34a2e47..a3a1d4b266f 100644
	--- a/builtin/unpack-objects.c
	+++ b/builtin/unpack-objects.c
	@@ -375,8 +375,7 @@ static void write_stream_blob(unsigned nr, size_t size)
	 	data.zstream =3D &zstream;
	 	git_inflate_init(&zstream);
=09=20
	-	if (write_stream_object_file(&in_stream, size, OBJ_BLOB, 0, 0,
	-				     &obj_list[nr].oid))
	+	if (write_stream_object_file(&in_stream, size, &obj_list[nr].oid))
	 		die(_("failed to write object in stream"));
=09=20
	 	if (zstream.total_out !=3D size || data.status !=3D Z_STREAM_END)
	diff --git a/object-file.c b/object-file.c
	index 7fc2363cfa1..0572b34fc5a 100644
	--- a/object-file.c
	+++ b/object-file.c
	@@ -2061,8 +2061,7 @@ static int freshen_packed_object(const struct object=
_id *oid)
	 }
=09=20
	 int write_stream_object_file(struct input_stream *in_stream, size_t len,
	-			     enum object_type type, time_t mtime,
	-			     unsigned flags, struct object_id *oid)
	+			     struct object_id *oid)
	 {
	 	int fd, ret, flush =3D 0;
	 	unsigned char compressed[4096];
	@@ -2081,9 +2080,9 @@ int write_stream_object_file(struct input_stream *in=
_stream, size_t len,
	 	/* When oid is not determined, save tmp file to odb path. */
	 	strbuf_addf(&filename, "%s/", get_object_directory());
=09=20
	-	fd =3D start_loose_object_common(&tmp_file, filename.buf, flags,
	+	fd =3D start_loose_object_common(&tmp_file, filename.buf, 0,
	 				       &stream, compressed, sizeof(compressed),
	-				       &c, type, len, hdr, &hdrlen);
	+				       &c, OBJ_BLOB, len, hdr, &hdrlen);
	 	if (fd < 0)
	 		return -1;
=09=20
	@@ -2135,7 +2134,7 @@ int write_stream_object_file(struct input_stream *in=
_stream, size_t len,
	 		strbuf_release(&dir);
	 	}
=09=20
	-	return finalize_object_file_with_mtime(tmp_file.buf, filename.buf, mtime=
, flags);
	+	return finalize_object_file(tmp_file.buf, filename.buf);
	 }
=09=20
	 int write_object_file_flags(const void *buf, unsigned long len,
	diff --git a/object-store.h b/object-store.h
	index 87d370d39ca..1362b58a4d3 100644
	--- a/object-store.h
	+++ b/object-store.h
	@@ -257,8 +257,7 @@ int hash_write_object_file_literally(const void *buf, =
unsigned long len,
	 				     unsigned flags);
=09=20
	 int write_stream_object_file(struct input_stream *in_stream, size_t len,
	-			     enum object_type type, time_t mtime,
	-			     unsigned flags, struct object_id *oid);
	+			     struct object_id *oid);
=09=20
	 /*
	  * Add an object file to the in-memory object store, without writing it
=09

> +		die(_("failed to write object in stream"));
> diff --git a/environment.c b/environment.c
> index 0d06a31024..04bba593de 100644
> --- a/environment.c
> +++ b/environment.c
> @@ -47,6 +47,7 @@ size_t packed_git_window_size =3D DEFAULT_PACKED_GIT_WI=
NDOW_SIZE;
>  size_t packed_git_limit =3D DEFAULT_PACKED_GIT_LIMIT;
>  size_t delta_base_cache_limit =3D 96 * 1024 * 1024;
>  unsigned long big_file_threshold =3D 512 * 1024 * 1024;
> +unsigned long big_file_streaming_threshold =3D 128 * 1024 * 1024;
>  int pager_use_color =3D 1;
>  const char *editor_program;
>  const char *askpass_program;
> diff --git a/t/t5590-unpack-non-delta-objects.sh b/t/t5590-unpack-non-del=
ta-objects.sh
> index 48c4fb1ba3..8436cbf8db 100755
> --- a/t/t5590-unpack-non-delta-objects.sh
> +++ b/t/t5590-unpack-non-delta-objects.sh
> @@ -13,6 +13,11 @@ export GIT_TEST_DEFAULT_INITIAL_BRANCH_NAME
>  prepare_dest () {
>  	test_when_finished "rm -rf dest.git" &&
>  	git init --bare dest.git
> +	if test -n "$1"
> +	then
> +		git -C dest.git config core.bigFileStreamingThreshold $1
> +		git -C dest.git config core.bigFileThreshold $1
> +	fi

All of this new code is missing "&&" to chain & test forfailures.
