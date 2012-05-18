From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] pack-objects: refactor write_object()
Date: Fri, 18 May 2012 14:16:55 -0700
Message-ID: <xmqqfwax2nqw.fsf@junio.mtv.corp.google.com>
References: <1336818375-16895-1-git-send-email-pclouds@gmail.com>
	<1337169731-23416-1-git-send-email-pclouds@gmail.com>
	<1337169731-23416-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Nicolas Pitre <nico@fluxnic.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri May 18 23:17:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVUXn-0000th-0z
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 23:17:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S967460Ab2ERVQ6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 May 2012 17:16:58 -0400
Received: from mail-yx0-f202.google.com ([209.85.213.202]:52075 "EHLO
	mail-yx0-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965340Ab2ERVQ4 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 May 2012 17:16:56 -0400
Received: by yenl3 with SMTP id l3so419892yen.1
        for <git@vger.kernel.org>; Fri, 18 May 2012 14:16:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type:content-transfer-encoding
         :x-gm-message-state;
        bh=nQ2QbudHnTs8SrB9aJR0a1AnHyXYuQyWKW/Vgr8S3Ow=;
        b=O8y4qx0F0L1mh8LR0Qxc5XmWyf5JAM9J9W75Da1TpRn18DgY17nstoYSD3W9B9xgfk
         oGj4/w9JVroFANORGupjkmNQf9G/vJ4kv7DHVU6n2TTL6Me+5hMIfvyAbgBBjbgZgOzn
         965yPE5SpxuQ+mvQmxvVFSe/sXaWJUifFVYYIgmD3KVKUP9NA0NsqmMZb2ce8wZQPgbH
         GUxP2Q1usJI0Vx7SMA7gPIRV2qv816htKO04bE2u62jcXSpPjYdlZ7PGx5zk/cEErf7W
         OLyK6ykPfUnSGJ1O9hGfT7vi16cAQsHLV0+xxEwzdBxbSXzCl65M//8nAm+XCoK0hNsQ
         tTdA==
Received: by 10.101.39.7 with SMTP id r7mr5861243anj.9.1337375816172;
        Fri, 18 May 2012 14:16:56 -0700 (PDT)
Received: by 10.101.39.7 with SMTP id r7mr5861236anj.9.1337375816107;
        Fri, 18 May 2012 14:16:56 -0700 (PDT)
Received: from wpzn4.hot.corp.google.com (216-239-44-65.google.com [216.239.44.65])
        by gmr-mx.google.com with ESMTPS id w40si3722997anp.3.2012.05.18.14.16.56
        (version=TLSv1/SSLv3 cipher=AES128-SHA);
        Fri, 18 May 2012 14:16:56 -0700 (PDT)
Received: from junio.mtv.corp.google.com (junio.mtv.corp.google.com [172.27.69.24])
	by wpzn4.hot.corp.google.com (Postfix) with ESMTP id E9B2A1E004D;
	Fri, 18 May 2012 14:16:55 -0700 (PDT)
Received: by junio.mtv.corp.google.com (Postfix, from userid 110493)
	id 93CCEE1772; Fri, 18 May 2012 14:16:55 -0700 (PDT)
In-Reply-To: <1337169731-23416-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Wed, 16
 May 2012 19:02:10 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.1 (gnu/linux)
X-Gm-Message-State: ALoCoQmLl1WuLiSsfm6K8NQc6Dg2CJSSceZvhy6TRpvRhfmE5WCPMRyOAaeqbZbxHZLX/eNw+MNO0O7Jufm7vVvYVKlv6dfXA/7o1c09+f9Yej3riikyvQlynYCe7uHRZjAwUqUV/AvyanRgyFe95muajPJFahaY9g==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197974>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Move !to_reuse and to_reuse write code out into two separate function=
s
> and remove "goto no_reuse;" hack

I do not necessarily think goto is a harmful hack, but the original cod=
e
is sufficiently large and its flow clearly ought to be separable into
two phases (phase I: decide if we want to copy from existing pack or
build data to be sent to the pack afresh; phase II: carry out the
decision, doing one of the two things we decided to do), so I think it
makes tons of sense to separate out the second phase into two helper
functions.

Looks good from a cursory reading.

Thanks.

> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---
>  builtin/pack-objects.c |  322 ++++++++++++++++++++++++++------------=
----------
>  1 files changed, 172 insertions(+), 150 deletions(-)
>
> diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
> index b2e0940..ccfcbad 100644
> --- a/builtin/pack-objects.c
> +++ b/builtin/pack-objects.c
> @@ -200,22 +200,178 @@ static void copy_pack_data(struct sha1file *f,
>  }
> =20
>  /* Return 0 if we will bust the pack-size limit */
> +static unsigned long write_no_reuse_object(struct sha1file *f, struc=
t object_entry *entry,
> +					   unsigned long limit, int usable_delta)
>  {
> +	unsigned long size, datalen;
>  	unsigned char header[10], dheader[10];
>  	unsigned hdrlen;
>  	enum object_type type;
> +	void *buf;
> +
> +	if (!usable_delta) {
> +		buf =3D read_sha1_file(entry->idx.sha1, &type, &size);
> +		if (!buf)
> +			die("unable to read %s", sha1_to_hex(entry->idx.sha1));
> +		/*
> +		 * make sure no cached delta data remains from a
> +		 * previous attempt before a pack split occurred.
> +		 */
> +		free(entry->delta_data);
> +		entry->delta_data =3D NULL;
> +		entry->z_delta_size =3D 0;
> +	} else if (entry->delta_data) {
> +		size =3D entry->delta_size;
> +		buf =3D entry->delta_data;
> +		entry->delta_data =3D NULL;
> +		type =3D (allow_ofs_delta && entry->delta->idx.offset) ?
> +			OBJ_OFS_DELTA : OBJ_REF_DELTA;
> +	} else {
> +		buf =3D get_delta(entry);
> +		size =3D entry->delta_size;
> +		type =3D (allow_ofs_delta && entry->delta->idx.offset) ?
> +			OBJ_OFS_DELTA : OBJ_REF_DELTA;
> +	}
> +
> +	if (entry->z_delta_size)
> +		datalen =3D entry->z_delta_size;
> +	else
> +		datalen =3D do_compress(&buf, size);
> +
> +	/*
> +	 * The object header is a byte of 'type' followed by zero or
> +	 * more bytes of length.
> +	 */
> +	hdrlen =3D encode_in_pack_object_header(type, size, header);
> +
> +	if (type =3D=3D OBJ_OFS_DELTA) {
> +		/*
> +		 * Deltas with relative base contain an additional
> +		 * encoding of the relative offset for the delta
> +		 * base from this object's position in the pack.
> +		 */
> +		off_t ofs =3D entry->idx.offset - entry->delta->idx.offset;
> +		unsigned pos =3D sizeof(dheader) - 1;
> +		dheader[pos] =3D ofs & 127;
> +		while (ofs >>=3D 7)
> +			dheader[--pos] =3D 128 | (--ofs & 127);
> +		if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >=3D li=
mit) {
> +			free(buf);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +		sha1write(f, dheader + pos, sizeof(dheader) - pos);
> +		hdrlen +=3D sizeof(dheader) - pos;
> +	} else if (type =3D=3D OBJ_REF_DELTA) {
> +		/*
> +		 * Deltas with a base reference contain
> +		 * an additional 20 bytes for the base sha1.
> +		 */
> +		if (limit && hdrlen + 20 + datalen + 20 >=3D limit) {
> +			free(buf);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +		sha1write(f, entry->delta->idx.sha1, 20);
> +		hdrlen +=3D 20;
> +	} else {
> +		if (limit && hdrlen + datalen + 20 >=3D limit) {
> +			free(buf);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +	}
> +	sha1write(f, buf, datalen);
> +	free(buf);
> +
> +	return hdrlen + datalen;
> +}
> +
> +/* Return 0 if we will bust the pack-size limit */
> +static unsigned long write_reuse_object(struct sha1file *f, struct o=
bject_entry *entry,
> +					unsigned long limit, int usable_delta)
> +{
> +	struct packed_git *p =3D entry->in_pack;
> +	struct pack_window *w_curs =3D NULL;
> +	struct revindex_entry *revidx;
> +	off_t offset;
> +	enum object_type type =3D entry->type;
> +	unsigned long datalen;
> +	unsigned char header[10], dheader[10];
> +	unsigned hdrlen;
> +
> +	if (entry->delta)
> +		type =3D (allow_ofs_delta && entry->delta->idx.offset) ?
> +			OBJ_OFS_DELTA : OBJ_REF_DELTA;
> +	hdrlen =3D encode_in_pack_object_header(type, entry->size, header);
> +
> +	offset =3D entry->in_pack_offset;
> +	revidx =3D find_pack_revindex(p, offset);
> +	datalen =3D revidx[1].offset - offset;
> +	if (!pack_to_stdout && p->index_version > 1 &&
> +	    check_pack_crc(p, &w_curs, offset, datalen, revidx->nr)) {
> +		error("bad packed object CRC for %s", sha1_to_hex(entry->idx.sha1)=
);
> +		unuse_pack(&w_curs);
> +		return write_no_reuse_object(f, entry, limit, usable_delta);
> +	}
> +
> +	offset +=3D entry->in_pack_header_size;
> +	datalen -=3D entry->in_pack_header_size;
> +
> +	if (!pack_to_stdout && p->index_version =3D=3D 1 &&
> +	    check_pack_inflate(p, &w_curs, offset, datalen, entry->size)) {
> +		error("corrupt packed object for %s", sha1_to_hex(entry->idx.sha1)=
);
> +		unuse_pack(&w_curs);
> +		return write_no_reuse_object(f, entry, limit, usable_delta);
> +	}
> +
> +	if (type =3D=3D OBJ_OFS_DELTA) {
> +		off_t ofs =3D entry->idx.offset - entry->delta->idx.offset;
> +		unsigned pos =3D sizeof(dheader) - 1;
> +		dheader[pos] =3D ofs & 127;
> +		while (ofs >>=3D 7)
> +			dheader[--pos] =3D 128 | (--ofs & 127);
> +		if (limit && hdrlen + sizeof(dheader) - pos + datalen + 20 >=3D li=
mit) {
> +			unuse_pack(&w_curs);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +		sha1write(f, dheader + pos, sizeof(dheader) - pos);
> +		hdrlen +=3D sizeof(dheader) - pos;
> +		reused_delta++;
> +	} else if (type =3D=3D OBJ_REF_DELTA) {
> +		if (limit && hdrlen + 20 + datalen + 20 >=3D limit) {
> +			unuse_pack(&w_curs);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +		sha1write(f, entry->delta->idx.sha1, 20);
> +		hdrlen +=3D 20;
> +		reused_delta++;
> +	} else {
> +		if (limit && hdrlen + datalen + 20 >=3D limit) {
> +			unuse_pack(&w_curs);
> +			return 0;
> +		}
> +		sha1write(f, header, hdrlen);
> +	}
> +	copy_pack_data(f, p, &w_curs, offset, datalen);
> +	unuse_pack(&w_curs);
> +	reused++;
> +	return hdrlen + datalen;
> +}
> +
> +/* Return 0 if we will bust the pack-size limit */
> +static unsigned long write_object(struct sha1file *f,
> +				  struct object_entry *entry,
> +				  off_t write_offset)
> +{
> +	unsigned long limit, len;
>  	int usable_delta, to_reuse;
> =20
>  	if (!pack_to_stdout)
>  		crc32_begin(f);
> =20
>  	/* apply size limit if limited packsize and not first object */
>  	if (!pack_size_limit || !nr_written)
>  		limit =3D 0;
> @@ -243,11 +399,11 @@ static unsigned long write_object(struct sha1fi=
le *f,
>  		to_reuse =3D 0;	/* explicit */
>  	else if (!entry->in_pack)
>  		to_reuse =3D 0;	/* can't reuse what we don't have */
> +	else if (entry->type =3D=3D OBJ_REF_DELTA || entry->type =3D=3D OBJ=
_OFS_DELTA)
>  				/* check_object() decided it for us ... */
>  		to_reuse =3D usable_delta;
>  				/* ... but pack split may override that */
> +	else if (entry->type !=3D entry->in_pack_type)
>  		to_reuse =3D 0;	/* pack has delta which is unusable */
>  	else if (entry->delta)
>  		to_reuse =3D 0;	/* we want to pack afresh */
> @@ -256,153 +412,19 @@ static unsigned long write_object(struct sha1f=
ile *f,
>  				 * and we do not need to deltify it.
>  				 */
> =20
> +	if (!to_reuse)
> +		len =3D write_no_reuse_object(f, entry, limit, usable_delta);
> +	else
> +		len =3D write_reuse_object(f, entry, limit, usable_delta);
> +	if (!len)
> +		return 0;
> =20
>  	if (usable_delta)
>  		written_delta++;
>  	written++;
>  	if (!pack_to_stdout)
>  		entry->idx.crc32 =3D crc32_end(f);
> -	return hdrlen + datalen;
> +	return len;
>  }
> =20
>  enum write_one_status {
