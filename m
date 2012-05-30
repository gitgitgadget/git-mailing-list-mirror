From: Junio C Hamano <gitster@pobox.com>
Subject: Re: How to find all the commits that comprise a branch?
Date: Wed, 30 May 2012 12:29:14 -0700
Message-ID: <7vaa0pzcvp.fsf@alter.siamese.dyndns.org>
References: <CAMP44s2kEMK8ik2NTiP4uiN4FPWFNYNJfY5qh5QE_hRH2AiNYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 30 21:29:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SZoaA-0006v3-65
	for gcvg-git-2@plane.gmane.org; Wed, 30 May 2012 21:29:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751269Ab2E3T3S (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 May 2012 15:29:18 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:58732 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751146Ab2E3T3R (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 May 2012 15:29:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B6E638120;
	Wed, 30 May 2012 15:29:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=TF062K2JjhdOZM6jvD00nd8fJTk=; b=Pro8ti
	6JYliEQHJHt4aVcDQmGliA9ONtT66sp5rjGkqf0EgxLQsEHDrRuWLUTrT7BipNaq
	w44V6z2N5XAoZQC3ZwA7l5CcDgRafR85tBqVW+BsquwMmXdbEwgEPbGRgXZMUu8W
	YKREoqxctFJ2l3AlPj1EAW7o95Dyxq9riVsZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tra/uKkmGXD4DotrQ7Ov3G2/xBty5Kj0
	fQVB2bV30z8CyNSVGGPYDlqhC3LYk9ttwv6JR/8PZ3ls0xRKZ8cH1b4ef+F7v8Ge
	yQ8kQpO9y5ggp5VXHhpRKJMbq7a7A5Dsva41S6AzFd3HkkqT+E58rVP/IB3Aa0Ff
	TvMLKBKFjAg=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AE446811E;
	Wed, 30 May 2012 15:29:16 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 352D5811D; Wed, 30 May 2012
 15:29:16 -0400 (EDT)
In-Reply-To: <CAMP44s2kEMK8ik2NTiP4uiN4FPWFNYNJfY5qh5QE_hRH2AiNYA@mail.gmail.com> (Felipe
 Contreras's message of "Wed, 30 May 2012 19:39:28 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: BE93A33A-AA8D-11E1-BA5C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198832>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> Hi,
>
> Basically what I want to do is:
>
>  % git log branch ^<any-other-branch>
>
> IOW; all the commits were 'git branch --contains' would show 'branch'
> and nothing else.
>
> Is there any easy way to do that?

There was "log blah --not --all --exclude-ref=refs/heads/blah"
discussion a few months ago, but I do not think anything came out of
it.

This is a tangent, but it would be a good way to find out set of
commits that you would lose and need to go to reflog to find if you
were to delete the branch.

It however is a poor definition for "commits that comprise a branch";
I actually am not sure if the concept has a sensible definition.

Let's think aloud with a few examples.

You may be done with your "work" branch and merge it to "master".
At that point, do you think you no longer have any commit that
comprises your "work" branch?

You could argue that "work" branch is no longer relevant because it
is part of "master", and it is an understandable viewpoint.

But imagine what happens when you find a bug in your "work" and want
to fix it up by queuing a correction on your "work" branch (not
directly on "master", because your "work" branch was forked from
"maint" and you eventually want to merge it there as well).  Now, is
the single fix-up commit the only commit that comprises your "work"?

Suppose you have 5-patch series in your "work" branch, two commits
at the bottom of which are useful refactoring of existing code.  I
fork from the second commit to take advantage of your refactoring to
work on something entirely different.  These two branches now share
the bottom two commits.  At this point, do you have only three
remaining commits on your "work" branch?  Wouldn't we rather want to
say that I am merely borrowing two commits from you and you still
have 5 commits that is what your "work" branch consists of?
