From: Junio C Hamano <junkio@cox.net>
Subject: Re: Figured out how to get Mozilla into git
Date: Sat, 10 Jun 2006 02:08:03 -0700
Message-ID: <7vzmglgyz0.fsf@assigned-by-dhcp.cox.net>
References: <9e4733910606081917l11354e49q25f0c4aea40618ea@mail.gmail.com>
	<46a038f90606082006t5c6a5623q4b9cf7b036dad1e5@mail.gmail.com>
	<46a038f90606091814n1922bf25l94d913238b260296@mail.gmail.com>
	<Pine.LNX.4.64.0606091825080.5498@g5.osdl.org>
	<Pine.LNX.4.64.0606091837040.5498@g5.osdl.org>
	<9e4733910606091848r5fb4d565taabfc5198140daf2@mail.gmail.com>
	<Pine.LNX.4.64.0606091853180.5498@g5.osdl.org>
	<9e4733910606091921o1d07826w8292dc22b1872345@mail.gmail.com>
	<87y7w5lowc.wl%cworth@cworth.org>
	<Pine.LNX.4.64.0606092001590.5498@g5.osdl.org>
	<448A847C.20105@dawes.za.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 10 11:08:15 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FozRx-0008Sf-4v
	for gcvg-git@gmane.org; Sat, 10 Jun 2006 11:08:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbWFJJIG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 10 Jun 2006 05:08:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751443AbWFJJIF
	(ORCPT <rfc822;git-outgoing>); Sat, 10 Jun 2006 05:08:05 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:435 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1751426AbWFJJIE (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Jun 2006 05:08:04 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060610090804.EMZI5347.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 10 Jun 2006 05:08:04 -0400
To: Rogan Dawes <lists@dawes.za.net>
In-Reply-To: <448A847C.20105@dawes.za.net> (Rogan Dawes's message of "Sat, 10
	Jun 2006 10:36:12 +0200")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21604>

Rogan Dawes <lists@dawes.za.net> writes:

> Here's an idea. How about separating trees and commits from the actual
> blobs (e.g. in separate packs)?

If I remember my numbers correctly, trees for any project with a
size that matters contribute nonnegligible amount of the total
pack weight.  Perhaps 10-25%.

> In this way, the user has a history that will show all of the commit
> messages, and would be able to see _which_ files have changed over
> time e.g. gitk would still work - except for the actual file level
> diff, "git log" should also still work, etc

I suspect it would make a very unpleasant system to use.
Sometimes "git diff -p" would show diffs, and other times it
mysteriously complain saying that it lacks necessary blobs to do
its job.  You cannot even run fsck and tell from its output
which missing objects are OK (because you chose to create such a
sparse repository) and which are real corruption.

A shallow clone with explicit cauterization in grafts file at
least would not have that problem. Although the user will still
not see the exact same result as what would happen in a full
repository, at least we can say "your git log ends at that
commit because your copy of the history does not go back beyond
that" and the user would understand.
