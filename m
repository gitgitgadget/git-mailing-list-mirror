Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02A3EC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 23:24:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234931AbiBYXZO (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233882AbiBYXZN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 18:25:13 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F2CD177761
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 15:24:40 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id C192A118AC2;
        Fri, 25 Feb 2022 18:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=7WIaIsJ731S0
        tYtNeIQRH5FfpkBVhHZ4aQ4gJxKQJf8=; b=NadpQcEVVtasTjqaC+fi5Qs1ZHhV
        RZs4xgfgoVnS/oDfCD0PVHrsZc0+cWu6L2oJPcVVSqlkDwMavBMaqcBbp2LTy+XT
        OmmLG+TuTB0tjZjVjDqA2Q4WXxLu1+ptXT1cRkN/yqHE0r87bCufyzUMZBoKlBuv
        V3K2U5h8kglChGA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B682A118AC1;
        Fri, 25 Feb 2022 18:24:39 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 23A2E118AC0;
        Fri, 25 Feb 2022 18:24:39 -0500 (EST)
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
Subject: Re: [PATCH v3 6/9] Makefile: move $(comma), $(empty) and $(space)
 to shared.mak
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <patch-v3-6.9-1b6ecb27f02-20220225T090127Z-avarab@gmail.com>
Date:   Fri, 25 Feb 2022 15:24:38 -0800
In-Reply-To: <patch-v3-6.9-1b6ecb27f02-20220225T090127Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Feb
 2022 10:04:32
        +0100")
Message-ID: <xmqqbkyu8r7t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 1A43D2F4-9692-11EC-9DF2-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Move these variables over to the shared.max, we'll make use of them in

max?

> a subsequent commit. There was no reason for these to be "simply
> expanded variables", so let's use the normal lazy "=3D" assignment here=
.

Seems to do unrelated things "while at it" which is a common pattern
that slows the reviews down.

> diff --git a/shared.mak b/shared.mak
> index 1dda948df09..f6b589ffd8f 100644
> --- a/shared.mak
> +++ b/shared.mak
> @@ -23,3 +23,11 @@
>  #
>  #    info make --index-search=3D.DELETE_ON_ERROR
>  .DELETE_ON_ERROR:
> +
> +### Global variables
> +
> +## comma, empty, space: handy variables as these tokens are either
> +## special or can be hard to spot among other Makefile syntax.
> +comma =3D ,
> +empty =3D
> +space =3D $(empty) $(empty)

In any case, wanting to have a $(space) is not specific to the
top-level Makefile, and it is a good idea to move them to the shared
file.
