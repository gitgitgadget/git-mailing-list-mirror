Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 43C241F855
	for <e@80x24.org>; Mon,  1 Aug 2016 19:52:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754863AbcHATwP (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 15:52:15 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:52930 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755098AbcHATv7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 15:51:59 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id AEEDD329E5;
	Mon,  1 Aug 2016 15:51:57 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=DkjoSEQ+000cGtlG5DO38ZDaHMk=; b=sLP1qR
	3hC2QYzdGoEd7pGl2bXnBGLtNZ0iI0Ia9T5tqA+MUZ+a+1P4ZOn9+h5DYAOrcSaA
	jbXme9inGgPSrssz5swdOjkieOBrSooZOAvaaPBDfVC7jGHunEbrF4iI9PsNeZZ0
	1tC+iQ2S+znFYssjP7dabI0DkJVZ5JM/0sBlo=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=hBM1QXnnp31zZMMVmT7SNo2n293ZMeg6
	u9bH9Bep+uY+zoyvjUVL6p3dhDK/Xu14llBayGAATrgO6pQB4LQmP+ORg1ApBWk+
	Y/TSOU3PbufhdQPxON8/ikBJ2taBf1V7okt/IAl0MtlUJq5ZjHFdZd2v+918cA6t
	GVhQYbcdWA0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A7A99329E4;
	Mon,  1 Aug 2016 15:51:57 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 282AB329E0;
	Mon,  1 Aug 2016 15:51:57 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Oleg Taranenko <olegtaranenko@gmail.com>, git <git@vger.kernel.org>
Subject: Re: git bisect for reachable commits only
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
	<xmqqinvonwxc.fsf@gitster.mtv.corp.google.com>
	<CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
	<CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
	<CAP8UFD118RdB5dX2-wEm5VnKud7sirHhdC9kvWmXV0eAQHvfsA@mail.gmail.com>
Date:	Mon, 01 Aug 2016 12:51:54 -0700
In-Reply-To: <CAP8UFD118RdB5dX2-wEm5VnKud7sirHhdC9kvWmXV0eAQHvfsA@mail.gmail.com>
	(Christian Couder's message of "Mon, 1 Aug 2016 17:41:35 +0200")
Message-ID: <xmqq7fc0jmhx.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 674E994A-5821-11E6-B128-89D312518317-77302942!pb-smtp1.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

> Yes, and the reason is that all the ancestors of a good commit are
> considered good.
> That's because git bisect supposes that there is only one transition
> from good to bad.
> Otherwise we would need a more complex algorithm to find all the
> transitions from good to bad, and that is not generally needed.

It may be debatable if that is generally needed or not, but by
definition "bisect" is about having a history that has a SINGLE
point that changes from good to bad (or old to new, or "have sugar"
to "no sugar"), and that single-ness is what allows us to BIsect the
graph.  So even if it may be a good thing to have to be able to find
multiple transitions, that is outside the scope of how the current
"git bisect" was designed to be used.

> I haven't looked at your previous issue much, sorry I have been busy these days.

I think the "previous issue" was that we can ask the user to ask to
check one of 'x' or 'y' when given Good and Bad points in a graph like
this:

        x---y---y---o---B
         \         / 
          x---G---o

while a more natural expectation by a user would be that we only
need to check one of these two 'o'.

Thinking about it again, I actually think it makes sense to ask the
user to check 'y'; there is no good reason to believe that 'y' can
never have introduced the badness we are hunting for, and limiting
the search to --ancestry-path (which is to ask only for 'o') would
stop at the merge 'o' if one of the 'y' were bad, which would
prevents us from knowing the exact breakage.

There however is no excuse if we asked to check 'x', though.  They
are ancestors of a Good commit, and "git bisect" should be able to
assume they are Good.



