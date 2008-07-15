From: Petr Baudis <pasky@suse.cz>
Subject: Re: [PATCH] git rev-parse: Fix --show-cdup inside symlinked
	directory
Date: Tue, 15 Jul 2008 17:40:36 +0200
Message-ID: <20080715154036.GR10151@machine.or.cz>
References: <1216131208.19334.171.camel@gemini> <20080715145920.13529.25603.stgit@localhost> <alpine.DEB.1.00.0807151614510.8950@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, git@vger.kernel.org, yves.orton@booking.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 15 17:42:27 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KImfC-0000Nu-4o
	for gcvg-git-2@gmane.org; Tue, 15 Jul 2008 17:42:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754799AbYGOPkm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2008 11:40:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753101AbYGOPkm
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Jul 2008 11:40:42 -0400
Received: from w241.dkm.cz ([62.24.88.241]:51060 "EHLO machine.or.cz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753329AbYGOPkl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2008 11:40:41 -0400
Received: by machine.or.cz (Postfix, from userid 2001)
	id A6CF21E4C021; Tue, 15 Jul 2008 17:40:36 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807151614510.8950@racer>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/88573>

  Hi,

On Tue, Jul 15, 2008 at 04:19:30PM +0100, Johannes Schindelin wrote:
> On Tue, 15 Jul 2008, Petr Baudis wrote:
> 
> > Consider the scenario when someone makes a symlink into a working tree
> > subdirectory at an unrelated place, then attempts to work inside the
> > symlinked directory. The scenario is a bit unwieldly, but most of
> > the Git will handle it fine - except git rev-parse --show-cdup. That
> > will output a sequence of ../ which will work wrong inside the symlink
> > using shell cd builtin.
> 
> Short version: do not use symlinks in the working directory, if you do not 
> want to track the _symlink_.
> 
> Long version: there are a lot of problems with that, and --show-cdup is 
> the least of the problems.  A checkout, for example, is able to kill the 
> symlink and check out a fresh copy of the subdirectory.
> 
> AFAICT this is a concious decision: If you want to track a symlink, track 
> a symlink, but if you want to track a subdirectory, you will have to track 
> a subdirectory, and it cannot be a symlink.

  no, no, this is for the scenario other way around: you have a normal
subdirectory in the working tree, and point a symlink _at_ it from
$somewhere_else. Then you try to work in $somewhere_else/symlink.

> > This patch changes --show-cdup to always show absolute workdir path
> > instead. I think this should hopefully cause no compatibility problems;
> > the testsuite is passing fine, at least.
> 
> See the thread where I proposed a change like this, back with the infamous 
> worktree desaster, and Junio NACKed; or the thread where Linus rightfully 
> insists that git_dir should be relative if possible, for performance 
> reasons.

  I see, <7vk5sly3h9.fsf@assigned-by-dhcp.cox.net>. But noone was aware
of this possible user case. Performance reasons sound reasonable, though
I'm not really sure if for cdup in particular this ever matters.

  P.S.: Either way, there is a possible workaround to tell git about the
working directory manually using git --work-tree=... that I missed to
mention on IRC, Yves.

-- 
				Petr "Pasky" Baudis
GNU, n. An animal of South Africa, which in its domesticated state
resembles a horse, a buffalo and a stag. In its wild condition it is
something like a thunderbolt, an earthquake and a cyclone. -- A. Pierce
