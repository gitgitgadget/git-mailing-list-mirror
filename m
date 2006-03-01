From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH 2/2] git-log (internal): more options.
Date: Wed, 01 Mar 2006 12:06:32 -0800
Message-ID: <7vwtfedj5j.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.64.0602281115110.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281126340.22647@g5.osdl.org>
	<Pine.LNX.4.64.0602281251390.22647@g5.osdl.org>
	<7vr75nm8cl.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0602281504280.22647@g5.osdl.org>
	<7vbqwqgxo8.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0603010730520.22647@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 01 21:06:55 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FEXan-0000vU-6S
	for gcvg-git@gmane.org; Wed, 01 Mar 2006 21:06:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751026AbWCAUGe (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 1 Mar 2006 15:06:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751024AbWCAUGe
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Mar 2006 15:06:34 -0500
Received: from fed1rmmtao07.cox.net ([68.230.241.32]:41643 "EHLO
	fed1rmmtao07.cox.net") by vger.kernel.org with ESMTP
	id S1751012AbWCAUGe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Mar 2006 15:06:34 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao07.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060301200519.BWER3131.fed1rmmtao07.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 1 Mar 2006 15:05:19 -0500
To: Linus Torvalds <torvalds@osdl.org>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/17009>

Linus Torvalds <torvalds@osdl.org> writes:

> Most helpers that want a list of commits probably want the printing 
> options too, and the ones that do not probably simply don't care (ie if 
> they silently pass a "--pretty=raw" without it affecting anything, who 
> really cares?)

Perhaps (meaning, agree in general but not 100% convinced and
haven't made up my mind yet).

> I can actually imagine using "--parents" as a way of parsing both the 
> commit log and the history. Of course, any such use is likely in a script, 
> at which point the script probably doesn't actually want "git log", but 
> just a raw "git-rev-list".

Yes, that is exactly why I did not see why "log viewer" wants --parents.

> To me, the question whether a flag would be parsed in the "revision.c" 
> library or in the "rev-list.c" binary was more a question of whether that 
> flag makes sense for other things than just "git log". 

Good to know we are in agreement (iow, I wasn't totally off the
mark) that revision.c should handle things that are common.
That means:

 * --bisect and --parents are for scripted use only and do not
   concern log viewer, so we would leave them in rev-list.

 * --header is good for anything that shows more than one
   record, so it may be worthwhile to have it in generic.

> For example, "git whatchanged" and "git diff" could both use 
> setup_revision(), although "git diff" wouldn't actually _walk_ the 
> revisions (it would just look at the "revs->commits" list to see what was 
> passed in).
>
> "git whatchanged" would obviously take all the same flags "git log" does, 
> and "git diff" could take them and just test the values for sanity (ie 
> error out if min/max_date is not -1, for example).

Perhaps.

> "git show" is like a "git-whatchanged" except it wouldn't walk the diffs 
> (I considered adding a "--nowalk" option to setup_revisions(), which would 
> just suppress the "add_parents_to_list()" entirely)

Umm.  The current "git show -4" walks and I find the behaviour
useful.  They are the same program with different defaults.
