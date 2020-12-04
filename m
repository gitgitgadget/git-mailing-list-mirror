Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFBACC433FE
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8685B22510
	for <git@archiver.kernel.org>; Fri,  4 Dec 2020 02:06:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbgLDCGx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 3 Dec 2020 21:06:53 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:55809 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgLDCGx (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Dec 2020 21:06:53 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 2F6A39E92E;
        Thu,  3 Dec 2020 21:06:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=XmucXdUW0Z6KLZuF+CYFKCUhaM4=; b=RCcEF8
        GgFLcKkM8wbNEZS2n/3CaF+1cKXievkGuzH78Ad7N83tRkcpMDIRtChXwIAdNsMB
        lNBXEANV8oDxp/bLdj07ZnOPRr+77u/NI3kH0qs9XX5uqWNjl7li3hj7z99j4Z2w
        hFhkdYWsDRjAI4wP7Jj6d5lW8GqudVDIy/dbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=kEd7Yj7KfxKnngf0WWfUJFkMcpF6XAWB
        56kjlw2AEl7gypk2iwxnx6Bhz7XSufESdjwjoEdg5uyL0U83kkB6inIvsg3POAt1
        w4i5oSEq85gLLeh8B5J6zwBIhs7umtw0bLw95ItRUDmGbH63dz9Z4clC2e6Fx7LB
        9JvMpQa0Eh4=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1E43B9E92D;
        Thu,  3 Dec 2020 21:06:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5BFF99E92C;
        Thu,  3 Dec 2020 21:06:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git <git@vger.kernel.org>, "Raymond E. Pasco" <ray@ameretat.dev>,
        Jeff King <peff@peff.net>,
        =?utf-8?Q?V=C3=ADt?= Ondruch <vondruch@redhat.com>,
        Theodore Tso <tytso@mit.edu>
Subject: Re: [RFC 2/2] pull: default pull.ff to "only" when pull.rebase is
 not set either
References: <20201125020931.248427-1-alexhenrie24@gmail.com>
        <20201125020931.248427-2-alexhenrie24@gmail.com>
        <xmqqmtyviq9e.fsf@gitster.c.googlers.com>
        <CAMP44s1Hwun+P=j5BBbVUT-ACS4hJCyRCJT-=6WvwK913fXq7g@mail.gmail.com>
        <xmqq7dpyix1d.fsf@gitster.c.googlers.com>
        <xmqqmtyuhemi.fsf@gitster.c.googlers.com>
Date:   Thu, 03 Dec 2020 18:06:07 -0800
In-Reply-To: <xmqqmtyuhemi.fsf@gitster.c.googlers.com> (Junio C. Hamano's
        message of "Thu, 03 Dec 2020 11:29:57 -0800")
Message-ID: <xmqqpn3qfhps.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4604D196-35D5-11EB-8A44-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>>> That would require changing the semantics of --ff-only, so that "git
>>> pull --no-rebase --ff-only" doesn't make sense (as --ff-only is
>>> overridden by --no-rebase).
>>
>> I do not think such a conclusion follows from "we do not want to use
>> the 'by default force the --ff-only' when the user chooses between
>> merge and rebase".  Specifically, I do not agree with "as --ff-only
>> is overridden" in your statement.
>
> Ah, sorry, I mis-read your three lines above.
> ...
> And if we introduce a third-way, i.e. "we do not handle the case
> where you have your own development at all, this is only to maintain
> pristine copy from your upstream", and repurpose "--ff-only" for
> that purpose, yes, what you said above does make sense.  At that
> point, there is no reason to disagree with "as --ff-only is
> overridden" part of your statement---in your new world, "--ff-only"
> is redesigned to act that way.

Just to avoid misunderstanding, I only meant to say that the first
three lines I quoted is internally consistent (unlike the message I
was responding to, in which I said "I disagree---the conclusion does
not follow").  It no way means I think such a re-definition of what
"--ff-only" means is a great design.

What we want to see can be done without such backward incompatible
changes, e.g. declaring the combination of "--ff-only" and
"--[no-]rebase" incompatible and/or the last one wins, I would say,
and I suspect Alex's RFC was an attempt to make the first step in
that direction.

What is most missing in the current system is a fix for the way in
which "--rebase" interacts with "--ff-only".  Immediately after
fetching, if our current branch is not a subset of what we fetched
from the other side, the command should die.  Otherwise, it should
just rebase what we have (which is nothing) on top of the tip of the
history of the other side (which is to fast-forward our tip and the
working tree to their tip).  

Another thing we would want to change is to make the "you must
choose between rebase and merge" trigger a lot more lazily.  If our
side does not have our own development and their history is a
descendent of what we have, the user shouldn't have to choose.  Only
when the history they have does not fast-forward, we have to abort
giving the "you must choose between the two" warning message.

When the user tells us to do rebase or merge, nothing (except that
"--ff-only" should prevent the rebase from going forward) should
have to be changed.
