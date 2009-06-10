From: Junio C Hamano <gitster@pobox.com>
Subject: Re: EasyGit Integration
Date: Wed, 10 Jun 2009 13:47:33 -0700
Message-ID: <7vab4fn7dm.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	<alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	<4A2F0B8A.9010203@vilain.net>
	<7vws7khlvj.fsf@alter.siamese.dyndns.org>
	<alpine.LFD.2.00.0906092252210.31536@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Jun 10 22:47:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEUhz-0007qb-Pd
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 22:47:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757938AbZFJUrg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Jun 2009 16:47:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757632AbZFJUrg
	(ORCPT <rfc822;git-outgoing>); Wed, 10 Jun 2009 16:47:36 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:47863 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753923AbZFJUrf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Jun 2009 16:47:35 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610204737.DUQW20976.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Wed, 10 Jun 2009 16:47:37 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo02.cox.net with bizsmtp
	id 2LnZ1c0044aMwMQ04LndPq; Wed, 10 Jun 2009 16:47:37 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=6VC1-P1-AAAA:8 a=qpKeeOeUW-QeXIIMGCgA:9
 a=Jov6_1mc8i2CdYjqcvEA:7 a=WvvRg3y2S_pJLfr-KxKbXqviVZIA:4 a=LRnQQUT8V1QA:10
X-CM-Score: 0.00
In-Reply-To: <alpine.LFD.2.00.0906092252210.31536@xanadu.home> (Nicolas Pitre's message of "Tue\, 09 Jun 2009 23\:27\:23 -0400 \(EDT\)")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121300>

Nicolas Pitre <nico@cam.org> writes:

> On the other hand, having multiple porcelains simply divide the user 
> base which is not always a good thing.

The addition of new synonymous commands or options has the same issue of
dividing the user base between revert-commit/revert-file folks and
revert/checkout people.  In addition, it has the subcommand bloat issue I
already mentioned.  If anything, we should be aiming for _reducing_ them
from the current set of ~150; it is silly to dismiss it, saying "one extra
added to 150 is less than 1%".

As long as the "fork" is feature complete and the user does not have to
resort to git-core, even though it may share the same issue of user base
division, at least that would _help_ the users who choose the forked one,
who does not have to know the old-timer lingo and concepts.  It would be a
much better solution than adding stupid synonyms to the existing system.

But coming up with a consistent and complete fork that does not show
git-core (not just phrases but also underlying concepts) is a lot of work.
That is the primary reason why nobody did "gh".

>> But aliases for doing essentially the same thing in slightly different
>> syntax?  I'd rather not to see them called "git foo".  In the end, I think
>> it will harm the users, both new and old.
>
> Again this should be evaluated on a case by case basis.  I think this is 
> clear already that re-targeting commands like revert is _not_ a good 
> idea.  But some other examples are not so controversial.

I do not think there is any disagreement here; each proposal must be
judged separately, and no backward compatibility is allowed, unless there
is a compelling reason, a clear migration plan, and understanding of how
expensive such a backward incompatibility is by all the parties involved.

I do not see how "git branch -s" is an improvement, unless our motto is
"we will support any and all conceivable permutations of what is done to
what".  It says "while creating a branch, switch to it".  We say "while
switching to a new commit, start a branch by given name there".

I'd throw it into "if we did not have X in the beginning, instead of
adding X, we could have added Y and it would have worked equally well"
category.

But we already have X.

A rule of thumb I use for judging such a case is that Y must be at least
10 times better than X to replace it, and that has to happen with some
deprecation period.  Supporting Y in addition to X may probably have lower
hurdle, but still Y must be much better than X for that to happen.

If "git resolved" is "git add $(git ls-files -u --name-only)" or even more
than that (say, check if the files from the work tree indeed have lost
conflict markers), I think that is a wonderful improvement.  It does not
even fall into the "Y would have worked equally well but we have X"
category, as it is something different from the existing command, and does
it better (if it works as advertised without funny corner cases, that is).
