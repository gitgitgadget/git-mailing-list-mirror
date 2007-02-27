From: "Theodore Ts'o" <tytso@mit.edu>
Subject: How do get a specific version of a particular file?
Date: Tue, 27 Feb 2007 07:34:31 -0500
Message-ID: <E1HM1XL-00071C-N5@candygram.thunk.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 27 13:34:48 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HM1XY-0000j9-Ts
	for gcvg-git@gmane.org; Tue, 27 Feb 2007 13:34:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933052AbXB0Mef (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Feb 2007 07:34:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933040AbXB0Mef
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Feb 2007 07:34:35 -0500
Received: from thunk.org ([69.25.196.29]:36172 "EHLO thunker.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933052AbXB0Mee (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Feb 2007 07:34:34 -0500
Received: from root (helo=candygram.thunk.org)
	by thunker.thunk.org with local-esmtps 
	(tls_cipher TLS-1.0:RSA_AES_256_CBC_SHA:32)  (Exim 4.50 #1 (Debian))
	id 1HM1cp-0001RB-Jl; Tue, 27 Feb 2007 07:40:11 -0500
Received: from tytso by candygram.thunk.org with local (Exim 4.62)
	(envelope-from <tytso@thunk.org>)
	id 1HM1XL-00071C-N5; Tue, 27 Feb 2007 07:34:31 -0500
Full-Name: Theodore Ts'o
Phone: (781) 391-3464
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on thunker.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/40719>


So given a particular tree-ish and a pathname, I'd like get the contents
of that particular file as of a particular revision.  i.e., the
equivalent of:

	cvs -r v1.37 -p e2fsck/pass1.c
or
	bk cat -r 2345 e2fsck/pass1.c

The closest I've been able to come is to use

	git archive --format=zip v1.37 e2fsck/pass1.c | gunzip

But that seems kinda silly.  

git-checkout will only write the output to the working tree.
git-cat-file and git-show only work on a object identifier (they are
low-level plumbing commands).  

So if it is a matter of we don't have an easy way to do this (as opposed
to me being stupid or the git documentation just failing to mention it
in the right places), what's the best way to add it?

One easy way would be to add --format=raw to git-archive, but that might
seem counter-intuitive to an average git user; they just want to see the
output of a file at a particular point in time, which doesn't have much
to do with archiving.   

Should we add a new command like "git-cat"?   Should we add a -p option
to the "git-checkout <treeish> <path>" form of git-checkout?

I'm currently leaning towards the last; it would be pretty simple to
enhance git-checkout so that a -p option would run "git archive
--format=zip ...", even though that would be a pretty nasty hack, and it
wouldn't be much harder to add --format=raw support to git-archive, but
I still think that's not a intuitive place to find that particular
functionality.

						- Ted
