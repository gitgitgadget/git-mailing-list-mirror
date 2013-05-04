From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Add porcelain command to revert a single staged file to its HEAD state while preserving its staged state
Date: Sat, 04 May 2013 13:01:10 -0700
Message-ID: <7v61yywm49.fsf@alter.siamese.dyndns.org>
References: <CADeMBooSZA4D7YctRpRf+axjcUhkMBaJhkd89nssxZYFKph5sA@mail.gmail.com>
	<87obcryvcw.fsf@hexa.v.cablecom.net>
	<7va9oawmbp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@inf.ethz.ch>, <git@vger.kernel.org>
To: Dimitar Bonev <dsbonev@gmail.com>
X-From: git-owner@vger.kernel.org Sat May 04 22:01:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYidy-00060R-3A
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 22:01:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754519Ab3EDUBO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 4 May 2013 16:01:14 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44223 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753401Ab3EDUBN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 4 May 2013 16:01:13 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BF4BD1B9C0;
	Sat,  4 May 2013 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=58QMi9JRGyZfzYXGxKWDScuzCRI=; b=V5RL6J
	ZqBbz417cS7BxK2eH100D7vNhLE3uws6DeKGTXrLKsqbh1ytCHkJUvzrdyuTCtNX
	oVE0RIyiJ+xKq3/L7U2eEes5SiiLix4D/NVzJhpue/75rOjuI+8h9WhhzSu6l8y1
	x99d0/sfvjD7cRA3BOdGeJtaxLQ7Q/4WxZYAY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=wF6hGBheNoc2w1JNStsxeI1t7WcTo24W
	aSU0kATgawVr/mwMId5xfcNHXQmUvcLKDKiRRa08behnL0lSBVNBUcoGRH+2IiRa
	KGoOhlGri45gHUGx0nswGZVFwKlYYRMBT5aKy/dcUf8UoBKI3LpIeWpUo0hQTW+z
	6ioU+My91/A=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B36C81B9BF;
	Sat,  4 May 2013 20:01:12 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F00741B9BE;
	Sat,  4 May 2013 20:01:11 +0000 (UTC)
In-Reply-To: <7va9oawmbp.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Sat, 04 May 2013 12:56:42 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 5E7F16BE-B4F5-11E2-895F-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223375>

Junio C Hamano <gitster@pobox.com> writes:

> "I have something worth saving, better than HEAD in some way
> (e.g. contains fixes), in my index. I want to keep it while I
> experiment an approach that is unrelated to it, so I want a clean
> slate in the working tree from HEAD without disturbing the index".
>
> At the first glance, that looks like a reasonable thing to ask, but
> after thinking about it a bit more, I am not sure if it really is,
> primarily because it is unclear what you can productively do to the
> end result next.
>
> Suppose you matched the working tree to HEAD while keeping a
> valuable change in the index, and after working for a while, now
> have finished the experiment and have something in your working
> tree.
>
> What is your next move?
>
> If the end result in the working tree were "Nah, this other approach
> does not work, trash it", you can checkout the working tree from the
> index, so nothing is lost.
>
> But if your result is _also_ something worth saving, what would you
> do?  "git add" to update the index will trash the work that was in
> the index, and that is by definition unrelated to what you worked on
> in the working tree (you wanted to start from the version in the
> HEAD, not from the version in the index, so the end result is likely
> to lack the work you saved in the index).
>
> That makes me think that "match working tree from HEAD bypassing
> index" is not a very useful strategy, unless you are expecting a
> failed experiment from the start.
>
> As Thomas said, I think a more reasonable workflow would begin by
> saving the "somewhat worth saving" state you have in your index as a
> WIP commit, i.e.
>
> 	git commit -m wip
>
> When I experiment starting from a clean slate (after saving away
> such a WIP commit), I would then do this:
>
>         git checkout HEAD^
>
> to start at the state before the WIP commit and hack away.  As I do
> not know how the experiment would go when I do this, I often do not
> bother giving the experiment its own branch.
>
> If the experiment does not seem to go in a productive direction, I
> can simply "git reset --hard && git checkout -" to get rid of it.
>
> On the other hand, if its direction shows promise but turns out to
> be more involved than a quick hack, I can at that point decide to
> give it its own branch with "git checkout -b newbranch".  Then I can
> choose to keep working on it, or switch to other tasks after making
> a wip commit on that new branch.
>
> Or if the experiment results in a series of good and straightforward
> changes that should come _before_ that original wip (which happens
> very often), then I could do:
>
> 	git commit ;# maybe more commits.
>       git cherry-pick @{-1} ;# the one stashed away
>       git co -B @{-1}
>
> to update the original branch and come back to it.

Also, if the alternative experiment was really to replace what you
originally did to your index, as a natural extension to the above
workflow, you would omit "cherry-pick" step in the above.  Your
perfected alternative solution will become the true history of the
original branch, discarding the tentative solution in the index.
