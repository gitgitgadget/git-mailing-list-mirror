From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Adding a 'version' command to the server
Date: Sun, 29 Jun 2008 00:08:56 -0400
Message-ID: <20080629040856.GD11793@spearce.org>
References: <7viqvupm3l.fsf@gitster.siamese.dyndns.org> <486572BC.9070201@gmail.com> <20080628114337.GA3489@steel.home> <48662DB0.3010608@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Alex Riesen <raa.lkml@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 29 06:10:35 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KCoFF-0003Kt-08
	for gcvg-git-2@gmane.org; Sun, 29 Jun 2008 06:10:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750719AbYF2EJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 29 Jun 2008 00:09:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750704AbYF2EJE
	(ORCPT <rfc822;git-outgoing>); Sun, 29 Jun 2008 00:09:04 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:55126 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750695AbYF2EJC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 29 Jun 2008 00:09:02 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.69)
	(envelope-from <spearce@spearce.org>)
	id 1KCoDW-0006uv-0O; Sun, 29 Jun 2008 00:08:46 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5A20020FBAE; Sun, 29 Jun 2008 00:08:57 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <48662DB0.3010608@gmail.com>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86759>

Lea Wiemann <lewiemann@gmail.com> wrote:
> Alex Riesen wrote:
> >And exactly how are the incompatibility problems avoided? By denying
> >the service if the versions don't match?
> 
> No, by talking to older servers in a way they understand it.  So for 
> instance it would call "git-upload-pack" instead of "git upload-pack".
> 
> (See also the SSH protocol with two versions, and I think Subversion's 
> svnserve also somehow identifies its own capabilities and/or version.)

We already have both sides of a git native connection select
functions to be used in the protocol based upon both sides having
the necessary capabilities.  This is in heavy use today for things
like thin packs, sideband progress messages and remote deletion of
branches through git-push.

So we're doing what you suggest.

The problem we are faced with right now is when invoking Git over
SSH we need to pass some string to the remote shell and expect
the remote shell to start up the program we need to talk to.
Without that program running there is nothing to ask the other side
its version.  :-(

This should be a one-time transition pain, as the original git
developers used git-foo-command style, but users today want just
"git foo-command" style, to reduce the number of commands they
see with tab completion.  Its the price we/they pay for making
that sort of change this late in the project.

I'm not sure when SVN start supporting "svn serve" over SSH.  It may
have been quite a while after they were already self-hosting, as
they started out with HTTP WebDAV as the only protocol.  Thus they
may have already been heavily into the "svn foo" style of command
invocation and never made the "misstep" that Git made.

Of course SVN has made _many_ other "missteps" that Git has done
right since day 1.  Like merge support.  :-)

Nobody is perfect.  Not even the Git developers.

-- 
Shawn.
