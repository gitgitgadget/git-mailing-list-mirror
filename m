Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C042FC433EF
	for <git@archiver.kernel.org>; Thu, 31 Mar 2022 20:38:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241506AbiCaUjs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 31 Mar 2022 16:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241504AbiCaUjq (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 31 Mar 2022 16:39:46 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38B981DF877
        for <git@vger.kernel.org>; Thu, 31 Mar 2022 13:37:59 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 1B9701257D4;
        Thu, 31 Mar 2022 16:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=kX5+YxFezWyI
        25ms9QyY2bEremYWhEoaQx0qIH7pRt0=; b=Q/RuKmjjDE1Z/pq02A++RyBMMZ/P
        NihUO/wNpXxXhvwvp3R1a57Z3Soor8R6/XjPRGGimDbJC7mH/BixtYB3M/QDkD4y
        jmQjyHn/CchYe1QgrIOmjwklkQsmj0Yr4oJ/l95gYy2Wziw5IFa7DaUP1yE4gQIj
        iUhT2rmeIYFnZpk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 107C41257D1;
        Thu, 31 Mar 2022 16:37:58 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.227.145.180])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 74F971257D0;
        Thu, 31 Mar 2022 16:37:57 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Eric Sunshine <sunshine@sunshineco.com>,
        =?utf-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v2] worktree: add -z option for list subcommand
References: <pull.1164.git.1645801727732.gitgitgadget@gmail.com>
        <pull.1164.v2.git.1648743688825.gitgitgadget@gmail.com>
Date:   Thu, 31 Mar 2022 13:37:56 -0700
In-Reply-To: <pull.1164.v2.git.1648743688825.gitgitgadget@gmail.com> (Phillip
        Wood via GitGitGadget's message of "Thu, 31 Mar 2022 16:21:28 +0000")
Message-ID: <xmqqk0c926zf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 72D93E44-B132-11EC-A2E9-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> Add a -z option to be used in conjunction with --porcelain that gives
> NUL-terminated output. As 'worktree list --porcelain' does not quote
> worktree paths this enables it to handle worktree paths that contain
> newlines.
>
> Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
> ---
>     worktree: add -z option for list subcommand
>    =20
>     Thanks to Eric, Jean-No=C3=ABl and Junio for their comments on V1. =
I've
>     reworded the docs and option help and tweaked the tests as suggeste=
d by
>     Eric, fixed the error messages as suggested by Eric/Jean-No=C3=ABl =
and
>     changed the implementation to use write_name_quoted() as suggested =
by
>     Junio. I've punted doing anything about quoting the output without =
-z
>     for now, I'll fix that with and without --porcelain in another seri=
es.

Thanks for an update.  Will queue.  I think this iteration is good
to merge to 'next', but let's wait for a few days to see what others
think.

It also made me wonder if "-z" alone should be made to imply
"--porcelain" (in other words, is there a good reason to ask for
NUL-terminated output when you are producing a human-readable
output?), but we can start stricter like this patch does; we can
later loosen it if needed.


