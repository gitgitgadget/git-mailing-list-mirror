From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFH] bug in unpack_trees
Date: Tue, 4 Mar 2008 13:31:44 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0803041325370.12253@woody.linux-foundation.org>
References: <20080304115940.GA5260@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	John Goerzen <jgoerzen@complete.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Mar 04 22:33:34 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWelG-0004UI-2r
	for gcvg-git-2@gmane.org; Tue, 04 Mar 2008 22:33:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756876AbYCDVcn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 4 Mar 2008 16:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756581AbYCDVcm
	(ORCPT <rfc822;git-outgoing>); Tue, 4 Mar 2008 16:32:42 -0500
Received: from smtp1.linux-foundation.org ([140.211.169.13]:35204 "EHLO
	smtp1.linux-foundation.org" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756187AbYCDVcl (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 4 Mar 2008 16:32:41 -0500
Received: from imap1.linux-foundation.org (imap1.linux-foundation.org [140.211.169.55])
	by smtp1.linux-foundation.org (8.14.2/8.14.2/Debian-2build1) with ESMTP id m24LVwZl032750
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 4 Mar 2008 13:32:00 -0800
Received: from localhost (localhost [127.0.0.1])
	by imap1.linux-foundation.org (8.13.5.20060308/8.13.5/Debian-3ubuntu1.1) with ESMTP id m24LVivn030162;
	Tue, 4 Mar 2008 13:31:44 -0800
In-Reply-To: <20080304115940.GA5260@sigill.intra.peff.net>
User-Agent: Alpine 1.00 (LFD 882 2007-12-20)
X-Spam-Status: No, hits=-4.082 required=5 tests=AWL,BAYES_00,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 3.2.4-osdl_revision__1.47__
X-MIMEDefang-Filter: lf$Revision: 1.188 $
X-Scanned-By: MIMEDefang 2.63 on 140.211.169.13
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76139>



On Tue, 4 Mar 2008, Jeff King wrote:
>
> I am tracking down a bug in unpack_trees, but I can't seem to find the
> exact problem; I'm hoping to get help from people who have touched this
> code a bit more than I have.

Ok, I haven't (the blame for that unpack_trees function lies mainly at 
Dscho, I think ;), and now that I'm looking at it more closely I really 
don't think unpack_trees() is salvageable.

I tried. I can't make it work.

The only really sane way to traverse trees in parallel is with the 
walk-tree.c functionality (ie using "traverse_trees()"), which is quite 
straightforward and rather simple, and which I can pretty much guarantee 
works.

In contrast, the things that unpack_trees() does to try to figure out how 
to mix in the index into the pot really doesn't work.

I'll take a good hard look at trying to convert users of unpack_trees() 
into traverse_trees(), or perhaps even convert "unpack_trees()" itself.

		Linus
