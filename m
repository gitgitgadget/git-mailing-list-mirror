From: David Kastrup <dak@gnu.org>
Subject: Re: Empty directories...
Date: Wed, 18 Jul 2007 19:34:25 +0200
Message-ID: <85vechy5su.fsf@lola.goethe.zz>
References: <85lkdezi08.fsf@lola.goethe.zz>
	<Pine.LNX.4.64.0707180135200.14781@racer.site>
	<858x9ez1li.fsf@lola.goethe.zz>
	<alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Jul 18 19:35:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IBDQS-000644-JL
	for gcvg-git@gmane.org; Wed, 18 Jul 2007 19:35:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933014AbXGRReb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 18 Jul 2007 13:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1763626AbXGRReb
	(ORCPT <rfc822;git-outgoing>); Wed, 18 Jul 2007 13:34:31 -0400
Received: from mail-in-10.arcor-online.net ([151.189.21.50]:36561 "EHLO
	mail-in-10.arcor-online.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1762780AbXGRRea (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 18 Jul 2007 13:34:30 -0400
Received: from mail-in-01-z2.arcor-online.net (mail-in-01-z2.arcor-online.net [151.189.8.13])
	by mail-in-10.arcor-online.net (Postfix) with ESMTP id 482C71F5BF0;
	Wed, 18 Jul 2007 19:34:28 +0200 (CEST)
Received: from mail-in-08.arcor-online.net (mail-in-08.arcor-online.net [151.189.21.48])
	by mail-in-01-z2.arcor-online.net (Postfix) with ESMTP id CBF5713ECFD;
	Wed, 18 Jul 2007 19:34:27 +0200 (CEST)
Received: from lola.goethe.zz (dslb-084-061-086-214.pools.arcor-ip.net [84.61.86.214])
	by mail-in-08.arcor-online.net (Postfix) with ESMTP id 8B0C32C29E5;
	Wed, 18 Jul 2007 19:34:27 +0200 (CEST)
Received: by lola.goethe.zz (Postfix, from userid 1002)
	id 0C0FC1C3ACCE; Wed, 18 Jul 2007 19:34:25 +0200 (CEST)
In-Reply-To: <alpine.LFD.0.999.0707180912430.27353@woody.linux-foundation.org> (Linus Torvalds's message of "Wed\, 18 Jul 2007 09\:23\:46 -0700 \(PDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1.50 (gnu/linux)
X-Virus-Scanned: ClamAV 0.91.1/3696/Wed Jul 18 14:56:36 2007 on mail-in-08.arcor-online.net
X-Virus-Status: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/52883>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Wed, 18 Jul 2007, David Kastrup wrote:
>
>> b) The problem is not just that empty directories don't get added
>> into the repository.  They also don't get removed again when
>> switching to a different checkout.
>
> Bzzt. Wrong.
>
> We *do* remove directories when all files under them go away.

But empty directories which were empty to start with don't go away
since they are not tracked.  And that means that their parents don't
go away.

Git will remove directories which _had_ git-tracked content prior to
the checkout.  But it will not register empty directories created
outside of git, and consequently will not remove them.

> HOWEVER (and this is where one of the reasons for not tracking them
> comes in):
>
>    ** YOU CANNOT REMOVE A DIRECTORY IF IT HAS SOME UNTRACKED CONTENTS **
>
> Think about that for five seconds, then think about it some
> more. Ponder it.

Linus, condescension is all very nice, but I already told you: I had a
directory hierarchy created outside of git's control (every file comes
into being first outside of git).  This hierarchy contained empty
directories.  The while hierarchy was committed into git.  git
silently skipped registering empty directories.  Then a different
version got checked out which did not contain the directory hierarchy
in question.  And git left the (unregistered) empty directories in, as
well as all their parent directories.

And that is just plain wrong.

> So the fact is, git *already* does ass good of a job as it could
> possibly do wrt directories that go away: it tries to remove them if
> all the files that are tracked in it have gone away.

But I told git to track the whole directory tree recursively.  There
were no uncommitted files it complained about.  It is not reasonable
that it is afterwards unable to remove this when I checkout some other
tag.

> A SCM *must*not* just remove that directory. It would be
> horrible. The fact that it has untracked files in it does not make
> those untracked files "unimportant".

Sure.  But that it refuses to track the files makes the total behavior
an annoyance.  I don't complain _how_ git handles not being able to
track empty directories.  I complain about it not being able to track
them in the first place.  The consequences are hideous.

> Maybe you feel that way about object files, but what about tracking
> some important parts of your home directory - does the fact that you
> don't necessarily track *all* of it mean that the rest is totally
> unimportant adn that git should just remove it? HELL NO!

When I tell it to track it, it should not refuse.  Even if it is
empty.  Because if it _stayed_ empty, git can then remove it (and
possibly the parents) when I checkout something else.

-- 
David Kastrup, Kriemhildstr. 15, 44793 Bochum
