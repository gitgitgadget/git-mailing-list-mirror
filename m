From: Junio C Hamano <gitster@pobox.com>
Subject: Re: error: src refspec refs/heads/master matches more than one.
Date: Tue, 18 Feb 2014 13:47:49 -0800
Message-ID: <xmqqlhx8ccu2.fsf@gitster.dls.corp.google.com>
References: <20140214113136.GA17817@raven.inka.de> <87a9dt981o.fsf@igel.home>
	<CACsJy8BevKQaRLYMMv7bTjf_ZAOnkrimws519OyhGZz6_Vr_-A@mail.gmail.com>
	<xmqqy51dirjs.fsf@gitster.dls.corp.google.com>
	<20140215085355.GA15461@lanh>
	<xmqqha7wfdld.fsf@gitster.dls.corp.google.com>
	<871tz0rz3z.fsf@fencepost.gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Duy Nguyen <pclouds@gmail.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
	Josef Wolf <jw@raven.inka.de>,
	Git Mailing List <git@vger.kernel.org>
To: David Kastrup <dak@gnu.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 22:48:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFsWY-0001kL-6K
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 22:48:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751982AbaBRVsM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 16:48:12 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48696 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752545AbaBRVr5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 16:47:57 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 00B266F000;
	Tue, 18 Feb 2014 16:47:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M2hehdp8GuvJrVgfvAqmxWoVcO4=; b=QhLY5n
	EeRn1kVmt1gWO5joogTmM2pKLmhA/SUklXYgrW60u26p7MWD3jDIUllwZGtDaFQ0
	+W7tulUaqJbp9LA1EpI2HJQ/ljvkBCsLofv+1VbeN68kZnhR0FMJYnrL7Vr0Yb/d
	BeFQ2QKbf7yyNPXVwnC7WUeHnb0y2LvliVkxk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=YZeqDtArkton75G+tpK8haZpiDbRT7KA
	ZrbgyySRO28MqMkwSOV1aWMdEy0tlI8Nd9SHD3+qMZNnMo93F1Cd/nJKdauYyyQH
	yh2jpab4vV4sQCDuV1xdBGZRMVwv2cYq3kgaUgWcdZN2PNdLWa+aBKnc6VHviC8k
	K9LZ2wrTUno=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AABDD6EFFC;
	Tue, 18 Feb 2014 16:47:54 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B8FBC6EFF8;
	Tue, 18 Feb 2014 16:47:51 -0500 (EST)
In-Reply-To: <871tz0rz3z.fsf@fencepost.gnu.org> (David Kastrup's message of
	"Tue, 18 Feb 2014 20:37:36 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 50E76850-98E6-11E3-A068-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242362>

David Kastrup <dak@gnu.org> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Duy Nguyen <pclouds@gmail.com> writes:
>>
>>> +	if (!force && dwim_ref(name, strlen(name), sha1, &real_ref))
>>> +		die(_("creating ref refs/heads/%s makes %s ambiguous.\n"
>>> +		      "Use -f to create it anyway."),
>>> +		    name, name);
>>
>> Does this check still allow you to create a branch "refs/heads/next"
>> and then later create a branch "next"?  The latter will introduce an
>> ambiguity without any prevention, even though the prevention would
>> trigger if the order in which these two branches are created is
>> swapped--- the end result has ambiguity but the safety covers only one
>> avenue to the confusing situation.
>>
>> And the only way I can think of to avoid that kind of confusion is
>> to forbid creation of a subset of possible names by reserving a set
>> of known (but arbitrary) prefixes---which I am not sure is a good
>> way to go.  At least not yet.
>
> Just for the record: after seeing the respective arguments, I consider
> it the sanest way.
>
> It's conceivable to give a configuration option for augmenting the set
> of reserved prefixes.  That would allow to adapt the arbitrariness to
> match the policies or ref name choices of a particular project while
> keeping the set of references addressed by the standard git commands in
> check automagically.

I am inclined to say that we should start by just giving a warning
whenever "git branch", "git checkout -b", etc. tries to create a
branch whose name begins with "refs/" and other potentially
ambiguous ones that match ref_rev_parse_rules[].  I personally do
not think people name their branch with a name that begins with
"refs/" on purpose; I am not sure about other ones, like "heads" or
"tags". Personally I think it also is unlikely to want to have these
words immediately followed by a slash in the branch name, so it may
not even be necessary to give them any way to turn off the warning,
which in turn would mean we can promote that warning to an die()
that can be overridable with "--force", but by going that "first
warn and see if people are annoyed" route, we would hopefully find
out soon enough that there may be some people who do want to name
their branches in a funny way ;-)
