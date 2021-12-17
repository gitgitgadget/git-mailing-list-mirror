Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 913C0C433F5
	for <git@archiver.kernel.org>; Fri, 17 Dec 2021 22:42:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbhLQWmL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Dec 2021 17:42:11 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:51359 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230518AbhLQWmK (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Dec 2021 17:42:10 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 2D00416AE58;
        Fri, 17 Dec 2021 17:42:10 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=+kmR01Hj9i8U
        p6UiJgaiSxuE33R4popxFtwXqrwRZOY=; b=fgRebAcS5bQDQK5uFWHde7Yfe4Pf
        3756R2c4RjxwkPXnycFddvqlzBSbh2pNRy8+r9eE1zxdylK9FUUqRTq7hGgKZcwd
        6d6Rp1c6ODI1z2VAVAFcCSkJJeqP5nvMqgNeJkL0ghqCPJyIxdE1L2MqM0hptxUK
        6ap/ium+3cn9BQs=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 25AE216AE57;
        Fri, 17 Dec 2021 17:42:10 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 67B6916AE55;
        Fri, 17 Dec 2021 17:42:06 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        Andriy Makukha via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Andriy Makukha <andriy.makukha@gmail.com>
Subject: Re: [PATCH] strlcpy(): safer and faster version
References: <pull.1097.git.1639675881065.gitgitgadget@gmail.com>
        <YbuB8xeHLNSYnv/a@coredump.intra.peff.net>
        <xmqqy24k6v1a.fsf@gitster.g>
        <211217.86sfur9503.gmgdl@evledraar.gmail.com>
Date:   Fri, 17 Dec 2021 14:42:05 -0800
In-Reply-To: <211217.86sfur9503.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Fri, 17 Dec 2021 06:22:30 +0100")
Message-ID: <xmqqa6gy3lc2.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 8FCE1708-5F8A-11EC-8629-C85A9F429DF0-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> Thanks for saying everything I wanted to say ;-)
>
> Isn't strlcpy() an OpenBSD-initiated effort? So if we're going to updat=
e

Yes.

> this at all shouldn't be be aiming for picking an "upstream" here?
> E.g. [1]?

If this were an improvement, yes.  But if I am reading the patch
correctly, it changes what the value returned from the function
means.  I do not think that would fly even in the upstream, without
a very good justification.  Adding a new function that has semantics
different from strlcpy() might be a possibility at upstream, but as
far as this project is concerned, if we were to change the use of
strlcpy() in the codebase, we often have tools that are much better
suited in our arsenal, as Peff already mentioned, so...
