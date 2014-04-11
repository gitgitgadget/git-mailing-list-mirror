From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/9] branch: display publish branch
Date: Fri, 11 Apr 2014 12:24:35 -0700
Message-ID: <xmqqsipjsm8c.fsf@gitster.dls.corp.google.com>
References: <1397156686-31349-1-git-send-email-felipe.contreras@gmail.com>
	<1397156686-31349-7-git-send-email-felipe.contreras@gmail.com>
	<CALkWK0mSfsUrSMPMmZ+PNtZ2WBUqN4Swk_e6S1fMGuUoocJSEg@mail.gmail.com>
	<53471d0b4c8dc_d696b12f08c@nysa.notmuch>
	<20140411111750.GA28858@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>,
	Matthieu Moy <matthieu.moy@imag.fr>,
	John Szakmeister <john@szakmeister.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Apr 11 21:24:53 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WYh4F-0005s5-TW
	for gcvg-git-2@plane.gmane.org; Fri, 11 Apr 2014 21:24:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754887AbaDKTYm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Apr 2014 15:24:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35060 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754883AbaDKTYi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Apr 2014 15:24:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2FAB67A190;
	Fri, 11 Apr 2014 15:24:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=qp+gOsGApH0BNlRiT4cNjyEsL+Q=; b=Ex18wM
	yxX7k9unb7jx5ursZEIJvS21oPfhjGxX8B3AFtK2Ke6kRSSlpiDtFkPboYP7QmxJ
	DmMyMfXcaw1M5eWurkm0ME/+Y5p5PNc1AJRvZwVQ6zRpjF9cLhja4K9j7WF0UHeT
	E19PTwZor+RR48BkIltNVLi5Gq/u5nbkmJ2no=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ji+Q29WB9I5I5yCK9BkhjVUC/rRAidtI
	zmTDRxOzn/S1wSvXWRxudk7FNdIU8KXMhkIFOEeEBwcvbBaBCS8K9SDAwCIMZhaH
	qstK+niJkzTyIJ79AYFROk98Yk2HXOpAKYDUFvlkOg6SUoa7j5enkCfZFxpQ3tpk
	rHfyvZPurcA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1AB5E7A18E;
	Fri, 11 Apr 2014 15:24:38 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9DDC27A187;
	Fri, 11 Apr 2014 15:24:36 -0400 (EDT)
In-Reply-To: <20140411111750.GA28858@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 11 Apr 2014 07:17:51 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: EB40BF50-C1AE-11E3-B968-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246133>

Jeff King <peff@peff.net> writes:

> For instance, it looks like your @{publish} requires config like:
>
>   [branch "master"]
>   pushremote = foo
>   push = refs/heads/bar
>
> to operate. Setting "pushremote" affects what "git push" does; it will
> go to the "foo" remote.

OK, and the same thing would happen if branch.*.pushremote is not
set for any branch, but remote.pushdefault is set to 'foo', right?

> But the branch.master.push setting does not do
> anything to "git push".

I am not sure I understand this.  I thought that the desire behind
the branch.*.push is to allow something like:

	... other things in the config ...
	[remote]
        	pushdefault = foo
	[remote "foo"]
		url = ...
        	push = +refs/heads/*:refs/remotes/satellite/*
                fetch = +refs/heads/*:refs/remotes/foo/*
	[branch "master"]
		; pushremote = foo
        	push = refs/heads/bar

so that "git push" on 'master' will override the more generic "all
local branches here will go to their remote-tracking hierarchy for
this satellite" refspec.  And in that sense branch.master.push would
do something to "git push".

I personally think that kind of override adds any more values than
it causes confusion, so I think it is OK not to support such uses of
branch.*.push at all.  A configuration without branch.master.push
may cause "git push" on 'master' to update refs/heads/master at the
remote, and if we fetched from 'foo' immediately after pushing
there, it would come back as refs/remotes/foo/master, and it would
be natural for users to expect that master@{publish} would be
refs/remotes/foo/master in such a case.

If we supported setting branch.master.push to refs/heads/bar, then
master would be pushed as refs/heads/bar over there and it would
come back as refs/remotes/foo/bar here, so I would expect that to be
the value of master@{publish}.

> Only a push refspec (or push.default setting)
> will change that. So the "branch.*.push" must be kept in sync manually
> (perhaps by running "git push -p").
>
> Whereas if @{publish} means "where you would push to", then
> "branch.*.push" does not need to exist at all. The values can be taken
> automatically from the other push settings.
>
> -Peff
>
> PS I first tried just setting "branch.master.pushremote" without setting
>    "branch.master.push". This results in a segfault, as branch_get()
>    assumes that push_name is always set and tries to xstrdup() it.
