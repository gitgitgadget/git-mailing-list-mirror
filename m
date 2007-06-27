From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] git-rev-list: give better diagnostic for failed write
Date: Wed, 27 Jun 2007 10:59:07 +0200
Message-ID: <87tzstpyck.fsf@rho.meyering.net>
References: <87r6nzu666.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0706251349540.8675@woody.linux-foundation.org>
	<878xa7u2gh.fsf@rho.meyering.net>
	<alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jun 27 10:59:17 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I3TMn-0003pY-Nv
	for gcvg-git@gmane.org; Wed, 27 Jun 2007 10:59:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752571AbXF0I7L (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 27 Jun 2007 04:59:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752521AbXF0I7K
	(ORCPT <rfc822;git-outgoing>); Wed, 27 Jun 2007 04:59:10 -0400
Received: from smtp3-g19.free.fr ([212.27.42.29]:59727 "EHLO smtp3-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752157AbXF0I7J (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jun 2007 04:59:09 -0400
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp3-g19.free.fr (Postfix) with ESMTP id 1663973C5
	for <git@vger.kernel.org>; Wed, 27 Jun 2007 10:59:08 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 036788D56; Wed, 27 Jun 2007 10:59:08 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.98.0706251505570.8675@woody.linux-foundation.org> (Linus Torvalds's message of "Mon\, 25 Jun 2007 15\:20\:16 -0700 \(PDT\)")
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51026>

Linus Torvalds <torvalds@linux-foundation.org> wrote:
> On Mon, 25 Jun 2007, Jim Meyering wrote:
>> Remember: I'm trying to improve existing code here.
>> You should save some of your ire for the person who wrote that code.
>
> Ehh. Remind me who I should be pissed at when the old code was _better_
> before your change?

If someone pointed out a bug in coreutils whereby a tool failed
to give an accurate diagnostic, I would thank them (and honestly,
I'd be grateful), even if their attempt at fixing it introduced
a horrible bug.  Of course, if the original bug were mine, I might
be annoyed with myself, but certainly would not shoot the messenger.

> With the current git.c, we report write errors quite well.

Yes, I'm glad (in spite of the tone of much of your feedback)
that my little improvements are making it into git.

> We don't give
> the exact output you want, but on a scale of 1-10, how important is that?
> Pretty damn low on the list.

If you get a report of a git write error, you might well
appreciate knowing right away whether it was due to EIO or to ENOSPC.

> And the reason I'm really really irritated at you is that you ignore me
> when I tell you what your bugs are.

Be careful when throwing stones...
I mentioned (without making a fuss) a regression you introduced,
  http://thread.gmane.org/gmane.comp.version-control.git/50742/focus=50917
and you included similar code in a snippet in the very message to which
I'm replying now.  I do see that you omitted the troublesome ferror call
from your eventual patch.

>  - I *told* you that EPIPE is special. What did you do? Ignore my advice,
>    and made a broken patch that did exactly the opposite of what I told
>    you.

I did not ignore your advice.  I considered it carefully and explained
why I hold the opposing view.  We've already beaten this to death, but
for the record, I'd summarize it like this:

You and I have a difference of opinion.  I firmly believe that it is
unnecessary and counterproductive (it is prohibited by POSIX for many
of the tools I maintain) to suppress an EPIPE diagnostic and to exit
successfully in spite of a write error.  Since EPIPE doesn't even arise
in most normal situations, the only reason to do that is if you want
to pander to the needs of some theoretical, broken-by-design (i.e.,
SIGPIPE-ignoring) git Porcelain program.  You want to add such code to
git, at every point where writing to stdout may fail.
