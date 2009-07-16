From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: auto-merge after push?
Date: Thu, 16 Jul 2009 10:01:39 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0907160953580.3155@pacific.mpi-cbg.de>
References: <20090511142326.GA18260@redhat.com> <alpine.DEB.1.00.0905111714250.4973@intel-tinevez-2-302> <20090511201705.GA21045@redhat.com> <alpine.DEB.1.00.0905112302130.27348@pacific.mpi-cbg.de> <20090611104020.GA12036@redhat.com> <20090711203831.GA10875@redhat.com>
 <alpine.DEB.1.00.0907120441440.3155@pacific.mpi-cbg.de> <7vocrplhbv.fsf@alter.siamese.dyndns.org> <20090715145430.GB9075@redhat.com> <7v1vohg2vf.fsf@alter.siamese.dyndns.org> <20090715195718.GA12033@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
X-From: git-owner@vger.kernel.org Thu Jul 16 09:59:47 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRLsX-00080f-P8
	for gcvg-git-2@gmane.org; Thu, 16 Jul 2009 09:59:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753174AbZGPH7h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Jul 2009 03:59:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753162AbZGPH7h
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Jul 2009 03:59:37 -0400
Received: from mail.gmx.net ([213.165.64.20]:38384 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753082AbZGPH7g (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Jul 2009 03:59:36 -0400
Received: (qmail invoked by alias); 16 Jul 2009 07:59:35 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp041) with SMTP; 16 Jul 2009 09:59:35 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/XwLEaMrDXwFt2snf2GwAINqRfhGJSeBDoxngD0+
	t7wklM+SH1N2Wz
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090715195718.GA12033@redhat.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.6
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123381>

Hi,

On Wed, 15 Jul 2009, Michael S. Tsirkin wrote:

> On Wed, Jul 15, 2009 at 12:31:00PM -0700, Junio C Hamano wrote:
> > "Michael S. Tsirkin" <mst@redhat.com> writes:
> > 
> > > So, let me summarize the issues:
> > > - if the tree is pushed into while files are being actively read
> > >   (e.g. built from), the build will get an inconsistent state
> > > - even worse if one of the files is open for editing or is being written
> > >   into: the file will get corrupted
> > > - if there are uncommitted changes in the tree, the push is denied
> > >
> > > Are there others?
> > 
> >  - If you choose to detach-on-push, the user who _thought_ was advancing
> >    the history of a branch using the work tree will get very confusing
> >    results.  The branch will be advanced by the push, and the work tree
> >    user is required to notice the situation, later at some point merging
> >    the work done in the work tree that went to the detached HEAD state.
> 
> I never use detach on push. Let's remove that option for now?

I do not use it.  But I added it upon explicit request.

> >  - What happens if the automerge gets conflict?
> 
> push is denied, unless you push with -f, then I think you get the new
> head.  Note that merge is not the right word here: only fast forward is
> done I think.  Right, Dscho?

Lemme look at that patch (it is pretty old by now...).

Actually, my patch has nothing to do with allowing only fast-forwards 
unless the push is forced.

The documentation states that a read-tree -u -m HEAD is performed.  This 
can fail when a file is not up-to-date.  As far as I can tell, read-tree 
-u -m HEAD refuses to update the index in such a situation.

So if there are files to be updated by the push which are dirty, the push 
will update the ref as requested, nevertheless error out, the index will 
be untouched, and so will be the working directory (unless I fscked up the 
patch, which is quite possible, as I was writing this just to get a 
quieter mailing list again).

One thing I got right, though, was the commit message.

> > Having said that, I think it is a _wrong_ approach to try summarizing 
> > the issues along these lines, without stating the most fundamental 
> > restriction.
> 
> Sure. I am just trying to figure out all the details before I try to 
> write this up. The coordination issue is obviously the main thing, I was 
> trying to enumerate the less obvious ones.

Happily enough, it is the duty of the local guy to actually set the config 
variable.  And to allow the other guy (who might be one and the same guy a 
la "I am schizophrenic and me too") is also the privilege of the local 
guy.

Ciao,
Dscho
