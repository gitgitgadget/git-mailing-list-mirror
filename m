From: Eric Wong <normalperson@yhbt.net>
Subject: Re: git-svnimport failed and now git-repack hates me
Date: Sat, 6 Jan 2007 16:36:54 -0800
Message-ID: <20070107003654.GA12551@localdomain>
References: <7v1wmbnw9x.fsf@assigned-by-dhcp.cox.net> <204011cb0701040958k884b613i8a4639201ae6443b@mail.gmail.com> <7v1wmalez6.fsf@assigned-by-dhcp.cox.net> <204011cb0701050919w2001105asefe2fd99165dfa95@mail.gmail.com> <7vbqldfg56.fsf@assigned-by-dhcp.cox.net> <204011cb0701051133r1ede14a6gd5093a3e7fa88cb5@mail.gmail.com> <20070105193958.GE8753@spearce.org> <7vtzz5duk1.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.64.0701051354590.3661@woody.osdl.org> <Pine.LNX.4.64.0701051414140.14017@blackbox.fnordora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 07 01:37:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H3M20-0000xx-Mc
	for gcvg-git@gmane.org; Sun, 07 Jan 2007 01:37:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932292AbXAGAg5 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 6 Jan 2007 19:36:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932293AbXAGAg5
	(ORCPT <rfc822;git-outgoing>); Sat, 6 Jan 2007 19:36:57 -0500
Received: from hand.yhbt.net ([66.150.188.102]:33484 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932292AbXAGAg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 6 Jan 2007 19:36:56 -0500
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C62A97DC094;
	Sat,  6 Jan 2007 16:36:54 -0800 (PST)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Sat, 06 Jan 2007 16:36:54 -0800
To: alan <alan@clueserver.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701051414140.14017@blackbox.fnordora.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36109>

alan <alan@clueserver.org> wrote:
> I am trying to import a subversion repository and have yet to be able to 
> suck down the whole thing without segfaulting.  It is a large repository. 
> Works fine until about the last 10% and then runs out of memory.
> 
> open3: fork failed: Cannot allocate memory at /usr/bin/git-svn line 2711
> 512 at /usr/bin/git-svn line 446
>         main::fetch_lib() called at /usr/bin/git-svn line 314
>         main::fetch() called at /usr/bin/git-svn line 173
> 
> I need to try the "partial download" script and see if that helps.

Which version of git-svn is this?  If it's a public repository I'd
like to have a look.

git-svn memory usage should be bounded by:
	max(max(commit-message size),
	    max(number of files changed per revision))

I'm not sure if the size of the files changed per-revision or if the
size of the deltas is an issue with git-svn.  But if you have a repo
with big files and big changes to them, let me know so I can take a
look.

Can you also try lowering $inc in git-svn to something lower (perhaps
100)? (my $inc = 1000; in the fetch_lib function) and see if that helps
things?  Thanks.

-- 
Eric Wong
