From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Wanted - a file browser interface to git
Date: Tue, 18 Oct 2005 20:03:17 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510181952350.3369@g5.osdl.org>
References: <dj45np$e88$1@sea.gmane.org> <Pine.LNX.4.64.0510181806250.3369@g5.osdl.org>
 <4355A00B.4000806@research.att.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 19 05:04:45 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1ES4Ee-0006bl-HI
	for gcvg-git@gmane.org; Wed, 19 Oct 2005 05:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932430AbVJSDDV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 18 Oct 2005 23:03:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932442AbVJSDDV
	(ORCPT <rfc822;git-outgoing>); Tue, 18 Oct 2005 23:03:21 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4043 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932430AbVJSDDU (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Oct 2005 23:03:20 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9J33IFC025350
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 18 Oct 2005 20:03:18 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9J33HwR013738;
	Tue, 18 Oct 2005 20:03:18 -0700
To: John Ellson <ellson@research.att.com>
In-Reply-To: <4355A00B.4000806@research.att.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.55__
X-MIMEDefang-Filter: osdl$Revision: 1.125 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10260>



On Tue, 18 Oct 2005, John Ellson wrote:
> Linus Torvalds wrote:
> > 
> > You are aware of "git whatchanged -p xxx", right?
> 
> I wasn't aware of it, no.  Looks very useful.  Thanks.
> 
> I see that you can take the tree id from the diff-tree lines and
> then produce the state of the file at that time with "cg-admin-cat -r <id>
> xxx"
> Is that how you would do it?

Well, I'd do it with the git commands: once you see the diff, you should 
know the SHA1's of the source and destination, and then you can just do

	git-cat-file blob [sha1]

to get the before (or after) state.

The way I'd get the SHA1 is either (now with the extended diff format) in 
the short form from the diff itself (the "index" line), or by just 
separately doing a

	git-diff-tree -r [sha-of-commit]

to see the "raw" diff format.

All the diff things can take a pathname limiter, the same way 
"git-whatchanged" does, so if you are only interested in one file, just 
name the file:

	git-diff-tree -r [sha-of-commit] [filename]

And just to make clear how powerful this is: "filename" doesn't have to be 
a single file. It can be a set of files and/or directories, so if you want 
to track multiple things at the same time, just do multiple filenames.

What I do a lot is to check what has changed in some particular subsystem, 
ie somebody says that something broke in SCSI, and then I do

	git-whatchanged -p drivers/scsi/ include/scsi/

and it will show any changes to anything under either of those 
directories.

"git-whatchanged" really is very powerful. The silly thing is that it 
really boils down to just a single line script (well, with various 
argument handling etc it's actually five lines, but the "core" is really 
just a single pipeline of "git-rev-list | git-diff-tree --stdin".

> Are there any plans for cogito to support it?

Well, cogito could certainly just do a "cg-whatchanged", but it's really 
the same thing. Since cogito depends on git anyway, cogito users could 
just use the git-whatchanged functionality.

Or to make it more seamless, just do

	alias cg-whatchanged=git-whatchanged

or something like that ;^)

			Linus
