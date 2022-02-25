Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AA95C433F5
	for <git@archiver.kernel.org>; Fri, 25 Feb 2022 23:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236990AbiBYXmw (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Feb 2022 18:42:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbiBYXmu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Feb 2022 18:42:50 -0500
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793131F0399
        for <git@vger.kernel.org>; Fri, 25 Feb 2022 15:42:17 -0800 (PST)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 196E518DF3F;
        Fri, 25 Feb 2022 18:42:17 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=rCMGg2dgxniS
        H/nt3DCMyd7PX2WGlizXJzseSHUpn3U=; b=PLFZYOU57n/vPpCO71noIflWN5IJ
        yplsYc4B4E4ngpXO1kFC1+kFMd97qwNHNGReM3mTeHt96L4vUc3MUaBitG1ckYas
        w/lvZqgmK1IN3PtQWAgStIcyrDqXOJVyxnUcZLs4nXCV6LTCLFJ+kFmnbeHHjJgQ
        RBeOqeelx3mLgaQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 111F118DF3E;
        Fri, 25 Feb 2022 18:42:17 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 7E35518DF3D;
        Fri, 25 Feb 2022 18:42:14 -0500 (EST)
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
Subject: Re: [PATCH v3 2/9] Makefiles: add "shared.mak", move
 ".DELETE_ON_ERROR" to it
References: <cover-v2-0.8-00000000000-20211224T173558Z-avarab@gmail.com>
        <cover-v3-0.9-00000000000-20220225T090127Z-avarab@gmail.com>
        <patch-v3-2.9-96a490bec54-20220225T090127Z-avarab@gmail.com>
        <xmqqwnhi8swx.fsf@gitster.g>
        <220226.861qzq7d2r.gmgdl@evledraar.gmail.com>
Date:   Fri, 25 Feb 2022 15:42:13 -0800
In-Reply-To: <220226.861qzq7d2r.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Sat, 26 Feb 2022 00:05:49 +0100")
Message-ID: <xmqqv8x27bu2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8F4FA4E0-9694-11EC-8765-CBA7845BAAA9-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> But wouldn't working this into this series be an even better option?

No.

What our current Makefile does (i.e. to have the default goal at the
beginning, even though the recipe for it may live elsewhere) is a
very well understood and established pattern, and there is no reason
to start doing the same thing in a different way, even if it is safe
to assume that the "different way" may be available everywhere.  We
are not gaining anything from doing it differently.

Especially it is not something I want to see as "while at it"
change, which adds more to the review cycle without improving
anything.

> The ".DEFAULT_GOAL" variable is new in, 3.81 (01 Apr 2006), which I
> think is old enough to hard depend on. We use $(or ...) added in the
> same release in config.mak.dev.
