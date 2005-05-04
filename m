From: Chris Mason <mason@suse.com>
Subject: Re: [PATCH] add the ability to create and retrieve delta objects
Date: Wed, 4 May 2005 13:44:50 -0400
Message-ID: <200505041344.51637.mason@suse.com>
References: <200505030657.38309.alonz@nolaviz.org> <200505041156.19499.mason@suse.com> <Pine.LNX.4.61.0505041202270.22203@cag.csail.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Nicolas Pitre <nico@cam.org>, Linus Torvalds <torvalds@osdl.org>,
	Alon Ziv <alonz@nolaviz.org>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 04 19:39:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DTNpm-0000QH-W6
	for gcvg-git@gmane.org; Wed, 04 May 2005 19:38:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261197AbVEDRpP (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 4 May 2005 13:45:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261251AbVEDRpP
	(ORCPT <rfc822;git-outgoing>); Wed, 4 May 2005 13:45:15 -0400
Received: from cantor.suse.de ([195.135.220.2]:39642 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261197AbVEDRo5 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 4 May 2005 13:44:57 -0400
Received: from extimap.suse.de (extimap.suse.de [195.135.220.6])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(No client certificate requested)
	by mx1.suse.de (Postfix) with ESMTP id 1C5A6160E227;
	Wed,  4 May 2005 19:44:57 +0200 (CEST)
To: "C. Scott Ananian" <cscott@cscott.net>
User-Agent: KMail/1.8
In-Reply-To: <Pine.LNX.4.61.0505041202270.22203@cag.csail.mit.edu>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wednesday 04 May 2005 12:12, C. Scott Ananian wrote:
> On Wed, 4 May 2005, Chris Mason wrote:
> > 3) create a git-pack tool that can pack/unpack existing changesets,trees
> > and files, optionally adding/removing deltas.
>
> A 'git-pull' tool might be more use.  I can imagine Linus maintaining his
> local tree uncompressed, but the 'kernel.org' tree set up to
> git-pull-delta from him every hour or whatever, so that the
> network-accessible version is always network-efficient.  'git-pack'
> would then simplify to a git-pull-delta from an existing local repository.

I had pictured the opposite, after the regular pull you would run git-pack to 
redelta/pack things to your local settings.  There's a ton of things to try 
in git pull for delta transmission, and I'd rather keep it separate from the 
local repository packing for now.

Later on if both tools are working properly we could look at combining them.

>
> Ideally, you'd also be able to git-pull from a network packed repository
> and (transparently) unpack and undelta-fy the pulled files as they're
> added to your local repo.  This would keep Linus from accidentally getting
> packed files in his tree when he pulled from a maintainer's
> packed/delta-ed network-accessible tree.
>
Yes, if Linus does take the patches, it's really important for people to be 
able to easily continue without deltas/packing if they want.

> I'd also be interested in seeing the speed/space numbers for some other
> delta chain lengths between 1 and 16.  Maybe some intermediate point is
> optimal.  [Also, limiting delta chains to a certain number of other
> *packed* objects -- instead of just 'objects' -- might be an improvement.
> Right now you're packing entire commits together, right?  Maybe defining a
> delta chain as 'N other commits max' might improve i/o performance, as
> you'd just have to keep N other unpacked files around, instead of an
> arbitrary number.]

It's easy to do additional runs, but I would rather do this kind of fine 
tuning with the git-pack tool.  That way we could experiment with packing 
multiple commits into a single file, deltas on tree objects, or even 
combining commits based on which files tye modify.

-chris
