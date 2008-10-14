From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: Git and tagging hook
Date: Tue, 14 Oct 2008 17:33:37 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0810141708450.19665@iabervon.org>
References: <1223268332.4072.7.camel@localhost> <48E9BB72.2080008@op5.se>  <1223399613.20250.1.camel@localhost> <gcg67d$4o2$1@ger.gmane.org>  <1223484445.4055.8.camel@localhost> <48ECF072.3000506@op5.se>  <20081014172227.GB6931@efreet.light.src>
 <1224007401.4073.40.camel@localhost>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jan Hudec <bulb@ucw.cz>, Andreas Ericsson <ae@op5.se>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org,
	scmbug-users@lists.mkgnu.net
To: Kristis Makris <kristis.makris@asu.edu>
X-From: git-owner@vger.kernel.org Tue Oct 14 23:34:53 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KprXY-0000pb-NI
	for gcvg-git-2@gmane.org; Tue, 14 Oct 2008 23:34:53 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750933AbYJNVdk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2008 17:33:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750879AbYJNVdk
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Oct 2008 17:33:40 -0400
Received: from iabervon.org ([66.92.72.58]:60140 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750812AbYJNVdj (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2008 17:33:39 -0400
Received: (qmail 3690 invoked by uid 1000); 14 Oct 2008 21:33:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 Oct 2008 21:33:37 -0000
In-Reply-To: <1224007401.4073.40.camel@localhost>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98213>

On Tue, 14 Oct 2008, Kristis Makris wrote:

> Jan, thanks for trying to clarify this for me.
> 
> I am working on adding integration support of Git with bug-trackers,
> using Scmbug. There may be an argument here towards/against distributed
> bug-trackers when it comes to Git.
> 
> Maybe there are things here I don't fully understand yet.
> 
> On Tue, 2008-10-14 at 19:22 +0200, Jan Hudec wrote:
> > >>> Kristis Makris wrote:
> > >>>> I want the integration when I apply the tag to a local repository, NOT
> > >>>> only when I push/pull.
> > 
> > Care to explain why that would ever be useful? It's local, which means that:
> >  - the user can take it back without a trace it ever happened (git tag -d or
> >    even git update-ref -d) and
> >  - noone except the user will see it anyway, so it's not like they should
> >    care either.
> 
> I have two use cases:
> 
> (1) A developer maintains besides his local copy a local bug-tracking
> system in which he tracks his changes. We would like to apply various
> verification policies when he commits or tags. For example, for tagging
> we wants to ensure that he tags giving consistent labels to his
> intermediate builds. e.g. as in:
> 
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-CONVENTION-BASED-LABELING
> 
> Or he may want to have Git force him to also supply a log message along
> with a tag, so that he can remember later more accurately why a tag was
> created and what it really captures. Even if Git (or other SCM systems)
> don't natively support log messages on tags. Scmbug plans to implement
> this.

Git supports using tags for a variety of other purposes in addition to the 
traditional ones (for example, you can tag a version as "the changes I'm 
sure of" or "the version I know is broken"; furthermore, your regression 
testing system could give you a tag that tags the commit you sent for 
testing with the test results). The bug tracker integration should only 
care about the traditional use (providing a persistant, human-recognizable 
name for a revision). Actually, it would probably be best, for integration 
with git, to skip tags entirely, and use the hash. With projects using 
git, it is routine to know that the bug was found in some particular 
flawed commit that didn't get tagged.

> http://bugzilla.mkgnu.net/show_bug.cgi?id=219
> 
> 
> (2) I would like to apply various verification policies when work from a
> local repository is finally merged with the central repository. I assume
> there can/will be a central repository, and there is one "software
> product" that is being released somewhere among the many copies.
> 
> When its time to merge local changes to a central repository, the
> verification policies may deem that changes are not acceptable to be
> merged with the mainline. e.g. because log messages are too short,
> commits during the merge are issued against bugs in "a central"
> bugtracker that are either closed, assigned to someone else, or just
> plain wrong bug-numbers that belong to other products:
> 
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-VALID-LOG-MESSAGE-SIZE
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-OPEN-BUG-STATE
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-VALID-BUG-OWNER
> http://files.mkgnu.net/files/scmbug/SCMBUG_RELEASE_0-26-9/manual/html-single/manual.html#VERIFICATION-CHECKS-VALID-PRODUCT-NAME
> 
> (I'm not very clear whether this is how Git works)
> 
> Does someone get to write-up a brand new log comment during the merge
> and the merge totally disregards older log comments ? My understanding
> is that log comments on the local copy are preserved (and will need to
> be mapped to bug-numbers in the central bug-tracker. 

In general, you send to the central repository, and it rejects you if (a) 
a merge would be required; you have to fetch and merge in your local 
repository; or (b) there's something wrong with the changes you're making.

For (a), you make a merge commit and try again; the new commit has a log 
message, but the old commits retain their log messages. For (b), you make 
a different set of commits that does follow the required policy. "git 
rebase -i origin/master" will guide you through this process. In general, 
you do this before sharing your changes with anybody else, or at least 
before sharing them with anyone who cares about the end result, so that 
other people see nice commits. It's also possible to rearrange the changes 
you made in a bunch of local commits into a series that looks nice and 
makes sense and follows the project rules, when your initial work had you 
introducing a lot of silly mistakes and fixing them.

> Thus the local verification policies may need to have already been
> configured to comply with future verification policies of the central
> repository. Else (perhaps considerable) mappings/adjustments will be
> needed during the push to the central copy.

In general, there's a ton of adjustment needed between working on a 
project and pushing to the central location in any system. With git, 
however, version control may be used locally before these adjustments are 
made, and this provides a huge benefit in terms of being able to prepare 
commits just how they should be, and in terms of being able to avoid 
losing work during the adjustments.

In general, you want to have a local understanding of the central 
repository rules, so that you can do this mapping while you don't have 
network, but there's no reason to prevent saving your work before it 
conforms.

	-Daniel
*This .sig left intentionally blank*
