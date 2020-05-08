Return-Path: <SRS0=7OUv=6W=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 289A7C38A2A
	for <git@archiver.kernel.org>; Fri,  8 May 2020 20:00:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C0F2F20A8B
	for <git@archiver.kernel.org>; Fri,  8 May 2020 20:00:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wVnClGhH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726913AbgEHUAB (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 May 2020 16:00:01 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51847 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726811AbgEHUAB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 May 2020 16:00:01 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id C40D6D945E;
        Fri,  8 May 2020 15:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pcpue532iuHg
        CMw9+DMLJ4w25bs=; b=wVnClGhHlC5jxdmfqSW9J6PDoTv3pUQvXifQYUWUP7Mq
        K95KCwV4ao7YMKYVZherU1YaHZYTJitS2epxjE/p+BA46Zv7pZHjf2uD+JOWe95B
        6Sh53a6LR4t2ZI10DDqYSTmFXkM6VJTcbMrl5j2KZFXglVlbTGD6Yjf1/c9mJg4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=DHkfQi
        8Ei6czpb4mq93u2kmRuwVS78jE+6UDHvFjoZ6hX1QsbXdniAl3BiFPAhYxCOxbk2
        AnWaaDsvlLtRslkyvnRbIgn0UQ+dHQ2JDgPna2TbndbZiFH5wUMpXhNq4w73f5Pj
        MyivOjD3Sm1Lt36YyTDSYjx7Qa9JkDdsNJoq4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id BBFDFD945D;
        Fri,  8 May 2020 15:59:59 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 04790D9452;
        Fri,  8 May 2020 15:59:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Han-Wen Nienhuys <hanwenn@gmail.com>,
        Han-Wen Nienhuys <hanwen@google.com>
Subject: Re: [PATCH v12 06/12] reftable: define version 2 of the spec to accomodate SHA256
References: <pull.539.v11.git.1588619028.gitgitgadget@gmail.com>
        <pull.539.v12.git.1588845585.gitgitgadget@gmail.com>
        <093fa74a3d0e7721093cceb338e8efc9c0c95b1c.1588845586.git.gitgitgadget@gmail.com>
Date:   Fri, 08 May 2020 12:59:55 -0700
In-Reply-To: <093fa74a3d0e7721093cceb338e8efc9c0c95b1c.1588845586.git.gitgitgadget@gmail.com>
        (Han-Wen Nienhuys via GitGitGadget's message of "Thu, 07 May 2020
        09:59:39 +0000")
Message-ID: <xmqq5zd6xkn8.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 7DBB3C4C-9166-11EA-96B6-B0405B776F7B-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Han-Wen Nienhuys via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Han-Wen Nienhuys <hanwen@google.com>
>
> Signed-off-by: Han-Wen Nienhuys <hanwen@google.com>
> ---
>  Documentation/technical/reftable.txt | 50 ++++++++++++++++------------
>  1 file changed, 28 insertions(+), 22 deletions(-)
>
> diff --git a/Documentation/technical/reftable.txt b/Documentation/techn=
ical/reftable.txt
> index 9fa4657d9ff..ee3f36ea851 100644
> --- a/Documentation/technical/reftable.txt
> +++ b/Documentation/technical/reftable.txt
> @@ -193,8 +193,8 @@ and non-aligned files.
>  Very small files (e.g.=C2=A01 only ref block) may omit `padding` and t=
he ref

Hmph, I am seeing nbsp before '1' and am wondering where it came from.

>  index to reduce total file size.
> =20
> -Header
> -^^^^^^
> +Header (version 1)
> +^^^^^^^^^^^^^^^^^^
> =20
>  A 24-byte header appears at the beginning of the file:
> =20
> @@ -215,6 +215,24 @@ used in a stack for link:#Update-transactions[tran=
sactions], these
>  fields can order the files such that the prior file=E2=80=99s
>  `max_update_index + 1` is the next file=E2=80=99s `min_update_index`.

Am I correct to assume that we do not plan to support a repository
with mixed set of refs, some referring to a commit with its SHA-1
object name while others using SHA-256 object name?

> +Header (version 2)
> +^^^^^^^^^^^^^^^^^^
> +
> +A 28-byte header appears at the beginning of the file:
> +
> +....
> +'REFT'
> +uint8( version_number =3D 1 )

Shouldn't this be 2 instead, as v1 lacked the Hash-id field?

> +uint24( block_size )
> +uint64( min_update_index )
> +uint64( max_update_index )
> +uint32( hash_id )
> +....
> +
> +The header is identical to `version_number=3D1`, with the 4-byte hash =
ID
> +("sha1" for SHA1 and "s256" for SHA-256) append to the header.

Am I correct to assume that SHA-1 repositories are encouraged to use
version 2 when the code becomes available?

>  First ref block
>  ^^^^^^^^^^^^^^^
> =20
> @@ -671,14 +689,8 @@ Footer
>  After the last block of the file, a file footer is written. It begins
>  like the file header, but is extended with additional data.
> =20
> -A 68-byte footer appears at the end:
> -
>  ....
> -    'REFT'
> -    uint8( version_number =3D 1 )
> -    uint24( block_size )
> -    uint64( min_update_index )
> -    uint64( max_update_index )
> +    HEADER
> =20
>      uint64( ref_index_position )
>      uint64( (obj_position << 5) | obj_id_len )
> @@ -701,12 +713,16 @@ obj blocks.
>  * `obj_index_position`: byte position for the start of the obj index.
>  * `log_index_position`: byte position for the start of the log index.
> =20
> +The size of the footer is 68 bytes for version 1, and 72 bytes for
> +version 2.
> +
>  Reading the footer
>  ++++++++++++++++++
> =20
> -Readers must seek to `file_length - 68` to access the footer. A truste=
d
> -external source (such as `stat(2)`) is necessary to obtain
> -`file_length`. When reading the footer, readers must verify:
> +Readers must first read the file start to determine the version
> +number. Then they seek to `file_length - FOOTER_LENGTH` to access the
> +footer. A trusted external source (such as `stat(2)`) is necessary to
> +obtain `file_length`. When reading the footer, readers must verify:

In any case, the size of this patch is pleasant to see---it must be
a sign that the previous step was done well not to hardcode the
"hash size is 20 bytes" assumption all over the place and instead
used "this field holds N+m bytes where N is the size of the hash
described in the REFT header" consistently.

Nicely done.
