From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] commit: inform pre-commit if --amend is used
Date: Sun, 30 Nov 2014 16:56:53 -0800
Message-ID: <xmqq3890tcfe.fsf@gitster.dls.corp.google.com>
References: <1416828111-4567-1-git-send-email-oystwa@gmail.com>
	<20141125034424.GA19161@peff.net>
	<xmqqtx1nub9e.fsf@gitster.dls.corp.google.com>
	<20141125050331.GB20805@peff.net> <547737C8.7070609@gmail.com>
	<20141128051805.GA19258@peff.net> <5478996F.5050207@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>,
	=?utf-8?Q?=C3=98ystein?= Walle <oystwa@gmail.com>,
	git@vger.kernel.org
To: Mark Levedahl <mlevedahl@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 01 01:57:02 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XvFIS-0003dw-DS
	for gcvg-git-2@plane.gmane.org; Mon, 01 Dec 2014 01:57:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145AbaLAA44 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 30 Nov 2014 19:56:56 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52151 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752118AbaLAA44 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 30 Nov 2014 19:56:56 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 448DF2379C;
	Sun, 30 Nov 2014 19:56:55 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5UqmmpykTPOzQQcBatFZsZ9w0ic=; b=d4tYV8
	vrEAOT558ak2xjRqR8LAauMNrZwWpanAMwDV+AWXWeCcD1/VjoXWoSkijvUMgnAg
	eL05G7RsMHMARahgO3UHxvvU89fnZLsSswOQXYMpOkLaV33diJzw0huoJg9o/OOb
	MeaX+yRU0AIOH+wtcWMroEnWaJOIpw/L7Iwc8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=pozdZ/n24ExpvnZ7E3/c3W7NIqh8vPhI
	RqQbRHeJjjtM6Lw0YxZglWJokXiSQQtZCESX7Z+aDqG2uX4soOXwkS9pMYw18ufQ
	u8IrZZRi5BQpA2r0ipsQklZEpvbVeYglWWDRk3Js6c9uI4xoahfzSYQNU87xRfbF
	5n2HR8DXBmw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 369232379B;
	Sun, 30 Nov 2014 19:56:55 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A75D82379A;
	Sun, 30 Nov 2014 19:56:54 -0500 (EST)
In-Reply-To: <5478996F.5050207@gmail.com> (Mark Levedahl's message of "Fri, 28
	Nov 2014 10:49:03 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F17F0CFC-78F4-11E4-9262-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/260458>

Mark Levedahl <mlevedahl@gmail.com> writes:

> On 11/28/2014 12:18 AM, Jeff King wrote:
>
>> Thanks for the links; I had no recollection of that thread.
>> Unsurprisingly, I like the "HEAD"/"HEAD~1" suggestion. That "peff" guy
>> seems really clever (and handsome, too, I'll bet).
>>
>> I'd still be OK with any of the suggestions given in this thread,
>> though.
>>
>> -Peff
>> ars
>
> Apparently our combined handsome-foo was insufficient to get this
> accepted way back when, hopefully the current submitter has more :^)
>
> In any event, I've carried the patches using HEAD/HEAD~1 in my tree
> for the last 4+ years, have a widely used pre-commit script that
> depends upon those. So, I personally would be very happy to see this
> finally show up in Junio's tree, would prefer HEAD/HEAD~1 but can
> adapt to whatever.

One thing to be careful about is that the approach HEAD, HEAD~,
etc. does allow this to be extended to cover merge cases as the old
thread speculated, it will make it impossible to pass any kind of
information, other than "here are the parents of the results", to
the hook.

Of course, there are ways to make sure that we won't paint us into
an unescapable corner, e.g. an obvious example (not necessarily the
best) being to pass "HEAD", "HEAD~", "b76b088 b260d26" etc., in
other words, passing these parents still as a single argument,
multiple parents concatenated with some delimiters, so that "$1"
will always be "who are the parent(s)" even when we needed to later
pass other sorts of information.
