From: Steven Grimm <koreth@midwinter.com>
Subject: Re: git annotate runs out of memory
Date: Tue, 11 Dec 2007 11:29:59 -0800
Message-ID: <74ED838F-4966-42A9-BC8A-906FD0B4B46F@midwinter.com>
References: <4aca3dc20712110933i636342fbifb15171d3e3cafb3@mail.gmail.com> <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: Daniel Berlin <dberlin@dberlin.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Tue Dec 11 20:30:32 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2AoE-0006AM-Jw
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 20:30:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752289AbXLKTaF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Dec 2007 14:30:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751466AbXLKTaF
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 14:30:05 -0500
Received: from tater.midwinter.com ([216.32.86.90]:57670 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752289AbXLKTaB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Dec 2007 14:30:01 -0500
Received: (qmail 5319 invoked from network); 11 Dec 2007 19:30:01 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=qvyaKFQNE4jXgX149sBRv5I6Rh9gOL/aLGrCWfJZKuVNPTmMG8GHDWzuAJp2pkVL  ;
Received: from localhost (127.0.0.1)
  by localhost with SMTP; 11 Dec 2007 19:30:00 -0000
In-Reply-To: <alpine.LFD.0.9999.0712111018540.25032@woody.linux-foundation.org>
X-Mailer: Apple Mail (2.915)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67917>

On Dec 11, 2007, at 10:40 AM, Linus Torvalds wrote:
> To git, "git annotate" is just about the *last* thing you ever want  
> to do.
> It's not a common operation, it's a "last resort" operation. In git,  
> the
> whole workflow is designed for "git log -p <pathnamepattern>" rather  
> than
> annotate/blame.

My use of "git blame" is perhaps not typical, but I use it fairly  
often when I'm looking at a part of my company's code base that I'm  
not terribly familiar with. I've found it's the fastest way to figure  
out who to go ask about a particular block of code that I think is  
responsible for a bug, or more commonly, who to ask to review a change  
I'm making.

"git log" is too coarse-grained to be useful for that purpose; it  
usually doesn't tell me which of the 500 revisions to the file I'm  
looking at introduced the actual line of code I want to change.

To me that really has nothing whatsoever to do with git workflow or  
svn workflow; it happens well before I'm ready to do any kind of  
integration or commit or even, sometimes, before I've made any changes  
to any code at all.

Given infinite spare time, one of the things I'd be strongly tempted  
to try to build would be some kind of blame cache. You could  
theoretically make blame pretty much instantaneous by doing something  
as simple as caching the per-line revision ID for each file in each  
revision in a shadow repository (or a shadow branch in the main repo)  
and keeping a map between shadow-repo revisions and real-repo ones. If  
the cache was of the form "one SHA1 hash per line in the original  
file" it would delta-compress pretty well. It'd be easy to update  
incrementally since you only need to walk back in history until you  
get to the most recently cached revision for each file, at which point  
you use the cached value for all the lines that haven't changed.

Yeah, I know, code talks louder than words...

-Steve
