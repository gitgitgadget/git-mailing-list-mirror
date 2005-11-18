From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Rss produced by git is not valid xml?
Date: Fri, 18 Nov 2005 12:28:33 -0800
Message-ID: <437E3971.3060803@zytor.com>
References: <200511181833.40048.ismail@uludag.org.tr> <200511182127.06958.ismail@uludag.org.tr> <20051118200217.GA2831@vrfy.org> <200511182208.24248.ismail@uludag.org.tr> <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Ismail Donmez <ismail@uludag.org.tr>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Nov 18 21:30:06 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by deer.gmane.org with esmtp (Exim 3.35 #1 (Debian))
	id 1EdCqw-0005hB-00
	for <gcvg-git@gmane.org>; Fri, 18 Nov 2005 21:28:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932406AbVKRU2z (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 18 Nov 2005 15:28:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932407AbVKRU2z
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Nov 2005 15:28:55 -0500
Received: from terminus.zytor.com ([192.83.249.54]:59565 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932406AbVKRU2z
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Nov 2005 15:28:55 -0500
Received: from [10.4.1.13] (yardgnome.orionmulti.com [209.128.68.65])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.4/8.13.4) with ESMTP id jAIKScaN012136
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Fri, 18 Nov 2005 12:28:39 -0800
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc4 (X11/20050929)
X-Accept-Language: en-us, en
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0511181220350.13959@g5.osdl.org>
X-Virus-Scanned: ClamAV version 0.87.1, clamav-milter version 0.87 on localhost
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12255>

Linus Torvalds wrote:
> 
> It's easy to say "just do the right thing", and ignore reality.
> 
> git commit logs have always been "8-bit data". It's actually gitweb that 
> is buggy if it claims it is UTF-8 without checking or converting it to 
> such.
> 
> I agree that UTF-8 is a good idea, but that's a totally different 
> argument.
> 

I think the point is: what do you do with the data?  If it *looks* like 
valid UTF-8, you pretty much have to assume it is; if it's not (it 
contains invalid UTF-8 sequences), what do you do?  There are only a 
small handful of alternatives, and none are really good:

	- Reject it (it's kind of too late, should have been done at
	  checkin)
	- Show them as SUBSTITUTE characters (U+FFFD).
	- Show them as Latin-1 or Windows-1252
	- Provide a complex configuration mechanism

I think Kay is going with the second option.

Note this problem always exists for the data contents anyway.  We can't 
do anything about that.

What's probably more important is that tools that rely on email or other 
outside data sources (like CVS) do the necessary conversions, so one 
doesn't end up with an inadvertently incorrect repository.

	-hpa
