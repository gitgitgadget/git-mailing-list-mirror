From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Thu, 13 Oct 2005 22:20:53 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510132203220.23590@g5.osdl.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
 <87ek6s0w34.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111121030.14597@g5.osdl.org>
 <87slv7zvqj.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510111346220.14597@g5.osdl.org>
 <877jcjmdmq.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510120749230.14597@g5.osdl.org>
 <87vf02qy79.fsf@penguin.cs.ucla.edu> <Pine.LNX.4.64.0510121411550.15297@g5.osdl.org>
 <87irw1q7eu.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Fri Oct 14 07:22:32 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EQI0I-0006kN-9q
	for gcvg-git@gmane.org; Fri, 14 Oct 2005 07:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751087AbVJNFVL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 14 Oct 2005 01:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751471AbVJNFVK
	(ORCPT <rfc822;git-outgoing>); Fri, 14 Oct 2005 01:21:10 -0400
Received: from smtp.osdl.org ([65.172.181.4]:20157 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751087AbVJNFVJ (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 14 Oct 2005 01:21:09 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9E5Kt4s009748
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Thu, 13 Oct 2005 22:20:55 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9E5Krjd019553;
	Thu, 13 Oct 2005 22:20:53 -0700
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87irw1q7eu.fsf@penguin.cs.ucla.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.124 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/10097>



On Thu, 13 Oct 2005, Paul Eggert wrote:
> 
> Perhaps so, but it has a lot of company.  I have even worse problems
> with Mozilla Thunderbird.  And as we observed, Pine also has problems
> sending properly-formatted email containing arbitrary binary data.

No, pine does it right. Exactly because it sends _arbitraty_ binary data.

The fact that I turned the terminal into utf-8 mode in order to generate 
the bytes (that end up being a garbage string in latin1) is not pine's 
fault. 

The point being that because the transport was 8-bit clean, I could do 
that. I could mix a latin1-encoding with a UTF-8 encoding, and the other 
side could see the mixed setting. Now, the other side had no way of 
knowing that I mixed things (unless it was a smart human and could read 
and understand what I wrote), so any email client would have trouble 
showing it.

But it got _transferred_ right, and you could have saved the email, and 
turned the terminal into latin1 or utf-8 mode, and done a "cat" both ways, 
and you'd have seen both versions.

> I suspect the vast majority of email clients will screw up in
> relatively common cases involving unusual characters in file names.

Not if they just save it.

Oh, sure, they can't _display_ it, since they don't know what it is, but 
when they save it, they'd _better_ save it bit-for-bit.

Which is the right thing to do. Then you apply it with "patch", and you 
get the right answer.

> Using attachments avoids many of the problems, but lots of patches are
> emailed inline and I'd rather not force people to use attachments to
> send diffs.

inline or attachment should not matter to any sane email client. If it 
does, then the email client isn't sane.

The point is, when you save it, it _has_ to be saved bit-for-bit. 

The only difference between a binary attachment and a text thing is that 
an email client will _try_ to show the text thing to you as text. It has 
no other meaning.

And trying is better than not trying. Attachments are _inferior_ to inline 
for that reason.

> > I find that email is very robust - it's basically 8-bit clean. No 
> > character encoding, no crap. Just a byte stream. It really _is_ the most 
> > reliable format.
> 
> Hmm.  To test that theory, I just now sent plain-text email to myself,
> containing a carriage-return (CR) byte in the middle of a line.
> 
> The CR byte was transliterated into a LF.  Ooops.

I'm not surprised, since CR/LF is special for a lot of (sad) reasons. Oh, 
well.

I agree that it makes sense to escape \r, and obviously you _have_ to 
escape \n. In general, escaping pretty much everything in the 0-31 range 
is likely the right approach, since those are never printable anyway.

That, btw, is probably true of the patch contents too, not just the 
filename. The exception being \t (and in patch contents, \n is obviously 
part of the stream).

> More generally, I suspect inline patches with weird bytes will suffer
> greatly from encoding and recoding by mail agents.

I've had pretty good luck. We do have 8-bit stuff occasionally, but it 
almost always makes it through. 

Spaces and tabs are much worse (yes, they're more common too). That's 
clearly just crap mailers.

> Unfortunately this isn't true for Emacs, and I suspect other mailers
> will have similar problems.  For example, with Emacs I can easily save
> either the exact byte-for-byte message body that my mail transfer
> agent gave me; or I can have Emacs decode the message into its
> constituent characters, reencode the result as UTF-8, and put that
> into a file.

Well, as long as there's a choice.

> In neither case, though, am I saving the original byte
> stream that you presented to your mail user agent.  Even if I save the
> byte-for-byte message body, it is often in quoted-printable format so
> I'll have to decode strings like "=EF" to recover the original bytes.

You have a broken mail client. Now, I'm not a big fan of QP (I think it 
was making a stupid excuse for bad transport), but QP is a _mail_ level 
quoting protocol, and the same way a MUA uses QP to encode, the MUA should 
have de-coded the QP. It shouldn't leave it to somebody else.

I think GNU emacs is a horrible mistake ("do everything - badly"), but you 
may be able to fix it by letting your mail transport agent do the un-QP 
for you. A lot of them do, which makes it easier to then use weak MUA's.

Anyway, it sounds like GNU emacs made the wrong choices (hey, I'm not 
surprised). It should have decoded QP, not the character set. There are 
lots of tools that do charset conversions, that's not very email-specific.

			Linus
