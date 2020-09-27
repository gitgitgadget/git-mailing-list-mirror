Return-Path: <SRS0=TjTC=DE=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAA42C4346E
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 19:51:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5D0DE21D95
	for <git@archiver.kernel.org>; Sun, 27 Sep 2020 19:51:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="JFscHLnn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726316AbgI0Tvt (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 27 Sep 2020 15:51:49 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:65365 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726239AbgI0Tvt (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 27 Sep 2020 15:51:49 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 5B820E6212;
        Sun, 27 Sep 2020 15:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=Yfwoj24k33WjT8QAj1LFVJDfRnA=; b=JFscHL
        nnCKX5ZdZsj9Hx/OFSuTlCIcxUaomgSuc5hMQsuQvFz16aZ5a6w2YVkAdUcCu9ki
        PUjfaI3KYrmuruq4Bz+P8b7gOsGpt3jGz5iUOv50NtEkenXA1uqgGETFzdSgfNu1
        tcwASM/2we06qGA/VJNet0AyzoIolOHxCzsJ0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=IBjSJ/IbQxXkuYw9mmIrmQMphySxrhE5
        sTSpQ/3YOJIZ7ChxodB0By6FNSpzitqb+FSvTwB3khxPiMZIzPtn+FY1v5PStM7I
        uMtTj7PWiQK7eR8Z7OW7k3NaWR72bD6IM0LvoVKi0nmzhxKctd0uARRIu6Xu3pm4
        z1x8xmXCnAc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 53EA6E6211;
        Sun, 27 Sep 2020 15:51:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id A461AE620E;
        Sun, 27 Sep 2020 15:51:44 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>
Subject: Re: [PATCH v2 4/8] shortlog: match commit trailers with --group
References: <20200927083933.GA2222823@coredump.intra.peff.net>
        <20200927084004.GD2465761@coredump.intra.peff.net>
Date:   Sun, 27 Sep 2020 12:51:43 -0700
In-Reply-To: <20200927084004.GD2465761@coredump.intra.peff.net> (Jeff King's
        message of "Sun, 27 Sep 2020 04:40:04 -0400")
Message-ID: <xmqqlfgvngkw.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DEED654A-00FA-11EB-8690-F0EA2EB3C613-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> If a project uses commit trailers, this patch lets you use
> shortlog to see who is performing each action. For example,
> running:
>
>   git shortlog -ns --group=trailer:reviewed-by
>
> in git.git shows who has reviewed. You can even use a custom
> format to see things like who has helped whom:
>
>   git shortlog --format="...helped %an (%ad)" \
>                --group=trailer:helped-by

That's a cute example.

> +Note that commits that do not include the trailer will not be counted.

Understandable.

> +Likewise, commits with multiple trailers (e.g., multiple signoffs) may
> +be counted more than once.

Solicits a "is it desirable, or is it just too hard to dedupe?" response.

> +The contents of each trailer value are taken literally and completely.
> +No mailmap is applied, and the `-e` option has no effect (if the trailer
> +contains a username and email, they are both always shown).

OK.  Some users may find that not quite satisfying, though.

But I have a suspicion that the above will be refined in later
steps?  It would have been nicer to see that mentioned in the
proposed log message (e.g. "this step gives the minimum basics and
rough edges like X and Y will be refined with later patches").

Thanks.
