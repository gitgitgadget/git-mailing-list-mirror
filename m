From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 2/2] rebase -i: use some kind of config file to save
 author information
Date: Tue, 23 Jun 2009 11:40:49 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0906231137220.5252@intel-tinevez-2-302>
References: <20090620023413.3995.3630.chriscool@tuxfamily.org> <7v1vpdqiv2.fsf@alter.siamese.dyndns.org> <alpine.DEB.1.00.0906221117270.4168@intel-tinevez-2-302> <200906230730.01456.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Stephan Beyer <s-beyer@gmx.net>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 23 11:41:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MJ2Uv-0005wq-Cu
	for gcvg-git-2@gmane.org; Tue, 23 Jun 2009 11:41:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbZFWJku (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2009 05:40:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751898AbZFWJkt
	(ORCPT <rfc822;git-outgoing>); Tue, 23 Jun 2009 05:40:49 -0400
Received: from mail.gmx.net ([213.165.64.20]:51818 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751765AbZFWJkt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2009 05:40:49 -0400
Received: (qmail invoked by alias); 23 Jun 2009 09:40:50 -0000
Received: from cbg-off-client.mpi-cbg.de (EHLO intel-tinevez-2-302.mpi-cbg.de) [141.5.11.5]
  by mail.gmx.net (mp004) with SMTP; 23 Jun 2009 11:40:50 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18eFmhY6XYeRqBgqdtxjgK9ufSwqTTmMf4wmYpafy
	5s5jKOc60AvgHF
X-X-Sender: schindel@intel-tinevez-2-302
In-Reply-To: <200906230730.01456.chriscool@tuxfamily.org>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.65
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122082>

Hi,

On Tue, 23 Jun 2009, Christian Couder wrote:

> On Monday 22 June 2009, Johannes Schindelin wrote:
>
> > On Sun, 21 Jun 2009, Junio C Hamano wrote:
> > > Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> > > > On Sat, 20 Jun 2009, Christian Couder wrote:
> > > >> This is better than saving in a shell script, because it will 
> > > >> make it much easier to port "rebase -i" to C. This also removes 
> > > >> some sed regexps and some "eval"s.
> > > >
> > > > It will not make it easier to port "rebase -i" to C, as this is an 
> > > > internal file.  The user is not supposed to touch it at all.  
> > > > Only "rebase -i".  So it would be very easy to just use a 
> > > > different on-disk format when turning "rebase -i" into a builtin.
> > >
> > > "This is an internal file" is just a declaration you are making, and 
> > > the file is observable by anybody after "rebase -i" relinquishes the 
> > > control to let the user sort out the mess.
> >
> > It is an observation I am making.  Sure, the file is observable by the 
> > user.  But it is hidden deep inside .git/ and users who change things 
> > inside .git/ (with the exception of config) are asking for trouble.
> >
> > I really do not see the point of changing the file format _before_ 
> > turning rebase -i into C.
> >
> > Oh, and I do not see the point of turning rebase -i into C before 
> > finally polishing sequencer so it can go into git.git's master.
> 
> The problem with this is that it will take a lot of time to implement 
> the features that have been added to rebase -i since the sequencer 
> stalled, then to polish it, and to get it reviewed and so on, and during 
> that time other features or changes may be implemented by other people.
> 
> So I prefer to use code from the current sequencer (at 
> http://repo.or.cz/w/git/sbeyer.git) to start porting step by step rebase 
> -i to C.

I think that the best way to go forward would be to have something like 
fetch--tool, i.e. a builtin helper that successively takes more and more 
functionality into C.

IMHO a first sensible step would be to implement the commands ("pick", 
"squash", "edit") in such a helper, and call them from do_next().

That should take care of the most difficult part, getting the transition 
started.

But I had the impression that the sequencer started out almost like this, 
but then it also wanted to implement the do_next() and everything.

Ciao,
Dscho
