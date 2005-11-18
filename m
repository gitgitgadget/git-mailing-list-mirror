From: Linus Torvalds <torvalds@osdl.org>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 12:47:59 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0511181237040.13959@g5.osdl.org>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr>
 <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr>
 <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org> <437E3971.3060803@zytor.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 21:48:16 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdD9c-0007Ec-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:48:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161184AbVKRUsN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:48:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161198AbVKRUsN
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:48:13 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47011 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1161184AbVKRUsM (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Nov 2005 15:48:12 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id jAIKm4nO028794
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Fri, 18 Nov 2005 12:48:04 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id jAIKlxi0031740;
	Fri, 18 Nov 2005 12:48:01 -0800
To: "H. Peter Anvin" <hpa@zytor.com>
In-Reply-To: <437E3971.3060803@zytor.com>
X-MIMEDefang-Filter: osdl$Revision: 1.127 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12260>



On Fri, 18 Nov 2005, H. Peter Anvin wrote:
> 
> I think the point is: what do you do with the data?  If it *looks* like valid
> UTF-8, you pretty much have to assume it is; if it's not (it contains invalid
> UTF-8 sequences), what do you do?

Btw, this is not a new issue.

This is true even of data that _claims_ to be UTF-8 but contains sequences 
that are illegal. A program that just barfs on it is a buggy program.

And yes, I know there are buggy programs out there. I seem to recall some 
perl(?) problems when it got UTF-8 strings that weren't, and did 
impossible things.

> There are only a small handful of alternatives, and none are really good:
> 
> 	- Reject it (it's kind of too late, should have been done at
> 	  checkin)

It can't be done at checkin, since it's not _wrong_. It's 8-bit data. 

It's like saying that /bin/echo is an illegal program and shouldn't be 
executed, because it's not encoded in utf-8.

I can well imagine somebody wanting to put a binary signature at the end 
of a commit. git shouldn't care, and the important thing to realize is 
that there _is_ no "encoding" for such things. So the commits don't 
necessarily have to have a font encoding at all, and any visualization 
tool should just accept that fact.

> 	- Show them as SUBSTITUTE characters (U+FFFD).
> 	- Show them as Latin-1 or Windows-1252
> 	- Provide a complex configuration mechanism
> 
> I think Kay is going with the second option.

Which is a fine option. Latin-1 is probably the right choice for the 
kernel, but not necessarily for other projects.

Another option is to just pass them through unmodified, and encourage the 
XML parser to handle it. Anything that takes UTF-8 and doesn't have some 
fallback to handle malformed input is basically buggy. It simply _will_ 
happen occasionally, quite independently of git.  You can either give up, 
or try to handle it. And giving up is always the wrong choice.

			Linus
