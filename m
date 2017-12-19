Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 73B731F406
	for <e@80x24.org>; Tue, 19 Dec 2017 17:47:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750799AbdLSRrK (ORCPT <rfc822;e@80x24.org>);
        Tue, 19 Dec 2017 12:47:10 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60334 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750737AbdLSRrJ (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 19 Dec 2017 12:47:09 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id BFB02D20F5;
        Tue, 19 Dec 2017 12:47:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=1TzeHy6vrJdbtSH4e8M49TUh14A=; b=BWuo2i
        9LtgOFRCz8KyZLfwTcTWXlEqu+c9zbvdnLCLFhrdzsIdKW1ykL/xM4qreP8Fwjp7
        vMR/jNdTSKTkR62FrkEeq1O2glgYqCfRkNlc7ud6LE3otphAyHnXQ4elekJTRXvp
        VxLm8blN+msdX6F4709BWZRbqbo+moBPEWSIs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=UFnNadgWmifE88xXIbHVqpSv1a1kQEuO
        gZF2h9HJLPeWmxP35Q+iimraZJHVcoggc0oI6Tfmz3GI2d7J8CPt42y7iG8RRptc
        BLijVT8tz3aBwlz1MYWfD+0uto4QejIfM6mfUsWebLRWqyCiWaim2NEbuX6OW46O
        gdZJtahoUQE=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B5ECED20F4;
        Tue, 19 Dec 2017 12:47:08 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 37BF4D20F1;
        Tue, 19 Dec 2017 12:47:08 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jakub Zaverka <jakub.zaverka@deutsche-boerse.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: difftool uses hardcoded perl shebang
References: <f5d4c8e7bceb410a95a34a8cce4c31dd@deutsche-boerse.com>
        <20171219162528.GA5804@sigill.intra.peff.net>
        <xmqqlghywuct.fsf@gitster.mtv.corp.google.com>
        <20171219164532.GA6745@sigill.intra.peff.net>
        <xmqqh8smwspv.fsf@gitster.mtv.corp.google.com>
        <20171219171253.GA7526@sigill.intra.peff.net>
Date:   Tue, 19 Dec 2017 09:47:06 -0800
In-Reply-To: <20171219171253.GA7526@sigill.intra.peff.net> (Jeff King's
        message of "Tue, 19 Dec 2017 12:12:53 -0500")
Message-ID: <xmqqd13awqxx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: A229E60E-E4E4-11E7-A5A0-575F0C78B957-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Tue, Dec 19, 2017 at 09:08:44AM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > In the meantime, pointing to the actual build-time perl is a workaround
>> > (but obviously not if it's being done by a third-party packager who has
>> > no idea where your perl is).
>> 
>> Is such a binary packaging scheme actually in use that deliberately
>> leaves it up to the end user where/if a perl is installed and if it
>> is an appropriately recent version?  It sounds rather irresponsible
>> to me.
>
> No, I mean that the user can do:
>
>   make PERL_PATH=/path/to/perl/in/my/PATH
>
> but if they are not building Git themselves, that is not an option for
> them. And a binary packager cannot help them there, because they do not
> know that path.

I think we are saying the same thing.  A third-party binary packager
cannot guess where your custom Perl is nor if it is recent enough.
I just was wondering if such an irresponsible packaging scheme is in
use that lets you install Git without somehow making sure that the
box also has a version of Perl that can be used with the version of
Git.  Then the presence of /path/to/perl/in/my/PATH does not matter,
as it does not have to be used with Git.


