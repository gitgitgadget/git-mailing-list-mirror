Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B93DFC433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 22:43:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238492AbiBYWnt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 17:43:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233266AbiBYWnq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 17:43:46 -0500
Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF8FE1BD069
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 14:43:12 -0800 (PST)
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 0E3AB18045C;
        Fri, 25 Feb 2022 17:43:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pAn7JGyw3pEd
        vMt8D3mjZ2iT4iNSKW+QDrwxFsDvwI8=; b=ogJOWCC50BpRErlx+UjaA72FR5LP
        pGDsj9PlSAumBXGTNPg3V4xlRKJIatFERN+VNMgeARXk+tX3fY1yAbndaoC2t/KU
        hGzuNkLcEq+Vu5N5arsYWFFzysmmE3WTSQcIMDJhDwSRdLUDrjCxHywE7+keACu6
        QaZ5NNIGOaNIplk=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 04FCB18045B;
        Fri, 25 Feb 2022 17:43:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 35FD718045A;
        Fri, 25 Feb 2022 17:43:09 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>,
        Jeff King <peff@peff.net>, Dan Jacques <dnj@google.com>,
        Eric Wong <e@80x24.org>, Jonathan Nieder <jrnieder@gmail.com>,
        Mike Hommey <mh@glandium.org>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>, Victoria Dye <vdye@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v3 1/9] scalar Makefile: set the default target after
 the includes
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <patch-v3-1.9-2404c4d8b96-20220225T090127Z-avarab@gmail.com>
Date:   Fri, 25 Feb 2022 14:43:08 -0800
In-Reply-To: <patch-v3-1.9-2404c4d8b96-20220225T090127Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Feb
 2022 10:04:27
        +0100")
Message-ID: <xmqq1qzqa7pf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 4E269CBA-968C-11EC-95EE-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Make have the "contrib/scalar/Makefile" be stylistically consistent
> with the top-level "Makefile" in including other makefiles before
> setting the default target.

I think that goal makes sense, but the patch looks like doing a
different thing.  The top-level "Makefile" does it correctly, by
starting the file with

        # The default target of this Makefile is...
        all::

that declares that saying "make" is equivalent to "make all"
upfront.

The patch does not do that; it moves "all" even lower.

What am I missing?

> This adjusts code added in 0a43fb22026 (scalar: create a rudimentary
> executable, 2021-12-03), it's a style-only change, in a subsequent
> commit the "QUIET" boilerplate at the beginning of this file will be
> retrieved via an include, and having an "all:" between the two set of
> "include"'s after that change would look odd.
>
> Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com=
>
> ---
>  contrib/scalar/Makefile | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/scalar/Makefile b/contrib/scalar/Makefile
> index 231b1ee1796..5b12a437426 100644
> --- a/contrib/scalar/Makefile
> +++ b/contrib/scalar/Makefile
> @@ -12,12 +12,12 @@ else
>  endif
>  endif
> =20
> -all:
> -
>  include ../../config.mak.uname
>  -include ../../config.mak.autogen
>  -include ../../config.mak
> =20
> +all:
> +
>  TARGETS =3D scalar$(X) scalar.o
>  GITLIBS =3D ../../common-main.o ../../libgit.a ../../xdiff/lib.a
