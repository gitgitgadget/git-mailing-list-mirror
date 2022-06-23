Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 660E9C43334
	for <git@archiver.kernel.org>; Thu, 23 Jun 2022 23:25:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbiFWXZ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 23 Jun 2022 19:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230118AbiFWXZz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 23 Jun 2022 19:25:55 -0400
Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619074D9E4
        for <git@vger.kernel.org>; Thu, 23 Jun 2022 16:25:54 -0700 (PDT)
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 8B0041401CE;
        Thu, 23 Jun 2022 19:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=lkktMbGz2WDk
        mqQPkT2lArJB1ytSj0jVSS/F4LBgIi4=; b=lUqUrY2YIBjbqfPOlgJke4L+2NgM
        kDmvlwNVrLYXmFQ5kCTVueEBuZD95lDbXGc6133WkzrKZ8ozJx8IAFWCe6PLp/Bz
        LrznOC+Qcgp6NTPcgyhqQxB5AEDLMOyrQ5On/IF4QO5UN+PYA9AmVwSIPYjA/ev8
        I0fMHDwV7ukZbSQ=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 7E66D1401CC;
        Thu, 23 Jun 2022 19:25:53 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.82.80.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id E10E81401C9;
        Thu, 23 Jun 2022 19:25:52 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Jeff King <peff@peff.net>,
        SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder.dev@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH v2 0/7] gitweb: fix "make" not including "gitweb"
 without NOOP run slowdowns
References: <220527.861qwf489s.gmgdl@evledraar.gmail.com>
        <cover-v2-0.7-00000000000-20220531T173805Z-avarab@gmail.com>
        <xmqqa6ap8z55.fsf@gitster.g> <20220620083202.GB1689@szeder.dev>
        <YrFphmtLuHVkI7yr@coredump.intra.peff.net>
        <220622.86r13hkp2c.gmgdl@evledraar.gmail.com>
        <xmqq7d587lqx.fsf@gitster.g>
        <220623.865ykrll0j.gmgdl@evledraar.gmail.com>
Date:   Thu, 23 Jun 2022 16:25:51 -0700
In-Reply-To: <220623.865ykrll0j.gmgdl@evledraar.gmail.com> (=?utf-8?B?IsOG?=
 =?utf-8?B?dmFyIEFybmZqw7Zyw7A=?=
        Bjarmason"'s message of "Thu, 23 Jun 2022 12:29:58 +0200")
Message-ID: <xmqq7d57x8qo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: D2FADA84-F34B-11EC-B924-CB998F0A682E-77302942!pb-smtp2.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

>> We could easily add "cd .. && make gitweb" to gitweb/Makefile with
>> the same "minor hassle" but that needs to be done just once, instead
>> of having to be done once per packager, so I am not sure the above
>> argues for a good tradeoff.
>
> True, but I think critically in this case we've never documented that
> you should be running gitweb/Makefile directly. I.e. the gitweb/INSTALL
> has always documented and assumed that you run these from the top-level=
.

Well, I do not think Makefiles document much of their targets in
general.  If its first/default target has a reasonable name, like
"all", people expect "cd there && make all" would do the right
thing.

So I do not think "we never documented" is a good excuse.  What the
current users have been doing and are expecting to keep working is
what counts.  If they are used to see "cd gitweb && make" working,
perhaps instead of giving an unfriendly $(error do not run) at the
beginning of gitweb/Makefile that is designed to trigger only when
they did that (instead of running 'make gitweb' from the top), it
would be trivial to have the rule to "cd .. && $(MAKE) gitweb"
there, no?



