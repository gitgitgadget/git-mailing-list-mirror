From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all
 entries
Date: Thu, 11 Jan 2007 10:02:52 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701111001150.3594@woody.osdl.org>
References: <81b0412b0701040247k47e398e6q34dd5233bb5706f6@mail.gmail.com> 
 <81b0412b0701040447u329dcf9bvcd7adb9e9d199f18@mail.gmail.com> 
 <7v8xgileza.fsf@assigned-by-dhcp.cox.net>  <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com>
  <20070107163112.GA9336@steel.home>  <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net>
  <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com> 
 <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org> 
 <81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com> 
 <Pine.LNX.4.64.0701110823300.3594@woody.osdl.org>
 <81b0412b0701110943s274bfbcbkfea0fcb294ccb820@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 19:03:20 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H54Gc-0001Jx-AV
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 19:03:10 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751318AbXAKSDH (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 13:03:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751349AbXAKSDG
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 13:03:06 -0500
Received: from smtp.osdl.org ([65.172.181.24]:50995 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751318AbXAKSDE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jan 2007 13:03:04 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0BI2rWi031589
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 11 Jan 2007 10:02:53 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0BI2qPr031282;
	Thu, 11 Jan 2007 10:02:52 -0800
To: Alex Riesen <raa.lkml@gmail.com>
In-Reply-To: <81b0412b0701110943s274bfbcbkfea0fcb294ccb820@mail.gmail.com>
X-Spam-Status: No, hits=-2.664 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED,PATCH_SUBJECT_OSDL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.107__
X-MIMEDefang-Filter: osdl$Revision: 1.167 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36600>



On Thu, 11 Jan 2007, Alex Riesen wrote:

> On 1/11/07, Linus Torvalds <torvalds@osdl.org> wrote:
> > That said, I think we actually have another problem entirely:
> > 
> > Look at "write_cache()", Junio: isn't it leaking memory like mad?
> 
> Unless it is used in some corner case not covered by tests - it
> looks like it does leak memory like mad. With the patch the
> memory usage for 44k-merge is more than halved!

Is that halving on _top_ of your and Junio's fixes to not flush 
unnecessarily?

Junio, I looked and looked, and that trivial one-liner definitely looks 
right to me. The pointer is not free'd by anybody else, and none of the 
things we call in to with it save it away, and they expect the caller to 
manage it.

And it does pass all the tests, although I don't know how much coverage 
they have in this area..

		Linus
