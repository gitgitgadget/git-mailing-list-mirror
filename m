From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 5/5] pathspec: record labels
Date: Mon, 16 May 2016 10:38:00 -0700
Message-ID: <xmqqlh393nuv.fsf@gitster.mtv.corp.google.com>
References: <20160513231326.8994-1-sbeller@google.com>
	<20160513231326.8994-6-sbeller@google.com>
	<xmqqk2iw78aq.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kZsVH3mE0zXu9wSWgit3QZ_CiKZqg-TQdyWnZw6D9=Cgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Duy Nguyen <pclouds@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Mon May 16 19:38:29 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b2MT5-0004f3-0H
	for gcvg-git-2@plane.gmane.org; Mon, 16 May 2016 19:38:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbcEPRiG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 May 2016 13:38:06 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:65528 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753887AbcEPRiF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 May 2016 13:38:05 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 48E771C98C;
	Mon, 16 May 2016 13:38:03 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=vbctj/kHnNb6XGX0UfCMgf+p7Vk=; b=VBtzIA
	+IIzIOhwm1ei41wNvUrpbkdO1MXXo9bLqAeErRLoM683ZR1f2KYeVdh2FlVFaIms
	GyHA8kVoxy+/3M0+mgY6KC0CLCgs2n+k5gfx1lpwPBWrCjl5E/NAvnlMWYyC476p
	vmu8QNiHI/B4KgXSdoLAygPgZ41ordjSO9h8g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZvukGri/eacw7EOVikqpWhNqutvUU+Q4
	H8yRRxYIO16/0yt1dw8Npaz+DcV6XGYiQQRpWoOQ7PcLCwq9pW4WPzQJ6nV4H8G9
	YX8qkrytLoCvpEutlJLWhX0YSPA2sCtt1fxSbbnWsOZxiXwO3z0xYZg0bGEG0113
	6hJ9oAgtixE=
Received: from pb-smtp1. (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 37C001C98B;
	Mon, 16 May 2016 13:38:03 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 941AD1C98A;
	Mon, 16 May 2016 13:38:02 -0400 (EDT)
In-Reply-To: <CAGZ79kZsVH3mE0zXu9wSWgit3QZ_CiKZqg-TQdyWnZw6D9=Cgw@mail.gmail.com>
	(Stefan Beller's message of "Mon, 16 May 2016 10:16:55 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: F092C874-1B8C-11E6-AF51-9A9645017442-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294759>

Stefan Beller <sbeller@google.com> writes:

>> Let's avoid "are meant to", which is merely to give you an excuse to
>> say "it was meant to ... but the implementation did not quite achieve
>> that goal".
>>
>>     The "label" attribute can be attached to paths, and the pathspec
>>     mechanism is extended via the new ":(label=X)pattern/to/match"
>
> I wasn't sure about whether we want to have '=' or ':' as the separator
> of "label" and its values. ...

Oh, sorry, the above wasn't a suggestion to change : to = at all.  I
was merely being sloppy in the details that is irrelevant to my main
point (which is, it is better spend the bits you spent for "meant
to" instead for saying clearly what it does).

> ... But as that is only internal, we can be inconsistent to a new
> public feature, so '=' seems better for the labeling system.

I can buy that, too.  Good that my sloppy wording helped you think
about it further ;-).

> But still we do not enforce it early enough. Some crazy upstream may
> add some labels which do not follow the requirements and then
> tell downstream to run a command like `git foo "(label=!@#$)".
> and then downstream curses at upstream as well as Git.

That is why it is "warn and ignore", not "die".

>>> +     if (ATTR_TRUE(check.value))
>>> +             ret = 1; /* has all the labels */
>>
>> So this is "pretend that I have all the labels under the sun".
>>
>>> +     else if (ATTR_FALSE(check.value))
>>> +             ret = 0; /* has no labels */
>>
>> I do not see a value in this.  What difference does it have compared
>> to having a "label=" that explicitly says "I do not have one"?  What
>> is your answer to an end-user question "When should I say 'label='
>> and when should I say '!label'?"
>>
>> Just forbid it for now; we may find a better use for it later.
>
> I don't think we want to die in that code as it is in the data already.

Is it?  I think this is coming from the command line pathspec magic,
not from .gitattributes file recorded in the tree.

> We need to allow the UNSET case, as otherwise you'd need to label
> any path if using labels?

You do need UNSET (roughly, "no label is mentioned for the path").

If I want to say "Everything under Documentation/ and also things
with label=doc", I'd say

	git cmd "Documentation/" ":(label=doc)"

and no path in Documentation/ need any label, i.e. for them, the
labels are unset.  They will not be caught with ":(label=doc)"
because they are not set, but that is OK.

FALSE is different from UNSET.  It needs an explicit mention, i.e.

	*.doc	doc
        false.doc	-doc

What's the difference between saying "-doc" and not saying anything?
If you really want to explicitly say "doc attribute is unset for
this path (perhaps because you may have other patterns that set the
doc elsewhere), you would say "!doc", and you already have code for
that.

>         if (ATTR_TRUE(check.value))
>                 ret = 1; /* has all the labels */
>         else if (ATTR_FALSE(check.value))
>                 die(_("Label attributes must not be unset"));

The message is wrong.  You are dying because the user explicitly set
it to false, not because the user made it unset.

>         else if (ATTR_UNSET(check.value))
>                 ret = 0; /* has no labels */

>>> +             struct string_list_item *si;
>>> +             struct string_list attr_labels = STRING_LIST_INIT_DUP;
>>> +             string_list_split(&attr_labels, check.value, ',', -1);
>>> +             string_list_sort(&attr_labels);
>>
>> Filter out a non-compliant label values here, so that they are
>> ignored from day one.  That way you would not have to deal with "I
>> know I got the warning, but it used to work and you broke it" later.
>
> So you're saying we should not die(...) but just ignore those labels?

Do not die() but warn-and-ignore when you see funnies in
.gitattributes; do die() if you see funnies in pathspec magic.

>> I am NOT suggesting to make this enhancement in the prototype to
>> allow us experiment with submodule selection use case, but this is
>> an obvious place to allow
>>
>>         :(label=A B):(label=C D)
>>
>> to mean ((A & B) | (C & D)) by making item->labels an array of set
>> of labels.
>>
>> And no, I do not think arbitrary boolean expression is too complex

s/do not/do/

>> to understand to the end-users, especially if we have to stay within
>> the pathspec magic syntax.  And my gut feeling is that it is not
>> worth it to support anything more complex than "OR of these ANDed
>> ones".
>
> That makes sense.

Thanks.
