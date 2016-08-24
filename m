Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 751301F6C1
	for <e@80x24.org>; Wed, 24 Aug 2016 22:01:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756618AbcHXWB0 (ORCPT <rfc822;e@80x24.org>);
        Wed, 24 Aug 2016 18:01:26 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58904 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756589AbcHXWBZ (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 24 Aug 2016 18:01:25 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 0CD9E391E3;
        Wed, 24 Aug 2016 18:01:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=oSSBGkUh2vnWTZoF7sFKin3sESk=; b=eOY3hP
        RFqVXiAuXbGjYDT58E4jOhAKRiB7mlBTHa0KhPZzrLwuyjpJ6NZqEfxryJDR3lqk
        i2SJ2sGN9JGPJqGFrayn/82sdy9/LkOsSz4jwbX9CTfl1EAtoG9BTfs6J1pG5rWC
        qBpMq5bKPIyirbkYdsV4PwxTPMIhxUj0qnJuc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=rVC//OpNpJ1A7t6gj13bo9dpBYOcnLqV
        ZA1yhU1IyJR7bnLIfplGj3I/vrIcWyJaD3VxW3Jd3jEhoBYFFlT9eMxdRch0vkhr
        2c8NMjFCLApvMGfrZVV1CWQJ8cWoXcK3W5oMROPw3DRAdtP7twrAMDH1S2GQQS0j
        xmGrq2ru7PM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id F4130391E1;
        Wed, 24 Aug 2016 18:01:23 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7A664391DF;
        Wed, 24 Aug 2016 18:01:23 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Aug 2016, #08; Wed, 24)
References: <xmqqy43lookt.fsf@gitster.mtv.corp.google.com>
        <20160824213450.eo6hlmt4oly6gwih@sigill.intra.peff.net>
Date:   Wed, 24 Aug 2016 15:01:21 -0700
In-Reply-To: <20160824213450.eo6hlmt4oly6gwih@sigill.intra.peff.net> (Jeff
        King's message of "Wed, 24 Aug 2016 17:34:50 -0400")
Message-ID: <xmqqpooxomha.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4BE86FF0-6A46-11E6-9F19-F7BB12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Wed, Aug 24, 2016 at 02:16:02PM -0700, Junio C Hamano wrote:
>
>> * jk/pack-objects-optim-mru (2016-08-11) 4 commits
>>   (merged to 'next' on 2016-08-11 at c0a7dae)
>>  + pack-objects: use mru list when iterating over packs
>>  + pack-objects: break delta cycles before delta-search phase
>>  + sha1_file: make packed_object_info public
>>  + provide an initializer for "struct object_info"
>> 
>>  "git pack-objects" in a repository with many packfiles used to
>>  spend a lot of time looking for/at objects in them; the accesses to
>>  the packfiles are now optimized by checking the most-recently-used
>>  packfile first.
>> 
>>  Will hold to see if people scream.
>
> Just a note that we've been running with this at GitHub on all of our
> servers for a bit over a week, and no screaming yet. That's not
> necessarily proof of anything, but it does make the audience of "people"
> a bit bigger than just "next", as we run quite a few invocations of
> pack-objects in a day.
>
> I don't think that changes anything in the near future, since this is
> obviously not for v2.10, but barring any complaints, it's probably a
> reasonable topic to consider for the version after (and of course I'll
> relay any issues we come across on our servers).

Yeah, that "Will hold" is primarily me being lazy [*1*] during the
-rc period when updating the "What's cooking".  After following the
"break delta cycles" patch carefully, I am no longer worried about
this topic.  It should be in 'master' early in the next cycle, among
other topics that are competently done.

> I'm planning to deploy the delta-cache topic soon, too, so that should
> give it some good exercise.

Good.  Thanks.


[Footnote]

*1* ... and a bit more careful, as any "Will merge to 'next'" thing
gets marked as "Will merge to 'master'" by default and having any
entry under "Will merge to 'master'" in "Meta/cook -w" report tempts
me to merge them even during -rc period.
