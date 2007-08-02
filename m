From: David Kastrup <dak@gnu.org>
Subject: Re: Shell script cleanups/style changes?
Date: Fri, 03 Aug 2007 00:14:13 +0200
Message-ID: <85vebxy47e.fsf@lola.goethe.zz>
References: <86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<7vsl71tyyq.fsf@assigned-by-dhcp.cox.net>
	<86bqdqkygp.fsf@lola.quinscape.zz>
	<7vlkctvfk9.fsf@assigned-by-dhcp.cox.net>
	<85odhpzmbo.fsf@lola.goethe.zz>
	<20070802214103.GT29424@schiele.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Robert Schiele <rschiele@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 03 00:14:30 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IGiw9-0004D8-Dt
	for gcvg-git@gmane.org; Fri, 03 Aug 2007 00:14:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754401AbXHBWOV (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 2 Aug 2007 18:14:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753124AbXHBWOV
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Aug 2007 18:14:21 -0400
Received: from mail-in-08.arcor-online.net ([151.189.21.48]:35341 "EHLO
	mail-in-08.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754401AbXHBWOU (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 2 Aug 2007 18:14:20 -0400
Received: from mail-in-14-z2.arcor-online.net (mail-in-14-z2.arcor-online.net [151.189.8.31])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 4CBE627B2B7;
	Fri,  3 Aug 2007 00:14:19 +0200 (CEST)
Received: from mail-in-11.arcor-online.net (mail-in-11.arcor-online.net [151.189.21.51])
	by mail-in-14-z2.arcor-online.net (Postfix) with ESMTP id 3B2C6100C2;
	Fri,  3 Aug 2007 00:14:19 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-049-245.pools.arcor-ip.net [84.61.49.245])
	by mail-in-11.arcor-online.net (Postfix) with ESMTP id C44D81291A;
	Fri,  3 Aug 2007 00:14:18 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 4FAAA1D0344E; Fri,  3 Aug 2007 00:14:13 +0200 (CEST)
In-Reply-To: <20070802214103.GT29424@schiele.dyndns.org> (Robert Schiele's message of "Thu\, 2 Aug 2007 23\:41\:03 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3848/Thu Aug  2 22:22:06 2007 on mail-in-11.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54627>

Robert Schiele <rschiele@gmail.com> writes:

> No, you should read the mails you are refering to.  I said that the
> most important stuff does work.  Apparently this did not yet hurt me
> on the platform.

A non-working rebase would seem rather tough.

> Thus we have to decide whether we want some textbook example code
> and thus break this platform completely or whether we want to fix
> the issues you have listed and thus have a more portable
> application.

The "issues" are with Solaris, apparently.  There is always a price
for portability.  If Solaris users can fix their problems with a
global search and replace of the first line in *.sh, the question is
whether it is worth the hassle of having unreadable but "portable"
code.  After all, it has to be read also by humans.

>> Sure.  What about the git-rebase line using $(($end - $msgnum)) ?
>
> Bad on Solaris:
>
> $ uname -a
> SunOS solaris10-x64 5.10 Generic i86pc i386 i86pc
> $ end=1
> $ msgnum=5
> $ echo $(($end - $msgnum))
> syntax error: `(' unexpected
> $

You are missing the line
$ echo $0
which is probably the most interesting one...  we don't need to be
compatible with everything having a "$ " prompt, just with everything
called "/bin/sh".

>> Too bad: this should mean that $EDITOR can get called from C...  I've
>> been glad to see that so far this could be avoided.
>
> Why is it bad to call the editor from C?

See the rationale in my recently posted patch for implementing
EDITOR/VISUAL support.  One needs to shell-quote stuff properly, and
the shell is better at shell-quote magic than C is.

>> I do not think we have trouble with ${parameter#word}.  Much
>
> $ uname -a
> SunOS solaris10-x64 5.10 Generic i86pc i386 i86pc
> $ parameter=bla
> $ echo ${parameter#word}
> bad substitution
> $ 
>
>> less with ${parameter+word}; it has been in /bin/sh forever.
>
> That one is ok for Solaris.

If you prepare a patch replacing all existing ${parameter#word} uses
and get it accepted, I will not push for inclusion of my cleanup.

But you _really_ should go for it _now_.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
