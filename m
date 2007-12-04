From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH v4] Allow update hooks to update refs on their own.
Date: Mon, 3 Dec 2007 20:51:08 -0500
Message-ID: <20071204015108.GV14735@spearce.org>
References: <7vr6i8sfsa.fsf@gitster.siamese.dyndns.org> <20071202212224.GA22117@midwinter.com> <20071203040108.GS14735@spearce.org> <Pine.LNX.4.64.0712031146520.27959@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Steven Grimm <koreth@midwinter.com>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Dec 04 02:51:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IzMwf-0005nq-DQ
	for gcvg-git-2@gmane.org; Tue, 04 Dec 2007 02:51:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751063AbXLDBvO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Dec 2007 20:51:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750975AbXLDBvN
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Dec 2007 20:51:13 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:48574 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750818AbXLDBvN (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Dec 2007 20:51:13 -0500
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.68)
	(envelope-from <spearce@spearce.org>)
	id 1IzMw7-0003NC-5z; Mon, 03 Dec 2007 20:50:59 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 5448D20FBAE; Mon,  3 Dec 2007 20:51:08 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712031146520.27959@racer.site>
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
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/66989>

Johannes Schindelin <Johannes.Schindelin@gmx.de> wrote:
> On Sun, 2 Dec 2007, Shawn O. Pearce wrote:
> 
> > Steven Grimm <koreth@midwinter.com> wrote:
> > > This is useful in cases where a hook needs to modify an incoming commit
> > > in some way, e.g., fixing whitespace errors, adding an annotation to
> > > the commit message, noting the location of output from a profiling tool,
> > > or committing to an svn repository using git-svn.
> > ...
> > > +/* Update hook exit code: hook has updated ref on its own */
> > > +#define EXIT_CODE_REF_UPDATED 100
> > 
> > Hmm.  I would actually rather move the ref locking to before we run
> > the update hook, so the ref is locked *while* the hook executes.
> 
> Would that not mean that you cannot use update-ref to update the ref, 
> since that wants to use the same lock?

You failed to quote the part of my email where I talked about how
we set an evironment variable to pass a hint to lockfile.c running
within the git-update-ref subprocess to instruct it to perform a
different style of locking, one that would work as a "recursive"
lock.

Such a recursive lock could be useful for a whole lot more than just
the update hook.  But it would at least allow the update hook to
use git-update-ref to safely change the ref, without receive-pack
losing its own lock on the ref.

-- 
Shawn.
