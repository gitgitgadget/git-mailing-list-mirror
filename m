From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Performance issue: initial git clone causes massive repack
Date: Tue, 14 Apr 2009 17:52:53 +0200 (CEST)
Message-ID: <alpine.DEB.1.00.0904141749330.10279@pacific.mpi-cbg.de>
References: <alpine.LFD.2.00.0904052315210.6741@xanadu.home> <20090407081019.GK20356@atjola.homenet> <m3tz5023rq.fsf@localhost.localdomain> <alpine.LFD.2.00.0904070903020.6741@xanadu.home> <20090407142147.GA4413@atjola.homenet> <alpine.LFD.2.00.0904071321520.6741@xanadu.home>
 <20090407181259.GB4413@atjola.homenet> <alpine.LFD.2.00.0904071454250.6741@xanadu.home> <20090407202725.GC4413@atjola.homenet> <alpine.LFD.2.00.0904080041240.6741@xanadu.home> <20090410T203405Z@curie.orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Tue Apr 14 17:54:33 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LtkvV-0006Rd-G1
	for gcvg-git-2@gmane.org; Tue, 14 Apr 2009 17:51:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbZDNPuK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2009 11:50:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751715AbZDNPuJ
	(ORCPT <rfc822;git-outgoing>); Tue, 14 Apr 2009 11:50:09 -0400
Received: from mail.gmx.net ([213.165.64.20]:43226 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751784AbZDNPuI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2009 11:50:08 -0400
Received: (qmail invoked by alias); 14 Apr 2009 15:50:06 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp008) with SMTP; 14 Apr 2009 17:50:06 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19qNIwM5dpqHBvhGzk729ZEbDYHXPW5VyxaKHNmNv
	bam/k50uZVguI3
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <20090410T203405Z@curie.orbis-terrarum.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116542>

Hi,

On Fri, 10 Apr 2009, Robin H. Johnson wrote:

> On Wed, Apr 08, 2009 at 12:52:54AM -0400, Nicolas Pitre wrote:
> > > http://git.overlays.gentoo.org/gitweb/?p=exp/gentoo-x86.git;a=summary
> > > At least that's what I cloned ;-) I hope it's the right one, but it fits
> > > the description...
> > OK.  FWIW, I repacked it with --window=250 --depth=250 and obtained a 
> > 725MB pack file.  So that's about half the originally reported size.
> The one problem with having the single large packfile is that Git
> doesn't have a trivial way to resume downloading it when the git://
> protocol is used.
> 
> For our developers cursed with bad internet connections (a fair number
> of firewalls that don't seem to respect keepalive properly), I suppose
> I can probably just maintain a separate repo for their initial clones,
> which leaves a large overall download, but more chances to resume.

IMO the best we could do under these circumstances is to use fsck 
--lost-found to find those commits which have a complete history (i.e. no 
"broken links") -- this probably needs to be implemented as a special mode 
of --lost-found -- and store them in a temporary to-be-removed 
namespace, say refs/heads/incomplete-refs/$number, which will be sent to 
the server when fetching the next time.  (Might need some iterations to 
get everything, though.)

Ciao,
Dscho
