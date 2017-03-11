Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 825ED201C2
	for <e@80x24.org>; Sat, 11 Mar 2017 03:17:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755512AbdCKDR1 (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Mar 2017 22:17:27 -0500
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58132 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1755375AbdCKDR0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Mar 2017 22:17:26 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 95D096CBCE;
        Fri, 10 Mar 2017 22:17:24 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=sQLM2BXbwMyu
        tn8MRkP2edOo38M=; b=ncNAoIukgWs42sJqirNsaFmcvtdK51RJBMKcxyALQ3mI
        qVpBK1O072ROvlS4WBZiI/LPvseUlPGecNVEjLk1LQGhPDmUbLtoti9RYk1DBZGt
        NyiI2kP3DjOSWa4BFOLzOZxKvw6bsB/c/jMR0SW3zZu+ZbR8stONZkrmU4AtLaE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=yXYN2r
        g2nEt2dw+95qsj7whaGYc1IDu/4w3esvZFI80Rjp/wm1DSHAR8RXo71igmPhMUlp
        +LHbnbcxtQwJ+oJSYBQkuwktRarlsrCf5yox1wU8kU7RKvuyhAXjpEScUUnwhjt4
        p52SdKiLZZBytyeg4oK/EmpbHBYi1P3GF8Ghk=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8F5286CBCD;
        Fri, 10 Mar 2017 22:17:24 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id EAA5B6CBCC;
        Fri, 10 Mar 2017 22:17:23 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Devin Lehmacher <djl329@cornell.edu>
Cc:     Noam Postavsky <npostavs@users.sourceforge.net>,
        Jonathan Nieder <jrnieder@gmail.com>, <git@vger.kernel.org>
Subject: Re: [GSoC] Move ~/.git-credential-cache to ~/.cache/git
References: <8BE1A361-32BB-4164-AD54-949555855C52@cornell.edu>
        <20170311002615.GG26789@aiede.mtv.corp.google.com>
        <CAM-tV-9DV=XOVSehEfd2LiWYdubhwV7fC8uRnKqmFT_aTQ1OKg@mail.gmail.com>
        <3B988055-D8A3-43B7-BF5F-C43479EF7BEB@cornell.edu>
Date:   Fri, 10 Mar 2017 19:17:04 -0800
In-Reply-To: <3B988055-D8A3-43B7-BF5F-C43479EF7BEB@cornell.edu> (Devin
        Lehmacher's message of "Fri, 10 Mar 2017 21:27:23 -0500")
Message-ID: <xmqqinngwlhr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1.91 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 3F03BF74-0609-11E7-ADF2-FC50AE2156B6-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Devin Lehmacher <djl329@cornell.edu> writes:

> If I=E2=80=99m not mistaken magit won=E2=80=99t stop working with the c=
hanged
> location since it will just spawn an new instance of the
> daemon. The only downside would be it wouldn=E2=80=99t get credentials
> that were cached in the default socket.

I am not quite sure how you can say "only" in that sentence.  Isn't
the whole point of socket based daemon interface to allow starting
the daemon so that it can keep using it?

Somebody upthread mentioned checking the current location (and use
it if there is) and then use the new location, which I found a more
reasonable approach.

Assuming that it is sensible to move it from ~/.git-credential-cache
to ~/.cache/git/ in the first place, that is.  If both are equally
acceptable places, then perhaps a configuration that allows those
who want to have things in ~/.config/git/ to specify where to have
the thing (and those without such a custom configuration will keep
using the current location) may be more appropriate.
