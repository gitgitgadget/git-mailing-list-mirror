From: Junio C Hamano <gitster@pobox.com>
Subject: Re: EasyGit Integration
Date: Tue, 09 Jun 2009 19:18:40 -0700
Message-ID: <7vws7khlvj.fsf@alter.siamese.dyndns.org>
References: <d411cc4a0906091159r51e7d16t4d66c6225322fb60@mail.gmail.com>
	<alpine.LFD.2.01.0906091512350.6847@localhost.localdomain>
	<4A2F0B8A.9010203@vilain.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Scott Chacon <schacon@gmail.com>,
	git list <git@vger.kernel.org>
To: Sam Vilain <sam@vilain.net>
X-From: git-owner@vger.kernel.org Wed Jun 10 04:39:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MEDin-0007BM-KU
	for gcvg-git-2@gmane.org; Wed, 10 Jun 2009 04:39:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752394AbZFJCjR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Jun 2009 22:39:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752040AbZFJCjQ
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Jun 2009 22:39:16 -0400
Received: from fed1rmmtai105.cox.net ([68.230.241.55]:52941 "EHLO
	fed1rmmtai105.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751804AbZFJCjP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Jun 2009 22:39:15 -0400
X-Greylist: delayed 803 seconds by postgrey-1.27 at vger.kernel.org; Tue, 09 Jun 2009 22:39:12 EDT
Received: from fed1rmimpo03.cox.net ([70.169.32.75])
          by fed1rmmtao103.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20090610021840.GIRP2915.fed1rmmtao103.cox.net@fed1rmimpo03.cox.net>;
          Tue, 9 Jun 2009 22:18:40 -0400
Received: from localhost ([68.225.240.211])
	by fed1rmimpo03.cox.net with bizsmtp
	id 22Jg1c00C4aMwMQ042JgXX; Tue, 09 Jun 2009 22:18:40 -0400
X-VR-Score: -100.00
X-Authority-Analysis: v=1.0 c=1 a=DX0WSri4AAAA:8 a=6jSZw4afHXKTm647voEA:9
 a=FlWM2jYmTCx0O2HMNS0A:7 a=G6cm-J3LxUqWUX-MpBI11hSJK6oA:4 a=CIOmP1rSAV8A:10
 a=IlQyjywJyzi4-Ete:21 a=MX9adqTPg1hU4dA9:21
X-CM-Score: 0.00
In-Reply-To: <4A2F0B8A.9010203@vilain.net> (Sam Vilain's message of "Wed\, 10 Jun 2009 13\:25\:30 +1200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121243>

Sam Vilain <sam@vilain.net> writes:

> We talked about this much at GitTogether '08. It's true that for
> 'reverting' a change in the past, that is the right thing to do. However
> I don't think there is a first principles case that this is always what
> people mean by 'revert'....

Sorry; what you think people mean by 'revert' does not matter at this
point, unless you are building a brand-new system from scratch.

> I think as long as there is a deprecation cycle, and that users can
> select the old behaviour (either via an alias or a config option), then
> we shouldn't upset many long-time users of revert. Do you agree?

I actually don't.

I do not think introducing "git revert-file" (or "git revert -- path") is
a problem at all.  But "git revert $commit" has been and is an integral
part of the established git workflow, and I do not see a point in changing
it to mean something else, with any deprecation period.

By the way, I have a bigger issue.

Some changes in "eg" may port well as a new command to git-core, and some
change (like this "revert" thing that has different semantics and breaks
established workflow) will never be in git-core.  People may think that it
would not cause many problems if we picked only the non-conflicting bits,
but I actually have some reservations about that.

It will bloat the total number of subcommands you can give git, with the
end result being

 (1) old timers won't use "revert-commit" and "revert-file" at all but use
     "revert" and "checkout -- path"; while

 (2) new people will behave the other way; and

 (3) the documentation will list all of commands from these two disjoint
    sets under "git".

When a "eg" minded person teaches git, the students may have to be told to
ignore "revert" and "checkout -- path", because there are other ways to do
the same thing in the lingo they are being taught, which is a subset of
git commands.  The manual pages will be littered with descriptions like
"this command, when used this way, is synonymous to using that other
command with this option", leaving the reader wondering why there are so
many ways to do the same thing.

If "eg" (I do not have _anything_ against it; the discussion applies to
other Porcelains as well) were kept independent _and_ offered complete set
of features that users need without resorting to git-core, on the other
hand, the students do not have to know about "revert", and the manuals
they need to consult will not have to talk about "if you are using
git-core, this is done differently in this way".  The learning curve will
get a lot smoother for new people.

If new and useful features (e.g. "creating a remote repository over SSH in
one shot") are supported by another Porcelain (e.g.  "eg") they may be
worth porting over to git-core, in order to make git-core more usable.
There is a precedent for that kind of side port (e.g. "filter-branch" that
came from Cogito).

But aliases for doing essentially the same thing in slightly different
syntax?  I'd rather not to see them called "git foo".  In the end, I think
it will harm the users, both new and old.

If you go back to the list archive, you will find me suggesting a new set
of commands with "gh" prefix, back in 1.3.X days, I think.

I was not joking.  The reasoning was exactly the same, and it remains so.
