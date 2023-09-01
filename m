Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CE3BCA0FE6
	for <git@archiver.kernel.org>; Fri,  1 Sep 2023 11:02:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233414AbjIALC2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 1 Sep 2023 07:02:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231592AbjIALC1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 1 Sep 2023 07:02:27 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A90CE42
        for <git@vger.kernel.org>; Fri,  1 Sep 2023 04:02:24 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1c09673b006so12797505ad.1
        for <git@vger.kernel.org>; Fri, 01 Sep 2023 04:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693566144; x=1694170944; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=vZMxQQaAuF9W7VMY9t/GEi2AohcmhgrJmZE8pJewu1o=;
        b=cycdFHWskhx1q1gb8iScVAL1PxH+9UuidZtX9qAW7x1GiN8fPA/eDgK1FbTM1U8bP4
         Vnwrr3a4dV2ZA2nQMTJG8bHsMClrjf0W1WJo42wPUtZs+41rRv23xbak9Gtekqbqe7Hn
         TDSIpveJRfGP2qsilJEf8OO72+me2cho6yOCO6jQh5dzMOZeLaYjM3TUaliVrdacvuTi
         yyG/bwnG3ISU0WPbU6E6QzNNddZE/gQUofsG6yeumpFWmNhS22GeAob0ltSdy4MzB0Ow
         v/1zQRGoEZngazPLGX3Hd+WA78DAScKjFLhEvqaphJzg9q69XuUtw6VxpGHn3mDFDweU
         2IYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693566144; x=1694170944;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vZMxQQaAuF9W7VMY9t/GEi2AohcmhgrJmZE8pJewu1o=;
        b=lJB7K32XvhXX/5iNxl2oBQdCT6kPtXHxmP2BmIsUhv9PsclDX+Z5+R2UNDq7WydqRz
         ZNXBJIJB0LigabXy95VNzbrufUXTWXGy+HETjph2w37e6UfQsT53YDJYN3VxD19ngsad
         kN5JAEAlehzmNd2mQRWVZO2CiptZ1p3WMNG03peRQ+Ku+vwmxw/ZukCJG7Lt/3Olkrza
         xFto7GjtAKhZCH4I7wjDvTwpDGJpD3It2GitdlzKahSFnYKakOOB4ur+BdYzYUZ51uRB
         AMAc6wPy5hgq+zPTbrZ8tEiP/QJ+PCFOq/oTYCzYjTYuOnCXp49V2eD4lW8lu+tS6SzX
         bKDg==
X-Gm-Message-State: AOJu0YwNXJaD6S/wxXoOkDHqrZOPpWRWq2sde5b/raDabJ47FgsucTdR
        Bw61hJWD7m9fI6hupmVkkw0+e7JtLVw=
X-Google-Smtp-Source: AGHT+IEIlS+VQlM2GJ+FE1x7nCtzI4m1ixRuKDu0uMw7+AwwnD1XCCoibiR7Tw0hQMa2H1gMuMFu9g==
X-Received: by 2002:a17:903:25d4:b0:1bf:120a:a29e with SMTP id jc20-20020a17090325d400b001bf120aa29emr2115603plb.10.1693566143623;
        Fri, 01 Sep 2023 04:02:23 -0700 (PDT)
Received: from debian.me ([103.124.138.83])
        by smtp.gmail.com with ESMTPSA id 12-20020a170902ee4c00b001bc445e2497sm2760303plo.79.2023.09.01.04.02.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Sep 2023 04:02:23 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id 4E2E9814B402; Fri,  1 Sep 2023 18:02:19 +0700 (WIB)
Date:   Fri, 1 Sep 2023 18:02:19 +0700
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     Eric Wong <e@80x24.org>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Jonathan Tan <jonathantanmy@google.com>
Subject: Re: [PATCH] treewide: fix various bugs w/ OpenSSL 3+ EVP API
Message-ID: <ZPHEu6qjwP478vPg@debian.me>
References: <ZPCL11k38PXTkFga@debian.me>
 <ZPEf8kbBUFqLO25W@tapette.crustytoothpaste.net>
 <20230901005742.M783359@dcvr>
 <20230901020928.M610756@dcvr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cLNa5MzSnFcLWA5H"
Content-Disposition: inline
In-Reply-To: <20230901020928.M610756@dcvr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


