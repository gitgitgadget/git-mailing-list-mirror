From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 07/16] git-read-tree: take --submodules option
Date: Thu, 24 May 2007 13:32:32 -0700
Message-ID: <7vy7jeufmn.fsf@assigned-by-dhcp.cox.net>
References: <7vd50x1n0r.fsf@assigned-by-dhcp.cox.net>
	<20070519130542.GR942MdfPADPa@greensroom.kotnet.org>
	<7v4pm8y8tf.fsf@assigned-by-dhcp.cox.net>
	<20070520155407.GC27087@efreet.light.src>
	<7vbqgfmjki.fsf@assigned-by-dhcp.cox.net>
	<20070521165938.GA4118@efreet.light.src>
	<20070521211133.GD5412@admingilde.org>
	<7viraixeme.fsf@assigned-by-dhcp.cox.net>
	<20070524184549.GW942MdfPADPa@greensroom.kotnet.org>
	<7vy7jevyjx.fsf@assigned-by-dhcp.cox.net>
	<20070524191438.GZ942MdfPADPa@greensroom.kotnet.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Martin Waitz <tali@admingilde.org>, Jan Hudec <bulb@ucw.cz>,
	Alex Riesen <raa.lkml@gmail.com>, git@vger.kernel.org
To: Sven Verdoolaege <skimo@kotnet.org>
X-From: git-owner@vger.kernel.org Thu May 24 22:32:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HrJzJ-0001mP-SM
	for gcvg-git@gmane.org; Thu, 24 May 2007 22:32:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750824AbXEXUce (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 24 May 2007 16:32:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750841AbXEXUce
	(ORCPT <rfc822;git-outgoing>); Thu, 24 May 2007 16:32:34 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:52882 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750824AbXEXUcd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 May 2007 16:32:33 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070524203233.IYZI2758.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Thu, 24 May 2007 16:32:33 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id 38YY1X00D1kojtg0000000; Thu, 24 May 2007 16:32:32 -0400
In-Reply-To: <20070524191438.GZ942MdfPADPa@greensroom.kotnet.org> (Sven
	Verdoolaege's message of "Thu, 24 May 2007 21:14:38 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48303>

Sven Verdoolaege <skimo@kotnet.org> writes:

[side note: I am ignoring your reply-to: liacs.nl as its MTA
seems to use sorbs that has my ISP's outgoing sender identified
as spam source; I'll send the bounce to you privately in a
separate message.]

> On Thu, May 24, 2007 at 11:58:26AM -0700, Junio C Hamano wrote:
>> Sven Verdoolaege <skimo@kotnet.org> writes:
>> > On Thu, May 24, 2007 at 11:26:01AM -0700, Junio C Hamano wrote:
>> >>  (2) In superproject .git/, we would have a bare repository for
>> >>      each project used by the superproject.
>> >> 
>> >> 	.git/subproject/kernel26/{objects,refs,...}
>> >> 
>> >>      This is created by making a bare clone from the upstream
>> >>      URL, decided by the user with the help from suggested URL
>> >>      described in the superproject .gitmodules.
>> >
>> > Do you mean a "pure" clone, i.e., without a working tree,
>> > but with separate-remotes?
>> 
>> I meant a bare clone without separate remotes.
>
> Why without separate remotes?
> It has been argued before that changes in the subproject
> may come from different remotes, so the user may want
> to configure extra remotes from which to fetch.

By different remotes, which do you mean?

 (1) .git/subprojects/kernel26/ repository has 'origin'
     different from any of the suggested URL in .gitmodules, but
     as far as it is concerned there is one 'origin';

or

 (2) it has 'origin' that is what the superproject suggests, but
     the user locally uses additional repositories to pull and
     merge from;

If the former that is not an argument, so I'd assume the
latter.  I would say in such a case, you are better off having a
usual repository to manage the development of subproject part,
not grafted to any superproject repository, and handle such
merges there (after all, a "subproject" should stand on its own
without having any of the superproject stuff).  And treat THAT
repository as the 'origin' used in (1) above.  It might be
easier to use non separate-remote layout in the standalone
repository for the subproject, but that is a separate issue.

>> The counter-proposal outline essentially says, for the sake of
>> simplicity, "nuke existing subproject directory whenever we need
>> to replace it with something else, and reclone a new/replacement
>> subproject directory every time we need to check it out, after
>> making sure nothing is lost".
>
> And she can't do it in the clone in his working tree if that's
> going to get nuked from time to time.

And she does not have to.  She can do the development/fixes in
(temporarily) checked out subproject tree, and push it back to
the .git/subproject/kernel26/ repository in the superproject
before she leaves (i.e. before branch switching at superproject
level needs to obliterate it).  The change stored in the
.git/subproject/kernel26/ repository in the superproject can
further be pushed back to its 'origin', be it the true
"upstream", or "the standalone repository for the subproject" I
mentioned above.

> But you still need figure out _what_ to fetch.
> Before you suggested to just use the default set up by
> clone with separate remotes, but you no longer have that
> in your new proposal.

I do remember saying the "default set up by clone" but I did not
mean separate remotes.

What is fetched by a bare and non-separate-remote repository vs
a repository that uses separate-remote layout from 'origin' is
exactly the same -- the difference is only 'pure/bare' layout
would use

	fetch = refs/heads/*:refs/heads/*

while separate-remotes would use

	fetch = refs/heads/*:/refs/remotes/origin/*

So I do not think the difference matters for our purpose of
being able to check out commits that are referenced in
superproject trees.  As long as we require that the 'origin' for
"longer term repository to keep track of the subproject in
superproject" (aka repository (2) in my message you are
responding to) always contain the commit referenced by tree
objects in the superproject, which I think is a sensible thing
to require (otherwise you cannot even clone and checkout the
whole superproject), both layout would work equally well.  It's
just bare/pure layout is easier to understand because it is
essentially a "mirror" of the upstream.
