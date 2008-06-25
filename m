From: Theodore Tso <tytso@mit.edu>
Subject: Re: why is git destructive by default? (i suggest it not be!)
Date: Tue, 24 Jun 2008 22:26:10 -0400
Message-ID: <20080625022610.GB20361@mit.edu>
References: <m31w2mlki4.fsf@localhost.localdomain> <FmVFerrNVumRho9GZZwRiHrXV_hb12J_P_hSYUBnFhcCFiMGdtdCrg@cipher.nrlssc.navy.mil> <20080624225442.GA20361@mit.edu> <7vod5qa0tu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brandon Casey <casey@nrlssc.navy.mil>,
	David Jeske <jeske@google.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Boaz Harrosh <bharrosh@panasas.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 04:27:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBKjW-00086c-4l
	for gcvg-git-2@gmane.org; Wed, 25 Jun 2008 04:27:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754208AbYFYC0q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Jun 2008 22:26:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754530AbYFYC0q
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Jun 2008 22:26:46 -0400
Received: from www.church-of-our-saviour.ORG ([69.25.196.31]:60013 "EHLO
	thunker.thunk.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752355AbYFYC0p (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Jun 2008 22:26:45 -0400
Received: from root (helo=closure.thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 4.50 #1 (Debian))
	id 1KBKi6-00009l-CZ; Tue, 24 Jun 2008 22:26:14 -0400
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KBKi2-0005nS-Ku; Tue, 24 Jun 2008 22:26:10 -0400
Content-Disposition: inline
In-Reply-To: <7vod5qa0tu.fsf@gitster.siamese.dyndns.org>
1;1613;0cFrom: Theodore Tso <tytso@mit.edu>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@mit.edu
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86196>

On Tue, Jun 24, 2008 at 04:07:57PM -0700, Junio C Hamano wrote:
> > Instead, I've just learned to be careful and my use of git reset
> > --hard is mainly for historical reasons.
> 
> This makes it sound as if avoiding "reset --hard" is a good thing, but I
> do not understand why.

Well, it was Brandon Casey who was asserting that git reset --hard was
evil, which I generally don't agree with.  I do use workflows that use
it a fair amount, usually because its more convenient to type "git
checkout <foo>; git reset --hard <baz>" than something involving "git
update-ref refs/heads/<foo> <baz>".  The former has more characters
than the latter, and involves more disk I/O since it mutates the
working directory; but it's something about needing to type
"refs/heads/" such that I generally tend to type "git checkout....
git reset".  I can't explain why; maybe it's just psychological.

The reason why I've been thinking that I should change my shell script
from:

	git checkout integration
	git reset --hard <foo>

to:

	git update-ref ref/heads/integration HEAD
	git checkout integration

Is actually because the first tends to touch more files in the working
directory than the second (because if the integration branch is a week
or two old, the git checkout unwinds the global state by two weeks,
and then the git reset --hard has to bring the state back up to
recentcy; the second generally involves a smaller set of files
changing).  That's a very minor point, granted.

> The reason you have the diff-index check in the second sequence is because
> update-ref does not have the "local changes" check either.  You could have
> used the same diff-index check in front of "reset --hard".

Definitely true.  The reason why I don't have this check is because
I'm generally careful and I run a "git stat" to make sure there are no
local changes in the tree before I run the script.

> Moreover, in your original sequence above, doesn't "git checkout
> integration" list your local changes when you have any, and wouldn't that
> be a clue enough that the next "reset --hard origin" would discard them?

... because it's in a shell script; being fundamentally lazy, instead
of typing that sequence over and over again, I've scripted it.  :-)

	     	  	 	     	   - Ted
