From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: .gitlink for Summer of Code
Date: Sun, 25 Mar 2007 16:39:01 -0400
Message-ID: <20070325203901.GB12376@spearce.org>
References: <1174825838.12540.5.camel@localhost> <vpqvegpe4e1.fsf@olympe.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eric Lesh <eclesh@ucla.edu>
To: Matthieu Moy <Matthieu.Moy@imag.fr>
X-From: git-owner@vger.kernel.org Sun Mar 25 22:39:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HVZUg-0005dR-Ti
	for gcvg-git@gmane.org; Sun, 25 Mar 2007 22:39:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752536AbXCYUjM (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 25 Mar 2007 16:39:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752578AbXCYUjM
	(ORCPT <rfc822;git-outgoing>); Sun, 25 Mar 2007 16:39:12 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59934 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752536AbXCYUjK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 25 Mar 2007 16:39:10 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HVZUM-00007y-S3; Sun, 25 Mar 2007 16:38:54 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id BED5B20FBAE; Sun, 25 Mar 2007 16:39:01 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <vpqvegpe4e1.fsf@olympe.imag.fr>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/43069>

Matthieu Moy <Matthieu.Moy@imag.fr> wrote:
> Eric Lesh <eclesh@ucla.edu> writes:
> 
> > .gitlink is for a lightweight checkout of a branch into a separate
> > directory on the local filesystem.
> 
> I think it's a pitty to restrict yourself to _local_ filesystem. There
> are tons of cases where you have a fast, non-NFS, access to a machine
> and would like to host your repository there.
> 
> That said, I suppose removing this restriction moves the solution from
> the category "quick and efficient hack" to something much harder.

Yes.  But there's another project on the ideas list that addresses
that (``Lazy Clone'').  It is quite a bit more difficult than the
.gitlink idea as the implementation requires a network protocol
client implemented somewhere near the read_sha1_file interface.

Junio and I had talked about this (I think it was on the list,
but maybe it was on #git) recently and considered maybe trying to
do it as a wrapper *above* read_sha1_file/has_sha1_file, and adjust
the clients that call them to invoke the wrapper instead.

Nothing will obviously beat having the file on a local disk; but if
you have a fast LAN it may be hard to beat an anonymous TCP socket
dedicated to serving Git objects.  Such a socket may even beat out
NFS...  ;-)
 
> > A .gitlink'ed checkout has its own index+HEAD, but otherwise refers
> > back to the main repository for objects, refs, etc.
> 
> Stupid question: why .gitlink, and not .git/link or so? This file is
> not versionned, I don't think it should be in the working tree.

I've thought the same thing.

Actually, I'd almost say put it into .git/config, e.g.:

	mkdir .git
	cat >.git/config <<EOF
	[core]
		repositoryversion = 0
		filemode = true
		link = /path/to/source
	EOF

as then the index and HEAD file can both be stored in .git, just
like with the non-gitlink case.

-- 
Shawn.
