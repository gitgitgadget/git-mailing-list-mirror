From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: Query remote repository files, blobs
Date: Sat, 19 Dec 2009 21:50:39 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0912192148360.4985@pacific.mpi-cbg.de>
References: <d16b1c80912182345h4163430bv810adb860575d67a@mail.gmail.com> <alpine.DEB.1.00.0912191159280.4985@pacific.mpi-cbg.de> <19244.54684.250532.801766@lisa.zopyra.com> <20091219192415.GC10687@spearce.org> <4B2D3AB1.5000504@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Bill Lear <rael@zopyra.com>,
	Shakthi Kannan <shakthimaan@gmail.com>, git@vger.kernel.org
To: A Large Angry SCM <gitzilla@gmail.com>
X-From: git-owner@vger.kernel.org Sat Dec 19 21:45:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NM6BZ-00049i-NS
	for gcvg-git-2@lo.gmane.org; Sat, 19 Dec 2009 21:45:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753435AbZLSUpx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Dec 2009 15:45:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753411AbZLSUpx
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Dec 2009 15:45:53 -0500
Received: from mail.gmx.net ([213.165.64.20]:46017 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753376AbZLSUpw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Dec 2009 15:45:52 -0500
Received: (qmail invoked by alias); 19 Dec 2009 20:45:50 -0000
Received: from pacific.mpi-cbg.de (EHLO pacific.mpi-cbg.de) [141.5.10.38]
  by mail.gmx.net (mp006) with SMTP; 19 Dec 2009 21:45:50 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX181vmM99b81Eq+jeVF1c6fM9vq3I8QOvAWCc4r4AM
	9N9GEalub4xtuU
X-X-Sender: schindelin@pacific.mpi-cbg.de
In-Reply-To: <4B2D3AB1.5000504@gmail.com>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.5600000000000001
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135501>

Hi,

On Sat, 19 Dec 2009, A Large Angry SCM wrote:

> Shawn O. Pearce wrote:
> > Bill Lear <rael@zopyra.com> wrote:
> > > On Saturday, December 19, 2009 at 12:02:02 (+0100) Johannes Schindelin
> > > writes:
> > > > On Sat, 19 Dec 2009, Shakthi Kannan wrote:
> > > > ...
> > > > > I am able to query for list of remote heads, and tags. I would like to
> > > > > know if it is possible to query for information on remote files, or
> > > > > blobs?
> > > > This has been discussed a number of times, but we cannot allow that for
> > > > security reasons.  A blob might contain confidential information, in
> > > > which case the branch has to be rewritten and force-pushed.  However,
> > > > that does not make the blob go away, but makes it only unreachable.
> > > > Until the next garbage collection kicks in, that is (which you typically
> > > > cannot control).
> > > Hmm, I thought this had been addressed by git in a different way (removing
> > > confidential information).  A company will not be satisfied that its
> > > proprietary information is "unreachable" in your software repository.
> > > They want absolute assurance that the information is completely
> > > removed.
> > >
> > > Have I remembered wrongly --- is this still not possible with git?
> > 
> > Its still possible, but you have to wipe out the reflog record(s)
> > that had the object in it, and you have to repack to evict it from
> > the pack files, and you have to run `git prune --expire=0` to force
> > it to wipe out the object immediately.
> > 
> > We already support dumping back random commits via upload-archive, if
> > its enabled in the daemon, and I think a lot of people do turn it on.
> > There is no validation that the requested tree-ish is reachable.
> > 
> > I think gitweb winds up doing the same thing, it doesn't actually
> > try to validate the object is reachable, it just serves whatever
> > it was asked for, if its present in the repository.
> > 
> > 
> > I'm getting some mild suggestions over here at $DAY_JOB to implement
> > shallow clones by lazily downloading large blobs on demand.
> > We've resisted doing this in git because of the reachability test
> > Dscho mentioned above... but many people skip that anyway due
> > to gitweb and upload-archive being enabled.  Which is making me
> > start to question who is broken... upload-pack for not being more
> > willing to serve arbitrary content, or gitweb/upload-archive for
> > not validating their requests are reachable.
> 
> The security argument hasn't been true for a while if any of the following are
> enabled on the server:
> 	Gitweb
> 	http transport
> 	rsync transport
> 	ftp transport
> 	alternates (the alternates are the ones at risk)

Right.  But we must not break the security for careful administrators 
(read: who did _not_ enable any of the above) just out of a whim, right?  
Certainly not if the only reason to do it was "somebody thought it would 
be neat, but most probably is not going to use it herself after having 
played with it for a few days".

Ciao,
Dscho
