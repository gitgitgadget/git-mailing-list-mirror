From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: mysterious error message
Date: Fri, 26 Sep 2008 07:26:48 -0700
Message-ID: <20080926142648.GV3669@spearce.org>
References: <20593.1222378418@as220.org> <alpine.DEB.1.00.0809261400400.13830@pacific.mpi-cbg.de.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Tom Sgouros <tomfool@as220.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 26 16:28:08 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KjEIZ-0002XC-6B
	for gcvg-git-2@gmane.org; Fri, 26 Sep 2008 16:27:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751707AbYIZO0t (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Sep 2008 10:26:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751726AbYIZO0t
	(ORCPT <rfc822;git-outgoing>); Fri, 26 Sep 2008 10:26:49 -0400
Received: from george.spearce.org ([209.20.77.23]:38741 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbYIZO0s (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Sep 2008 10:26:48 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id 40A1E3835F; Fri, 26 Sep 2008 14:26:48 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0809261400400.13830@pacific.mpi-cbg.de.mpi-cbg.de>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96852>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Thu, 25 Sep 2008, Tom Sgouros wrote:
> 
> > I receive the following error message when I try to do a 'git push':
> > 
> >   tomfool@toms-box:hpl$ git push
> >   updating 'refs/heads/master'
> >     from ad4ae7925d3dd23798e7c5b733d2d8f930f7410f
> >     to   5b5f5fae014a4f3535fa10b0f6e28b4bf3225dc3
> >    Also local refs/remotes/origin/master
> >   Generating pack...
> >   Done counting 10 objects.
> >   Deltifying 10 objects...
> >   error: pack-objects died with strange error
> >   unpack eof before pack header was fully read
> >   ng refs/heads/master n/a (unpacker error)
> >   error: failed to push to 'ssh://tomfool@as220.org/home/tomfool/hpl.git'
> >   tomfool@toms-box:hpl$
> 
> I got this message when I tried to push a project with submodules to a 
> server which had submodule-ignorant git installed.  Maybe it's that?

Almost.

I think its that there are submodules in the local side and they are
being pushed to the remote peer, but the git binary on the client
that is being used to execute git-push doesn't know about submodules.

"error: pack-objects died with strange error":

This was pack-objects aborting when it saw a subtree entry and it
couldn't trace down that path in order to include it into the pack.

"unpack eof before pack header was fully read":

This is the server side aborting because its gotten the command
set from the git-push client, but pack-objects never even got to
create the pack header, since it couldn't generate the full list
of objects it needed to include.

Tom, try upgrading to a Git implementation on the client.  It seems
to me that this repository must have been moved here by means outside
of Git (NFS mount?), or the client got downgraded (wrong $PATH?)

-- 
Shawn.
