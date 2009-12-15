From: Eric Paris <eparis@redhat.com>
Subject: Re: git-reflog 70 minutes at 100% cpu and counting
Date: Mon, 14 Dec 2009 21:11:51 -0500
Message-ID: <1260843111.9379.86.camel@localhost>
References: <1260822484.9379.53.camel@localhost>
	 <20091214211142.GC9364@coredump.intra.peff.net>
	 <1260825629.9379.56.camel@localhost>
	 <20091214212343.GA11131@coredump.intra.peff.net>
	 <1260827790.9379.59.camel@localhost>
	 <alpine.LFD.2.00.0912141924030.23173@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Dec 15 03:12:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKMtQ-0003f0-Jd
	for gcvg-git-2@lo.gmane.org; Tue, 15 Dec 2009 03:12:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758589AbZLOCL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Dec 2009 21:11:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758231AbZLOCL5
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 21:11:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52188 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756885AbZLOCL4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 21:11:56 -0500
Received: from int-mx04.intmail.prod.int.phx2.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.17])
	by mx1.redhat.com (8.13.8/8.13.8) with ESMTP id nBF2Bqti032535
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
	Mon, 14 Dec 2009 21:11:52 -0500
Received: from [10.11.9.84] (vpn-9-84.rdu.redhat.com [10.11.9.84])
	by int-mx04.intmail.prod.int.phx2.redhat.com (8.13.8/8.13.8) with ESMTP id nBF2Bpp4026515;
	Mon, 14 Dec 2009 21:11:51 -0500
In-Reply-To: <alpine.LFD.2.00.0912141924030.23173@xanadu.home>
X-Scanned-By: MIMEDefang 2.67 on 10.5.11.17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135261>

On Mon, 2009-12-14 at 19:26 -0500, Nicolas Pitre wrote:
> On Mon, 14 Dec 2009, Eric Paris wrote:
> 
> > On Mon, 2009-12-14 at 16:23 -0500, Jeff King wrote:
> > > On Mon, Dec 14, 2009 at 04:20:29PM -0500, Eric Paris wrote:
> > > 
> > > > Updated to git-1.6.5.3-1 from Fedora rawhide and still git reflog ran
> > > > for >5 minutes at 100% cpu (I killed it, it didn't finish)
> > > > 
> > > > I'm pushing a copy of the whole repo (all 1.9G after bzip compression)
> > > > to
> > > > 
> > > > http://people.redhat.com/~eparis/git-tar/
> > > 
> > > Wowzers, that's big. Can you send just what's in .git?
> > 
> > So I zipped up just .git   1.2G.  I did a make clean and zipped up the
> > whole repo  1.3G.
> > 
> > Just started pushing the 1.3G file.
> > 
> > Maybe having a .git directory that large is the problem?
> 
> Shouldn't be, unless your repo is really badly packed.
> 
> What's the output of 'git count-objects -v' ?

count: 87065
size: 866744
in-pack: 1203497
packs: 148
size-pack: 976474
prune-packable: 1611
garbage: 0


It's not home movies   :)  .  It's a kernel trees with about 5
'upstream' trees that are remotes, which I update daily.  One of the
remotes constantly rebases every day starting with Linus' tree and
pulling in about 150+ branches of work from others all of which might
rebase.  I have (needlessly) the tags he keeps of that repo every day.
I daily rebase my work on top of that constantly rebasing tree
(linux-next) using stgit.

I noticed just blindly poking at sizes in my .git/object/pack that the
largest pack is a lot larger than the second and third largest....

-r--r--r-- 1 paris paris 108031039 Feb 12  2009 pack-71a9c0f08c76b8ffd1cf0a14d7cfe991fbc9db80.pack
-r--r--r-- 1 paris paris  32670479 Apr  7  2009 pack-5c8333301012d9b70d70648b287cf540afcc63ed.pack
-r--r--r-- 1 paris paris  26728958 Dec 30  2008 pack-fb8ceb5a33d9881fe771860c6006f55f73ecdf65.pack

And all total there is almost 1G of data in .git/object/pack

If the answer really is that I just have too much data and it can't be
handled, I'm fine exporting my patches getting some clean trees and
starting over till I get in this situation again, but if it really is a
problem/bug that can be solved, the full tar ball of my repo is at

http://people.redhat.com/~eparis/git-tar/

-Eric
