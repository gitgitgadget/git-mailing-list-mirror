Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C4E471F955
	for <e@80x24.org>; Mon,  1 Aug 2016 23:11:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753219AbcHAXLy (ORCPT <rfc822;e@80x24.org>);
	Mon, 1 Aug 2016 19:11:54 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:50111 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753223AbcHAXLo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Aug 2016 19:11:44 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 605AC32DFC;
	Mon,  1 Aug 2016 19:11:39 -0400 (EDT)
DKIM-Signature:	v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hkCdLchE8dC50JPFszxU0V6csdQ=; b=piOfDo
	6p1/QOO1ZVAS1+eWOoTIa+ybvnVm8dPhMj+YPEtDQfpv4iOJ4pYdEzapbzA13yuv
	2OGqyrmGxM3Sxd76Pg56KsEoN/+jY7awqU7tI7sRmOnP7lLryA0klI32nJVyaMja
	RtvRU8NMGlBanmK4zWPQPRb+3jqvdVbsldF7w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=HJY3gYPKaFNt5UJJ1IaLg6dOfWEGF9L+
	KaB010U5gSpoBtYlyHXZbRKJIZwX6XyMo9/6LP2Str3VfAMwOW2UDyIwhV4AKtD1
	rNvu+sQ+kfCST/Wa6RtIPeD8hQoZn6jy7puxSAJzcFWcTKa/y+6XnDEB5i1G22Vu
	JHd8LwAb8NM=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 58F2732DFB;
	Mon,  1 Aug 2016 19:11:39 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id B8DF032DFA;
	Mon,  1 Aug 2016 19:11:38 -0400 (EDT)
From:	Junio C Hamano <gitster@pobox.com>
To:	Christian Couder <christian.couder@gmail.com>
Cc:	Oleg Taranenko <olegtaranenko@gmail.com>, git <git@vger.kernel.org>
Subject: Re: git bisect for reachable commits only
References: <CABEd3j8VLbpeWbA6BfHYp5aLPEy0PesqYoHM9u4OM=b7Qm=LDg@mail.gmail.com>
	<xmqqinvonwxc.fsf@gitster.mtv.corp.google.com>
	<CABEd3j-MW--YSC9=nwcgHzxd6cqmUY+ky3-wLxMiMmbBGsvS7Q@mail.gmail.com>
	<CABEd3j--sxCwv6fWmNxTtdpgwU0_YKbfiFONX6TsQFZGn79yuQ@mail.gmail.com>
	<CAP8UFD118RdB5dX2-wEm5VnKud7sirHhdC9kvWmXV0eAQHvfsA@mail.gmail.com>
	<xmqq7fc0jmhx.fsf@gitster.mtv.corp.google.com>
	<CAP8UFD315CgntwYiC9g-R7KN0XiL9635Vwv_y8yi4n-uj8o90A@mail.gmail.com>
Date:	Mon, 01 Aug 2016 16:11:36 -0700
In-Reply-To: <CAP8UFD315CgntwYiC9g-R7KN0XiL9635Vwv_y8yi4n-uj8o90A@mail.gmail.com>
	(Christian Couder's message of "Mon, 1 Aug 2016 22:36:06 +0200")
Message-ID: <xmqqwpk0f5jr.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4CE4C4C8-583D-11E6-8C4F-EE617A1B28F4-77302942!pb-smtp2.pobox.com
Sender:	git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List:	git@vger.kernel.org

Christian Couder <christian.couder@gmail.com> writes:

>> I think the "previous issue" was that we can ask the user to ask to
>> check one of 'x' or 'y' when given Good and Bad points in a graph like
>> this:
>>
>>         x---y---y---o---B
>>          \         /
>>           x---G---o
>>
>> while a more natural expectation by a user would be that we only
>> need to check one of these two 'o'.
>
> Yeah, I reproduced the steps described in the Google Groups discussion:
>
> https://groups.google.com/forum/#!topic/git-users/v3__t42qbKE
>
> and I think that is indeed the "previous issue".
>
>> Thinking about it again, I actually think it makes sense to ask the
>> user to check 'y'; there is no good reason to believe that 'y' can
>> never have introduced the badness we are hunting for, and limiting
>> the search to --ancestry-path (which is to ask only for 'o') would
>> stop at the merge 'o' if one of the 'y' were bad, which would
>> prevents us from knowing the exact breakage.
>
> I agree.

Having agreed on that, there are cases where you do want to stop at
the merge 'o' on the upper history, when lower-history leading to B
is the mainline and you are interested in finding the merge with
which side branch introduced a breakage, and not particularly
interested in finding the exact commit on the side branch.  Upon
finding the merge 'o' that is the parent of 'B' is bad, you find out
the owner of the side branch merged there who wrote the two 'y's,
and have him work on figuring out where in his branch he broke it.

For that, the --ancestry-path is a wrong way to traverse; what we
want in that context is the --first-parent traversal.

>> There however is no excuse if we asked to check 'x', though.  They
>> are ancestors of a Good commit, and "git bisect" should be able to
>> assume they are Good.
>
> I think it does. When I reproduced the steps in the "previous issue",
> it did assume they are good.

I actually had an impression that the original report claimed that
the user was asked to check immediate parent of G, and that would be
a bug.
