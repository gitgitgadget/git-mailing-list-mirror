From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH RFC] new config option remote.<name>.pushexec
Date: Tue, 16 Jan 2007 15:08:47 -0500
Message-ID: <20070116200847.GB29100@spearce.org>
References: <20070116150259.GA2439@cepheus> <Pine.LNX.4.63.0701161614070.22628@wbgn013.biozentrum.uni-wuerzburg.de> <20070116162645.GA18894@informatik.uni-freiburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jan 16 21:09:01 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H6uc5-0003R0-Jb
	for gcvg-git@gmane.org; Tue, 16 Jan 2007 21:08:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751409AbXAPUIz (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 16 Jan 2007 15:08:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751407AbXAPUIz
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Jan 2007 15:08:55 -0500
Received: from corvette.plexpod.net ([64.38.20.226]:49558 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751409AbXAPUIy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jan 2007 15:08:54 -0500
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1H6ubp-00046w-4c; Tue, 16 Jan 2007 15:08:41 -0500
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id C3BEF20FBAE; Tue, 16 Jan 2007 15:08:47 -0500 (EST)
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<zeisberg@informatik.uni-freiburg.de>
Content-Disposition: inline
In-Reply-To: <20070116162645.GA18894@informatik.uni-freiburg.de>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36959>

Uwe Kleine-K?nig <zeisberg@informatik.uni-freiburg.de> wrote:
> Exactly.  Quoting git-send-pack(1):
> 
> 	Path to the git-receive-pack program on the remote end.
> 	Sometimes useful when pushing to a remote repository over ssh,
> 	and you do not have the program in a directory on the default
> 	$PATH.
> 
> For me it would be:
> 
> 	pushexec = /home/zeisberg/usr/bin/git-receive-pack
> 
> While having /home/zeisberg/usr/bin only in my PATH for interactive
> shells.  (Yes I know I could expand my PATH which .<someshrc>, but I'd
> prefer it that way.)

Some of us have UNIX accounts where our shell is the (retarded)
/usr/bin/ksh on Solaris.  And where the SSH daemon won't seem to
let us set PATH, and where Git isn't in the PATH.  This leaves
us with some difficulty in pointing Git at itself on the remote
system.

I've worked around it with a GIT_SSH wrapper, e.g.

	$ cat >~/bin/mygitssh.sh
	#!/bin/sh
	host="$1"; shift
	exec ssh "$host" "PATH=\"/path/to/git:\$PATH\"; exec $@"
	^D
	$ chmod 755 ~/bin/mygitssh.sh
	$ export GIT_SSH=~/bin/mygitssh.sh

Being able to just set pushexec and fetchexec in the .git/config
file would be nice, but GIT_SSH works well for my sad needs.

-- 
Shawn.
