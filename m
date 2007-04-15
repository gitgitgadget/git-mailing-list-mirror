From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Expose subprojects as special files to "git diff" machinery
Date: Sun, 15 Apr 2007 12:05:44 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704151204320.5473@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0704151100550.5473@woody.linux-foundation.org>
 <20070415190119.GA21786@uranus.ravnborg.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
To: Sam Ravnborg <sam@ravnborg.org>
X-From: git-owner@vger.kernel.org Sun Apr 15 21:06:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HdA3F-0001ec-Ct
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 21:06:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753317AbXDOTFv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 15:05:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753368AbXDOTFv
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 15:05:51 -0400
Received: from smtp.osdl.org ([65.172.181.24]:33081 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753317AbXDOTFu (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 15:05:50 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3FJ5jIs022541
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sun, 15 Apr 2007 12:05:45 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3FJ5ile018446;
	Sun, 15 Apr 2007 12:05:44 -0700
In-Reply-To: <20070415190119.GA21786@uranus.ravnborg.org>
X-Spam-Status: No, hits=-0.454 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44504>



On Sun, 15 Apr 2007, Sam Ravnborg wrote:

> >  
> > +static int diff_populate_gitlink(struct diff_filespec *s, int size_only)
> > +{
> > +	int len;
> > +	char *data = xmalloc(100);
> > +	len = snprintf(data, 100,
> > +		"Subproject commit %s\n", sha1_to_hex(s->sha1));
> 
> In userland I would use a local variable for an array of the size of 100.
> I would normally only allocate when we are say 5x bigger.

We're _returning_ the pointer to the caller, so no, we cannot use an 
automatic array.

But I do think I had a bug - I think I should have set

	s->should_free = 1;

to let the caller know it should be free'd with free(), and not leak the 
thing.

		Linus
