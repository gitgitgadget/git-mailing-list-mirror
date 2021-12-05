Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF80C433F5
	for <git@archiver.kernel.org>; Sun,  5 Dec 2021 19:30:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237796AbhLETeP (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Dec 2021 14:34:15 -0500
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63009 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237544AbhLETeP (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Dec 2021 14:34:15 -0500
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 72CD1176D62;
        Sun,  5 Dec 2021 14:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=ALOzPP96hdI2
        luEDl+G+dkkEumblZiZ7ZUlxZ2vjg+A=; b=geUIZvga1aXDYkeDLJ7FeoqqsyCo
        GVoqaMfBYigkpC3hsL0T2rgaJhK0ehzLqNNrHdakg4DsRJoIhDUldkPdu4xGI6Pj
        BvIGgYOf1jbO05oEBpirp8FduoxvRbcB/nqRzQL/B23uea/8vh9AGH4NkKBIec5j
        oi1OX0+zPGFUpEI=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 6B04B176D61;
        Sun,  5 Dec 2021 14:30:47 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 725C2176D60;
        Sun,  5 Dec 2021 14:30:43 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?= 
        <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>
Subject: Re: [PATCH 00/10] Factorization of messages with similar meaning
References: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
Date:   Sun, 05 Dec 2021 11:30:41 -0800
In-Reply-To: <pull.1088.git.1638514909.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
        Avila via GitGitGadget"'s message of "Fri, 03 Dec 2021 07:01:39
        +0000")
Message-ID: <xmqqfsr6luhq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D67918DE-5601-11EC-8F44-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Jean-No=C3=ABl Avila via GitGitGadget"  <gitgitgadget@gmail.com> writes:

> This series is a meager attempt at rationalizing a small fraction of th=
e
> internationalized messages. Sorry in advance for the dull task of revie=
wing
> these insipide patches.
>
> Doing so has some positive effects:
>
>  * non-translatable constant strings are kept out of the way for transl=
ators
>  * messages with identical meaning are built identically
>  * the total number of messages to translate is decreased.
>
> I'm inclined to even go a step further and turn these messages into #de=
fine
> or const strings.

After looking at [01/10] that repeats the same string in many
places, I would have to say that we do not want such C preprocessor
macros.  Having to hunt for an existing message that is close enough
to what you want to say, when you are writing a new message, feels a
bit too much.

I wonder if a tool that

 - looks for "newly added" messages (by scanning "git diff" output)

 - compares them with po/git.pot for existing msgid in a fuzzy way
   to locate the ones that may be candidate for a change like the
   changes in this series

can help developers, though.

Thanks.
