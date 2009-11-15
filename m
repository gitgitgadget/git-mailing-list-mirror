From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3] Add branch management for releases to gitworkflows
Date: Sun, 15 Nov 2009 01:14:53 -0800
Message-ID: <7vy6m8p2sy.fsf@alter.siamese.dyndns.org>
References: <1258055164-11876-1-git-send-email-rocketraman@fastmail.fm>
 <1258055164-11876-2-git-send-email-rocketraman@fastmail.fm>
 <20091114071946.6117@nanako3.lavabit.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: rocketraman@fastmail.fm, git@vger.kernel.org,
	trast@student.ethz.ch, gitster@pobox.com
To: Nanako Shiraishi <nanako3@lavabit.com>
X-From: git-owner@vger.kernel.org Sun Nov 15 10:15:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N9bCY-0003aZ-A6
	for gcvg-git-2@lo.gmane.org; Sun, 15 Nov 2009 10:15:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752471AbZKOJPE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Nov 2009 04:15:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752465AbZKOJPE
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Nov 2009 04:15:04 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:47880 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752459AbZKOJPA (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Nov 2009 04:15:00 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7222C9923F;
	Sun, 15 Nov 2009 04:15:06 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=0Em2S1wAnQ6pUL/ENAZbEOBaaWk=; b=eJuy/aN3ju7i3Ge6T2fkHYN
	t6PkAoU0oCge6manysjYXEGO4LIXp2qdhLMGt9MQMM4RXNls/ac/PArvjhST1DMc
	spTKzyZgSPKlZEZDJsp8xILJzjc+pHF+FmULJ4hx+dRPfmgZWmdHqSlviuod1AlG
	CkTbwKWYJC4aiWG69Uoc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=H6yl1C/XLmHQTnTmALmpb7iNTa2ornISShQHNjbyEf2POhGDn
	CP8Nt+vrIQ1lxtIfZdPm0ADGCTXn8mHq7JmK55iKmhFcMzDjNStiqcvmCacePfLu
	iGg68G+RMx7enlS+HKSbL7uTmgpb9YrRjrOWQV/+iUgY07phty9rlsLezU=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 334189923E;
	Sun, 15 Nov 2009 04:15:02 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 7536199239; Sun, 15 Nov 2009
 04:14:55 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 5AEA0CDA-D1C7-11DE-91A7-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132923>

Nanako Shiraishi <nanako3@lavabit.com> writes:

> Other minor clarifications in the text are also included in this change:
>
>  * Clarify "building documentation" a bit; the post-update hook
>    creates preformatted documentation pages.
>
>  * The latest documentation set uses "fast-forward", not "fast
>    forward".
>
>  * Call 'next' branch an integration branch, not a "testing" branch, to be
>    consistent with the Graduation section.
> ...
> Signed-off-by: Nanako Shiraishi <nanako3@lavabit.com>
> ---

Your changes look mostly fine.

I obviously agree with the removal of "use 'branch -f' to update maint"
which I said I do not want to see in the document number of times.

There is another thing; I didn't notice it in the earlier round but the
way I actually rotate 'master', 'maint' and the 'maint-one-rev-old' is
similar to how Thomas mentioned.  That is:

================================
git checkout master
git log ..maint        ;# should see nothing
git tag ...            ;# release task
git checkout maint
git branch maint-X.Y.Z ;# without -f so that I can catch a typo to
                          clobber what already exists
git merge --ff-only master
================================

My fingers are trained to type "git merge" before --ff-only was invented,
so I actually do use "merge master" without --ff-only option in the last
step, but if I see a real merge created with that command, I notice it and
treat it as a grave error, so in the Recipe we should say --ff-only.
