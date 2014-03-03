From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] implemented strbuf_write_or_die()
Date: Mon, 03 Mar 2014 12:35:44 -0800
Message-ID: <xmqqsiqznhpb.fsf@gitster.dls.corp.google.com>
References: <1393672871-28281-1-git-send-email-faiz.off93@gmail.com>
	<CAJr59C0e22OuDWU5Xc0A=cc+zY32nfum6SXTDU3wLCPyFPF70A@mail.gmail.com>
	<CAPig+cRgc4UtmJMieS9Mdrz7vjUNiu7QFu1PSBppKo22Ln5G-A@mail.gmail.com>
	<xmqqvbvvqglc.fsf@gitster.dls.corp.google.com>
	<CAPig+cTmejtWXRzr6qk-kd+P8j4b6xMJSUVnNnqObqNXc-S9UA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: He Sun <sunheehnus@gmail.com>, Faiz Kothari <faiz.off93@gmail.com>,
	git <git@vger.kernel.org>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 21:35:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKZab-0003aw-GO
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 21:35:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754310AbaCCUft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2014 15:35:49 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52868 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753590AbaCCUfs (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2014 15:35:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id CE75E70AA5;
	Mon,  3 Mar 2014 15:35:47 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=acoEt7rXKaGDpXqRUdiT22RB420=; b=TAjvRw
	FHDEuq2UZhTlAHFT7yIhO6ZgQUtt/wZk52lIYyIXyxiNHM8trzpRwAw4Z0C/QAoI
	8s7FXtKKp4OXbMncxezBO0RmmzPaVM9+4l2M9xIMJjcsaZgCWnM84oOBOW13SCkF
	41p68pJVXRDl2NliB+odqxu/HwxlfO5J5uOos=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=msgJX/+7K66U5eqBkaKwyBu83M49mM/b
	Cd/Qn28yrIUP4DIJ/8IhY4Gfc06r6J+/F2YmI3K2BUIa25n8KpZWuWAy7wazcJtS
	WscZ8bogFbn/8FFJtz4NPdhRY97rAgHmcrLpDghx1HWlmMG3eYj0bf+YpqZIGO6X
	ogeLl+yXtM0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9ECA970AA3;
	Mon,  3 Mar 2014 15:35:47 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF08570AA0;
	Mon,  3 Mar 2014 15:35:46 -0500 (EST)
In-Reply-To: <CAPig+cTmejtWXRzr6qk-kd+P8j4b6xMJSUVnNnqObqNXc-S9UA@mail.gmail.com>
	(Eric Sunshine's message of "Mon, 3 Mar 2014 14:46:12 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 664CF20A-A313-11E3-B09C-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243269>

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Mon, Mar 3, 2014 at 1:31 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eric Sunshine <sunshine@sunshineco.com> writes:
>>
>>> On Sat, Mar 1, 2014 at 7:51 AM, He Sun <sunheehnus@gmail.com> wrote:
>>>> 2014-03-01 19:21 GMT+08:00 Faiz Kothari <faiz.off93@gmail.com>:
>>>>> diff --git a/remote-curl.c b/remote-curl.c
>>>>> index 10cb011..dee8716 100644
>>>>> --- a/remote-curl.c
>>>>> +++ b/remote-curl.c
>>>>> @@ -634,7 +634,7 @@ static int rpc_service(struct rpc_state *rpc, struct discovery *heads)
>>>>>         if (start_command(&client))
>>>>>                 exit(1);
>>>>>         if (preamble)
>>>>> -               write_or_die(client.in, preamble->buf, preamble->len);
>>>>> +               strbuf_write_or_die(client.in, preamble);
>>>>>         if (heads)
>>>>>                 write_or_die(client.in, heads->buf, heads->len);
>>>>
>>>> This should be changed. May be you can use Ctrl-F to search write_or_die().
>>>> Or if you are using vim, use "/ and n" to find all.
>>>
>>> It's not obvious from the patch fragment, but 'heads' is not a strbuf,
>>> so Faiz correctly left this invocation alone.
>>
>> That is a very good sign why this change is merely a code-churn and
>> not an improvement, isn't it?  We know (and any strbuf user should
>> know) that ->buf and ->len are the ways to learn the pointer and the
>> length the strbuf holds.  Why anybody thinks it is benefitial to
>> introduce another function that is _only_ for writing out strbuf and
>> cannot be used to write out a plain buffer is simply beyond me.
>
> As a potential GSoC student and newcomer to the project, Faiz would
> not have known that this would be considered unwanted churn when he
> chose the task from the GSoC microproject page [1]. Perhaps it would
> be a good idea to retire this item from the list?

I don't think I saw this on the microproject suggestion page when I
last looked at it, and assumed that this was on the student's own
initiative.

> On the other hand, it did expose Faiz to the iterative code review
> process on this project and gave him a taste of what would be expected
> of him as a GSoC student, so the microproject achieved that important
> goal, and thus wasn't an utter failure.
>
> [1]: https://github.com/git/git.github.io/blob/master/SoC-2014-Microprojects.md

Surely.

I would have to say that this is not a good sample exercise to
suggest to new students and I'd encourage dropping it from the list.
You could argue that it is an effective way to cull people with bad
design taste to mix suggestions to make the codebase worse and see
who picks them, but I do not think it is very fair ;-)
