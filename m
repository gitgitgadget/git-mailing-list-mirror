Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A98CC5519F
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 15:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A0907247A7
	for <git@archiver.kernel.org>; Wed, 18 Nov 2020 15:53:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ZsxGu0sF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726724AbgKRPxN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 18 Nov 2020 10:53:13 -0500
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65220 "EHLO
        pb-smtp1.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgKRPxN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 18 Nov 2020 10:53:13 -0500
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 7E9B89EC40;
        Wed, 18 Nov 2020 10:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; s=sasl; bh=yVGDKoxBJNFs
        sP9ef6XcPkaLB6A=; b=ZsxGu0sFMsRrxH0CQCp+g7yeuAA/Zyl20VnUTVhvSq3M
        OfXJXqV4XCfNudLupArZ1Uu8CKicMnBbPZRE1KYE53C4aEaj7VGgQrKdEdDx3KQf
        rt73H7jTJRW1RsamhED4feFYS8XLHEblAmO8UGG2a5FaKqJR3zi1SjsBnixFkrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type:content-transfer-encoding; q=dns; s=sasl; b=UvB92O
        zi1nrO5ZnuhuPmHrTB0YYX2bf4ntRUGt3xdqkD2WyXmKQh9XipiKtrWurrU2vB2x
        e0hoxMMevytzHreHXMXwEkOTYTYy6W6NE+v1jxn4ioXFCcKMJWAMhLzfw0pIQfxa
        RRP9VHdf71Rh6Ejcg+E+gOnBCa+kD+0Wd3SrA=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 675E29EC3F;
        Wed, 18 Nov 2020 10:53:09 -0500 (EST)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.74.119.39])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 471119EC3C;
        Wed, 18 Nov 2020 10:53:08 -0500 (EST)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
        Jeff King <peff@peff.net>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Dominik Salvet <dominik.salvet@gmail.com>
Subject: Re: [RFC/PATCH] Add fetch.updateHead option
References: <20201118091219.3341585-1-felipe.contreras@gmail.com>
        <87wnyjdnb3.fsf@evledraar.gmail.com>
Date:   Wed, 18 Nov 2020 07:53:06 -0800
In-Reply-To: <87wnyjdnb3.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Wed, 18 Nov 2020 10:30:40 +0100")
Message-ID: <xmqqwnyi3bml.fsf@gitster.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID: 273A0A36-29B6-11EB-903F-D152C8D8090B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com> writes:

> On Wed, Nov 18 2020, Felipe Contreras wrote:
>
>> Users might change the behavior when running "git fetch" so that the
>> remote's HEAD symbolic ref is updated at certain point.
>>
>> For example after running "git remote add" the remote HEAD is not
>> set like it is with "git clone".
>>
>> Setting "fetch.updatehead =3D missing" would probably be a sensible
>> default that everyone would want, but for now the default behavior is =
to
>> never update HEAD, so there shouldn't be any functional changes.
>>
>> For the next major version of Git, we might want to change this defaul=
t.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>
>> This is just a RFC, the tests are missing.
>
> I haven't taken much time to re-think through the patch/implications of
> this, but I remember running into this and going through some pre-patch
> investigation at some point.
>
> It's really annoying in some cases that "clone" isn't creating the same
> state as "remote". IIRC I was doing some heuristics to figure out the
> remote branch name etc.
>
> Isn't this something we can just change without an option? There were a
> bunch of cases in clone/fetch that were different for no different
> reasons, IIRC I patched one or two of those in the past. But I haven't
> gone through the history of the feature and checked if it was
> intentional.

I think what Peff outlined earlier was reasonable.  "remote add -f",
since it talks with the remote, should be able to learn where their
HEAD points at and set it up.  "remote add" that does not talk to
the remote cannot do so and "fetch" could help but we should not
touch existing refs/remotes/$name/HEAD by default [*1*], as the
symref is meant to indicate the local choice of which one of their
branches is significant to _us_ and what "clone" does is merely to
give it the initial value.

But when interacting with a remote whose choice of HEAD is always
what the local user wants to follow, letting "git fetch" update
refs/remotes/$name/HEAD to a newly observed value would be a welcome
optional feature.

I haven't thought through what Jonathan (Nieder) said about an
option to fail a fetch when refs/remotes/$name/HEAD and the remote
HEAD "git fetch" observed do not match.  It may make sense in some
cases but not always, and I do not know what the right explanation
for the use case the mode is supposed to be a good match is.


[Footnote]

*1* This is important when you work in more than one repositories
with working tree and use fetch+rebase to keep them in sync.
