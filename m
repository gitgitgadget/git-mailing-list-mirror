Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1DA3C433ED
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:38:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954E160725
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:38:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbhD2Ei5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 00:38:57 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53650 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbhD2Ei4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 00:38:56 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A80DC131404;
        Thu, 29 Apr 2021 00:37:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=LXh/NSyqH9ck
        nXTLyiXFOH4LlwARwZFHHdnumuUcTfo=; b=BxUH597WEx5ScoyZtSGSQxFXrlwL
        k+sbSM9Uj9DsAgsPSUOSrceM0+lDCHVb9ZZtoSLv2+tP4myhcIBKlbdwN6KdVOtm
        6qwvX6r/iAnolAxChKdyZBNl/ymurXEwdRJ2EF40bQ29qXL2x+AIpkyU7NEOLjLc
        VhRjDSxqLL4MPlY=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8ED4F131403;
        Thu, 29 Apr 2021 00:37:24 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AFC361313C0;
        Thu, 29 Apr 2021 00:37:21 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 04/10] object-file.c: take type id, not string, in
 read_object_with_reference()
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
        <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
        <patch-04.10-48aca62864-20210420T124428Z-avarab@gmail.com>
Date:   Thu, 29 Apr 2021 13:37:20 +0900
In-Reply-To: <patch-04.10-48aca62864-20210420T124428Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Apr
 2021 14:50:37 +0200")
Message-ID: <xmqqeeet905b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 96761120-A8A4-11EB-BEBB-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Make the read_object_with_reference() function take "enum object_type"
> instead of a "const char *" with a type name that it converted via
> type_from_string().
>
> Out of the nine callers of this function, only one wanted to pass a
> "const char *". The others were simply passing along the
> {commit,tree}_type string constants.

s/wanted to pass a/wanted to pass an arbitrary/, I would think.
Other than that, nicely analyzed.

> That one caller in builtin/cat-file.c did not expect to pass a "raw"
> type (i.e. in invalid "--literally" type, but one gotten from
> type_from_string().

It is unclear what you are trying to say here.  Missing closing ')'
that should close '(i.e.' does not help, either, because it muddles
what you wanted to imply by bringing up the "--literally" option.

    The one caller in builtin/cat-file.c passes the typename the
    end-user typed on the command line i.e. "git cat-file <TYPE>
    <NAME>", but read_object_with_reference() called in the codepath
    is *NOT* expected to deal with objects with unknown/bogus type
    crafted with "hash-object --literally" (note: "git cat-file"
    does have the "--allow-unknown-type" option, but it can only be
    used with the "-s" and "-t" options).  It won't result in loss
    of functionality if we restricted the required_type parameter
    given to read_object_with_reference() to the four known types by
    changing the function signature to take the enum instead of
    string.

is probably what you meant to say, but I am only guessing.

> diff --git a/builtin/cat-file.c b/builtin/cat-file.c
> index 5ebf13359e..46fc7a32ba 100644
> --- a/builtin/cat-file.c
> +++ b/builtin/cat-file.c
> @@ -66,7 +66,7 @@ static int cat_one_file(int opt, const char *exp_type=
, const char *obj_name,
>  			int unknown_type)
>  {
>  	struct object_id oid;
> -	enum object_type type;
> +	enum object_type type, exp_type_id;
>  	char *buf;
>  	unsigned long size;
>  	struct object_context obj_context;
> @@ -154,7 +154,8 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name,
>  		break;
> =20
>  	case 0:
> -		if (type_from_string(exp_type) =3D=3D OBJ_BLOB) {
> +		exp_type_id =3D type_from_string(exp_type);
> +		if (exp_type_id =3D=3D OBJ_BLOB) {
>  			struct object_id blob_oid;
>  			if (oid_object_info(the_repository, &oid, NULL) =3D=3D OBJ_TAG) {
>  				char *buffer =3D read_object_file(&oid, &type,
> @@ -177,7 +178,7 @@ static int cat_one_file(int opt, const char *exp_ty=
pe, const char *obj_name,
>  			 */
>  		}
>  		buf =3D read_object_with_reference(the_repository,
> -						 &oid, exp_type, &size, NULL);
> +						 &oid, exp_type_id, &size, NULL);
>  		break;
> =20
>  	default:

And this is the caller we just discussed.

> diff --git a/object-file.c b/object-file.c
> index 624af408cd..d2f223dcef 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -1669,25 +1669,24 @@ void *read_object_file_extended(struct reposito=
ry *r,
> =20
>  void *read_object_with_reference(struct repository *r,
>  				 const struct object_id *oid,
> -				 const char *required_type_name,
> +				 enum object_type object_type,
>  				 unsigned long *size,
>  				 struct object_id *actual_oid_return)
>  {
> -	enum object_type type, required_type;
>  	void *buffer;
>  	unsigned long isize;
>  	struct object_id actual_oid;
> =20
> -	required_type =3D type_from_string(required_type_name);
>  	oidcpy(&actual_oid, oid);
>  	while (1) {
>  		int ref_length =3D -1;
>  		const char *ref_type =3D NULL;
> +		enum object_type type;
> =20
>  		buffer =3D repo_read_object_file(r, &actual_oid, &type, &isize);
>  		if (!buffer)
>  			return NULL;
> -		if (type =3D=3D required_type) {
> +		if (type =3D=3D object_type) {
>  			*size =3D isize;
>  			if (actual_oid_return)
>  				oidcpy(actual_oid_return, &actual_oid);

I do not think it is a good change to effectively rename
required_type to object_type.  Swapping the required_type_name
parameter with required_type parameter of type "enum object_type"
and dropping the now unneeded type_from_string() call would have
been much easier to follow.

