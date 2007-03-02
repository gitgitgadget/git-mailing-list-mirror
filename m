From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] Quick description of possible gitattributes system
Date: Fri, 2 Mar 2007 08:58:24 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0703020850470.3953@woody.linux-foundation.org>
References: <200703011206.47213.andyparkins@gmail.com> <es9aal$5gf$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463790079-1763019354-1172854704=:3953"
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 02 17:59:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HNB5y-0006sF-5W
	for gcvg-git@gmane.org; Fri, 02 Mar 2007 17:59:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992613AbXCBQ62 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 2 Mar 2007 11:58:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992614AbXCBQ62
	(ORCPT <rfc822;git-outgoing>); Fri, 2 Mar 2007 11:58:28 -0500
Received: from smtp.osdl.org ([65.172.181.24]:34502 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S2992613AbXCBQ61 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 2 Mar 2007 11:58:27 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l22GwPAb026656
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 2 Mar 2007 08:58:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l22GwOY1013272;
	Fri, 2 Mar 2007 08:58:25 -0800
In-Reply-To: <es9aal$5gf$1@sea.gmane.org>
X-Spam-Status: No, hits=-2.447 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.176 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41230>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463790079-1763019354-1172854704=:3953
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT



On Fri, 2 Mar 2007, Jakub Narebski wrote:

> Andy Parkins wrote:
> 
> > + - prettyfilter
> > +   Run by git-cat-file or git-show when content is being pretty-printed
> > +   for display to the user.  If no prettyfilter is set, then it should
> > +   default to outfilter.
> 
> I'd rather have plumbing operate without filters (if it is possible),
> so git-cat-file would not run prettyfilter, and git-show would run it.

That really sucks. I do "git show xyz > filname" all the time, and while 
it's been about diffs and commits, I could imagine doing the same thing 
for things like "git show v2.6.17:Documentation/logo.gif > some.gif" too.

Yes, I know could do "git cat-file -p .." instead, but since we added "git 
show", and made it do the Right Thing (tm) for blobs, I've come to use it 
more (which is as it should be: "cat-file" is low-level plumbing, while 
"git show" is what you'd expect users to use.

So I really think that the issue here is that the *pager* should do the 
right thing. Which gets us to:

> Or at least detect if output is tty, so one can do something like
> "git cat-file -p v1.0.0:gitweb/git-logo.png > git-logo.png" and get
> expected result, while "git show v1.0.0:gitweb/git-logo.png" would
> show the image.

Yes. How about just having the built-in git pager do the right thing?

Right now we actually wait for data to start arriving (commit 35ce862) due 
to working around a bug in less. But what if we could make the pager 
actually do the right thing here automatically? With "less" just being the 
default action for *text*?

			Linus
---1463790079-1763019354-1172854704=:3953--
