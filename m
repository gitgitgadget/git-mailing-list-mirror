Return-Path: <SRS0=5D3W=ZY=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91F4FC432C0
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 261D02231B
	for <git@archiver.kernel.org>; Mon,  2 Dec 2019 06:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wlk01P1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727465AbfLBGN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 2 Dec 2019 01:13:26 -0500
Received: from pb-smtp21.pobox.com ([173.228.157.53]:53252 "EHLO
        pb-smtp21.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727462AbfLBGNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Dec 2019 01:13:25 -0500
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8FE9C97978;
        Mon,  2 Dec 2019 01:13:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Xa2zQxckUL2VKHW4a5ixGZvLcKY=; b=wlk01P
        1iZF3pjQN7aF1Z7sqzHn3FjpAf9CrjeHirhkXNgqQ2+0ZwUerXQaNt5n7B7/nmBC
        jzKrQr04ZgKBZW8ZhW0HEntH68OLP5yB1EO8A4vtMkMKj7K5uADg7YCILXWmCXwd
        6PO4qmbx8rdq12vdYNDdRriq2wn77VRTVKFkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=XYU6195X2CGBqKSD0Psb93D2wfbIoa7P
        QDv8iQqhEBNl6zMn3Boo4NXRdfBKjBU1p+0S2bxpw+kc5upbzVgY6L3y9Ges++99
        YijSKrcuYcb0gtOXkgshjsZgCP7Jn9hCNqIl82Hfk8X8hB+1Mc2Tm34stX3OAIss
        oypkqz7nk8E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 8741997977;
        Mon,  2 Dec 2019 01:13:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.76.80.147])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BCBF497976;
        Mon,  2 Dec 2019 01:13:17 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Todd Zullinger <tmz@pobox.com>
Cc:     Andreas Schwab <schwab@linux-m68k.org>,
        =?utf-8?B?w4Z2YXIgQXJuZmo=?= =?utf-8?B?w7Zyw7A=?= Bjarmason 
        <avarab@gmail.com>, git@vger.kernel.org,
        Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= 
        <carenas@gmail.com>, Beat Bolli <dev+git@drbeat.li>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: [PATCH] t7812: expect failure for grep -i with invalid UTF-8 data
References: <20191130004653.8794-1-tmz@pobox.com> <87a78ddc9o.fsf@hase.home>
        <xmqqo8wsypit.fsf@gitster-ct.c.googlers.com>
        <20191201183203.GC17681@pobox.com>
Date:   Sun, 01 Dec 2019 22:13:15 -0800
In-Reply-To: <20191201183203.GC17681@pobox.com> (Todd Zullinger's message of
        "Sun, 1 Dec 2019 13:32:03 -0500")
Message-ID: <xmqqfti3z24k.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: D5031C2C-14CA-11EA-9FF6-8D86F504CC47-77302942!pb-smtp21.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Todd Zullinger <tmz@pobox.com> writes:

> After Andreas' missing redirect fix, that still fails on
> s390x (not surprisingly).  But now systems with JIT enabled
> fail at:
> ...
> Here's how I changed the commit message locally.  I was
> going to wait a day or so for any other feedback on the
> actual test changes, being a holiday weekend in the US (and
> more generally a weekend).
>
> 1:  d9aeaf0c98 ! 1:  d0c083db78 t7812: expect failure for grep -i with invalid UTF-8 data
>     @@ Commit message
>          8a5999838e (grep: stess test PCRE v2 on invalid UTF-8 data, 2019-07-26)
>          and 870eea8166 (grep: do not enter PCRE2_UTF mode on fixed matching,
>          2019-07-26) they lacked a redirect which caused them to falsely succeed
>     -    on most architectures.  They failed on big-endian arches where the test
>     -    never reached the portion which was missing the redirect.
>     +    on most systems.  The 'grep -i' test failed on systems where JIT was
>     +    disabled as it never reached the portion which was missing the redirect.
>      
>     -    A recent patch add the missing redirect and exposed the fact that the
>     -    'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' test fails on
>     -    all architectures.
>     +    A recent patch added the missing redirect and exposed the fact that the
>     +    'PCRE v2: grep non-ASCII from invalid UTF-8 data with -i' test fails
>     +    regardless of whether JIT is enabled.
>      
>          Based on the final paragraph in in 870eea8166:
>
> Thanks for pointing out the proper reasoning to use in the
> commit message Andreas.  I hadn't looked at the Fedora pcre2
> package to see that it explicitly disables JIT on s390x.

OK.  I locally edited the log message to match the above.  I guess
this forms an integral part of a topic that Andreas started with the
"missing redirects" fix, so let me queue your patch directly on the
same topic branch, without creating a separate one.

Thanks, both.
