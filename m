From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Don't ignore write failure from git-diff, git-log, etc.
Date: Sat, 26 May 2007 10:27:43 -0700
Message-ID: <7vk5uvjy0g.fsf@assigned-by-dhcp.cox.net>
References: <87bqg724gp.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jim Meyering <jim@meyering.net>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Sat May 26 20:39:16 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from [129.240.10.15] (helo=pat.uio.no)
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hs16k-000383-G5
	for gcvg-git@gmane.org; Sat, 26 May 2007 20:35:18 +0200
Received: from mail-mx9.uio.no ([129.240.10.39])
	by pat.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Hs09Y-0005fy-Ek
	for gcvg-git@gmane.org; Sat, 26 May 2007 19:34:08 +0200
Received: from vger.kernel.org ([209.132.176.167])
	by mail-mx9.uio.no with esmtp (Exim 4.66)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Hs09S-0005BD-9D
	for gcvg-git@gmane.org; Sat, 26 May 2007 19:34:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751434AbXEZR1p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 May 2007 13:27:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752783AbXEZR1p
	(ORCPT <rfc822;git-outgoing>); Sat, 26 May 2007 13:27:45 -0400
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:49145 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751434AbXEZR1p (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 May 2007 13:27:45 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070526172745.EXQO6556.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Sat, 26 May 2007 13:27:45 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id 3tTj1X00c1kojtg0000000; Sat, 26 May 2007 13:27:44 -0400
In-Reply-To: <alpine.LFD.0.98.0705260910220.26602@woody.linux-foundation.org>
	(Linus Torvalds's message of "Sat, 26 May 2007 09:18:20 -0700 (PDT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
X-UiO-Spam-info: not spam, SpamAssassin (score=-2.4, required=12.0, autolearn=disabled, AWL=0.614,UIO_VGER=-3)
X-UiO-Scanned: 5E1EDAE590981FC3D51376910A090BE17FC9BD50
X-UiO-SPAM-Test: remote_host: 209.132.176.167 spam_score: -23 maxlevel 200 minaction 2 bait 0 mail/h: 36 total 249568 max/h 813 blacklist 0 greylist 0 ratelimit 0
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48480>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> Also, PLEASE don't do this:
>
>> +		if (0 <= fcntl(fileno (stdout), F_GETFD)
>
> That's totally unreadable to any normal human.
>
> You don't say "if zero is smaller or equal to X". You say "if X is larger 
> than or equal to zero". Stop messing with peoples minds, dammit!
>
> Anybody who thinks that code like this causes fewer errors is just fooling 
> himself. It causes *more* bugs, because people have a harder time reading 
> it.
>
> Maybe you and Junio have taught yourself bad manners, but you're a tiny 
> tiny part of humanity or the development community. Junio can do it just 
> because while he's just a single person, he's a big part of the git coding 
> base, but anybody else who does it should just be shot.

Whew, that is a blast from the past.

cf. http://thread.gmane.org/gmane.comp.version-control.git/3903/focus=3906

 (1) Maybe Jim was just being nice, trying to make the code look
     like surrounding code;

 (2) Maybe Jim and the person I learned the style from worked
     together for a long time and they picked it up from the
     same source;

 (3) Maybe I am not alone, and it is not native language -
     mother tongue issue as some suspected in the quoted thread.

In any case, I think my recent code have much less "textual
order should reflect actual order" convention than before,
because I have been forcing myself to say aloud "if X is larger"
or "if X is smaller" before writing my comparisons, in order to
match the "peoples minds" expectation you mentioned above.

This initially slowed me down and made my head hurt quite a bit,
and sometimes it still does.

Once you learn to _visualize_ the ordering relationship in "X op
Y" by relying on "op" being always < or <=, you will get the
"number line" pop in your head whenever you see a comparision
expression, without even having to think about it, and you "see"
X and Y on the number line:

        ... -2        -1         0         1         2  ...  
    ---------+---------+---------+---------+---------+---------
    true:                        0   <=  fcntl(...)


        ... -2        -1         0         1         2  ...  
    ---------+---------+---------+---------+---------+---------
    false:    (0 <= fcntl(...))

What the comparison is doing comes naturally to you, without
even having to translate it back to human language "X is larger
(or smaller) than this constant".  The ordering is right there,
in front of your eyes, before you vocalize it.

In a sense, just like it is hard to go back from git to CVS (or
it is hard to go back to not knowing the power of the index), it
is very hard to go back once you learn to do this.
