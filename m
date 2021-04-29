Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83885C433B4
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:51:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 49BC06101C
	for <git@archiver.kernel.org>; Thu, 29 Apr 2021 04:51:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230103AbhD2Ewo (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Apr 2021 00:52:44 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58811 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229814AbhD2EwS (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Apr 2021 00:52:18 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 522E913157D;
        Thu, 29 Apr 2021 00:51:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=3KejWq41Fmxk
        qzyE+/+2X6SMC8+9ow26tcKsvUiBF+o=; b=t7l44+ozsfOCxfjnGVTI1fiJQgTB
        TQD7TzFQ4QYrgocjjM4HnnofN8eAQpvGP3xbmUUBMqoDGm1nF2pNBdixO8xvzbPz
        hLd1VQCVDdYmAk7a5wR7HZPRHcRUXOqAhJ+LvQjzHfyr6tkDsEiubK7bEz1RRGty
        rTMfPKBkIBCYZGk=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4B9B013157C;
        Thu, 29 Apr 2021 00:51:31 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 709ED13157B;
        Thu, 29 Apr 2021 00:51:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v2 06/10] blob.c: remove parse_blob_buffer()
References: <cover-0.3-0000000000-20210409T080534Z-avarab@gmail.com>
        <cover-00.10-0000000000-20210420T124428Z-avarab@gmail.com>
        <patch-06.10-02c8d2a9ba-20210420T124428Z-avarab@gmail.com>
Date:   Thu, 29 Apr 2021 13:51:26 +0900
In-Reply-To: <patch-06.10-02c8d2a9ba-20210420T124428Z-avarab@gmail.com>
 (=?utf-8?B?IsOGdmFyCUFybmZqw7Zyw7A=?= Bjarmason"'s message of "Tue, 20 Apr
 2021 14:50:39 +0200")
Message-ID: <xmqq5z058zht.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F281376-A8A6-11EB-A0AF-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> -int parse_blob_buffer(struct blob *item, void *buffer, unsigned long s=
ize)
> -{
> -	item->object.parsed =3D 1;
> -	return 0;
> -}

Understandable.

> diff --git a/object.c b/object.c
> index 78343781ae..f4e419e5c3 100644
> --- a/object.c
> +++ b/object.c
> @@ -195,8 +195,7 @@ struct object *parse_object_buffer(struct repositor=
y *r, const struct object_id
>  	if (type =3D=3D OBJ_BLOB) {
>  		struct blob *blob =3D lookup_blob(r, oid);
>  		if (blob) {
> -			if (parse_blob_buffer(blob, buffer, size))
> -				return NULL;
> +			blob->object.parsed =3D 1;
>  			obj =3D &blob->object;
>  		}

Understandable, too.

>  	} else if (type =3D=3D OBJ_TREE) {
> @@ -262,12 +261,16 @@ struct object *parse_object(struct repository *r,=
 const struct object_id *oid)
>  	if ((obj && obj->type =3D=3D OBJ_BLOB && repo_has_object_file(r, oid)=
) ||
>  	    (!obj && repo_has_object_file(r, oid) &&
>  	     oid_object_info(r, oid, NULL) =3D=3D OBJ_BLOB)) {
> +		if (!obj) {
> +			struct blob *blob =3D create_blob(r, oid);
> +			obj =3D &blob->object;
> +		}

I do not recall this change explained or justified in the log
message.  What am I missing?

>  		if (check_object_signature(r, repl, NULL, 0, NULL) < 0) {
>  			error(_("hash mismatch %s"), oid_to_hex(oid));
>  			return NULL;
>  		}
> -		parse_blob_buffer(lookup_blob(r, oid), NULL, 0);
> -		return lookup_object(r, oid);
> +		obj->parsed =3D 1;
> +		return obj;

Likewise.  Why isn't it just a call to lookup_blob() followed by
setting of its .parsed bit? =20

In other words, it is not clear why we need to expose create_blob().

>  	}
> =20
>  	buffer =3D repo_read_object_file(r, oid, &type, &size);
