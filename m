From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: SHA1 hash safety
Date: Sun, 17 Apr 2005 20:09:48 -0400
Message-ID: <20050418000946.GA7172@thunk.org>
References: <Pine.LNX.4.62.0504160519330.21837@qynat.qvtvafvgr.pbz> <20050416123155.GA19908@elte.hu> <Pine.LNX.4.62.0504160542190.21837@qynat.qvtvafvgr.pbz> <4261132A.3090907@khandalf.com> <Pine.LNX.4.61.0504161040310.29343@cag.csail.mit.edu> <20050416151116.GC19099@pasky.ji.cz> <Pine.LNX.4.61.0504161114530.29343@cag.csail.mit.edu> <Pine.LNX.4.62.0504161549410.22652@qynat.qvtvafvgr.pbz> <20050416161153.534b47d5.pj@sgi.com> <4261E84D.6040208@dwheeler.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Paul Jackson <pj@sgi.com>, David Lang <dlang@digitalinsight.com>,
	cscott@cscott.net, pasky@ucw.cz, omb@bluewin.ch, mingo@elte.hu,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 18 04:38:55 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DNM9y-00027b-NY
	for gcvg-git@gmane.org; Mon, 18 Apr 2005 04:38:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261614AbVDRCmo (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 17 Apr 2005 22:42:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261615AbVDRCmo
	(ORCPT <rfc822;git-outgoing>); Sun, 17 Apr 2005 22:42:44 -0400
Received: from THUNK.ORG ([69.25.196.29]:42719 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261614AbVDRCmi (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 17 Apr 2005 22:42:38 -0400
Received: from root (helo=thunk.org)
	by thunker.thunk.org with local-esmtp   (Exim 3.35 #1 (Debian))
	id 1DNMDE-0000qV-00; Sun, 17 Apr 2005 22:42:13 -0400
Received: from tytso by thunk.org with local (Exim 4.50)
	id 1DNJpk-0001u3-SY; Sun, 17 Apr 2005 20:09:48 -0400
To: "David A. Wheeler" <dwheeler@dwheeler.com>
Content-Disposition: inline
In-Reply-To: <4261E84D.6040208@dwheeler.com>
User-Agent: Mutt/1.5.8i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Sun, Apr 17, 2005 at 12:38:37AM -0400, David A. Wheeler wrote:
> The probability of an accidental overlap for SHA-1 for two
> different files is absurdly remote; it's just not worth worrying about.
> 
> However, the possibility of an INTENTIONAL overlap is a completely
> different matter.  I think the hash algorithm should change in the
> future; I have a proposal below.
> 
> Someone has ALREADY broken into a server to modify the Linux kernel
> code already, so the idea of an attack on kernel code
> is not an idle fantasy. MD5 is dead, and SHA-1's work factor has
> already been sufficiently broken that people have already been told
> "walk to the exits" (i.e., DO NOT USE SHA-1 for new programs like git).

We're very clearly going to need a FAQ for git.

SHA-1's work factor has been decreased to 2**69 from 2**80 for
generating two messages that have the same hash value, WHERE THE HASH
VALUE AND THE MESSAGES ARE NOT UNDER THE ATTACKER'S CONTROL.  This is
not the same as a pre-image attack, where given a message M1 which
hashes to value H, the attacker can find another message M2 which also
hashes to value H.  In even if the attacker can do this, the result
has to have valid git metadata format, and also be valid C code.

So the the recent result which has weakened (but not broken) SHA-1's
use in digital signatures, and which has resulted in the advice to
"walk not run" for the exits, do not apply to git.

Can we guarantee that there won't be further innovations that may
break SHA-1?  Of course not.  But an attacker who wants to introduced
a trojan into the Linux kernel would have a much easier time doing a
"black bag job" --- i.e., breaking into Linus's house in Portland, and
then inserting a buggered patch into his master source tree.

If you're going to be a professional paranoid, it's best to worry
about the realistic attacks before stressing out over the unrealistic
ones.

						- Ted
