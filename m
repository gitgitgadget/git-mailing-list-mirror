Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8EE4C433EF
	for <git@archiver.kernel.org>; Tue, 21 Dec 2021 15:06:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238935AbhLUPGb (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 10:06:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbhLUPGa (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 10:06:30 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5BFC06173F
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 07:06:30 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id y13so53160908edd.13
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 07:06:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:references:user-agent:in-reply-to
         :message-id:mime-version:content-transfer-encoding;
        bh=47dpxYYA7vFRQqmTFfumMKRUiY3oZdXf+TYKpF/113g=;
        b=MrjKB4Lpt4jpRyBj1697uAA9nW7qZ60qkJpR91aXcIAP7K24K5UNGO7C5L0QcW+uF1
         wfU4b+5XnPAul2avU4uBBmLukbGu02BA1PeN/V6k9J+hZWpnDp4JpHttNwA72TlDrVHq
         UV0yn5FOT2XE3NyvUjVuCOmWsrdUPMWsdRTOd5ZjOvwSnQ8l3/Roc37kkbx2QDnU1vt3
         4T6LJXTk2il9yss26uavAnWQdaA139i3WWsyx921n1I6aPhDVG2lm82F/MkmZyoM8SXT
         ipPRPj+cbyOO30C14dH0DSli4TyqmE9zGkQqgOAaU3/0NfsLhAQ9cScMBMfv1CNEZVFk
         6NWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:references:user-agent
         :in-reply-to:message-id:mime-version:content-transfer-encoding;
        bh=47dpxYYA7vFRQqmTFfumMKRUiY3oZdXf+TYKpF/113g=;
        b=X+8WZbn9oOu3Yfjs9yNkXIR21rd/+ek26WzWjg7l+yamRkfb7lo1fW4Hbw4I4DfmYM
         zEVbEQlIpjmErc6KHIqC5esHysBIjZ3jpjqrxRKrb9avDnC3tzUXuM8g5Mle0rySXLqk
         +fddjBLNQDLepQhjo17qNkpzC1PH8af7FX3b9MRvmo08R5vIRGUAw2lufx7qhvyywBOp
         Vxo0sSnUUdDtPyvjfGKAM0dX9w7MR82afKG+4Pirij3cMJcvwBar09VJgGQxEACR44z2
         UosZzLFcUTLv2IBos1T8slOVKoX6cdCKOlHXmxyfvObQoJV59vrtsOIToJMhLCCmmAYK
         NZCg==
X-Gm-Message-State: AOAM531AjmNsA1Zxf87p/CdwWt+NWoS2P0qKA6Ye0uIRh0fE1FTA6e0/
        C9lOAR0GJh4OVrfZ9Q7STdw=
X-Google-Smtp-Source: ABdhPJxun+3j5vJO5OKtmJDCEFSGfYGrAi4qiKHjdMLUB2lCwttGBtmXFyang5j0VMCstsyGaVdAwA==
X-Received: by 2002:a17:906:f890:: with SMTP id lg16mr3134331ejb.757.1640099188640;
        Tue, 21 Dec 2021 07:06:28 -0800 (PST)
Received: from gmgdl (j120189.upc-j.chello.nl. [24.132.120.189])
        by smtp.gmail.com with ESMTPSA id 24sm6552318eje.158.2021.12.21.07.06.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 07:06:28 -0800 (PST)
Received: from avar by gmgdl with local (Exim 4.95)
        (envelope-from <avarab@gmail.com>)
        id 1mzgih-000m9I-Ax;
        Tue, 21 Dec 2021 16:06:27 +0100
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
Date:   Tue, 21 Dec 2021 16:05:11 +0100
References: <20211217112629.12334-1-chiyutianyi@gmail.com>
 <20211221115201.12120-5-chiyutianyi@gmail.com>
 <211221.8635mmrpps.gmgdl@evledraar.gmail.com>
User-agent: Debian GNU/Linux bookworm/sid; Emacs 27.1; mu4e 1.6.10
In-reply-to: <211221.8635mmrpps.gmgdl@evledraar.gmail.com>
Message-ID: <211221.86tuf2q9os.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Tue, Dec 21 2021, =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason wrote:

> On Tue, Dec 21 2021, Han Xin wrote:

>> +	/* Then the data itself.. */
>> +	do {
>> +		unsigned char *in0 =3D stream.next_in;
>> +		if (!stream.avail_in) {
>> +			const void *in =3D in_stream->read(in_stream, &stream.avail_in);
>> +			stream.next_in =3D (void *)in;
>> +			in0 =3D (unsigned char *)in;
>> +			/* All data has been read. */
>> +			if (len + hdrlen =3D=3D stream.total_in + stream.avail_in)
>> +				flush =3D Z_FINISH;
>> +		}
>> +		ret =3D git_deflate(&stream, flush);
>> +		the_hash_algo->update_fn(&c, in0, stream.next_in - in0);
>> +		if (write_buffer(fd, compressed, stream.next_out - compressed) < 0)
>> +			die(_("unable to write loose object file"));
>> +		stream.next_out =3D compressed;
>> +		stream.avail_out =3D sizeof(compressed);
>> +	} while (ret =3D=3D Z_OK || ret =3D=3D Z_BUF_ERROR);
>> +
>> +	if (ret !=3D Z_STREAM_END)
>> +		die(_("unable to deflate new object streamingly (%d)"), ret);
>> +	ret =3D git_deflate_end_gently(&stream);
>> +	if (ret !=3D Z_OK)
>> +		die(_("deflateEnd on object streamingly failed (%d)"), ret);
>
> nit: let's say "unable to stream deflate new object" or something, and
> not use the confusing (invented?) word "streamingly".
>
>> +	the_hash_algo->final_oid_fn(&parano_oid, &c);
>> +
>> +	close_loose_object(fd);
>> +
>> +	oidcpy(oid, &parano_oid);
>
> I see there's still quite a bit of duplication between this and
> write_loose_object(), but maybe it's not easy to factor out.

For what it's worth I tried to do that and the result doesn't really
seem worth it. I.e. something like the below. The inner loop of the
do/while looks like it could get a similar treatment, but likewise
doesn't seem worth the effort.

diff --git a/object-file.c b/object-file.c
index b0dea96906e..7fc2363cfa1 100644
--- a/object-file.c
+++ b/object-file.c
@@ -1957,6 +1957,46 @@ static void setup_stream_and_header(git_zstream *str=
eam,
 	the_hash_algo->update_fn(c, hdr, hdrlen);
 }
=20
+static int start_loose_object_common(struct strbuf *tmp_file,
+				     const char *filename, unsigned flags,
+				     git_zstream *stream,
+				     unsigned char *buf, size_t buflen,
+				     git_hash_ctx *c,
+				     enum object_type type, size_t len,
+				     char *hdr, int *hdrlen)
+{
+	int fd;
+
+	fd =3D create_tmpfile(tmp_file, filename, flags);
+	if (fd < 0)
+		return -1;
+
+	if (type !=3D OBJ_NONE)
+		*hdrlen =3D format_object_header(hdr, *hdrlen, type, len);
+
+	/* Set it up and write header */
+	setup_stream_and_header(stream, buf, buflen, c, hdr, *hdrlen);
+
+	return fd;
+
+}
+
+static void end_loose_object_common(int ret, git_hash_ctx *c,
+				    git_zstream *stream,
+				    struct object_id *parano_oid,
+				    const struct object_id *expected_oid,
+				    const char *zstream_end_fmt,
+				    const char *z_ok_fmt)
+{
+	if (ret !=3D Z_STREAM_END)
+		die(_(zstream_end_fmt), ret, expected_oid);
+	ret =3D git_deflate_end_gently(stream);
+	if (ret !=3D Z_OK)
+		die(_(z_ok_fmt), ret, expected_oid);
+	the_hash_algo->final_oid_fn(parano_oid, c);
+}
+
+
 static int write_loose_object(const struct object_id *oid, char *hdr,
 			      int hdrlen, const void *buf, unsigned long len,
 			      time_t mtime, unsigned flags)
@@ -1970,15 +2010,12 @@ static int write_loose_object(const struct object_i=
d *oid, char *hdr,
 	static struct strbuf filename =3D STRBUF_INIT;
=20
 	loose_object_path(the_repository, &filename, oid);
-
-	fd =3D create_tmpfile(&tmp_file, filename.buf, flags);
+	fd =3D start_loose_object_common(&tmp_file, filename.buf, flags,
+				       &stream, compressed, sizeof(compressed),
+				       &c, OBJ_NONE, 0, hdr, &hdrlen);
 	if (fd < 0)
 		return -1;
=20
-	/* Set it up and write header */
-	setup_stream_and_header(&stream, compressed, sizeof(compressed),
-				&c, hdr, hdrlen);
-
 	/* Then the data itself.. */
 	stream.next_in =3D (void *)buf;
 	stream.avail_in =3D len;
@@ -1992,14 +2029,9 @@ static int write_loose_object(const struct object_id=
 *oid, char *hdr,
 		stream.avail_out =3D sizeof(compressed);
 	} while (ret =3D=3D Z_OK);
=20
-	if (ret !=3D Z_STREAM_END)
-		die(_("unable to deflate new object %s (%d)"), oid_to_hex(oid),
-		    ret);
-	ret =3D git_deflate_end_gently(&stream);
-	if (ret !=3D Z_OK)
-		die(_("deflateEnd on object %s failed (%d)"), oid_to_hex(oid),
-		    ret);
-	the_hash_algo->final_oid_fn(&parano_oid, &c);
+	end_loose_object_common(ret, &c, &stream, &parano_oid, oid,
+				N_("unable to deflate new object %s (%d)"),
+				N_("deflateEnd on object %s failed (%d)"));
 	if (!oideq(oid, &parano_oid))
 		die(_("confused by unstable object source data for %s"),
 		    oid_to_hex(oid));
@@ -2049,16 +2081,12 @@ int write_stream_object_file(struct input_stream *i=
n_stream, size_t len,
 	/* When oid is not determined, save tmp file to odb path. */
 	strbuf_addf(&filename, "%s/", get_object_directory());
=20
-	fd =3D create_tmpfile(&tmp_file, filename.buf, flags);
+	fd =3D start_loose_object_common(&tmp_file, filename.buf, flags,
+				       &stream, compressed, sizeof(compressed),
+				       &c, type, len, hdr, &hdrlen);
 	if (fd < 0)
 		return -1;
=20
-	hdrlen =3D format_object_header(hdr, hdrlen, type, len);
-
-	/* Set it up and write header */
-	setup_stream_and_header(&stream, compressed, sizeof(compressed),
-				&c, hdr, hdrlen);
-
 	/* Then the data itself.. */
 	do {
 		unsigned char *in0 =3D stream.next_in;
@@ -2078,12 +2106,9 @@ int write_stream_object_file(struct input_stream *in=
_stream, size_t len,
 		stream.avail_out =3D sizeof(compressed);
 	} while (ret =3D=3D Z_OK || ret =3D=3D Z_BUF_ERROR);
=20
-	if (ret !=3D Z_STREAM_END)
-		die(_("unable to deflate new object streamingly (%d)"), ret);
-	ret =3D git_deflate_end_gently(&stream);
-	if (ret !=3D Z_OK)
-		die(_("deflateEnd on object streamingly failed (%d)"), ret);
-	the_hash_algo->final_oid_fn(&parano_oid, &c);
+	end_loose_object_common(ret, &c, &stream, &parano_oid, NULL,
+				N_("unable to deflate new object streamingly (%d)"),
+				N_("deflateEnd on object streamingly failed (%d)"));
=20
 	close_loose_object(fd);
=20
