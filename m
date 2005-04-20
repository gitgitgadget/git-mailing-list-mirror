From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: WARNING! Object DB conversion (was Re: [PATCH] write-tree
 performance problems)
Date: Wed, 20 Apr 2005 11:28:20 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504201121490.2630@cag.csail.mit.edu>
References: <200504191250.10286.mason@suse.com> <200504191708.23536.mason@suse.com>
 <Pine.LNX.4.58.0504191420060.19286@ppc970.osdl.org> <200504192049.21947.mason@suse.com>
 <Pine.LNX.4.58.0504192337120.6467@ppc970.osdl.org> <42660708.60109@zytor.com>
 <Pine.LNX.4.58.0504200144260.6467@ppc970.osdl.org> <2cfc403205042005116484231c@mail.gmail.com>
 <20050420132446.GA10126@macavity> <Pine.LNX.4.61.0504201025030.2630@cag.csail.mit.edu>
 <20050420151902.GA13175@macavity>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 20 17:26:14 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DOH3z-0008Ih-F0
	for gcvg-git@gmane.org; Wed, 20 Apr 2005 17:24:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261683AbVDTP2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 20 Apr 2005 11:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261687AbVDTP2l
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Apr 2005 11:28:41 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:28046 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S261683AbVDTP2e (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Apr 2005 11:28:34 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DOH7v-0000O9-00; Wed, 20 Apr 2005 11:28:31 -0400
To: Martin Uecker <muecker@gmx.de>
In-Reply-To: <20050420151902.GA13175@macavity>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, 20 Apr 2005, Martin Uecker wrote:

>> You can (and my code demonstrates/will demonstrate) still use a whole-file
>> hash to use chunking.  With content prefixes, this takes O(N ln M) time
>> (where N is the file size and M is the number of chunks) to compute all
>> hashes; if subtrees can share the same prefix, then you can do this in
>> O(N) time (ie, as fast as possible, modulo a constant factor, which is
>> '2').  You don't *need* internal hashing functions.
>
> I don't understand this paragraph. What is an internal
> hash function? Your code seems to do exactly what I want.
> The hashes are computed recusively as in a hash tree
> with O(N ln N). The only difference between your design
> and a design based on a conventional (binary) hash tree
> seems to be that data is stored in the intermediate nodes
> too.

A merkle-tree (which I think you initially pointed me at) makes the hash 
of the internal nodes be a hash of the chunk's hashes; ie not a straight 
content hash.  This is roughly what my current implementation does, but
I would like to identify each subtree with the hash of the 
*(expanded) contents of that subtree* (ie no explicit reference to 
subtree hashes).  This makes it interoperable with non-chunked or 
differently-chunked representations, in that the top-level hash is *just 
the hash of the complete content*, not some hash-of-subtree-hashes.  Does 
that make more sense?

The code I posted doesn't demonstrate this very well, but now that Linus 
has abandoned the 'hash of compressed content' stuff, my next code posting 
should show this more clearly.

> If I don't miss anything essential, you can validate
> each treap piece at the moment you get it from the
> network with its SHA1 hash and then proceed with
> downloading the prefix and suffix tree (in parallel
> if you have more than one peer a la bittorrent).

Yes, I guess this is the detail I was going to abandon. =)

I viewed the fact that the top-level hash was dependent on the exact chunk 
makeup a 'misfeature', because it doesn't allow easy interoperability with 
existing non-chunked repos.
  --scott

WTO atomic operation Mossad Castro overthrow FSF fissionable HTAUTOMAT 
LCPANES MKDELTA Bush non-violent protest OVER THE HORIZON RADAR KUPALM
                          ( http://cscott.net/ )
