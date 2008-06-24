From: Junio C Hamano <gitster@pobox.com>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 16:07:57 -0700
Message-ID: <7vod5qa0tu.fsf@gitster.siamese.dyndns.org>
References: <m31w2mlki4.fsf@localhost.localdomain>
 <FmVFerrNVumRho9GZZwRiHrXV_hb12J_P_hSYUBnFhcCFiMGdtdCrg@cipher.nrlssc.navy.mil> <20080624225442.GA20361@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	David Jeske <jeske@google.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Jun 25 01:09:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBHdJ-0004YI-Jy
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 01:09:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752807AbYFXXIM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 19:08:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753761AbYFXXIM
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 19:08:12 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:43985 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750942AbYFXXIL (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 19:08:11 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C71C6938E;
	Tue, 24 Jun 2008 19:08:09 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id D559F938D; Tue, 24 Jun 2008 19:07:59 -0400 (EDT)
In-Reply-To: <20080624225442.GA20361@mit.edu> (Theodore Tso's message of
 "Tue, 24 Jun 2008 18:54:42 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 699AFF0C-4242-11DD-BCB7-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86175>

Theodore Tso <tytso@mit.edu> writes:

> The main reason that I find for reusing a branch name is for my
> integration branch.  I have a script which basically does:
>
> git checkout integration
> git reset --hard origin
> git merge branch-A
> git merge branch-B
> git merge branch-C
> git merge branch-D
>
> I suppose I could have avoided the use of git reset with something
> like this:
>
> git update-index --refresh --unmerged > /dev/null
> if git diff-index --name-only HEAD | read dummy; then
> 	echo "There are local changes; refusing to build integration branch!"
> 	exit 1
> fi
> git update-ref refs/heads/integration origin
> git checkout integration
> git merge branch-A
> git merge branch-B
> git merge branch-C
> git merge branch-D
>
> Instead, I've just learned to be careful and my use of git reset
> --hard is mainly for historical reasons.

This makes it sound as if avoiding "reset --hard" is a good thing, but I
do not understand why.

The reason you have the diff-index check in the second sequence is because
update-ref does not have the "local changes" check either.  You could have
used the same diff-index check in front of "reset --hard".

Moreover, in your original sequence above, doesn't "git checkout
integration" list your local changes when you have any, and wouldn't that
be a clue enough that the next "reset --hard origin" would discard them?

> ...  But the point is, I can very
> easily think of workflows where it makes sense to reuse a branch name,
> most of them having to do with creating integration branches which are
> basically throwaways after I am done testing or building that combined
> tree.

Absolutely.
