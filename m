From: "David Jeske" <jeske@willowmail.com>
Subject: Re: policy and mechanism for less-connected clients
Date: Thu, 26 Jun 2008 16:21:20 -0000
Message-ID: <32522.1654064537$1214502239@news.gmane.org>
References: <20080626113710.GD8610@mit.edu>
	<willow-jeske-01l6@3PlFEDjCVAh-01l6rSE7FEDjCYv6>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: "Junio C Hamano" <gitster@pobox.com>, git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Thu Jun 26 19:43:52 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KBvVX-0002Z8-Aw
	for gcvg-git-2@gmane.org; Thu, 26 Jun 2008 19:43:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757459AbYFZRmo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jun 2008 13:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757409AbYFZRmn
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Jun 2008 13:42:43 -0400
Received: from w2.willowmail.com ([64.243.175.54]:60925 "HELO
	w2.willowmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753020AbYFZRmm (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jun 2008 13:42:42 -0400
Received: (qmail 15872 invoked by uid 90); 26 Jun 2008 17:42:38 -0000
X-Mailer: Willow v0.02
Received: from 67.188.42.104 at Thu, 26 Jun 2008 16:21:20 -0000
In-Reply-To: <20080626113710.GD8610@mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86464>


Thanks for pointing out the issue with automatically committing and bisect.
You're right, if I'm going to automatically commit under the covers I should
use stash instead. However, I don't want users to keep a dirty tree, and now
they don't have to.

To use your two-months-without-checkins example.. one of the big problems I
have with cvs/p4 is this notion that I'm not supposed to record my work every
5-50 minutes. I checkin every time my code does something new and the tests
pass. In my own startup projects/companies this is fine, because it's my tree.
As soon as the group policy stops me from checking in every 5-50 minutes, I
painfully make my own branch so I can checkin on my schedule. I'm starting to
witness some users solving this problem in a very libertarian way, by using git
to manage their local changes even though they work in a code-review restricted
cvs/p4 environment.

-- Theodore Tso wrote:
> I'd suggest that you try using git straight for a bit longer, before
> you start drawing these conclusions. Trust me, the concepts of git
> really aren't that hard to explain to people; that's not what you need
> to hide from people coming from the CVS world.  The hard part is the
> fact that git's UI has all sorts of non-linearities and that git's
> documentation and introductory tutorials are not as good as it should
> be.  (Although it's gotten a LOT better than just a year or two ago.)

I agree 100%. I am using git straight. I think I have read more git
documentation and definitely read more git source-code in trying to use it over
a couple months, than I have read of cvs/p4 in decades - just to try to
understand which of the 3 ways to get from here-to-there is correct, and then
when I pull back the red curtain a little further I realize I was totally
wrong.

This started as a "cheat sheet" file with the combination of git commands I had
to execute to perform each task. However, they are only valid in the context of
a git-repo that's configured in certain ways. I realized it would be simpler
(even for just me) if I had something that grouped commands and did 'lint'
sanity checks, with helpful tutorial responses. Thus the wrapper.

> Exactly.  So what I would ask you to consider is that you may find it
> personally useful to design this system,

I see where you're going with this, and I agree...

> but afterwards, before you inflict it on projects, and deal
> with some of the attendent side effects (like all of these trash
> commits causing "git bisect" to go down the drain), that you
> consider whether *now* that you understand how git works and
> why it does some of the things it does, and what the
> shortcomings of the git porcelain are from a UI perspective, whether
> CVS refugees really would be best served by this system you are
> designing, or whether a few wrapper scripts to hide some of the more
> pointy spikes in git's CLI, plus some better tutorials, might in the
> long run be much better for these CVS developers that you are trying
> to serve.

Absolutly. I hope that you can understand my goal of an 'interactive command
line/tutorial linear path from cvs/p4 to git'. One where they don't get stuck
and turn back, but also where they work in ways which are 'fairly reasonable'
in the git community. I also hope you'll help me evaluate whether I've succeed
or just made another confusing set of compromises that are no good. There is no
need for more of the latter.

I also have a group that's been using git and wants to switch back to cvs/p4.
They are willing to give up tracking their local changes (or do it with private
gits) in order to get a simpler model for 'shared head of tree' development. I
think they are a good test-case as well.

------

So far, 1/2 of the lines of my script merely transitional documentation from
p4/cvs to git. As I write more of this prose, I realize that it may be helpful
as transition documentation webpages. However, it is much more than passive
documentation, because if there are 3 steps from here to there, I can look at
the repository and see where the user is, and tell them what they need to do
next.

As one example, I have a command "pending" (like p4 pending) which shows local
changes in my branch (on my inaccessible firewalled machine) which are not on
my origin repo(s). Except that in order for this concept to even make sense, it
first:

- checks if I have an 'origin' for a public repo
- checks that my current branch is tracking an [some]origin
- if it is mapped to a 'myorigin' personal published repo
(because I'm firewalled), it checks that the name of the
branch matches the myorigin/branchname (because it's easier
to think straight if myorigin is a literal copy of my local
repo)
- shows what changes I have which are not submitted to myorigin
and/or origin

If at any step along that path something doesn't check out, it explains what
didn't check out, and has a helpful help-page about ways that I might configure
it so 'pending' can do something useful. Think of it like "git lint" and some
documentation.

That said, it's trickier than I thought, because git is capable of working in
so many ways. (all that complexity isn't there for nothing) Time will tell if I
can strike a useful balance.
