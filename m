Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE03C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 14:34:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238507AbhLUOe7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 09:34:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234548AbhLUOe7 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 09:34:59 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91AFFC061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:34:58 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id o20so52752226eds.10
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 06:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=T9tkc1SdQNDcwHhOXWNUYVv0rTtzOJTTry7ZfoOg9KE=;
        b=DczpF+8kjPzkhKwvj6yxPKi95FYKOJFlJ+kSah0juWjbkyFoS2zCepgOLlMbYkMAUj
         DgBYldu/Mqw99xjU+dkvkcSjAkwDzYge5ew/tEbBJ0zh9o+2qNQIn3Dlgp6cCBwmgVRQ
         DAOlhVwv3Kk/0K/PMjyb3KX5fDurJeFZ9mdyI8zmJedJ1CEAnR5rzwfWbLVnM+sStOqh
         RcHfhaEo3ct2O4Ps9UnWUK7/0qqCqgftHwazmB0ZYdRkXVmxvfuN8AO8Fqsz4b6hSE1n
         iuW4G6vnEbve5keD1oO0z/gMaEnt3eMT6CbL0YA2v5Z4uGv/tyqkjkZYgwjpruUljoHj
         Y2gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=T9tkc1SdQNDcwHhOXWNUYVv0rTtzOJTTry7ZfoOg9KE=;
        b=tE1jqQeZlNDJgWckFk59ba3nrpeV5/xH0lYjpXTEm8SBD/EWdXSBXr4uzxqwoEHC5A
         FzNfgl/kmttjLq+q/wIy3MoCtNLzh/nVRHuOH7NnHIrV6SkyD1aBZO01WUZoWSl/JKKY
         N4IRw+d6ZzLGlcLCpy+STEkJMbNYNiFynhXYaDIJzCJMRpUNm7t4qg+iOBvRfaYIRQVh
         JrsSPww2BKtl1ixL8iQ5ExCrYONFZRrAwxTL1REY9FCcCFjDbzO0n99NGp3dQvq5XbFQ
         +HOo6snZQYmBS2F19huW8AcPih87/Aa6GIAcvfqfEdoCTlcAaRpBqSWycfqOj83F7Wpx
         T4cA==
X-Gm-Message-State: AOAM531wJQu+Gkryg77fD7OpKQCDXIjDtBwqLsjC7SHaLAZ9LD4BRJFN
        PXf6Hhh9KpHpKJM8z5eQupc=
X-Google-Smtp-Source: ABdhPJziq1hqTyxd6Vv/tilurNLEk4WFdspbmnT4nsF7J8Srcsok+neSMBh8INNkYIH36TQ8ETKQqw==
X-Received: by 2002:a17:906:544d:: with SMTP id d13mr2862307ejp.651.1640097297007;
        Tue, 21 Dec 2021 06:34:57 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 3sm6553479ejq.159.2021.12.21.06.34.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 06:34:56 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzgEB-000lKa-Ju;
        Tue, 21 Dec 2021 15:34:55 +0100
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Han Xin <chiyutianyi@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Git List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        Derrick Stolee <stolee@gmail.com>,
        =?utf-8?Q?Re?= =?utf-8?Q?n=C3=A9?= Scharfe <l.s.r@web.de>,
        Han Xin <hanxin.hx@alibaba-inc.com>
Subject: Re: [PATCH v7 4/5] object-file.c: add "write_stream_object_file()"
 to support read in stream
Date:   Tue, 21 Dec 2021 15:20:22 +0100
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20211221115201.12120-5-chiyutianyi@gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <20211221115201.12120-5-chiyutianyi@gmail.com>
Message-ID: <211221.8635mmrpps.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, Han Xin wrote:

