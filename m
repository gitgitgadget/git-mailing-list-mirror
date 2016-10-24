Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 19CF720193
	for <e@80x24.org>; Mon, 24 Oct 2016 20:00:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S941088AbcJXUAf (ORCPT <rfc822;e@80x24.org>);
        Mon, 24 Oct 2016 16:00:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:59275 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S933409AbcJXUAf (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2016 16:00:35 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 486D04748A;
        Mon, 24 Oct 2016 16:00:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=+mSZWAWNiXDg81ywbdT4A2daZZs=; b=fKnFBj61Av9aJPSmWyjx
        wLRXSqnTrIib8Y1hw5m0qMG0cVRy08cBhTgWRAJFn2A48TbGuwq3zZmul3VM/79q
        dNkQ/ZqCyz0qwBKkUMmmmPtBM91sO4gKcKu60loHVOL9utRUOkT8Xwgy9wn5NLFc
        H2XrSSbzd2Sg/sXBwV0vYR8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         q=dns; s=sasl; b=USJ1tq3XpsT4ZccuJyGdYoq18Ir5VwbrUzyoTb2+4+oV+s
        aBR4ge+KiQ6DUONgHZnoa2m/4ikbpoiaOTJNi0ttCu191cHxY3WcytRA5vVyi3jk
        qHVig7Ha8/N18iYTtaPFJihVtuPcE+SUmfVnboCs+rao391YRTsBmeE7qfBF0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 3E43347488;
        Mon, 24 Oct 2016 16:00:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B1E9547487;
        Mon, 24 Oct 2016 16:00:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org,
        Jakub =?utf-8?Q?Nar=C4=99bski?= <jnareb@gmail.com>,
        Johannes Sixt <j6t@kdbg.org>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: Re: [PATCH v5 00/27] Prepare the sequencer for the upcoming rebase -i patches
References: <cover.1476450940.git.johannes.schindelin@gmx.de>
        <cover.1477052405.git.johannes.schindelin@gmx.de>
        <xmqqinslbl5t.fsf@gitster.mtv.corp.google.com>
        <alpine.DEB.2.20.1610231135270.3264@virtualbox>
Date:   Mon, 24 Oct 2016 13:00:31 -0700
Message-ID: <xmqq8ttd4iw0.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 85E8275A-9A24-11E6-BA88-3AB77A1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

>> I still do not understand (note that I am not saying "I do not
>> accept"--acceptance or rejection happens after an understandable
>> explanation is given, and "do not understand" means no such
>> explanation has been given yet) your justification behind adding a
>> technical debt to reimplement the author-script parser and not
>> sharing it with "git am" in 13/27.
>
> At this point, I am most of all reluctant to introduce such a huge change,
> which surely would introduce a regression.

That is a perfectly sensible and honest answer that I can
understand, accept and even support.

You've been working on the series for several months, running with
these dozen or so lines of code, and replacing it with another dozen
or so lines of code would require you to make sure the result is
actually doing the same thing for the remainder of your series.  And
I agree that is an unnecessary risk in order to ship a working code.
The code being battle tested counts.

I cared on this point mostly because I wanted to make sure that
people later can find out why there are two functions that ought to
be doing the same thing.  

If there were a technical reason why these two must stay to be
different implementations that are potentially doing different
things, I want to see that reason described, so that those who come
later and want to refactor the helper functions into one later will
know why they are separate in the first place.

If on the other hand there isn't any technical reason why they must
stay to be different, and they are different mostly because you
happened to have written a different one in 13/27 and have been
running with it, that is also a good thing for them to know.

