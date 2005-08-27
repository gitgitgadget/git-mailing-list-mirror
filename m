From: Junio C Hamano <junkio@cox.net>
Subject: Re: Comments in read-tree about #nALT
Date: Sat, 27 Aug 2005 01:59:41 -0700
Message-ID: <7vy86nvjpe.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.63.0508270151590.23242@iabervon.org>
	<7vwtm726xq.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 27 11:00:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1E8wXe-00011E-JG
	for gcvg-git@gmane.org; Sat, 27 Aug 2005 10:59:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030351AbVH0I7n (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 27 Aug 2005 04:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbVH0I7n
	(ORCPT <rfc822;git-outgoing>); Sat, 27 Aug 2005 04:59:43 -0400
Received: from fed1rmmtao05.cox.net ([68.230.241.34]:52722 "EHLO
	fed1rmmtao05.cox.net") by vger.kernel.org with ESMTP
	id S1030351AbVH0I7n (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 27 Aug 2005 04:59:43 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao05.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050827085941.SCUK8651.fed1rmmtao05.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 27 Aug 2005 04:59:41 -0400
To: Daniel Barkalow <barkalow@iabervon.org>
In-Reply-To: <7vwtm726xq.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Sat, 27 Aug 2005 00:08:17 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/7847>

Junio C Hamano <junkio@cox.net> writes:

> Daniel Barkalow <barkalow@iabervon.org> writes:
>
>> Part of threeway_merge, however, wants to search the rest of the cache for
>> interfering entries in some cases, which would have to happen differently,
>> because I won't have the cache completely filled out beforehand. I'm
>> trying to figure out what the comments are talking about, and they seem to
>> refer to a list of the possible cases. Is that list somewhere convenient?
>
> Please look for END_OF_CASE_TABLE in t/t1000-read-tree-m-3way.sh;
> the table talks about some of the (ALT) not implemented, but
> some of them are ("git whatchanged t/t1000-read-tree-m-3way"
> would tell you which).
>
> Two way cases are described in Documentation/git-read-tree.txt,
> if you care.  If you were not touching the three-way case right
> now, I'd move/copy the three way cases there as well, but that
> can wait until after your changes.

The comments like /* 4 and 5 */ in twoway_merge refer to the
case table number in the Documentation/git-read-tree.txt

Just in case you are wondering what all this index constraints
are about.  It used to be that the order of stages given to
"read-tree -m O A B" did not have any inherent meaning, but it
is not anymore, especially after the "-u" flag was introduced
and the "new world order" was introduced to the merge operation.
Before that, we tried to do everything in the index file, and
even merge-one-file-script tried not to touch the files in the
working tree at all while it worked.  But that has changed, and
these days I believe the code assumes that A corresponds to the
commit the current working tree is based upon, and tries to make
sure that the index file does not have a local modification that
would be lost by the result of "read-tree -m -u O A B" (that is,
roughly speaking, read-tree chose B and the working tree was
modified since A).

If you need more information, probably the first thing to do
would be to run "git whatchanged" on read-tree, its tests and
documentations to find the rough timescale of those "new world
order" changes, and check the list archives.

As a software archaeologist, I've done some of that for you and
for myself.  I hope these would help you.

Gee, up until now I thought my only significant contribution was
around diff, but going through 5000+ messages made me realize I
was all over the place ;-).

------------------------------------------------


This message talked about Linus' desire not to touch working
tree at all.

    Date:	Sun, 1 May 2005 13:29:59 -0700 (PDT)
    From:	Linus Torvalds <torvalds@osdl.org>
    Subject: Re: [PATCH] Really fix git-merge-one-file-script this time.
    Message-ID: <Pine.LNX.4.58.0505011312080.2296@ppc970.osdl.org>

This was a question to Linus after the "new merge world order"
happened.

    Message-ID: <7v64wrvpt4.fsf@assigned-by-dhcp.cox.net>
    From: Junio C Hamano <junkio@cox.net>
    Subject: new read-tree questions.
    Date: Mon, 06 Jun 2005 01:43:03 -0700

And these three discusses the issues.  The first two are the
must-read responses from Linus.

    Message-ID: <Pine.LNX.4.58.0506060748390.1876@ppc970.osdl.org>
    From: Linus Torvalds <torvalds@osdl.org>
    Subject: Re: new read-tree questions.
    Date: Mon, 6 Jun 2005 08:04:22 -0700 (PDT)

    Message-ID: <Pine.LNX.4.58.0506060738170.1876@ppc970.osdl.org>
    From: Linus Torvalds <torvalds@osdl.org>
    Subject: Re: Last mile for 1.0
    Date: Mon, 6 Jun 2005 07:47:52 -0700 (PDT)

    Message-ID: <7voeajp875.fsf@assigned-by-dhcp.cox.net>
    From: Junio C Hamano <junkio@cox.net>
    Subject: Re: clarifying two tree merge semantics
    Date: Mon, 06 Jun 2005 12:59:58 -0700

The thread starting at this message is about emu23, which may
not affect directly what you are doing, but if you are
interesting the issues there are interesting.

    Message-ID: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
    From: Linus Torvalds <torvalds@osdl.org>
    Subject: Handling merge conflicts a bit more gracefully..
    Date: Wed, 8 Jun 2005 13:55:23 -0700 (PDT)

I've reproduced the whole message for this one, which is what
your question was about.

    Message-ID: <7voeagrp11.fsf_-_@assigned-by-dhcp.cox.net>
    From: Junio C Hamano <junkio@cox.net>
    Subject: [PATCH 0/3] Handling merge conflicts a bit more gracefully
    Date: Thu, 09 Jun 2005 00:02:34 -0700

This series consists of three patches.

  [PATCH 1/3] read-tree.c: rename local variables used in 3-way merge code.
  [PATCH 2/3] read-tree -m 3-way: loosen index requirements that is too strict.
  [PATCH 3/3] read-tree -m 3-way: handle more trivial merges internally

You may have noticed that I already described some "alternative
semantics" in the 3-way merge test script t1000.  This set of
patches implements some of them, namely the following 5 cases:

     O       A       B         result      index requirements
-------------------------------------------------------------------
  5  missing exists  A==B      take A      must match A, if exists.
 ------------------------------------------------------------------
  6  exists  missing missing   remove      must not exist.
 ------------------------------------------------------------------
  8  exists  missing O==B      remove      must not exist.
 ------------------------------------------------------------------
 10  exists  O==A    missing   remove      must match A and be
                                           up-to-date, if exists.
 ------------------------------------------------------------------
 14  exists  O==A    O!=B      take B      if exists, must either (1)
                                           match A and be up-to-date,
                                           or (2) match B.
-------------------------------------------------------------------

The first patch is to match the local variable names used in the
functions involved to the names used in the case matrix.

Case #14 is resolved identically as the old code does, but the
index requirement old code placed on this case was stricter than
necessary.  In this case, satisfying the usual rule of "match A
and be up-to-date if exists" is certainly OK, but additionally,
if the original index matches the tree being merged (without
even being up-to-date) is also permissible, because there would
be no information loss or work-tree clobbering if we allowed it.
The second patch in the series corrects this.

Case #5, #6, #8, and #10 were traditionally kept unmerged in the
index file when read-tree is done, and resolving them was left
to the script.  By resolving these internally, we can loosen the
index requirements without compromising correctness for case #5.
Other three cases could still be left for the "script policy"
because this change does not affect the index requirements for
these cases, but it was simple enough to implement them and this
would not be too controversial a change.  The third patch in the
series implements these changes.
