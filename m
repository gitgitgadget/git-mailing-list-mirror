From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] push: introduce implicit push
Date: Mon, 15 Apr 2013 02:29:29 -0700
Message-ID: <7vk3o416rq.fsf@alter.siamese.dyndns.org>
References: <1365780835-2853-1-git-send-email-artagnon@gmail.com>
 <7v38uvcrjl.fsf@alter.siamese.dyndns.org>
 <CALkWK0=-GcOF17Q-y-Aqj0ThX5pPQFrriDqoJ2qsr=CS+wUNGA@mail.gmail.com>
 <7vehed7ilu.fsf@alter.siamese.dyndns.org>
 <CALkWK0k6bmjFxTSMAutgu2EjWRZ_cyTU9jZ3Er-aaV78T16RtQ@mail.gmail.com>
 <7vppxw335o.fsf@alter.siamese.dyndns.org> <516BA732.4080405@viscovery.net>
 <7vzjx01cqn.fsf@alter.siamese.dyndns.org>
 <20130415083558.GB2278@serenity.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
	Jonathan Nieder <jrnieder@gmail.com>
To: John Keeping <john@keeping.me.uk>
X-From: git-owner@vger.kernel.org Mon Apr 15 11:29:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1URfjE-0005Bf-PH
	for gcvg-git-2@plane.gmane.org; Mon, 15 Apr 2013 11:29:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934425Ab3DOJ3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Apr 2013 05:29:33 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:50516 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933959Ab3DOJ3c (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Apr 2013 05:29:32 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7BC0F14575;
	Mon, 15 Apr 2013 09:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=jY7HgYVvoGu0AmvdksvBITc0gi4=; b=JVPvrn43RHqmTmP2kJfH
	bn0dtna/BehSlWPlcTnwPvwv/OkF0nG06Exa+y1jma5YhoiQ53J215JEqql/Nwir
	0HR68U7c9gWTzs++UhKbSSzylwWRf+A4gCffGk24bZhXGeJzes79ArKJx1dkLNiS
	ighGKl6Ns77LO5yaKNmaewQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=dYfJBHi/r994xIK9aJRRrk3AHGd8TzbfJ/XRu6c7m84bZE
	XB7bFqS1mnIqE4m00XyWWMMCidbNpEQ8QI7kCnmlN+OM/5TuCcAEOHjivddID1EF
	llttiTuq0MJLiTl4GPUq/AbXAr7ZZa9h4GS4Oc+30Pd8pwRlKQZ/49BnW/oZ8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 72D5814573;
	Mon, 15 Apr 2013 09:29:31 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E6BC314571; Mon, 15 Apr
 2013 09:29:30 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F9DED082-A5AE-11E2-95F5-8341C8FBB9E7-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221209>

John Keeping <john@keeping.me.uk> writes:

> I may be an atypical user, but my expectation currently is that
> branch.<name>.remote is what is used when I run "git push" with no
> additional arguments.
>
> This is probably because whenever I add additional arguments (currently)
> I have to specify where I am pushing to.
>
> So I think breaking user expectations is a red herring here because the
> current behaviour means that users cannot have any expectation of what
> will happen in this case.

The thing is, people _want_ to reuse the knowledge they have already
learned to a situation it does not directly apply to, by finding a
consequence, natural extension of that knowledge, applied to a new
situation.

 - Your "branch.*.remote only kicks in when I do not say either what
   to push or where to push to, so 'git push -- master' won't be
   affected" could be one valid natural extension to your knowledge
   "the config only kicks in when I do not say either".

 - Peff's "'git push' chooses to push to branch.next.remote when I
   am on 'next', so 'git push -- master' run in the same state
   should also push to that place" is another equally valid natural
   extension to his knowledge that "'git push' chooses to push to
   branch.next.remote when I am on 'next'".

 - Ram's and my "branch.master.remote is about what remote my master
   branch integrates with, so no matter where I am, 'git push' that
   does not say where-to should push out my master to that remote"
   is yet another equally valid natural extension to our knowledge
   that ""branch.master.remote is about what remote my master branch
   integrates with".

I do not think it is a red-herring at all. It is not about
"breaking", but "there will be multiple, conflicting and equally
plausible expectations" that makes me worry about unnecessary
confusion.
