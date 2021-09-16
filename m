Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACA4EC433F5
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:47:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 87F1E611CA
	for <git@archiver.kernel.org>; Thu, 16 Sep 2021 22:47:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbhIPWsh (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Sep 2021 18:48:37 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:60336 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbhIPWsh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Sep 2021 18:48:37 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id 044EE15A5EC;
        Thu, 16 Sep 2021 18:47:16 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oV0MgGfFktoTZ1XVzdq3zT/4p4itI3q0cvo6Qp
        KLFcU=; b=FBiun54te90ysw+bXtdhqdMrusjCotkURwRWEQsQtbCY3lznTKeSEa
        sqEXhLfn/skP47rYpg7fvKAT0dVOd3nC05kuzp+oBVKkG3PU8Cgr79FczHGl9jGU
        pwhh7bkVJoCF93BvIkSU9/nrT6OdeVD81AgUcmap8ulEgRauiYzWU=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id F278215A5EB;
        Thu, 16 Sep 2021 18:47:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.73.10.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 3E4B415A5E5;
        Thu, 16 Sep 2021 18:47:13 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     wesley@schwengle.net
Cc:     git@vger.kernel.org, me@ttaylorr.com
Subject: Re: [PATCH] Document `rebase.forkpoint` in rebase man page
References: <xmqqtuikrzca.fsf@gitster.g>
        <20210916223528.2910292-1-wesley@schwengle.net>
        <20210916223528.2910292-2-wesley@schwengle.net>
Date:   Thu, 16 Sep 2021 15:47:11 -0700
In-Reply-To: <20210916223528.2910292-2-wesley@schwengle.net>
        (wesley@schwengle.net's message of "Thu, 16 Sep 2021 18:35:28 -0400")
Message-ID: <xmqq4kakrvdc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08AF9806-1740-11EC-B833-F327CE9DA9D6-77302942!pb-smtp20.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

wesley@schwengle.net writes:

> From: Wesley Schwengle <wesley@opperschaap.net>
>
> The option exists and the rebase behaviour tricked me into thinking
> there was a bug with git. This will tell people how they can tweak the
> default behavior.

So this still does not explain what rebase behaviour tricked you
into thinking so.  That leaves the readers of "git log" frustrated,
much more than a log message based only on a simple statement of
fact, e.g.

    "git config --help" describes rebase.forkpoint as a way to give
    the default value for --[no-]forkpoint option, but "git rebase
    --help" does not mention it.  

    Help people who visits the documentation of "rebase" to find the
    variable.

or something like that.

> diff --git a/Documentation/git-rebase.txt b/Documentation/git-rebase.txt
> index 506345cb0e..8d2bee3365 100644
> --- a/Documentation/git-rebase.txt
> +++ b/Documentation/git-rebase.txt
> @@ -446,7 +446,8 @@ When --fork-point is active, 'fork_point' will be used instead of
>  ends up being empty, the <upstream> will be used as a fallback.
>  +
>  If <upstream> is given on the command line, then the default is
> -`--no-fork-point`, otherwise the default is `--fork-point`.
> +`--no-fork-point`, otherwise the default is `--fork-point`. You can override
> +this default by setting the configuration option `rebase.forkpoint` to false.

It is not wrong per-se, but sounds overly verbose and seems to give
only half an advice.  You can also set it to 'true' to override the
default --no-fork-point given when you give <upstream> on the
command line, no?  So perhaps only a single line addition (plus
downcasing "If" to "if"), i.e.

+   If `rebase.forkpoint` is set, that gives the default.  Otherwise,
    if <upstream is given on the command line, the default is ...

would be a better rewrite?

Thanks.
