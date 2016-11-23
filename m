Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3A0651FF30
	for <e@80x24.org>; Wed, 23 Nov 2016 20:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756286AbcKWUE2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 23 Nov 2016 15:04:28 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:51771 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751167AbcKWUE1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2016 15:04:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 86D4650C84;
        Wed, 23 Nov 2016 15:04:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=QcvpliOJNt6xdqcpgEbupNGOGdw=; b=bXlsLW
        QF/0fL4P3WE5dQeAKfYGSE8UFKULOzywHPxGAvXh9yJooeT91hSdCzPBYER1nfGl
        X2d1zJRgwSlcOw7qzd5e5YxT9qT7ElnHkzNS4KUnSLQ5AqgJ4HHilleFOu5MO6Ae
        xg008h2YwbTbGuYrHMnsLg8BInvuS/mGeACm8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=hniU8oNMwJG1+ktmeMX1SB/G7NAOHzEC
        TxA3P6CTjYE+IdYjLZNQPyzxviagHN/eIpwbkil5l6QCQOGeQOO8TJbvu8wm+rJD
        rD2nYP6W0OvJ8VyB8Vv8CUGqrMG3lhbeEtSkL45SgyZzEr0KqHPHeWjjiiF2OB5p
        bnCsRvYDkMA=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7DC2F50C83;
        Wed, 23 Nov 2016 15:04:26 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E558C50C82;
        Wed, 23 Nov 2016 15:04:25 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     Dennis Kaarsemaker <dennis@kaarsemaker.net>, git@vger.kernel.org
Subject: Re: [PATCH 2/2] difftool: add a feature flag for the builtin vs scripted version
References: <cover.1479834051.git.johannes.schindelin@gmx.de>
        <598dcfdbeef4e15d2d439053a0423589182e5f30.1479834051.git.johannes.schindelin@gmx.de>
        <1479912693.5181.27.camel@kaarsemaker.net>
        <alpine.DEB.2.20.1611231824530.3746@virtualbox>
        <xmqqh96ym6x6.fsf@gitster.mtv.corp.google.com>
        <xmqqd1hmm54f.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1611232051420.3746@virtualbox>
Date:   Wed, 23 Nov 2016 12:04:24 -0800
In-Reply-To: <alpine.DEB.2.20.1611232051420.3746@virtualbox> (Johannes
        Schindelin's message of "Wed, 23 Nov 2016 20:55:25 +0100 (CET)")
Message-ID: <xmqq8tsam08n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 08B4DB06-B1B8-11E6-95E1-B2917B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Hi Junio,
>
> On Wed, 23 Nov 2016, Junio C Hamano wrote:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>> 
>> > Can't you route the control upon seeing "git difftool" to your
>> > experimental "C" difftool and check the configuration there?  Then
>> > you can decide to run_command() a non-builtin one depending what the
>> > configuration says---that way, you would incur cost of spawning Perl
>> > only when you need it, no?
>> 
>> FWIW, the approach taken by 73c2779f42 ("builtin-am: implement
>> skeletal builtin am", 2015-08-04) is what I had in mind when I wrote
>> the above.
>
> Maybe that worked back then. But I doubt it, because checking out that
> revision, I get this "warning":
>
> Makefile:1732: warning: overriding recipe for target 'git-am'
> Makefile:1696: warning: ignoring old recipe for target 'git-am'
>
> Seems like a matter of luck whether the `make` executable you happen to
> use guesses what we want: to munge git-am.sh into git-am, as opposed to
> hard-linking git to git-am.

You do not need to keep two copies of "git-cmd", though.  commands[]
table can have an entry "difftool" that points at cmd_difftool(),
which switches between run_command("difftool-scripted") or makes a
function call to a static difftool_builtin() that you wrote in 1/2.
