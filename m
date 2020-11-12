Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 486CDC388F7
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 21:22:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2AAA216FD
	for <git@archiver.kernel.org>; Thu, 12 Nov 2020 21:22:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="vf2GsIkb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727217AbgKLVWJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 12 Nov 2020 16:22:09 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:60487 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726943AbgKLVWI (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 12 Nov 2020 16:22:08 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1211B98447;
        Thu, 12 Nov 2020 16:22:04 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=xsxgojm6PQgPO9IAjqlkJdIWAyw=; b=vf2GsI
        kbO4Uv5XoO/ZeNtanLpa2bKIcJZQ9IMAM88Z6b4KqNz8VrtnSnDa+7dCOaIZov26
        287Qn8idQ0xvOpVDjc6wumDZ+HQiHMZkUnx8K6yWDitKKudG4FNerHsEiD3abjV6
        rTYagDJxMbaqeCyO6YgKHVkrWRsvpTtFUA1Vc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=c92oNMI4vkU5bgpgEHl9ei34dFAUSKFo
        7UMKRZQDkMTz+ja3r6Y5TTVQHSk9tXkzrJeChAleRchqmi7XtpnrqFsQuW12fN2I
        pVRpYTlQnzH/mnMp5kM37Kpab6916a1EPDfL+9MsCTTATtu/PMaDVxwwwhbSfe7o
        ad6CJ3z00cM=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id E909C98446;
        Thu, 12 Nov 2020 16:22:03 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 597FB98444;
        Thu, 12 Nov 2020 16:22:03 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     Chris Torek <chris.torek@gmail.com>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnI=?= =?utf-8?B?w7A=?= Bjarmason 
        <avarab@gmail.com>, Git List <git@vger.kernel.org>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stefan Beller <stefanbeller@gmail.com>
Subject: Re: How do I "git fetch" with a custom <refspec> but a default remote?
References: <CAGZ79kb57HzJQ4VLFD_NMKvEnriPVXoAAPimg6BG_Z+PPjJ4aQ@mail.gmail.com>
        <20201111151754.31527-1-avarab@gmail.com>
        <877dqqhd3s.fsf@evledraar.gmail.com>
        <20201112185146.GD701197@coredump.intra.peff.net>
        <CAPx1Gvckixj2hj5wL8EPpJbnp4rsV7-qnVUCG1d-UAqVtp-H-Q@mail.gmail.com>
        <20201112204802.GA707750@coredump.intra.peff.net>
Date:   Thu, 12 Nov 2020 13:22:02 -0800
In-Reply-To: <20201112204802.GA707750@coredump.intra.peff.net> (Jeff King's
        message of "Thu, 12 Nov 2020 15:48:02 -0500")
Message-ID: <xmqqeekycltx.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 1BB9F956-252D-11EB-8AE7-D152C8D8090B-77302942!pb-smtp1.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> On Thu, Nov 12, 2020 at 11:26:25AM -0800, Chris Torek wrote:
>
>> On Thu, Nov 12, 2020 at 10:52 AM Jeff King <peff@peff.net> wrote:
>> > If we were starting from scratch, then I think that might have been
>> > nicer, because --default-remote would be implied if there is no
>> > "--remote" option. And then my lazy-to-type:
>> >
>> >   git fetch topic
>> >
>> > would just work. But given that we have the positional <remote>
>> > parameter already, I don't think adding --remote gives much value. And
>> > it raises the question of what "git fetch --remote=foo --remote=bar"
>> > means (I think the answer is last-one-wins).
>> 
>> Since `git fetch` can fetch from more than one remote, it seems to me
>> to make more sense to mean "fetch from each".
>
> Ah, right, I forgot that --multiple existed. Without it, specifying
> multiple remotes makes no sense at all. But perhaps giving multiple
> --remote would implicitly specify "--multiple". That makes sense to me.
>
>> (This isn't necessarily an argument in favor of adding these options,
>> just my suggestion for what multiple `--remote=` settings would mean.)
>
> Likewise. "makes sense" above mostly means I would not object to it, but
> I am not advocating for it. :)

I am not sure if it makes much sense, though.

The "--multiple" mode of "fetch" is about running the default fetch
against each of the named remotes and the idea does not mesh very
well with using (possibly different) fetch refspec per each of these
fetch operations.

We could come up with the maximally flexible and orthogonal syntax
that gives the command one or more (remote, fetch refspec) tuples
and give a way to say "use the default remote" for the first
component of the tuple, and a way to say "use the configured way for
the remote" for the second component of the tuple.  But at that
point, there would just be a single syntax that can be used to drive
fetches from multiple repositories, so...



