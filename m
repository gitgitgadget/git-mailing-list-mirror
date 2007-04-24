From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [BUG] git gui and =?iso-8859-1?Q?my_?=
	=?iso-8859-1?Q?=F6?=
Date: Tue, 24 Apr 2007 01:39:35 -0400
Message-ID: <20070424053935.GO17480@spearce.org>
References: <20070423113225.GA5427@lala>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
	<ukleinek@informatik.uni-freiburg.de>
X-From: git-owner@vger.kernel.org Tue Apr 24 07:39:49 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HgDki-0008Jo-B9
	for gcvg-git@gmane.org; Tue, 24 Apr 2007 07:39:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161631AbXDXFjl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 24 Apr 2007 01:39:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161637AbXDXFjl
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Apr 2007 01:39:41 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:59070 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1161631AbXDXFjk (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Apr 2007 01:39:40 -0400
Received: from cpe-74-70-48-173.nycap.res.rr.com ([74.70.48.173] helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.63)
	(envelope-from <spearce@spearce.org>)
	id 1HgDkK-0004Yo-IO; Tue, 24 Apr 2007 01:39:24 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id AA4D520FBAE; Tue, 24 Apr 2007 01:39:35 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070423113225.GA5427@lala>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45412>

Uwe Kleine-K??nig <ukleinek@informatik.uni-freiburg.de> wrote:
> 	commit-tree failed:
> 
> 	<sha1 sum>
> 	Warning: commit message does not conform to UTF-8.
> 	You may ...
> 
> The commit was done with git-commit, I have 
> 
> 	zeisberg@cassiopeia:~$ set | grep -E '^L(ANG|C_)'
> 	LANG=en_US.UTF-8
> 	LC_CTYPE=en_US.UTF-8

What does your git-config think is the value of i18n.commitencoding?
If its unset git-gui assumes utf-8 as the encoding.  Hmm...

This particular code is around line 1287 of git-gui:

   1287     # -- Build the message.
   1288     #
   1289     set msg_p [gitdir COMMIT_EDITMSG]
   1290     set msg_wt [open $msg_p w]
   1291     if {[catch {set enc $repo_config(i18n.commitencoding)}]} {
   1292         set enc utf-8
   1293     }
   1294     fconfigure $msg_wt -encoding $enc -translation binary
   1295     puts -nonewline $msg_wt $msg
   1296     close $msg_wt

We should be writing the commit message (here $msg) out to a
temporary file ($msg_p / $msg_t), using a UTF-8 encoding ($enc).
Apparently that's not what's happening here.  I wonder if the Tk
text widget is feeding me UTF-8, and the way I have configured the
file channel Tcl is than mangling things futher... *sigh*

Anyone reading this a better Tcl guru than I?


I'll try to take a look at this tomorrow.  I'll have to figure out
how to get your proper name into git-gui first.  :-)

I had thought I had most of git-gui i8n safe, but apparently not.
Thanks for the bug report!

-- 
Shawn.
