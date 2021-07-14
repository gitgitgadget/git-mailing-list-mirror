Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6125FC12002
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:47:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A379613C1
	for <git@archiver.kernel.org>; Wed, 14 Jul 2021 20:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232491AbhGNUuu (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 14 Jul 2021 16:50:50 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50378 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233822AbhGNUut (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 14 Jul 2021 16:50:49 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id E1838D1B4C;
        Wed, 14 Jul 2021 16:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=dVbRba9HUEz/NPeXVOZ8qi+SB7RBoaNuQuEYIw
        gfPRs=; b=OJS1AfrWTq/KUvJUaYw2nhJLbHJpYSfkOdNG9xY6HuJjaQ8kTOcK+u
        cZ3QAdg368h1dW1g60tNLAad0RPKcTUTznGbTIT6ymux/j3Y2BmzMVklT0OF+StV
        u/dQ4PFlmwHLYVgwotCR3pe7KV5OtH2jxWNnllyjlZm56oNUZTVBA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D9780D1B4B;
        Wed, 14 Jul 2021 16:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.3.135])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 4F23CD1B4A;
        Wed, 14 Jul 2021 16:47:56 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     German Lashevich <german.lashevich@gmail.com>,
        "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: Bug report: GIT_CONFIG and user.email/name
References: <1C6C1E49-5EC1-420D-A72A-8C50BD1931A2@getmailspring.com>
        <YO8ordiN18sNP6tA@coredump.intra.peff.net>
Date:   Wed, 14 Jul 2021 13:47:55 -0700
In-Reply-To: <YO8ordiN18sNP6tA@coredump.intra.peff.net> (Jeff King's message
        of "Wed, 14 Jul 2021 14:10:53 -0400")
Message-ID: <xmqqeec0vczo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: C462DD9E-E4E4-11EB-BC4E-FD8818BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The GIT_CONFIG variable doesn't work that way. It is not a general
> mechanism used by all of Git, but rather a specific feature of the
> git-config program (and even there it is a historical wart; you should
> use "git config --file" instead).

We both have known that, but a fresh re-read of GIT_CONFIG in "git
help config" gave me a misleading impression.

    ENVIRONMENT
    -----------

    GIT_CONFIG::
            Take the configuration from the given file instead of .git/config.
            Using the "--global" option forces this to ~/.gitconfig. Using the
            "--system" option forces this to $(prefix)/etc/gitconfig.

is what we have above the GLOBAL and SYSTEM you quoted below.  We
should say GIT_CONFIG is only for "git config" command while the
other two affects everybody, right?

Thanks.

> One of these variables is probably more helpful:
>
>   $ man git | sed -n '/GLOBAL/,/^$/p'
>   GIT_CONFIG_GLOBAL, GIT_CONFIG_SYSTEM
>     Take the configuration from the given files instead from global or
>     system-level configuration files. If GIT_CONFIG_SYSTEM is set, the
>     system config file defined at build time (usually /etc/gitconfig)
>     will not be read. Likewise, if GIT_CONFIG_GLOBAL is set, neither
>     $HOME/.gitconfig nor $XDG_CONFIG_HOME/git/config will be read. Can
>     be set to /dev/null to skip reading configuration files of the
>     respective level.
>
> Note that they're new in v2.32.0.
>
> -Peff
