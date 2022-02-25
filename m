Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E704EC433EF
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 23:17:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239281AbiBYXRr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:17:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230190AbiBYXRq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 18:17:46 -0500
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 099D21F0817
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 15:17:13 -0800 (PST)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 39CA4118A2E;
        Fri, 25 Feb 2022 18:17:12 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ZTkNevFgyMoW
        PhSyCKtZLd2uHIuI/kZisEBJsXRP+EQ=; b=i0D2L4iPYhPYd0TC0DQNqhZaqSMG
        8ueiaplK+WTmZGFlAQYnCrQL4dWSGmjCyQ6nLzWGXbgY0P7jbIGXYmQ0OdbIw2fv
        r83JLDiWjUipu/Idd4aRPl+yNv7ZQxKwZwAeXiECAscqLQwzdUcYrDSGr1aD8rmR
        lNaaHdSHiQIs8as=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 30A26118A2D;
        Fri, 25 Feb 2022 18:17:12 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 91524118A2C;
        Fri, 25 Feb 2022 18:17:11 -0500 (EST)
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
Subject: Re: [PATCH v3 3/9] Makefile: disable GNU make built-in wildcard rules
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <patch-v3-3.9-9392e3c3e97-20220225T090127Z-avarab@gmail.com>
Date:   Fri, 25 Feb 2022 15:17:10 -0800
In-Reply-To: <patch-v3-3.9-9392e3c3e97-20220225T090127Z-avarab@gmail.com>
        (=?utf-8?B?IsOGdmFyIEFybmZqw7Zyw7A=?= Bjarmason"'s message of "Fri, 25 Feb
 2022 10:04:29
        +0100")
Message-ID: <xmqqk0di8rk9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 0F810DCE-9691-11EC-A106-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason  <avarab@gmail.com> writes:

> Override built-in rules of GNU make that use a wildcard target. This
> can speeds things up significantly as we don't need to stat() so many
> files. GNU make does that by default to see if it can retrieve their
> contents from RCS or SCCS. See [1] for an old mailing list discussion
> about how to disable these.

;-)

> The speed-up may wary. I've seen 1-10% depending on the speed of the

vary, you mean?

> local disk, caches, -jN etc. Running:
>
>     strace -f -c -S calls make -j1 NO_TCLTK=3DY
>
> Shows that we reduce the number of syscalls we make, mostly in "stat"
> calls.

Naturally understandable.

I do remember getting surprised after seeing output from "make -d"
and how many paths were considered for possible places that a source
file can come from.

> +### Remove GNU make implicit rules
> +
> +## This speeds things up since we don't need to look for and stat() a
> +## "foo.c,v" every time a rule referring to "foo.c" is in play. See
> +## "make -p -f/dev/null | grep ^%::'".
> +%:: %,v
> +%:: RCS/%,v
> +%:: RCS/%
> +%:: s.%
> +%:: SCCS/s.%
> +
>  ### Flags affecting all rules
> =20
>  # A GNU make extension since gmake 3.72 (released in late 1994) to
