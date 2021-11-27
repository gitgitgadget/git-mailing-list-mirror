Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C5116C4332F
	for <git@archiver.kernel.org>; Sat, 27 Nov 2021 20:22:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343794AbhK0UZg (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 27 Nov 2021 15:25:36 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:61051 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240132AbhK0UXg (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 27 Nov 2021 15:23:36 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id C271610F220;
        Sat, 27 Nov 2021 15:20:20 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=wQjz+ix4WCEZ7Oj2hZC6J83qhwpE0TCMIsLGh8
        AcEyU=; b=BJoBLTtYDAY3A9AaeUO4GyJR7Z5/Ai2BDhuQT9zheWODahXpXYPNPV
        OTE442hC7CT/OQp1DMPnMUCWLXKC7yHtWCteBw3mUL5RoafAosQIz9VRAyGSXZiu
        +Tlq5xIxTA5rp6/ER8l8MJurXsKcGW6p2xI8sUvZ266L5mRYoe7aI=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B9A8C10F21F;
        Sat, 27 Nov 2021 15:20:20 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 25CFD10F21E;
        Sat, 27 Nov 2021 15:20:20 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Eric Wong <e@80x24.org>
Cc:     Thorsten Leemhuis <linux@leemhuis.info>, workflows@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Jonathan Corbet <corbet@lwn.net>, git@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [RFC PATCH v1 1/1] docs: add the new commit-msg tags
 'Reported:' and 'Reviewed:'
References: <cover.1637566224.git.linux@leemhuis.info>
        <6b760115ecdd3687d4b82680b284f55a04f3ad90.1637566224.git.linux@leemhuis.info>
        <20211123185237.M476855@dcvr>
        <12cefa81-495b-3083-5f19-b319c704ebf7@leemhuis.info>
        <20211126171141.GA21826@dcvr>
        <42ff6b8d-0b7c-12e0-4648-a9232b0f577c@leemhuis.info>
        <20211127195231.GA4636@dcvr>
Date:   Sat, 27 Nov 2021 12:20:18 -0800
In-Reply-To: <20211127195231.GA4636@dcvr> (Eric Wong's message of "Sat, 27 Nov
        2021 19:52:31 +0000")
Message-ID: <xmqqtufx5p19.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 7169B0E0-4FBF-11EC-9A29-CD991BBA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Eric Wong <e@80x24.org> writes:

> Thorsten Leemhuis <linux@leemhuis.info> wrote:
>> Just to be sure I'll do what you expect to be done: I assume you want to see
>> it changed like this?
>> 
>> -	perl -pi -e 's|^Message-Id:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|g;' "$1"
> ...
> The entire match should be case-insensitive[1], so I'd add `i'
> at the end:
>
> 	perl -pi -e 's|^Message-ID:\s*<?([^>]+)>?$|Link: https://lore.kernel.org/r/$1|gi;' "$1"
>
> Fwiw, every mail and HTTP/1.x header parser I've looked at works
> case-insensitively.  Also, I'm not sure if `g' is needed, actually...

It is left anchored with "^" so it would be hard to match more than
once on the same line ;-)

I agree that it is the right solution to make the whole thing
case-insensitive by adding 'i' at the end.

FWIW, the RFC first says this:

    1.2.2. Syntactic notation

       This standard uses the Augmented Backus-Naur Form (ABNF) notation
       specified in [RFC2234] for the formal definitions of the syntax of
       messages.  Characters will be specified either by a decimal value
       (e.g., the value %d65 for uppercase A and %d97 for lowercase A) or by
       a case-insensitive literal value enclosed in quotation marks (e.g.,
       "A" for either uppercase or lowercase A).

and then goes on to define how message-id should look like.

    3.6.4. Identification fields

    message-id      =       "Message-ID:" msg-id CRLF


But if you go the "add /i at the end" route, you do not have to
upcase "d" to "D" and that may reduce the patch noise (it only
matters if the patch viewer highlights letter-by-letter changes for
your recipients).

HTH
