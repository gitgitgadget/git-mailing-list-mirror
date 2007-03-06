From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Add git-mergetool to run an appropriate merge conflict resolution program
Date: Tue, 06 Mar 2007 15:02:55 -0800
Message-ID: <7vk5xunffk.fsf@assigned-by-dhcp.cox.net>
References: <E1HORtY-0000zK-8B@candygram.thunk.org>
	<7vr6s3sz8r.fsf@assigned-by-dhcp.cox.net>
	<20070306124002.GA18370@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Theodore Tso <tytso@mit.edu>
X-From: git-owner@vger.kernel.org Wed Mar 07 00:04:11 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HOihQ-0003hf-3I
	for gcvg-git@gmane.org; Wed, 07 Mar 2007 00:04:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030634AbXCFXDB (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 6 Mar 2007 18:03:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030654AbXCFXDB
	(ORCPT <rfc822;git-outgoing>); Tue, 6 Mar 2007 18:03:01 -0500
Received: from fed1rmmtao106.cox.net ([68.230.241.40]:56250 "EHLO
	fed1rmmtao106.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030634AbXCFXC4 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2007 18:02:56 -0500
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao106.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070306230255.UQQM2807.fed1rmmtao106.cox.net@fed1rmimpo02.cox.net>;
          Tue, 6 Mar 2007 18:02:55 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id Xb2v1W00Y1kojtg0000000; Tue, 06 Mar 2007 18:02:56 -0500
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/41608>

Theodore Tso <tytso@mit.edu> writes:

>> > +# This file is licensed under the GPL v2, or a later version
>> > +# at the discretion of Linus Torvalds.
>> 
>> Heh ;-).
>
> Hey, that's what the COPYING file requested, and it was late when I
> started doing the git package integration, hence the stupid think-o
> with the man page.  :-)
>
> I assume you would prefer that it read Junio instead?

Oh, no, sorry.  The text itself is just fine as is, if that is
the way you want.

I just laughed out because I remembered the list discussion
(which might also have cc'ed the kernel list, but I do not
remember) about possible relicensing schenario, where Linus
mentioned that exact clause in the COPYING file, saying that his
discretion would by now be to let me decide ;-).

>> You should be able to set IFS to exclude SP and then you only
>> have to say you do not support LF and HT, both of which are much
>> less likely than SP to be in the pathname.
>
> Do we have any coding guidelines about what characters we have to
> support in filenames?  I had assumed that we should support at least
> SP and HT, but life does get easier if we don't need to worry about HT.

The core scripts, at least the ones I personally use, are meant
to handle all characters, including SP, HT and LF, so if there
were any guidelines that would be it.  However, your particular
case to interface with external editor needs `eval` with sq
magic if it needs to be coded in portable bourne, which can be
done, but I suspect it is not worth doing, as we would not see
HT in pathnames in the practice.  UNIXy folks tend to avoid any
whitespaces in the filenames, and Windows folks cannot use HT in
pathnames as far as I understand.

> Yeah, that should probably read "merge conflict resolution programs",
> even though that's a lot more words.
>
>> > +if test $# -eq 0 ; then
>> > +	files=`git ls-files -u --abbrev=8 | colrm 1 24 | sort -u`
>> 
>> Careful.  I think --abbrev=8 just means use at least 8 but more
>> as needed to make them unique.  sed -e 's/^[^	]*	//'
>> (whitespace are HTs) would be safer and simpler, as you are not
>> dealing with a pathname that has LF in it anyway.
>
> OK, I can do that.  Alternatively I guess I could submit a patch which
> caused git-ls-files to only list the files that still needed merging.
> (i.e., git-ls-files -u --nostage".)  Do you have any preferences?

The latter would be more useful in general, and something I
should have done long time ago to help scripts.  Thanks.
