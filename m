From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a
 subdirectory
Date: Sat, 13 Jan 2007 16:52:21 -0800
Message-ID: <45A97EC5.10401@midwinter.com>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net> <7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net> <7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net> <200701140111.20671.Josef.Weidendorfer@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 14 01:52:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H5tbn-0001Hi-RK
	for gcvg-git@gmane.org; Sun, 14 Jan 2007 01:52:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750726AbXANAwZ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 13 Jan 2007 19:52:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750743AbXANAwZ
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Jan 2007 19:52:25 -0500
Received: from tater.midwinter.com ([216.32.86.90]:47311 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750726AbXANAwY (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Jan 2007 19:52:24 -0500
Received: (qmail 1947 invoked from network); 14 Jan 2007 00:52:24 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 14 Jan 2007 00:52:23 -0000
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>
In-Reply-To: <200701140111.20671.Josef.Weidendorfer@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36787>

Josef Weidendorfer wrote:
> Why not add a general "--top" option to the "git" wrapper,
> to temporarily let git change to the toplevel while running
> the command?
>   

If I can add a config entry so --top is the default, then that's 
acceptable, but IMO it should be the default and we should, at most, 
spit out a warning if a command is run in a subdirectory and there's a 
chance of confusion.

When I run one of the commands that currently can't run in a 
subdirectory and it spits out its error message, I NEVER react to that 
by saying, "Oops, forgot I was in a subdirectory, guess I didn't want to 
run that after all." (Have any of you said that, even once?) I react by 
grimacing and typing "cd" so the command will do what I told it to do. I 
have done that every single time I've gotten the in-a-subdirectory 
error. And muttering under my breath something along the lines of, "The 
code knows everything it needs to know to do what I just told it to, but 
it's making me take seconds to do by hand what it could have done on its 
own in nanoseconds."

Which is why I think the commands should just cd to the top directory as 
needed. Doing otherwise is just making the user do pointless busywork. 
IMO any command that, if run in a subdirectory, currently does nothing 
but spit out a "hey, you can't run me in a subdirectory!" error is not 
doing what the user wanted. The user never runs one of those commands 
hoping to see an error message or to test whether he's in the top-level 
directory. I can't think of any situation in which I'd want to see that 
error instead of the --top behavior.

It is entirely possible that automatically changing to the top directory 
will also do something other than what the user wanted some percentage 
of the time, but that percentage will be far, far lower than 100, which 
is what it is now. And I posit that the number of users confused or 
frustrated by the whole-tree operations after the first time they see it 
happen (after which it won't be unexpected) will be far smaller than the 
number frustrated by the current pointless error message on a regular basis.

> The wish to allow git-fetch from subdirectories is the
> inconvenience to have to cd up, and later down. This is
> avoided by running "git --top fetch", and theses people
> should be happy.
>
> Yet, if the command outputs some relative paths, the
> user is very well aware that these paths are from the
> toplevel, as he explicitly specified "--top".
>   

That would be covered just as well by outputting a status message before 
any relative paths, e.g.

Updating /home/john/git-repo ...
Conflict: src/foo.c

(Not that that's real git output, but you get the idea.) It could be 
suppressed when the command is run from the top-level directory, though 
I think it'd be better to just always output it for consistency's sake.

-Steve
