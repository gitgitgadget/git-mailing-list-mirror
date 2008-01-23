From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: git filter-branch should run git gc --auto
Date: Wed, 23 Jan 2008 13:00:37 +0000 (GMT)
Message-ID: <alpine.LSU.1.00.0801231256400.5731@racer.site>
References: <1200783050.5724.196.camel@brick> <20080120033737.GA7767@soma> <20080120093436.GA10924@diana.vm.bytemark.co.uk> <7vlk6k8fyp.fsf@gitster.siamese.dyndns.org> <20080121224818.GA8872@untitled> <7vr6gawvkt.fsf@gitster.siamese.dyndns.org>
 <20080122003911.GA16453@hand.yhbt.net> <7vtzl6vd7v.fsf@gitster.siamese.dyndns.org> <BE604744-0D26-4A39-85CE-B5C0C8C00F9E@sb.org> <7v1w89qmw3.fsf@gitster.siamese.dyndns.org> <20080123064430.GD16297@glandium.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, Kevin Ballard <kevin@sb.org>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Wed Jan 23 14:01:16 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JHfEB-0002Ks-KM
	for gcvg-git-2@gmane.org; Wed, 23 Jan 2008 14:01:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752159AbYAWNAq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2008 08:00:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751605AbYAWNAp
	(ORCPT <rfc822;git-outgoing>); Wed, 23 Jan 2008 08:00:45 -0500
Received: from mail.gmx.net ([213.165.64.20]:51507 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751959AbYAWNAo (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2008 08:00:44 -0500
Received: (qmail invoked by alias); 23 Jan 2008 13:00:43 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp018) with SMTP; 23 Jan 2008 14:00:43 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/xnXdV1tTxYYoOVy1qE107QxFcbLkjPAcOXlYOND
	AmN+2VKll5rm/3
X-X-Sender: gene099@racer.site
In-Reply-To: <20080123064430.GD16297@glandium.org>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/71537>

Hi,

On Wed, 23 Jan 2008, Mike Hommey wrote:

> On Tue, Jan 22, 2008 at 06:46:52PM -0800, Junio C Hamano wrote:
> > Kevin Ballard <kevin@sb.org> writes:
> > 
> > > I just glanced at git-filter-branch.sh (and I must say I was 
> > > incredibly surprised to find out it was a shell script) and it seems 
> > > it never runs git-gc or git-repack. Doesn't that end up with the 
> > > same problems as git-svn sans git-repack when filtering a large 
> > > number of commits? I was just thinking, if I were to 
> > > git-filter-branch on my massive repo (in fact, the same repo that 
> > > started this thread, with over 33000 commits in the upstream svn 
> > > repo), even if I just do something as simple as change the commit 
> > > msg wont I end up with thousands of unreachable objects? I shudder 
> > > to think how many unreachable objects I would have if I pruned the 
> > > entire dports directory off of the tree.
> > >
> > > Am I missing something, or does git-filter-branch really not do any 
> > > garbage collection? I tried reading the source, but complex bash 
> > > scripts are almost as bad as perl in terms of readability.
> > 
> > Theoretically yes, and it largely depends on what you do, but 
> > filter-branch goes over the objects that already exists in your 
> > repository, and hopefully you won't be rewriting majority of them.
> > 
> > So the impact of not repacking is probably much less painful in 
> > practice.
> > 
> > But again as I said, it largely depends on what you do in your filter.  
> > If you are upcasing (or convert to NFD ;-)) the contents of all of 
> > your blob objects, you would certainly want to repack every once in a 
> > while.
> 
> I wonder if it wouldn't be possible to have filter-branch use 
> fast-import, so that it would create a pack instead of a lot of loose 
> objects.

Not really; the filters are very much tuned to the index-modification and 
commit process.

And I doubt that the gc --auto would help much; git-filter-branch creates 
gazillions of files, and that is likely to bring performance down.  If, 
that is, you choose _not_ to heed the comment in 
Documentation/git-filter-branch.txt lines 44-46:

	Note that since this operation is extensively I/O expensive, it 
	might be a good idea to redirect the temporary directory off-disk 
	with the '-d' option, e.g. on tmpfs.  Reportedly the speedup is 
	very noticeable.

Ciao,
Dscho
