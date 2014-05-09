From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Output from "git blame A..B -- path" for the bottom commit is misleading
Date: Fri, 09 May 2014 10:28:19 -0700
Message-ID: <xmqqy4yazwss.fsf@gitster.dls.corp.google.com>
References: <xmqq8uqc2dt5.fsf@gitster.dls.corp.google.com>
	<20140508212647.GA6992@sigill.intra.peff.net>
	<874n10ot2m.fsf@fencepost.gnu.org>
	<20140509001145.GA8734@sigill.intra.peff.net>
	<87zjiro856.fsf@fencepost.gnu.org>
	<20140509152935.GD18197@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri May 09 19:28:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wioaz-0006EF-H3
	for gcvg-git-2@plane.gmane.org; Fri, 09 May 2014 19:28:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932168AbaEIR2Z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 May 2014 13:28:25 -0400
Received: from smtp.pobox.com ([208.72.237.35]:60369 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757094AbaEIR2Y (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 May 2014 13:28:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 26B191557D;
	Fri,  9 May 2014 13:28:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ax4P4znLMi8N+j2ff/lXGRUpCL4=; b=MGanA9
	jFTh4eEy9AKhV8CwnLI2AWm154DnoEBK3WIt2jpOlyplIIPsqoJH0SStf1X9Q1O7
	mFhYEHikkeiHaV3kCqHRYJcLddadEJYK5Xalr9wJ4uy7T0GxjCVTpSll7iKe53vo
	pHUXAgqtu/2Xm9SxuYt3d5UXqWUbh7YOcHBQM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Wq9tF36CHS9e3Xp67leQzC1pFZ86+FYI
	GH+1nb/j8cb7T273D6okdd6FVB99mAnuZjSB7hy6b6UcM325oa18/Wk0tPzeqt2l
	ptcYxhhVSTZquKecUsL7JTpwP1aCXD8mZJtcr6OvNj9I9Rrn44gIWBAP15J3IKE+
	04ZF2iS4gMQ=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1D87F1557B;
	Fri,  9 May 2014 13:28:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D40791556F;
	Fri,  9 May 2014 13:28:20 -0400 (EDT)
In-Reply-To: <20140509152935.GD18197@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 9 May 2014 11:29:35 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 50EE3746-D79F-11E3-88BF-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248593>

Jeff King <peff@peff.net> writes:

> On Fri, May 09, 2014 at 07:04:05AM +0200, David Kastrup wrote:
>
>> Arguably if the user explicitly limited the range, he knows what he's
>> looking at. Admittedly, I don't know offhand which options _will_
>> produce boundary commit indications: there may be some without explicit
>> range limitation, and we might also be talking about limiting through
>> shallow repos (git blame on a shallow repo is probably a bad idea in the
>> first place, but anyway).
>
> Yes, I was thinking mostly of "X..Y" types of ranges, which are probably
> the most common. I hadn't considered shallow repositories, and you can
> also hit the root commit as a boundary if you do not specify --root.
>
> I guess the question still in my mind is: what use does the identity of
> the boundary commit have? That is, whether you know ahead of time where
> the boundary is or not, is there ever a case where knowing its author
> and/or commit sha1 is a useful piece of information, as opposed to
> knowing that we hit a boundary at all?
>
> I could not think of one, but I may simply lack imagination.

Well, the original message was triggered by the same "I could not
think of one" from me ;-).

We may want to flip the default to do a more sanitised version of "-b"
that has been suggested earlier:

>              (                                         103) 
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 104) test_expect_...
>              (                                         105)         test...
>     7bbc458b (Kyle J. McKay  2014-04-22 04:16:22 -0700 106)         git ...
>              (                                         107)         test...
> 
> which does away with the misleading information altogether.

and have another option to show the current default output for those
who would want that information.

But that will be a topic for post 2.0; I should start preparing for
the -rc3 soonish, so I'll stop here.
