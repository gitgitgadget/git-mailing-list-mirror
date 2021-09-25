Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECEFCC433F5
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 16:37:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B673460EE9
	for <git@archiver.kernel.org>; Sat, 25 Sep 2021 16:37:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbhIYQii (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Sep 2021 12:38:38 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56704 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbhIYQih (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Sep 2021 12:38:37 -0400
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id B23EBE79E5;
        Sat, 25 Sep 2021 12:37:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=YGtaY+VMv++9HkNGprf0YDipoK1WEYnYLIc6mH
        4DtlE=; b=JAv+i2mJbmsggy+FaOxHcxnbaOADmdyLY95JprwrRk6ills08TtPZG
        KGnR6woTt9YxqCadRs+1Up1sFj4bWl7+WB4rqiDC6GHZtolhwqhHbXWORxjOdINV
        v2prH7+Ejr1wI5JRnlvTL8qo9OG7/aqGEfFUdenGEP2Q76sgubTAY=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id A8669E79E4;
        Sat, 25 Sep 2021 12:37:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [104.133.2.91])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id E59CDE79E1;
        Sat, 25 Sep 2021 12:37:00 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     git@vger.kernel.org, th.acker@arcor.de, bfields@citi.umich.edu
Subject: Re: [PATCH] git(1): Define "porcelain commands"
References: <20210925122228.1090901-1-bagasdotme@gmail.com>
Date:   Sat, 25 Sep 2021 09:36:59 -0700
In-Reply-To: <20210925122228.1090901-1-bagasdotme@gmail.com> (Bagas Sanjaya's
        message of "Sat, 25 Sep 2021 19:22:29 +0700")
Message-ID: <xmqqtui8r4r8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: CED5B508-1E1E-11EC-A06F-62A2C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Bagas Sanjaya <bagasdotme@gmail.com> writes:

> The description before list of porcelain commands doesn't tell what
> "porcelain" term is, nor the accurate categorization (because it only
> says that such commands are divided into main and ancillary commands,
> although there are also tools for interacting with others and trio
> reset-restore-revert).
>
> Define the term and say the proper categorization in the description
> paragraph.
>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---
>  Documentation/git.txt | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 6dd241ef83..fb6d7d860d 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -221,8 +221,14 @@ We divide Git into high level ("porcelain") commands and low level
>  High-level commands (porcelain)
>  -------------------------------
>  
> -We separate the porcelain commands into the main commands and some
> -ancillary user utilities.
> +Porcelain commands are user-facing, high level command interface of
> +Git. These are built from plumbing commands and expose SCM interface
> +and human-friendly output. Most users run only porcelains unless they
> +have absolute necessity for plumbing commands (e.g. scripting).

Before this section, we briefly mention that we have two classes of
commands (high level "porcelain" and low level "plumbing").  It is
certainly a good idea to have additional clarification on what "high
level" and "low level" mean and how they differ, but most of the new
material should go to the preamble before this paragraph, I would
think.

Also, the phrasing to describe criteria to choose between them needs
careful rewriting.  These two classes of commands serve different
purposes.  The "high level" ones are meant for end-user interaction,
where DWIMmery and short-cuts for human convenience outweigh, while
the "low level" ones aim more for predictability to help their use
in scripts.  The choice certainly would *not* be "unless absolutely
necessary, use Porcelain even for scripting".  Porcelain commands
are designed for interactive use, plumbing are designed for
scripting.  It is more like "script with plumbing---you can use
Porcelain in your scripts when it is absolutely necessary, but be
prepared that future changes to Porcelain may break your scripts and
do not come back to us with complaints---Porcelain can change in a
way that will help human interactive users."

> +The following description divides porcelain commands into main
> +commands, ancillary utilities, tools for interacting with foreign SCM
> +and email, and similarly-named commands for reverting changes.

While a finer grained categorization like the above may not be a bad
idea, I have not formed an opinion if the above one is what we
want (especially I am not sure about singling out "reverting
changes", both as a category and as a characterization).

Thanks.