> From: Han Xin <hanxin.hx@alibaba-inc.com>
> [...]
> +int write_stream_object_file(struct input_stream *in_stream, size_t len,
> +			     enum object_type type, time_t mtime,
> +			     unsigned flags, struct object_id *oid)
> +{
> +	int fd, ret, flush =3D 0;
> +	unsigned char compressed[4096];
> +	git_zstream stream;
> +	git_hash_ctx c;
> +	struct object_id parano_oid;
> +	static struct strbuf tmp_file =3D STRBUF_INIT;
> +	static struct strbuf filename =3D STRBUF_INIT;
> +	int dirlen;
> +	char hdr[MAX_HEADER_LEN];
> +	int hdrlen =3D sizeof(hdr);
> +
> +	/* Since "filename" is defined as static, it will be reused. So reset it
> +	 * first before using it. */
> +	strbuf_reset(&filename);
> +	/* When oid is not determined, save tmp file to odb path. */
> +	strbuf_addf(&filename, "%s/", get_object_directory());

I realize this is somewhat following the pattern of code you moved
around earlier, but FWIW I think these sorts of comments are really
over-doing it. I.e. we try not to comment on things that are obvious
from the code itself.

Also Ren=C3=A9's comment on v6 still applies here:

    Given that this function is only used for huge objects I think making
    the strbufs non-static and releasing them is the best choice here.

I thin just making them non-static and doing a strbuf_release() as he
suggested is best here.

> +
> +	fd =3D create_tmpfile(&tmp_file, filename.buf, flags);
> +	if (fd < 0)
> +		return -1;
> +
> +	hdrlen =3D format_object_header(hdr, hdrlen, type, len);
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

nit: let's say "unable to stream deflate new object" or something, and
not use the confusing (invented?) word "streamingly".

> +	the_hash_algo->final_oid_fn(&parano_oid, &c);
> +
> +	close_loose_object(fd);
> +
> +	oidcpy(oid, &parano_oid);

I see there's still quite a bit of duplication between this and
write_loose_object(), but maybe it's not easy to factor out.

> +	if (freshen_packed_object(oid) || freshen_loose_object(oid)) {
> +		unlink_or_warn(tmp_file.buf);
> +		return 0;
> +	}
> +
> +	loose_object_path(the_repository, &filename, oid);
> +
> +	/* We finally know the object path, and create the missing dir. */
> +	dirlen =3D directory_size(filename.buf);
> +	if (dirlen) {
> +		struct strbuf dir =3D STRBUF_INIT;
> +		strbuf_add(&dir, filename.buf, dirlen - 1);

Just a minor nit, but I noticed we could have this on top, i.e. this
"remove the slash" is now what 1/3 users of it wan:
=09
	 object-file.c | 10 +++++-----
	 1 file changed, 5 insertions(+), 5 deletions(-)
=09
	diff --git a/object-file.c b/object-file.c
	index 77a3217fd0e..b0dea96906e 100644
	--- a/object-file.c
	+++ b/object-file.c
	@@ -1878,13 +1878,13 @@ static void close_loose_object(int fd)
	 		die_errno(_("error when closing loose object file"));
	 }
=09=20
	-/* Size of directory component, including the ending '/' */
	+/* Size of directory component, excluding the ending '/' */
	 static inline int directory_size(const char *filename)
	 {
	 	const char *s =3D strrchr(filename, '/');
	 	if (!s)
	 		return 0;
	-	return s - filename + 1;
	+	return s - filename;
	 }
=09=20
	 /*
	@@ -1901,7 +1901,7 @@ static int create_tmpfile(struct strbuf *tmp, const =
char *filename,
=09=20
	 	strbuf_reset(tmp);
	 	strbuf_add(tmp, filename, dirlen);
	-	strbuf_addstr(tmp, "tmp_obj_XXXXXX");
	+	strbuf_addstr(tmp, "/tmp_obj_XXXXXX");
	 	fd =3D git_mkstemp_mode(tmp->buf, 0444);
	 	do {
	 		if (fd >=3D 0 || !dirlen || errno !=3D ENOENT)
	@@ -1913,7 +1913,7 @@ static int create_tmpfile(struct strbuf *tmp, const =
char *filename,
	 		 * scratch.
	 		 */
	 		strbuf_reset(tmp);
	-		strbuf_add(tmp, filename, dirlen - 1);
	+		strbuf_add(tmp, filename, dirlen);
	 		if (mkdir(tmp->buf, 0777) && errno !=3D EEXIST)
	 			break;
	 		if (adjust_shared_perm(tmp->buf))
	@@ -2100,7 +2100,7 @@ int write_stream_object_file(struct input_stream *in=
_stream, size_t len,
	 	dirlen =3D directory_size(filename.buf);
	 	if (dirlen) {
	 		struct strbuf dir =3D STRBUF_INIT;
	-		strbuf_add(&dir, filename.buf, dirlen - 1);
	+		strbuf_add(&dir, filename.buf, dirlen);
=09=20
	 		if (mkdir_in_gitdir(dir.buf) && errno !=3D EEXIST) {
	 			ret =3D error_errno(_("unable to create directory %s"), dir.buf);

On my platform (linux) it's not needed either way, a "mkdir foo" works
as well as "mkdir foo/", but maybe some oS's have trouble with it.
