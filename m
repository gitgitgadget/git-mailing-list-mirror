From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Possible regression in master? (submodules without a "master" branch)
Date: Thu, 27 Mar 2014 12:39:03 -0700
Message-ID: <xmqqwqffctyg.fsf@gitster.dls.corp.google.com>
References: <CALKQrgeRJRoyC-UV7J98U1qQfqEFr_H1sEfAWd0GbstZagUisw@mail.gmail.com>
	<xmqqob0ref3v.fsf@gitster.dls.corp.google.com>
	<5334606F.5010109@web.de> <20140327185405.GS4008@odin.tremily.us>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Johan Herland <johan@herland.net>,
	Git mailing list <git@vger.kernel.org>
To: "W. Trevor King" <wking@tremily.us>
X-From: git-owner@vger.kernel.org Thu Mar 27 20:39:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WTG8z-00051Z-F4
	for gcvg-git-2@plane.gmane.org; Thu, 27 Mar 2014 20:39:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755170AbaC0TjL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Mar 2014 15:39:11 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:46562 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754643AbaC0TjH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Mar 2014 15:39:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D58E877CC7;
	Thu, 27 Mar 2014 15:39:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wpkdG7Hel9K93YDxDnEiyL1OxDE=; b=BJB8dE
	6EDYVrhWQZBha9+31wIka1YhwXOkk7JwpITgGh/r7l7ybCcVSo57snerE3ZEswLG
	/KuXgl2oadLwoUH2lhMdqu0XE68ZjsSEDqe309qK6V41SRLiaa8N9JtJ9Zvh/p1T
	rEYW1CBdYAOEWZauwu7EZ6hGs4STqxe3Yx9KY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=f4CV9JJLQizQE0SSFlImvN6H5Q4f4ukP
	wepQbzVWs57m7C+FJ08BKlaZ5JINR6yy7n0wBBzhy6Xm/YQJCxMC3MYa3LpcAJeP
	7ES/FF1hES34QlJkomp+USgdMST9t8pw25+YyVF8bKxBkCP2dOdT/Y3xfTWkRqIs
	8GjNz8x6fNA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C497877CC6;
	Thu, 27 Mar 2014 15:39:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 660A777CC3;
	Thu, 27 Mar 2014 15:39:05 -0400 (EDT)
In-Reply-To: <20140327185405.GS4008@odin.tremily.us> (W. Trevor King's message
	of "Thu, 27 Mar 2014 11:54:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 74E22E0C-B5E7-11E3-81B7-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245321>

"W. Trevor King" <wking@tremily.us> writes:

> On Thu, Mar 27, 2014 at 06:31:27PM +0100, Jens Lehmann wrote:
>> Am 27.03.2014 18:16, schrieb Junio C Hamano:
>> > Johan Herland <johan@herland.net> writes:
>> > 
>> >> I just found a failure to checkout a project with submodules where
>> >> there is no explicit submodule branch configuration, and the
>> >> submodules happen to not have a "master" branch:
>> >>
>> >>   git clone git://gitorious.org/qt/qt5.git qt5
>> >>   cd qt5
>> >>   git submodule init qtbase
>> >>   git submodule update
>> >>
>> >> In current master, the last command fails with the following output:
>> > 
>> > ... and with a bug-free system, what does it do instead?  Just clone
>> > 'qtbase' and make a detached-head checkout at the commit recorded in
>> > the superproject's tree, or something else?
>> 
>> After reverting 23d25e48f5ead73 on current master it clones 'qtbase'
>> nicely with a detached HEAD.
>
> Fixing this for initial update clone is pretty easy, we just need to
> unset start_point before calling module_clone if
> submodule.<name>.branch is not set. 

There is this bit for "update" in git-submodule.txt:

  For updates that clone missing submodules, checkout-mode updates
  will create submodules with detached HEADs; all other modes will
  create submodules with a local branch named after
  submodule.<path>.branch.

  [side note] Isn't that a typo of submodule.<name>.branch?

So the proposed change is to make the part before semicolon true?
If we are not newly cloning (because we already have it), if the
submodule.<name>.branch is not set *OR* refers to a branch that does
not even exist, shouldn't we either (1) abort as an error, or (2) do
the same and detach?

> However, that's just going to
> push remote branch ambiguity problems back to the --remote update
> functionality.  What should happen when submodule.<name>.branch is not
> set and you run a --remote update, which has used:
>
>     git rev-parse "${remote_name}/${branch}"
>
> since the submodule.<name>.branch setting was introduced in 06b1abb
> (submodule update: add --remote for submodule's upstream changes,
> 2012-12-19)?

Isn't --remote about following one specific branch the user who
issues that command has in mind?  If you as the end user did not
give any indication which branch you meant, e.g. by leaving the
submodule.<name>.branch empty, shouldn't that be diagnosed as an
error?

> gitmodules(5) is pretty clear that 'submodule.<name>.branch' defaults
> to master (and not upstream's HEAD), do we want to adjust this at the
> same time?

That may be likely.  If the value set to a configuration variable
causes an established behaviour of a program change a lot, silently
defaulting that variable to something many people are expected to
have (e.g. 'master') would likely to cause a usability regression.

>> > If an existing set-up that was working in a sensible way is broken
>> > by a change that assumes something that should not be assumed,
>> > then that is a serious regression, I would have to say.
>> 
>> Yes, especially as it promised to not change this use case.
>
> Sorry.  A side effect of relying too much on our existing
> documentation and not enough on testing actual use cases.  I can work
> up some non-master submodule tests to go with the fix.

I was wondering if we need to revert the merge with that
branch out of 'master', or submodule folks can work on a set of
fixes to apply on top.

Will wait to see how it goes.  Thanks.
