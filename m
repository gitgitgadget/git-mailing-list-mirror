From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 2/2] Define a few built-in attribute rules.
Date: Sat, 14 Apr 2007 21:30:37 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704142103210.5473@woody.linux-foundation.org>
References: <7vr6qod4wh.fsf@assigned-by-dhcp.cox.net> <200704131033.15751.andyparkins@gmail.com>
 <7vejmm78qp.fsf@assigned-by-dhcp.cox.net> <7vvefy5tzo.fsf@assigned-by-dhcp.cox.net>
 <Pine.LNX.4.64.0704141839030.5473@woody.linux-foundation.org>
 <7vr6qm5r73.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Sun Apr 15 06:31:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HcwOC-0001Bu-WB
	for gcvg-git@gmane.org; Sun, 15 Apr 2007 06:31:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751068AbXDOEal (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 15 Apr 2007 00:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751648AbXDOEal
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Apr 2007 00:30:41 -0400
Received: from smtp.osdl.org ([65.172.181.24]:46102 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750894AbXDOEal (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Apr 2007 00:30:41 -0400
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l3F4UcIs018561
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Sat, 14 Apr 2007 21:30:38 -0700
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l3F4UbC9006263;
	Sat, 14 Apr 2007 21:30:37 -0700
In-Reply-To: <7vr6qm5r73.fsf@assigned-by-dhcp.cox.net>
X-Spam-Status: No, hits=-0.955 required=5 tests=AWL,OSDL_HEADER_SUBJECT_BRACKETED
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.119__
X-MIMEDefang-Filter: osdl$Revision: 1.177 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44485>



On Sat, 14 Apr 2007, Junio C Hamano wrote:
> 
> You do not have to worry.

I do.

> That's how "crlf" is defined.  Paths you explicitly say !crlf
> will _not_ go through the existing core.autocrlf mechanism.

That's broken.

It should be:

 - "crlf": always do crlf.
 - "!crlf": never do crlf.
 - no attrbute: guess.

Why? Because quite frankly, it's quite possible that some file really *is* 
text, even if the content-based guessing doesn't catch it. 

It boils down to a simple truth: if our content-based guessing is so 
perfect that it never makes mistakes, there's no *point* to having a 
'crlf' attribute in the first place!

Here's a simple example:

	echo -e '\007Bell!' > bell

and just because we consider the BEL character to be binary, we'll think 
the file is binary.

Could we add the BEL character? Sure. But that's not the point. The 
*point* is that the whole and only reason for attributes in the first 
place is to _override_ guessing.

The guesses should be good enough that hopefully nobody really will ever 
need attributes. But people do strange things.

			Linus
