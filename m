Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E84C9C433E0
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:40:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2C19229C6
	for <git@archiver.kernel.org>; Mon, 21 Dec 2020 21:40:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726089AbgLUVkz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Dec 2020 16:40:55 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:58050 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726071AbgLUVky (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Dec 2020 16:40:54 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id AC1A8108CC7;
        Mon, 21 Dec 2020 16:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=nZPKt+TfxpKO
        NfU8ioGkwGkwMHo=; b=GI94l2sQCGW4EeF7ZX6Jf/dwcdi6mXV7IYbNRKBAbBVL
        v0IMZgUEuSlpUC7R/1eVsRWD+RVvU17X8VymUxga6ydM7ICFQPYpefQKwL2czzmM
        IfN0rD4Al3ptWAraCD4l6x5mOhcyv5LBtf6gAvhByn2D+DL7mcxnn+68bslaf1g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=g/2Q5A
        DXBxwPyslE0Gvr69MXZU0YZlPlJj5unCJjT1XXlVskiZv11Jxi4nNe0413hWp4N9
        SXflN/3NKUspmcG9yB1i5cqCuy3TDIJe+Ytzw3Vcxl5tPjzv3AL6o/QClsIrrenl
        WlEFwukkjLrq5Pj2NhyKt9i0jz0lnQSAVG1iA=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id A4E51108CC6;
        Mon, 21 Dec 2020 16:40:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.196.173.25])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D0600108CC5;
        Mon, 21 Dec 2020 16:40:05 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Cc:     Ross Light <ross@zombiezen.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] pack-format.txt: define "varint" format
References: <CAEs=z9Pajgjnq56+umA+g9-NFv-Rzo9m5sa-7cow_byckLiJ0A@mail.gmail.com>
        <cover.1608537234.git.martin.agren@gmail.com>
        <42c6206b102cd97290fd9ad207bb39b20660064c.1608537234.git.martin.agren@gmail.com>
Date:   Mon, 21 Dec 2020 13:40:03 -0800
In-Reply-To: <42c6206b102cd97290fd9ad207bb39b20660064c.1608537234.git.martin.agren@gmail.com>
        ("Martin =?utf-8?Q?=C3=85gren=22's?= message of "Mon, 21 Dec 2020 08:54:58
 +0100")
Message-ID: <xmqqft3yltxo.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 170B85C0-43D5-11EB-93B4-D609E328BF65-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin =C3=85gren <martin.agren@gmail.com> writes:

> We define our varint format pretty much on the fly as we describe a pac=
k
> file entry. In preparation for referring to it in more places in this
> document, define "varint" and refer to it.
>
> Signed-off-by: Martin =C3=85gren <martin.agren@gmail.com>
> ---
>  Documentation/technical/pack-format.txt | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/technical/pack-format.txt b/Documentation/te=
chnical/pack-format.txt
> index f96b2e605f..42198de74c 100644
> --- a/Documentation/technical/pack-format.txt
> +++ b/Documentation/technical/pack-format.txt
> @@ -55,6 +55,15 @@ Valid object types are:
> =20
>  Type 5 is reserved for future expansion. Type 0 is invalid.
> =20
> +=3D=3D=3D Variable-length integer encoding
> +
> +This document uses "varint" encoding of non-negative integers: From
> +each byte, the seven least significant bits are used to form the
> +resulting integer. As long as the most significant bit is 1, this
> +process continues; the byte with MSB 0 provides the last seven bits.
> +The seven-bit chunks are concatenated. Later values are more
> +significant.
> +

Unfortunately we have two kinds of varint, and the above describes
the older and less efficient variant that is used to encode

 (1) the size of the base object and the object that would result
     by applying a delta (stored at the beginning of each datum that
     represents a deltified object, and read by get_delta_hdr_size())

 (2) the size of the object that is represented in the base
     representation and read by unpack_object_header())

(and nothing else as far as I know).

There is another varint encoding that is slightly more efficient and
it also is used in the packfile format to encode the OFS_DELTA
offset, i.e. the number of bytes to go back in the same packfile
starting at the beginning of OFS_DELTA dats to find the object the
delta applies to.  This newer variant is what is known as "varint"
and used throughout the other parts of the system (see hits from
"git grep -e ncode_varint").

We need to be careful when using a generic "varint" to mean the
older variant as it would confuse readers of OFS_DELTA section.

	... goes and looks ...

The phrase "offset encoding" is used in the document to talk about
OFS_DELTA offset.  It is actually what the rest of the code thinks
is the canonical varint defined in varint.[ch]).

A way to avoid confusion would be to refrain from using "varint" as
the primary way to describe this size field; instead explain it as
the "size encoding", to match "offset encoding" used for OFS_DELTA.

It may also help if we added to the description of "offset encoding"
that it is what other parts of the system consider the canonical
"varint" encoding.

Thanks.

>  =3D=3D=3D Deltified representation
>  Conceptually there are only four object types: commit, tree, tag and
> @@ -196,10 +205,10 @@ Pack file entry: <+
>  	1-byte size extension bit (MSB)
>  	       type (next 3 bit)
>  	       size0 (lower 4-bit)
> -        n-byte sizeN (as long as MSB is set, each 7-bit)
> -		size0..sizeN form 4+7+7+..+7 bit integer, size0
> -		is the least significant part, and sizeN is the
> -		most significant part.
> +        n-byte size1 (varint encoding; present if MSB is set)
> +        If the MSB is set, the size is size0 + 16*size1, otherwise
> +        it is size0. (Equivalently, the entire packed object header
> +        is a varint encoding of (size/16)*128 + type*16 + size%16.)
>       packed object data:
>          If it is not DELTA, then deflated bytes (the size above
>  		is the size before compression).
