From: Ryan Anderson <ryan@michonline.com>
Subject: Re: [PATCH/RFC] "Recursive Make considered harmful"
Date: Fri, 29 Jul 2005 02:53:35 -0400
Message-ID: <20050729065335.GA32263@mythryan2.michonline.com>
References: <20050727083910.GG19290@mythryan2.michonline.com> <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jul 29 08:54:26 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DyOlG-00013s-DP
	for gcvg-git@gmane.org; Fri, 29 Jul 2005 08:54:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262362AbVG2GyA (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 29 Jul 2005 02:54:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262055AbVG2GyA
	(ORCPT <rfc822;git-outgoing>); Fri, 29 Jul 2005 02:54:00 -0400
Received: from mail.autoweb.net ([198.172.237.26]:4264 "EHLO mail.autoweb.net")
	by vger.kernel.org with ESMTP id S262445AbVG2Gxg (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 29 Jul 2005 02:53:36 -0400
Received: from pcp01184054pcs.strl301.mi.comcast.net ([68.60.186.73] helo=michonline.com)
	by mail.autoweb.net with esmtp (Exim 4.44)
	id 1DyOkS-0000mT-8Y; Fri, 29 Jul 2005 02:53:36 -0400
Received: from mythical ([10.254.251.11] ident=Debian-exim)
	by michonline.com with esmtp (Exim 3.35 #1 (Debian))
	id 1DyOtm-00018c-00; Fri, 29 Jul 2005 03:03:14 -0400
Received: from ryan by mythical with local (Exim 4.52)
	id 1DyOkR-0008Sh-MX; Fri, 29 Jul 2005 02:53:35 -0400
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7v4qafrk8w.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.6+20040907i
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

On Wed, Jul 27, 2005 at 02:50:55PM -0700, Junio C Hamano wrote:
> Ryan Anderson <ryan@michonline.com> writes:
> 
> > 003afd3ed1f83b4533b628182fa16c9ab0dc0467
> > diff --git a/Documentation/Makefile.inc b/Documentation/Makefile.inc
> > new file mode 100644
> > --- /dev/null
> > +++ b/Documentation/Makefile.inc
> > @@ -0,0 +1,50 @@
> > +MAN1_TXT=$(wildcard Documentation/git-*.txt)
> > +MAN7_TXT=Documentation/git.txt
> > +
> >...
> 
> While I do not have strong objections to make the build process
> go faster, it is somewhat disturbing that the Makefile pieces
> maintained in subdirectories need to name things they touch
> using paths that include the subdirectory names.  I do not have
> a better alternative to suggest, though...
> 
> I'd keep it in the proposed updates branch for now and wait for
> a bit until discussions on the list die out.

Sorry for taking so long to respond here - I've probably got 2 or 3
general replies to make on this thread, but basically, I truly intended
it as a RFC.

I think the best justification for the end goal of the process I was
thinking of starting is this:

	$ git clone -l git-linus git-example
	defaulting to local storage area
	0 blocks
	$ cd git-example
	$ git checkout
	$ ls | wc -l
	154

I've been spending some time trying to think out what qualifies as a
"tool" and what is "core", etc.  I think it wouldn't be a bad idea to
think about restructuring things a bit so that all the little "helper"
scripts we keep adding don't fill up the top level directory.

I think I'm going to rethink this, a bit more.  I'm unhappy with how I
had to edit the sub-dir Makefiles to include directory names.  Sam, if
you happen to be reading this, feel free to help out!

I'm almost thinking that something like:

	PROGS := 
	SCRIPTS :=
	include x/Makefile.inc
	PROGRAMS += $(addprefix x/,$PROGS)
	ALL_SCRIPTS += $(addprefix x/,$SCRIPTS)

in the top-level Makefile might be the cleanest way to keep the
subdirectory ones simpler - but that's still somewhat distasteful, and
only fixes up one part of the problem.

Anyway, I'll come back to this later when I've got some of the follow-up
issues sorted out, like what to do with the directory structure.

-- 

Ryan Anderson
  sometimes Pug Majere
