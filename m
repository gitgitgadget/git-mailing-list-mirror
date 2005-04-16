From: "C. Scott Ananian" <cscott@cscott.net>
Subject: Re: SHA1 hash safety
Date: Sat, 16 Apr 2005 10:58:15 -0400 (EDT)
Message-ID: <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz>   
 <20050416123155.GA19908@elte.hu>    <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz>
 <4261132A.3090907@khandalf.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: David Lang <david.lang@digitalinsight.com>,
	Ingo Molnar <mingo@elte.hu>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 16 16:56:07 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DMoiL-0002va-CW
	for gcvg-git@gmane.org; Sat, 16 Apr 2005 16:56:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVDPO7B (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 16 Apr 2005 10:59:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262679AbVDPO7B
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Apr 2005 10:59:01 -0400
Received: from sincerity-forever.csail.mit.edu ([128.30.67.31]:51863 "EHLO
	sincerity-forever.csail.mit.edu") by vger.kernel.org with ESMTP
	id S262677AbVDPO6k (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Apr 2005 10:58:40 -0400
Received: from catfish.lcs.mit.edu ([128.30.67.25] helo=cag.csail.mit.edu)
	by sincerity-forever.csail.mit.edu with esmtp (Exim 3.36 #1 (Debian))
	id 1DMoka-0007kk-00; Sat, 16 Apr 2005 10:58:24 -0400
To: omb@bluewin.ch
In-Reply-To: <4261132A.3090907@khandalf.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sat, 16 Apr 2005, Brian O'Mahoney wrote:

> (1) I _have_ seen real-life collisions with MD5, in the context of
>    Document management systems containing ~10^6 ms-WORD documents.

Dude!  You could have been *famous*!  Why the 
aitch-ee-double-hockey-sticks didn't you publish this when you found it?
Seriously, man.

Even given the known weaknesses in MD5, it would take much more than a 
million documents to find MD5 collisions.  I can only conclude that the 
hash was being used incorrectly; most likely truncated (my wild-ass guess 
would be to 32 bits; a collision is likely with > 50% probability in a 
million document store for a hash of less than 40 bits).

I know the current state of the art here.  It's going to take more than 
just hearsay to convince me that full 128-bit MD5 collisions are likely. 
I believe there are only two or so known to exist so far, and those were 
found by a research team in China (which, yes, is fairly famous among the 
cryptographic community now after publishing a paper consisting of little 
apart from the two collisions themselves).

Please, let's talk about hash collisions responsibly.  I posted earlier 
about the *actual computed probability* of finding two files with an SHA-1 
collision before the sun goes supernova.  It's 10^28 to 1 against.
The recent cryptographic works has shown that there are certain situations 
where a decent amount of computer work (2^69 operations) can produce two 
sequences with the same hash, but these sequences are not freely chosen; 
they've got very specific structure.  This attack does not apply to 
(effectively) random files sitting in a SCM.
   http://www.schneier.com/blog/archives/2005/02/sha1_broken.html

That said, Linux's widespread use means that it may not be unimaginable 
for an attacker to devote this amount of resources to an attack, which 
would probably involve first committing some specially structured file to 
the SCM (but would Linus accept it?) and then silently corrupting said 
file via a SHA1 collision to toggle some bits (which would presumably Do 
Evil).  Thus hashes other than SHA1 really ought to be considered...

...but the cryptographic community has not yet come to a conclusion on 
what the replacement ought to be.  These attacks are so new that we don't 
really understand what it is about the structure of SHA1 which makes them 
possible, which makes it hard to determine which other hashes are 
similarly vulnerable.  It will take time.

I believe Linus has already stated on this list that his plan is to 
eventually provide a tool for bulk migration of an existing SHA1 git 
repository to a new hash type.   Basically munging through the repository 
in bulk, replacing all the hashes.  This seems a perfectly adequate 
strategy at the moment.
  --scott

WASHTUB Panama Minister Moscow explosives KUGOWN hack Marxist LPMEDLEY 
genetic immediate radar SCRANTON COBRA JANE KGB Shoal Bay atomic Bejing
                          ( http://cscott.net/ )
