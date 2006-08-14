From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH/RFC] gitweb: Great subroutines renaming
Date: Sun, 13 Aug 2006 17:11:30 -0700
Message-ID: <7vejvki3bh.fsf@assigned-by-dhcp.cox.net>
References: <200608071626.52655.jnareb@gmail.com> <ebln1v$s6j$1@sea.gmane.org>
	<7v7j1dnzo5.fsf@assigned-by-dhcp.cox.net> <ebmrbm$umk$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 14 02:11:41 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GCQ3M-0004Ji-P0
	for gcvg-git@gmane.org; Mon, 14 Aug 2006 02:11:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751753AbWHNALd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 13 Aug 2006 20:11:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751754AbWHNALd
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Aug 2006 20:11:33 -0400
Received: from fed1rmmtao06.cox.net ([68.230.241.33]:1437 "EHLO
	fed1rmmtao06.cox.net") by vger.kernel.org with ESMTP
	id S1751753AbWHNALc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Aug 2006 20:11:32 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao06.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060814001131.KUQF6235.fed1rmmtao06.cox.net@assigned-by-dhcp.cox.net>;
          Sun, 13 Aug 2006 20:11:31 -0400
To: Jakub Narebski <jnareb@gmail.com>
In-Reply-To: <ebmrbm$umk$1@sea.gmane.org> (Jakub Narebski's message of "Sun,
	13 Aug 2006 11:29:00 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/25301>

Jakub Narebski <jnareb@gmail.com> writes:

> Junio C Hamano wrote:
>
>> I'll be pushing out 1.4.2 this weekend, and then moving all the
>> gitweb stuff pending in "next" to "master" after that.
>> 
>> Let's have the rename immediately on top of it first, then
>> continue cleaning up after that.
>
> So after 1.4.2 gitweb patches should be based on next, or on master?

Well, since "git diff master next -- gitweb/" reports empty, the
question should not matter at this moment ;-).

Here are my preferences, as a general guideline:

 * If it is a general clean-up (e.g. changing a function
   signature declared in cache.h to tighten constness), I would
   prefer two patches; one to apply on "master", and another one
   created by assuming:

    - your first patch for "master" is accepted;
    - resulting "master" (with your first patch applied) will be
      merged into "next";

   Then the other patch is to clean-up the remaining stuff
   introduced between "master" and "next" (e.g. the function
   whose signature you changed in the first patch may have more
   call sites in "next" you may need to fix them up).

   If you know the specific topic I internally have (you can
   tell them by looking at the merge commits on "next"),
   separating the remainder patch into one per topic would be
   even nicer, but that is probably too much work to ask from
   contributors.

   Most of the time I can do this split myself, though, so it is
   Ok to send a patch to fix things up only in "master", and
   have me find out that it breaks "next", at that time I may
   fix things up myself similarly or I may ask you to send in a
   separete patch in similar spirit to fix up things in "next".

 * If it is a new series, I would prefer things be based on
   "master", unless you use some feature (either internal or
   external) that only exists in "next" or in "pu".

 * If it is a follow-up on stuff still in "next", obviously
   basing the patch on "master" is not possible.

 * If you have independent fix even though we have stuff that
   touch the same general area in "next", it is very much
   preferable if it applies to "master".  A critical fix for
   "next" that does not apply to "master" is taking the fix
   hostage to whatever is in "next".

 * If you need to base on "next", telling me why (i.e. "this
   uses such and such function which are not in master") helps
   me identify which topic I internally have to base a topic to
   house your series in.

 * If you need to base on "pu", think twice.  You will be taken
   hostage by whatever you are basing on (this is the same if
   you base on something in "next", but "pu" is for stuff of
   even more dubious merits than "next").  On the other hand,
   your new series may turn out to be the killer application for
   the feature that was earlier felt not-so-useful and help it
   (and your series) merged to "next".
