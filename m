From: Nicolas Pitre <nico@cam.org>
Subject: Re: [PATCH] Make "git reset" a builtin. (incomplete)
Date: Wed, 22 Aug 2007 21:15:24 -0400 (EDT)
Message-ID: <alpine.LFD.0.999.0708222033040.16727@xanadu.home>
References: <46CC3090.7080500@gmail.com> <86absjenc3.fsf@lola.quinscape.zz>
 <46CC3C17.8040901@op5.se> <864pirej6w.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221154150.16727@xanadu.home>
 <Pine.LNX.4.64.0708221713540.20400@racer.site>
 <86mywjcwv7.fsf@lola.quinscape.zz>
 <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=us-ascii
Content-Transfer-Encoding: 7BIT
Cc: David Kastrup <dak@gnu.org>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Thu Aug 23 03:15:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IO1IL-00025Z-IN
	for gcvg-git@gmane.org; Thu, 23 Aug 2007 03:15:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751526AbXHWBP3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 22 Aug 2007 21:15:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750960AbXHWBP3
	(ORCPT <rfc822;git-outgoing>); Wed, 22 Aug 2007 21:15:29 -0400
Received: from relais.videotron.ca ([24.201.245.36]:39779 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751264AbXHWBP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2007 21:15:28 -0400
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005))
 with ESMTP id <0JN7005HFCTQ0P01@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Wed, 22 Aug 2007 21:15:27 -0400 (EDT)
In-reply-to: <alpine.LFD.0.999.0708221149440.30176@woody.linux-foundation.org>
X-X-Sender: nico@xanadu.home
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56443>


[ I'm branching off from here and not from later posts on purpose ... ]

On Wed, 22 Aug 2007, Linus Torvalds wrote:

> "git reset" is a command, not a scripting language. We can still script 
> git as much as we want, but the fewer dependencies we have on anything 
> external, the better off we are.
> 
> I don't understand why people consider scripting languages (whether shell, 
> perl, or anything else) "better" than C if there is an alternative. Once 
> the C work has been done (and if you require C _anyway_ for other reasons, 
> like git does), doing it in C is simply superior.

Absolutely no argument with that.  Considering that "git reset" is a 
command, the language used to implement it is just that: an 
_implementation_ "detail".  Especially if the C conversion has already 
been done.

> We ended up writing our own versions (or merging other peoples code) for 
> things like appying patches, generating diffs, three-way merging etc, 
> because not having external dependencies is *so* much more maintainable 
> and portable that it's not even funny.

Indeed. And this is the very same reason why Git should _also_ acquire a 
script interpreter of its own if we want to continue bragging about 
Git's easy scriptability.

> I'd love for every single shell-script in git core to be written in C, so 
> that we can drop the dependency on shell *entirely*.

What about the test suite?

> I also dispute your "easy to do". Quite often, shell (or any scripting 
> language) is actually much *more* complicated than C. Yes, the C code may 
> be more lines (in this case, the shell script is 106 lines, and the C code 
> was 216 lines), but from a maintenance standpoint, C has had *much* fewer 
> problems than the shell script stuff has ever had!

Let's not talk strictly about this very case.  Like we agreed above, the 
C conversion has been done so there is no downside really not to move on 
with the C version.  Same for other core commands if/when they get 
converted.

That would still be nice, though, if we could have a unified scripting 
language for Git, that didn't have any nasty external dependency either.  
If only so Git could be self sufficient on any platform it is ported to 
for its test suite, and also for extra functionality that users would 
end up sharing across the whole user base and not only on platform where 
bash comes installed by default.

And there might be some cases where using that same scripting language 
for permanently implementing actual command could simply make sense once 
it can be safely depended upon.

> So scripting languages are often good for *prototyping*, and a lot of 
> people like scripting languages for that reason. But once something is 
> already prototyped, and if somebody then rewrites it in C, all the 
> advantages of a scripting language have already disappeared!
> 
> So yes, we could just make the shell/etc from busybox _be_ the scripting 
> language, but the fact is, that is *more* C code than just making the 
> commands C code in the first place, and while a lot of the effort is 
> already done for us, "busybox under windows" is actually likely to be more 
> of a maintenance problem than "native git commands under windows" are.

Possibly.  Again that depends how much we need from it.  We don't need 
_that_ much from a shell and the bad portability issues can certainly be 
avoided altogether simply by ripping out problematic functionality.  
Such shell doesn't even have to be POSIX compliant or whatever.

> So if we have the choice, and somebody has written a git command in native 
> C code, I think we should *always* take it. Just because it means that 
> _eventually_ we can drop shell entirely, even if it would be a git 
> internal busybox shell.

It could be taken the other way around too: If we have the choice, and 
somebody has ported a subset of busybox to Windows tailored for Git 
plumbing usage, then we _could_ stop worrying so much about shell 
portability right there and redirect our efforts toward other things.


Nicolas
