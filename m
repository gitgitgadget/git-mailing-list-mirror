From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] branch: new option --will-track
Date: Thu, 17 Dec 2009 16:07:08 -0800
Message-ID: <7vaaxhdu1f.fsf@alter.siamese.dyndns.org>
References: <1260956399-13802-1-git-send-email-cxreg@pobox.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Dave Olszewski <cxreg@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 01:07:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLQNR-0000ZV-Kx
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 01:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751261AbZLRAHV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Dec 2009 19:07:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750907AbZLRAHS
	(ORCPT <rfc822;git-outgoing>); Thu, 17 Dec 2009 19:07:18 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750829AbZLRAHQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Dec 2009 19:07:16 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id A3C3E89066;
	Thu, 17 Dec 2009 19:07:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1fVy39WSbeBIVWpE5vkC0WEngqo=; b=fouhbb
	707b94Adq7OiTBJy78FntbrDXMED2wthFuUX5+WDUAPhIURSn9iQPb9GQ4LcEfLx
	0OE9YIUxThO2L4UfUWVMAjv8HpmjgGtGpVDAoia/wU5AZn0Keml9maHAlCAw/Q5R
	NXldBqJLzOpto6BC6k6p2oZtvKnf0lHU7SWdc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Axpjr6sdl0iJl7XOZaMZs/ldEdfb7fSL
	qQVptE9GQ7xpzdsMVq1LL9KddH+p3iy5HhOnwuqeog2Qv4ud2spPDuXCkXyUeKC9
	kFecyovA/jdGtPgyP/bh0q8dER38DlcamvzCQMOACuknxX7SeZf/hwlCIQuCUilI
	OMsTJl1bTuo=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 7D37C89065;
	Thu, 17 Dec 2009 19:07:12 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AEFCE89064; Thu, 17 Dec
 2009 19:07:09 -0500 (EST)
In-Reply-To: <1260956399-13802-1-git-send-email-cxreg@pobox.com> (Dave
 Olszewski's message of "Wed\, 16 Dec 2009 01\:39\:59 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 4AAF3AA0-EB69-11DE-9ED2-DC0DEE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135390>

Dave Olszewski <cxreg@pobox.com> writes:

> A common question from users creating branches in an environment where
> they intend to push the branch to a shared bare repository, and then
> later pull commits from upstream into the branch that they initially
> created, is how do they create the branch with this tracking info
> already set up.

We try reasonably hard not to force users to make a decision before it
gets absolutely necessary [*1*].  This option seems to only help users who
can decide upfront upon "git branch" time if the branch is worth sharing
with others and if the name of the branch will be the final one, and
people who forget to give this new option when they ran "git branch", or
those who changed their mind as to what the newly created branch with this
option should interact with, will still need to use "git config" to update
the settings.

Not very nice, not because it solves only a part of the problem, but
because it force users to decide early and not change their mind.

Instead perhaps we would want to add an option to retarget an existing
branch any time the user wants, e.g. "git branch --reconfigure"?  Once we
have such an option, people who *can* decide upfront can use that feature
when creating a new branch at the same time.

Also "git pull --remember $there $this" might be a good way to tell the
configuration mechanism from the UI to remember that "I always want to
merge $this branch from $there while on the branch I am currently on", and
its implementation may probably use "git branch --reconfigure" internally.

Having said all that, I am not very interested in topics on the mechanism
that updates or uses these variables, as I tend to avoid relying on them
myself, and instead teach people to spell them out (which seems to foster
better understanding of what goes on, with reduced user confusion).
Hence, I wouldn't claim I have thought things through in this area, and
the above is just me thinking aloud [*2*].


[Footnote]

*1* There are ample examples, ranging from detached HEAD (you do not have
to decide if the experiment you are going to do deserves a separate branch
to store the result permanently) to the separation between commit and push
(what you commit does not have to be perfect and you have a chance to tidy
them up before publishing).

*2* IOW don't take my "I am not interested" as "patches in this area have
little chance of getting applied."
