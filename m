From: Junio C Hamano <junkio@cox.net>
Subject: Re: What's in git.git
Date: Thu, 09 Feb 2006 16:47:35 -0800
Message-ID: <7vpslw3uqg.fsf@assigned-by-dhcp.cox.net>
References: <7vslqtf2p1.fsf@assigned-by-dhcp.cox.net>
	<BAYC1-PASMTP1142DA49F5BC7B7B42B22FAE030@CEZ.ICE>
	<43EB05B5.20307@op5.se> <7vk6c4etzy.fsf@assigned-by-dhcp.cox.net>
	<43EB1984.3040602@op5.se> <7vr76cby2v.fsf@assigned-by-dhcp.cox.net>
	<43EB290A.6060407@op5.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 10 01:47:53 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1F7MRv-0004N6-Qu
	for gcvg-git@gmane.org; Fri, 10 Feb 2006 01:47:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750907AbWBJArj (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 9 Feb 2006 19:47:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750903AbWBJArj
	(ORCPT <rfc822;git-outgoing>); Thu, 9 Feb 2006 19:47:39 -0500
Received: from fed1rmmtao03.cox.net ([68.230.241.36]:28293 "EHLO
	fed1rmmtao03.cox.net") by vger.kernel.org with ESMTP
	id S1750905AbWBJAri (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Feb 2006 19:47:38 -0500
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao03.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20060210004617.RTOI20875.fed1rmmtao03.cox.net@assigned-by-dhcp.cox.net>;
          Thu, 9 Feb 2006 19:46:17 -0500
To: Andreas Ericsson <ae@op5.se>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/15850>

Andreas Ericsson <ae@op5.se> writes:

> But wouldn't rebase detect the commits as being the same, unless
> you've made changes to them? If it doesn't, can we teach it to discard
> parent info and re-hash the commits if they conflict? That should
> solve most such merge-conflicts, really.

Yes, rebase would help somewhat (I said that didn't I?).  But
the thing is, with the "pu" workflow of mine so far, I _did_
rewrite/replace commits on my topic branches, especially when
they are young and not in a good shape.

For example, the topic branch jc/nostat ("Assume unchanged" git)
has four commits since it forked from the mainline:

 + [jc/nostat] "Assume unchanged" git: --really-refresh fix.
 + [jc/nostat^] ls-files: debugging aid for CE_VALID changes.
 + [jc/nostat~2] "Assume unchanged" git: do not set CE_VALID with --refresh
 + [jc/nostat~3] "Assume unchanged" git

With the "pu" workflow, I would have merged the "do not set
CE_VALID" commit and "--really-refresh fix" commit into the
first "Assume unchanged" commit after I found out about these
two small mistakes.  So one day "pu" would have contained what
is there right now as "jc/nostat~3", but the next day it would
have a commit, perhaps with slightly modified log message from
what is there as "jc/nostat~3" to contain fixes jc/nostat~2 and
jc/nostat have right now (the ls-files one is a debugging aid so
I would have left it separate even with the rewriting-history
workflow).

That kind of rewriting history is not being honest, but the end
result is that people do not have to see intermediate states and
earlier mistakes when things are fully cooked and ready to be
merged into the mainline.  By promising not to rewind "next" and
topic branches that go to "next", I am closing the door for me
to do this kind of history rewrite freely.  I can still rewrite
things I have not pushed out yet, though.

BTW, it is always a judgement call if it is a good thing to
squash commits into one like this.  Being too honest hurts the
usability of the history.  Especially if you have a trivial "Oh,
what I checked in does not even compile" kind of mistakes left
in the development trail, that would inconvenience bisection.
Being too sanitized OTOH tends to drop a single big ball of wax
into the history, and makes correcting things harder if it is
found later that only parts of that change are desired and the
other parts are not.
