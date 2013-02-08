From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Proposal: branch.<name>.remotepush
Date: Thu, 07 Feb 2013 22:08:48 -0800
Message-ID: <7vliaz49sf.fsf@alter.siamese.dyndns.org>
References: <CALkWK0nA4hQ0VWivk3AVVVq8Rbb-9CpQ9xFsSOsTQtvo4w08rw@mail.gmail.com>
 <20130208044836.GC4157@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Git List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Feb 08 07:09:17 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U3h9A-00080B-A6
	for gcvg-git-2@plane.gmane.org; Fri, 08 Feb 2013 07:09:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945997Ab3BHGIx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2013 01:08:53 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:59928 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750981Ab3BHGIw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2013 01:08:52 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF90979B3;
	Fri,  8 Feb 2013 01:08:51 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=hddZHakaaWXjx2Z2r8u/A4l2SNY=; b=P27v0t
	jIKUNm5/JSyIBvgKP2ToMXZO34symEyKCUbAHRPieVuCKMmrfzinaLaYxjrfx9Jg
	lS6vklB7PJ3WcO3JGJYXCxu/jnJuRUHkLK1f6EKQC5SGPeq0boGa8bNfJ5LJFSQy
	SlDY4oM3jJKnei3RLn+ifigRun4f1AfeSMtpk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=P0M8R2ExSLDluCT0YPSQ3vfybQfpQWjg
	APOfYtgaspXOEiaTq5Bv+BaXg+X+TVrz/1Z1Lldr9+gEZV9m7DOM6gAAIXWvfvyr
	fsC9c9kByYwvXCT/Q8nO8QJGAqEt1wKpfc+IK7Y3xD2qotO2FO0Od4MNZ6w3VaAb
	c8eaNBiPjkg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B39D879B2;
	Fri,  8 Feb 2013 01:08:51 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1A7AC79B1; Fri,  8 Feb 2013
 01:08:50 -0500 (EST)
In-Reply-To: <20130208044836.GC4157@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 7 Feb 2013 23:48:36 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 024D859C-71B6-11E2-AA79-BCD12E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215755>

Jeff King <peff@peff.net> writes:

> On Thu, Feb 07, 2013 at 09:44:59PM +0530, Ramkumar Ramachandra wrote:
>
>> This has been annoying me for a really long time, but I never really
>> got around to scratching this particular itch.  I have a very common
>> scenario where I fork a project on GitHub.  I have two configured
>> remotes: origin which points to "git://upstream" and mine which points
>> to "ssh://mine".  By default, I always want to pull `master` from
>> origin and push to mine.
>
> Same here. Even without GitHub, working on git.git I treat Junio as my
> "origin", but push to a publishing point.

The "you fetch from and push to the same place" semantics that
associates a branch to a single remote was primarily done for people
coming from CVS/SVN background [*1*].  I think the triangle
arrangement where you want to have "this is where I fetch from and
integrate with, and that is where I publish" is more common among
the Git users these days.

How best to express the triangle is somewhat tricky, but I think it
is sensible to say you have "origin" that points to your upstream
(i.e. me), and "peff" that points to your publishing point, in other
words, make it explicit that the user deals with two remotes.  Then
have push.default name the remote "peff", so that "git push" goes to
that remote by default (and have "git fetch/pull" go to "origin).
You will have two sets of remote tracking branches (one from "origin"
that your push will never pretend to have fetched immediately after
finishing, the other from "peff" that keeps track of what you pushed
the last time).

Of course, some people may have "I use this and that branches to
interact with upstream X while I use these other branches to
interacct with upstream Y, and all of them push to different
places", and supporting that may need complex per branch "On this
branch fetch from and integrate with remote X, and push to remote Z"
settings, but as you said, "I fetch from and integrate with X, and
result is pushed out to Y" should be the most common, and it would
be desirable to have a simple way to express it with just a single
new configuration variable.


[Footnote]

*1* It also happens to work reasonably well for people like Linus
and I with the "I pull from random places, I locally integrate and I
publish the results" workflow, because we are trained to think that
it is not just being lazy but simply meaningless to say "git pull"
without saying "fetch and integrate _what_ and from _whom_", and
that is only because we do not have a fixed upstream.  Linus and I
would practically never fetch from "origin", i.e. from ourselves.
