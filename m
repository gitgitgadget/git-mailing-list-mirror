Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 642E81F4DD
	for <e@80x24.org>; Tue,  5 Sep 2017 10:03:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751007AbdIEKDR (ORCPT <rfc822;e@80x24.org>);
        Tue, 5 Sep 2017 06:03:17 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:56474 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1750814AbdIEKDO (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Sep 2017 06:03:14 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id EB023AAF8A;
        Tue,  5 Sep 2017 06:03:12 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=N1vrJMqd+9IbsF54hK0UURXRc6Q=; b=HJmbILbclZGfAqEspAQt
        w6cjSHp7sOXdQqJfTG2BKEEo5o7T6/Fhq7i42BI4alhbTMqLiD5ji5s1pa0sXLTV
        o1pIkc76lgTHVatcnPYTeUu2sKdqDxfWT4Dw2Za9NDFe40KV5JL1tUgILn/zxqOt
        f/6xl+7l2nycKWFb0Go8vSQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=ZtoYqs+S02GknhT1A6d88t12V3snnhJGJ5oNAWOVYhnySQ
        vhz9Xp06SXu9ZHwOA37zXqW8cl1QaxOQAn4/w2E8OlMsJIFArJBW4e9/Z3FoMHNM
        CNxOpWSwPVojzz9u0QmPHLOSlUFy9goTRalmwPGo6cCVRUSEwnxOgh1uSaeIg=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E3735AAF89;
        Tue,  5 Sep 2017 06:03:12 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 4AFF2AAF88;
        Tue,  5 Sep 2017 06:03:12 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Stefan Beller <sbeller@google.com>,
        Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
        Lars Schneider <larsxschneider@gmail.com>,
        Git Users <git@vger.kernel.org>
Subject: Re: [PATCH] pkt-line: re-'static'-ify buffer in packet_write_fmt_1()
References: <20170827073732.546-1-martin.agren@gmail.com>
        <9E4606AF-8814-42DE-8D3A-3A15C1B1723C@gmail.com>
        <CAN0heSraJFbbog7FKpAtmob9W6_5-AS1StZFVW6xUwMDWfMYgg@mail.gmail.com>
        <179AC8FB-5991-4200-9AAC-2F8D0914D5F9@gmail.com>
        <20170827232338.hm5t7t7c2xaa3zyl@sigill.intra.peff.net>
        <CAN0heSoUqcOqVspZkbPahWQdtVpSdtSZoCFWu0ZQJfN3F0mD2g@mail.gmail.com>
        <CAGZ79ka3+T+TgakKDcHSmoc83mOdSDgoN=S=P5PtaYygo0nGWA@mail.gmail.com>
        <20170828175855.vs2s7lpxxhwlfhdi@sigill.intra.peff.net>
Date:   Tue, 05 Sep 2017 19:03:11 +0900
Message-ID: <xmqqy3ptbgyo.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 6D4A1802-9221-11E7-85D5-FE4B1A68708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Mon, Aug 28, 2017 at 10:52:51AM -0700, Stefan Beller wrote:
>
>> >> I'm curious, too. I don't think the valgrind setup in our test suite is
>> >> great for finding leaks right now.
>> 
>> This discussion comes up every once in a while,
>> the last time I was involved in this discussion I proposed
>> to have an "optional_free(void *)", which only frees memory
>> in e.g. the developer build/debug build.
>> 
>> That way we can have a strict "no leaks in developer build"
>> policy (as it is easy to detect!), but it doesn't slow down the
>> widely distributed version of Git.
>
> Personally I am not that worried about slowing down program-exit with
> some free() calls (though I would reserve judgement to see how slow it
> actually is).
>
> It is that I do not want to deal with the complexity and maintenance
> headache of dropping values which are program-lifetime caches. If we
> introduce a free-all-object-structs function, now everybody needs to
> remember to call it (even if they didn't realize they were allocating
> object structs in the first place, as it may have happened under the
> hood of a sub-function). And we have to wonder what might happen when
> somebody calls that function _not_ at program exit.

In addition, the code earlier may have a variable point at a
compiled in literal string or an allocated string depending on the
situation and it would have been perfectly fine to rely on exit() to
clean it up.  "We free all ourselves before exit()" would mean these
codepaths now need to be updated to keep track of what needs to be
and what must not be freed, or just duplicate everything to make the
life of that "free everything" part easier, which somehow feels like
a tail wagging a dog.

> If we can declare "reachable things are not leaks" (and certainly
> valgrind is aware of that distinction), then all of that goes away. And
> you're just left with local variables in main() (or our cmd_*
> equivalents) that appear as leaks. And then we can solve that either by
> freeing them, or just calling them program-lifetime and telling the
> compiler that it's so by declaring them "static".

Yup.
