From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Please undo "Use git-merge instead of git-resolve in git-pull"
Date: Wed, 21 Sep 2005 19:10:08 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0509211902010.2553@g5.osdl.org>
References: <Pine.LNX.4.58.0509211310150.2553@g5.osdl.org> 
 <7vu0genlc1.fsf@assigned-by-dhcp.cox.net>  <Pine.LNX.4.58.0509211501130.2553@g5.osdl.org>
  <20050921.172849.103555057.davem@davemloft.net> <46a038f905092118464b98e149@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: "David S. Miller" <davem@davemloft.net>, junkio@cox.net,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Sep 22 04:13:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EIGZG-0000Oj-VU
	for gcvg-git@gmane.org; Thu, 22 Sep 2005 04:12:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750813AbVIVCLw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Sep 2005 22:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750816AbVIVCLw
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Sep 2005 22:11:52 -0400
Received: from smtp.osdl.org ([65.172.181.4]:60315 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750813AbVIVCLw (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 21 Sep 2005 22:11:52 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j8M2ABBo000420
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 21 Sep 2005 19:10:12 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j8M2A8It009325;
	Wed, 21 Sep 2005 19:10:10 -0700
To: Martin Langhoff <martin.langhoff@gmail.com>
In-Reply-To: <46a038f905092118464b98e149@mail.gmail.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.45__
X-MIMEDefang-Filter: osdl$Revision: 1.117 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9092>



On Thu, 22 Sep 2005, Martin Langhoff wrote:
>
> Using Cogito, we've found a couple of cases where merging on a dirty
> tree messed things up. The local changes were lost after the merge.

Hmm. I merge a ton of stuff, and as mentioned, I probably have a dirty 
tree at least half the time. I don't think I've seen a problem yet.

But cogito at least _used_ to have some special logic for moving patches
forward. git-resolve-script never had that - it only ever did the per-file
three-way merge, and refused to touch dirty state except for the
"everything stays the same" case.

Oh. I'm looking at the current cg-merge thing, and I think I see the
problem: it's doing

	git-checkout-index -f -u -a

at the end. That's not only unnecessary, since it uses the "-u" flag to 
"git-read-tree", but it will force an overwrite of the working tree, and 
is thus actively incorrect.

Pasky?

		Linus
