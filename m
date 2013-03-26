From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git ate my home directory :-(
Date: Tue, 26 Mar 2013 11:20:58 -0700
Message-ID: <7vfvzit439.fsf@alter.siamese.dyndns.org>
References: <5150C3EC.6010608@nod.at> <20130325214343.GF1414@google.com>
 <7vboa7w2vm.fsf@alter.siamese.dyndns.org>
 <384BCFE976364F1EA6E56306566D003A@PhilipOakley> <51519DA0.4090201@nod.at>
 <20130326145637.GA3822@sigill.intra.peff.net> <5151D589.2000002@nod.at>
 <20130326174059.GA10383@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Richard Weinberger <richard@nod.at>,
	Philip Oakley <philipoakley@iee.org>,
	Jonathan Nieder <jrnieder@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 26 19:21:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UKYV2-0006pd-3O
	for gcvg-git-2@plane.gmane.org; Tue, 26 Mar 2013 19:21:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755308Ab3CZSVD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 Mar 2013 14:21:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45588 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754400Ab3CZSVB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 Mar 2013 14:21:01 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 52C5AACDA;
	Tue, 26 Mar 2013 14:21:00 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=PZ7M5xbH5RuahjcaBwdAxq00/B4=; b=dGG9jP
	WEl+WD6nWr5AJS0CEPt0hRaoBIhbLylW+3+4wSOk4ACY+ijS8Tu9UkLz5/OKJ4kh
	47S8cDdjY8x9JMrGI7vvA5WgAdPqAuGKdJVNyTEGK4MZp5Z8rYWlXk4HFqs8cltg
	JUBkOjDe9Sbnf0JX7iE4T0SOyccvw3puqBg44=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nIYrC2CIvZzRVy6uPcNukPuYjKTVbSyN
	MWlbuOYnJ1jM9teyrAkIn3qob+2Gg6C0Toss9KiaCWKFF3q41G5931ISjbzPcRcK
	+84Z9/sebmUiKYvi3bh+VDe0bBb0IK0dytqXOG4nOVP36phQYbKLqElfCIBpfIIX
	7erlFqI2iJc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 472A7ACD9;
	Tue, 26 Mar 2013 14:21:00 -0400 (EDT)
Received: from pobox.com (unknown [24.4.35.13]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A2A5FACD6; Tue, 26 Mar 2013
 14:20:59 -0400 (EDT)
In-Reply-To: <20130326174059.GA10383@sigill.intra.peff.net> (Jeff King's
 message of "Tue, 26 Mar 2013 13:41:00 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E8C42DD2-9641-11E2-B118-EA7A2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/219175>

Jeff King <peff@peff.net> writes:

> Yes, setting GIT_DIR but not GIT_WORK_TREE has always been a valid way
> to work on a repository where you do not want the working tree polluted
> with your .git file. It's not a common setup, but people do use it.
> E.g., you might keep ~/mail as a git repo, but do not want the presence
> of ~/mail/.git to confuse your mail tools. You can keep ~/git/mail.git
> as just a repository, and do "cd ~/mail && GIT_DIR=~/git/mail.git git
> foo" (or "git --git-dir=~git/mail.git foo").
>
> Later, we introduced GIT_WORK_TREE (and core.worktree), which provided
> another way of doing the same thing (instead of the "cd", you could set
> GIT_WORK_TREE).

A small correction is necessary as the above invites confusion.

When you are in ~/mail/subdir, because GIT_DIR alone does not give
you to specify where the root-level of the working tree is, you had
to "cd .." before running "GIT_DIR=~/git/mail.git git ...".  By
setting GIT_WORK_TREE to point at ~/mail once, you can freely chdir
around inside subdirectories of ~/mail without losing sight of where
the root-level is, and if your ~/git/mail.git is tied to a single
working tree (and that is true in this example, it is always ~/mail),
you can even set core.worktree in ~/git/mail.git/config.

These two mechanisms are *not* about allowing you to run git from
any random place, e.g. "/tmp".

> For the most part, I'd expect setting core.worktree to be the
> simplest for such setups, as once it is set, you can just do "cd
> ~/git/mail.git git foo", and everything should just work.

Yes.

> We could do so now, as long as we provide an escape hatch (and I think
> spelling that hatch as GIT_WORK_TREE=. is probably sane, but I am open
> to other suggestions).

If we were to do so, GIT_WORK_TREE=. would be the most sensible, but
I do not think it is worth breaking.  Why do these people set GIT_DIR
without setting GIT_WORK_TREE in the first place?

That is the source of the confusion.  Perhaps some random but
popular websites are spreading bad pieces of advice?

> The problem is not with "clean", which just happens to be a destructive
> command, but rather with the notion of what the git tree is when you
> provide GIT_DIR.

Yes, "git add ." would happily add random cruft to your index, which
is equally bad.
