From: Simon Hausmann <simon@lst.de>
Subject: Re: git fsck segmentation fault
Date: Fri, 28 Nov 2008 09:19:09 +0100
Message-ID: <200811280919.10685.simon@lst.de>
References: <200811271814.06941.simon@lst.de> <200811272021.56108.simon@lst.de> <alpine.LFD.2.00.0811271449500.14328@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Fri Nov 28 09:21:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L5yav-0005YT-2e
	for gcvg-git-2@gmane.org; Fri, 28 Nov 2008 09:20:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbYK1ITO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Nov 2008 03:19:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbYK1ITO
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Nov 2008 03:19:14 -0500
Received: from verein.lst.de ([213.95.11.210]:52350 "EHLO verein.lst.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751220AbYK1ITN (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Nov 2008 03:19:13 -0500
Received: from rhea.localnet ([62.70.27.104])
	(authenticated bits=0)
	by verein.lst.de (8.12.3/8.12.3/Debian-7.1) with ESMTP id mAS8J5IF026764
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 28 Nov 2008 09:19:05 +0100
User-Agent: KMail/1.10.3 (Linux/2.6.27-7-generic; KDE/4.1.3; x86_64; ; )
In-Reply-To: <alpine.LFD.2.00.0811271449500.14328@xanadu.home>
Content-Disposition: inline
X-Spam-Score: 1.789 (*) BAYES_60
X-Scanned-By: MIMEDefang 2.39
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/101868>

On Thursday 27 November 2008 Nicolas Pitre, wrote:
> On Thu, 27 Nov 2008, Simon Hausmann wrote:
> > On Thursday 27 November 2008 20:10:20 Simon Hausmann wrote:
> > > On Thursday 27 November 2008 18:47:41 Nicolas Pitre wrote:
> > > > On Thu, 27 Nov 2008, Simon Hausmann wrote:
> > > > > Hi,
> > > > >
> > > > > when running git fsck --full -v (version 1.6.0.4.26.g7c30c) on a
> > > > > medium sized
> > > >
> > > > That version doesn't exist in the git repo.
> > >
> > > Ah, oops, it was a merge commit, corresponding to maint as of 5aa3bd.
> > >
> > > > > (930M) repository I get a segfault.
> > > > >
> > > > > The backtrace indicates an infinite recursion. Here's the output
> > > > > from the last few lines:
> > > >
> > > > [...]
> > > >
> > > > Could you try with latest master branch please?  It is more robust
> > > > against some kind of pack corruptions that could send the code into
> > > > infinite loops.
> > >
> > > Same problem with git version 1.6.0.4.790.gaa14a
> >
> > Forgot to paste the changed line numbers of the recursion:
>
> [...]
>
> Well... Your initial backtrace showed recursion in unpack_entry() which
> was rather odd in the first place.  Your latest backtrace shows a loop
> in make_object() which has nothing to do what so ever with
> unpack_entry().  So the backtrace might not be really useful.
>
> I suspect you'll have to bisect git to find the issue, given that some
> old version can be found to be good.  For example, does it work with
> v1.5.2.5?

Ah yes, v1.5.2.5 works! (phew, and it verified that the repo is fine)

Ok, I bisected and "git bisect run" identified the following commit as first bad 
commit:

commit 271b8d25b25e49b367087440e093e755e5f35aa9
Author: Martin Koegler <mkoegler@auto.tuwien.ac.at>
Date:   Mon Feb 25 22:46:05 2008 +0100

    builtin-fsck: move away from object-refs to fsck_walk




Simon
