Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E9D192036D
	for <e@80x24.org>; Sun, 26 Nov 2017 09:36:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752083AbdKZJgA (ORCPT <rfc822;e@80x24.org>);
        Sun, 26 Nov 2017 04:36:00 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:51100 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1752064AbdKZJf7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Nov 2017 04:35:59 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 193CFA3B95;
        Sun, 26 Nov 2017 04:35:58 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=ljo8/Jb3JL2G6p0dfu54+6HFzPY=; b=hDQPJH
        Zby31/f31HzCnbhABvsW3GjTYkWOVvHWMMKLyYbKoeyLTLW4w1vtf0cD6UcTw6kS
        UExOoCA7PFmIgFA6yGutKgby8F5LTswyZOnOCEl6LUf1RGTwLiqY28GEWw/wzniw
        B7W4yUYBQXbRtJuLQ4oCYhToJxyVf8EaPCGoo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=Ws4JQUSEsQp109Lf09w8Gwq4ysGFWZ8+
        CdqwowyksEl4lRvi8ZbyzUH/Of5sdYDSyDwI/wIQb4UFzHuUfQjNxlVDivZ08Eed
        a0ZNqHgfwkyrBg8SCdeY2NtG8kPx+/ofT1TIsHFKwhGH9edk1cKC3bcy9nHrRqql
        ZliXjaJnz28=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 110CBA3B93;
        Sun, 26 Nov 2017 04:35:58 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 739EBA3B92;
        Sun, 26 Nov 2017 04:35:57 -0500 (EST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Nathan Neulinger <nneul@neulinger.org>,
        Santiago Torres <santiago@nyu.edu>, git@vger.kernel.org,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: git status always modifies index?
References: <a039d139-dba5-683e-afbf-4044cd32ab1d@neulinger.org>
        <20171122153028.olssotkcf3dd6ron@LykOS.localdomain>
        <5050d779-2981-6f06-49f7-0ecb4efb25b8@neulinger.org>
        <20171122161014.djkdygmclk227xmq@LykOS.localdomain>
        <dfbf4af3-e87c-bdcb-7544-685572925a50@neulinger.org>
        <20171122202720.GD11671@aiede.mtv.corp.google.com>
        <20171122211729.GA2854@sigill>
        <20171122215635.GE11671@aiede.mtv.corp.google.com>
        <20171122220627.GE2854@sigill>
        <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com>
Date:   Sun, 26 Nov 2017 18:35:56 +0900
In-Reply-To: <xmqqwp2diuki.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
        message of "Sun, 26 Nov 2017 12:32:13 +0900")
Message-ID: <xmqq7eudidqb.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 34C3C3F0-D28D-11E7-9305-8EF31968708C-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Jeff King <peff@peff.net> writes:
>
>> What I was trying to get at is that naming it "status --no-lock-index"
>> would not be the same thing (even though with the current implementation
>> it would behave the same). IOW, can we improve the documentation of
>> "status" to point to make it easier to discover this use case.
>
> Yeah, the name is unfortunate. 
>
> What the end user really wants to see, I suspect, is a "--read-only"
> option that applies to any filesystem entity and to any command, in
> the context of this thread, and also in the original discussion that
> led to the introduction of that option.  
>
> While I think the variable losing "index" from its name was a vast
> improvement relative to "--no-lock-index", simply because it
> expresses what we do a bit closer to "do not just do things without
> modifying anything my repository", it did not go far enough.

Yuck, the last sentence was garbled.  What I meant as the ideal
"read-only" was "do things without modifying anything in my
repository".

And to avoid any misunderstanding, what I mean by "it did not go far
enough" is *NOT* this:

    We added a narrow feature and gave it a narrow name.  Instead we
    should have added a "--read-only" feature, which this change may
    be a small part of, and waited releasing the whole thing until
    it is reasonably complete.

By going far enough, I was wondering if we should have done
something that we historically did not do.  An "aspirational"
feature that is incrementally released with a known bug and that
will give users what they want in the larger picture when completed.

IOW, we could have made this "git --read-only <cmd>", that is
explained initially as "tell Git not to modify repository when it
does not have to (e.g. avoid opportunistic update)" and perhaps
later as "tell Git not to modify anything in the repository--if it
absolutely has to (e.g. "git --read-only commit" is impossible to
complete without modifying anything in the repository), error out
instead".  And with a known-bug section to clearly state that this
feature is not something we vetted every codepath to ensure the
read-only operation, but is still a work in progress.

After all, "status" does not have to stay to be the only command
with opportunistic modification (in the current implementation, it
does "update-index --refresh" to update the index).  And the index
does not have to stay to be the only thing that is opportunistically
modified (e.g. "git diff --cached" could not just opportunistically
update the index, but also it could be taught to write out tree
objects for intermediate directories when it does its cache-tree
refresh, which would help the diff-index algorithm quite a bit in
the performance department).  

Having a large picture option like "--read-only" instead of ending
up with dozens of "we implemented a knob to tweak only this little
piece, and here is an option to trigger it" would help users in the
long run, but we traditionally did not do so because we tend to
avoid shipping "incomplete" features, but being perfectionist with
such a large undertaking can stall topics with feature bloat.  In a
case like this, however, I suspect that an aspirational feature that
starts small, promises little and can be extended over time may be a
good way to move forward.



