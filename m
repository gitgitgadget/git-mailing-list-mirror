Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0790AC433EF
	for <git@archiver.kernel.org>; Thu, 20 Jan 2022 19:30:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347061AbiATTaU (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 20 Jan 2022 14:30:20 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:53601 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231733AbiATTaU (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jan 2022 14:30:20 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D869E17AE0A;
        Thu, 20 Jan 2022 14:30:19 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=yMbBKHoJ4jtvF25OASe+u5TamgZ39geQ44QiOX
        xaOE8=; b=sQwOiIQ0IFd45Wq6282bTvfxRt1AOnJsw2KbXKKFA5jsDdezrPpDSL
        B0/hwKiyM1GeuTdMywdarS9MhvZC/eCxkCc9ud2yD9h0aeP51F8jtdRDcMgRjVzQ
        Rv+DvzRkl1sZymAFVFD9O6ix4bjGBZSoZrK7Sgey8DWYG5SarEisE=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id D147317AE08;
        Thu, 20 Jan 2022 14:30:19 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 2729417AE07;
        Thu, 20 Jan 2022 14:30:16 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Gwyneth Morgan <gwymor@tilde.club>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH] signature-format.txt: Note SSH and X.509 signature
 delimiters
References: <20220120053223.221667-1-gwymor@tilde.club>
Date:   Thu, 20 Jan 2022 11:30:15 -0800
In-Reply-To: <20220120053223.221667-1-gwymor@tilde.club> (Gwyneth Morgan's
        message of "Thu, 20 Jan 2022 05:32:24 +0000")
Message-ID: <xmqq7daui4s8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 653265D2-7A27-11EC-99D1-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Gwyneth Morgan <gwymor@tilde.club> writes:

> Subject: Re: [PATCH] signature-format.txt: Note SSH and X.509 signature delimiters

Convention: downcase "N" in "Note".

> This document only explained PGP signatures, but Git now supports X.509
> and SSH signatures.

This is technically incorrect as the original text does talk about
MESSAGE that is used by X.509.

But the change does make it more clear to help readers not to make
the same mistake as the above sentence.  In 3-item enumeration, it
is very clear what we now support ;-)

> Signed-off-by: Gwyneth Morgan <gwymor@tilde.club>
> ---
>  Documentation/technical/signature-format.txt | 19 ++++++++++++++++---
>  1 file changed, 16 insertions(+), 3 deletions(-)
>
> diff --git a/Documentation/technical/signature-format.txt b/Documentation/technical/signature-format.txt
> index 166721be6f..c148d4c750 100644
> --- a/Documentation/technical/signature-format.txt
> +++ b/Documentation/technical/signature-format.txt
> @@ -9,9 +9,22 @@ is about to create an object or transaction determines a payload from that,
>  calls gpg to obtain a detached signature for the payload (`gpg -bsa`) and
>  embeds the signature into the object or transaction.
>  
> -Signatures always begin with `-----BEGIN PGP SIGNATURE-----`
> -and end with `-----END PGP SIGNATURE-----`, unless gpg is told to
> -produce RFC1991 signatures which use `MESSAGE` instead of `SIGNATURE`.
> +Signatures always begin and end with a delimiter, which differs

The term "signature delimiter" is understandable, but is that the
term used by the users and the developers of OpenPGP, X.509 and SSH
who know and use such an ascii-armored signatures?  Just making sure
we do not accidentally "invent" a new word that the upstream/wider
community has an established word for.

	... Goes and looks ...
	https://www.rfc-editor.org/rfc/rfc4880.html#section-7
	seems to use "Armor Header and Armor Tail Lines" to refer to
	the BEGIN and the END delimiter lines, respectively.

Other than that, the patch looks good to me.

Thanks.

> +depending on signature type.
> +
> +PGP::
> +	Signatures begin with `-----BEGIN PGP SIGNATURE-----` and end
> +	with `-----END PGP SIGNATURE-----`, unless gpg is told to
> +	produce RFC1991 signatures which use `MESSAGE` instead of
> +	`SIGNATURE`.
> +
> +SSH::
> +	Signatures begin with `-----BEGIN SSH SIGNATURE-----` and end
> +	with `-----END SSH SIGNATURE-----`.
> +
> +X.509::
> +	Signatures begin with `-----BEGIN SIGNED MESSAGE-----` and end
> +	with `-----END SIGNED MESSAGE-----`.
>  
>  Signatures sometimes appear as a part of the normal payload
>  (e.g. a signed tag has the signature block appended after the payload
