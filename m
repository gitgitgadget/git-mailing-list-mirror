From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Shortest path between commits
Date: Wed, 8 Feb 2006 08:43:50 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602080834490.2458@g5.osdl.org>
References: <20060208160308.GB3484@linux-mips.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Feb 08 17:47:09 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6sQL-0007td-16
	for gcvg-git@gmane.org; Wed, 08 Feb 2006 17:44:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030591AbWBHQny (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 11:43:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030589AbWBHQny
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 11:43:54 -0500
Received: from smtp.osdl.org ([65.172.181.4]:40652 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030591AbWBHQny (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 11:43:54 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k18GhoDZ030826
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 08:43:51 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k18GhoXa032752;
	Wed, 8 Feb 2006 08:43:50 -0800
To: Ralf Baechle <ralf@linux-mips.org>
In-Reply-To: <20060208160308.GB3484@linux-mips.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15742>



On Wed, 8 Feb 2006, Ralf Baechle wrote:
>
> I wonder if there some way to find the shortest path between two commits?
> That is if there is a merge between the two commits I only want the merge
> commit itself, not the potencially large list of commits that were merged.

The problem is that it's entirely possible that no such path even 
exists.

Two commits are not necessarily directly related, and asking for the 
shortest path may involve having to go both backwards _and_ forwards in 
history to get from one to the other. The most trivial case is

	    a  <- head of tree
	   / \
	  /   \
	 b     c
	  \   /
	   \ /
	    d  <- root

where the shortest path between "b" and "c" is not really a well-defined 
notion.

Now, _if_ you know that one of the commits is a direct descendant of the 
other, a sensible path can be decided on, but even then the notion of 
"shortest" is not obvious. Look at "a" vs "d" above - which path is the 
shortest one? The one through "b" or the one through "c"? There's really 
no way to tell them apart (you could select "first parent", but in more 
complex graphs that might not be unambiguous either).

That said, and to finally answer your question: selecing _one_ short path 
between two commits (if they are directly related) is certainly possible, 
but no, we don't have anything like that available right now. It wouldn't 
be hugely difficult to do an addition to git-rev-list to do so, though.

Can you describe your usage case? The operation really _isn't_ sensible in 
general, so while I could add a flag to git-rev-list to only print out as 
direct a chain as possible, I'd like to know that there is at least _one_ 
entirely sane usage for such a thing.

		Linus
