From: fork0@t-online.de (Alex Riesen)
Subject: Re: [PATCH] Speedup recursive by flushing index only once for all entries
Date: Thu, 11 Jan 2007 22:48:26 +0100
Message-ID: <20070111214826.GC6058@steel.home>
References: <7v8xgileza.fsf@assigned-by-dhcp.cox.net> <81b0412b0701050322u67131900xea969b2da9981a94@mail.gmail.com> <20070107163112.GA9336@steel.home> <7vr6u2adgx.fsf@assigned-by-dhcp.cox.net> <81b0412b0701101507n764aed73p31c7533e743283f0@mail.gmail.com> <Pine.LNX.4.64.0701101521410.3594@woody.osdl.org> <81b0412b0701110102m5264696dg68a573e9d5f2a17c@mail.gmail.com> <Pine.LNX.4.64.0701110823300.3594@woody.osdl.org> <81b0412b0701110943s274bfbcbkfea0fcb294ccb820@mail.gmail.com> <Pine.LNX.4.64.0701111001150.3594@woody.osdl.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 11 22:49:03 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H57n5-0004Fh-OM
	for gcvg-git@gmane.org; Thu, 11 Jan 2007 22:48:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932081AbXAKVsx (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 11 Jan 2007 16:48:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932137AbXAKVsx
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Jan 2007 16:48:53 -0500
Received: from mailout11.sul.t-online.com ([194.25.134.85]:43916 "EHLO
	mailout11.sul.t-online.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S932081AbXAKVsw (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 11 Jan 2007 16:48:52 -0500
Received: from fwd30.aul.t-online.de 
	by mailout11.sul.t-online.com with smtp 
	id 1H57ml-0001K2-01; Thu, 11 Jan 2007 22:48:35 +0100
Received: from tigra.home (E1VNkOZbregkrwTIUCQvAetTzamKahFpomSQ-BOC1D5V+rU52y5QYF@[84.163.96.128]) by fwd30.sul.t-online.de
	with esmtp id 1H57md-0Egjyq0; Thu, 11 Jan 2007 22:48:27 +0100
Received: from steel.home (steel.home [192.168.1.2])
	by tigra.home (Postfix) with ESMTP id CFE02277B6;
	Thu, 11 Jan 2007 22:48:26 +0100 (CET)
Received: by steel.home (Postfix, from userid 1000)
	id 91E1AC166; Thu, 11 Jan 2007 22:48:26 +0100 (CET)
To: Linus Torvalds <torvalds@osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0701111001150.3594@woody.osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-ID: E1VNkOZbregkrwTIUCQvAetTzamKahFpomSQ-BOC1D5V+rU52y5QYF
X-TOI-MSGID: 2e161a36-787f-4ded-9dd5-7c111c9ba147
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36616>

Linus Torvalds, Thu, Jan 11, 2007 19:02:52 +0100:
> > > That said, I think we actually have another problem entirely:
> > > 
> > > Look at "write_cache()", Junio: isn't it leaking memory like mad?
> > 
> > Unless it is used in some corner case not covered by tests - it
> > looks like it does leak memory like mad. With the patch the
> > memory usage for 44k-merge is more than halved!
> 
> Is that halving on _top_ of your and Junio's fixes to not flush 
> unnecessarily?

Yes.

> And it does pass all the tests, although I don't know how much coverage 
> they have in this area..

Quite a bit: criss-cross, renames, simple. My 44k-merge is just a
primitive two-head merge useful only as a stress test (it doesn't even
has any renames).
