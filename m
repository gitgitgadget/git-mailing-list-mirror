From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-pull and tag objects
Date: Tue, 13 Feb 2007 23:22:11 -0800
Message-ID: <7vfy99td98.fsf@assigned-by-dhcp.cox.net>
References: <1170933407.15431.38.camel@okra.transitives.com>
	<81b0412b0702090133qa4eb0c0v6a2d309fe9653a3f@mail.gmail.com>
	<7v4ppurka1.fsf@assigned-by-dhcp.cox.net>
	<20070210142322.GB25607@thunk.org>
	<Pine.LNX.4.64.0702100938540.8424@woody.linux-foundation.org>
	<7vy7n5gs0y.fsf@assigned-by-dhcp.cox.net>
	<20070212162745.GB2741@thunk.org>
	<7vr6su1szp.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0702132230490.3604@woody.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Theodore Tso <tytso@mit.edu>, Alex Riesen <raa.lkml@gmail.com>,
	Alex Bennee <kernel-hacker@bennee.com>, git@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Wed Feb 14 08:22:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHET2-0004lP-Me
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 08:22:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751231AbXBNHWN (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 02:22:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbXBNHWN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 02:22:13 -0500
Received: from fed1rmmtao107.cox.net ([68.230.241.39]:58420 "EHLO
	fed1rmmtao107.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751231AbXBNHWM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 02:22:12 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao107.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214072212.MXJL1306.fed1rmmtao107.cox.net@fed1rmimpo01.cox.net>;
          Wed, 14 Feb 2007 02:22:12 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PKNB1W00q1kojtg0000000; Wed, 14 Feb 2007 02:22:12 -0500
In-Reply-To: <Pine.LNX.4.64.0702132230490.3604@woody.linux-foundation.org>
	(Linus Torvalds's message of "Tue, 13 Feb 2007 22:38:37 -0800 (PST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39622>

Linus Torvalds <torvalds@linux-foundation.org> writes:

> On Mon, 12 Feb 2007, Junio C Hamano wrote:
>> 
>> "fsck --full" should report "dangling tag".
>
> Well, except if
>  - you've pruned
>  - the importer never imported anything but the most recent one.

True -- but Ted was talking about look for them in order to
eradicate them, so if you've pruned or never had one, you are
Ok.

> One thing that _might_ be a good idea for tags (if people _really_ want to 
> actually update tags under the same name) is to have a "parent" pointer 
> for tag objects, the same way we have for commits. That way you could - if 
> you really wanted to - create a chain of tags, and show the history of 
> them.
> ...
> I dunno. Personally I'd rather try to just tell people to not re-use 
> tag-names, because it kind of destroys the whole point of a tag ("I 
> checked out tag X!" just leadsto "_Which_ X?").

I agree.

> And you could certainly do the "passed testing" thing with commits in a 
> separate branch instead: you'd create the "testing" branch, which is 
> always a set of commits that have as their primary parent the commit that 
> got tested, and as the second parent the previous commit in the "testing" 
> series).

I personally feel that that kind of commit is misusing the
parent field (for one thing, it would not play well with merges
at all, although people who abuse commits to record non-ancestry
structure may not even be interested in merging such things so
it may not be a problem in practice).  If people want to express
relationship between commits (and other objects in general)
other than ancestry, I think it would be cleaner to allow a tag
to have more than one pointers to other objects.

I know you are against arbitrary pointers inside objects that
does not have semantic meaning, and I agree.  Probably your
"previous version of this tag was that one" is better than "more
than one arbitrary pointers" in that sense.

But I do not know how useful a linear history of tags are; it is
semantically the same as v1.5.0, v1.5.0.1, v1.5.0.2, ... sequence.
