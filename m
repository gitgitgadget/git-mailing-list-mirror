From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: git branch --switch?
Date: Tue, 17 Apr 2007 09:44:43 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704170938510.5473@woody.linux-foundation.org>
References: <4624CD58.90103@gmail.com> <C940520E-732A-4F6E-A7F2-0215FD534455@silverinsanity.com>
 <4624EAAA.6040000@gmail.com> <4624F4BB.7010308@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brian Gernhardt <benji@silverinsanity.com>, git@vger.kernel.org
To: Rene Herman <rene.herman@gmail.com>
X-From: git-owner@vger.kernel.org Tue Apr 17 18:45:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hdqna-0000DH-Ld
	for gcvg-git@gmane.org; Tue, 17 Apr 2007 18:44:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031147AbXDQQoz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 Apr 2007 12:44:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031161AbXDQQoz
	(ORCPT <rfc822;git-outgoing>); Tue, 17 Apr 2007 12:44:55 -0400
Received: from smtp.osdl.org ([65.172.181.24]:53953 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031147AbXDQQoy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 Apr 2007 12:44:54 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3HGik6q008872
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 17 Apr 2007 09:44:46 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3HGihMt001842;
	Tue, 17 Apr 2007 09:44:45 -0700
In-Reply-To: <4624F4BB.7010308@gmail.com>
X-Spam-Status: No, hits=-0.385 required=5 tests=AWL,HTML_MESSAGE
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44794>



On Tue, 17 Apr 2007, Rene Herman wrote:

> On 04/17/2007 05:41 PM, Rene Herman wrote:
> 
> > You'd be quite right in saying that there isn't much point; if I want to now
> > start populating branch a, I have to "git checkout a" anyway, and that
> > action _will_ now be instantaneous.
> 
> Actually, I take that back, it's not instantaneous at all. 1995 systems are
> much better at showing long delays than those fancy modern computers are!

You'll always have at least _one_ slow checkout. If you checkout at all.

The kernel archive is 8 million lines - 240MB or so checked out. Writing 
out that 240 MB to disk is not going to be instantaneous even on a modern 
machine, although having so much memory that you can ignore the writeout 
and let it happen in the background will certainly help.

If you don't need to build the tree, you can avoid the checkout entirely, 
of course. Most git operations don't actually need a checked-out tree at 
all, and you could even have done a bare clone and just inspected it with 
git tools if that's what is wanted.

So you could have avoided the checkout completely, and done

	git clone -l -s -n <a local linux repo> local
	git branch v20 v2.6.20
	git branch a v20
	git branch b v20
	git branch c v20

and now you'd have four branches that all point to the v20 thing, and none 
of them are actually checked out. And all of that would have been 
instantaneous, even on an old machine (apart fromt he clone itself, of 
course ;)

But the moment you decide to write 240MB to disk, you'll be slow.

			Linus
