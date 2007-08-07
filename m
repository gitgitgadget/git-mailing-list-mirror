From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH] Add --show-touched option to show "diff --git" line when
 contents are unchanged
Date: Tue, 07 Aug 2007 13:56:35 +0800
Message-ID: <46B80993.3080409@midwinter.com>
References: <vpqwswf8c1i.fsf@bauges.imag.fr> <7v4pjj5fp6.fsf@assigned-by-dhcp.cox.net> <vpqhcni47ek.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021050500.14781@racer.site> <vpqbqdq45ua.fsf@bauges.imag.fr> <Pine.LNX.4.64.0708021147110.14781@racer.site> <AF1190E2-A0F4-479F-B0A1-50B2C7278995@yahoo.ca> <Pine.LNX.4.64.0708021541520.14781@racer.site> <46B1F3F4.5030504@midwinter.com> <Pine.LNX.4.64.0708021614420.14781@racer.site> <20070803053717.GA16379@midwinter.com> <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Jean-Fran?ois Veillette <jean_francois_veillette@yahoo.ca>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Aug 07 07:56:51 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1III3i-000754-2E
	for gcvg-git@gmane.org; Tue, 07 Aug 2007 07:56:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751022AbXHGF4l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 7 Aug 2007 01:56:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751220AbXHGF4l
	(ORCPT <rfc822;git-outgoing>); Tue, 7 Aug 2007 01:56:41 -0400
Received: from tater2.midwinter.com ([216.32.86.91]:48700 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with SMTP
	id S1750913AbXHGF4k (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Aug 2007 01:56:40 -0400
Received: (qmail 27481 invoked from network); 7 Aug 2007 05:56:40 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=nXgXmH0WCx3/UHdBctCnXhS+icy2yedCuvIyVhVQNxrI0FsnPtqbhfS1ntW5BOsK  ;
Received: from localhost (HELO sgrimm-mbp.local) (koreth@127.0.0.1)
  by localhost with SMTP; 7 Aug 2007 05:56:39 -0000
User-Agent: Thunderbird 2.0.0.6 (Macintosh/20070728)
In-Reply-To: <alpine.LFD.0.999.0708062118190.5037@woody.linux-foundation.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55219>

Linus Torvalds wrote:
> It's not that the old output is "useful" in itself, but it's important for 
> people to know that the index is clean. So I'd suggest just setting a flag 
> when the header isn't printed, and then printing out a single line at the 
> end about "git index not up-to-date" or something.
>   

Or even a count of the number of files whose index data is unclean. I'd 
be fine with that as a suffix to the diff output.

> Doing a "git diff" cannot actually update the index (since it very much 
> has to work on a read-only setup too), which is why the index _stays_ 
> stale unless something is done (eg "git status") to refresh it. And it's 
> that stale index that continues to make for bad performance without any 
> indication of why that is a problem.
>   

I totally agree that there needs to be a way to tell if the index is 
clean or not. I do wonder if the default output of "git diff" is the 
right place for that information, but if the notification can be 
collapsed to a line or two (rather than the unbounded number of lines 
that it potentially outputs now) then that's probably good enough.

Actually, though this will probably make people roll their eyes, before 
this discussion I would have guessed that "git status" would be the 
command that would tell you the index was out of date, and that there'd 
be a separate command (say, "git update-index"?) that you could then use 
to sync things up again. The fact that "git status" is really "git 
update index a little bit then show status" was not something I 
expected; it presents itself as a query utility, not an update utility, 
so I would have expected it to be read-only. Its index-modifying 
behavior is not even hinted at in the documentation (a patch for which 
follows.)

-Steve
