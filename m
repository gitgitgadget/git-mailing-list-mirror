X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Theodore Tso <tytso@mit.edu>
Subject: Re: Cleaning up git user-interface warts
Date: Thu, 16 Nov 2006 11:07:00 -0500
Message-ID: <20061116160700.GA3383@thunk.org>
References: <87bqn9u43s.wl%cworth@cworth.org> <ejdcg5$4fl$1@sea.gmane.org> <Pine.LNX.4.64.0611141633430.2591@xanadu.home> <7vbqn9y6w6.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142007010.2591@xanadu.home> <7v3b8ltq7r.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0611142306090.2591@xanadu.home> <Pine.LNX.4.64.0611150950170.3349@woody.osdl.org> <20061116011411.GB10512@thunk.org> <7vd57of2cv.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
NNTP-Posting-Date: Thu, 16 Nov 2006 16:10:15 +0000 (UTC)
Cc: git@vger.kernel.org, Nicolas Pitre <nico@cam.org>,
	Linus Torvalds <torvalds@osdl.org>
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Content-Disposition: inline
In-Reply-To: <7vd57of2cv.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/31592>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GkjoX-0007al-J4 for gcvg-git@gmane.org; Thu, 16 Nov
 2006 17:10:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1424243AbWKPQKF (ORCPT <rfc822;gcvg-git@m.gmane.org>); Thu, 16 Nov 2006
 11:10:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1424245AbWKPQKE
 (ORCPT <rfc822;git-outgoing>); Thu, 16 Nov 2006 11:10:04 -0500
Received: from thunk.org ([69.25.196.29]:30925 "EHLO thunker.thunk.org") by
 vger.kernel.org with ESMTP id S1424243AbWKPQKB (ORCPT
 <rfc822;git@vger.kernel.org>); Thu, 16 Nov 2006 11:10:01 -0500
Received: from root (helo=candygram.thunk.org) by thunker.thunk.org with
 local-esmtps  (tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1
 (Debian)) id 1Gkjrn-0002Lh-Fs; Thu, 16 Nov 2006 11:13:31 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
 (envelope-from <tytso@thunk.org>) id 1GkjlU-0003gP-7O; Thu, 16 Nov 2006
 11:07:00 -0500
To: Junio C Hamano <junkio@cox.net>
Sender: git-owner@vger.kernel.org

On Wed, Nov 15, 2006 at 08:21:36PM -0800, Junio C Hamano wrote:
> Theodore Tso <tytso@mit.edu> writes:
> > So with Bitkeeper, with "bk pull" there was never any question about
> > which branch ("line of development") you would be merging into after
> > doing a "bk pull", since there was only one LOD, and given that BK had
> > the rule that a within a LOD only one tip was allowed, a "bk pull"
> > _had_ to do do a merge operation.   
> 
> I've never used Bk and I really appreciate your comments here.
> 
> > If you are operating on your local development branch, the reality is
> > that merging is probably not the right answer in the general case,
> 
> I agree, but I wonder why you are pulling/fetching (with or
> without merge) if you are operating on your local development
> branch (implying that you are in the middle of something else).

Well, when I was using BitKeeper, I never would.  Bitkeeper has what
Linus calls the broken "repository == branch" model.  So normally I
would have one repository where I would track the upstream branch, and
only do bk pull into that branch.  I would do my hacking in another
repository (i.e., branch), and periodically keep track wha was going
on in mainline by cd'ing to the mainline repository and doing the bk
pull there.  

The challenge when you put multiple branches into a single repository,
is you have to keep track of which branch you happen to be in.  In the
BK world, this was obvious because it would show up in my shell
prompt:

<tytso@candygram>       {/usr/src/linux-2.6}
2% 

(OK, obviously I'm in the Linux 2.6 upstream repository)

In a system where you need to keep track of what branch you are in via
an SCM-specific local state information, it's easy to get confused and
do a pull when you are in the "wrong" branch, or while you have local
state in your working directory.   

What I currently do (and I'm sure I'm being really horrible and need
to be say 100 "Hail, Linus"'es for penance for not adhering staying in
the one true distributed state of grace) is that I keep an entirely
separate Linux 2.6 git repository just to make sure I never get
confused about what branch I might happen to be in when I do the "git
pull" --- and yeah, I could have used "git fetch", but 3+ years of BK
usage plus Hg usage is hard to get away from.  I'm sure this is where
Linus would say that use of BK and Hg, causes permanent brain damage,
ala's Dijkstra's ofted quoted comment about use of Basic inducing
brain damage....

> I have to disagree with this.  In the simplest CVS-like central
> repository with single branch setup in which many "novice users"
> start out with, there is almost no need for "git fetch" nor
> tracking branch.  You pull, resolve conflicts, attempt to push
> back, perhaps gets "oh, no fast forward somebody pushed first",
> pull again, then push back.  So I am not sure where "you really
> do not want to use pull.  trust me" comes from.

I think the problem is the people who have had years of BK or Hg
experience.  Maybe it's more of a documentation problem; perhaps a
"git for BK" or "git for Hg" users is what's needed.  The problem
though is that while use of BK is definitely legacy, there are going
to be a lot of people who need to use both BK and Hg.   

> It is a different story for people who _know_ git enough to know
> what is going on.  They may be using multiple branches and
> interacting with multiple remote branches, and there are times
> you would want fetch and there are other times you would want
> pull.  But for them, I do think the suggestion would never end
> with "trust me" -- they would understand what the differences
> are.

Well, I think this is where git's learning curve challenges are.  Yes,
for users that are doing the stupidest, most simplistic usage models,
git is quite easy to use.  And I am willing to grant that for people
who are using the deepest, most complicated and most distributed
development, who understand multiple branches and the index, and all
of the deep git plumbing, there's also no problem.

The challenge is in between; to use a car analogy, git has a great
automatic transmision, and an extremely powerful "racing clutch".  But
for someone where the automatic transmission isn't good enough, when
as they start to learn how to use the manual transmission, git's
extremely touchy "racing clutch" is much more difficult master ---
especially in comparison to people who have learned to drive other,
more pedestrian "standard transmission" cars.  So people who try to
use git's racing clutch keep stalling out the car, and some give up in
frustration.

And maybe the problem is one that should be addressed only by lots of
training, but at the moment, that's the reason why I believe a number
of projects have chosen Hg instead of git; they need more than the
"stupid simple" git usage, but if they don't need the extreme power of
git, Hg is simpler for people to learn how to use.  The problem, of
course, comes when later on, the project finds out they really want
git's power, and now they have to deal with the repository conversion
as well as retraining their entire development community.

But hey, maybe this isn't a problem the git community wants to solve;
clearly git is optimized for the Linux kernel development, and maybe
it's too much to ask that it also work well for somewhat less
extremely distributed development models.  But in any case, that's why
I chose Hg for e2fsprogs.  At the time when I made my choice, git was
just too painful to learn how to use its more esoteric features, and
Hg was much closer to BK's model.  (Since then, Hg has added more
functionality, including better multiple branches in a repository
support, and it's gotten more complicated, but it's still much simper
to teach someone how to use Hg than git.)

Regards,

