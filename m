From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: 'git commit' duplicates parents?
Date: Sun, 19 Jun 2005 19:33:55 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506191926530.2268@ppc970.osdl.org>
References: <42B59CF7.3080509@pobox.com> <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 20 04:26:38 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DkBzc-0006yg-Oe
	for gcvg-git@gmane.org; Mon, 20 Jun 2005 04:26:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261179AbVFTCcO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 19 Jun 2005 22:32:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261305AbVFTCcO
	(ORCPT <rfc822;git-outgoing>); Sun, 19 Jun 2005 22:32:14 -0400
Received: from smtp.osdl.org ([65.172.181.4]:52952 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261179AbVFTCby (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 19 Jun 2005 22:31:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j5K2VpjA026547
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 19 Jun 2005 19:31:51 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j5K2VoQb004705;
	Sun, 19 Jun 2005 19:31:50 -0700
To: Jeff Garzik <jgarzik@pobox.com>
In-Reply-To: <Pine.LNX.4.58.0506191921270.2268@ppc970.osdl.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 19 Jun 2005, Linus Torvalds wrote:
> 
> Your commit is a merge. A corrupted one.

Btw, if possibly, you should just undo it. It's "valid" in the sense that
having the same parent duplicated will just be considered to be a merge by
a paritcularly strange person, but it's definitely not good practice, and
since it _is_ technically a merge, programs that avoid showing merges
(like "git-whatchanged" - because it doesn't know what it should show as 
the "difference") won't show it.

Other programs, like "git-diff-tree -m", which show _all_ sides of a 
merge, will show the diff twice (because it shows the diff against all 
parents). Which is also why you see it twice in your git-changes-script.

Again, "git commit" _did_ warn about this, I'm sure, but I actually see 
why that stupid MERGE_HEAD file was there - a null merge won't remove a 
stale MERGE_HEAD, so it's probably because you did a "git pull" that was a 
trivial merge, and that would have left that turd around..

		Linus
