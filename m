Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 643001F859
	for <e@80x24.org>; Tue,  9 Aug 2016 18:44:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932421AbcHISok (ORCPT <rfc822;e@80x24.org>);
	Tue, 9 Aug 2016 14:44:40 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:60856 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932283AbcHISoj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Aug 2016 14:44:39 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 9E90B34E8E;
	Tue,  9 Aug 2016 14:44:38 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=EVO9NPzKjsFabQeVyfvI1wYiOZ4=; b=LPA7Bi
	tp7dBVCM/9AEgYgK5qQ5Ixd6TDf5732HNSMQA1gec9M9+RBuHiDNpWmw+u+oyT1e
	pcK47KasZ3no55eVX949uGOsr6RcD3uY874Ba78qv/rvjaELIPtybWKl1l8f2Uj2
	QavpJLwT0+Si8dPi0VOQaJKM60LkLYcV796EQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Df8uSMzA0QZwmneCMtAy2JvZD0KBijjJ
	yrESPjnBFsCG4+dB+MEteEu1GoJcdgJcRfuayuNzVENWyhH/ksgYnwnfd5COglcW
	Mk0b0mLDuA9a8sk2zQVYT5JRUKcX7p5+VsGnLLh4tMg/GTHd8jCZjl5e80Bi1QL9
	jhVGUYyTMuw=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 96CDA34E8D;
	Tue,  9 Aug 2016 14:44:38 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 2348034E8C;
	Tue,  9 Aug 2016 14:44:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Stefan Beller <sbeller@google.com>
Cc:	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	"Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv2 0/6] git clone: Marry --recursive and --reference
References: <20160809040811.21408-1-sbeller@google.com>
	<xmqqk2fqc583.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZKTV5PCAR41O1t1c_y6N18u6gsoWozOfr=EPHic-7wYw@mail.gmail.com>
	<xmqq8tw5bzs1.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kY8EiGaugsh4FxKYp1FxqYr10JfGqsrfsnhULB+OBnFXw@mail.gmail.com>
Date:	Tue, 09 Aug 2016 11:44:36 -0700
In-Reply-To: <CAGZ79kY8EiGaugsh4FxKYp1FxqYr10JfGqsrfsnhULB+OBnFXw@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Aug 2016 11:09:34 -0700")
Message-ID: <xmqq8tw5aijv.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 532AF594-5E61-11E6-A723-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Stefan Beller <sbeller@google.com> writes:

> The way I understood and implemented it is
>
>     here is a path, try to use it as an alternate; if that is not
>     an alternate, it's fine too; maybe warn about it, but carry
>     on with the operation.

My expectation is without "maybe warn about it".  And not adding it
as an alternate (because it is not usable) is just "doing as I was
told to do", nothing noteworthy.  Because "do it only if you can" is
an explicit instruction to the doer that the caller does not care
about the outcome, I'd think there shouldn't be any warning, whether
it is used or not.  At the same time, if the caller wants to know
the outcome, and using if-able as a way to say "I prefer to see it
happen, but you do not have to panic if you can't", I'd think it is
OK to give "info:" to report which of the two possible paths was
taken in either case.  Throwing a "warning:" only when it didn't do
so does not make much sense to me.

> The way you write this response I think you have a slightly
> different understanding of what the -if-able ought to do?
>
>     When --reference is given, only the superproject should
>     borrow and the -if-able, may allow submodules to also borrow?

I have no idea what this sentence means.

>> I have a very strong opinion what should happen when the end-user
>> facing command is "git submodule", but if I have to choose, I would
>> prefer to see "git submodule update" tell what it did with "info:"
>> either case, i.e. "info: borrowing from ... because the superproject
>> borrows from there", and "info: not borrowing from ... even though
>> the superproject borrows from there".
>
> I see. This way the user is most informed.

Yes, and if we were to go that route, "clone" without "-v" should
not report which of the two it took.  It is OK for "submodule" to
look at what "clone" left as the result and do more intelligent
reporting that is better suited for the context of the command.

> The current implementation
> of "submodule update --init" for start from scratch yields for example:
>
> Submodule 'foo' (<url>) registered for path 'foo'
> Submodule 'hooks' (<url>) registered for path 'hooks'
> Cloning into '/home/sbeller/super/foo'...
> Cloning into '/home/sbeller/super/hooks'...
> warning: Not using proposed alternate
> /home/sbeller/super-reference/.git/modules/hooks/
> Submodule path 'foo': checked out '7b41f3a413b46140b050ae5324cbbcdd467d2b3a'
> Submodule path 'hooks': checked out '3acc14d10d26678eae6489038fe0d4dad644a9b4'
>
> so before this series we had 3 lines per submodule, and with this series
> we get a 4th line for the unusual case.
>
> You would prefer to see always 4 lines per submodule?

If the user says "--recursive --reference", then the user probably
deserves to be notified.  As I said (eh, rather, as I wanted to say
but failed to say so), I do not have a strong preference either way.

