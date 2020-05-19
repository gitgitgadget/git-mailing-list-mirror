Return-Path: <SRS0=xHKm=7B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61445C433E0
	for <git@archiver.kernel.org>; Tue, 19 May 2020 22:32:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21D5520674
	for <git@archiver.kernel.org>; Tue, 19 May 2020 22:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cAjUZCiz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726432AbgESWce (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 19 May 2020 18:32:34 -0400
Received: from pb-smtp21.pobox.com ([173.228.157.53]:62541 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726064AbgESWcd (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 May 2020 18:32:33 -0400
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 09B23D3996;
        Tue, 19 May 2020 18:32:29 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=RC8Zu66RHAs4
        gtaZc4gET0CsJdk=; b=cAjUZCiz0uSPa8/3UgCAzQl9362HrXKFGIX51jForjV7
        hlC4nT9wbn1RoRXR/qUzVIVplUeUaGbb/hnLb7/tH0teiXNHiEbkZ5GS8/Kn2Hks
        5PnCQ9NCaC4+ratn0owB+xOBt522JrwSWOyj2AR67NItqgQZSbzNWLC2B/O+u+8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=gBSZWM
        9xNwTKShBdB7+bFWsAOwCk2WaHCJT/azUbnBpUjuNGcRryVy+hJI6L5ECvPRPM7U
        AmpDAkxwlNuESjKV/6VMGZvMjCr+Ysd4eue3HlyYjf9Up0b4K2ZAvYmAQQh/sgsk
        gDFlKyYQs/Dovcdp/5qBVAs0KtWIz9QjC8Xnw=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id E7664D3995;
        Tue, 19 May 2020 18:32:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 12D25D3994;
        Tue, 19 May 2020 18:32:25 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v13 06/13] reftable: define version 2 of the spec to accomodate SHA256
References: <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <pull.539.v13.git.1589226388.gitgitgadget@gmail.com>
        <1e3c8f2d3e8c6c6db8460f29115d2fe898f85012.1589226388.git.gitgitgadget@gmail.com>
Date:   Tue, 19 May 2020 15:32:24 -0700
In-Reply-To: <1e3c8f2d3e8c6c6db8460f29115d2fe898f85012.1589226388.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Mon, 11 May 2020
        19:46:21 +0000")
Message-ID: <xmqq5zcrzhc7.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 9D8A2DD6-9A20-11EA-81D1-8D86F504CC47-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Version appends a hash ID to the file header, making it slightly larger=
.
>
> This commit also changes "SHA-1" into "object ID" in many places.
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  Documentation/technical/reftable.txt | 79 ++++++++++++++++------------
>  1 file changed, 44 insertions(+), 35 deletions(-)
>
> diff --git a/Documentation/technical/reftable.txt b/Documentation/techn=
ical/reftable.txt
> index 6223538d64e..1464c4e7437 100644
> --- a/Documentation/technical/reftable.txt
> +++ b/Documentation/technical/reftable.txt
> @@ -29,7 +29,7 @@ Objectives
> =20
>  * Near constant time lookup for any single reference, even when the
>  repository is cold and not in process or kernel cache.
> -* Near constant time verification if a SHA-1 is referred to by at leas=
t
> +* Near constant time verification if an object ID is referred to by at=
 least
>  one reference (for allow-tip-sha1-in-want).

Good.  These are called "object names", though.

> @@ -193,8 +193,8 @@ and non-aligned files.
>  Very small files (e.g. a single ref block) may omit `padding` and the =
ref
>  index to reduce total file size.
> =20
> -Header
> -^^^^^^
> +Header (version 1)
> +^^^^^^^^^^^^^^^^^^
> =20
>  A 24-byte header appears at the beginning of the file:
> =20
> @@ -215,6 +215,27 @@ used in a stack for link:#Update-transactions[tran=
sactions], these
>  fields can order the files such that the prior file=E2=80=99s
>  `max_update_index + 1` is the next file=E2=80=99s `min_update_index`.
> =20
> +Header (version 2)
> +^^^^^^^^^^^^^^^^^^
> +
> +A 28-byte header appears at the beginning of the file:
> +
> +....
> +'REFT'
> +uint8( version_number =3D 2 )
> +uint24( block_size )
> +uint64( min_update_index )
> +uint64( max_update_index )
> +uint32( hash_id )
> +....
> +
> +The header is identical to `version_number=3D1`, with the 4-byte hash =
ID
> +("sha1" for SHA1 and "s256" for SHA-256) append to the header.
> +
> +For maximum backward compatibility, it is recommended to use version 1=
 when
> +writing SHA1 reftables.
> +
> +
>  First ref block
>  ^^^^^^^^^^^^^^^
> =20
> @@ -302,8 +323,8 @@ The `value` follows. Its format is determined by `v=
alue_type`, one of
>  the following:
> =20
>  * `0x0`: deletion; no value data (see transactions, below)
> -* `0x1`: one 20-byte object id; value of the ref
> -* `0x2`: two 20-byte object ids; value of the ref, peeled target
> +* `0x1`: one object id; value of the ref
> +* `0x2`: two object ids; value of the ref, peeled target

Ah, OK, I pointed out these future-proofing for the previous step,
but as long as the end result is written in a hash-algorithm
agnostic way, it is OK.  Again these are called "object names",
though.

>  * `0x3`: symbolic reference: `varint( target_len ) target`

> @@ -434,7 +455,7 @@ works the same as in reference blocks.
> =20
>  Because object identifiers are abbreviated by writers to the shortest
>  unique abbreviation within the reftable, obj key lengths are variable
> -between 2 and 20 bytes. Readers must compare only for common prefix
> +between 2 and 32 bytes. Readers must compare only for common prefix

Is it allowed for a reftable file whose hash_id field says "sha1" to
use more than 20 bytes of obj key?  Phrasing it like "unique prefix
of object name, no shorter than 2 bytes" would avoid the problem, I
would think.

This version also adds more


	=E2=80=99

apostrophes, where we would prefer to place vanilla single quotes,
which may need to be corrected in the conversion toolchain.

I did not see any new typo introduced in this step.

Thanks.


