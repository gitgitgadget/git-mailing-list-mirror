From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Wed, 12 Oct 2005 14:05:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510121355280.15297@g5.osdl.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
 <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
 <877jcjmdmq.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
 <87vf02qy79.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Wed Oct 12 23:09:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPnnG-0008HE-Es
	for gcvg-git@gmane.org; Wed, 12 Oct 2005 23:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751582AbVJLVFn (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 12 Oct 2005 17:05:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751583AbVJLVFn
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Oct 2005 17:05:43 -0400
Received: from smtp.osdl.org ([65.172.181.4]:62934 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751581AbVJLVFm (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 12 Oct 2005 17:05:42 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9CL5R4s029242
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Wed, 12 Oct 2005 14:05:27 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9CL5PPd017032;
	Wed, 12 Oct 2005 14:05:26 -0700
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87vf02qy79.fsf@penguin.cs.ucla.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10048>



On Wed, 12 Oct 2005, Paul Eggert wrote:
> 
> Your email message suggests that we need to be cautious here.
> That message contained UTF-8 text but its header said "Content-Type:
> TEXT/PLAIN; charset=ISO-8859-1".

Well, my email message was wrong and evil, because it _mixed_ two 
different encodings in the same text. No sane client could have shown them 
both at the same time - but especially with a stupid client, you could 
have changed your terminal to show either one or the other by switching 
from utf-8 to latin1 encoding and doing a refresh.

In other words, my email really was a nasty case of not one or the other, 
but both.

Now, I believe patches can actually be that way - it's not at all 
impossible to have a diff where the _filename_ is utf-8, but the content 
of the patch itself is some byte-encoding like latin1. Or the other way 
around.

> If we're still having problems like this in 2005 then I guess we need
> to deal with them.  This suggests we should be escaping every
> non-ASCII byte, at least for patches designed to be emailed robustly.

I find that email is very robust - it's basically 8-bit clean. No 
character encoding, no crap. Just a byte stream. It really _is_ the most 
reliable format.

Now, a lot of email clients are really weak in _showing_ it, and as 
mentioned, the email that mixed both is fundamentally not something you 
really even _can_ show sanely. But who cares? What matters is not what it 
looks like, but what it _saves_ as. If you save the email message, it 
should come out as the same reliable 8-bit byte stream, or your client is 
actively corrupting messages rather than just showing them.

This is really what my argument boils down to: character set encoding 
should _not_ EVER affect the _transfer_ of the data. It doesn't matter if 
something is latin1 or utf-8, the only thing that matters is the byte 
sequence. Only when you _display_ it should you try to figure out what the 
byte sequence possibly means.

So I repeat: 
 - escape as little as possible
 - make the _viewer_ decide how to view it.

Yes, if people use "cat" to view patches, it can be dangerous. But that's 
_their_ problem.

		Linus
