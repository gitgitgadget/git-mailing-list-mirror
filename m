Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A67DDC433ED
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7ADDB613C5
	for <git@archiver.kernel.org>; Fri, 16 Apr 2021 19:50:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243897AbhDPTuf (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Apr 2021 15:50:35 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58343 "EHLO
        pb-smtp2.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbhDPTua (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Apr 2021 15:50:30 -0400
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id D44CBC893F;
        Fri, 16 Apr 2021 15:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=T+gprRYOhh+ZG6zldlBufg8Txvw=; b=vPi4hj
        7zZfXqTwqBdL5hfxjC5cZOSjC6cvTvEg0fnFTu/qboRIsP/d8VE+nJE+Y2YfOlm3
        ssVhkv9IX1z17q9l59GFmsU/vZiPBl1/pgF/zRd9dF9pFEdNA+gYChuCzCw/ers/
        CZG4oDdt/qCEMGgh3cdRkZv/qdk0QWa5ZveZM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=uSXqcrEWH9vqhxZrC3TY6OlIL2BhG3Sq
        zoIj7yaekLhyUNvb8mZktTZJrhM1jKehYI1Lp5rxrNkCZItGTEIttC1De+cDZa0v
        xsYzjhJkNsvvD8aYKHHkVZM1Wq295oyV3JzjxEDTbGdYF6xlWL6ocENmXiKScKsJ
        BXNuiXZLfCY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id B8604C893C;
        Fri, 16 Apr 2021 15:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 10CEBC893B;
        Fri, 16 Apr 2021 15:50:04 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     git@vger.kernel.org, Raxel Gutierrez <raxelgutierrez09@gmail.com>,
        mricon@kernel.org, patchwork@lists.ozlabs.org,
        Taylor Blau <me@ttaylorr.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        ZheNing Hu <adlternative@gmail.com>
Subject: Re: Pain points in Git's patch flow
References: <YHaIBvl6Mf7ztJB3@google.com>
Date:   Fri, 16 Apr 2021 12:50:03 -0700
In-Reply-To: <YHaIBvl6Mf7ztJB3@google.com> (Jonathan Nieder's message of "Tue,
        13 Apr 2021 23:13:26 -0700")
Message-ID: <xmqqfszqko0k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: EFFFF452-9EEC-11EB-A701-74DE23BA3BAF-77302942!pb-smtp2.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jonathan Nieder <jrnieder@gmail.com> writes:

>  3. Do you think patchwork goes in a direction that is likely to help
>     with these?

So here is a real-life example.

Let's say somebody is looking at a "gentle ping" [*1*]

znh> The patch seems to have fallen into the crack.
zhn> Jeff and Junio, willing to help?

How would we figure out what happened to the patch today without
visiting patchwork would be:

 1. Visit the message at lore.kernel.org/git/ [*1*]

 2. Notice that it is a response to a message, and click the link to
    be taken to [*2*]

 3. Notice that nobody commented on the patch.

 4. Type "f:zhening ref-filter" to the search box and search, with
    suspicion that this was an updated version of something.

 5. Click one of them in the result [*3*]

 6. This time, we can tell that this seemed to have had two earlier
    iterations, and after reading the discussion through, the last
    one changed the course in a major way.  Not just a new helper
    introduced in the earlier rounds has gone away, but an existing
    helper got removed.

 7. All comments in the discussion for the earlier two rounds can be
    read as supporting the new direction the latest round takes.

 8. The fact remains that even if the direction has been endorsed
    (see 7. above) nobody took a look at the implementation for the
    latest round.

 9. Make the final verdict.

I use my newsreader to do pretty much the equivalent of the above
without hitting https://lore.kernel.org/git/ but the above is
written to use the web interface, in order to make it reproducible
more easily by anybody on the list.

Now, how can patchwork improve the above reviewer experience, out
of the box and possibly with new helpe rools around it?

I can see #3 would immediately become obvious, and I hope #4-#5
would become unnecessary.

Anything else?

At steps #6 and #7, there is human judgment involved that may not be
automatable, but would there be some mechanism to make it easy to
help these steps if the user visits patchwork (instead of staying
in my newsreader or web interface to the lore archive)?

I am of course not expecting to automate step #9 ;-)  It would be
nice though.

Thanks.


[References]

*1* https://lore.kernel.org/git/CAOLTT8Tis5Yjg8UR0c-i0BnqiFQvLXvDgxUQJ-WcP6jjQPu9cQ@mail.gmail.com/

*2* https://lore.kernel.org/git/pull.928.git.1617975348494.gitgitgadget@gmail.com/

*3* https://lore.kernel.org/git/pull.927.v2.git.1617809209164.gitgitgadget@gmail.com/