--cLNa5MzSnFcLWA5H
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 01, 2023 at 02:09:28AM +0000, Eric Wong wrote:
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 4dbb10aff3..444f41cf8c 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -1102,6 +1102,7 @@ static void stream_blob(uintmax_t len, struct objec=
t_id *oidout, uintmax_t mark)
>  		|| (pack_size + PACK_SIZE_THRESHOLD + len) < pack_size)
>  		cycle_packfile();
> =20
> +	the_hash_algo->init_fn(&checkpoint.ctx);
>  	hashfile_checkpoint(pack_file, &checkpoint);
>  	offset =3D checkpoint.offset;
> =20
> diff --git a/builtin/index-pack.c b/builtin/index-pack.c
> index 006ffdc9c5..dda94a9f46 100644
> --- a/builtin/index-pack.c
> +++ b/builtin/index-pack.c
> @@ -1166,6 +1166,7 @@ static void parse_pack_objects(unsigned char *hash)
>  	struct ofs_delta_entry *ofs_delta =3D ofs_deltas;
>  	struct object_id ref_delta_oid;
>  	struct stat st;
> +	git_hash_ctx tmp_ctx;
> =20
>  	if (verbose)
>  		progress =3D start_progress(
> @@ -1202,7 +1203,9 @@ static void parse_pack_objects(unsigned char *hash)
> =20
>  	/* Check pack integrity */
>  	flush();
> -	the_hash_algo->final_fn(hash, &input_ctx);
> +	the_hash_algo->init_fn(&tmp_ctx);
> +	the_hash_algo->clone_fn(&tmp_ctx, &input_ctx);
> +	the_hash_algo->final_fn(hash, &tmp_ctx);
>  	if (!hasheq(fill(the_hash_algo->rawsz), hash))
>  		die(_("pack is corrupted (SHA1 mismatch)"));
>  	use(the_hash_algo->rawsz);
> diff --git a/builtin/unpack-objects.c b/builtin/unpack-objects.c
> index 32505255a0..fef7423448 100644
> --- a/builtin/unpack-objects.c
> +++ b/builtin/unpack-objects.c
> @@ -609,6 +609,7 @@ int cmd_unpack_objects(int argc, const char **argv, c=
onst char *prefix UNUSED)
>  {
>  	int i;
>  	struct object_id oid;
> +	git_hash_ctx tmp_ctx;
> =20
>  	disable_replace_refs();
> =20
> @@ -669,7 +670,9 @@ int cmd_unpack_objects(int argc, const char **argv, c=
onst char *prefix UNUSED)
>  	the_hash_algo->init_fn(&ctx);
>  	unpack_all();
>  	the_hash_algo->update_fn(&ctx, buffer, offset);
> -	the_hash_algo->final_oid_fn(&oid, &ctx);
> +	the_hash_algo->init_fn(&tmp_ctx);
> +	the_hash_algo->clone_fn(&tmp_ctx, &ctx);
> +	the_hash_algo->final_oid_fn(&oid, &tmp_ctx);
>  	if (strict) {
>  		write_rest();
>  		if (fsck_finish(&fsck_options))
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index 73bff3a23d..92b9c8598b 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -268,6 +268,7 @@ static int deflate_to_pack(struct bulk_checkin_packfi=
le *state,
>  					  type, size);
>  	the_hash_algo->init_fn(&ctx);
>  	the_hash_algo->update_fn(&ctx, obuf, header_len);
> +	the_hash_algo->init_fn(&checkpoint.ctx);
> =20
>  	/* Note: idx is non-NULL when we are writing */
>  	if ((flags & HASH_WRITE_OBJECT) !=3D 0)
> diff --git a/csum-file.c b/csum-file.c
> index cd01713244..870748e016 100644
> --- a/csum-file.c
> +++ b/csum-file.c
> @@ -207,7 +207,7 @@ int hashfile_truncate(struct hashfile *f, struct hash=
file_checkpoint *checkpoint
>  	    lseek(f->fd, offset, SEEK_SET) !=3D offset)
>  		return -1;
>  	f->total =3D offset;
> -	f->ctx =3D checkpoint->ctx;
> +	the_hash_algo->clone_fn(&f->ctx, &checkpoint->ctx);
>  	f->offset =3D 0; /* hashflush() was called in checkpoint */
>  	return 0;
>  }

The regression gone away, thanks!

Tested-by: Bagas Sanjaya <bagasdotme@gmail.com>

--=20
An old man doll... just what I always wanted! - Clara

--cLNa5MzSnFcLWA5H
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQQZO/gRNchuWgPJR+Z7tWyQc2rTCAUCZPHEtAAKCRB7tWyQc2rT
CEeJAPwK40YaVfyZdI+FsYd/0mkZM7oCaJH6Pozh9DCNgffMbAEA9MCCriFMBJlQ
J1NG47GW9RshL7cWocCeuF5B1/uATAw=
=aUjy
-----END PGP SIGNATURE-----

--cLNa5MzSnFcLWA5H--
