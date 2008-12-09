From: Nicolas Pitre <nico@cam.org>
Subject: Re: git fsck segmentation fault
Date: Tue, 09 Dec 2008 14:09:58 -0500 (EST)
Message-ID: <alpine.LFD.2.00.0812091408560.14328@xanadu.home>
References: <200811271814.06941.simon@lst.de> <200811272021.56108.simon@lst.de>
 <alpine.LFD.2.00.0811271449500.14328@xanadu.home>
 <200811280919.10685.simon@lst.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Martin Koegler <mkoegler@auto.tuwien.ac.at>,
	Git Mailing List <git@vger.kernel.org>
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Tue Dec 09 20:11:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LA7zQ-0001Ha-Vc
	for gcvg-git-2@gmane.org; Tue, 09 Dec 2008 20:11:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754296AbYLITKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Dec 2008 14:10:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753579AbYLITKH
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Dec 2008 14:10:07 -0500
Received: from relais.videotron.ca ([24.201.245.36]:45580 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754293AbYLITKF (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Dec 2008 14:10:05 -0500
Received: from xanadu.home ([66.131.194.97]) by VL-MO-MR001.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KBM00JFNIKM48C0@VL-MO-MR001.ip.videotron.ca> for
 git@vger.kernel.org; Tue, 09 Dec 2008 14:09:59 -0500 (EST)
X-X-Sender: nico@xanadu.home
In-reply-to: <200811280919.10685.simon@lst.de>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102647>


Has this been looked at?  Martin?

On Fri, 28 Nov 2008, Simon Hausmann wrote:

> On Thursday 27 November 2008 Nicolas Pitre, wrote:
> > On Thu, 27 Nov 2008, Simon Hausmann wrote:
> > > On Thursday 27 November 2008 20:10:20 Simon Hausmann wrote:
> > > > On Thursday 27 November 2008 18:47:41 Nicolas Pitre wrote:
> > > > > On Thu, 27 Nov 2008, Simon Hausmann wrote:
> > > > > > Hi,
> > > > > >
> > > > > > when running git fsck --full -v (version 1.6.0.4.26.g7c30c) on a
> > > > > > medium sized
> > > > >
> > > > > That version doesn't exist in the git repo.
> > > >
> > > > Ah, oops, it was a merge commit, corresponding to maint as of 5aa3bd.
> > > >
> > > > > > (930M) repository I get a segfault.
> > > > > >
> > > > > > The backtrace indicates an infinite recursion. Here's the output
> > > > > > from the last few lines:
> > > > >
> > > > > [...]
> > > > >
> > > > > Could you try with latest master branch please?  It is more robust
> > > > > against some kind of pack corruptions that could send the code into
> > > > > infinite loops.
> > > >
> > > > Same problem with git version 1.6.0.4.790.gaa14a
> > >
> > > Forgot to paste the changed line numbers of the recursion:
> >
> > [...]
> >
> > Well... Your initial backtrace showed recursion in unpack_entry() which
> > was rather odd in the first place.  Your latest backtrace shows a loop
> > in make_object() which has nothing to do what so ever with
> > unpack_entry().  So the backtrace might not be really useful.
> >
> > I suspect you'll have to bisect git to find the issue, given that some
> > old version can be found to be good.  For example, does it work with
> > v1.5.2.5?
> 
> Ah yes, v1.5.2.5 works! (phew, and it verified that the repo is fine)
> 
> Ok, I bisected and "git bisect run" identified the following commit as first bad 
> commit:
> 
> commit 271b8d25b25e49b367087440e093e755e5f35aa9
> Author: Martin Koegler <mkoegler@auto.tuwien.ac.at>
> Date:   Mon Feb 25 22:46:05 2008 +0100
> 
>     builtin-fsck: move away from object-refs to fsck_walk
> 
> 
> 
> 
> Simon
> 
