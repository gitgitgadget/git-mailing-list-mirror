From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/6] t1500: avoid setting environment variables outside of tests
Date: Tue, 10 May 2016 13:07:27 -0700
Message-ID: <xmqqk2j1oeww.fsf@gitster.mtv.corp.google.com>
References: <20160510052055.32924-1-sunshine@sunshineco.com>
	<20160510052055.32924-6-sunshine@sunshineco.com>
	<20160510183955.GA16211@sigill.intra.peff.net>
	<CAPig+cRR49iJOkaLfynkvch4zUHVkpcJwVah0rvaEOeR7aY2Nw@mail.gmail.com>
	<CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jeff King <peff@peff.net>, Git List <git@vger.kernel.org>,
	Michael Rappazzo <rappazzo@gmail.com>,
	Duy Nguyen <pclouds@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Tue May 10 22:07:36 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b0DwN-0000Eo-Og
	for gcvg-git-2@plane.gmane.org; Tue, 10 May 2016 22:07:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752557AbcEJUHc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 May 2016 16:07:32 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:58997 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752465AbcEJUHb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 May 2016 16:07:31 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id C2660196E6;
	Tue, 10 May 2016 16:07:29 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hm0f/pWq3sVr4r1n3jpXWp2+wac=; b=S8EM+M
	Jh6MarfyGGz4h1WivwnCaOT4jOPKSoj3J4/X4kTjAFQQjByAqogV1Z/KrAjrLX6u
	gQbveHuAlQpN3kF4xC/FDqi63ukppso2Qahf1Pb3Rx/VEQzI9BgT+pS43ir/UC95
	iXojtel0hQOXaD1dcc1TivMUrBHCKY9Jf4zQk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JUyd1nUxd2JVhXdpTfF8kZ5IlCAB/DzM
	mIrHoZOJrr95gnPzS/jpVSdbnbjtvj+eu7xYuqCGUgk15UHJYf3f2yt25/VBLww8
	U3M9+OXTtH7Ax+a6CS9urEH4/uCQd4ZgvG36slMEh9lrm/PqNn5JU9s4P2/KFcWb
	0FfL5AlvLgY=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id B767E196E4;
	Tue, 10 May 2016 16:07:29 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 39419196E3;
	Tue, 10 May 2016 16:07:29 -0400 (EDT)
In-Reply-To: <CAPig+cTtU9_3=2eu0boaPbXKXh2gngEe7byDpJuSFAR4rcbrMA@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 10 May 2016 15:48:56 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: D29E2594-16EA-11E6-A3F2-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294182>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, May 10, 2016 at 3:12 PM, Eric Sunshine <sunshine@sunshineco.com> wrote:
>> On Tue, May 10, 2016 at 2:39 PM, Jeff King <peff@peff.net> wrote:
>>> On Tue, May 10, 2016 at 01:20:54AM -0400, Eric Sunshine wrote:
>>>>       while :
>>>>       do
>>>>               case "$1" in
>>>>               -C) dir="-C $2"; shift; shift ;;
>>>>               -b) bare="$2"; shift; shift ;;
>>>> +             -g) env="GIT_DIR=$2; export GIT_DIR"; shift; shift ;;
>>>> @@ -36,6 +38,8 @@ test_rev_parse () {
>>>>       do
>>>>               expect="$1"
>>>>               test_expect_success "$name: $o" '
>>>> +                     test_when_finished "sane_unset GIT_DIR" &&
>>>> +                     eval $env &&
>>>
>>> This will set up the sane_unset regardless of whether $env does
>>> anything. Would it make more sense to stick the test_when_finished
>>> inside $env? You could use regular unset then, too, since you know the
>>> variable would be set.
>>
>> I didn't worry about it too much because the end result is effectively
>> the same and, with all the 'case' arms being short one-liners, I think
>> the code is a bit easier to read as-is; bundling 'test_when_finished'
>> into the 'env' assignment line would probably require wrapping the
>> line. I do like the improved encapsulation of your suggestion but
>> don't otherwise feel strongly about it.
>
> Actually, I think we can have improved encapsulation and maintain
> readability like this:
>
>     case "$1" in
>     ...
>     -g) env="$2"; shift;  shift ;;
>     ...
>     esac
>
>     ...
>     test_expect_success "..." '
>         if test -n "$env"
>         do
>             test_when_finished "unset GIT_DIR"
>             GIT_DIR="$env"
>             export GIT_DIR
>         fi
>         ...
>     '

That's even better.  Thanks.
