From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Merging tags does not fast-forward with git 1.7.9
Date: Thu, 09 Feb 2012 10:05:55 -0800
Message-ID: <7v4nuzyj98.fsf@alter.siamese.dyndns.org>
References: <20120209095415.GA19230@glitch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Domenico Andreoli <cavokz@gmail.com>
X-From: git-owner@vger.kernel.org Thu Feb 09 19:06:04 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RvYNf-0004Wb-Qd
	for gcvg-git-2@plane.gmane.org; Thu, 09 Feb 2012 19:06:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758079Ab2BISF7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Feb 2012 13:05:59 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39614 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757894Ab2BISF6 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2012 13:05:58 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4E6006CB9;
	Thu,  9 Feb 2012 13:05:57 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nLV/u2CbIPqqW+/APzK7AJdLnMs=; b=BUCCcs
	/KeceVpDOBkTCuirCs1rRYJEmskyvsADACpCKHcr0+jRr6rLMToghuaeGjgzIyXA
	7RvHj7J1CBAxJHIx9/f40pEr8LX8X5fZDUlO+ruanHL9q/z+QmWuMiFS8Aj7yHKT
	56RCgbySXgklSyNKTjKmRNYdmTk5evl5ZDgkI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=unMxU7Qm4O/iWXG6axr0VYzvhxnp6v8G
	EV8N3CGb+wbkZJb6VKOqMaDAd3X4AMVbpzuC+3M++qzF3TwaP2mFz0v2L+FzwGZy
	B8TwSX8Svf7pOkMS5yAEVBvsLo37YXHcjw2APo/YvvqlNZd4UqRgVe5j1o5Fj9tD
	6nT055M17ZI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 43FF46CB8;
	Thu,  9 Feb 2012 13:05:57 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id C93E86CB6; Thu,  9 Feb 2012
 13:05:56 -0500 (EST)
In-Reply-To: <20120209095415.GA19230@glitch> (Domenico Andreoli's message of
 "Thu, 9 Feb 2012 10:54:15 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B6DA8B3C-5348-11E1-BAD4-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190300>

Domenico Andreoli <cavokz@gmail.com> writes:

>   with the recent changes in tag merging (I updated git to 1.7.9),
> my usual "git merge v3.X-rcY" command does not fast-forward any more.

Making "merge $tag" always record the signed tag information was the whole
point of the change in 1.7.9, so asking to merge a tag will *not* fast
forward by default anymore.  "git merge v3.X-rcY^0" is a usable workaround
in the meantime; we are also cooking a fix for a typical case where you
ask for "git merge --ff-only v3.X-rcY" explicitly. This errored out
incorrectly, which was discovered and fixed early this week and is cooking
in the 'next' branch. We would like to push it out as part of 1.7.9.1, and
we would need help testing it. The more people test it sooner, the likelier
people will see more solid 1.7.9.1 release sooner.

> The editor is instead fired off and I have to fill the details of a
> merge commit, diverging from mainline as soon as I save and exit.

Yes, that "diverging from mainline" is really bad, and that is why we need
the fix to honor "--ff-only" (which is the way to make sure you do not
diverge) tested quicly so that we can push 1.7.9.1 out.

Thanks.
