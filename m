From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] Add multiple workdir support to branch/checkout
Date: Wed, 05 Oct 2011 11:19:17 -0700
Message-ID: <7vzkhf713u.fsf@alter.siamese.dyndns.org>
References: <1317786204-57335-1-git-send-email-jaysoffian@gmail.com>
 <CACsJy8AqYq+YF+rvUp=BBeFUAtUz783iF2jbUp3fO58yLp9ptQ@mail.gmail.com>
 <CAG+J_DygQTD5ibco=-NOiKg0BLgBGFJnvV8zPyhngC2iZv_H8g@mail.gmail.com>
 <7vpqib8jzk.fsf@alter.siamese.dyndns.org>
 <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>, git@vger.kernel.org
To: Jay Soffian <jaysoffian@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 05 20:19:32 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RBW3z-0006gB-9I
	for gcvg-git-2@lo.gmane.org; Wed, 05 Oct 2011 20:19:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933240Ab1JESTV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Oct 2011 14:19:21 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41919 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932812Ab1JESTU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Oct 2011 14:19:20 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C39DB5C7C;
	Wed,  5 Oct 2011 14:19:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=XqjZpMrlzVBLXe/varIV9IWIxnA=; b=n+KFwV
	l7dns+gvpNBIcMoFcwTinM1j9PTmpIH0bK2XZLJl/kXjppEJtx2kqJauwGR3QbKW
	khoG0PbRe90XFrDcnUhHcpEDmmZjlqbASDJU3k+7yH9o6y3CieLRzy+ERK32fUyV
	gthQsscEceLsDMqDJ7xDNipx1GfDAiouHyup0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n2U65kDAUz1DoD9gwlNx8G/B9rPfMK4J
	7gcpfjMoUmXa822EYM7yoPskUe3KDP+hdm2Imc9aKSQ3AXeKqNHkFctshSIb3ef7
	BFv8//M1KVDZYFyGuBOTRFmt6QpqeH36NM6uEy070POV9WQxy4WFjl1SFF8tcdSq
	0GeXtkDgjx8=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id BAE275C7B;
	Wed,  5 Oct 2011 14:19:19 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 280885C7A; Wed,  5 Oct 2011
 14:19:19 -0400 (EDT)
In-Reply-To: <CAG+J_Dz-GXvRbYUXSoyfyHfOO-_BszcOza9x=ysHhmL5YBW-Jw@mail.gmail.com> (Jay
 Soffian's message of "Wed, 5 Oct 2011 13:17:13 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 8A9F96EE-EF7E-11E0-9C43-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182873>

Jay Soffian <jaysoffian@gmail.com> writes:

> Git has survived w/o needing to lock branches till now.

Careful. Git has survived without your patch series till now, as people
learned to be careful when they use separate workdirs and avoid certain
things, to the point that they are not necessarily aware that they are
avoiding them (one good practice is to keep the HEADs of non-primary
workdirs detached).

Does that mean what your patch aims to do is unnecessary? I think not.

> What are these
> use cases we cannot already think of today?

What is important is that we should have learned by now that the "gotchas"
live where we do not immediately see. "Can you tell me what you are missing?"
is a senseless thing to ask.

>> I think "switch_branches()" that updates HEAD to point at a local branch
>> is one good place to lock the branch, but I do not know if it is a good
>> idea to hook the check into the codepaths for deletion of the branch using
>> "branch -[dD]" and check-out of the branch using "checkout $branch". I
>> wonder if it makes sense to add the "checking" hook into much lower level
>> in the callchain, perhaps delete_ref(), rename_ref() and update_ref() to
>> catch attempts to update "your" current branch by other people.
>
> I don't think so. There are lots of ways to shoot yourself in the foot
> at the plumbing level. Besides, this is not about all refs, just local
> branches.
>
> Aside, there's nothing wrong with renaming a checked out branch.

There are pros and cons between hooking at lower level vs higher
level. The advantage of hooking at higher level is you do not risk
breaking low-level operations, but that directly results in allowing the
same low level operations that are unaware of the new requirement higher
level added break it. It also allows other high level operations you
forgot to teach the new requirement break it.

For example, you checkout branch frotz in a workdir, and then in the
primary repository that has nitfol branch checked out, you rename the
frotz branch to xyzzy. The HEAD of workdir still says refs/heads/frotz
that no longer exist. Of course you can break the same way by doing a
"update-ref -d refs/heads/frotz" from the primary repository.

Because you forgot that the high level operation "branch renaming" needs
to be aware of that "this branch is checked out elsewhere" information,
you allowed it to break the workdir. If you hooked into lower level
machinery that is shared, you wouldn't have caused this breakage.
Similarly, if delete_ref() were taught about the new requirement, you
would have covered both "branch -d" and "update-ref -d".

I do not necessarily think that it is a good approach to forbid the same
branch to be checked out in two different places, by the way. One reason
people would want to keep multiple workdirs is so that while they are
still working on a branch and are not yet at a good "stop point" to even
make a temporary commit to get interrupted, they find it sometimes
necessary to be able to build the tip of that same branch and even make a
small in-working-tree fixes (which later will be carried back to the
primary branch). The problem arises only when one of the repositories try
to update or delete the branch while it is checked out in another working
tree.

Can this series be extended/reworked so that:

 - Each branch has multi-value configuration record to note the workdirs
   that it is checked out;

 - Error out (or warn if forced) upon any attempt to update the tip of a
   branch that is checked out in more than one place; and

 - Similarly for renaming or deleting a branch that is checked out in more
   than one place.
   
