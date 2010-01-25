From: tom fogal <tfogal@alumni.unh.edu>
Subject: Re: mesa_7_7_branch -> master merges
Date: Mon, 25 Jan 2010 12:04:00 -0700
Message-ID: <auto-000021766217@sci.utah.edu>
References: <1264424650.3029.155.camel@jfonseca-laptop>
	<auto-000021765525@sci.utah.edu>
	<1264443264.3029.255.camel@jfonseca-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mesa3d-dev <mesa3d-dev@lists.sourceforge.net>
To: José Fonseca <jfonseca@vmware.com>
X-From: mesa3d-dev-bounces@lists.sourceforge.net Mon Jan 25 20:02:45 2010
Return-path: <mesa3d-dev-bounces@lists.sourceforge.net>
Envelope-to: gcvmd-mesa3d-493@gmane.org
Received: from lists.sourceforge.net ([216.34.181.88])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZUCy-0000Sa-Ur
	for gcvmd-mesa3d-493@gmane.org; Mon, 25 Jan 2010 20:02:45 +0100
Received: from localhost ([127.0.0.1] helo=sfs-ml-1.v29.ch3.sourceforge.com)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <mesa3d-dev-bounces@lists.sourceforge.net>)
	id 1NZUBl-0002fj-4w; Mon, 25 Jan 2010 19:01:29 +0000
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <tfogal@alumni.unh.edu>) id 1NZUBj-0002fb-Jt
	for mesa3d-dev@lists.sourceforge.net; Mon, 25 Jan 2010 19:01:27 +0000
X-ACL-Warn: 
Received: from mail.sci.utah.edu ([155.98.58.79] helo=sci.utah.edu)
	by sfi-mx-2.v28.ch3.sourceforge.com with esmtp (Exim 4.69)
	id 1NZUBg-0007No-Pv
	for mesa3d-dev@lists.sourceforge.net; Mon, 25 Jan 2010 19:01:27 +0000
Received: from dummy.name; Mon, 25 Jan 2010 12:01:17 -0700
In-Reply-To: Your message of "Mon, 25 Jan 2010 18:14:24 GMT."
	<1264443264.3029.255.camel@jfonseca-laptop> 
X-Spam-Score: -0.1 (/)
X-Spam-Report: Spam Filtering performed by mx.sourceforge.net.
	See http://spamassassin.org/tag/ for more details.
	0.0 UNPARSEABLE_RELAY Informational: message has unparseable relay
	lines -0.1 AWL AWL: From: address is in the auto white-list
X-Headers-End: 1NZUBg-0007No-Pv
X-BeenThere: mesa3d-dev@lists.sourceforge.net
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: Mesa developer's list <mesa3d-dev.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=mesa3d-dev>
List-Post: <mailto:mesa3d-dev@lists.sourceforge.net>
List-Help: <mailto:mesa3d-dev-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/mesa3d-dev>,
	<mailto:mesa3d-dev-request@lists.sourceforge.net?subject=subscribe>
Errors-To: mesa3d-dev-bounces@lists.sourceforge.net
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137980>

I think we've touched on a core git workflow issue here, and its likely
others have hit this && have a solution, so I've added the git ML to
the CC list.

Git: the situation in this repo is a fast-moving master that is
including many changes to internal interfaces.  Stable branches just
get bugfixes, and are periodically merged to master.  However, the more
the heads diverge, the more difficult it is for a bugfix to merge into
the head.  The major issue is that more experienced developers should
really weigh in on these merges, because they tend to automagically
undo some of the interface changes.  Yet during such a delay, master
inevitably moves, and the bugfixer has to do even more work to "redo"
the merge (and potentially get more review!).

Of course, if there are two bugfixers trying to make separate changes
in the same time period, this gets worse.

Is there a workflow that can solve this issue?

 writes:
> On Mon, 2010-01-25 at 09:52 -0800, tom fogal wrote:
> > writes:
> > [snip]
> > > The ideal would be to peer-review the merges before committing,
> > > but it seems difficult to do that with git, while preserving merge
> > > history and not redoing merges.
> > 
> > Google has developed an infrastructure to do peer review using git.
> > `Gerrit':
[snip]
> Review infrastructures are nice. I'd have some bias towards
> http://www.reviewboard.org/  by the similar reasons ;)

Heh, yeah I can understand the bias ;)

Personally, I'm not keen on a review tool I can't use from the command
line, or at least not-the-web.  Then again, my reviews wouldn't really
be important in Mesa, so my opinion is irrelevant here ;)

> But automated infrastructures aside, my worry with reviewing merges is
> the actual constraints that git has. For example, let's suppose the
> following scenario:
> 
> 1) Developer A merges a stable branch into master.
> 2) After spending a bunch of time fixing conflicts the best he can, he
> emails the patch to mesa3d-dev for peer review.
> 3) Developer B checks in a change into master.
> 4) Developer A takes feedback from list, updates the code, and commits.
> 5) Developer A cannot push because remote head has moved.
> 
> So what can Developer A do now?
>
> a) Redo the merge, using the new master head.
> b) Rebase the merge on top of the new head (I'm not sure it works, or
> that it preserves branch history)
> c) Double merge, i.e., merge its local head with the new master head.

Hrm, I was thinking of some sort of staging branch, but I can't think
of a good way to make it work.  The crux of the issue seems to be that
a developer needs to somehow give a version control promise that they
will do the merge, even if the merge isn't done yet, because otherwise
anyone else coming afterwards will duplicate the work (potentially
incorrectly).  That would mean some kind of lock though, which sounds
like a terrible idea...

-tom

------------------------------------------------------------------------------
The Planet: dedicated and managed hosting, cloud storage, colocation
Stay online with enterprise data centers and the best network in the business
Choose flexible plans and management services without long-term contracts
Personal 24x7 support from experience hosting pros just a phone call away.
http://p.sf.net/sfu/theplanet-com
