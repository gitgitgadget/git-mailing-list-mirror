From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree
 performance problems)
Date: Wed, 20 Apr 2005 10:30:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504201025030.2630@cag.csail.mit.edu>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com>
 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com>
 <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org> <2cfc403205042005116484231c@mail.gmail.com>
 <20050420132446.GA10126@macavity>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 16:27:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOGA0-0005im-Jx
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 16:26:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261637AbVDTOaf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 10:30:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261650AbVDTOaf
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 10:30:35 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:10889 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261637AbVDTOa1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 10:30:27 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DOGDh-0008Qk-00; Wed, 20 Apr 2005 10:30:25 -0400
To: Martin Uecker <muecker@gmx.de>
In-Reply-To: <20050420132446.GA10126@macavity>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Martin Uecker wrote:

> The other thing I don't like is the use of a sha1
> for a complete file. Switching to some kind of hash
> tree would allow to introduce chunks later. This has
> two advantages:

You can (and my code demonstrates/will demonstrate) still use a whole-file 
hash to use chunking.  With content prefixes, this takes O(N ln M) time 
(where N is the file size and M is the number of chunks) to compute all 
hashes; if subtrees can share the same prefix, then you can do this in 
O(N) time (ie, as fast as possible, modulo a constant factor, which is 
'2').  You don't *need* internal hashing functions.

> It would allow git to scale to repositories of large
> binary files. And it would allow to build a very cool
> content transport algorithm for those repositories.
> This algorithm could combine all the advantages of
> bittorrent and rsync (without the cpu load).

Yes, the big benefit of internal hashing is that it lets you check 
validity of a chunk w/o having the entire file available.  I'm not sure 
that's terribly useful in this case.  [And, if it is, then it can 
obviously be done w/ other means.]

> And it would allow trivial merging of patches which
> apply to different chunks of a file in exact the same
> way as merging changesets which apply to different
> files in a tree.

I'm not sure anyone should be looking at chunks.  To me, at least, they 
are an object-store-implementation detail only.  For merging, etc, we 
should be looking at whole files, or (better) the whole repository.
The chunking algorithm is guaranteed not to respect semantic boundaries 
(for *some* semantics of *some* file).
  --scott

explosion JMTRAX DC KUBARK biowarfare LCFLUTTER ESMERALDITE for Dummies 
Hager Nader Israel General ZRMETAL Castro cryptographic Indonesia
                          ( http://cscott.net/ )
