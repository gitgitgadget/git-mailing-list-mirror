From: David Kastrup <dak@gnu.org>
Subject: Re: bisect / history preserving on rename + update
Date: Sat, 25 Aug 2007 09:35:48 +0200
Message-ID: <85r6lsdq23.fsf@lola.goethe.zz>
References: <1187080681.12828.174.camel@chaos>
	<alpine.LFD.0.999.0708140853500.30176@woody.linux-foundation.org>
	<7vmywgb45c.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Aug 25 09:36:21 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IOqBt-0008D2-TH
	for gcvg-git@gmane.org; Sat, 25 Aug 2007 09:36:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755491AbXHYHfv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 25 Aug 2007 03:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754994AbXHYHfv
	(ORCPT <rfc822;git-outgoing>); Sat, 25 Aug 2007 03:35:51 -0400
Received: from fencepost.gnu.org ([140.186.70.10]:45032 "EHLO
	fencepost.gnu.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752899AbXHYHfu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 25 Aug 2007 03:35:50 -0400
Received: from localhost ([127.0.0.1] helo=lola.goethe.zz)
	by fencepost.gnu.org with esmtp (Exim 4.60)
	(envelope-from <dak@gnu.org>)
	id 1IOqBO-00075e-ER; Sat, 25 Aug 2007 03:35:46 -0400
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 549F71C39500; Sat, 25 Aug 2007 09:35:48 +0200 (CEST)
In-Reply-To: <7vmywgb45c.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's message of "Fri\, 24 Aug 2007 21\:59\:43 -0700")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56626>

Junio C Hamano <gitster@pobox.com> writes:

> Linus Torvalds <torvalds@linux-foundation.org> writes:
>
>> [ However, there does seem to be a bug in the "-B" logic, so it doesn't 
>>   actually work as well as it should! See below ]
>
> I finally had a bit of time to follow this through.  After
> running your set-up using revision.c and Makefile to emulate the
> situation, you can try running:
>
> 	$ git diff-tree -B -C --numstat --summary HEAD
>
> or
>
> 	$ git diff-tree -B -M --numstat --summary HEAD
>
> which would say:
>
>         90028d007986de4db8c3af30a2d5e5c00e5a2c8b
>         0       0       revision.c => old-revision.c
>         1117    1579    revision.c
>          rename revision.c => old-revision.c (100%)
>          rewrite revision.c (98%)
>
> The code is working as intended (it is a different discussion if
> "as intended" is actually the desired behaviour).

>From reading the argument of Linus, I would say that this "stateless,
not applicable by patch" behavior is desirable in some application.
And the "sequential, applicable by patch" behavior also is desirable
in a number of applications.

So there should be an option to select those behaviors.  This has the
added advantage that the manual page will explain that option, and so
the user gets to actively pick what he wants, and gets to _think_
about this choice.

This would be strictly better than "at some point of time, we figured
that this particular way suited Linus' personal workflow best, so we
obliterated all traces of other applications from code, documentation,
discussion and thought".

> This behaviour actually was a bit counterintuitive to me.  I did
> not implement the very original rename/copy the way we currently
> operate.  It was corrected into the current behaviour, following
> the guiding principle described in this message:
>
> 	http://thread.gmane.org/gmane.comp.version-control.git/3807
>
> which is reproduced below.

I think this is a case where restricting git's operation to a single
way of doing it is limiting the range of its applications.  And having
_neither_ an option _nor_ an explanation but rather pretending that
this is the only valid way one could want this feature to work is not
going to help even those users who would, in the end, decide to choose
that behavior after all.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
