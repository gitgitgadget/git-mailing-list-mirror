From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Why are ref_lists sorted?
Date: Mon, 19 Mar 2007 10:03:10 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0703190935360.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Mon Mar 19 18:03:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HTLGQ-0000ib-Tz
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 18:03:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966022AbXCSRDR (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 19 Mar 2007 13:03:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966023AbXCSRDR
	(ORCPT <rfc822;git-outgoing>); Mon, 19 Mar 2007 13:03:17 -0400
Received: from smtp.osdl.org ([65.172.181.24]:41755 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S966022AbXCSRDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Mar 2007 13:03:16 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l2JH3BcD031271
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 19 Mar 2007 10:03:11 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l2JH3AoB011771;
	Mon, 19 Mar 2007 09:03:10 -0800
In-Reply-To: <Pine.LNX.4.64.0703190321370.28570@beast.quantumfyre.co.uk>
X-Spam-Status: No, hits=-0.478 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42644>



On Mon, 19 Mar 2007, Julian Phillips wrote:
> 
> So my questions are:
> 
> 1) what have I broken by removing the sort?

The big thing is probably consistency.

I *really* think we need to sort these things. Otherwise you'll see two 
totally identical repositories giving different results to something as 
fundamental as "git ls-remote" just because they didn't get sorted.

So I think sorting is absolutely required, perhaps not so much because it 
is necessarily "incorrect" without the sorting, but because I think 
consistency in this area is too important *not* to sort it.

And sorting it really is simple. The fact that we use a O(n**2) list 
insertion thing that is also probably pessimal for the case of "already 
sorted" input is just a "hey, it was easy, we never actually hit it in 
practice" issue. 

> 2) is it worth trying to optimise the sort?

Absolutely. It might involve changing the "ref_list *" thing into an array 
of ref_entries, and that will cause a lot of (fairly trivial) changes, but 
it should all be entirely internal to refs.c, so it's hopefully not 
painful, just some boring grunt-work.

		Linus
