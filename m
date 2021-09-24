Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42759C433F5
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:53:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2AB15610C7
	for <git@archiver.kernel.org>; Fri, 24 Sep 2021 17:53:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345055AbhIXRzC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Sep 2021 13:55:02 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56936 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345086AbhIXRzC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Sep 2021 13:55:02 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 50072E015C;
        Fri, 24 Sep 2021 13:53:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YQjZgse58udJ4H1ke2sQGWjDHyAX2ukkh7UVkv
        mOtLU=; b=jIFDW33y9USZxGYAPXjma4ha0NOB7Yc1ZnrjTUJun1qjtpWE0dUa1f
        Dhtg0+6uYh5Pj5f38hDL8Rt4nIV4AV+7ko61sx0aFiLS3Qy/3B9A7g7Kt4eo5bzH
        MqQeRGEEfmW17WqqW4hulTJe62TQaQdP8zl3GmXr4K0TQHMKV8Iu4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 46CE8E015B;
        Fri, 24 Sep 2021 13:53:28 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A8E31E0159;
        Fri, 24 Sep 2021 13:53:27 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, Thiago Perrotta <tbperrotta@gmail.com>,
        Carlo Arenas <carenas@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH] send-email: clarify dual-mode behavior
References: <20210924121352.42138-1-bagasdotme@gmail.com>
Date:   Fri, 24 Sep 2021 10:53:26 -0700
In-Reply-To: <20210924121352.42138-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Fri, 24 Sep 2021 19:13:54 +0700")
Message-ID: <xmqq35ptx3l5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 52562BF2-1D60-11EC-ADE0-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> git send-email can be operated in two modes: one that sends
> already-prepared patches and one that generates patches from
> revision range on-the-fly for sending. Clarify it in the documentation
> and usage help.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  This patch is based on [PATCH v5 2/3] send-email: programmatically
>  generate bash completions [1]. PATCH v5 3/3 can be replaced with
>  this patch, or be integrated as stand-alone patch.

Hmph.  I appreciate your enthusiasm, but I am not sure about this
change.

>
>  Questions:
>
>    1. Do all supported revision range syntaxes from git rev-list also be
>       accepted by git send-email? I only test `A..B` and `B ^A` syntaxes
>       and assumed that all are supported.

We do not have to ask that question if we said "format-patch
options" instead of ""revision range".

>    2. Does git send-email also accepts options understood by git
>       rev-list?

This becomes an irrelevant question if we used "format-patch
options" instead of "revision range".  Does git format-patch accept
options understood by git rev-list?  Very likely, given that it
shares the underlying option parser.  Do all options understood by
git rev-list make sense in that context?  Absolutely not.  What does
"git format-patch --left-right --boundary" even mean, for example?

But "git format-patch -U5 master" would make sense (show the commits
not yet in 'master' in patch form, but using 5-line context instead
of the usual 3).  So it is not "revision range", but more like "what
format-patch takes".

So from that point of view ...

> +'git send-email' [<options>] <file|directory>...
> +'git send-email' [<options>] <revision range>

... this is not improving Thiago's [3/3], I suspect.

Thanks.
