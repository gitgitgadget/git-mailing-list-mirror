From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Fix "git log -z" behaviour
Date: Sat, 10 Feb 2007 09:09:44 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0702100902250.8424@woody.linux-foundation.org>
References: <68948ca0702070841m76817d9el7ce2ec69835c50e@mail.gmail.com>
 <Pine.LNX.4.64.0702070856190.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702070919320.8424@woody.linux-foundation.org>
 <Pine.LNX.4.64.0702071139090.8424@woody.linux-foundation.org>
 <7v7iusz3c2.fsf@assigned-by-dhcp.cox.net> <7vtzxumps5.fsf@assigned-by-dhcp.cox.net>
 <7vlkj6mk0q.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Don Zickus <dzickus@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sat Feb 10 18:09:58 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HFvjY-0004MV-5X
	for gcvg-git@gmane.org; Sat, 10 Feb 2007 18:09:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbXBJRJx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Feb 2007 12:09:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751393AbXBJRJx
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Feb 2007 12:09:53 -0500
Received: from smtp.osdl.org ([65.172.181.24]:52494 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751391AbXBJRJw (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Feb 2007 12:09:52 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l1AH9jUI018965
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 10 Feb 2007 09:09:45 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l1AH9iop017324;
	Sat, 10 Feb 2007 09:09:44 -0800
In-Reply-To: <7vlkj6mk0q.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.436 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.116__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39244>



On Sat, 10 Feb 2007, Junio C Hamano wrote:
> 
> ... well, it just occured to me that it might make sense not to
> let this new "use NUL as inter-commit separator for grep -z"
> semantics hijack existing -z option, but introduce another
> option, say, -Z.

I don't think I disagree, but I do suspect it's not worth it.

Yes, we really do have two "line_termination" characters: the one between 
commits, and the one we use within raw diffs. However, I don't think the 
*combination* ever makes sense any more (*), so using the same flag 
doesn't seem to really be a problem.

And the -z "line_termination" already got hijacked a long time ago for 
inter-commit messages too, so while adding a "-Z" would perhaps avoid a 
certain ambiguity, it would actually potentially break stuff that just did

	git-rev-list -z --pretty .. | ...

which is actually _more_ likely than the "multiple commit messages _and_ 
raw outpu _and_ '-z'" combination.

So I would suggest leaving it as-is, especially since I don't think 
anybody has actually even noticed (ie nobody probably used that 
combination), and the new semantics in many ways are both more useful and 
more logical.

		Linus

(*) It may well have made sense a year and a half ago, I don't think it 
makes much sense any more.
