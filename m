From: Junio C Hamano <gitster@pobox.com>
Subject: Re: ephemeral-branches instead of detached-head?
Date: Mon, 12 Aug 2013 00:55:13 -0700
Message-ID: <7veh9z1gym.fsf@alter.siamese.dyndns.org>
References: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: David Jeske <davidj@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 12 09:55:25 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V8myK-0007Cr-Kq
	for gcvg-git-2@plane.gmane.org; Mon, 12 Aug 2013 09:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752828Ab3HLHzR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Aug 2013 03:55:17 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33273 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752362Ab3HLHzQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Aug 2013 03:55:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A09CF331DE;
	Mon, 12 Aug 2013 07:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=sCXfKqCaAy0WuZgAK6TAil8DaZA=; b=T2OV32
	4E3LyfSHAVcwJCj8VpcLTQZgNt0cGP0vxbhYdPWzJsxtiYztpLDM/pRKt5PhOlbg
	Knpa3qVyNBvXUBxGrZgkoPuAWOS26Ac3zhap0rtivgLN8f9coZ/0CcvhX+lVLJG1
	MHxSNLWd7lK93NgNaW32pwSbDDkVpGappG3mc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=b7J6MCgCZhE3iwJ+X+htebaI70GJ6FK8
	WJvayFBb8aCA7edtkk7EUxUxnvP9/gxk8+ECFyrxN3BgNqLeHhbshb9WFJPh1TDa
	t1E8lmgTV8t+Nx1n80KkG6Q3ETDEiSQ0lFfQ04RDbo4Iq1Km4bydNKYamMd2e6S1
	pOhcmPUMNik=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 94301331DC;
	Mon, 12 Aug 2013 07:55:15 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E60B2331DA;
	Mon, 12 Aug 2013 07:55:14 +0000 (UTC)
In-Reply-To: <CA+CP9O6on2NXo6o4_0NoULnT8sgUD3pvvkFZvCTM5xKb38qOeA@mail.gmail.com>
	(David Jeske's message of "Mon, 12 Aug 2013 00:25:44 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 85C93CC2-0324-11E3-ADE3-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232171>

David Jeske <davidj@gmail.com> writes:

> I'm asking about (and proposing) this mechanism, because it would
> prevent refs from ever being "accidentally lost", such as occurs in
> the following scenerios..
>
> 1) forgetting to branch a detached head before checkin
> 2) forgetting a head is detached before moving away from it
> 3) forgetting about checkins before a submodule update

As Jonathan mentioned, your local branch namespace _is_ ephemeral in
the larger picture, and you can and should use your regular branches
as such.

I do not think any of the above will be helped by truly epheral
branch that are not consciously named by the end user.

(1) is not a problem at all by itself with detached HEAD.  You can
commit all you want, and the true problem people perceive that comes
from (1) is (2), as they think they would lose commit that way.  But
the thing is, the commits are not lost---they are recoverable from
the reflog of the HEAD itself.  A truely ephemeral branch that users
do not consciously name would be referred to some random string
(your etmp/4324 below) that is just as discoverable as an entry in
the reflog of the HEAD, so you didn't solve any problem here.

I am not sure what you are trying to improve with (3) but I suspect
it is just the same issue between (1) and (2) in the submodule
working tree.  After running a submodule update in the superproject,
you will get into the detached HEAD state in the submodule, and that
state by itself is not a problem at all, but after committing and
then switching to other branch (or to another commit), the history
leading to the tip commit will not be at the tip of any meaningfully
named branch.  That is different from a commit getting lost, and I
do not see how ephemerally created branches with random names would
help people discover these commits better compared to reflog for the
HEAD.

> Also, these "etmp/####" branches would serve as an obvious visible
> reminder in the branch list that a change was checked in that should
> either be merged, named, or discarded.
