From: Theodore Tso <tytso@MIT.EDU>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 09:51:46 -0400
Message-ID: <20080911135146.GE5082@mit.edu>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl> <200809111020.55115.jnareb@gmail.com> <20080911123148.GA2056@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 15:53:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kdmbn-0002f1-Vc
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 15:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbYIKNwH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 09:52:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752674AbYIKNwG
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 09:52:06 -0400
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:55653 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751636AbYIKNwE (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Sep 2008 09:52:04 -0400
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m8BDpmH4017988;
	Thu, 11 Sep 2008 09:51:48 -0400 (EDT)
Received: from closure.thunk.org (c-98-216-98-217.hsd1.ma.comcast.net [98.216.98.217])
	(authenticated bits=0)
        (User authenticated as tytso@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m8BDpkfq020998
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 11 Sep 2008 09:51:47 -0400 (EDT)
Received: from tytso by closure.thunk.org with local (Exim 4.69)
	(envelope-from <tytso@mit.edu>)
	id 1KdmaI-0001ND-NR; Thu, 11 Sep 2008 09:51:46 -0400
Content-Disposition: inline
In-Reply-To: <20080911123148.GA2056@cuci.nl>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95607>

On Thu, Sep 11, 2008 at 02:31:48PM +0200, Stephen R. van den Berg wrote:
> 
> Well, the train of thought here goes as follows:
> 1. Sure, why not add a field (zero or more) at the bottom of the free-form
>    commit message reading like:
> 
>    Origin: bbb896d8e10f736bfda8f587c0009c358c9a8599 ee837244df2e2e4e9171f508f83f353730db9e53
> 
> 2. Add support to cherry-pick/revert to actually generate the field upon
>    demand.

"git cherry-pick -x" already generates the field you want.

> 
> 3. Then add support to prune/gc/fsck/blame/log --graph to take the field
>    into account.
> 

Um, why should "git fsck", or "git prune" or "git gc" need to
understand about this field?  What were you saying about unclean
semantics, again?  I thought you claimed that dangling origin links
were OK?  So why the heck should git fsck care?  And why shouldn't
gc/prune drop objects that are only referenced via the origin link.

> 4. Add support to filter-branch/rebase to renumber the field if necessary.

As we discussed earlier in some cases renumbering the field is not the
right thing to do, especially if the commit in question has already
been cherry-picked --- and you don't know that.  Again, this is why
prototyping it outside of the core git is so useful; it will show up
some of these fundamental flaws in the origin link proposal.

> Well, and after having done steps 1 to 5, the net result is that it
> works almost as if the field is present in the header, except that:
> - It is now at the end of the body in the commit message.
> - It takes more time to find and parse it.

A proof of concept, even if it isn't fully performant, is useful to
prove that an idea actually has merit --- which clearly not everyone
believes at this point.

I'll also note that having a ***local*** database to cache the origin
link is a great way of short-circuiting the performance difficulties.
If it works, then it will be a lot easier to convince people that
perhaps it should be done git-core, and by modifying core git functions.

Alternatively, if you think this is such a great idea, why don't you
grab a copy of the git repository, and start hacking the idea
yourself?  If you have running code, it tends to make the idea much
more concrete, and much easier to evaluate.  Or were you hoping to
convince other people to do all of this programming for you?

						- Ted
