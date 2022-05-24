Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE532C433EF
	for <git@archiver.kernel.org>; Tue, 24 May 2022 22:34:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239135AbiEXWep (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 18:34:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbiEXWeo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 18:34:44 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 971B96D4C4
        for <git@vger.kernel.org>; Tue, 24 May 2022 15:34:43 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B930C127BEA;
        Tue, 24 May 2022 18:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=pQCs/wONb4tL
        7BoVocPEGWaNPWysAFIPfQsqBLLr3Wo=; b=kZ1LO6K3vgm9OpvXGlhHpbJWw1xY
        2XRqbzgKAGFzcKxQ54nmFG/JlMyon8KBiNd8tLKnNZx+SZJ2WAJ5cjAyGHFHnvpv
        M8QkrQpr6A02TqZYFt0OQVSpfU92daiA2ahwKqu17gbJ0Dalyjw2u36bV6V/HiOW
        73uZvONlw+nx1Ng=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B0915127BE9;
        Tue, 24 May 2022 18:34:42 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.92.57])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id DC4EC127BE7;
        Tue, 24 May 2022 18:34:41 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= <carenas@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git@vger.kernel.org, Michael J Gruber <git@grubix.eu>
Subject: Re: [PATCH] http.c: clear the 'finished' member once we are done
 with it
References: <cover.1651859773.git.git@grubix.eu>
        <3f0e462e86625a3c253653e4a4eefabcd8590bf9.1651859773.git.git@grubix.eu>
        <xmqqtua2jtr0.fsf@gitster.g> <xmqqczgqjr8y.fsf_-_@gitster.g>
        <nycvar.QRO.7.76.6.2205232248360.352@tvgsbejvaqbjf.bet>
        <xmqqr14jluu4.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205240124280.352@tvgsbejvaqbjf.bet>
        <xmqqa6b7lrw6.fsf@gitster.g>
        <nycvar.QRO.7.76.6.2205241258510.352@tvgsbejvaqbjf.bet>
        <xmqqleuqj1gy.fsf@gitster.g>
        <20220524201639.2gucdkzponddk5qt@carlos-mbp.lan>
        <220524.86mtf6ve89.gmgdl@evledraar.gmail.com>
Date:   Tue, 24 May 2022 15:34:40 -0700
In-Reply-To: <220524.86mtf6ve89.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Tue, 24 May 2022 22:45:03 +0200")
Message-ID: <xmqqh75eef0f.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: B41E875C-DBB1-11EC-BA5E-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> It doesn't mean that GCC has additionally proved that we'll later used
> it in a way that will have a meaningful impact on the behavior of our
> program, or even that it's tried to do that. See an excerpt from the GC=
C
> code (a comment) in [1].

But that means the warning just as irrelevant as "you stored 438 to
this integer variable".  Sure, there may be cases where that integer
variable should not exceed 400 and if the compiler can tell us that,
that would be a valuable help to developers.  But "you stored an
address of an object that can go out of scope in another object
whose lifetime lasts beyond the scope" alone is not, without "and
the caller that passed the latter object later dereferences that
address here".  We certainly shouldn't -Werror on such a warning
and bend our code because of it.
