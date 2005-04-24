From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [GIT PATCH] Selective diff-tree
Date: Sun, 24 Apr 2005 10:20:03 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0504241016390.15879@ppc970.osdl.org>
References: <1113400651.20848.135.camel@hades.cambridge.redhat.com>
 <Pine.LNX.4.58.0504232202340.19877@ppc970.osdl.org> <7vbr84tyfd.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: David Woodhouse <dwmw2@infradead.org>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Apr 24 19:13:49 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DPkfr-0008JI-8g
	for gcvg-git@gmane.org; Sun, 24 Apr 2005 19:13:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262313AbVDXRS1 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 24 Apr 2005 13:18:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262308AbVDXRS1
	(ORCPT <rfc822;git-outgoing>); Sun, 24 Apr 2005 13:18:27 -0400
Received: from fire.osdl.org ([65.172.181.4]:8427 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262283AbVDXRSO (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 24 Apr 2005 13:18:14 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j3OHI5s4002061
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 24 Apr 2005 10:18:05 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j3OHI4GZ013102;
	Sun, 24 Apr 2005 10:18:04 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vbr84tyfd.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.35__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Sun, 24 Apr 2005, Junio C Hamano wrote:
>
> Is either of you planning to do the same for diff-cache?

I wasn't. I don't think it's nearly as relevant for diff-cache, since 
diff-cache is never run thousands of times.

IOW, with diff-cache you can just do

	diff-cache <tree> | grep "interesting"

and you're done.

Diff-tree is different, simply because diff-tree is the way you find out
which files changed between two revisions, so if you search for "when did
this file change" you may well have to do _thousands_ of different
diff-tree's. That's why pruning the diff-tree output is important: it
makes diff-tree _much_ cheaper.

diff-cache usually doesn't make sense to do against more than one or two
threes (the parent, and after a merge but before you commit maybe the
parent_s_).

		Linus
