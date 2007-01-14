From: Steven Grimm <koreth@midwinter.com>
Subject: Re: [PATCH 3/3] Allow whole-tree operations to be started from a
 subdirectory
Date: Sun, 14 Jan 2007 10:13:53 -0800
Message-ID: <45AA72E1.6060701@midwinter.com>
References: <7v8xg9x8uu.fsf@assigned-by-dhcp.cox.net>	<7vy7o8rnyw.fsf_-_@assigned-by-dhcp.cox.net>	<7vac0orml9.fsf_-_@assigned-by-dhcp.cox.net>	<200701140111.20671.Josef.Weidendorfer@gmx.de>	<45A97EC5.10401@midwinter.com> <7virfaie1m.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Josef Weidendorfer <Josef.Weidendorfer@gmx.de>,
	Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 15 19:30:09 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@m.gmane.org
Received: from main.gmane.org ([80.91.229.2] helo=ciao.gmane.org)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6VWa-0000uv-VC
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 18:21:36 +0100
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1H6V7k-0003eK-9G
	for gcvg-git@m.gmane.org; Mon, 15 Jan 2007 17:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751446AbXANSNy (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 14 Jan 2007 13:13:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbXANSNy
	(ORCPT <rfc822;git-outgoing>); Sun, 14 Jan 2007 13:13:54 -0500
Received: from tater.midwinter.com ([216.32.86.90]:37891 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751446AbXANSNx (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 14 Jan 2007 13:13:53 -0500
Received: (qmail 1418 invoked from network); 14 Jan 2007 18:13:52 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.130?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 14 Jan 2007 18:13:52 -0000
User-Agent: Thunderbird 1.5.0.9 (Macintosh/20061207)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7virfaie1m.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36823>

Junio C Hamano wrote:
> I consider that being in a subdirectory means the user is in the
> middle of actively working on something in that area.  Honestly
> I do not understand why anybody would want to run the five
> whole-tree commands under discussion (merge, pull, rebase,
> revert and cherry-pick) in the middle of doing something, so
> from the theoretical point of view I would agree that it makes
> sense for the commands to internally cd-up to do their work, I
> am not sure how much practical value it would add.
>   

Here's one use case for merge/pull/rebase that is, if not an everyday 
thing, then at least fairly common in my group: Person B fixes a bug in 
some code that's causing problems for the code person A is working on. 
Person A is not at a stopping point in his own work yet, but wants to 
get the fix.

Revert and cherry-pick are less common here but consider this: some 
people want submodule support because they're working on a specific part 
of the tree. They only cd into a subdirectory because there's no way for 
them to make that subdirectory the top level of their local repository. 
The fact that there are siblings of their current directory is just an 
artifact of the project layout and has nothing to do with what they're 
doing at the moment.

For example, on a simple Web project, the UI designers will always cd to 
the "html" directory. They get "src" and "lib" too, but if they had a 
choice they wouldn't. When they cherry-pick, it'll always be a 
cherry-pick of their own stuff (in the html directory) and likewise with 
a revert, so they have no reason to cd-up for any of those operations if 
the tool doesn't demand it. And perhaps less obvious: in a typical 
shared integration area setup, they will never have any conflicts 
anywhere but their subdirectory since the other directories will always 
be able to fast-forward merge. So cd-up isn't useful for them even in 
the case of merge conflicts.

-Steve
