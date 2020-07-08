Return-Path: <SRS0=LMRs=AT=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1556DC433E1
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5ADD20786
	for <git@archiver.kernel.org>; Wed,  8 Jul 2020 15:42:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="PJG1Aygh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730310AbgGHPmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:42:55 -0400
Received: from pb-smtp20.pobox.com ([173.228.157.52]:63642 "EHLO
        pb-smtp20.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730144AbgGHPmy (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Jul 2020 11:42:54 -0400
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id EDCD4DC48D;
        Wed,  8 Jul 2020 11:42:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=leOhGxwMAA6y9u8KIcTKG8bBvN0=; b=PJG1Ay
        gh+QjiOoRLs+EFDcvP7nqRH55s1VEZfqC3EzHanA07FaQeb5Nid5g80sZp8L8/9/
        1UKlbude5C+ZoRjFx70r5lQIg1nklH3N6EhS88yUA4H3WkpMPpqy2WKkHtz7+i0p
        KT8EVU1a8X+yjiRrayMj4LDcYOxu4wfgPsD+o=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=gyA+UbvwnNIk2TCYmKSqe8sXJDCWuJed
        GKlnmsgjxj5mDD7uBsSC/I13L3yqYn1HRanbN8ffTdZJMqsgAo2lu+7JZLYcu1kH
        vOXQ7aShkF6knQZGvEtScVUIWScu3+cFUVlKW6BdlBAzkpfmZVKs0p3x97MIoYVD
        FOrM+4wJzP8=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp20.pobox.com (Postfix) with ESMTP id E5F27DC48C;
        Wed,  8 Jul 2020 11:42:51 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [35.231.104.69])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 863E0DC48A;
        Wed,  8 Jul 2020 11:42:48 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH/RFC] config: default to protocol v2
References: <20200707053805.GB784740@google.com>
        <20200708045008.GC2303891@coredump.intra.peff.net>
Date:   Wed, 08 Jul 2020 08:42:46 -0700
In-Reply-To: <20200708045008.GC2303891@coredump.intra.peff.net> (Jeff King's
        message of "Wed, 8 Jul 2020 00:50:08 -0400")
Message-ID: <xmqq7dve2etl.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: ACD902F2-C131-11EA-ACC1-B0405B776F7B-77302942!pb-smtp20.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

>> Mostly sending this to get the discussion started about what changes
>> we want before flipping the default.
>
> I can't actually think of any changes we'd want to make. AFAIK aside
> from the negotiation problem, v2 is good to go. When we flipped it off
> by default for 2.27 out of caution, I had hoped we would flip it back on
> for the 2.28 cycle to get more exposure.

If there were any changes we already can think of before going
public with v2 at this moment, it makes it definitely way too late
to propose making it the default again.  I do not think of any
changes either, so I'd say it is a good sign ;-) 

> And that has been the only bug people have reported for 2.26. That
> implies to me that:
>
>   - we won't get significantly more information by leaving v2-as-default
>     in "next" or even "master" before it actually hits a release
>
>   - there probably aren't other major problems lurking, given that
>     people clearly upgraded to 2.26, found the negotiation problem, but
>     never reported any other issues

I've already said elsewhere that it is way too late to propose this
flipping back the default for this cycle but it was mainly out of
principle.  I do agree with you and Jonathan that we won't see any
further breakages in the v2 code until we expose more users to it by
making it the default in a released version.

I am afraid that "there probably aren't other" may be overly
optimistic, as the bug in 2.26 crippled the negotiation logic and
forced it to punt, which was so severe that it would have hidden any
other bugs in the negotiation logic.  If there is another bug in v2
negotiation logic that makes the sender to omit objects that should
be sent, it would not have been observed in 2.26 because the effect
of the more severe bug was to cripple the negotiation logic itself
and to make it punt, sending more objects all the way down the
history.  Now, with that larger bug fixed post 2.26, we can start to
see if there are other bugs hidden by it.

In any case, we've learned in 2.26 that it is unlikely that such
bugs would be uncovered until v2 is made the default again in a
released version to be used by more users.

So, let's flip the default in -rc0; we can revert if we see
something funny in 2.28.1 in the worst case.

Thanks.
