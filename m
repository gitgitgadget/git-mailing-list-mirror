From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Redirect cd output to /dev/null, was: git-clone seems dead
Date: Mon, 12 Sep 2005 12:53:13 -0700
Message-ID: <7v3boaawra.fsf@assigned-by-dhcp.cox.net>
References: <vhp64t7v5ff.fsf@ebar091.ebar.dtu.dk>
	<7vd5nfs9y0.fsf@assigned-by-dhcp.cox.net>
	<20050911220421.GA14593@athame.dynamicro.on.ca>
	<20050911230136.GA15224@athame.dynamicro.on.ca>
	<7vwtlnm4zx.fsf@assigned-by-dhcp.cox.net>
	<20050912105637.GA5290@athame.dynamicro.on.ca>
	<7vbr2yfp0r.fsf@assigned-by-dhcp.cox.net>
	<20050912163637.GA22018@athame.dynamicro.on.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 12 21:53:57 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EEuMh-0005x9-Mp
	for gcvg-git@gmane.org; Mon, 12 Sep 2005 21:53:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751054AbVILTxQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Sep 2005 15:53:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932177AbVILTxP
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Sep 2005 15:53:15 -0400
Received: from fed1rmmtao01.cox.net ([68.230.241.38]:14282 "EHLO
	fed1rmmtao01.cox.net") by vger.kernel.org with ESMTP
	id S1751054AbVILTxP (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Sep 2005 15:53:15 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao01.cox.net
          (InterMail vM.6.01.05.02 201-2131-123-102-20050715) with ESMTP
          id <20050912195314.PAZR24420.fed1rmmtao01.cox.net@assigned-by-dhcp.cox.net>;
          Mon, 12 Sep 2005 15:53:14 -0400
To: Greg Louis <glouis@dynamicro.on.ca>
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8419>

Greg Louis <glouis@dynamicro.on.ca> writes:

> Or (2+1==3) detect CDPATH in the same places as (1), complain with a
> brief explanation ("don't export CDPATH; it's really only useful in
> interactive shells") and unset it.

I like your wording above, so probably that is what is going to
happen.  Thanks for the suggestion.

> My patch was about the equivalent of (1), and (1) is what I'd feel
> was the most that git owes its users.

CDPATH has two problems.  1. It takes scripts to unexpected
places (somebody had CDPATH=..:../..:$HOME and the "cd" in
git-clone.sh:get_repo_base took him to $HOME/.git when he said
"clone foo bar" to clone a repository in "foo" which had
"foo/.git").  CDPATH mechanism does not implicitly give "." at
the beginning of CDPATH, which is the most irritating part.
2. the extra echo when it does its thing.

I was under the impression that the patch fixed 2. without doing
anything about 1., but I may be mistaken.

> Option (0) could be justified on the grounds that git users
> are presumably developers and ought to be able to catch that
> sort of blunder, but the facts that you didn't originally twig
> to it, and that it took me a couple of hours to find it
> independently, suggest that that's too cavalier an attitude
> (neither of us being a tyro).

Maybe.  I did not trigger it and did not immediately spot what
was wrong when I heard the symptom because I do not use CDPATH
anywhere myself -- I am old fashioned ;-).
