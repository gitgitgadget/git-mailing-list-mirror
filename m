From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] Try URI quoting for embedded TAB and LF in pathnames
Date: Tue, 11 Oct 2005 08:17:25 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0510110802470.14597@g5.osdl.org>
References: <7vu0ftyvbc.fsf@assigned-by-dhcp.cox.net> <20051007232909.GB8893@steel.home>
 <7vpsqgyjrj.fsf@assigned-by-dhcp.cox.net> <20051008064555.GA3831@steel.home>
 <7vachks7aq.fsf@assigned-by-dhcp.cox.net> <20051008133032.GA32079@localhost>
 <7v64s7svya.fsf@assigned-by-dhcp.cox.net> <7vu0frpxs1.fsf@assigned-by-dhcp.cox.net>
 <87mzlgh8xa.fsf@penguin.cs.ucla.edu>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Junio C Hamano <junkio@cox.net>,
	Robert Fitzsimons <robfitz@273k.net>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org,
	Kai Ruemmler <kai.ruemmler@gmx.net>
X-From: git-owner@vger.kernel.org Tue Oct 11 17:21:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EPLw7-0001kd-Pw
	for gcvg-git@gmane.org; Tue, 11 Oct 2005 17:21:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751176AbVJKPVA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 11 Oct 2005 11:21:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751322AbVJKPU7
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Oct 2005 11:20:59 -0400
Received: from smtp.osdl.org ([65.172.181.4]:4803 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751176AbVJKPU7 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Oct 2005 11:20:59 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id j9BFHR4s017682
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Tue, 11 Oct 2005 08:17:28 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id j9BFHPAw011371;
	Tue, 11 Oct 2005 08:17:26 -0700
To: Paul Eggert <eggert@CS.UCLA.EDU>
In-Reply-To: <87mzlgh8xa.fsf@penguin.cs.ucla.edu>
X-Spam-Status: No, hits=0 required=5 tests=
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.52__
X-MIMEDefang-Filter: osdl$Revision: 1.123 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/9971>



On Mon, 10 Oct 2005, Paul Eggert wrote:
> 
> An issue I hadn't really had time to think about is the character
> encoding of file names.

Please don't. Use filenames as if they are just binary blobs of data, 
that's the only thing that has a high chance of success. Yes, it too can 
break in the presense of something _else_ doing character translation 
and/or people moving a patch from one encoding to another , buthat's 
just true of anything.

Eventually everybody will hopefully use UTF-8, and nothing else really 
matters, but the thing is, if you see filenames as just blobs of data, 
that works with UTF-8 too, so it's not "wrong" even in the long run. And 
until everybody has one single encoding, you simply won't be able to tell, 
and the likelihood that you'd screw up is pretty high.

The happy part of the "binary blob" approach is that users _understand_ 
it. People who actively use different encoding formats are (painfully) 
aware of conversions, and they may curse you for not doing the random 
encoding format of the day, but they will be able to handle it.

In contrast, if you start doing conversions, I guarantee you that people 
will _not_ be able to handle it when you do something strange - you've 
changed the data.

Personally, I'd like the normal C quoting the best. Leave space as-is, and 
quote TAB/NL as \t and \n respectively. It's pretty universally understood 
in programming circles even outside of C, and it's not like a very 
uncommon patch format like that really needs to be well-understood outside 
of those circles.

It also has a very obvious and ASCII-safe format for other characters (ie 
just the normal octal escapes: \377 etc..

That said, I personally don't think it's necessarily even worth it. If 
somebody wants to use names with tabs and newlines, is he really going to 
work with diffs? Or is it just a driver error?

			Linus
