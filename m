From: Linus Torvalds <torvalds@osdl.org>
Subject: gitweb using "--cc"?
Date: Wed, 8 Feb 2006 15:44:58 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0602081532360.2458@g5.osdl.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Feb 09 00:45:20 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F6yzp-00079A-Qc
	for gcvg-git@gmane.org; Thu, 09 Feb 2006 00:45:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422642AbWBHXpK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Feb 2006 18:45:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422644AbWBHXpJ
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Feb 2006 18:45:09 -0500
Received: from smtp.osdl.org ([65.172.181.4]:56722 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1422642AbWBHXpI (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 8 Feb 2006 18:45:08 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id k18Nj5DZ023073
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 8 Feb 2006 15:45:05 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id k18Niwpu018704;
	Wed, 8 Feb 2006 15:45:02 -0800
To: Kay Sievers <kay.sievers@suse.de>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.68__
X-MIMEDefang-Filter: osdl$Revision: 1.129 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15764>


I just did an arm merge that needed some (very trivial) manual fixups 
(commit ID cce0cac1, in case anybody cares).

As usual, git-diff-tree --cc does a beautiful job on it, but I also 
checked the gitweb output, which seems to not do as well (the commit 
message about a manual conflict merge doesn't make any sense at all).

Now, in this case, what gitweb shows is actually "sensible": it will show 
the diff of what the merge "brought in" to the mainline kernel, and in 
that sense I can certainly understand it. It basically diffs the merge 
against the first parent.

So looking at that particular example, arguably gitweb does something 
"different" from what the commit message is talking about, but in many 
ways it's a perfectly logical thing.

However, diffing against the first parent, while it sometimes happens to 
be a sane thing to do, really isn't very sane in general. The merge may go 
the other way (subdevelopers merging my code), like in commit b2faf597, 
and sometimes there might not be a single reference tree, but more of a 
"couple of main branches" approach with merging back and forth). Then the 
current gitweb behaviour makes no sense at all.

So it would be much nicer if gitweb had some alternate approach to showing 
merge diffs. My suggested approach would be to just let the user choose: 
have separate "diff against fist/second[/third[/..]] parent" buttons. And 
one of the choices would be the "conflict view" that git-diff-tree --cc 
gives (I'd argue for that being the default one, because it's the only one 
that doesn't have a "preferred parent").

Kay?

		Linus
