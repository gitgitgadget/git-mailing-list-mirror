From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: Use case (was Re: Should branches be objects?)
Date: Tue, 24 Jun 2014 07:09:32 -0400
Message-ID: <20140624110932.GI14887@thunk.org>
References: <CAK3OfOgskVKs=eUT+EM+GZOjh0p6gxKeDWH-iTt29P1i1d1iZA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	git discussion list <git@vger.kernel.org>,
	Ronnie Sahlberg <sahlberg@google.com>
To: Nico Williams <nico@cryptonector.com>
X-From: git-owner@vger.kernel.org Tue Jun 24 13:09:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WzObh-0000F6-LW
	for gcvg-git-2@plane.gmane.org; Tue, 24 Jun 2014 13:09:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbaFXLJm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2014 07:09:42 -0400
Received: from imap.thunk.org ([74.207.234.97]:54913 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751530AbaFXLJl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2014 07:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=fnlIRd/xZY49a+px6EEpgVq8fJ8F9P2hfmIn9UDAj2w=;
	b=lSz9eeXZipj4O3NS/q3iAu9Eu4D6q3SVo3QUNPqLZ8/rK5aMMn6SII18tPOGQNQxSMOhLDHWRR3FfDtVAUhvlRy99u1XOoQEuR1j88DQd8NcdyS52hMMr7JS2UZWvBxWdoikAJcI8NyKPUyez9Q6nej9xz5RERRY/d32HS8WWXs=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.80)
	(envelope-from <tytso@thunk.org>)
	id 1WzOba-0008SP-GU; Tue, 24 Jun 2014 11:09:38 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id C2AA05808A8; Tue, 24 Jun 2014 07:09:32 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CAK3OfOgskVKs=eUT+EM+GZOjh0p6gxKeDWH-iTt29P1i1d1iZA@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252397>

On Mon, Jun 23, 2014 at 10:20:14PM -0500, Nico Williams wrote:
> 
> Now, suppose that branches were objects.  Then at push time one might
> push with a message about the set of commits being pushed, and this
> message (and time of push, and pusher ID) would get recorded in the
> branch object.  At fetch time the branch objects's histories would be
> pulled (but usually never pushed), and would be available for browsing
> with git log at remotes/<remote>/<branch>.  Each commit of the branch
> object (as it were) would record each logical set of commits.

This seems pretty close to what we have with signed tags.  When I send
a pull request to Linus, I create a signed tag which createscontains a
message about a set of commits, and this message is automatically
included in the pull request message generated with "git
request-pull", and when Linus merges my pull request, the
cryptographically signed tag, along with the message, date of the
signature, etc., is preserved for all posterity.

> Problem: if pushing via an intermediary the push metadat would get
> lost.  This would argue for either a stronger still notion of related
> commits, or none stronger than what exists now (because ETOOMUCH).
> But this branch object concept could also be just right: if pushing
> through a an intermediary (what at Sun was called a project gate) then
> it becomes that intermedirary's (gatekeeper's) job to squash, rebase,
> regroup, edit, drop, reword, ... commits.

With signed tags, the metadata is preserved even when the set of
commits is sent via an intermediary.

It seems the major difference is that it's a pull model, where some
projects seem much happier with a push model.  But that sounds like
what is needed is that someone replaces Linus Torvalds with a shell
script --- namely, an e-mail bot that receives pull requests, checks
the signed tag against an access control list, and if it is an
authorized committer, accepts the pull request automatically (or
rejects it if there are merge conflicts).

Not that I am suggesting for even a second that Linus could be fully
replaced by a shell script.  For example, he handles trivial merge
conflicts, and more importantly, applies a "oh my G*d you must be
kidding" taste filter on incoming pull requests, which I think would
be hard to automate.  Then again, neural networks have automatically
evolved to recognize cat videos, so we can't rule it out in the
future.  :-)

Cheers,

							- Ted
