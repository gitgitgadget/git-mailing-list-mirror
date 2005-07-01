From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: "git-send-pack"
Date: Thu, 30 Jun 2005 17:02:57 -0700 (PDT)
Message-ID: <Pine.LNX.4.58.0506301656570.14331@ppc970.osdl.org>
References: <Pine.LNX.4.21.0506301651250.30848-100000@iabervon.org>
 <Pine.LNX.4.58.0506301412470.14331@ppc970.osdl.org> <42C46A3C.1070104@zytor.com>
 <Pine.LNX.4.58.0506301514240.14331@ppc970.osdl.org> <42C482ED.1010306@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Daniel Barkalow <barkalow@iabervon.org>,
	Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 01 01:53:52 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Do8qf-0004lq-1O
	for gcvg-git@gmane.org; Fri, 01 Jul 2005 01:53:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbVGAABE (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 30 Jun 2005 20:01:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263127AbVGAABE
	(ORCPT <rfc822;git-outgoing>); Thu, 30 Jun 2005 20:01:04 -0400
Received: from smtp.osdl.org ([65.172.181.4]:28641 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S263094AbVGAAA6 (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 Jun 2005 20:00:58 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j6100qjA007254
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 30 Jun 2005 17:00:52 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j6100pHk009902;
	Thu, 30 Jun 2005 17:00:51 -0700
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <42C482ED.1010306@zytor.com>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.40__
X-MIMEDefang-Filter: osdl$Revision: 1.111 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org



On Thu, 30 Jun 2005, H. Peter Anvin wrote:
> 
> In your linux-2.6 tree, there are currently 54,204 objects, and that is 
> after less than one full 2.6.x kernel release cycle.  That's a megabyte 
> of SHA1s.

But that's _all_ objects. There are "only" 4040 commit objects (which are
always the starting point for a search). 

So streaming out the commit objects a few hundred at a time is actually 
a very simple strategy. 

Also, note that the server is usually _more_ ahead than the client is, and 
the server is the one that potentially has lots of commits that the 
client doesn't have. Not the other way around. So if the client makes a 
list of it's top commits, it almost certainly won't have to make a very 
long list until the server can tell it "ok, stop, I've seen it".

Yeah, maybe we want to limit the "burst" to 70 sha1's, since that will fit 
in a regular-sized ethernet packet, but whatever - you'd burst out your 
commits "latest first", so you'd never even get to the current 4040 unless 
you've literally done the kind of work we've done in the git tree for the 
last 3 months _and_you've_not_pulled_from_that_server_in_the_whole_time_.

		Linus
