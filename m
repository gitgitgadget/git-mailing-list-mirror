Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1DAC3207DF
	for <e@80x24.org>; Fri, 16 Sep 2016 18:13:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752784AbcIPSNP (ORCPT <rfc822;e@80x24.org>);
        Fri, 16 Sep 2016 14:13:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:63255 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1751277AbcIPSNN (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2016 14:13:13 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 347F53F57E;
        Fri, 16 Sep 2016 14:13:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=9YdXfkKjkln/LjyqqP/MchVlFJs=; b=ffL7JP
        pnZiO4JPvZULLAMxIwTUvqyvVzHzCY5O1i2vWIT098nG76zqEwpX3y60hsYlzWHw
        r67wbyBdNYjK42duNZ0hVjN2dMbL64dhMR5P6ZXRBL07eYu37AHH4JtFzLBbYmm/
        3Ck/97kT/oUy0BeI/fOlxnp5YaMqzAiw1hpAU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=LgwoyhvbBQHyaLHeztHaBCO7d6gwCoXM
        ds6PHJiHKLLBF4CSejqwQBqlCqM4rLa57DrmON++nARBHRgMopuUuIEZ7Dj7Kshf
        YNhOvWncfdD0RaJ8/dfzpx16wAyr0oxAq1FI8VnD1t44Ol1vCh45A6B+iVp9P4Jp
        1T1TO13c34s=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2C3963F57D;
        Fri, 16 Sep 2016 14:13:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 9CC8A3F57C;
        Fri, 16 Sep 2016 14:13:11 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Heiko Voigt <hvoigt@hvoigt.net>
Cc:     Jeff King <peff@peff.net>, Stefan Beller <sbeller@google.com>,
        "git\@vger.kernel.org" <git@vger.kernel.org>,
        Jens Lehmann <Jens.Lehmann@web.de>,
        Fredrik Gustafsson <iveqy@iveqy.com>,
        Leandro Lucarella <leandro.lucarella@sociomantic.com>
Subject: Re: [PATCH 3/2] batch check whether submodule needs pushing into one call
References: <20160824173017.24782-1-sbeller@google.com>
        <20160824183112.ceekegpzavnbybxp@sigill.intra.peff.net>
        <xmqqh9aaot49.fsf@gitster.mtv.corp.google.com>
        <CAGZ79kYOBqQ0FF4J-+KbefSD8HRrUeMqpO27m_jprhm93aB+LA@mail.gmail.com>
        <20160824230115.jhmcr4r7wobj5ejb@sigill.intra.peff.net>
        <20160914173124.GA7613@sandbox>
        <xmqqwpiep10i.fsf@gitster.mtv.corp.google.com>
        <20160915121044.GA96648@book.hvoigt.net>
        <xmqq1t0kna51.fsf@gitster.mtv.corp.google.com>
        <20160916094019.GB1488@book.hvoigt.net>
        <20160916123155.GA40725@book.hvoigt.net>
Date:   Fri, 16 Sep 2016 11:13:09 -0700
In-Reply-To: <20160916123155.GA40725@book.hvoigt.net> (Heiko Voigt's message
        of "Fri, 16 Sep 2016 14:31:55 +0200")
Message-ID: <xmqq1t0jlnm2.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 3A763EF0-7C39-11E6-9574-096F12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Fri, Sep 16, 2016 at 11:40:19AM +0200, Heiko Voigt wrote:
>> > By the way, with the two new patches, 'pu' seems to start failing
>> > some tests, e.g. 5533 5404 5405.
>> 
>> Ah ok I did only test on master, will look into those.
>
> Ok I had a look into these and the reason t5533 fails is because on pu
> --recurse-submodules is enabled by default and I missed the case when
> overwriting a ref. In that case we get the sha1 from the remote side as
> old. So we could catch that and fall back to all revisions there, but...
>
> ... tl;dr: The solution to use the old revisions from the remote side
> was too simple and does not make matters better but actually worse for
> some typical usecases. Its only in the last patch.

You may not even have the old one in your copy of the remote
repository if you haven't fetched from them and you are forcing your
push.  "rev-list <new ones> --not <old ones>" may fail in such a case,
not producing the list of new commits.  You'd need to exclude old ones
you learned over the wire that you do not yet have locally.

> The most exact solution would be to use all actual remote refs available
> (not sure if we have them at this point in the process?) another
> solution would be to still append the --remotes=<remotename> option as a
> fallback to reduce the revisions.

I'd say --remotes=<remotename> is the least problematic thing to do.

