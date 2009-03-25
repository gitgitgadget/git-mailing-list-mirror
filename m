From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Reference for git.git release process
Date: Wed, 25 Mar 2009 12:30:31 -0700
Message-ID: <7viqlxz9go.fsf@gitster.siamese.dyndns.org>
References: <49CA78BF.2020101@fastmail.fm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Raman Gupta <rocketraman@fastmail.fm>
X-From: git-owner@vger.kernel.org Wed Mar 25 20:32:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmYpi-00072U-Fp
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 20:32:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755075AbZCYTaj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 15:30:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754873AbZCYTai
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 15:30:38 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:57295 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753696AbZCYTai (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Mar 2009 15:30:38 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 2A10C9962;
	Wed, 25 Mar 2009 15:30:36 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 694049961; Wed,
 25 Mar 2009 15:30:33 -0400 (EDT)
In-Reply-To: <49CA78BF.2020101@fastmail.fm> (Raman Gupta's message of "Wed,
 25 Mar 2009 14:32:31 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6A371D98-1973-11DE-BCC3-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114652>

Raman Gupta <rocketraman@fastmail.fm> writes:

> One question about the dev process:
>
> 1) I don't see any topic branches available in git.git. Are these
> generally kept in a private repo and/or shared between individual
> developer's public repositories?

I do not answer "generally" part, but in git.git, I do not publish heads
of individual topic branches.  I could, but simply I don't, because that
has been the way I've operated so far, and I am too lazy to change my
configuration.  Also I suspect it would make my life more cumbersome
because I have to prune stale topics from the public repositories from
time to time.

> Some questions about the release process:
>
> 1) After a release is made (master is tagged with vX.Y.Z), is the
> maint branch deleted and recreated from the new release tag? e.g.
>
> git branch -d maint
> git branch maint master

It is rather:

        git checkout maint
        git merge master

which should be the same because the merge should fast-forward, but an
advantage is that it would keep the reflog of 'maint'.

In addition, you can keep older maintenance track around, i.e.

	git branch maint-X.Y.(Z-1) maint
        git checkout maint
        git merge master

so that maintenance releases for even older codebase _could_ be issued
_if_ necessary.

> 2) MaintNotes states:
>
> "After a feature release is made from "master", however, "next" will
> be rebuilt from the tip of "master" using the surviving topics"
>
> Does this mean:
>
> git branch -d next
> git checkout -b next master
> git merge ai/topic1_to_cook_in_next
> git merge ai/topic2_to_cook_in_next

That is more-or-less correct, even though I'd actually do either

	git branch -f next master

or

	git checkout next
        git reset --hard master

instead of deleting and recreating.
