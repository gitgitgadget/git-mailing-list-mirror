Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DEBFA1F404
	for <e@80x24.org>; Sat, 17 Feb 2018 00:47:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750957AbeBQAr6 (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Feb 2018 19:47:58 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50922 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750940AbeBQAr4 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Feb 2018 19:47:56 -0500
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 52F5FCF8E8;
        Fri, 16 Feb 2018 19:47:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=date:from:to
        :cc:subject:message-id:references:mime-version:content-type
        :in-reply-to; s=sasl; bh=/iIsW2/LOah9qQ3mks4EqC9A1ek=; b=Uo275L4
        pEmA09wJ/q3tMAdunn8/o3LcX2NFffC4SmqtOtJdwM5c786T016XBeLpTWlgVV0U
        VZE8WNW27Ym6P+Lh4ZV8/9H5ynLLKx2XTQrP9kI9MaNVPR/DaHfvLCrP+j8/Ixrd
        6fwewOajmhYb5iOpvqyllGvaq+g1toEI5x8w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=date:from:to:cc
        :subject:message-id:references:mime-version:content-type
        :in-reply-to; q=dns; s=sasl; b=KVJe6cEOYoX5FU2qdKDtnsQZZBhirTQoA
        h1cWElNUB9nb3jRbWQSKOWLuhvPniWsw3ifxbGO4lQu5Xa7yYXtj6Fa5gyL3S22H
        0bfUkB69dOEdDofL0ZOYBy7bDGZlks0QIBMdvQmUtTAMFQSLyQ+uZLla2H5TwtfR
        JbvsBIjstQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49924CF8E7;
        Fri, 16 Feb 2018 19:47:56 -0500 (EST)
Received: from zaya.teonanacatl.net (unknown [173.67.181.41])
        (using TLSv1.2 with cipher AES256-SHA (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B6ECACF8E6;
        Fri, 16 Feb 2018 19:47:55 -0500 (EST)
Date:   Fri, 16 Feb 2018 19:47:54 -0500
From:   Todd Zullinger <tmz@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0?= Bjarmason <avarab@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Matthieu Moy <git@matthieu-moy.fr>, Petr Baudis <pasky@ucw.cz>,
        Jeff King <peff@peff.net>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jari Aalto <jari.aalto@cante.net>,
        Giuseppe Bilotta <giuseppe.bilotta@gmail.com>,
        Marcus Griep <marcus@griep.us>
Subject: Re: [PATCH 3/8] perl: generalize the Git::LoadCPAN facility
Message-ID: <20180217004753.GS27038@zaya.teonanacatl.net>
References: <20180214222146.10655-1-avarab@gmail.com>
 <20180214222146.10655-4-avarab@gmail.com>
 <20180215045301.GC27038@zaya.teonanacatl.net>
 <87sha2f0j1.fsf@evledraar.gmail.com>
 <20180215212338.GL27038@zaya.teonanacatl.net>
 <87k1vdf188.fsf@evledraar.gmail.com>
 <20180216175519.GQ27038@zaya.teonanacatl.net>
 <20180216220300.GC216564@aiede.svl.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180216220300.GC216564@aiede.svl.corp.google.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
X-Pobox-Relay-ID: 314CF48C-137C-11E8-87D3-D3940C78B957-09356542!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jonathan,

Jonathan Nieder wrote:
> Todd Zullinger wrote:
[...]
>> +++ b/Makefile
>> @@ -296,6 +296,9 @@ all::
>>  #
>>  # Define NO_PERL if you do not want Perl scripts or libraries at all.
>>  #
>> +# Define NO_PERL_CPAN_FALLBACKS if you do not want to install fallbacks for
>> +# perl CPAN modules.
> 
> nit: Looking at this as a naive user, it's not obvious what kind of
> fallbacks are meant. How about:
> 
> 	Define NO_PERL_CPAN_FALLBACKS if you do not want to install bundled
> 	copies of CPAN modules that serve as a fallback in case the modules are
> 	not available on the system.
> 
> Or perhaps:
> 
> 	Define HAVE_CPAN_MODULES if you have Error.pm and Mail::Address installed
> 	and do not want to install the fallback copies from perl/FromCPAN.

Hmm, a positive variable like HAVE_CPAN_MODULES is
appealing.

I don't know about listing the modules, as those seem likely
to change and then the comment becomes stale.  It's nice to
have a shorter name.  I could easily go back and forth.
Hopefully some other folks will chime in with preferences.

> Would this patch need to update the loader to expect the modules in
> the new location?

That's a good catch.  In checking how this ends up when not
setting NO_PERL_CPAN_FALLBACKS, we end up installing
FromCPAN at the root of $perllibdir rather than under the
Git dir.

While we could probably fix Git::LoadCPAN, I doubt we want
to pollute the namespace. ;) So we'll want to ensure the
files get put in the right place from the start.  I'll try
to fix that up.

Thanks for the careful eyes, as usual.

-- 
Todd
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Happiness is like peeing on yourself. Everyone can see it, but only
you can feel its warmth

