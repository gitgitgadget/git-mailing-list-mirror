Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DC48C07E99
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:38:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 277656141C
	for <git@archiver.kernel.org>; Mon,  5 Jul 2021 19:38:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhGETlG (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jul 2021 15:41:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:62406 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbhGETlG (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jul 2021 15:41:06 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 3CAB7D7D6F;
        Mon,  5 Jul 2021 15:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=FRCA8nezTioN
        Zum4KcC26QaDSBa92OliCr+FgO5PvcI=; b=DNRHUjG//Mp/SdWVWqwc4IaF84if
        CkGa3ExVJvy820d5r2cUD8pwGth62y3EUVIAxh1Ez+L2ZOtgjF8iPlhekPDaDMn6
        z5FtztUDPLBaIKuornSefZ0x293Dl518rYNlI1K0lviTDlmzJg5UcjRyZQa4nKu/
        MpeLjPLnITNH9zY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 31D8ED7D6E;
        Mon,  5 Jul 2021 15:38:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id AB448D7D6D;
        Mon,  5 Jul 2021 15:38:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>
Subject: Re: [PATCH] Documentation/Makefile: don't re-build on 'git version'
 changes
References: <874kdn1j6i.fsf@evledraar.gmail.com>
        <patch-1.1-911881ce19f-20210702T115617Z-avarab@gmail.com>
        <60dfb7d11cac3_3dd220811@natae.notmuch>
        <87mtr38tvd.fsf@evledraar.gmail.com>
Date:   Mon, 05 Jul 2021 12:38:26 -0700
In-Reply-To: <87mtr38tvd.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Sat, 03 Jul 2021 14:03:40 +0200")
Message-ID: <xmqqh7h8mtzh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 91FA3B0E-DDC8-11EB-8148-8B3BC6D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It's useful e.g. on my Debian system to see that the "next" Debian
> packaged is 2.31.0.291.g576ba9dcdaf in docs & "git version", arguably
> less so for documentation.

If it is arguable, perhaps make an argument that is more convincing?

What I dislike the most is that in the sample scenario where master
and next has the same documentation material to build "git-cat-file.1",
the installed result would be different depending on the order of
building the documentation, with the change being discussed, i.e.

    $ git checkout master && make prefix=3D$HOME/git-master install-doc
    $ git checkout next && make prefix=3D$HOME/git-next install-doc

would make "~/git-next/bin/git help cat-file" to claim the
documentation is from the "master" version.  Which is not all that
bad, given that there wasn't anything that changed the documentation
between 'master' and 'next'.  But if you swap the installation
order, "~/git-master/bin/git help cat-file" would say that the
documentation is from a version much newer than 'master', which is
not quite acceptable.

I am OK with the approach you hinted to have an option to _hide_ the
version string in the generated documentation (hence they lose their
dependency on GIT-VERSION-FILE), while keeping the dependency of
version.o on GIT-VERSION-FILE, so that something goes wrong in a
built binary, the developer can still ask "git version" to identify
where the binary came from.

Thanks.

