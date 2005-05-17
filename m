From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/4] Tweak diff output further to make it a bit less
 distracting.
Date: Tue, 17 May 2005 12:08:14 -0700
Message-ID: <7vu0l1fz6p.fsf@assigned-by-dhcp.cox.net>
References: <7vvf5kqj9l.fsf@assigned-by-dhcp.cox.net>
	<20050516220559.GC8609@pasky.ji.cz>
	<7vsm0mn5s1.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0505161556260.18337@ppc970.osdl.org>
	<20050517070158.GA10031@pasky.ji.cz>
	<Pine.LNX.4.58.0505170812060.18337@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@ucw.cz>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 17 21:12:00 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DY7QM-0005Z4-Da
	for gcvg-git@gmane.org; Tue, 17 May 2005 21:08:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261357AbVEQTIf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 17 May 2005 15:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261448AbVEQTIf
	(ORCPT <rfc822;git-outgoing>); Tue, 17 May 2005 15:08:35 -0400
Received: from fed1rmmtao10.cox.net ([68.230.241.29]:30865 "EHLO
	fed1rmmtao10.cox.net") by vger.kernel.org with ESMTP
	id S261357AbVEQTIS (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 17 May 2005 15:08:18 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao10.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050517190815.WWBQ20235.fed1rmmtao10.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 17 May 2005 15:08:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0505170812060.18337@ppc970.osdl.org> (Linus
 Torvalds's message of "Tue, 17 May 2005 08:20:26 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

LT> There's also a real technical reason for this: since the rename format
LT> would not be a valid patch for a traditional "patch" program, and if we
LT> ever want to actually teach "patch" to handle it, we really need to be
LT> explicit. There are tons of traditional patches around that say

LT> 	diff -Nur a/kernel/sched.c.old b/kernel/sched.c
LT> 	--- a/kernel/sched.c.old
LT> 	+++ b/kernel/sched.c
LT> 	...

LT> and clearly the above is _not_ a rename from "sched.c.old" to "sched.c",
LT> so if we want to teach "patch" about the magic git rules, we'd have to
LT> have something unambiguous that a GNU patch maintainer might be willing to
LT> trigger on. The combination of the "diff -git " and "rename" markers might
LT> be such a thing.

LT> So it's a combination of clarity, canonical names, and "patch" issues.

I've been thinking about doing some rename detection in
diff-helper for some time.  Here is what that would produce in
your proposed file format (BTW, wouldn't the earlier patch ready
for merge already?), if you move file frotz to file nitfol and
at the same time do some edits:

    diff -git a/frotz b/frotz
    rename old frotz
    rename new nitfol
    delete file mode 100644
    --- a/frotz
    +++ /dev/null
    @@ -1,2 +0,0 @@
    -xyzzy
    -rezrov
    diff -git a/nitfol b/nitfol
    rename old frotz
    rename new nitfol
    new file mode 100644
    --- /dev/null
    +++ b/nitfol
    @@ -0,0 +1,2 @@
    +xyzzy
    +rezrov
    diff -git a/nitfol b/nitfol
    rename old frotz
    rename new nitfol
    --- a/nitfol
    +++ b/nitfol
    @@ -1,2 +1,3 @@
     xyzzy
     rezrov
    +gnusto

The basic idea is to express the pure rename with traditional
two patches against /dev/null, plus optionally contents patch on
top after pure rename patches.

I am still debating myself where rename lines should be, though.
I cannot decide so I placed them in all three in the above
example.


