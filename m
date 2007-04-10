From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 3/6] Add 'resolve_gitlink_ref()' helper function
Date: Tue, 10 Apr 2007 07:58:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704100756060.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704092100110.6730@woody.linux-foundation.org> 
 <Pine.LNX.4.64.0704092114010.6730@woody.linux-foundation.org>
 <81b0412b0704100238l38ad3765w6c06878e2db654a7@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 11 00:33:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbHnn-0002Hd-55
	for gcvg-git@gmane.org; Tue, 10 Apr 2007 16:58:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753891AbXDJO6c (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 10 Apr 2007 10:58:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbXDJO6c
	(ORCPT <rfc822;git-outgoing>); Tue, 10 Apr 2007 10:58:32 -0400
Received: from smtp.osdl.org ([65.172.181.24]:59826 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753891AbXDJO6b (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Apr 2007 10:58:31 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3AEwSPD012519
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 10 Apr 2007 07:58:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3AEwRtW009963;
	Tue, 10 Apr 2007 07:58:27 -0700
In-Reply-To: <81b0412b0704100238l38ad3765w6c06878e2db654a7@mail.gmail.com>
X-Spam-Status: No, hits=-0.958 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44144>



On Tue, 10 Apr 2007, Alex Riesen wrote:
>
> On 4/10/07, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > +int resolve_gitlink_ref(const char *path, const char *refname, unsigned
> > char *result)
> > +{
> > +       int len = strlen(path), retval;
> > +       char *gitdir;
> > +
> > +       while (len && path[len-1] == '/')
> > +               len--;
> > +       if (!len)
> > +               return -1;
> > +       gitdir = xmalloc(len + MAXREFLEN + 8);
> > +       memcpy(gitdir, path, len);
> > +       memcpy(gitdir + len, "/.git/", 7);
> 
> Can't a subproject be bare?

Not when it is checked out, no. That's what "checked out" means ;)

If a subproject is bare, it never gets resolved, because it's never 
checked out in a superproject.

So a subproject *can* be bare, but when it's bare it is just a totally 
regular independent git project, simply by *definition* of not being 
checked out inside a superproject.

But hey, that was just a design decision of mine, and if people can argue 
for it being wrong, I don't think I'm married to it ;)

		Linus
