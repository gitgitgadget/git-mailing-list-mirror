From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 1.6.1.3: git merge --no-commit ... DID commit
Date: Wed, 06 Jan 2010 18:13:21 -0800
Message-ID: <7vwrzuhdby.fsf@alter.siamese.dyndns.org>
References: <11785.1262828518@relay.known.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: layer <layer@known.net>
X-From: git-owner@vger.kernel.org Thu Jan 07 03:13:45 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NShsY-00085K-VI
	for gcvg-git-2@lo.gmane.org; Thu, 07 Jan 2010 03:13:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756454Ab0AGCNd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jan 2010 21:13:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755903Ab0AGCNd
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Jan 2010 21:13:33 -0500
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:55862 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754699Ab0AGCNc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jan 2010 21:13:32 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id E83F18E902;
	Wed,  6 Jan 2010 21:13:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=omtFFGHpgXq5B+K/KArm+Jaghcs=; b=LUJHUl
	x6JPybN1lvo6sfi+8F8NYcfk99VkVGiifWcT/v6pFmO0hnmk1nDdlq3S7WqlmHda
	QImbPA4ELKZ6V70DdJatoEbeXnJ80k5BLOOnQGQjs191iROORHPAOiOlTjsdcTSz
	Ugl4+rDyGice/ev7r4nb+zBNR5itN8yNV+zrg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=h9xqGMfbJp59YLjBrWKSR09YZQRaJMso
	SvRj4LEkD5ZMbvJXDt4L1NddfN3r35J7RMpcfgjuDpKS5QUbV6cjOKzuCxUh1U0b
	/xHX+o2iUFKPzYOt9InedmcEPhBidSgSl/wwgVQAx1+2S/32ROOnLaVtOk59nz97
	t+F/Wk3eHR0=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id C332A8E901;
	Wed,  6 Jan 2010 21:13:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id F08998E8FE; Wed,  6 Jan
 2010 21:13:23 -0500 (EST)
In-Reply-To: <11785.1262828518@relay.known.net> (layer@known.net's message of
 "Wed\, 06 Jan 2010 17\:41\:58 -0800")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 3D92FC8E-FB32-11DE-9A40-9D59EE7EF46B-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136314>

layer <layer@known.net> writes:

> quadra% git merge --no-commit duane-acl82/acl82
> Updating 621f935..a94f7fc
> Fast forward
> ...
> quadra% git status
> # On branch acl82
> # Your branch is ahead of 'origin/acl82' by 2 commits.
> #
> nothing to commit (working directory clean)
> ...
> Has this been fixed in a later version?

In short, there is nothing to fix.  You asked it not to create a commit,
and the merge was a fast-forward; there was no new commit created.

When a real merge is involved, e.g. you have this history:

         x---x---x---x---B duane-acl82/acl82
        /
    ---O---o---o---o---A HEAD

telling "--no-commit" to merge creates the state to be committed in your
work tree and the index, notes the fact that the next "git commit" will
record a merge between A and B, and stops.  Hence, "git diff HEAD" will
show the damange merging duane-acl82/acl82 will cause to your current
branch, and then you can "git commit" to record the merge to result in
this history:


         x---x---x---x---B duane-acl82/acl82
        /                 \
    ---O---o---o---o---A---* HEAD

A --no-commit merge followed by committing on your own will result in a
history of the same shape as "merge" without --no-commit will create.

Think what you want to happen if you started from this history:

         x---x---x---x---B duane-acl82/acl82
        /
    ---A HEAD

If "merge --no-commit" left HEAD at A but updated the index and the work
tree to the result of the merge, which would be the same as the tree
recorded by commit B, and prepared to record a merge commit between A and
B, then next "git commit" will not create a history of the same shape as
you would normally get from "merge" without --no-commit, which is:

                           HEAD
         x---x---x---x---B duane-acl82/acl82
        /
    ---A

Instead, you will end up with a history of this shape, with one useless
merge commit:

         x---x---x---x---B duane-acl82/acl82
        /                 \
    ---A-------------------* HEAD

That is why "merge --no-commit" will fast-forward.

If you really want to do this, there is a way to create a history with
such a shape ("git merge --no-ff") but by default it is not recommended
and you need to explicitly ask for it (or configure).  It can also be used
together with --no-commit option.

Often people claim that they want to review before actually merging, but
it is much better to get in the habit of running "git merge topic" first
then inspecting "git diff ORIG_HEAD^ after the fact.  If the result is
undesirable, you can always "git reset --hard ORIG_HEAD" it away.  The
reason it is better is that this will work regardless of the kind of merge
you would end up with; you can reset away a fast-forward using ORIG_HEAD.

Another technique that may be worth learning is to do "git diff ...topic"
before running a merge (notice three dots).
