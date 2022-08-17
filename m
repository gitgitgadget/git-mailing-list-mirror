Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A657C32772
	for <git@archiver.kernel.org>; Wed, 17 Aug 2022 18:57:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237461AbiHQS5O (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 17 Aug 2022 14:57:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238328AbiHQS5F (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 17 Aug 2022 14:57:05 -0400
Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2551695E5B
        for <git@vger.kernel.org>; Wed, 17 Aug 2022 11:57:03 -0700 (PDT)
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1F43612DA36;
        Wed, 17 Aug 2022 14:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:message-id:mime-version:content-type;
         s=sasl; bh=O0Qn2qf/+LA1ulY24wDXC5kci2Tx8/24fzGe3lh2OI4=; b=MhrS
        5S1AfJ2ScoImkfWc1YeYpuObev8Jy59QR3ZCGswkpsfhT+mMyamvXW8z8IvlH/3+
        cVawr1WiAJkImUshFVb7zSP5dQUTfHfo9gWumrASdMmIeyw95lscV/qWHihvgXe6
        WJPy4Szsy6YuPzlpWa844scsY9ZF0OMZTjkmGx8=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0F0E912DA35;
        Wed, 17 Aug 2022 14:57:02 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.5.33])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3845A12DA31;
        Wed, 17 Aug 2022 14:57:01 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Git Mailing List <git@vger.kernel.org>
Subject: Re: js/bisect-in-c, was Re: What's cooking in git.git (Aug 2022,
 #05; Mon, 15)
References: <xmqq5yityzcu.fsf@gitster.g>
        <p053rrpq-17q7-pnrs-3794-o04ro1445s5s@tzk.qr>
        <CABPp-BFAERLt_z-D=7gbXWVA9JgsqTP_2iW9BLe5S=YbsQ1V6w@mail.gmail.com>
Date:   Wed, 17 Aug 2022 11:57:00 -0700
Message-ID: <xmqqtu6avgub.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 60769410-1E5E-11ED-B008-5E84C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Elijah Newren <newren@gmail.com> writes:

>> >  Expecting a (hopefully final) reroll.
>> ...
>
> Could I vote for just merging it down, as-is?  As far as I can tell,
> ... Further, such changes, while likely
> desirable for consistency among Git commands, would likely move us
> away from "faithful conversion from shell to C", and thus is likely
> better to be done as a separate step on top of the existing series
> anyway[4].

If this were a faithful conversion, yes, merging it right now can be
one good approach; add a faithful but not very C-like convesion
first and then make it "more like C code" later.

I however got an impression from the review discussion that it
subtly changes behaviour (IIRC, one thing pointed out was that exit
codes are now different from the original---there may or may not be
others, but my impression was they were all minor like the "exit
code" one).

My "hopefully final" comment was not about a big rearchitecting
change like use of parse-options API but about adjusting such minor
behaviour diversion so that we can say "This may not be very C-like,
and does not use much of our established API, but it is a fairly
faithful bug-to-bug compatible translation.  Let's take it and make
it more like C incrementally".  And of course, what was implied in
"hopefully final" was that such adjustments would be tiny, trivial
and can be done without much controversy.  After all, I was aware
that the series was otherwise reviewed and received extensive
comments (sorry, I forgot that it was by you).

Thanks.
