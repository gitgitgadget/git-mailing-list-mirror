From: Junio C Hamano <junkio@cox.net>
Subject: Re: Recent unresolved issues
Date: Sat, 15 Apr 2006 01:57:10 -0700
Message-ID: <7vk69ri5cp.fsf@assigned-by-dhcp.cox.net>
References: <7v64lcqz9j.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141637230.3701@g5.osdl.org>
	<7vlku7n05x.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0604141748070.3701@g5.osdl.org>
	<Pine.LNX.4.64.0604141751270.3701@g5.osdl.org>
	<7vu08vjra5.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 15 10:58:02 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FUgbN-0004je-DR
	for gcvg-git@gmane.org; Sat, 15 Apr 2006 10:57:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591AbWDOI5R (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 15 Apr 2006 04:57:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751595AbWDOI5R
	(ORCPT <rfc822;git-outgoing>); Sat, 15 Apr 2006 04:57:17 -0400
Received: from fed1rmmtao12.cox.net ([68.230.241.27]:44258 "EHLO
	fed1rmmtao12.cox.net") by vger.kernel.org with ESMTP
	id S1751591AbWDOI5Q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Apr 2006 04:57:16 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao12.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060415085711.UKNJ26035.fed1rmmtao12.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 15 Apr 2006 04:57:11 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <7vu08vjra5.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Fri, 14 Apr 2006 23:18:10 -0700")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/18731>

Junio C Hamano <junkio@cox.net> writes:

> Although I've already decided to merge it up, there are small
> fallout from this.  I've fixed the ones I noticed, but there
> probably remain some backward compatibility issues in commands
> that I do not usually use.  We'll see.

I am very to sorry to say this, but...


				Pain


"git log" wants default abbrev (to show Merge: lines and
"whatchanged -r" output compactly) while "git diff-tree -r" by
default wants to show full SHA1 unless asked, which means
"memset(revs, 0, sizeof(*revs))" in revision.c::init_revisions()
needs to be defeated by the caller.

"git rev-list" wants to know if any --pretty was specified to
set verbose_header, but there is no way to tell if the user did
not say anything or said --pretty because revs->commit_format
will be CMIT_FMT_DEFAULT either way.  This is the worst breakage
I found so far -- "git rev-list --pretty" no longer works,
although "git rev-list --header" works so you probably did not
notice the breakage with gitk.

Honestly, the longer I look at it, the more I feel that this way
might break more things than it fixes.  I haven't even looked at
blame.c or http-push.c to see what's broken yet.
