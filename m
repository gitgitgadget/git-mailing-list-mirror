From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH] git put: an alternative to add/reset/checkout
Date: Tue, 07 Jun 2011 14:04:55 -0700
Message-ID: <7vvcwh4ako.fsf@alter.siamese.dyndns.org>
References: <20110607200659.GA6177@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Scott Chacon <schacon@gmail.com>,
	Michael Nahas <mike@nahas.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 07 23:05:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QU3Se-0002zm-48
	for gcvg-git-2@lo.gmane.org; Tue, 07 Jun 2011 23:05:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756835Ab1FGVFJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Jun 2011 17:05:09 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:51493 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754070Ab1FGVFI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Jun 2011 17:05:08 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5370C5456;
	Tue,  7 Jun 2011 17:07:17 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5615jlJM87kYDVA7rr8T5KKN7ds=; b=w8Sx0D
	DP/sGLbb+Z7toYfXjXUR4XJ2aChrfbRFVGGugZMKG8D/57L5uhb3yf6F60Ezq7cI
	xE4bKhw2/jHiKcFvMfdbNV6dSwWrjpCtbwcjAWxkbgl4PJWNONECwhMXlyTuNyqW
	WR31UqNq+uQkLCXy/AZz6PH11KKkBDrCHwA5w=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=U3pp1xxKiGOO8ObqyEbNy7fqjRoTq3C7
	rJ+JArRrXH3gTXKcFmUmXf0+BFuXMPn4v0vOTlK1eX9oOeaaB1B+9r8rHNEB7JiS
	2687gdlw8hNh8IoAvKoO2wIF88SKqpwLHHGgSzq+bp6Paa72+IAjLvPBz/5KFiBk
	dFTflsCSuBA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 114F7544D;
	Tue,  7 Jun 2011 17:07:13 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 84C0F5438; Tue,  7 Jun 2011
 17:07:07 -0400 (EDT)
In-Reply-To: <20110607200659.GA6177@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 7 Jun 2011 16:06:59 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1A27F8BC-914A-11E0-A9C1-85C8C023C68D-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175269>

Jeff King <peff@peff.net> writes:

> As you can see, this handles only three typoes of locations: the

Is that a recursive typo, or a typo of type?

> worktree, the index, and an arbitrary commit (really a tree-ish).

> Some other types I've thought of are:
>
>   - stashes; you can already use stashes a source with "stash@{0}". They
>     could also be a destination, chaining to "git stash".

No opinion on this.

>   - branches as destinations; obviously we can't change an existing
>     commit, but what about something like:
>
>       git put WORKTREE BRANCH:foo
>
>     to optionally create a new branch "refs/heads/foo" based on the
>     current HEAD, push changes into a temporary index that matches its
>     tip, and then making a new commit based on top.
>
>     This would serve a similar purpose to stashes, except that they
>     would be named and could operate as full branches. I would find it
>     useful for picking apart a mass of worktree changes into discrete
>     commits.

Should "git put WORKTREE HEAD" be equivalent to "git commit -A" then?

>   - allow multiple destinations, like
>
>      # equivalent to "git checkout --"
>      git put HEAD INDEX,WORKTREE

This is close to going overboard, but OK.

>   - blobs as locations. We could allow something like:
>
>       git put v1.7.5:Makefile WORKTREE:Makefile
>
>     which would be equivalent to
>
>       git put v1.7.5 WORKTREE -- Makefile
>
>     but sometimes matches the user's mental model better. It also allows
>     pulling blobs from index stages, like:
>
>       # Resolve in favor of "ours"
>       git put :2:Makefile INDEX,WORKTREE

More importantly, it would allow people to do things like...

	git put v1.7.5:Makefile WORKTREE:oMakefile
        magicdiff oMakefile Makefile

>   - subtrees as locations. This allows a form of renaming between old
>     versions.
>
>       git put gitgui-0.10.0: WORKTREE:git-gui

This is a natural extension of the above "we could rename" theme, right?

> ...  Of course, it may also just introduce insane
> confusion.

The only worry about confusion is if people incorrectly think these magic
tokens are not mere syntax sugars available only in "put", especially,
they look so similar to "HEAD" which is _not_ syntax sugar and can be used
elsewhere. Other than that, I think this is a nice approach.
