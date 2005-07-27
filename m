From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Linux BKCVS kernel history git import..
Date: Wed, 27 Jul 2005 08:29:49 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0507270819550.3227@g5.osdl.org>
References: <Pine.LNX.4.58.0507261136280.19309@g5.osdl.org>
 <1122457238.3027.37.camel@baythorne.infradead.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: tglx@linutronix.de, Git Mailing List <git@vger.kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Jul 27 17:31:30 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Dxnre-0000yp-Ib
	for gcvg-git@gmane.org; Wed, 27 Jul 2005 17:30:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261253AbVG0PaK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jul 2005 11:30:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261297AbVG0PaK
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jul 2005 11:30:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:33461 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261253AbVG0PaH (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 27 Jul 2005 11:30:07 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6RFTojA028407
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 27 Jul 2005 08:29:50 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6RFTn5E026018;
	Wed, 27 Jul 2005 08:29:50 -0700
To: David Woodhouse <dwmw2@infradead.org>
In-Reply-To: <1122457238.3027.37.camel@baythorne.infradead.org>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.113 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Wed, 27 Jul 2005, David Woodhouse wrote:

> On Tue, 2005-07-26 at 11:57 -0700, Linus Torvalds wrote:
> > If somebody adds some logic to "parse_commit()" to do the "fake parent"
> > thing, you can stitch the histories together and see the end result as one
> > big tree. Even without that, you can already do things like
> > 
> >         git diff v2.6.10..v2.6.12
> 
> That's a bit of a hack which really doesn't belong in the git tools.

Actually, it's not a hack at all. It's very fundamentally how git works: 
you give it two trees that it knows about, and it will show the 
differences between them - regardless of whether they share any common 
ancestry or not.

> It's not particularly hard to reparent the tree for real -- I'd much
> rather see a tool added to git which can _actually_ change the
> 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 commit to have a parent of
> 0bcc493c633d78373d3fcf9efc29d6a710637519, and ripple the corresponding
> SHA1 changes up to the current HEAD.

I used to think I wanted to, but these days I really don't. One of the
reasons is that I expect to try to pretty up the old bkcvs conversion some
time: use the name translation from the old "shortlog" scripts etc, and
see if I can do some other improvements on the conversion (I think I'll
remove the BK files - "ChangeSet" etc).

And it's really much easier and more general to have a "graft" facility.  
It's something that git can do trivially (literally a hook in
"parse_commit" to add a special parent), and it's actually a generic
mechanism exactly for issues like this ("project had old history in some
other format").

Somebody already asked for having the import history for old historic 
patches - which we _do_ actually have as patches, but which obviously 
don't have any changelogs except for the version information. Most people 
may not want that, but the thing is, with a "graft" facility, the people 
who _do_ want that can easily see it all, and it is totally seamless.

So it's not even a one-time hack - it's a real feature that just in the 
kernel would have several cases we'd be able to use it for, and the same 
is likely true for almost any other project that wasn't started purely 
from git..

		Linus
