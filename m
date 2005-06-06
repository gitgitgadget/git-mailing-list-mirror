From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Last mile for 1.0
Date: Mon, 6 Jun 2005 07:37:56 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506060730510.1876@ppc970.osdl.org>
References: <7voeak1o0q.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051509490.1876@ppc970.osdl.org> <7vk6l8xue5.fsf_-_@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.58.0506051658100.1876@ppc970.osdl.org>
 <20050606054356.GB3669@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0506052300350.1876@ppc970.osdl.org>
 <20050606064456.GC3669@cip.informatik.uni-erlangen.de>
 <Pine.LNX.4.58.0506052351470.1876@ppc970.osdl.org> <7vekbgufra.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Thomas Glanzmann <sithglan@stud.uni-erlangen.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 06 16:34:25 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DfIee-0005uP-JD
	for gcvg-git@gmane.org; Mon, 06 Jun 2005 16:32:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261448AbVFFOgK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 6 Jun 2005 10:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261477AbVFFOgK
	(ORCPT <rfc822;git-outgoing>); Mon, 6 Jun 2005 10:36:10 -0400
Received: from fire.osdl.org ([65.172.181.4]:18146 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261448AbVFFOgB (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 6 Jun 2005 10:36:01 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j56EZrjA009794
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 6 Jun 2005 07:35:53 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j56EZp38028991;
	Mon, 6 Jun 2005 07:35:52 -0700
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vekbgufra.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.109 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Mon, 6 Jun 2005, Junio C Hamano wrote:
> 
> Yes, this was done from your explicit request not to touch the
> working directory while it works AFAICR.  At least back then,
> not touching the working tree was the _requirement_.

Yes. Now that read-tree verifies that the working directory is clean (at
least for any non-identity files), it's a non-issue.

> So is "the new merge world order" you mentioned in the log
> message now require (and assume) the work tree more-or-less
> matches the first head being merged?

Well, without "-u" you should see the old "order doesn't matter" case, but
yes, the theory is that the three trees are <base> <current> <merge> for
the three-way case, and <current> <new> for the two-way one.

You can get the old behaviour by using

	git-read-tree -m <cur>
	git-read-tree -m <base> <cur> <merge>

where the first read-tree ends up just makign sure that the index file 
matches the current head (use "-u" or not as you like).

(Side note: the actual read-tree phase should be totally agnostic about 
whether the current tree is the first, second or third of the trees, since 
it will happily say "oh, we saw this exact directory entry in _one_ of the 
trees, so we know it hasn't gotten lost".  So for now, order still is left 
to the final user, but I don't think you should depend on that).

		Linus
