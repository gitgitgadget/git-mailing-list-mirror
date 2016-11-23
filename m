Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C65E1FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 17:47:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965139AbcKWRrP (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 12:47:15 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60046 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S965122AbcKWRrM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 12:47:12 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F16464BFBD;
        Wed, 23 Nov 2016 12:40:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=2w777BF8Xd1Eyr3y9dVfBQXjcsQ=; b=wVdeEW
        Kxsn2fqAQXgHtobHw2xMGe3STxwIQouegk8KLouQTuO3sZZYvVTetLJlVbRTpwRV
        hMpdFSaX5z6w49cxBsfZ0SePmNaBLX1BtbHTzTXIwCNQGHlqjwQ2qu7/QsJ9o21B
        JeCqITi0NUzX7vqXLgoCYRJdGPVw+zvLPPjCA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=AiyXJfs3DUFInw1hW2w7NTD2LE+4o5Yl
        5ATE+k86KV5MdKSnkKOKJ946LTBW/vyF1BhWSwtYIvK8+UjBMYgF+/dkuMje4ekH
        t0hyUF9s+k0LsqeHqVIrKl7zFurha/1qTRmuHtl0TuqiuOtbsNJ0/1MIvZgxNVpS
        LAc0PMjS1/U=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E9C794BFBB;
        Wed, 23 Nov 2016 12:40:06 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5A9634BFBA;
        Wed, 23 Nov 2016 12:40:06 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] difftool: add a feature flag for the builtin vs scripted version
References: <cover.1479834051.git.johannes.schindelin@gmx.de>
        <598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de>
        <1479912693.5181.27.camel@kaarsemaker.net>
        <alpine.DEB.2.20.1611231824530.3746@virtualbox>
Date:   Wed, 23 Nov 2016 09:40:05 -0800
In-Reply-To: <alpine.DEB.2.20.1611231824530.3746@virtualbox> (Johannes
        Schindelin's message of "Wed, 23 Nov 2016 18:29:43 +0100 (CET)")
Message-ID: <xmqqh96ym6x6.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: DF33F64A-B1A3-11E6-B85D-E98412518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> The downside is that we actually *do* go through Perl to do that. Only to
> go back to a builtin. Which is exactly the thing I intended to avoid.
>
> If we do not go through Perl, we have to set up the git directory and
> parse the config in git.c *just* to figure out whether we want to
> magically forward difftool to builtin-difftool. That is not only ugly, but
> has potential side effects I was not willing to risk.

I won't accept the latter anyway, so do not worry ;-)

> In any case, this feature flag will be there only for one or two Git for
> Windows releases, to give early adopters a chance to send me bug reports
> about any regressions.

I think that is sensible.  I suspect that for early detection of
breakages, you do not need to invent and force people to use a
completely new "mechanism" to switch between two implementations.

Can't you route the control upon seeing "git difftool" to your
experimental "C" difftool and check the configuration there?  Then
you can decide to run_command() a non-builtin one depending what the
configuration says---that way, you would incur cost of spawning Perl
only when you need it, no?

