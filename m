Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19845C19F2A
	for <git@archiver.kernel.org>; Thu,  4 Aug 2022 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235459AbiHDP72 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 4 Aug 2022 11:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233149AbiHDP70 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 4 Aug 2022 11:59:26 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B91365D0DE
        for <git@vger.kernel.org>; Thu,  4 Aug 2022 08:59:25 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 2B152152F0E;
        Thu,  4 Aug 2022 11:59:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ikTIqq+FoHJU
        1i5l4PfXFumfkKLQ5pGsnx9PZaPZ6fE=; b=kOgDRUsFlbLcfhAGFt6f5yzd3PFL
        9f87bdfiEpIetWfofsWeTC3a0I8Ljhh3/7hJhIrSbSuS7JrcF9gIchTTQdXgIi29
        hGRJvbVuD5qInFMy85E4XAPTnnOsso5qJ0YGKR+/GZPYmKAPJc8WXzSh8EtNzYx6
        LmK8lFLlfpq9+Jw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 22B88152F0D;
        Thu,  4 Aug 2022 11:59:23 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.145.39.32])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 87EEF152F0C;
        Thu,  4 Aug 2022 11:59:22 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v3 4/6] log: refactor "rev.pending" code in cmd_show()
References: <cover-v2-0.6-00000000000-20220729T082919Z-avarab@gmail.com>
        <cover-v3-0.6-00000000000-20220802T152925Z-avarab@gmail.com>
        <patch-v3-4.6-fd474666e7c-20220802T152925Z-avarab@gmail.com>
        <xmqqo7x19pif.fsf@gitster.g>
        <220804.865yj8e93t.gmgdl@evledraar.gmail.com>
Date:   Thu, 04 Aug 2022 08:59:20 -0700
In-Reply-To: <220804.865yj8e93t.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 04 Aug 2022 09:51:41 +0200")
Message-ID: <xmqqy1w46luv.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 6806DE06-140E-11ED-A368-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> Yeah, I saw that. I took it as we should consider changing this more
> generally (e.g. with coccicheck etc.).

To make things easier in the future, for the record, I in general do
not suggest such a bulk rewrite for the sake of rewrite, whether
driven with Coccinelle or something else, and I did not in this
case.

> This was mentioned in one of the original threads about the memcpy()
> idiom, but IIRC there was some reason to think that it wasn't as widely
> supported, ...

I somehow thought that we had that stage too long ago; I recall we
spotted struct assignment in a patch post release and left it there
without reverting.

> ... or in any case we'd want to re-rest that the compilers we
> care about similarly optimize it.

Perhaps.  Using struct assignment only when we feel an urge to use
memcpy() in a new code (or in the postimage of a newly rewritten
code), instead of doing a bulk update, would give us a chance to
start small and vet the result with compilers of such a small scale
rewrite carefully to build confidence, hopefully?

Thanks.
