Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD20C0015E
	for <git@archiver.kernel.org>; Fri, 28 Jul 2023 15:10:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbjG1PKu (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 28 Jul 2023 11:10:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjG1PKt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Jul 2023 11:10:49 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E551610CB
        for <git@vger.kernel.org>; Fri, 28 Jul 2023 08:10:47 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 4758C3760F;
        Fri, 28 Jul 2023 11:10:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=JAjfF9dSwe9nvLsTfmgq6zAL9rU+/2DPdR857l
        EM6Io=; b=mi60GjCFxXv2gh8k9PsPHai6AEN6h6CQjvPjNkqZ76JCKYziNC1Tfy
        xNXzC7Ru3I2LwV6vLKoL07y7jXRaMZUYhWT0HZTxxo3Xq2FHJ59pHUsIUcpqRl74
        9zpLMPnoawKV+3Tzxjm8bx2gVcVcASVdBqd3ItWE57DcF3Wv9FNn8=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 3F4563760D;
        Fri, 28 Jul 2023 11:10:47 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.168.215.201])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id BB8B53760C;
        Fri, 28 Jul 2023 11:10:43 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Linus Arver <linusa@google.com>,
        Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        Kristoffer Haugsbakk <code@khaugsbakk.name>
Subject: Re: [PATCH v2] sequencer: beautify subject of reverts of reverts
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
        <3f5e4116-54e6-9753-f925-ed4a9f6e3518@gmail.com>
        <ZGSlqAPwaLhgWm6v@ugly>
        <2d416834-ef3e-01a2-6be0-9e88bc0de25e@gmail.com>
        <ZGUIqBU0+Vr5LSBF@ugly>
        <10523968-0f02-f483-69c4-24e62e839f70@gmail.com>
        <xmqqmt21txid.fsf@gitster.g> <owly7cqkfvyu.fsf@fine.c.googlers.com>
        <ZMOOQTMk2wFwtSfa@ugly>
Date:   Fri, 28 Jul 2023 08:10:42 -0700
In-Reply-To: <ZMOOQTMk2wFwtSfa@ugly> (Oswald Buddenhagen's message of "Fri, 28
        Jul 2023 11:45:37 +0200")
Message-ID: <xmqqpm4c5ax9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EC2D7672-2D58-11EE-AF34-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:

> On Thu, Jul 27, 2023 at 10:26:01PM -0700, Linus Arver wrote:
>>How about introducing a suffix (+ or -) after the word "Revert" to
>>indicate the application/inclusion (+) or removal (-) of a commit?
>>
> i think that falls squarely into the "too nerdy" category, like the
> Revert^n proposal does.

True, but instead of dismissing it (or ^n) as "too nerdy", let's
compare it with what we are trying to achieve and see why we feel it
is not desirable.  I think we are trying to find a good balance
between aesthetics and usefulness.  The former should take lower
precedence, as it would be more subjective between the two.

The usefulness of the message comes from its information content.
What do we want to read out of these messages?  I think we want
a title that immediately lets us know three things:

 (1) What the original patch was about.  
 (2) What the final state is.
 (3) How involved was the road to get to the final state has been.

As to (1), we are not proposing to lose what comes "Revert", so this
information is not lost under any proposal we have seen so far in
the discussion.

As to (2), with the current "Revert" -> "Revert Revert" -> "Revert
Revert Revert" -> ..., you have to count, which is cumbersome and
does not give you an immediate access to that information.  With
"Revert^n", you'd see if n is even or odd to determine, which is
much better than the status quo, but it takes practice to interpret.
With "Revert" -> "Reapply" -> "Revert Reapply" -> "Reapply Reapply"
-> ..., the first word would give you the final state immediately.

We want to know (3), because between a change whose revert was
reverted and a change that hasn't been involved in any revert, there
may be no difference in the end result, the former is likely to be
trickier and merits more careful inspection than the latter.  With
"Revert^n", we read how large the number n is to find the
information.  With the current "the Revert repeated number of times"
or your "a pair of frontmost Reverts become one Reapply", the length
of the Revert/Reapply prefix conveys this information, but this is
associated with the cost of pushing the original title further to
the right and hard to read/find.  Note that, while the number of
times revert-reapply sequence took place is a useful piece of
information, the exact number may not be all that important.

And from the above discussion, I wonder if the following would be a
good place to stop:

 - The first revert is as before:         Revert "original title"
 - A revert of a revert becomes:          Reapply "original title"
 - A revert of a reapply becomes:         Revert Reapply "original title"
 - A revert of "Revert Reapply" becomes:  Reapply Reapply "original title"
 - A revert of "Reapply Reapply" becomes: Revert Reapply "original title"

In other words, we accept the fact that wedo not need exact number
of times reversions were done, and use that to simplify the output
to make sure we will not spend more than two words in the front of
the title.  That would help to keep the original title visible,
while still allowing us to distinguish the ones that was reverted up
to four times (and "Revert Reapply" and "Reapply Reapply" only tell
us "final state is to (discard|accept) the original but it took us
_many_ times", without saying exactly how many).
