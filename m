From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Redirect cd output to /dev/null, was: git-clone seems dead
Date: Mon, 12 Sep 2005 05:29:08 -0700
Message-ID: <7vbr2yfp0r.fsf@assigned-by-dhcp.cox.net>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk>
	<7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net>
	<20050911220421.GA14593@athame.dynamicro.on.ca>
	<20050911230136.GA15224@athame.dynamicro.on.ca>
	<7vwtlnm4zx.fsf@assigned-by-dhcp.cox.net>
	<20050912105637.GA5290@athame.dynamicro.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 14:31:35 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEnRS-0001NE-T2
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 14:29:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750784AbVILM3O (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 08:29:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750785AbVILM3N
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 08:29:13 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:35536 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1750784AbVILM3N (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 08:29:13 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912122909.XYQV24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 08:29:09 -0400
To: Greg Louis <glouis@dynamicro.on.ca>
In-Reply-To: <20050912105637.GA5290@athame.dynamicro.on.ca> (Greg Louis's
	message of "Mon, 12 Sep 2005 06:56:37 -0400")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8379>

Greg Louis <glouis@dynamicro.on.ca> writes:

> I could argue that it's a relatively harmless contribution to
> robustness of the git scripts, but if someone replied that total
> idiot-proofing isn't a worthwhile goal for a project of this sort, I   
> wouldn't necessarily disagree.

I have been made aware of the CDPATH issue since Carl Baldwin
diagnosed it last week, but have not done anything about it
because I am ambivalent about what the right thing to do is.

We could:

 (0) do nothing and let people shoot in the foot themselves.

 (1) unset CDPATH silently while we run.  Most conveniently done
     by doing so at the beginning of git-setup-sh, and scripts
     that do not use the setup script but still does "cd".

 (2) detect CDPATH in the same places as (1), complain and die.

Among these, (1) would be naturally the approach of least
resistance.  It would make things "just work" for everybody, and
I do not have to deal with bug reports from people with a broken
environment, nor have to waste time preaching why CDPATH as an
environment is bad.

That, however, would guard only me without helping the world.
Such a broken environment would still harm other scripts.  In
that sense (2) would be a better approach -- the "complain and
die" step would make it explicit what we do not like about their
environments.  But that would put me in the position of "CDPATH
considered harmful" preacher -- I do not want to waste time on
defending that position every time a misguided soul wants to
keep CDPATH in his environment for whatever reason.  I may end
up even explaining the difference between plain shell variable
and environment variable depending on how misguided that soul is
X-<.

And unlike (1), it would be more baggage to carry around.  It's
only difference between 1 line vs 3 to 4 lines of shell scripts,
but 1 line just to idiot proof feels far more attractive to me
than 4 lines that starts and commits me to a crusade I do not
particularly care about.

Yes, I do realize that I am contradicting myself when I say (1)
does not help the world but I do not particularly want to spend
time and effort on helping the world anyway.  If I really wanted
to make the world a better place, I should do (2) and be
prepared to spend some time defending that position.  Otherwise
I should just weasel out of the problem by doing (1), keep
silent about the issue, let other people who supply scripted
solution suffer and call it their problem.

I would probably end up doing (1), though.
